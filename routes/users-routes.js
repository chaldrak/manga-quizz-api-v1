import express from "express";
import pool from "../database.js";
import bcrypt from "bcrypt";
import { authenticateToken } from "../middleware/authorization.js";

const router = express.Router();

router.get("/users/:id", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const user = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
        res.status(200).json({user: user.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

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

router.put("/users/:id/avatar", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const {avatar} = req.body;
        const newUser = await pool.query("UPDATE users SET avatar = $1 WHERE id = $2 RETURNING *", [avatar, id]);
        res.status(200).json({user: newUser.rows[0]});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

export default router;