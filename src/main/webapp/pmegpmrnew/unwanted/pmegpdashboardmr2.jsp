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
String repnm="pmegpdashboardmr2.jsp";
 urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt;
 
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
qrysb.append(" SELECT"+qryField+"  ");
qrysb.append(" ,COUNT(*) as TOTALDATAENTERED  ,");
qrysb.append("   SUM (CASE WHEN TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FromDt+"' and '"+ToDt+"' THEN"      );
qrysb.append("      1 ELSE 0 END)                AS APP_REC,"      );
qrysb.append("       SUM("      );
qrysb.append("       "      );
qrysb.append("       CASE WHEN TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("       AND AD.ACT_ID=3"      );
qrysb.append("       THEN"      );
qrysb.append("      1 ELSE 0 END ) AS agency_reject,"      );
qrysb.append("       SUM( CASE WHEN"      );
qrysb.append("       TRUNC(AD.BANK_F_DATE)  BETWEEN '"+FromDt+"' and '"+ToDt+"' AND ad.ACT_ID=5 THEN"      );
qrysb.append("       1 ELSE 0 END) AS bank_ford,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ad.ACT_ID = 5 AND  TRUNC(AD.BANK_F_DATE)  BETWEEN '"+FromDt+"' and '"+ToDt+"' "      );
qrysb.append("         THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("       END, 0)) AS bankfordmminv,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11 AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         AND ad.ACT_ID   = 5"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_sanc,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11"      );
qrysb.append("         AND ad.ACT_ID   = 5  AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("       END, 0)) AS bank_sanc_mm,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS mm_claim,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("       END, 0)) AS mm_claim_amt,"      );
qrysb.append("   SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_REL_DT IS NOT NULL AND TRUNC(bd.MM_REL_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         AND bd.ACT_ID     >= 11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A'"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS mm_rel,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_REL_DT IS NOT NULL AND TRUNC(bd.MM_REL_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         AND bd.ACT_ID     >= 11"      );
qrysb.append("         THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("       END, 0)) AS mm_rel_amt,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.EDP_CERT_DT IS NOT NULL AND TRUNC(bd.EDP_CERT_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         AND bd.ACT_ID        = 11"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS edp_cert_iss,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.EDP_CERT_DT IS NULL AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' "      );
qrysb.append("         AND bd.ACT_ID        = 11"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS edp_cert_iss_pending,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.PACT_ID = 30 AND  TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS REF_PEND_NO,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID = 3"      );
qrysb.append("         AND ad.ACT_ID  = 5 AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_reject,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) IN (0, 8)"      );
qrysb.append("         AND ad.ACT_ID  = 5 AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS pend_bank_sanc,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) IN (0, 8)"      );
qrysb.append("         AND ad.ACT_ID           = 5 AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"'"     );
qrysb.append("         THEN ROUND(NVL(mminvolve(ad.APP_ID), 0) / 100000, 2)"      );
qrysb.append("       END, 0)) AS pend_bank_sanc_mm,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT    > 0 AND TRUNC(bd.MM_CLAIM_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"'"     );
qrysb.append("         AND bd.LOAN_DOCFNAME   IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID          >= 11"      );
qrysb.append("         AND NVL(bd.PACT_ID, 0) <> 34"      );
qrysb.append("         THEN ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("       END, 0)) AS Pend_mmrel_amt,"      );
qrysb.append("     sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL and bd.act_id>=11 AND BD.MM_REL_DT IS NULL AND TRUNC(bd.MM_CLAIM_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as Pend_mmrel, ");
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0 AND TRUNC(bd.MM_CLAIM_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11  THEN 1    END, 0)) AS pv_no                      "      );
qrysb.append("   FROM app_detail_second ad, bank_dataentry_second bd, m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM ");
qrysb.append(" where ad.app_id=bd.app_id(+)  ");
qrysb.append(" and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd  ");
qrysb.append("  "+txtSearch+" ");
qrysb.append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by "+qryGroup+" )A ");

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
  <th colspan="2" >No of Applications at Agency </th>
 
  <th  rowspan="2" >No of Applications Forwarded to Bank </th>
  <th colspan="2" >Sanctioned by Bank </th>
 
  <th colspan="2" >MM Claimed </th>
  <th colspan="2" >MM Disbursement </th>
 
  <th  rowspan="2" >No of <br />
Applications Returned <br />
by Bank</th>
  <th colspan="2" >Pending at Bank </th>
  <th colspan="3" >Pending for MM Disbursement</th>
  <th rowspan="2" >Bank wise Detail view </th>
  <th rowspan="2" >District wise Detail view </th>
  <th rowspan="2" >TDR DETAIL </th>
</tr>
<tr>
<th  >Received</th>
<th >Returned</th>

<th >No of <br />
Prj.</th>
<th >MM Involve <br />
(In Lakh)</th>
<th >No of <br />
Prj.</th>
<th >MM<br />
(In Lakh)</th>
<th >No of <br />
Prj.</th>
<th  >MM<br />
(In Lakh)</th>
<th  >No of Prj.</th>
<th  >MM Involve<br />
(In Lakh)</th>
<th  >No of Prj Referred for Rectification </th>
<th  >Total </th>
<th  >MM<br />
(In Lakh)</th>
</tr>
<tr>
<th >(A)</th>
<th >(B)</th>
<th >(C)</th>
<th >(D)</th>
<th >(E)</th>
<th >(F)</th>
<th >(G)</th>

<th >(I)</th>
<th >(J)</th>
<th >(K)</th>
<th >(L)</th>

<th >(N)</th>
<th >(O)</th>
<th >(P)</th>
<th >(Q)</th>
<th >(R)</th>
<th >(S)</th>
<th >(T)</th>
<th >(U)</th>
<th >(V)</th>
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
 <th  colspan="24"><div align="center"></div>   <%=firstcolold%></span></th>
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
      <a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=0"%>">
      <% out.print(dfn.format(rsinst.getDouble("APP_REC")));%>
      </a></div></td>
<td><a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=20"%>">
  <% out.print(dfd.format(rsinst.getDouble("agency_reject")));%>
</a>  <div align="right">
  <a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=2"%>"></a>
  </div></td>



<td><div align="right">
<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=5"%>">

      <% out.print(dfd.format(rsinst.getDouble("bank_ford")));%>
 </a></div></td>
  <td>
    <div align="right">
	<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=6"%>">

      <% out.print(dfd.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%>
  </div></td>
<td><div align="right">
<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=11"%>">

  <% out.print(dfd.format(rsinst.getDouble("mm_claim")));%>
</a></div></td>
<td>
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_claim_amt")));%>
</div></td>
<td>
    <div align="right">
	<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=12"%>">

      <% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel_amt")));%>
  </div></td>

<td><div align="right">
<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=7"%>">
  <% out.print(dfd.format(rsinst.getDouble("bank_reject")));%>
</a></div></td>
<td><div align="right">
<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=38"%>">
  <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc")));%>
</a></div></td>
<td><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc_mm")));%>
</div></td>
<td><div align="right"><a href="dwstatewiseSec.jsp?<%=p3+"&amp;QRYCODE=40"%>">
  <% out.print(dfd.format(rsinst.getDouble("REF_PEND_NO")));%>
</a>
<a href="dwstatewiseSec.jsp?<%=p3+"&QRYCODE=16"%>"></a></div></td>
<td><div align="right"><a href="dwstatewiseSec.jsp?<%=p3+"&amp;QRYCODE=16"%>">
  <% out.print(dfd.format(rsinst.getDouble("Pend_mmrel")));%>
</a>
</div></td>
<td><% out.print(dfd.format(rsinst.getDouble("Pend_mmrel_amt")));%></td>
<th nowrap="nowrap"><a href="bankdw_pmegpSecond.jsp?<%=p3+vFurl%>">view</a></th>
<th nowrap="nowrap"><a href="bankdw_pmegpdistrictSecond.jsp?<%=p3+vFurl%>">view</a></th>
     <th nowrap="nowrap"><a href="bankWiseTdrUpdateSecopnd.jsp?<%=p3+vFurl%>">view</a></th>
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
