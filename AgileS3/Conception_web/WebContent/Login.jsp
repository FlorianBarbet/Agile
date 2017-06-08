<%@ page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page
	import="java.lang.*, java.util.concurrent.ThreadLocalRandom, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>


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

	<div
		style="background-color: #dddddd; margin: 2%; border-radius: 10px; padding: 1%;">

		<div class="container">
			<div class="page-header">
				<h1 style="text-align: center;">Connexion à notre site de
					commerce en ligne HENDEK</h1>
			</div>
			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form id="loginForm" method="POST" action="">
						<div class="form-group">
							<label for="login" class="control-label">Login</label> <input
								type="text" class="form-control" id="login" name="login"
								value="">
						</div>
						<div class="form-group">
							<label for="password" class="control-label">Mot de passe</label>
							<input type="password" class="form-control" id="password"
								name="mdp" value="">
						</div>

						<button type="submit" class="btn btn-success btn-block">Envoyer</button>
						<%						
						Connection con=null;
						
						    
						    // enregistrement du driver
						    Class.forName("org.postgresql.Driver");
						    
						    // connexion a la base
						    Article articles = Article.getInstance();	
						    application.setAttribute("articles", articles);
						    con = DriverManager.getConnection("jdbc:postgresql://psqlserv/n2p1","barbetf","moi");
						    String login = request.getParameter("login");
						    // execution de la requete
							PreparedStatement ps = con.prepareStatement("select * from utilisateur where login=? and mdp=?");
							ps.setString(1, request.getParameter("login"));
							ps.setString(2, request.getParameter("mdp"));
						    ResultSet rs = ps.executeQuery();
						    String retour = request.getParameter("page");
						    
						    if(rs.next()) {
								 session = request.getSession(true);
								 session.setAttribute("user", new Me(request.getParameter("login"), request.getParameter("mdp")));
								 session.setAttribute("panier", new Panier(request.getParameter("login"), request.getParameter("mdp")));
								// les autres pages devront tester la presence de login pour savoir si on a bien ete authentifie
								
								session.setAttribute("login", login);
								con.close();
								if(retour != null) {
									response.sendRedirect(retour+".jsp");
								} else {
									response.sendRedirect("accueil.jsp");
								}
									
						    } else { 
						    	out.println("<div class='container'>");
							    	out.println("<div class='page-header'>");
							
									out.println("</div>");
							    	
									out.println("<div class='row'>");
										out.println("<div class='col-xs-12'>");
										//	out.println("<div class='alert alert-danger' role='alert'>Login ou mot de passe incorrect.</div>");
										    con.close();
								
									    out.println("</div>");
								    out.println("</div>");
							    out.println("</div>");
						    }
						    
						    out.println("</center>");
					
						
						%>
						<!-- <a href="servlet/New" class="btn btn-default btn-block">Créer un compte !</a> -->
					</form>
					
					<a class="btn btn-default" href="./Inscription.jsp" role="button" style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Inscription</a>
				</div>
			</div>
		</div>

	</div>
</body>