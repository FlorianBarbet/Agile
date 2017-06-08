localhost:8080/Conception_web/verify.jsp?tok=61ff1a88c8b02ac3abadd80e533b1de7&droit=0&login=salutsalutsaluto 

/

Configuration à appliquer

Serveur de courrier sortant SMTP : smtps.univ-lille1.fr

Cocher Utiliser un nom et un mot de passe utilisateur ou Mon serveur requiert une authentification

Connexion sécurisée SSL

Nom du compte ou Nom d'utilisateur / mot de passe :  votre identifiant USTL

Port : 587

Utiliser une connexion sécurisé TLS (Thunderbird, ...) ou Ce serveur nécessite une connexion sécurisé (SSL) (Outlook, ...)

source : http://cri.univ-lille1.fr/Services-proposes/messagerie/configuration/SMTP/

/

tuto vpn : http://fil.univ-lille1.fr/documentation-vpn

/


appelez les Hendek !
Livraison chez toi, en moins de 2.

Exemple de creation de site de e-commerce en java : http://wayofcode.fr/site-de-e-commerce-en-java-ee-avec-spring-framework-partie-1/
/


Command line instructions 


Git global setup 

git config --global user.name "Alexandre RICHARD" 


git config --global user.email "alexandre.richard@etudiant.univ-lille1.fr" 



Create a new repository 

git clone https://git-iut.univ-lille1.fr/barbetf/AgileS3.git 

cd ProjeMode2016-O2 touch README.md 

git add README.md 

git commit -m "add README" 

git push -u origin master 


Existing folder 

cd existing_folder 


git init 

git remote add origin https://git-iut.univ-lille1.fr/bonevai/ProjeMode2016-O2.git 


git add . 


git commit git push -u origin master 



Existing Git repository 



cd existing_repo git remote add origin https://git-iut.univ-lille1.fr/bonevai/ProjeMode2016-O2.git 


git push -u origin --all git push -u origin --tags

