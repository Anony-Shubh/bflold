<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="600kb" %>
<% 
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<html>
<head>
   <title>PMEGP e-Portal</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
   <script type="text/javascript" src="../js/ModalPopupWindow.js"></script> 
   <script language="javascript">
function mypopup(myurl,param,w,h ) { 
//var w = 700; 
//var h = 400; 
var winl = (screen.width-w)/2; 
var wint = (screen.height-h)/2; 
if (winl < 0) winl = 0; 
if (wint < 0) wint = 0; 

var page = myurl+'?'+param; 
windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=no"; 
window.open(page, "Popup", windowprops); 
} 

</script>
</head>

<body>
<%
String voffname="";
String vUserID="";
String vAssign=(String) session.getAttribute("assign")==null?"":(String)session.getAttribute("assign");
//out.print(vAssign);
if  (session.getAttribute("user_id") !=null){
vUserID=(String)session.getAttribute("user_id");
}
if (session.getAttribute("off_name") !=null){
voffname=(String) session.getAttribute("off_name");
}
if (vUserID.equals("")){
response.sendRedirect("loginPage.jsp");
}
%>
<img src="../images/pmegponline.jpg" width="100%" height="150" >
<table align="center" class="pmegpTable" >
  <tr>
    <td colspan="16" nowrap><div align="center">PMEGP Portal Tracking  User Login : <%= voffname %></div></td>
  </tr>
  
  <tr>
  <td nowrap> <div align="center"><a href="PMEGPAgencyHomePage.jsp" target="_parent" class="greenButtonRound">Home</a></div></td>
    <td nowrap><div align="center"><a href="resetPassAgn.jsp" class="greenButtonRound">Reset</a></div></td>
	 <td nowrap><div align="center"><a href="agencyProfileUpdate.jsp" class="greenButtonRound">Profile</a></div></td>
     <td nowrap><a href="EdpNodalUpload.jsp" class="greenButtonRound">EDP Update</a></td>
	 <!-- <TD nowrap> <DIV align="center"><A href="../geoportal/GTAppSearchLOV.jsp" target="_parent" class="greenButtonRound">Physical Verification</A></DIV></TD>-->
    <td nowrap><div align="center"><a href="AppSearchLOV.jsp" class="greenButtonRound">Status Update </a></div></td>
   
    <!---->
    <td nowrap><a href="bankRejectedbyBankView.jsp"  class="greenButtonRound" >Bank Rejection </a></td>
    <td nowrap><a href="mmclaimProvclaimView.jsp" class="greenButtonRound">MM Claim</a></td>
    <td nowrap><div align="center"><a href="nbview.jsp"  class="greenButtonRound">Update Mobile</a></div></td>
    <td nowrap><div align="center"><a href="../pmegpeportaltutorialdoc/ImplementingAgency.pdf" class="greenButtonRound">Manual </a></div></td>
	 <td nowrap><div align="center"><a href="SecondApplicationDetails.jsp"  class="greenButtonRound">Second Loan</a></div></td>
	 	<td ><a href="bankRejectedbyBankViewSec.jsp"  class="greenButtonRound" >Bank Rejection Second </a></td>
	  <td nowrap><a href="mmclaimProvclaimViewSec.jsp" class="greenButtonRound">MM Claim For Second Loan</a></td>
    <td nowrap><div align="center"><a href="indexmonitoring.jsp"  class="greenButtonRound">Monitor</a></div></td>
	<td nowrap ><a href="openGrivences.jsp" class="greenButtonRound">Grivences</a> </td>
	<td nowrap><div align="center"><a href="agencyMeetingView.jsp"  class="greenButtonRound">DLTFC/Bank</a></div></td>
    <td nowrap><div align="center"><a href="dltfcReforwardByAgency.jsp"  class="greenButtonRound">DLTFC Reforward</a></div></td>
    <td nowrap><div align="center"><a href="logout.jsp"  class="greenButtonRound">Logout</a></div></td>
  </tr>
</table>
