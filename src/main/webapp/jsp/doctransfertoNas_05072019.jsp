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
<title>Documentview </title>
</head>
<body>
<form>
<%

String vdocname=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");
String vappID=request.getParameter("APP_ID")==null?"-":(String) request.getParameter("APP_ID");
//session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");

if (vappID.equals("-")){
vappID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
}

//out.print(vappID);
StringBuffer qrysb = new StringBuffer();

if (!vdocname.equals("")) {
qrysb.append("SELECT AUT.UP_ID, aut.APP_ID  AS APP_ID, ");
qrysb.append(" aut.DOC_NAME  AS DOC_NAME,");
qrysb.append(" 'pmegpeportalupload'||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) AS DOC_PATH, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) ");
qrysb.append("  AS TDIR, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON')|| ");
qrysb.append(" '/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) ");
qrysb.append("  AS REDPATH ");
qrysb.append(" FROM app_upload_trans aut  WHERE aut.DOC_NAME ='"+vdocname+"' AND AUT.APP_ID='"+vappID+"' ");

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

try {
   ResultSet rs = db.execSQL(qrysb.toString());

  while (rs.next()){
  
    UP_ID=rs.getString("UP_ID")==null?"":rs.getString("UP_ID");
  APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
    TDIR=rs.getString("TDIR")==null?"":rs.getString("TDIR");
   DOC_NAME=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");
   DOC_PATH=rs.getString("DOC_PATH")==null?"":rs.getString("DOC_PATH");
   REDPATH=rs.getString("REDPATH")==null?"":rs.getString("REDPATH");
 cnt=cnt+1;
}//end of loop
rs.close();
db.close();
}catch (Exception e){}

if (cnt>0) {
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String c2=sm.getStorage(TDIR);
String b2=sm.getStorage(TDIR+"/"+DOC_NAME+"");

String temfile=a+DOC_NAME;

try {
File file = new File(c2);
if (!file.exists()) {
			b = file.mkdirs();
		}

}catch (Exception m) {out.print(m.toString());}
out.print (c2);


File fnas = new File(b2);

fileExistinNas=(fnas.exists()? "Y" : "N");
String tempyn="N";
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile);
tempyn=(ftemp.exists()? "Y" : "N");
}
//out.print (tempyn);

if (tempyn.equals("Y")){
 Path source1 = Paths.get(a+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
}



}//end of val
	response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME);
}else{
out.print ("<h1>Improper Login or session Out</h1>");

}

%>
