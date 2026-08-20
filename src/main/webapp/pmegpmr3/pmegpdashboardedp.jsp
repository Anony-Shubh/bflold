<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,javax.naming.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
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

/*try {
 Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
Connection conn=ds.getConnection(); 

CallableStatement cs = conn.prepareCall("{call  SYNCEDPDATA ()}");
cs.executeQuery();
cs.close();
conn.close();
}catch (Exception b) {
out.print (b.toString());
}
*/
 

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


txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"'";
//out.print(vsStatecd);
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");

/*
Connection conn=null;	
		try {
 
  Class.forName("oracle.jdbc.OracleDriver");
  conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "PMEGPNEW", "PMEGP_1239");



 
CallableStatement cs = conn.prepareCall("{call SYNCEDPDATA(?,?)}");
cs.setString(1,FromDt);
cs.setString(2,ToDt);
cs.executeQuery();
}
catch (Exception b) {
out.print (b.toString());
}
*/




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
String repnm="pmegpdashboardedp.jsp";
 urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt;
 String repnmE="edpJasperRepo.jsp";
  
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
String QRYCODE="";

 
 txtSearch=txtSearch+"AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"' AND MOM.OFF_NAME1 LIKE '"+vOffice+"' ";



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
qryGroup1=" A.zone_nm,ROLLUP(A.AGENCY_TYPE) ";
}else{
qryGroup=" A.zone_nm,A.AGENCY_TYPE  ";
qryGroup1=" A.zone_nm,A.AGENCY_TYPE  ";
}

urlrep=urlrep+"&REPTP=2";
p1="&ZONECD=";
p2="&AGENCY=";
}else if (vfields.equals("2")){
ReportName="Zone and State Wise ";
qryField=" A.zone_nm as zone_nm , A.STATE_NM ";
qryField1=" A.zone_nm as zone_nm , A.STATE_NM as off_name1 ";
if (vAgency.equals("KVIC")){
urlrep=urlrep+"&REPTP=3&AGENCY=KVIC";
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
 

qrysb.append("   SELECT"      );
qrysb.append("     "+qryField1+" ,"      );
qrysb.append("      sum(A.BANK_FORW)  AS BANK_FORW,"      );
qrysb.append("     sum(A.PREONSAN_EDP) AS PREONSAN_EDP,"      );
qrysb.append("     sum(A.POSONSAN_EDP)  AS POSONSAN_EDP,"      );
qrysb.append("     sum(A.PREOFSAN_EDP)  AS PREOFSAN_EDP,"      );
qrysb.append("     sum(A.POSOFSAN_EDP) AS POSOFSAN_EDP, "      );
qrysb.append("     sum(A.PREON_EDP)  AS PREON_EDP,"      );
qrysb.append("     sum(A.POSTON_EDP) AS POSTON_EDP,"      );
qrysb.append("     sum(A.TOTON_EDP)  AS TOTON_EDP,"      );
qrysb.append("     sum(A.PREOF_EDP)  AS PREOF_EDP,"      );
qrysb.append("     sum(A.POSTOF_EDP) AS POSTOF_EDP,"      );
qrysb.append("     sum(A.TOTOF_EDP)  AS TOTOF_EDP,"      );
qrysb.append("     sum(A.TOT_EDP)    AS TOT_EDP,"      );
qrysb.append("     sum(A.COMPREON_EDP)  AS COMPREON_EDP,  "      );
qrysb.append("     sum(A.COMPOSTON_EDP)  AS COMPOSTON_EDP,"      );
qrysb.append("     sum(A.COMPREOF_EDP)  AS COMPREOF_EDP,"      );
qrysb.append("     sum(A.COMPOSTOF_EDP)  AS COMPOSTOF_EDP,"      );
qrysb.append("     sum(A.PENPREON_EDP)  AS PENPREON_EDP,"      );
qrysb.append("     sum(A.PENPOSTON_EDP)  AS PENPOSTON_EDP,   "      );
qrysb.append("     sum(A.PENPREOF_EDP)  AS PENPREOF_EDP,"      );
qrysb.append("     sum(A.PENPOSTOF_EDP)  AS PENPOSTOF_EDP"      );
qrysb.append("   FROM"      );

qrysb.append("     (SELECT "+qryField+" ,"      );

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
qrysb.append("         WHEN ed.EDP_TYPE   IN (1,3) AND ed.ACT_YN = 'Y' "      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL and bd.act_id <>11  "      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREON_EDP,"      );

qrysb.append("      0  AS PENPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN    "      );
qrysb.append("          ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREOF_EDP,"      );

qrysb.append("       0 AS PENPOSTOF_EDP"      );
qrysb.append("     FROM APP_DETAIL ado,"      );
qrysb.append("       BANK_DATAENTRY bd,"      );
qrysb.append("       edp_conduct_trans ed,"      );
qrysb.append("       m_district DM,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       mas_off_mast mom,"      );

qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ado.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("     AND ado.APP_ID       = ed.APP_ID "      );
qrysb.append("     AND ado.UNIT_DIST_CD = DM.DISTRICT_CD"      );
qrysb.append("     AND DM.STATE_CD      = ms.STATE_CD"      );
qrysb.append("     AND ado.OFF_CD       = mom.OFF_CD"      );
qrysb.append("     AND ms.ZONE_CD       = ZM.ZONE_CD "+txtSearch+" "      );
qrysb.append("     group by "+qryGroup+" "      );

qrysb.append("     ) A  group by "+qryGroup1+"  "      );

*/
/*

qrysb.append("   SELECT "+qryField1+" ,"      );
qrysb.append("     SUM(A.BANK_FORW)     AS BANK_FORW,"      );
qrysb.append("     SUM(A.PREONSAN_EDP)  AS PREONSAN_EDP,"      );
qrysb.append("     SUM(A.POSONSAN_EDP)  AS POSONSAN_EDP,"      );
qrysb.append("     SUM(A.PREOFSAN_EDP)  AS PREOFSAN_EDP,"      );
qrysb.append("     SUM(A.POSOFSAN_EDP)  AS POSOFSAN_EDP,"      );
qrysb.append("     SUM(A.PREON_EDP)     AS PREON_EDP,"      );
qrysb.append("     SUM(A.POSTON_EDP)    AS POSTON_EDP,"      );
qrysb.append("     SUM(A.TOTON_EDP)     AS TOTON_EDP,"      );
qrysb.append("     SUM(A.PREOF_EDP)     AS PREOF_EDP,"      );
qrysb.append("     SUM(A.POSTOF_EDP)    AS POSTOF_EDP,"      );
qrysb.append("     SUM(A.TOTOF_EDP)     AS TOTOF_EDP,"      );
qrysb.append("     SUM(A.TOT_EDP)       AS TOT_EDP,"      );
qrysb.append("     SUM(A.COMPREON_EDP)  AS COMPREON_EDP,"      );
qrysb.append("     SUM(A.COMPOSTON_EDP) AS COMPOSTON_EDP,"      );
qrysb.append("     SUM(A.COMPREOF_EDP)  AS COMPREOF_EDP,"      );
qrysb.append("     SUM(A.COMPOSTOF_EDP) AS COMPOSTOF_EDP,"      );
qrysb.append("     SUM(A.COMPTOT_EDP) AS COMPTOT_EDP,"      );
qrysb.append("     SUM(A.PENPREON_EDP)  AS PENPREON_EDP,"      );
qrysb.append("     SUM(A.PENPOSTON_EDP) AS PENPOSTON_EDP,"      );
qrysb.append("     SUM(A.PENPREOF_EDP)  AS PENPREOF_EDP,"      );
qrysb.append("     SUM(A.PENPOSTOF_EDP) AS PENPOSTOF_EDP,"      );
qrysb.append("     SUM(A.PENPREON_EDP+A.PENPREOF_EDP) AS TOT_PEN_EDP "      );

qrysb.append("   FROM"      );
qrysb.append("     (SELECT "+qryField+" , "      );
qrysb.append("       "      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ado.ACT_ID = 5"      );
qrysb.append("        "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_FORW,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2)"      );
qrysb.append("         AND bd.ACT_ID     = 11"      );
qrysb.append("         AND ado.ACT_ID    = 5"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREONSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE in (1,2,3,4)"      );
qrysb.append("         AND bd.ACT_ID    = 11"      );
qrysb.append("         AND ado.ACT_ID   = 5"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSONSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (3, 4)"      );
qrysb.append("         AND bd.ACT_ID     = 11"      );
qrysb.append("         AND ado.ACT_ID    = 5"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOFSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 4"      );
qrysb.append("         AND bd.ACT_ID    = 11"      );
qrysb.append("         AND ado.ACT_ID   = 5"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSOFSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 1"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 2"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2)"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 3"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 4"      );
qrysb.append("         "      );
qrysb.append("        AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (3, 4)"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2, 3, 4)"      );
qrysb.append("         "      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOT_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (1)"      );
qrysb.append("         AND ed.ACT_YN       = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("          AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (2)"      );
qrysb.append("         AND ed.ACT_YN       = 'Y'"      );
qrysb.append("       AND ed.EDP_CERT_DT IS NOT NULL "      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (3)"      );
qrysb.append("         AND ed.ACT_YN       = 'Y'"      );
qrysb.append("       AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("          AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (4)"      );
qrysb.append("         AND ed.ACT_YN       = 'Y'"      );
qrysb.append("        AND ed.EDP_CERT_DT IS NOT NULL "      );
qrysb.append("          AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTOF_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (1,2,3,4)"      );
qrysb.append("         AND ed.ACT_YN       = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL "      );
qrysb.append("          AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPTOT_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN  ed.ACT_YN       = 'Y' and ed.edp_type in (1,3) "      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND nvl(bd.ACT_ID,0)      <> 11"      );
qrysb.append("         AND TRUNC(ado.online_subdt) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREON_EDP,"      );
qrysb.append("       0    AS PENPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREOF_EDP,"      );
qrysb.append("       0    AS PENPOSTOF_EDP"      );
qrysb.append("     FROM APP_DETAIL ado,"      );
qrysb.append("       BANK_DATAENTRY bd,"      );
qrysb.append("       edp_conduct_trans ed,"      );
qrysb.append("       m_district DM,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ado.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("     AND ado.APP_ID       = ed.APP_ID"      );
qrysb.append("     AND ado.UNIT_DIST_CD = DM.DISTRICT_CD"      );
qrysb.append("     AND DM.STATE_CD      = ms.STATE_CD"      );
qrysb.append("     AND ado.OFF_CD       = mom.OFF_CD"      );
qrysb.append("     AND ms.ZONE_CD       = ZM.ZONE_CD   "+txtSearch+"   "      );
qrysb.append("     group by "+qryGroup+" "      );

qrysb.append("     ) A  group by "+qryGroup1+"  "      );

out.print (qrysb.toString());*/

String PEND_VERY="";


qrysb.append("   SELECT  "+qryField1+" , ");
qrysb.append("     SUM(A.BANK_FORW)                     AS BANK_FORW,"      );
qrysb.append("     SUM(A.PREONSAN_EDP)                  AS PREONSAN_EDP,"      );
qrysb.append("     SUM(A.POSONSAN_EDP)                  AS POSONSAN_EDP,"      );
qrysb.append("     SUM(A.PREOFSAN_EDP)                  AS PREOFSAN_EDP,"      );
qrysb.append("     SUM(A.POSOFSAN_EDP)                  AS POSOFSAN_EDP,"      );
qrysb.append("     SUM(A.PREON_EDP)                     AS PREON_EDP,"      );
qrysb.append("     SUM(A.POSTON_EDP)                    AS POSTON_EDP,"      );
qrysb.append("     SUM(A.TOTON_EDP)                     AS TOTON_EDP,"      );
qrysb.append("     SUM(A.PREOF_EDP)                     AS PREOF_EDP,"      );
qrysb.append("     SUM(A.POSTOF_EDP)                    AS POSTOF_EDP,"      );
qrysb.append("     SUM(A.TOTOF_EDP)                     AS TOTOF_EDP,"      );
qrysb.append("     SUM(A.TOT_EDP)                       AS TOT_EDP,"      );
qrysb.append("     SUM(A.COMPREON_EDP)                  AS COMPREON_EDP,"      );
qrysb.append("     SUM(A.COMPOSTON_EDP)                 AS COMPOSTON_EDP,"      );
qrysb.append("     SUM(A.COMPREOF_EDP)                  AS COMPREOF_EDP,"      );
qrysb.append("     SUM(A.COMPOSTOF_EDP)                 AS COMPOSTOF_EDP,"      );
qrysb.append("     SUM(A.COMPTOT_EDP)                   AS COMPTOT_EDP,"      );
qrysb.append("     SUM(A.PENPREON_EDP)                  AS PENPREON_EDP,"      );
qrysb.append("     SUM(A.PENPOSTON_EDP)                 AS PENPOSTON_EDP,"      );
qrysb.append("     SUM(A.PENPREOF_EDP)                  AS PENPREOF_EDP,"      );
qrysb.append("     SUM(A.PENPOSTOF_EDP)                 AS PENPOSTOF_EDP,"      );
qrysb.append("     SUM(A.PENPREON_EDP + A.PENPREOF_EDP) AS TOT_PEN_EDP,"      );
qrysb.append("     SUM(A.PEND_VERY) AS PEND_VERY,MAX(ROWNUM) AS SRNO  "      );
qrysb.append("      FROM("      );
qrysb.append("     SELECT "+qryField+" , "      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.ACT_ID = 5"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_FORW,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE IN (1, 2)"      );
qrysb.append("         AND A.ACT_ID     = 11"      );
qrysb.append("         AND A.ACT_ID_1    = 5"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREONSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE IN (1, 2, 3, 4)"      );
qrysb.append("         AND A.ACT_ID     = 11"      );
qrysb.append("         AND A.ACT_ID_1    = 5"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSONSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE IN (3, 4)"      );
qrysb.append("         AND A.ACT_ID     = 11"      );
qrysb.append("         AND A.ACT_ID_1    = 5"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOFSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE = 4"      );
qrysb.append("         AND A.ACT_ID    = 11"      );
qrysb.append("         AND A.ACT_ID_1   = 5"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSOFSAN_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE = 1"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE = 2"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE IN (1, 2)"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE = 3"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE = 4"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE IN (3, 4)"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE IN (1, 2, 3, 4)"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOT_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE   IN (1)"      );
qrysb.append("         AND A.ACT_YN       = 'Y'"      );
qrysb.append("         AND A.EDP_CERT_DT IS NOT NULL  AND A.ACT_ID=11 AND A.OFF_CD IS NOT NULL "      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE   IN (2)"      );
qrysb.append("         AND A.ACT_YN       = 'Y'"      );
qrysb.append("         AND A.EDP_CERT_DT IS NOT NULL  AND A.ACT_ID=11 AND A.OFF_CD IS NOT NULL"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE   IN (3)"      );
qrysb.append("         AND A.ACT_YN       = 'Y'"      );
qrysb.append("         AND A.EDP_CERT_DT IS NOT NULL  AND A.ACT_ID=11 AND A.OFF_CD IS NOT NULL"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE   IN (4)"      );
qrysb.append("         AND A.ACT_YN       = 'Y'"      );
qrysb.append("         AND A.EDP_CERT_DT IS NOT NULL  AND A.ACT_ID=11 AND A.OFF_CD IS NOT NULL "      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_TYPE   IN (1, 2, 3, 4)"      );
qrysb.append("         AND A.ACT_YN       = 'Y'"      );
qrysb.append("         AND A.EDP_CERT_DT IS NOT NULL  AND A.ACT_ID=11 AND A.OFF_CD IS NOT NULL"      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPTOT_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.ACT_YN         = 'Y'"      );
qrysb.append("         AND A.EDP_TYPE       IN (1, 3)"      );
qrysb.append("         AND A.EDP_CERT_DT    IS NULL"      );
qrysb.append("         AND NVL(A.ACT_ID, 0) <> 11"      );
qrysb.append("         AND TRUNC(A.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREON_EDP,"      );
qrysb.append("       0    AS PENPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN A.EDP_CERT_DT IS NULL AND A.ACT_ID=11  "      );
qrysb.append("         AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREOF_EDP,"      );
qrysb.append("       0    AS PENPOSTOF_EDP,"      );
qrysb.append("              SUM(NVL("      );
qrysb.append("          CASE"      );
qrysb.append("            WHEN TRUNC(A.EDP_CERT_DT_B) IS NULL"      );
qrysb.append("            AND A.UPLOAD_YN            = 'Y' AND A.ACT_ID=11 "      );
qrysb.append("            AND TRUNC(A.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  "      );
qrysb.append("            THEN 1"      );
qrysb.append("            ELSE 0"      );
qrysb.append("          END, 0)) AS PEND_VERY"      );
qrysb.append("    FROM("      );
qrysb.append("   SELECT A.*,"      );
qrysb.append("   DECODE(b.DOC_NAME, NULL, 'N', 'Y') AS UPLOAD_YN"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT  /*+ PARALLEL(auto) */  bd.APP_ID,bd.OFF_CD,"      );
qrysb.append("     bd.LOAN_SANC_DT,"      );
qrysb.append("     bd.ACT_ID,"      );
qrysb.append("     ado.act_id as ACT_ID_1,"      );
qrysb.append("     ado.ONLINE_SUBDT,"      );
qrysb.append("     ed.EDP_CERT_DT,bd.EDP_CERT_DT as EDP_CERT_DT_B,"      );
qrysb.append("     DM.DISTRICT_NAME,"      );
qrysb.append("     ms.STATE_NM,"      );
qrysb.append("     ZM.ZONE_NM,"      );
qrysb.append("     mom.AGENCY_TYPE,"      );
qrysb.append("     ed.EDP_TYPE,"      );
qrysb.append("     ed.ACT_YN"      );
qrysb.append("     FROM APP_DETAIL ado,"      );
qrysb.append("       BANK_DATAENTRY bd,"      );
qrysb.append("       edp_conduct_trans ed,"      );
qrysb.append("       m_district DM,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ado.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("     AND ado.APP_ID       = ed.APP_ID"      );
qrysb.append("     AND ado.UNIT_DIST_CD = DM.DISTRICT_CD"      );
qrysb.append("     AND DM.STATE_CD      = ms.STATE_CD"      );
qrysb.append("     AND ado.OFF_CD       = mom.OFF_CD"      );
qrysb.append("     AND ms.ZONE_CD       = ZM.ZONE_CD "+txtSearch+" "      );
qrysb.append("     ) A,"      );
qrysb.append("     (SELECT   /*+ PARALLEL(auto) */ AUT.APP_ID,"      );
qrysb.append("       MAX(AUT.UP_ID)    AS UP_ID,"      );
qrysb.append("       MAX(AUT.DOC_NAME) AS DOC_NAME"      );
qrysb.append("     FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("     WHERE AUT.UPM_CD  = 8"      );
qrysb.append("     AND AUT.DOC_ACTYN = 'Y'"      );
qrysb.append("     GROUP BY AUT.APP_ID"      );
qrysb.append("     ) B"      );
qrysb.append("   WHERE A.APP_ID = B.APP_ID(+)"      );
qrysb.append("   )A GROUP BY "+qryGroup+""      );
qrysb.append("   )A GROUP BY "+qryGroup1+""      );
qrysb.append("   ORDER BY MAX(ROWNUM)  "      );
//out.print(qrysb.toString());

try{
ResultSet rsinst = db.execSQL(qrysb.toString());

String TOT_PEN_EDP="";
String COMPTOT_EDP="";

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
 out.print(offtl);
 %>
 </div>
 <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
   <thead>
     <tr>
       <th rowspan="4">Row ID</th>
       <th rowspan="4" > Name </th>
       <th colspan="2"  >Online EDP </th>
       <th rowspan="4" >Total </th>
       <th colspan="2" >Offline EDP </th>
       <th rowspan="4" >Total </th>
       <th rowspan="4" >Grand Total </th>
     ]
       <th colspan="5" rowspan="2" >Sanctioned By Bank </th>
       <th colspan="5">Completed EDP </th>
       <th colspan="3"> Pending EDP</th>
	    <th rowspan="4">Pending Verification</th>
       <th rowspan="4">Training Center Wise </th>
     </tr>
     <tr>
       <th rowspan="3"  >Pre</th>
       <th rowspan="3"  >Post</th>
       <th rowspan="3" >Pre</th>
       <th rowspan="3" >Post</th>
       <th colspan="2">Online</th>
       <th colspan="2">Offline</th>
       <th rowspan="3">Total</th>
       <th rowspan="3"  > 
         <p>Pre EDP </p>
         <p>(Before Sanction) </p>
       </th>
       <th rowspan="3"  >Loan Sanction Pending for EDP</th>
       <th rowspan="3"  >Total</th>
     </tr>
     <tr>
       <th colspan="2" >Online</th>
       <th >Offline</th>
       <th colspan="2" >Total</th>
       <th rowspan="2">Pre</th>
       <th rowspan="2">Post</th>
       <th rowspan="2">Pre</th>
       <th rowspan="2">Post</th>
      </tr>
     <tr>
       <th ></th>
       <th ></th>
       <th ></th>
       <th ></th>
       <th ></th>
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
	
zone_nm=rsinst.getString("zone_nm")==null?"":rsinst.getString("zone_nm");


TOT_PEN_EDP=rsinst.getString("TOT_PEN_EDP")==null?"":rsinst.getString("TOT_PEN_EDP");
COMPTOT_EDP=rsinst.getString("COMPTOT_EDP")==null?"":rsinst.getString("COMPTOT_EDP");

PREOF_EDP=rsinst.getString("PREOF_EDP")==null?"":rsinst.getString("PREOF_EDP");
PREON_EDP=rsinst.getString("PREON_EDP")==null?"":rsinst.getString("PREON_EDP");
PEND_VERY=rsinst.getString("PEND_VERY")==null?"":rsinst.getString("PEND_VERY");
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
       <th  colspan="28"><div align="center"></div>
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
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=1"><%=PREON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=2"> <%=POSTON_EDP  %></a> </td>
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=3"><%=TOTON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=4"> <%=PREOF_EDP  %></a> </td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=5"><%=POSTOF_EDP  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=6"> <%=TOTOF_EDP  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=7"><%=TOT_EDP  %></a></td>
      
       <td colspan="2"  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=17"><%=PREONSAN_EDP  %></a></td>
       <td colspan="2"  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=18"> <%=PREOFSAN_EDP  %></a></td>
       <td  ><%=POSONSAN_EDP  %></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=8"><%=COMPREON_EDP  %></a> </td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=9"><%=COMPOSTON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=10"><%=COMPREOF_EDP  %></a> </td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&amp;QRYCODE=11"><%=COMPOSTOF_EDP  %></a></td>
       <td ><%=COMPTOT_EDP  %></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=12"><%=PENPREON_EDP  %></a> </td>
       <!--<td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=13"><%=PENPOSTON_EDP  %></a></td>-->
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=14"><%=PENPREOF_EDP  %></a></td>
       <td ><%=TOT_PEN_EDP  %></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&REPNM=EDPBANKNOTVERIFY&QRYCODE=15"><%=PEND_VERY  %></a></td>
       <!--<td nowrap="nowrap"><a href="TrainingEdp.jsp<%=urlrep+p2+vnmdw+p1+firstcolold%>">view</a></td>-->
       <td nowrap="nowrap"><a href="edpOffTypeC.jsp<%=urlrep+p2+vnmdw+p1+firstcolold%>">view</a></td>
       <% } else{%>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=1&REPTP=4"><%=PREON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=2&REPTP=4"> <%=POSTON_EDP  %></a> </td>
       <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=3&REPTP=4"><%=TOTON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=4&REPTP=4"> <%=PREOF_EDP  %></a> </td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=5&REPTP=4"><%=POSTOF_EDP  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=6&REPTP=4"><%=TOTOF_EDP  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=7&REPTP=4"><%=TOT_EDP  %></a></td>
      
       <td colspan="2"  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=17&REPTP=4"><%=PREONSAN_EDP  %></a></td>
       <td colspan="2"  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=18&REPTP=4"><%=PREOFSAN_EDP  %></a></td>
	    <td  ><%=POSONSAN_EDP  %></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=8&REPTP=4"><%=COMPREON_EDP  %> </a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=9&REPTP=4"><%=COMPOSTON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=10&REPTP=4"><%=COMPREOF_EDP  %> </a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=11&REPTP=4"><%=COMPOSTOF_EDP  %></a></td>
	   <td ><%=COMPTOT_EDP  %></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=12&REPTP=4"><%=PENPREON_EDP  %></a> </td>
       <!--<td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=13&REPTP=4"><%=PENPOSTON_EDP  %></a></td>-->
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=14&REPTP=4"><%=PENPREOF_EDP  %> </a></td>
	   <td ><%=TOT_PEN_EDP  %></td>
      <td ><a href="<%=repnmE+urlrep+p3%>&REPNM=EDPBANKNOTVERIFY&QRYCODE=15&REPTP=4"><%=PEND_VERY  %></a></td>
       <td nowrap="nowrap"><% if (!vnmdw.equals("Total")){%>
           <a href="edpOffTypeC.jsp?<%=p3+vFurl%>&REPTP=3">view</a>
           <%}%></td>
       <%}%>
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
