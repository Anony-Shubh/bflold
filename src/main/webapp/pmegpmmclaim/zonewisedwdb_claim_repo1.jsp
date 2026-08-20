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
<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<%

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();
 
qrysb.append("SELECT nvl(ZONE_NM,'TOTAL') AS ZONE_NM,NVL(OFF_NAME1,'TOTAL') AS OFF_NAME1,COUNT(APP_ID) AS TOT_MM_CLAIM_PRJ, SUM(MM_CLAIM_AMT) AS TOT_MM_CLAIM_MM, "      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RMR' THEN 1 ELSE 0 END) NO_OF_PRJ_RMR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RMR' THEN (MM_CLAIM_AMT) ELSE 0 END) MM_CLAIM_AMT_RMR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='CUP' THEN 1 ELSE 0 END) NO_OF_PRJ_CUP,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='CUP' THEN (MM_CLAIM_AMT) ELSE 0 END) MM_CLAIM_AMT_CUP,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='MR' THEN 1 ELSE 0 END) NO_OF_PRJ_MR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='MR' THEN (MM_CLAIM_AMT) ELSE 0 END) MM_CLAIM_AMT_MR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RC' THEN 1 ELSE 0 END) NO_OF_PRJ_RC,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RC' THEN (MM_CLAIM_AMT) ELSE 0 END) MM_CLAIM_AMT_RC," );
qrysb.append("SUM(CASE WHEN APP_STATUS='RP' THEN 1 ELSE 0 END) NO_OF_PRJ_RP, SUM(CASE WHEN APPRV_YN <>'A' AND PACT_ID IN (30,32) THEN 1 ELSE 0 END) AS PEND_APPRV,  "      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RP' THEN (MM_CLAIM_AMT) ELSE 0 END) MM_CLAIM_AMT_RP FROM   "      ); 
qrysb.append("( SELECT AD.APP_ID,"      );
 qrysb.append(" AD.APP_NAME,"      );
  qrysb.append("PMEGPCO_PENDINGSTATUS(AD.APP_ID) APP_STATUS,"      );
  qrysb.append("BD.LOAN_DOCFNAME,"      );
  qrysb.append("BD.MM_CLAIM_AMT,"      );
  qrysb.append("MOM.AGENCY_TYPE,"      );
  qrysb.append("MOM.OFF_NAME1,"      );
  qrysb.append("ZM.ZONE_NM,"      );
  qrysb.append("MS.STATE_NM,"      );
  qrysb.append("BD.PAY_STATUS,"      );
  qrysb.append("BD.UTRN_NO,"      );
  qrysb.append("BD.PACT_ID,"      );
  qrysb.append("BD.MM_CLAIM_DT,"      );
  qrysb.append("BD.MM_REL_AMT,"      );
 qrysb.append(" BD.MM_REL_DT,"      );
  qrysb.append("BD.APPRV_YN        "      );
qrysb.append("FROM APP_DETAIL AD,"      );
  qrysb.append("BANK_DATAENTRY BD,"      );
 qrysb.append(" MAS_OFF_MAST MOM,"      );
  qrysb.append("M_DISTRICT MD,"      );
  qrysb.append("M_STATE MS,"      );
  qrysb.append("ZONE_MAST ZM     "      );
qrysb.append("WHERE AD.APP_ID       = BD.APP_ID    "      );
qrysb.append("AND MOM.OFF_CD        = AD.OFF_CD     "      );
qrysb.append("AND MOM.DISTRICT_CD   = MD.DISTRICT_CD     "      );
qrysb.append("AND MD.STATE_CD       = MS.STATE_CD    "      );
qrysb.append("AND MS.ZONE_CD        = ZM.ZONE_CD   "      );
qrysb.append("AND BD.LOAN_DOCFNAME IS NOT NULL   "      );
qrysb.append("AND BD.MM_CLAIM_AMT   > 0   "      );
qrysb.append("AND AD.ACT_ID         = 5   "      );
qrysb.append("AND BD.ACT_ID         = 11)  "      );
qrysb.append("GROUP BY  ROLLUP("      );
qrysb.append("ZONE_NM ,OFF_NAME1)  "      );

//out.print (qrysb.toString());

String  ZONE_NM = "";
String  OFF_NAME1 = "";
String  APP_STATUS="";
String  NO_OF_PRJ_RMR = "";
String  NO_OF_PRJ_MR= "";
String  NO_OF_PRJ_RC= "";
String  NO_OF_PRJ_RP = "";
String  NO_OF_PRJ_CUP = "";
String  MM_CLAIM_AMT_RMR = "";
String  MM_CLAIM_AMT_MR = "";
String  MM_CLAIM_AMT_RC = "";
String  MM_CLAIM_AMT_RP = "";
String  MM_CLAIM_AMT_CUP = "";
String TOT_MM_CLAIM_PRJ="";
String TOT_MM_CLAIM_MM="";
String PEND_APPRV="";
DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<center>
  <h1> Margin Money (MM) Claim Status Zone Wise 01 July,2016 to <%= curdt %>
<a href="mmclaimProcHomepage.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="3"><div align="center">SRNO</div></th>
    <th rowspan="3"><div align="center">ZONE </div></th>
	 <th rowspan="3"><div align="center">Office Name </div></th>
	<th colspan="2" rowspan="2"><div align="center">MM Claimed</div></th>
	<th colspan="4"><div align="center">Claims Under Process</div></th>
	<th colspan="2" rowspan="2"><div align="center">Referred to SO/DO and pending for retification </div></th>
	<th colspan="2" rowspan="2"><div align="center">Recommended For MM Release</div></th>  
    <th rowspan="2"><div align="center">Pending for Approval </div></th>
    <th colspan="2" rowspan="2"><div align="center">MM Released by corp. Bank </div></th>
    </tr>
  <tr>
    <th colspan="2"><div align="center">New Claims for process </div></th>
    <th colspan="2"><div align="center">Retified by so/do </div></th>
    </tr>
  <tr>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt </div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt</div></th>
    <th><div align="center">Prj. No </div></th>
    <th><div align="center">MM Amt</div></th>
    <th><div align="center">Prj. No</div></th>
    <th><div align="center">MM Amt</div></th>
	<th><div align="center"></div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">MM Amt</div></th>
  </tr>
   </thead>
  <% 

int srno =0;
 while (rsMain.next()) { 
ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
NO_OF_PRJ_RMR=rsMain.getString("NO_OF_PRJ_RMR")==null?"":rsMain.getString("NO_OF_PRJ_RMR");
NO_OF_PRJ_MR=rsMain.getString("NO_OF_PRJ_MR")==null?"":rsMain.getString("NO_OF_PRJ_MR");
NO_OF_PRJ_RC=rsMain.getString("NO_OF_PRJ_RC")==null?"":rsMain.getString("NO_OF_PRJ_RC");
NO_OF_PRJ_RP=rsMain.getString("NO_OF_PRJ_RP")==null?"":rsMain.getString("NO_OF_PRJ_RP");
NO_OF_PRJ_CUP=rsMain.getString("NO_OF_PRJ_CUP")==null?"":rsMain.getString("NO_OF_PRJ_CUP");
//APP_STATUS=rsMain.getString("APP_STATUS")==null?"":rsMain.getString("APP_STATUS");
MM_CLAIM_AMT_RMR=rsMain.getString("MM_CLAIM_AMT_RMR")==null?"":rsMain.getString("MM_CLAIM_AMT_RMR");
MM_CLAIM_AMT_MR=rsMain.getString("MM_CLAIM_AMT_MR")==null?"":rsMain.getString("MM_CLAIM_AMT_MR");
MM_CLAIM_AMT_RC=rsMain.getString("MM_CLAIM_AMT_RC")==null?"":rsMain.getString("MM_CLAIM_AMT_RC");
MM_CLAIM_AMT_RP=rsMain.getString("MM_CLAIM_AMT_RP")==null?"":rsMain.getString("MM_CLAIM_AMT_RP");
MM_CLAIM_AMT_CUP=rsMain.getString("MM_CLAIM_AMT_CUP")==null?"":rsMain.getString("MM_CLAIM_AMT_CUP");
TOT_MM_CLAIM_PRJ=rsMain.getString("TOT_MM_CLAIM_PRJ")==null?"":rsMain.getString("TOT_MM_CLAIM_PRJ");
TOT_MM_CLAIM_MM=rsMain.getString("TOT_MM_CLAIM_MM")==null?"":rsMain.getString("TOT_MM_CLAIM_MM");
PEND_APPRV=rsMain.getString("PEND_APPRV")==null?"":rsMain.getString("PEND_APPRV");

srno =srno+1;
%>

<tbody>

  <tr>
    <td><%=srno %></td>
	<td><%=ZONE_NM %></td>
    <td><%=OFF_NAME1 %></td>	
    <td><%= TOT_MM_CLAIM_PRJ %></td>
    <td><%= TOT_MM_CLAIM_MM %></td>
    <td><a href="appZonewisedwdb.jsp?APP_STATUS=CUP&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>"><%=NO_OF_PRJ_CUP %></a></div></td>
    <td><%=MM_CLAIM_AMT_CUP %></td>	
	<td><a href="appZonewisedwdb.jsp?APP_STATUS=RC&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>" ><%=NO_OF_PRJ_RC %></a></div></td>
	<td><%=MM_CLAIM_AMT_RC %></td>
	<td><a href="appZonewisedwdb.jsp?APP_STATUS=RP&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>" ><%=NO_OF_PRJ_RP %></a></div></td>
	<td><%= MM_CLAIM_AMT_RP%></td>
	<td><a href="appZonewisedwdb.jsp?APP_STATUS=RMR&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>" ><%=NO_OF_PRJ_RMR %></a></div></td>
	<td><%=MM_CLAIM_AMT_RMR %></td>
	<td><%= PEND_APPRV %></td>
	<td><a href="appZonewisedwdb.jsp?APP_STATUS=MR&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>" ><%=NO_OF_PRJ_MR %></a></div></td>
	<td><%= MM_CLAIM_AMT_MR%></td>
  </tr>
  </tbody>
   
  <%  }
  rsMain.close();
  db.close();
    %>
   
</table>

</body>
</html>
