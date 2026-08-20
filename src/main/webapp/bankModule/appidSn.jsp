
<%@ page session="true" import="java.sql.*"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>



<% 
String APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
session.setAttribute("SAPP_ID",APP_ID);
if (!APP_ID.equals("")){
response.sendRedirect ("bankDataEntryForm.jsp");
}

 %>