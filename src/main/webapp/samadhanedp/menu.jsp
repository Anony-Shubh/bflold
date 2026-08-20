<!DOCTYPE html>
<HTML>
<HEAD>
<body>

<%

String vlogin =session.getAttribute("slogin")==null?"N":(String)session.getAttribute("slogin");
String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
String SOFF_NAME=session.getAttribute("SOFF_NAME")==null?"":(String)session.getAttribute("SOFF_NAME");

if (vlogin.equals("N")) {

response.sendRedirect("soutmsg.jsp");
}
%>

<br>
<center>
<table align="center" >
  
  <tr>
  <td>
    <a href="GenerateExcel.jsp?REPNM=SAMADHANEDP_SUMMARY" class="login100-form-btn" >Download Online EDP Summary    </a></td>

	<td >
	  <div align="center"></div></td>
 
   <td>
     <a href="GenerateExcel.jsp?REPNM=samadhanrev" class="login100-form-btn">Download Online EDP Applicant Detail    </a></td>
	<td>
	  <a href="logout.jsp" class="login100-form-btn">logout</a> </td>
  </tr>
</table>
</center>


