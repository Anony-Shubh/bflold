

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
    <HEAD>
	<LINK rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	 <LINK href="css/simple-sidebar123.css" rel="stylesheet">
        <STYLE>
		.myButtonYellow {
	-moz-box-shadow: 0px 1px 0px 0px #fff6af;
	-webkit-box-shadow: 0px 1px 0px 0px #fff6af;
	box-shadow: 0px 1px 0px 0px #fff6af;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffec64), color-stop(1, #ffab23));
	background:-moz-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-webkit-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-o-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-ms-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:linear-gradient(to bottom, #ffec64 5%, #ffab23 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffec64', endColorstr='#ffab23',GradientType=0);
	background-color:#ffec64;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #ffaa22;
	display:inline-block;
	cursor:pointer;
	color:#333333;
	font-family:Arial;
	font-size:16px;
	font-weight:bold;
	padding:2px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffee66;
}
.myButtonYellow:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffab23), color-stop(1, #ffec64));
	background:-moz-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-webkit-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-o-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-ms-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:linear-gradient(to bottom, #ffab23 5%, #ffec64 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffab23', endColorstr='#ffec64',GradientType=0);
	background-color:#ffab23;
}
.myButtonYellow:active {
	position:relative;
	top:1px;
}

            /* header/copyright link */
			.myButtonblue {
	-moz-box-shadow: 0px 11px 14px -7px #2c2773;
	-webkit-box-shadow: 0px 11px 14px -7px #2c2773;
	box-shadow: 0px 11px 14px -7px #2c2773;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5f59b3), color-stop(1, #434099));
	background:-moz-linear-gradient(top, #5f59b3 5%, #434099 100%);
	background:-webkit-linear-gradient(top, #5f59b3 5%, #434099 100%);
	background:-o-linear-gradient(top, #5f59b3 5%, #434099 100%);
	background:-ms-linear-gradient(top, #5f59b3 5%, #434099 100%);
	background:linear-gradient(to bottom, #5f59b3 5%, #434099 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5f59b3', endColorstr='#434099',GradientType=0);
	background-color:#5f59b3;
	-moz-border-radius:18px;
	-webkit-border-radius:18px;
	border-radius:18px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:18px;
	font-weight:bold;
	padding:8px 15px;
	text-decoration:none;
	text-shadow:0px 1px 0px #433e8a;
}
.myButtonblue:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #434099), color-stop(1, #5f59b3));
	background:-moz-linear-gradient(top, #434099 5%, #5f59b3 100%);
	background:-webkit-linear-gradient(top, #434099 5%, #5f59b3 100%);
	background:-o-linear-gradient(top, #434099 5%, #5f59b3 100%);
	background:-ms-linear-gradient(top, #434099 5%, #5f59b3 100%);
	background:linear-gradient(to bottom, #434099 5%, #5f59b3 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#434099', endColorstr='#5f59b3',GradientType=0);
	background-color:#434099;
}
.myButtonblue:active {
	position:relative;
	top:1px;
}

			.mybuttonred {
	-moz-box-shadow: 0px 11px 14px -7px #732727;
	-webkit-box-shadow: 0px 11px 14px -7px #732727;
	box-shadow: 0px 11px 14px -7px #732727;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #b35959), color-stop(1, #994040));
	background:-moz-linear-gradient(top, #b35959 5%, #994040 100%);
	background:-webkit-linear-gradient(top, #b35959 5%, #994040 100%);
	background:-o-linear-gradient(top, #b35959 5%, #994040 100%);
	background:-ms-linear-gradient(top, #b35959 5%, #994040 100%);
	background:linear-gradient(to bottom, #b35959 5%, #994040 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#b35959', endColorstr='#994040',GradientType=0);
	background-color:#b35959;
	-moz-border-radius:18px;
	-webkit-border-radius:18px;
	border-radius:18px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:18px;
	font-weight:bold;
	padding:8px 15px;
	text-decoration:none;
	text-shadow:0px 1px 0px #8a3e3e;
}
.mybuttonred:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #994040), color-stop(1, #b35959));
	background:-moz-linear-gradient(top, #994040 5%, #b35959 100%);
	background:-webkit-linear-gradient(top, #994040 5%, #b35959 100%);
	background:-o-linear-gradient(top, #994040 5%, #b35959 100%);
	background:-ms-linear-gradient(top, #994040 5%, #b35959 100%);
	background:linear-gradient(to bottom, #994040 5%, #b35959 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#994040', endColorstr='#b35959',GradientType=0);
	background-color:#994040;
}
.mybuttonred:active {
	position:relative;
	top:1px;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    position: relative;
    background-color: #fefefe;
    margin: auto;
    padding: 0;
    border: 1px solid #888;
    width: 80%;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s
}

/* Add Animation */
@-webkit-keyframes animatetop {
    from {top:-300px; opacity:0} 
    to {top:0; opacity:1}
}

@keyframes animatetop {
    from {top:-300px; opacity:0}
    to {top:0; opacity:1}
}

/* The Close Button */
.close {
    color: white;
    float: right;
    font-size: 35px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #FFFFFF;
    text-decoration: none;
    cursor: pointer;
}

.modal-header {
    padding: 2px 2px;
    background-color: #990000;
    color: white;
}

.modal-body {padding: 2px 16px;}

.modal-footer {
    padding: 2px 16px;
    background-color: #5cb85c;
    color: white;
}
			
.link {
  text-decoration: none;
  color: white;
  border-bottom: 2px dotted #55acee;
  transition: .3s;
  -webkit-transition: .3s;
  -moz-transition: .3s;
  -o-transition: .3s;
  cursor: url(http://cur.cursors-4u.net/symbols/sym-1/sym46.cur), auto;
}
.link:hover {
  color: white;
  border-bottom: 2px dotted #2ecc71;
}

/* button div */
#buttons {
  padding-top: 50px;
  text-align: center;
}

/* start da css for da buttons */
.btn {
  border-radius: 5px;
  padding: 15px 25px;
  font-size: 22px;
  text-decoration: none;
  margin: 20px;
  color: #fff;
  position: relative;
  display: inline-block;
}

.btn:active {
  transform: translate(0px, 5px);
  -webkit-transform: translate(0px, 5px);
  box-shadow: 0px 1px 0px 0px;
  color: white;
}

.blue {
    background-color: #003399;
  box-shadow: 0px 5px 0px 0px #3C93D5;
  color: white;
}

.blue:hover {
  background-color: #003399;
  color: white;
}

.green {
  background-color: #2ecc71;
  box-shadow: 0px 5px 0px 0px #15B358;
}

.green:hover {
  background-color: #48E68B;
}

.red {
  background-color: #e74c3c;
  box-shadow: 0px 5px 0px 0px #CE3323;
}

.red:hover {
  background-color: #FF6656;
}

.purple {
    background-color: #009999;
  box-shadow: 0px 5px 0px 0px #82409D;
}

.purple:hover {
  background-color: #009999;
}

.orange {
  background-color: #e67e22;
  box-shadow: 0px 5px 0px 0px #CD6509;
}

.orange:hover {
  background-color: #FF983C;
}

.yellow {
  background-color: #f1c40f;
  box-shadow: 0px 5px 0px 0px #D8AB00;
}

.yellow:hover {
  background-color: #FFDE29;
}
@-moz-keyframes blink {
    0% {
        opacity:1;
    }
    50% {
        opacity:0;
    }
    100% {
        opacity:1;
    }
} 

@-webkit-keyframes blink {
    0% {
        opacity:1;
    }
    50% {
        opacity:0;
    }
    100% {
        opacity:1;
    }
}

        </STYLE>
        <SCRIPT>
                function htmlbodyHeightUpdate(){
		var height3 = $( window ).height()
		var height1 = $('.nav').height()+50
		height2 = $('.main').height()
		if(height2 > height3){
			$('html').height(Math.max(height1,height3,height2)+10);
			$('body').height(Math.max(height1,height3,height2)+10);
		}
		else
		{
			$('html').height(Math.max(height1,height3,height2));
			$('body').height(Math.max(height1,height3,height2));
		}
		
	}
	$(document).ready(function () {
		htmlbodyHeightUpdate()
		$( window ).resize(function() {
			htmlbodyHeightUpdate()
		});
		$( window ).scroll(function() {
			height2 = $('.main').height()
  			htmlbodyHeightUpdate()
		});
	});
            </SCRIPT>
        <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <META name="viewport" content="width=device-width, initial-scale=1">
  <LINK rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <SCRIPT src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></SCRIPT>
  <LINK rel="stylesheet" href="css/pmegpdashboard3.css">
<LINK href="styles/ticker-style.css" rel="stylesheet" type="text/css" />
	<SCRIPT type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></SCRIPT> 
	<SCRIPT src="includes/jquery.ticker.js" type="text/javascript"></SCRIPT>
	<SCRIPT src="includes/site.js" type="text/javascript"></SCRIPT>
    <STYLE type="text/css">
<!--
.style1 {font-size: 18px}
.style2 {font-size: 24px}
-->
    </STYLE>
    </HEAD>
    <BODY style="background-color: #EEC692">
    
        <IMG src="images/04_01.png" width="100%" style="border-bottom: 1px solid #003399">
		

		
        <!-- Sidebar -->
        <nav class="sidebar" role="navigation" style="background-color: #EEC692; border:1px solid #003399">
    <DIV class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<DIV class="navbar-header">
                    <BUTTON type="button" class="navbar-toggle" DATA-TOGGLE="collapse" DATA-TARGET="#bs-sidebar-navbar-collapse-1" style="border: 1px solid #000">
				<SPAN class="sr-only">Toggle navigation</SPAN>
				<SPAN class="icon-bar"></SPAN>
				<SPAN class="icon-bar"></SPAN>
				<SPAN class="icon-bar"></SPAN>
			</BUTTON>
			<A class="navbar-brand" href="#">For Applicant</A>
		</DIV>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<DIV class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
			<UL class="nav navbar-nav">
			
			<LI >
			
			
					<DIV class="w3-container">

  <BUTTON onClick="document.getElementById('id01').style.display='block'" class="w3-button w3-#EEC692">ONLINE EDP</BUTTON>

  <DIV id="id01" class="w3-modal">
    <DIV class="w3-modal-content">
      <DIV class="w3-container">
        <SPAN onClick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</SPAN>
      <BR><BR>
	    <IMG src="02.gif" width="100%" height="132">
		<BR><BR>

		<TABLE width="571" border="1" id="customers" align="center">
  <TR>
    <TD width="234"><SPAN class="style1"><STRONG>Website Address </STRONG></SPAN></TD>
    <TD width="321"><SPAN class="style1"><STRONG><A href="https://www.udyami.org.in" target="_blank">https://www.udyami.org.in</A></STRONG></SPAN></TD>
    </TR>
  <TR>
    <TD><SPAN class="style1"><STRONG>Contact no for online EDP </STRONG></SPAN></TD>
    <TD><SPAN class="style1"><STRONG>07526000333/07526000555</STRONG></SPAN></TD>
    </TR>
  <TR>
    <TD><SPAN class="style1"><STRONG>Email</STRONG></SPAN></TD>
    <TD><SPAN class="style1"><STRONG>helpdesk@udyami.org.in</STRONG></SPAN></TD>
    </TR>
</TABLE>
 <BR>
  <P align="center"><A href="../pmegphome/EDP_CIRCULAR_15.11.2019.pdf" style="color:#FFFFFF " class="myButton3" target="_blank">DOWNLOAD ONLINE EDP TRAINING CIRCULAR</A></P>
	  <BR>
	 <P align="center"><A href="https://www.udyami.org.in" style="color:#FFFFFF " class="myButton3" target="_blank">CLICK HERE FOR ONLINE EDP TRAINING </A></P>
	  <BR>
		<P align="center"><INPUT type="button" value="SHOW FAQ ON PMEGP ONLINE EDP TRAINING" class="myButton3" onClick="showHideDiv('divMsg')"/></P><BR>
		
		<DIV id="divMsg" style="display:none" >
         <TABLE id="customers">
			<TR>
			  <TH width="45"><DIV align="center">Sr. No. </DIV></TH>
			  <TH width="483"><DIV align="center">Question</DIV></TH>
			  <TH width="802"><DIV align="center">Answer</DIV></TH>
			  </TR>
			<TR>
			  <TD>1</TD>
			  <TD>What  is online EDP portal address?</TD>
			  <TD>PMEGP  online EDP portal address is <A href="http://www.udyami.org.in">www.udyami.org.in</A></TD>
			  </TR>
			<TR>
			  <TD>2</TD>
			  <TD>How  can I download Online EDP Mobile App?</TD>
			  <TD><P>You can download by searching "Udyomi" in Mobile PlayStore App and install accordingly.</P></TD>
			  </TR>
			<TR>
			  <TD>3</TD>
			  <TD>Who are eligible for Online EDP Training? </TD>
			  <TD><P>Applicants  whose PMEGP loan has been sanctioned and not completed online EDP training form  any institute.</P></TD>
			  </TR>
			<TR>
			  <TD>4</TD>
			  <TD>What is the EDP Online Training Fees? </TD>
			  <TD>It is  free of cost for PMEGP beneficiary whose application has been sanctioned by  bank and not taken any training from RSETI/RUDSETI and other eligible institute  as per guidelines.</TD>
			  </TR>
			<TR>
			  <TD>5</TD>
			  <TD>What is the duration of the Training?</TD>
			  <TD><P>15  days is the duration of the Training Modules.</P></TD>
			  </TR>
			<TR>
			  <TD>6</TD>
			  <TD>How to register Online EDP Training?</TD>
			  <TD>By using  registered mobile number in PMEGP E-Portal you can register for Online EDP  training.</TD>
			  </TR>
			<TR>
			  <TD>7</TD>
			  <TD>How to get EDP Certificate?</TD>
			  <TD><P>A  certificate and letter of appreciation will be generated by the portal on  completion of training.</P></TD>
			  </TR>
			<TR>
			  <TD>8</TD>
			  <TD>What is the Online EDP Training helpdesk Contact Details?</TD>
			  <TD><P>Contact  Numbers is 07526000333/ 07526000555</P>
			    <P>E-mail id: <A href="mailto:helpdesk@udyami.org.in">helpdesk@udyami.org.in</A> </P></TD>
			  </TR>
			<TR>
			  <TD>9</TD>
			  <TD>What is additional benefit of the EDP online Portal?</TD><TD>Beside  Online EDP training beneficiary can download projects reports, Industrial  Documentaries, Expert Episodes, Guidance for Statutory Registration and various  Government grants, Incentives and other related Information for a period of one  year.</TD></TR>
			</TABLE>
		  </DIV>
		  
		    <P align="center"><A href="EDPFAQ.pdf" style="color:#FFFFFF " class="myButton3" target="_blank" download>DOWNLOAD FAQ</A></P>
	  <BR>
      </DIV>
    </DIV>
  </DIV>
</DIV>
			<LI ><A href="covin19_circular.pdf">COVID19 CIRCULAR  <SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></SPAN></A></LI>
		
			
			<LI ><A href="ExemptionofEDP30092020.pdf">EDP Exemption (30-09-2020) <SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></SPAN></A></LI>
			<LI ><A href="../pmegpdashboardmsme">MSME Dashboard<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></SPAN></A></LI>
				<LI ><A href="edp_projects.jsp">Potential Projects<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></SPAN></A></LI>
			    <LI ><A href="ScoreCardCircular.pdf">Score Card Circular<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></SPAN></A></LI>
				<LI ><A href="../PMEGPONLINETUTORIAL/pmegponline.swf.html">Video Tutorial<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></SPAN></A></LI>
				<LI ><A href="../../pmegp/pmegpweb/docs/jsp/newprojectReports.jsp">Download Model Projects<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><A href="../jsp/SchemeFaqApplicant.html">Frequently Asked Questions (FAQ)<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><A href="../dynamicdistrict/officeSearchForm.jsp">Contact List<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><A href="../pmegpfeedback/index.jsp">Feedback Report <SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><A href="msmedilist.pdf">MSME DI List<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				
				<LI ><A href="../jsp/pmegphindi.html">Hindi<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><A href="../dashboard/circular.jsp">Notifications<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><A href="../jsp/applicantLogin.jsp">Grievances<SPAN style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></SPAN></A></LI>
				<LI ><DIV class="c1" id="google_translate_element"></DIV></LI>
			</UL>
	  </DIV>
	</DIV>
</nav>
<!-- Page Content -->
<DIV class="main" align="center">

<UL id="js-news" class="js-hidden">

		 </li>
               <li class="news-item"> MSME Directorate of Industries Contact Numbers 	 
		
		<a href="msmedilist.pdf" style="color: white;"> Click here -> to Download state wise MSME DI List </a>
		 </li>
		
		<li class="news-item"> EDP exempted upto 30 sep 2020, Upload the Margin Money Claim without EDP Now. 
		
		<a href="ExemptionofEDP30092020.pdf" style="color: white;"> Click here -> to Download Circular </a>
		 </li>
               <li class="news-item"> PMEGP Scheme has been simplified from 01-APR-2020 	 
		
		<a href="ScoreCardCircular.pdf" style="color: white;"> Click here -> to Download Score Card </a>
		 </li>
  </UL>
       <DIV align="center">
		 <DIV  style="border:2px solid black;padding:5px;background-color:#FBCBBF " >
		
		<SPAN style="font-family:Geneva, Arial, Helvetica, sans-serif ;color:#000000;font-weight:bold;font-size:25px">For Upgradation / Expansion of existing PMEGP / REGP / MUDRA units </SPAN><br>
		<SPAN style="color: red;font-size: 15px;font-weight: 800;">Apply for 2nd Loan upto Rs.1.00 Crore</SPAN><br>
		<SPAN style="color: red;font-size: 15px;font-weight: 800;">(Avail Government Subsidy from 15% to 20%)
		</SPAN><BR> 
		<A href="#" class="myButtonYellow style2"  id="myBtn">Apply Online</A><SPAN style="color: black;font-size: 15px;font-weight: 800;">(For Second Loan)</span>		</DIV>
	</DIV>
<DIV class="row" >
  <DIV class="col-sm-0">
    <DIV class="row" >
      <DIV class="col-md-3">
          <A href="../jsp/pmegponline.jsp" class="btn red" style="width: 100%;font-size: 12px"><B>Online Application form for Individual</B></A>
          
      </DIV>
      <DIV class="col-md-3">
          <A href="../jsp/pmegponlineAppType.jsp" class="btn blue" style="width: 100%;font-size: 10.5px"><B>Online Application form for Non-Individual</B></A>
      </DIV>
       
      <DIV class="col-md-3"> 
          <A href="../jsp/applicantLogin.jsp" class="btn purple" style="width: 100%;font-size: 12px"><B>Login form for Registered Applicant</B></A>
        </DIV>
        <DIV class="col-md-3"> 
            <A href="../jsp/applicantLogin.jsp" class="btn orange" style="width: 100%;;font-size: 12px"><B>Feedback form for Applicant</B></A>
        </DIV>
      </DIV>
      
    </DIV><!--/row-->    
  </DIV>
      
   <DIV class="row">
  <DIV class="col-sm-0">
    <DIV class="row">
      <DIV class="col-md-3">
          <DIV class="box box2 shadow6">
              <DIV align="center"><SPAN class="link_label" style="font-size: 15px;">OFFICIAL LOGIN FOR<BR></SPAN><SPAN class="link_label" style="font-size: 22px;"> KVIC /KVIB /DIC /COIR</SPAN> <BR><A href="../jsp/AgencyloginPageNew.jsp">Agency Login</A></DIV>
  </DIV>
          
      </DIV>
      <DIV class="col-md-3">
          <DIV class="box box2 shadow6"><BR>
		
            <DIV align="center"><SPAN class="link_label" style="font-size: 25px;">Online EDP Training</SPAN><BR><A href="#"  onClick="document.getElementById('id01').style.display='block'">Register</A></DIV>
        </DIV>
      </DIV>
       
      <DIV class="col-md-3"> 
          <DIV class="box box2 shadow6"><BR>
              <DIV align="center"> <SPAN class="link_label" style="font-size: 25px;">BANK LOGIN</SPAN><BR><A href="../bankModule/index.jsp">Bank Login</A></DIV>
  </DIV>
        </DIV>
        <DIV class="col-md-3"> 
            <DIV class="box box2 shadow6"><BR>
              <DIV align="center"><SPAN class="link_label" style="font-size: 25px;">PMEGP Dashboard</SPAN><BR><A href="dashboard.jsp">CLICK HERE</A></DIV>	
  </DIV>
        </DIV>
      </DIV>
      
    </DIV><!--/row-->    
  </DIV>
<BR>
        <DIV align="center"> 
		<DIV align="center" style="color: red;font-size: 18px;font-weight: 800;">CAUTION AGAINST MIDDLEMAN</DIV>

<P style="color: #081C6B;font-size: 13px;padding: 2%;border: 1px solid blue;background-color: #F1E0BC"><B>KVIC /KVIB /DIC /COIR have not engaged any private Party/Agency/ Middlemen/ Franchise etc for promoting or sanctioning of PMEGP Projects or any financial assistance under PMEGP Programme and any potential entrepreneurs / beneficiaries dealing with such agency shall be doing it at their risk and consequences.
                    </B> 
  </DIV>   
        
<!-- The Modal -->
<DIV id="myModal" class="modal">

  <!-- Modal content -->
  <DIV class="modal-content">
    <DIV class="modal-header">
      <SPAN class="close" style="color:#FFFFFF ">&times;</SPAN>
      <H4>For Upgradation / Expansion of existing PMEGP / MUDRA units</H4>
    </DIV>
    <DIV class="modal-body">
      <P align="center"><A href="../pmegpIILOAN/PMEGP.pdf" style="color:#FFFFFF " class="mybuttonred" target="_blank">Download Guideline</A></P>
	  <BR>
      <P align="center"><A href="../pmegpIILOAN/index.jsp"  style="color:#FFFFFF" class="myButtonblue">Online Application</A></P>
	  <BR>
	  <P align="center"><A href="../pmegpIILOAN/applicantLogin.jsp"  style="color:#FFFFFF" class="myButtonblue">Login Form For Registered Applicant</A></P>
    </DIV>
  <!--  <div class="modal-footer">
      <h3>Modal Footer</h3>
    </div>-->
  </DIV>

</DIV>

<SCRIPT>
// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</SCRIPT>   

         <DIV style="
  right: 0;
  bottom: 0;
  left: 0;
  padding: 0.5rem;
  background-color: #B57D96;
  text-align: center;
  color: #FFFFFF;border-top: 1px solid ;font-weight: 800;border:2px solid #000"><B>DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI ( pmegpeportal.kvic@gov.in ) </B></DIV>
       
    </DIV> 
		<SCRIPT type="text/javascript">
//<![CDATA[
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'en', includedLanguages: 'en,hi', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
//]]>
</SCRIPT><SCRIPT type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit">
</SCRIPT>

<SCRIPT>  
	function showHideDiv(ele) {
				var srcElement = document.getElementById(ele);
				if (srcElement != null) {
					if (srcElement.style.display == "block") {
						srcElement.style.display = 'none';
					}
					else {
						srcElement.style.display = 'block';
					}
					return false;
				}
			}
			
</SCRIPT>   

    </BODY>
</HTML>
