<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>



<%

try {
String SmsText=request.getParameter("smsmsg")==null?"hello":(String) request.getParameter("smsmsg");
String MOB_NO1=request.getParameter("MOB_NO1")==null?"7977242551":(String) request.getParameter("MOB_NO1");
out.print (SmsText);
out.print ("<br>");
out.print (MOB_NO1);

if (!SmsText.equals("") && !MOB_NO1.equals("")) {
	 SMSServices sms1=new SMSServices();

//sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d");
sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007353226336882857");	
out.print ("SMS Sent Successfully");
}// END IF

}catch (Exception e) {out.print(e.toString());}

%>

