<%@ page
	import="java.lang.*,java.util.concurrent.ThreadLocalRandom, java.lang.Integer, java.util.*, achat.*, article.*, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<title>Hendek</title>
</head>
<body style="background-color: #f7f7f7;">

	<header
		style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
		<H1
			style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
			<a style="color: white" href=./accueil.jsp>HENDEK</a>
		</H1>
	</header>
	<h2 class="text-center"><%="Bonjour " + session.getAttribute("login")%></h2>
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
		%>

		<% if(((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 ){ %>
		<a class="btn btn-default" href="./admin.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Administration</a> 
		<% } else { %>
		<a class="btn btn-default" href="./edit_account.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a>
		<% } %>  <a class="btn btn-default" href="./MesCommandes.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mes
			Commandes</a> <a class="btn btn-default" href="./Promotions.jsp" role="button"
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
			<form action="./Select.jsp? method="GET">
				<div class="form-group">
					<label for="Search">Rechercher :</label> <input style=""
						type="text" class="form-control" id="search" name="search"
						placeholder="ex : Cocktails au white spirit">
				</div>
			</form>
		</div>
		<div>
			<h1>
				<%	Article article = Article.getInstance();
					if (request.getParameter("id") == null) {
						response.sendRedirect("accueil.jsp");
					} else {
						Integer id = Integer.valueOf(request.getParameter("id"));
						String category = Article.getInstance().getCat(id);
						
				%>
				<%=article.getLibelle(id)%></h1>
			<h4>Reference : <%=id%> - Categorie : <a href="Search.jsp?search=<%=category%>&searchbycategory=true"><%=category%></a></h4>

		</div>
		<div class="row">
			<div class="col-sm-4">


				<img class="img-responsive" src="<%=article.getImage(id)%>"
					alt="Image Article">


			</div>

			<div class="col-sm-4">
				<div>
					<h1>
						Prix :
						<%=article.getPrix(id)%>&euro;
					</h1>
				</div>
				<div>
					<h1>
						Quantit&eacute; :
						<%=article.getStock(id)%>
					</h1>
				</div>
			</div>

			<a href="AjouterPanier.jsp?id=<%=id%>&page=Article.jsp?id=<%=id%>"
				class="btn btn-primary btn-lg active" role="button"
				aria-pressed="true">Ajouter au panier</a>
		</div>
		<h3>
			Description du produit :
			<%=article.getDescription(id)%></h3>

	</div>
	<% Article articles = (Article)application.getAttribute("articles"); %>
			<% String cat = article.getCat(id);%>
			<% SortedSet<Integer> set = new TreeSet<Integer>(articles.getAllLibelle().keySet()); %>
			
			
			<%Integer r1 = null, r2 = null;
			for(Integer key: articles.getAllLibelle().keySet()) {
				if(articles.getCat(key).equals(cat)) {
					if(r1 == null && key != id)
						r1 = key;
					if(r1 != key && r1 != null && r2 == null && key != id) {
						r2 = key;
						break;
					}
						
				}	
				
			}
			if(r1 != null) {
			%>
			
	<div
			style="background-color: #ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<h2>Articles de la meme categorie :</h2>
			
			
		

			<div style="margin: 1%; border-radius: 10px;">
				<img src="<%=articles.getImage(r1)%>"
					alt="<%=articles.getLibelle(r1)%>"
					style="width: 10%; height: 10%; display: inline-block;">
				<div style="display: inline-block;">
				<h3 style="margin-bottom:1%"><a href=Article.jsp?id=<%=r1%>><%=articles.getLibelle(r1)%><small style="margin-left:5%;"><%=articles.getPrix(r1)%>&euro;</small></a></h3>
				<p><%=articles.getDescription(r1)%></p>
				</div>
				<a class="btn btn-default"
					href="./AjouterPanier.jsp?page=accueil.jsp&id=<%=r1%>"
					role="button"
					style="width: 10%; background-color: #dfe3ee; position: Absolute; right: 5%;">Ajouter
					au panier</a>
			</div>
			<%if(r2 != null) { %>
			<div style="margin: 1%; border-radius: 10px;">
				<img src="<%=articles.getImage(r2)%>"
					alt="<%=articles.getLibelle(r2)%>"
					style="width: 10%; height: 10%; display: inline-block;">
				<div style="display: inline-block;">
				<h3 style="margin-bottom:1%"><a href=Article.jsp?id=<%=r2%>><%=articles.getLibelle(r2)%><small style="margin-left:5%;"><%=articles.getPrix(r2)%>&euro;</small></a></h3>
				<p><%=articles.getDescription(r2)%></p>
				</div>
				<a class="btn btn-default"
					href="./AjouterPanier.jsp?page=accueil.jsp&id=<%=r2%>"
					role="button"
					style="width: 10%; background-color: #dfe3ee; position: Absolute; right: 5%;">Ajouter
					au panier</a>
			</div>
			<%} %>
			<%} %>
		</div>
	</div>
	<%} %>
</body>