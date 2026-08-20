 <%@ include file="MonitoringRep.jsp" %>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>

<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>
<head>
<title>PMEGP Bank Data Entry Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
</head>
<body>
<form  method="post"  name="form" id="form" >
 
 
  <%
  String PV_DT="";
  String PV_STATUS="";
  String PHY_EMP_PT="";
  String PHY_EMP_FT="";
  String PHY_ANL_TO="";
  String PHY_INV="";
  String PHTR_ID="";
  
  
  
  String APPID=  session.getAttribute("SAPP_ID")==null?"":(String) session.getAttribute("SAPP_ID");

StringBuffer qrysb= new StringBuffer();
qrysb.append("  SELECT to_char(m.PV_DT,'DD-MON-RRRR') AS PV_DT,DECODE(m.PV_STATUS,'WO','WORKING','NS','NOT STARTED','NT','NOT TRACEBLE','DF','DEFUNCT') AS PV_STATUS,NVL(m.PHY_EMP_PT,0)+NVL(m.PHY_EMP_FT,0) AS  PHY_EMP_PT, "      );
qrysb.append("     m.PHY_ANL_TO,  m.PHY_INV,  m.PHTR_ID FROM monitoring_pv_detail m WHERE APP_ID='"+APPID+"' "      );


DBCon db= new DBCon();
db.connect();
%>
<table align="center">

<tr>
  <td><table class="CSSTableGenerator">
    <tr bgcolor="#D1A476">
      <td colspan="8"><div align="center" class="style1">
          <h3>APPLICANT ID:<%=APPID%></h3>
      </div></td>
    </tr>
	<tr bgcolor="#D1A476">
      <td colspan="8"><div align="right" class="style1">
          <h3><a href="monitoring.jsp" class="buttonMerun">ADD NEW MONITORING REPORT </a></h3>
      </div></td>
    </tr>
	 <tr>
      <th>Sr.No</th>
      <th>Verification Dtae </th>
      <th>Status</th>
      <th>Total Emp </th>
      <th>Annual Production </th>
      <th>Annual Sales </th>   
      <th>Report</th>
      </tr>

	<%
int srno=0;
ResultSet rsMain = db.execSQL(qrysb.toString());
 while (rsMain.next()) {
PV_DT =rsMain.getString("PV_DT")==null?"":rsMain.getString("PV_DT");
PV_STATUS =rsMain.getString("PV_STATUS")==null?"":rsMain.getString("PV_STATUS");
PHY_EMP_PT =rsMain.getString("PHY_EMP_PT")==null?"":rsMain.getString("PHY_EMP_PT");
PHY_ANL_TO =rsMain.getString("PHY_ANL_TO")==null?"":rsMain.getString("PHY_ANL_TO");
PHY_INV =rsMain.getString("PHY_INV")==null?"":rsMain.getString("PHY_INV");
PHTR_ID =rsMain.getString("PHTR_ID")==null?"":rsMain.getString("PHTR_ID");

srno=srno+1;


%>


       <tr>
      <td><%=srno%></th>
      <th ><%=PV_DT%></th>
      <td><%=PV_STATUS%></td>
      <td ><%=PHY_EMP_PT%> </td>
      <td ><%=PHY_ANL_TO%></td>
	  <td><%=PHY_INV%></td>
     
      <td ><a href="../jasperrop/monitoView.jsp?APP_ID=<%=APPID%>&PHTRID=<%=PHTR_ID%>" target="_blank" class="buttonBlue">View </a></td>
    </tr>
	<%

}
rsMain.close();
db.close();


%>
  </table>
  
