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


txtSearch=" AND mom.AGENCY_TYPE LIKE '"+vsAgency+"' AND zm.ZONE_NM LIKE '"+vsZonecd+"' AND  ms.STATE_NM LIKE '"+vsStatecd+"'";
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
String repnm="pmegpAward.jsp";
 urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt+"&";
 String repnmE="awardjasper.jsp";
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

 
 txtSearch=txtSearch+"AND mom.AGENCY_TYPE LIKE '"+vAgency+"' AND zm.ZONE_NM LIKE '"+vZonecd+"' AND ms.STATE_NM LIKE '"+vStatecd+"' AND mom.OFF_NAME1 LIKE '"+vOffice+"' ";



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
 


 

qrysb.append("   select "+qryField1+",count(*) as total_registration,"      );
qrysb.append("   sum(decode(final_sub_dt,null,0,1)) as final_submission,"      );
qrysb.append("   "      );
qrysb.append("   SUM(CASE WHEN dco_approv_date IS NULL AND final_sub_dt IS NOT NULL THEN 1 ELSE 0 END)pending_for_scrutitybydoc,"      );
qrysb.append("   "      );
qrysb.append("   sum(decode(dco_approv_yn,'Y',1,0)) recom_by_dco,"      );
qrysb.append("   sum(decode(dco_approv_yn,'N',1,0)) rejected_by_dco,"      );
qrysb.append("   "      );
qrysb.append("   SUM(CASE WHEN dco_approv_yn='Y' AND app_approv_yn ='Y' THEN 1 ELSE 0 END)FORWARD_TO_CO"      );
qrysb.append("   from"      );
qrysb.append("   (SELECT"      );
qrysb.append("       ad.app_id,"      );
qrysb.append("       ad.off_cd,"      );
qrysb.append("       ad.app_name,"      );
qrysb.append("       pa.unit_name,"      );
qrysb.append("       pa.mob_no_n,"      );
qrysb.append("       pa.email_n,"      );
qrysb.append("       pa.app_approv_yn,"      );
qrysb.append("       pa.app_approv_date,"      );
qrysb.append("       pa.final_sub_dt,"      );
qrysb.append("       pa.update_timestamp,"      );
qrysb.append("       pa.dco_approv_yn,"      );
qrysb.append("       pa.dco_approv_date,"      );
qrysb.append("       pa.dco_remark,"      );
qrysb.append("       md.district_name as UNIT_DIST,"      );
qrysb.append("       ms.state_nm,"      );
qrysb.append("       ms.zone_cd,"      );
qrysb.append("       mom.off_name1,"      );
qrysb.append("       mom.agency_type,zm.ZONE_NM"      );
qrysb.append("   FROM"      );
qrysb.append("       app_detail     ad,"      );
qrysb.append("       pmegp_award    pa,"      );
qrysb.append("       mas_off_mast   mom,"      );
qrysb.append("       m_state        ms,"      );
qrysb.append("       m_district     md,"      );
qrysb.append("       zone_mast zm    "      );
qrysb.append("   WHERE"      );
qrysb.append("       ad.unit_dist_cd = md.district_cd"      );
qrysb.append("       AND md.state_cd = ms.state_cd"      );
qrysb.append("       AND mom.off_cd = ad.off_cd"      );
qrysb.append("       AND ad.app_id = pa.app_id"      );
qrysb.append("       and ms.zone_cd=zm.zone_cd "+txtSearch+" )A"      );
qrysb.append("   GROUP BY "+qryGroup1+"  "      );








//out.print (qrysb.toString());

try{
ResultSet rsinst = db.execSQL(qrysb.toString());

%>


 <table align="center">
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">PMEGP Portal Award </div></td>
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
  <th><div align="center">Row<br />
  ID</div></th>
  <th > Name</th>
  <th >Total Application Registered</th>
  <th >Final Submission </th>
  <th >Pending At IA </th>
  <th >Recommended BY IA </th>
  <th >Rejected BY IA </th>
  <th >Forwarded to CO </th>
 
  </tr>

<tr>
<th >
 (A) </th>
<th>(B)</th>
<th> (C)</th>
<th>
(D)</th>
<th>(E)</th>
<th>(F)</th>
<th>(G)</th>
<th>(H)</th>
</tr>
</thead>
 <%
  
 String Head="";
 String firstcolnew="";
 String firstcolold="";
 String flag="Y";
 String final_submission="";
 String pending_for_scrutitybydoc="";
 String recom_by_dco="";
 String rejected_by_dco="";
 String FORWARD_TO_CO="";
 String total_registration ="";
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
	
total_registration=rsinst.getString("total_registration")==null?"":rsinst.getString("total_registration");
final_submission=rsinst.getString("final_submission")==null?"":rsinst.getString("final_submission");
pending_for_scrutitybydoc=rsinst.getString("pending_for_scrutitybydoc")==null?"":rsinst.getString("pending_for_scrutitybydoc");
recom_by_dco=rsinst.getString("recom_by_dco")==null?"":rsinst.getString("recom_by_dco");

rejected_by_dco=rsinst.getString("rejected_by_dco")==null?"":rsinst.getString("rejected_by_dco");
FORWARD_TO_CO=rsinst.getString("FORWARD_TO_CO")==null?"":rsinst.getString("FORWARD_TO_CO");
//recom_by_dco=rsinst.getString("recom_by_dco")==null?"":rsinst.getString("recom_by_dco");
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
<th >

 <%if (vfields.equals("3")) {
p3=vFurl+"&DISTCD="+vnmdw+"&STATECD="+firstcolold;
out.print(vnmdw);
}else{
p3=vFurl+p2+vnmdw+p1+firstcolold;
%>
         <a href="<%=repnm+urlrep+p2+vnmdw+p1+firstcolold%>"><%=vnmdw %></a>
         <%}%></th>
		 <%if (!vfields.equals("3")) {%>
<td>   <div align="right">
 <a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=1">
    <%=total_registration%>
    </a>
      </div></td>
<td>
    <div align="right">
	<a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=2">

      <%=final_submission%>
	  </a>
</div>   </td>

<td>
<a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=3">
  <%=pending_for_scrutitybydoc%>
  </a></td>
<td><div align="right">

<a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=4">
      <%=recom_by_dco%>
	  </a>
 </div></td>
  <td>
    <div align="right">
	
<a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=5">
      <%=rejected_by_dco%>
	  </a>
	  </div>    </td>
	  <td><div align="center">
	  <a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=6">
    <%=FORWARD_TO_CO%></a>
</div></td>
<%} else{ %>
<td>   <div align="right">
 <a href="<%=repnmE+urlrep+p3%>&QRYCODE=1">
    <%=total_registration%></a>
    </a>
      </div></td>
<td>
    <div align="right">
	<a href="<%=repnmE+urlrep+p3%>&QRYCODE=2">

      <%=final_submission%>
	  </a>
</div>   </td>

<td>
<a href="<%=repnmE+urlrep+p3%>&QRYCODE=3">
  <%=pending_for_scrutitybydoc%>
  </a>
  </td>
<td><div align="right">
<a href="<%=repnmE+urlrep+p3%>&QRYCODE=4">

      <%=recom_by_dco%>
	  </a>
 </div></td>
  <td>
    <div align="right">
	
<a href="<%=repnmE+urlrep+p3%>&QRYCODE=5">
      <%=rejected_by_dco%></a></div>    </td><td><div align="center">
 <a href="<%=repnmE+urlrep+p3%>&QRYCODE=6">   <%=FORWARD_TO_CO%>
 </a>
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
