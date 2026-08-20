<html>
<head>
<title>PMEGP Monitoring Logout Implementing Agency</title>

</head>
  <% 
session.invalidate();
response.setHeader("Cache-Control", "no-store");
response.setHeader("Cache-Control", " max-age=0, must-revalidate, no-cache, no-store, private"); 
response.setHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
response.setDateHeader("Expires", 0); 
response.setDateHeader("Expires", -1);
 %> 
  <form name="form1" method="post" action="logout.jsp">
<%

 response.sendRedirect("../index.jsp");
%>
</form>
</html>
