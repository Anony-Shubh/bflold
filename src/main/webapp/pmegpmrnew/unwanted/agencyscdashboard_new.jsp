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
String qryGroup="";
String urladd="";
String urlrep="";
String repnm="agencyscdashboard_new.jsp";
urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt;
//urlrep ="?";
 txtSearch=txtSearch+" AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"' AND MOM.OFF_NAME1 LIKE '"+vOffice+"' ";



if (vfields.equals("0")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" MAX('ALL') as zone_nm , MOM.AGENCY_TYPE  as off_name1 ";
urladd="&AGENCY=";

if (vAgencytit.equals("ALL") ) {
qryGroup=" ROLLUP(MOM.AGENCY_TYPE) ORDER BY MOM.AGENCY_TYPE ";
}else{
qryGroup=" MOM.AGENCY_TYPE ORDER BY MOM.AGENCY_TYPE ";
}
urlrep=urlrep+"&REPTP=1";
p1="&ZONECD=";
p2="&AGENCY=";
}

if (vfields.equals("1")){
ReportName="Agency Wise and  KVIC Zone wise";
qryField=" ZM.zone_nm as zone_nm , MOM.AGENCY_TYPE  as off_name1 ";
urladd="&ZONECD=";
if (vAgencytit.equals("ALL") && vsZonetit.equals("ALL")) {
qryGroup=" ROLLUP(ZM.zone_nm,MOM.AGENCY_TYPE) ORDER BY ZM.zone_nm,MOM.AGENCY_TYPE ";
}else if( !vAgencytit.equals("ALL") && vsZonetit.equals("ALL") ){
qryGroup=" MOM.AGENCY_TYPE,ROLLUP(ZM.zone_nm) ORDER BY ZM.zone_nm,MOM.AGENCY_TYPE ";
}else if( vAgencytit.equals("ALL") && !vsZonetit.equals("ALL") ){
qryGroup=" ZM.zone_nm,ROLLUP(MOM.AGENCY_TYPE) ORDER BY ZM.zone_nm,MOM.AGENCY_TYPE ";
}else{
qryGroup=" ZM.zone_nm,MOM.AGENCY_TYPE ORDER BY ZM.zone_nm,MOM.AGENCY_TYPE ";
}

urlrep=urlrep+"&REPTP=2";
p1="&ZONECD=";
p2="&AGENCY=";
}else if (vfields.equals("2")){
ReportName="Zone and State Wise ";
qryField=" ZM.zone_nm as zone_nm , MS.STATE_NM as off_name1 ";

if (vAgency.equals("KVIC")){
urlrep=urlrep+"&REPTP=4&AGENCY=KVIC";
}else{
urlrep=urlrep+"&REPTP=3&AGENCY="+vAgency;
}

p1="&ZONECD=";
p2="&STATECD=";

if (vsStatetit.equals("ALL") && vsZonetit.equals("ALL")) {
qryGroup=" ROLLUP(ZM.zone_nm,MS.STATE_NM) ORDER BY ZM.zone_nm,MS.STATE_NM ";
}else if (!vsStatetit.equals("ALL") && vsZonetit.equals("ALL"))  {
qryGroup=" ROLLUP(ZM.zone_nm),MS.STATE_NM ORDER BY ZM.zone_nm,MS.STATE_NM ";
}else if (vsStatetit.equals("ALL") && !vsZonetit.equals("ALL"))  {
qryGroup=" ZM.zone_nm,ROLLUP(MS.STATE_NM) ORDER BY ZM.zone_nm,MS.STATE_NM ";
}else{
qryGroup=" ZM.zone_nm,MS.STATE_NM ORDER BY ZM.zone_nm,MS.STATE_NM ";
}

}else if (vfields.equals("3")){
ReportName="State and District Wise ";
qryField=" MS.STATE_NM as zone_nm ,DM.district_name as off_name1 ";

if (vsStatetit.equals("ALL")) {
qryGroup=" ROLLUP(MS.STATE_NM,DM.district_name) ORDER BY MS.STATE_NM,DM.district_name ";
}else {
qryGroup=" MS.STATE_NM,ROLLUP(DM.district_name) ORDER BY MS.STATE_NM,DM.district_name ";
}

}//end of else

if (vfields.equals("4")){
ReportName="KVIC Zonewise and officewise ";
qryField=" ZM.zone_nm as zone_nm ,MOM.OFF_NAME1 as off_name1 ";

if (vsStatetit.equals("ALL")) {
qryGroup=" ROLLUP(ZM.zone_nm ,MOM.OFF_NAME1) ORDER BY ZM.zone_nm ,MOM.OFF_NAME1 ";
}else {
qryGroup=" ZM.zone_nm,ROLLUP(MOM.OFF_NAME1) ORDER BY ZM.zone_nm  ,MOM.OFF_NAME1 ";
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

String ReportDesc=" PMEGP e-Tracking "+ReportName+" Performance Report for the Period " ; 
 StringBuffer qrysb= new StringBuffer();
 
 
  

 
qrysb.append("   SELECT A.* , PREVYRPENDING+CURYRPENDING AS TOTALPENDING "      );
qrysb.append("    FROM ("      );
qrysb.append("      SELECT"+qryField+""      );
qrysb.append("      ,SUM(CASE WHEN ACT_ID IN (0,1,2) AND "      );
qrysb.append("      TRUNC(ONLINE_SUBDT) <'01-APR-2020' "      );
qrysb.append("      THEN 1 END) AS PREVYRPENDING,"      );
qrysb.append("      SUM(CASE WHEN  "      );
qrysb.append("      TRUNC(ONLINE_SUBDT) >='01-APR-2020' "      );
qrysb.append("      THEN 1 END) AS CURYRPENDING,"      );
qrysb.append("      COUNT(PSC.APP_ID) AS SCORECARDFILLUP,"      );
qrysb.append("      SUM(CASE WHEN PSC.HO_VERIFY_YN='Y' THEN 1 END) AS AGENCY_VERIFY,"      );
qrysb.append("      SUM(CASE WHEN PSC.TOTAL_SCORE>=60 AND PSC.HO_VERIFY_YN='Y'  THEN 1 END) VAR_SCORE_60PER,"      );
qrysb.append("      SUM(CASE WHEN PSC.TOTAL_SCORE>=60 AND PSC.HO_VERIFY_YN='Y' AND ACT_ID=5 THEN 1 END) SIXTYPER_FORD,"      );
qrysb.append("      SUM(CASE WHEN PSC.TOTAL_SCORE>=60 AND PSC.HO_VERIFY_YN='Y' AND ACT_ID<> 5 THEN 1 END) PENDING_TO_FORWAD"      );
qrysb.append("      FROM APP_DETAIL AD,PMEGP_SCORE_CARD PSC,"      );
qrysb.append("      m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM "      );
qrysb.append("      WHERE AD.APP_ID=PSC.APP_ID(+)"      );
qrysb.append("      AND ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd "      );
qrysb.append("       and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd "      );
qrysb.append("       "+txtSearch+" "      );
qrysb.append("       GROUP BY "+qryGroup+"  )A "      );


//out.print (qrysb.toString());

try{
ResultSet rsinst = db.execSQL(qrysb.toString());

%>


 <table align="center">
<tr>
<th colspan="7">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="7"><div align="center">PMEGP Portal Agency Score Card Report </div></td>
</tr>
<tr>
<th>Agency</th>
<td><%=vAgencytit  %></td>
<th>KVIC Zone</th>
<td><%=vsZonetit  %></td>
<th>State</th>
<td><%= vsStatetit %></td>
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
  <th  rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th  rowspan="2" > Name</th>
  <th colspan="3" >Pending with Agency </th>
  <th rowspan="2" >Score Card Filled by Applicant</th>
  <th colspan="3" >Score Card Validated by Implementing Agency </th>
  <th rowspan="2" >Pending to Forwarded to Bank by IA </th>
  <th rowspan="2" >Bank wise Detail view</th>
  <th rowspan="2" >District wise Detail view</th>
  </tr>
<tr>
<th  >Previous Year </th>
<th >Current Year </th>
<th >Total Pending </th>
<th >Total Score Card Verified </th>
<th >60 percent above </th>
<th >Forwarded to Bank </th>
</tr>
<tr>
<th >A</th>
<th>B</th>
<th>C</th>
<th >D</th>
<th >E=C+D</th>
<th> F</th>
<th>G</th>
<th>H</th>
<th>I</th>
<th>J=H-I</th>
<th>K</th>
<th>L</th>
</tr>
</thead>
 <%
 String Head="";
 String firstcolnew="";
 String firstcolold="";
 String flag="Y";
 
double vPREVYRPENDING=0.00;
double vCURYRPENDING=0.00;
double vTOTALPENDING=0.00;
double vSCORECARDFILLUP=0.00;
double vAGENCY_VERIFY=0.00;
double vVAR_SCORE_60PER=0.00;
double vSIXTYPER_FORD=0.00;
double vPENDING_TO_FORWAD=0.00;

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
 %>
<% if (flag.equals("Y")){%>
<tbody>
 <tr>
 <th  colspan="26"><div align="center"></div>   <%=firstcolold%></span></th>
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
out.print(vnmdw);
}else{
p3=vFurl+p2+vnmdw+p1+firstcolold;
%>
<a href="<%=repnm+urlrep+p2+vnmdw+p1+firstcolold%>"><%=vnmdw  %></a>
<%}%></th>

<td><div align="right">
      <a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=1"%>">
      <% out.print(dfn.format(rsinst.getDouble("PREVYRPENDING")));%>
      </a></div></td>
<td><a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=2"%>">
  <% out.print(dfd.format(rsinst.getDouble("CURYRPENDING")));%>
</a></td>
<td><div align="right">
<a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=3"%>">
      <% out.print(dfd.format(rsinst.getDouble("TOTALPENDING")));%>
	  </a>
</div></td>
<td>
    <div align="right">
	<a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=4"%>">

      <% out.print(dfd.format(rsinst.getDouble("SCORECARDFILLUP")));%>
</a></div></td>

<td><a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=5"%>">
  <% out.print(dfd.format(rsinst.getDouble("AGENCY_VERIFY")));%>
</a></td>
<td><div align="right"> <a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=6"%>">
      <% out.print(dfd.format(rsinst.getDouble("VAR_SCORE_60PER")));%>
  </a></div></td>
  <td><div align="right"> <a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=7"%>">
      <% out.print(dfd.format(rsinst.getDouble("SIXTYPER_FORD")));%>
  </a></div></td>
  <td><div align="right"><a href="../jasperrop/AgencySCGenerateXLS.jsp?<%=p3+"&QRYCODE=8"%>">
    <% out.print(dfd.format(rsinst.getDouble("PENDING_TO_FORWAD")));%>
  </a></div></td>
  <td><a href="bankdw_pmegp_scorecard.jsp?<%=p3+vFurl%>">view</a></td>
  <td><a href="bankdw_pmegpdistrict_scorecard.jsp?<%=p3+vFurl%>">view</a></td>
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
