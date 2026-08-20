<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<title> Pending for EDP Training </title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
</head>
<body>
<form>

  <%@include file="includeHeaderedp.jsp"%>
  
  <%
  String pState=request.getParameter("STATE")==null?"":request.getParameter("STATE");
   StringBuffer qrysb= new StringBuffer();
 String vcls="";
  if (!pState.equals("TOTAL")) {
vcls=vcls+"  AND MS.STATE_NM = '"+pState+"'  ";
}
  qrysb.append(" SELECT NVL(DISTRICT_NAME, 'TOTAL') AS DISTRICT_NAME,            " ); 
   qrysb.append(" MAX(STATE_CD)      AS STATE_CD,"      );
   qrysb.append(" SUM(NO_OF_APP)     AS NO_OF_APP,"      );
   qrysb.append(" SUM(EDPUPLOADED)   AS EDP_CERT_UPLOADED,"      );
   qrysb.append(" SUM(BANK_VERIFIED) AS EDP_BANK_VERIFIED"      );
 qrysb.append(" FROM"      );
   qrysb.append(" (SELECT MS.STATE_NM,"      );
     qrysb.append(" MS.STATE_CD,"      );
     qrysb.append(" SUM(NVL("      );
     qrysb.append(" CASE"      );
      qrysb.append("  WHEN BD.ACT_ID = 11"      );
      qrysb.append("  THEN 1"      );
    qrysb.append(" END, 0)) AS tot_no_app,"      );
    qrysb.append("  SUM(NVL("      );
    qrysb.append("  (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
    qrysb.append("  FROM APP_UPLOAD_TRANS AUT"      );
    qrysb.append(" WHERE AUT.UPM_CD = 8"      );
    qrysb.append("  AND AUT.APP_ID   = BD.APP_ID"      );
    qrysb.append("    ), 0)) AS EDPUPLOADED,"      );
     qrysb.append(" SUM(NVL("      );
     qrysb.append(" CASE"      );
      qrysb.append("  WHEN BD.EDP_CERT_DT IS NOT NULL"      );
      qrysb.append("  AND BD.ACT_ID        = 11"      );
       qrysb.append(" THEN 1"      );
     qrysb.append(" END, 0)) AS BANK_VERIFIED,"      );
     qrysb.append(" MD.DISTRICT_NAME,"      );
   qrysb.append("   COUNT(*) AS NO_OF_APP"      );
  qrysb.append("  FROM APP_DETAIL AD,"      );
    qrysb.append("  BANK_DATAENTRY BD,"      );
    qrysb.append("  MAS_OFF_MAST MOM,"      );
    qrysb.append("  M_STATE MS,"      );
    qrysb.append("  M_DISTRICT MD"      );
   qrysb.append(" WHERE AD.APP_ID     = BD.APP_ID"      );
  qrysb.append("  AND AD.OFF_CD       = MOM.OFF_CD"      );
   qrysb.append(" AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
   qrysb.append(" AND MD.STATE_CD     = MS.STATE_CD"      );
  qrysb.append("  AND BD.ACT_ID       = 11"      );
  qrysb.append("  "+vcls+"          "      );
   qrysb.append(" GROUP BY MS.STATE_NM,"      );
    qrysb.append("  MS.STATE_CD,"      );
    qrysb.append("  MD.DISTRICT_NAME"      );
   qrysb.append(" )"      );
 qrysb.append(" GROUP BY STATE_NM,ROLLUP(DISTRICT_NAME)"      );



//out.print (qrysb.toString());
  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String NO_OF_APP="";
String EDP_CERT_UPLOADED="";
String EDP_BANK_VERIFIED="";
%>
<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <th colspan="5" scope="row"><div align="center">Applications Sanctioned by Bank and Pending for EDP Training</div></th>
    </tr>
  <tr>
    <th colspan="2" scope="row">State Name: </th>
    <th colspan="3"><div align="left"><h2 align="center"><%= pState %></h2>
    </div></th>
    </tr>
  <tr>
    <th scope="row">Sr. No. </th>
    <th>District Name </th>
    <th><p>No of Application</p>
      <p>Ssanctioned</p></th>
    <th><p align="center">No of EDP Certificate</p>
      <p align="center">Uploaded </p></th>
    <th>No of EDP Certificate verified by Bank </th>
    </tr>
<%
   while (rsMain.next()) { 
   recCount=recCount+1;
 STATE_NM=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 //DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 NO_OF_APP=rsMain.getString("NO_OF_APP")==null?"":rsMain.getString("NO_OF_APP");
  EDP_CERT_UPLOADED=rsMain.getString("EDP_CERT_UPLOADED")==null?"":rsMain.getString("EDP_CERT_UPLOADED");
 EDP_BANK_VERIFIED=rsMain.getString("EDP_BANK_VERIFIED")==null?"":rsMain.getString("EDP_BANK_VERIFIED");
  
  %>

  <tr>
    <td><%= recCount %></td>
    <td><%= STATE_NM %></td>
    <td><%= NO_OF_APP %></td>
    <td><%= EDP_CERT_UPLOADED %></td>
    <td><%= EDP_BANK_VERIFIED %></td>
  </tr>
  <%
   }
  rsMain.close();
  db.close();
  
  
  %>
</table>

</form>
</body>