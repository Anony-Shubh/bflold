<%@ include file="headerfile.jsp" %>
<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Bank applicant view</title>

<script src="js/jquery-1.12.4.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.scroller.min.js" type="text/javascript"></script>
<link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="css/scroller.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="js/ModalPopupWindow.js" type="text/javascript"></script>

<style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {color: #FF0000}
.style3 {
	color: #000000;
	font-weight: bold;
}
.style4 {font-size: large}
.style5 {
	color: #FF0000;
	font-size: large;
	font-weight: bold;
}
-->
</style>
<script>


$(document).ready(function() {
//var vdatasearch=$('#DTYPE').val();
var vdatasearch=$('#DTYPE :selected').val();
    $('#example').DataTable( { 	
	
       "ajax": 
	   {
    "url": "jsonBankData.jsp",
	"type": "POST",
    "data": {
        "DTYPE": vdatasearch
		
		
		
    }
  },   

/*	"columns":
		[
		{ "data": "APP ID" },
            { "data": "APP NAME" },
			{ "data": "IFSCODE" },	
			{ "data": "BRANCHNAME" },	
			{ "data": "BANK F DATE" },
			
			
			{ "data": "DOCUMENTS" },
		{ "data": "APPLICANT DATA" },
			{ "data": "STATUS" },
			{ "data": "DOWNLOAD" },
			{ "data": "EDP" },
			//{ "data": "CLAIM" },
			//{ "data": "AMOUNT" },
			{ "data": "LOAN" },
			
	
	   
		 ],
		 */
		 
		 "columns":
		[
		
	
		{ title: "Application ID", "data": "APP ID"   },
            { title: "Applicant Name", "data": "APP NAME"   },
			{ title: "NEFT IFS Code", "data": "IFSCODE"    },	

			{ title: "Branch Name",  "data": "BRANCHNAME" },	
			{  title: "Forwarding Date", "data": "BANK F DATE" },
			
			
			{  title: "Documents", "data": "DOCUMENTS" },
		{  title: "Update", "data": "APPLICANT DATA" },
			{  title: "Current Status", "data": "STATUS" },
			{  title: "Upload Sanction", "data": "UPLOAD" },
			{ title: "Download",  "data": "DOWNLOAD" },
			{ title: "EDP",  "data": "EDP" },
			{ title: "SignBoard",  "data": "SIGNBOARD" },
			//{ "data": "CLAIM" },
			//{ "data": "AMOUNT" },
			{ title: "Loan Statement",  "data": "LOAN" },   
		 ],
		 columnDefs: [
                {
                    render: function (data, type, full, meta) {
                        return "<div class='text-wrap width-200'>" + data + "</div>";
                    },
                    targets: 2
					
                }
             ],
		
      /*  deferRender:    true,		
        scrollY:        600,
        scrollCollapse: true,
		stateSave: true,		
        scroller:       
		{
			loadingIndicator:true
		}
		*/
		 
        deferRender:    true,
        scrollX:        true,
        scrollY:        400,
        scrollCollapse: true,
        scroller:       true,
        searching:      true,
        paging:         true,
        info:           false


		
    } 	);
	
	
	
} );


</script>
</head>

<body>
<form  method="post" name="form" >

<% 
String TYPE = request.getParameter("DTYPE")==null?"":request.getParameter("DTYPE");
 %>

<table border="2" align="center"   class="pmegpTable" >
  <tr>
    <td align="left"><div align="center"><img src="../images/pmegpetrackN.png" width="auto" height="43" /></div></td>
    </tr>
    <tr>
    <td align="left">Status : <select id="DTYPE" name="DTYPE">
	<OPTION value="ALL" <% if(TYPE.equals("ALL")){out.print("SELECTED");}%> >All</OPTION>
    <OPTION value="NEW" <% if(TYPE.equals("NEW")){out.print("SELECTED");}%> >Fresh (New)</OPTION>
	<OPTION value="UP" <% if(TYPE.equals("UP")){out.print("SELECTED");}%> >Under Process</OPTION>
	<OPTION value="SC" <% if(TYPE.equals("SC")){out.print("SELECTED");}%> >Sanctioned</OPTION>
	<OPTION value="CL" <% if(TYPE.equals("CL")){out.print("SELECTED");}%> >Claimed</OPTION>
	<OPTION value="RJ" <% if(TYPE.equals("RJ")){out.print("SELECTED");}%> >Rejected / Returned</OPTION>

	</select>
	<input name="Button" type="submit" class="buttongrey" id="btnClick"   onClick="searchdata();" value="Search">
	</td>
    </tr>
  </table>
   <table id="example"    cellspacing="0" width="98%" >
  <!--      <thead>
  <tr>
    <th nowrap ><div align="center">Applicant id </div></th>
    <th nowrap><div align="center">Applicant Name</div></th>
	<th nowrap><div align="center">IFSC Code</div></th>
	<th nowrap><div align="center">Branch Name</div></th>
    <th nowrap><div align="center">Forwarding Date </div></th>
	
    <th nowrap>Documents</th>
		<th nowrap>Update</th>
	 <th nowrap>Current Status </th>
	 	<th nowrap>Download</th>
	<th nowrap>EDP </th>

	<th nowrap>Loan Statement</th>
	</tr>
	
  </thead>
  
    
 
  <tfoot>
  <tr>
   <th nowrap ><div align="center">Applicant id </div></th>
    <th nowrap><div align="center">Applicant Name</div></th>
	<th nowrap><div align="center">IFSC Code</div></th>
	<th nowrap><div align="center">Branch Name</div></th>
    <th nowrap><div align="center">Forwarding Date</div></th>
	
    <th nowrap>Documents</th>
	<th nowrap>Update</th>
	 <th nowrap>Current Status </th>
	 	<th nowrap>Download</th>
	<th nowrap>EDP </th>

	<th nowrap>Loan Statement</th>

	
	</tr>
    </tfoot> -->
</table>

<p>&nbsp;  </p>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function openSancReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=LetterHeadOfBank';
 modalWin.ShowURL(url,600,1100,'PMEGP Loan Sanction Letter',null,null);
 
}
function openmmReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoney';
 modalWin.ShowURL(url,600,1100,'Margin Money Claim Format',null,null);
 
}
function uploadSign(pAppid) {
var url ='PmegpBoardUpload.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload PMEGP Sign Board',null,null);
 
}
function viewLs(APP_ID){
var urlpar='uploadclaim/'+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Loan Disbursement Statement',null,null);
 }//E
 
function uploadCert(pAppid) {
var url ='edpAppUplodadByAgency.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload EDP Certificate',null,null);
 
}

function uploadBanc(pAppid) {
var url ='BankSanctionLetUpload.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload PMEGP Sign Board',null,null);
 
}


function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }//END OF FUNCTION

function HideModalWindow() {
    modalWin.HideModalPopUp();
}


</script>

</form>

</body>
</html>

