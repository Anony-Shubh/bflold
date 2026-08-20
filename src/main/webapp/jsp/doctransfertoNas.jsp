<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption" %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="globalp.*"%>
<%-- <%@ page import="com.kvic.util.SftpFileReader" %> --%>

<%
/* String linuxIp = "43.240.67.38";
int sshPort = 5938;
String linuxUser = "root";
String linuxPassword = "s0J8&9&!@ENmjlc2B"; */
//SftpFileReader sftp =new SftpFileReader(linuxIp,sshPort,linuxUser,linuxPassword);
//String remoteFilePath = "/home/readonly_user/sample.txt";
//String remoteFilePath = "/shared_storage/pmegpeportalupload/KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp";


String vdocname=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");
String vappID=session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");;

if (vappID.equals("-")){
vappID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
}


if (vappID !="" && !vdocname.equals("")) {
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
qrysb.append(" FROM app_upload_trans aut  WHERE aut.DOC_NAME ='"+vdocname+"' AND AUT.APP_ID='"+vappID+"' ");

  String UP_ID="";
  String APP_ID="";
  String TDIR="";
  String DOC_NAME="";
  String DOC_PATH="";
  String REDPATH ="";
 
  List values=new ArrayList();
 List pstm=new ArrayList();
 boolean b = false;
  boolean c = false;


int cnt=0;
DBCon db= new DBCon();
  db.connect(); 

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
}catch (Exception e){}
out.print (cnt);
if (cnt>0) {
kvicGlobalPath sm = new kvicGlobalPath();
//String tempFolderPath=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String tempFolderPath="/shared_storage/pmegpeportalupload/KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp";
String nonTempFolderPath=sm.getStorage(TDIR);
String nonTempFilePath=sm.getStorage(TDIR+"/"+DOC_NAME+"");

//out.print (nonTempFolderPath);
try {
File file = new File(nonTempFolderPath);

if (!file.exists()) {
			b = file.mkdirs();
		}else{
	File mainfile =	new File(nonTempFilePath);
	
	if (mainfile.exists()) {
	  c = true;
		out.print ("File Exist in main path"+mainfile+"<br>");
		}else {
		 c = false;
		out.print ("File not Exist in main path"+mainfile+"<br>");
		}
	
	if (!c) {
	
	File tempfile =	new File(tempFolderPath+"/"+DOC_NAME+"");
	
	if (tempfile.exists()) {
	String temp=tempFolderPath+"/"+DOC_NAME+"";
	  Path tempPath= Paths.get(temp);
		Path originalpath =Paths.get (nonTempFilePath);
		Files.createDirectories(originalpath.getParent());
		Files.move(tempPath,originalpath,StandardCopyOption.ATOMIC_MOVE);
	
	}else {
	
	c = false;
	out.print ("File not Existin tempfile"+tempfile+"<br>");
	}
	
	}
	
	if (!c) {
	
	String foldername="";
	String Nashfolder="";
	
	ResultSet rstemp = db.execSQL("SELECT foldername FROM TEMPUPLOADVIEW WHERE FILENME='"+vdocname+"' GROUP BY foldername ");
     while (rstemp.next()){
	 foldername=rstemp.getString("foldername")==null?"":rstemp.getString("foldername"); 
	 Nashfolder=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/"+foldername+"/"+vdocname);
 
	  File filensh = new File(Nashfolder);
	 
	   
	   if (filensh.exists()) {
	  Path NashPath= Paths.get(Nashfolder);
		Path originalpath =Paths.get (nonTempFilePath);
		Files.createDirectories(originalpath.getParent());
		Files.move(NashPath,originalpath,StandardCopyOption.ATOMIC_MOVE);
		
		out.print ("File NashPath tempfile"+NashPath+"<br>");
		}
	
	
	}
		}
		
		}

//out.print (b);

}catch (Exception m) {}

response.sendRedirect("../../uploads/"+REDPATH+"/"+DOC_NAME);
}// end if
db.close();

}
%>
