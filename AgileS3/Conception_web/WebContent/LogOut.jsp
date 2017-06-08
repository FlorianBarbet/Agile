<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Logout</title>

</head>
<body>
	<%@ page
		import="java.io.*,javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*,java.sql.*"%>

	<%
		session = request.getSession(true);
		session.invalidate();
		response.sendRedirect("Login.jsp");
	%>


</body>
</html>