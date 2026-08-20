<%-- 
    Document   : logout
    Created on : Dec 28, 2016, 2:58:13 AM
    Author     : testing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
    <HEAD>
        <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <TITLE>Logout</TITLE>
    </HEAD>
    <BODY>
        <%
            session.invalidate();
            response.sendRedirect("../bnf/index.jsp");
        %>
    </BODY>
</HTML>
