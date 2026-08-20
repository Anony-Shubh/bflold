

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
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

        </style>
        <script>
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
            </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="css/pmegpdashboard3.css">
<link href="styles/ticker-style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script> 
	<script src="includes/jquery.ticker.js" type="text/javascript"></script>
	<script src="includes/site.js" type="text/javascript"></script>
    </head>
    <body style="background-color: #EEC692">
    
        <img src="images/04_01.png" width="100%" style="border-bottom: 1px solid #003399">
		
        <!-- Sidebar -->
        <nav class="sidebar" role="navigation" style="background-color: #EEC692; border:1px solid #003399">
    <div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1" style="border: 1px solid #000">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">For Applicant</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
			<ul class="nav navbar-nav">
			<li ><a href="edpCircularExmp.pdf">EDP Exemption<img src="new.gif" width="35%" > <span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></span></a></li>
			<li ><a href="../pmegpdashboardmsme">MSME Dashboard<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></span></a></li>
			<li ><a href="https://www.facebook.com/PMEGPKVIC/">PMEGP Facebook<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon fa fa-facebook-official"></span></a></li>
				<li ><a href="../PMEGPONLINETUTORIAL/pmegponline.swf.html">Video Tutorial<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>
				<li ><a href="../../pmegp/pmegpweb/docs/jsp/newprojectReports.jsp">Download Model Projects<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../jsp/SchemeFaqApplicant.html">Frequently Asked Questions (FAQ)<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../dynamicdistrict/officeSearchForm.jsp">Contact List<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../pmegpfeedback/index.jsp">Feedback Report <span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../dashboard/index.jsp">OLD DASHBOARD<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				
				<li ><a href="../jsp/pmegphindi.html">Hindi<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../dashboard/circular.jsp">Notifications<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><div class="c1" id="google_translate_element"></div></li>
			</ul>
		</div>
	</div>
</nav>
<!-- Page Content -->
<div class="main">

<ul id="js-news" class="js-hidden">

		<li class="news-item">EDP exempted upto 31-10-2019, Upload the Margin Money Claim without EDP Now. Download EDP Exemption Circular </li>
               
  </ul>
    <div align="center"><img src="images/eportal.png" width="550">
	<!--
	<a href="https://www.facebook.com/PMEGPKVIC/" target="_blank" title="Connect me with facebook"><img src="images/facebook.png" width="40px" height="40px" ></a><img src="new.gif" width="5%" >
	-->
	 <a href="edpCircularExmp.pdf"><img src="../images/pmegpEDPEx.gif" width="35%" border="0"></a> 
	
	</div>
<div class="row" >
  <div class="col-sm-0">
    <div class="row" >
      <div class="col-md-3">
          <a href="../jsp/pmegponline.jsp" class="btn red" style="width: 100%;font-size: 12px"><b>Online Application form for Individual</b></a>
          
      </div>
      <div class="col-md-3">
          <a href="../jsp/pmegponlineAppType.jsp" class="btn blue" style="width: 100%;font-size: 10.5px"><b>Online Application form for Non-Individual</b></a>
      </div>
       
      <div class="col-md-3"> 
          <a href="../jsp/applicantLogin.jsp" class="btn purple" style="width: 100%;font-size: 12px"><b>Login form for Registered Applicant</b></a>
        </div>
        <div class="col-md-3"> 
            <a href="../jsp/applicantLogin.jsp" class="btn orange" style="width: 100%;;font-size: 12px"><b>Feedback form for Applicant</b></a>
        </div>
      </div>
      
    </div><!--/row-->    
  </div>
      
   <div class="row">
  <div class="col-sm-0">
    <div class="row">
      <div class="col-md-3">
          <div class="box box2 shadow6">
              <div align="center"><span class="link_label" style="font-size: 15px;">OFFICIAL LOGIN FOR<br></span><span class="link_label" style="font-size: 25px;"> KVIC /KVIB /DIC /COIR</span> <br><a href="../jsp/AgencyloginPageNew.jsp">Agency Login</a></div>
  </div>
          
      </div>
      <div class="col-md-3">
          <div class="box box2 shadow6"><br>
            <div align="center"><span class="link_label" style="font-size: 25px;">DLTFC LOGIN</span><br><a href="../jsp/convDltfcLogin.jsp">Convenor Login</a></div>
        </div>
      </div>
       
      <div class="col-md-3"> 
          <div class="box box2 shadow6"><br>
              <div align="center"> <span class="link_label" style="font-size: 25px;">BANK LOGIN</span><br><a href="../bankModule/index.jsp">Bank Login</a></div>
  </div>
        </div>
        <div class="col-md-3"> 
            <div class="box box2 shadow6"><br>
              <div align="center"><span class="link_label" style="font-size: 25px;">PMEGP Dashboard</span><br><a href="dashboard.jsp">CLICK HERE</a></div>	
  </div>
        </div>
      </div>
      
    </div><!--/row-->    
  </div>

        <div align="center"> 
		<div  style="border:2px solid black;padding:5px;background-color:#FBCBBF " >
		<a href="#" class="myButtonYellow"  id="myBtn">Apply Online</a>  <br> 
		<span style="font-family:Geneva, Arial, Helvetica, sans-serif ;color:#000000;font-weight:bold;font-size:25px">For Upgradation / Expansion of existing PMEGP / MUDRA units </span></div>
       <br>
<div align="center" style="color: red;font-size: 18px;font-weight: 800;">CAUTION AGAINST MIDDLEMAN</div>

<p style="color: #081C6B;font-size: 13px;padding: 2%;border: 1px solid blue;background-color: #F1E0BC"><b>KVIC /KVIB /DIC /COIR have not engaged any private Party/Agency/ Middlemen/ Franchise etc for promoting or sanctioning of PMEGP Projects or any financial assistance under PMEGP Programme and any potential entrepreneurs / beneficiaries dealing with such agency shall be doing it at their risk and consequences.
                    </b> 
  </div>   
        
<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close" style="color:#FFFFFF ">&times;</span>
      <h4>For Upgradation / Expansion of existing PMEGP / MUDRA units</h4>
    </div>
    <div class="modal-body">
      <p align="center"><a href="../pmegpIILOAN/PMEGP.pdf" style="color:#FFFFFF " class="mybuttonred" target="_blank">Download Guideline</a></p>
	  <br>
      <p align="center"><a href="../pmegpIILOAN/index.jsp"  style="color:#FFFFFF" class="myButtonblue">Online Application</a></p>
	  <BR>
	  <p align="center"><a href="../pmegpIILOAN/applicantLogin.jsp"  style="color:#FFFFFF" class="myButtonblue">Login Form For Registered Applicant</a></p>
    </div>
  <!--  <div class="modal-footer">
      <h3>Modal Footer</h3>
    </div>-->
  </div>

</div>

<script>
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
</script>   

         <div style="
  right: 0;
  bottom: 0;
  left: 0;
  padding: 0.5rem;
  background-color: #B57D96;
  text-align: center;
  color: #FFFFFF;border-top: 1px solid ;font-weight: 800;border:2px solid #000"><B>DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI ( pmegpeportal.kvic@gov.in ) </B></div>
       
    </div> 
		<script type="text/javascript">
//<![CDATA[
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'en', includedLanguages: 'en,hi', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
//]]>
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit">
</script>
    </body>
</html>
