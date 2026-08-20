<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<%! 

public String getParm(String p_val) {

if (p_val.equals("ALL")||p_val.equals("null")||p_val.equals("Total")||p_val.equals("")||p_val.equals("%%")){
p_val="%%";
}
return (p_val);
  }

public String getTit(String p_val) {

if (p_val.equals("%%")){
p_val="ALL";
}
return (p_val);
  }

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Performance Bank Detail</title>
	<link rel="stylesheet" type="text/css" href="css/indexr.css">
 <style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-size: 24px;
	font-weight: bold;
}
-->
    </style>
	
	</head>
<body>
<form method="post" >


<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";
String flagC="Y";
String p3="";
String p4="";
int lrow=0;

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String vAgency=request.getParameter("AGENCY")==null||request.getParameter("AGENCY")=="ALL"?"%%":(String) request.getParameter("AGENCY");
String vZonecd =request.getParameter("ZONECD")==null||request.getParameter("ZONECD")=="ALL"?"%%":(String) request.getParameter("ZONECD");
String vStatecd =request.getParameter("STATECD")==null||request.getParameter("STATECD")=="ALL"?"%%":(String) request.getParameter("STATECD");
String vOffice =request.getParameter("OFFNAMECD")==null||request.getParameter("OFFNAMECD")=="ALL"?"%%":(String) request.getParameter("OFFNAMECD");
String vDist =request.getParameter("DISTCD")==null||request.getParameter("DISTCD")=="ALL"?"%%":(String) request.getParameter("DISTCD");
String vBank = request.getParameter("BANKNAME")==null||request.getParameter("BANKNAME")=="ALL"?"%%":(String) request.getParameter("BANKNAME");

 vStatecd=getParm(vStatecd);  
 vOffice=getParm(vOffice); 
 vZonecd=getParm(vZonecd); 
 vAgency=getParm(vAgency); 
 vDist=getParm(vDist); 
 vBank=getParm(vBank);  
 String addUrl="AGENCY="+vAgency+"&ZONECD="+vZonecd+"&STATECD="+vStatecd+"&OFFNAMECD="+vOffice+"&DISTCD="+vDist+"&FROMDT="+FromDt+"&TODT="+ToDt;
 txtSearch=txtSearch+" AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"' AND MOM.OFF_NAME1 LIKE '"+vOffice+"' AND DM.DISTRICT_NAME LIKE '"+vDist+"'  ";

out.print ("<center>PMEGP e-Tracking System</center>");

 StringBuffer sb= new StringBuffer();
 
sb.append(" SELECT bank_name, NVL(DECODE(STATE_NM,NULL,'Total',STATE_NM),'Total') as STATE_NM,").
append(" COUNT(*) AS NO_OF_APP,SUM(DECODE (TDR_YN,'Y',1,0)) AS TDR_UPDATED,").
append(" SUM(DECODE (TDR_YN,'N',1,0)) AS TDR_NOT_UPDATED").
append(" FROM").
  append(" (SELECT NVL(DECODE(ad.BANK_NAME, NULL, 'Total', ad.BANK_NAME), 'Total') AS bank_name,").
   append("   NVL(DECODE(MS.STATE_NM,NULL,'Total',MS.STATE_NM),'Total') as STATE_NM, ").
append("   AD.APP_ID,AD.APP_NAME,DECODE(BD.TDR_ADJ_DT,NULL,'N','Y') AS TDR_YN").
append(" FROM app_detail_second ad, bank_dataentry_second bd, m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM ").
append(" where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd ").
append("  AND BD.ACT_ID = 11").
append("  AND TRUNC(bd.MM_REL_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"' ").
append(" AND BD.PACT_ID = 34").
append(" AND BD.APPRV_YN='A'").
append(" AND AD.APP_ID=BD.APP_ID").
append("  "+txtSearch+"  ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd   ) where bank_name='"+vBank+"'  group by bank_name, ROLLUP(state_nm) ");
//out.print(sb.toString());

 ResultSet rsinst = db.execSQL(sb.toString());
try{
%>
<table align="center">
<tr>
<th>Agency</th>
<td><%= getTit(vAgency)  %></td>
<th>KVIC Zone</th>
<td><%= getTit(vZonecd)  %></td>
<th>State/Office</th>
<td><%= getTit(vStatecd) %>(<%= getTit(vOffice) %> )</td>
<th>District</th>
<td><%= getTit(vDist) %></td>
<th>From Date </th>
<td><%=FromDt  %></td>
<th>To Date </th>
<td><%=ToDt  %></td>
</tr>
</table>
<br />
<div align="center"><span class="style1"><u><%= vBank %></u></span><br />
 </div>
 <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
<thead>
<tr>
  <th rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th rowspan="2" > STATE</th>
 
  <th >MM Disbursed </th>
  <th colspan="2" >TDR Detail</th>
  <th rowspan="2" >Districtwise</th>
  </tr>
<tr>

<th >No of <br />
Prj.</th>
<th >TDR Updated </th>
<th >TDR Not Update </th>

</tr>
<tr>
<th >
 (A)
 </th>
<th>(B)</th>

<th>(C)</th>
<th>(E)</th>
<th>(F)</th>

<th>(G)</th>
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
srn=srn+1;	
p3=addUrl+"&BANKNAME="+rsinst.getString("bank_name");
p4=addUrl+"&BANKNAME="+rsinst.getString("bank_name")+"&STATECD="+rsinst.getString("state_nm");
 %>
	 
     <tr>
	 
<td nowrap="nowrap"><div align="center"><%=srn%>)</div></td>
<td nowrap="nowrap" >
  <div align="left"><%= rsinst.getString("STATE_NM") %></div></td>

<td nowrap="nowrap">
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("NO_OF_APP")));%>
</div></td>
<td nowrap="nowrap"><a href="dwstatewise.jsp?<%=p4+"&amp;QRYCODE=27"%>">
  <% out.print(dfd.format(rsinst.getDouble("TDR_UPDATED")));%>
</a></td>

<td nowrap="nowrap"><div align="right">
<a href="dwstatewise.jsp?<%=p4+"&amp;QRYCODE=24"%>">
    
<% out.print(dfd.format(rsinst.getDouble("TDR_NOT_UPDATED")));%></a>
</div></td>
 <td><a href="districtWiseTdrDetailSec.jsp?<%=p4%>">view </a>
 </td>
</tr>
<%
}
rsinst.close();
db.close();
}catch (Exception e) {
out.print (e.toString());
}
%>
</tbody>
</table>
</w:realPage>
</w:wait>
</form>
</body>
</html>
