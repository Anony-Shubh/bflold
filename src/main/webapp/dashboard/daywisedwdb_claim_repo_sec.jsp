<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

<style type="text/css">
<!--
.style1 {
	color: #804000;
	font-size: 16px;
}
.style2 {color: #0000A0}
-->
</style>
</head>

<body>
<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<%
String YR=request.getParameter("YR")==null?"%%":(String) request.getParameter("YR");
String vcls="";
if (YR.equals("201819")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2018' and '31-MAR-2019' ";
}

if (YR.equals("201920")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2019' and '31-MAR-2020' ";
}
if (YR.equals("202021")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2020' and '31-MAR-2021' ";
}

if (YR.equals("202122")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2021' and '31-MAR-2022' ";
}
if (YR.equals("202223")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2022' and '31-MAR-2023' ";
}
if (YR.equals("202324")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2023' and '31-MAR-2024' ";
}
if (YR.equals("202425")) {
vcls=" WHERE PROC_DT BETWEEN '1-APR-2024' and SYSDATE ";
}


Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);
String wcls="";
if (YR.equals("201819")) {
wcls=" 1-APR-2018 TO 31-MARCH-2019 ";
}

if (YR.equals("201920")) {
wcls=" 1-APRIL-2019 TO 31-MARCH-2020";
}

if (YR.equals("202021")) {
wcls=" 1-APRIL-2020 TO 31-MARCH-2021 ";
}

if (YR.equals("202122")) {
wcls=" 1-APRIL-2021 TO '31-MAR-2022' ";
}
if (YR.equals("202223")) {
wcls=" 1-APRIL-2022 TO '31-MAR-2023' ";
}
if (YR.equals("202324")) {
wcls=" 1-APRIL-2023 TO  '31-MAR-2024' ";
}

if (YR.equals("202425")) {
wcls=" 1-APRIL-2024 TO "+curdt+" ";
}
 StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT TO_CHAR(PROC_DT, 'DD-MON-YYYY') AS PROC_DT,"      );
qrysb.append("     SUM(MM_CLAIM_NO)                     AS TOTAL_CLAIM,"      );
qrysb.append("     SUM(MM_CLAIM_AMT)                    AS MM_CLAIM_AMT,"      );
qrysb.append("     SUM(REF_CL)                          AS REF_CL,"      );
qrysb.append("     SUM(REF_CL_MM)                       AS REF_CL_MM,"      );
qrysb.append("     SUM(RECOM_CL)                        AS RECOM_CL,"      );
qrysb.append("     SUM(RECOM_MM)                        AS RECOM_MM,"      );
qrysb.append("     SUM(MM_REL_NO)                       AS MM_DISB,"      );
qrysb.append("     SUM(MM_REL_AMT)                      AS MM_DISB_MM,"      );
qrysb.append("     SUM(CLAIM_UP_NO)                     AS PENDING_CL,"      );
qrysb.append("     SUM(CLAIM_UP_MM)                     AS PENDING_CL_MM"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT TRUNC(BANK_DATAENTRY_SECOND.MM_CLAIM_DT) AS PROC_DT,"      );
qrysb.append("       COUNT(                                *)                                AS MM_CLAIM_NO,"      );
qrysb.append("       SUM(ROUND(BANK_DATAENTRY_SECOND.MM_CLAIM_AMT / 100000, 2))                     AS MM_CLAIM_AMT,"      );
qrysb.append("       0                                                                       AS REF_CL,"      );
qrysb.append("       0                                                                       AS REF_CL_MM,"      );
qrysb.append("       0                                                                       AS RECOM_CL,"      );
qrysb.append("       0                                                                       AS RECOM_MM,"      );
qrysb.append("       0                                                                       AS MM_REL_NO,"      );
qrysb.append("       0                                                                       AS MM_REL_AMT,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BANK_DATAENTRY_SECOND.PACT_ID IS NULL"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS CLAIM_UP_NO,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BANK_DATAENTRY_SECOND.PACT_ID IS NULL"      );
qrysb.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS CLAIM_UP_MM"      );
qrysb.append("     FROM BANK_DATAENTRY_SECOND"      );
qrysb.append("     WHERE BANK_DATAENTRY_SECOND.MM_CLAIM_AMT > 0"      );
qrysb.append("     AND BANK_DATAENTRY_SECOND.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("     GROUP BY TRUNC(BANK_DATAENTRY_SECOND.MM_CLAIM_DT)"      );
qrysb.append("     UNION"      );
qrysb.append("     SELECT TRUNC(PROC_DT) AS PROC_DT,"      );
qrysb.append("       0                   AS MM_CLAIM_NO,"      );
qrysb.append("       0                   AS MM_CLAIM_AMT,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ACT_ID = 30"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS REF_CL,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ACT_ID = 30"      );
qrysb.append("         THEN ROUND(MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS REF_CL_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ACT_ID = 32"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS RECOM_CL,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ACT_ID = 32"      );
qrysb.append("         THEN ROUND(MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS RECOM_MM,"      );
qrysb.append("       0 MM_REL_NO,"      );
qrysb.append("       0 MM_REL_AMT,"      );
qrysb.append("       0,"      );
qrysb.append("   0"      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT MOM.OFF_NAME1       AS AGENCY_STATE,"      );
qrysb.append("         AD.APP_ID                 AS PMEGP_APPLICANTION_ID,"      );
qrysb.append("         AD.APP_NAME               AS APPLICANT_NAME,"      );
qrysb.append("         BD.IFSC_CODE              AS IFSC_CODE,"      );
qrysb.append("         BD.FB_ACNO                AS TRANSIENT_ACCNT_NO,"      );
qrysb.append("         TO_CHAR(BD.APPLOAN_ACCNO) AS LOAN_ACCOUNT_NUMBER,"      );
qrysb.append("         BD.MM_CLAIM_AMT           AS MARGIN_MONEY_CLAIMED_AMOUNT,"      );
qrysb.append("         MRT.CO_REMARKS,"      );
qrysb.append("         TRUNC(MRT.PROC_DT)                                AS PROC_DT,"      );
qrysb.append("         TRUNC(BD.MM_CLAIM_DT)                             AS MM_CLAIM_DT,"      );
qrysb.append("         NVL(BAS.ACT_ID, 0)                                AS ACT_ID,"      );
qrysb.append("         NVL(BAS.ACT_DESC, 'Pending for MM claim process') AS ACT_DESC,"      );
qrysb.append("         NVL(BD.MM_CLAIM_AMT, 0)                           AS MM_CLAIM_AMT,"      );
qrysb.append("         BBM.BR_NAME,"      );
qrysb.append("         BBM.BR_ADDR,"      );
qrysb.append("         BBM.EMAIL,"      );
qrysb.append("         BBM.BRANCH_NAME,"      );
qrysb.append("         BBM.CONT_NO,"      );
qrysb.append("         BBM.DESIG,"      );
qrysb.append("         BBM.CONT_NAME,"      );
qrysb.append("         BD.APPRV_YN,"      );
qrysb.append("         BD.PACT_ID,"      );
qrysb.append("         BD.PBATCH_ID,"      );
qrysb.append("         TO_CHAR(BD.BATCH_DATE, 'DD-MON-RRRR') AS BTACH_DATE,"      );
qrysb.append("         BD.PAY_STATUS,"      );
qrysb.append("         BD.UTRN_NO"      );
qrysb.append("       FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("         BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("         MAS_OFF_MAST MOM,"      );
qrysb.append("         M_DISTRICT MD,"      );
qrysb.append("         M_STATE MS,"      );
qrysb.append("         MM_REMARKS_TRANS_SECOND MRT,"      );
qrysb.append("         BANK_APP_STATUS BAS,"      );
qrysb.append("         BANK_BR_MAST BBM"      );
qrysb.append("       WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("       AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("       AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD"      );
qrysb.append("       AND MS.STATE_CD       = MD.STATE_CD"      );
qrysb.append("       AND BD.REMTRID        = MRT.REMTR_ID"      );
qrysb.append("       AND BD.PACT_ID        = BAS.ACT_ID(+)"      );
qrysb.append("       AND BBM.BR_IFSL_CODE  = BD.IFSC_CODE"      );
qrysb.append("       AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("       AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       )"      );
qrysb.append("     GROUP BY (TRUNC(PROC_DT))"      );
qrysb.append("     UNION"      );
qrysb.append("     SELECT TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) AS PROC_DT,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       COUNT(                                *)            AS MM_REL_NO,"      );
qrysb.append("       SUM(ROUND(BANK_DATAENTRY_SECOND.MM_CLAIM_AMT / 100000, 2)) AS MM_REL_AMT,"      );
qrysb.append("       0,"      );
qrysb.append("   0"      );
qrysb.append("     FROM BANK_DATAENTRY_SECOND"      );
qrysb.append("     WHERE BANK_DATAENTRY_SECOND.MM_REL_DT IS NOT NULL"      );
qrysb.append("     AND BANK_DATAENTRY_SECOND.PACT_ID      = 34"      );
qrysb.append("     GROUP BY TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT)"      );
qrysb.append("     ) "+vcls+"  "      );
qrysb.append("   GROUP BY ROLLUP(PROC_DT)"      );
qrysb.append("   ORDER BY TO_DATE(PROC_DT) DESC"      );


 //out.print(qrysb.toString());
 
String  PROC_DT = "";
String  PENDING_CL = "";
String  PENDING_CL_MM="";
String  REF_CL = "";
String  REF_CL_MM= "";
String  RECOM_CL = "";
String  RECOM_MM = "";
String  MM_DISB = "";
String  MM_DISB_MM = "";
String  MM_CLAIM_AMT = "";
String  TOTAL_CLAIM = "";
String  MM_DESC = "";
String  NO_OF_PRJDW= "";
String  MM_RELDW = "";

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());



 StringBuffer qry= new StringBuffer();


	ResultSet mmapprv= db.execSQL("SELECT  round(SUM(MM_CLAIM_AMT)/100000,2) as mm_no FROM BANK_DATAENTRY_second bd WHERE PACT_ID=32 AND APPRV_YN='A'");
String vmmapprv="0";

while (mmapprv.next()) {
vmmapprv=mmapprv.getString("mm_no")==null?"0":mmapprv.getString("mm_no");
}
mmapprv.close();

%>
<center>
  <h1> Day Wise Margin Money (MM) Claim And Disbursement For Second Loan   From <%=wcls%>
<a href="daywisedwdb_claim_repo.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
 
	

 
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">SRNO</div></th>   
    <th rowspan="2"><div align="center">Date</div></th>
	<th colspan="2"><div align="center">MM Claim Uploaded</div></th>	
	 <th colspan="2">Recommended For MM Release(Apprv. claim: <%= vmmapprv %>)</th>    
	<th colspan="2">Referred to SO/DO </th>
     <th colspan="2"><div align="center">Claims Under process</div></th>
    <th colspan="2"><div align="center">MM Released by corp. Bank </div></th>
	
  </tr>
  <tr>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt </div></th>
    <th><div align="center">Prj. No</div></th>
    <th><div align="center">MM Amt</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt </div></th>
	<th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt </div></th>
    
  </tr>
   </thead>
  <% 
String bgcolor="";

int srno =0;
 while (rsMain.next()) { 
PROC_DT=rsMain.getString("PROC_DT")==null?"Grand Total":rsMain.getString("PROC_DT");
PENDING_CL=rsMain.getString("PENDING_CL")==null?"":rsMain.getString("PENDING_CL");
PENDING_CL_MM=rsMain.getString("PENDING_CL_MM")==null?"":rsMain.getString("PENDING_CL_MM");
REF_CL=rsMain.getString("REF_CL")==null?"":rsMain.getString("REF_CL");
REF_CL_MM=rsMain.getString("REF_CL_MM")==null?"":rsMain.getString("REF_CL_MM");
RECOM_CL=rsMain.getString("RECOM_CL")==null?"":rsMain.getString("RECOM_CL");
RECOM_MM=rsMain.getString("RECOM_MM")==null?"":rsMain.getString("RECOM_MM");
MM_DISB=rsMain.getString("MM_DISB")==null?"":rsMain.getString("MM_DISB");
MM_DISB_MM=rsMain.getString("MM_DISB_MM")==null?"":rsMain.getString("MM_DISB_MM");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
TOTAL_CLAIM=rsMain.getString("TOTAL_CLAIM")==null?"":rsMain.getString("TOTAL_CLAIM");

srno =srno+1;
if ( srno==1){bgcolor="#FFFF66";
}else if (srno==2){
bgcolor="#FFCC99";
}else{
bgcolor="";
}


%>

<tbody>

  <tr bgcolor="<%=  bgcolor %>">
    <td><%=srno %></td>
	<td nowrap><%=PROC_DT %></td>	
    <td><%=TOTAL_CLAIM %></td>
	<td><%=MM_CLAIM_AMT %></td>
	<td><%=RECOM_CL%></td>
    <td><%=RECOM_MM %></td>
    <td><%=REF_CL%></td>
    <td><%=REF_CL_MM%></td>
    <td><%=PENDING_CL %></td>	
    <td><%=PENDING_CL_MM%></td>    
    <td><%=MM_DISB%></td>
    <td><%=MM_DISB_MM%></a></td>
    
	
  </tr>
  </tbody>
   
  <%  }
  rsMain.close();
  db.close();
    %>
   
</table>

</body>
</html>
