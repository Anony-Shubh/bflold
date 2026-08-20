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

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();
qrysb.append("    SELECT TO_CHAR(PROC_DT,'DD-MON-YYYY') AS PROC_DT, "      );
qrysb.append("    SUM(MM_CLAIM_NO) AS TOTAL_CLAIM,"      );
qrysb.append("    SUM(MM_CLAIM_AMT)AS MM_CLAIM_AMT,"      );
qrysb.append("    SUM(REF_CL) AS REF_CL,"      );
qrysb.append("    SUM( REF_CL_MM) AS REF_CL_MM,"      );
qrysb.append("     SUM(RECOM_CL) AS RECOM_CL,"      );
qrysb.append("   SUM(RECOM_MM) AS RECOM_MM,"      );
qrysb.append("    SUM(MM_REL_NO) AS MM_DISB,"      );
qrysb.append("     SUM(MM_REL_AMT) AS MM_DISB_MM,"      );
qrysb.append("    SUM(CLAIM_UP_NO) AS PENDING_CL,"      );
qrysb.append("    SUM(CLAIM_UP_MM) AS PENDING_CL_MM"      );
qrysb.append("    FROM"      );
qrysb.append("     ("      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("    SELECT TRUNC(BANK_DATAENTRY.MM_CLAIM_DT) AS PROC_DT,"      );
qrysb.append("    COUNT(                                *)                                AS MM_CLAIM_NO,"      );
qrysb.append("    SUM(ROUND(BANK_DATAENTRY.MM_CLAIM_AMT / 100000, 2))                     AS MM_CLAIM_AMT,"      );
qrysb.append("      0                                                                       AS REF_CL,"      );
qrysb.append("     0                                                                       AS REF_CL_MM,"      );
qrysb.append("       0                                                                       AS RECOM_CL,"      );
qrysb.append("       0                                                                       AS RECOM_MM,"      );
qrysb.append("   0                                                                       AS MM_REL_NO,"      );
qrysb.append("        0                                                                       AS MM_REL_AMT,"      );
qrysb.append("       "      );
qrysb.append("       SUM(CASE WHEN PACT_ID IS NULL  THEN 1 ELSE 0 END) AS CLAIM_UP_NO,"      );
qrysb.append("      SUM( CASE WHEN PACT_ID IS NULL  THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS CLAIM_UP_MM"      );
qrysb.append("     FROM BANK_DATAENTRY"      );
qrysb.append("     WHERE BANK_DATAENTRY.MM_CLAIM_AMT > 0"      );
qrysb.append("     AND BANK_DATAENTRY.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("     GROUP BY TRUNC(MM_CLAIM_DT)"      );
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
qrysb.append("         WHEN ACT_ID = 32 AND APPRV_YN<>'R' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS RECOM_CL,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN ACT_ID = 32 AND  APPRV_YN<>'R' "      );
qrysb.append("         THEN ROUND(MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS RECOM_MM,"      );
qrysb.append("       0 MM_REL_NO,"      );
qrysb.append("       0 MM_REL_AMT,0,0"      );
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
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("         BANK_DATAENTRY BD,"      );
qrysb.append("         MAS_OFF_MAST MOM,"      );
qrysb.append("         M_DISTRICT MD,"      );
qrysb.append("         M_STATE MS,"      );
qrysb.append("         MM_REMARKS_TRANS MRT,"      );
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
qrysb.append("     SELECT TRUNC(BANK_DATAENTRY.MM_REL_DT) AS PROC_DT,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       0,"      );
qrysb.append("       COUNT(                                *)            AS MM_REL_NO,"      );
qrysb.append("       SUM(ROUND(BANK_DATAENTRY.MM_CLAIM_AMT / 100000, 2)) AS MM_REL_AMT,0,0"      );
qrysb.append("     FROM BANK_DATAENTRY"      );
qrysb.append("     WHERE BANK_DATAENTRY.MM_REL_DT IS NOT NULL"      );
qrysb.append("     AND BANK_DATAENTRY.PACT_ID      = 34"      );
qrysb.append("     GROUP BY TRUNC(BANK_DATAENTRY.MM_REL_DT)"      );
qrysb.append("     )"      );
qrysb.append("   GROUP BY ROLLUP(PROC_DT)"      );
qrysb.append("   ORDER BY TO_DATE(PROC_DT) DESC"      );

 
 
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
 qry.append("   SELECT NVL(MM_DESC, 'TOTAL:') AS MM_DESC,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ)      AS NO_OF_PRJDW,"      );
qry.append("     SUM(OFFLINE_MM)             AS MM_RELDW,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ_1718) AS NO_OF_PRJ1718,"      );
qry.append("     SUM(OFFLINE_MM_1718)        AS MM_REL1718,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ_1819) AS NO_OF_PRJ1819,"      );
qry.append("     SUM(OFFLINE_MM_1819)        AS MM_REL1819,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ_1920) AS NO_OF_PRJ1920,"      );
qry.append("     SUM(OFFLINE_MM_1920)        AS MM_REL1920,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ_2021) AS NO_OF_PRJ2021,"      );
qry.append("     SUM(OFFLINE_MM_2021)        AS MM_REL2021,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ_2122) AS NO_OF_PRJ2122,"      );
qry.append("     SUM(OFFLINE_MM_2122)        AS MM_REL2122,"      );
qry.append("     SUM(OFFLINE_NO_OF_PRJ_2223) AS NO_OF_PRJ2223,"      );
qry.append("     SUM(OFFLINE_MM_2223)        AS MM_REL2223,"      );
qry.append("       SUM(OFFLINE_NO_OF_PRJ_2324) AS NO_OF_PRJ2324,"      );
qry.append("     SUM(OFFLINE_MM_2324)        AS MM_REL2324,"      );
qry.append("       SUM(OFFLINE_NO_OF_PRJ_2425) AS NO_OF_PRJ2425,"      );
qry.append("     SUM(OFFLINE_MM_2425)        AS MM_REL2425"      );
qry.append("   "      );
qry.append("   FROM"      );
qry.append("     (SELECT 'Bi-Weekly Upto 30 June' AS MM_DESC,"      );
qry.append("       21447                          AS OFFLINE_NO_OF_PRJ,"      );
qry.append("       48122.97                       AS OFFLINE_MM,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_1718,"      );
qry.append("       0                              AS OFFLINE_MM_1718,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("       0                              AS OFFLINE_MM_1819,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("       0                              AS OFFLINE_MM_1920,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("       0                              AS OFFLINE_MM_2021,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_2122,"      );
qry.append("       0                              AS OFFLINE_MM_2122,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("       0                              AS OFFLINE_MM_2223,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_2324,"      );
qry.append("       0                              AS OFFLINE_MM_2324,"      );
qry.append("       0                              AS OFFLINE_NO_OF_PRJ_2425,"      );
qry.append("       0                              AS OFFLINE_MM_2425"      );
qry.append("     FROM DUAL"      );
qry.append("     UNION"      );
qry.append("     SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2016-17'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_ETRAC,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2016-17'"      );
qry.append("         THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS MARGIN_AMOUNT_CLAIMED,"      );
qry.append("       0    AS OFFLINE_NO_OF_PRJ_1718,"      );
qry.append("       0    AS OFFLINE_MM_1718,"      );
qry.append("       0    AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("       0    AS OFFLINE_MM_1819,"      );
qry.append("       0    AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("       0    AS OFFLINE_MM_1920,"      );
qry.append("       0    AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("       0    AS OFFLINE_MM_2021,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2122,"      );
qry.append("       0 AS OFFLINE_MM_2122,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("       0 AS OFFLINE_MM_2223,0,0,0,0"      );
qry.append("     FROM pmegponline.corpdata_final"      );
qry.append("     UNION"      );
qry.append("     SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ,"      );
qry.append("       0                AS OFFLINE_MM,"      );
qry.append("       5240             AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("       12915.35         AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("       0                AS OFFLINE_MM_1819,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("       0                AS OFFLINE_MM_1920,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("       0                AS OFFLINE_MM_2021,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2122,"      );
qry.append("       0 AS OFFLINE_MM_2122,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("       0 AS OFFLINE_MM_2223,0,0,0,0"      );
qry.append("     FROM DUAL"      );
qry.append("     UNION"      );
qry.append("     SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ,"      );
qry.append("       0                AS OFFLINE_MM,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1718,"      );
qry.append("       0                AS OFFLINE_MM_1718,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (PMEGPONLINE.CORPDATA_FINAL.APR_YEAR) = '2018-19'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_ETRAC_1819,"      );
qry.append("       ROUND(SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (PMEGPONLINE.CORPDATA_FINAL.APR_YEAR) = '2018-19'"      );
qry.append("         THEN NVL(PMEGPONLINE.CORPDATA_FINAL.MARGIN_AMOUNT_CLAIMED, 0)"      );
qry.append("         ELSE 0"      );
qry.append("       END) / 100000, 2) AS MARGIN_AMOUNT_CLAIMED_1819,"      );
qry.append("       0                 AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("       0                 AS OFFLINE_MM_1920,"      );
qry.append("       0                 AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("       0                 AS OFFLINE_MM_2021,"      );
qry.append("       0,"      );
qry.append("       0,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("       0 AS OFFLINE_MM_2223,0,0,0,0"      );
qry.append("     FROM PMEGPONLINE.CORPDATA_FINAL"      );
qry.append("     UNION"      );
qry.append("     SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ,"      );
qry.append("       0                AS OFFLINE_MM,"      );
qry.append("       0                AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("       0                AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("       0                AS OFFLINE_MM_1819,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2019-20'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_ETRAC_1920,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2019-20'"      );
qry.append("         THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS MARGIN_AMOUNT_CLAIMED_1920,"      );
qry.append("       0,"      );
qry.append("       0,"      );
qry.append("       0,"      );
qry.append("       0,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("       0 AS OFFLINE_MM_2223,0,0,0,0"      );
qry.append("     FROM pmegponline.corpdata_final"      );
qry.append("     UNION"      );
qry.append("     SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ,"      );
qry.append("       0                AS OFFLINE_MM,"      );
qry.append("       0                AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("       0                AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("       0                AS OFFLINE_MM_1819,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("       0                AS OFFLINE_MM_1920,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2020-21'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_ETRAC_2021,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2020-21'"      );
qry.append("         THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS MARGIN_AMOUNT_CLAIMED_2021,"      );
qry.append("       0,"      );
qry.append("       0,"      );
qry.append("       0,"      );
qry.append("       0,0,0,0,0"      );
qry.append("     FROM pmegponline.corpdata_final"      );
qry.append("     UNION"      );
qry.append("     SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ,"      );
qry.append("       0                AS OFFLINE_MM,"      );
qry.append("       0                AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("       0                AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("       0                AS OFFLINE_MM_1819,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("       0                AS OFFLINE_MM_1920,"      );
qry.append("       0                AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("       0                AS OFFLINE_MM_2021,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2021-22'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_ETRAC_2122,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN (pmegponline.corpdata_final.APR_YEAR) = '2021-22'"      );
qry.append("         THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS MARGIN_AMOUNT_CLAIMED_2122,"      );
qry.append("       0 OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("       0 AS OFFLINE_MM_2223,0,0,0,0"      );
qry.append("     FROM pmegponline.corpdata_final"      );
qry.append("     UNION"      );
qry.append("     SELECT 'PMEGP e-Portal New Claims' AS MM_DESC,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) < '01-APR-2017'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) < '01-APR-2017'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2017' AND '31-MAR-2018'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_1718,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2017' AND '31-MAR-2018'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_1718,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_1819,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_1819,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2019' AND '31-MAR-2020'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_1920,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2019' AND '31-MAR-2020'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_1920,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2021,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2021,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2122,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2122,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2223,MMRELDASH('I','01-APR-2022','31-MAR-2023') as NEWMMCLAIM_2223,"      );
/*qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2223,"      );*/

qry.append("        SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2023' AND '31-MAR-2024'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2324,MMRELDASH('I','01-APR-2023','31-MAR-2024') as NEWMMCLAIM_2324,"      );

qry.append("        SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2024' AND '31-MAR-2025'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2425,MMRELDASH('I','01-APR-2024','31-MAR-2025') as NEWMMCLAIM_2425"      );
/*qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2023' AND '31-MAR-2024'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2324"      );*/
qry.append("     FROM BANK_DATAENTRY"      );
qry.append("     WHERE BANK_DATAENTRY.PACT_ID  = 34"      );
qry.append("     AND BANK_DATAENTRY.MM_REL_DT IS NOT NULL"      );
qry.append("     UNION"      );
qry.append("     SELECT 'PMEGP e-Portal Second Loan' AS MM_DESC,"      );
qry.append("       0                                 AS NO_OF_PRJ_SEC_1617,"      );
qry.append("       0                                 AS MM_SEC_1617,"      );
qry.append("       0                                 AS NO_OF_PRJ_SEC_1718,"      );
qry.append("       0                                 AS M_SEC_1718,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_1819,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_1819,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2019' AND '31-MAR-2020'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_1920,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2019' AND '31-MAR-2020'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_1920,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2021,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2021,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2122,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2122,"      );
qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2223,MMRELDASH('II','01-APR-2022','31-MAR-2023') as NEWMMCLAIM_2223,  "      );
/*qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2223,"      );*/
qry.append("           SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2023' AND '31-MAR-2024'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2324,MMRELDASH('II','01-APR-2023','31-MAR-2024') as NEWMMCLAIM_2324,"      );
qry.append("           SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2024' AND '31-MAR-2025'"      );
qry.append("         THEN 1"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NO_OF_PRJ_EPORTAL_2425,MMRELDASH('II','01-APR-2024','31-MAR-2025') as NEWMMCLAIM_2425"      );
/*qry.append("       SUM("      );
qry.append("       CASE"      );
qry.append("         WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2023' AND '31-MAR-2024'"      );
qry.append("         THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("         ELSE 0"      );
qry.append("       END) AS NEWMMCLAIM_2324"      );*/
qry.append("     FROM BANK_DATAENTRY_SECOND"      );
qry.append("     WHERE BANK_DATAENTRY_SECOND.PACT_ID  = 34"      );
qry.append("     AND BANK_DATAENTRY_SECOND.MM_REL_DT IS NOT NULL"      );
qry.append("     )"      );
qry.append("   GROUP BY ROLLUP(MM_DESC)"      );


 
/*

qry.append("      SELECT NVL(MM_DESC, 'TOTAL:') AS MM_DESC,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ)      AS NO_OF_PRJDW,"      );
qry.append("        SUM(OFFLINE_MM)             AS MM_RELDW,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ_1718) AS NO_OF_PRJ1718,"      );
qry.append("        SUM(OFFLINE_MM_1718)        AS MM_REL1718,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ_1819) AS NO_OF_PRJ1819,"      );
qry.append("        SUM(OFFLINE_MM_1819)        AS MM_REL1819,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ_1920) AS NO_OF_PRJ1920,"      );
qry.append("        SUM(OFFLINE_MM_1920)        AS MM_REL1920,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ_2021) AS NO_OF_PRJ2021,"      );
qry.append("        SUM(OFFLINE_MM_2021)        AS MM_REL2021,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ_2122) AS NO_OF_PRJ2122,"      );
qry.append("        SUM(OFFLINE_MM_2122)        AS MM_REL2122,"      );
qry.append("        SUM(OFFLINE_NO_OF_PRJ_2223) AS NO_OF_PRJ2223,"      );
qry.append("        SUM(OFFLINE_MM_2223)        AS MM_REL2223"      );
qry.append("      FROM"      );
qry.append("        ("      );
qry.append("        SELECT 'Bi-Weekly Upto 30 June' AS MM_DESC,"      );
qry.append("          21447                                        AS OFFLINE_NO_OF_PRJ,"      );
qry.append("          48122.97                                     AS OFFLINE_MM,"      );
qry.append("          0                                            AS OFFLINE_NO_OF_PRJ_1718,"      );
qry.append("          0                                            AS OFFLINE_MM_1718,"      );
qry.append("          0                                            AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("          0                                            AS OFFLINE_MM_1819,"      );
qry.append("          0                                            AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("          0                                            AS OFFLINE_MM_1920,"      );
qry.append("           0                                            AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("          0                                            AS OFFLINE_MM_2021,"      );
qry.append("           0                                            AS OFFLINE_NO_OF_PRJ_2122,"      );
qry.append("          0                                            AS OFFLINE_MM_2122,"      );
qry.append("          0                                            AS OFFLINE_NO_OF_PRJ_2223,"      );
qry.append("          0                                            AS OFFLINE_MM_2223"      );
qry.append("        FROM DUAL"      );
qry.append("        "      );
qry.append("        "      );
qry.append("        UNION"      );
qry.append("        SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (pmegponline.corpdata_final.APR_YEAR)='2016-17' "      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_ETRAC,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (pmegponline.corpdata_final.APR_YEAR)='2016-17'"      );
qry.append("            THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS MARGIN_AMOUNT_CLAIMED,"      );
qry.append("          0    AS OFFLINE_NO_OF_PRJ_1718,"      );
qry.append("          0    AS OFFLINE_MM_1718,"      );
qry.append("          0    AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("          0    AS OFFLINE_MM_1819,"      );
qry.append("          0    AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("          0    AS OFFLINE_MM_1920,"      );
qry.append("            0                                            AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("          0                                            AS OFFLINE_MM_2021,0 OFFLINE_NO_OF_PRJ_2122,0 AS OFFLINE_MM_2122,"      );
qry.append("          0 OFFLINE_NO_OF_PRJ_2223,0 AS OFFLINE_MM_2223"      );
qry.append("        FROM pmegponline.corpdata_final"      );
qry.append("   "      );
qry.append("        UNION"      );
qry.append("        SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ,"      );
qry.append("          0                           AS OFFLINE_MM,"      );
qry.append("          5240                        AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("          12915.35                    AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("          0                           AS OFFLINE_MM_1819,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("          0                           AS OFFLINE_MM_1920,"      );
qry.append("            0                                            AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("          0                                            AS OFFLINE_MM_2021,0 OFFLINE_NO_OF_PRJ_2122,0 AS OFFLINE_MM_2122 ,"      );
qry.append("           0 OFFLINE_NO_OF_PRJ_2223,0 AS OFFLINE_MM_2223"      );
qry.append("        FROM DUAL"      );
qry.append("        UNION"      );
qry.append("        SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ,"      );
qry.append("          0                           AS OFFLINE_MM,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ_1718,"      );
qry.append("          0                           AS OFFLINE_MM_1718,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (PMEGPONLINE.CORPDATA_FINAL.APR_YEAR) = '2018-19'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_ETRAC_1819,"      );
qry.append("           ROUND(SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (PMEGPONLINE.CORPDATA_FINAL.APR_YEAR) = '2018-19'"      );
qry.append("            THEN NVL(PMEGPONLINE.CORPDATA_FINAL.MARGIN_AMOUNT_CLAIMED, 0)"      );
qry.append("            ELSE 0"      );
qry.append("          END)/ 100000, 2) AS MARGIN_AMOUNT_CLAIMED_1819,"      );
qry.append("          0    AS OFFLINE_NO_OF_PRJ_1920,"      );
qry.append("          0    AS OFFLINE_MM_1920,"      );
qry.append("            0                                            AS OFFLINE_NO_OF_PRJ_2021,"      );
qry.append("          0                                            AS OFFLINE_MM_2021,0,0, 0 OFFLINE_NO_OF_PRJ_2223,0 AS OFFLINE_MM_2223"      );
qry.append("        FROM PMEGPONLINE.CORPDATA_FINAL"      );
qry.append("   "      );
qry.append("        UNION"      );
qry.append("        SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ,"      );
qry.append("          0                           AS OFFLINE_MM,"      );
qry.append("          0                           AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("          0                           AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("          0                           AS OFFLINE_MM_1819,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (pmegponline.corpdata_final.APR_YEAR)='2019-20' "      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_ETRAC_1920,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (pmegponline.corpdata_final.APR_YEAR)='2019-20'  "      );
qry.append("            THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS MARGIN_AMOUNT_CLAIMED_1920,"      );
qry.append("          0,0,0,0, 0 OFFLINE_NO_OF_PRJ_2223,0 AS OFFLINE_MM_2223"      );
qry.append("        FROM pmegponline.corpdata_final"      );
qry.append("      union "      );
qry.append("   "      );
qry.append("        SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ,"      );
qry.append("          0                           AS OFFLINE_MM,"      );
qry.append("          0                           AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("          0                           AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("          0                           AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("          0                           AS OFFLINE_MM_1819,0 as OFFLINE_NO_OF_PRJ_1920,0 as OFFLINE_MM_1920, "      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (pmegponline.corpdata_final.APR_YEAR)='2020-21' "      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_ETRAC_2021,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN (pmegponline.corpdata_final.APR_YEAR)='2020-21'  "      );
qry.append("            THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS MARGIN_AMOUNT_CLAIMED_2021,0,0,0,0"      );
qry.append("   "      );
qry.append("        FROM pmegponline.corpdata_final"      );
qry.append("        UNION "      );
qry.append("               SELECT 'Old Claim' AS MM_DESC,"      );
qry.append("             0                           AS OFFLINE_NO_OF_PRJ,"      );
qry.append("             0                           AS OFFLINE_MM,"      );
qry.append("             0                           AS NO_OF_PRJ_ETRAC_1718,"      );
qry.append("             0                           AS MARGIN_AMOUNT_CLAIMED_1718,"      );
qry.append("             0                           AS OFFLINE_NO_OF_PRJ_1819,"      );
qry.append("             0                           AS OFFLINE_MM_1819,0 as OFFLINE_NO_OF_PRJ_1920,0 as OFFLINE_MM_1920,0 as OFFLINE_NO_OF_PRJ_2021,0 as OFFLINE_MM_2021, "      );
qry.append("             SUM("      );
qry.append("             CASE"      );
qry.append("               WHEN (pmegponline.corpdata_final.APR_YEAR)='2021-22' "      );
qry.append("               THEN 1"      );
qry.append("               ELSE 0"      );
qry.append("             END) AS NO_OF_PRJ_ETRAC_2122,"      );
qry.append("             SUM("      );
qry.append("             CASE"      );
qry.append("               WHEN (pmegponline.corpdata_final.APR_YEAR)='2021-22'  "      );
qry.append("               THEN ROUND(NVL(pmegponline.corpdata_final.MARGIN_AMOUNT_CLAIMED, 0) / 100000, 2)"      );
qry.append("               ELSE 0"      );
qry.append("             END) AS MARGIN_AMOUNT_CLAIMED_2122, 0 OFFLINE_NO_OF_PRJ_2223,0 AS OFFLINE_MM_2223"      );
qry.append("      "      );
qry.append("           FROM pmegponline.corpdata_final"      );
qry.append("      UNION   "      );
qry.append("   "      );
qry.append("        SELECT 'PMEGP e-Portal New Claims' AS MM_DESC,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) < '01-APR-2017'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) < '01-APR-2017'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2017' AND '31-MAR-2018'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_1718,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2017' AND '31-MAR-2018'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_1718,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_1819,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_1819,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2019' AND '31-MAR-2020'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_1920,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2019' AND '31-MAR-2020'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_1920,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_2021,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_2021,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_2122,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_2122,"      );
qry.append("            SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_2223,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY.MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_2223"      );
qry.append("   "      );
qry.append("   "      );
qry.append("   "      );
qry.append("   "      );
qry.append("        FROM BANK_DATAENTRY"      );
qry.append("        WHERE BANK_DATAENTRY.PACT_ID  = 34"      );
qry.append("        AND BANK_DATAENTRY.MM_REL_DT IS NOT NULL"      );
qry.append("        UNION"      );
qry.append("        SELECT 'PMEGP e-Portal Second Loan' AS MM_DESC,"      );
qry.append("          0                                                   AS NO_OF_PRJ_SEC_1617,"      );
qry.append("          0                                                   AS MM_SEC_1617,"      );
qry.append("          0                                                   AS NO_OF_PRJ_SEC_1718,"      );
qry.append("          0                                                   AS M_SEC_1718,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_1819,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT) BETWEEN '01-APR-2018' AND '31-MAR-2019'"      );
qry.append("            THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_1819,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT)  between '01-APR-2019' and '31-MAR-2020' "      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_1920,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(BANK_DATAENTRY_SECOND.MM_REL_DT)  BETWEEN  '01-APR-2019' and '31-MAR-2020' "      );
qry.append("            THEN ROUND(BANK_DATAENTRY_SECOND.MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_1920,"      );
qry.append("           SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_2021,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(MM_REL_DT) BETWEEN '01-APR-2020' AND '31-MAR-2021'"      );
qry.append("            THEN ROUND(MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_2021,"      );
qry.append("           SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_2122,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(MM_REL_DT) BETWEEN '01-APR-2021' AND '31-MAR-2022'"      );
qry.append("            THEN ROUND(MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_2122,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("            THEN 1"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NO_OF_PRJ_EPORTAL_2223,"      );
qry.append("          SUM("      );
qry.append("          CASE"      );
qry.append("            WHEN TRUNC(MM_REL_DT) BETWEEN '01-APR-2022' AND '31-MAR-2023'"      );
qry.append("            THEN ROUND(MM_REL_AMT / 100000, 2)"      );
qry.append("            ELSE 0"      );
qry.append("          END) AS NEWMMCLAIM_2223"      );
qry.append("        FROM BANK_DATAENTRY_SECOND"      );
qry.append("        WHERE BANK_DATAENTRY_SECOND.PACT_ID  = 34"      );
qry.append("        AND BANK_DATAENTRY_SECOND.MM_REL_DT IS NOT NULL"      );
qry.append("        )"      );
qry.append("      GROUP BY ROLLUP(MM_DESC)"      );
qry.append("   "      );
*/



//out.print (qry.toString());
ResultSet rs = db.execSQL(qry.toString());


	ResultSet mmapprv= db.execSQL("SELECT  round(SUM(MM_CLAIM_AMT)/100000,2) as mm_no FROM BANK_DATAENTRY bd WHERE PACT_ID=32 AND APPRV_YN='A'");
String vmmapprv="0";

while (mmapprv.next()) {
vmmapprv=mmapprv.getString("mm_no")==null?"0":mmapprv.getString("mm_no");
}
mmapprv.close();

%>
<center>
  <h1> Day Wise Margin Money (MM) Claim And Disbursement   From 01 July,2016 to <%= curdt %>
<a href="mmclaimProcHomepage.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
 
	
<table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">DESCRIPTION</div></th>   
    <th rowspan="2"><div align="center">No of Projects <br>(2016-17)</div></th>
	<th rowspan="2"><div align="center">MM Disbursed<br> (2016-17)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2017-18)</div></th>
	<th rowspan="2"><div align="center">MM Disbursed<br>(2017-18)</div></th>
	<th rowspan="2"><div align="center">No of Projects<br> (2018-19)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2018-19)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2019-20)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2019-20)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2020-21)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2020-21)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2021-22)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2021-22)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2022-23)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2022-23)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2023-24)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2023-24)</div></th>
	<th rowspan="2"><div align="center">No of Projects <br>(2024-25)</div></th>
    <th rowspan="2"><div align="center">MM Disbursed<br>(2024-25)</div></th>
  </tr>
	</thead>
	<%
	String NO_OF_PRJ1718="";
	String MM_REL_1718="";
	String NO_OF_PRJ1819="";
	String MM_REL_1819="";
	String MM_REL_1920="";
	String NO_OF_PRJ1920="";
	
	String MM_REL_2021="";
	String NO_OF_PRJ2021="";
	
	String MM_REL_2122="";
	String NO_OF_PRJ2122="";
	String MM_REL_2223="";
	String NO_OF_PRJ2223="";
	String MM_REL_2324="";
	String NO_OF_PRJ2324="";
		String MM_REL_2425="";
	String NO_OF_PRJ2425="";
	
	int count=0;
 while (rs.next()) {
	count=count+1;
MM_DESC=rs.getString("MM_DESC")==null?"Grand Total":rs.getString("MM_DESC");
NO_OF_PRJDW=rs.getString("NO_OF_PRJDW")==null?"":rs.getString("NO_OF_PRJDW");
MM_RELDW=rs.getString("MM_RELDW")==null?"":rs.getString("MM_RELDW");
NO_OF_PRJ1718=rs.getString(4)==null?"":rs.getString(4);
MM_REL_1718=rs.getString(5)==null?"":rs.getString(5);
NO_OF_PRJ1819=rs.getString(6)==null?"":rs.getString(6);
MM_REL_1819=rs.getString(7)==null?"":rs.getString(7);
NO_OF_PRJ1920=rs.getString(8)==null?"":rs.getString(8);
MM_REL_1920=rs.getString(9)==null?"":rs.getString(9);

NO_OF_PRJ2021=rs.getString(10)==null?"":rs.getString(10);
MM_REL_2021=rs.getString(11)==null?"":rs.getString(11);

NO_OF_PRJ2122=rs.getString(12)==null?"":rs.getString(12);
MM_REL_2122=rs.getString(13)==null?"":rs.getString(13);

NO_OF_PRJ2223=rs.getString(14)==null?"":rs.getString(14);
MM_REL_2223=rs.getString(15)==null?"":rs.getString(15);
NO_OF_PRJ2324=rs.getString(16)==null?"":rs.getString(16);
MM_REL_2324=rs.getString(17)==null?"":rs.getString(17);

NO_OF_PRJ2425=rs.getString(18)==null?"":rs.getString(18);
MM_REL_2425=rs.getString(19)==null?"":rs.getString(19);
	%>
	<tbody>
  <tr>
  <th><h1><%=MM_DESC%></h1></th>
  <th><h1><%= NO_OF_PRJDW %></h1></th>
  <th><h1><%= MM_RELDW %></h1></th>
  <th><h1><%= NO_OF_PRJ1718 %></h1></th>
  <th><h1><%= MM_REL_1718 %></h1></th>
  <th><h1><%= NO_OF_PRJ1819 %></h1></th>
  <th><h1><%= MM_REL_1819 %></h1>
  <% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=201819" class="button">Read more</a>
 <% }%>
  </th>
  <th><h1><%= NO_OF_PRJ1920 %></h1></th>
  <th><h1><%= MM_REL_1920 %></h1><% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=201920" class="button">Read more</a>
 <% }%>
  </th>
  <th><h1><%= NO_OF_PRJ2021 %></h1></th>
  <th><h1><%= MM_REL_2021 %></h1>
  <% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=202021" class="button">Read more</a>
 <% }%>
   <th><h1><%= NO_OF_PRJ2122 %></h1></th>
  <th><h1><%= MM_REL_2122 %></h1>
  <% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=202122" class="button">Read more</a>
 <% }%></th>
 
 <th><h1><%= NO_OF_PRJ2223 %></h1></th>
  <th><h1><%= MM_REL_2223 %></h1>
  <% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=202223" class="button">Read more</a>
 <% }%></th>
 <th><h1><%= NO_OF_PRJ2324 %></h1></th>
  <th><h1><%= MM_REL_2324 %></h1>
  <% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=202324" class="button">Read more</a>
 <% }%></th>
 
 <th><h1><%= NO_OF_PRJ2425 %></h1></th>
  <th><h1><%= MM_REL_2425 %></h1>
  <% if (count==4){%>
  <a href="daywisedwdb_claim_repo_sec.jsp?YR=202425" class="button">Read more</a>
 <% }%></th>
  </tr>
  </tbody>
  <%
 }
rs.close();	

%> 
  </table>
 
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">SRNO</div></th>   
    <th rowspan="2"><div align="center">Date</div></th>
	<th colspan="2"><div align="center">MM Claim Uploaded</div></th>	
	 <th colspan="2">Recommended For MM Release (Apprv. claim: <%= vmmapprv %>)</th>    
	<th colspan="2">Referred to SO/DO </th>
     <th colspan="2"><div align="center">Claims Under process</div></th>
    <th colspan="2"><div align="center">MM Released by Nodal Bank </div></th>
	
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
