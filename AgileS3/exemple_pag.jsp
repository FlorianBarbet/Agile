<%

ArrayList<Integer> affichage = new ArrayList<>();
int cpt=0,lastID=0;
boolean next=true, prev=false;
if(request.getParameter("next")==null){
	for(int idart:articles.getAllLibelle().keySet() )
	{
		if(cpt<4){
			affichage.add(idart);
		cpt++;
		}

	}

}else{
	cpt=Integer.parseInt(request.getParameter("next"));
	for(int idart:articles.getAllLibelle().keySet() )
	{
		if(cpt<Integer.parseInt(request.getParameter("next"))+4){
			affichage.add(idart);
			cpt++;
		}

		lastID=idart;

	}
	if(lastID == affichage.get(3)){
		next=false;
	}
}


if(request.getParameter("prev")==null){

}else{

	cpt=Integer.parseInt(request.getParameter("prev"));
	for(int idart:articles.getAllLibelle().keySet() )
	{
		if(cpt>Integer.parseInt(request.getParameter("prev"))-4){
			affichage.add(idart);
			cpt--;
		}

		lastID=idart;
	}

	if(cpt==lastID || cpt>4){
		prev=true;
	}

}

%>



<% if(next){ %>
<a href="Select.jsp?next=<%=cpt%>" class="btn btn-default">Next</a>
<% } %>



<% if(prev){ %>
<a href="Select.jsp?prev=<%=cpt%>" class="btn btn-default" >Prev</a>
<% } %>
