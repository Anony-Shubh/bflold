<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon" %>
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";

String p1="";
String p2="";
String rowcol="";

String vUsrnm= (String) session.getAttribute("suser_detail");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;


String vAgencytit="";
String vsZonetit="";
String vsStatetit="";

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String vAgency=request.getParameter("AGENCY")==null?"%%":(String) request.getParameter("AGENCY");
vAgency=vAgency.trim();
String vfields =request.getParameter("REPTP")==null?"0":(String) request.getParameter("REPTP");
vfields=vfields.trim();
String vZonecd =request.getParameter("ZONECD")==null?"%%":(String) request.getParameter("ZONECD");
vZonecd=vZonecd.trim();
String vStatecd =request.getParameter("STATECD")==null?"%%":(String) request.getParameter("STATECD");
vStatecd=vStatecd.trim();


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
String qryGroup="";
String urladd="";

String urlrep="";
 String repnm="pmegpdashboardmr1.jsp";
 urlrep =repnm+"?TODT="+ToDt+"&FROMDT="+FromDt;
 txtSearch=txtSearch+" AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"'";



if (vfields.equals("0")){
ReportName="Agency Wise";
qryField=" max(ALL) as zone_nm , MOM.AGENCY_TYPE  as off_name1 ";
qryGroup=" ROLLUP(MOM.AGENCY_TYPE) ORDER BY MOM.AGENCY_TYPE ";
}

if (vfields.equals("1")){
ReportName="Zone Wise";
qryField=" ZM.zone_nm as zone_nm , MOM.AGENCY_TYPE  as off_name1 ";
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE ORDER BY ZM.zone_nm,MOM.AGENCY_TYPE ";
}


if (vfields.equals("2")){
ReportName="State Wise ";
qryField=" ZM.zone_nm as zone_nm , MS.STATE_NM as off_name1 ";
qryGroup=" ZM.zone_nm,MS.STATE_NM ORDER BY ZM.zone_nm,MS.STATE_NM ";
}

if (vfields.equals("3")){
ReportName="Officewise ";
qryField=" ZM.zone_nm as zone_nm , MOM.OFF_NAME as off_name1 ";
qryGroup=" ZM.zone_nm, MOM.OFF_NAME ORDER BY ZM.zone_nm,MS.STATE_NM ";
}

if (vfields.equals("4")){
ReportName="District wise";
qryField=" MS.STATE_NM as zone_nm ,DM.district_name as off_name1 ";
qryGroup=" MS.STATE_NM,DM.district_name ORDER BY MS.STATE_NM,DM.district_name ";
}

%>

</html>
