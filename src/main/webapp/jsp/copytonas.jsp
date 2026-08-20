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
<link rel="stylesheet" type="text/css" href="css/pmegpNew.css" />

</head>
<%
String uploadDate=request.getParameter("APPDATE")==null?"":(String) request.getParameter("APPDATE");
if (!uploadDate.equals("")) {
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
qrysb.append(" FROM app_upload_trans aut  WHERE TRUNC(aut.UPLOAD_TIMESTAMP)='"+uploadDate+"' ");



/*qrysb.append("SELECT AUT.UP_ID, aut.APP_ID  AS APP_ID, ");
qrysb.append(" aut.DOC_NAME  AS DOC_NAME,");
qrysb.append(" 'pmegpeportalupload'||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id)) AS DOC_PATH, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'\\'||'\\'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'\\'||'\\'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'\\'||'\\'||substr(app_id,instr(app_id,'-')+1,length(app_id)) ");
qrysb.append("  AS TDIR ");
qrysb.append(" FROM app_upload_trans aut  WHERE TRUNC(aut.UPLOAD_TIMESTAMP)='"+uploadDate+"' AND FLAG_EXP_SUC='N'");
*/
  DBCon db= new DBCon();
  db.connect(); 
   ResultSet rs = db.execSQL(qrysb.toString());

  String UP_ID="";
  String APP_ID="";
  String TDIR="";
  String DOC_NAME="";
  String DOC_PATH="";
  String flag="N";
  String errmsg="";
   boolean b = false;
  boolean c = false;
String fileExistinNas="Y";
String moveToNas="N";
String getFromAppdir="N";

  List values=new ArrayList();
 List pstm=new ArrayList();

  StringBuffer qryUpdate = new StringBuffer();

int cnt=0;
  while (rs.next()){
  
    UP_ID=rs.getString("UP_ID")==null?"":rs.getString("UP_ID");
  APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
    TDIR=rs.getString("TDIR")==null?"":rs.getString("TDIR");
   DOC_NAME=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");
   DOC_PATH=rs.getString("DOC_PATH")==null?"":rs.getString("DOC_PATH");

 cnt=cnt+1;

 
 
 kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String c2=sm.getStorage(TDIR);
String b2=sm.getStorage(TDIR+"/"+DOC_NAME+"");
String d2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp1/");
String e2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp2/");
String f2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp101/");
String g2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp102/");
String h2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp103/");
String i2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp104/");
String j2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp105/");
String k2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp106/");
String temfile=a+DOC_NAME;
String temfile1=d2+DOC_NAME;
String temfile2=e2+DOC_NAME;
String temfile3=f2+DOC_NAME;
String temfile4=g2+DOC_NAME;
String temfile5=h2+DOC_NAME;
String temfile6=i2+DOC_NAME;
String temfile7=j2+DOC_NAME;
String temfile8=k2+DOC_NAME;
 
 
try {
File file = new File(c2);
if (!file.exists()) {
			b = file.mkdirs();
		}

}catch (Exception m) {out.print(m.toString());}
//out.print (c2);


 File fnas = new File(b2);

fileExistinNas=(fnas.exists()? "Y" : "N");
String tempyn="N";
// for temp
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile);
tempyn=(ftemp.exists()? "Y" : "N");
}
//out.print (tempyn);

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(a+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

/*
// for temp1
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile1);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(d2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


// for temp2
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile2);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(e2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



// for temp101
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile3);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(f2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




// for temp102
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile4);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(g2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



// for temp103
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile5);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(h2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



// for temp104
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile6);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(i2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



// for temp105
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile7);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(j2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}*/
// for temp106
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile8);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k2+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

 
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  /*
try {

File file = new File("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR);
		
		if (!file.exists()) {
			b = file.mkdirs();
		}
		
}catch (Exception e) {
//out.print (e.toString());	
}

  Path source = Paths.get("E:\\tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\"+DOC_NAME+"");
  Path target = Paths.get("\\\\kvicditnas\\pmegpeportalupload\\"+TDIR+"\\"+DOC_NAME+"");
  
   try {
 
   Files.move(source, target);
   flag="Y";
  } catch (IOException k) {
   flag="N";
  errmsg=k.toString();
  //out.print (errmsg);
  out.print ("<br>");
  }

  
  
  
   if (flag.equals("Y")) {
                        qryUpdate.append(" UPDATE app_upload_trans SET ");
						qryUpdate.append("SET FLAG_EXP_SUC=?,");
						qryUpdate.append("EXP_DT=SYSDATE,");
						qryUpdate.append("EXP_ERR_REMARKS=?, DOC_PATH_PE=?");
						qryUpdate.append(" WHERE UP_ID=? ");
						
						values.add (flag);pstm.add ("S");
						values.add (errmsg);pstm.add ("S");
						values.add (DOC_PATH);pstm.add ("S");
						values.add (UP_ID);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
						values.clear();	
						
						}//END OF FLAG......
						*/
						
  }//WHILE LOOP
  rs.close();
 out.print (cnt);
   
 db.close();
 }
%>

<body>
<form>
<table align="center">
  <tr>
    <th colspan="3"><div align="center">Transfer to Data to NAS </div></th>
  </tr>
  <tr>
    <th>Enter Date:(DD-MON-RRRR)</th>
    <td><input name="APPDATE" type="text" id="APPDATE" value="<%= uploadDate %>" size="12" maxlength="12">
    </td>
    <td><input name="btnSubit" type="submit" value="Transfer Data to Nas">
    </td>
  </tr>
</table>
</form>
