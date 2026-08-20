<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<title> Pending for EDP Training </title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
</head>
<body>
<form>

    <%@include file="AppIncludePage.jsp"%>
  
  <%
  String pState=request.getParameter("STATE")==null?"":request.getParameter("STATE");
  String vcls="";
  if (!pState.equals("TOTAL")) {
vcls=vcls+"  AND MS.STATE_NM = '"+pState+"'  ";
}
   StringBuffer qrysb= new StringBuffer();
   qrysb.append("  SELECT AD.APP_ID,  AD.APP_NAME,  AD.OFF_CD,  AUT.UPM_CD,  MAX(AUT.DOC_NAME) AS DOC_NAME, MAX(TO_CHAR(UPLOAD_TIMESTAMP,'DD-MM-YYYY')) AS UPLOAD_TIMESTAMP ,  "      );
  qrysb.append("  AD.GENDER,  AD.MOB_NO1,  AD.AADHAR_NO,  MOM.AGENCY_TYPE,  MD.DISTRICT_NAME,  MS.STATE_NM,MS.STATE_CD "      );
qrysb.append("  FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  APP_UPLOAD_TRANS AUT,  M_DISTRICT MD,  M_STATE MS,"      );
 qrysb.append(" MAS_OFF_MAST MOM WHERE AD.APP_ID     = BD.APP_ID AND BD.APP_ID       = AUT.APP_ID"      );
qrysb.append("  AND AD.UNIT_DIST_CD = MD.DISTRICT_CD AND MOM.OFF_CD      = AD.OFF_CD AND MD.STATE_CD     = MS.STATE_CD"      );
qrysb.append("  "+vcls+"  AND AUT.UPM_CD      = 8  AND BD.ACT_ID = 11  GROUP BY AD.APP_ID,  AD.APP_NAME,  AD.OFF_CD,"      );
 qrysb.append("   AUT.UPM_CD,  AD.GENDER,  AD.MOB_NO1,  AD.AADHAR_NO,  MOM.AGENCY_TYPE,  MD.DISTRICT_NAME,  MS.STATE_NM  ,MS.STATE_CD   "      );
   
 

  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String APP_ID="";
String APP_NAME="";
String DOC_NAME="";
String MOB_NO1="";
String AADHAR_NO="";
String AGENCY_TYPE="";
String STATE_CD="";
String UPLOAD_TIMESTAMP="";
%>
<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <th colspan="10" scope="row"><div align="center">Applications Sanctioned by Bank and Pending for EDP Training</div></th>
    </tr>
  <tr>
    <th width="6%" scope="row">Sr. No. </th>
    <th width="7%">State</th>
    <th width="9%"><div align="center">District</div></th>
    <th width="9%"><div align="center">Agency</div></th>
    <th width="9%"><div align="center">App_ID</div></th>
   <th width="12%"><div align="center">App_Name</div></th>
    <th width="9%"><div align="center">Aadhar No </div></th>
    <th width="10%"><div align="center">Contact no</div></th>
	 <th width="14%"><div align="center">EDP Upload Date</div></th>
    <th width="15%">EDP Certificate</th>
	 
  </tr>
<%
   while (rsMain.next()) { 
   recCount=recCount+1;
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
 DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID"); 
 APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME"); 
 DOC_NAME=rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");
 MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1"); 
 AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");  
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE"); 
  UPLOAD_TIMESTAMP=rsMain.getString("UPLOAD_TIMESTAMP")==null?"":rsMain.getString("UPLOAD_TIMESTAMP"); 
 //session.setAttribute("sAPP_ID",APP_ID);
  %>

  <tr>
    <td><div align="center"><%= recCount %></div></td>
    <td><div align="center"><%= STATE_NM %></div></td>
    <td><div align="center"> <%= DISTRICT_NAME %></div></td>
	<td><div align="center"><%= AGENCY_TYPE %></div></td>
    <td><div align="center"><%= APP_ID %></div></td>
    <td><div align="center"> <%= APP_NAME %></div></td>
	 <td><div align="center"> <%= AADHAR_NO %></div></td>
	 <td><div align="center"> <%= MOB_NO1 %></div></td>
      <td><div align="center"><%=UPLOAD_TIMESTAMP%></div> </td>
	 <td><div align="center"><a href="../jsp/doctransfertoNas.jsp?docname=<%= DOC_NAME %>&APP_ID=<%= APP_ID %>"  class="button">View EDP Certificate </a></div></td>
    
  </tr>
  <%
   }
  rsMain.close();
  db.close();
  
  %>
</table>

</form>
</body>