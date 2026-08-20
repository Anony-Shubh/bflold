<%
response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
%>
<!DOCTYPE html>

<HTML>
    <TITLE>Login</TITLE>
	  <META name="viewport" content="width=device-width, initial-scale=1">
<LINK rel="stylesheet" type="text/css" href="css/pmegpNew.css" />
<BODY> 
<CENTER>
<br>
<br>
<br>
<br>
<br>
<br>	
 <TABLE width="30%" height="200px" border="1" align="center">

  <TR>
  
    <TD>
	<H1><DIV align="center">Login</DIV></H1>
	
	<DIV align="center">
		<FORM action="login.jsp" method="post">

			
			<DIV>
				<INPUT type="text" PLACEHOLDER="Username" REQUIRED="Enter User Name" name="USERNAME"  autocomplete="off" maxlength="12" id="username">
			</DIV>
			<br>

			<DIV>
				<INPUT type="password" PLACEHOLDER="Password" REQUIRED="Enter Password"  name="PASSWORD" id="password" maxlength="12" AUTOCOMPLETE="off">
			</DIV>
			<DIV align="center">
				<INPUT type="submit" value="Log in" class="buttonlogin">
			</DIV>
		</FORM>
		</TD>
  </TR>
</TABLE>
  </CENTER>
	 <P id="error"></P>
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
      <CENTER>  <H4 style="color: red"><%=request.getAttribute("errorMessage") %></H4></CENTER>
 <%   }
%>
<BR>
<BR>

	

    </BODY>
</HTML>
