<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<title> Pending for EDP Training </title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script>

function form_submit() {

document.form.submit(); 
}
</script>
</head>
<body>
<form name="form" id="form" method="post">

  <%@include file="AppIncludePage.jsp"%>
  
  <%
  
   String YR=request.getParameter("FIN_YR")==null?"2020-21":(String)request.getParameter("FIN_YR");
  String vcls="";
if (YR.equals("2016-17")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2016' and '31-MAR-2017' ";
}

if (YR.equals("2017-18")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2017' and '31-MAR-2018' ";
}

if (YR.equals("2018-19")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2018' and '31-MAR-2019' ";
}
if (YR.equals("2019-20")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2019' and '31-MAR-2020' ";
}

if (YR.equals("2020-21")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2020' and TRUNC(SYSDATE) ";
}
if (YR.equals("TOTAL")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2016' and TRUNC(SYSDATE) ";
}
  
   StringBuffer qrysb= new StringBuffer();
   /*
  qrysb.append(" SELECT STATE_NM,STATE_CD,NO_OF_APP,EDP_CERT_UPLOADED,NVL(NO_OF_APP,0)-NVL(EDP_CERT_UPLOADED,0) AS EDP_CERT_NOT_UPLOADED, ");


  qrysb.append(" EDP_BANK_VERIFIED,NVL(EDP_CERT_UPLOADED,0)-NVL(EDP_BANK_VERIFIED,0) AS EDP_BANK_VERIFIED_NOT FROM ( ");
  
  
  qrysb.append("  SELECT NVL(STATE_NM,'TOTAL') AS STATE_NM, NVL(MAX(STATE_CD),'TOTAL')  AS STATE_CD,SUM(NO_OF_APP) AS NO_OF_APP,"      );
qrysb.append(" sum(EDPUPLOADED)AS EDP_CERT_UPLOADED ,sum(BANK_VERIFIED)AS EDP_BANK_VERIFIED, SUM(BANK_NOT_VERIFIED)          AS EDP_BANK_VERIFIED_NOT FROM "      );
qrysb.append(" ( SELECT MS.STATE_NM,MS.STATE_CD, sum( nvl(case when bd.act_id=11 then 1 end ,0)) as tot_no_app ,"      );
qrysb.append(" SUM(NVL((SELECT COUNT(DISTINCT(APP_ID)) FROM APP_UPLOAD_TRANS AUT WHERE UPM_CD=8 AND AUT.APP_ID=BD.APP_ID),0)) AS EDPUPLOADED,"      );
qrysb.append(" SUM(NVL(    CASE      WHEN BD.EDP_CERT_DT IS  NULL      AND BD.ACT_ID        = 11      THEN 1    END, 0)) AS BANK_NOT_VERIFIED,"      );
qrysb.append(" sum( nvl(case when bd.edp_cert_dt IS NOT NULL and bd.act_id=11 then 1 end ,0)) as BANK_VERIFIED,"      );
qrysb.append(" MD.DISTRICT_NAME, COUNT(*) AS NO_OF_APP FROM APP_DETAIL AD, BANK_DATAENTRY BD,"      );
qrysb.append(" MAS_OFF_MAST MOM, M_STATE MS, M_DISTRICT MD WHERE AD.APP_ID = BD.APP_ID AND"      );
qrysb.append(" AD.OFF_CD = MOM.OFF_CD AND AD.UNIT_DIST_CD = MD.DISTRICT_CD AND "      );
qrysb.append(" MD.STATE_CD = MS.STATE_CD AND BD.ACT_ID = 11 GROUP BY MS.STATE_NM,MS.STATE_CD, MD.DISTRICT_NAME) GROUP BY ROLLUP(STATE_NM)) order by  NO_OF_APP desc "      );
out.print(qrysb.toString());
  /*qrysb.append("  SELECT STATE_NM,MAX(STATE_CD) AS STATE_CD,SUM(NO_OF_APP) AS NO_OF_APP FROM ( SELECT MS.STATE_NM,MS.STATE_CD,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     COUNT(*) AS NO_OF_APP"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     M_DISTRICT MD"      );
qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD     = MS.STATE_CD"      );
qrysb.append("   AND BD.ACT_ID       = 11 AND BD.EDP_CERT_DT IS NULL "      );
qrysb.append("   GROUP BY MS.STATE_NM,MS.STATE_CD,"      );
qrysb.append("     MD.DISTRICT_NAME) GROUP BY ROLLUP(STATE_NM,STATE_CD) "      );*/

qrysb.append("   SELECT STATE_CD,"      );
qrysb.append("     NO_OF_APP,"      );
qrysb.append("     EDP_CERT_UPLOADED,"      );
qrysb.append("     NVL(NO_OF_APP, 0) - NVL(EDP_CERT_UPLOADED, 0) AS EDP_CERT_NOT_UPLOADED,"      );
qrysb.append("     EDP_BANK_VERIFIED,"      );
qrysb.append("     EDP_BANK_VERIFIED_NOT,"      );
qrysb.append("     STATE_NM"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT NVL(STATE_NM, 'TOTAL') AS STATE_NM,"      );
qrysb.append("       NVL(MAX(STATE_CD), 'TOTAL')  AS STATE_CD,"      );
qrysb.append("       SUM(NO_OF_APP)               AS NO_OF_APP,"      );
qrysb.append("       SUM(EDPUPLOADED)             AS EDP_CERT_UPLOADED,"      );
qrysb.append("       SUM(BANK_VERIFIED)           AS EDP_BANK_VERIFIED,"      );
qrysb.append("       SUM(BANK_NOT_VERIFIED)       AS EDP_BANK_VERIFIED_NOT"      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT MS.STATE_NM,"      );
qrysb.append("         MS.STATE_CD,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("         CASE"      );
qrysb.append("           WHEN BD.ACT_ID = 11"      );
qrysb.append("           THEN 1"      );
qrysb.append("         END, 0)) AS tot_no_app,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("         (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID"      );
qrysb.append("         ), 0)) AS EDPUPLOADED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("          (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NULL"      );
qrysb.append("         ), 0)) AS BANK_NOT_VERIFIED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("               (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NOT NULL), 0)) AS BANK_VERIFIED,bd.EDP_CERT_DT,"      );
qrysb.append("         MD.DISTRICT_NAME,"      );
qrysb.append("         COUNT(*) AS NO_OF_APP"      );
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("         BANK_DATAENTRY BD,"      );
qrysb.append("         MAS_OFF_MAST MOM,"      );
qrysb.append("         M_STATE MS,"      );
qrysb.append("         M_DISTRICT MD"      );
qrysb.append("       WHERE AD.APP_ID     = BD.APP_ID (+)"      );
qrysb.append("       AND AD.OFF_CD       = MOM.OFF_CD AND AD.ACT_ID=5 "      );
qrysb.append("       AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("       AND MD.STATE_CD     = MS.STATE_CD"      );
qrysb.append("       AND (BD.ACT_ID      = 11) AND "+vcls+" "      );
qrysb.append("       GROUP BY MS.STATE_NM,"      );
qrysb.append("         MS.STATE_CD,"      );
qrysb.append("         MD.DISTRICT_NAME,BD.EDP_CERT_DT"      );
qrysb.append("       )"      );
qrysb.append("     GROUP BY ROLLUP(STATE_NM)"      );
qrysb.append("     )"      );
qrysb.append("   ORDER BY NO_OF_APP DESC"      );

//out.print(qrysb.toString());



  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String NO_OF_APP="";
String STATE_CD="";
String EDP_CERT_UPLOADED="";
String EDP_BANK_VERIFIED="";
String EDP_BANK_VERIFIED_NOT="";
String EDP_CERT_NOT_UPLOADED="";
%>



<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <th colspan="9" scope="row"><div align="center">Applications Sanctioned by Bank and Pending for EDP Training</div></th>
    </tr>
	<tr>
      <td colspan="5">SELECT FINANCIAL YEAR:</td>
      <td colspan="4"><div align="center"><select name="FIN_YR"  id="FIN_YR" onChange="form_submit();">
	         	
			   <option value="2020-21"<% if (YR.equals("2020-21")){ out.println("selected");}%> > 2020-21</option>
			   <option value="2019-20" <% if (YR.equals("2019-20")){ out.println("selected");}%> > 2019-20</option>
			    <option value="2018-19" <% if (YR.equals("2018-19")){ out.println("selected");}%> > 2018-19</option>
				 <option value="2017-18" <% if (YR.equals("2017-18")){ out.println("selected");}%> > 2017-18</option>
				  <option value="2016-17" <% if (YR.equals("2016-17")){ out.println("selected");}%> > 2016-17</option>
			   </select></div>
      </td>
    </tr>
  <tr>
    <th width="7%" scope="row">Sr. No. </th>
    <th width="7%">State</th>
    <th width="15%"><p align="center">No of Application</p>
      <p align="center">Sanctioned </p></th>
    <th width="20%"><p align="center">No of EDP Certificate</p>
      <p align="center">Uploaded </p></th>
	   <th width="20%"><p align="center">No of EDP Certificate</p>
      <p align="center">Not Uploaded </p></th>
    <th width="22%"><div align="center">No of EDP Certificate Uploaded and verified by Bank </div></th>
	 <th width="22%"><div align="center">No of EDP Certificate Uploaded yet to be verified by Bank </div></th>
    <th width="15%"><div align="center">District Wise Report </div></th>
    <th width="14%">Applicant Detail </th>
  </tr>
<%
   while (rsMain.next()) { 
   recCount=recCount+1;
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
 NO_OF_APP=rsMain.getString("NO_OF_APP")==null?"":rsMain.getString("NO_OF_APP");
 EDP_CERT_UPLOADED=rsMain.getString("EDP_CERT_UPLOADED")==null?"":rsMain.getString("EDP_CERT_UPLOADED"); 
 EDP_BANK_VERIFIED=rsMain.getString("EDP_BANK_VERIFIED")==null?"":rsMain.getString("EDP_BANK_VERIFIED"); 
 EDP_BANK_VERIFIED_NOT =rsMain.getString("EDP_BANK_VERIFIED_NOT")==null?"":rsMain.getString("EDP_BANK_VERIFIED_NOT");
 EDP_CERT_NOT_UPLOADED=rsMain.getString("EDP_CERT_NOT_UPLOADED")==null?"":rsMain.getString("EDP_CERT_NOT_UPLOADED");
  %>

  <tr>
    <td><%= recCount %></td>
    <td><%= STATE_NM %></td>
    <td> <%= NO_OF_APP %></td>
	<td><a href="edp_certuploadView.jsp?STATE=<%=STATE_NM %>"><%= EDP_CERT_UPLOADED %></td>
	<td><%= EDP_CERT_NOT_UPLOADED %></td>
	<td><%= EDP_BANK_VERIFIED %></td>
	 <td><a href="edpRepGenerate.jsp?REPNM=EDPBANKNOTVERIFY&STATE_CD=<%= STATE_NM %>"><%=EDP_BANK_VERIFIED_NOT %></a></td>
    <td><a href="edp_drilldownReport_dw.jsp?STATE=<%=STATE_NM  %>">View</a></td>
    <td><a href="edpRepGenerate.jsp?REPNM=PENDINGEDPTRAINING&STATE_CD=<%= STATE_NM %>&YR=<%=YR%>">Download</a></td>
  </tr>
  <%
   }
  rsMain.close();
  db.close();
  
  
  %>
</table>

</form>
</body>