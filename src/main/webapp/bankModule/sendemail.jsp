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
//response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<title>sendEmail to Financing Branch</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script language="javascript">

function sendEmail(){
document.form.ins.value="I";
document.form.submit();
}

</script>
</head>

<body>
<form  method="post"  name="form" id="form">

<p>
  <input name="ins" id="ins" type="hidden" value="">
</p>
<p align="center">
  <input name="Button" type="button" class="button" value="send eMail to Financing Branch" onClick="sendEmail();">
</p>
<p>  
  <%
DBCon db= new DBCon();
db.connect();

  String BR_IFSL_CODE =request.getParameter("SBR_IFSC_CODE")==null?"":(String) request.getParameter("SBR_IFSC_CODE") ;
String BR_NAME = "";
String BR_TYPE = "";
String BR_ADDR = "";
String DISTRICT = "";
String STATE = "";
String CONT_NAME = "";
String DESIG = "";
String CONT_NO = "";
String FAX_NO = "";
String REMARKS = "";
String PSSWD = "";
String ACT_YN = "";
String EMAIL_VALID_YN = "";
String EMAIL_VALID_DT = "";
String EMAIL = "";
String PINCODE = "";
String BRANCH_NAME = "";
String TRANS_ACNO = "";
String RESETYN="";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins") ;

StringBuffer qyrSel= new StringBuffer();
qyrSel.append(" SELECT ");
qyrSel.append("BR_IFSL_CODE,");
qyrSel.append("BR_NAME,");
qyrSel.append("BR_ADDR,");
qyrSel.append("DISTRICT,");
qyrSel.append("STATE,");
qyrSel.append("CONT_NAME,");
qyrSel.append("DESIG,");
qyrSel.append("CONT_NO,");
qyrSel.append("FAX_NO,");
qyrSel.append("PSSWD,");
qyrSel.append("EMAIL,");
qyrSel.append("PINCODE,");
qyrSel.append("BRANCH_NAME,");
qyrSel.append("TRANS_ACNO");
qyrSel.append(" FROM BANK_BR_MAST WHERE BR_IFSL_CODE=? ");

List values=new ArrayList();
List pstm=new ArrayList();
values.add(BR_IFSL_CODE);		
ResultSet rsMain = db.executeSQL(qyrSel.toString(),values);
values.clear();

 int countr=0;
  while (rsMain.next()) {
  countr = countr+1;
BR_IFSL_CODE=rsMain.getString("BR_IFSL_CODE")==null?"":rsMain.getString("BR_IFSL_CODE");
BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
PSSWD=rsMain.getString("PSSWD")==null?"":rsMain.getString("PSSWD");
TRANS_ACNO=rsMain.getString("TRANS_ACNO")==null?"":rsMain.getString("TRANS_ACNO");
}
rsMain.close();

String subj="Confirmation of Bank registration in PMEGP e-portal...reg.";

StringBuffer msgboxy= new StringBuffer();

msgboxy.append("<html><head>");
     msgboxy.append( "<style>#rcorners1{border-radius: 25px;border: 10px solid #E0E0E0 ;padding: 20px;width:500px;height:650px;}" );
    msgboxy.append( "</style></head><body>");
   msgboxy.append( "<div id=");
    msgboxy.append( "rcorners1");
   msgboxy.append( "><br/><br/>");
    msgboxy.append( "<div align = left>");
	msgboxy.append( "<center> <Strong>KHADI AND VILLAGE INDUSTRIES COMMISSION, <br> PRIME MINISTER'S EMPLOYMENT GENERATION PROGRAMME (PMEGP) <br> email: pmegpeportal.kvic@gov.in </strong></center><br><br>");
     msgboxy.append( " <b>To,</b><br/></b>Branch Manager,</b><br/>"+BR_NAME+"<br>"+BRANCH_NAME+",</b><br/><strong>"+BR_IFSL_CODE+"</strong><br>");
    msgboxy.append( "</div><div align = left><b><br/>Sub:  Confirmation of registration in PMEGP e-portal");
     msgboxy.append( "</div><div align = left><br/>");
     msgboxy.append( "Sir</div><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As per details communicated through your e-mail ID: <u>"+EMAIL+" </u> , it is to inform you ");
     msgboxy.append( "that your Bank Branch has been successfully registered in PMEGP e-portal.<br/><br/>");
     msgboxy.append( " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your User ID will be your IFS CODE  (in capital letter) of your branch  ");
     msgboxy.append( "and One Time Password is <b><u>"+PSSWD+"</u></b><br/><br/>");
    msgboxy.append( "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Kindly visit <a href=");
      msgboxy.append(  "http://www.kviconline.gov.in/pmegpeportal");
     msgboxy.append(">PMEGP e-portal </a>(kviconline.gov.in/pmegpeportal) and ");
    msgboxy.append( "follow the following procedure to update the sanction, disbursement, claim etc.under PMEGP scheme.<br/><br/>");
    msgboxy.append( "<strong>Steps :-</strong>");
   msgboxy.append( "<ul style=list-style-type:square>");
   msgboxy.append( " <li>Click on bank login link.</li>");
    msgboxy.append( "<li>On first login you need to change your password.</li>");
     msgboxy.append( " <li>Please confirm the transient Ac no <strong> <u> "+TRANS_ACNO+" </u></strong> as mentioned in your mail ID.</li>");
     msgboxy.append(  "<li>Incase of any discrepancy the same may be immediately communicated to our email pmegpeportal.kvic@gov.in</li>");
     msgboxy.append(	"</ul><br/><br/><br/><br/>");
    msgboxy.append(  "<div align = center>");
    msgboxy.append(    "<i><font color=grey> This is system generated mail hence,no signature is required.</i></font>");
     msgboxy.append(    "</div> </div> </body> <html>");
	  
	  if (ins.equals("I")) {
	  
   Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
Session session1 = (Session) envCtx.lookup("ditmail/Session");

Message message = new MimeMessage(session1);
message.setFrom(new InternetAddress("dit@kvic.gov.in"));
InternetAddress to[] = new InternetAddress[1];
to[0] = new InternetAddress("pandakvic@gmail.com");
message.setRecipients(Message.RecipientType.TO, to);
message.setSubject(subj);
message.setContent(msgboxy.toString(), "text/html");
Transport.send(message);

values.add(BR_IFSL_CODE); pstm.add ("L");

db.setSqlValue("UPDATE BANK_BR_MAST SET EMAIL_VALID_YN='Y' ,EMAIL_VALID_DT=SYSDATE,RESETYN='Y' WHERE BR_IFSL_CODE=?");
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("emailSuccessMsg.jsp");

}


out.print (msgboxy.toString());



%>
</form>
</body>
</html>
