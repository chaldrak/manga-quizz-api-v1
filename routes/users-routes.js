import express from "express";
import pool from "../database.js";
import bcrypt from "bcrypt";
import { authenticateToken } from "../middleware/authorization.js";

const router = express.Router();

// Get an user with id
router.get("/users/:id", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const user = await pool.query("SELECT username, avatar FROM users WHERE id = $1", [id]);
        res.status(200).json({user: user.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Delete an user account
router.delete("/users/:id", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const scores = await pool.query("DELETE FROM scores WHERE user_id = $1", [id]);
        const user = await pool.query("DELETE FROM users WHERE id = $1", [id]);
        res.status(200).json({user: user.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Update an user password
router.put("/users/:id/password", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const {password, confirmPass} = req.body;
        const user = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
        if (user.rowCount === 0) return res.status(401).json({error: "User not found"});
        if (password.length < 6) {
            return res.status(500).json({error: "Password must have minimum 6"});
        }
        if (password !== confirmPass) {
            return res.status(500).json({error: "The two password don't match"});
        }
        const cryptedPass = await bcrypt.hash(password, 12);
        const newUser = await pool.query("UPDATE users SET password = $1 WHERE id = $2 RETURNING *", [cryptedPass, id]);
        res.status(200).json({user: newUser.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Update an user info
router.put("/users/:id/info", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const {username} = req.body;
        const user = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
        if (user.rowCount === 0) return res.status(401).json({error: "User not found"});
        if (username.length > 15) {
            return res.status(400).json({error: "Username too long maximum 15"});
        }
        if (!username) {
            return res.status(400).json({error: "Username might not be empty"});
        }
        const newUser = await pool.query("UPDATE users SET username = $1 WHERE id = $2 RETURNING *", [username, id]);
        res.status(200).json({user: newUser.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Update user's avatar
router.put("/users/:id/avatar", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const {avatar} = req.body;
        const newUser = await pool.query("UPDATE users SET avatar = $1 WHERE id = $2 RETURNING *", [avatar, id]);
        res.status(200).json({user: newUser.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Add a score to user
router.post("/users/:id/scores", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const {manga_id, total} = req.body;
        const score = await pool.query("INSERT INTO scores (total, user_id, manga_id) VALUES ($1, $2, $3) RETURNING *", [total, id, manga_id]);
        res.status(200).json({score: score.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Get all the users's scores
router.get("/users/:id1/mangas/:id2/scores", authenticateToken, async (req, res)=>{
    try {
        const user_id = parseInt(req.params.id1);
        const manga_id = parseInt(req.params.id2);
        const scores = await pool.query("SELECT * FROM scores WHERE user_id = $1 AND manga_id = $2 ORDER BY total DESC", [user_id, manga_id]);
        res.status(200).json({scores: scores.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

// Get all the scores based on user's id
router.get("/users/:id/scores", authenticateToken, async (req, res)=>{
    try {
        const user_id = parseInt(req.params.id);
        const scores = await pool.query("SELECT * FROM scores WHERE user_id = $1 ORDER BY total DESC", [user_id]);
        res.status(200).json({scores: scores.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

// Get all the scores
router.get("/scores", authenticateToken, async (req, res)=>{
    try {
        const scores = await pool.query("SELECT username, avatar, created_date, user_id, manga_id, total FROM scores AS s JOIN users AS u ON s.user_id = u.id ORDER BY total DESC");
        res.status(200).json({scores: scores.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

// Get all the total scores
router.get("/scores/total", authenticateToken, async (req, res)=>{
    try {
        const scores = await pool.query("SELECT SUM(total) AS total, user_id FROM scores GROUP BY user_id ORDER BY total DESC");
        res.status(200).json({scores: scores.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

// Delete all the scores of a specific user
router.delete("/users/:id/scores", authenticateToken, async (req, res)=>{
    try {
        const user_id = parseInt(req.params.id);
        const scores = await pool.query("DELETE FROM scores WHERE user_id = $1", [user_id]);
        res.status(200).json({scores: scores.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

export default router;