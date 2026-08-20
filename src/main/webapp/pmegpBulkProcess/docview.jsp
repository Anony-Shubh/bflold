<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="java.util.*" %>
<%@ page import="globalp.*"%>
<%
String fileExistinNas="Y";
String DOC_NAME=request.getParameter("docname")==null?"":(String) request.getParameter("docname");
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/uploadclaim_temp1/");
String b2=sm.getStorage("uploadclaim/"+DOC_NAME+"");
if (!DOC_NAME.equals("")) {
		


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
response.sendRedirect("../../pmegpeportalappdoc/uploadclaim/"+DOC_NAME);
%>

