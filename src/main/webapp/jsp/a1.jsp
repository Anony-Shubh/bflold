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


<%

String vdocname="app7468931.jpg";

//app40265286.pdf
//request.getParameter("docname")==null?"-":(String) request.getParameter("docname");


StringBuffer qrysb = new StringBuffer();

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
qrysb.append(" FROM app_upload_trans aut  WHERE aut.DOC_NAME ='"+vdocname+"'");

DBCon db= new DBCon();
  db.connect(); 
   ResultSet rs = db.execSQL(qrysb.toString());
   
String TDIR="";
String basepath="";
 boolean extyn=false;
int cnt=0;
kvicGlobalPath sm = new kvicGlobalPath();

  while (rs.next()){
   TDIR=rs.getString("TDIR")==null?"":rs.getString("TDIR"); 
   
basepath=sm.getStorage(TDIR)+"/"+vdocname;
  File fileoriginal = new File(basepath);
extyn=fileoriginal.exists();
cnt =cnt+1;

  }
  
  //out.print (basepath);
  //out.print ("<br>");
  
    rs.close();
 
  String foldername="";
  String Nashfolder="";
  
 if (cnt>0 && extyn==false) {
 
   ResultSet rstemp = db.execSQL("SELECT foldername FROM TEMPUPLOADVIEW WHERE FILENME='"+vdocname+"'");
   
     while (rstemp.next()){
	 foldername=rstemp.getString("foldername")==null?"":rstemp.getString("foldername"); 
	 
	 Nashfolder=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/"+foldername+"/"+vdocname);
 
	  File filensh = new File(Nashfolder);
	   extyn=filensh.exists();
	   
	   if (extyn) {
	   Path NashPath= Paths.get(Nashfolder);
		Path originalpath =Paths.get (basepath);
		Files.createDirectories(originalpath.getParent());
		Files.move(NashPath,originalpath,ATOMIC_MOVE);
		}
	 
	 }
	  // out.print ("<br>");
	  // out.print (extyn);
	 // out.print (originalpath);
      //out.print ("<br>");
	 
	 rstemp.close();
 }


db.close();
%>