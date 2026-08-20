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
String vappID=request.getParameter("APP_ID")==null?"-":(String) request.getParameter("APP_ID");
//session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");

if (vappID.equals("-")){
vappID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
}

//out.print(vappID);
StringBuffer qrysb = new StringBuffer();

if (!DOC_NAME.equals("")) {
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
qrysb.append(" FROM app_upload_trans aut  WHERE aut.DOC_NAME ='"+DOC_NAME+"' AND AUT.APP_ID='"+vappID+"' ");

  DBCon db= new DBCon();
  db.connect(); 

  String UP_ID="";
  String APP_ID="";
  String TDIR="";
 // String DOC_NAME="";
  String DOC_PATH="";
  String flag="N";
  String errmsg="";
  String REDPATH=""; 
  List values=new ArrayList();
 List pstm=new ArrayList();
 boolean b = false;
  boolean c = false;
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













kvicGlobalPath sm = new kvicGlobalPath();
//String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String destnationfolder=sm.getStorage(TDIR+"/"+DOC_NAME+"");
String c2=sm.getStorage(TDIR);
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
ar.add("pmegpappupload_temp107");
ar.add("pmegpappupload_temp108");

int count=0;
		
File file= new File(destnationfolder);

if (file.exists()) {
count=10;
out.print ("Exit in destination folder..........");
}
if (count<1) {
try{
File file1 = new File(c2);
if (!file1.exists()) {
			b = file1.mkdirs();
		}

}catch (Exception m) {out.print(m.toString());}
//out.print (c2);
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

response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME);
}// end of docfind

else{
out.print ("<h1>Improper Login or session Out</h1>");

}
	
//response.sendRedirect("../../pmegpeportalappdoc/pmegpappuploadSecond/"+DOC_NAME);


%>

</body>
</form>
