<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<html>
<head>
<title>NSTFDC Login Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script language="javascript">
function validatePwd() {
var vusr = encodeURIComponent(document.form.usr.value);
var vpw = encodeURIComponent(document.form.pwd.value);
 if(vusr == "") {
    inlineMsg('usr','Enter User Name',2);
    return false;
  }
  
 if(vpw == "") {
    inlineMsg('pwd','Enter Password',2);
    return false;
  }
  
 document.form.submit();
  
 
}//end of function
</script>
</head>

<body>

 
<form name="form" id="form"   method="Post" >
<% 
 
 
  String msgStr="";
   
 
    String username=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
	      // username=username.toUpperCase();
		   String suser_detail="";
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	      // pw =pw.toUpperCase();
	
	if ((username.equals("nstfdcpmegp") && pw.equals("nst@2030#"))) {

	 session.setAttribute("suser_detail","NSTFDC");				
	// session.setAttribute("admin", vUsrnm);				
	 response.sendRedirect("reportHomePage.jsp");
	} else{
	// msgStr= "Login Fail........! <br><br> Please Enter Valid User Name and Password... ";
	 
	 }
 
%> 
<br/><br/><br/>
<table align="center">

  <tr>
    <td colspan="2"><center>
      <img src="../images/pmegponlineN.jpg" width="100%" />
    </center></td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
    </tr>
  <tr>
    <td colspan="2"><div align="right"><a href="../jsp/loginPage.jsp">Home</a></div></td>
    </tr>
  
  
  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel">
      <h2>Login Form for NSTFDC MIS Report </h2>
    </div></th>
    </tr>
  <tr>
    <th><div align="right">User ID:</div></th>
    <td ><input name="usr" type="text" id="usr" tabindex="1" maxlength="20" autocomplete="off"></td>
    </tr>
  <tr>
    <th ><div align="right">Password:</div></th>
    <td ><input name="pwd" type="password" id="pwd" tabindex="2" maxlength="10" autocomplete="off"></td>
    </tr>
   <tr>
    <td colspan="2" ><div align="center" class="redLebel"><%=msgStr%></div></td>
    </tr>
  <tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validatePwd()" value="Login">          
        </div>      </th>
    </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
  <tr> 
    <td colspan="2">     </td>
    </tr>
   
      <tr > 
        
    <th colspan="2" nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>

</form>
</body>
</html>
