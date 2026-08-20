<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
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
	   
	   try {
	rs.close();
	db.close();
	}catch (Exception e){
	rs.close();
	db.close();
	}
	   /* out.println("Session ID: " + session.getId() + "<br>");
	   out.println("User Detail from DB: " + rs.getString("user_detail") + "<br>");

	   session.setAttribute("suser_detail", rs.getString("user_detail"));

	   out.println("Session Attribute: " + session.getAttribute("suser_detail") + "<br>"); */
	response.sendRedirect("reportHomePage.jsp");	
	}
	
	try {
	rs.close();
	db.close();
	}catch (Exception e){
	rs.close();
	db.close();
	}
 } //end flag if
 %>
<table align="center">
    <tr>
      <th colspan="11"><img src="../images/pmegponlineN.jpg" width="1220" height="135"></th>
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
     <td colspan="3"><img src="../images/pmegpetrackN.png" width="699" height="83"></td>
   </tr>
   <tr>
     <td colspan="3"><div align="center">
	 <h1>
	 PMEGP PORTAL MIS REPORTING LOGIN FORM 
	 </h1>
	 </div></td>
    </tr>
   <tr>
     <td><table align="center" cellpadding="5" cellspacing="5">
       <tr>
         <th colspan="2" nowrap>Login for MSME/HO/KVIC/KVIB/DIC/COIR/LDM</th>
       </tr>
       <tr>
         <th >User Name: </th>
         <th ><div align="left">
           <input name="usr" type="text" id="usr" tabindex="1" size="15" maxlength="10">
         </div></th>
       </tr>
       <tr>
         <th>Password:</th>
         <th><div align="left">
           <input name="pwd" type="password" id="pwd" tabindex="2" size="15" maxlength="10">         
         </div></th>
       </tr>
       <tr>
         <th colspan="2"><div align="center"><span class="style6">
             <input name="btnLogIn" type=submit class="button" id="btnLogIn" tabindex="3" onClick="validatePwd()" value=" Login">
         </span></div></th>
       </tr>
     </table></td>
     <td>&nbsp;</td>
     <td><div align="center"><a href="../bankModule/index.jsp" class="brownLink">Bank Login (MIS USER) </a> </div></td>
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
 </form>
</body>
</html>



