<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
<title>PMEGP e-Tracking System Login Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">
  function refreshCaptcha() {
    var captchaImg = document.getElementById('captchaImage');
    captchaImg.src = '/pmegpeportal/captcha.jpg?t=' + new Date().getTime();
    document.getElementById('captcha').value = '';
  }

  function validatePwd() {
    var vusr = document.form1.usr.value;
    var vpw = document.form1.pwd.value;
    var vcaptcha = document.form1.captcha ? document.form1.captcha.value : '';

    if(vusr == '') {
        inlineMsg('usr','Enter User Name',2);
        return false;
      } else if(vpw == '') {
        inlineMsg('pwd','Enter Password',2);
        return false;
      } else if(vcaptcha == '') {
        inlineMsg('captcha','Enter CAPTCHA',2);
        return false;
      } else {
        document.form1.submit();
      }
  }//end of function
</script>

<style>
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
      font-size: 12px;
      margin-bottom: 5px;
  }
</style>
</head>

<body>
<form name="form1"  method="Post" action="applicantLogin.jsp">
<script>refreshCaptcha();</script>
<% 
  String msgStr="";
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
			
		}

		if(!(userCode != null && userCode.matches("^[a-zA-Z0-9@.\\-_ ]+$")))
		{
			msgStr="Invalid UserCode";
			isCaptchaPass = false;
		}
	}

  if(isCaptchaPass) {
    DBCon db= new DBCon();
    db.connect();
  
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
    String ACT_ID="";
    String APP_ID="";
    String APP_NAME="";
    String BENF_TYPE_DESC="";
    
    try {
    
    StringBuffer sb= new StringBuffer();
    
    
    sb.append (" SELECT  A.APP_ID, ");
    sb.append (" A.APP_NAME, ");
    sb.append (" A.ACT_ID ");
    sb.append ("FROM APP_DETAIL_ONLINE_SECOND A ");
    sb.append ("WHERE ");
    sb.append (" substr(A.App_id,instr(A.App_id,'-')+1,length(A.app_id)) =? ");
    sb.append (" AND A.APP_PWD = ? ");

    List values=new ArrayList();
    values.add (UserCode); 
    values.add (pw);
    
    String sbt=sb.toString();
    
    ResultSet rs = db.executeSQL(sbt,values);
    
    int count=0;
    
    while (rs.next()){
    
      APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
      APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");	 
      ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
    

            session.setAttribute("sAPP_ID",APP_ID);
        session.setAttribute("sAPP_NAME",APP_NAME);			
        session.setAttribute("sACT_ID",ACT_ID); 

        count=count+1;
    }
    
    if (count>0){
      response.sendRedirect("ApplicantHomePage.jsp");
    }else if (!(UserCode.equals("")&&pw.equals(""))){
    
      msgStr=" User Name and Password incorrect........ ";
    }
    
    
      
    }catch (Exception e) {
    
      out.print ( e.toString());
    }
  }



  
	 
	 
%>
<img src="../images/04_01.png" width="100%"  >
<div align="right"><a href="../jsp/loginPage.jsp" class="greenButtonRound">
	Home Page</a> </div>
 <div align="center" class="GreenLebel">
      <h2>Login Form for Registered Applicant Of Second Loan Subsidy For Upgrading Of Exisiting Unit </h2>
    </div>
<table align="center">
   
  <tr>
    <td colspan="2"><center><img src="../images/pmegpetrackN.png"></center></td>
  </tr>
  
  
  <tr >
    <td colspan="2" ></td>
    </tr>
  <tr > 
    <th colspan="2" ></th>
    </tr>
  <tr>
    <th><div align="right">User ID:</div></th>
    <td ><input name="usr" type="text" id="usr" tabindex="1" maxlength="10"></td>
    </tr>
  <tr>
    <th ><div align="right">Password:</div></th>
    <td ><input name="pwd" type="password" id="pwd" tabindex="2" maxlength="10"></td>
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
    <td colspan="2"><div align="right"><a href="appFogpn.jsp" target="_parent" class="blueRound">Forget password</a></div></td>
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
