<%@ page session="true" import="java.sql.*,java.util.*"  %>
<head>
	<title>pension</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">


</head>

<%

String username = request.getParameter("username")==null?"":(String) request.getParameter("username");
String password = request.getParameter("password")==null?"":(String) request.getParameter("password");


if( (username.equals("kvic"))&&(password.equals("kvic@123")) ){
 session.setAttribute("kvic@123", "kvic@123");
response.sendRedirect("hologin.jsp"); 

	
	
	
	
	
	
	
	}else{			   
				   session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("indexho.jsp");
                    rd.forward(request, response); 
			}	
%>


