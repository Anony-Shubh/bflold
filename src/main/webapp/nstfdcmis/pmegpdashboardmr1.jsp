<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<html>
<head>
<title>PMEGP Performance Report</title>
<script language="javascript" src="../js1/jquery-1.12.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/indexr.css">
<style type="text/css">
<!--
.style1 {color: #CC3333}
-->
</style>
</head>

<body>	

<form name="form1" method="post" action="">
<p>
  <%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";

String vUsrnm= (String) session.getAttribute("suser_detail");

String vsStatetit= (String) session.getAttribute("vsStatetit");

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");

 

String ReportDesc="  " ; 
String NO_OF_PRJ="";
String STATE_NM="";
String MMINV="";


 StringBuffer qrysb= new StringBuffer();
 
 


//qrysb.append("   SELECT NVL(STATE_NM,'TOTAL') AS STATE_NM,MAX(STATE_CD) state_cd, COUNT(*) as NO_OF_PRJ,SUM(MMINLAK) AS MMINLAK FROM("      );
qrysb.append(" SELECT NVL(MS.STATE_NM,'TOTAL') AS STATE_NM,MAX(MS.STATE_CD) state_cd, ");
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
qrysb.append("         WHEN bd.ACT_ID = 3"      );
qrysb.append("         AND ad.ACT_ID  = 5 AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_reject,"      );

qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID = 3"      );
qrysb.append("         AND ad.ACT_ID  = 5 AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+FromDt+"' and '"+ToDt+"'"      );
qrysb.append("         THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("       END, 0)) AS bank_reject_mm"      );
qrysb.append("   FROM app_detail ad, bank_dataentry bd, m_district dm, mas_off_mast mom,m_state ms ");
qrysb.append(" where ad.app_id=bd.app_id(+)  ");


qrysb.append(" and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd  ");


qrysb.append(" and ad.off_cd=mom.off_cd and AD.BENF_CATAGORY_CD='ST' group by ROLLUP(MS.STATE_NM)  ");




 

 



String STATE_CD ="";



 DecimalFormat dfd = new DecimalFormat("##.## ");
  DecimalFormat dfn = new DecimalFormat("####");
ResultSet rsinst = db.execSQL(qrysb.toString());
%>

 <table align="center">
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">PMEGP Portal online Performance Report For Scheduled Tribes </div></td>
</tr>
<tr>


<th>From Date </th>
<td><%=FromDt  %></td>
<th>To Date </th>
<td><%=ToDt  %></td>
</tr>
</table>



<table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
<thead>
<tr>
  <th rowspan="2" >Row ID</th>
  <th  rowspan="2">State Nane </th>
  
  <th  rowspan="2" > Applications Forwarded to Bank (in No) </th>
  <th colspan="2" >Sanctioned by Bank </th>
  <th colspan="2" >MM Disbursement </th>
 
  <th colspan="2" ><br />
Applications Returned <br />
by Bank</th>
  <th rowspan="2" >District wise Detail view </th>
</tr>
<tr>


<th >No of <br />
Prj.</th>
<th >MM Involve <br />
(In Lakh)</th>
<th >No of <br />
Prj.</th>
<th  >MM<br />
(In Lakh)</th>
<th >No of <br />
  Prj.</th>
<th >MM Involve <br />
  (In Lakh)</th>
</tr>
</thead>
<tbody>
	<%	
	int srno=0;	
	

	  while (rsinst.next()) { 	
	 
	  

	  
		STATE_NM=rsinst.getString("STATE_NM")==null?"":rsinst.getString("STATE_NM");
	
//NO_OF_PRJ=rsinst.getString("NO_OF_PRJ")==null?"":rsinst.getString("NO_OF_PRJ");
//MMINV=rsinst.getString("MMINLAK")==null?"":rsinst.getString("MMINLAK");
STATE_CD=rsinst.getString("STATE_CD")==null?"":rsinst.getString("STATE_CD");
srno=srno+1;	
%>	




 

<% if (!STATE_NM.equals("TOTAL")){%>
<tr>

 <td><div align="center"><%= srno 	 %></div></td>
 <td><div align="center"><%=STATE_NM  %>	</div></td>
<td><div align="right">
<a href="../jasperrop/nbfcGenReport.jsp?state=<%=STATE_CD%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=5&QRY=1">

      <% out.print(dfd.format(rsinst.getDouble("bank_ford")));%>
 </a></div></td>
  <td>
    <div align="right">
	<a href="../jasperrop/nbfcGenReport.jsp?state=<%=STATE_CD%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=6&QRY=1">
	<% out.print(dfd.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%>
  </div></td>
<td>
    <div align="right">
	<a href="../jasperrop/nbfcGenReport.jsp?state=<%=STATE_CD%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=12&QRY=1"%>
	<% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel_amt")));%>
  </div></td>
  <td><div align="right">
<a href="../jasperrop/nbfcGenReport.jsp?state=<%=STATE_CD%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=7&QRY=1"%>
<% out.print(dfd.format(rsinst.getDouble("bank_reject")));%>
</a></div></td>
  <td><% out.print(dfd.format(rsinst.getDouble("bank_reject_MM")));%></td>
  <th nowrap="nowrap"><a href="districtWiseRepo2.jsp?state=<%=STATE_CD%>&nm=<%=STATE_NM%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>">view</a></th>

 
 
 <!--<td ><a href="../jasperrop/nbfcGenReport.jsp?state=<%=STATE_CD%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRY=1"><%=NO_OF_PRJ  %></td>
<td ><%=MMINV  %>	</td>-->
</TR>
<%}else{%>
	<tr>
 <td><div align="center"><%= srno 	 %></div></td>
 <td><div align="center"><a href="districtWiseRepo2.jsp?state=TOTAL&nm=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>"><%=STATE_NM  %>	</div></td>
<td><div align="right">
<a href="../jasperrop/nbfcGenReport.jsp?state=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=5&QRY=1">

      <% out.print(dfd.format(rsinst.getDouble("bank_ford")));%>
 </a></div></td>
  <td>
    <div align="right"><a href="../jasperrop/nbfcGenReport.jsp?state=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=6&QRY=1"%>
      <% out.print(dfd.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%>
  </div></td>
<td>
    <div align="right">
	<a href="../jasperrop/nbfcGenReport.jsp?state=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=12&QRY=1"%>
	<% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("mm_rel_amt")));%>
  </div></td>
  <td><div align="right">
<a href="../jasperrop/nbfcGenReport.jsp?state=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRYCODE=7&QRY=1"%>
<% out.print(dfd.format(rsinst.getDouble("bank_reject")));%>
</a></div></td>
  <td><div align="right">

<% out.print(dfd.format(rsinst.getDouble("bank_reject_mm")));%>
</div></td>
  <th nowrap="nowrap"><a href="districtWiseRepo2.jsp?state=TOTAL&nm=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>">

view</a></th>

 <!--<td ><a href="../jasperrop/nbfcGenReport.jsp?state=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRY=1"><%=NO_OF_PRJ  %></td>
<td >		</td>-->
</TR>
	

<%
}
 } //end of while
 rsinst.close();
 db.close();
 
 %>	
 </tbody>
</table>

 

</form>


</body>
</html>
