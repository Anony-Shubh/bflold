<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html>
<HTML lang="en">
<HEAD>
	<TITLE>BNF</TITLE>
	<META CHARSET="UTF-8">
	<META name="viewport" content="width=device-width, initial-scale=1">
	<LINK rel="stylesheet" type="text/css" href="main1.css">
	
  <script language="javascript">
    function refreshCaptcha() {
      var captchaImg = document.getElementById('captchaImage');
      captchaImg.src = '/pmegpeportal/captcha.jpg?t=' + new Date().getTime();
      document.getElementById('captcha').value = '';
    }
  </script>

<STYLE>
.button {
  border-radius: 4px;
  background-color: #FFEC00;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 20px;
  padding: 15px;
  width: 250px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}

.captcha-container {
    margin: 15px 0;
}
.captcha-image {
    border: 1px solid #ccc;
    margin: 5px 0;
    cursor: pointer;
}
.refresh-captcha {
    color: #0066cc;
    text-decoration: underline;
    cursor: pointer;
    font-size: 12px;
    margin-bottom: 5px;
}
.captcha-input {
    /* width: 150px; */
    padding: 5px;
    margin-top: 5px;
}
.refresh-captcha {
    color: #0066cc;
    text-decoration: underline;
    cursor: pointer;
    font-size: 12px;    /* Added missing semicolon here */
    margin-bottom: 5px;
}
</STYLE>
</HEAD>
<BODY>


<FORM method="post" action="login.jsp">

<IMG src="../images/04_01.png"  width="100%" height="100%">
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>

<TABLE border="0" align="center" width="80%">
  <TR>
  
    <TD> <CENTER>
	<DIV class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50" align="right">
	<SPAN class="login100-form-title">
	BFL LOGIN 
	</SPAN>

 <BR>
<CENTER>   <SELECT name="select"  class="select-css">
            <OPTION value="2024-25">2024-25</OPTION>
            <OPTION value="2023-24">2023-24</OPTION>
			<OPTION value="2022-23">2022-23</OPTION>
			<OPTION value="2021-22">2021-22</OPTION>
            <OPTION value="2020-21">2020-21</OPTION>
            <OPTION value="2019-20">2019-20</OPTION>
            <OPTION value="2018-19">2018-19</OPTION>
          </SELECT> 
</CENTER> <BR>

	<DIV class="wrap-input100 validate-input" >
	<INPUT class="input100" type="text" name="USERNAME" id="USERNAME" PLACEHOLDER="USERNAME">
						
	</DIV>

	<DIV class="wrap-input100 rs1 validate-input">
	
	<INPUT class="input100" type="password" name="PASSWORD"  id="PASSWORD"  placeholder="PASSWORD">
	<SPAN class="focus-input100-1"></SPAN>
	<SPAN class="focus-input100-2"></SPAN>
	
	</DIV>
  <DIV class="wrap-input100 rs1 validate-input">
        <div class="captcha-container" style="display: flex; align-items: center; gap: 10px;">
            <div style="display: flex; align-items: center; gap: 5px;">
              <input type="text" name="captcha" id="captcha" 
                   class="captcha-input input100" 
                   maxlength="6" 
                   required 
                   placeholder="CAPTCHA" />
                <img id="captchaImage" src="/pmegpeportal/captcha.jpg" 
                     onclick="refreshCaptcha()" 
                     class="captcha-image" 
                     title="Click to refresh"
                     style="cursor: pointer; vertical-align: middle;" />
                <a href="javascript:void(0);" 
                   onclick="refreshCaptcha()" 
                   style="text-decoration: none; color: #0066cc; font-size: 12px;"
                   title="Click to refresh">
                    Refresh
                </a>
                
            </div>
        </div>
  </DIV>
  
  <BR>
	<BUTTON class="login100-form-btn">
	Sign in
	</BUTTON>
	</DIV>
	</CENTER></TD>
    </TR>
    </TABLE>				
  <BR />
  <P id="error"></P>
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
      <CENTER>  <H4 style="color: red"><%=request.getAttribute("errorMessage") %></H4></CENTER>
 <%   }
%>

	

</FORM>
<!--<CENTER>
<button class="button"><A href="dr.jsp"><SPAN>Detailed Report</SPAN></A></button>
</CENTER>-->

</BODY>
</HTML>