<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="java.util.*" %>
<%@ page import="globalp.*"%>
<%
String DOC_NAME=request.getParameter("docname")==null?"":(String) request.getParameter("docname");



		
response.sendRedirect("../../../pmegpeportalappdoc/SAMADHANUPLOAD/"+DOC_NAME);	
	
%>

