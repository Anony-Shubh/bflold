<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<!DOCTYPE html>
<HTML lang="en">

<HEAD>

    <META CHARSET="utf-8">
    <META name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <META name="description" content="">
    <META name="author" content="">

    <TITLE>::KVIC ::</TITLE>

    <!-- Bootstrap core CSS -->
    <LINK href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/simple-sidebar1.css" rel="stylesheet">
	<LINK rel="stylesheet" href="css/animate.css">
	<LINK rel="stylesheet" href="css/style.css">

</HEAD>

<BODY>
<img src="images/nomination.jpeg" width="100%" style="border: 5px solid #555;">

		<FORM action="hologin.jsp" method="post">

        <!-- Page Content -->
		
            <DIV class="container-fluid" >
								
			 		<DIV class="login-box animated fadeInUp">
			<DIV class="box-header" style="background-color:black">
				<H6>OFFICIAL Login</H6>
			</DIV>
			<LABEL for="username" style="color:black;">Username</LABEL>
			
			<INPUT type="USERNAME" id="USERNAME" name="USERNAME" required>
			<BR/>
			<LABEL for="password" style="color:black;">Password</LABEL>
			
			<INPUT type="password" id="PASSWORD" name="PASSWORD" required>
			<BR>
			<INPUT type="submit" style="background-color:black" value="Login" class="button">
		
<BR>
			<a class="button" href="index.jsp">BACK</a>
			
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



</FORM>
    <!-- Bootstrap core JavaScript -->
    <SCRIPT src="vendor/jquery/jquery.min.js"></SCRIPT>
    <SCRIPT src="vendor/bootstrap/js/bootstrap.bundle.min.js"></SCRIPT>


   
   
</BODY>

</HTML>
