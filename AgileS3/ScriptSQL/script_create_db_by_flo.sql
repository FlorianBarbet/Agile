DROP FUNCTION IF EXISTS fact_gen(varchar,date);
DROP FUNCTION IF EXISTS fact_gen_other(varchar,date,text);
DROP TABLE IF EXISTS facture;
DROP TABLE IF EXISTS lignefact;

DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS status;

DROP TABLE IF EXISTS infoart;

DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS vendeur;


CREATE TABLE utilisateur(
	login varchar(16) NOT NULL,
	mdp varchar(16) DEFAULT md5((random())::varchar(16)),
	nom text DEFAULT '?',
	prenom text DEFAULT '?',
	address text NOT NULL,
	mail text NOT NULL,
	dateins date DEFAULT now(),
	tel varchar(10),
	droit integer DEFAULT 0,
	tok text DEFAULT md5((random())::text),
	CONSTRAINT pk_user PRIMARY KEY(login),
	CONSTRAINT fj_droit FOREIGN KEY(droit)
		REFERENCES droit(iddroit)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT check_mail CHECK(mail LIKE  '%_@_%.__%'),
	CONSTRAINT unique_mail UNIQUE(mail)

);

INSERT INTO utilisateur(login,mdp,address,mail,tel,droit)VALUES('admin','hendek','?','florian.barbet@fbarbet.fr','?',2),('Faunus','123456','?','flow.fb60@gmail.com','?',1);

CREATE TABLE status(
	idstatus integer,
	libelle text NOT NULL,
	CONSTRAINT pk_status PRIMARY KEY(idstatus)
);

INSERT INTO status VALUES (-2,'Erreur de livraison'),(-1,'Rupture de stock'),(0,'En cours de validation'),(1,'Traitement en cours'),(2,'Livré');

CREATE TABLE vendeur(
	entreprise varchar(16),
	description text,
	CONSTRAINT pk_vendeur PRIMARY KEY(entreprise)
);

INSERT INTO vendeur VALUES('Hendek','Commerce du site.'),('Aplep','L arnaque du web');

CREATE TABLE article(
	idart serial,
	libelle text NOT NULL,
	description text DEFAULT '?',
	prix numeric(10,2) NOT NULL,
	image text DEFAULT 'http://www.logementtunisie.com/images/upload/inconnu.jpg',
	CONSTRAINT pk_art PRIMARY KEY(idart),
	CONSTRAINT check_image CHECK(image LIKE 'http%://%_.__%'),
	CONSTRAINT check_prix CHECK(prix > 0.00)
);

INSERT INTO article(libelle,prix) VALUES ('bouteille vide',50.09),('biscuit',7.00);

CREATE TABLE infoart(
	idart integer,
	entreprise varchar(16) DEFAULT 'Hendek',
	CONSTRAINT pk_infoart PRIMARY KEY (idart,entreprise),
	CONSTRAINT fk_vendeur FOREIGN KEY (entreprise)
		REFERENCES vendeur(entreprise)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_article FOREIGN KEY (idart)
		REFERENCES article(idart)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO infoart VALUES (1,'Aplep');

CREATE TABLE lignefact(
	idligne serial,
	login varchar(16) NOT NULL,
	idart integer NOT NULL,
	qte integer DEFAULT 1,
	dat date DEFAULT now(),
	fait boolean DEFAULT 'false',
	CONSTRAINT pk_lignefact PRIMARY KEY(idligne),
	CONSTRAINT unique_login_art UNIQUE(login,idart),
	CONSTRAINT check_qte CHECK(qte>0),
	CONSTRAINT fk_article FOREIGN KEY (idart)
		REFERENCES article(idart)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_user FOREIGN KEY (login)
		REFERENCES utilisateur(login)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO lignefact(login,idart,qte) VALUES ('Faunus',1,10),('Faunus',2,2);

CREATE TABLE facture(
	nofacture serial,
	login text,
	status integer DEFAULT 0,
	address text,
	dat date,
	CONSTRAINT pk_facture PRIMARY KEY (nofacture),
	CONSTRAINT fk_user FOREIGN KEY (login)
		REFERENCES utilisateur(login)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	
);

CREATE OR REPLACE FUNCTION fact_gen_other( p_login varchar(16), p_dat date, p_address text)
RETURNS integer AS
$$
INSERT INTO facture(login,dat,address)VALUES($1,$2,$3)
RETURNING nofacture;
$$
LANGUAGE 'sql' VOLATILE;

CREATE OR REPLACE FUNCTION fact_gen( p_login varchar(16), p_dat date)
RETURNS integer AS
$$
INSERT INTO facture(login,dat)VALUES($1,$2)
RETURNING nofacture;
$$
LANGUAGE 'sql' VOLATILE;

--SELECT fact_gen('Faunus','2017-06-06') As fact_id;
--select * from facture join lignefact using (login,dat);
