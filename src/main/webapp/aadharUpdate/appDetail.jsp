<%@ page contentType="text/html; charset=iso-8859-1" buffer="500kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<style type="text/css">
<!--
.style2 {color: #FFFFFF}
-->
</style>
</head>

<body>
<form name="form" id="form" class="form" method="post">
<img src="../images/pmegponline.jpg" width="100%" height="150">
  <%@ include file="AppIncludePage.jsp" %>
  <% 
  
  String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID"); 
  
 
String APP_NAME = "";  
String OFF_CD="";
String OFF_NAME = "";
String AADHAR_NO = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String UNIT_DIST_CD="";
String APP_PIN="";
String BANK_NAME="";
String ACT_DESC= "";
String IFSC_CODE= "";
String BANK_USERNAME= "";
String BANK_PASSWORD= "";
String OFFICE_NAME= "";
String CONVENOR_LOGIN= "";
String CONVENOR_PASSWORD= "";
String AGENCY_USERNAME= "";
String AGENCY_PASSWORD= "";
String APP_PWD= "";
String BANK_STATUS= "";
String REMARK= "";
String vWherecls=""; 
String DOB="";
String GENDER="";
String INVALID_AADHAR="";
if (!APP_ID.equals("")){
       vWherecls=vWherecls+" AND (AD.APP_ID ) LIKE  ('%"+APP_ID+"%')  ";

   }
   else {
	  vWherecls=vWherecls+" AND (AD.APP_ID ) LIKE  ('-')  ";  
   }
      

  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  qrysb.append(" SELECT * FROM " );
  qrysb.append("(SELECT AD.APP_ID, " );
 qrysb.append(" AD.APP_NAME,AD.APP_PWD,AD.GENDER, " );
  qrysb.append("AD.AADHAR_NO,TO_Char(ad.dob,'dd-mon-rrrr') as DOB, " );
  qrysb.append("AD.UNIT_DIST_CD, " );
  qrysb.append("MD.DISTRICT_NAME, " );
 qrysb.append(" MS.STATE_NM,AO.RET_YN AS INVALID_AADHAR, " );
  qrysb.append("AD.BANK_NAME, " );
 qrysb.append(" AD.IFSC_CODE, " ); 
  qrysb.append("(BRM.BR_IFSL_CODE) AS BANK_USERNAME, " );
 qrysb.append(" AD.OFF_CD , " );
  qrysb.append("(MOM.OFF_NAME1) AS OFFICE_NAME " );
qrysb.append("FROM APP_DETAIL AD, BANK_DATAENTRY BD , " );
qrysb.append("  M_DISTRICT MD, " );
  qrysb.append("M_STATE MS, " );
  qrysb.append("MAS_OFF_MAST MOM, " );
  qrysb.append("BANK_BR_MAST BRM,AADHARVALIDATION_OLD AO " );
qrysb.append("WHERE AD.APP_ID      = BD.APP_ID AND MD.DISTRICT_CD = AD.UNIT_DIST_CD " );
qrysb.append("AND MD.STATE_CD      = MS.STATE_CD  AND AD.APP_ID=AO.APP_ID  " );
qrysb.append("AND MOM.OFF_CD       = AD.OFF_CD " );
qrysb.append("AND BRM.BR_IFSL_CODE = AD.IFSC_CODE " );
qrysb.append("   "+vWherecls+" ) " );






//out.print (qrysb.toString());
 ResultSet rsMain = db.execSQL(qrysb.toString());

	int edpcount=0;
	while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
STATE_NM =rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
INVALID_AADHAR=rsMain.getString("INVALID_AADHAR")==null?"N":rsMain.getString("INVALID_AADHAR");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");

OFF_NAME=rsMain.getString("OFFICE_NAME")==null?"":rsMain.getString("OFFICE_NAME");

BANK_USERNAME=rsMain.getString("BANK_USERNAME")==null?"":rsMain.getString("BANK_USERNAME");
GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
DOB=rsMain.getString("DOB")==null?"":rsMain.getString("DOB");
edpcount=edpcount+1;
		}
rsMain.close();
	%>
 

  <table align="center" class="bordered">
    <tr>
      <th colspan="7"><div align="center">APPLICATION DETAIL SEARCH FORM </div></th>
    </tr>
 
    <tr>
      <td>SEARCH BY APPLICATION_ID:</td>
      <td><input name="APP_ID" type="APP_ID" size="20" maxlength="20" value="<%= APP_ID %>" placeholder="Search by APPLICATION_ID"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
    </tr>
</table>
<% if (edpcount>0){%>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>
      <th><div align="center">Application_Id</div></th>
      <th><div align="center">Applicant_Name</div></th>     
      <th><div align="center">Aadhar_No</div></th>
	  <th><div align="center">Gender</div></th>
	   <th><div align="center">Date Of Birth</div></th>
	  <th><div align="center">District</div></th>
	  <th><div align="center">State</div></th>
	  <th><div align="center">Office Name</div></th>
	  <th><div align="center">View</div></th>
	  <th><div align="center">Update</div></th>
	  </tr>
	
	</thead>
	
	
	<tr>
	  <td><div align="center"><%= edpcount %></div></td>
	  <td><div align="center"><%=APP_ID%></div></td>
	  <td><div align="center"><%=APP_NAME %></div></td>
	  <td><div align="center"><%=AADHAR_NO %></div></td>
	  <td><div align="center"><%=GENDER %></div></td>	  
	  <td><div align="center"><%=DOB %></div></td>
	  <td><div align="center"><%= DISTRICT_NAME %></div></td>
	  <td><div align="center"><%= STATE_NM  %></div></td>
	  <td><div align="center"><%= OFF_NAME  %></div></td>
	  <td align="left" nowrap="nowrap"><DIV align="center"><SPAN >
        <INPUT name="btnSunction" type="button" class="buttonOrange" value="Documents" style="color:#000000; background-color:#FF9900" onClick="viewAppDocument('<%= APP_ID %>')">
    </SPAN></DIV></td>
	<td>
			<% if  (!INVALID_AADHAR.equals("Y")) {%>
<div align="center"><input name="btnUpload" type="button" class="buttonMerun" style="color:#FF0000" value="Update Aadhar Details" onClick="updateAA('<%= APP_ID %>')"></div>
			<% } else {	%>
			   AAdhar Verified
	             <%
}%>			</td>	
	  </tr>
	
	<% 
}

db.close();
	
	 %>	
</table>
</div>
</br></br>
	<br/>
	<br/><br/><br/><br/><br/></br></br>
	<br/>
	<br/><br/><br/><br/><br/>
  <table class="pmegpTable"><br>
<tr>

<th>
 <center> <h2>For Technical issues contact email: pmegpeportal.kvic@gov.in and PMEGP Scheme related queries contact email: pmegp.kvic@gov.in</h2>
 </center>
  </th>
  </tr>
  </table>
<script language="javascript">
jQuery(function(){
i=document.form.STATE.selectedIndex; 
vstate=document.form.STATE.options[i].value;
$("#DISTRICT_NAME").autocomplete("itemlov.jsp?q="+vstate);
});

 var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
function ShowNewPage(app_id,filename){
var urlpar=filename+'?APP_ID='+app_id;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//end of bank

function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }
 
 function updateAA(pAppid) {
var url ="AdharUpdateForm.jsp?APP_ID="+pAppid;
 modalWin.ShowURL(url,500,800,'Update Aadhar Details',null,null);
 
}
function refresh_data(){
window.parent.location.reload();
}
function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}


   </script>
</form>
</body>
</html>
