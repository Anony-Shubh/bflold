<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.math.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META name="viewport" content="width=device-width, initial-scale=1.0">
		<META name="description" content="">
<title>PFMS Search Form</title>
</head>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT language="javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
<SCRIPT src="../js/jquery-customselect.js"></SCRIPT>
<script type="text/javascript">
var locate = window.location.toString();
var text = locate;

function delineate2(str)
{
point = str.lastIndexOf("=");
return(str.substring(point+1,str.length));
}
var PEN_EMP_CODE = delineate2(text);

function radio_onload(){
document.getElementById(PEN_EMP_CODE).checked="checked";
}
</script>

<STYLE>
table {
  border-collapse: collapse;
  
}

th, td {
  text-align: left;
  padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}

th {
  background-color: #324275;
  color: white;
}
* {
  box-sizing: border-box;
}


input {
  padding: 10px;
  
  font-size: 17px;
  font-family: Raleway;
  border: 1px solid #aaaaaa;
}

.blueRound {
    border: 2px solid #000000;
    border-radius: 10px;
    background-color:#6699CC;
    color: #ffffff;
    font-weight: bold;
    text-decoration: none;
    margin : 1px;
    padding: 5px 10px 5px 10px;
    display: inline-block;
	width: auto;
}
.blueRound:hover {
    border: 2px solid #000000;
    background-color: #e0effc;
	 color: #000000;
}

</STYLE>

<body>

<h1 align="center">PFMS Search Form</h1>

<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();	

  String vWherecls="";
  
  String BANK_NAME = request.getParameter("BANK_NAME")==null?"":(String)request.getParameter("BANK_NAME");
  String BRANCHADDRESS1 = request.getParameter("BRANCHADDRESS1")==null?"":(String)request.getParameter("BRANCHADDRESS1");
  String IFSC_CODE = request.getParameter("IFSC_CODE")==null?"":(String)request.getParameter("IFSC_CODE");

  
  if (!BANK_NAME.equals("")) {
  //vWherecls=vWherecls+ " AND UPPER(PB.BANK_NAME) LIKE  UPPER('%"+BANK_NAME+"%') ";
  vWherecls=vWherecls+ " AND upper(REPLACE(pb.bank_name,'''','')) like upper('%"+BANK_NAME+"%') ";

  }
  
   if (!BRANCHADDRESS1.equals("")) {
  vWherecls=vWherecls+ " AND UPPER(PB.BRANCHADDRESS1) LIKE UPPER('%"+BRANCHADDRESS1+"%') ";
  }
  
    if (!IFSC_CODE.equals("")) {
  vWherecls=vWherecls+ " AND UPPER(PB.IFSC_CODE) LIKE UPPER('%"+IFSC_CODE+"%') ";
  }
  
//out.print(vWherecls);
	
StringBuffer qrysb= new StringBuffer();

if((BANK_NAME.equals(""))&&(BRANCHADDRESS1.equals(""))&&(IFSC_CODE.equals(""))){
qrysb.append(" SELECT PB.BANK_NAME, PB.BRANCHADDRESS1, PB.IFSC_CODE, PB.IFSCCODE FROM pfms_bankbranchmast PB WHERE PB.BANK_NAME is null "      );
}else{
qrysb.append(" SELECT PB.BANK_NAME, PB.BRANCHADDRESS1, PB.IFSC_CODE, PB.IFSCCODE FROM pfms_bankbranchmast PB WHERE PB.BANK_NAME is not null "+vWherecls+""      );

}

//out.print (qrysb.toString());

// values.add (BASEID); 

ResultSet rs = db.executeSQL(qrysb.toString(),values);
values.clear();	

%>


          <form method="post">
       <center>  
		 <table width="90%">
		 <tr>
		 <td width="10%">Bank Name: </td>
		 <td width="23%">
		 
		 <SELECT name="BANK_NAME" id="BANK_NAME" class="custom-select">
    <OPTION value="">----Select----</OPTION>
    <%
	String STATE_CD_D1="";
	String STATE_NM_D1="";
	ResultSet staters1 =db.execSQL("SELECT REPLACE(pb.bank_name,'''','') as BANK_NAME, PB.BANK_NAME || ' '||max(IFSCCODE)||' ('||COUNT(*) ||')'  AS BANK_DESC FROM pfms_bankbranchmast PB GROUP BY PB.BANK_NAME ORDER BY PB.BANK_NAME");
	while (staters1.next()) {
STATE_CD_D1=staters1.getString(1);
STATE_NM_D1=staters1.getString(2);
	%>
    <OPTION value="<%= STATE_CD_D1 %>" <%if(BANK_NAME.equals(STATE_CD_D1)){out.print("selected");}%>><%= STATE_NM_D1 %></OPTION>
    <%  }  staters1.close();//while close  
	   %>
  </SELECT>
		 </td><td width="10%">Branch Address</td>
        <td width="18%"><INPUT name="BRANCHADDRESS1" type="text" id="BRANCHADDRESS1" value="<%=BRANCHADDRESS1 %>"/ ></td><td width="9%">IFSC Code</td>
        <td width="18%"><INPUT name="IFSC_CODE" type="text" id="IFSC_CODE" size="20" maxlength="75" value="<%=IFSC_CODE %>"/ ></td><td width="12%"> <INPUT name="btnFind" type="submit" class="blueRound" id="btnFind" value="Search" /></td>
		 </tr>
		 </table>
		 </center>  
		 <br>
	   <div class="container">


<center>

<center>
<table width="90%" border="1">
  <tr>
    <th width="388"><div align="center">Bank Name</div></th>
    <th width="424"><div align="center">Branch Address</div></th>
    <th width="179"><div align="center">IFSC Code </div></th>
    <th width="159"><div align="center">View </div></th>
    </tr>
  
  <% 
		int srno=0;
		while (rs.next()) {

BANK_NAME=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
BRANCHADDRESS1=rs.getString("BRANCHADDRESS1")==null?"":rs.getString("BRANCHADDRESS1");
IFSC_CODE=rs.getString("IFSC_CODE")==null?"":rs.getString("IFSC_CODE");

srno=srno+1;
			 
			 %>
  
  	<tr>
    <td ><div align="center"><%= BANK_NAME %></div></td>
    <td ><div align="center"><%= BRANCHADDRESS1 %></div></td>
    <td><div align="center"><%= IFSC_CODE %></div></td>
    <td><div align="center"><a href="#" class="blueRound">View</a></div></td>
   </tr>
  
   <%

}
rs.close();
db.close();
%>
</table>
	
	<SCRIPT>
$(function() {
$("#BANK_NAME").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     20,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});

$(function() {
$("#BANK_NAME2").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     20,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});
</SCRIPT>
<SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");

function DV(PEN_EMP_CODE){
 modalWin.ShowURL("dvform.jsp?PEN_EMP_CODE="+PEN_EMP_CODE,390,700,'DV',null,null);
 }

  function HideModalWindow() {
  modalWin.HideModalPopUp();
}
/*
function refreshpage(){
form.submit(); 
}
*/
function refreshpage() {
//form.submit(); 
location.reload();
}


</SCRIPT>
	
	
</form>

</body>
</html>
