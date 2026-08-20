<%@ page session="true" import="java.sql.*,java.util.*,java.io.*, pkgPmegpNew.DBCon,javax.naming.*,javax.mail.*,javax.mail.internet.*,javax.activation.*"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<title>pmegpeportal Financing Branch</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><style type="text/css">
<!--
body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size:20px;
	font-weight:bold;
	
}
-->
</style></head>

<body>
<img src="../images/pmegponlineN.jpg" width="100%">
<form  method="post"  name="form" id="form">

<p>
  <input name="ins" id="ins" type="hidden" value="">
</p>
<p align="center">&nbsp;</p>
<table width="100%"  border="1">
  <tr>
    <th colspan="2"><div align="center">Registration Confirmation Message... </div></th>
    </tr>
  <tr>
    <th><div align="right"><a href="getpmegppwdConfirm.jsp" class="marunRound">Back</a></div></th>
    <th><a href="index.jsp" class="greenButtonRound">Login Page </a></th>
  </tr>
</table>

<p>  
  <%
  String succmsg="";
String infomsg="";
String errmsg="";
  
  try {
DBCon db= new DBCon();
db.connect();
  String BR_IFSL_CODE = (String) session.getAttribute("bid");
String BR_NAME =(String)session.getAttribute("brname");
String lent=(String) session.getAttribute("lent");
String vemail=(String) session.getAttribute("semail");
//out.print("lent:"+lent);
out.print ("IFS Code:"+BR_IFSL_CODE);

String subj="PMEGP ePortal  User Detail of Financing Branch ";
if (!BR_IFSL_CODE.equals(null)) {
StringBuffer msgboxy= new StringBuffer();

msgboxy.append("<html><head>");
     msgboxy.append( "<style>#rcorners1{border-radius: 25px;border: 10px solid #E0E0E0 ;padding: 20px;width:500px;height:650px;}" );
    msgboxy.append( "</style></head><body>");
   msgboxy.append( "<div id=");
    msgboxy.append( "rcorners1");
   msgboxy.append( "><br/><br/>");
    msgboxy.append( "<div align = left>");
	msgboxy.append( "<center> <Strong>KHADI AND VILLAGE INDUSTRIES COMMISSION, <br> PRIME MINISTER'S EMPLOYMENT GENERATION PROGRAMME (PMEGP) <br> email: pmegpeportal.kvic@gov.in </strong></center><br><br>");
     msgboxy.append( " <b></b><br/></b>To initiate the password reset process for PMEGP e-Portal  of your Branch "+BR_NAME+",( "+BR_IFSL_CODE+") <br>");
    msgboxy.append( "</div><div align = left><b><br/>please  click the link below: <br><br><br>");
    msgboxy.append( "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=");
	
     // msgboxy.append(  "http://www.kviconline.gov.in/pmegpeportal/rsps.jsp?lent="+lent+" ");
    // msgboxy.append(">Click here to Reset your Branch User Detail </a>  ");
     msgboxy.append(" http://www.kviconline.gov.in/pmegpeportal/rsps.jsp?lent="+lent+" ");
     msgboxy.append(" >Click here to Reset your Branch User Detail </a> <br><br> ");
	 
	  msgboxy.append(" If clicking the link above does not work, please copy and paste the URL in a new browser window instead.<br><br> ");
 msgboxy.append(" &nbsp;&nbsp;&nbsp; If you have received this mail in error, it is likely that another user entered your email address by mistake ");
 msgboxy.append(" while trying to reset a password. If you did not initiate the request, you do not need ");
 msgboxy.append(" to take any further action and can safely disregard this email.");
 msgboxy.append(" This is a post-only mailing. Replies to this message are not monitored or answered.");
     msgboxy.append(    " </body> <html>");
	 
Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
Session session1 = (Session) envCtx.lookup("ditmail/Session");
Message message = new MimeMessage(session1);
message.setFrom(new InternetAddress("dit.kvic@gov.in"));
InternetAddress to[] = new InternetAddress[1];
to[0] = new InternetAddress(vemail);
message.setRecipients(Message.RecipientType.TO, to);
message.setSubject(subj);
message.setContent(msgboxy.toString(), "text/html");
Transport.send(message);
succmsg="User Details has been Sucessfully send to your Registered Email ID:  "+vemail;
}else {
infomsg="User Details has already been Sucessfully send to your Registered Email ID <br><br> technical assistance send email to <br> pmegpeportal.kvic@gov.in <br> with IFS Code, Branch Name, State, Contact Person Name, Designation and Contact No. ";
}//end of if.....
}catch (Exception m){
//out.print(m.toString());

errmsg="Please verify your Registered branch email id  ........<br><br> ( For technical assistance send email to  pmegpeportal.kvic@gov.in  with IFS Code, Branch Name, State, Contact Person Name, Designation and Contact No.)";

}

%>
<p></p>
<p></p>
<p></p>

 
 <% if (!succmsg.equals("")) {%>
<div class="success">
<%=succmsg  %>
 </div>
<%}%>

<% if (!infomsg.equals("")) {%>
<div class="info">
<%=infomsg  %>
 </div>
<%}%>

<% if (!errmsg.equals("")) {%>
<div class="error">
<%=errmsg  %>
 </div>
<%}%>

<%

if (!session.equals(null)){
//session.invalidate();
}

%>


</form>
</body>
</html>









