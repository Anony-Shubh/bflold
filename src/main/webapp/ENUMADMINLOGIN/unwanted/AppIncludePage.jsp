<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="../js/dis.js"></script>
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
    <td colspan="8" nowrap><div align="center"> ADMIN LOGIN: MAHARASHTRA-MUMBAI-CENTRAL OFFICE</div></td>
  </tr>  
  <tr>
    <td nowrap> <div align="center"><a href="home.jsp" class="greenButtonRound">HOME</a></div></td>    
    <td nowrap><div align="center"><a href="UploadView.jsp" class="greenButtonRound">UPLOAD</a></div></td>	 
      <td nowrap><div align="center"><a href="logout.jsp" class="greenButtonRound">LOGOUT</a></div></td>
  </tr>
</table>
