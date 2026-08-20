<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
<head>

</head>

<table align="center" class="pmegpTable">
  <tr>
    <td colspan="9" nowrap><div align="center">PMEGP ADMIN LOGIN: MAHARASHTRA-MUMBAI-SO</div></td>
  </tr>  
  <tr>
    <td nowrap> <div align="center"><a href="index.jsp" class="greenButtonRound">HOME</a></div></td>    
    <td nowrap><div align="center"><a href="statewise_repo.jsp" class="greenButtonRound">STATEWISE REPORT </a></div></td>
    <td nowrap><div align="center"><a href="officewise_repo.jsp" class="greenButtonRound">DISTRICTWISE REPORT </a></div></td>
    <td nowrap><div align="center"><a href="logout.jsp" class="greenButtonRound">LOGOUT</a></div></td>
      </tr>
</table>
