  <%@ include file="IncludeHeader.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dis.css">
<style type="text/css">
<!--
.style2 {color: #FFFFFF}
-->
</style>
</head>

<body>
<form name="form" id="form" class="form" method="post">


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
 qrysb.append(" AD.APP_NAME,AD.APP_PWD, " );
  qrysb.append("ASM.ACT_DESC, " );
  qrysb.append("AD.AADHAR_NO, " );
  qrysb.append("AD.UNIT_DIST_CD, " );
  qrysb.append("MD.DISTRICT_NAME, " );
 qrysb.append(" MS.STATE_NM, " );
  qrysb.append("AD.BANK_NAME, " );
 qrysb.append(" AD.IFSC_CODE, " ); 
  qrysb.append("(BRM.IFSC_CODE) AS BANK_USERNAME, " );
  qrysb.append("'' AS BANK_PASSWORD, " );
 qrysb.append(" AD.OFF_CD , " );
  qrysb.append("(MOM.OFF_NAME1) AS OFFICE_NAME, " );
  qrysb.append("(MOM.U_NAME)   AS CONVENOR_LOGIN, " );
  qrysb.append("(MOM.P_WORD)   AS CONVENOR_PASSWORD, " );
  qrysb.append("(DU.USER_NAME) AS AGENCY_USERNAME, " );
  qrysb.append("(DU.PASSWORD)  AS AGENCY_PASSWORD,MRT.CO_REMARKS, BAP.ACT_DESC    AS BANK_STATUS " ); 
qrysb.append("FROM APP_DETAIL AD, BANK_DATAENTRY BD , BANK_APP_STATUS BAP," );
qrysb.append("  M_DISTRICT MD, " );
  qrysb.append("M_STATE MS, " );
 qrysb.append(" APP_STATUS_MAST ASM, " );
  qrysb.append("MAS_OFF_MAST MOM, " );
  qrysb.append("RBIBANKLIST BRM, " );
  qrysb.append("DATAENTRY_USER DU,MM_REMARKS_TRANS MRT " );
qrysb.append("WHERE AD.APP_ID      = BD.APP_ID(+) AND MD.DISTRICT_CD = AD.UNIT_DIST_CD " );
qrysb.append(" AND BD.PACT_ID       = BAP.ACT_ID(+)  AND AD.ACT_ID        = ASM.ACT_ID " );
qrysb.append("AND MD.STATE_CD      = MS.STATE_CD " );
qrysb.append("AND MOM.OFF_CD       = AD.OFF_CD " );
qrysb.append("AND BRM.IFSC_CODE = AD.IFSC_CODE " );
qrysb.append("AND DU.USER_ID       = MOM.USER_ID AND BD.REMTRID=MRT.REMTR_ID(+) " );
qrysb.append("   "+vWherecls+"  " );
qrysb.append("AND DU.ACT_YN        = 'Y' " );
qrysb.append("AND MOM.ACT_YN       = 'Y'  )MQ, " );
qrysb.append("(SELECT DISTRICT_CD,U_NAME,P_WORD,OFF_CD FROM MAS_OFF_MAST WHERE ACT_YN='Y')RQ  " );
qrysb.append("WHERE MQ.UNIT_DIST_CD=RQ.DISTRICT_CD(+) AND MQ.OFF_CD=RQ.OFF_CD(+) " );

out.print (qrysb.toString());
 ResultSet rsMain = db.execSQL(qrysb.toString());

 
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="7"><div align="center">APPLICATION DETAIL SEARCH FORM </div></th>
    </tr>
 
    <tr>
      <td>SEARCH BY APPLICATION_ID:</td>
      <td><input name="APP_ID" type="APP_ID" size="20" maxlength="20" value="<%= APP_ID %>" placeholder="Search by APPLICATION_ID"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     <!-- <td><input name="Submit" type="submit" class="button" id="reset" value="View All"></td>-->
    </tr>
</table>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>
      <th><div align="center">Application_Id</div></th>
      <th><div align="center">Applicant_Name</div></th>     
      <th><div align="center">Aadhar_No</div></th>
	  <th><div align="center">Current Status</div></th>
	
	  <th><div align="center">District</div></th>
	  <th><div align="center">State</div></th>
	 
	  <th><div align="center">Office Name</div></th>
	   <th><div align="center">Bank Status</div></th>
	   <th><div align="center">Remarks</div></th>
	   <th><div align="center">Applicant Detail View</div> </th>
	    <th><div align="center">Documents</div> </th>
    </tr>
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
STATE_NM =rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
UNIT_DIST_CD=rsMain.getString("UNIT_DIST_CD")==null?"":rsMain.getString("UNIT_DIST_CD");
ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
OFF_NAME=rsMain.getString("OFFICE_NAME")==null?"":rsMain.getString("OFFICE_NAME");
AGENCY_USERNAME=rsMain.getString("AGENCY_USERNAME")==null?"":rsMain.getString("AGENCY_USERNAME");
AGENCY_PASSWORD=rsMain.getString("AGENCY_PASSWORD")==null?"":rsMain.getString("AGENCY_PASSWORD");
CONVENOR_LOGIN=rsMain.getString("U_NAME")==null?"":rsMain.getString("U_NAME");
CONVENOR_PASSWORD=rsMain.getString("P_WORD")==null?"":rsMain.getString("P_WORD");
BANK_USERNAME=rsMain.getString("BANK_USERNAME")==null?"":rsMain.getString("BANK_USERNAME");
//BANK_PASSWORD=rsMain.getString("BANK_PASSWORD")==null?"":rsMain.getString("BANK_PASSWORD");
APP_PWD=rsMain.getString("APP_PWD")==null?"":rsMain.getString("APP_PWD");
BANK_STATUS=rsMain.getString("BANK_STATUS")==null?"":rsMain.getString("BANK_STATUS");
REMARK=rsMain.getString("CO_REMARKS")==null?"":rsMain.getString("CO_REMARKS");
edpcount=edpcount+1;
	
	%>
	
	<tr>
	  <td height="21"><div align="center"><%= edpcount %></div></td>
	  <td><div align="center"><%=APP_ID%></div></td>
	  <td><div align="center"><%=APP_NAME %></div></td>
	  <td><div align="center"><%=AADHAR_NO %></div></td>
	  <td><div align="center"><%=ACT_DESC %></div></td>	  
	 
	  <td><div align="center"><%= DISTRICT_NAME %></div></td>
	  <td><div align="center"><%= STATE_NM  %></div></td>
	 
	  <td><div align="center"><%= OFF_NAME  %></div></td>
	  <td><div align="center"><%= BANK_STATUS  %></div></td>
	   <td><div align="center"><%= REMARK  %></div></td>
	   <td><div align="center"><a href="../jasperrop/PMEGPGenAppFormD.jsp?APP_ID=<%= APP_ID %>&RNAME=APPSTATUSVIEWD"  class="greenButtonRound" target="_blank">View</a></div></td>
	   <td><INPUT name="btnSunction" type="button" class="buttonOrange" value="Documents" style="color:#000000; background-color:#FF9900" onClick="viewAppDocument('<%= APP_ID %>')">
	   </td>
	</tr>
	<!--<tr>
	  <td colspan="15"><div align="left"></div>	    
	    <div align="left">
	      <p align="center">&nbsp;</p>
	      <p align="center"> INDIVIDUAL USER NAME:</p>
	      <p align="center">INDIVIDUAL PASSWORD:</p>
	      <p align="center">&nbsp;</p>	      
	    </div>	    </td>
	  </tr>-->
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>	
</table>
</div>
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
 }//END OF FUNCTION

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
