<%@ include file="headerfile.jsp" %>
<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Bank applicant view</title>

<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/scroller/1.4.2/js/dataTables.scroller.min.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="https://cdn.datatables.net/scroller/1.4.2/css/scroller.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>

<style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {color: #FF0000}
.style3 {
	color: #000000;
	font-weight: bold;
}
.style4 {font-size: medium}
.style5 {
	color: #FF0000;
	font-size: medium;
	font-weight: bold;
}
-->
</style>
<script>
$(document).ready(function() {
    $('#example').DataTable( {
		
       "ajax": "jsonBankDataSec.jsp",      
       
		
		
		"columns":
		[
		{ "data": "APP ID" },
            { "data": "APP NAME" },
			{ "data": "IFSCODE" },
			{ "data": "BRANCHNAME" },			
			{ "data": "BANK F DATE" },
			{ "data": "DOCUMENTS" },
			{ "data": "STATUS" },			
			{ "data": "CLAIM" },
			{ "data": "AMOUNT" },
			{ "data": "LOAN" },
			{ "data": "DOWNLOAD" },
			{ "data": "APPLICANT DATA" },	
	   
		 ],
		
         deferRender:    true,
        scrollX:        true,
        scrollY:        400,
        scrollCollapse: true,
        scroller:       true,
        searching:      true,
        paging:         true,
        info:           false
		
    } );
} );
</script>
</head>

<body>
<form action="bankApplicationViewSecond.jsp" method="post" name="form1" id="form1">


<table border="2" align="center"  class="pmegpTable" >
  <tr>
    <td colspan="12" align="left"><div align="center"><img src="../images/pmegpetrackN.png" width="auto" height="43" /></div></td>
  </tr>
  <tr>
    <td colspan="12" align="left"><div align="center">For Technical Assistance contact ( Information Technology, KVIC, Mumbai) #022-26712087, and send email to<span class="OrangeLebel"><em><bold> pmegpeportal.kvic@gov.in </bold> </em></span>from your branch email id,</div></td>
  </tr>
  <tr>
    <th colspan="12" align="left"><div align="center">For MM Claim status (PMEGP,MUMBI) contact No: # 022-26713686 and send email to<span class="OrangeLebel"><em><bold> regpkvic@gmail.com</bold> </em></span></div></th>
  </tr>
  <tr>
    <th colspan="12" align="left"> <div align="center">for Govt. Subsidy Release ( Corp. Bank) queries contact :022-22833391 ( cb0511@corpbank.co.in) </div></th>
  </tr>
  <tr>
    <th colspan="12" align="left"><div align="center">Applicant data Search and Update form </div></th>
  </tr>
  <tr>
    <td colspan="12" align="left" class="redLebel">Note: After  Margin Money (Govt. Subsidy) Claimed Data Cannot be Updated.......... </td>
  </tr> 
</table>  
 <table align="center" cellspacing="0" class="display" id="example">
        <thead>
  <tr >
     <th nowrap><div align="center">Applicant id </div></th>
    <th nowrap><div align="center">Applicant Name</div></th>
	<th nowrap><div align="center">IFSC Code</div></th>
    <th nowrap><div align="center">Branch Name</div></th>
    <th nowrap><div align="center">Date of Forwarding </div></th>
    <th nowrap>Download Applicant </th>
	 <th nowrap>Current Status </th>	
	 <th nowrap>Online Claim Submission	Applicant Data Date</th>
	<th nowrap>Amount</th>
	<th nowrap>Loan Statement</th>
	<th nowrap>Download</th>
	<th nowrap>Applicant Data</th>
    </tr>
	 </thead>
	 <tfoot>
  <tr >
  
       <th nowrap><div align="center">Applicant id </div></th>
    <th nowrap><div align="center">Applicant Name</div></th>
	<th nowrap><div align="center">IFSC Code</div></th>
    <th nowrap><div align="center">Branch Name</div></th>
    <th nowrap><div align="center">Date of Forwarding </div></th>
    <th nowrap>Download Applicant </th>
	 <th nowrap>Current Status </th>	
	 <th nowrap>Online Claim Submission	Applicant Data Date</th>
	<th nowrap>Amount</th>
	<th nowrap>Loan Statement</th>
	<th nowrap>Download</th>
	<th nowrap>Applicant Data</th>
    </tr>
 </tfoot>
  
</table>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function openSancReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=LetterHeadOfBankSecond';
 modalWin.ShowURL(url,600,1100,'PMEGP Loan Sanction Letter',null,null);
 
}
function openmmReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoneySecond';
 modalWin.ShowURL(url,600,1100,'Margin Money Claim Format',null,null);
 
}
function viewLs(APP_ID){
var urlpar='uploadclaim/'+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Loan Disbursement Statement',null,null);
 }//E
 
function uploadCert(pAppid) {
var url ='edpAppUplodadByAgency.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload EDP Certificate',null,null);
 
}


function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_sec_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }//END OF FUNCTION

function HideModalWindow() {
    modalWin.HideModalPopUp();
}


</script>

</form>

</body>
</html>

