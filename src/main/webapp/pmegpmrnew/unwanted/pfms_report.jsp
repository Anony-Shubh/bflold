<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Performance Report</title>
<link rel="stylesheet" type="text/css" href="css/indexr.css">
</head>
<body>
<form method="post" >
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();

String MMREL="";
String NO_OF_APP="";
String ACTUALTRANSACTIONDATE="";
String PBATCH_ID="";
String txtSearch="";
String flagC="Y";
String p1="";
String p2="";
String p3="";
String rowcol="";
String FAILNO="";
String FAILAMT="";
int lrow=0;
String vUsrnm=  session.getAttribute("suser_detail")==null?"": (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")==null?"":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")==null?"":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")==null?"":(String) session.getAttribute("sstate_cd");
String OFFICEORDERDATE="";

if(vUsrnm.equals("")){
response.sendRedirect("index.jsp");
}

if(vsZonecd.equals("ALL") && vsAgency.equals("ALL") &&  vsStatecd.equals("ALL") ){

 StringBuffer qrysb= new StringBuffer();

 qrysb.append("   SELECT PBATCH_ID,"      );
qrysb.append("     MIN(actualtransactiondate) AS actualtransactiondate,"      );
qrysb.append("     MIN(officeorderdate)       AS officeorderdate,"      );
qrysb.append("     SUM(NVL(APPFEES, 0))       AS APPFEES,"      );
qrysb.append("     COUNT(PBATCH_ID)           AS no_of_app,"      );
qrysb.append("     SUM(amount) mmrel,"      );
qrysb.append("     FINYR,"      );
qrysb.append("    SUM( DECODE (F_S,'F',1,0)) AS FAILNO,"      );
qrysb.append("     SUM(DECODE (F_S,'F',amount,0)) AS FAILAMT"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT bd.PBATCH_ID,"      );
qrysb.append("       getfinyr(bd.BATCH_DATE) AS FINYR,"      );
qrysb.append("       ad.APP_ID               AS schemespecifictransactionid,"      );
qrysb.append("       NULL                    AS project,"      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.PBATCH_ID >= 563"      );
qrysb.append("         THEN 500"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END AS APPFEES,"      );
qrysb.append("       TO_CHAR(bd.BATCH_DATE, 'DDMMRRRR')"      );
qrysb.append("       || '-'"      );
qrysb.append("       || getfinyr(bd.BATCH_DATE)"      );
qrysb.append("       || '-'"      );
qrysb.append("       || bd.PBATCH_ID                             AS officeorderno,"      );
qrysb.append("       TO_CHAR(TRUNC(bd.BATCH_DATE), 'DD-MM-RRRR') AS officeorderdate,"      );
qrysb.append("       TO_CHAR(TRUNC(bd.MM_REL_DT), 'DD-MM-RRRR')  AS actualtransactiondate,"      );
qrysb.append("       upper(ad.APP_NAME)                          AS receivingpartyname,"      );
qrysb.append("       '01.A'                                      AS componentcode,"      );
qrysb.append("       'R'                                         AS expensetype,"      );
qrysb.append("       bd.MM_REL_AMT                               AS amount,"      );
qrysb.append("       NULL                                        AS expenditureorrefund,"      );
qrysb.append("       getfinyr(bd.BATCH_DATE) || ' New' AS remarks,"      );
qrysb.append("      ( CASE WHEN  UPPER(BD.pay_status) LIKE '%FAIL%' OR UPPER(BD.FAIL_REASON) IS NOT NULL THEN 'F' ELSE 'S' END) AS F_S"      );
qrysb.append("     FROM bank_dataentry bd,"      );
qrysb.append("       app_detail ad"      );
qrysb.append("     WHERE ad.APP_ID    = bd.APP_ID"      );
qrysb.append("     AND bd.PBATCH_ID   > 0"      );
qrysb.append("     AND bd.MM_REL_AMT  > 0"      );
qrysb.append("     AND bd.PACT_ID     = 34"      );
qrysb.append("     AND bd.MM_REL_DT  IS NOT NULL"      );
qrysb.append("     AND bd.BATCH_DATE IS NOT NULL"      );
qrysb.append("     UNION ALL"      );
qrysb.append("     SELECT bd.PBATCH_ID,"      );
qrysb.append("       getfinyr(bd.BATCH_DATE) AS FINYR,"      );
qrysb.append("       ad.APP_ID               AS schemespecifictransactionid,"      );
qrysb.append("       NULL                    AS project,"      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.PBATCH_ID >= 563"      );
qrysb.append("         THEN 500"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END AS APPFEES,"      );
qrysb.append("       TO_CHAR(bd.BATCH_DATE, 'DDMMRRRR')"      );
qrysb.append("       || '-'"      );
qrysb.append("       || getfinyr(bd.BATCH_DATE)"      );
qrysb.append("       || '-'"      );
qrysb.append("       || bd.PBATCH_ID                             AS officeorderno,"      );
qrysb.append("       TO_CHAR(TRUNC(bd.BATCH_DATE), 'DD-MM-RRRR') AS officeorderdate,"      );
qrysb.append("       TO_CHAR(TRUNC(bd.MM_REL_DT), 'DD-MM-RRRR')  AS actualtransactiondate,"      );
qrysb.append("       upper(ad.APP_NAME)                          AS receivingpartyname,"      );
qrysb.append("       '01.A'                                      AS componentcode,"      );
qrysb.append("       'R'                                         AS expensetype,"      );
qrysb.append("       bd.MM_REL_AMT                               AS amount,"      );
qrysb.append("       NULL                                        AS expenditureorrefund,"      );
qrysb.append("       getfinyr(bd.BATCH_DATE)"      );
qrysb.append("       || ' 2nd Loan' AS remarks,"      );
qrysb.append("       ( CASE WHEN  UPPER(BD.pay_status) LIKE '%FAIL%' OR UPPER(BD.FAIL_REASON) IS NOT NULL THEN 'F' ELSE 'S' END) AS F_S"      );
qrysb.append("     FROM bank_dataentry_second bd,"      );
qrysb.append("       app_detail_second ad"      );
qrysb.append("     WHERE ad.APP_ID    = bd.APP_ID"      );
qrysb.append("     AND bd.PBATCH_ID   > 0"      );
qrysb.append("     AND bd.MM_REL_AMT  > 0"      );
qrysb.append("     AND bd.PACT_ID     = 34"      );
qrysb.append("     AND bd.MM_REL_DT  IS NOT NULL"      );
qrysb.append("     AND bd.BATCH_DATE IS NOT NULL"      );
qrysb.append("     )"      );
qrysb.append("   GROUP BY PBATCH_ID,"      );
qrysb.append("     FINYR"      );
qrysb.append("   ORDER BY PBATCH_ID DESC"      );
 
 ResultSet rsinst = db.execSQL(qrysb.toString());
//out.print(sb.toString());
 %><br><br>
<h1><center>
  MM Disbursement Detail to be uploaded in PFMS  </h1>
<br>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5" >
  <tr>
    <th>Sr no. </th>
 
    <th>Batch Id </th>
	 <th>Fin year</th>
    <th>Transaction Date </th>
    <th>No. of Application </th>
    <th>MM Released Amt (in Rs.) </th>
	<th>Applicationfees@500</th>
    <th>Fail (in No) </th>
    <th>Fail MM Amount ( in Rs.) </th>
    <th>&nbsp;</th>
  </tr>
  <%
   String FINYR="";
   String APPFEES="";
while (rsinst.next()) {
lrow=lrow+1;
PBATCH_ID=rsinst.getString("PBATCH_ID")==null?"":rsinst.getString("PBATCH_ID");
ACTUALTRANSACTIONDATE=rsinst.getString("ACTUALTRANSACTIONDATE")==null?"":rsinst.getString("ACTUALTRANSACTIONDATE");
NO_OF_APP=rsinst.getString("NO_OF_APP")==null?"":rsinst.getString("NO_OF_APP");
MMREL=rsinst.getString("MMREL")==null?"":rsinst.getString("MMREL");
OFFICEORDERDATE=rsinst.getString("OFFICEORDERDATE")==null?"":rsinst.getString("OFFICEORDERDATE");
FINYR=rsinst.getString("FINYR")==null?"":rsinst.getString("FINYR");
APPFEES=rsinst.getString("APPFEES")==null?"":rsinst.getString("APPFEES");
FAILNO=rsinst.getString("FAILNO")==null?"":rsinst.getString("FAILNO");
FAILAMT=rsinst.getString("FAILAMT")==null?"":rsinst.getString("FAILAMT");

  %> <tr>
    <td><div align="center"><%= lrow %>)</div></td>
    <td><div align="center"><%= PBATCH_ID %></div></td>
	<td><div align="center"><%= FINYR %></div></td>
    <td><div align="center"><%= OFFICEORDERDATE %></div></td>
    <td><div align="center"><%= NO_OF_APP %></div></td>
    <td><div align="center"><%= MMREL %></div></td>
	<td><div align="center"><%= APPFEES %></div></td>
	
    <td><%= FAILNO %></td>
    <td><%= FAILAMT %></td>
    <td><div align="center"><a href="pfmsRepGenerateexcel.jsp?PBATCH_ID=<%= PBATCH_ID %>" >Download</a></div></td>
	
  </tr><%
	}rsinst.close();

}
db.close();
	%>
</table>

</w:realPage>
</w:wait> 
</form>
</body>
</html>
