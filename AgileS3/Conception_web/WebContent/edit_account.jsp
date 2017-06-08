<%@ page pageEncoding="UTF-8"%>
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

	<div style="margin-left: 3%; margin-right: 3%;">
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier</a> <a class="btn btn-default" href="./edit_account.jsp"
			role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a> <a class="btn btn-default" href="./MesCommandes.jsp" role="button"
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

	<%
		if (request.getParameterMap().size() == 4) {
			String new_mail = request.getParameter("mail");
			String new_password = request.getParameter("password");
			String new_default_address = request.getParameter("default_address");
			String new_phone = request.getParameter("phone");
			
			User user = User.getInstance();
			
			System.out.println("Changements : " + new_mail + new_password + new_default_address + new_phone);
		}
	%>


	<%
		if (session.getAttribute("login") != null) {
			String login = (String) session.getAttribute("login");

			User user = User.getInstance();

			String mail = user.getMail(login);
			String password = user.getMDP(login);
			String default_address = user.getAddress(login);
			String phone = user.getTel(login);
			System.out.println("--->" + default_address);
	%>

	<div
		style="background-color: #dddddd; margin: 2% 22% 0 22%; border-radius: 10px; padding: 1%;">

		<div
			style="background-color: #ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<form>
				<div class="form-group">
					<h2>
						Modifier le compte
						<h2>
							<h3>
								<label for="mail">Mail :</label>
								<h3>
									<input type="text" class="form-control" id="mail"
										value=<%=mail%>>
									<h3>
										<label for="password">Mot de passe :</label>
										<h3>
											<input type="password" class="form-control" id="password"
												value=<%=password%>>
											<h3>
												<label for="default_address">Addresse par default :</label>
												<h3>
													<textarea class="form-control" id="default_address"
														rows="3"><%=default_address%></textarea>
													<h3>
														<label for="phone">Telephone :</label>
														<h3>
															<input type="text" class="form-control" id="phone"
																value=<%=phone%>> <br> <input type="submit"
																class="form-control" id="submit" value="Valider">
				</div>
			</form>
		</div>
	</div>

	<%
		} else {
			response.sendRedirect("accueil.jsp");
		}
	%>
</body>