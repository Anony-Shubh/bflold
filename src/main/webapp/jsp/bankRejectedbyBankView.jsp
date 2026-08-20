<%@ include file="includeHeaderPage.jsp" %>

<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>

<style>
body {
  font: normal medium/2.0 sans-serif;
}
table {
  border-collapse: collapse;
  width: 100%;
}
th, td {
  padding: 0.25rem;
  text-align: left;
  border: 1px solid #ccc;
}
tbody tr:nth-child(odd) {
  background: #eee;
}

.style1 {
	font-size: large;
	font-weight: bold;
	color: #0000FF;
}
</style>

</head>
<body>
<form name="form" id="form"  class="form" method="post" >
<%
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb = new StringBuffer();
 String vOffcd= (String) session.getAttribute("off_cd");

qrysb.append("   SELECT AD.APP_ID,AD.ACT_YN,"      );
qrysb.append("     UPPER(AD.APP_NAME) AS APP_NAME,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.MACHINARY_COST,"      );
qrysb.append("     AD.WORKING_CAPITAL,"      );
qrysb.append("     AD.BANK_NAME,"      );
qrysb.append("     AD.BANK_POST_ADDR,"      );
qrysb.append("     AD.BANK_TALUK_BLOCK,"      );
qrysb.append("     AD.BANK_PINCD,"      );
qrysb.append("     AD.MTG_ID,"      );
qrysb.append("     AD.IFSC_CODE,"      );
qrysb.append("     AD.ONLINE_SUBDT,"      );
 qrysb.append("   CASE WHEN (NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0))=0 THEN"      );
 qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0)"      );
 qrysb.append("   ELSE NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0) END TOTAL_PROJCOST,"      );
qrysb.append("     AD.PAN_NO,"      );
qrysb.append("     BD.BANK_REC_DT,"      );
qrysb.append("     BD.BANK_REMARKS,"      );
qrysb.append("     AD.BRANCH_NAME,"      );
qrysb.append("     AD.BANK_DISTRICT,"      );
qrysb.append("     AD.ACTIVITY_CD,"      );
qrysb.append("     AD.IND_TYPE,"      );
qrysb.append("     AD.BANK_F_DATE,"      );
qrysb.append("     AD.IFSC_CODE2,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     RBL.BANK_NAME AS BANK_NAME2,"      );
qrysb.append("     RBL.BRANCHNAME AS BRANCHNAME2 ,"      );
qrysb.append("     RBL.ADDRESS AS ADDRESS2,"      );
qrysb.append("     RBL.CENTRE AS CENTRE2,"      );
qrysb.append("     RBL.DISTRICT AS DISTRICT2,"      );
qrysb.append("     RBL.STATE AS STATE2,"      );
qrysb.append("     RBL.EMAIL AS EMAIL2,"      );
qrysb.append("  UPPER(AM.ACTIVITY_NAME) AS ACTIVITY_NAME,"      );
 qrysb.append("  UPPER(AD.PROD_DESC) AS PROD_DESC"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     RBIBANKLIST RBL, ACTIVITY_MAST AM "      );
qrysb.append("   WHERE AD.APP_ID   = BD.APP_ID AND AM.ACTIVITY_CD=AD.ACTIVITY_CD "      );
qrysb.append("   AND AD.IFSC_CODE2 = RBL.IFSC_CODE(+) AND AD.OFF_CD="+vOffcd+""      );
qrysb.append("   AND AD.OFF_CD     = MOM.OFF_CD"      );
qrysb.append("   AND AD.APP_ID LIKE '%%'"      );
qrysb.append("   AND AD.ACT_ID = 5"      );
qrysb.append("   AND BD.ACT_ID = 3"      );

ResultSet rsMain = db.execSQL(qrysb.toString());

String APP_ID = "";
String APP_NAME = "";
String MOB_NO1 = "";
String MACHINARY_COST = "";
String BANK_POST_ADDR = "";
String BANK_TALUK_BLOCK = "";
String BANK_PINCD = "";
String MTG_ID = "";
String IFSC_CODE = "";
String ONLINE_SUBDT = "";
String DLTFC_CE = "";
String DLTFC_WC = "";
String PAN_NO = "";
String BANK_REC_DT = "";
String BANK_REMARKS = "";
String BRANCH_NAME = "";
String BANK_DISTRICT = "";
String ACTIVITY_CD = "";
String IND_TYPE = "";
String BANK_F_DATE = "";
String IFSC_CODE2 = "";
String AADHAR_NO = "";
String BANK_NAME2 = "";
String BRANCHNAME2 = "";
String ADDRESS2 = "";
String CENTRE2 = "";
String DISTRICT2 = "";
String STATE2 = "";
String EMAIL2 = "";
String WORKING_CAPITAL="";
String BANK_NAME="";
String ACTIVITY_NAME="";
String PROD_DESC="";
String TOTAL_PROJCOST="";
String ACT_YN="";
String BANKFOR_YN="";
%>
<br>
<br>
<table border="1" align="center" cellpadding="2" cellspacing="2">
<tr>
  <th><div align="center">SRNO</div></th>
  <th> <div align="center">ID </div></th>
<th>	<div align="center">NAME	</div></th>
<th><div align="center">AADHAR/ PAN </div></th>

<th><div align="center">Project cost </div></th>
<th> <div align="center">IFS CODE </div></th>
<th>	<div align="center">BANK NAME	</div></th>
<th><div align="center">BRANCH NAME </div></th>
<th> <div align="center">Rejection Reason </div></th>
<th>	<div align="center">Forward to Other bank </div></th>
<th><div align="center">Returned To Applicant </div></th>
</tr>
<%

  if ((vOffcd.equals("6159")) || (vOffcd.equals("6160"))){
 BANKFOR_YN="N";
 }
 else{
  BANKFOR_YN="Y";
 }
   


int SRNO=0;
while(rsMain.next())
  { 
  SRNO=SRNO+1;
  
  APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
MACHINARY_COST=rsMain.getString("MACHINARY_COST")==null?"":rsMain.getString("MACHINARY_COST");
WORKING_CAPITAL=rsMain.getString("WORKING_CAPITAL")==null?"":rsMain.getString("WORKING_CAPITAL");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
BANK_POST_ADDR=rsMain.getString("BANK_POST_ADDR")==null?"":rsMain.getString("BANK_POST_ADDR");
BANK_TALUK_BLOCK=rsMain.getString("BANK_TALUK_BLOCK")==null?"":rsMain.getString("BANK_TALUK_BLOCK");
BANK_PINCD=rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
MTG_ID=rsMain.getString("MTG_ID")==null?"":rsMain.getString("MTG_ID");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
ONLINE_SUBDT=rsMain.getString("ONLINE_SUBDT")==null?"":rsMain.getString("ONLINE_SUBDT");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
BANK_REC_DT=rsMain.getString("BANK_REC_DT")==null?"":rsMain.getString("BANK_REC_DT");
BANK_REMARKS=rsMain.getString("BANK_REMARKS")==null?"":rsMain.getString("BANK_REMARKS");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
BANK_DISTRICT=rsMain.getString("BANK_DISTRICT")==null?"":rsMain.getString("BANK_DISTRICT");
ACTIVITY_CD=rsMain.getString("ACTIVITY_CD")==null?"":rsMain.getString("ACTIVITY_CD");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
BANK_F_DATE=rsMain.getString("BANK_F_DATE")==null?"":rsMain.getString("BANK_F_DATE");
IFSC_CODE2=rsMain.getString("IFSC_CODE2")==null?"":rsMain.getString("IFSC_CODE2");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
BANK_NAME2=rsMain.getString("BANK_NAME2")==null?"":rsMain.getString("BANK_NAME2");
BRANCHNAME2=rsMain.getString("BRANCHNAME2")==null?"":rsMain.getString("BRANCHNAME2");
ADDRESS2=rsMain.getString("ADDRESS2")==null?"":rsMain.getString("ADDRESS2");
CENTRE2=rsMain.getString("CENTRE2")==null?"":rsMain.getString("CENTRE2");
DISTRICT2=rsMain.getString("DISTRICT2")==null?"":rsMain.getString("DISTRICT2");
STATE2=rsMain.getString("STATE2")==null?"":rsMain.getString("STATE2");
EMAIL2=rsMain.getString("EMAIL2")==null?"":rsMain.getString("EMAIL2");
ACTIVITY_NAME=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
PROD_DESC=rsMain.getString("PROD_DESC")==null?"":rsMain.getString("PROD_DESC");
TOTAL_PROJCOST=rsMain.getString("TOTAL_PROJCOST")==null?"":rsMain.getString("TOTAL_PROJCOST");
ACT_YN=rsMain.getString("ACT_YN")==null?"":rsMain.getString("ACT_YN");
if (ACT_YN.equals("Y"))
{

%>


<tr>
  <td><div align="center"><%=  SRNO%></div></td>
<td>	<div align="center"><%=  APP_ID%>	</div></td>
<td>	<div align="center"><%=  APP_NAME%>	</div></td>
<td><div align="center"><%=  AADHAR_NO%> / <%=  PAN_NO%></div></td>
<td><div align="center"><%= TOTAL_PROJCOST %></div></td>
<td><div align="center"><%=  IFSC_CODE%> </div></td>
<td>	<div align="center"><%=  BANK_NAME%>	</div></td>
<td><div align="center"><%= BRANCH_NAME%></div></td>
<td>	<div align="center"><%=  BANK_REMARKS%>	</div></td>
<td>	
  <div align="center">
    <p>
	<% if (BANKFOR_YN.equals("Y")){%>
      <input name="btnReforwd" type="button"  class="button" id="btnReforwd" onClick="updateRejBankPage('<%= APP_ID %>')" value="Reforward">
	  <%} else{%>
	  -
	  <%}%>
    </p>
   
  </div></td>
<td><input name="btnReturned" type="button" class="buttonMarun"  id="btnReturned" onClick="rejectBankPage('<%= APP_ID %>')" value="Returned"></td>
</tr>

<%
}
else {
	%>
<tr>
<td><div align="center"><%=  SRNO%></div></td>
<td>	<div align="center"><%=  APP_ID%>	</div></td>
<td>	<div align="center"><%=  APP_NAME%>	</div></td>
<td colspan="5"><span class="style1">Returned To Applicant For Fresh Application Submission</span></td>
<td colspan="5"><div align="center"><%=  BANK_REMARKS%>	</div></td>
</tr>	
<%}
}
rsMain.close();
db.close();

%>
</table>
</form>
 <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");

function updateRejBankPage(APP_ID){

var urlpar='appUpdateRejectedbyBank.jsp?APP_ID='+APP_ID;
//var urlpar='applicantFormValidation.jsp?APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1000,'Reject Bank Process....',null,null);
 }//END OF FUNCTION
  
 function rejectBankPage(APP_ID){
 var callbackFunctionArray = new Array(refreshpage);
var urlpar='appRejectedbyBank.jsp?APP_ID='+APP_ID;
//var urlpar='applicantFormValidation.jsp?APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1000,'Reject App Process....',callbackFunctionArray,null);
 }//
function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refreshpage() {
   form.submit(); 
}



</script>

</body>
</html>
