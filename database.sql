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

INSERT INTO mangas (name, picture) 
VALUES ('Naruto', 'https://res.cloudinary.com/dumxkdcvd/image/upload/v1673436818/anime_logo_naruto_en_wxn0f9.webp'),
('Naruto Shippuden', 'https://res.cloudinary.com/dumxkdcvd/image/upload/v1673437369/anime_logo_naruto_s_en_exnp65.webp'),
('Boruto: Naruto Next Generations', 'https://res.cloudinary.com/dumxkdcvd/image/upload/v1673437370/anime_logo_boruto_en_ftmqjh.webp')

