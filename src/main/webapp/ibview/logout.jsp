<%-- 
    Document   : logout
    Created on : Aug 1, 2016, 3:29:29 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

       
 
<html>
<body>
 
 <%
 session.removeAttribute("sUSER_NM");

            session.invalidate();
			response.sendRedirect("index.jsp");
       
 
%>  
</body>
</html>