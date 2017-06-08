<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<title>Hendek</title>
</head>

	<body style="background-color:#f7f7f7;">
	
       <header style="background-color:#3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
    <H1 style="color:white; font-size: 600%; font-weight:bold; margin-left:1%; display: inline-block;">HENDEK</H1>
      </header>
	  
	<div style="margin-left: 3%; margin-right: 3%;">
	    <a class="btn btn-default" href="#" role="button" style="width: 18%; margin-right:1%; background-color:#dfe3ee">Mon Panier</a>
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mon Compte</a>
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mes Commandes</a>
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Promotions</a>
		<%if(request.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Deconnexion</a>
		<%}%>
	</div>
	  
	<div style="background-color:#dddddd; margin: 2%; border-radius: 10px; padding: 1%;">
	
		<div style="background-color:#ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<form>
				<div class="form-group">
					<h2><label for="search">Rechercher un article :</label><h2>
					<input type="text" class="form-control" id="search" placeholder="ex : cocktails au white spirit">
				</div>
			</form>
		</div>
	
		<div style="background-color:#ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<h2>Susceptible de vous interesser :</h2>
			
			<div style="margin: 1%; border-radius: 10px;">
				<img src="https://www.leroymerlin.fr/multimedia/d21400296059/produits/rateau-a-gazon-leborgne-l-150-cm.jpg" alt="Rateau" style="width:10%;height:10%;display: inline-block;">
				<div style="display: inline-block;">
					<h3 style="margin-bottom:1%"><a href=#>Super Rateau<small style="margin-left:5%;">19,99&euro;</small></a></h3>
					<p> Un super rateau pour super rateler votre super jardin de ouf guedin <p>
					<p> Vraiment pas tres cher du tout et avec pleins de dents dessus <p>
				</div>
			</div>
			
			<div style="margin: 1%; border-radius: 10px;">
				<img src="https://statics.monoprix.fr/course/g_1774679_pure-vodka.jpg" alt="Belvedere" style="width:10%;height:10%;display: inline-block;">
				<div style="display: inline-block;">
					<h3 style="margin-bottom:1%"><a href=#>Belv&eacute;d&egrave;re - Pure Vodka<small style="margin-left:5%;">41,60&euro;</small></a></h3>
					<p> Elabor&eacute;e dans la plus pure tradition polonaise et exclusivement &agrave; partir de seigle d'or de dankowskie <p>
					<p> Son go&ucirc;t d&eacute;licieux convient &agrave; tout type de consommation : pure, sur glace, ou en cocktails <p>
				</div>
			</div>
			
		</div>
		
	</div>
  </body>