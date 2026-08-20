<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="in.gov.mgov.SMSServices"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/jquery-customselect.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/autolist.css" />



<style type="text/css">
<!--
.style13 {font-size: 16px}
.style4 {font-size: 14px; color: #990000; }
.style1 {	padding: 2px 16px;
	background-color: #CACACA;
	color: #232121;
	font-size: 24px;
	font-weight: bold;
}
-->
</style>
</head>

<body >
		<form action="checkOTPdb.jsp" method="post">
<%String ins = request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String UPDATE= (String) session.getAttribute("UPDATE");
String SESSION_ID=(String) session.getAttribute("SESSION_ID")==null?"":(String)session.getAttribute("SESSION_ID");
String MSG=request.getParameter("MSG")==null?"":(String) request.getParameter("MSG"); 

List values=new ArrayList();
List pstm=new ArrayList();
 %>

<img src="../images/pmegponline.jpg" width="100%" height="150" >
<BR>
<BR>
<BR>
<BR>
<BR>
<%
 
String cSUSER=(String)session.getAttribute("SUSER");
String RANDOM_NO = request.getAttribute("RANDOM_NO")==null?"":(String) request.getAttribute("RANDOM_NO");
out.print(RANDOM_NO+"-RANDOM_NO");
//ins
%>
<input type="hidden" id="ins" name="ins" value="1">
<table border="1" align="center" width="50%">
  <tr>
    <th > <div align="center" class="style1" >LOGIN</div></th>
  </tr>
  <tr>
    <th > <br>
        <div>
          <div align="center">
         Enter 4 Digit OTP : 
  
   <input type="text" placeholder="OTP" required="Enter OTP" name="OTP" height="30%" autocomplete="off" maxlength="4" id="OTP" />

          </div>
        </div>
      <br />
 <div>
          <div align="center">
            <input name="submit" type="submit" class="button" value="Log in" />
          </div>
      </div></th>
  </tr>
</table>
<%if(( !MSG.equals(""))){
		%>
	<center>	<div class="error" style="width:30%" ><%= MSG %></div></center>
		
		<%
		
		}
    %>

</form>
 
</body>

</html>
