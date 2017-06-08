<!DOCTYPE html>
<html>
<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<title>Hendek</title>
</head>

<body style="background-color: #f7f7f7;">
	
	<%if (request.getParameter("clear")!=null){%>
	<%Panier empty = new Panier( ((Me)session.getAttribute("user")).getLogin(), ((Me)session.getAttribute("user")).getPassword() );%>
	<%session.setAttribute("panier", empty); %>
	<% }%>
	
	<%if (request.getParameter("rm")!=null){%>
	<% Panier newPanier = (Panier)session.getAttribute("panier"); %>
	<% newPanier.rmPannier(request.getParameter("rm")); %>
	<% session.setAttribute("panier", newPanier); %>
	<% }%>
	
	<%if (session.getAttribute("login") == null || session.getAttribute("panier") == null){
			response.sendRedirect("Login.jsp");}%>

	<header
		style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
		<H1
			style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
			<a style="color: white" href=./accueil.jsp>HENDEK</a>
		</H1>
	</header>

	<div style="margin-left: 3%; margin-right: 3%;">
		<%if(session.getAttribute("panier")==null){ %>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier (Vide)</a>
		<%}else{%>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier (<%=(((Panier)session.getAttribute("panier")).getNbContent())%>)
		</a>
		<%}%>
		<% if(((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 ){ %>
		<a class="btn btn-default" href="./admin.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Administration</a> 
		<% } else { %>
		<a class="btn btn-default" href="./edit_account.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a>
		<% } %> <a class="btn btn-default" href="./MesCommandes.jsp" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mes Commandes</a>
				
		<a class="btn btn-default" href="./Promotions.jsp" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Promotions</a>
			<%if(session.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee; float: right;">Deconnexion</a>
		<%}%>
	</div>

	<div style="background-color:#dddddd; margin: 2%; border-radius: 10px; padding: 1%;">
	
	<% if(session.getAttribute("panier")!=null){ %>
	<% Panier mypan = (Panier)session.getAttribute("panier");%>
		<table class="table table-hover">
			<%= mypan.toString() %>
		</table>
	</div>
	<%}%>
	<div>
	<a class="btn btn-primary" href="PasserCommande.jsp" role="button"style="width: 18%; margin-left:2%; margin-right:1%;">Passer la commande</a>
	
	<a class="btn btn-warning" href="./MonPanier.jsp?clear=yes" role="button" style="width: 18%; margin-left:1%; margin-right:1%;">Vider mon panier</a>
	</div>
</body>
</html>
