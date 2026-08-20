<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,pkgPmegpNew.LoginAttemptCache"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<HTML>
<HEAD>
<TITLE>EDP Training Center Login Form</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT type="text/javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript">
  function refreshCaptcha() {
    var captchaImg = document.getElementById('captchaImage');
    captchaImg.src = '/pmegpeportal/captcha.jpg?t=' + new Date().getTime();
    document.getElementById('captcha').value = '';
  }

  function validatePwd() {
    var vusr = encodeURIComponent(document.form.usr.value);
    var vpw = encodeURIComponent(document.form.pwd.value);
    var vcaptcha = document.form.captcha ? document.form.captcha.value : '';

    if(vusr == "") {
        inlineMsg('usr','Enter User Name',2);
        return false;
    }
      
    if(vpw == "") {
        inlineMsg('pwd','Enter Password',2);
        return false;
    }

    if(vcaptcha == '') {
      inlineMsg('captcha','Enter CAPTCHA',2);
      return false;
    }
      
    document.form.submit();
  
  }//end of function
</SCRIPT>

<STYLE>
.notification {
  background-color: #bf980b;
  color: white;
  text-decoration: none;
  padding: 15px 26px;
  position: relative;
  display: inline-block;
  border-radius: 2px;
}

.notification:hover {
  background: red;
}

.notification .badge {
  position: absolute;
  top: -10px;
  right: -10px;
  padding: 5px 10px;
  border-radius: 50%;
  background-color: red;
  color: white;
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
    width: 150px;
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

 
<FORM name="form" id="form"   method="Post" >
<script>refreshCaptcha();</script>
<% 
  String msgStr="";
  String moduleName="eddOff";
  boolean isCaptchaPass = false;

  	// CAPTCHA Validation.
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String captcha = request.getParameter("captcha");
		String userCode = request.getParameter("usr");
    String password = request.getParameter("pwd");
		if (userCode != null && !userCode.isEmpty() && 
        password != null && !password.isEmpty() && captcha != null) {
			//HttpSession session = request.getSession(false);
			String sessionCaptcha = session != null ? (String) session.getAttribute("captcha_key") : null;
			
			if (sessionCaptcha == null || !sessionCaptcha.equalsIgnoreCase(captcha.trim())) {
				// out.println("<script>inlineMsg('captcha','Invalid CAPTCHA',2);");
				// out.println("refreshCaptcha();</script>");
				msgStr="----Invalid CAPTCHA----";
				// Don't proceed with login
			} else {
				// Remove used CAPTCHA
				session.removeAttribute("captcha_key");
				isCaptchaPass = true;
			}

      if(!(userCode != null && userCode.matches("^[a-zA-Z0-9@.\\-_ ]+$")))
      {
        msgStr="Invalid User Id";
        isCaptchaPass = false;
      }

      if (LoginAttemptCache.isAccountLocked(moduleName + userCode)) {
        long minutesLeft = LoginAttemptCache.getTimeUntilUnlock(moduleName + userCode);
        msgStr="Account is locked.";
        isCaptchaPass = false;
      }
		}
	}

  if(isCaptchaPass) {
      DBCon db= new DBCon();
      db.connect();
    
        String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
        String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
      String OFF_CD="";
      String OFF_NAME="";
      String DISTRICT_CD="";
      String BENF_TYPE_DESC="";
      String OFF_TYPE_CD="";
      if (!UserCode.equals("")) {
      try {
      
      StringBuffer sb= new StringBuffer();
      
      
      sb.append (" SELECT   A.OFF_CD, A.OFF_TYPE_CD, ");
    sb.append (" A.OFF_NAME, ");
    sb.append (" A.DISTRICT_CD ");
    sb.append (" FROM MAS_OFF_MAST A ");
    sb.append (" WHERE ACT_YN='Y' AND TRIM(U_NAME)=TRIM(?) AND TRIM(P_WORD)=TRIM(? )");


      List values=new ArrayList();
      values.add (UserCode); 
      values.add (pw);
      
      String sbt=sb.toString();
      
      ResultSet rs = db.executeSQL(sbt,values);
      
      if (!rs.isBeforeFirst()) {
				// No records found - invalid login
				LoginAttemptCache.trackFailedLogin(moduleName + UserCode,5,30);
			}

      int count=0;
      
      while (rs.next()){
        LoginAttemptCache.resetFailedLogin(moduleName+ UserCode);
        OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
      OFF_NAME=rs.getString("OFF_NAME")==null?"":rs.getString("OFF_NAME");
      DISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
      OFF_TYPE_CD=rs.getString("OFF_TYPE_CD")==null?"":rs.getString("OFF_TYPE_CD");
      

              session.setAttribute("SOFF_CD",OFF_CD);
          session.setAttribute("SOFF_NAME",OFF_NAME);
          session.setAttribute("SDIST_CD",DISTRICT_CD); 
          session.setAttribute("SOFF_TYPE_CD",OFF_TYPE_CD); 
          

          count=count+1;
      }
      rs.close();
      db.close();
      if (count>0){
        response.sendRedirect("edpHomePage.jsp");
      }else if (!(UserCode.equals("")&&pw.equals(""))){
      
      msgStr=" User Name and Password incorrect........ ";
      }
      
      
        
      }catch (Exception e) {
          out.print ( e.toString());
      }
      
      }//end of if user id is not null
  }

  
%>

 <IMG src="../images/pmegponlineN.jpg" width="100%" />
 <br><br>
<TABLE align="center">

  <TR>
    <TD colspan="2">
	
	<DIV align="center">
	<A href="../pmegphome/Phy.verification.pdf" download class="notification">
  <SPAN>Download Physical verification and Geo tagging Letter</SPAN>
  <SPAN class="badge">New</SPAN>
</A></DIV>
	
	<DIV align="right"><A href="../jsp/loginPage.jsp">Home</A></DIV></TD>
    </TR>
  
  
  <TR > 
    <TH colspan="2" > <DIV align="center" class="GreenLebel">
      <H2>Login Form for EDP Training Center </H2>
    </DIV></TH>
    </TR>
  <TR>
    <TH><DIV align="right">User ID:</DIV></TH>
    <TD ><INPUT name="usr" type="text" id="usr" tabindex="1" maxlength="10" AUTOCOMPLETE="off"></TD>
    </TR>
  <TR>
    <TH ><DIV align="right">Password:</DIV></TH>
    <TD ><INPUT name="pwd" type="password" id="pwd" tabindex="2" maxlength="10" AUTOCOMPLETE="off"></TD>
    </TR>
  <TR>
    <TD><DIV align="right">&nbsp;</DIV></TD>
    <TD>
        <div class="captcha-container" style="display: flex; align-items: center; gap: 10px;">
            <div style="display: flex; align-items: center; gap: 5px;">
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
    </TD>       
</TR>
<TR>
	<TD>
		<DIV align="right" style="margin-top: 10px; display: block;">CAPTCHA:
		</DIV>
	</TD>
	<TD> 
		<input type="text" name="captcha" id="captcha" 
                   class="captcha-input" 
                   maxlength="6" 
                   required 
                   placeholder="Enter CAPTCHA" />
	</TD>
</TR>
  <TR>
    <TH colspan="2" >
      <div align="center">
        <DIV align="center">
          <INPUT  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validatePwd()" value="Login">          
        </DIV>      </TH>
    </TR>
  <TR>
    <TD colspan="2">&nbsp;</TD>
    </TR>
   <TR>
    <TD colspan="2" ><DIV align="center" class="redLebel"><%=msgStr%></DIV></TD>
  </TR>
  <TR> 
    <TD colspan="2">     </TD>
    </TR>
   
      <TR > 
        
    <TH colspan="2" nowrap>
      <DIV align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </DIV></TH>
      </TR>
</TABLE>

</FORM>
</BODY>
</HTML>
