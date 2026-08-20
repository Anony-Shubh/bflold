<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>



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
  String vooff_cd=session.getAttribute("off_cd")==null?"0":(String) session.getAttribute("off_cd");// (String) session.getAttribute("off_cd");
//out.print(vooff_cd);
	   if (vooff_cd.equals(null)||vooff_cd.equals("")||vooff_cd.equals("0")) {
	   response.sendRedirect("index.jsp");	
	  }

String voffname=(String) session.getAttribute("off_name");

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");

String repwls="";

String vsAgency=session.getAttribute("sagency_type")=="ALL"?"%%":(String) session.getAttribute("sagency_type");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
//vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
//vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;

   txtSearch=" AND MOM.off_cd="+vooff_cd+" "; 
   
   
   
 

out.print ("<center>Bankwise Pending Detail of PMEGP e-Portal ("+voffname+")</center>");

 StringBuffer sb= new StringBuffer();
 sb.append("SELECT A.* ").
append(" FROM ( ").
append(" SELECT  NVL(DECODE(RBL.bank_name,NULL,'Total',RBL.BANK_NAME),'Total') as bank_name").

 append(" ,sum( nvl(case when  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5  AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as pend_bank_sanc  ").
 append(" ,sum( nvl(case when  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5  AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"' then round(NVL(mminvolve(AD.app_id),0)/100000,2) end ,0)) as pend_bank_sanc_mm ").
  append(" ,sum( nvl(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND   TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL THEN  ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2)ELSE 0 END ,0)) as Pend_mmrel_amt ").
  append(" ,sum( nvl(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 and TRUNC(bd.LOAN_SANC_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"' AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL  THEN 1 ELSE 0 END ,0)) as Pend_mmrel ").
append(" FROM app_detail ad, bank_dataentry bd, m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM ,RBIBANKLIST RBL").
append(" where ad.app_id=bd.app_id(+) AND AD.IFSC_CODE=RBL.IFSC_CODE and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd "+txtSearch+" ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by ROLLUP(DECODE(RBL.bank_name,NULL,'Total',RBL.BANK_NAME))  )A  ");

//out.print(sb.toString());

ResultSet rsinst = db.execSQL(sb.toString());

//out.print (txtSearch);



try{
%>
<table align="center">
<tr>
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
  <th colspan="2" >Pending for credit decision at bank </th>
  <th colspan="2" >Pending for MM CLaim </th>
 
  </tr>
<tr>

<th >No of Prj.</th>
<th >MM Involve<br />
(In Lakh)</th>
<th >No of Prj. </th>
<th >MM<br />
(In Lakh)</th>
</tr>
<tr>
<th >
 (A) </th>
<th>(B)</th>

<th>(C)</th>
<th>(D)</th>
<th>(E)</th>
<th>(F)</th>

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
p3="BANKNAME="+rsinst.getString("bank_name")+"&FROMDT="+FromDt+"&TODT="+ToDt;
 %>
	 
     <tr>
	 
<td nowrap="nowrap"><div align="center"><%=srn%>)</div></td>
<td nowrap="nowrap" >
  <div align="left"><%= rsinst.getString("bank_name") %></div></td>

<td nowrap="nowrap"><div align="right">
<a href="jasper/pmegpMisPend.jsp?<%=p3+"&QRYCODE=1"%>">

  <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc")));%>
</a></div></td>
<td nowrap="nowrap"><div align="right">
  <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc_mm")));%>
</div></td>
<td nowrap="nowrap"><div align="right">
<a href="jasper/pmegpMisPend.jsp?<%=p3+"&QRYCODE=2"%>">
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
