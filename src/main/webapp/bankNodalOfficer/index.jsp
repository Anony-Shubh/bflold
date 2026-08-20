<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,pkgPmegpNew.LoginAttemptCache"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script language="javascript">

function refreshCaptcha() {
    var captchaImg = document.getElementById('captchaImage');
    captchaImg.src = '/pmegpeportal/captcha.jpg?t=' + new Date().getTime();
    document.getElementById('captcha').value = '';
}

function validatePwd() {
var vusr = document.form.usr.value;
var vpw = document.form.pwd.value;
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
</script>

<STYLE>
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

</head>

<body>
<form name="form" id="form"   method="Post">
<script>refreshCaptcha();</script>
<% 
  String msgStr="";
  boolean isCaptchaPass = false;
  String moduleName="bankNodalOfficer";
  
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
    String USER_NM="";
    String PASSWD="";
    String USER_DESC="";
    String IFSL_CODE="";
    if (!(UserCode.equals("") && pw.equals(""))) {
    try {
    StringBuffer qry= new StringBuffer();
    
      qry.append(" SELECT USER_NM, PASSWD, USER_DESC, IFSL_CODE ");		   
          qry.append("  FROM BU_USERMAST  ");
          qry.append("  WHERE USER_NM = ?  AND PASSWD = ? ");
    
    List values=new ArrayList();
    values.add (UserCode);
    values.add (pw);
    
    
    ResultSet rs = db.executeSQL(qry.toString(),values);
    if (!rs.isBeforeFirst()) {
				// No records found - invalid login
				LoginAttemptCache.trackFailedLogin(moduleName + UserCode,5,30);
		}
    int count=0;
    
    while (rs.next()){
			LoginAttemptCache.resetFailedLogin(moduleName+ UserCode);
      USER_NM=rs.getString("USER_NM")==null?"":rs.getString("USER_NM");	    
      USER_DESC=rs.getString("USER_DESC")==null?"":rs.getString("USER_DESC");
      IFSL_CODE=rs.getString("IFSL_CODE")==null?"":rs.getString("IFSL_CODE");
            session.setAttribute("sUSER_NM",USER_NM);
        session.setAttribute("sUSER_DESC",USER_DESC);
        session.setAttribute("sIFSL_CODE",IFSL_CODE);
        count=count+1;
    }

    rs.close();
    db.close();
    if ( count>0) {
    response.sendRedirect("bankHomePage.jsp");

    } else{
    msgStr= "Login Fail........! <br><br> Please Enter Valid User Name and Password... ";
    }
    
    
    
    }catch (Exception e) {
      out.print ( e.toString());
    }
    
    }//end validation
  }

%>
<div align="center">
 <img src="../images/pmegponlineN.jpg" width="100%">
</div>
<br>
<table align="center">
  
  <tr>
    <td colspan="2"><center><img src="../images/pmegpetrackN.png"></center></td>
  </tr>
  
  <tr>
    <td colspan="2"><A href="../pmegphome/index.jsp" target="_parent" class="greenButtonRound">Home</A></td>
    </tr>
  
  

  
  
  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel">
      <h2>BANK NODAL OFFICER  LOGIN </h2>
    </div></th>
    </tr>
  <tr>
    <th><div align="right">User ID:</div></th>
    <td ><input name="usr" type="text" id="usr" tabindex="1" maxlength="20" autocomplete="off"></td>
    </tr>
  <tr>
    <th ><div align="right">Password:</div></th>
    <td ><input name="pwd" type="password" id="pwd" tabindex="2" maxlength="20" autocomplete="off"></td>
  </tr>

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

  <tr>
    <td colspan="2" ><div align="center" class="redLebel"><%=msgStr%></div></td>
    </tr>
  <tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validatePwd()" value="Login">          
        </div>      </th>
    </tr>
  <tr>
    <td colspan="2"><div align="center" class="mtextarea">for Technical assistance email to : pmegpeportal.kvic@gov.in </div></td>
    </tr>
  <tr> 
    <td colspan="2">     </td>
    </tr>
   
      <tr > 
        
    <th colspan="2" nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>
</form>
</body>
</html>
