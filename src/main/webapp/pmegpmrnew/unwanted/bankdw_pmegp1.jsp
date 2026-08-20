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

<html>
<head>
<title>PMEGP Performance Bank Detail</title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<style>
body {
  font: normal medium/1.4 sans-serif;
}
table {
  border-collapse: collapse;
  width: 100%;
}
th, td {
  padding: 0.25rem;
  text-align: left;
  border: 1px solid #ccc;
}
tbody tr:nth-child(odd) {
  background: #eee;
}
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

out.print ("<center>PMEGP e-Portal System</center>");

 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT NVL(DECODE(ad.BANK_NAME, NULL, 'Total', ad.BANK_NAME), 'Total') AS bank_name,"      );
qrysb.append("     COUNT(DISTINCT(AD.IFSC_CODE))                                                      AS NO_OF_BRANCH,"      );
qrysb.append("       COUNT(AD.APP_ID) AS bank_ford,"      );
qrysb.append("       SUM(ROUND(mminvolve(ad.APP_ID) / 100000, 2)) AS bankfordmminv,"      );
qrysb.append("       SUM(DECODE(BD.ACT_ID, 3, 1, 0))                                                     AS bank_reject,"      );
qrysb.append("       SUM(DECODE(BD.ACT_ID, 3, ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2), 0))               AS bank_rej_mm,"      );
qrysb.append("       SUM(CASE WHEN NVL(BD.ACT_ID,0) NOT IN (3,11) THEN 1 ELSE 0 END) pend_bank_sanc,"      );
qrysb.append("       SUM(CASE WHEN NVL(BD.ACT_ID,0) NOT IN (3,11) THEN  ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2) ELSE 0 END) pend_bank_sanc_mm,"      );
qrysb.append("        SUM(DECODE(BD.ACT_ID, 11, 1, 0)) AS bank_sanc,"      );
qrysb.append("        SUM(DECODE(BD.ACT_ID, 11, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2), 0)) bank_sanc_mm,"      );
qrysb.append("       SUM(DECODE(BD.OWN_CONT_DT, NULL, 0, 1))                                             AS OWN_CONT_NOPRJ,"      );
qrysb.append("       SUM(DECODE(BD.OWN_CONT_DT, NULL, 0, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2))) AS OWN_CONT_MM,"      );
qrysb.append("       SUM(DECODE(BD.IST_LOAN_DT, NULL, 0, 1))                                             AS LOAN_NOPRJ,"      );
qrysb.append("       SUM(DECODE(BD.IST_LOAN_DT, NULL, 0, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2))) AS LOAN_MM,"      );
qrysb.append("       SUM(DECODE(BD.EDP_CERT_DT, NULL, 0, 1))                                             AS EDP_NOPRJ,"      );
qrysb.append("       SUM(DECODE(BD.EDP_CERT_DT, NULL, 0, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2)))       AS EDP_MM,"      );
qrysb.append("        SUM(CASE WHEN BD.ACT_ID=11 AND BD.EDP_CERT_DT IS NULL THEN 1 ELSE 0 END) AS EDP_PEND_NO,"      );
qrysb.append("          SUM(CASE WHEN BD.ACT_ID=11 AND BD.EDP_CERT_DT IS NULL THEN ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2) ELSE 0 END) AS EDP_PEND_MM,"      );
qrysb.append("       SUM(NVL( CASE WHEN TRUNC(bd.MM_CLAIM_AMT) >0 AND  BD.MM_CLAIM_DT  IS NOT NULL AND  BD.LOAN_DOCFNAME IS NOT NULL THEN 1 END, 0)) AS mm_claim,"      );
qrysb.append("        SUM(NVL( CASE WHEN TRUNC(bd.MM_CLAIM_AMT) >0 AND  BD.MM_CLAIM_DT  IS NOT NULL "      );
qrysb.append("        AND  BD.LOAN_DOCFNAME IS NOT NULL THEN ROUND( NVL(bd.MM_CLAIM_AMT,0)/100000,2) END, 0)) AS mm_claim_MM,"      );
qrysb.append("         SUM(CASE WHEN BD.PACT_ID=30 THEN 1 ELSE 0 END) AS REF_PEND_NO,"      );
qrysb.append("          SUM(CASE WHEN BD.PACT_ID=30 THEN ROUND( NVL(bd.MM_CLAIM_AMT,0)/100000,2) ELSE 0 END) AS REF_PEND_MM,"      );
qrysb.append("           SUM( CASE WHEN nvl(BD.PACT_ID,0) NOT IN (30) AND BD.MM_REL_DT IS NULL AND BD.MM_CLAIM_DT  IS NOT NULL AND BD.MM_CLAIM_AMT   > 0 "      );
qrysb.append("           AND BD.LOAN_DOCFNAME IS NOT NULL THEN 1 ELSE 0 END) AS PMEGP_PEND_NO,"      );
qrysb.append("            SUM( CASE WHEN nvl(BD.PACT_ID,0) NOT IN (30) AND BD.MM_REL_DT IS NULL AND BD.MM_CLAIM_DT  IS NOT NULL AND BD.MM_CLAIM_AMT   > 0 "      );
qrysb.append("           AND BD.LOAN_DOCFNAME IS NOT NULL THEN  ROUND(NVL(bd.MM_CLAIM_AMT,0)/100000,2) ELSE 0 END) AS PMEGP_PEND_MM,"      );
qrysb.append("       SUM(NVL(CASE WHEN TRUNC(bd.MM_REL_DT) IS NOT NULL THEN 1 END, 0)) AS mm_rel,"      );
qrysb.append("       SUM(NVL( CASE WHEN TRUNC(bd.MM_REL_DT)IS NOT NULL AND bd.ACT_ID = 11 THEN ROUND(bd.MM_REL_AMT / 100000, 2) END, 0)) AS mm_rel_amt"      );
qrysb.append("     FROM app_detail ad,"      );
qrysb.append("       bank_dataentry bd,"      );
qrysb.append("       m_district dm,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE "      );
qrysb.append("      AD.ACT_ID=5"      );
qrysb.append("     AND ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("     AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("     AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("     AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("     AND ms.ZONE_CD      = ZM.ZONE_CD"      );
qrysb.append("    "+txtSearch+" "      );
qrysb.append("     AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );
qrysb.append("     GROUP BY ROLLUP(DECODE(ad.BANK_NAME, NULL, 'Total', ad.BANK_NAME))"      );




ResultSet rsinst = db.execSQL(qrysb.toString());
try{
%>
<table align="center"  >
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
<div align="center">(Prj. in No and MM in Lakhs) <br />
 </div>
<table border="1" id="tableid">
<thead>
<tr>
  <th rowspan="2"><div align="center">Row<br />
    ID</div></th>
  <th rowspan="2" > <div align="center">Name</div></th>
  <th colspan="2" ><div align="center">Fordwarded to Bank </div></th>
  <th colspan="2" ><div align="center">Rejected / Returned <br />
  by Bank</div></th>
  <th colspan="2" ><div align="center">Sanctioned by Bank </div></th>
  <th colspan="2" ><div align="center">Pending with Bank </div></th>
  <th colspan="2" ><div align="center">Own Contribution Deposited </div></th>
  <th colspan="2" ><div align="center">Loan Disbursed </div></th>
  <th colspan="2" ><div align="center">EDP Training Completed </div></th>
  <th colspan="2" ><div align="center">Pending for EDP Training </div></th>
  <th colspan="2" ><div align="center">MM Claimed </div></th>
  <th colspan="2" ><div align="center">MM Claims Under Process at CO, KVIC Mumbai </div></th>
  <th colspan="2" ><div align="center">Referred to Field Offices for Confirmation </div></th>
  <th colspan="2" ><div align="center">MM Disbused to FB from Corp Bank </div></th>
  </tr>
<tr>
<th ><div align="center"><br /> 
    Prj.
</div></th>
<th ><div align="center">MM Inv.<br /> 
    </div></th>
<th ><div align="center"><br />
    Prj.</div></th>
<th ><div align="center">MM Inv.<br />
    </div></th>
<th ><div align="center"><br />
  Prj.</div></th>
<th ><div align="center">MM Inv.<br />
  </div></th>
<th ><div align="center"><br />
  Prj.</div></th>
<th ><div align="center">MM<br />
  </div></th>
<th ><div align="center"><br />
  Prj.</div></th>
<th ><div align="center">MM Inv. <br />
  </div></th>
<th ><div align="center"><br />
    Prj. </div></th>
<th ><div align="center">MM Inv.</div></th>
<th ><div align="center">Prj.</div></th>
<th ><div align="center">MM Inv.</div></th>
<th ><div align="center">Prj.</div></th>
<th ><div align="center">MM Inv.</div></th>
<th ><div align="center">Prj.</div></th>
<th ><div align="center">MM </div></th>
<th ><div align="center">Prj.</div></th>
<th ><div align="center">MM </div></th>
<th ><div align="center">Prj.</div></th>
<th ><div align="center">MM </div></th>
<th ><div align="center">Prj. </div></th>
<th ><div align="center">MM<br />
</div></th>
</tr>
</thead>
<tbody>
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
 %>
	 
     <tr>
	 
<td><div align="center"><%=srn%>)</div></td>
<td >
  <div align="left"><%= rsinst.getString("bank_name") %></div></td>
<td><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=5"%>">

      <% out.print(dfd.format(rsinst.getDouble("bank_ford")));%>
 </a></div></td>
  <td>
    <div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bankfordmminv")));%>
</div></td>
  <td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=7"%>">
    <% out.print(dfd.format(rsinst.getDouble("bank_reject")));%>
  </a></td>
  <td><% out.print(dfd.format(rsinst.getDouble("bank_rej_mm")));%></td>
  <td>
    <div align="right">
	<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">

      <% out.print(dfd.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td><td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%>
  </div></td>
<td><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=11"%>"></a><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
<% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc")));%>
</a></div></td>
<td>
    <div align="right"><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
      <% out.print(dfd.format(rsinst.getDouble("pend_bank_sanc_mm")));%>
    </a></div></td>
<td>
    <div align="right">
	<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=12"%>"></a><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
	<% out.print(dfd.format(rsinst.getDouble("OWN_CONT_NOPRJ")));%>
	</a></div></td><td><div align="right"><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
	<% out.print(dfd.format(rsinst.getDouble("OWN_CONT_MM")));%>
	</a>
  </div></td>
<td><div align="right">
<a href="dwstatewise.jsp?<%=p3+"&QRYCODE=7"%>"></a><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
<% out.print(dfd.format(rsinst.getDouble("LOAN_NOPRJ")));%>
</a></div></td>
<td><div align="right"><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("LOAN_MM")));%>
</a></a></div></td>
<td><div align="right"> <a href="dwstatewise.jsp?<%=p3+"&QRYCODE=7"%>"></a><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
    <% out.print(dfd.format(rsinst.getDouble("EDP_NOPRJ")));%>
</a></div></td>
<td><div align="right"><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
    <% out.print(dfd.format(rsinst.getDouble("EDP_MM")));%>
</a></div></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("EDP_PEND_NO")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("EDP_PEND_MM")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("MM_CLAIM")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("MM_CLAIM_MM")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("PMEGP_PEND_NO")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("PMEGP_PEND_MM")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("REF_PEND_NO")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("REF_PEND_MM")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("mm_rel")));%>
</a></td>
<td><a href="dwstatewise.jsp?<%=p3+"&QRYCODE=6"%>">
  <% out.print(dfd.format(rsinst.getDouble("mm_rel_AMT")));%>
</a></td>
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
