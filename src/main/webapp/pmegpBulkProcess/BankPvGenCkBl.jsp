
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
String TYPE =request.getParameter("TYPE")==null?"":(String) request.getParameter("TYPE") ;
String VERIFYC=request.getParameter("VERIFYC")==null?"":(String) request.getParameter("VERIFYC") ;
String IFSC_CODE=(String)session.getAttribute("bank_id");
out.print(APP_ID);
out.print(IFSC_CODE);
out.print(TYPE);
session.setAttribute("SAPPID",APP_ID);
session.setAttribute("bank_id",IFSC_CODE);
session.setAttribute("SVC",VERIFYC);
if ((!APP_ID.equals("")) && (TYPE.equals("P"))){
response.sendRedirect ("../pmegpchaln/payment_gateway_B.jsp");
}
else if ((!APP_ID.equals("")) && (TYPE.equals("R"))){
response.sendRedirect ("../pmegpchaln/pmegp_Refund_gateway_B.jsp");
}
else{
response.sendRedirect ("../pmegpchaln/payment_verify_status.jsp");
}

 %>