
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
String BR_IFSL_CODE =request.getParameter("SBR_IFSC_CODE")==null?"":(String) request.getParameter("SBR_IFSC_CODE") ;
session.setAttribute("SBR_IFSL_CODEs",BR_IFSL_CODE);

if (!BR_IFSL_CODE.equals("")){
response.sendRedirect ("bankProfileUpdate.jsp");
}

 %>