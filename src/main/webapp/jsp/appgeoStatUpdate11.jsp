
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
 String vOffcd=(String) session.getAttribute("off_cd");
  String vAppid= request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
   String vPmGid= request.getParameter("PMEGPGEOTAGID")==null?"":request.getParameter("PMEGPGEOTAGID");
out.print(vOffcd);
if (!vOffcd.equals("")){
	session.setAttribute("SAPP_ID",vAppid);
	session.setAttribute("SPGID",vPmGid);
response.sendRedirect ("../geoportal/GTStatusUpdateTest.jsp");
}
else{
response.sendRedirect ("AgencyloginPageNew.jsp");
}

 %>