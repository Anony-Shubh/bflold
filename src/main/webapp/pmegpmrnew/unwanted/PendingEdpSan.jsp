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
String repnm="PendingEdpSan.jsp";
 urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt;
 String repnmE="PenEdpJasper.jsp";
 
 
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

String ReportDesc=" PMEGP e-Tracking "+ReportName+" Performance Report for the Period from "+FromDt +" to "+ToDt+" " ; 
 StringBuffer qrysb= new StringBuffer();
 
 
  

 
qrysb.append("SELECT A.* ");
qrysb.append(" FROM ( ");
qrysb.append(" SELECT "+qryField+"  ");
qrysb.append("    ,SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(BD.IST_LOAN_DT) IS NULL"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS SANC_PEND,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(BD.IST_LOAN_DT) IS NULL"      );
qrysb.append("         THEN ROUND(MM_AMT_BANKSANC(BD.APP_ID) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS SANC_PEND_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(BD.IST_LOAN_DT) IS NOT NULL"      );
qrysb.append("         AND BD.MM_CLAIM_DT         IS NULL"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS LOAN_PEND,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(BD.IST_LOAN_DT) IS NOT NULL"      );
qrysb.append("         AND BD.MM_CLAIM_DT         IS NULL"      );
qrysb.append("         THEN ROUND(MM_AMT_BANKSANC(BD.APP_ID) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS LOAN_PEND_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.MM_CLAIM_DT IS NOT NULL"      );
qrysb.append("         AND BD.MM_REL_DT    IS NULL"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) mm_CLAIM_PEND,"      );
qrysb.append("         SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.MM_CLAIM_DT IS NOT NULL"      );
qrysb.append("         AND BD.MM_REL_DT    IS NULL"      );
qrysb.append("         THEN ROUND(BD.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) mm_CLAIM_PEND_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.MM_REL_DT IS NOT NULL"      );
qrysb.append("         AND BD.PACT_ID     = 34"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END)     AS mm_rel,"      );
qrysb.append("        SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.MM_REL_DT IS NOT NULL"      );
qrysb.append("         AND BD.PACT_ID     = 34"      );
qrysb.append("         THEN ROUND(BD.MM_REL_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END)     AS mm_rel_MM,"      );
qrysb.append("       COUNT(*) AS TOT_SANC_PEN,"      );
qrysb.append("       SUM(ROUND(MM_AMT_BANKSANC(BD.APP_ID) / 100000, 2)) AS TOT_SANC_PEN_MM "      );

qrysb.append("   from APP_DETAIL AD,bank_dataentry BD,MAS_OFF_MAST MOM,M_DISTRICT DM,M_STATE MS,ZONE_MAST ZM"      );
qrysb.append("    where ad.app_id=bd.app_id(+) "      );
qrysb.append("    and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd "      );
qrysb.append("   and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd "      );
qrysb.append("   AND BD.act_id=11 and BD.edp_cert_dt is null AND BD.LOAN_SANC_DT IS NOT NULL AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' "      );
qrysb.append("  "+txtSearch+" ");
qrysb.append(" group by "+qryGroup+" )A ");

ResultSet rsinst = db.execSQL(qrysb.toString());

//out.print (qrysb.toString());

try{

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
  <th  rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th  rowspan="2" > Name</th>
  <th colspan="2" >Sanction Pending For Edp </th>
  <th colspan="2" >Loan Released Pending For EDP </th>
  <th colspan="2" >MM Claimed Pending For EDP </th>
  <th colspan="2" >MM Released Pending For EDP </th>
  <th colspan="2" >Total Sanction </th>

</tr>
<tr>
<th  >No of Prj </th>
<th >MM Involve <br />
(In Lakh)</th>
<th >No Of Prj </th>
<th >MM Involve <br />
(In Lakh)</th>
<th >No Of Prj </th>
<th >MM Involve <br />
(In Lakh)</th>
<th >No of <br />
Prj.</th>
<th >MM Involve <br />
(In Lakh)</th>
<th >No of <br />
Prj.</th>
<th >MM Involve <br />
(In Lakh)</th>

</tr>
<tr>
<th >
 (A) </th>
<th>(B)</th>
<th>
(C)</th>
<th colspan="2" >
(D)</th>
<th>
(E)</th>
<th>(F)</th>
<th>(G)</th>
<th>(H)</th>
<th>(I)</th>
<th>(J)</th>
<th>(K)</th>


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
<% if(!vfields.equals("3")){%>
<td><div align="right">
      <a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=1">
      <% out.print(dfn.format(rsinst.getDouble("SANC_PEND")));%>
      </a></div></td>
<td>
  <% out.print(dfd.format(rsinst.getDouble("SANC_PEND_MM")));%>
</td>
<td><div align="right">
<a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=2">
      <% out.print(dfd.format(rsinst.getDouble("LOAN_PEND")));%>
	  </a>
</div></td>
<td>
    <div align="right">

      <% out.print(dfd.format(rsinst.getDouble("LOAN_PEND_MM")));%>
</div></td>

<td><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=3">
  <% out.print(dfd.format(rsinst.getDouble("mm_CLAIM_PEND")));%>
</a></td>
<td><div align="right">


      <% out.print(dfd.format(rsinst.getDouble("mm_CLAIM_PEND_MM")));%>
</div></td>
  <td>
    <div align="right">
	<a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=4">

      <% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel_MM")));%>
  </div></td>
<td ><div align="center"><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=5">
    <% out.print(dfd.format(rsinst.getDouble("TOT_SANC_PEN")));%>
</a></div></td>
 <td>
    <div align="right">
	
      <% out.print(dfd.format(rsinst.getDouble("TOT_SANC_PEN_MM")));%>
    </div></td>

<%} else {%>
<td><div align="right">
     <a href="<%=repnmE+urlrep+p3%>&QRYCODE=1&REPTP=4">
      <% out.print(dfn.format(rsinst.getDouble("SANC_PEND")));%>
      </a></div></td>
<td>
  <% out.print(dfd.format(rsinst.getDouble("SANC_PEND_MM")));%>
</td>
<td><div align="right">
<a href="<%=repnmE+urlrep+p3%>&QRYCODE=2&REPTP=4">
      <% out.print(dfd.format(rsinst.getDouble("LOAN_PEND")));%>
	  </a>
</div></td>
<td><div align="right">
	

      <% out.print(dfd.format(rsinst.getDouble("LOAN_PEND_MM")));%>
</div></td>

<td><a href="<%=repnmE+urlrep+p3%>&QRYCODE=3&REPTP=4">
  <% out.print(dfd.format(rsinst.getDouble("mm_CLAIM_PEND")));%>
</a></td>
<td><div align="right">


      <% out.print(dfd.format(rsinst.getDouble("mm_CLAIM_PEND_MM")));%>
</div></td>
  <td>
    <div align="right">
	<a href="<%=repnmE+urlrep+p3%>&QRYCODE=4&REPTP=4">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel_MM")));%>
  </div></td>
<td ><div align="center"><a href="<%=repnmE+urlrep+p3%>&QRYCODE=5&REPTP=4">
    <% out.print(dfd.format(rsinst.getDouble("TOT_SANC_PEN")));%>
</a></div></td>
 <td>
    <div align="right">


      <% out.print(dfd.format(rsinst.getDouble("TOT_SANC_PEN_MM")));%>
</div></td>

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
