
<%
	if (session.getAttribute("login") == null || session.getAttribute("panier") == null) {
		response.sendRedirect("Login.jsp");
	}
%>
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

<header
	style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
	<H1
		style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
		<a style="color: white" href=./accueil.jsp>HENDEK</a>
	</H1>
</header>
<body style="background-color: #f7f7f7;">
	<div style="margin-left: 3%; margin-right: 3%;">
		<%
			if (session.getAttribute("panier") == null) {
		%>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier (Vide)</a>
		<%
			} else {
		%>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier (<%=(((Panier) session.getAttribute("panier")).getNbContent())%>)
		</a>
		<%}%>
		<% if(((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 ){ %>
		<a class="btn btn-default" href="./admin.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Administration</a> 
		<% } else { %>
		<a class="btn btn-default" href="./edit_account.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a>
		<% } %> <a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mes Commandes</a>
				
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Promotions</a>
			<%if(session.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee; float: right;">Deconnexion</a>
		<%
			}
		%>
	</div>
	<%
		Integer nbArt = ((Panier) session.getAttribute("panier")).getNbContent();
		if (nbArt == 1) {
	%>
	<h1>
		Passer la commande (<%=nbArt%>article)
	</h1>
	<%
		}
		if (nbArt == 0) {
	%>
	<h1>Aucun article !</h1>
	<%
		}
		if (nbArt > 1) {
	%>

	<h1 style="margin-left: 3%;">
		Passer la commande (<%=nbArt%>
		articles)
	</h1>
	<%
		}
	%>
	<%
		String chAddr = request.getParameter("chAddr");
		
	%>


	<h1 style="display: inline-block; margin-left: 2%; margin-right: 1%;">1: Adresse et livraison :</h1>
	<a href="PasserCommande.jsp?chAddr=true"
		style="display: inline-block; margin-left: 2%; margin-right: 1%;"
		class="btn btn-primary btn-lg active" role="button">Autre adresse</a>
		<%String addr = ((Me)session.getAttribute("user")).getAddress(); %>
	<%if (chAddr == null)  {%>
	<h3 style="margin-left: 3%;">Adresse : <%= addr%></h3>

	<%}
		if (chAddr != null) {
			if (chAddr.equals("true")) {
	%>

	<form style="margin-left: 3%;"class="form-inline" method="POST" action="">
		<label class="sr-only" for="inlineFormInput">Adresse</label> <input
			type="text" class="form-control mb-2 mr-sm-2 mb-sm-0" id="autreAddr"
			name="autreAddr" placeholder="Ex : 10 Rue des Roux">

		<button type="submit" class="btn btn-primary">Valider</button>
	</form>

	<%
		}
		}
	%>
	<%
		addr = request.getParameter("autreAddr");
		if (addr != null && chAddr != null) {
	%>
	<h3 style="margin-left: 3%;">Nouvelle adresse :<%=addr%></h3>
	
	<%
		}
		session.setAttribute("address", addr);
	%>
	
	<h1 style="display: inline-block; margin-left: 2%; margin-right: 1%;">2: Moyen de paiement :</h1>
	
	<%String cb = ""; %>


	<form style="margin-left: 3%;"class="form-inline" method="POST" action="">
		<label class="sr-only" for="inlineFormInput">Carte bancaire :</label> <input
			type="text" class="form-control mb-2 mr-sm-2 mb-sm-0" id="cb"
			name="cb" placeholder="Ex : 5985-78958-58899">

		<button type="submit" class="btn btn-primary">Valider</button>
	</form>

	
	<%
		cb = request.getParameter("cb");
		if (cb != null) {
	%>
	<h3 style="margin-left: 3%;">Numero de carte bancaire :<%=cb%></h3>
	<%
		}
	
	%>
	<h1 style="display: inline-block; margin-left: 2%; margin-right: 1%;">3: Recapitulatif de la commande :</h1>
	<% if(session.getAttribute("panier")!=null){ %>
	<% Panier mypan = (Panier)session.getAttribute("panier");%>
		<table class="table table-hover" style="margin-left: 3%;">
			<%= mypan.toString() %>
		</table>
	</div>
	<%}%>
	<a href="livraison.jsp"
		style="display: inline-block; margin-left: 2%; margin-right: 1%;"
		class="btn btn-danger btn-lg btn-block" role="button">Payer</a>


</body>