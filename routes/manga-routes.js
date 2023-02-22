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

router.get("/mangas/:id/characters", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const characters = await pool.query("SELECT id, name, description, picture FROM ( SELECT c.picture, c.info_id, c.manga_id FROM characters as c JOIN mangas as m ON c.manga_id = m.id  WHERE m.id = $1 ) as res JOIN info_characters as info ON res.info_id = info.id", [id]);
        res.status(200).json({characters: characters.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Get all the high scores by manga order by total 
router.get("/mangas/:id/scores", authenticateToken, async (req, res)=>{
    try {
        const id = parseInt(req.params.id);
        const scores = await pool.query("SELECT username, score, avatar FROM (SELECT MAX(total) AS score, user_id FROM scores WHERE manga_id = $1 GROUP BY user_id) AS max JOIN users ON max.user_id = users.id ORDER BY score DESC", [id]);
        res.status(200).json({scores: scores.rows});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

export default router;