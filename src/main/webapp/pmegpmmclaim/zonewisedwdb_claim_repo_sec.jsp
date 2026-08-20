<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>
		<script>
		 function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

return (showdt);
}
 
 function todaydt() {
 test = new Date()
document.getElementById("TODT").value=now();
 }


   $(document).ready(function() {
 
todaydt();
            
        });

</script>




</head>

<body>
<FORM name="form" method="post">
<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<%
String VUSER_ID ="";
String VUSER_DETAIL ="";
String VSUSER_TYPE ="";

try {

 VUSER_ID = session.getAttribute("SUSER_ID")==null?"":(String) session.getAttribute("SUSER_ID");
 VUSER_DETAIL = session.getAttribute("SUSER_DETAIL")==null?"":(String) session.getAttribute("SUSER_DETAIL");
 VSUSER_TYPE = session.getAttribute("SUSER_TYPE")==null?"":(String) session.getAttribute("SUSER_TYPE");


if (VUSER_ID.equals("")) {
//session.invalidate();
response.sendRedirect("index.jsp");
}
}catch (Exception e){
response.sendRedirect("index.jsp");

}

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
//DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);
String FROMDT=request.getParameter("FROMDT")==null?"01-JUL-2016":(String) request.getParameter("FROMDT");
String TODT=request.getParameter("TODT")==null?"":(String) request.getParameter("TODT");
//out.print(FROMDT);
//out.print(TODT);

if (TODT.equals("")){
	TODT=curdt;
}else{
	TODT=TODT;
}
%>
<br><br><br>   
<table width="50%" align="center">
  <tr>
    <td><div align="center">Statements From </div></td>
    <td><div align="center">
    <input name="FROMDT" type="text" id="FROMDT" value="<%=FROMDT%>"  onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')">
    </div></td>
    <td><div align="center">to</div></td>
    <td><div align="center">
      <input name="TODT" type="text" id="TODT"  value="<%=TODT%>" onClick="javascript:NewCssCal('TODT','ddMMMyyyy')">
	  
    </div></td>
	<td><div align="center"><INPUT name="button32" type="submit" class="buttonMerun"  value="Submit" ></div></td>
  </tr>
</table><br>
<%
 StringBuffer qrysb= new StringBuffer();
 
/*qrysb.append("SELECT nvl(ZONE_NM,'TOTAL') AS ZONE_NM,NVL(OFF_NAME1,'TOTAL') AS OFF_NAME1,COUNT(APP_ID) AS TOT_MM_CLAIM_PRJ, SUM(MM_CLAIM_AMT) AS TOT_MM_CLAIM_MM, "      ); 
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
*/
qrysb.append("SELECT /*+ NOPARALLEL(AUTO) */  nvl(ZONE_NM,'TOTAL') AS ZONE_NM,NVL(OFF_NAME1,'TOTAL') AS OFF_NAME1,"      ); 
qrysb.append("COUNT(*) AS TOT_MM_CLAIM_PRJ, SUM(ROUND(MM_CLAIM_AMT / 100000, 2)) AS TOT_MM_CLAIM_MM, "      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RMR' THEN 1 ELSE 0 END) NO_OF_PRJ_RMR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='RMR' THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) MM_CLAIM_AMT_RMR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='MR' THEN 1 ELSE 0 END) NO_OF_PRJ_MR,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='MR' THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) MM_CLAIM_AMT_MR ,"      ); 
qrysb.append("SUM(CASE WHEN VUPLOADTIMESTAMP > = PROC_DT AND PACT_ID=30 THEN 1 ELSE 0 END) AS NO_OF_PRJ_RC,"      ); 
qrysb.append("SUM(CASE WHEN VUPLOADTIMESTAMP > = PROC_DT AND PACT_ID=30 THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS MM_CLAIM_AMT_RC,"      ); 
qrysb.append("SUM(CASE WHEN (VUPLOADTIMESTAMP< PROC_DT OR (VUPLOADTIMESTAMP IS NULL OR PROC_DT IS NULL)) AND PACT_ID=30 THEN 1 ELSE 0 END)NO_OF_PRJ_RP,"      ); 
qrysb.append("SUM(CASE WHEN (VUPLOADTIMESTAMP< PROC_DT OR (VUPLOADTIMESTAMP IS NULL OR PROC_DT IS NULL)) AND PACT_ID=30 THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS MM_CLAIM_AMT_RP,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='CUP' THEN 1 ELSE 0 END) NO_OF_PRJ_CUP,"      ); 
qrysb.append("SUM(CASE WHEN APP_STATUS='CUP' THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) MM_CLAIM_AMT_CUP,"      ); 
qrysb.append("SUM(CASE WHEN NVL(PACT_ID,0)= 32  AND APPRV_YN = 'S' THEN 1 ELSE 0 END) AS PEND_APPRV,"      ); 
qrysb.append(" SUM(CASE WHEN NVL(PACT_ID,0)= 32  AND APPRV_YN = 'S' THEN ROUND(MM_CLAIM_AMT / 100000, 2) ELSE 0 END) AS PEND_APPRV_MM "      ); 
qrysb.append(" FROM ( SELECT  /*+ NOPARALLEL(AUTO) */    BD.APP_ID,"      ); 
qrysb.append("   AD.APP_NAME,"      ); 
qrysb.append("   (CASE WHEN NVL(BD.PACT_ID,0)=34 AND BD.APPRV_YN='A'"      ); 
qrysb.append("   THEN 'MR'"      ); 
qrysb.append("   WHEN NVL(BD.PACT_ID,0)=32 AND BD.APPRV_YN='A'"      ); 
qrysb.append("   THEN 'RMR'"      ); 
qrysb.append("   WHEN  BD.PACT_ID IS NULL    "      ); 
qrysb.append("   THEN 'CUP' "      ); 
qrysb.append("   ELSE 'NA'"      ); 
qrysb.append("   END) AS APP_STATUS ,"      ); 
qrysb.append("   (SELECT MAX(TRUNC(UPLOAD_TIMESTAMP))  "      ); 
qrysb.append("   FROM APP_UPLOAD_TRANS AUT WHERE  AUT.APP_ID=BD.APP_ID AND AUT.UPM_CD IN (17,18,19,8)) AS VUPLOADTIMESTAMP ,"      ); 
qrysb.append("   CASE WHEN NVL(BD.PACT_ID,0)=30"      ); 
qrysb.append("   THEN TRUNC(MRT.PROC_DT) END AS PROC_DT,"      );  
qrysb.append("   BD.LOAN_DOCFNAME,"      ); 
qrysb.append("   BD.MM_CLAIM_AMT,"      ); 
 qrysb.append("  MOM.AGENCY_TYPE,"      ); 
qrysb.append("   MOM.OFF_NAME1,"      ); 
qrysb.append("   ZM.ZONE_NM,"      ); 
qrysb.append("   MS.STATE_NM,"      ); 
qrysb.append("   BD.PAY_STATUS,"      ); 
 qrysb.append("  BD.UTRN_NO, BD.PACT_ID,  BD.MM_CLAIM_DT,  BD.MM_REL_AMT,"      ); 
qrysb.append("   BD.MM_REL_DT,  BD.APPRV_YN  FROM APP_DETAIL_SECOND AD,  BANK_DATAENTRY_SECOND BD,"      ); 
qrysb.append("   MAS_OFF_MAST MOM,  M_DISTRICT MD,  MM_REMARKS_TRANS_SECOND MRT,  M_STATE MS,"      ); 
qrysb.append("   ZONE_MAST ZM     WHERE AD.APP_ID       = BD.APP_ID   "      );  
qrysb.append(" AND MOM.OFF_CD        = AD.OFF_CD  "      ); 
qrysb.append(" AND MOM.DISTRICT_CD   = MD.DISTRICT_CD    "      );  
qrysb.append(" AND MD.STATE_CD       = MS.STATE_CD    "      ); 
qrysb.append(" AND MS.ZONE_CD        = ZM.ZONE_CD   "      ); 
qrysb.append(" AND BD.LOAN_DOCFNAME IS NOT NULL  "      ); 
qrysb.append(" AND BD.REMTRID = MRT.REMTR_ID(+)"      ); 
qrysb.append(" AND BD.MM_CLAIM_AMT   > 0   "      );
qrysb.append(" AND AD.ACT_ID         = 5  "      );  
qrysb.append(" AND BD.ACT_ID         = 11)"      );   
qrysb.append(" GROUP BY  ROLLUP("      ); 
qrysb.append(" ZONE_NM ,OFF_NAME1)"      ); 
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
String APPR_STATUS="";
String PEND_APPRV_MM="";
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
	<th colspan="2" rowspan="2"><div align="center">Recommended For MM Release and Approved </div></th>  
    <th rowspan="2" colspan="2"><div align="center">Pending for Approval </div></th>
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
	 <th><div align="center">Prj. No</div></th>
    <th><div align="center">MM Amt</div></th>
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
//APPR_STATUS=rsMain.getString("APPr_STATUS")==null?"":rsMain.getString("APP_STATUS");
MM_CLAIM_AMT_RMR=rsMain.getString("MM_CLAIM_AMT_RMR")==null?"":rsMain.getString("MM_CLAIM_AMT_RMR");
MM_CLAIM_AMT_MR=rsMain.getString("MM_CLAIM_AMT_MR")==null?"":rsMain.getString("MM_CLAIM_AMT_MR");
MM_CLAIM_AMT_RC=rsMain.getString("MM_CLAIM_AMT_RC")==null?"":rsMain.getString("MM_CLAIM_AMT_RC");
MM_CLAIM_AMT_RP=rsMain.getString("MM_CLAIM_AMT_RP")==null?"":rsMain.getString("MM_CLAIM_AMT_RP");
MM_CLAIM_AMT_CUP=rsMain.getString("MM_CLAIM_AMT_CUP")==null?"":rsMain.getString("MM_CLAIM_AMT_CUP");
TOT_MM_CLAIM_PRJ=rsMain.getString("TOT_MM_CLAIM_PRJ")==null?"":rsMain.getString("TOT_MM_CLAIM_PRJ");
TOT_MM_CLAIM_MM=rsMain.getString("TOT_MM_CLAIM_MM")==null?"":rsMain.getString("TOT_MM_CLAIM_MM");
PEND_APPRV=rsMain.getString("PEND_APPRV")==null?"":rsMain.getString("PEND_APPRV");
PEND_APPRV_MM=rsMain.getString("PEND_APPRV_MM")==null?"":rsMain.getString("PEND_APPRV_MM");

srno =srno+1;
%>

<tbody>

  <tr>
    <td><%=srno %></td>
	<td><%=ZONE_NM %></td>
    <td><%=OFF_NAME1 %></td>	
    <td><a href="appZonewisedwdb_sec.jsp?ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>" ><%= TOT_MM_CLAIM_PRJ %></a></div></td>
    <td><%= TOT_MM_CLAIM_MM %></td>
    <td><a href="appZonewisedwdb_sec.jsp?APP_STATUS=CUP&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>&FROMDT=<%=FROMDT%>&TODT=<%=TODT%>"><%=NO_OF_PRJ_CUP %></a></div></td>
    <td><%=MM_CLAIM_AMT_CUP %></td>	
	<td><a href="appZonewisedwdb_sec.jsp?APP_STATUS=RC&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>&FROMDT=<%=FROMDT%>&TODT=<%=TODT%>" ><%=NO_OF_PRJ_RC %></a></div></td>
	<td><%=MM_CLAIM_AMT_RC %></td>
	<td><a href="appZonewisedwdb_sec.jsp?APP_STATUS=RP&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>&FROMDT=<%=FROMDT%>&TODT=<%=TODT%>" ><%=NO_OF_PRJ_RP %></a></div></td>
	<td><%= MM_CLAIM_AMT_RP%></td>
	<td><a href="appZonewisedwdb_sec.jsp?APP_STATUS=RMR&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>&FROMDT=<%=FROMDT%>&TODT=<%=TODT%>" ><%=NO_OF_PRJ_RMR %></a></div></td>
	<td><%=MM_CLAIM_AMT_RMR %></td>
	<td><a href="appZonewisedwdb_sec.jsp?APPR_STATUS=A&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>&FROMDT=<%=FROMDT%>&TODT=<%=TODT%>" ><%= PEND_APPRV %></a></div></td>
	<td><%=PEND_APPRV_MM%></td>
	<td><a href="appZonewisedwdb_sec.jsp?APP_STATUS=MR&ZONE_NM=<%=ZONE_NM %>&OFF_NAME=<%=OFF_NAME1 %>&FROMDT=<%=FROMDT%>&TODT=<%=TODT%>" ><%=NO_OF_PRJ_MR %></a></div></td>
	<td><%= MM_CLAIM_AMT_MR%></td>
  </tr>
  </tbody>
   
  <%  }
  rsMain.close();
  db.close();
    %>
   
</table>
</FORM>
</body>
</html>
