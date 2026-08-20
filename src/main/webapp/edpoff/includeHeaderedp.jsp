<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<title> Pending for EDP Training </title>
<script src="../js/inlineMsgMain.js"></script>
<link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<style type="text/css">
<!--
.style1 {color: #999900}
.style2 {color: #CC9900; }
-->
</style>
</head>
<body>

<%
  String vOFF_CD= session.getAttribute("SOFF_CD")==null?"":(String) session.getAttribute("SOFF_CD");
 // out.print(vOFF_CD);
String vOFF_NAME=  session.getAttribute("SOFF_NAME")==null?"":(String) session.getAttribute("SOFF_NAME");
//out.print(vOFF_NAME);
String vOFF_TYPE_CD=  session.getAttribute("SOFF_TYPE_CD")==null?"":(String) session.getAttribute("SOFF_TYPE_CD");
try {
if (vOFF_NAME==null||vOFF_NAME.equals("")){
response.sendRedirect("index.jsp");
}
	}catch (Exception m) {}		
	
%>
<p><img src="../images/pmegponlineN.jpg" width="100%" /></p>
<p>
  <br>
</p>
<table width="100%"  border="" cellspacing="3" cellpadding="3">
  <tr> 
    <th><div align="center"><a href="edpHomePage.jsp" class="button">Home</a></div></th>
    <th><div align="center"><a href="ReserPassEdp.jsp" class="button">Reset Password</a></div></th> 
	
    <th><div align="center"><a href="edpPaidTr.jsp" class="button">Pending For Edp Training</a></div></th>
    <!-- <th><div align="center"><a href="edpUplCert.jsp" class="button">Completed EDP</a></div></th> 	-->
	<th><div align="center"><a href="Report.jsp" class="button">Report</a></div></th>
    <th><a href="logout.jsp"  class="button">Logout</a></th>
  </tr>
</table>



