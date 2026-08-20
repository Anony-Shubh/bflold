<%@ include file="includeHeadercomm.jsp" %>
<html>
<head>

<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/scroller/1.4.2/js/dataTables.scroller.min.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="https://cdn.datatables.net/scroller/1.4.2/css/scroller.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
    $('#example').DataTable( {
       "ajax": "jsondataSecondLoan.jsp",
	   "columns": [
            { "data": "AGENCY" },
            { "data": "APP_ID" },
			{ "data": "APPLICANT NAME" },
			{ "data": "IFSC" },
			{ "data": "MM CLAIM DATE" },
            { "data": "MM CLAIM" },
			{ "data": "VIEW" },
			{ "data": "STATUS" },			
            { "data": "TRANSIENT A/C" },
        ],
        deferRender:    true,		
        scrollY:        600,
        scrollCollapse: true,
		stateSave: true,
        scroller:       
		{
			loadingIndicator:true
		}
    } );
} );
</script>
<body>
<form name="form" id="form" class="form" method="post">
<table align="center" class="pmegpTable">
    <tr>
      <td colspan="18"><div align="center"> PMEGP MARGIN MONEY PENDING CLAIM PROCESS </div></td>
    </tr>
</table>
 <% if (!VUSER_ID.equals("3")){ %>
<table align="center" cellspacing="0" class="display" id="example">
        <thead>
            <tr>
              <th nowrap>Agency</th>
              <th nowrap>Applicant ID </th>
                <th nowrap>APPLICANT NAME</th>
                <th nowrap>IFSC</th>
                <th nowrap>MM Claim Date </th>
				<th nowrap>MM Claim </th>
				<th nowrap>View </th>
				<th nowrap>Status</th>
				<th nowrap>Transient A/c No. </th>
            </tr>
        </thead>
        <tfoot>
            <tr>
              <th>&nbsp;</th>
              <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>IFSC</th>
                <th>MM Claim Date </th>
				<th>MM Claim</th>
				<th>Loan Statement</th>
				<th>Status</th>
				<th>Transient A/c No. </th>
            </tr>
        </tfoot>
		      </table>
<%}%>
</body>	
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowMMClaim(pAppid){
var urlpar='StatusUpdateIstLCOSec.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,900,'PMEGP STATUS UPDATE',null,null);
 }
 
 function viewAlldocument(pAppid){
var urlpar='viewAppdocumentSec.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,800,1200,'PMEGP View All Applicant Document',null,null);
 }
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

 </script>
</form>
</body>
	</html>