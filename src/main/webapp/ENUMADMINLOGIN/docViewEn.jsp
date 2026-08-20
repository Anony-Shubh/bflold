<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="java.util.*" %>
<%@ page import="globalp.*"%>
<%
String DOC_NAME=request.getParameter("DOC_NAME")==null?"":(String) request.getParameter("DOC_NAME");

kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("ENUMUPLOAD/"+DOC_NAME+"");
out.print(a);


		
response.sendRedirect("../../../pmegpeportalappdoc/ENUMUPLOAD/"+DOC_NAME);	
	
%>

