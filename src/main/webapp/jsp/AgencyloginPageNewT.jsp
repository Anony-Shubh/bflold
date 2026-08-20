<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
<title>PMEGP e-Tracking System Login Form</title>

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
String assign="AG";
String LOGINT ="";
  String STATE_NM ="";
  String AGENCY ="";
  String ZONE_NM ="";
  String USER_DETAIL ="";
  String OFF_CD ="";
  String LOGIN_TYPE ="";
  String DISTRICT_NAME ="";
  String MIS_OFF_CD ="";
  String AGENCY_TYPE ="";
  String OFF_NAME1 ="";
  String STATE_CD ="";
  String USER_ID ="";
  String ACT_YN ="";
  String OFF_TYPE_CD ="";
  String ORG_CD ="";
  String SMS_YN ="";
  String USER_NAME ="";
  String PWD ="";
  String DISTRICT_CD="";
  
   StringBuffer sb= new StringBuffer();
      StringBuffer sbmon= new StringBuffer();

   
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	String flag= (UserCode !=""&&pw !="")?"Y":"N";
	 if ( flag.equals("Y")  ){
		 DBCon db= new DBCon();
   db.connect();
	
	sbmon.append("	SELECT a.LOGINT,  a.STATE_NM,  a.AGENCY,  a.ZONE_NM,  a.USER_DETAIL,  a.OFF_CD,a.LOGIN_TYPE,  a.DISTRICT_CD, ").
	
 append(" a.DISTRICT_NAME, a.MIS_OFF_CD,  a.AGENCY_TYPE,  a.OFF_NAME1,  a.STATE_CD, a.USER_ID,  a.ACT_YN,  a.OFF_TYPE_CD,  a.ORG_CD, ").
 append(" a.SMS_YN,  a.USER_NAME,  a.PWD FROM agencylog a  ").
 append("    where UPPER(TRIM(user_name)) =UPPER(TRIM('"+UserCode+"')) and UPPER(TRIM(pwd))=UPPER(TRIM('"+pw+"')) ");
		
 
   int count=0;
   try {
    ResultSet rs = db.execSQL(sbmon.toString());
	
//if ( (rs.next()==false) && ( flag.equals("Y")  )  ){
 //msgStr="----Log in Failed----";
 //   }
//	else{
	
	while (rs.next()) {
		LOGINT=rs.getString("LOGINT")==null?"":rs.getString("LOGINT");			
  STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
  AGENCY=rs.getString("AGENCY")==null?"":rs.getString("AGENCY");
  ZONE_NM=rs.getString("ZONE_NM")==null?"":rs.getString("ZONE_NM");
  USER_DETAIL=rs.getString("USER_DETAIL")==null?"":rs.getString("USER_DETAIL");
  OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
  LOGIN_TYPE=rs.getString("LOGIN_TYPE")==null?"":rs.getString("LOGIN_TYPE");
  DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
  MIS_OFF_CD=rs.getString("MIS_OFF_CD")==null?"":rs.getString("MIS_OFF_CD");
  AGENCY_TYPE=rs.getString("AGENCY_TYPE")==null?"":rs.getString("AGENCY_TYPE");
  OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
  STATE_CD=rs.getString("STATE_CD")==null?"":rs.getString("STATE_CD");
  USER_ID=rs.getString("USER_ID")==null?"":rs.getString("USER_ID");
 
  OFF_TYPE_CD=rs.getString("OFF_TYPE_CD")==null?"":rs.getString("OFF_TYPE_CD");
  ORG_CD=rs.getString("ORG_CD")==null?"":rs.getString("ORG_CD");
  SMS_YN=rs.getString("SMS_YN")==null?"":rs.getString("SMS_YN");
  
  DISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
	count=count+1;	
	}	
		
		
	
	
	
	 if (count>0){
	
	 if (LOGINT.equals("REP")) { 
	
	 session.setAttribute("suser_detail",USER_DETAIL);
	 session.setAttribute("sstate_cd",STATE_NM);
	  session.setAttribute("sagency",AGENCY);
	   session.setAttribute("szone",ZONE_NM);
	   rs.close();
	db.close();
	response.sendRedirect("../pmegpmr/reportHomePage.jsp");	
	
	}
	else if (LOGINT.equals("AV")){
		
		 session.setAttribute("sOffCd",OFF_CD);
			 session.setAttribute("sStatecd",STATE_CD);
			 session.setAttribute("sDistrictCd",DISTRICT_CD);
			 session.setAttribute("sDISTRICTNAME",DISTRICT_NAME);
			 session.setAttribute("sOffName1",OFF_NAME1); 
			session.setAttribute("sAgencyType",AGENCY_TYPE); 
			session.setAttribute("sDistrictnm",DISTRICT_NAME); 
			session.setAttribute("slgType",LOGIN_TYPE); 
			 rs.close();
	db.close();
	 response.sendRedirect("../NodalAgency/PMEGPAgencyHomePage.jsp");	
	}
	
	else{	
	
			
				session.setAttribute("assign",assign);	
               session.setAttribute("user_id",USER_ID);
			 session.setAttribute("off_cd",OFF_CD);
			 session.setAttribute("org_cd",ORG_CD);
			session.setAttribute("off_name",OFF_NAME1);
			session.setAttribute("state_cd",STATE_CD); 
			session.setAttribute("sms_yn",SMS_YN); 
			session.setAttribute("sOFF_TYPE_CD",OFF_TYPE_CD);
			session.setAttribute("sdistrict_cd",DISTRICT_CD);
			session.setAttribute("sagency_type",AGENCY_TYPE);
		 rs.close();
	db.close();
		 response.sendRedirect("PMEGPAgencyHomePage.jsp");

	}
	 }
	 
	 else{
	 msgStr="  User Name or Password Incorrect........ ";		 
	 }  
	
	rs.close();
	db.close();
   }
   
	 catch (Exception e){
		 
		
	 }
	 }
%>

<table align="center" width="30%">

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
 
   
      <tr > 
        
    <th colspan="2" nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>

</form>
</body>
</html>
