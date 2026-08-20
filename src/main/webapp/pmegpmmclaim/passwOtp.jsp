<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="in.gov.mgov.SMSServices"%>


<html>
<head>
<title>MM CLAIM FORGOT PASSWORD</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">
function validateform() {

var BEN_CONTACT2_MOB= document.form1.BEN_CONTACT2_MOB.value;

 var numberOnly=/^[0-9]*$/;
 

   if(BEN_CONTACT2_MOB == "") {
    inlineMsg('BEN_CONTACT2_MOB','Enter 10 digit Registered Mobile No',2);
    return false;
  }
  
   if(!numberOnly.test(BEN_CONTACT2_MOB)) {
	inlineMsg('BEN_CONTACT2_MOB','Mobile No should be in Number....',2);
				return false;
	}
  
	
	 if(Number(BEN_CONTACT2_MOB.length)!=10) {
	inlineMsg('BEN_CONTACT2_MOB','Mobile Number must be 10 digit',2);
				return false;
	}
	
	
  document.form1.ins.value="I";
  document.form1.submit();
 
}//end of function

function validateformSub(){
 document.form1.ins.value="V";
  document.form1.submit();
}


	</script>

</head>

<body>
<form name="form1"  method="Post">
<% 
String BEN_CD =  (String) session.getAttribute("SUSER_ID");

	 String STRID =  (String) session.getAttribute("STRID");
String msgStr="";
String HRS="";
String VALID_YN="";
   DBCon db= new DBCon();
   db.connect();
  int count=0;
  
  String UPDATE_YN="";
String  TRID1="";
/*StringBuffer qryt = new StringBuffer();
qryt.append(" SELECT trid,CASE WHEN T2 <= T1 THEN 'Y' ELSE 'N' END AS UPDATE_YN FROM (   ");
qryt.append(" SELECT trid,P_TIMESTAMP AS T1,(to_timestamp(to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss')) AS T2");
qryt.append(" FROM MDA_ART_OTP WHERE TRID=(SELECT MAX(TRID) FROM MDA_ART_OTP WHERE  BEN_CD="+BEN_CD+"))     ");
		 
		 
		   ResultSet rsAppt = db.execSQL(qryt.toString());
	
	 while (rsAppt.next()){
	 
	 	 UPDATE_YN=rsAppt.getString("UPDATE_YN")==null?"":rsAppt.getString("UPDATE_YN");
		 TRID1=rsAppt.getString("TRID")==null?"":rsAppt.getString("TRID");
		
	 }
	rsAppt.close();	
if (UPDATE_YN.equals("N")){
	
	String docStr="update mda_art_otp set valid_yn='N' where trid="+TRID1+" ";
		  
		    ResultSet rsDoc = db.execSQL(docStr);	
	
}

*/
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
    String BEN_CONTACT2_MOB = request.getParameter("BEN_CONTACT2_MOB")==null?"":(String) request.getParameter("BEN_CONTACT2_MOB");
	
	String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
	String BEN_CD_Q="";
	String WRD_PW="";
	String  OTP="";
		String  OTP_D="";
	String TRID="";	
	String CONTACT_NO="";
	out.print(ins);
	
	
	if (ins.equals("I")) {
	
	try {
	 StringBuffer sb= new StringBuffer();
	sb.append (" select USER_ID,MOB_NO ,LPAD(SUBSTR(MOB_NO,-3),LENGTH(MOB_NO),'X') AS CONTACT_NO from MMCLAIM_USER where ACT_YN ='Y' AND USER_ID=? AND MOB_NO=?  ");


 
// out.print(sb.toString());
	List values=new ArrayList();
     values.add (BEN_CD); 
	 values.add (BEN_CONTACT2_MOB);
	
	 
	 ResultSet rs = db.executeSQL(sb.toString(),values);
	
	 while (rs.next()){
	 
	 	 BEN_CD_Q=rs.getString("USER_ID")==null?"":rs.getString("USER_ID");   
			
		 CONTACT_NO=rs.getString("CONTACT_NO")==null?"":rs.getString("CONTACT_NO");
		 
			count=count+1;
			
	 }//END WHILE
	 rs.close();
	 }catch (Exception e) {
	  out.print ( e.toString());
	 }
	 String s=String.valueOf(count);
	if (count>0) {
		
		
		ResultSet rsOTP = db.execSQL("select valid_yn from PMEGP_PASS_OTP where trid=(select max(trid) from PMEGP_PASS_OTP where USERID="+BEN_CD+") ");
		
		while (rsOTP.next()){
		  VALID_YN=rsOTP.getString("VALID_YN")==null?"":rsOTP.getString("VALID_YN");;
		}
		rsOTP.close();
		
	//if((VALID_YN.equals("N")) || (VALID_YN.equals(""))) {
		
		
		 ResultSet rsMax= db.execSQL("select nvl(max(TRID),0)+1 from PMEGP_PASS_OTP ");
     while (rsMax.next()) {
     TRID=rsMax.getString(1);
     }
rsMax.close();
 session.setAttribute("STRID",TRID);


		ResultSet rsRd = db.execSQL("select round(dbms_random.value(100000,999999),0) APP_PWD from dual ");
		
		while (rsRd.next()){
		  OTP=rsRd.getString(1);
		}
		rsRd.close();
 
String SmsText="PMEGP MMClaimuser  Your Credential for  OTP is "+OTP+" and Password is as earlier - KVIC";




 //out.print(SmsText);
 
 
	 SMSServices sms1=new SMSServices();

	
			try {
 	
	String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",BEN_CONTACT2_MOB,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007767720108823736");
	
	//String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",BEN_CONTACT2_MOB,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007691521385364161");
	
	//sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",BEN_CONTACT2_MOB,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007691521385364161");
}catch (Exception e) {}


		
	StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" INSERT INTO PMEGP_PASS_OTP ( TRID,");
						qryUpdate.append("USERID,");				
						qryUpdate.append("MOB_NO,");
						qryUpdate.append("OTP,VALID_YN,TIMESTAMP ) VALUES (?,?,?,?,'N',SYSDATE) ");
						
						values.add (TRID);pstm.add ("S");
						values.add (BEN_CD);pstm.add ("S");
						
						values.add (BEN_CONTACT2_MOB);pstm.add ("S");
		                values.add (OTP);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
						values.clear();	
						//db.close();
						//response.sendRedirect("A.jsp");
						
		
		 StringBuffer qryOtp = new StringBuffer();
         qryOtp.append(" SELECT A.OTP,A.TIMESTAMP FROM PMEGP_PASS_OTP A WHERE A.TRID="+TRID+" AND A.USERID="+BEN_CD+"  ");	
		 

        ResultSet rsApp = db.execSQL(qryOtp.toString());
      

        while (rsApp.next()){
		OTP=rsApp.getString("OTP")==null?"":rsApp.getString("OTP");
	 
	 }
		
		
	
	 msgStr="OTP has been successfully sent to your mobile no ending with ("+CONTACT_NO+")";
	//}
	//else{
	// msgStr="One Active session is already going on......";
	 //session.setAttribute("SmsgStr",msgStr);
	 //response.sendRedirect("resetPass.jsp");
	//}
	 
	 
	 
	 }
	 
	 else {
	  msgStr="No Data found Please verify Your Mobile No.";
	   session.setAttribute("SmsgStr",msgStr);
	// response.sendRedirect("ArtOtpMsg.jsp");
	 }
	 
	
	 	
	}

	
	
	if (ins.equals("V")) {
		 OTP = request.getParameter("OTP")==null?"":(String) request.getParameter("OTP");
	 OTP_D=request.getParameter("OTP_D")==null?"":(String) request.getParameter("OTP_D");

		out.print(OTP);
		out.print(OTP_D);
		out.print(STRID);
		 StringBuffer qrytm = new StringBuffer();
         qrytm.append(" select extract(MINUTE  from (T1-T2)) hrs FROM(select  to_timestamp(to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss') t1, ");
         qrytm.append("  to_timestamp(to_char(TIMESTAMP, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss') t2 FROM PMEGP_PASS_OTP WHERE TRID="+STRID+") ");
		 
		 
		   ResultSet rsApptm = db.execSQL(qrytm.toString());
	
	 while (rsApptm.next()){
	 
	 	 HRS=rsApptm.getString("HRS")==null?"":rsApptm.getString("HRS");
		
	 }
	rsApptm.close();	
		
		int t1 = Integer.parseInt(HRS);
		
		if ((OTP.equals(OTP_D)) && (t1 <= 5)){
			
			 session.setAttribute("REQOTP",OTP);
		 response.sendRedirect("resetPass.jsp?reqid="+OTP);
			
		}
		else{
		 msgStr="ENTERED OTP IS NOT CORRECT.. PLEASE ENTER CORRECT OTP";
		  session.setAttribute("SmsgStr",msgStr);
		}
		
		  //msgStr="You Can Now update Artisan Data";
		  //session.setAttribute("SmsgStr",msgStr);
	
		  
	
	
		
	}
	
	
	
	
	
	
	
	
%>
<jsp:include page="includeHeadercomm.jsp"/>

<br/>



<table align="center" width="100%">
  <tr>
    <td colspan="2">    </td>
  </tr>

  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel">
      <h2>
        <input name="ins" type="hidden" id="ins" value="">
       PMEGP PASSWORD RESET OTP </h2>
    </div></th>
    </tr>  
	<% if (ins.equals("")) { %>
  <tr>
    <th ><div align="right">Registered Mobile No :</div></th>
    <td ><input name="BEN_CONTACT2_MOB" type="text" id="BEN_CONTACT2_MOB" tabindex="2" maxlength="10" autocomplete="off" >
	</td>
    </tr>
	<% }%>
		
	<% if ((!ins.equals(""))  && (count>0)) {%>
	<tr>
    <th ><div align="right">Enter The OTP :</div></th>
    <td ><input name="OTP" type="text" id="OTP" tabindex="2" maxlength="10" value="" autocomplete="off" >
	<input name="OTP_D" type="HIDDEN" id="OTP_D" tabindex="2" maxlength="10" value="<%=OTP%>" autocomplete="off" >
	</td>
    </tr>
	<tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validateformSub()" value="Submit">          
        </div>      </th>
    </tr>
	<%}%>
	<% if (ins.equals("")){%>
  <tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validateform()" value="Get otp">          
        </div>      </th>
    </tr>
	<%}%>
	<tr>
  
    <td colspan="2" ><H2><div align="center" class="redLebel"><strong><%=msgStr%></strong></div></H2></td>
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

