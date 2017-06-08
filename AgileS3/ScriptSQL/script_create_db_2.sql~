


DROP TABLE IF EXISTS facture;


DROP TABLE IF EXISTS personne;
DROP TABLE IF EXISTS article;


DROP TABLE IF EXISTS droit;

DROP TABLE IF EXISTS status;




CREATE TABLE droit(
	iddroit serial,
    libelle text NOT NULL,
    CONSTRAINT pk_droit PRIMARY KEY(iddroit)
);

INSERT INTO droit(iddroit,libelle)VALUES(-1,'BlackList'),(0,'En validation');
INSERT INTO droit(libelle)VALUES('Normal'),('Admin');


CREATE TABLE personne(

    	idpersonne serial,
    	droit integer NOT NULL DEFAULT 0,
    	nom varchar(20) NOT NULL,
    	prenom varchar(20) NOT NULL,
		login varchar (16) NOT NULL,
		mdp varchar(20) NOT NULL,
    	mail text NOT NULL,
    	tok text NOT NULL DEFAULT md5((random())::text),
    	CONSTRAINT pk_personne PRIMARY KEY(idpersonne),
    
    	CONSTRAINT fk_droit FOREIGN KEY (droit)
    	REFERENCES droit(iddroit)
    		ON UPDATE CASCADE
    		ON DELETE CASCADE,
		CONSTRAINT tok_is_unique UNIQUE (tok),
    	CONSTRAINT unique_mail UNIQUE (mail),
    	CONSTRAINT check_mail CHECK(mail LIKE '%_@_%.__%')
    
);

CREATE TABLE article(

    reference integer,
    produit text,
    prix numeric(10,2),
    lib text,
    image text,
    marque varchar(16),
    CONSTRAINT pk_article PRIMARY KEY(reference),
    CONSTRAINT check_url_img CHECK(image LIKE 'http://%_.__%')
        
);

CREATE TABLE status(

	idstatus integer,
	lib text NOT NULL,

	CONSTRAINT pk_status PRIMARY KEY (idstatus)

);

INSERT INTO status VALUES(-2,'Erreur de livraison'),(-1,'Erreur de stock'),(0,'En attente'),(1,'En cours de preparation'),(2,'Expidie'),(3,'Livre');

CREATE TABLE facture(
<<<<<<< HEAD
	idf serial,
 	qte integer NOT NULL,
	idclient integer NOT NULL,
	receveur text ,
    reference integer NOT NULL,
	nopanier integer NOT NULL,
=======

	idf serial,

   	qte integer NOT NULL,

	idclient integer NOT NULL,

	receveur text ,

    reference integer NOT NULL,

	nopanier integer NOT NULL,

>>>>>>> 767f7402661c8a23650dc8bbf7ede1ae2af711ce
	status integer DEFAULT 0,

	CONSTRAINT pk_facture PRIMARY KEY(idf),

    CONSTRAINT fk_personne FOREIGN KEY (idclient)
    	REFERENCES personne(idpersonne)
    	ON UPDATE CASCADE
    	ON DELETE CASCADE,

    CONSTRAINT fk_article FOREIGN KEY (reference)
    	REFERENCES article(reference)
    	ON UPDATE CASCADE
    	ON DELETE CASCADE,

	CONSTRAINT fk_status FOREIGN KEY(status)
		REFERENCES status(idstatus)
		ON UPDATE CASCADE
		ON DELETE CASCADE


);




<<<<<<< HEAD
=======



>>>>>>> 767f7402661c8a23650dc8bbf7ede1ae2af711ce
INSERT INTO personne(nom,prenom,mail,login,mdp) 
VALUES ('DURAND','Paul','flow.fb60@gmail.com','First','123456');

INSERT INTO personne(nom,prenom,mail,droit,login,mdp) 
VALUES ('DUPONT','Michel','florianb32@live.fr',2,'admin','admin');

INSERT INTO article(reference,produit,prix,lib,image,marque)
VALUES ('00001','bouteille vide',50.09,'une bouteille vide','http://www.embouteille.com/admin/images/produit/311_logo1_1302171015.jpeg','Aplpe');

INSERT INTO facture(idclient,reference,qte,nopanier)VALUES (1,'00001',10,0);
<<<<<<< HEAD
select * from facture JOIN article USING (reference);
=======
select * from facture JOIN article USING (reference);
>>>>>>> 767f7402661c8a23650dc8bbf7ede1ae2af711ce
