<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Change Password</title>
<link rel="stylesheet" type="text/css" href="main1.css" />
<script type="text/javascript" src="../js/inlinemsg.js"></script>

<script language="javascript">
function checkPass()
{
    //Store the password field objects into variables ...
    var pass1 = document.getElementById('pass1');
    var pass2 = document.getElementById('pass2');
    //Store the Confimation Message Object ...
    var message = document.getElementById('confirmMessage');
    //Set the colors we will be using ...
    var goodColor = "#66cc66";
    var badColor = "#ff6666";
    //Compare the values in the password field 
    //and the confirmation field
    if(pass1.value == pass2.value){
        //The passwords match. 
        //Set the color to the good color and inform
        //the user that they have entered the correct password 
        message.innerHTML = "Passwords Match!"
    }else{
        //The passwords do not match.
        //Set the color to the bad color and
        //notify the user.
        message.innerHTML = "Passwords Do Not Match!"
    }
}  


function submit_update(){
    var BNF_PWD = document.getElementById('BNF_PWD').value;
    var OLDPASSWORD = document.getElementById('OLDPASSWORD').value;
	var pass1 = document.getElementById('pass1').value;
    var pass2 = document.getElementById('pass2').value;

//alert(pass1);




if(OLDPASSWORD == BNF_PWD){

}else{
    inlineMsg('OLDPASSWORD','Old Password Does Not Match..',2);
    return false;
}

var passw=  /^[A-Za-z]\w{7,12}$/;  
if(pass1.match(passw))   
{   
}
else  
{   
    inlineMsg('pass1','Password should contain [8 to 12 characters which contain at least one numeric digit]',2);
    return false;

}  

if(pass1 == pass2){
}else{
    inlineMsg('pass2','New Password and confirm Password Does Not Match!',2);
    return false;
}
document.form.ins.value='I';
document.form.submit();

//window.parent.refreshpage();
}
</script>
<style type="text/css">
<!--
.style2 {color: #0000FF}
.style3 {color: #990000}
.style4 {color: #FF0000}
-->
</style>
</head>

<body>
  <%@ include file = "sessionoutinc.jsp" %>

<%
//String BASEID = SBASEID;
String OFF_CD = SOFF_CD;
String OFF_NAME1 = "";
String BNF_USERID = "";
String BNF_PWD = "";
//String KINAME = "";
String OLDPASSWORD="";
//String USER_NAME = "";
String NEWPASSWORD="";
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();	

StringBuffer qrysb= new StringBuffer();


qrysb.append("SELECT BOM.OFF_CD, BOM.OFF_NAME1, BOM.BNF_USERID, BOM.BNF_PWD FROM BNF_OFF_MAST BOM WHERE BOM.OFF_CD=?");

values.add (OFF_CD); 


 
 ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();	
		
		while (rsMain.next()){
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
BNF_USERID=rsMain.getString("BNF_USERID")==null?"":rsMain.getString("BNF_USERID");
BNF_PWD=rsMain.getString("BNF_PWD")==null?"":rsMain.getString("BNF_PWD");

}
		rsMain.close();
%>
<form method="post" name="form" id="form">
<br />
<br />
<table width="50%" border="1" align="center" id="customers2">
  <tr>
    <th colspan="2"><div align="center">Change Password for<br/>
    <%=OFF_NAME1%></div></th>
  </tr>
  <tr>
    <th colspan="2"><div align="center">(*) Required fields are mandatory</div></th>
    </tr>
  <tr>
    <td><div align="left">User Name </div></td>
    <td>
      <div align="left">
        <input name="BNF_USERID" type="text" value="<%=BNF_USERID%>" maxlength="12" readonly="true"  autocomplete="off">
		<input name="BNF_PWD" id="BNF_PWD" type="HIDDEN" value="<%=BNF_PWD%>"  >
        </div></td>
  </tr>
  <tr>
    <td><div align="left">Old Password <span class="style3">*</span></div></td>
    <td>
        <div align="left">
          <input name="OLDPASSWORD" style="background-color:#B1FF7D" type="password" value="" id="OLDPASSWORD" maxlength="12" autocomplete="off"/>
          </div></td>
  </tr>
  <tr>
    <td><div align="left">New Password <span class="style3">*</span></div></td>
    <td> <div align="left">
      <input name="NEWPASSWORD" type="password" id="pass1" maxlength="12" autocomplete="off">
    </div></td>
  </tr>
  <tr>
    <td><div align="left">Confirm Password<span class="style3"> *</span></div></td>
    <td><div align="left">
      <input name="pass2" type="password" id="pass2" onkeyup="checkPass(); return false;" maxlength="12" autocomplete="off">
      <span id="confirmMessage" class="confirmMessage"></span></div></td>
  </tr>
  

  <tr>
    <td colspan="2"><div align="center">
      <input name="Button" type="button" class="myButton" value="Change Password" onClick="submit_update();">  
    </div></td>
  </tr>
</table>
<input name="ins" type="hidden" id="ins">
  

<%

		

 if ((String)request.getParameter("ins")!=null){

BNF_USERID=(String) request.getParameter("BNF_USERID")==null?"":(String) request.getParameter("BNF_USERID").trim();
OLDPASSWORD=(String) request.getParameter("OLDPASSWORD")==null?"":(String) request.getParameter("OLDPASSWORD").trim();
NEWPASSWORD=(String) request.getParameter("NEWPASSWORD")==null?"":(String) request.getParameter("NEWPASSWORD").trim();
NEWPASSWORD=(String) request.getParameter("NEWPASSWORD")==null?"":(String) request.getParameter("NEWPASSWORD").trim();


String msg="";

List pstm=new ArrayList();






if(OLDPASSWORD.equals(BNF_PWD))
{
 StringBuffer qryUpdate = new StringBuffer();


qryUpdate.append(" UPDATE BNF_OFF_MAST SET ");
qryUpdate.append("BNF_USERID=?,");
qryUpdate.append("BNF_PWD=? ");
qryUpdate.append("WHERE OFF_CD=? ");



values.add(BNF_USERID); pstm.add ("L");
values.add(NEWPASSWORD); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
out.print("Password changed successfully...");
} 
else {
out.print("Old Password doesn't match");
}


values.clear();
pstm.clear();
response.sendRedirect("save_password_msg.jsp");
   
   }
  
  db.close();
  
  
  %>



</form>
</body>
</html>
