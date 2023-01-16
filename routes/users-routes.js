import express from "express";
import pool from "../database.js";
import bcrypt from "bcrypt";
import { authenticateToken } from "../middleware/authorization.js";

const router = express.Router();

// Get an user with id
router.get("/users/:id", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const user = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
        res.status(200).json({user: user.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Update an user info
router.put("/users/:id", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const {username, password} = req.body;
        const user = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
        if (user.rowCount === 0) return res.status(401).json({error: "User not found"});
        if (username.length > 15) {
            return res.status(400).json({error: "Username too long maximum 15"});
        }
        if (!username) {
            return res.status(400).json({error: "Username might not be empty"});
        }
        if (password.length < 6) {
            return res.status(400).json({error: "Password must have minimum 6"});
        }
        const cryptedPass = await bcrypt.hash(password, 12);
        const newUser = await pool.query("UPDATE users SET (username, password) = ($1, $2) WHERE id = $3 RETURNING *", [username, cryptedPass, id]);
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

export default router;