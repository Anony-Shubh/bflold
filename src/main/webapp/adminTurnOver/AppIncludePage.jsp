<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/dis.css">
</head>
<%
String vUserID=(String) session.getAttribute("userid")==null?"":(String)session.getAttribute("userid");

out.print(vUserID);


if (vUserID.equals("")){response.sendRedirect("index.jsp");
}
%>
<table align="center" class="pmegpTable">
  <tr>
    <td colspan="8" nowrap><div align="center">PMEGP BANK ADMIN LOGIN: MAHARASHTRA-MUMBAI-SO</div></td>
  </tr>  
  <tr>
    
    <td nowrap><div align="center"><a href="appSearchdata.jsp" class="greenButtonRound">APPLICANT SEARCH FORM</a></div></td>
	 <td nowrap><div align="center"><a href="bankjasper.jsp?REPNM=PmegpAnnual" class="greenButtonRound">DOWNLOAD</a></div></td>
      <td nowrap><div align="center"><a href="logout.jsp" class="greenButtonRound">LOGOUT</a></div></td>
  </tr>
</table>
