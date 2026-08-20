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
	 // String vState=(String) session.getAttribute("STATE")==null?"":(String)session.getAttribute("STATE");
  if (bank_id==null){
  response.sendRedirect("index.jsp");
  }
  %>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<style>
    #content {
        position: relative;
    }
    #content img {
        position: absolute;
        top: 0px;
        right: 0px;
    }

.button8 {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.button6 {background-color: #008CBA;} 
</style>

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
  
   

    <td bgcolor="#CFC59A" ><div id="content"><a href="bankUsermanual.jsp" target="_blank" class="button8 button6">User Manual and Notification<div align="right"><img src="images/new-gif.gif" class="ribbon" width="50" height="30" ></div></div></a> 
	
	</td>
	
    <td bgcolor="#CFC59A" ><a href="bankWiseReport.jsp" class="greenButtonRound">MM Claim Status</a> </td>
	<td bgcolor="#CFC59A" ><a href="bankWiseReportSecond.jsp" class="greenButtonRound">MM Claim Status For Second Loan</a> </td>
	<td bgcolor="#CFC59A" ><a href="openGrivences.jsp" class="marunRound">Grivences</a> </td>
  </tr>
   <tr bordercolor="#000000">
    <td nowrap="nowrap" ><div align="center">Bank Name </div></td>
    <td colspan="3"><span class="redLebel"><%=vBank_nm%></span></td>
    <td nowrap="nowrap"><div align="center">IFS Code </div></td>
    <td colspan="2"><span class="redLebel"><%=bank_id%></span></td>
    <td nowrap="nowrap"><div align="center">Branch:</div></td>
    <td colspan="3"><span class="redLebel"><%=vBranch%></span></td>
  </tr>
  <!--<tr bordercolor="#000000">
  
    <td colspan="10"><div align="center"><span class="redLebel">(Note: Rs.500 will be Deducted as Application Fees) <a href="500_Fee_Deduct.pdf" target="_blank"  download>Download Circular</a></span></div></td>
  </tr>
  <tr>
  <td colspan="10"><div align="center"><span class="redLebel">Physical Verification of PMEGP Units through Geo-tagging -Reg<a href="../pmegpeportaltutorialdoc/PV_through_Geotaging.pdf" target="_blank"  download>Download Circular</a></span></div></td>
  </tr>-->
</table>
<MARQUEE width="100%" direction="left" vspace="8px">
<span class="style11"><h3>Please read the new notifications......For Project Cost Within 2 lakh,EDP is not Mandatory ......</h3></span>

</MARQUEE>
