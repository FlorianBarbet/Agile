<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<%@ page import="java.io.*,
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
 java.sql.Types" %>

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
	ArrayList<String> link = new ArrayList<String>();
	String lien="";
String table = "lignefact";
	
	if(session.getAttribute("user")==null || session.getAttribute("panier")==null)
		response.sendRedirect("Login.jsp");

	ArrayList<String> produit = new ArrayList<>();
	ArrayList<String> count = new ArrayList<>();

	Connection con = null;

	%> avant if <%

			try{
				%> try <% 
				Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://psqlserv/n2p1";
				String user = "barbetf";
				String mdpasse = "moi";
				con = DriverManager.getConnection(url,user,mdpasse);
				String query="INSERT INTO ";
				query+=table+"(login,idart,qte) VALUES ";
				int idartLast=0;
				PreparedStatement ps = con.prepareStatement(query+"(?,?,?);");
				for(String key : ((Panier)session.getAttribute("panier")).getProduits().keySet()){
					
					
					ps.setString(1,((Me)session.getAttribute("user")).getLogin());
					ps.setInt(2,Integer.parseInt(key));
					ps.setInt(3,((Panier)session.getAttribute("panier")).getCount(key));
					ps.executeUpdate();
					
					produit.add(((Panier)session.getAttribute("panier")).getLib(key));
					count.add(((Panier)session.getAttribute("panier")).getCount(key).toString());
					
					idartLast=Integer.valueOf(key);
				}
				%> apres for <%
				Date dat=null;
				query="SELECT dat FROM lignefact WHERE login='"+((Me)session.getAttribute("user")).getLogin()+"' AND idart='"+idartLast+"';";
				
				Statement stmt = con.createStatement();
				stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				if(rs.next())
				dat = rs.getDate("dat");
				
				%> apres rs next -> ps<%
				if(session.getAttribute("address")==null){
					query="INSERT INTO facture (login,dat,address) VALUES (?,?,?)";
					ps = con.prepareStatement(query);
					ps.setString(1,((Me)session.getAttribute("user")).getLogin());
					ps.setDate(2,dat);
					ps.setString(3,((Me)session.getAttribute("user")).getAddress());
				}else{
					query="INSERT INTO facture (login,dat,address) VALUES (?,?,?)";
					ps = con.prepareStatement(query);
					ps.setString(1,((Me)session.getAttribute("user")).getLogin());
					ps.setDate(2,dat);
					ps.setString(3,(String)session.getAttribute("address"));
				}
				%> av update<%
				ps.executeUpdate();
				%> apres update<%
				
				String content="<h1>HENDEK prend en charge votre livraison</h1>\n";
				content+="<p>Bonjour "+((Me)session.getAttribute("user")).getLogin()+",<p>";
				content+="\n<p>Nous prenons bien en charge votre livraison<p>";
				content+="\n<p>verifier les informations :</p>\n<ul>";
				for(int i=0; i < produit.size();i++){
					content+="\n <p>"+produit.get(i)+" - "+count.get(i)+"</p>\n";
				}
				

				content+="<h2>Appelez les HENDEKs</h2>";
				%> av Mail.send 
				
				<% new Mail().sendMail(content,((Me)session.getAttribute("user")).getMail());
			
				response.sendRedirect("MonPanier.jsp?clear=true");
				
			}catch (Exception e) {
				%> catch 1<%
				out.println("=====>"+ e.getCause()+ e.getMessage());
				

			}
			finally {	  
				try{
					con.close();	  
				}catch (Exception e) {
					%> catch 2 <%
					System.out.println("=====> ERROR(Mailer.service(2)) : "+e.getMessage());
				}
			}
		
 
 
 %>
</body>
</html>