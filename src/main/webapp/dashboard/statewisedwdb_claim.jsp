<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="kvic.inputvalid.*"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

<style type="text/css">
<!--
.style1 {font-size: 12px}
-->
</style>
</head>

<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">

<% 
jspinputvalid js = new jspinputvalid();
String YR=request.getParameter("YR")==null?"%%":(String) js.getOnlyTextspc(request.getParameter("YR"),7);
String vcls="";
if (YR.equals("2016-17")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2016' and '31-MAR-2017' ";
}

if (YR.equals("2017-18")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2017' and '31-MAR-2018' ";
}
if (YR.equals("2018-19")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2018' and '31-MAR-2019' ";
}
if (YR.equals("2019-20")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2019' and '31-MAR-2020' ";
}
if (YR.equals("2020-21")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2020' and '31-MAR-2021' ";
}

if (YR.equals("2021-22")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2021' and '31-MAR-2022' ";
}


if (YR.equals("2022-23")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2022' and '31-MAR-2023' ";
}
if (YR.equals("2023-24")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2023' and '31-MAR-2024' ";
}

if (YR.equals("2024-25")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2024' and '31-MAR-2025' ";
}

if (YR.equals("2025-26")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2025' and TRUNC(SYSDATE) ";
}

if (YR.equals("TOTAL")) {
vcls=" TRUNC(bd.MM_CLAIM_DT) BETWEEN '1-APR-2016' and TRUNC(SYSDATE) ";
}
Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);
String wcls="";
if (YR.equals("2016-17")) {
wcls=" 1-JULY-2016 TO 31-MARCH-2017 ";
}

if (YR.equals("2017-18")) {
wcls=" 1-APRIL-2017 TO 31-MARCH-2018 ";
}
if (YR.equals("2018-19")) {
wcls=" 1-APRIL-2018 TO 31-MARCH-2019 ";
}

if (YR.equals("2019-20")) {
wcls=" 1-APRIL-2019 TO "+curdt+" ";
}
if (YR.equals("2019-20")) {
wcls=" 1-APRIL-2019 TO 31-MARCH-2020 ";}


if (YR.equals("2020-21")) {
wcls=" 1-APRIL-2020 TO 31-MAR-2021 ";
}

if (YR.equals("2021-22")) {
wcls=" 1-APRIL-2021 TO 31-MAR-2022 ";
}

if (YR.equals("2022-23")) {
wcls=" 1-APRIL-2022 TO 31-MAR-2023 ";
}

if (YR.equals("2023-24")) {
wcls=" 1-APRIL-2023 TO 31-MAR-2024 ";
}

if (YR.equals("2024-25")) {
wcls=" 1-APRIL-2024 TO 31-MAR-2025 ";
}

if (YR.equals("2025-26")) {
wcls=" 1-APRIL-2025 TO "+curdt+" ";
}

if (YR.equals("TOTAL")) {
wcls=" 1-APRIL-2016 TO "+curdt+" ";
}
 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT NVL(AD.BANK_NAME,'Z TOTAL') AS BANK_NAME,"      );
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
qrysb.append("      SUM( CASE WHEN nvl(BD.PACT_ID,0)=0 "      );
qrysb.append("      THEN 1 ELSE 0 END) AS PMEGP_PEND_NO,"      );

qrysb.append("      SUM( CASE WHEN nvl(BD.PACT_ID,0)=0 "      );
qrysb.append("      THEN  ROUND(BD.MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS PMEGP_PEND_MM,"      );
qrysb.append("      SUM( CASE WHEN nvl(BD.PACT_ID,0)=32 "      );

qrysb.append("      THEN 1 ELSE 0 END) AS PMEGP_RECOM_NO,"      );
qrysb.append("      SUM( CASE WHEN nvl(BD.PACT_ID,0)=32 "      );
qrysb.append("      THEN  ROUND(BD.MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS PMEGP_RECOM_MM,"      );

qrysb.append("     SUM(DECODE(BD.MM_REL_DT, NULL, 0, 1))                                 AS CORPMM_REL_PRJNO,"      );
qrysb.append("     SUM(DECODE(BD.MM_REL_AMT, NULL, 0, ROUND(BD.MM_REL_AMT / 100000, 2))) AS CORPMM_REL_AMT"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     BANK_BR_MAST BBM"      );
qrysb.append("   WHERE AD.APP_ID      = BD.APP_ID(+)"      );
qrysb.append("   AND MOM.OFF_CD       = AD.OFF_CD"      );
qrysb.append("   AND BBM.BR_IFSL_CODE = AD.IFSC_CODE"      );
qrysb.append("   AND AD.ACT_ID        = 5   and "+vcls+"  "      );
qrysb.append("   AND bd.act_id=11 AND bd.loan_docfname IS NOT NULL AND bd.MM_CLAIM_AMT>0 AND "+vcls+" "      );
qrysb.append("   GROUP BY ROLLUP(AD.BANK_NAME)"      );
qrysb.append("   ORDER BY AD.BANK_NAME"      );

//out.print(qrysb.toString());

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

String PMEGP_RECOM_NO="";
String PMEGP_RECOM_MM="";
DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<center>
  <h1> Margin Money (MM) Claim Status at Bank From <%=wcls%>
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a><span class="style1"> (Rs. in Lakhs) </span></h1>
</center>

<table id="tableid" align="center" class="bordered">
 <thead>
  <tr bgcolor="#FCDCF4">
    <td width="4%" rowspan="2">SRNO</td>
    <td width="20%" rowspan="2" bgcolor="#FCDCF4"><div align="center">Bank Name </div></td>
    <td colspan="2"><div align="center">MM Claimed </div></td>
    <td colspan="2"><div align="center">MM Recommended for MM Release </div></td>
    <td colspan="2"><div align="center">MM Claims Under Process </div></td>
    <td colspan="2"><div align="center">Referred to KVIC Field Offices for Rectification </div></td>
    <td colspan="2"><div align="center">MM Disbursed </div></td>
    </tr>
  <tr>
    <td width="5%" bgcolor="#FCDCF4"><div align="center">Nos. of Prj.</div></td>
    <td width="6%" bgcolor="#FCDCF4"><div align="center">MM </div></td>
    <td width="8%" bgcolor="#FCDCF4"><div align="center">Nos. of Prj.</div></td>
    <td width="9%" bgcolor="#FCDCF4"><div align="center">MM </div></td>
    <td width="8%" bgcolor="#FCDCF4"><div align="center">Nos. of Prj.</div></td>
    <td width="7%" bgcolor="#FCDCF4"><div align="center">MM </div></td>
    <td width="10%" bgcolor="#FCDCF4"><div align="center">Nos. of Prj.</div></td>
    <td width="8%" bgcolor="#FCDCF4"><div align="center">MM </div></td>
    <td width="6%" bgcolor="#FCDCF4">Nos. of Prj.</td>
    <td width="9%" bgcolor="#FCDCF4"><div align="center">MM Inv.</div></td>
  </tr>
   </thead>
  
<tbody>
<% 

int srno =0;
 while (rsMain.next()) { 
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");

FB_MM_CLAIM_PRJNO=rsMain.getString("FB_MM_CLAIM_PRJNO")==null?"":rsMain.getString("FB_MM_CLAIM_PRJNO");
FB_MM_CLAIM_AMT=rsMain.getString("FB_MM_CLAIM_AMT")==null?"":rsMain.getString("FB_MM_CLAIM_AMT");
CORPMM_REL_PRJNO=rsMain.getString("CORPMM_REL_PRJNO")==null?"":rsMain.getString("CORPMM_REL_PRJNO");
CORPMM_REL_AMT=rsMain.getString("CORPMM_REL_AMT")==null?"":rsMain.getString("CORPMM_REL_AMT");


 REF_PEND_NO=rsMain.getString("REF_PEND_NO")==null?"":rsMain.getString("REF_PEND_NO");
 REF_PEND_MM=rsMain.getString("REF_PEND_MM")==null?"":rsMain.getString("REF_PEND_MM");
 PMEGP_PEND_NO=rsMain.getString("PMEGP_PEND_NO")==null?"":rsMain.getString("PMEGP_PEND_NO");
 PMEGP_PEND_MM=rsMain.getString("PMEGP_PEND_MM")==null?"":rsMain.getString("PMEGP_PEND_MM");
 
 PMEGP_RECOM_NO=rsMain.getString("PMEGP_RECOM_NO")==null?"":rsMain.getString("PMEGP_RECOM_NO");
 PMEGP_RECOM_MM=rsMain.getString("PMEGP_RECOM_MM")==null?"":rsMain.getString("PMEGP_RECOM_MM");

srno =srno+1;
%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"><a href="statewisedwdb_claim_dw.jsp?bankname=<%= BANK_NAME %>&YR=<%=YR%>" target="_parent"><%= BANK_NAME %></a></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_PRJNO %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_AMT %></div></td>
	<td><%= PMEGP_RECOM_NO %></td>
	<td><%= PMEGP_RECOM_MM %></td>
	<td><%= PMEGP_PEND_NO %></td>
	<td><%= PMEGP_PEND_MM %></td>
	<td><%= REF_PEND_NO %></td>
	<td><%= REF_PEND_MM %></td>
	<td><%= CORPMM_REL_PRJNO %></td>
	<td><div align="right"><%= CORPMM_REL_AMT %></div></td>
  </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
</table>

</body>
</html>
