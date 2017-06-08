<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<%@ page import=" java.io.*,
 javax.servlet.*,
 javax.servlet.http.*,
 javax.servlet.annotation.WebServlet,
 java.util.Properties,
 java.sql.PreparedStatement,
 java.sql.ResultSet,
 javax.mail.*,
 javax.mail.internet.*,
 java.sql.DriverManager,
 java.sql.Connection,
 java.util.Calendar,
 java.sql.Date,
 java.sql.Types,
 org.apache.commons.validator.routines.EmailValidator," %>

<!DOCTYPE html>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<style>
                .successfull_message {
                   	 background-color: #fff;
                   	 color: #03d826;
                }

		.error_message {
   			color: #b90202;
    			background-color: #fff;
		}

		.ecritpetit {
   			 font-size: 10px;
   			 color:#000;
		}

</style>
<title>Hendek</title>
</head>

<body style="background-color: #f7f7f7;">

 <%
	String table = "utilisateur";
	String code=request.getParameter("tok");
	String droit=request.getParameter("droit");
	String login=request.getParameter("login");
	String content="";
	

	
		
	content="<section class=\"\">\n<header><h1 class=\"\">Verification email</h1>\n</header>\n";
		
	if (login==null || code == null || droit == null){
		session.setAttribute("badlink","y");
		response.sendRedirect("../Login.jsp");
	}else if(!droit.equals("0")){

		content+="\n<p class=\"error_message\">Ce lien à déjà été utilisé.</p>";
		content+="\n<p class=\"error_message\">Si vous avez un problème veuillez Appeler les HENDEK </p>";

	}else{ 
		Connection con=null;

		try{
			Class.forName("org.postgresql.Driver");
			System.out.println("ICI PB4");
			String url="jdbc:postgresql://psqlserv/n2p1";
			String nom="barbetf";
			String mdpasse="moi";
			con = DriverManager.getConnection(url,nom,mdpasse);

			PreparedStatement ps=con.prepareStatement("select nom,prenom,tel,mail,address,dateins,droit,login,mdp from "+table+" WHERE login=? AND code=? AND droit=?;");

			ps.setString(1, login);
			ps.setString(2, code);
			ps.setInt(3, Integer.parseInt(droit));
			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()&&rs.getInt("droit")==0){
				PreparedStatement ps2=con.prepareStatement("UPDATE "+table+" set  droit=1 WHERE login=? AND code=?");
				ps2.setString(1, login);
				ps2.setString(2, code);
				ps2.executeUpdate();
				
				content+="<p class=\"successfull_message\">Votre enregistrement s'est bien terminé.</p>\n";
				content+="<p class=\"successfull_message\">Si vous avez un problème veuillez appeler les hendek </p>\n";
				
				session.setAttribute("user",new Me(rs.getString("login"),rs.getString("mdp")));
				session.setAttribute("panier",new Panier(rs.getString("login"),rs.getString("mdp")));
				
				session.setAttribute("login",rs.getString("login"));
								
				session.setMaxInactiveInterval(600);

			}else{
				content+="<p class=\"error_message\">Ce lien à déjà été utilisé.</p>\n";
			}

		}
		catch (Exception e) {
			content+="<p>Oups ! il semblerai que vous avez appelé les Hendeks </p>";
			System.out.println("=====> ERROR(Verify(1)) : "+e.getMessage());
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				content+="<p>Oups ! il semblerai que vous avez appelé les Hendeks </p>";
				System.out.println("=====> ERROR(Verify(2)) : "+e.getMessage());
			}
		}

	}
	content+="<a href=\"accueil.jsp\" class=\"btn\">Accueil</a> ";
	content+="</section>";

	out.println(content);
 %>
</body>
</html>