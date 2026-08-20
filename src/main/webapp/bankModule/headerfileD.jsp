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
  String vAssign=(String) session.getAttribute("assign")==null?"":(String)session.getAttribute("assign");
    String vBranch=(String) session.getAttribute("BRANCH_NAME")==null?"":(String)session.getAttribute("BRANCH_NAME");
	  String vBank_nm=(String) session.getAttribute("BR_NAME")==null?"":(String)session.getAttribute("BR_NAME");
 // out.print(bank_id);
 //  out.print(vAssign);
  if (bank_id==null){
  response.sendRedirect("index.jsp");
  }
  %>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<style type="text/css">
<!--
.style11 {color: #FF0000}
-->
</style>
<style type="text/css">
<!--
.style10 {font-size: 12px}
-->
</style>
<div align="left"><img src="../images/pmegponlineN.jpg" align="middle" width="100%"></div>
<table width="100%"  border="1" align="left" cellpadding="3" cellspacing="3" bordercolor="#FF3300" bgcolor="#D6C0D6">
  <tr bordercolor="#000000"  bgcolor="#a2914d">
    <td bgcolor="#CFC59A"><div align="center"> <a href="BankHomePage.jsp" target="_parent" class="greenButtonRound">Home</a></div></td>

  
     <td bgcolor="#CFC59A" ><div align="center"> <a href="bankApplicationView.jsp" target="_parent"  class="greenButtonRound">Application Detail </a></div></td>
     <td bgcolor="#CFC59A" ><a href="rspchangeuser.jsp" class="marunRound">Change Password</a></td>
	 <td bgcolor="#CFC59A" ><a href="pvidCard.jsp" class="greenButtonRound">PV ID card</a></td>
    <td bgcolor="#CFC59A" ><div align="center" ><a href="#"  class="greenButtonRound">Reports</a></div></td>
	<td bgcolor="#CFC59A" ><div align="center" ><a href="bankApplicationViewSecond.jsp"  class="greenButtonRound">Second Loan Detail</a></div></td>
	<td bgcolor="#CFC59A" ><div align="center" ><a href="BankPv.jsp"  class="marunRound">MM Adjustment</a></div></td>
	<td bgcolor="#CFC59A" ><div align="center" ><a href="logout.jsp" target="_parent" class="greenButtonRound">logout</a></div></td>
    
    <td bgcolor="#CFC59A" ><div align="center" ><a href="bankUsermanual.jsp" target="_blank" class="greenButtonRound" >User Manual/Notification</a></div></td>
    <td bgcolor="#CFC59A" ><a href="bankWiseReport.jsp" class="greenButtonRound">MM Claim Status</a> </td>
	<td bgcolor="#CFC59A" ><a href="PVBankform_pmegp.pdf" class="marunRound">PV  Bank Form</a></td>
	<td colspan="2" bgcolor="#CFC59A" ><a href="bankWiseReportSecond.jsp" class="greenButtonRound">MM Claim Status For IInd Loan</a> </td>
	<td colspan="2" bgcolor="#CFC59A" ><a href="openGrivences.jsp" class="marunRound">Grivences</a> </td>
  </tr>
  <tr bordercolor="#000000">
    <td nowrap="nowrap" ><div align="center">Bank Name </div></td>
    <td colspan="3"><span class="redLebel"><%=vBank_nm%></span></td>
    <td nowrap="nowrap"><div align="center">IFS Code </div></td>
    <td colspan="2"><span class="redLebel"><%=bank_id%></span></td>
    <td nowrap="nowrap"><div align="center">Branch:</div></td>
    <td colspan="4"><span class="redLebel"><%=vBranch%></span></td>
  </tr>
</table>
<MARQUEE width="100%" direction="left" vspace="8px">
<span class="style11"><h3>Please read the new notifications</h3></span>
</MARQUEE>
