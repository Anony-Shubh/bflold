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
int lrow=0;

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String vAgency=request.getParameter("AGENCY")==null||request.getParameter("AGENCY")=="ALL"?"%%":(String) request.getParameter("AGENCY");
String vZonecd =request.getParameter("ZONECD")==null||request.getParameter("ZONECD")=="ALL"?"%%":(String) request.getParameter("ZONECD");
String vStatecd =request.getParameter("STATECD")==null||request.getParameter("STATECD")=="ALL"?"%%":(String) request.getParameter("STATECD");
String vOffice =request.getParameter("OFFNAMECD")==null||request.getParameter("OFFNAMECD")=="ALL"?"%%":(String) request.getParameter("OFFNAMECD");
String vDist =request.getParameter("DISTCD")==null||request.getParameter("DISTCD")=="ALL"?"%%":(String) request.getParameter("DISTCD");
 vStatecd=getParm(vStatecd);  
  vOffice=getParm(vOffice); 
 vZonecd=getParm(vZonecd); 
 vAgency=getParm(vAgency); 
   vDist=getParm(vDist); 
   
 String addUrl="AGENCY="+vAgency+"&ZONECD="+vZonecd+"&STATECD="+vStatecd+"&OFFNAMECD="+vOffice+"&DISTCD="+vDist+"&FROMDT="+FromDt+"&TODT="+ToDt;
 txtSearch=txtSearch+" AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' AND ZM.ZONE_NM LIKE '"+vZonecd+"' AND MS.STATE_NM LIKE '"+vStatecd+"' AND MOM.OFF_NAME1 LIKE '"+vOffice+"' AND DM.DISTRICT_NAME LIKE '"+vDist+"' ";

out.print ("<center>PMEGP e-Tracking System</center>");

 StringBuffer sb= new StringBuffer();
  sb.append("SELECT A.* ").
append(" FROM ( ").
append(" SELECT  NVL(DECODE(dm.district_name,NULL,'Total',dm.district_name),'Total') as bank_name  ").
append(" , sum( nvl(case when ad.act_id=5 then 1 end ,0)) as bank_ford  " ) .
 append(" ,SUM(CASE WHEN AD.ACT_ID=5 AND NVL(BD.ACT_ID,0) NOT IN (11,3) AND TRUNC(AD.ONLINE_SUBDT) < '"+FromDt+"' THEN 1 ELSE 0 END) AS PRV_BANK_FORD_PEN  ").
   append(" ,SUM(    CASE WHEN ad.ACT_ID   = 5      AND NVL(bd.ACT_ID, 0) NOT IN (11, 3)      AND TRUNC(ad.ONLINE_SUBDT) < '"+FromDt+"'       THEN ROUND(MMINVOLVE(AD.APP_ID)/100000,2)      ELSE 0    END) AS PRV_BANK_FORD_PEN_MM  " ) .
   append("  ,SUM(CASE WHEN AD.ACT_ID=5 AND  TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS CUR_BANK_FORD_PEN  ").
  append(" ,SUM(CASE WHEN ad.ACT_ID = 5 AND TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN ROUND(MMINVOLVE(AD.APP_ID)/100000,2) ELSE 0 END) AS CUR_BANK_FORD_PEN_MM  " ) .
   append(" ,SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL AND TRUNC(AD.ONLINE_SUBDT) < '"+FromDt+"' THEN 1 ELSE 0 END) AS PRV_BANK_NOT_CLAIM_PEN  ").
  append(",SUM(    CASE      WHEN ad.ACT_ID             = 5      AND bd.ACT_ID              = 11      AND bd.LOAN_DOCFNAME      IS NULL      AND bd.MM_CLAIM_DT        IS NULL      AND TRUNC(ad.ONLINE_SUBDT) < '"+FromDt+"'      THEN ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2)     ELSE 0    END) AS PRV_BANK_NOT_CLAIM_PEN_MM  " ) .
  append("  ,SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11  AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS CUR_BANK_NOT_CLAIM_PEN ").
  append(",SUM( CASE   WHEN ad.ACT_ID = 5      AND bd.ACT_ID  = 11      AND TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'     THEN ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2)      ELSE 0    END) AS CUR_BANK_NOT_CLAIM_PEN_MM  " ) .
  append(" ,SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND NVL(BD.PACT_ID,0) <> 34 AND TRUNC(BD.MM_CLAIM_DT) < '"+FromDt+"' THEN 1 ELSE 0 END) AS PRV_CLAIM_PEN_DISB  ").
 append(",SUM(    CASE      WHEN ad.ACT_ID            = 5      AND bd.ACT_ID             = 11      AND bd.LOAN_DOCFNAME     IS NOT NULL      AND bd.MM_CLAIM_DT       IS NOT NULL      AND NVL(bd.PACT_ID, 0)   <> 34      AND TRUNC(bd.MM_CLAIM_DT) < '"+FromDt+"'      THEN ROUND((bd.MM_CLAIM_AMT/100000),2)      ELSE 0    END) AS PRV_CLAIM_PEN_DISB_MM  " ) .
 append(" ,SUM( CASE WHEN ad.ACT_ID = 5 AND bd.ACT_ID = 11 AND bd.LOAN_DOCFNAME IS NOT NULL AND bd.MM_CLAIM_DT IS NOT NULL AND NVL(bd.PACT_ID, 0) <> 34 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS CUR_CLAIM_PEN_DISB ").
 append("  ,SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND NVL(BD.PACT_ID,0) <> 34 AND TRUNC(BD.MM_CLAIM_DT)  BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND NVL(bd.PACT_ID, 0) <> 34      AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'       THEN ROUND((bd.MM_CLAIM_AMT/100000),2)      ELSE 0    END) AS CUR_CLAIM_PEN_DISB_MM  " ) .
 append(" ,SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND NVL(BD.PACT_ID,0) = 34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS CUR_CLAIM_DISB  ").
append(" ,SUM(    CASE      WHEN ad.ACT_ID         = 5      AND bd.ACT_ID          = 11      AND bd.LOAN_DOCFNAME  IS NOT NULL      AND bd.MM_CLAIM_DT    IS NOT NULL      AND NVL(bd.PACT_ID, 0) = 34      AND TRUNC(bd.MM_REL_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'      THEN ROUND((bd.MM_REL_AMT/100000),2)      ELSE 0    END) AS CUR_CLAIM_DISB_MM  " ) .
append(" ,SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND BD.PACT_ID NOT IN(34,30) AND BD.APPRV_YN='A' AND TRUNC(BD.MM_CLAIM_DT)  BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS CLAIM_UP ").
append(" , SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND BD.PACT_ID =30 AND BD.APPRV_YN='A' AND TRUNC(BD.MM_CLAIM_DT)  BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS REFF_DISB  ").
append(" FROM app_detail ad, bank_dataentry bd, m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM ").
append(" where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd ").
append("  "+txtSearch+"  ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by ROLLUP(DECODE(dm.district_name,NULL,'Total',dm.district_name))  )A  ");
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
 <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
<thead>
<tr>
  <th rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th rowspan="2" > Name</th>
  <th colspan="2" >Previous Years Application Pending At Bank For Credit Decision </th>
  <th colspan="2" >Forwarded To Bank During Current Year</th>
  <th colspan="2" >Loan Sanctioned During Previous Year And Pending For MM Claim</th>
  <th colspan="2" >Current Year Loan Sanction</th>
  <th colspan="2" >Previous Years Claims Pending For Disbursement</th>
  <th colspan="2" >Current Year Claims</th>
  <th colspan="2" >Disburesd During Current Year (Including Last Year)</th>
  </tr>
<tr>
<th ><br /> 
  No of Prj.
</th>
<th >MM Involve<br /> 
  (In Lakh) </th>
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
<th >MM<br />
(In Lakh)</th>
<th ><br />
  No of Prj. </th>
<th >MM Involve<br />
  (In Lakh) </th>
<th >No of Prj.</th>
<th >MM Involve<br />
(In Lakh)</th>
<th >No of Prj. </th>
<th >MM<br />
(In Lakh)</th>
</tr>
<tr>
<th >
 (A)
 </th>
<th>(B)</th>
<th>(F)</th>
<th>(G)</th>
<th>(H)</th>
<th>(I)</th>
<th>(J)</th>
<th>(K)</th>
<th>(L)</th>
<th>(M)</th>
<th>(P)</th>
<th>(Q)</th>
<th>(R)</th>
<th>(S)</th>
<th>(T)</th>
<th>(U)</th>
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
p3=addUrl+"&DISTCD="+rsinst.getString("bank_name");
 %>
	 
     <tr>
	 
<td nowrap="nowrap"><div align="center"><%=srn%>)</div></td>
<td nowrap="nowrap" >
  <div align="left"><%= rsinst.getString("bank_name") %></div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise_Pen.jsp?<%=p3+"&QRYCODE=5"%>">

      <% out.print(dfd.format(rsinst.getDouble("PRV_BANK_FORD_PEN")));%>
 </a></div></td>
  <td nowrap="nowrap">
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("PRV_BANK_FORD_PEN_MM")));%>
</div></td>
  <td nowrap="nowrap">
    <div align="right">
	<a href="dwstatewise_Pen.jsp?<%=p3+"&QRYCODE=6"%>">

      <% out.print(dfd.format(rsinst.getDouble("CUR_BANK_FORD_PEN")));%>
</a></div></td><td nowrap="nowrap"><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("CUR_BANK_FORD_PEN_MM")));%>
  </div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise_Pen.jsp?<%=p3+"&QRYCODE=8"%>">

  <% out.print(dfd.format(rsinst.getDouble("PRV_BANK_NOT_CLAIM_PEN")));%>
</a></div></td>
<td nowrap="nowrap">
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("PRV_BANK_NOT_CLAIM_PEN_MM")));%>
</div></td>
<td nowrap="nowrap">
    <div align="right">
	<a href="dwstatewise_Pen.jsp?<%=p3+"&QRYCODE=9"%>">

      <% out.print(dfd.format(rsinst.getDouble("CUR_BANK_NOT_CLAIM_PEN")));%>
</a></div></td><td nowrap="nowrap"><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("CUR_BANK_NOT_CLAIM_PEN_MM")));%>
  </div></td>
<td nowrap="nowrap">
<div align="right"><a href="dwstatewise_Pen.jsp?<%=p3+"&amp;QRYCODE=11"%>">
<% out.print(dfd.format(rsinst.getDouble("PRV_CLAIM_PEN_DISB")));%>
</a>
</td>
<td nowrap="nowrap"><% out.print(dfd.format(rsinst.getDouble("PRV_CLAIM_PEN_DISB_MM")));%></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise_Pen.jsp?<%=p3+"&QRYCODE=12"%>">
  <% out.print(dfd.format(rsinst.getDouble("CUR_CLAIM_PEN_DISB")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("CUR_CLAIM_PEN_DISB_MM")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise_Pen.jsp?<%=p3+"&QRYCODE=14"%>">
  <% out.print(dfd.format(rsinst.getDouble("CUR_CLAIM_DISB")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("CUR_CLAIM_DISB_MM")));%>
</div></td>
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
