import express, {json} from "express";
import cors from "cors";
import dotenv from "dotenv";
import authRouter from "./routes/auth-routes.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 8080;
const corsOptions = {Credentials: true, origin: process.env.URL || '*'};

app.use(cors(corsOptions));
app.use(json());

app.get("/", (req, res)=>{
    res.send("<h1>Hello Manga Quizz API</h1>");
});

app.use("/api/auth", authRouter);

app.listen(PORT, ()=>console.log(`Server is running on port ${PORT}...`));
