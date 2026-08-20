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
<title></title>
 <link rel="stylesheet" type="text/css" href="../css/dis.css">
 <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
</head>
<body>
<form>
<%@ include file="IncludeHeader.jsp" %>

<p>
  <%
  
String IFSC_CODE1=session.getAttribute("IFSC_CODE")==null?"":(String) session.getAttribute("IFSC_CODE");
String EMAIL= "";
String BRANCH_NAME="";
String WRD_PW="";
String BR_NAME="";
String TRANS_ACNO="";

try {
 DBCon db= new DBCon();
 db.connect();
  List values=new ArrayList();


   StringBuffer qry = new StringBuffer();
         qry.append(" SELECT BM.BRANCH_NAME, ");
		   qry.append(" BM.PSSWD,BM.EMAIL,BM.BR_NAME,BM.TRANS_ACNO  ");		   
			  qry.append("FROM BANK_BR_MAST BM,BU_USERMAST BU  ");
			   qry.append(" WHERE BM.N_IFSC_CODE=BU.IFSL_CODE AND BM.BR_IFSL_CODE = ?  ");
		
			  values.add(IFSC_CODE1);
		  ResultSet rsApp = db.executeSQL(qry.toString(),values);
		  values.clear();
		   while (rsApp.next()){
		BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"":rsApp.getString("BRANCH_NAME");
		WRD_PW=rsApp.getString("PSSWD")==null?"":rsApp.getString("PSSWD");
		EMAIL =rsApp.getString("EMAIL")==null?"":rsApp.getString("EMAIL");
		BR_NAME=rsApp.getString("EMAIL")==null?"":rsApp.getString("EMAIL");
		TRANS_ACNO=rsApp.getString("EMAIL")==null?"":rsApp.getString("EMAIL");
		   }
		 rsApp.close();
		db.close();
		String subj="Confirmation of Bank registration in PMEGP e-portal...reg.";

       StringBuffer msgboxy= new StringBuffer();

      msgboxy.append("<html><head>");
     msgboxy.append( "<style>#rcorners1{border-radius: 25px;border: 10px solid #E0E0E0 ;padding: 20px;width:500px;height:650px;}" );
    msgboxy.append( "</style></head><body>");
   msgboxy.append( "<div id=");
    msgboxy.append( "rcorners1");
   msgboxy.append( "><br/><br/>");
    msgboxy.append( "<div align = left>");
	msgboxy.append( "<center> <Strong>KHADI AND VILLAGE INDUSTRIES COMMISSION, <br> PRIME MINISTER'S EMPLOYMENT GENERATION PROGRAMME (PMEGP) <br> email: pmegpeportal@kvic.gov.in </strong></center><br><br>");
     msgboxy.append( " <b>To,</b><br/></b>Branch Manager,</b><br/>"+BR_NAME+"<br>"+BRANCH_NAME+",</b><br/><strong>"+IFSC_CODE1+"</strong><br>");
    msgboxy.append( "</div><div align = left><b><br/>Sub:  Confirmation of registration in PMEGP e-portal");
     msgboxy.append( "</div><div align = left><br/>");
     msgboxy.append( "Sir</div><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As per your Registered e-mail ID: <u>"+EMAIL+" </u> , it is to inform you ");
     msgboxy.append( "that your Bank Branch has been successfully registered in PMEGP e-portal.<br/><br/>");
     msgboxy.append( " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your User ID will be your IFS CODE  (in capital letter) of your branch  ");
     msgboxy.append( "and One Time Password is <b><u>"+WRD_PW+"</u></b><br/><br/>");
    msgboxy.append( "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Kindly visit <a href=");
      msgboxy.append(  "http://www.kviconline.gov.in/pmegpeportal");
     msgboxy.append(">PMEGP e-portal </a>(kviconline.gov.in/pmegpeportal) and ");
    msgboxy.append( "follow the following procedure to update the sanction, disbursement, claim etc.under PMEGP scheme.<br/><br/>");
    msgboxy.append( "<strong>Steps :-</strong>");
   msgboxy.append( "<ul style=list-style-type:square>");
   msgboxy.append( " <li>Click on bank login link.</li>");
    msgboxy.append( "<li>On first login you need to change your password.</li>");
     msgboxy.append( " <li>Please confirm the transient Ac no <strong> <u> "+TRANS_ACNO+" </u></strong> as mentioned in your mail ID.</li>");
     msgboxy.append(  "<li>Incase of any discrepancy the same may be immediately communicated to our email pmegpeportal@kvic.gov.in</li>");
     msgboxy.append(	"</ul><br/><br/><br/><br/>");
    msgboxy.append(  "<div align = center>");
    msgboxy.append(    "<i><font color=grey> This is system generated mail hence,no signature is required.</i></font>");
     msgboxy.append(    "</div> </div> </body> <html>");
		  Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		Session session1 = (Session) envCtx.lookup("ditmail/Session");
		
		Message message = new MimeMessage(session1);
		message.setFrom(new InternetAddress("dit.kvic@gov.in"));
		InternetAddress to[] = new InternetAddress[1];
		to[0] = new InternetAddress(EMAIL);
		message.setRecipients(Message.RecipientType.TO, to);
		message.setSubject(subj);
		message.setContent(msgboxy.toString(), "text/html");
		Transport.send(message);
		}catch (Exception m) {
		out.print (m.toString());
		}
%>
  
</p>
<p>&nbsp;</p>
<table align="center" class="pmegpTable">
  <tr>
    <td colspan="2" scope="row"><div align="center" class="success">Following User name and Password has been sent to your branch email id:<%= EMAIL %> </div></td>
  </tr>
  <tr>
    <td colspan="2" scope="row">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" nowrap scope="row"><div align="center" class="mtextarea">( if Your branch Reported not received any email, kindly communicate the same to your branch)</div></td>
  </tr>
  <tr>
    <td colspan="2" scope="row"><div align="center">BANK NAME<%= BR_NAME %></div></td>
  </tr>
  <tr>
    <td colspan="2" scope="row"><div align="center"><h1>FINANCING BRANCH NAME :<%= BRANCH_NAME %> </h1></div></td>
  </tr>
  <tr class="mtextarea">
    <th scope="row"><div align="right">User ID (IFS Code of the Branch): </div></th>
    <th><%= IFSC_CODE1 %></th>
  </tr>
  <tr class="mtextarea">
    <th scope="row"><div align="right">Password:</div></th>
    <th><%= WRD_PW%></th>
  </tr>
</table>
<p>&nbsp; </p>
</form>
</body>
</html>