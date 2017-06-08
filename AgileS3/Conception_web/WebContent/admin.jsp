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
	<% if(!  (((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 )){ %>
	<% response.sendRedirect("./accueil.jsp");%>
	<%}%>

<header
	style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
	<H1
		style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
		<a style="color: white" href=./accueil.jsp>HENDEK</a>
	</H1>
</header>

<style>
/* make sidebar nav vertical */ 
@media (min-width: 768px){
  .affix-content .container {
    width: 700px;
  }   

  html,body{
    background-color: #f8f8f8;
    height: 100%;
    overflow: hidden;
  }
    .affix-content .container .page-header{
    margin-top: 0;
  }
  .sidebar-nav{
        position:fixed; 
        width:100%;
  }
  .affix-sidebar{
    padding-right:0; 
    font-size:small;
    padding-left: 0;
  }  
  .affix-row, .affix-container, .affix-content{
  	
    height: 100%;
    margin-left: 0;
    margin-right: 0;    
  } 
  .affix-content{
    background-color:white; 
  } 
  .sidebar-nav .navbar .navbar-collapse {
    padding: 0;
    max-height: none;
  }
  .sidebar-nav .navbar{
    border-radius:0; 
    margin-bottom:0; 
    border:0;
  }
  .sidebar-nav .navbar ul {
    float: none;
    display: block;
  }
  .sidebar-nav .navbar li {
    float: none;
    display: block;
  }
  .sidebar-nav .navbar li a {
    padding-top: 12px;
    padding-bottom: 12px;
  }  
}

@media (min-width: 769px){
  .affix-content .container {
    width: 600px;
  }
    .affix-content .container .page-header{
    margin-top: 0;
  }  
}

@media (min-width: 992px){
  .affix-content .container {
  width: 900px;
  }
    .affix-content .container .page-header{
    margin-top: 0;
  }
}

@media (min-width: 1220px){
  .affix-row{
    overflow: hidden;
  }

  .affix-content{
    overflow: auto;
  }

  .affix-content .container {
    width: 1000px;
  }

  .affix-content .container .page-header{
    margin-top: 0;
  }
  .affix-content{
    padding-right: 30px;
    padding-left: 30px;
  }  
  .affix-title{
    border-bottom: 1px solid #ecf0f1; 
    padding-bottom:10px;
  }
  .navbar-nav {
    margin: 0;
  }
  
  .navbar-collapse{
    padding: 0;
  }
  .sidebar-nav .navbar li a:hover {
    background-color: #428bca;
    color: white;
  }
  .sidebar-nav .navbar li a > .caret {
    margin-top: 8px;
  }  
}

</style>

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
		<% } %>  <a class="btn btn-default" href="./MesCommandes.jsp" role="button"
		style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mes
		Commandes</a> <a class="btn btn-default" href="./Promotions.jsp" role="button"
		style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Promotions</a>
	<%if(session.getAttribute("login")==null){ %>
	<a class="btn btn-default" href="" role="button"
		style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Connexion</a>
	<%}else{%>
	<a class="btn btn-default" href="./LogOut.jsp" role="button"
		style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Deconnexion</a>
	<%}%>
</div>

<div class="row affix-row" style="margin-top: 50px; margin-left: 3%;">
    <div class="col-sm-3 col-md-2 affix-sidebar">
		<div class="sidebar-nav">
  <div class="navbar navbar-default" role="navigation">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-navbar-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      </button>
      <span class="visible-xs navbar-brand">Sidebar menu</span>
    </div>
    <div class="navbar-collapse collapse sidebar-navbar-collapse" >
      <ul class="nav navbar-nav" id="sidenav01" style="">
        <li class="active">
          <a style="background-color: #dfe3ee;" data-toggle="collapse" data-target="#toggleDemo0" data-parent="#sidenav01" class="collapsed">
          <h4>Panneau de contrôle</h4>
          </a>
        </li>
        <li><a href="javascript:" onclick="changeCat(0)"><span class="glyphicon glyphicon-user"></span> Utilisateur</a></li>
        <li><a href="javascript:" onclick="changeCat(1)"><span class="glyphicon glyphicon-barcode"></span> Article</a></li>
        <li><a href="javascript:" onclick="changeCat(2)"><span class="glyphicon glyphicon-inbox"></span> Tickets<span style="margin-left: 10px;" class="badge">42</span></a></li>
      </ul>
      </div><!--/.nav-collapse -->
    </div>
	</div>
		</div>
	<div class="col-sm-9 col-md-10 affix-content">
		<div class="container">
			
				<div class="page-header">
	<h3 id="Titre"><span class="glyphicon glyphicon-th-list"></span> 
	<%
		String user = request.getParameter("idUser");
		int article = (request.getParameter("idArticle") != null ? Integer.parseInt(request.getParameter("idArticle")) : -1);
		int ticket = -1;
		boolean supprimerUser = (request.getParameter("supprimerUser") != null);
		int droitUser = (request.getParameter("droitUser") != null ? Integer.parseInt(request.getParameter("droitUser")) : -2);
		boolean supprimerArticle = (request.getParameter("supprimerArticle") != null);
		if(user != null && article != -1) article = -1;
		if(user != null) out.println("Utilisateur");
		else if(article != -1) out.println("Article");
		else out.println("Bienvenu sur le panneau de controle d'administrateur !");
	%></h3>
	</div>
	<div class="cat-content" <% if(user == null){ %> style="display: none;" <% } %> title="Utilisateur">
	
	<% 
	User us = null;
	if(user != null){ 
		us = User.getInstance();
		String[] droits = {"bloqué", "", "débloqué", "promu administrateur"};
		if(us.getNom(user) != null && supprimerUser){
			out.print("<h3 style=\"color:green;\"> L'utilisateur "+user+" a bien été suprrimé</h3>");
			us.rmUser(user);
		}else if(us.getNom(user) == null && supprimerUser){
			out.print("<h3 style=\"color:red;\"> Impossible de supprimer cet utilisateur car il n'existe pas</h3>");
		}else if(us.getNom(user) != null && droitUser != -2){
			out.print("<h3 style=\"color: green;\"> L'utilisateur a bien été "+droits[droitUser+1]+"</h3>");
			us.setDroit(user, droitUser);
		}else if(us.getNom(user) == null && droitUser != -2){
			out.print("<h3 style=\"color:green;\"> L'utilisateur n'a pas pu être "+droits[droitUser+1]+" car il n'existe pas</h3>");
		}
	}
	%>
	
	<form>
	<label for="user">Login utilisateur : </label>
	<input type="text" id="user" name="idUser"/>
	<input type="submit" value="Go"/>
	</form>
	
	<%
		if(user != null && !supprimerUser){
			if(us.getNom(user) != null){
	%>
		<h3> <%= user %></h3>
		Nom : <%= us.getNom(user) %><br/>
		Prénom : <%= us.getPrenom(user) %><br/>
		Droit : <%= us.getDroit(user) %><br/>
		
		<form>
		<input type="hidden" name="idUser" value="<%= user %>"/>
		<%
			if(us.getDroit(user) == -1)
				out.println("<button name=\"droitUser\" value=\"1\" type=\"submit\">Débloquer</button>");
			else if(us.getDroit(user) < 2){
				out.println("<button name=\"droitUser\" value=\"-1\" type=\"submit\">Bloquer</button>");
				out.println("<input type=\"submit\" name=\"supprimerUser\" value=\"Supprimer\"/>");
			}
			if(us.getDroit(user) >= 0 && us.getDroit(user) < 2)
				out.println("<button name=\"droitUser\" value=\"2\" type=\"submit\">Mettre admin</button>");
		%>
		</form>
			
	<% }else{ %>
		<h3 style="color:red;"> Aucun utilisateur trouvé avec ce login !</h3>
	<% }} %>

	</div>
	<div class="cat-content" <% if(article == -1){ %> style="display: none;" <% } %> title="Article">

	<% 
	Article art = null;
	if(article != -1){ 
	art = Article.getInstance(); 
		if(art.getLibelle(article) != null && supprimerArticle){
			out.print("<h3 style=\"color:green;\"> L'article "+art.getLibelle(article)+" a bien été suprrimé</h3>");
			art.rmArticle(article);
		}else if(art.getLibelle(article) == null && supprimerArticle){
			out.print("<h3 style=\"color:red;\"> Impossible de supprimer cet article car il n'existe pas</h3>");
		}
	}
	%>
		
	<form style="display: inline;">
	<label for="article">Ref article : </label>
	<input type="text" id="article" name="idArticle"/>
	<input type="submit" value="Go"/>
	</form>
	
	ou <button onclick="window.location='ajouterArticle.jsp'">Ajouter un article</button>
	
	<%
		if(article != -1 && !supprimerArticle){
			if(art.getLibelle(article) != null){
	%>
		<h3> <%= art.getLibelle(article) %></h3>
		<form style="display: inline;">
		<input type="hidden" name="idArticle" value="<%= article %>"/>
		<input type="submit" name="supprimerArticle" value="Supprimer"></input>
		</form>
		
		<button onclick="window.location='ajouterArticle.jsp?edit=1&id=<%= article %>'">Editer</button>
			
	<% }else{ %>
		<h3 style="color:red;"> Aucun article trouvé avec cette réference !</h3>
	<% }} %>
	
	</div>
	<div class="cat-content" <% if(ticket == -1){ %> style="display: none;" <% } %> title="Ticket">
	
	Ticket !
	
	</div>
	</div>
	</div>
</div>

<script>
	var cat = document.getElementsByClassName("cat-content");
	var title = document.getElementById("Titre");
	var actual = <% if(user != null) out.print(0); else if(article != -1) out.print(1); else out.println(2); %>;
	function changeCat(categorie){
		console.log(cat);
		cat[actual].style.display="none";
		cat[categorie].style.display="block";
		title.innerHTML = "<span class=\"glyphicon glyphicon-th-list\"></span> "+cat[categorie].getAttribute("title");
		actual = categorie;
	}
</script>

</body>
</html>