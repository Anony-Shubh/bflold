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

<HTML>
<HEAD>
   <TITLE>PMEGP e-Portal</TITLE>
   <LINK rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
   <SCRIPT type="text/javascript" src="../js/ModalPopupWindow.js"></SCRIPT> 
   <SCRIPT language="javascript">
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

</SCRIPT>
</HEAD>

<BODY>
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
<IMG src="../images/pmegponline.jpg" width="100%" height="150" >
<TABLE align="center" class="pmegpTable" >
  <TR>
    <TD colspan="16" nowrap><DIV align="center">PMEGP Portal Agency   Login : <%= voffname %></DIV></TD>
  </TR>
  
  <TR>
  <TD nowrap> <DIV align="center"><A href="PMEGPAgencyHomePage.jsp" target="_parent" class="greenButtonRound">Home</A></DIV></TD>
   <TD nowrap> <DIV align="center"><A href="GTAppSearchLOV.jsp" target="_parent" class="greenButtonRound">Physical Verification</A></DIV></TD>
 <TD nowrap> <DIV align="center"><A href="Reports.jsp" target="_parent" class="greenButtonRound">Reports</A></DIV></TD>
    <TD nowrap><DIV align="center"><A href="resetPassAgn.jsp" class="greenButtonRound">Reset</A></DIV></TD>
	 <TD nowrap><DIV align="center"><A href="agencyProfileUpdate.jsp" class="greenButtonRound">Profile</A></DIV></TD>
     <TD nowrap><A href="EdpNodalUpload.jsp" class="greenButtonRound">EDP Update</A></TD>
    <TD nowrap><DIV align="center"><A href="AppSearchLOV.jsp" class="greenButtonRound">Status Update </A></DIV></TD>
   
    <!---->
    <TD nowrap><A href="bankRejectedbyBankView.jsp"  class="greenButtonRound" >Bank Rejection </A></TD>
    <TD nowrap><A href="mmclaimProvclaimView.jsp" class="greenButtonRound">MM Claim</A></TD>
    <TD nowrap><DIV align="center"><A href="nbview.jsp"  class="greenButtonRound">Update Mobile</A></DIV></TD>
    <TD nowrap><DIV align="center"><A href="../pmegpeportaltutorialdoc/ImplementingAgency.pdf" class="greenButtonRound">Manual </A></DIV></TD>
	 <TD nowrap><DIV align="center"><A href="SecondApplicationDetails.jsp"  class="greenButtonRound">Second Loan</A></DIV></TD>
	 	<TD ><A href="bankRejectedbyBankViewSec.jsp"  class="greenButtonRound" >Bank Rejection Second </A></TD>
	  <TD nowrap><A href="mmclaimProvclaimViewSec.jsp" class="greenButtonRound">MM Claim For Second Loan</A></TD>
    <TD nowrap><DIV align="center"><A href="indexmonitoring.jsp"  class="greenButtonRound">Monitor</A></DIV></TD>
	<TD nowrap ><A href="openGrivences.jsp" class="greenButtonRound">Grivences</A> </TD>
	<TD nowrap><DIV align="center"><A href="agencyMeetingView.jsp"  class="greenButtonRound">DLTFC/Bank</A></DIV></TD>
    <TD nowrap><DIV align="center"><A href="dltfcReforwardByAgency.jsp"  class="greenButtonRound">DLTFC Reforward</A></DIV></TD>
    <TD nowrap><DIV align="center"><A href="logout.jsp"  class="greenButtonRound">Logout</A></DIV></TD>
  </TR>
</TABLE>
