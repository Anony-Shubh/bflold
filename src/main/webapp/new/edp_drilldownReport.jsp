<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<title> Pending for EDP Training </title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
</head>
<body>
<form>

  <%@include file="includeHeaderedp.jsp"%>
  
  <%
   StringBuffer qrysb= new StringBuffer();
  
  qrysb.append("  SELECT NVL(STATE_NM,'TOTAL') AS STATE_NM, NVL(MAX(STATE_CD),'TOTAL')  AS STATE_CD,SUM(NO_OF_APP) AS NO_OF_APP,"      );
qrysb.append(" sum(EDPUPLOADED)AS EDP_CERT_UPLOADED ,sum(BANK_VERIFIED)AS EDP_BANK_VERIFIED FROM "      );
qrysb.append(" ( SELECT MS.STATE_NM,MS.STATE_CD, sum( nvl(case when bd.act_id=11 then 1 end ,0)) as tot_no_app ,"      );
qrysb.append(" SUM(NVL((SELECT COUNT(DISTINCT(APP_ID)) FROM APP_UPLOAD_TRANS AUT WHERE UPM_CD=8 AND AUT.APP_ID=BD.APP_ID),0)) AS EDPUPLOADED,"      );
qrysb.append(" sum( nvl(case when bd.edp_cert_dt IS NOT NULL and bd.act_id=11 then 1 end ,0)) as BANK_VERIFIED,"      );
qrysb.append(" MD.DISTRICT_NAME, COUNT(*) AS NO_OF_APP FROM APP_DETAIL AD, BANK_DATAENTRY BD,"      );
qrysb.append(" MAS_OFF_MAST MOM, M_STATE MS, M_DISTRICT MD WHERE AD.APP_ID = BD.APP_ID AND"      );
qrysb.append(" AD.OFF_CD = MOM.OFF_CD AND AD.UNIT_DIST_CD = MD.DISTRICT_CD AND "      );
qrysb.append(" MD.STATE_CD = MS.STATE_CD AND BD.ACT_ID = 11 GROUP BY MS.STATE_NM,MS.STATE_CD, MD.DISTRICT_NAME) GROUP BY ROLLUP(STATE_NM) "      );

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
%>
<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <th colspan="7" scope="row"><div align="center">Applications Sanctioned by Bank and Pending for EDP Training</div></th>
    </tr>
  <tr>
    <th width="7%" scope="row">Sr. No. </th>
    <th width="7%">State</th>
    <th width="15%"><p align="center">No of Application</p>
      <p align="center">Sanctioned </p></th>
    <th width="20%"><p align="center">No of EDP Certificate</p>
      <p align="center">Uploaded </p></th>
    <th width="22%"><div align="center">No of EDP Certificate verified by Bank </div></th>
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
   
  %>

  <tr>
    <td><%= recCount %></td>
    <td><%= STATE_NM %></td>
    <td> <%= NO_OF_APP %></td>
	<td><a href="edp_certuploadView.jsp?STATE=<%=STATE_NM %>"><%= EDP_CERT_UPLOADED %></td>
	<td><%= EDP_BANK_VERIFIED %></td>
    <td><a href="edp_drilldownReport_dw.jsp?STATE=<%=STATE_NM  %>">View</a></td>
    <td><a href="edpRepGenerate.jsp?REPNM=PENDINGEDPTRAINING&STATE_CD=<%= STATE_NM %>">Download</a></td>
  </tr>
  <%
   }
  rsMain.close();
  db.close();
  
  
  %>
</table>

</form>
</body>