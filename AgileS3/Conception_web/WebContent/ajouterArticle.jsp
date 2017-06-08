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

<style>
.form-group {
	margin-bottom: 20px;
}
</style>

<body style="background-color: #f7f7f7;">
	<%
		if (!(((Me) session.getAttribute("user")) != null && ((Me) session.getAttribute("user")).getDroit() == 2)) {
			response.sendRedirect("./accueil.jsp");
			return;
		}

		Article art = Article.getInstance();
		boolean edit = request.getParameter("edit") != null;
		boolean resultEdit = request.getParameter("resultEdit") != null;
		int artId = -1;
		if (edit)
			artId = Integer.parseInt(request.getParameter("id"));
		else if(resultEdit){
			artId = Integer.parseInt(request.getParameter("resultEdit"));
			art.setStock(artId, Integer.parseInt(request.getParameter("stockArticle")));
			art.setImage(artId, request.getParameter("imageArticle"));
			art.setPrix(artId, Double.parseDouble(request.getParameter("prixArticle")));
			art.setLibelle(artId, request.getParameter("nomArticle"));
			art.setDescription(artId, request.getParameter("descriptionArticle"));
			art.setCat(artId, request.getParameter("catArticle"));
		}else if(request.getParameter("nomArticle") != null){
			art.addArticle(request.getParameter("nomArticle"),
					Double.parseDouble(request.getParameter("prixArticle")),
					request.getParameter("descriptionArticle"),
					request.getParameter("imageArticle"),
					request.getParameter("vendeurArticle"),
					Integer.parseInt(request.getParameter("stockArticle")),
					request.getParameter("catArticle")
					);
			out.print("<h3 style=\"color: green;\">L'article a bien été ajouté !</h3>");
		}
			
	%>
	<div style="background-color: #dddddd; margin: 2%; border-radius: 10px; padding: 1%;">
	<div class="container">
	<div class="page-header">
		<h1 style="text-align: center;"><% if(edit){out.print("Editer");}else{out.print("Ajouter");} %> un article</h1>
	</div>
	<div class="row">
	<div class="col-xs-6 col-xs-offset-3">
	<form>
	<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="nomArticle">Nom </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="nomArticle" name="nomArticle" value="<% if(edit) out.print(art.getLibelle(artId)); %>"/>
		</div>
	</div>
	<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="catArticle">Catégorie </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="catArticle" name="catArticle" value="<% if(edit) out.print(art.getCat(artId)); %>"/>
		</div>
	</div>
	<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="stockArticle">Stock </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="stockArticle" name="stockArticle" value="<% if(edit) out.print(art.getStock(artId)); %>"/>
		</div>
	</div>
	<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="vendeurArticle">Vendeur </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="vendeurArticle" name="vendeurArticle" value="<% if(edit) out.print(art.getVendeur(artId)); %>"/>
		</div>
	</div>
	<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="imageArticle">URL Image </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="imageArticle" name="imageArticle" value="<% if(edit) out.print(art.getImage(artId)); %>"/>
		</div>
	</div>
	<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="prixArticle">Prix </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="prixArticle" name="prixArticle" value="<% if(edit) out.print(art.getPrix(artId)); %>"/>
		</div>
	</div>
		<div class="form-group row" style="max-width: 500px;">
		<label class="col-form-label col-sm-2" for="descriptionArticle">Description </label>
		<div class="col-sm-10">
			<textarea name="descriptionArticle" id="descritptionArticle"><% if(edit) out.print(art.getDescription(artId)); %></textarea>
		</div>
	</div>
	<% if(edit) out.print("<input type=\"hidden\" name=\"resultEdit\" value=\""+artId+"\"/>");%>
	<input type="submit" value="<% if(edit){out.print("Editer");}else{out.print("Ajouter");} %>"/>
	</form>
	</div></div></div></div>


</body>
</html>