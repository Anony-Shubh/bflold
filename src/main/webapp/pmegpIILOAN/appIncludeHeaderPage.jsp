<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
   <title>PMEGP e-Tracking</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>

<body>
<%
String vACT_ID= session.getAttribute("sACT_ID")==null?"":(String) session.getAttribute("sACT_ID");
String vAppid=  session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");
String vAppName=  session.getAttribute("sAPP_NAME")==null?"":(String) session.getAttribute("sAPP_NAME");

%>
<img src="../images/pmegponline.jpg" width="100%" height="150" >
<table align="center" class="pmegpTable" >
  <tr>
    <td colspan="8" nowrap><div align="center">PMEGP APPLICANT HOME PAGE </div></td>
  </tr>
  
  <tr>
  <%  if (vACT_ID.equals("-1")){ %>
  <td nowrap> <div align="center"><a href="ApplicantHomePage.jsp"  class="greenButtonRound">Home</a></div></td>
    <td nowrap><div align="center"><a href="editpmegpapplication.jsp?app_id=<%= vAppid %>&DIS=Y" class="greenButtonRound">Applicant Data Update </a></div></td>    
    <td nowrap><div align="center"><a href="upload.jsp?app_id=<%= vAppid %>&DIS=Y" class="greenButtonRound">Upload Documents </a></div></td>
    <td nowrap><div align="center"><a href="validateBeforeSubmit.jsp?app_id=<%= vAppid %>&DIS=Y"  class="greenButtonRound">Final Submission (3)</a></div></td>
	<% }else{%>
	
	    <td nowrap><div align="center"><a href="PMEGPGenAppForm.jsp?APP_ID=<%= vAppid %>" target="_blank" class="greenButtonRound">Print Application Form </a></div></td>
        <td nowrap><div align="center"><a href="upload.jsp?app_id=<%= vAppid %>&DIS=Y" class="greenButtonRound">Upload Documents(2) </a></div></td>
	<% }%>
	
    <td nowrap><div align="center"><a href="PMEGPGenAppForm.jsp?APP_ID=<%= vAppid %>&RNAME=APPSTATUSVIEWSEC"  class="greenButtonRound" target="_blank">Current Status </a></div></td>
	<td nowrap><div align="center"><a href="PmBoChk.jsp" class="marunRound">SignBoard Upload  </a></div></td>
           <td nowrap><div align="center"><a href="logout.jsp"  class="greenButtonRound">Logout/close</a></div></td>
  </tr>
</table>
<% 
if (vAppid.equals("")||vAppid.equals(null)){
%>
<jsp:forward page="applicantLogin.jsp" />
<%
}else{
out.print ("<center><h2>User Name:"+vAppName+" </h2></center>");

}
%>