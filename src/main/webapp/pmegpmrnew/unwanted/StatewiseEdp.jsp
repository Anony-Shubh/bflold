<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<html>
<head>
<title>PMEGP Performance Report</title>
<script language="javascript" src="../js1/jquery-1.12.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/indexr.css">
<style type="text/css">
<!--
.style1 {color: #CC3333}
-->
</style>
</head>

<body>	

<form name="form1" method="post" action="">
<p>
  <%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";

String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;


String vAgencytit="";
String vsZonetit="";
String vsStatetit="";


txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"'";
//out.print(vsStatecd);

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

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String repnm="pmegpdashboardmr1.jsp";
// 
String vWherecls1="";
String flagC="Y";
String p1="";
String p2="";
String p3="";
String rowcol="";
int lrow=0;
String vnmdw="";
String ReportName="";
String qryField="";
String qryGroup="";
String urladd="";
String urlrep="";
String vWherecls2="";
String vtitle="";
urlrep ="edpOffDetail.jsp?TODT="+ToDt+"&FROMDT="+FromDt;
 

String ReportDesc="  " ; 
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

 StringBuffer qrysb= new StringBuffer();
 
 
/* qrysb.append("   SELECT   nvl(ms.state_nm,'Total') as state_nm,max(ms.state_cd) state_cd,"      );

qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=1 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS PREON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=2 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS POSTON_EDP,"      );
qrysb.append("      SUM(CASE WHEN ED.EDP_TYPE IN (1,2) AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS TOTON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=3 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS PREOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=4 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS POSTOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (3,4) AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS TOTOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (1,2,3,4) AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS TOT_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (1,2) AND ED.EDP_CERT_DT IS NOT NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS COMON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (3,4) AND ED.EDP_CERT_DT IS NOT NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS COMOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (1,2) AND ED.EDP_CERT_DT IS  NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS PENON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (3,4) AND ED.EDP_CERT_DT IS  NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS PENOF_EDP"      );
qrysb.append("   FROM app_detail_online ado,"      );
qrysb.append("     edp_conduct_trans ed,"      );
qrysb.append("     m_district md,"      );
qrysb.append("     m_state ms,"      );
qrysb.append("     mas_off_mast mom"      );
qrysb.append("   WHERE ado.APP_ID     = ed.APP_ID"      );
qrysb.append("   AND ado.UNIT_DIST_CD = md.DISTRICT_CD(+)"      );
qrysb.append("   AND md.STATE_CD      = ms.STATE_CD(+)"      );
qrysb.append("   AND ed.EDPOFF_CD     = mom.OFF_CD(+)"      );
qrysb.append("   AND (ed.ACT_YN       = 'Y')"      );
qrysb.append("   GROUP BY rollup(ms.state_nm)"      );
*/

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

qrysb.append("   SELECT"      );
qrysb.append("     A.zone_nm  AS zone_nm,"      );
qrysb.append("    nvl(A.off_name1,'Total')  AS off_name1,"      );
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
qrysb.append("     (SELECT MAX('ALL') AS zone_nm,"      );
qrysb.append("       mom.AGENCY_TYPE  AS off_name1,0 AS BANK_FORW,0 AS PREONSAN_EDP,0 AS POSONSAN_EDP,0 AS PREOFSAN_EDP,0 AS POSOFSAN_EDP,  "      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 1"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 2"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2)"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 3"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 4"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS POSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (3, 4)"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE IN (1, 2, 3, 4)"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOT_EDP,"      );
qrysb.append("      SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (1)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      ); 
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREON_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (2)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (3)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPREOF_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (4)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS COMPOSTOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (1)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREON_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (2)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (3)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (4)"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      ); 
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND ed.ACT_YN = 'Y' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPOSTOF_EDP"      );
qrysb.append("     FROM app_detail_online ado,"      );
qrysb.append("       edp_conduct_trans ed,"      );
qrysb.append("       m_district md,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       mas_off_mast mo,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ado.APP_ID     = ed.APP_ID"      );
qrysb.append("     AND ado.UNIT_DIST_CD = md.DISTRICT_CD(+)"      );
qrysb.append("     AND md.STATE_CD      = ms.STATE_CD(+)"      );
qrysb.append("     AND ed.EDPOFF_CD     = mom.OFF_CD(+)"      );
qrysb.append("     AND ado.APP_ID NOT IN (SELECT APP_ID FROM APP_DETAIL WHERE ACT_ID > =0 AND APP_ID=ado.APP_ID)"      );
qrysb.append("     and ado.act_id=-1"      );
qrysb.append("     AND ado.OFF_CD       = mo.OFF_CD(+)"      );
qrysb.append("     AND ms.ZONE_CD       = ZM.ZONE_CD"      );

qrysb.append("     AND ed.ACT_YN = 'Y'"      );
qrysb.append("     GROUP BY ROLLUP(mom.AGENCY_TYPE)"      );
qrysb.append("     UNION ALL"      );
qrysb.append("     SELECT MAX('ALL') AS zone_nm,"      );
qrysb.append("       mom.AGENCY_TYPE AS off_name1,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(ado.BANK_F_DATE) BETWEEN  '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         AND ado.ACT_ID = 5"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_FORW,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE = 1 AND bd.act_id=11 and ado.act_id=5 AND ed.ACT_YN = 'Y'"      );
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
qrysb.append("         WHEN ed.EDP_TYPE =3  AND bd.act_id=11 and ado.act_id=5 AND ed.ACT_YN = 'Y'"      );
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
qrysb.append("         WHEN ed.EDP_TYPE   IN (1) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREON_EDP,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (2) AND ed.ACT_YN = 'Y'"      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPOSTON_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (3) AND ed.ACT_YN = 'Y' "      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPREOF_EDP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ed.EDP_TYPE   IN (4) AND ed.ACT_YN = 'Y' "      );
qrysb.append("         AND ed.EDP_CERT_DT IS NULL"      );
qrysb.append("         AND TRUNC(ed.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PENPOSTOF_EDP"      );
qrysb.append("     FROM APP_DETAIL ado,"      );
qrysb.append("       BANK_DATAENTRY bd,"      );
qrysb.append("       edp_conduct_trans ed,"      );
qrysb.append("       m_district md,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       mas_off_mast mom,"      );

qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ado.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("     AND ado.APP_ID       = ed.APP_ID (+)"      );
qrysb.append("     AND ado.UNIT_DIST_CD = md.DISTRICT_CD(+)"      );
qrysb.append("     AND md.STATE_CD      = ms.STATE_CD(+)"      );
//qrysb.append("     AND ed.EDPOFF_CD     = mom.OFF_CD(+)"      );
qrysb.append("     AND ado.OFF_CD       = moM.OFF_CD(+)"      );
qrysb.append("     AND ms.ZONE_CD       = ZM.ZONE_CD"      );

//qrysb.append("     AND ed.ACT_YN = 'Y' "      );
qrysb.append("     GROUP BY ROLLUP(mom.AGENCY_TYPE)"      );
qrysb.append("     ) A group by zone_nm,off_name1"      );
qrysb.append("     order by off_name1"      );


//ResultSet rsinst = db.execSQL(qrysb.toString());
//out.print (qrysb.toString());


//out.print(qrysb.toString());

String ZONE_NM="";
String OFF_NM = "";
String NO_OF_INSTN = "";
String STATE_CD ="";
String off_cd="";





ResultSet rsMain = db.execSQL(qrysb.toString());
%>

 <table align="center">
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">EDP Registered by PMEGP Applicant </div></td>
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
  <th rowspan="4" >Forwarded To Bank </th>
  <th colspan="4" rowspan="2" >Sanctioned By Bank </th>
  <th colspan="4">Completed EDP </th>
  <th colspan="4">Pending EDP </th>
</tr>
<tr>
  <th rowspan="3"  >Pre</th>
  <th rowspan="3"  >Post</th>
  <th rowspan="3" >Pre</th>
  <th rowspan="3" >Post</th>
  <th colspan="2">Online</th>
  <th colspan="2">Offline</th>
  <th colspan="2"  >Online</th>
  <th colspan="2"  >offline</th>
</tr>
<tr>
  <th colspan="2" >Online</th>
  <th colspan="2" >Offline</th>
  <th rowspan="2">Pre</th>
  <th rowspan="2">Post</th>
  <th rowspan="2">Pre</th>
  <th rowspan="2">Post</th>
  <th rowspan="2"  >Pre</th>
  <th rowspan="2"  >Post</th>
  <th rowspan="2"  >Pre</th>
  <th rowspan="2"  >Post</th>
</tr>
<tr>
  <th >Pre</th>
  <th >Post</th>
  <th >Pre</th>
  <th >Post</th>
</tr>
</thead>
<tbody>
	<%	
	int srno=0;	
	

	  while (rsMain.next()) { 	
	 
	  

	//zone_nm=  
		//STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
	
zone_nm=rsMain.getString("zone_nm")==null?"":rsMain.getString("zone_nm");
off_name1=rsMain.getString("off_name1")==null?"":rsMain.getString("off_name1");
//PENOF_EDP=rsMain.getString("PENOF_EDP")==null?"":rsMain.getString("PENOF_EDP");
//PENON_EDP=rsMain.getString("PENON_EDP")==null?"":rsMain.getString("PENON_EDP");
//COMOF_EDP=rsMain.getString("COMOF_EDP")==null?"":rsMain.getString("COMOF_EDP");
PREOF_EDP=rsMain.getString("PREOF_EDP")==null?"":rsMain.getString("PREOF_EDP");
PREON_EDP=rsMain.getString("PREON_EDP")==null?"":rsMain.getString("PREON_EDP");
//COMON_EDP=rsMain.getString("COMON_EDP")==null?"":rsMain.getString("COMON_EDP");
POSTOF_EDP=rsMain.getString("POSTOF_EDP")==null?"":rsMain.getString("POSTOF_EDP");
POSTON_EDP=rsMain.getString("POSTON_EDP")==null?"":rsMain.getString("POSTON_EDP");
TOTOF_EDP=rsMain.getString("TOTOF_EDP")==null?"":rsMain.getString("TOTOF_EDP");
TOTON_EDP=rsMain.getString("TOTON_EDP")==null?"":rsMain.getString("TOTON_EDP");
TOT_EDP=rsMain.getString("TOT_EDP")==null?"":rsMain.getString("TOT_EDP");
BANK_FORW=rsMain.getString("BANK_FORW")==null?"":rsMain.getString("BANK_FORW");
PREONSAN_EDP=rsMain.getString("PREONSAN_EDP")==null?"":rsMain.getString("PREONSAN_EDP");
POSONSAN_EDP=rsMain.getString("POSONSAN_EDP")==null?"":rsMain.getString("POSONSAN_EDP");
PREOFSAN_EDP=rsMain.getString("PREOFSAN_EDP")==null?"":rsMain.getString("PREOFSAN_EDP");
POSOFSAN_EDP=rsMain.getString("POSOFSAN_EDP")==null?"":rsMain.getString("POSOFSAN_EDP");

COMPREON_EDP=rsMain.getString("COMPREON_EDP")==null?"":rsMain.getString("COMPREON_EDP");
COMPOSTON_EDP=rsMain.getString("COMPOSTON_EDP")==null?"":rsMain.getString("COMPOSTON_EDP");
COMPREOF_EDP=rsMain.getString("COMPREOF_EDP")==null?"":rsMain.getString("COMPREOF_EDP");
COMPOSTOF_EDP=rsMain.getString("COMPOSTOF_EDP")==null?"":rsMain.getString("COMPOSTOF_EDP");



PENPREON_EDP=rsMain.getString("PENPREON_EDP")==null?"":rsMain.getString("PENPREON_EDP");
PENPOSTON_EDP=rsMain.getString("PENPOSTON_EDP")==null?"":rsMain.getString("PENPOSTON_EDP");
PENPREOF_EDP=rsMain.getString("PENPREOF_EDP")==null?"":rsMain.getString("PENPREOF_EDP");
PENPOSTOF_EDP=rsMain.getString("PENPOSTOF_EDP")==null?"":rsMain.getString("PENPOSTOF_EDP");


srno=srno+1;	
%>	



 


<tr>
 <td><div align="center"><%= srno 	 %></div></td>
 <td><div align="center"><a href="<%=urlrep%>&state=<%=STATE_CD%>"><%=off_name1  %>	</div></td>
<td ><%=PREON_EDP  %></td>
<td >	<%=POSTON_EDP  %>	</td>
<td  ><%=TOTON_EDP  %></td>
<td >	<%=PREOF_EDP  %>	</td>
<td ><%=POSTOF_EDP  %></td>
<td  >	<%=TOTOF_EDP  %>	</td>
<td  ><%=TOT_EDP  %></td>
<td  ><%=BANK_FORW  %></td>
<td  ><%=PREONSAN_EDP  %></td>
<td  ><%=POSONSAN_EDP  %></td>
<td  ><%=PREOFSAN_EDP  %></td>
<td  ><%=POSOFSAN_EDP  %></td>
<td >	<%=COMPREON_EDP  %>	</td>
<td ><%=COMPOSTON_EDP  %></td>
<td >	<%=COMPREOF_EDP  %>	</td>
<td ><%=COMPOSTOF_EDP  %></td>
<td >	<%=PENPREON_EDP  %>	</td>
<td ><%=PENPOSTON_EDP  %></td>
<td >	<%=PENPREOF_EDP  %>	</td>
<td ><%=PENPOSTOF_EDP  %></td>
<%
 } //end of while
 rsMain.close();
 db.close();
 
 %>	
 </tbody>
</table>

 

</form>


</body>
</html>
