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

<STYLE>
/* CSS Document */

@import url(https://fonts.googleapis.com/css?family=Open+Sans);
@import url(https://fonts.googleapis.com/css?family=Bree+Serif);

h1 {
	font-size: 60px;
	text-align: center;
	color: #FFF;
}	

h3 {
	font-size: 30px;
	text-align: center;
	color: #FFF;
}

h3 a {
	color: #FFF;
}

a {
	color: #FFF;
}

h1 {
	margin-top: 100px;
	text-align:center;
	font-size:60px;
	font-family: 'Bree Serif', 'serif';
	}

#container {
	margin: 0 auto;
}

p {
	text-align: center;
}

nav {
	margin: 10px 0;
	background-color: #d8c0d5;
	
}

nav ul {
	padding: 0;
 	margin: 0;
	list-style: none;
	position: relative;
	z-index: 6;
	}
	
nav ul li {
	display:inline-block;
	background-color: #d8c0d5;
	border: 1px solid black;
	
	}

nav a {
	display:block;
	padding:0 10px;	
	color:black;
	font-size:20px;
	line-height: 60px;
	text-decoration:none;
}

nav a:hover { 
	background-color: #000000; 
	color:#FFFFFF;
}

/* Hide Dropdowns by Default */
nav ul ul {
	display: none;
	position: absolute; 
	top: 60px; /* the height of the main nav */
}
	
/* Display Dropdowns on Hover */
nav ul li:hover > ul {
	display:inherit;
}
	
/* Fisrt Tier Dropdown */
nav ul ul li {
	width:auto;
	float:none;
	display:list-item;
	position: relative;
}

/* Second, Third and more Tiers	*/
nav ul ul ul li {
	position: relative;
	top:-60px; 
	left:170px;
}

	
/* Change this in order to change the Dropdown symbol */
li > a:after { content:  ' +'; }
li > a:only-child:after { content: ''; }
</STYLE>

</HEAD>

<BODY>
<%
String voffname="";
String vUserID="";
String vAssign=(String) session.getAttribute("assign")==null?"":(String)session.getAttribute("assign");
String vDISTRICTNM=(String) session.getAttribute("sDISTRICTNAME")==null?"":(String)session.getAttribute("sDISTRICTNAME");
//out.print(vAssign);
if  (session.getAttribute("user_id") !=null){
vUserID=(String)session.getAttribute("user_id");
//out.print(vUserID);
}
if (session.getAttribute("off_name") !=null){
voffname=(String) session.getAttribute("off_name");
}
if (vUserID.equals("")){
response.sendRedirect("loginPage.jsp");
}
%>
<IMG src="../images/pmegponline.jpg" width="100%" height="150" >

<DIV align="center" style="background-color:#0f7fb6; color:#FFFFFF; margin:1px; padding:5px;">PMEGP Portal Tracking  User Login : <%= voffname %>, District:<%=vDISTRICTNM%> </DIV>

<DIV>
    <nav>
        <UL>
            <LI><A href="PMEGPAgencyHomePage.jsp" target="_parent">Home</A></LI>
            <LI><A href="AppSearchLOV.jsp" target="_parent">Status Update</A>
            <!-- First Tier Drop Down -->
            <UL>
                <LI><A href="AppSearchLOV.jsp" target="_parent">New Loan</A></LI>
                <LI><A href="SecondApplicationDetails.jsp" target="_parent">Second Loan</A></LI>
            </UL>        
            </LI>
            <LI><A href="bankRejectedbyBankView.jsp" target="_parent">Bank Rejection</A>
            <!-- First Tier Drop Down -->
            <UL>
                <LI><A href="bankRejectedbyBankView.jsp" target="_parent">New Loan</A></LI>
                <LI><A href="bankRejectedbyBankViewSec.jsp" target="_parent">Second Loan</A></LI>
            </UL>
            </LI>
            <LI><A href="mmclaimProvclaimView.jsp" target="_parent">MM Claim</A>
            <!-- First Tier Drop Down -->
            <UL>
                <LI><A href="mmclaimProvclaimView.jsp" target="_parent">New Loan</A></LI>
                <LI><A href="mmclaimProvclaimViewSec.jsp" target="_parent">Second Loan</A></LI>
            </UL>
            </LI>
            <LI><A href="openGrivences.jsp" target="_parent">Grivences</A></LI>
            <LI><A href="GTAppSearchLOV.jsp" target="_parent">Physical Verification</A>
			<UL>
			<LI><A href="GTAppSearchLOV.jsp" target="_parent">Physical Verification</A></LI>
			<LI><A href="pvidCard.jsp" target="_parent">PV Id Card</A></LI>
			<LI><A href="pdf/PhysicalVerificationPPT.pptx" target="_parent">Download Physical Verification PPT</A></LI>
			<LI><A href="../jasperrop/genergeexcel.jsp" target="_parent">Download GeoTag Pull Back Report</A></LI>
			</UL>
			</LI>
            <LI><A href="EdpNodalUpload.jsp" target="_parent">EDP Update</A></LI>
			<LI><A href="GTAppSearchLOV_award.jsp" target="_parent">PMEGP Award</A></LI>
			<LI><A href="agencyProfileUpdate.jsp" target="_parent">Others</A>
			
            <!-- First Tier Drop Down -->
			
            <UL>
                <LI><A href="resetPassAgn.jsp" target="_parent">Reset Password</A></LI>
                <LI><A href="agencyProfileUpdate.jsp" target="_parent">Update Office Profile</A></LI>
				<LI><A href="nbview.jsp" target="_parent">Update Applicant Mobile</A></LI>
				<LI><A href="indexmonitoring.jsp" target="_parent">Field Visit</A></LI>
				
				<LI><A href="agencyMeetingView.jsp" target="_parent">DLTFC / Bank</A></LI>
				<LI><A href="dltfcReforwardByAgency.jsp" target="_parent">DLTFC / Reforward</A></LI>
				<LI><A href="AgencyReport.jsp" target="_parent">Report</A></LI>
				<LI><A href="SearchAppDet.jsp" target="_parent">Validate Aadhar</A></LI>
				<LI><A href="AppSearchLOVOFF.jsp" target="_parent">Offline Application</A></LI>
				
            </UL>
			<LI><A href="AgenUsermanaul.jsp" target="_parent">User Manual</A></LI>
            </LI>
            <LI><A href="logout.jsp">Logout</A></LI>
        </UL>
    </nav>
</DIV>
