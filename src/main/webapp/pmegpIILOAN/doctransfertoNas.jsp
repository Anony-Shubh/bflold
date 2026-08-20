<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="globalp.*"%>

<html>
<head>
<title>JSP JavaMail Example </title>
</head>
<body>
<form>
<%
String DOC_NAME=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");
StringBuffer qrysb = new StringBuffer();
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String b2=sm.getStorage("pmegpappuploadSecond/"+DOC_NAME+"");
if (!DOC_NAME.equals("")) {

 try {
		Path source = Paths.get(a+DOC_NAME+"")	;		
			Path target = Paths.get(b2);
   			Files.move(source, target);
	}catch (Exception r) {
	//out.print (r.toString());
	//response.sendRedirect("../pmegpeportalappdoc/DigitalKVICupload/"+DOC_NAME);
	}	 

}	
response.sendRedirect("../../pmegpeportalappdoc/pmegpappuploadSecond/"+DOC_NAME);


%>

</body>
</form>
