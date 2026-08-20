<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>LOGIN</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link href="css/style.css" rel="stylesheet">
  <link href="Media Query/media.css" rel="stylesheet">
  <link rel="stylesheet" href="css/font-awesome.css">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <script language="javascript">
function validatePwd() {
var vusr = document.form.usr.value;
var vpw = document.form.pwd.value;
 if(vusr == "") {
    inlineMsg('usr','Enter User Name',2);
    return false;
  }
  
 if(vpw == "") {
    inlineMsg('pwd','Enter Password',2);
    return false;
  }
  
 document.form.submit();
  
 
}//end of function
</script>
</head>
<body>
<form name="form" id="form"   method="Post">
<% 
   String msgStr="";
   
 
    String username=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	
	
	if ((username.equals("chairman") && pw.equals("chairman"))) {
	
	 session.setAttribute("userid", username);				
	response.sendRedirect("homepage.jsp");
	// response.sendRedirect("edpViewPageAgency.jsp");

	} 
	
	else
	{
	//msgStr= "Login Fail........! <br><br> Please Enter Valid User Name and Password... ";
	 
	 } 
	 
%>
  <section class="main" id="main">
  <header class="top-banner mt-1 mb-1" style="width: 100%;" id="myDiv1">
    <div class="container-fluid">
      <img src="img/chairman_dashboard (7).jpeg" style="margin: 0; width: 100%;">
    </div>
  </header>
   
  <div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <!-- <div class="login100-form-title">
                <img src="images/title-1.jpg">
            </div> -->
            <div class="login_head">
                <h5>LOGIN</h5>
            </div>
            <form class="login100-form validate-form">
                <div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
                    <span class="label-input100">Username&nbsp;:</span>
                    <input class="input100" type="text" name="usr" id="usr" placeholder="Enter username">
                    <span class="focus-input100"></span>
                </div>
                <div class="wrap-input100 validate-input m-b-18" data-validate="Password is required">
                    <span class="label-input100">Password&nbsp;:</span>
                    <input class="input100" type="password" name="pwd" id="pwd" placeholder="Enter password">
                    <span class="focus-input100"></span>
                </div>
                <div class="check-100">
                    <div class="contact100-form-checkbox">
                        <input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
                        <label class="label-checkbox100" for="ckb1">
                            Remember me
                        </label>
                    </div>

                </div>
                <div class="container-login100-form-btn">
				 <input  type="button" class="login100-form-btn"  tabindex="3" onClick="validatePwd()" value="Login">   
                       
                                        
                </div>
            </form>
        </div>
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

</body>

</html>