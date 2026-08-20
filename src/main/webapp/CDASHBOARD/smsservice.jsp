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
    <link href="Media Query/media.css" rel="stylesheet"
	<script src="../js/inlineMsgMain.js"></script>
	<SCRIPT type="text/javascript" src="../js/sweetalert.min.js"></SCRIPT>
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
	<script>
	

function submit_offupdate() {
	var SER_MSG=document.getElementById("SER_MSG").value;
var format = /[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;

 // var SER_MSG=document.form.SER_MSG.value; 
  var SER_TYPE1=document.getElementById("units1");
    var SER_TYPE2=document.getElementById("units2").value; 
	 var SER_TYPE3=document.getElementById("units3").value; 
	  var SER_TYPE4=document.getElementById("units4").value;
	 // alert(SER_TYPE1.checked);
	 if (SER_TYPE1.checked == false || SER_TYPE2.checked == false || SER_TYPE3.checked == false || SER_TYPE4.checked == false ) {
		 
	swal ( 'Note:','Please Select Msg Type','error');	

    return false;	 
		 
	 }

 
   if(SER_MSG == "") {
 //inlineMsg('SER_MSG',"Enter Msg",2);
	swal ( 'Note:','Enter Msg','error');	

    return false;
	 }
	  if(!format.test(SER_MSG)) {
	//inlineMsg('BEN_CD','Institution Code should be in Number....',2);
	swal ( 'Note:','No Special Character Allowed','error');	
				return false;
	}

document.form.ins.value='I'; 
document.form.submit(); 

}

function RestrictSpecialChar(e)
    {
        var exp = String.fromCharCode(window.event.keyCode) 
        //var address=document.getElementById(txtName);
        var r = new RegExp("[-/\:().#,0-9a-zA-Z \r]", "g");
        if (exp.match(r) == null)
        {
            window.event.keyCode = 0;
            return false;
        }        
        
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
String BEN_CONTACT2_MOB="9987402341";
String OID="";
String OTP="";
String BEN_CD="99";
DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
List pstm=new ArrayList();
String vwhercls ="";
 try {
	 
 if ((String)request.getParameter("ins")!=null){
	 
	 String [] vBillid=request.getParameterValues("SER_TYPE");
 if (vBillid == null) {
out.print ("<center><h1> No Application has been Selected.........<br> <br> Please Select Check Box to select Application.....</h1></center>");
}else{

 

if (vBillid != null && vBillid.length != 0) {
for (int i = 0; i < vBillid.length; i++) {
	vwhercls=vBillid[i]+","+vwhercls;
//vwhercls="'"+vBillid[i]+"'"+","+vwhercls ; 
}//end of for loop
vwhercls=vwhercls+"-";
}//end of if
}
out.print(vwhercls);



  ResultSet rsMax= db.execSQL("select nvl(max(OID),0)+1 from cdash_otp ");
     while (rsMax.next()) {
     OID=rsMax.getString(1);
     }
rsMax.close();
 

//SER_TYPE=(String) request.getParameter("SER_TYPE")==null?"":(String) request.getParameter("SER_TYPE").trim();
SER_MSG=(String) request.getParameter("SER_MSG")==null?"":(String) request.getParameter("SER_MSG").trim();


ResultSet rsRd = db.execSQL("select round(dbms_random.value(1000,9999),0) APP_PWD from dual ");
		
		while (rsRd.next()){
		  OTP=rsRd.getString(1);
		}
		rsRd.close();
		
		
		
	StringBuffer qryUpdate = new StringBuffer();
						
						//out.print("SER_TYPE"+SER_TYPE);
						//out.print("OTP"+OTP);
						///out.print("OID"+OID);
						//out.print("BEN_CONTACT2_MOB"+BEN_CONTACT2_MOB);
						
						qryUpdate.append(" INSERT INTO cdash_otp ( OID,");
						qryUpdate.append("OTP,");
						qryUpdate.append("MOB_NO,CID,");
						qryUpdate.append("ACT_YN,TIMESTAMP) VALUES (?,?,?,0,'N',SYSDATE) ");
						
						values.add (OID);pstm.add ("S");
						values.add (OTP);pstm.add ("S");
						values.add (BEN_CONTACT2_MOB);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
						values.clear();	
						  session.setAttribute("SER_TYPE",vwhercls);
   session.setAttribute("SER_MSG",SER_MSG);
    session.setAttribute("SOTP",OTP);
	session.setAttribute("SOID",OID);
					
		
		
 String sms_string="Dear KIeportal Beneficiary  ( "+BEN_CD +" ). Your requested OTP  for Updation of Artisan Data is  "+OTP+" . Do not share this OTP with anyone. This will be valid for 60 mins only -KVIC";

	 SMSServices sms1=new SMSServices();
			try {
	      String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",BEN_CONTACT2_MOB,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007141026265968304");

   
}catch (Exception e) {}
		
 


response.sendRedirect("sms_otp.jsp");
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
                                </div>
								
								<TABLE align="center">

  <TR > 
    <TH ><DIV align="center" class="GreenLebel">SMS Type :</div></TH>
	<TD>
								
                               
                                    
                                        <input type="checkbox" id="units1" name="SER_TYPE" value="PM" > 
                                        <strong>PMEGP
                                            Units                                        </strong>
                                        <input type="checkbox" id="units2" name="SER_TYPE" value="KI" > <strong>Khadi
                                            Institutions</strong>
                    <input type="checkbox" id="units3" name="SER_TYPE" value="KV" > 
                                        <strong>KVIC
                                            Offices</strong>
                    <input type="checkbox" id="units4" name="SER_TYPE" value="KA" > 
                                        <strong>Khadi
                                            Artisans</strong></TD>
  </TR>
											<TR>
		<TH ><DIV align="center" class="GreenLebel">SMS Text :</div></TH>									 
                                        
                                           <td><textarea class="form-control" name="SER_MSG" id="SER_MSG" cols="20" rows="5"
                                                placeholder="Type the SMS text here...." onKeyPress="return RestrictSpecialChar(event);">
												</textarea>
												</td>
                                        </TR>
                               <TR>        
                                <td colspan="2"> 
									 <input  type="button" class="button"  tabindex="3" onClick="submit_offupdate()" value="Register text with TRAI"> 
                              </td>
							  </TR>
                               </TABLE>
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