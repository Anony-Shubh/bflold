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

</head>

<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">

<% 
jspinputvalid js = new jspinputvalid();
String YR=request.getParameter("YR")==null?"%%":(String) js.getOnlyTextspc(request.getParameter("YR"),7);

String vcls="";
String pcls="";
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

String banknm=request.getParameter("bankname")==null?"":(String) js.getOnlyTextspc(request.getParameter("bankname"),75);

if (banknm.equals("Z TOTAL")) {
pcls=" AD.BANK_NAME LIKE '%%' ";
}
else{
pcls=" AD.BANK_NAME LIKE '"+banknm+"' ";
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
wcls=" 1-APRIL-2019 TO 31-MARCH-2020 ";
}

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
/*
qrysb.append("   SELECT Nvl(MOM.OFF_NAME1,'Total') AS BANK_NAME,"      );
qrysb.append("   Nvl(AD.IFSC_CODE,'Total:') AS NO_OF_BRANCH,"      );
qrysb.append("   COUNT(AD.APP_ID) AS FORD_PRJNO,"      );
qrysb.append("   SUM(ROUND(MMINVOLVE(AD.APP_ID)/100000,2)) AS FORD_MM ,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,3,1,0)) AS REJ_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,3,ROUND(MMINVOLVE(AD.APP_ID)/100000,2),0)) AS REJ_MM,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,8,1,0)) AS BANK_UP_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,8,ROUND(MMINVOLVE(AD.APP_ID)/100000,2),0)) AS UP_MM,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,11,1,0)) AS SANC_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,11,ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2),0)) AS SANC_MM,"      );
qrysb.append("   SUM(DECODE(BD.OWN_CONT_DT,NULL,0,1)) AS OWN_CONT_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.OWN_CONT_DT,NULL,0,ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2),0)) AS OWN_CONT_MM,"      );
qrysb.append("   SUM(DECODE(BD.IST_LOAN_DT,NULL,0,1)) AS LOAN_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.IST_LOAN_DT,NULL,0,ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2),0)) AS LOAN_MM,"      );
qrysb.append("   SUM(DECODE(BD.EDP_CERT_DT,NULL,0,1)) AS EDP_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.EDP_CERT_DT,NULL,0,ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2),0)) AS EDP_MM,"      );
qrysb.append("   SUM(DECODE(BD.MM_CLAIM_DT,NULL,0,1)) AS FB_MM_CLAIM_PRJNO,"      );
qrysb.append("   SUM(DECODE(BD.MM_CLAIM_DT,NULL,0,MM_CLAIM_AMT)) AS FB_MM_CLAIM_AMT,"      );
qrysb.append("   SUM(DECODE(BD.MM_REL_DT,NULL,0,1)) AS CORPMM_REL_PRJNO,"      );
qrysb.append("   SUM(DECODE(BD.MM_REL_AMT,NULL,0,MM_REL_AMT)) AS CORPMM_REL_AMT"      );
qrysb.append("   FROM "      );
qrysb.append("   APP_DETAIL AD,BANK_DATAENTRY BD, MAS_OFF_MAST MOM  "      );
qrysb.append("   WHERE AD.APP_ID=BD.APP_ID AND AD.ACT_ID=5 AND AD.OFF_CD=MOM.OFF_CD AND bd.act_id=11 AND bd.loan_docfname IS NOT NULL AND bd.MM_CLAIM_AMT>0 AND AD.BANK_NAME LIKE '"+banknm+"' "      );
qrysb.append("   GROUP BY ROLLUP(MOM.OFF_NAME1,AD.IFSC_CODE)"      );
*/

qrysb.append("   SELECT NVL(MOM.OFF_NAME1,'Z TOTAL') AS BANK_NAME,"      );
//qrysb.append("      Nvl(AD.IFSC_CODE,'Total:')                                                      AS NO_OF_BRANCH,"      );
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
qrysb.append("   AND AD.ACT_ID        = 5"      );
qrysb.append("   AND bd.act_id=11 AND bd.loan_docfname IS NOT NULL AND bd.MM_CLAIM_AMT>0 AND  "+pcls+" and "+vcls+" "      );
qrysb.append("   GROUP BY ROLLUP(MOM.OFF_NAME1)"      );
qrysb.append("   ORDER BY MOM.OFF_NAME1"      );

//,AD.IFSC_CODEout.print(qrysb.toString());

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

 %>
<center>
  <h1> Application Status at Bank From <%=wcls%>
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr bgcolor="#FBDDF9">
    <td rowspan="2">Sr.No.</td>
    <td rowspan="2"><div align="center">State/Office name </div></td>
    <td colspan="2"><div align="center">MM Claimed </div></td>
    <td colspan="2"><div align="center">MM Claims Under Process at KVIC,CO,Mumbai </div></td>
    <td colspan="2"><div align="center">Referred to KVIC Field Offices for Rectification</div></td>
    <td colspan="2"><div align="center">MM Disbursed from Corporation Bank </div></td>
    </tr>
  <tr>
    <td bgcolor="#FBDDF9"><div align="center">No. of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM </div></td>
    <td bgcolor="#FBDDF9"><div align="center">No. of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM </div></td>
    <td bgcolor="#FBDDF9"><div align="center">No. of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM </div></td>
    <td bgcolor="#FBDDF9"><div align="center">No. of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM </div></td>
  </tr>
   </thead>
  
<tbody>
<% 

int srno =0;
 while (rsMain.next()) { 
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
//NO_OF_BRANCH=rsMain.getString("NO_OF_BRANCH")==null?"":rsMain.getString("NO_OF_BRANCH");
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


%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"><%= BANK_NAME %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_PRJNO %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_AMT %></div></td>
	<td><div align="center"><%= PMEGP_PEND_NO %></div></td>
	<td><div align="center"><%= PMEGP_PEND_MM %></div></td>
	<td><div align="center"><%= REF_PEND_NO %></div></td>
	<td><div align="center"><%= REF_PEND_MM %></div></td>
	<td>
      <div align="center"><%= CORPMM_REL_PRJNO %>
      </div></td>
	    <td><div align="center"><%= CORPMM_REL_AMT %></div></td>
  </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
</table>

</body>
</html>
