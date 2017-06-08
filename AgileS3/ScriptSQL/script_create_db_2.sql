DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS unchecked CASCADE;
DROP TABLE IF EXISTS status CASCADE;
DROP TABLE IF EXISTS xorder CASCADE;
DROP TABLE IF EXISTS brand CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS article CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS xline CASCADE;

CREATE TABLE person(
id serial,
is_admin boolean NOT NULL DEFAULT FALSE,
first_name varchar(20) NOT NULL,
last_name varchar(20) NOT NULL,
mail varchar(100) NOT NULL,
password varchar(20) NOT NULL,
default_address text,
phone varchar(10),
cerdit_card_number varchar(16) NOT NULL,
cerdit_card_date date NOT NULL,
CONSTRAINT pk_person PRIMARY KEY(id),
CONSTRAINT unique_mail UNIQUE (mail),
CONSTRAINT check_mail CHECK(mail LIKE '%_@_%.__%'),
CONSTRAINT check_cerdit_card_number CHECK(mail LIKE '%[^0-9]%')
);

CREATE TABLE unchecked(
mail varchar(100),
first_name varchar(20) NOT NULL,
last_name varchar(20) NOT NULL,
password varchar(20) NOT NULL,
code text NOT NULL,
xdate date NOT NULL,
CONSTRAINT pk_unchecked PRIMARY KEY(mail)
);

CREATE TABLE status(
id integer,
title varchar(100) NOT NULL,
CONSTRAINT pk_status PRIMARY KEY (id)
);

INSERT INTO status VALUES(-3,'Annule'), (-2,'Erreur de livraison'), (-1,'Erreur de stock'), (0,'En attente'), (1,'En cours de preparation'), (2,'Expidie'), (3,'Livre');

CREATE TABLE xorder(
id serial,
person integer NOT NULL,
address text NOT NULL,
recipient text NOT NULL,
status integer DEFAULT 0,
xdate date NOT NULL,
CONSTRAINT pk_xorder PRIMARY KEY(id),
CONSTRAINT fk_person FOREIGN KEY (person)
REFERENCES person(id)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_status FOREIGN KEY(status)
REFERENCES status(id)
);

CREATE TABLE brand(
name varchar(100) NOT NULL,
CONSTRAINT pk_brand PRIMARY KEY (name)
);

CREATE TABLE category(
name varchar(100) NOT NULL,
CONSTRAINT pk_category PRIMARY KEY (name)
);

CREATE TABLE article(
reference serial,
name text NOT NULL,
description text NOT NULL,
image_url text,
brand varchar(100) NOT NULL,
category varchar(100) NOT NULL,
price numeric(8,2) NOT NULL,
discount numeric(3,2) NOT NULL DEFAULT 0.0,
quantity integer NOT NULL,
CONSTRAINT pk_article PRIMARY KEY(reference),
CONSTRAINT check_image_url CHECK(image_url LIKE ('http%://%_.__%')),
CONSTRAINT check_price CHECK (price >= 0.0),
CONSTRAINT check_discount CHECK (discount >= 0.0 AND discount <= 1.0)
);

CREATE TABLE review(
id serial,
reference integer NOT NULL,
person integer NOT NULL,
mark integer NOT NULL,
review text NOT NULL,
CONSTRAINT pk_review PRIMARY KEY (id),
CONSTRAINT check_mark CHECK (mark >= 0 AND mark <= 1.0),
CONSTRAINT fk_reference FOREIGN KEY (reference)
REFERENCES article(reference)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_person FOREIGN KEY (person)
REFERENCES person(id)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE xline(
xorder integer,
reference integer,
quantity integer NOT NULL,
CONSTRAINT pk_xline PRIMARY KEY (xorder, reference),
CONSTRAINT fk_xorder FOREIGN KEY (xorder)
REFERENCES xorder(id)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_reference FOREIGN KEY (reference)
REFERENCES article(reference)
ON UPDATE CASCADE
ON DELETE CASCADE
);
