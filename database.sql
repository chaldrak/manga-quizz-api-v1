CREATE DATABASE mangaquizz;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    avatar TEXT
);

CREATE TABLE mangas (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    picture TEXT NOT NULL
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    picture TEXT NOT NULL,
    manga_id INT REFERENCES mangas(id)
);

CREATE TABLE scores (
    id SERIAL PRIMARY KEY,
    total TEXT NOT NULL,
    created_date TIMESTAMP DEFAULT current_timestamp,
    user_id INT REFERENCES users(id),
    manga_id INT REFERENCES mangas(id)
);