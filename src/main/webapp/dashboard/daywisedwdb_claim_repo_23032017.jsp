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
/*String MM_CLAIM_DT1=request.getParameter("MM_CLAIM_DT")== null?"%%":(String) request.getParameter("MM_CLAIM_DT");
//out.print(MM_CLAIM_DT);

if (!MM_CLAIM_DT.equals("")) {
vcls=" MM_CLAIM_DT LIKE '"+MM_CLAIM_DT1+"'  ";
}*/
 StringBuffer qrysb= new StringBuffer();
 
qrysb.append("SELECT TO_CHAR(MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT, ");
qrysb.append("SUM(CASE WHEN ACT_ID=0 THEN 1 ELSE 0 END) AS PENDING_CL,");
qrysb.append("SUM(CASE WHEN ACT_ID=0 THEN ROUND(MM_CLAIM_AMT/100000,2) ELSE 0 END) AS PENDING_CL_MM,");
qrysb.append("SUM(CASE WHEN ACT_ID=30 THEN 1 ELSE 0 END) AS REF_CL,");
qrysb.append("SUM(CASE WHEN ACT_ID=30 THEN ROUND(MM_CLAIM_AMT/100000,2) ELSE 0 END) AS REF_CL_MM,");
qrysb.append("SUM(CASE WHEN ACT_ID=32 THEN 1 ELSE 0 END) AS RECOM_CL,");
qrysb.append("SUM(CASE WHEN ACT_ID=32 THEN ROUND(MM_CLAIM_AMT/100000,2) ELSE 0 END) AS RECOM_MM,");
qrysb.append("SUM(CASE WHEN ACT_ID=34 THEN 1 ELSE 0 END) AS MM_DISB,");
qrysb.append("SUM(CASE WHEN ACT_ID=34 THEN ROUND(MM_CLAIM_AMT/100000,2) ELSE 0 END) AS MM_DISB_MM,");
qrysb.append("COUNT(*) AS TOTAL_CLAIM, SUM(ROUND(MM_CLAIM_AMT/100000,2)) AS MM_CLAIM_AMT         ");
qrysb.append("   FROM(SELECT MOM.OFF_NAME1        AS AGENCY_STATE,");
qrysb.append(" AD.APP_ID                 AS PMEGP_APPLICANTION_ID,");
qrysb.append(" AD.APP_NAME               AS APPLICANT_NAME,");
qrysb.append("  BD.IFSC_CODE              AS IFSC_CODE,");
qrysb.append("  BD.FB_ACNO                AS TRANSIENT_ACCNT_NO,");
qrysb.append(" TO_CHAR(BD.APPLOAN_ACCNO) AS LOAN_ACCOUNT_NUMBER,");
qrysb.append("  BD.MM_CLAIM_AMT           AS MARGIN_MONEY_CLAIMED_AMOUNT,");
qrysb.append("  MRT.CO_REMARKS,");
qrysb.append(" TRUNC(MRT.PROC_DT)  AS PROC_DT,");
qrysb.append("  TRUNC( BD.MM_CLAIM_DT) AS MM_CLAIM_DT,");
qrysb.append("  NVL(BAS.ACT_ID,0) AS ACT_ID,");
qrysb.append("  NVL(BAS.ACT_DESC, 'Pending for MM claim process') AS ACT_DESC,");
qrysb.append("  NVL(BD.MM_CLAIM_AMT,0) AS MM_CLAIM_AMT,");
qrysb.append("  BBM.BR_NAME,");
qrysb.append(" BBM.BR_ADDR,");
qrysb.append("  BBM.EMAIL,");
qrysb.append("  BBM.BRANCH_NAME,");
qrysb.append("  BBM.CONT_NO,");
qrysb.append("  BBM.DESIG,");
qrysb.append("  BBM.CONT_NAME,");
qrysb.append("  BD.APPRV_YN,");
qrysb.append("  BD.PACT_ID,");
qrysb.append("  BD.PBATCH_ID,");
qrysb.append("  TO_CHAR(BD.BATCH_DATE, 'DD-MON-RRRR') AS BTACH_DATE,");
qrysb.append("  BD.PAY_STATUS,");
qrysb.append(" BD.UTRN_NO      ");
qrysb.append("   FROM APP_DETAIL AD,");
qrysb.append("BANK_DATAENTRY BD,");
qrysb.append("MAS_OFF_MAST MOM,");
qrysb.append("M_DISTRICT MD,");
qrysb.append("M_STATE MS,");
qrysb.append("MM_REMARKS_TRANS MRT,");
qrysb.append("BANK_APP_STATUS BAS,");
qrysb.append("BANK_BR_MAST BBM      ");
qrysb.append("        WHERE AD.APP_ID       = BD.APP_ID"           );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"    );
qrysb.append("   AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD " );
qrysb.append("   AND MS.STATE_CD       = MD.STATE_CD ");
qrysb.append("   AND BD.REMTRID        = MRT.REMTR_ID(+) ");
qrysb.append("   AND BD.PACT_ID        = BAS.ACT_ID(+) ");
qrysb.append("   AND BBM.BR_IFSL_CODE  = BD.IFSC_CODE  ");
qrysb.append("  AND BD.MM_CLAIM_AMT   > 0");
qrysb.append("  AND BD.LOAN_DOCFNAME IS NOT NULL)  ");
//qrysb.append("  ORDER BY MRT.PROC_DT)");
qrysb.append("GROUP BY Rollup(MM_CLAIM_DT) ");
qrysb.append("ORDER BY TO_DATE(MM_CLAIM_DT) DESC  ");

//out.print (qrysb.toString());

 
String  MM_CLAIM_DT = "";
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
 
qry.append("   SELECT NVL(MM_DESC,'TOTAL:') AS MM_DESC, SUM(OFFLINE_NO_OF_PRJ) AS NO_OF_PRJDW, SUM(OFFLINE_MM) AS MM_RELDW");
qry.append("     FROM");
qry.append("    (SELECT 'As per Bi-Weekly Report Upto 30 June' AS MM_DESC , 21447 AS OFFLINE_NO_OF_PRJ,48122.97 AS OFFLINE_MM FROM DUAL");
qry.append("  UNION");
qry.append("  select 'Old Claim Settlement in 2016-17' AS MM_DESC, COUNT(APP_ID) AS NO_OF_PRJ_ETRAC, SUM( ROUND(NVL(MARGIN_AMOUNT_CLAIMED,0)/100000,2) )");
qry.append("  AS MARGIN_AMOUNT_CLAIMED from pmegponline.corpdata_final WHERE STATUS NOT LIKE 'F%'");
qry.append("  UNION");
qry.append("  SELECT 'New Claims as per PMEGP e-Portal' as MM_DESC, COUNT(APP_ID)  AS NO_OF_PRJ_EPORTAL, SUM(ROUND(MM_CLAIM_AMT/100000,2)) AS NEWMMCLAIM FROM BANK_DATAENTRY");
qry.append("  WHERE  PACT_ID=34)");
qry.append("  GROUP BY ROLLUP(MM_DESC)");

ResultSet rs = db.execSQL(qry.toString());

	

%>
<center>
  <h1> Day Wise Margin Money (MM) Claim And Disbursement   From 01 July,2016 to <%= curdt %>
<a href="mmclaimProcHomepage.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
 
	
<table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">DESCRIPTION</div></th>   
    <th rowspan="2"><div align="center">PROJECT-NO</div></th>
	<th rowspan="2"><div align="center">MM INVOLVED</div></th>
	</tr>
	</thead>
	<%
 while (rs.next()) {
	
MM_DESC=rs.getString("MM_DESC")==null?"Grand Total":rs.getString("MM_DESC");
NO_OF_PRJDW=rs.getString("NO_OF_PRJDW")==null?"":rs.getString("NO_OF_PRJDW");
MM_RELDW=rs.getString("MM_RELDW")==null?"":rs.getString("MM_RELDW");
	%>
	<tbody>
  <tr>
  <th><h1><%=MM_DESC%></h1></th>
  <th><h1><%= NO_OF_PRJDW %></h1></th>
  <th><h1><%= MM_RELDW %></h1></th>
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
	 <th colspan="2">Recommended For MM Release</th>    
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
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"Grand Total":rsMain.getString("MM_CLAIM_DT");
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
	<td nowrap><%=MM_CLAIM_DT %></td>	
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
