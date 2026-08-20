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
String Statep=request.getParameter("State")==null?"%%":(String) request.getParameter("State");
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
String repnm="pmegpdashboardmr1.jsp";
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
 
 
  

 
qrysb.append("   SELECT nvl(state_nm,'Grand Total') as ZONE_NM,nvl(district_name,'Total') as State_nm,COUNT(*) AS NOOFAPPREC"      );

qrysb.append("   FROM "      );
qrysb.append("   ("      );
qrysb.append("   SELECT"      );
qrysb.append("       ad.app_id,"      );
qrysb.append("       ad.app_name,"      );
qrysb.append("       ad.gender,"      );
qrysb.append("       ad.benf_type_cd,"      );
qrysb.append("       ad.benf_catagory_cd,"      );
qrysb.append("       ad.mob_no1,"      );
qrysb.append("       ad.mob_no2,"      );
qrysb.append("       md.district_name,"      );
qrysb.append("       ms.state_nm,"      );
qrysb.append("       RBL.BANK_NAME,"      );
qrysb.append("       ZM.ZONE_NM,"      );
qrysb.append("       nvl(bd.working_capital, 0) + nvl(bd.machinary_cost, 0) AS prj_cost,"      );
qrysb.append("       bd.mm_claim_amt,"      );
qrysb.append("      nvl( bd.ce_sanc_fb,0)+"      );
qrysb.append("      nvl( bd.wc_sanc_fb,0) as sanc,"      );
qrysb.append("      ZM.ZONE_CD,"      );
qrysb.append("      bd.APPRV_YN"      );
qrysb.append("   FROM"      );
qrysb.append("       app_detail       ad,"      );
qrysb.append("       bank_dataentry   bd,"      );
qrysb.append("       m_district       md,"      );
qrysb.append("       m_state          ms,"      );
qrysb.append("       RBIBANKLIST RBL,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("   WHERE"      );
qrysb.append("       ad.app_id = bd.app_id(+)"      );
qrysb.append("       AND MS.ZONE_CD=ZM.ZONE_CD"      );
qrysb.append("       AND ad.IFSC_CODE=RBL.IFSC_CODE"      );
qrysb.append("       AND ad.unit_dist_cd = md.district_cd"      );
qrysb.append("       AND md.state_cd = ms.state_cd"      );
qrysb.append("  AND ad.RET_YN='Y' AND TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FromDt+"' and '"+ToDt+"' AND MS.STATE_NM like'"+Statep+"'  " );
qrysb.append("   "      );
qrysb.append("    )"      );
qrysb.append("       GROUP BY ROLLUP(STATE_NM,DISTRICT_NAME)"      );



//out.print (qrysb.toString());

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
 out.print(offtl);
 %>
 </div>
 <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
<thead>
<tr>
  <th  rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th  rowspan="2" > State </th>
  <th  rowspan="2" >District</th>
 

</tr>
<tr>
<th  >No Of Project </th>


</tr>
<tr>
<th >
 (A) </th>
<th>(B)</th>
<th>(C)</th>
<th>
(D)</th>



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

<tbody>


	 
     <tr>
	 
<td><div align="center"><%=srn%>)</div></td>
<%

String ZONE_NM=rsinst.getString("ZONE_NM");
String State_nm=rsinst.getString("State_nm")==null?"Total":rsinst.getString("State_nm");
%>
<td><div align="center"><%=ZONE_NM%></div></td>

<td><div align="right">
     
      <%= State_nm%>
    </div></td>
<td>
  <% out.print(dfd.format(rsinst.getDouble("NOOFAPPREC")));%>
</td>


     </tr>
<%
}
rsinst.close();
db.close();
}catch (Exception e) {
out.print (e.toString());
}
}

%>
</tbody>
</table>
</w:realPage>
</w:wait> 
</form>
</body>
</html>
