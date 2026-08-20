<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Performance Report</title>


<link rel="stylesheet" type="text/css" href="css/indexr.css">


</head>
<body>
<form name="form" id="form"  class="form" >

  
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

String vUsrnm= (String) session.getAttribute("suser_detail")==null?"":(String) session.getAttribute("suser_detail");
//out.print(vUsrnm);
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
//out.print(vsZonecd);
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
//out.print(vsAgency);
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
//out.print(vsStatecd);
if ((vUsrnm.equals("null")) || (vsZonecd.equals("null")) || (vsAgency.equals("null")) || (vsStatecd.equals("null")))
{
	response.sendRedirect("index.jsp");
	
}

vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;

String vAgencytit="";
String vsZonetit="";
String vsStatetit="";


txtSearch=" AND A.AGENCY_TYPE LIKE '"+vsAgency+"' AND A.ZONE_NM LIKE '"+vsZonecd+"' AND  A.STATE_NM LIKE '"+vsStatecd+"'";
//out.print(vsStatecd);
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



String PARDIS_MM="";
String PARDIS_NO="";
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
String repnm="pmegpdashboardgeoPhy.jsp";
 urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt+"&";
 String repnmE="geojasper.jsp";
  String PEN_APV="";
  String APV_DO="";
 String EDPOFF_CD="";
String STATE_NM="";
String OFF_NAME="";
String PREON_EDP="";
String BCLNO_AMT="";
String BCLNO="";
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
String QRYCODE="";

 
 txtSearch=txtSearch+"AND A.AGENCY_TYPE LIKE '"+vAgency+"' AND A.ZONE_NM LIKE '"+vZonecd+"' AND A.STATE_NM LIKE '"+vStatecd+"' AND A.OFF_NAME1 LIKE '"+vOffice+"' ";



if (vfields.equals("0")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" MAX('ALL') as zone_nm , A.AGENCY_TYPE as off_name1 ";
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
qryField=" A.zone_nm as zone_nm , A.AGENCY_TYPE as off_name1 ";
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
qryGroup1=" A.zone_nm,ROLLUP(A.AGENCY_TYPE) ";
}else{
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE  ";
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE  ";
}

urlrep=urlrep+"&REPTP=2";
p1="&ZONECD=";
p2="&AGENCY=";
}else if (vfields.equals("2")){
ReportName="Zone and State Wise ";
qryField=" A.zone_nm as zone_nm , A.STATE_NM as off_name1 ";
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
qryField=" A.STATE_NM ,A.UNIT_DIST as off_name1";
qryField1=" A.STATE_NM as zone_nm ,A.UNIT_DIST as off_name1 ";
if (vsStatetit.equals("ALL")) {
qryGroup=" (A.STATE_NM,A.UNIT_DIST) ";
qryGroup1=" ROLLUP(A.STATE_NM,A.UNIT_DIST) ";
}else {
qryGroup=" A.STATE_NM,(A.UNIT_DIST)  ";
qryGroup1=" A.STATE_NM,ROLLUP(A.UNIT_DIST)  ";
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

	
	String RVNO="";	
		%>
		
		<%

    Enumeration parameterList = request.getParameterNames();
	String vFurl="AGENCY="+vsAgency+"&ZONECD="+vsZonecd+"&STATECD="+vsStatecd+"&";
	
	//String vFurl="AGENCY="+vsAgency+"&ZONECD="+vsZonecd+"&STATECD="+vsStatecd+"&";
	
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
 
/* 
qrysb.append(" select "+qryField1+", COUNT(*) AS TOT, ");
qrysb.append(" SUM(NVL(DECODE(gt.pmegpgeotagid,NULL,1,0),0)) AS NOT_COMP, ");
qrysb.append(" SUM(NVL(DECODE(gt.pmegpgeotagid,NULL,0,1),0)) AS COMP,"); 
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND UPPER(VERIFICATION_STATUS)='WORKING' THEN 1 ELSE 0 END) AS COM,"); 
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND UPPER(VERIFICATION_STATUS)='NON-TRACEABLE' THEN 1 ELSE 0 END) AS NT,"); 
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND UPPER(VERIFICATION_STATUS)='DEFUNCT' THEN 1 ELSE 0 END) AS DF,");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS not NULL   THEN 1 ELSE 0 END) AS QC_PEN,  ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS NOT  NULL AND ACT_ID=1    THEN 1 ELSE 0 END) AS QC_COMP,  ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND GT.MM_ADJUSTMENT_STATUS IS NOT NULL  THEN 1 ELSE 0 END) AS ADJ_NO,  ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND GT.MM_ADJUSTMENT_STATUS IS NOT NULL AND GT.AGENCY_UPLOAD IS NOT NULL THEN 1 ELSE 0 END) AS ADJ_MM,  ");
qrysb.append("SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND  GT.MM_ADJUSTMENT_STATUS='RU' THEN 1 ELSE 0 END) AS RVNO,  ");
qrysb.append("SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND  GT.MM_ADJUSTMENT_STATUS IS NOT NULL  THEN 1 ELSE 0 END) AS FULLADJ_NO,  ");
qrysb.append("SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND  GT.MM_ADJUSTMENT_STATUS IS NOT NULL   THEN  ROUND(MM_ADJUSTMENT_AMT_S / 100000, 2) ELSE 0 END) AS FULLADJ_MM,  ");
qrysb.append("SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND  GT.MM_ADJUSTMENT_STATUS='RM' AND NVL(GT.MM_ADJUSTMENT_AMT_S,0)=0 THEN 1 ELSE 0 END) AS FULLDIS_NO,  ");
qrysb.append("SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1  AND GT.MM_ADJUSTMENT_STATUS='RM' AND NVL(GT.MM_ADJUSTMENT_AMT_S,0)=0 THEN  ROUND(MM_ADJUSTMENT_AMT_S / 100000, 2) ELSE 0 END) AS FULLDIS_MM,  ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND NVL(gt.agn_callback,0) > 0 THEN 1 ELSE 0 END) AS PARDIS_NO,  ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND NVL(gt.agn_callback,0) > 0 THEN ROUND(A.MM_REL_AMT / 100000, 2) ELSE 0 END) AS PARDIS_MM,");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND GT.ACT_ID=1 AND NVL(gt.agn_callback,0) > 0 THEN round(gt.agn_callback/100000,2)  ELSE 0 END) AS CALL_BCK, ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS  NULL    THEN 1 ELSE 0 END) AS AGEN_PEN,   ");
qrysb.append(" SUM(CASE WHEN gt.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS NOT  NULL AND NVL(ACT_ID,0) IN (0,2)   THEN 1 ELSE 0 END) AS NAGEN_PEN ");
qrysb.append(" from GEOTAGAPIDATA A ,geotag_trans gt ");
qrysb.append(" where A.app_id=gt.app_id(+)   "+txtSearch+" ");
qrysb.append(" GROUP BY "+qryGroup1+" ");
 */

//out.print(qrysb.toString());
//AND TRUNC(A.DATE_OF_VERIFICATION) BETWEEN '"+FromDt+"' AND '"+ToDt+"'

//out.print(qrysb.toString());

qrysb.append("   SELECT "+qryField1+",  "      );
qrysb.append("     COUNT(*)                                          AS TOT,"      );
qrysb.append("     SUM(NVL(DECODE(A.PMEGPGEOTAGID, NULL, 1, 0), 0)) AS NOT_COMP,"      );
qrysb.append("     SUM(NVL(DECODE(A.PMEGPGEOTAGID, NULL, 0, 1), 0)) AS COMP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID            IS NOT NULL"      );
qrysb.append("       AND UPPER(A.VERIFICATION_STATUS) = 'WORKING'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS COM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID            IS NOT NULL"      );
qrysb.append("       AND UPPER(A.VERIFICATION_STATUS) = 'NON-TRACEABLE'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS NT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID            IS NOT NULL"      );
qrysb.append("       AND UPPER(A.VERIFICATION_STATUS) = 'DEFUNCT'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS DF,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS QC_PEN,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                = 1"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS QC_COMP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS ADJ_NO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       AND A.AGENCY_UPLOAD        IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS ADJ_MM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID      IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID               = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS = 'RU'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS RVNO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS FULLADJ_NO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       THEN ROUND(A.MM_ADJUSTMENT_AMT_S / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS FULLADJ_MM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID             IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                      = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS        = 'RM'"      );
qrysb.append("       AND NVL(A.MM_ADJUSTMENT_AMT_S, 0) = 0"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS FULLDIS_NO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID             IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID                      = 1"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS        = 'RM'"      );
qrysb.append("       AND NVL(A.MM_ADJUSTMENT_AMT_S, 0) = 0"      );
qrysb.append("       THEN ROUND(A.MM_ADJUSTMENT_AMT_S / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS FULLDIS_MM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID IS NOT NULL AND AGENCY_UPLOAD IS NOT NULL "      );
qrysb.append("       AND A.ACT_ID               = 1"      );
qrysb.append("       AND NVL(A.AGN_CALLBACK, 0) > 0"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PARDIS_NO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID IS NOT NULL AND AGENCY_UPLOAD IS NOT NULL "      );
qrysb.append("       AND A.ACT_ID               = 1"      );
qrysb.append("       AND NVL(A.AGN_CALLBACK, 0) > 0"      );
qrysb.append("       THEN ROUND(A.MM_REL_AMT / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PARDIS_MM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID      IS NOT NULL AND AGENCY_UPLOAD IS NOT NULL"      );
qrysb.append("       AND A.ACT_ID               = 1"      );
qrysb.append("       AND NVL(A.AGN_CALLBACK, 0) > 0"      );
qrysb.append("       THEN ROUND(A.AGN_CALLBACK / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS CALL_BCK,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS AGEN_PEN,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN A.PMEGPGEOTAGID       IS NOT NULL"      );
qrysb.append("       AND A.MM_ADJUSTMENT_STATUS IS NOT NULL"      );
qrysb.append("       AND NVL(A.ACT_ID, 0)       IN (0, 2)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS NAGEN_PEN,"      );
qrysb.append("      SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN B.STATUS = 'success' AND B.PRODUCTINFO='Margin Money Callback'   "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS BCLNO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN B.STATUS = 'success' AND B.PRODUCTINFO='Margin Money Callback'   "      );
qrysb.append("       THEN ROUND(TO_NUMBER(B.AMOUNT)/100000,2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS BCLNO_AMT"      );
qrysb.append("      "      );
qrysb.append("   from "      );
qrysb.append("   (SELECT A.AGENCY_TYPE,"      );
qrysb.append("     A.ZONE_NM,"      );
qrysb.append("     A.STATE_NM,"      );
qrysb.append("     A.UNIT_DIST,"      );
qrysb.append("     A.MM_REL_AMT,"      );
qrysb.append("     gt.PMEGPGEOTAGID,"      );
qrysb.append("     gt.APP_ID,"      );
qrysb.append("     gt.ACT_ID,"      );
qrysb.append("     gt.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("     gt.AGN_CALLBACK,"      );
qrysb.append("     gt.MM_ADJUSTMENT_AMT_S,"      );
qrysb.append("     gt.AGENCY_UPLOAD,gt.VERIFICATION_STATUS,A.OFF_NAME1"      );
qrysb.append("   FROM GEOTAGAPIDATA A,"      );
qrysb.append("     geotag_trans gt"      );
qrysb.append("   WHERE A.APP_ID = gt.APP_ID(+) AND TRUNC(A.MM_REL_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "+txtSearch+" "      );
qrysb.append("   )A,"      );
qrysb.append("   (SELECT ir.STATUS,ir.PRODUCTINFO,"      );
qrysb.append("     ir.UDF1 as app_id,"      );
qrysb.append("     ir.AMOUNT"      );
qrysb.append("   FROM GEOTAGAPIDATA A,"      );
qrysb.append("     indbank_request ir"      );
qrysb.append("   WHERE A.APP_ID = ir.UDF1 AND ir.STATUS = 'success'"      );
qrysb.append("   )B"      );
qrysb.append("   where A.app_id=B.app_id(+)"      );
qrysb.append("   GROUP BY "+qryGroup1+" "      );


//out.print(qrysb.toString());

try{
ResultSet rsinst = db.execSQL(qrysb.toString());

String CALL_BCK="";


%>


 <table align="center" >
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">PMEGP Portal online Physical Verification Report </div></td>
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
 out.print(offtl);
 %>
 </div>
<table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
   <thead>
     <tr>
       <th rowspan="2">Row ID</th>
       <th rowspan="2" > Name </th>
       <th rowspan="2"  >Physical Verification To be Conducted </th>
	   <th colspan="4"  >Physical Verification Completed </th>
	     <th colspan="2"  >Validated By DCO </th>
		   <th colspan="2"  >Approved By Approver </th>
       <th colspan="2" > Adjustment Letter </th>
       <th colspan="2" >Margin Money Adjustment Status </th>
       <th colspan="3" >MM Call Back Status </th>
      
	   <th colspan="2" >Reverification </th>
	    <th colspan="2" >Callback MM Recieved from Financing Bank</th>
     </tr>
     <tr>
       <th  >Working </th>
       <th  >Not Working </th>
       <th  >Non Traceable </th>
       <th  >Total</th>
       <th  >Recommended</th>
       <th  >Pending</th>
       <th  >Approved</th>
       <th  >Pending</th>
       <th >&nbsp;</th>
       <th >Uploaded</th>
       <th >No.</th>
       <th >MM.</th>
       <th >No.</th>
       <th >MM.</th>
       <th >Callback Amt </th>
      
 <th colspan="2">&nbsp;</th>
  <th >No.</th>
   <th >MM.</th>
     </tr>
   </thead>
   <%
 String Head="";
 String firstcolnew="";
 String firstcolold="";
 String flag="Y";
 String COMP="";
 String NOT_COMP="";
 String DF="";
 String NT="";
 String COM="";
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
	
zone_nm=rsinst.getString("zone_nm")==null?"":rsinst.getString("zone_nm");
COM=rsinst.getString("COM")==null?"":rsinst.getString("COM");
NT=rsinst.getString("NT")==null?"":rsinst.getString("NT");
DF=rsinst.getString("DF")==null?"":rsinst.getString("DF");

PENOF_EDP=rsinst.getString("TOT")==null?"":rsinst.getString("TOT");
PREOF_EDP=rsinst.getString("QC_PEN")==null?"":rsinst.getString("QC_PEN");
PREON_EDP=rsinst.getString("QC_COMP")==null?"":rsinst.getString("QC_COMP");
TOTOF_EDP=rsinst.getString("ADJ_NO")==null?"":rsinst.getString("ADJ_NO");
TOTON_EDP=rsinst.getString("ADJ_MM")==null?"":rsinst.getString("ADJ_MM");
TOT_EDP=rsinst.getString("FULLADJ_NO")==null?"":rsinst.getString("FULLADJ_NO");
BANK_FORW=rsinst.getString("FULLADJ_MM")==null?"":rsinst.getString("FULLADJ_MM");
PREONSAN_EDP=rsinst.getString("FULLDIS_NO")==null?"":rsinst.getString("FULLDIS_NO");
POSONSAN_EDP=rsinst.getString("FULLDIS_MM")==null?"":rsinst.getString("FULLDIS_MM");
PARDIS_NO=rsinst.getString("PARDIS_NO")==null?"":rsinst.getString("PARDIS_NO");
PARDIS_MM=rsinst.getString("PARDIS_MM")==null?"":rsinst.getString("PARDIS_MM");
APV_DO=rsinst.getString("AGEN_PEN")==null?"":rsinst.getString("AGEN_PEN");
PEN_APV=rsinst.getString("NAGEN_PEN")==null?"":rsinst.getString("NAGEN_PEN");
COMP=rsinst.getString("COMP")==null?"":rsinst.getString("COMP");
NOT_COMP=rsinst.getString("NOT_COMP")==null?"":rsinst.getString("NOT_COMP");
CALL_BCK=rsinst.getString("CALL_BCK")==null?"":rsinst.getString("CALL_BCK");
RVNO=rsinst.getString("RVNO")==null?"":rsinst.getString("RVNO");
BCLNO=rsinst.getString("BCLNO")==null?"":rsinst.getString("BCLNO");
BCLNO_AMT=rsinst.getString("BCLNO_AMT")==null?"":rsinst.getString("BCLNO_AMT");




	
	
	
 %>
   <% if (flag.equals("Y")){%>
   <tbody>
     <tr>
       <th  colspan="36"><div align="center"></div>
           <%=firstcolold%></th>
     </tr>
     <%}%>
     <tr>
       <td><div align="center"><%=srn%>)</div></td>
       <%
vnmdw=rsinst.getString("off_name1");
vnmdw=rsinst.getString("off_name1")==null?"Total":rsinst.getString("off_name1");

%>
       <th > <%if (vfields.equals("3")) {
p3=vFurl+"&DISTCD="+vnmdw+"&STATECD="+firstcolold;
out.print(vnmdw);
}else{
p3=vFurl+p2+vnmdw+p1+firstcolold;
%>
         <a href="<%=repnm+urlrep+p2+vnmdw+p1+firstcolold%>"><%=vnmdw %></a>
         <%}%></th>
       <% if(!vfields.equals("3")){%>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=1"><%=PENOF_EDP%></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=2"><%=COM  %></a></td>
	    <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=3"><%=DF  %></a></td>
	    <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=4"><%=NT  %></a></td>
	     <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=5"><%=COMP  %></a></td>
	    <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=6"><%=PREOF_EDP  %></a></td>
		 <td> <a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=7"><%=APV_DO  %></a></td>
		 <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=8"><%=PREON_EDP  %></a></td>
	     <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=9"><%=PEN_APV  %></a></td>
        <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=10"></a></td>
        <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=11"><%=TOTON_EDP%></a></td>
        <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=12"><%=TOT_EDP  %></a></td>
        <td  ><%=BANK_FORW%></td>
        <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=13"><%=PARDIS_NO  %></a></td>
        <td ><%=PARDIS_MM%></td>
		 <td ><%=CALL_BCK%></td>
       
	    <td colspan="2"><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=14"><%=RVNO%></a></td>
     
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=15"><%= BCLNO%></a></td>
	    <td  ><%= BCLNO_AMT%></td>
       <% } else{%>
      <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=1"><%=PENOF_EDP%></a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=2"><%=COM  %></a></td>
	    <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=3"><%=DF  %></a></td>
	    <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=4"><%=NT  %></a></td>
	     <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=5"><%=COMP  %></a></td>
	    <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=6"><%=PREOF_EDP  %></a></td>
		 <td> <a href="<%=repnmE+urlrep+p3%>&QRYCODE=7"><%=APV_DO  %></a></td>
		 <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=8"><%=PREON_EDP  %></a></td>
	     <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=9"><%=PEN_APV  %></a></td>
        <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=10"><%=TOTOF_EDP  %></a></td>
        <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=11"><%=TOTON_EDP%></a></td>
        <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=12"><%=TOT_EDP  %></a></td>
        <td  ><%=BANK_FORW%></td>
        <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=13"><%=PARDIS_NO  %></a></td>
        <td ><%=PARDIS_MM%></td>
		 <td ><%=CALL_BCK%></td>
       
	    <td colspan="2"><a href="<%=repnmE+urlrep+p3%>&QRYCODE=14"><%=RVNO%></a></td>
      
       <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=15"><%= BCLNO%></a></td>
	    <td  ><%= BCLNO_AMT%></td>
	          <!--  <td   ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=8&REPTP=4"><%=PREON_EDP  %></a></td>-->
       <%}%>
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
