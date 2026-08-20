<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Performance Report</title>
<link rel="stylesheet" type="text/css" href="css/indexr.css">
</head>
<body>
<form method="post" >
<table>
<tr>
<td>
  </td>
  </tr>
  </table>
  </div>
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";
String flagC="Y";
String p1="";
String p2="";
String p3="";
String rowcol="";
int lrow=0;
String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
String vDist =request.getParameter("DISTCD")==null||request.getParameter("DISTCD")=="ALL"?"%%":(String) request.getParameter("DISTCD");

vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;
vDist=vDist.equals("ALL")?"%%":vDist;
String vAgencytit="";
String vsZonetit="";
String vsStatetit="";


txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"' AND DM.DISTRICT_NAME LIKE '"+vDist+"' ";
//out.print(txtSearch);
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String vAgency=request.getParameter("AGENCY")==null?"%%":(String) request.getParameter("AGENCY");
//out.print (vAgency);
vAgency=vAgency.trim();
String vfields =request.getParameter("REPTP")==null?"0":(String) request.getParameter("REPTP");

//FOR AGENCY WISE LOGIN
vfields=(vsAgency.equals("DIC")||vsAgency.equals("KVIB"))?"3":vfields;
//vfields=vsAgency.equals("KVIC")?"4":vfields;

//out.print(vfields);
vfields=vfields.trim();
String vZonecd =request.getParameter("ZONECD")==null?"%%":(String) request.getParameter("ZONECD");
vZonecd=vZonecd.trim();
String vStatecd =request.getParameter("STATECD")==null?"%%":(String) request.getParameter("STATECD");
vStatecd=vStatecd.trim();

String vStatedc=request.getParameter("STATEDC")==null?"%%":(String) request.getParameter("STATEDC");
vStatedc=vStatedc.trim();

String vOffice =request.getParameter("OFFNAMECD")==null?"%%":(String) request.getParameter("OFFNAMECD");
vOffice=vOffice.trim();

if (vOffice.equals("ALL")||vOffice.equals("null")||vOffice.equals("Total")||vOffice.equals("")||vOffice.equals("%%")){
vOffice="%%";
}




if (vAgency.equals("ALL")||vAgency.equals("null")||vAgency.equals("Total")||vAgency.equals("")||vAgency.equals("%%")){
vAgency="%%";
vAgencytit="ALL";
}else {
vAgencytit=vAgency;
}

if (vZonecd.equals("ALL")||vZonecd.equals("null")||vZonecd.equals("Total")||vZonecd.equals("")||vZonecd.equals("%%")){
vZonecd="%%";
vsZonetit="ALL";
}else {
vsZonetit=vZonecd;
}

if (vStatecd.equals("ALL")||vStatecd.equals("null")||vStatecd.equals("Total")||vStatecd.equals("")||vStatecd.equals("%%")){
vStatecd="%%";
vsStatetit="ALL";
}else {
vsStatetit=vStatecd;
}
if(!(vsAgency.equals("%%"))){
vAgency=vsAgency;
vAgencytit=vsAgency;
}


if(!(vsZonecd.equals("%%"))){
vZonecd=vsZonecd;
vsZonetit=vsZonecd;
}


if(!(vsStatecd.equals("%%"))){
vStatecd=vsStatecd;
vsStatetit=vStatecd;
}




String vCategory="";
String vGender="";
String vnmdw="";
String ReportName="";
String qryField="";
String qryField1="";
String qryGroup="";
String qryGroup1="";
String urladd="";
String urlrep="";
String urlrepE="";
String OFF_TYPE_CD=request.getParameter("OFF_TYPE_CD")==null?"%%":(String)request.getParameter("OFF_TYPE_CD");
String repnm="centerWiseEdp.jsp";
 //urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt;
 urlrepE ="edpDetJasper.jsp?TODT="+ToDt+"&FROMDT="+FromDt+"&AGENCY="+vAgency+"&ZONECD="+vZonecd+"&STATEDC="+vStatedc+"&STATECD="+vStatecd+"&OFF_NAME1=";
 String EDPOFF_CD="";
String STATE_NM="";
String OFF_NAME="";
String PREON_EDP="";
String EDP_STATE="";
String OFF_CD="";
String TOTOF_EDP="";
String TOT_EDP="";
String COMON_EDP="";
String COMOF_EDP="";
String PENON_EDP="";
String PENOF_EDP="";
 
String POSTON_EDP="";
String TOTON_EDP="";
String PREOF_EDP="";
String POSTOF_EDP="";

String BANK_FORW="";
String zone_nm="";
String off_name1="";
String PREONSAN_EDP="";
String POSONSAN_EDP="";
String PREOFSAN_EDP="";
String POSOFSAN_EDP="";

String COMPREON_EDP="";  
String  COMPOSTON_EDP="";  
 String   COMPREOF_EDP="";  
 String COMPOSTOF_EDP="";  
String  PENPREON_EDP="";  
String  PENPOSTON_EDP="";    
String   PENPREOF_EDP="";  
String   PENPOSTOF_EDP="";  


 
 txtSearch=txtSearch+" AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"' AND MOM.OFF_NAME1 LIKE '"+vOffice+"' AND MO.OFF_TYPE_CD="+OFF_TYPE_CD+" AND MS.STATE_NM LIKE '"+vStatedc+"' "; 


/*
if (vfields.equals("0")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" MAX('ALL') as zone_nm , MOM.AGENCY_TYPE ";
qryField1=" MAX('ALL') as zone_nm , A.AGENCY_TYPE  as off_name1 ";
urladd="&AGENCY=";

if (vAgencytit.equals("ALL") ) {
qryGroup=" MOM.AGENCY_TYPE ";
qryGroup1=" ROLLUP(A.AGENCY_TYPE)  ";
}else{
qryGroup=" MOM.AGENCY_TYPE ";
qryGroup1=" A.AGENCY_TYPE ";
}
urlrep=urlrep+"&REPTP=1";
p1="&ZONECD=";
p2="&AGENCY=";
}

if (vfields.equals("1")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" ZM.zone_nm as zone_nm , MOM.AGENCY_TYPE ";
qryField1=" A.zone_nm as zone_nm , A.AGENCY_TYPE  as off_name1 ";
urladd="&ZONECD=";
if (vAgencytit.equals("ALL") && vsZonetit.equals("ALL")) {
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE ";
qryGroup1=" ROLLUP(A.zone_nm,A.AGENCY_TYPE)  ";
}else if( !vAgencytit.equals("ALL") && vsZonetit.equals("ALL") ){
qryGroup=" MOM.AGENCY_TYPE,ZM.zone_nm ";
qryGroup1=" A.AGENCY_TYPE,ROLLUP(A.zone_nm) ";
}else if( vAgencytit.equals("ALL") && !vsZonetit.equals("ALL") ){
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE ";
qryGroup1=" A.zone_nm,A.AGENCY_TYPE ";
}else{
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE O ";
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE O ";
}

urlrep=urlrep+"&REPTP=2";
p1="&ZONECD=";
p2="&AGENCY=";
}else if (vfields.equals("2")){
ReportName="Zone and State Wise ";
qryField=" ZM.zone_nm as zone_nm , MS.STATE_NM ";
qryField1=" A.zone_nm as zone_nm , A.STATE_NM as off_name1 ";
if (vAgency.equals("KVIC")){
urlrep=urlrep+"&REPTP=4&AGENCY=KVIC";
}else{
urlrep=urlrep+"&REPTP=3&AGENCY="+vAgency;
}

p1="&ZONECD=";
p2="&STATECD=";

if (vsStatetit.equals("ALL") && vsZonetit.equals("ALL")) {
qryGroup=" (ZM.zone_nm,MS.STATE_NM) ";
qryGroup1=" ROLLUP(A.zone_nm,A.STATE_NM) ";
}else if (!vsStatetit.equals("ALL") && vsZonetit.equals("ALL"))  {
qryGroup=" (ZM.zone_nm),MS.STATE_NM ";
qryGroup1=" ROLLUP(A.zone_nm),A.STATE_NM ";
}else if (vsStatetit.equals("ALL") && !vsZonetit.equals("ALL"))  {
qryGroup=" ZM.zone_nm,(MS.STATE_NM)";
qryGroup1=" A.zone_nm,ROLLUP(A.STATE_NM)";
}else{
qryGroup=" ZM.zone_nm,MS.STATE_NM  ";
qryGroup1=" A.zone_nm,A.STATE_NM  ";
}

}else if (vfields.equals("3")){
ReportName="State and District Wise ";
qryField=" MS.STATE_NM ,DM.district_name ";
qryField1=" A.STATE_NM as zone_nm ,A.district_name as off_name1 ";
if (vsStatetit.equals("ALL")) {
qryGroup=" (MS.STATE_NM,DM.district_name) ";
qryGroup1=" ROLLUP(A.STATE_NM,A.district_name) ";
}else {
qryGroup=" MS.STATE_NM,(DM.district_name)  ";
qryGroup1=" A.STATE_NM,ROLLUP(A.district_name)  ";
}

}//end of else

if (vfields.equals("4")){
ReportName="KVIC Zonewise and officewise ";
qryField=" ZM.zone_nm as zone_nm ,MOM.OFF_NAME1 ";
qryField1=" A.zone_nm as zone_nm ,A.OFF_NAME1 as off_name1 ";
if (vsStatetit.equals("ALL")) {
qryGroup=" (ZM.zone_nm ,MOM.OFF_NAME1) ";
qryGroup1=" ROLLUP(A.zone_nm ,A.OFF_NAME1) ";
}else {
qryGroup=" ZM.zone_nm,(MOM.OFF_NAME1) ";
qryGroup1=" A.zone_nm,ROLLUP(A.OFF_NAME1) ";
}
urlrep=urlrep+"&REPTP=3&AGENCY="+vAgency+"&STATECD="+vStatecd;
p1="&ZONECD=";
p2="&OFFNAMECD=";
}
*/
if (vfields.equals("0")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" MAX('ALL') as zone_nm , A.AGENCY_TYPE ";
qryField1=" MAX('ALL') as zone_nm , A.AGENCY_TYPE  as off_name1 ";
urladd="&AGENCY=";

if (vAgencytit.equals("ALL") ) {
qryGroup=" A.AGENCY_TYPE ";
qryGroup1=" ROLLUP(A.AGENCY_TYPE)  ";
}else{
qryGroup=" A.AGENCY_TYPE ";
qryGroup1=" A.AGENCY_TYPE ";
}
urlrep=urlrep+"&REPTP=1";
p1="&ZONECD=";
p2="&AGENCY=";
}

if (vfields.equals("1")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" A.zone_nm as zone_nm , A.AGENCY_TYPE ";
qryField1=" A.zone_nm as zone_nm , A.AGENCY_TYPE  as off_name1 ";
urladd="&ZONECD=";
if (vAgencytit.equals("ALL") && vsZonetit.equals("ALL")) {
qryGroup=" A.zone_nm,A.AGENCY_TYPE ";
qryGroup1=" ROLLUP(A.zone_nm,A.AGENCY_TYPE)  ";
}else if( !vAgencytit.equals("ALL") && vsZonetit.equals("ALL") ){
qryGroup=" A.AGENCY_TYPE,A.zone_nm ";
qryGroup1=" A.AGENCY_TYPE,ROLLUP(A.zone_nm) ";
}else if( vAgencytit.equals("ALL") && !vsZonetit.equals("ALL") ){
qryGroup=" A.zone_nm,A.AGENCY_TYPE ";
qryGroup1=" A.zone_nm,A.AGENCY_TYPE ";
}else{
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE O ";
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE O ";
}

urlrep=urlrep+"&REPTP=2";
p1="&ZONECD=";
p2="&AGENCY=";
}else if (vfields.equals("2")){
ReportName="Zone and State Wise ";
qryField=" A.zone_nm as zone_nm , A.STATE_NM ";
qryField1=" A.zone_nm as zone_nm , A.STATE_NM as off_name1 ";
if (vAgency.equals("KVIC")){
urlrep=urlrep+"&REPTP=4&AGENCY=KVIC";
}else{
urlrep=urlrep+"&REPTP=3&AGENCY="+vAgency;
}

p1="&ZONECD=";
p2="&STATECD=";

if (vsStatetit.equals("ALL") && vsZonetit.equals("ALL")) {
qryGroup=" (A.zone_nm,A.STATE_NM) ";
qryGroup1=" ROLLUP(A.zone_nm,A.STATE_NM) ";
}else if (!vsStatetit.equals("ALL") && vsZonetit.equals("ALL"))  {
qryGroup=" (A.zone_nm),A.STATE_NM ";
qryGroup1=" ROLLUP(A.zone_nm),A.STATE_NM ";
}else if (vsStatetit.equals("ALL") && !vsZonetit.equals("ALL"))  {
qryGroup=" A.zone_nm,(A.STATE_NM)";
qryGroup1=" A.zone_nm,ROLLUP(A.STATE_NM)";
}else{
qryGroup=" A.zone_nm,A.STATE_NM  ";
qryGroup1=" A.zone_nm,A.STATE_NM  ";
}

}else if (vfields.equals("3")){
ReportName="State and District Wise ";
qryField=" A.STATE_NM ,A.district_name ";
qryField1=" A.STATE_NM as zone_nm ,A.district_name as off_name1 ";
if (vsStatetit.equals("ALL")) {
qryGroup=" (A.STATE_NM,A.district_name) ";
qryGroup1=" ROLLUP(A.STATE_NM,A.district_name) ";
}else {
qryGroup=" A.STATE_NM,(A.district_name)  ";
qryGroup1=" A.STATE_NM,ROLLUP(A.district_name)  ";
}

}//end of else

if (vfields.equals("4")){
ReportName="KVIC Zonewise and officewise ";
qryField=" A.zone_nm as zone_nm ,A.OFF_NAME1 ";
qryField1=" A.zone_nm as zone_nm ,A.OFF_NAME1 as off_name1 ";
if (vsStatetit.equals("ALL")) {
qryGroup=" (A.zone_nm ,A.OFF_NAME1) ";
qryGroup1=" ROLLUP(A.zone_nm ,A.OFF_NAME1) ";
}else {
qryGroup=" A.zone_nm,(A.OFF_NAME1) ";
qryGroup1=" A.zone_nm,ROLLUP(A.OFF_NAME1) ";
}
urlrep=urlrep+"&REPTP=3&AGENCY="+vAgency+"&STATECD="+vStatecd;
p1="&ZONECD=";
p2="&OFFNAMECD=";
}


		
		%>
		
		<%

    Enumeration parameterList = request.getParameterNames();
	String vFurl="AGENCY="+vsAgency+"&ZONECD="+vsZonecd+"&STATECD="+vsStatecd+"&";
	
  while( parameterList.hasMoreElements() )
  {
    String sName = parameterList.nextElement().toString();
      String[] sMultiple = request.getParameterValues( sName );
	   if(sName.equals("AGENCY")||sName.equals("TODT")||sName.equals("FROMDT")||sName.equals("ZONECD")||sName.equals("STATECD")||sName.equals("OFFNAMECD")||sName.equals("DISTCD")){
      if( 1 >= sMultiple.length ){
        // parameter has a single value. print it.
        vFurl=vFurl+ sName + "=" + request.getParameter( sName ) + "&" ;
      }else{
        for( int i=0; i<sMultiple.length; i++ )
          // if a paramater contains multiple values, print all of them
		 if (!( sMultiple[i].equals("ALL")||sMultiple[i].equals("null")||sMultiple[i].equals("Total")||sMultiple[i].equals("")||sMultiple[i].equals("%%"))){
		  //sMultiple[i].equals("ALL")){
          vFurl=vFurl+ sName+"=" + sMultiple[i] + "&";
		  }
  }
  }
  
}

if (flagC.equals("Y") ){

String ReportDesc=" PMEGP e-Tracking "+ReportName+" Performance Report for the Period from "+FromDt +" to "+ToDt+" " ; 
 StringBuffer qrysb= new StringBuffer();
 
 
  

 
 qrysb.append("   SELECT NVL(A.OFF_NAME, 'Total') AS OFF_NAME1,MAX(A.OFF_TYPE_CD) AS OFF_TYPE_CD,MAX(OFF_CD) AS OFF_CD,MAX(EDP_STATE) AS EDP_STATE, "      );
qrysb.append("     SUM(A.tot_sanc)          AS TOT_SANC,"      );
qrysb.append("     SUM(NVL(A.EDP_COMP, 0)) EDP_COMP,"      );
qrysb.append("     SUM(NVL(A.EDP_ONLINE, 0)) EDP_ONLINE,"      );
qrysb.append("     SUM(NVL(A.EDP_OFFLINE, 0)) EDP_OFFLINE"      );
qrysb.append("     "      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT A.OFF_NAME,A.OFF_TYPE_CD,A.OFF_CD,A.EDP_STATE,"      );
qrysb.append("       COUNT(*)                                              AS tot_sanc,"      );
//qrysb.append("       SUM(NVL(DECODE(TRUNC(A.EDP_CERT_DT), NULL, 0, 1), 0)) AS EDP_COMP,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NOT NULL"      );
qrysb.append("         AND A.OFF_CD     IS NOT NULL "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS EDP_COMP,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NOT NULL"      );
qrysb.append("         AND A.OFF_CD               = 9246"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS EDP_ONLINE,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NOT NULL"      );
qrysb.append("         AND NVL(A.OFF_CD, 0)      <> 9246"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0))                                              AS EDP_OFFLINE"      );
qrysb.append("     "      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT MOM.AGENCY_TYPE, MO.off_name AS OFF_NAME,MOC.OFF_TYPE_CD,SM.STATE_NM ,"      );
qrysb.append("           "      );
qrysb.append("           ZM.ZONE_NM,"      );
qrysb.append("           MS.STATE_NM,"      );
qrysb.append("           DM.DISTRICT_NAME AS EDP_STATE,"      );
qrysb.append("           BD.APP_ID,"      );
qrysb.append("           BD.EDP_CERT_DT,"      );
qrysb.append("           BD.MM_REL_DT,"      );
qrysb.append("           BD.OFF_CD,"      );
qrysb.append("           BD.PACT_ID"      );
qrysb.append("         FROM APP_DETAIL ADO,"      );
qrysb.append("           BANK_DATAENTRY BD,"      );
qrysb.append("           MAS_OFF_MAST MOM,"      );
qrysb.append("           MAS_OFF_MAST MO,"      );
qrysb.append("           M_STATE MS,"      );
qrysb.append("           M_DISTRICT DM,"      );
qrysb.append("           ZONE_MAST ZM,MAS_OFF_TYPE_CDMAST MOC,M_DISTRICT UD,M_STATE SM "      );
qrysb.append("         WHERE ADO.APP_ID     = BD.APP_ID"      );
qrysb.append("         AND ADO.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("         AND MO.OFF_CD(+)     = BD.OFF_CD"      );
qrysb.append("         AND ADO.UNIT_DIST_CD = DM.DISTRICT_CD"      );
qrysb.append("         AND DM.STATE_CD      = MS.STATE_CD AND MO.DISTRICT_CD=UD.DISTRICT_CD AND UD.STATE_CD=SM.STATE_CD "      );
qrysb.append("         AND MS.ZONE_CD       = ZM.ZONE_CD"      );
qrysb.append("         AND MO.OFF_TYPE_CD=MOC.OFF_TYPE_CD "+txtSearch+"     "      );
qrysb.append("         AND TRUNC(BD.LOAN_SANC_DT) BETWEEN  '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         AND BD.ACT_ID = 11"      );
qrysb.append("         ) A"      );
qrysb.append("     GROUP BY A.OFF_NAME,A.OFF_TYPE_CD,A.OFF_CD,A.EDP_STATE"      );
qrysb.append("     ) A"      );
qrysb.append("   WHERE A.EDP_COMP > 0"      );
qrysb.append("   GROUP BY ROLLUP(A.OFF_NAME)"      );
qrysb.append("   "      );
//out.print(qrysb.toString());


try{
ResultSet rsinst = db.execSQL(qrysb.toString());




%>


 <table align="center">
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">PMEGP Portal online Performance Report </div></td>
</tr>
<tr>
<th>Agency</th>
<td><%=vAgencytit  %></td>
<th>KVIC Zone</th>
<td><%=vsZonetit  %></td>
<th>State</th>
<td><%= vsStatetit %></td>
<th>From Date </th>
<td><%=FromDt  %></td>
<th>To Date </th>
<td><%=ToDt  %></td>
</tr>
</table>
 <div align="center">
 <%
 String offtl=vOffice.equals("%%")?"":vOffice;
 //out.print(offtl);
 %>
 </div>
 <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
   <thead>
     <tr>
       <th rowspan="3">Row ID</th>
       <th rowspan="3" > Name </th>
       <th rowspan="3" >District</th>
       <th colspan="3"  >EDP Completed </th>
      
       
       <th rowspan="3">Training Center Wise </th>
     </tr>
    
     <tr>
	  
       <th >Online</th>
       <th >Offline</th>
       <th >Total</th>
      </tr>
   </thead>

 <%
 String Head="";
 String firstcolnew="";
 String firstcolold="";
 String flag="Y";
 
double vAPP_REC=0.00;
double vdtfc_place=0.00;
double vdtfc_sanction=0.00;
double vbank_ford=0.00;
double vbankfordmminv=0.00;
double vbank_sanc_mm=0.00;
String srno="";
 DecimalFormat dfd = new DecimalFormat("##.## ");
  DecimalFormat dfn = new DecimalFormat("####");
 

while (rsinst.next()) {
	firstcolnew=(rsinst.getString(1)==null)?"":rsinst.getString(1);
	srn=srn+1;
	if (firstcolnew.equals(firstcolold)){
	flag="N";
	}else{
	firstcolold=(rsinst.getString(1)==null)?"":rsinst.getString(1);
	flag="Y";
	}
	//zone_nm=rsinst.getString("zone_nm")==null?"":rsinst.getString("zone_nm");
//off_name1=rsinst.getString("off_name1")==null?"":rsinst.getString("off_name1");
//PENOF_EDP=rsinst.getString("PENOF_EDP")==null?"":rsinst.getString("PENOF_EDP");
//PENON_EDP=rsinst.getString("PENON_EDP")==null?"":rsinst.getString("PENON_EDP");
//COMOF_EDP=rsinst.getString("COMOF_EDP")==null?"":rsinst.getString("COMOF_EDP");
//PREOF_EDP=rsinst.getString("MM_REL_NOT")==null?"":rsinst.getString("MM_REL_NOT");
OFF_CD=rsinst.getString("OFF_CD")==null?"":rsinst.getString("OFF_CD");
EDP_STATE=rsinst.getString("EDP_STATE")==null?"":rsinst.getString("EDP_STATE");

TOTOF_EDP=rsinst.getString("EDP_OFFLINE")==null?"":rsinst.getString("EDP_OFFLINE");
TOTON_EDP=rsinst.getString("EDP_ONLINE")==null?"":rsinst.getString("EDP_ONLINE");
TOT_EDP=rsinst.getString("EDP_COMP")==null?"":rsinst.getString("EDP_COMP");
BANK_FORW=rsinst.getString("TOT_SANC")==null?"":rsinst.getString("TOT_SANC");
//PREONSAN_EDP=rsinst.getString("PEND_VERY")==null?"":rsinst.getString("PEND_VERY");
//POSONSAN_EDP=rsinst.getString("EDP_NOTCOMP")==null?"":rsinst.getString("EDP_NOTCOMP");


	
	
	
 %>
<% if (flag.equals("Y")){%>
<tbody>
 <tr>
 <th  colspan="25"><div align="center"></div> </span></th>
 </tr>
	 <%}%>
	 
     <tr>
	 
<td><div align="center"><%=srn%>)</div></td>
<%
vnmdw=rsinst.getString("off_name1");
vnmdw=rsinst.getString("off_name1")==null?"Total":rsinst.getString("off_name1");

%>

<th >

<%if (vfields.equals("3")) {
p3=vFurl+"&DISTCD="+vnmdw+"&STATECD="+firstcolold;
//out.print(vnmdw);
}else{
p3=vFurl+p2+vnmdw+p1+firstcolold;
//out.print(repnm+urlrep+p2+vnmdw+p1+firstcolold+"&0FF_NAME="+vnmdw);
}
if (!vnmdw.equals("Total")){
out.print(vnmdw+"-"+OFF_CD);
}
else{
out.print(vnmdw);	
}%>
</th>

<td>
<% if (!vnmdw.equals("Total")){
 out.print(EDP_STATE);
}%>
 
 
 </td>


 
<td ><%=TOTON_EDP  %></td>
<td >	<%=TOTOF_EDP  %>	</td>
<td  ><%=TOT_EDP  %></td>

<th nowrap="nowrap">
<% if (!vnmdw.equals("Total")){%>
<a href="<%=urlrepE+vnmdw+"&DISTCD="+zone_nm%>">DOWNLOAD</a>
<%}%></th>
<!--<th nowrap="nowrap"><a href="bankdw_pmegpdistrict.jsp?<%=p3+vFurl%>">view</a></th>-->
     </tr>
<%
}
rsinst.close();
db.close();
}catch (Exception e) {
out.print (e.toString());
}
}//end if
%>
</tbody>
</table>
</w:realPage>
</w:wait> 
</form>
</body>
</html>
