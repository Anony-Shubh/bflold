
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>       
 
<html>
<body>
 
 <%
 session.removeAttribute("admin");

            session.invalidate();
			response.sendRedirect("index.jsp");
       
 
%>  
</body>
</html>