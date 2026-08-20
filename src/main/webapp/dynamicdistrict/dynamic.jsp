<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
<title>Online Application Khadi Certification</title>
<link rel="stylesheet" href="../css/kieportal.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
</script>
</head>

<body>
      <% 
	  DBCon db= new DBCon();
      db.connect();
	  String REG_OFF_CD="";
	  
	  
	  %>
<form name="form" id="form"  class="form" method="post">
<table border="1" align="center" cellpadding="4" cellspacing="10" class="GreenLebel">
  
  <tr>
    <th>&nbsp;</th>
    <th align="left" nowrap >Select State</th>
    <th colspan="5"><select name="STATE" id="STATE" >
      <option value="">--Select--</option>
<%
	  ResultSet rsOffice= db.execSQL("SELECT * FROM M_STATE");
	  String vRegoffcd = "";
	  String vRegoffname= "";  
	  while (rsOffice.next()){
	  vRegoffcd =rsOffice.getString("STATE_CD");
	  vRegoffname= rsOffice.getString("STATE_NM");
	  out.print(vRegoffcd);
	   %>
      <option value="<%= vRegoffcd%>" <% if (vRegoffcd.equals(REG_OFF_CD)){out.print("selected");}%>><%= vRegoffname%></option>
<% 
		}
		rsOffice.close();
		 %>	  
    </select></th>
  </tr>
   <tr>
        <td>&nbsp;</td>
        <td>Select District </td>
        <td colspan="3"><input name="DISTRICT" type="text" id="DISTRICT"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <input name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select District" /></td>
      </tr>
</table>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(){
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
var urlpar='itemlov.jsp?STATE='+vstate;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,600,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 
 function getDistrictName(DISTRICT_NAME){
 form.DISTRICT.value=DISTRICT_NAME;

}
function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}


function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}


</script>
</form>
</body>