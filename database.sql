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

INSERT INTO info_characters (name, description)
VALUES ('Naruto Uzumaki', 'C''est un ninja du village caché de Konoha. Il devint le jinchûriki de Kyûbi le jour de sa naissance.'),
('Kushina Uzumaki', 'Elle était une kunoichi de Konoha originaire du clan Uzumaki du village caché d''Uzushio. Elle était la deuxième jinchûriki de Kyûbi.'),
('Ashina Uzumaki', 'Le chef du clan Uzumaki à l''époque de la construction du premier village caché, Konoha.'),
('Boruto Uzumaki', 'C''est un shinobi du clan Uzumaki du village caché de Konoha et également un descendant direct du clan Hyûga par sa mère.'),
('Fusô', 'Elle était une infirmière et une habitante d''Ame, où elle vivait dans un petit village avec son fils et son mari.')

INSERT INTO characters (picture, manga_id, info_id) VALUES 
('https://static.wikia.nocookie.net/naruto/images/f/f1/Naruto_Partie_I.png/revision/latest/scale-to-width-down/300?cb=20151201180820&path-prefix=fr', 1, 1),
('https://static.wikia.nocookie.net/naruto/images/3/36/Naruto_Uzumaki.png/revision/latest/scale-to-width-down/300?cb=20170212111141&path-prefix=fr', 2, 1),
('https://static.wikia.nocookie.net/naruto/images/0/08/Naruto_part_III.png/revision/latest/scale-to-width-down/300?cb=20170812082557&path-prefix=fr', 3, 1),
('https://static.wikia.nocookie.net/naruto/images/0/08/Kushina_Uzumaki_2.png/revision/latest/scale-to-width-down/350?cb=20170813190811&path-prefix=fr', 2, 2),
('https://static.wikia.nocookie.net/naruto/images/3/32/Chef_du_Clan_Uzumaki.png/revision/latest/scale-to-width-down/350?cb=20150208234834&path-prefix=fr', 2, 3),
('https://static.wikia.nocookie.net/naruto/images/a/a2/Boruto_Uzumaki.png/revision/latest/scale-to-width-down/350?cb=20211026120402&path-prefix=fr', 3, 4),
('https://static.wikia.nocookie.net/naruto/images/f/f0/Fus%C3%B4.png/revision/latest/scale-to-width-down/350?cb=20141111131253&path-prefix=fr',2, 5)

