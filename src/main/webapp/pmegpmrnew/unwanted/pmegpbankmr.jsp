<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon" %>
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";
String flagC="Y";
String p1="";
String p2="";
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
vAgency=vAgency.trim();
String vfields =request.getParameter("REPTP")==null?"0":(String) request.getParameter("REPTP");



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
// String repnm="pmegpdashboardmr1.jsp";
 urlrep ="pmegpdashboardmr1.jsp?TODT="+ToDt+"&FROMDT="+FromDt;
 
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



String rsStmt= "select " +qryField+ " FROM  m_district dm, mas_off_mast mom,m_state ms, " ;
rsStmt=rsStmt+ " ZONE_MAST ZM where mom.district_cd=dm.district_cd and " ;
rsStmt=rsStmt+ " dm.state_cd=ms.state_cd   and  MS.zone_cd=ZM.zone_cd  " +txtSearch;
rsStmt=rsStmt+ " group by " +qryGroup;


	ResultSet rs = db.execSQL(rsStmt);
	int rowno=0;
	while (rs.next()) {
	rowno=rowno+1;
	}
	
		rs.close();
		out.print (rowno);
		
		if (rowno==1 && !vfields.equals("0") ) {
		flagC ="N";
		response.sendRedirect(urlrep+"&REPTP=3");
		}

if (flagC.equals("Y") ){

String ReportDesc=" PMEGP e-Tracking "+ReportName+" Performance Report for the Period from "+FromDt +" to "+ToDt+" " ; 
 StringBuffer sb= new StringBuffer();
 sb.append("SELECT A.*, ").
 append("NVL((CASE WHEN MM_REL>0 THEN").
append(" ROUND(MM_REL_AMT/MM_REL,2) END),0) AS AVG_MM,").
 append("NVL((CASE WHEN TOT_PROJ>0 THEN").
append(" ROUND(TOT_PROJ/BANK_SANC,2) END),0) AS AVG_PROJ").
append(" FROM (").
append(" SELECT"+qryField+"").
 append(" ,COUNT(*) as TOTALDATAENTERED").
append(" ,sum( nvl(case when ad.app_rec_date between '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as APP_REC ").
 append(" ,sum( nvl(case when amm.mt_date between '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as dtfc_place ").
append(" ,sum( nvl(case when amm.mt_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id<>7 then 1 end ,0)) as dtfc_sanction ").
append(" ,sum( nvl(case when ad.bank_f_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=5 then 1 end ,0)) as bank_ford ").
append(" ,sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=5 then round(mminvolve(bd.app_id)/100000,2) end ,0)) as bankfordmminv").
append(",sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as bank_sanc").
append(" ,sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then round(bd.elig_mm/100000,2) end ,0)) as bank_sanc_mm").
append(",sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as mm_rel ").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt ").
append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then ad.emp_env end ,0)) as emp "). 
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and (upper(aD.gender))='FEMALE' then 1 end ,0)) as mm_rel_wo ").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and (upper(aD.gender))='FEMALE' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_wo").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd IN ('HA','ST') then 1 end ,0)) as mm_rel_ST ").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd IN ('HA','ST') then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_ST "). 
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd ='SC' then 1 end ,0)) as mm_rel_sc ").
append(",sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd ='SC' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_sc ").
 append(" ,sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then (NVL(BD.workshed_cost,0)+NVL(BD.working_capital,0)+NVL(BD.machinary_cost,0)+NVL(BD.machinary_cost,0))/100000 end ,0)) as TOT_PROJ").
 append(",sum( nvl(case when bd.edp_cert_iss_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as edp_cert_iss").
 append(",sum( nvl(case when bd.bank_rec_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=3 then 1 end ,0)) as bank_reject ").
append(" FROM app_detail ad, bank_detail bd, m_district dm, mas_off_mast mom,m_state ms,app_meeting_mast amm,ZONE_MAST ZM ").
append(" where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd and ad.mtg_id=amm.mtg_id(+)").
append(" AND AD.BANK_NAME IS NOT NULL  "+txtSearch+" ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by "+qryGroup+" )A ");
out.print(sb.toString());
%>
<%
ResultSet rsinst = db.execSQL(sb.toString());
try{
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Performance Report</title>
	<link rel="stylesheet" type="text/css" href="css/indexr.css">
</head>
<body>
<form method="post" >
<%@ include file="includeRepMenu.jsp" %> 
 <table align="center">
<tr>
<th colspan="8">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="8"><div align="center">PMEGP e-Traking Performance Report for Bank User </div></td>
</tr>
<tr>
<th>Bank Name </th>
<td><%=vAgencytit  %></td>
<td>&nbsp;</td>
<th>&nbsp;</th>
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
 <table align="center">
<thead>
<tr>
  <th width="26" rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th width="37" rowspan="2" > Name</th>
  <th colspan="3" >No of Applications </th>
  <th colspan="2" >Fordwarded to Bank </th>
  <th colspan="2" >Sanctioned by Bank </th>
  <th colspan="2" >Margin Money Claimed </th>
  <th colspan="3" >Disbursement Made by <br />
Nodal Branches</th>
  <th width="90" rowspan="2" >EDP Trg. given</th>
  <th width="80" colspan="2" >No of <br />
Applications Rejected<br />
by Bank</th>
  <th colspan="2" >Pending for Sanction</th>
  <th colspan="2" >Pending for MM Disbursement </th>
  <th width="80" rowspan="2" >Physical Verification (In N0)</th>
  </tr>
<tr>
<th width="59" >Received</th>
<th width="47" > Placed <br />
Before <br />
DLTFC</th>
<th width="56" >Recom-<br />
mended <br />
by DLTFC</th>
<th width="37" ><br /> 
  No of Prj.
</th>
<th width="50" >MM Involve<br /> 
  (In Lakh) </th>
<th width="23" >No of <br />
Prj.</th>
<th width="54" >MM Involve <br />
(In Lakh)</th>
<th width="26" >No of <br />
Prj.</th>
<th width="27" >MM<br />
(In Lakh)</th>
<th width="55" >No of <br />
Prj.</th>
<th width="37" >MM<br />
(In Lakh)</th>
<th width="32" >Emp.<br />
(in No)</th>
<th ><br />
  No of Prj. </th>
<th >MM Involve<br />
  (In Lakh) </th>
<th width="80" >No of Prj.</th>
<th width="80" >MM Involve<br />
(In Lakh)</th>
<th width="80" >No of Prj. </th>
<th width="80" >MM<br />
(In Lakh)</th>
</tr>
<tr>
<th >
 (A)
 </th>
<th>(B)</th>
<th>
(C)
</th>
<th >
(D)
</th>
<th>
(E)
</th>
<th>(F)</th>
<th>(G)</th>
<th>(H)</th>
<th>(I)</th>
<th>&nbsp;</th>
<th>&nbsp;</th>
<th>(J)</th>
<th>(K)</th>
<th>(L)</th>
<th>&nbsp;</th>
<th colspan="2">&nbsp;</th>
<th>&nbsp;</th>
<th>&nbsp;</th>
<th>&nbsp;</th>
<th>&nbsp;</th>
<th>&nbsp;</th>
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
 <th  colspan="22"><div align="center"></div>   <%=firstcolold%></span></th>
 </tr>
	 <%}%>
	 
     <tr>
	 
<td><div align="center"><%=srn%>)</div></td>
<%
vnmdw=rsinst.getString("off_name1");
vnmdw=rsinst.getString("off_name1")==null?"Total":rsinst.getString("off_name1");
if (vfields.equals("3")) {
%>
<td ><div align="left"><%=vnmdw  %></div></td>
<%}else{%>
<th ><div align="left"><a href="<%=urlrep+p2+vnmdw+p1+firstcolold%>"><%=vnmdw  %></a></div></th>
<%}%>
<td><div align="right"><% out.print(dfn.format(rsinst.getDouble("APP_REC")));%></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%></div></td>
<td colspan="2"><div align="right"></div></td>
<td><div align="right">-</div></td>
<td><div align="right">-</div></td>
<td colspan="2">&nbsp;</td>
<td><div align="right">-</div></td>
<td><div align="right">-</div></td>
<td>-</td>
<td>-</td>
<td colspan="2">&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td width="22"><div align="right">-</div></td>
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
</form>
</body>
</html>
