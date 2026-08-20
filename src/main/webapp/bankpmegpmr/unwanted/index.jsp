<%@ page import="java.sql.*,pkgPMEGP.DBCon"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");%>

<html>
<head>
<TITLE>PMEGP e-Tracking Monitoring Report </TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="css/indexr.css">
<script language="javascript" src="js/reportmr.js"></script>

<SCRIPT language=JavaScript>
function validatePwd() {
var vusr = document.form1.usr.value;
var vpw = document.form1.pwd.value;
  if (vusr == '' || vpw == '') {
    alert('username or password should not be blank');
    return false;
    }
}
</script>

<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body>
 <form name="form1"  method="Post" >
 <%
 
 String msgStr="";
   DBCon db= new DBCon();
   db.connect();
   StringBuffer sb= new StringBuffer();
   
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	
	String flag= (UserCode !=""&&pw !="")?"Y":"N";
	
	if (flag.equals("Y")) {
  sb.append(" SELECT * FROM pmegp_rep_user ").
   append(" WHERE UPPER(TRIM(user_name)) =UPPER(TRIM('"+UserCode+"')) and UPPER(TRIM(pwd))=UPPER(TRIM('"+pw+"')) AND ACT_YN='Y'");
   
    ResultSet rs = db.execSQL(sb.toString());
	
	if ( (rs.next()==false) && ( UserCode !=null )  ){
 msgStr="User Name or Password incorrect..";
    }else{ 
    session.setAttribute("suser_detail",rs.getString("user_detail"));
	 session.setAttribute("sstate_cd",rs.getString("state_nm"));
	  session.setAttribute("sagency",rs.getString("agency"));
	   session.setAttribute("szone",rs.getString("zone_nm"));
	rs.close();
	response.sendRedirect("reportHomePage.jsp");	
	}
 } //end flag if
 %>
<table align="center">
    <tr>
      <th colspan="11"><input name="imageField" type="image" src="../pmegpweb/docs/images/homepage/headdesign1.jpg" width="960" height="88" border="0"></th>
    </tr>
    <tr>
      <th colspan="11">&nbsp;</th>
    </tr>
    <tr>
      <td colspan="11"><div align="center">
        
      </div></td>
    </tr>
    <tr>
      <td colspan="11">&nbsp;</td>
    </tr>
   
  </table>

 <p>&nbsp;</p>
 <table border="0" align="center" cellpadding="10" cellspacing="0" bordercolor="#00FFFF">
   <tr>
     <td colspan="3"><input name="imageField" type="image" src="./img/c2LuZd1385728842.gif" width="835" height="48" border="0"></td>
    </tr>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><table border="3" align="center" cellpadding="1" cellspacing="2" bordercolor="#00FFFF">
       <tr>
         <th colspan="3" nowrap>Login for MSME/KVIC/KVIB/DIC</th>
       </tr>
       <tr>
         <td >User Name </td>
         <td >:</td>
         <td ><input name="usr" type="text" id="usr" tabindex="1" size="10" maxlength="10"></td>
       </tr>
       <tr>
         <td>Password</td>
         <td>:</td>
         <td><input name="pwd" type="password" id="pwd" tabindex="2" size="10" maxlength="11">
         </td>
       </tr>
       <tr>
         <td colspan="3"><div align="center"><span class="style6">
             <input name="btnLogIn" type=submit class="button" id="btnLogIn" tabindex="3" onClick="validatePwd()" value=" Login">
         </span></div></td>
       </tr>
     </table></td>
     <td>&nbsp;</td>
     <td><table border="3" align="center" cellpadding="1" cellspacing="1" bordercolor="#00FFFF">
       <tr>
         <th colspan="3">Login for Bank User </th>
       </tr>
       <tr>
         <td >User Name </td>
         <td >:</td>
         <td ><input name="usrbank" type="text" id="usrbank" tabindex="4" size="10" maxlength="10"></td>
       </tr>
       <tr>
         <td>Password</td>
         <td>:</td>
         <td><input name="pwdbank" type="password" id="pwdbank" tabindex="5" size="10" maxlength="10">
         </td>
       </tr>
       <tr>
         <td colspan="3"><div align="center"><span class="style6">
             <input name="btnLogIn" type=submit class="button" id="btnLogIn" tabindex="6" onClick="validatePwd()" value="Bank Login">
         </span></div></td>
       </tr>
     </table></td>
   </tr>
   <tr>
     <td colspan="3" nowrap><div align="center" class="style1"><%= msgStr %></div></td>
   </tr>
   <tr>
     <td colspan="3" nowrap>&nbsp;</td>
   </tr>
   <tr>
     <th colspan="3" nowrap><div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai </div></th>
    </tr>
 </table>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 </form>
</body>
</html>



