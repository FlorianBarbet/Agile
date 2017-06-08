<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
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

	<header
		style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
		<H1
			style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
			<a style="color: white" href=./accueil.jsp>HENDEK</a>
		</H1>
	</header>
	<div style="background-color:#dddddd; margin: 2%; border-radius: 10px; padding: 1%;">
	
                <% 
            System.out.println( "CHECK mdp : ~~~~~~~ "+session.getAttribute("login") +"\n");
            if(session.getAttribute("error")=="o"){ %>

                    <p class="error_message">Erreur les mots de passes ne correspondent pas.</p>

			<% }else if(session.getAttribute("errort")=="t"){ %>
	                        <p class="error_message">Veuillez entrer un mot de passe.</p>
			<% } else if(session.getAttribute("errore")=="e"){%>
	                        <p class="error_message"> ce login existe deja </p>
			<% } else if(session.getAttribute("errorm")=="m"){ %>
                                <p class="error_message"> ce mail est deja present sur ce site </p>
			<% } else if(session.getAttribute("errornull")=="nullr"){ %>
        	                <p class="error_message"> Veuillez renseigner :
					<% if(session.getAttribute("isnulll")!=null ) %>
						<%=session.getAttribute("isnulll")%>
					<% if(session.getAttribute("isnulln")!=null ) %>
						<%=session.getAttribute("isnulln")%>
					<% if(session.getAttribute("isnullna")!=null ) %>
						<%=session.getAttribute("isnullna")%>
					<% if(session.getAttribute("isnullp")!=null ) %>
						<%=session.getAttribute("isnullp")%>
                                    </p>
			<% } else if(session.getAttribute("errorfm")=="fm"){ %>
                               <p class="error_message"> cette adresse email est invalide </p>
			<% } %>
                                            <header>
                                                <h1 class="color-clear">Inscription</h1>
                                            </header>

                                            <form method="get" action="servlet_ins.jsp">
 
                                              	 <div class="form-group">
                                                    <label for="login">Login*</label>
                                                    <input type="text" maxlength="16" class="form-control"  value="${login}" name="login"/>
                                                </div>
                                                
												 <div class="form-group">
                                                    <label for="nom">Nom</label>
                                                    <input type="text" maxlength="20" class="form-control" value="${nom}" name="nom" />
                                                </div>
                                                
                                                <div class="form-group">
                                                      <label for="prenom">Prénom</label>
                                                      <input type="text" maxlength="16" class="form-control"  value="${prenom}" name="prenom" />
                                                </div>
                                                
                                                <div class="form-group">
                                                	<label for="address">Adresse*</label>
                                                	<input type="text" size="10" maxlength="250" value="${address}" class="form-control" name="address" />
                                                </div>
                                                
                                                 <div class="form-group">
                                                	<label for="mail">E-Mail*</label> 
                                                	<input type="email" maxlength="50" value="${mail}" class="form-control" name="mail" /></p>
                                                </div>

                                                <div class="form-group">
                                                    <label for="tel">Téléphone</label> 
                                                    <input type="text" maxlength="10" value="${tel}" class="form-control" name="tel" />
                                                </div>

                                                <div class="form-group">
                                                	<label for="mdp">Mot de passe</label> 
                                               		<input type="password" maxlength="16"  class="form-control"  value="${mdp}" name="mdp"/>
                                                	<label for="checkmdp">Confirmer mot de passe</label> 
                                                	<input type="password" maxlength="16" value="" class="form-control" name="checkmdp"/>
                                                </div>


                                                <input type=submit value="Valider" class="btn btn-primary btn-x1" />
                                            </form>
                                            
                                            <p class="ecritpetit text-left">* : obligatoire </p>

            </div>
</body>
</html>
