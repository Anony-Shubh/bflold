<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%!
 public String findpmegfile(String direc, String name){
 String fileExist="N";
  String dirName=direc;
    File dir = new File(dirName);
    File[] dir_contents = dir.listFiles();
    String temp = dirName+"/"+name;
    boolean check = new File(temp).exists();
     for (int i = 0; i < dir_contents.length; i++) {
        if (dir_contents[i].getName().equals(name)){
            fileExist="Y";
			 return(fileExist);
	              }
	}
   return(fileExist); 
 
 }
 
  %>

<html>
<head>
<title>JSP JavaMail Example </title>
</head>
<body>
<form>
<%
String vdocname=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");
StringBuffer qrysb = new StringBuffer();

if (!vdocname.equals("")) {
qrysb.append("SELECT AUT.UP_ID, aut.APP_ID  AS APP_ID, ");
qrysb.append(" aut.DOC_NAME  AS DOC_NAME,");
qrysb.append(" 'pmegpeportalupload'||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) AS DOC_PATH, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'\\'||'\\'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'\\'||'\\'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'\\'||'\\'||substr(app_id,instr(app_id,'-')+1,length(app_id)) ");
qrysb.append("  AS TDIR, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON')|| ");
qrysb.append(" '/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) ");
qrysb.append("  AS REDPATH ");
qrysb.append(" FROM app_upload_trans aut  WHERE aut.DOC_NAME ='"+vdocname+"'");

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
String FileYN_NAS="";
String FileYN_E="";
String FileYN_L="";
String TD="\\\\kvicditnas\\pmegpeportalupload\\";
String TD_L="L:\\tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\";
String TD_E="E:\\tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\";
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

 FileYN_NAS=findpmegfile(TD+TDIR,vdocname);
 FileYN_E=findpmegfile(TD_E,vdocname);
out.print(FileYN_NAS);
out.print(FileYN_E);
if (FileYN_NAS.equals("Y") || FileYN_NAS.equals("Y")){

try {


try {
File file = new File("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR);
		if (!file.exists()) {
			b = file.mkdirs();
		}
		//Path source = Paths.get("D:\\pmegpeportalupload\\pmegpappupload\\"+DOC_NAME+"");
		Path source = Paths.get("L:\\tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\"+DOC_NAME+"");
  			Path target = Paths.get("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR+"\\"+DOC_NAME+"");
   			Files.move(source, target);
	}catch (Exception m) {
	fileExistinNas="N";
	//out.print (m.toString());
	}	
		
		if (fileExistinNas.equals("N")) {
		try {
		//Path source1 = Paths.get("D:\\pmegpeportalupload\\pmegpappupload\\"+DOC_NAME+"");
		   Path source1 = Paths.get("E:\\tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\"+DOC_NAME+"");
  			Path target1 = Paths.get("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR+"\\"+DOC_NAME+"");
   			Files.move(source1, target1);
	}catch (Exception r) {	
	out.print (r.toString());
	}	

		}
		
		
		
		response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME);
		
		
		}catch (Exception m) {}
		
		}//ii
	else{
response.sendRedirect("../pmegpappupload/blank.html");
}	
		
		
}//end of val

%>

</body>
</form>
