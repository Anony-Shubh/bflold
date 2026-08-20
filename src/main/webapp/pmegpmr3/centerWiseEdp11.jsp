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
String repnm="centerWiseEdp.jsp";
 //urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt;
 urlrepE ="edpJasperRepo.jsp?TODT="+ToDt+"&FROMDT="+FromDt+"&AGENCY="+vAgency+"&DISTCD="+vDist+"&ZONECD="+vZonecd+"&STATECD="+vStatecd+"&OFF_NAME1=";
 String EDPOFF_CD="";
String STATE_NM="";
String OFF_NAME="";
String PREON_EDP="";

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


 
 txtSearch=txtSearch+" AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"' AND MOM.OFF_NAME1 LIKE '"+vOffice+"' ";

out.print(vfields);

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
 
 /*
  

 qrysb.append("   SELECT A.* FROM (SELECT NVL(MO.OFF_NAME,'Total') as OFF_NAME1 ,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ado.ACT_ID = 5   "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS BANK_FORW,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE IN (1, 2)"      );
qrysb.append("       AND bd.ACT_ID     = 11"      );
qrysb.append("       AND ado.ACT_ID    = 5   "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PREONSAN_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE = 2"      );
qrysb.append("       AND bd.ACT_ID    = 11"      );
qrysb.append("       AND ado.ACT_ID   = 5"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS POSONSAN_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE IN (3, 4)"      );
qrysb.append("       AND bd.ACT_ID     = 11"      );
qrysb.append("       AND ado.ACT_ID    = 5"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PREOFSAN_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE = 4"      );
qrysb.append("       AND bd.ACT_ID    = 11"      );
qrysb.append("       AND ado.ACT_ID   = 5"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS POSOFSAN_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE = 1"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PREON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE = 2"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS POSTON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE IN (1, 2)"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS TOTON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE = 3"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PREOF_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE = 4"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS POSTOF_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE IN (3, 4)"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS TOTOF_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE IN (1, 2, 3, 4)"      );
qrysb.append("      "      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS TOT_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (1)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS COMPREON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (2)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS COMPOSTON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (3)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS COMPREOF_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (4)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS COMPOSTOF_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (1)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PENPREON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (2)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PENPOSTON_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (3)"      );
qrysb.append("      "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PENPREOF_EDP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ed.EDP_TYPE   IN (4)   "      );
qrysb.append("       AND ed.EDP_CERT_DT IS NULL   "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PENPOSTOF_EDP"      );
qrysb.append("   FROM APP_DETAIL ado,"      );
qrysb.append("     BANK_DATAENTRY bd,"      );
qrysb.append("     edp_conduct_trans ed,"      );
qrysb.append("     m_district DM,"      );
qrysb.append("     m_state ms,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     MAS_OFF_MAST MO,"      );
qrysb.append("     ZONE_MAST ZM"      );
qrysb.append("   WHERE ado.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("   AND ado.APP_ID       = ed.APP_ID"      );
qrysb.append("   AND ado.app_dist_cd = DM.DISTRICT_CD"      );
qrysb.append("   AND DM.STATE_CD      = ms.STATE_CD"      );
qrysb.append("   AND ed.EDPOFF_CD     = MO.OFF_CD"      );
qrysb.append("   AND ado.OFF_CD       = mom.OFF_CD"      );
qrysb.append("   AND ms.ZONE_CD       = ZM.ZONE_CD  "+txtSearch+"   "      );
qrysb.append("   AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("   GROUP BY ROLLUP(MO.OFF_NAME))A WHERE A.TOT_EDP >0 OR A.bank_forw > 0 "      );

//qrysb.append(" and ad.unit_pin in (221307,221403,221109,221206,221405,221105,221001) and ad.UNIT_DIST_CD=436 ");
//qrysb.append("  "+txtSearch+" ");
//qrysb.append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by "+qryGroup+" )A ");
*/
qrysb.append("   SELECT nvl(A.OFF_NAME,'Total')  as off_name1 ,max(A.off_cd ) as off_cd,"      );
qrysb.append("   sum(A.BANK_FORW) AS BANK_FORW, sum(A.PREONSAN_EDP) AS PREONSAN_EDP, "      );
qrysb.append("   sum(A.POSONSAN_EDP) AS POSONSAN_EDP, sum(A.PREOFSAN_EDP) AS PREOFSAN_EDP,"      );
qrysb.append("   sum(A.POSOFSAN_EDP) AS POSOFSAN_EDP, sum(A.PREON_EDP) AS PREON_EDP,"      );
qrysb.append("   sum(A.POSTON_EDP) AS POSTON_EDP, sum(A.TOTON_EDP) AS TOTON_EDP, sum(A.PREOF_EDP) AS PREOF_EDP,"      );
qrysb.append("   sum(A.POSTOF_EDP) AS POSTOF_EDP, sum(A.TOTOF_EDP) AS TOTOF_EDP, sum(A.TOT_EDP) AS TOT_EDP, sum(A.COMPREON_EDP) AS COMPREON_EDP,"      );
qrysb.append("   sum(A.COMPOSTON_EDP) AS COMPOSTON_EDP, sum(A.COMPREOF_EDP) AS COMPREOF_EDP, sum(A.COMPOSTOF_EDP) AS COMPOSTOF_EDP, "      );
qrysb.append("   sum(A.PENPREON_EDP) AS PENPREON_EDP, sum(A.PENPOSTON_EDP) AS PENPOSTON_EDP, sum(A.PENPREOF_EDP) AS PENPREOF_EDP,"      );
qrysb.append("   sum(A.PENPOSTOF_EDP) AS PENPOSTOF_EDP FROM ");
 

qrysb.append("   (SELECT DM.district_name,mo.OFF_NAME,mo.off_cd,"      );
qrysb.append("  SUM( CASE WHEN ADO.ACT_ID=5 AND ED.ACT_YN='Y' THEN 1 ELSE 0 END) AS BANK_FORW,  " );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN(1,2) AND bd.act_id=11 and ado.act_id=5 AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREONSAN_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE =2  AND bd.act_id=11 and ado.act_id=5 AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSONSAN_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (3,4)  AND bd.act_id=11 and ado.act_id=5 AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOFSAN_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE =4  AND bd.act_id=11 and ado.act_id=5 AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSOFSAN_EDP,    "      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 1 AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 2 AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 3 AND ed.ACT_YN = 'Y' "      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 4 AND ed.ACT_YN = 'Y' "      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (3,4) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2, 3, 4) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOT_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (1) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREON_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (2) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (3) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREOF_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (4) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (1,3) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL  "      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREON_EDP,"      );

qrysb.append("       0 AS PENPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (2,4) AND ed.ACT_YN = 'Y'  and bd.act_id=11"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREOF_EDP,"      );

qrysb.append("      0 AS PENPOSTOF_EDP"      );
qrysb.append("  FROM APP_DETAIL ado, BANK_DATAENTRY bd, edp_conduct_trans ed, m_district DM, m_state ms, mas_off_mast mom,MAS_OFF_MAST MO, ZONE_MAST ZM ");
 qrysb.append("  WHERE ado.APP_ID = bd.APP_ID(+) AND ado.APP_ID = ed.APP_ID (+) AND ado.UNIT_DIST_CD = DM.DISTRICT_CD(+) AND DM.STATE_CD = ms.STATE_CD(+)  ");
 qrysb.append("  AND ed.EDPOFF_CD = mo.OFF_CD(+) AND ado.OFF_CD = mom.OFF_CD(+) AND ms.ZONE_CD = ZM.ZONE_CD"      );
qrysb.append("  "+txtSearch+"    "  );
qrysb.append("    group by mo.OFF_NAME,mo.off_cd,(DM.district_name) )"      );
qrysb.append("   A WHERE A.TOT_EDP >0 OR BANK_FORW > 0 group by ROLLUP(A.OFF_NAME)"      );



//out.print (qrysb.toString());
String off_cd="";
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
  <th rowspan="4">Row ID</th>
  <th rowspan="4" > Nane </th>
  
  <th colspan="2"  >Online EDP </th>
  <th rowspan="4" >Total   </th>
  <th colspan="2" >Offline EDP </th>
  <th rowspan="4" >Total   </th>
  <th rowspan="4" >Grand Total  </th>
  <th rowspan="4" >Forwarded to Bank</th>
  <th colspan="4" rowspan="2" >Sanctioned By Bank </th>
  <th colspan="4">Completed EDP </th>
  <th colspan="2"><span class="redLebel">Pending EDP </span></th>
  <th rowspan="4">Training Center Wise </th>
</tr>
<tr>
  <th rowspan="3"  >Pre</th>
  <th rowspan="3"  >Post</th>
  <th rowspan="3" >Pre</th>
  <th rowspan="3" >Post</th>
  <th colspan="2">Online</th>
  <th colspan="2">Offline</th>
  <th rowspan="3"  > <span class="OrangeLebel"><p>Pre EDP </p>
   <p>(Before Sanction) </p></span></th>
  <th rowspan="3"  ><span class="MarunLebel">Loan Sanction Pending for EDP</span> </th>
</tr>
<tr>
  <th colspan="2" >Online</th>
  <th colspan="2" >Offline</th>
  <th rowspan="2">Pre</th>
  <th rowspan="2">Post</th>
  <th rowspan="2">Pre</th>
  <th rowspan="2">Post</th>
  </tr>
<tr>
  <th >Pre</th>
  <th >Post</th>
  <th >Pre</th>
  <th >Post</th>
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
off_cd=rsinst.getString("off_cd")==null?"":rsinst.getString("off_cd");
//PENOF_EDP=rsinst.getString("PENOF_EDP")==null?"":rsinst.getString("PENOF_EDP");
//PENON_EDP=rsinst.getString("PENON_EDP")==null?"":rsinst.getString("PENON_EDP");
//COMOF_EDP=rsinst.getString("COMOF_EDP")==null?"":rsinst.getString("COMOF_EDP");
PREOF_EDP=rsinst.getString("PREOF_EDP")==null?"":rsinst.getString("PREOF_EDP");
PREON_EDP=rsinst.getString("PREON_EDP")==null?"":rsinst.getString("PREON_EDP");
//COMON_EDP=rsinst.getString("COMON_EDP")==null?"":rsinst.getString("COMON_EDP");
POSTOF_EDP=rsinst.getString("POSTOF_EDP")==null?"":rsinst.getString("POSTOF_EDP");
POSTON_EDP=rsinst.getString("POSTON_EDP")==null?"":rsinst.getString("POSTON_EDP");
TOTOF_EDP=rsinst.getString("TOTOF_EDP")==null?"":rsinst.getString("TOTOF_EDP");
TOTON_EDP=rsinst.getString("TOTON_EDP")==null?"":rsinst.getString("TOTON_EDP");
TOT_EDP=rsinst.getString("TOT_EDP")==null?"":rsinst.getString("TOT_EDP");
BANK_FORW=rsinst.getString("BANK_FORW")==null?"":rsinst.getString("BANK_FORW");
PREONSAN_EDP=rsinst.getString("PREONSAN_EDP")==null?"":rsinst.getString("PREONSAN_EDP");
POSONSAN_EDP=rsinst.getString("POSONSAN_EDP")==null?"":rsinst.getString("POSONSAN_EDP");
PREOFSAN_EDP=rsinst.getString("PREOFSAN_EDP")==null?"":rsinst.getString("PREOFSAN_EDP");
POSOFSAN_EDP=rsinst.getString("POSOFSAN_EDP")==null?"":rsinst.getString("POSOFSAN_EDP");

COMPREON_EDP=rsinst.getString("COMPREON_EDP")==null?"":rsinst.getString("COMPREON_EDP");
COMPOSTON_EDP=rsinst.getString("COMPOSTON_EDP")==null?"":rsinst.getString("COMPOSTON_EDP");
COMPREOF_EDP=rsinst.getString("COMPREOF_EDP")==null?"":rsinst.getString("COMPREOF_EDP");
COMPOSTOF_EDP=rsinst.getString("COMPOSTOF_EDP")==null?"":rsinst.getString("COMPOSTOF_EDP");



PENPREON_EDP=rsinst.getString("PENPREON_EDP")==null?"":rsinst.getString("PENPREON_EDP");
PENPOSTON_EDP=rsinst.getString("PENPOSTON_EDP")==null?"":rsinst.getString("PENPOSTON_EDP");
PENPREOF_EDP=rsinst.getString("PENPREOF_EDP")==null?"":rsinst.getString("PENPREOF_EDP");
PENPOSTOF_EDP=rsinst.getString("PENPOSTOF_EDP")==null?"":rsinst.getString("PENPOSTOF_EDP");


	
	
	
 %>
<% if (flag.equals("Y")){%>
<tbody>
 <tr>
 <th  colspan="23"><div align="center"></div> </span></th>
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
%>
<% if (!vnmdw.equals("Total")){%>
<%=vnmdw  %>-<%=off_cd%>
<% }else { out.print(vnmdw);}%>

</th>





 
<td ><%=PREON_EDP  %></td>
<td >	<%=POSTON_EDP  %>	</td>
<td  ><%=TOTON_EDP  %></td>
<td >	<%=PREOF_EDP  %>	</td>
<td ><%=POSTOF_EDP  %></td>
<td  >	<%=TOTOF_EDP  %>	</td>
<td  ><%=TOT_EDP  %></td>
<td  ><%=BANK_FORW  %></td>
<td colspan="2"  ><%=PREONSAN_EDP  %></td>
<td colspan="2"  ><%=PREOFSAN_EDP  %></td>
<td >	<%=COMPREON_EDP  %>	</td>
<td ><%=COMPOSTON_EDP  %></td>
<td >	<%=COMPREOF_EDP  %>	</td>
<td ><%=COMPOSTOF_EDP  %></td>
<td >
<% if (!vnmdw.equals("Total")){%>
<a href="<%=urlrepE+vnmdw+"&DISTCD="+vDist%>&QRYCODE=1&REPTP=5">	<%=PENPREON_EDP  %></a>
<%} else{%>
<%=PENPREON_EDP  %>
<%}%>
</td>
<td ><% if (!vnmdw.equals("Total")){%>
<a href="<%=urlrepE+vnmdw+"&DISTCD="+vDist%>&QRYCODE=2&REPTP=5">	<%=PENPREOF_EDP  %></a>
<%} else{%>
<%=PENPREOF_EDP  %>
<%}%>
</td>
<th nowrap="nowrap">
<% if (!vnmdw.equals("Total")){%>
<a href="<%=urlrepE+off_cd+"&DISTCD="+zone_nm%>">DOWNLOAD</a>
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
