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

String vdocname=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");
String vappID=request.getParameter("APP_ID")==null?"-":(String) request.getParameter("APP_ID");
//session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");

if (vappID.equals("-")){
vappID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
}

out.print(vappID);
StringBuffer qrysb = new StringBuffer();

if (!vdocname.equals("")) {
qrysb.append("SELECT AUT.UP_ID, aut.APP_ID  AS APP_ID, ");
qrysb.append(" aut.DOC_NAME  AS DOC_NAME,");
qrysb.append(" 'pmegpeportalupload'||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) AS DOC_PATH, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) ");
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


out.print (qrysb.toString());

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

out.print (TDIR);
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String c2=sm.getStorage(TDIR);
String b2=sm.getStorage(TDIR+"/"+DOC_NAME+"");
//String d2=sm.getStorage(TDIR+"/"+DOC_NAME+"");
//String e2=sm.getStorage(TDIR+"/"+DOC_NAME+"");
try {



try {
File file = new File(c2);
		if (!file.exists()) {
			b = file.mkdirs();
		}
		//Path source = Paths.get("D:\\pmegpeportalupload\\pmegpappupload\\"+DOC_NAME+"");
		Path source = Paths.get("L:\\tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\"+DOC_NAME+"");
  			Path target = Paths.get("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR+"\\"+DOC_NAME+"");
   			//Files.move(source, target);
	}catch (Exception m) {
	fileExistinNas="N";
	//out.print (m.toString());
	}	
		
		if (fileExistinNas.equals("N")) {
		try {
		//Path source1 = Paths.get("D:\\pmegpeportalupload\\pmegpappupload\\"+DOC_NAME+"");
		   Path source1 = Paths.get("/opt/tomcat5/webapps/pmegpeportal/pmegpappupload/"+DOC_NAME+"");
  			Path target1 = Paths.get("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR+"\\"+DOC_NAME+"");
   			Files.move(source1, target1);
	}catch (Exception r) {	
fileExistinNas="N";
	//out.print (r.toString());
	}	

		}
		

if (fileExistinNas.equals("N")) {
//out.print("hello");
		try {
		//Path source1 = Paths.get("D:\\pmegpeportalupload\\pmegpappupload\\"+DOC_NAME+"");
		   Path source1 = Paths.get(a+DOC_NAME+"");
//out.print(source1);
  			Path target1 = Paths.get(b2);

out.print(target1);
   			Files.move(source1, target1);

	}catch (Exception r) {	
fileExistinNas="N";
	out.print (r.toString());
	}	

		}


/*if (fileExistinNas.equals("N")) {
response.sendRedirect(a+DOC_NAME);

}
	*/	
		
		response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME);
		
		
		}catch (Exception m) {}
		
		
		
		
		
}//end of val

%>

</body>
</form>
