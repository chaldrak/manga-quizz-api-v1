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
    name TEXT NOT NULL UNIQUE,
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
('Ashina Uzumaki', 'Le chef du clan Uzumaki à l''époque de la construction du premier village caché, Konoha.'),
('Boruto Uzumaki', 'C''est un shinobi du clan Uzumaki du village caché de Konoha et également un descendant direct du clan Hyûga par sa mère.'),
('Fusô', 'Elle était une infirmière et une habitante d''Ame, où elle vivait dans un petit village avec son fils et son mari.'),
('Himawari Uzumaki ', 'C''est la deuxième enfant de Naruto et Hinata Uzumaki.'),
('Hinata Hyûga', 'Née Hyûga, elle est une kunoichi du clan Hyûga du village de Konoha et un membre de l''Équipe Kurenaï.'),
('Karin', 'Elle est une subordonnée d''Orochimaru, une ancienne ninja de Kusa et une membre du clan Uzumaki.'),
('Kushina Uzumaki', 'Elle était une kunoichi de Konoha originaire du clan Uzumaki du village caché d''Uzushio. Elle était la deuxième jinchûriki de Kyûbi.'),
('Mito Uzumaki', 'Elle fut l''épouse du Premier Hokage et la première jinchûriki de Kyûbi, le Démon-Renard à neuf queues.'),
('Nagato', 'Aussi connu comme Pain, était l''ancien chef officiel de l''Akatsuki et du village d''Ame et un des principaux antagonistes de la série. Il est révélé plus tard qu''il avait discrètement collaboré avec Tobi, qui était le vrai chef de l''Akatsuki.'),
('Butsuma Senju', 'Il était un membre du clan Senju durant l''Époque de la Guerre des Provinces précédant l''ère des villages cachés. Il est le père de Hashirama le premier Hokage.'),
('Hashirama Senju', 'Il était un ninja légendaire qui devint le Premier Hokage. Il est à l''origine de la création du village Konoha.'),
('Itama Senju', 'Il était un jeune shinobi du clan Senju. Frère de Hashirama et Tobirama.'),
('Kawarama Senju', 'Il était un jeune ninja du clan Senju. Frère de Hashirama mort au combat durant la guerre des provinces.'),
('Nawaki', 'Il était un genin du clan Senju du village caché de Konoha. Frère de Tsunade mort au combat suite à une explosion.'),
('Tobirama Senju', 'Aux côtés de son frère, le Premier Hokage, qui fonda Konoha, il travailla en coulisses afin d''apporter la stabilité politique et mettre en place les institutions qui mirent le village en fonctionnement, assurant ainsi la prospérité de Konoha.'),
('Tôka Senju', 'Elle était une kunoichi du clan Senju avant la fondation des villages cachés. Elle était une proche collaboratrice et digne de confiance à Hashirama, avant la fondation de Konoha.'),
('Tsunade', 'Elle est une descendante des clans Senju et Uzumaki, ainsi que l''une des légendaires Sannin de Konoha. Considérée dans le monde comme la plus forte des kunoichi et la plus grande ninja médecin.')



INSERT INTO characters (picture, manga_id, info_id) VALUES 
('https://static.wikia.nocookie.net/naruto/images/f/f1/Naruto_Partie_I.png/revision/latest/scale-to-width-down/300?cb=20151201180820&path-prefix=fr', 1, 1),
('https://static.wikia.nocookie.net/naruto/images/3/36/Naruto_Uzumaki.png/revision/latest/scale-to-width-down/300?cb=20170212111141&path-prefix=fr', 2, 1),
('https://static.wikia.nocookie.net/naruto/images/0/08/Naruto_part_III.png/revision/latest/scale-to-width-down/300?cb=20170812082557&path-prefix=fr', 3, 1),
('https://static.wikia.nocookie.net/naruto/images/3/32/Chef_du_Clan_Uzumaki.png/revision/latest/scale-to-width-down/350?cb=20150208234834&path-prefix=fr', 2, 2),
('https://static.wikia.nocookie.net/naruto/images/a/a2/Boruto_Uzumaki.png/revision/latest/scale-to-width-down/350?cb=20211026120402&path-prefix=fr', 3, 3),
('https://static.wikia.nocookie.net/naruto/images/f/f0/Fus%C3%B4.png/revision/latest/scale-to-width-down/350?cb=20141111131253&path-prefix=fr',2, 4),
('https://static.wikia.nocookie.net/naruto/images/1/18/Himawari_Uzumaki_Anime.png/revision/latest/scale-to-width-down/350?cb=20170412212115&path-prefix=fr', 3, 5),
('https://static.wikia.nocookie.net/naruto/images/9/97/Hinata.png/revision/latest/scale-to-width-down/300?cb=20150508121138&path-prefix=fr', 1, 6),
('https://static.wikia.nocookie.net/naruto/images/4/43/Hinata_Partie_II.png/revision/latest/scale-to-width-down/300?cb=20150508121512&path-prefix=fr', 2, 6),
('https://static.wikia.nocookie.net/naruto/images/2/22/Hinata_Adulte.png/revision/latest/scale-to-width-down/300?cb=20160130202730&path-prefix=fr', 3, 6),
('https://static.wikia.nocookie.net/naruto/images/5/50/Karin.png/revision/latest/scale-to-width-down/300?cb=20201231015434&path-prefix=fr', 2, 7),
('https://static.wikia.nocookie.net/naruto/images/8/84/Karin_%C3%A9pilogue.png/revision/latest/scale-to-width-down/300?cb=20200504035022&path-prefix=fr', 3, 7),
('https://static.wikia.nocookie.net/naruto/images/0/08/Kushina_Uzumaki_2.png/revision/latest/scale-to-width-down/350?cb=20170813190811&path-prefix=fr', 2, 8),
('https://static.wikia.nocookie.net/naruto/images/d/da/Mito_Uzumaki.png/revision/latest/scale-to-width-down/350?cb=20171016172148&path-prefix=fr', 2, 9),
('https://static.wikia.nocookie.net/naruto/images/a/aa/Nagato_Squelettique.png/revision/latest/scale-to-width-down/350?cb=20130505185531&path-prefix=fr', 2, 10),
('https://static.wikia.nocookie.net/naruto/images/9/95/Butsuma_Senju2.png/revision/latest/scale-to-width-down/350?cb=20150907165339&path-prefix=fr', 2, 11),
('https://static.wikia.nocookie.net/naruto/images/7/7e/Hashirama_Senju.png/revision/latest/scale-to-width-down/350?cb=20130802131737&path-prefix=fr', 1, 12),
('https://static.wikia.nocookie.net/naruto/images/0/03/Itama_Senju2.png/revision/latest/scale-to-width-down/350?cb=20140706184030&path-prefix=fr', 2, 13),
('https://static.wikia.nocookie.net/naruto/images/6/67/KawaramaSenju.png/revision/latest/scale-to-width-down/350?cb=20140727200745&path-prefix=fr', 2, 14),
('https://static.wikia.nocookie.net/naruto/images/9/91/Nawaki.png/revision/latest/scale-to-width-down/350?cb=20170706215407&path-prefix=fr', 1, 15),
('https://static.wikia.nocookie.net/naruto/images/b/be/Tobirama_Senju.png/revision/latest/scale-to-width-down/350?cb=20150413175057&path-prefix=fr', 1, 16),
('https://static.wikia.nocookie.net/naruto/images/6/68/T%C3%B4ka_Senju.png/revision/latest/scale-to-width-down/304?cb=20220211174835&path-prefix=fr', 2, 17),
('https://static.wikia.nocookie.net/naruto/images/e/e6/Tsunade2.png/revision/latest/scale-to-width-down/350?cb=20161120222345&path-prefix=fr', 1, 18)



