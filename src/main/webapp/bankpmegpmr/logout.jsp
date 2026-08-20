<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>PMEGP Monitoring Logout form for Bank</title>

</head>
  <% 

response.setHeader("Cache-Control", "no-store");
response.setHeader("Cache-Control", " max-age=0, must-revalidate, no-cache, no-store, private"); 
response.setHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
response.setDateHeader("Expires", 0); 
response.setDateHeader("Expires", -1);
 %> 
  <form name="form1" method="post" action="logout.jsp">
<%
session.invalidate();
response.sendRedirect("../bankModule/index.jsp");
%>
</form>
</html>
