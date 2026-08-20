<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<html>
<head>
<title>JSP JavaMail Example </title>
</head>
<body>
<form>
<%
String vdocname=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");
StringBuffer qrysb = new StringBuffer();


  DBCon db= new DBCon();
  db.connect(); 

  String UP_ID="";
  String APP_ID="";
  String TDIR="";
  String DOC_NAME="";
  String DOC_PATH="";
  String flag="N";
  String errmsg="";
  String REDPATH=""; 
  List values=new ArrayList();
 List pstm=new ArrayList();
 boolean b = false;
  boolean c = false;
String fileExistinNas="Y";
String moveToNas="N";
String getFromAppdir="N";

int cnt=0;


if (!vdocname.equals("")) {



try {
		
		    Path source1 = Paths.get("E:\\tomcat5\\webapps\\pmegpeportal\\bankModule\\uploadclaim\\"+vdocname+"");
  			Path target1 = Paths.get("\\\\kvicditnas\\pmegpeportalupload\\pmegploandoc\\"+vdocname+"");
   			Files.move(source1, target1);
	}catch (Exception r) {
	out.print (r.toString());
	}	

		
		}
		response.sendRedirect("../../pmegpeportalappdoc/pmegploandoc/"+vdocname);

%>

</body>
</form>
