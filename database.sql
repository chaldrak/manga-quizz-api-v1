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

CREATE TABLE info_characters (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    picture TEXT NOT NULL,
    manga_id INT REFERENCES mangas(id),
    info_id INT REFERENCES info_characters(id)
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

INSERT INTO characters (name, description, picture, manga_id)
VALUES ('Naruto Uzumaki', 'C''est un ninja du village caché de Konoha. Il devint le jinchûriki de Kyûbi le jour de sa naissance.', 'https://static.wikia.nocookie.net/naruto/images/f/f1/Naruto_Partie_I.png/revision/latest/scale-to-width-down/300?cb=20151201180820&path-prefix=fr', 1),
('Hinata Hyûga', 'Née Hyûga est une kunoichi du clan Hyûga du village de Konoha et un membre de l''Équipe Kurenaï.', 'https://static.wikia.nocookie.net/naruto/images/9/97/Hinata.png/revision/latest/scale-to-width-down/300?cb=20150508121138&path-prefix=fr', 1),
()