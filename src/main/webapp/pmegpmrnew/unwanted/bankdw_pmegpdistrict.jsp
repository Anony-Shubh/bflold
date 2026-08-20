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
append(" SELECT  NVL(DECODE(dm.district_name,NULL,'Total',dm.district_name),'Total') as bank_name").
append(" ,sum( nvl(case when   ad.act_id=5 and TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as bank_ford  ").
append(" ,sum( nvl(case when   ad.act_id=5 and TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then round(mminvolve(AD.app_id)/100000,2) end ,0)) as bankfordmminv").
append(",sum( nvl(case when BD.ACT_ID>=11 and ad.act_id=5 AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as bank_sanc ").
append(" ,sum( nvl(case when  bd.act_id>=11 and ad.act_id=5 AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then ROUND( MM_AMT_BANKSANC(BD.APP_ID)/100000,2) end ,0)) as bank_sanc_mm").
append(",sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL and bd.act_id>=11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as mm_claim ").
 append(" ,sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL  and bd.act_id>=11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'  then round(bd.mm_claim_amt/100000,2) end ,0)) as mm_claim_amt ").
append(",sum( nvl(case when bd.MM_REL_DT IS NOT NULL and bd.act_id>=11 AND TRUNC(bd.MM_REL_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as mm_rel ").
 append(" ,sum( nvl(case when MM_REL_DT IS NOT NULL and bd.act_id>=11 AND TRUNC(bd.MM_REL_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt ").
append(" ,sum( nvl(case when  bd.act_id=11 then ad.emp_env end ,0)) as emp "). 
 append(" ,sum( nvl(case when  bd.act_id=3 AND   TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then round(mminvolve(bd.app_id)/100000,2) end ,0)) as bank_rej_mm").
 append(",sum( nvl(case when  bd.act_id=3 AND   TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as bank_reject ").
 append(",SUM(CASE WHEN BD.PACT_ID=30 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'  THEN 1 ELSE 0 END) AS REF_PEND_NO ").
 append(" ,SUM(CASE WHEN BD.PACT_ID=30  AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"'  THEN ROUND(NVL(BD.MM_CLAIM_AMT,0)/100000,2) ELSE 0 END) AS REF_PEND_MM ").
 append(", sum( nvl(case when  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5  AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as pend_bank_sanc  ").
 append(" ,sum( nvl(case when  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5  AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then round(NVL(mminvolve(AD.app_id),0)/100000,2) end ,0)) as pend_bank_sanc_mm ").
  append(" ,sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL and bd.act_id>=11 AND NVL(PACT_ID,0) <>34 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then round(bd.mm_claim_amt/100000,2) end ,0)) as Pend_mmrel_amt ").
  append(" ,sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL and bd.act_id>=11 AND BD.MM_REL_DT IS NULL AND NVL(PACT_ID,0) <>34 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as Pend_mmrel ").
append(" FROM app_detail ad, bank_dataentry bd, m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM ").
append(" where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd ").
append("  "+txtSearch+"  ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by ROLLUP(DECODE(dm.district_name,NULL,'Total',dm.district_name))  )A ");
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
  <th colspan="2" >Forwarded to Bank </th>
  <th colspan="2" >Sanctioned by Bank </th>
  <th colspan="2" >Margin Money Claimed </th>
  <th colspan="2" >Disbursement Made by <br />
Nodal Branches</th>
  <th colspan="2" >No of <br />
Applications Returned<br />
by Bank</th>
  <th colspan="2" >Pending at Bank </th>
  <th colspan="2" >Pending for MM Disbursement </th>
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
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=5"%>">

      <% out.print(dfd.format(rsinst.getDouble("bank_ford")));%>
 </a></div></td>
  <td nowrap="nowrap">
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bankfordmminv")));%>
</div></td>
  <td nowrap="nowrap">
    <div align="right">
	<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">

      <% out.print(dfd.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td><td nowrap="nowrap"><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%>
  </div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=11"%>">

  <% out.print(dfd.format(rsinst.getDouble("mm_claim")));%>
</a></div></td>
<td nowrap="nowrap">
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_claim_amt")));%>
</div></td>
<td nowrap="nowrap">
    <div align="right">
	<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=12"%>">

      <% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></div></td><td nowrap="nowrap"><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel_amt")));%>
  </div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=7"%>">
  <% out.print(dfd.format(rsinst.getDouble("bank_reject")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("bank_rej_mm")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=38"%>">
  <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc_mm")));%>
</div></td>
<td nowrap="nowrap"><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=16"%>">
  <% out.print(dfd.format(rsinst.getDouble("Pend_mmrel")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("Pend_mmrel_amt")));%>
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
