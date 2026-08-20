<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
<title>PMEGP e-Tracking System Login Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>

<script>

function validatePwd() {
var vusr = document.form1.usr.value;
var vpw = document.form1.pwd.value;


 if(vusr == '') {
    inlineMsg('usr','Enter User Name',2);
    return false;
  }else if(vpw == '') {
    inlineMsg('pwd','Enter Password',2);
    return false;
  }else {
  document.form1.submit();
  
  }

  
}//end of function
</script>
</head>

<body>
<table align="center" width="100%">
<tr>
<th>
<img src="../images/pmegponlineN.jpg" width="100%"  >
</th>
</tr>
</table><center>
<%@ include file="edp_header.jsp" %>

<form name="form1"  method="Post">
<% 
String msgStr="";
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
	sbmon.append(" SELECT * FROM pmegp_rep_user ").
   append(" WHERE UPPER(TRIM(user_name)) =UPPER(TRIM('"+UserCode+"')) and UPPER(TRIM(pwd))=UPPER(TRIM('"+pw+"')) AND ACT_YN='Y'");
   
    ResultSet rsmon = db.execSQL(sbmon.toString());
	
	
	while (rsmon.next()) {
    session.setAttribute("suser_detail",rsmon.getString("user_detail"));
	 session.setAttribute("sstate_cd",rsmon.getString("state_nm"));
	  session.setAttribute("sagency",rsmon.getString("agency"));
	   session.setAttribute("szone",rsmon.getString("zone_nm"));
	response.sendRedirect("../pmegpmr/reportHomePage.jsp");	
	}// while loop
		rsmon.close();
	}
	
		
	
  sb.append(" SELECT user_id, user_name, password, act_yn, state_nm, user_detail,state_cd FROM dataentry_user ").
   append(" WHERE TRIM(user_name) ='"+UserCode+"' and TRIM(password)='"+pw+"' AND ACT_YN='Y'");
   
   try {
    ResultSet rs = db.execSQL(sb.toString());
	
if ( (rs.next()==false) && ( flag.equals("Y")  )  ){
 msgStr="----Log in Failed----";
    }else{ 
	
		
    session.setAttribute("user_id",rs.getString("USER_ID"));
	String vUserId=rs.getString("USER_ID");
	
	 ResultSet rs2 = db.execSQL("SELECT COUNT(USER_ID) FROM MAS_OFF_MAST WHERE USER_ID='"+vUserId+"'");
	 String recount="";
	 while (rs2.next()){
	 recount= rs2.getString(1);
	 }
	 rs2.close();
	 
	if (recount.equals("1")){
	 
			  ResultSet rs1 = db.execSQL(" SELECT a.district_cd,a.OFF_TYPE_CD,A.off_cd,A.off_name,A.agency_type,A.org_cd,D.state_cd,A.sms_yn FROM MAS_OFF_MAST A, DATAENTRY_USER B,M_DISTRICT C, M_STATE D WHERE A.user_id=B.user_id AND A.district_cd=C.district_cd AND C.state_cd=D.state_cd AND A.user_id="+vUserId+"");
			while (rs1.next()) {
			 session.setAttribute("off_cd",rs1.getString("OFF_CD"));
			 session.setAttribute("org_cd",rs1.getString("org_cd"));
			session.setAttribute("off_name",rs1.getString("off_name"));
			session.setAttribute("state_cd",rs1.getString("state_cd")); 
			session.setAttribute("sms_yn",rs1.getString("sms_yn")); 
			session.setAttribute("sOFF_TYPE_CD",rs1.getString("OFF_TYPE_CD"));
			session.setAttribute("sdistrict_cd",rs1.getString("district_cd"));
			session.setAttribute("sagency_type",rs1.getString("agency_type"));
		}
		rs1.close();
		 response.sendRedirect("PMEGPAgencyHomePage.jsp");
	 }else{
	response.sendRedirect("PMEGPAgencyHomePage.jsp");
	 }
   }//final if		
  }catch (Exception e){
 // out.print(e.toString());
  }
  db.close();
  }//end of flag
%>

<table align="center" width="30%">
  <tr>
    <td colspan="2">    </td>
  </tr>
  <tr>
    <th colspan="2">
    <div align="right"><a href="../pmegphome/index.jsp" class="greenButtonRound">
	  Home Page</a> 
    </div></th>
    </tr>

  <tr > 
    <th colspan="2" > <div align="center">OFFICIAL LOGIN (KVIC/KVIB/DIC/COIR)    </div></th>
    </tr>
  <tr>
    <td><div align="right">User ID:</div></td>
    <td ><input name="usr" type="text" id="usr" tabindex="1" maxlength="10" autocomplete="off"></td>
    </tr>
  <tr>
    <td ><div align="right">Password:</div></td>
    <td ><input name="pwd" type="password" id="pwd" tabindex="2" maxlength="10" autocomplete="off"></td>
    </tr>
  <tr>
    <td height="10" colspan="2" ><div align="center"><%=msgStr%></div></td>
    </tr>
  <tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validatePwd()" value="Agency Login">          
        </div>      </th>
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
