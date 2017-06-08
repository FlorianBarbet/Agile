<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.lang.*, java.util.concurrent.ThreadLocalRandom, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if(session.getAttribute("panier")!=null){%>
	<% ((Panier)session.getAttribute("panier")).addPanier(request.getParameter("id"), 1); %>
	<% response.sendRedirect("./"+request.getParameter("page"));%>
	<% } else { response.sendRedirect("./accueil.jsp");}%>
</body>
</html>