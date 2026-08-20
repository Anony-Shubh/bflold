<%@ page session="true" buffer="50kb" import="java.sql.*,java.util.*,java.io.*, pkgPmegpNew.DBCon"  %>
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
<title>PMEGP e-Tracking System Bank Change Password</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>

<script language="javascript">
function form_submit(){
var NEW_PWD=document.form.NEW_PWD.value;
var  RE_PWD=document.form.RE_PWD.value;
if(NEW_PWD == "") {
    inlineMsg("NEW_PWD","Please Enter New Password",2);
    return false;
  }
  
  if(NEW_PWD.length <8 ) {
    inlineMsg("NEW_PWD","Length Of the Password at Least 8  ",2);
    return false;
  }
  
  if(RE_PWD == "") {
    inlineMsg("RE_PWD","Please ReEnter New Password",2);
    return false;
  }
  
  
  if (NEW_PWD !=RE_PWD) {
      inlineMsg("NEW_PWD","Password Entered mismatch With Confirm Password.....",2);
    return false;
  }
  
document.form.ins.value='I'; 
document.form.submit();
return(true);
}

</script>

</head>

<body>
<form method="post" action="rsp.jsp" name="form">

 <img src="../images/pmegponlineN.jpg" width="100%">  <table align="center">
  <script language="javascript" src="../js/inlineMsgMain.js"></script>
 <%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();

 String BANK_ID=session.getAttribute("bid")==null?"":(String) session.getAttribute("bid");  
 String vlent=session.getAttribute("slent")==null?"":(String) session.getAttribute("slent"); 
 
 String BR_IFSL_CODE = BANK_ID==null?"":BANK_ID.trim();

  String err_msg ="";
  String NEW_PWD="";
  String RE_PWD="";
  String ins="";
  String OLD_PWD="";
  
  String RESETYN="";
  String BR_NAME="";
  String CONT_NO="";
  String TRANS_ACNO="";
  String BRANCH_NAME="";
  String EMAIL="";
 
if (request.getParameter("ins") != null){
		ins = (String) request.getParameter("ins");
	}else{
		ins = "";
	}


StringBuffer qrysb =new StringBuffer();

qrysb.append("   SELECT bbm.BR_IFSL_CODE,"      );
qrysb.append("     bbm.BANK_FLAG,"      );
qrysb.append("     bbm.PSSWD,"      );
qrysb.append("     bbm.RESETYN,"      );
qrysb.append("     bbm.BR_NAME,"      );
qrysb.append("     bbm.STATE,"      );
qrysb.append("     bbm.CONT_NAME,"      );
qrysb.append("     bbm.CONT_NO,"      );
qrysb.append("     bbm.TRANS_ACNO,"      );
qrysb.append("     bbm.BRANCH_NAME,"      );
qrysb.append("     bbm.EMAIL"      );
qrysb.append("   FROM bank_br_mast bbm"      );
qrysb.append("   WHERE bbm.BR_IFSL_CODE=?   "      );


     values.add (BR_IFSL_CODE);
	

		ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();


while (rsMain.next()) {

 RESETYN=rsMain.getString("RESETYN")==null?"":rsMain.getString("RESETYN");
   BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
   CONT_NO=rsMain.getString("CONT_NO")==null?"":rsMain.getString("CONT_NO");
   TRANS_ACNO=rsMain.getString("TRANS_ACNO")==null?"":rsMain.getString("TRANS_ACNO");
   BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
  EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");


}

rsMain.close();




 %>
 
 
 
    <tr >
      <td colspan="3" ><div align="center"><span class="style6"><img src="../images/pmegpetrackN.png" width="699" height="83"></span></div></td>
    </tr>
    <tr >
      <th colspan="3" ><div align="center"><h1>Password Change form </h1></div></th>
    </tr>
    <tr >
      <td colspan="3" >
          
            <div align="center">
  <input name="ins" type="hidden" id="ins" value="I">
  (* mark fields are mendotory )
  </div>
        </td>
    </tr>
    <tr >
      <td ></td>
      <th >
        IFSC Code (11 digit)</th>
      <td>
        <%= BR_IFSL_CODE %>
      </td>
    </tr>
    <tr >
      <td >&nbsp;</td>
      <th nowrap >Bank Name: </th>
      <td><%= BR_NAME %></td>
    </tr>
    <tr >
      <td >&nbsp;</td>
      <th nowrap >Branch name: </th>
      <td><%= BRANCH_NAME %></td>
    </tr>
    <tr >
      <td >&nbsp;</td>
      <th >Registered Branch eMail Id: </th>
      <td ><%= EMAIL %></td>
    </tr>
    <tr >
      <td colspan="3" class="redLebel" ><div align="center"><%= err_msg %></div></td>
    </tr>
    <tr >
      <td >(1)</td>
      <th nowrap > 
      Enter New Password*:</div></th>
      <td>
        <input name="NEW_PWD" id="NEW_PWD" type="password"  size="20" maxlength="15">
      </td>
    </tr>
    <tr >
      <td >(2)</td>
      <th >        
      Re-enter New Password*:</div></th>
      <td>
        <input name="RE_PWD" id="RE_PWD" type="password"  size="20" maxlength="15">
      </td>
    </tr>
    <tr >
      <th colspan="3" align="right" nowrap><div align="center">
        
              <input name="Button" type="button" class="button" onClick="form_submit();" value="CHANGE PASSWORD">      
      </div></th>
    </tr>
  </table>
 
</form>

</body>
</html>

<%
if (ins.equals("I")){

NEW_PWD=request.getParameter("NEW_PWD")== null?"":(String) request.getParameter("NEW_PWD").trim();
RE_PWD=request.getParameter("RE_PWD")== null?"":(String) request.getParameter("RE_PWD").trim();

StringBuffer sb= new StringBuffer();
sb.append("UPDATE  bank_br_mast SET psswd=?, timestamp=sysdate ,RESETYN='Y' WHERE BR_IFSL_CODE=?");
 values.add (NEW_PWD);
 pstm.add ("L");
  values.add (BR_IFSL_CODE);
pstm.add ("L");

db.setSqlValue(sb.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

values.clear();
  pstm.clear();
  
   values.add (BR_IFSL_CODE);
   pstm.add ("L");

db.setSqlValue("UPDATE FB_REQUESTUD_LOG SET FB_EMAIL_CONF='Y', FB_CONF_DT=SYSDATE WHERE FB_IFSC_REQ=?");
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
session.invalidate();
response.sendRedirect("index.jsp");
db.close();

}// end of if;

%>

