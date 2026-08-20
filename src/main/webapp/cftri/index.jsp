<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <title>New Loan Application</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link href="css/style.css" rel="stylesheet" />
    <link href="Media Query/media.css" rel="stylesheet" />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap"
      rel="stylesheet"
    />
  </head>

  <body>
    <header class="top-banner mt-1 mb-1" style="width: 100%">
      <div class="container-fluid">
     <img src="images/cftri.jpeg" width="100%" height="250" border="" ></div>
      </div>
    </header>
	<div>&nbsp;</div>
<div>&nbsp;</div>
	<FORM action="logincheck.jsp" method="post">
       

      <label for="username">Username :</label>
      <input type="text" class="login-input" placeholder="Enter Username" id="username" name="username"  />

      <label for="password">Password :</label>
      <input type="password" class="login-input" placeholder="Enter Password" id="password" name="password" />
      <button><INPUT type="submit" value="Login"></button>
    </form>

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
    <!--------------Footer Section  start  ---------->
<div>&nbsp;</div>
<div>&nbsp;</div>


    <footer>
      <div class="container-fluid">
        <div class="footer-content">
          <p>
            DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY,
            KVIC, MUMBAI
            <!-- <span class="email">( pmegpeportal.kvic@gov.in )</span> -->
          </p>
        </div>
      </div>
    </footer>

    <!----------------Footer Section End---------------->
    <script src="js/popper.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.ticker.js" type="text/javascript"></script>
  </body>
</html>
