<%@ include file="../jsp/includeHeaderPage.jsp" %>
 
 <head>
 <!--<link rel="stylesheet" type="text/css" href="../css/pmegpTable.css" />-->
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
 <script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>

   	<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");

  function Update(APP_ID){
//var callbackFunctionArray = new Array(refreshpage);
 var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("MonitoringRep.jsp?APP_ID="+APP_ID,750,950,'Concurrent Monitoring of PMEGP Entrepreneur',null,null);

 }
 
function refresh_data(){
form.submit();
}


function refresh_da(){
window.parent.location.reload();
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
<STYLE>
.buttongreen {
  border: 4px solid #A84300;
    border-radius: 10px;
    background-color: #990000;
    color: #ffffff;
    font-weight: bold;
    text-decoration: none;
    margin : 1px;
    padding: 5px 10px 5px 10px;
    display: inline-block;
 }
 .buttongreen:hover {
  border: 2px solid #A84300;
    background-color: #990000;
	 color: #000000;
 }
 
.buttonBlue {
  border: 4px solid #A84300;
    border-radius: 10px;
    background-color:  #000099;
    color: #ffffff;
    font-weight: bold;
    text-decoration: none;
    margin : 1px;
    padding: 5px 10px 5px 10px;
    display: inline-block;
 }
 .buttonOrange {
  border: 4px solid #A84300;
    border-radius: 10px;
    background-color: #FF6600;
    color: #ffffff;
    font-weight: bold;
    text-decoration: none;
    margin : 1px;
    padding: 5px 10px 5px 10px;
    display: inline-block;
 }
 .buttonOrange:hover {
  border: 2px solid #A84300;
    background-color: #FF6600;
	 color: #000000;
 }


</STYLE>

</head>
<body  >
<form  method="post" name="form" >
<p align="center"><span class="mtextarea">Concurrent Field Office Visit of PMEGP Entrepreneurs</span><br/>
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
String PHTR_ID="";

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
    <th>No of Visit </th>
    <th><div align="center">Update</div></th>
  
    <th>&nbsp;</th>
  </tr>
  </thead>

  <tbody>
  <%
  //and bd.app_id not in (select app_id from MONITORING_PV_DETAIL)
  StringBuffer qrysb= new StringBuffer();
qrysb.append("      SELECT ROWNUM AS SRNO,AD.APP_NAME,(SELECT count(*) FROM MONITORING_PV_DETAIL WHERE APP_ID=AD.APP_ID) PHTR_ID ,"      );
qrysb.append("        AD.APP_ID,"      );
qrysb.append("            AD.AADHAR_NO,"      );
qrysb.append("              AD.PAN_NO,"      );
qrysb.append("              TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') MM_REL_DT,"      );
qrysb.append("              BD.MM_REL_AMT,(SELECT max(TO_CHAR(MD.PV_DT,'DD-MON-YYYY')) FROM MONITORING_PV_DETAIL MD WHERE  MD.APP_ID=AD.APP_ID) AS PV_DT"      );
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("        BANK_DATAENTRY BD"      );
qrysb.append("     "      );
qrysb.append("      WHERE AD.APP_ID         = BD.APP_ID  "      );
qrysb.append("      AND BD.PACT_ID=34 AND  AD.OFF_CD="+SOFF_CD+" "      );

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
PHTR_ID= rsMain.getString("PHTR_ID")==null?"":rsMain.getString("PHTR_ID");
 
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
    <td><div align="center"><%= PHTR_ID %></div></td>
    <td>
	<% if (!PHTR_ID.equals("3")){%>
	<input name="button" type="button" class="buttonGreen" id="button"  onClick="Update('<%= APP_ID %>');" value="Update" />
	<%} else{ %>
	-
	<%}%>
	</td>
    
    <td><a href="#" class="buttonOrange">Download</a> </td>
  </tr>
  <%}
	rsMain.close();
	db.close();
	%></tbody>
</table>


</form>
</body>
</html>
