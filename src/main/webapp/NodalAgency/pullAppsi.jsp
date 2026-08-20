
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
 String vOffcd= (String) session.getAttribute("sOffCd");
 String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim(); 
 String PMEGPGEOTAGID=(String) request.getParameter("PMEGPGEOTAGID")==null?"":(String) request.getParameter("PMEGPGEOTAGID").trim();
 String APPNAME=(String) request.getParameter("APPNAME")==null?"":(String) request.getParameter("APPNAME").trim();
out.print(PMEGPGEOTAGID);
if (!vOffcd.equals("")){
session.setAttribute("SAPP_ID",APP_ID);
session.setAttribute("PMEGPGEOTAGID",PMEGPGEOTAGID);
session.setAttribute("APPNAME",APPNAME);
response.sendRedirect ("GeotagPull.jsp");
}
else{
response.sendRedirect ("AgencyloginPageNew.jsp");
}

 %>