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

 String ED_ID= request.getParameter("ED_ID")==null?"0":(String) request.getParameter("ED_ID");
String vappID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
//session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
out.print(ED_ID);

//String vappID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");


out.print(vappID);
StringBuffer qrysb = new StringBuffer();

if (!vappID.equals("")) {
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
qrysb.append(" FROM app_upload_trans aut  WHERE aut.UPM_CD =11 AND AUT.APP_ID='"+vappID+"' ");

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
String d2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp1/");
String e2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp2/");
String f2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp101/");
String g2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp102/");
String h2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp103/");
String i2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp104/");
String j2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp105/");
String k2=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp106/");
String k3=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp_106/");
String k4=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp107/");
String k5=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp108/");
String k7=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp109/");
String k6=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_unwanted/");
String k8=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp110/");
String k9=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp111/");
String k10=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp112/");
String k11=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/tempedponline/");
String k13=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp113/");
String k14=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp114/");
String k15=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp115/");
String k16=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp116/");
String k17=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp117/");
String k18=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp118/");
String k19=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp119/");
String k20=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp121/");
String k21=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp122/");
String k22=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp123/");
String k23=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp124/");
String k24=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp125/");
String k25=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp126/");
String k26=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp127/");
String k27=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp128/");
String k28=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp130/");
String k29=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp131/");
String k30=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp132/");
String k31=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp133/");
String k32=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp_134/");
String k33=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp135/");
String k34=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp136/");
String k35=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp137/");
String k36=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp138/");
String k37=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp139/");
String k38=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp140/");
String k39=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp141/");
String k40=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp142/");
String k41=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp143/");
String k42=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp144/");
String k43=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp145/");
String k44=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp146/");

String temfile=a+DOC_NAME;
String temfile1=d2+DOC_NAME;
String temfile2=e2+DOC_NAME;
String temfile3=f2+DOC_NAME;
String temfile4=g2+DOC_NAME;
String temfile5=h2+DOC_NAME;
String temfile6=i2+DOC_NAME;
String temfile7=j2+DOC_NAME;
String temfile8=k2+DOC_NAME;
String temfile9=k3+DOC_NAME;
String temfile10=k4+DOC_NAME;
String temfile11=k5+DOC_NAME;
String temfile12=k6+DOC_NAME;
String temfile13=k7+DOC_NAME;
String temfile14=k8+DOC_NAME;
String temfile15=k9+DOC_NAME;
String temfile16=k10+DOC_NAME;
String temfile17=k11+DOC_NAME;
String temfile18=k13+DOC_NAME;
String temfile19=k14+DOC_NAME;
String temfile20=k15+DOC_NAME;
String temfile21=k16+DOC_NAME;
String temfile22=k17+DOC_NAME;
String temfile23=k18+DOC_NAME;
String temfile24=k19+DOC_NAME;
String temfile25=k20+DOC_NAME;
String temfile26=k21+DOC_NAME;
String temfile27=k22+DOC_NAME;
String temfile28=k23+DOC_NAME;
String temfile29=k24+DOC_NAME;
String temfile30=k25+DOC_NAME;
String temfile31=k26+DOC_NAME;
String temfile32=k27+DOC_NAME;
String temfile33=k28+DOC_NAME;
String temfile34=k29+DOC_NAME;
String temfile35=k30+DOC_NAME;
String temfile36=k31+DOC_NAME;
String temfile37=k32+DOC_NAME;
String temfile38=k33+DOC_NAME;
String temfile39=k34+DOC_NAME;
String temfile40=k35+DOC_NAME;
String temfile41=k36+DOC_NAME;
String temfile42=k37+DOC_NAME;
String temfile43=k38+DOC_NAME;
String temfile44=k39+DOC_NAME;
String temfile45=k40+DOC_NAME;
String temfile46=k41+DOC_NAME;
String temfile47=k42+DOC_NAME;
String temfile48=k43+DOC_NAME;
String temfile49=k44+DOC_NAME;



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
			
}
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

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile9);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k3+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile10);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k4+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile11);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k5+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//String temfile11=k5+DOC_NAME;

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile12);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k6+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FILE FOR 109

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile13);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k7+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FILE FOR 110

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile14);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k8+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

/////TEMP 11
//// FILE FOR 111

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile15);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k9+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
///////////////


//// FILE FOR 112

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile16);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k10+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
///////////////

//// FILE FOR 113

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile18);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k13+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
///////////////

//// FILE FOR 114

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile19);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k14+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
///////////////

/////////   FILE FOR 115

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile20);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k15+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

/////////   FILE FOR 116

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile21);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k16+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 117


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile22);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k17+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 118


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile23);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k18+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 119


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile24);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k19+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 121


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile25);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k20+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 122


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile26);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k21+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
//////////   FILE FOR 123


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile27);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k22+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 124


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile28);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k23+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 125


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile29);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k24+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 126


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile30);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k25+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
//////////   FILE FOR 127


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile31);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k26+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 128


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile32);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k27+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 130
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile33);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k28+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 131
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile34);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k29+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 132
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile35);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k30+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 133

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile36);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k31+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




//////////   FILE FOR 134

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile37);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k32+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 135

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile38);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k33+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile39);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k34+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 137

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile40);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k35+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 138

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile41);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k36+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 139

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile42);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k37+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 140

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile43);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k38+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//////////   FILE FOR 141

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile44);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k39+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 142

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile45);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k40+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 143

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile46);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k41+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 144

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile47);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k42+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 145

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile48);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k43+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 146

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile49);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k44+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}





//// file edp online data 

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile17);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k11+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


}//end of val
out.print(REDPATH);
out.print(DOC_NAME);
session.setAttribute("sREDPATH",REDPATH);
session.setAttribute("sDOC_NAME",DOC_NAME);
session.setAttribute("sAPP_ID",APP_ID);
session.setAttribute("sED_ID",ED_ID);
	//response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME);
	response.sendRedirect("edpUploadByOff.jsp");
}else{
out.print ("<h1>Improper Login or session Out</h1>");

}

%>
