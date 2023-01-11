import express from "express";
import pool from "../database.js";
import { authenticateToken } from "../middleware/authorization.js";

const router = express.Router();

router.get("/mangas", authenticateToken, async (req, res)=>{
    try {
        const mangas = await pool.query("SELECT * FROM mangas");
        res.status(200).json({manga: mangas.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;