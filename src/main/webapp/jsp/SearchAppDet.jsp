<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
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
<%@ include file="includeHeaderPage.jsp" %>
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
	String sOFF_TYPE_CD=(String) session.getAttribute("sOFF_TYPE_CD");
			String sdistrict_cd =(String) session.getAttribute("sdistrict_cd");
			String sagency_type=(String) session.getAttribute("sagency_type");
			String vwhereqry="";
			String sUserID=(String)session.getAttribute("user_id"); 

			
if (!APP_ID.equals("")){
	if (sOFF_TYPE_CD.equals("2")){
       vWherecls=vWherecls+" AND (AD.APP_ID ) LIKE  ('%"+APP_ID+"%') AND MOM.DISTRICT_CD= "+sdistrict_cd+"  ";

   }
   else{
	    vWherecls=vWherecls+" AND (AD.APP_ID ) LIKE  ('%"+APP_ID+"%') AND MOM.USER_ID= "+sUserID+"  ";
	   
   }
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
  qrysb.append("(BRM.IFSC_CODE) AS BANK_USERNAME " );

qrysb.append("FROM APP_DETAIL AD, BANK_DATAENTRY BD," );
qrysb.append("  M_DISTRICT MD, " );
  qrysb.append("M_STATE MS, " );
 qrysb.append(" APP_STATUS_MAST ASM, " );
  qrysb.append("MAS_OFF_MAST MOM, " );
  qrysb.append("RBIBANKLIST BRM " );
 
qrysb.append("WHERE AD.APP_ID      = BD.APP_ID(+) AND MD.DISTRICT_CD = AD.UNIT_DIST_CD " );
qrysb.append(" AND AD.ACT_ID        = ASM.ACT_ID " );
qrysb.append("AND MD.STATE_CD      = MS.STATE_CD " );
qrysb.append("AND MOM.OFF_CD       = AD.OFF_CD " );
qrysb.append("AND BRM.IFSC_CODE = AD.IFSC_CODE AND BD.ACT_ID=11 AND AD.ACT_YN='Y' AND AD.ACT_ID=5  " );
qrysb.append("  and bd.act_id=11 and ((BD.MM_CLAIM_DT is null and loan_docfname is null) or (BD.MM_CLAIM_DT is not null and pact_id=30 and apprv_yn='A')) ");
qrysb.append("   "+vWherecls+")  " );


 ResultSet rsMain = db.execSQL(qrysb.toString());
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

edpcount=edpcount+1;
}
rsMain.close();

 
 %>
 <br/>
 <div align="center"><h2>Only Sanction Case Can be Updated</h2></div>
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
<% if (!APP_ID.equals("")) {if (edpcount > 0) {%>
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
	  <th><div align="center">Bank Name</div></th>
	   <th><div align="center">Update</div></th>
    </tr>
	
	
	<tr>
	  <td height="21"><div align="center"><%= edpcount %></div></td>
	  <td><div align="center"><%=APP_ID%></div></td>
	  <td><div align="center"><%=APP_NAME %></div></td>
	  <td><div align="center"><%=AADHAR_NO %></div></td>
	  <td><div align="center"><%=ACT_DESC %></div></td>	  
	  <td><div align="center"><%= DISTRICT_NAME %></div></td>
	  <td><div align="center"><%= STATE_NM  %></div></td>
	  <td><div align="center"><%= BANK_NAME%></div></td>
	 <td><input name="btnDocument" type="button" class="buttonMerun" id="btnDocument" onClick="ReferAppDetail('<%=APP_ID%>');" value="Update"></td>

	  
	</tr>
	
	<%
  } else{%>
  
 <div align="center"><H2>This Module is only for Sanctioned Case </H2></div>
  <%
  }}
  db.close();
  %>

</table>
</div>
<script language="javascript">


 var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
   function ReferAppDetail(pAppid){
var urlpar='../jsp/DemoGraUpdate.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,1000,'PMEGP View All Applicant Document',null,null);
 }

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

function refreshpage(){
form.submit();
}


   </script>
</form>
</body>
</html>
