<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>User Manual</title>
<%@ include file="includeHeaderPage.jsp" %>
</head>

<body>
<%
 String vstate_cd=(String)session.getAttribute("state_cd");	
String DOC_NAME =request.getParameter("APP_ID");
String ACT_YN="";
String STATE_NM = "";
String STATE_CD = "";
String EN_ID="";

  int count=0;
ResultSet  rs;




%>

<h2 align="center">&nbsp;</h2>
<p align="center">&nbsp;</p>

<p align="center" class="OrangeLebel"><h2 align="center">Report</h2> </p>
<center>
<table  border="1" align="center" cellpadding="3" cellspacing="3" class="warning">
  <tr>
    <td scope="row">(1)</td>
    <td><a href="AgnReporjasper.jsp?REPNM=AgnReport" class="greenButtonRound">download Applicant Detail</a> </td>
  </tr>
  
  
  
</table>
</center>

</body>
</html>
