
<%
response.addHeader("X-Frame-Options", "SAMEORIGIN");
response.addHeader("X-XSS-Protection"," 1; mode=block");
response.addHeader("X-Content-Type-Options","nosniff");
response.addHeader("Content-Type","text/html; charset=utf-8");

%>

<%

String vlogin =session.getAttribute("slogin")==null?"N":(String)session.getAttribute("slogin");
String username=session.getAttribute("username")==null?"":(String)session.getAttribute("username");

if (username.equals("")) {

response.sendRedirect("index.jsp");
}

%>

