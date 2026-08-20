<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
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

<body onload="getfrequenttab(3);check();" >
		<form action="logincheck.jsp" method="post">
<%

String ins = request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String UPDATE= (String) session.getAttribute("UPDATE");
String SESSION_ID=(String) session.getAttribute("SESSION_ID")==null?"":(String)session.getAttribute("SESSION_ID");

List values=new ArrayList();
List pstm=new ArrayList();

 %>

<img src="../pmegponline.jpg" width="100%" height="150" >
<BR>
<BR>
<BR>
<BR>
<BR>

<table border="1" align="center" width="50%">
  <tr>
    <td ><div align="center" class="mtextarea">PMEGP GEOTAGGING API</div></td>
  </tr>
  <tr>
    <td > <div align="center" class="OrangeLebel" >LOGIN</div></td>
  </tr>
  <tr>
    <th > <br>
        <div>
          <div align="center">
            <input type="text" placeholder="Username" required="Username" name="USERNAME" height="30%" autocomplete="off" maxlength="12" id="USERNAME" />
          </div>
        </div>
     	   <br>
        <div>
          <div align="center">
            <input type="password" placeholder="Password" required="Password" name="PASSWORD" height="30%" autocomplete="off" maxlength="12" id="PASSWORD" />
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
<BR>
	
  
	 <p id="error"></p>
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
  <center>  <DIV style="width:50%">    <h4 style="color: red" class="error" ><%=request.getAttribute("errorMessage") %></h4></DIV></center>
 <%   }
%>


 
</form>
 
</body>

</html>
