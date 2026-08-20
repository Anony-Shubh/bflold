<%@ include file="includeHeaderPage.jsp" %>
 
 <head>
 <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
 <script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script language="javascript" src="../js/popcalendarN.js"></script>
   	<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");

  function Update(APP_ID){
//var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("MonitoringRep.jsp?APP_ID="+APP_ID,750,750,'Concurrent Monitoring of PMEGP Entrepreneur',null,null);
 }
 
 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refreshpage() {
   form.submit(); 
}
	

$(document).ready(function() {
    $('#example').DataTable();
} );



</script>
</head>
<body  >
<form  method="post" name="form" >
<p align="center"><span class="mtextarea">Concurrent Monitoring of PMEGP Entrepreneurs</span><br/>
</p>
<%

String SOFF_CD =(String) session.getAttribute("off_cd"); 
 List values=new ArrayList();
     List pstm=new ArrayList();
	pstm.clear();
    values.clear();
	


//"DIAS16175805-1266832"
String  APP_ID = "";
String  APP_NAME ="";
String  PAN_NO="";
String   AADHAR_NO = "";
String   MM_REL_DT= "";
String    MM_REL_AMT = "";
String  PV_DT= "";
String SRNO="";

%>
<table align="center"  class="display" id="example" >
 <thead>
  <tr>
    <th><div align="center">Sr no. </div></th>
    <th><div align="center">Applicant ID </div></th>
    <th><div align="center">Applicant Name</div></th>
    <th><div align="center">Aadhar Card No. </div></th>
    <th><div align="center">PAN No. </div></th>
    <th><div align="center">Date of MM Release</div></th>
    <th><div align="center">MM Amt (in Rs.) </div></th>
    <th> <div align="center">Date of Last Visit</div></th>
    <th><div align="center">Update</div></th>
    <th><div align="center">Report</div></th>
    <th>&nbsp;</th>
  </tr>
  </thead>

  <tbody>
  <%
  StringBuffer qrysb= new StringBuffer();
qrysb.append("      SELECT ROWNUM AS SRNO,AD.APP_NAME, "      );
qrysb.append("        AD.APP_ID,"      );
qrysb.append("            AD.AADHAR_NO,"      );
qrysb.append("              AD.PAN_NO,"      );
qrysb.append("              TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') MM_REL_DT,"      );
qrysb.append("              BD.MM_REL_AMT,(SELECT TO_CHAR(MD.PV_DT,'DD-MON-YYYY') FROM MONITORING_PV_DETAIL MD WHERE  MD.APP_ID=AD.APP_ID) AS PV_DT"      );
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("        BANK_DATAENTRY BD"      );
qrysb.append("     "      );
qrysb.append("      WHERE AD.APP_ID         = BD.APP_ID"      );
qrysb.append("      AND BD.PACT_ID=34 AND  AD.OFF_CD="+SOFF_CD+""      );

//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();



ResultSet rsMain = db.execSQL(qrysb.toString());
 while (rsMain.next()) {
 SRNO =rsMain.getString("SRNO")==null?"":rsMain.getString("SRNO");
APP_ID =rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME =rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
 AADHAR_NO = rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
 MM_REL_DT= rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
  MM_REL_AMT = rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
PV_DT= rsMain.getString("PV_DT")==null?"":rsMain.getString("PV_DT");

 
%>
  <tr valign="middle">
    <td><div align="center"><%= SRNO %></div></td>
    <td><div align="center"><%= APP_ID %></div></td>
    <td><div align="left"><%= APP_NAME %></div></td>
    <td><div align="center"><%= AADHAR_NO %></div></td>
    <td><div align="center"><%= PAN_NO %></div></td>
    <td><div align="center"><%= MM_REL_DT %></div></td>
    <td><div align="center"><%= MM_REL_AMT %></div></td>
    <td><div align="center"><%= PV_DT %></div></td>
    <td>
	<input name="button3" type="button" class="buttonMerun" id="button2" onClick="Update('<%= APP_ID %>');" value="Update" /></td>
    <td><a href="#" class="buttonBlue">View </a></td>
    <td><a href="#" class="buttonOrange">Download</a> </td>
  </tr>
  <%}
	rsMain.close();
	%></tbody>

</table>


</form>
</body>
</html>
