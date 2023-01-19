import express from "express";
import pool from "../database.js";
import bcrypt from "bcrypt";
import { jwtTokens } from "../utils/jwt-helpers.js";

const router = express.Router();

router.post("/signup", async (req, res)=>{
    try {
        const {username, password, confirmPass} = req.body;
        const avatar = "https://res.cloudinary.com/dumxkdcvd/image/upload/v1673972861/uwp2202806_mu3vgh.jpg";
        if (username.length > 15) {
            return res.status(500).json({error: "Username too long maximum 15"});
        }
        if (username.length === 0) {
            return res.status(500).json({error: "Username must not be empty"});
        }
        if (password.length < 6) {
            return res.status(500).json({error: "Password must have minimum 6"});
        }
        if (password !== confirmPass) {
            return res.status(500).json({error: "The two password don't match"});
        }
        const cryptedPass = await bcrypt.hash(password, 12);
        const newUser = await pool.query("INSERT INTO users (username, password, avatar) VALUES ($1, $2, $3) RETURNING *", [username, cryptedPass, avatar]);
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