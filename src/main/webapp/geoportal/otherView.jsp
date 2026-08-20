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
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");


		
response.sendRedirect("../../../pmegpeportalappdoc/GEOTAGUPLOAD/AGENCY/OTHER/"+APP_ID+"/"+DOC_NAME);	
	
%>

