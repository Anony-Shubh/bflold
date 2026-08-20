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
String vcls="";
String vUtype=(String) session.getAttribute("assign")==null?"":(String)session.getAttribute("assign");
String vupid=session.getAttribute("sUP_ID")==null?"-":(String) session.getAttribute("sUP_ID");
//out.print(vupid);

if (vUtype.equals("IN")){
//String vAppID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
	vcls=vcls + "  AND AUT.APP_ID='"+vappID+"' and  aut.DOC_NAME ='"+vdocname+"' ";

}
else if (vUtype.equals("AG")){
String vOffcd=session.getAttribute("off_cd")==null?"-":(String) session.getAttribute("off_cd");
	vcls=vcls + "  AND AUT.APP_ID='"+vappID+"' AND AD.OFF_CD='"+vOffcd+"' and  aut.DOC_NAME ='"+vdocname+"' ";

}

else if (vUtype.equals("BK")){
String vIfsc=session.getAttribute("Bank_id")==null?"-":(String) session.getAttribute("Bank_id");
	vcls=vcls + "  AND AUT.APP_ID='"+vappID+"' AND  bd.ifsc_code='"+vIfsc+"' and  aut.DOC_NAME ='"+vdocname+"' ";

}

out.print(vUtype);
out.print(vcls);

StringBuffer qrysb = new StringBuffer();

if (!vUtype.equals("")) {
/*
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
qrysb.append(" FROM app_upload_trans aut  WHERE aut.DOC_NAME ='"+vdocname+"' AND AUT.APP_ID='"+vappID+"' "+vcls+"  ");
*/

qrysb.append(" SELECT AUT.UP_ID, aut.APP_ID  AS APP_ID, ");
qrysb.append(" aut.DOC_NAME  AS DOC_NAME,");
qrysb.append(" 'pmegpeportalupload'||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(aut.app_id,instr(aut.app_id,'-')+1,length(aut.app_id)) AS DOC_PATH, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON') ");
qrysb.append(" ||'/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(aut.app_id,instr(aut.app_id,'-')+1,length(aut.app_id))    AS TDIR, ");
qrysb.append(" TO_CHAR(aut.UPLOAD_TIMESTAMP,'RRRR')||'/'||TO_CHAR(aut.UPLOAD_TIMESTAMP,'MON')|| ");
qrysb.append(" '/'|| TO_CHAR(aut.UPLOAD_TIMESTAMP,'DD') ||'/'||substr(aut.app_id,instr(aut.app_id,'-')+1,length(aut.app_id))   AS REDPATH ");
qrysb.append(" FROM app_upload_trans aut,app_detail ad,bank_dataentry bd  WHERE    ad.app_id=aut.app_id(+) and ad.app_id=bd.app_id(+)  "+vcls+" ");
out.print(qrysb.toString());
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
String k45=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp147/");
String k46=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp148/");
String k47=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp149/");
String k48=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp150/");
String k49=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp151/");
String k50=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp152/");
String k51=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp153/");
String k52=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp154/");
String k53=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp155/");
String k54=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp156/");
String k55=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp157/");
String k56=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp158/");
String k57=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp159/");
String k58=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp160/");
String k59=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp161/");
String k60=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp162/");
String k61=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp163/");
String k62=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp164/");
String k63=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp165/");
String k64=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp166/");
String k65=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp167/");
String k66=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp168/");
String k67=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp169/");
String k68=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp170/");
String k69=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp171/");
String k70=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp172/");
String k71=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp173/");
String k72=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp174/");
String k73=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp175/");
String k74=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp176/");
String k75=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp177/");
String k76=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp178/");
String k77=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp179/");
String k78=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp180/");
String k79=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp181/");
String k80=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp182/");
String k81=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp183/");
String k82=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp184/");
String k83=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp185/");
String k84=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp186/");


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
String temfile50=k45+DOC_NAME;
String temfile51=k46+DOC_NAME;
String temfile52=k47+DOC_NAME;
String temfile53=k48+DOC_NAME;
String temfile54=k49+DOC_NAME;
String temfile55=k50+DOC_NAME;
String temfile56=k51+DOC_NAME;
String temfile57=k52+DOC_NAME;
String temfile58=k53+DOC_NAME;
String temfile59=k54+DOC_NAME;
String temfile60=k55+DOC_NAME;
String temfile61=k56+DOC_NAME;
String temfile62=k57+DOC_NAME;
String temfile63=k58+DOC_NAME;
String temfile64=k59+DOC_NAME;
String temfile65=k60+DOC_NAME;
String temfile66=k61+DOC_NAME;
String temfile67=k62+DOC_NAME;
String temfile68=k63+DOC_NAME;
String temfile69=k64+DOC_NAME;
String temfile70=k65+DOC_NAME;
String temfile71=k66+DOC_NAME;
String temfile72=k67+DOC_NAME;
String temfile73=k68+DOC_NAME;
String temfile74=k69+DOC_NAME;
String temfile75=k70+DOC_NAME;
String temfile76=k71+DOC_NAME;
String temfile77=k72+DOC_NAME;
String temfile78=k73+DOC_NAME;
String temfile79=k74+DOC_NAME;
String temfile80=k75+DOC_NAME;
String temfile81=k76+DOC_NAME;
String temfile82=k77+DOC_NAME;
String temfile83=k78+DOC_NAME;
String temfile84=k79+DOC_NAME;
String temfile85=k80+DOC_NAME;
String temfile86=k81+DOC_NAME;
String temfile87=k82+DOC_NAME;
String temfile88=k83+DOC_NAME;
String temfile89=k84+DOC_NAME;

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


//////////   FILE FOR 136

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


//////////   FILE FOR 147

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile50);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k45+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 148

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile51);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k46+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 149

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile52);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k47+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




//////////   FILE FOR 150

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile53);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k48+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




//////////   FILE FOR 151

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile54);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k49+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 152

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile55);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k50+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 153

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile56);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k51+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 154


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile57);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k52+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 155


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile58);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k53+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 156


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile59);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k54+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 157


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile60);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k55+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//////////   FILE FOR 158


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile61);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k56+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//////////   FILE FOR 159


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile62);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k57+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 160
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile63);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k58+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}






////// FOR  FILE 161
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile64);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k59+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 162
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile65);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k60+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 163
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile66);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k61+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 164
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile67);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k62+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 165
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile68);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k63+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 166
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile69);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k64+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 167
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile70);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k65+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 168
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile71);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k66+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 169
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile72);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k67+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 170
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile73);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k68+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 171
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile74);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k69+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 172
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile75);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k70+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 173
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile76);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k71+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 174
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile77);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k72+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 175
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile78);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k73+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 176
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile79);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k74+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 177
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile80);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k75+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 178
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile81);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k76+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 179
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile82);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k77+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 180
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile83);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k78+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 181
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile84);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k79+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 182
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile85);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k80+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 183
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile86);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k81+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 183
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile87);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k82+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 185
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile88);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k83+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 186
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile89);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k84+DOC_NAME);
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
	response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME);
}else{
out.print ("<h1>Improper Login or session Out</h1>");

}

%>
