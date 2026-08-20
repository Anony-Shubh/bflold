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
<title>sendEmail to EDP Training Center</title>
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
  <input name="Button" type="button" class="button" value="send eMail to EDP Center" onClick="sendEmail();">
</p>
<p>  
  <%
DBCon db= new DBCon();
db.connect();

  String OFF_CD =request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD") ;
  
String SUB_DESC = "";
String OFF_EMAIL_ADDR = "";
String OFF_TYPE_SHORT_DESC = "";
String OFF_NAME = "";
String U_NAME = "";
String P_WORD="";
String TODT="";
String CITY="";
String STATE_NM="";
String OFF_LONG_DESC="";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins") ;

StringBuffer qyrSel= new StringBuffer();
qyrSel.append(" SELECT MOM.OFF_CD,  MOM.OFF_EMAIL_ADDR,TO_CHAR(SYSDATE,'DD-MON-RRRR') AS TODT,   M.OFF_TYPE_SHORT_DESC, MOM.OFF_LONG_DESC, MOM.OFF_NAME,  MOM.U_NAME, MOM.P_WORD,  ");
qyrSel.append(" MOM.CITY, MS.STATE_NM FROM mas_off_mast MOM,  mas_off_type_cdmast M,m_district md,m_state ms WHERE MOM.OFF_TYPE_CD   = M.OFF_TYPE_CD ");
qyrSel.append(" AND MOM.OFF_TYPE_CD   IN  (26,17,18,19,28,29,30,31,32,33,34) AND mom.district_cd=md.district_cd  AND MD.STATE_cD=MS.STATE_CD  ");
qyrSel.append(" AND MOM.ACT_YN  = 'Y' AND  MOM.OFF_CD=? ");


List values=new ArrayList();
List pstm=new ArrayList();
values.add(OFF_CD);		
ResultSet rsMain = db.executeSQL(qyrSel.toString(),values);
values.clear();

 int countr=0;
  while (rsMain.next()) {
  countr = countr+1;
OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
OFF_LONG_DESC=rsMain.getString("OFF_LONG_DESC")==null?"":rsMain.getString("OFF_LONG_DESC");
OFF_TYPE_SHORT_DESC=rsMain.getString("OFF_TYPE_SHORT_DESC")==null?"":rsMain.getString("OFF_TYPE_SHORT_DESC");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
U_NAME=rsMain.getString("U_NAME")==null?"":rsMain.getString("U_NAME");
P_WORD=rsMain.getString("P_WORD")==null?"":rsMain.getString("P_WORD");
TODT=rsMain.getString("TODT")==null?"":rsMain.getString("TODT");
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
CITY=rsMain.getString("CITY")==null?"":rsMain.getString("CITY");

}
//out.print(OFF_CD);
rsMain.close();

String subj="Sub: User Name and Password for the training centres";

StringBuffer msgboxy= new StringBuffer();

     msgboxy.append("<html><head>");
     msgboxy.append( "<style>#rcorners1{border-radius: 25px;border: 10px solid #E0E0E0 ;padding: 20px;width:500px;height:750px;}" );
    msgboxy.append( "</style></head><body>");
   msgboxy.append( "<div id=");
    msgboxy.append( "rcorners1");
   msgboxy.append( "><br/><br/>");
    msgboxy.append( "<div align = left>");
	msgboxy.append( "<center> <Strong>KHADI AND VILLAGE INDUSTRIES COMMISSION, <br> 3 Irla Road, Vile Parle West, Mumbai-400056<br>Email: pmegpeportal.kvic@gov.in<br>Date:"+TODT+"<br></center><br>");
 msgboxy.append( "<div align = left>No:DIT/PMEGP/EDP/20-21</div><br>");
     msgboxy.append( " <b>To,</b><br/></b><b>"+OFF_LONG_DESC+"("+OFF_CD+")</b><br/><b>"+OFF_TYPE_SHORT_DESC+"</b><br/><b>"+CITY+"</b><br/><b>"+STATE_NM+"</b><br/>");
    msgboxy.append( "</div><div align = left><b><br/>"+subj+" ");
     msgboxy.append( "</div><div align = left><br/>");
     msgboxy.append( " Sir</div><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kindly refer to the Circular dated 16.10.2020, wherein the detailed guideline for conducting EDP training by various training centres was communicated.  The said Circular is already uploaded on the PMEGP portal for reference.<br/>  ");
	 msgboxy.append( "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In  order to access the information of the applicants, who have preferred&nbsp; EDP training from your training Institute,  and subsequently to organise the training programme the User Name and Password  in respect of your training centre are provided&nbsp;  as under:<br/> <br/>");
     msgboxy.append( " USERNAME&nbsp;&nbsp;  : "+U_NAME+" <br/>  PASSWORD&nbsp;&nbsp; : "+P_WORD+"<br/><br/>");
     msgboxy.append( "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The  password is default password.&nbsp; You may  reset your own password immediately after login to a system. The Username and  password credentials are confidential in nature and should not be shared with  anyone to avoid misuse of the same.<br/><br/> ");     
   msgboxy.append( "<div align = right> (M. RAJAN  BABU) <br/>  DY. CEO (PMEGP)</div><br/><br/>");   
    msgboxy.append(  "<div align = center>");
    msgboxy.append(    "<i><font color=grey> This is system generated mail hence,no signature is required.</i></font>");
     msgboxy.append(    "</div> </div> </body> <html>");
	  
	  if (ins.equals("I")) {
	  
   Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
Session session1 = (Session) envCtx.lookup("ditmail/Session");

Message message = new MimeMessage(session1);
message.setFrom(new InternetAddress("dit.kvic@gov.in"));
InternetAddress to[] = new InternetAddress[1];
to[0] = new InternetAddress(OFF_EMAIL_ADDR);
message.setRecipients(Message.RecipientType.TO, to);
message.setSubject(subj);
message.setContent(msgboxy.toString(), "text/html");
Transport.send(message);

values.add(OFF_CD); pstm.add ("L");
db.setSqlValue("UPDATE MAS_OFF_MAST SET SMS_YN='Y' WHERE OFF_CD=?");
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("emailSuccessMsg.jsp");

}


out.print (msgboxy.toString());



%>
 <input name="<%=OFF_CD%>" id="OFF_CD" type="hidden" value="<%=OFF_CD%>">
</form>
</body>
</html>
