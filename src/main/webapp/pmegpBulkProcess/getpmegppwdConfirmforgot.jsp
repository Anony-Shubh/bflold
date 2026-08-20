<%@ page session="true" buffer="50kb" import="java.sql.*,java.util.*,java.io.*, pkgPmegpNew.DBCon,java.security.SecureRandom"  %>
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
<title>PMEGP ePortal Get User Detail</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>

<script language="javascript">
function form_submit(){
var IFSC=document.form.IFSC.value;
var  EMAIL=document.form.EMAIL.value;
var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
var IFSCRegex=/[A-Z|a-z]{4}[0][a-zA-Z0-9]{6}$/;

if(IFSC == "") {
    inlineMsg("IFSC","Please Enter Branch IFS Code",2);
    return false;
  }
   if(IFSC.length !=11 ) {
    inlineMsg("IFSC","IFS Code length should be 11 ( Entered Code Length is: "+IFSC.length+" )",2);
    return false;
  }
  /*
   if(!IFSC.match(IFSCRegex) && !IFSC == "") {
    inlineMsg('IFSC','<strong>Invalid IFS Code</strong><br /> <br /> Entered Valid IFS Code of your Branch',2);
    return false;
  }
  */
 
  
  if(EMAIL == "") {
    inlineMsg("EMAIL","Enter Registered Email ID of Your Branch.",2);
    return false;
  }
  
  
  
  
   if(!EMAIL.match(emailRegex) && !EMAIL == "") {
    inlineMsg('EMAIL','<strong>Invalid e_Mail</strong><br /> Entered Valid Registered Branch email ID',2);
    return false;
  }
document.form.ins.value='I'; 
document.form.submit();
return(true);
}

</script>

<style type="text/css">
<!--
.style1 {font-size: 18px}
-->
</style>
</head>

<body>
<form method="post"  name="form" action="getpmegppwdConfirm.jsp">

 <img src="../images/pmegponlineN.jpg" width="100%">   <table align="center" class="pmegpTable">
 <%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();


  String err_msg ="";
  String IFSC="";
  String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
 String EMAIL="";


 IFSC=request.getParameter("IFSC")==null?"":(String) request.getParameter("IFSC");
 EMAIL=request.getParameter("EMAIL")== null?"":(String) request.getParameter("EMAIL").trim();

  String OLD_PWD="";
  
  String RESETYN="";
  String BR_NAME="";
  String CONT_NO="";
  String TRANS_ACNO="";
  String BRANCH_NAME="";
 
String Msg="";
StringBuffer qrysb =new StringBuffer();

qrysb.append("  select IFSL_CODE AS BR_IFSL_CODE,   USER_NM AS BRANCH_NAME,   USER_DESC AS BR_NAME,NOD_CONTNO1 AS CONT_NO,   NOD_EMAIL1 AS EMAIL,PASSWD AS PSSWD "      );
qrysb.append("    from bu_usermast bbm  where  TRIM(UPPER(bbm.IFSL_CODE))=TRIM(UPPER(?)) AND TRIM(UPPER(NOD_EMAIL1)) =TRIM(UPPER(?))"      );

     values.add (IFSC); 
	  values.add (EMAIL); 
	
		ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();
		
		

String senmail ="N";
String BR_IFSL_CODE="";

while (rsMain.next()) {
   BR_IFSL_CODE=BR_NAME=rsMain.getString("BR_IFSL_CODE")==null?"":rsMain.getString("BR_IFSL_CODE");
   BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
   BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
  EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
 senmail ="Y"; 
 
}
 rsMain.close();

try {

if (ins.equals("I")){


 
String IP_ADDR_CLIENT ="";


IP_ADDR_CLIENT=request.getHeader("X-FORWARDED-FOR");

if (IP_ADDR_CLIENT == null) {
	   IP_ADDR_CLIENT = request.getRemoteAddr();
}


String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
 SecureRandom rnd = new SecureRandom();
  int len=15;
   StringBuilder sbrnd = new StringBuilder( len );
   for( int i = 0; i < len; i++ ) {
      sbrnd.append( AB.charAt( rnd.nextInt(AB.length()) ) );
      } //END OF FOR LOOP
	  
StringBuffer sb= new StringBuffer();
sb.append("INSERT INTO FB_REQUESTUD_LOG (FBREQ_ID,FB_RND_NO,FB_REQ_EMAIL,FB_IFSC_REQ,DATAVALID_YN,INVALID_MSG,IP_ADDR_CLIENT) VALUES (FB_REQ_SEQ.nextval,?,?,?,?,?,?) ");
 values.add (sbrnd.toString());pstm.add ("L");
  values.add (EMAIL);pstm.add ("L");
 values.add (IFSC);pstm.add ("L");
 values.add (senmail);pstm.add ("L");
  values.add (Msg);pstm.add ("L");
    values.add (IP_ADDR_CLIENT);pstm.add ("L");



db.setSqlValue(sb.toString());
db.setValues(values,pstm);
//db.executeUpdate() ;
db.close();
values.clear();
  pstm.clear();
  
  session.setAttribute("bid",BR_IFSL_CODE);
	session.setAttribute("brname",BRANCH_NAME);
  	session.setAttribute("lent",sbrnd.toString());
	session.setAttribute("semail",EMAIL);
if (senmail.equals("Y")){;
   response.sendRedirect("rsuser.jsp");
   }else{
err_msg="Please verify your Registered branch email id  or IFS Code<br><br> ( For technical assistance send email to  pmegpeportal@kvic.gov.in  with IFS Code, Branch Name, State, Contact Person Name, Designation and Contact No.)";
   
   }
}// end of if;
}catch (Exception e) {

session.invalidate();
}
//out.print(e.toString());}
%>
 
  <tr >
      <td colspan="2" ><div align="center"><span class="style6"><img src="../images/pmegpetrackN.png" width="699" height="83"></span></div></td>
    </tr>
    <tr >
      <th colspan="2" ><div align="right"><a href="index.jsp" class="greenButtonRound">Login </a> </div></th>
    </tr>
    <tr >
      <th colspan="2" ><div align="center">
        <h1>
          <input name="ins" type="hidden" id="ins" value="I">
          Reset Password for Financing Branch </h1>
      </div></th>
    </tr>
    <tr >
      <td colspan="2" >
            <div align="center">        </div>
        </td>
    </tr>
    <tr >
      <td colspan="2" ><div align="center" class="GreenLebel"> Note: Confirmation Mail will be Sent to Your Registered branch eMail ID</div></td>
    </tr>
    <tr >
      <td colspan="2" >
	   <% if (!err_msg.equals("")) {%>
<div class="error">
<%=err_msg  %>
 </div>
<%}%>
	  
	  
	  </td>
    </tr>
    <tr >
      <th nowrap > 
        <div align="right">Branch IFS Code*: </div></th>
      <td>
        <input name="IFSC" id="IFSC" type="text"  size="11" maxlength="11" value="<%= IFSC %>"  autocomplete="off" title=" Enter IFS Code of Your Branch">
      </td>
    </tr>
    <tr >
      <th >        
        <div align="right">Registered branch Email*:</div></th>
      <td>
        <input name="EMAIL" type="text" id="EMAIL"  size="50" maxlength="50" value="<%= EMAIL %>" autocomplete="off" title=" Enter email ID of Your Branch which is registered in our PMEGP eportal">
      </td>
    </tr>
    <tr >
      <td colspan="2" align="right" nowrap><div align="center"><%= Msg %></div></td>
    </tr>
    <tr >
      <th colspan="2" align="right" nowrap><div align="center">
        
      </div>        <div align="center">
          <input name="Button" type="button" class="button" onClick="form_submit();" value="Reset Password" >
        </div></th>
    </tr>
    <tr >
      <td colspan="2" align="right" nowrap><div align="center" class="style1">For technical assistance send email to  pmegpeportal.kvic@gov.in  with IFS Code, Branch Name, State, Contact Person Name, Designation and Contact No.</div></td>
    </tr>
  </table>
</form>

</body>
</html>