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

  <%@include file="includeHeaderedp.jsp"%>
  
  <%
   String OFF_CD = (String) session.getAttribute("SOFF_CD");
   String DISTRICT_CD = (String) session.getAttribute("SDIST_CD");

  
   StringBuffer qrysb= new StringBuffer();
 
qrysb.append(" SELECT AD.APP_ID,NVL(AD.MACHINARY_COST,0) + NVL(AD.WORKING_CAPITAL,0) AS ");
qrysb.append(" PROJECT_COST,AD.MOB_NO1,AD.APP_NAME,MD.DISTRICT_NAME,MS.STATE_NM ");
qrysb.append(" FROM APP_DETAIL AD,BANK_DATAENTRY BD,M_DISTRICT MD, M_STATE MS,EDP_CONDUCT_TRANS ED WHERE AD.APP_ID=BD.APP_ID ");
qrysb.append(" AND AD.APP_ID=ED.APP_ID AND AD.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND ED.EDP_CERT_DT IS NULL ");
qrysb.append(" AND ED.EDP_TYPE IN(2,4) AND ED.EDPOFF_CD="+OFF_CD+" ");
/*qrysb.append(" UNION ALL");
qrysb.append(" SELECT AD.APP_ID,NVL(BD.MACHINARY_COST,0) + NVL(BD.WORKING_CAPITAL,0) AS ");
qrysb.append(" PROJECT_COST,AD.MOB_NO1,AD.APP_NAME,MD.DISTRICT_NAME,MS.STATE_NM  ");
qrysb.append(" FROM BANK_DATAENTRY BD,APP_DETAIL AD,M_DISTRICT MD, M_STATE MS,MAS_OFF_MAST MOM  ");
qrysb.append(" WHERE AD.APP_ID=BD.APP_ID AND AD.OFF_CD=MOM.OFF_CD "); 
qrysb.append(" AND AD.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD");
qrysb.append(" AND AD.ACT_ID=5 AND  BD.ACT_ID=11 AND BD.EDP_CERT_DT IS NULL  ");
qrysb.append(" AND MOM.DISTRICT_CD="+DISTRICT_CD+" ");
*/ 

//out.print(qrysb.toString());



  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String APP_ID="";
String APP_NAME="";
String PROJECT_COST="";
String MOB_NO1="";

%>



<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <th colspan="9" scope="row"><div align="center">Applications Sanctioned By Bank Pending for Paid EDP Training</div></th>
    </tr>
	
  <tr>
    <th width="7%" scope="row">Sr. No. </th>
    <th width="7%">Application ID</th>
    <th width="15%"><p align="center">Applicant Name</p> </th>
    <th width="20%"><p align="center">Project Cost</p>  </th>
	<th width="20%"><p align="center">District</p> </th>
	<th width="20%"><p align="center">State</p> </th>
    <th width="22%"><div align="center">Contact Details</div></th>  
  </tr>
<%
   while (rsMain.next()) { 
   recCount=recCount+1;
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
 APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME"); 
 MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1"); 
 PROJECT_COST =rsMain.getString("PROJECT_COST")==null?"":rsMain.getString("PROJECT_COST");
 //EDP_CERT_NOT_UPLOADED=rsMain.getString("EDP_CERT_NOT_UPLOADED")==null?"":rsMain.getString("EDP_CERT_NOT_UPLOADED");
  %>

  <tr>
    <td><%= recCount %></td>
    <td><%= APP_ID %></td>
    <td> <%= APP_NAME %></td>
	<td><%= PROJECT_COST %></td>
	<td><%= DISTRICT_NAME %></td>
	<td><%= STATE_NM %></td>	
    <td><%= MOB_NO1 %></td>	
  </tr>
  <%
   }
  rsMain.close();
  db.close();
  
  
  %>
</table>

</form>
</body>