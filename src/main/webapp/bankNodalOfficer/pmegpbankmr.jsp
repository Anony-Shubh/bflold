<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
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

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

</head>

<body>
<%@ include file="IncludeHeader.jsp" %>

<% 

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
String curdt = df.format(now);
String N_IFSL_CODE= session.getAttribute("sIFSL_CODE")==null?"":(String) session.getAttribute("sIFSL_CODE");

 StringBuffer qrysb= new StringBuffer();
String urlrep="../bankpmegpmr/BankRepGenerate.jsp?TODT="+curdt+"&FROMDT=01-JUL-2016&BRNAME="+USER_DESC;

qrysb.append("   SELECT NVL(BBM.HIRONE,'Z TOTAL') AS HIRONE,"      );
qrysb.append("     NVL(BBM.HIRTWO,'X TOTAL') AS HIRTWO,"      );
qrysb.append("     COUNT(DISTINCT (AD.IFSC_CODE))                                                      AS NO_OF_BRANCH,"      );
qrysb.append("     COUNT(AD.APP_ID)                                                                    AS FORD_PRJNO,"      );
qrysb.append("     SUM(ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2))                                        AS FORD_MM,"      );
qrysb.append("     SUM(DECODE(BD.ACT_ID, 3, 1, 0))                                                     AS REJ_NOPRJ,"      );
qrysb.append("     SUM(DECODE(BD.ACT_ID, 3, ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2), 0))               AS REJ_MM,"      );
qrysb.append("     SUM(DECODE(BD.ACT_ID, 8, 1, 0))                                                     AS BANK_UP_NOPRJ,"      );
qrysb.append("     SUM(DECODE(BD.ACT_ID, 8, ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2), 0))               AS UP_MM,"      );
qrysb.append("     SUM(DECODE(BD.ACT_ID, 11, 1, 0))                                                    AS SANC_NOPRJ,"      );
qrysb.append("     SUM(DECODE(BD.ACT_ID, 11, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2), 0))        AS SANC_MM,"      );
qrysb.append("     SUM(DECODE(BD.OWN_CONT_DT, NULL, 0, 1))                                             AS OWN_CONT_NOPRJ,"      );
qrysb.append("     SUM(DECODE(BD.OWN_CONT_DT, NULL, 0, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2))) AS OWN_CONT_MM,"      );
qrysb.append("     SUM(DECODE(BD.IST_LOAN_DT, NULL, 0, 1))                                             AS LOAN_NOPRJ,"      );
qrysb.append("     SUM(DECODE(BD.IST_LOAN_DT, NULL, 0, ROUND(MMINV_BANKADMIT(AD.APP_ID) / 100000, 2))) AS LOAN_MM,"      );
qrysb.append("     SUM(DECODE(BD.EDP_CERT_DT, NULL, 0, 1))                                             AS EDP_NOPRJ,"      );
qrysb.append("     SUM(DECODE(BD.EDP_CERT_DT, NULL, 0, ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2)))       AS EDP_MM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN BD.MM_CLAIM_DT  IS NOT NULL"      );
qrysb.append("       AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("       AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS FB_MM_CLAIM_PRJNO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN BD.MM_CLAIM_DT  IS NOT NULL"      );
qrysb.append("       AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("       AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       THEN ROUND(BD.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END)                                                                  AS FB_MM_CLAIM_AMT,"      );
qrysb.append("     SUM(CASE WHEN BD.ACT_ID=11 AND BD.EDP_CERT_DT IS NULL THEN"      );
qrysb.append("   1"      );
qrysb.append("     ELSE"      );
qrysb.append("   0"      );
qrysb.append("     END) AS EDP_PEND_NO,"      );
qrysb.append("     SUM(CASE WHEN BD.ACT_ID=11 AND BD.EDP_CERT_DT IS NULL THEN"      );
qrysb.append("     ROUND(MMINVOLVE(AD.APP_ID) / 100000, 2)"      );
qrysb.append("     ELSE"      );
qrysb.append("   0"      );
qrysb.append("     END) AS EDP_PEND_MM,"      );
qrysb.append("     "      );
qrysb.append("     SUM(CASE WHEN BD.PACT_ID=30 THEN"      );
qrysb.append("   1"      );
qrysb.append("     ELSE"      );
qrysb.append("   0"      );
qrysb.append("     END) AS REF_PEND_NO,"      );
qrysb.append("     SUM(CASE WHEN BD.PACT_ID=30 THEN"      );
qrysb.append("     ROUND(BD.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("     ELSE"      );
qrysb.append("   0"      );
qrysb.append("     END) AS REF_PEND_MM,"      );
qrysb.append("     "      );
qrysb.append("      SUM( CASE WHEN nvl(BD.PACT_ID,0) NOT IN (30) AND BD.MM_REL_DT IS NULL AND BD.MM_CLAIM_DT  IS NOT NULL AND BD.MM_CLAIM_AMT   > 0 AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("      THEN 1 ELSE 0 END) AS PMEGP_PEND_NO,"      );
qrysb.append("      SUM( CASE WHEN nvl(BD.PACT_ID,0) NOT IN (30) AND BD.MM_REL_DT IS NULL AND BD.MM_CLAIM_DT  IS NOT NULL AND BD.MM_CLAIM_AMT   > 0 AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("      THEN  ROUND(BD.MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS PMEGP_PEND_MM,"      );
qrysb.append("     SUM(DECODE(BD.MM_REL_DT, NULL, 0, 1))                                 AS CORPMM_REL_PRJNO,"      );
qrysb.append("     SUM(DECODE(BD.MM_REL_AMT, NULL, 0, ROUND(BD.MM_REL_AMT / 100000, 2))) AS CORPMM_REL_AMT"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     BANK_BR_MAST BBM"      );
qrysb.append("   WHERE AD.APP_ID      = BD.APP_ID(+)"      );
qrysb.append("   AND MOM.OFF_CD       = AD.OFF_CD"      );
qrysb.append("   AND BBM.BR_IFSL_CODE = AD.IFSC_CODE"      );
qrysb.append("   AND AD.ACT_ID        = 5 AND AD.ACT_YN='Y' "      );
qrysb.append("   AND BBM.N_IFSC_CODE  = '"+N_IFSL_CODE+"'"      );
qrysb.append("   GROUP BY ROLLUP(BBM.HIRONE, BBM.HIRTWO)"      );
qrysb.append("   ORDER BY BBM.HIRONE,BBM.HIRTWO"      );


//out.print (qrysb.toString());

String HIRONE="";
String HIRTWO="";
String BANK_NAME = "";
String NO_OF_BRANCH = "";
String FORD_PRJNO = "";
String FORD_MM = "";
String REJ_NOPRJ = "";
String REJ_MM = "";
String BANK_UP_NOPRJ = "";
String UP_MM = "";
String SANC_NOPRJ = "";
String SANC_MM = "";
String OWN_CONT_NOPRJ = "";
String OWN_CONT_MM = "";
String LOAN_NOPRJ = "";
String LOAN_MM = "";
String EDP_NOPRJ = "";
String EDP_MM = "";
String FB_MM_CLAIM_PRJNO = "";
String FB_MM_CLAIM_AMT = "";
String CORPMM_REL_PRJNO = "";
String CORPMM_REL_AMT = "";

String EDP_PEND_NO="";
String EDP_PEND_MM="";

String REF_PEND_NO="";
String REF_PEND_MM="";

String PMEGP_PEND_NO="";
String PMEGP_PEND_MM="";


DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

//out.print(qrysb.toString());

 %>
 <br>
Report Date:<%= df.format(now)%>
<table align="center" class="bordered" id="tableid">
 <thead>
  <tr>
    <th rowspan="2">SRNO</th>
    <th colspan="2" rowspan="2"><div align="center">NAME </div></th>
    <th colspan="4"><div align="center">Applications Forwarded to Bank </div></th>
    <th colspan="2"><div align="center">Rejected /Returned by Bank </div></th>
    <th colspan="2"><div align="center">Under Process </div></th>
    <th colspan="2"><div align="center">Sanctioned by Bank </div></th>
    <th><div align="center">Own Contribution </div></th>
    <th><div align="center">Loan Released </div></th>
    <th><div align="center">EDP Completed </div></th>
    <th colspan="2"><div align="center">Sanctioned Projects Pending for EDP </div></th>
    <th colspan="2"><div align="center">MM Claimed by Financing Branch </div></th>
    <th colspan="2"><div align="center">MM Claims Under Process at PMEGP </div></th>
    <th colspan="2"><div align="center">MM Claims Referred to Field office KVIC for confirmation </div></th>
    <th colspan="2"><div align="center">MM Disbursed to FB from Corporation Bank </div></th>
    </tr>
  <tr>
    <th colspan="2"><div align="center">No of branches </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Inv.</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Inv.</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Inv.</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Inv.</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">Prj. No </div></th>
    <th>Prj. No </th>
    <th>MM Inv.</th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM </div></th>
    <th>Prj. No </th>
    <th>MM</th>
    <th>Prj. No </th>
    <th>MM</th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM </div></th>
  </tr>
   </thead>
  
<tbody>
<% 
String urladd="";
String vHIRONE="";
String vHIRTWO="";
int srno =0;
 while (rsMain.next()) { 
 urladd="";
 HIRONE=rsMain.getString("HIRONE")==null?"":rsMain.getString("HIRONE");
 HIRTWO=rsMain.getString("HIRTWO")==null?"":rsMain.getString("HIRTWO");
NO_OF_BRANCH=rsMain.getString("NO_OF_BRANCH")==null?"":rsMain.getString("NO_OF_BRANCH");
FORD_PRJNO=rsMain.getString("FORD_PRJNO")==null?"":rsMain.getString("FORD_PRJNO");
FORD_MM=rsMain.getString("FORD_MM")==null?"":rsMain.getString("FORD_MM");
REJ_NOPRJ=rsMain.getString("REJ_NOPRJ")==null?"":rsMain.getString("REJ_NOPRJ");
REJ_MM=rsMain.getString("REJ_MM")==null?"":rsMain.getString("REJ_MM");
BANK_UP_NOPRJ=rsMain.getString("BANK_UP_NOPRJ")==null?"":rsMain.getString("BANK_UP_NOPRJ");
UP_MM=rsMain.getString("UP_MM")==null?"":rsMain.getString("UP_MM");
SANC_NOPRJ=rsMain.getString("SANC_NOPRJ")==null?"":rsMain.getString("SANC_NOPRJ");
SANC_MM=rsMain.getString("SANC_MM")==null?"":rsMain.getString("SANC_MM");
OWN_CONT_NOPRJ=rsMain.getString("OWN_CONT_NOPRJ")==null?"":rsMain.getString("OWN_CONT_NOPRJ");
OWN_CONT_MM=rsMain.getString("OWN_CONT_MM")==null?"":rsMain.getString("OWN_CONT_MM");
LOAN_NOPRJ=rsMain.getString("LOAN_NOPRJ")==null?"":rsMain.getString("LOAN_NOPRJ");
LOAN_MM=rsMain.getString("LOAN_MM")==null?"":rsMain.getString("LOAN_MM");
EDP_NOPRJ=rsMain.getString("EDP_NOPRJ")==null?"":rsMain.getString("EDP_NOPRJ");
EDP_MM=rsMain.getString("EDP_MM")==null?"":rsMain.getString("EDP_MM");
FB_MM_CLAIM_PRJNO=rsMain.getString("FB_MM_CLAIM_PRJNO")==null?"":rsMain.getString("FB_MM_CLAIM_PRJNO");
FB_MM_CLAIM_AMT=rsMain.getString("FB_MM_CLAIM_AMT")==null?"":rsMain.getString("FB_MM_CLAIM_AMT");
CORPMM_REL_PRJNO=rsMain.getString("CORPMM_REL_PRJNO")==null?"":rsMain.getString("CORPMM_REL_PRJNO");
CORPMM_REL_AMT=rsMain.getString("CORPMM_REL_AMT")==null?"":rsMain.getString("CORPMM_REL_AMT");

 EDP_PEND_NO=rsMain.getString("EDP_PEND_NO")==null?"":rsMain.getString("EDP_PEND_NO");
 EDP_PEND_MM=rsMain.getString("EDP_PEND_MM")==null?"":rsMain.getString("EDP_PEND_MM");
 REF_PEND_NO=rsMain.getString("REF_PEND_NO")==null?"":rsMain.getString("REF_PEND_NO");
 REF_PEND_MM=rsMain.getString("REF_PEND_MM")==null?"":rsMain.getString("REF_PEND_MM");
 PMEGP_PEND_NO=rsMain.getString("PMEGP_PEND_NO")==null?"":rsMain.getString("PMEGP_PEND_NO");
 PMEGP_PEND_MM=rsMain.getString("PMEGP_PEND_MM")==null?"":rsMain.getString("PMEGP_PEND_MM");

srno =srno+1;

vHIRONE=HIRONE.equals("Z TOTAL")?"":HIRONE;
vHIRTWO=HIRTWO.equals("X TOTAL")?"":HIRTWO;

urladd=urlrep+"&HIRONE="+vHIRONE+"&HIRTWO="+vHIRTWO;
%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><%= HIRONE %></td>
     <td><%= HIRTWO %></td>
    <td>
      <div align="center"><%=NO_OF_BRANCH  %></div></td>
    <td ><a href="<%= urladd %>&QCODE=0" target="_blank"><img src="../images/excelicondownload.png" height="12%" border="0" title="download Applicant detail in Excel format"></a></td>
    <td><div align="center"><%= FORD_PRJNO %></div></td>
    <td><div align="center"><%= FORD_MM  %></div></td>
    <td><div align="center"><%= REJ_NOPRJ  %></div></td>
    <td><div align="center"><%= REJ_MM %></div></td>
    <td><div align="center"><%= BANK_UP_NOPRJ  %></div></td>
    <td><div align="center"><%= UP_MM  %></div></td>
    <td><div align="center"><%=SANC_NOPRJ  %></div></td>
    <td><div align="center"><%=SANC_MM  %></div></td>
    <td><div align="center"><%=OWN_CONT_NOPRJ  %></div></td>
    <td><div align="center"><%= LOAN_NOPRJ %></div></td>
    <td><div align="center"><%= EDP_NOPRJ %></div></td>
    <td><%= EDP_PEND_NO %></td>
    <td><%= EDP_PEND_MM %></td>
    <td><div align="center"><%= FB_MM_CLAIM_PRJNO %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_AMT %></div></td>
	<td><%= PMEGP_PEND_NO %></td>
	<td><%= PMEGP_PEND_NO %></td>
	<td><%= REF_PEND_NO %></td>
	<td><%= REF_PEND_MM %></td>
	<td>
      <div align="center"><%= CORPMM_REL_PRJNO %>
      </div></td>
	    <td><div align="center"><%= CORPMM_REL_AMT %></div></td>
  </tr>
  
   <%  }
  rsMain.close();
  db.close();
    %>
	</tbody>
</table>

</body>
</html>
