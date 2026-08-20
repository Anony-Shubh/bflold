<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%@ page import="cdacuidai.VerifyAadhaarByID"%>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
   <title>PMEGP Tracking</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script src="../js/inlineMsgMain.js"></script>

</head>

<body>
<%
String vACT_ID= session.getAttribute("sACT_ID")==null?"":(String) session.getAttribute("sACT_ID");
String vAppid=  session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");
String vAppName=  session.getAttribute("sAPP_NAME")==null?"":(String) session.getAttribute("sAPP_NAME");
String vBenfType= session.getAttribute("sBENF_TYPE_DESC")==null?"":(String) session.getAttribute("sBENF_TYPE_DESC");
String ftype=vBenfType.equals("Individual")?"pmegponlineUpdate.jsp":"pmegponlineNIUpdate.jsp";






%>

<img src="../images/pmegponline.jpg" width="100%" height="150" >
<table align="center" class="pmegpTable" >
  <tr>
    <td colspan="15" nowrap><div align="center">PMEGP APPLICANT HOME PAGE </div></td>
  </tr>
 
  <tr>
  <%  if (vACT_ID.equals("-1")){ %>
  <td nowrap> <div align="center"><a href="ApplicantHomePage.jsp"  class="greenButtonRound">Home</a></div></td>
    <td nowrap><div align="center"><a href="<%= ftype %>" class="greenButtonRound">Applicant Data </a></div></td>  
	 <td nowrap><div align="center"><a href="pmegpscorecard.jsp" class="buttonBlue">Score Card </a></div></td>
	
	  <td nowrap><div align="center"><a href="upload_app_doc.jsp" class="greenButtonRound">Upload  </a></div></td>
    <td nowrap><div align="center"><a href="applicantFormValidationBeforeFinalSubmission.jsp"  class="greenButtonRound">Final Submission</a></div></td>
	<% }else{%>	
	    <td nowrap><div align="center"><a href="PMEGPGenAppForm.jsp?APP_ID=<%= vAppid %>" target="_blank" class="greenButtonRound">Print Application </a></div></td>
        <td nowrap><div align="center"><a href="upload_app_doc.jsp" class="greenButtonRound">Upload </a></div></td>	
	    <td nowrap><div align="center"><a href="pmegpscorecard.jsp" class="buttonBlue">Score Card </a></div></td>	    
	 <td nowrap><div align="center"> <a href="geoMPage.jsp" class="marunRound">MM Adjustment letter</a></div></td>
	
	<!--<td nowrap><a href="TurnMPage.jsp" class="buttonOrange ">Pmegp Turnover</a> </td>-->
	
	<td nowrap><a href="mobchng.jsp" class="greenButtonRound">Update Mobile</a> </td>
    <td nowrap><a href="pmegpFeedback.jsp" class="greenButtonRound">Feedback</a></td>
	<% }%>
	  <td nowrap><div align="center"><a href="PMEGPGenAppForm.jsp?APP_ID=<%= vAppid %>&RNAME=APPSTATUSVIEW"  class="greenButtonRound" target="_blank">Current Status </a></div></td> 
	  <td nowrap><div align="center"> <A href="BankPvformDown.jsp" target="_blank" class="buttonOrange">Download Bank Form For Physical Verification</A></DIV>
	  
	 </td>
	   <td nowrap><div align="center"><a href="edpMPage.jsp" class="buttonBlue">EDP </a></div></td>
    <td nowrap><div align="center"><a href="grivencesDetail.jsp" class="greenButtonRound">Grievance </a></div></td>
	<td nowrap><div align="center"><a href="PmBoChk.jsp" class="marunRound">SignBoard Upload  </a></div></td>
    <td nowrap><div align="center"><a href="logout.jsp"  class="greenButtonRound">Logout</a></div></td>
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
</form>
