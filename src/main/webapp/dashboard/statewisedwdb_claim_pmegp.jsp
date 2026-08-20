<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

</head>

<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">

<% 

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT NVL(MOM.OFF_NAME1, 'Z TOTAL')                                                  AS BANK_NAME,"      );
qrysb.append("      SUM("      );
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
qrysb.append("     END) AS FB_MM_CLAIM_AMT,"      );
qrysb.append("       SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN BD.PACT_ID = 30"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS REF_PEND_NO,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN BD.PACT_ID = 30"      );
qrysb.append("       THEN ROUND(BD.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS REF_PEND_MM,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NVL(BD.PACT_ID, 0) NOT IN (30,32)"      );
qrysb.append("       AND BD.MM_REL_DT            IS NULL"      );
qrysb.append("       AND BD.MM_CLAIM_DT          IS NOT NULL"      );
qrysb.append("       AND BD.MM_CLAIM_AMT          > 0"      );
qrysb.append("       AND BD.LOAN_DOCFNAME        IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PMEGP_PEND_NO,"      );
qrysb.append("    "      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NVL(BD.PACT_ID, 0) NOT IN (30,32) "      );
qrysb.append("       AND BD.MM_REL_DT            IS NULL"      );
qrysb.append("       AND BD.MM_CLAIM_DT          IS NOT NULL"      );
qrysb.append("       AND BD.MM_CLAIM_AMT          > 0"      );
qrysb.append("       AND BD.LOAN_DOCFNAME        IS NOT NULL"      );
qrysb.append("       THEN ROUND(BD.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END)                                                                  AS PMEGP_PEND_MM,"      );
qrysb.append("      SUM(DECODE (BD.PACT_ID,32,1,0)) AS RECOM_PAYMENT,"      );
qrysb.append("       SUM(DECODE (BD.PACT_ID,32,ROUND(BD.MM_CLAIM_AMT / 100000, 2),0)) AS RECOM_PAYMENT_MM,"      );
qrysb.append("     SUM(DECODE(BD.MM_REL_DT, NULL, 0, 1))                                 AS CORPMM_REL_PRJNO,"      );
qrysb.append("     SUM(DECODE(BD.MM_REL_AMT, NULL, 0, ROUND(BD.MM_REL_AMT / 100000, 2))) AS CORPMM_REL_AMT"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     BANK_BR_MAST BBM"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND MOM.OFF_CD        = AD.OFF_CD"      );
qrysb.append("   AND BBM.BR_IFSL_CODE  = AD.IFSC_CODE"      );
qrysb.append("   AND AD.ACT_ID         = 5"      );
qrysb.append("   AND BD.ACT_ID         = 11"      );
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN TRUNC(SYSDATE-300) AND TRUNC(SYSDATE)"      );
qrysb.append("   GROUP BY ROLLUP(MOM.OFF_NAME1)"      );
qrysb.append("   ORDER BY MOM.OFF_NAME1"      );

//out.print (qrysb.toString());

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
String RECOM_PAYMENT="";
String RECOM_PAYMENT_MM="";

DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<center>
  <h1> Margin Money (MM) Claim Status at Bank 01 July,2016 to <%= curdt %>
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2">SRNO</th>
    <th rowspan="2"><div align="center">Name </div></th>
    <th colspan="2"><div align="center">MM Claimed </div></th>
    <th colspan="2">MM Claims Under Process at KVIC,CO,Mumbai </th>
    <th colspan="2">Referred to KVIC Field Offices for Rectification </th>
    <th colspan="2">Recommended for MM Release by PMEGP </th>
    <th colspan="2"><div align="center">MM Disbursed </div></th>
	<th rowspan="2">VIEW DETAIL</th>
    </tr>
  <tr>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM </div></th>
    <th>Prj. No </th>
    <th><div align="center">MM Inv.</div></th>
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
RECOM_PAYMENT=rsMain.getString("RECOM_PAYMENT")==null?"":rsMain.getString("RECOM_PAYMENT");
RECOM_PAYMENT_MM=rsMain.getString("RECOM_PAYMENT_MM")==null?"":rsMain.getString("RECOM_PAYMENT_MM");
 REF_PEND_NO=rsMain.getString("REF_PEND_NO")==null?"":rsMain.getString("REF_PEND_NO");
 REF_PEND_MM=rsMain.getString("REF_PEND_MM")==null?"":rsMain.getString("REF_PEND_MM");
 PMEGP_PEND_NO=rsMain.getString("PMEGP_PEND_NO")==null?"":rsMain.getString("PMEGP_PEND_NO");
 PMEGP_PEND_MM=rsMain.getString("PMEGP_PEND_MM")==null?"":rsMain.getString("PMEGP_PEND_MM");

srno =srno+1;
%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"><%= BANK_NAME %></a></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_PRJNO %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_AMT %></div></td>
	<td><%= PMEGP_PEND_NO %></td>
	<td><%= PMEGP_PEND_MM %></td>
	<td><%= REF_PEND_NO %></td>
	<td><%= REF_PEND_MM %></td>
	<td><%= RECOM_PAYMENT %></td>
	<td><%= RECOM_PAYMENT_MM %></td>
	<td><%= CORPMM_REL_PRJNO %></td>
	<td><div align="center"><%= CORPMM_REL_AMT %></div></td>
	<td><a href="../jasperrop/jaspergen_mmdetailreport.jsp?OFF_NAME=<%= BANK_NAME %>" target="_parent" class="button1">View Detail</a></td>
  </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
</table>

</body>
</html>
