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
String qryField1="";
String qryGroup="";
String qryGroup1="";
String urladd="";
String urlrep="";
String repnm="pmegpdashboardedpType.jsp";
 urlrep ="?TODT="+ToDt+"&FROMDT="+FromDt+"&";
 String repnmE="edpDetJasper.jsp";
  
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
 
 
  

 
 


qrysb.append("   SELECT  "+qryField1+" ,SUM(TOT_SANC) AS TOT_SANC,"      );
qrysb.append("     SUM(NVL(EDP_COMP,0)) EDP_COMP,"      );
qrysb.append("     SUM(NVL(EDP_ONLINE,0))EDP_ONLINE,"      );
qrysb.append("     SUM(NVL(EDP_OFFLINE,0))EDP_OFFLINE,"      );
qrysb.append("     SUM(NVL(EDP_NOTCOMP,0))EDP_NOTCOMP,"      );
qrysb.append("     SUM(NVL(MM_RELONLINE,0))MM_RELONLINE,"      );
qrysb.append("     SUM(NVL(EDP_NOTCOMP,0)-NVL(MM_RELONLINE,0)) AS MM_REL_NOT,"      );
qrysb.append("     SUM(NVL(PEND_VERY,0))PEND_VERY"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT  "+qryField+","      );
qrysb.append("       COUNT(*) as tot_sanc,"      );
//qrysb.append("       SUM(NVL(DECODE(TRUNC(A.EDP_CERT_DT), NULL, 0, 1), 0)) AS EDP_COMP,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NOT NULL"      );
qrysb.append("         AND A.OFF_CD     IS NOT NULL "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS EDP_COMP,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NOT NULL"      );
qrysb.append("         AND A.OFF_CD               = 9246"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS EDP_ONLINE,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NOT NULL"      );
qrysb.append("         AND( NVL(A.OFF_CD, 0)      <> 9246 AND A.OFF_CD IS NOT NULL)"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0))                                              AS EDP_OFFLINE,"      );
qrysb.append("       SUM(NVL(CASE WHEN TRUNC(A.EDP_CERT_DT) IS NULL  THEN 1 ELSE 0 END, 0)) AS EDP_NOTCOMP,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NULL  "      );
qrysb.append("         AND TRUNC(A.MM_REL_DT)    IS NOT NULL"      );
qrysb.append("         AND A.PACT_ID              = 34"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS MM_RELONLINE,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(A.EDP_CERT_DT) IS NULL"      );
qrysb.append("         AND A.UPLOAD_YN            = 'Y'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS PEND_VERY"      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT a.*,"      );
qrysb.append("         DECODE(b.DOC_NAME, NULL, 'N', 'Y') AS UPLOAD_YN"      );
qrysb.append("       FROM"      );
qrysb.append("         (SELECT MOM.AGENCY_TYPE,ZM.ZONE_NM,MS.STATE_NM,DM.DISTRICT_NAME,MO.OFF_NAME AS OFF_NAME1,"      );
qrysb.append("           BD.APP_ID,"      );
qrysb.append("           BD.EDP_CERT_DT,"      );
qrysb.append("           BD.MM_REL_DT,"      );
qrysb.append("           BD.OFF_CD,"      );
qrysb.append("           BD.PACT_ID"      );
qrysb.append("         FROM APP_DETAIL ADO,"      );
qrysb.append("           BANK_DATAENTRY BD,"      );
qrysb.append("           MAS_OFF_MAST MOM,MAS_OFF_MAST MO,M_STATE MS,M_DISTRICT DM, ZONE_MAST ZM"      );
qrysb.append("         WHERE ADO.APP_ID = BD.APP_ID"      );
qrysb.append("         AND ADO.OFF_CD   = MOM.OFF_CD AND MO.OFF_CD(+)=BD.OFF_CD "      );
qrysb.append("     AND ado.UNIT_DIST_CD = DM.DISTRICT_CD"      );
qrysb.append("     AND DM.STATE_CD      = ms.STATE_CD AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );

qrysb.append("     AND ms.ZONE_CD       = ZM.ZONE_CD "+txtSearch+" "      );
qrysb.append("         AND (BD.ACT_ID  = 11)"      );
qrysb.append("         ) a,"      );
qrysb.append("         (SELECT AUT.APP_ID,"      );
qrysb.append("           MAX(AUT.DOC_NAME) AS DOC_NAME"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8 AND AUT.DOC_ACTYN='Y' "      );
qrysb.append("         GROUP BY AUT.APP_ID"      );
qrysb.append("         ) b"      );
qrysb.append("       WHERE a.APP_ID = b.APP_ID(+)   "      );
qrysb.append("       ) A GROUP BY "+qryGroup+" "      );
qrysb.append("     "      );
qrysb.append("     )A GROUP BY "+qryGroup1+" "      );



//out.print(qrysb.toString());




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
       <th rowspan="3">Row ID</th>
       <th rowspan="3" > Name </th>
       <th rowspan="3"  >Sanctioned Project </th>
       <th colspan="3" rowspan="2" >EDP Completed </th>
       <th colspan="4" >EDP Pending </th>
       
       <th rowspan="3">Training Center Type Wise </th>
     </tr>
     <tr>
	    <th rowspan="2"  >Total Pending</th>
       <th rowspan="2"  >MM Released </th>
       <th rowspan="2" >Sanctioned</th>
       <th rowspan="2" >Validation Pending </th>
     </tr>
     <tr>
	  
       <th >Online</th>
       <th >Offline</th>
       <th >Total</th>
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
//off_name1=rsinst.getString("off_name1")==null?"":rsinst.getString("off_name1");
//PENOF_EDP=rsinst.getString("PENOF_EDP")==null?"":rsinst.getString("PENOF_EDP");
//PENON_EDP=rsinst.getString("PENON_EDP")==null?"":rsinst.getString("PENON_EDP");
//COMOF_EDP=rsinst.getString("COMOF_EDP")==null?"":rsinst.getString("COMOF_EDP");
PREOF_EDP=rsinst.getString("MM_REL_NOT")==null?"":rsinst.getString("MM_REL_NOT");
PREON_EDP=rsinst.getString("MM_RELONLINE")==null?"":rsinst.getString("MM_RELONLINE");
//COMON_EDP=rsinst.getString("COMON_EDP")==null?"":rsinst.getString("COMON_EDP");

TOTOF_EDP=rsinst.getString("EDP_OFFLINE")==null?"":rsinst.getString("EDP_OFFLINE");
TOTON_EDP=rsinst.getString("EDP_ONLINE")==null?"":rsinst.getString("EDP_ONLINE");
TOT_EDP=rsinst.getString("EDP_COMP")==null?"":rsinst.getString("EDP_COMP");
BANK_FORW=rsinst.getString("TOT_SANC")==null?"":rsinst.getString("TOT_SANC");
PREONSAN_EDP=rsinst.getString("PEND_VERY")==null?"":rsinst.getString("PEND_VERY");
POSONSAN_EDP=rsinst.getString("EDP_NOTCOMP")==null?"":rsinst.getString("EDP_NOTCOMP");







	
	
	
 %>
   <% if (flag.equals("Y")){%>
   <tbody>
     <tr>
       <th  colspan="33"><div align="center"></div>
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
p3=vFurl+"&DISTCD="+vnmdw+"&STATECD="+firstcolold+"&STATEDC="+firstcolold+"&";
out.print(vnmdw);
}else{
p3=vFurl+p2+vnmdw+p1+firstcolold;

%>
           <a href="<%=repnm+urlrep+p2+vnmdw+p1+firstcolold%>"><%=vnmdw %>
		
		   </a>
           <%}%></th>
       <% if(!vfields.equals("3")){%>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=1"><%=BANK_FORW  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=2"><%=TOTON_EDP  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=3"><%=TOTOF_EDP  %></a></td>
       <td  ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=4"><%=TOT_EDP  %></a></td>
	   <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=5"><%=POSONSAN_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=6"><%=PREON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=7"><%=PREOF_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p2+vnmdw+p1+firstcolold%>&QRYCODE=8"> <%=PREONSAN_EDP  %></a></td>
       
      <td nowrap="nowrap"><a href="edpOffTypeWise.jsp<%=urlrep+p2+vnmdw+p1+firstcolold%>">view</a>
	  
	  
	  </td>
      
       <!--<td nowrap="nowrap"><a href="TrainingEdp.jsp<%=urlrep+p2+vnmdw+p1+firstcolold%>">view</a></td>-->
       
       <% } else{%>
	   <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=1&REPTP=4"><%=BANK_FORW  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=2&REPTP=4"><%=TOTON_EDP  %></a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=3&REPTP=4"> <%=TOTOF_EDP  %></a> </td>
       <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=4&REPTP=4"><%=TOT_EDP  %></a></td>
	   <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=5&REPTP=4"><%=POSONSAN_EDP  %> </a></td>
       <td ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=6&REPTP=4"> <%=PREON_EDP  %></a> </td>
   
       <td  ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=7&REPTP=4"><%=PREOF_EDP  %></a></td>
  
       <td   ><a href="<%=repnmE+urlrep+p3%>&QRYCODE=8&REPTP=4"><%=PREONSAN_EDP  %></a></td>
       
   
       
      
       <td nowrap="nowrap"><a href="edpOffTypeWise.jsp?<%=p3+vFurl%>">view</a>
	   <%//out.print(p3+vFurl);%>
	   
	   </td>
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
