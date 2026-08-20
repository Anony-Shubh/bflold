
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%@ page import="java.io.*"%>
<%
String vAppid= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");



		  
	    session.setAttribute("sAPP_ID", vAppid);	
	  	
	
	
	  
	  response.sendRedirect ("userCrend.jsp");	  
	  
	  
	 
	    


	 %> 




	   
	   
	   
	   