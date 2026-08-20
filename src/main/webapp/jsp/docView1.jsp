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
<title>datatransfer</title>
</head>
<body>
<form>
<%
String fileExistinNas="Y";
String DOC_NAME=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");

if (!DOC_NAME.equals("")) {
StringBuffer qrysb = new StringBuffer();
kvicGlobalPath sm = new kvicGlobalPath();
//String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String destnationfolder=sm.getStorage("pmegpappuploadSecond/"+DOC_NAME+"");

ArrayList<String> ar = new ArrayList<String>();

String updir=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/");

ar.add("pmegpappupload_temp107");
ar.add("pmegpeportal_deletedfile");
ar.add("pmegpappupload_temp");
ar.add("pmegpappupload_temp1");
ar.add("pmegpappupload_temp2");
ar.add("pmegpappupload_temp_106");
ar.add("pmegpappupload_temp101");
ar.add("pmegpappupload_temp102");
ar.add("pmegpappupload_temp103");
ar.add("pmegpappupload_temp104");
ar.add("pmegpappupload_temp105");
ar.add("pmegpappupload_temp106");

int count=0;
		
File file= new File(destnationfolder);

if (file.exists()) {
count=10;
out.print ("Exit in destination folder..........");
}
if (count<1) {
String docpath="";
Path target = Paths.get(destnationfolder);
 while (ar.size() > count) {
	docpath=updir+""+ar.get(count)+"/"+DOC_NAME+"";
	file= new File(docpath);
		if (file.exists()) {
		Path source = Paths.get(docpath)	;		
   			Files.move(source, target);
			break;
		}
         count++;
      }
	  
} // end of count

}// end of docfind


	
response.sendRedirect("../../pmegpeportalappdoc/pmegpappuploadSecond/"+DOC_NAME);


%>

</body>
</form>
