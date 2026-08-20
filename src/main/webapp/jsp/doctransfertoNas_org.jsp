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
String vappID=session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");;
//request.getParameter("APP_ID")==null?"-":(String) request.getParameter("APP_ID");
//session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");

if (vappID.equals("-")){
vappID=session.getAttribute("sAPP_ID")==null?"-":(String) session.getAttribute("sAPP_ID");
}

if (vappID !="") {
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
DBCon db= new DBCon();
  db.connect(); 
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
String k32=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp134/");
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
String k85=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp187/");
String k86=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp188/");
String k87=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp189/");
String k88=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp190/");
String k89=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp191/");
String k90=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp192/");
String k91=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp193/");
String k92=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp194/");
String k93=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp195/");
String k94=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp196/");
String k95=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp197/");
String k96=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp198/");
String k97=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp199/");
String k98=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp200/");
String k99=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp201/");
String k100=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp202/");
String k101=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp203/");
String k102=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp204/");
String k103=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp205/");
String k104=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp206/");
String k105=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp207/");
String k106=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp208/");
String k107=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp209/");
String k108=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp210/");
String k109=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp211/");
String k110=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp212/");
String k111=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp213/");
String k112=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp214/");
String k113=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp215/");
String k114=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp216/");
String k115=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp217/");
String k116=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp218/");
String k117=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp219/");
String k118=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp220/");
String k119=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp221/");
String k120=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp222/");
String k121=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp223/");
String k122=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp224/");
String k123=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp225/");
String k124=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp226/");
String k125=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp227/");
String k126=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp228/");
String k127=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp229/");
String k128=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp230/");
String k129=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp231/");
String k130=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp232/");
String k131=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp233/");
String k132=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp234/");
String k133=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp235/");
String k134=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp236/");
String k135=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp237/");
String k136=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp238/");
String k137=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp239/");
String k138=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp240/");
String k139=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp241/");
String k140=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp242/");
String k141=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp243/");
String k142=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp244/");
String k143=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp245/");
String k144=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp246/");
String k145=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp247/");
String k146=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp248/");
String k147=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp249/");
String k148=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp250/");
String k149=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp251/");
String k150=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp252/");
String k151=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp253/");
String k152=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp254/");
String k153=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp255/");
String k154=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp256/");
String k155=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp257/");
String k156=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp258/");
String k157=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp259/");
String k158=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp260/");
String k159=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp261/");
String k160=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp262/");
String k161=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp263/");
String k162=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp264/");
String k163=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp265/");
String k164=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp266/");
String k165=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp267/");
String k166=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp268/");
String k167=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp269/");
String k168=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp270/");
String k169=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp271/");
String k170=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp272/");
String k171=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp273/");
String k172=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp274/");
String k173=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp275/");
String k174=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp276/");
String k175=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp277/");
String k176=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp278/");
String k177=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp279/");
String k178=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp280/");
String k179=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp281/");
String k180=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp282/");
String k181=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp283/");
String k182=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp284/");
String k183=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp285/");
String k184=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp286/");
String k185=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp287/");
String k186=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp288/");
String k187=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp289/");
String k188=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp290/");
String k189=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp291/");
String k190=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp292/");
String k191=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp293/");
String k192=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp294/");
String k193=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp295/");
String k194=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp296/");
String k195=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp297/");
String k196=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp298/");
String k197=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp299/");
String k198=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp300/");
String k199=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp301/");
String k200=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp302/");
String k201=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp303/");
String k202=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp304/");
String k203=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp305/");
String k204=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp306/");
String k205=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp307/");
String k206=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp308/");
String k207=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp309/");
String k208=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp310P/");
String k209=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp311/");
String k210=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp312/");
String k211=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp313/");
String k212=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp314/");
String k213=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp315/");
String k214=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp316/");
String k215=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp317/");
String k216=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp318/");
String k217=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp319/");
String k218=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp320/");
String k219=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp321/");
String k220=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp322/");
String k221=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp323/");
String k222=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp324/");
String k223=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp325/");
String k224=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp326/");
String k225=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp327/");
String k226=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp328/");
String k227=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp329/");
String k228=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp330/");
String k229=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp331/");
String k230=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp332/");
String k231=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp333/");
String k232=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp334/");
String k233=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp335/");
String k234=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp336/");
String k235=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp337/");
String k236=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp338/");
String k237=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp339/");
String k238=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp340/");
String k239=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp341/");
String k240=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp342/");
String k241=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp343/");
String k242=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp344/");
String k243=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp345/");
String k244=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp_346/");
String k245=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp_348/");
String k246=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp_349/");
String k247=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp350/");
String k248=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp351/");

String k249=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp352/");
String k250=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp353/");
String k251=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp354/");

// 27-06-2025
String k357=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp357/");
String k358=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp358/");
String k359=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp359/");


// 10-07-2025
String k360=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp360/");
String k361=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp361/");
String k362=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp362/");

// 29-07-2025

String k364=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp364/");
String k365=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp365/");

//11-08-25

String k366=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp366/");
String k367=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp367/");
//20-08-25
String k368=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp368/");
String k369=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp369/");


String k370=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp370/");

String k371=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp371/");


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
String temfile90=k85+DOC_NAME;
String temfile91=k86+DOC_NAME;
String temfile92=k87+DOC_NAME;
String temfile93=k88+DOC_NAME;
String temfile94=k89+DOC_NAME;
String temfile95=k90+DOC_NAME;
String temfile96=k91+DOC_NAME;
String temfile97=k92+DOC_NAME;
String temfile98=k93+DOC_NAME;
String temfile99=k94+DOC_NAME;
String temfile100=k95+DOC_NAME;
String temfile101=k96+DOC_NAME;
String temfile102=k97+DOC_NAME;
String temfile103=k98+DOC_NAME;
String temfile104=k99+DOC_NAME;
String temfile105=k100+DOC_NAME;
String temfile106=k101+DOC_NAME;
String temfile107=k102+DOC_NAME;
String temfile108=k103+DOC_NAME;
String temfile109=k104+DOC_NAME;
String temfile110=k105+DOC_NAME;
String temfile111=k106+DOC_NAME;
String temfile112=k107+DOC_NAME;
String temfile113=k108+DOC_NAME;
String temfile114=k109+DOC_NAME;
String temfile115=k110+DOC_NAME;
String temfile116=k111+DOC_NAME;
String temfile117=k112+DOC_NAME;
String temfile118=k113+DOC_NAME;
String temfile119=k114+DOC_NAME;
String temfile120=k115+DOC_NAME;
String temfile121=k116+DOC_NAME;
String temfile122=k117+DOC_NAME;
String temfile123=k118+DOC_NAME;
String temfile124=k119+DOC_NAME;
String temfile125=k120+DOC_NAME;
String temfile126=k121+DOC_NAME;
String temfile127=k122+DOC_NAME;
String temfile128=k123+DOC_NAME;
String temfile129=k124+DOC_NAME;
String temfile130=k125+DOC_NAME;
String temfile131=k126+DOC_NAME;
String temfile132=k127+DOC_NAME;
String temfile133=k128+DOC_NAME;
String temfile134=k129+DOC_NAME;
String temfile135=k130+DOC_NAME;
String temfile136=k131+DOC_NAME;
String temfile137=k132+DOC_NAME;
String temfile138=k133+DOC_NAME;
String temfile139=k134+DOC_NAME;
String temfile140=k135+DOC_NAME;
String temfile141=k136+DOC_NAME;
String temfile142=k137+DOC_NAME;
String temfile143=k138+DOC_NAME;
String temfile144=k139+DOC_NAME;
String temfile145=k140+DOC_NAME;
String temfile146=k141+DOC_NAME;
String temfile147=k142+DOC_NAME;
String temfile148=k143+DOC_NAME;
String temfile149=k144+DOC_NAME;
String temfile150=k145+DOC_NAME;
String temfile151=k146+DOC_NAME;
String temfile152=k147+DOC_NAME;
String temfile153=k148+DOC_NAME;
String temfile154=k149+DOC_NAME;
String temfile155=k150+DOC_NAME;
String temfile156=k151+DOC_NAME;
String temfile157=k152+DOC_NAME;
String temfile158=k153+DOC_NAME;
String temfile159=k154+DOC_NAME;
String temfile160=k155+DOC_NAME;
String temfile161=k156+DOC_NAME;
String temfile162=k157+DOC_NAME;
String temfile163=k158+DOC_NAME;
String temfile164=k159+DOC_NAME;
String temfile165=k160+DOC_NAME;
String temfile166=k161+DOC_NAME;
String temfile167=k162+DOC_NAME;
String temfile168=k163+DOC_NAME;
String temfile169=k164+DOC_NAME;
String temfile170=k165+DOC_NAME;
String temfile171=k166+DOC_NAME;
String temfile172=k167+DOC_NAME;
String temfile173=k168+DOC_NAME;
String temfile174=k169+DOC_NAME;
String temfile175=k170+DOC_NAME;
String temfile176=k171+DOC_NAME;
String temfile177=k172+DOC_NAME;
String temfile178=k173+DOC_NAME;
String temfile179=k174+DOC_NAME;
String temfile180=k175+DOC_NAME;
String temfile181=k176+DOC_NAME;
String temfile182=k177+DOC_NAME;
String temfile183=k178+DOC_NAME;
String temfile184=k179+DOC_NAME;
String temfile185=k180+DOC_NAME;
String temfile186=k181+DOC_NAME;
String temfile187=k182+DOC_NAME;
String temfile188=k183+DOC_NAME;
String temfile189=k184+DOC_NAME;
String temfile190=k185+DOC_NAME;
String temfile191=k186+DOC_NAME;
String temfile192=k187+DOC_NAME;
String temfile193=k188+DOC_NAME;
String temfile194=k189+DOC_NAME;
String temfile195=k190+DOC_NAME;
String temfile196=k191+DOC_NAME;
String temfile197=k192+DOC_NAME;
String temfile198=k193+DOC_NAME;
String temfile199=k194+DOC_NAME;
String temfile200=k195+DOC_NAME;
String temfile201=k196+DOC_NAME;
String temfile202=k197+DOC_NAME;
String temfile203=k198+DOC_NAME;
String temfile204=k199+DOC_NAME;
String temfile205=k200+DOC_NAME;
String temfile206=k201+DOC_NAME;
String temfile207=k202+DOC_NAME;
String temfile208=k203+DOC_NAME;
String temfile209=k204+DOC_NAME;
String temfile210=k205+DOC_NAME;
String temfile211=k206+DOC_NAME;
String temfile212=k207+DOC_NAME;
String temfile213=k208+DOC_NAME;
String temfile214=k209+DOC_NAME;
String temfile215=k210+DOC_NAME;
String temfile216=k211+DOC_NAME;
String temfile217=k212+DOC_NAME;
String temfile218=k213+DOC_NAME;
String temfile219=k214+DOC_NAME;
String temfile220=k215+DOC_NAME;
String temfile221=k216+DOC_NAME;
String temfile222=k217+DOC_NAME;
String temfile223=k218+DOC_NAME;
String temfile224=k219+DOC_NAME;
String temfile225=k220+DOC_NAME;
String temfile226=k221+DOC_NAME;
String temfile227=k222+DOC_NAME;
String temfile228=k223+DOC_NAME;
String temfile229=k224+DOC_NAME;
String temfile230=k225+DOC_NAME;
String temfile231=k226+DOC_NAME;
String temfile232=k227+DOC_NAME;
String temfile233=k228+DOC_NAME;
String temfile234=k229+DOC_NAME;
String temfile235=k230+DOC_NAME;
String temfile236=k231+DOC_NAME;
String temfile237=k232+DOC_NAME;
String temfile238=k233+DOC_NAME;
String temfile239=k234+DOC_NAME;
String temfile240=k235+DOC_NAME;
String temfile241=k236+DOC_NAME;
String temfile242=k237+DOC_NAME;
String temfile243=k238+DOC_NAME;
String temfile244=k239+DOC_NAME;
String temfile245=k240+DOC_NAME;
String temfile246=k241+DOC_NAME;
String temfile247=k242+DOC_NAME;
String temfile248=k243+DOC_NAME;
String temfile249=k244+DOC_NAME;
String temfile250=k245+DOC_NAME;
String temfile251=k246+DOC_NAME;
String temfile350=k247+DOC_NAME;
String temfile351=k248+DOC_NAME;


String temfile352=k249+DOC_NAME;
String temfile353=k250+DOC_NAME;
String temfile354=k251+DOC_NAME;


String temfile357=k357+DOC_NAME;
String temfile358=k358+DOC_NAME;
String temfile359=k359+DOC_NAME;

String temfile360=k360+DOC_NAME;
String temfile361=k361+DOC_NAME;
String temfile362=k362+DOC_NAME;


String temfile364=k364+DOC_NAME;
String temfile365=k365+DOC_NAME;

String temfile366=k366+DOC_NAME;
String temfile367=k367+DOC_NAME;


String temfile368=k368+DOC_NAME;
String temfile369=k369+DOC_NAME;

String temfile370=k370+DOC_NAME;

String temfile371=k371+DOC_NAME;


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

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile370);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k370+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile371);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k371+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile368);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k368+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile369);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k369+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}












if (fileExistinNas.equals("N")){
File ftemp = new File(temfile359);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k359+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k360+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k361+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k362+DOC_NAME);
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



////// FOR  FILE 187
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile90);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k85+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 188
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile91);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k86+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 189
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile92);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k87+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}






////// FOR  FILE 190
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile93);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k88+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 191
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile94);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k89+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 192
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile95);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k90+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 193
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile96);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k91+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}





////// FOR  FILE 194
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile97);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k92+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}





////// FOR  FILE 195
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile98);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k93+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

////// FOR  FILE 196
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile99);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k94+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 197
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile100);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k95+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 198
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile101);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k96+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 199
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile102);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k97+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 200
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile103);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k98+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 201
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile104);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k99+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 202
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile105);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k100+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 203
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile106);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k101+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 204
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile107);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k102+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}





////// FOR  FILE 205
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile108);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k103+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 206
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile109);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k104+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 207
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile110);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k105+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 208
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile111);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k106+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


////// FOR  FILE 209
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile112);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k107+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 210
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile113);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k108+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 211
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile114);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k109+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




////// FOR  FILE 212
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile115);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k110+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 213
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile116);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k111+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



////// FOR  FILE 214
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile117);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k112+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




///// FOR  FILE 215
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile118);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k113+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

///// FOR  FILE 216
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile119);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k114+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 217
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile120);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k115+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 218
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile121);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k116+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 219
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile122);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k117+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 220
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile123);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k118+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




///// FOR  FILE 221
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile124);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k119+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 222
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile125);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k120+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 223
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile126);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k121+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 224
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile127);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k122+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 225
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile128);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k123+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 226
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile129);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k124+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 227
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile130);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k125+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 228
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile131);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k126+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 229
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile132);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k127+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 230
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile133);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k128+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




///// FOR  FILE 231
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile134);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k129+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




///// FOR  FILE 232
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile135);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k130+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 233
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile136);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k131+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

///// FOR  FILE 234
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile137);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k132+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 235
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile138);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k133+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 236
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile139);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k134+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 237
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile140);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k135+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 238
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile141);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k136+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 239
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile142);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k137+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 240
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile143);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k138+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 241
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile144);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k139+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 242
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile145);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k140+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 243
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile146);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k141+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 244
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile147);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k142+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 245
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile148);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k143+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

///// FOR  FILE 246
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile149);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k144+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 247
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile150);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k145+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 248
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile151);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k146+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 249
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile152);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k147+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




///// FOR  FILE 250
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile153);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k148+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 251
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile154);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k149+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


///// FOR  FILE 252
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile155);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k150+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



///// FOR  FILE 253
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile156);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k151+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 254
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile157);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k152+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 255
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile158);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k153+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 256
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile159);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k154+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}





//// FOR  FILE 257
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile160);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k155+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 258
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile161);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k156+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 259
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile162);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k157+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 260
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile163);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k158+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 261
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile164);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k159+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 262
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile165);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k160+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 263
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile166);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k161+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 264
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile167);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k162+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 265
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile168);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k163+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 266
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile169);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k164+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 267
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile170);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k165+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 268
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile171);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k166+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 269
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile172);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k167+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 270
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile173);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k168+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 271
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile174);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k169+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 272
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile175);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k170+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 273
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile176);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k171+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 274
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile177);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k172+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 275
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile178);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k173+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 276
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile179);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k174+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 277
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile180);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k175+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 278
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile181);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k176+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 279
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile182);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k177+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 280
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile183);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k178+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 281
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile184);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k179+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 282
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile185);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k180+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 283
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile186);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k181+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 284
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile187);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k182+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}







//// FOR  FILE 285
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile188);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k183+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 286
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile189);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k184+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 287
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile190);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k185+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 288
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile191);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k186+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 289
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile192);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k187+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 290
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile193);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k188+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 291
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile194);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k189+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 292
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile195);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k190+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 293
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile196);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k191+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 294
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile197);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k192+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 295
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile198);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k193+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 296
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile199);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k194+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 297
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile200);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k195+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
//// FOR  FILE 298
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile201);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k196+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 299
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile202);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k197+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 300
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile203);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k198+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 301
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile204);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k199+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 302
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile205);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k200+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 303
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile206);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k201+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 304
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile207);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k202+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 305
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile208);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k203+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 306
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile209);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k204+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}





//// FOR  FILE 307
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile210);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k205+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




//// FOR  FILE 308
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile211);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k206+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 309
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile212);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k207+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 311
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile214);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k209+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 312
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile215);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k210+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 313
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile216);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k211+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}




//// FOR  FILE 314
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile217);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k212+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 315
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile218);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k213+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 316
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile219);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k214+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 317
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile220);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k215+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 318
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile221);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k216+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 319
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile222);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k217+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 320
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile223);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k218+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 321
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile224);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k219+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 322
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile225);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k220+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 323
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile226);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k221+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 324
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile227);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k222+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}



//// FOR  FILE 325
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile228);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k223+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 326
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile229);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k224+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 327
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile230);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k225+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
//// FOR  FILE 328
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile231);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k226+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 329
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile232);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k227+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 330
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile233);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k228+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 331
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile234);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k229+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 332
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile235);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k230+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 333
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile236);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k231+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 334
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile237);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k232+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 335
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile238);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k233+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 336
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile239);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k234+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 337
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile240);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k235+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 338
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile241);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k236+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 339
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile242);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k237+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
//// FOR  FILE 339
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile242);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k237+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 340
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile243);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k238+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 341
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile244);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k239+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

//// FOR  FILE 342
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile245);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k240+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 343
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile246);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k241+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 344
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile247);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k242+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


//// FOR  FILE 345
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile248);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k243+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

// updated on 20th jan 2025

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile249);
tempyn=(ftemp.exists()? "Y" : "N");
}



if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k244+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
// changed on 2nd feb 25
if (fileExistinNas.equals("N")){
File ftemp = new File(temfile250);
tempyn=(ftemp.exists()? "Y" : "N");
}




if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k245+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile251);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k246+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

// 11TH FEB 2025

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile350);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k247+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile351);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k248+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

// data 030325

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile352);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k249+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile353);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k250+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile354);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k251+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


// 27-06-2025 updated


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile357);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k357+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}

if (fileExistinNas.equals("N")){
File ftemp = new File(temfile358);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k358+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile366);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k366+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile367);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k367+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}
















if (fileExistinNas.equals("N")){
File ftemp = new File(temfile364);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k364+DOC_NAME);
 			Path target1 = Paths.get(b2);
   			Files.move(source1, target1);
			}
			catch (Exception m) {
	fileExistinNas="N";	
	}	
			
}


if (fileExistinNas.equals("N")){
File ftemp = new File(temfile365);
tempyn=(ftemp.exists()? "Y" : "N");
}

if (tempyn.equals("Y")){
try{
 Path source1 = Paths.get(k365+DOC_NAME);
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
}else {
out.print ("Access denied.....");
}
//end....

%>
