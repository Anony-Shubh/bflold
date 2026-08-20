<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            /* header/copyright link */
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
    <body style="background-color: #EDE0E7;">
    
        <img src="images/04.jpg" width="100%">
		
        <br><br>
        <!-- Sidebar -->
        <nav class="sidebar" role="navigation" style="background-color: #FFFFFF">
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
				<li ><a href="../PMEGPONLINETUTORIAL/pmegponline.swf.html">Video Tutorial for Online Application<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>
				<li ><a href="../../pmegp/pmegpweb/docs/jsp/newprojectReports.jsp">Download Model Projects<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../jsp/SchemeFaqApplicant.html">Frequently Asked Questions (FAQ)<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../dynamicdistrict/officeSearchForm.jsp">Contact List<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../pmegpfeedback/index.jsp">Feedback Report <span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><a href="../dashboard/index.jsp">OLD DASHBOARD<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				
				<li ><a href="../jsp/pmegphindi.html">Hindi<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-envelope"></span></a></li>
				<li ><div class="c1" id="google_translate_element"></div></li>
			</ul>
		</div>
	</div>
</nav>
<!-- Page Content -->
<div class="main">

<ul id="js-news" class="js-hidden">
		<li class="news-item">For IT related Query send email to our new email ID  pmegpeportal.kvic@gov.in  </li>
                <li class="news-item">(2) Update profile link has been included to update the address and contact detail of Implementing Agency, Please update the profile.....</li>
	</ul>
    <div align="center"><img src="images/eportal.png" width="550"></div>
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
              <div align="center"><span class="link_label" style="font-size: 15px;">OFFICIAL LOGIN FOR<br></span><span class="link_label" style="font-size: 25px;"> KVIC /KVIB /DIC</span> <br><a href="../jsp/AgencyloginPageNew.jsp">Agency Login</a></div>
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
        <hr style="border: 1px solid #003399">
        <div align="center"> 
<p align="center" style="color: red;font-size: 18px;font-weight: 800;">CAUTION AGAINST MIDDLEMAN</p>
<p style="color: #081C6B;font-size: 13px;padding: 2%;border: 1px solid blue;background-color: #ffcccc"><b>KVIC /KVIB /DIC have not engaged any private Party/Agency/ Middlemen/ Franchise etc for promoting or sanctioning of PMEGP Projects or any financial assistance under PMEGP Programme and any potential entrepreneurs / beneficiaries dealing with such agency shall be doing it at their risk and consequences.
                    </b> 
                </div>   
           

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
