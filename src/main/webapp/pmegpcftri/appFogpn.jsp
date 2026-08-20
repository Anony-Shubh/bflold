<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="pkgPmegpNew.VerhoeffAlgorithm"%>
<%@ page import="pkgPmegpNew.printApplication"%>
<%@ page import="in.gov.mgov.SMSServices"%>


<html>
<head>
<title>Forgot Password</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">
function validateform() {
var APPID = document.form1.APPID.value;
var MOBNO = document.form1.MOBNO.value;
var AADHAAR= document.form1.AADHAAR.value;

 var numberOnly=/^[0-9]*$/;
 
/* if(APPID == "") {
    inlineMsg("APPID","Enter Applicant ID",2);
    return false;
	 }
	*/ 
	  if(AADHAAR == "") {
    inlineMsg('AADHAAR','Enter Aadhaar No.',2);
    return false;
  }
  
   if(MOBNO == "") {
    inlineMsg('MOBNO','Enter 10 digit Registered Mobile No',2);
    return false;
  }
  
   if(!numberOnly.test(AADHAAR)) {
	inlineMsg('AADHAAR','Aadhar No should be in Number....',2);
				return false;
	}
	
/*	 if(Number(APPID.length)<16) {
	inlineMsg('APPID','Invalid Applicant ID.......',2);
				return false;
	}
	*/
	 if(Number(AADHAAR.length)!=12) {
	inlineMsg('AADHAAR','Aadhar Number should be 12 Digit',2);
				return false;
	}
	
	 if(Number(MOBNO.length)!=10) {
	inlineMsg('MOBNO','Mobile Number must be 10 digit',2);
				return false;
	}
	
	if(!numberOnly.test(MOBNO)) {
	inlineMsg('MOBNO','Mobile Number should be in Number',2);
				return false;
	}
  
  document.form1.ins.value="I";
  document.form1.submit();
 
}//end of function
	</script>

</head>

<body>
<form name="form1"  method="Post">
<% 
String msgStr="";
   DBCon db= new DBCon();
   db.connect();
  int count=0;
    String APPID=request.getParameter("APPID")==null?"":(String) request.getParameter("APPID");
    String MOBNO = request.getParameter("MOBNO")==null?"":(String) request.getParameter("MOBNO");
	String AADHAARNO=request.getParameter("AADHAAR")==null?"":(String) request.getParameter("AADHAAR");
	String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
	String APP_NAME="";
	String APPUSERID="";
	String  APP_PWD="";
		
	out.print(ins);
	if (ins.equals("I")) {
	
	try {
	 StringBuffer sb= new StringBuffer();
sb.append (" SELECT  AD.APP_ID,  AD.APP_NAME, AD.MOB_NO1, substr(AD.App_id,instr(AD.App_id,'-')+1,length(AD.app_id)) AS APPUSERID, AD.APP_PWD ");
sb.append (" FROM APP_DETAIL AD,BANK_DATAENTRY BD,activity_mast am,ind_grp_mast igm  ");
sb.append (" WHERE AD.APP_ID=BD.APP_ID AND BD.PACT_ID=34 AND AD.ACT_YN='Y' AND BD.MM_REL_DT is not null and igm.ind_grp_cd=4    ");
sb.append (" AND   MOB_NO1=? AND AADHAR_NO=?   AND ad.ACTIVITY_CD=am.ACTIVITY_CD AND am.IND_GRP_CD= igm.IND_GRP_CD ");

	 


	List values=new ArrayList();
   //  values.add (APPID); 
	 values.add (MOBNO);
	  values.add (AADHAARNO);
	 
	 ResultSet rs = db.executeSQL(sb.toString(),values);
	
	 while (rs.next()){
	 
	 	 APPID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
	     APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
			APPUSERID=rs.getString("APPUSERID")==null?"":rs.getString("APPUSERID");
			APP_PWD=rs.getString("APP_PWD")==null?"":rs.getString("APP_PWD");
			count=count+1;
			
	 }//END WHILE
	 rs.close();
	 }catch (Exception e) {
	  out.print ( e.toString());
	 }
	if (count>0) {
	 String sms_string=APPID+" Your Credential for PMEGPCFTRI is: "+APPUSERID+" and Password is: "+APP_PWD+" - KVIC";
	 SMSServices sms1=new SMSServices();

try {
String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOBNO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007767720108823736");
}catch (Exception e) {}


	 msgStr="User Detail has been successfully sent to your mobile";
	 }else {
	  msgStr="No Data found Please verify Aadhaar No and Mobile No.";
	 }
	 }
	 db.close();
%>
<img src="images/cftri.jpeg" width="100%" >

<br>
<br>
<br>
<br>


<table align="center">
  
  <tr>
    <td colspan="2"></td>
    </tr>

  <tr >
    <td ></td>
    <td ><div align="right"><a href="index.jsp" class="greenButtonRound">
	Login Page</a> </div></td>
  </tr>
  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel">
      <h2>
        <input name="ins" type="hidden" id="ins" value="">
        Forget Password for  Registered Applicant </h2>
    </div></th>
    </tr>
  <tr hidden>
    <th><div align="right">Applicant ID :</div></th>
    <td ><input name="APPID" type="hidden" id="APPID" tabindex="1" maxlength="20" autocomplete="off" ></td>
    </tr>
  <tr>
    <th ><div align="right">Aadhaar No: </div></th>
    <td ><input name="AADHAAR" type="text" id="AADHAAR" tabindex="2" required  maxlength="12" autocomplete="off" ></td>
  </tr>
  <tr>
    <th ><div align="right">Registered Mobile No :</div></th>
    <td ><input name="MOBNO" type="text" id="MOBNO" tabindex="2" required maxlength="10" autocomplete="off" ></td>
    </tr>
  <tr>
    <td colspan="2" ><div align="center" class="redLebel"><%=msgStr%></div></td>
    </tr>
  <tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validateform()" value="Get Login Detail">          
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

