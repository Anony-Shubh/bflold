<%@ page import="javax.sql.*,java.util.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon,pkgPmegpNew.LoginAttemptCache,java.net.*"%>
<%@ include file="responseheaderinclude.jsp" %>

<HTML>
<HEAD>
<TITLE>PMEGP e-Tracking System Login Form</TITLE>

<SCRIPT type="text/javascript" src="../js/inlineMsgMain.js"></SCRIPT>

<SCRIPT>
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
  }else if(vpw == '') {
    inlineMsg('pwd','Enter Password',2);
    return false;
  } else if(vcaptcha == '') {
	inlineMsg('captcha','Enter CAPTCHA',2);
    return false;
  } else {
  document.form1.submit();
  
  }

  
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
    font-size: 12px    margin-bottom: 5px;
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
<IMG src="../images/pmegponlineN.jpg" width="100%"  >

<center>
<%@ include file="edp_header.jsp" %>
<FORM name="form1"  method="Post">
<script>refreshCaptcha();</script>
<% 

	boolean isCaptchaPass = false;
	String msgStr="";
	String moduleName="agencylogin:";
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
			msgStr="Invalid User Id";
			isCaptchaPass = false;
		}

		if (LoginAttemptCache.isAccountLocked(moduleName + userCode)) {
			long minutesLeft = LoginAttemptCache.getTimeUntilUnlock(moduleName + userCode);
			msgStr="Account is locked.";
			isCaptchaPass = false;
		}
	}



	if(isCaptchaPass) {

			String assign="AG";
			String OFF_CD = "";
			String MIS_OFF_CD="";	
			String DISTRICT_CD = "";
			String AGENCY_TYPE = "";
			String OFF_NAME1 = "";
			String STATE_CD="";
			String DISTRICT_NAME="";
			String surl="";
			String CLIENTIP=request.getRemoteHost()==null?"NA":(String) request.getRemoteHost();
			DBCon db= new DBCon();
			db.connect();
			StringBuffer sb= new StringBuffer();
			StringBuffer sbmon= new StringBuffer();

		
			String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
			String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
			String flag= (UserCode !=""&&pw !="")?"Y":"N";
			if ( flag.equals("Y")  ){
			
			if ( flag.equals("Y")  ){
				if ( (UserCode.equals("kvic")||UserCode.equals("msme"))&& (pw.equals("etpmegp")||pw.equals("hq"))) {
			response.sendRedirect("coreport/pmegpReportco.jsp");
			} }
			
			
			if ( UserCode.equals(pw)&&flag.equals("Y") ) {
			//.append(" SELECT * FROM pmegp_rep_user ").
			//append(" WHERE UPPER(TRIM(user_name)) =UPPER(TRIM('"+UserCode+"')) and UPPER(TRIM(pwd))=UPPER(TRIM('"+pw+"')) AND ACT_YN='Y'");

			String sql = " SELECT * FROM pmegp_rep_user WHERE UPPER(TRIM(user_name)) = UPPER(TRIM(?)) AND UPPER(TRIM(pwd)) = UPPER(TRIM(?)) AND ACT_YN='Y'";
			List params = new ArrayList<>();
			params.add(UserCode);
			params.add(pw);
			ResultSet rsmon = db.executeSQL(sql, params);

			//ResultSet rsmon = db.execSQL(sbmon.toString());
			
			if (!rsmon.isBeforeFirst()) {
				// No records found - invalid login
				LoginAttemptCache.trackFailedLogin(moduleName + UserCode,5,30);
			}
			while (rsmon.next()) {
				LoginAttemptCache.resetFailedLogin(moduleName + UserCode);
				session.setAttribute("suser_detail",rsmon.getString("user_detail"));
				session.setAttribute("sstate_cd",rsmon.getString("state_nm"));
				session.setAttribute("sagency",rsmon.getString("agency"));
				session.setAttribute("szone",rsmon.getString("zone_nm"));
				response.sendRedirect("../pmegpmr1/reportHomePage.jsp");	
			}// while loop
				rsmon.close();
			}
			
			
			try{
			
			//  StringBuffer sb1= new StringBuffer();
			// sb1.append (" SELECT MOM.OFF_CD,MOM.U_CAT AS LOGIN_TYPE, ");
			//  sb1.append (" MOM.DISTRICT_CD,MD.DISTRICT_NAME,MOM.MIS_OFF_CD, ");
			//  sb1.append (" MOM.AGENCY_TYPE, ");
			//  sb1.append (" MOM.OFF_NAME1 , MS.STATE_CD ");
			// sb1.append (" FROM MAS_OFF_MAST MOM,M_DISTRICT MD, M_STATE MS  WHERE ");
			// sb1.append (" MOM.DISTRICT_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND ");
			// sb1.append ("  MOM.U_NAME='"+UserCode+"' AND MOM.P_WORD='"+pw+"' AND MOM.CONV_DLTFCYN='Y' ");

			String sql2 = "SELECT MOM.OFF_CD,MOM.U_CAT AS LOGIN_TYPE, MOM.DISTRICT_CD,MD.DISTRICT_NAME,MOM.MIS_OFF_CD,MOM.AGENCY_TYPE, MOM.OFF_NAME1 , MS.STATE_CD FROM MAS_OFF_MAST MOM,M_DISTRICT MD, M_STATE MS WHERE MOM.DISTRICT_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND MOM.U_NAME=? AND MOM.P_WORD=? AND MOM.CONV_DLTFCYN='Y'";
			List params = new ArrayList<>();
			params.add(UserCode);
			params.add(pw);
			ResultSet rs = db.executeSQL(sql2, params);
			
			//ResultSet rs = db.execSQL(sb1.toString());
			String LOGIN_TYPE="";
			
			int count=0;
			if (!rs.isBeforeFirst()) {
				// No records found - invalid login
				LoginAttemptCache.trackFailedLogin(moduleName + UserCode,5,30);
			}
			while (rs.next()){
				LoginAttemptCache.resetFailedLogin(moduleName+ UserCode);
				OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
				DISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
				DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
				AGENCY_TYPE=rs.getString("AGENCY_TYPE")==null?"":rs.getString("AGENCY_TYPE");
				OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
				STATE_CD=rs.getString("STATE_CD")==null?"":rs.getString("STATE_CD");
				LOGIN_TYPE=rs.getString("LOGIN_TYPE")==null?"":rs.getString("LOGIN_TYPE");
				//MIS_OFF_CD=rs.getString("MIS_OFF_CD")==null?"":rs.getString("MIS_OFF_CD");
				session.setAttribute("sOffCd",OFF_CD);
				session.setAttribute("sStatecd",STATE_CD);
				session.setAttribute("sDistrictCd",DISTRICT_CD);
				session.setAttribute("sDISTRICTNAME",DISTRICT_NAME);
				session.setAttribute("sOffName1",OFF_NAME1); 
				session.setAttribute("sAgencyType",AGENCY_TYPE); 
				session.setAttribute("sDistrictnm",DISTRICT_NAME); 
				session.setAttribute("slgType",LOGIN_TYPE); 
				//session.setAttribute("sMiscd",MIS_OFF_CD); 
				session.setAttribute("SCLIENTIP",CLIENTIP);	
				count=count+1;
			}
			rs.close();
			
			if (count>0){
				response.sendRedirect("../NodalAgency/PMEGPAgencyHomePage.jsp");
			}else if (!(UserCode.equals("")&&pw.equals(""))){
				msgStr=" Agency Approver User Name or Password Incorrect........ ";
			}
			}catch (Exception e) {
			
			out.print ( e.toString());
			}
				
				
				
				
				
				
				
				
				
			
		//   sb.append(" SELECT user_id, user_name, password, act_yn, state_nm, user_detail,state_cd FROM dataentry_user ").
		//    append(" WHERE TRIM(user_name) ='"+UserCode+"' and TRIM(password)='"+pw+"' AND ACT_YN='Y'");
			String sql3 = "SELECT user_id, user_name, password, act_yn, state_nm, user_detail,state_cd FROM dataentry_user WHERE TRIM(user_name)=? AND TRIM(password)=? AND ACT_YN='Y'";
			
			try {
				List params = new ArrayList<>();
				params.add(UserCode);
				params.add(pw);
				ResultSet rs = db.executeSQL(sql3, params);
				//ResultSet rs = db.execSQL(sb.toString());
			
				if ( (rs.next()==false) && ( flag.equals("Y")  )  ){
					msgStr="----Log in Failed----";
				} else { 
					session.setAttribute("assign",assign);	
					session.setAttribute("user_id",rs.getString("USER_ID"));
					String vUserId=rs.getString("USER_ID");
					
					ResultSet rs2 = db.execSQL("SELECT COUNT(USER_ID) FROM MAS_OFF_MAST WHERE USER_ID='"+vUserId+"'");
					String recount="";
					while (rs2.next()){
						recount= rs2.getString(1);
					}
					rs2.close();
					
					if (recount.equals("1")){
						ResultSet rs1 = db.execSQL(" SELECT a.district_cd,a.OFF_TYPE_CD,A.off_cd,A.off_name,A.agency_type,C.DISTRICT_NAME,A.org_cd,D.state_cd,A.sms_yn FROM MAS_OFF_MAST A, DATAENTRY_USER B,M_DISTRICT C, M_STATE D WHERE A.user_id=B.user_id AND A.district_cd=C.district_cd AND C.state_cd=D.state_cd AND A.user_id="+vUserId+"");
						while (rs1.next()) {
							session.setAttribute("off_cd",rs1.getString("OFF_CD"));
							session.setAttribute("org_cd",rs1.getString("org_cd"));
							session.setAttribute("off_name",rs1.getString("off_name"));
							session.setAttribute("state_cd",rs1.getString("state_cd"));
							session.setAttribute("sDISTRICTNAME",rs1.getString("DISTRICT_NAME")); 
							session.setAttribute("sms_yn",rs1.getString("sms_yn")); 
							session.setAttribute("sOFF_TYPE_CD",rs1.getString("OFF_TYPE_CD"));
							session.setAttribute("sdistrict_cd",rs1.getString("district_cd"));
							session.setAttribute("sagency_type",rs1.getString("agency_type"));
							session.setAttribute("SCLIENTIP",CLIENTIP);	
						}
						rs1.close();
						response.sendRedirect("PMEGPAgencyHomePage.jsp");
					} else {
						response.sendRedirect("PMEGPAgencyHomePage.jsp");
					}
				}//final if		
		}catch (Exception e){
		// out.print(e.toString());
		}
			db.close();
		}//end of flag
	}
  
%>

<TABLE align="center" width="30%">

  <TR>
    <TH colspan="2">
    <DIV align="right"><A href="../pmegphome/index.jsp" class="greenButtonRound">
	  Home Page</A>    </DIV></TH>
    </TR>

  <TR >
    <TH colspan="2" ><DIV align="center">
	<A href="../pmegphome/Phy.verification.pdf" download class="notification">
  <SPAN>Click here to Download Physical verification and Geo tagging Letter</SPAN>
  <SPAN class="badge">New</SPAN>
</A></DIV>
	
	
  </TR>
  <TR > 
    <TH colspan="2" > <DIV align="center">OFFICIAL LOGIN (KVIC/KVIB/DIC/COIR)    </DIV></TH>
    </TR>
  <TR>
    <TD><DIV align="right">User ID:</DIV></TD>
    <TD ><INPUT name="usr" type="text" id="usr" tabindex="1" maxlength="10" AUTOCOMPLETE="off"></TD>
    </TR>
  <TR>
    <TD ><DIV align="right">Password:</DIV></TD>
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
    <TD height="10" colspan="2" ><DIV align="center"><%=msgStr%></DIV></TD>
    </TR>
  <TR>
    <TH colspan="2" >
      <div align="center">
        <DIV align="center">
          <INPUT name="btnLogIn"  type="button" class="button" id="btnLogIn"   tabindex="3" onClick="validatePwd()" value="Agency Login">          
        </DIV>      </TH>
    </TR>
 
   
      <TR > 
        
    <TH colspan="2" nowrap>
      <DIV align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </DIV></TH>
      </TR>
</TABLE>

</FORM>
</BODY>
</HTML>
