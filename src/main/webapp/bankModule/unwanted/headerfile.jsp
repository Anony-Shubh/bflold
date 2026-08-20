<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<style type="text/css">
<!--
.style9 {color: #E7FFFF}
-->
</style>
<div align="left"><img src="../images/pmegponlineN.jpg" align="middle" width="100%">
  
</div>
<div align="center"></div>
<table width="100%"  border="1" align="left" cellpadding="3" cellspacing="3" bordercolor="#FF3300" bgcolor="#D6C0D6">
  <tr bordercolor="#000000"  bgcolor="#a2914d">
    <td bgcolor="#CFC59A"><div align="center"> <a href="NBMENUPAGE.jsp" target="_parent" class="greenButtonRound">Home</a></div></td>
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
  
  if (bank_id==null){
  response.sendRedirect("index.jsp");
  }
  %>
  
     <td bgcolor="#CFC59A" ><div align="center"> <a href="bankApplicationView.jsp" target="_parent"  class="greenButtonRound">Application Detail </a></div></td>
    <td bgcolor="#CFC59A" ><div align="center" ><a href="bankStatusWiseReportForm.jsp" target="_parent" class="greenButtonRound">Reports</a></div></td>
	<td bgcolor="#CFC59A" ><div align="center" ><a href="logout.jsp" target="_parent" class="greenButtonRound">logout</a></div></td>
    
    <td bgcolor="#CFC59A" ><div align="center" ><a href="usermanual%20for%20union%20bank%20-%20for%20merge.doc" class="greenButtonRound">User Manual</a> </div></td>
  </tr>
</table>

