<%@ page language="java" import="java.sql.*" %>
<html>
<head>
</head>

<body>

<% 

if(session!=null) {	
session.invalidate();
response.sendRedirect("indexlogin.jsp")	;
}	

 %>
</body>
</html>
