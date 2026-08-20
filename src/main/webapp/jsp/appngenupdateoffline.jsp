
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
 String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
  String TYPE=(String) request.getParameter("TYPE")==null?"":(String) request.getParameter("TYPE").trim();
session.setAttribute("sAPP_ID",APP_ID);

if (TYPE.equals("1")){
response.sendRedirect ("appUpdatebyAgencyOffline.jsp");
}
else if (TYPE.equals("2")){
response.sendRedirect ("pmegpscorecardOffline.jsp");
}
else{
response.sendRedirect ("applicantFormValidationBeforeFinalSubmissionoffline.jsp");
}




 %>