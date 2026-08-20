<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<!DOCTYPE html>
<HTML lang="en">

<HEAD>

    <META CHARSET="utf-8">
    <META name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <META name="description" content="">
    <META name="author" content="">

    <TITLE>::KVIC ::PMEGP DASHBOARD</TITLE>

    <!-- Bootstrap core CSS -->
    <LINK href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/simple-sidebar.css" rel="stylesheet">
	<LINK rel="stylesheet" href="css/animate.css">
	<LINK rel="stylesheet" href="css/style.css">
	<SCRIPT language="javascript">

function submit_btn() {	
		document.form.ins.value='I'; 
	document.form.submit();
}

</SCRIPT>
    <STYLE type="text/css">
<!--
.style1 {color: #3333FF}
-->
    </STYLE>
</HEAD>

<BODY>
<IMG src="img/banner3.jpg" width="100%">
    <div id="wrapper">

     
		<FORM action="logincheck.jsp" id="form" name="form" method="post">

        <!-- Page Content -->
        <DIV id="page-content-wrapper" >
		
            <DIV class="container-fluid" >
			
				
			 		<DIV class="login-box animated fadeInUp">
			<DIV class="box-header">
				<H6>MSME DASHBOARD LOGIN</H6>
			</DIV>
			<LABEL for="username"><SPAN class="style1">Username</SPAN></LABEL>
			
			<INPUT type="USERNAME" id="USERNAME" name="USERNAME" required>
			<BR/>
			<LABEL for="password"><SPAN class="style1">Password</SPAN></LABEL>
			
			<INPUT type="password" id="PASSWORD" name="PASSWORD" required>
			<INPUT type="hidden" name="ins" id="ins">
			<BR>
			<INPUT type="button"  value="Login" class="button" onClick="submit_btn();">
		<BR>
			
 <P id="error"></P>
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
      <CENTER>  <H5 style="color: red"><%=request.getAttribute("errorMessage") %></H5></CENTER>
 <%   }
%>
	
		</DIV>
	</DIV>




			
			
			
        </DIV>
        <!-- /#page-content-wrapper -->

    </DIV>
    <!-- /#wrapper -->
</FORM>




    <!-- Bootstrap core JavaScript -->
    <SCRIPT src="vendor/jquery/jquery.min.js"></SCRIPT>
    <SCRIPT src="vendor/bootstrap/js/bootstrap.bundle.min.js"></SCRIPT>

    <!-- Menu Toggle Script -->
    <SCRIPT>
	          //  $(document).ready(function () {
			  
		//	    $("#menu-toggle").ready(function(e) {
       // e.preventDefault();
     //   $("#wrapper").toggleClass("toggled");
  //  });
   function toggle(){
        $("#wrapper").toggleClass("toggled");
		}
    </SCRIPT>
</BODY>

</HTML>
