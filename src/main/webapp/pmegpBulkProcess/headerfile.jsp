  <%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "max-age=60");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");

  String bank_id=(String) session.getAttribute("bank_id");
  String USER_DESC=(String) session.getAttribute("USER_DESC");
  if (bank_id==null){
  response.sendRedirect("index.jsp");
  }
  %>
<html>
<head>
   <title>PMEGP e-Tracking</title>
  

<link rel="stylesheet" type="text/css" href="../css/pmegpNewLt.css" />
<style type="text/css">
<!--
.style9 {color: #E7FFFF}
-->
</style>
</head>
<body>
<div align="left"><img src="../images/pmegponlineN.jpg" align="middle" width="100%"></div>
<table width="100%"  class="pmegpTable">
  <tr bordercolor="#000000"  bgcolor="#a2914d">
    <td bgcolor="#CFC59A"> <div align="center"><a href="bankApplicationView.jsp" target="_parent" class="greenButtonRound" >Home</a></div></td>
    <td bgcolor="#CFC59A" > <div align="center"><a href="bankApplicationView.jsp" target="_parent"  class="greenButtonRound">Application Detail </a></div></td>
    <td bgcolor="#CFC59A" ><div align="center"><a href="rspchangeuser.jsp" class="marunRound">Change Password</a></div></td>
	
    <td bgcolor="#CFC59A" ><div align="center"><a href="bankApplicationViewSecond.jsp"  class="greenButtonRound">Second Loan Detail</a></div></td>
    <td bgcolor="#CFC59A" ><div align="center"><a href="bankWiseReport.jsp" class="greenButtonRound">MM Claim Status</a> </div></td>
    <td bgcolor="#CFC59A" ><div align="center"><a href="bankWiseReportSecond.jsp" class="greenButtonRound">MM Claim Status For Second Loan</a> </div></td>
	<td bgcolor="#CFC59A" ><div align="center" ><a href="BankPv.jsp"  class="marunRound">MM Adjustment</a></div></td>
    <td bgcolor="#CFC59A" ><div align="center"><a href="pmegpbankBulkReport.jsp" target="_blank" class="greenButtonRound">Reports</a></div></td>
	 <td bgcolor="#CFC59A" ><div align="center"><a href="bankUsermanual.jsp" target="_blank" class="greenButtonRound" >User Manual and scheme guidelines</a></div></td>
    <td bgcolor="#CFC59A" ><div align="center"><a href="logout.jsp" target="_parent" class="greenButtonRound">logout</a></div></td>
  </tr>

  <tr bordercolor="#000000">
    <td colspan="9"><div align="center"><span class="redLebel"><%=USER_DESC%></span></div></td>
  </tr>
</table>
<table>
  <tr>
    <td colspan="9"><div align="center"><span class="redLebel">Physical Verification of PMEGP Units through Geo-tagging -Reg<a href="../pmegpeportaltutorialdoc/PV_through_Geotaging.pdf" target="_blank"  download>Download Circular</a></span></div></td>
  </tr>
</table>