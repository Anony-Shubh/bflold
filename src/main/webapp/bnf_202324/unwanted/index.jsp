<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>BNF HOMEPAGE</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">

</head>

<body>
<%@ include file = "sessionoutinc.jsp" %>

<center>
<br>
<br>
<h1 style="font-family:'Lucida Calligraphy'">WELCOME! <br>User Details:</h1>
  <table width="63%" height="188" align="center">
 
  <tr>
    <td width="20%"><div align="right">OFFICE CODE : </div></td>
    <td width="20%"><div align="left"><%= SOFF_CD %></div></td>
  </tr>
  <tr>
    <td><div align="right">TYPE : </div></td>
    <td><div align="left"><%= SFO_HO %></div></td>
  </tr>
  <tr>
    <td><div align="right"><span style="font-family:'Castellar'">Office Name :</span></div></td>
    <td><div align="left"><span style="font-family:'Castellar'"><%= SOFF_NAME1 %></span></div></td>
  </tr>
  <tr>
    <td><div align="right"><span style="font-family:'Castellar'">State :</span></div></td>
    <td><div align="left"><span style="font-family:'Castellar'"><%= SSTATE_NM %></span></div></td>
  </tr>
  <tr>
    <td><div align="right"><span style="font-family:'Castellar'">Zone : </span></div></td>
    <td><div align="left"><span style="font-family:'Castellar'"><%= SZONE_NM %></span></div></td>
  </tr>
</table>




<h1 style="font-family:'Castellar'">&nbsp;</h1>
<h2 hidden>&nbsp;</h2>
<h2 style="font-family:'Castellar'">&nbsp;</h2>
</center>

</body>
</html>
