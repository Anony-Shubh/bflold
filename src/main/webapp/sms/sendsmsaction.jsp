<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>



<%

//String MOB_NO1="9987402341";
String MOB_NO1="9907802584";
//String sms_string="Your OTP for PMEGP Application Form of Final Authentication is : 123456 Regards, KVIC";

String sms_string="Your OTP for Login is 123456. This OTP is valid for 15 minutes. Regards, KVIC";
 

 SMSServices sms1=new SMSServices();
	      String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007090325177036429");	
	
 out.print(smsresponse);
%>	 

