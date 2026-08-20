<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<% 
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<html>
<head>
   <title>PMEGP e-Tracking</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
</head>

<body>

<img src="../images/pmegponlineN.jpg" width="100%"  >


<%
String VUSER_ID ="";
String VUSER_DETAIL ="";
String VSUSER_TYPE ="";


try {

 VUSER_ID = session.getAttribute("SUSER_ID")==null?"":(String) session.getAttribute("SUSER_ID");
 VUSER_DETAIL = session.getAttribute("SUSER_DETAIL")==null?"":(String) session.getAttribute("SUSER_DETAIL");
 VSUSER_TYPE = session.getAttribute("SUSER_TYPE")==null?"":(String) session.getAttribute("SUSER_TYPE");


if (VUSER_ID.equals("")) {
//session.invalidate();
response.sendRedirect("index.jsp");
}
}catch (Exception e){
response.sendRedirect("index.jsp");

}
%>
<table align="center" class="pmegpTable" >
  <tr>
    <td colspan="13" nowrap><div align="center">
      <h2>PMEGP Portal Central Office (User:<%= VUSER_DETAIL %>)</h2>
    </div></td>
  </tr>
  <tr>
  <td nowrap> <div align="center"><a href="mmclaimProcHomepage.jsp" target="_blank" class="greenButtonRound">Home</a></div></td>
 <%  if (VSUSER_TYPE.equals("V") ){ %>
    <td nowrap>
	  <div align="center"><a href="mmclaimProcessbysodo.jsp" class="greenButtonRound"> Pending for Process</a> </div></td>
	 <td nowrap><a href="mmclaimRefProcessbysodo.jsp" class="greenButtonRound">Ref. MM Claim </a></td>
	 <td nowrap><a href="mmclaimRetRefProcessbysodo.jsp" class="greenButtonRound">Returned </a></td>
	 <td nowrap> <a href="mmclaimProvclaim.jsp" class="greenButtonRound">MM Claim Status View </a></td>
	  <td nowrap> <a href="mmclaimProvclaimSec.jsp" class="greenButtonRound">Second Loan MM Claim Status View </a></td>
	  <td nowrap><div align="center"><a href="mmclaimSecondLoan.jsp" class="greenButtonRound">Pending for Process Second Loan</a> </div></td>
	   <td nowrap><div align="center"><a href="mmclaimRefProcessbysodoSec.jsp" class="greenButtonRound">Ref. MM Claim Second Loan</a> </div></td>
	    <td nowrap><a href="mmclaimRetRefProcessbysodoSec.jsp" class="greenButtonRound">Returned Second Loan</a></td>
	 <%  } %>
	  <%  if (VSUSER_TYPE.equals("A")) { %>
    <td nowrap> <div align="center"><a href="mmclaimPendingForApproval.jsp" class="greenButtonRound">Pending for Approval</a> </div></td>
	 <td nowrap> <div align="center"><a href="mmclaimPendingForApprovalSec.jsp" class="greenButtonRound">Pending for Approval Second Loan</a> </div></td>
	   <td nowrap><a href="mmclaimProvclaim1.jsp" class="greenButtonRound"> Approved Claims</a></td>
	    <td nowrap><a href="mmclaimProvclaim1Sec.jsp" class="greenButtonRound"> Approved Claims Second Loan</a></td>
	   
	   <%  } %>
	  <%  if (VSUSER_TYPE.equals("C") ){ %>
    <td nowrap><div align="center"><a href="appdetailmmdisb.jsp" class="greenButtonRound">Search By Application ID</a></div></td>
	 <%  } %>
    <td nowrap><a href="zonewisedwdb_claim_repo.jsp" class="greenButtonRound">Report</a></td>
	 <td nowrap><a href="zonewisedwdb_claim_repo_sec.jsp" class="greenButtonRound">Report Second Loan</a></td>
	 <td nowrap><a href="passwOtp.jsp" class="greenButtonRound">Password Reset</a></td>
    <td nowrap><div align="center"><a href="logout.jsp"  class="greenButtonRound">Logout</a></div></td>
    <td nowrap><a href="edpSearchApp.jsp" target="_self" class="greenButtonRound">EDP</a></td>
	<td nowrap><a href="mmclaimdaywisereport.jsp" class="greenButtonRound">Individual Report</a></td>
  </tr>
</table>
