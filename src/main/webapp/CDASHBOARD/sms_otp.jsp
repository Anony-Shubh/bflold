<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
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
	<SCRIPT type="text/javascript" src="../js/sweetalert.min.js"></SCRIPT>
    <link href="Media Query/media.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
	<script>
	

function submit_offupdate() {
  var OTP_D=document.form.OTP_D.value; 
  
if(OTP_D == "") {
 
	 swal ( 'Note:','Enter OTP','error');	

    return false;
	 }
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
String SER_TYPE= (String) session.getAttribute("SER_TYPE");
String SER_MSG= (String) session.getAttribute("SER_MSG");
String SOTP=(String) session.getAttribute("SOTP");
String SOID=(String) session.getAttribute("SOID");
String msgStr="";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String STATUS="";
String CID=request.getParameter("CID")==null?"0":(String) request.getParameter("CID");

String OTP_D="";

DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
List pstm=new ArrayList();
 try {
	 
 if ((String)request.getParameter("ins")!=null){
 
 
OTP_D=(String) request.getParameter("OTP_D")==null?"":(String) request.getParameter("OTP_D").trim();
STATUS=(String)request.getParameter("STATUS")==null?"0":(String) request.getParameter("STATUS");

if (SOTP.equals(OTP_D)){
StringBuffer qryUpdate= new StringBuffer();
 


if (CID.equals("0"))  {

 ResultSet rsMax= db.execSQL("SELECT CSMS_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
     while (rsMax.next()) {
     CID=rsMax.getString(1);
     }
rsMax.close();


out.print("CID"+CID);
qryUpdate.append("INSERT INTO CDASH_SMS(CID, ");
qryUpdate.append("CONTENT,");
qryUpdate.append("SMS_STAT,");
qryUpdate.append("SENT_DATE,REGIS_DATE,TIMESTAMP,ACT_YN,CSMS_TYPE)");
qryUpdate.append("VALUES (?,?,?,sysdate,null,sysdate,'Y',?) ");
}
else{
qryUpdate.append("  UPDATE CDASH_SMS SET CONTENT=?, SMS_STAT=?, SENT_DATE=sysdate,REGIS_DATE=null,TIMESTAMP=SYSDATE, ACT_YN='Y',CSMS_TYPE=? WHERE CID=?  ");

}


values.add(CID); pstm.add ("L");
values.add(SER_MSG); pstm.add ("L");
values.add(STATUS); pstm.add ("L");
values.add(SER_TYPE); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;

values.clear();
pstm.clear();


String docStr="update cdash_otp set ACT_YN='Y',UTIME_STAMP=SYSDATE,CID="+CID+" where OID="+SOID+" ";
		  
		    ResultSet rsDoc = db.execSQL(docStr);
db.close();			
response.sendRedirect("MsgPass.jsp");

 msgStr=" Detail has been successfully sent to TRAI";
 }else {
	  msgStr="OTP MISMATCH";
	 }
 }
}
catch(Exception e)
{
out.print(e.toString());
}
finally{
//db.close();
}


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
                                </div><br/><br/>
                                <div class="info-data">
                                    <div class="sms-dest">
                                      <label><strong>Enter Otp</strong>:  
                                    <INPUT name="OTP_D" type="text" id="OTP_D" tabindex="2"  value="" maxlength="10" value="" AUTOCOMPLETE="off" >
									<INPUT name="STATUS" type="hidden" id="STATUS" tabindex="2" value="0" maxlength="10" value="" AUTOCOMPLETE="off" >
									  </label>
								  </div><br/><br/>
                                      <div class="sms-area">
                                    <div class="row">
                                        <div class="col-lg-3 col-md-12"></div>
                                        <div class="col-lg-6 col-md-12">
                                          <input name="button"  type="button" class="button"  tabindex="3" onClick="submit_offupdate()" value="Submit">
                                        </div>
                                        <div class="col-lg-3 col-md-12"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-12">
					<DIV align="center" class="style2"><%=msgStr%></DIV>
					</div>
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