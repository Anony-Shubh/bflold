<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>BNF</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../css/main1.css">
</head>
<body>
<form method="post" action="login.jsp">

<img src="../images/01.jpg"  width="100%" height="100%">
<br>
<br>
<br>
<br>
<br>
<br>
<table border="0" align="center" width="80%">
  <tr>
  
    <td> <center>
				<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50" align="right">
					<span class="login100-form-title">
					 BFL LOGIN 
					</span>

					<div class="wrap-input100 validate-input" >
						<input class="input100" type="text" name="USERNAME" id="USERNAME" placeholder="USERNAME">
						
					</div>

					<div class="wrap-input100 rs1 validate-input">
						<input class="input100" type="password" name="PASSWORD"  id="PASSWORD"  placeholder="PASSWORD">
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>					</div>
<br>
						<button class="login100-form-btn">
							Sign in
						</button>

			</div>
	</center></td>
  </tr>
</table>

					
  <br />
                 <p id="error"></p>
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
      <center>  <h4 style="color: red"><%=request.getAttribute("errorMessage") %></h4></center>
 <%   }
%>

	

</form>
	


</body>
</html>