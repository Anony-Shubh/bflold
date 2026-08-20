<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<html>
<head>
<title>PMEGP Performance Report</title>
<script language="javascript" src="../js1/jquery-1.12.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/indexr.css">
<style type="text/css">
<!--
.style1 {color: #CC3333}
-->
</style>
</head>

<body>	

<form name="form1" method="post" action="">
<p>
  <%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";

String vUsrnm= (String) session.getAttribute("suser_detail");

String vsStatetit= (String) session.getAttribute("vsStatetit");

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");

 

String ReportDesc="  " ; 
String NO_OF_PRJ="";
String STATE_NM="";
String MMINV="";


 StringBuffer qrysb= new StringBuffer();
 
 


qrysb.append("   SELECT NVL(STATE_NM,'TOTAL') AS STATE_NM,MAX(STATE_CD) state_cd, COUNT(*) as NO_OF_PRJ,SUM(MMINLAK) AS MMINLAK FROM("      );
qrysb.append("   SELECT "      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.GENDER,"      );
qrysb.append("     AD.BENF_CATAGORY_CD,"      );
qrysb.append("     AD.BENF_SPECAT_CD,"      );
qrysb.append("     AD.E_MAIL,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.UNIT_LOC,"      );
qrysb.append("     MD.DISTRICT_NAME AS UNIT_DISTRICT,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     AD.UNIT_POST_ADDR,"      );
qrysb.append("     AD.UNIT_TALUK_BLOCK,"      );
qrysb.append("     AD.UNIT_PIN,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     MS.STATE_CD,"      );
qrysb.append("     AD.IND_TYPE,"      );
qrysb.append("     IGM.IND_GRP_LONG_DESC,"      );
qrysb.append("     AM.ACTIVITY_NAME,"      );
qrysb.append("     AD.PROD_DESC,"      );
qrysb.append("     BD.EDP_TRG_NAME,"      );
qrysb.append("     TO_CHAR(BD.EDP_FR_DT, 'DD-MON-RRRR') AS EDP_FR_DT,"      );
qrysb.append("     TO_CHAR(BD.EDP_TO_DT, 'DD-MON-RRRR') AS EDP_TO_DT,"      );
qrysb.append("     BD.LOAN_SANC_DT,"      );
qrysb.append("     NVL(BD.WC_SANC_FB, 0)                                  AS WC_SANC_FB,"      );
qrysb.append("     NVL(BD.CE_SANC_FB, 0)                                  AS CE_SANC_FB,"      );
qrysb.append("     NVL(BD.WC_SANC_FB, 0) + NVL(BD.CE_SANC_FB, 0)          AS TOT_SANC,"      );
qrysb.append("     NVL(BD.MACHINARY_COST, 0)                              AS MACHINARY_COST,"      );
qrysb.append("     NVL(BD.WORKING_CAPITAL, 0)                             AS WORKING_CAPITAL,"      );
qrysb.append("     NVL(BD.MACHINARY_COST, 0) + NVL(BD.WORKING_CAPITAL, 0) AS PROP_PRJ,"      );
qrysb.append("     BD.OWN_CONTRIBUTION,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.BRANCHNAME,"      );
qrysb.append("     RBL.ADDRESS,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     BD.MM_REL_DT,"      );
qrysb.append("     BD.MM_REL_AMT,ROUND(mminvolve(ad.APP_ID) / 100000, 2)AS MMINLAK, "      );
qrysb.append("     BD.UTRN_NO,"      );
qrysb.append("     BD.PAY_STATUS,"      );
qrysb.append("     BD.IST_LOAN_AMT,"      );
qrysb.append("     BD.IST_LOAN_DT,"      );
qrysb.append("    "      );
qrysb.append("     NVL(BD.MACHINARY_COST, 0) + NVL(BD.WORKING_CAPITAL, 0) AS BANK_APPRV_PRJCOST,"      );
qrysb.append("     NVL(BD.WC_SANC_FB, 0)     + NVL(BD.CE_SANC_FB, 0)      AS BANK_SANC_PRJCOST,"      );
qrysb.append("     AD.UNIT_PIN,"      );
qrysb.append("     '********'"      );
qrysb.append("     || SUBSTR(AD.AADHAR_NO, 9, 4) AADHAR_NO,"      );
qrysb.append("     '******'"      );
qrysb.append("     || SUBSTR(AD.PAN_NO, 7, 4) PAN_NO,"      );
qrysb.append("     AD.APP_POST_ADDR"      );
qrysb.append("     || ', '"      );
qrysb.append("     || AD.APP_TALUK_BLOCK"      );
qrysb.append("     || ', '"      );
qrysb.append("     || AD.APP_PIN AS APP_ADDRESS"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,  "      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD       = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD    = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE      = RBL.IFSC_CODE"      );
qrysb.append("   AND AM.IND_GRP_CD     = IGM.IND_GRP_CD"      );
qrysb.append("   AND bd.BANK_REC_DT BETWEEN '"+FromDt+"' AND '"+ToDt+"' AND BD.ACT_ID=3 "      );
qrysb.append("   AND AD.BENF_CATAGORY_CD='ST') GROUP BY ROLLUP (STATE_NM)"      );
qrysb.append("   "      );


 

 



String STATE_CD ="";




ResultSet rsMain = db.execSQL(qrysb.toString());
%>
 <table align="center">
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">PMEGP e-Portal online Performance Report </div></td>
</tr>
<tr>

<th>From Date </th>
<td><%=FromDt  %></td>
<th>To Date </th>
<td><%=ToDt  %></td>
</tr>
</table>



<table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
<thead>
<tr>
  <th >Row ID</th>
  <th  >State Nane </th>
  
  <th   >No Of Project
 </th>
  <th  >MM Release
 </th>
  
</thead>
<tbody>
	<%	
	int srno=0;	
	

	  while (rsMain.next()) { 	
	 
	  

	  
		STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
	
NO_OF_PRJ=rsMain.getString("NO_OF_PRJ")==null?"":rsMain.getString("NO_OF_PRJ");
MMINV=rsMain.getString("MMINLAK")==null?"":rsMain.getString("MMINLAK");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
srno=srno+1;	
%>	



 

<% if (!STATE_NM.equals("TOTAL")){%>
<tr>
 <td><div align="center"><%= srno 	 %></div></td>
 <td><div align="center"><a href="districtWiseRepo2.jsp?state=<%=STATE_CD%>&nm=<%=STATE_NM%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>"><%=STATE_NM  %>	</div></td>
<td ><a href="../jasperrop/nbfcGenReport.jsp?state=<%=STATE_CD%>&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRY=3"><%=NO_OF_PRJ  %></td>
<td ><%=MMINV  %>	</td>
</TR>
<%}else{%>
	<tr>
 <td><div align="center"><%= srno 	 %></div></td>
 <td><div align="center"><a href="districtWiseRepo2.jsp?state=TOTAL&nm=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>"><%=STATE_NM  %>	</div></td>
<td ><a href="../jasperrop/nbfcGenReport.jsp?state=TOTAL&FROMDT=<%=FromDt%>&TODT=<%=ToDt%>&QRY=3"><%=NO_OF_PRJ  %></td>
<td >	<%=MMINV  %>	</td>

</TR>
	

<%
}
 } //end of while
 rsMain.close();
 db.close();
 
 %>	
 
 </tbody>

</table>

 

</form>


</body>
</html>
