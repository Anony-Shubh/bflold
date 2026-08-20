<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="in.gov.mgov.SMSServices"%>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>DASHBOARD</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href="css/style.css" rel="stylesheet">
    <link href="Media Query/media.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
	<script>
	
function onlyOne(checkbox) {
    var checkboxes = document.getElementsByName('SER_TYPE')
    checkboxes.forEach((item) => {
        if (item !== checkbox) item.checked = false
    })
}
function submit_offupdate() {
  var SER_MSG=document.form.SER_MSG.value; 
   var SER_TYPE=document.getElementsByName("SER_TYPE");
   //alert(SER_MSG);
   //alert(SER_TYPE);

document.form.ins.value='I'; 
document.form.submit(); 

}
	</script>
	<style>
	.button {
	-moz-box-shadow: 0px 10px 14px -7px #e4f09e;
	-webkit-box-shadow: 0px 10px 14px -7px #e4f09e;
	box-shadow: 0px 10px 14px -7px #e4f09e;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #b7c278), color-stop(1, #969c46));
	background:-moz-linear-gradient(top, #b7c278 5%, #969c46 100%);
	background:-webkit-linear-gradient(top, #b7c278 5%, #969c46 100%);
	background:-o-linear-gradient(top, #b7c278 5%, #969c46 100%);
	background:-ms-linear-gradient(top, #b7c278 5%, #969c46 100%);
	background:linear-gradient(to bottom, #b7c278 5%, #969c46 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#b7c278', endColorstr='#969c46',GradientType=0);
	background-color:#b7c278;
	-moz-border-radius:8px;
	-webkit-border-radius:8px;
	border-radius:8px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Trebuchet MS;
	font-size:14px;
	font-weight:bold;
	padding:8px 19px;
	text-decoration:none;
	text-shadow:0px 1px 0px #646629;
}
	</style>
</head>

<body>
<form name="form" id="form" method="Post">
<%
String SMS_ID="";
String SER_TYPE="";
String SER_MSG="";
String SMS_STATUS="";
String SMS_STAT="";
String REGIS_DATE="";
String CID="";
String REJ_RES="";
String CONTENT="";
String OTP="";
String SENT_DATE ="";
String CSMS_TYPE ="";
int count =0;
DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
List pstm=new ArrayList();

	  StringBuffer sb= new StringBuffer();
	sb.append (" SELECT c.CID,c.CONTENT, c.SMS_STAT,decode(c.SMS_STAT,0,'Pending With TRAI',1,'Sucessfully sent to TRAI',2,'Rejected By TRAI') as SMS_STATUS, to_char(c.SENT_DATE,'DD-MON-RRRR') as SENT_DATE ,to_char(c.REGIS_DATE,'DD-MON-RRRR') as REGIS_DATE, ");
 sb.append (" decode(c.CSMS_TYPE,'PM','PMEGP Units','KI','Khadi Institution','KV','KVIC Office','KA','Khadi Artisan') as CSMS_TYPE,REJ_RES FROM cdash_sms c ");

// out.print (sb.toString());

	
    
	
	 ResultSet rs = db.execSQL(sb.toString());
	
	
 

%>
    <section class="main" id="main">
        <header class="top-banner mt-1 mb-1" style="width: 100%;" id="myDiv1">
            <div class="container-fluid">
                <img src="img/chairman_dashboard (7).jpeg" style="margin: 0; width: 100%;">
            </div>
        </header><input name="ins" type="hidden" id="ins" value="">
        <section class="ftco-section">
            <nav class="navbar navbar-expand-lg" id="ftco-navbar">
                <div class="container">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                        aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="fa fa-bars" style="color: #fff;"> MENU</span>
                    </button>
                    <div class="logout order-lg-last">

                        <a href="logout.jsp">Logout</a>

                    </div>
                    <div class="collapse navbar-collapse" id="ftco-nav">
                        <ul class="navbar-nav mr-auto" ID="ftco-ul">
                            <li class="nav-item"><a href="homepage.jsp" class="nav-link">Home</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Tour</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Leave</a></li>
							<li class="nav-item"><a href="#" class="nav-link">Change Password</a></li>
                            <li class="nav-item "><a href="SmsView.jsp" class="nav-link">SMS Service</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </section>
        <div class="container-fluid">
            <div class="online-application">
                <div class="row">
                    <div class="col-lg-3 col-md-12"></div>
                    <div class="col-lg-6 col-md-12">
                        <div class="card">
                            <div class="card-body" style="padding: 0; margin: 0;">
                                <div class="info-head">
                                    <h5>SMS SERVICE</h5>
                                </div>
                              

                                <div class="sms-area">
                                    <div class="row">
             <DIV align="right">  <A href="smsservice.jsp" class="button" >
	ADD</A></DIV>                         
	<TABLE align="center">

  <TR > 
    <TH > <DIV align="center" class="GreenLebel">SrNo
      </TH>
	  <TH > <DIV align="center" class="GreenLebel">Content
      </TH>
	  <TH > <DIV align="center" class="GreenLebel">Sent date
      </TH>
	  
	 <!--  <TH > <DIV align="center" class="GreenLebel">SMS Type
      </TH>-->
	   <TH > <DIV align="center" class="GreenLebel">Register Date
      </TH>
	  <TH > <DIV align="center" class="GreenLebel">Status
      </TH>
	  <TH > <DIV align="center" class="GreenLebel">TRAI Rejection Reason (if any)
      </TH>
    </TR>
	<%  while (rs.next()){
	 
	 	 CID=rs.getString("CID")==null?"":rs.getString("CID");
	     CONTENT=rs.getString("CONTENT")==null?"":rs.getString("CONTENT");
		 session.setAttribute("SCID",CID);		
		 REGIS_DATE=rs.getString("REGIS_DATE")==null?"":rs.getString("REGIS_DATE");
			SENT_DATE=rs.getString("SENT_DATE")==null?"":rs.getString("SENT_DATE");
			  SMS_STATUS=rs.getString("SMS_STATUS")==null?"":rs.getString("SMS_STATUS");
 SMS_STAT=rs.getString("SMS_STAT")==null?"":rs.getString("SMS_STAT");
			CSMS_TYPE=rs.getString("CSMS_TYPE")==null?"":rs.getString("CSMS_TYPE");
			REJ_RES=rs.getString("REJ_RES")==null?"":rs.getString("REJ_RES");
			count=count+1;
			%>
			
			
			<TR>
			
			<td><%=count%></td>
			<td><%=CONTENT%></td>
			<td><%=SENT_DATE%></td>
			
			<!--<td></td>-->
			<td><%=REGIS_DATE%></td>
			<td><%=SMS_STATUS%></td>
			<td><%=REJ_RES%></td>
			</TR>
			
			<%
			
	}rs.close();
	db.close();
			
			%>
	</TABLE>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-12"></div>
                </div>
                <!-- <div class="row">
            <div class="col-12">
              <div class="tour_link">
                <div class="tour_section">
                  <a href="#" onclick="readonlyFunction()" 
                  id="login-alert"><h3>Officers on Tour/Leave</h3></a>
                </div>                
              </div>
            </div>
          </div> -->
            </div>
        </div>


        <!-------------------------------------------------Footer Section  start  ---------------------------------------------->

        <Footer>
            <div class="container-fluid">
                <div class="footer-content py-2">
                    <p>DESIGNED AND MAINTAINED
                        BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI
                    </p>
                </div>
            </div>
        </Footer>
    </section>

    <!-------------------------------------------------Footer Section End  ---------------------------------------------->

    <div class="alert kircs-alert" role="alert">
        <div class="login-links">
            <a href="#" class="alert-link">ON TOUR</a>
            <a href="#" class="alert-link">ON LEAVE</a>
        </div>
    </div>




    <script src="js/popper.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#login-alert').click(function () {
                $('.alert').show()
            })
        });

        function readonlyFunction() {
            document.getElementById("main").disabled = true;
            document.getElementById("main").style.filter = 'blur(10px)';
        }
    </script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</body>

</html>