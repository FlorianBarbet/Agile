<!DOCTYPE html>
<html>
<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, business.*, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<title>Hendek - Recherche</title>
</head>

<body style="background-color: #f7f7f7;">

	<%
		if (session.getAttribute("login") == null)
			response.sendRedirect("Login.jsp");
	%>

	<header
		style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
		<H1
			style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
			<a style="color: white" href=./accueil.jsp>HENDEK</a>
		</H1>
	</header>

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
		<%
			}

			String keyword = request.getParameter("search");
			String keywordHTML = "";
			if (keyword != null)
				keywordHTML = "value=\"" + keyword + "\"";

			boolean searchByName = (request.getParameter("searchbyname") != null);
			String searchByNameHTML = "checked";
			if (searchByName == false)
				searchByNameHTML = "unchecked";

			boolean searchByBrand = (request.getParameter("searchbybrand") != null);
			String searchByBrandHTML = "checked";
			if (searchByBrand == false)
				searchByBrandHTML = "unchecked";

			boolean searchByCategory = (request.getParameter("searchbycategory") != null);
			String searchByCategoryHTML = "checked";
			if (searchByCategory == false)
				searchByCategoryHTML = "unchecked";
			
			String sortedBy = request.getParameter("sortedby");
			String sortedByHTML = "Nom";
			if (sortedBy != null) {
				sortedByHTML = "value=\"" + keyword + "\"";
			
				switch (sortedBy) {
				case "Nom":
					sortedBy = "libelle";
					break;
				case "Categorie":
					sortedBy = "category";
					break;
				case "Prix":
					sortedBy = "prix";
					break;
				case "Recution":
					sortedBy = "discount";
					break;
				}
			}
		%>
		<% if(((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 ){ %>
		<a class="btn btn-default" href="./admin.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Administration</a>
		<% } else { %>
		<a class="btn btn-default" href="./edit_account.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a>
		<% } %>
		<a class="btn btn-default" href="./MesCommandes.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mes
			Commandes</a> <a class="btn btn-default" href="./Promotions.jsp"
			role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Promotions</a>
		<%
			if (session.getAttribute("login") == null) {
		%>
		<a class="btn btn-default" href="" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Connexion</a>
		<%
			} else {
		%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Deconnexion</a>
		<%
			}
		%>
	</div>

	<div
		style="background-color: #dddddd; margin: 2%; border-radius: 10px; padding: 1%;">

		<div
			style="background-color: #ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<form action="./Search.jsp? method="GET">
				<div class="form-group">
					<label for="search">Rechercher :</label> <input style=""
						type="text" class="form-control" id="search" name="search"
						placeholder="ex : Cocktails au white spirit" <%=keywordHTML%>>
					<input type="checkbox" name="searchbyname" value="true"
						<%=searchByNameHTML%>>Par nom&nbsp;&nbsp;&nbsp; <input
						type="checkbox" name="searchbybrand" value="true"
						<%=searchByBrandHTML%> disabled>Par
					marque&nbsp;&nbsp;&nbsp;<input type="checkbox"
						name="searchbycategory" value="true" <%=searchByCategoryHTML%>>Par
					categorie <br> <label for="sortedby">Trie par :</label> <select
						name="sortedby" onChange="combo(this, <%=sortedByHTML%>)">
						<option>Nom</option>
						<option>Categorie</option>
						<option>Prix</option>
						<option>Reduction</option>
					</select><br> <input type="submit" value="Rechercher"
						class="btn btn-primary">
				</div>
			</form>
		</div>


		<%
			if (keyword == null) {
		%>
		<h2>Pas d'arguments de recherche...</h2>
		<%
			} else {
				List<business.Article> articles = Bridge.searchArticles(keyword, searchByName, searchByBrand,
						searchByCategory, sortedBy);

				if (articles == null) {
		%>
		<h2">Erreur !</h2>
		<%
			} else if (articles.size() == 0) {
		%>
		<h2">Aucun resultat trouve...</h2>
		<%
			} else {
					for (Article article : articles) {
		%>
		<div style="margin: 1%; border-radius: 10px;">
			<img src="<%=article.getImageURL()%>" alt="<%=article.getName()%>"
				style="width: 10%; height: 10%; display: inline-block;">
			<div style="display: inline-block;">
				<h3 style="margin-bottom: 1%">
					<a href="<%="Article.jsp?id="+article.getReference()%>"><%=article.getName()%><small
						style="margin-left: 5%;"><%=article.getPrice()%>&euro;</small></a>
				</h3>
				<p><%=article.getDescription()%></p>
			</div>
			<a class="btn btn-default"
				href="./AjouterPanier.jsp?page=Select.jsp&id=<%=article.getReference()%>"
				role="button"
				style="width: 10%; background-color: #dfe3ee; position: Absolute; right: 5%;">Ajouter
				au panier</a>
		</div>
		<%
			}
				}
			}
		%>
	</div>

	</div>
</body>