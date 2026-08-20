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

<script language="javascript">
function form_submit(){
document.form1.ins.value='I'; 
document.form1.submit();
return(true);
}

</script>

</head>

<body>
<form method="post" action="BANKCHANGEPW.jsp" name="form1">

 <img src="../images/pmegponlineN.jpg" width="100%">  <table align="center">
  
 <%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();

 String BANK_ID=session.getAttribute("bank_id")==null?"":(String) session.getAttribute("bank_id");  
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
qrysb.append("   WHERE bbm.BR_IFSL_CODE=?"      );


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
  <input name="ins" type="hidden" id="ins">
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
      <td >&nbsp;</td>
      <th >Transient A/c No. of Your Branch: </th>
      <td ><%= TRANS_ACNO %></td>
    </tr>
    <tr >
      <td colspan="3" ><div align="center" class="GreenLebel">Password Change Confirmation will be Sent to Your Registered eMail ID </div></td>
    </tr>
    <tr >
      <td colspan="3" class="redLebel" ><div align="center"><%= err_msg %></div></td>
    </tr>
    <tr >
      <td >(1)</td>
      <th nowrap > 
      Enter New Password*:</div></th>
      <td>
        <input name="NEW_PWD" type="password" id="NEW_PWD" size="15" maxlength="10">
      </td>
    </tr>
    <tr >
      <td >(2)</td>
      <th >        
      Re-enter New Password*:</div></th>
      <td>
        <input name="RE_PWD" type="password" id="RE_PWD" size="15" maxlength="10">
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
sb.append("UPDATE  bank_br_mast SET psswd=?, timestamp=sysdate WHERE BR_IFSL_CODE=?");
 values.add (NEW_PWD);
 pstm.add ("L");
  values.add (BR_IFSL_CODE);
pstm.add ("L");

db.setSqlValue(sb.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

values.clear();
  pstm.clear();
db.close();
response.sendRedirect("bankApplicationView.jsp");


}// end of if;

%>
