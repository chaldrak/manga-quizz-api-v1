import express from "express";
import pool from "../database.js";
import bcrypt from "bcrypt";
import { jwtTokens } from "../utils/jwt-helpers.js";

const router = express.Router();

router.post("/signup", async (req, res)=>{
    try {
        const {username, password} = req.body;
        if (username.length > 15) {
            return res.status(400).json({error: "Username too long maximum 15"});
        }
        if (password.length < 6) {
            return res.status(400).json({error: "Password must have minimum 6"});
        }
        const cryptedPass = await bcrypt.hash(password, 12);
        const newUser = await pool.query("INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *", [username, cryptedPass]);
        res.status(201).json({user: newUser.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

router.post("/signin", async (req, res)=>{
    try {
        const {username, password} = req.body;
        const user = await pool.query("SELECT * FROM users WHERE username = $1", [username]);
        if (user.rowCount === 0) return res.status(401).json({error: "Username is incorrect"});

        const validPass = await bcrypt.compare(password, user.rows[0].password);
        if(!validPass) return res.status(401).json({error: "Password is incorrect"});

        const token = jwtTokens(user.rows[0]);
        res.json(token);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

export default router;