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
String fileExistinNas="Y";
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/uploadclaim_temp/");
String b2=sm.getStorage("uploadclaimSec/"+DOC_NAME+"");
if (!DOC_NAME.equals("")) {
		try {
		Path source = Paths.get("E:/tomcat5/webapps/pmegpeportal/bankModule/uploadclaim/"+DOC_NAME+"");				
			Path target = Paths.get(b2);
   			Files.move(source, target);
	}catch (Exception r) {
	//out.print (r.toString());
	//response.sendRedirect("../pmegpeportalappdoc/DigitalKVICupload/"+DOC_NAME);
fileExistinNas="N";
	}

if (fileExistinNas.equals("N")) {

		try {
		
		   Path source1 = Paths.get(a+DOC_NAME+"");

  			Path target1 = Paths.get(b2);

out.print(target1);
   			Files.move(source1, target1);

	}catch (Exception r) {	
//fileExistinNas="N";
	out.print (r.toString());
	}	

		}





	
		
	}	
response.sendRedirect("../../pmegpeportalappdoc/uploadclaimSec/"+DOC_NAME);
%>

