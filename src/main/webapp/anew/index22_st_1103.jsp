<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html>
<HTML lang="en">

<HEAD>

    <META CHARSET="utf-8">
    <META http-equiv="X-UA-Compatible" content="IE=edge">
    <META name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <META name="description" content="">
    <META name="author" content="">

    <TITLE>PMEGP DASHBOARD</TITLE>

    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <LINK href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<SCRIPT type="text/javascript" src="js/datetimepicker_css.js"></SCRIPT>

<SCRIPT language="javascript">

function changetype(){
/*
var GENDERT=document.getElementById("GENDERT").value;

				
				if(GENDERT==""){
				inlineMsg('GENDERT','Select Gender',2);
				return false;
				}
*/
document.form.submit();

}


  function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

return (showdt);
}
 
 function todaydt() {
 test = new Date()
document.getElementById("TODT").value=now();
 }

</SCRIPT>

<SCRIPT src="https://code.jquery.com/jquery-3.5.1.js"></SCRIPT>   
<SCRIPT src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></SCRIPT>   

<SCRIPT>
function format ( d ) {
 
		
		 return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
        '<tr>'+
            '<td>Last Year:</td>'+
            '<td>'+d.BANK_FORD_LASTYR+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>Current Year:</td>'+
            '<td>'+d.BANK_FORD+'</td>'+
        '</tr>'+
        '<tr>'+
            '<td>Total:</td>'+
            '<td>'+d.BANK_FORD+'</td>'+
        '</tr>'+
    '</table>';
	
	
	
	
}
 
$(document).ready(function() {
    var dt = $('#example').DataTable( {
        "processing": true,
        "serverSide": true,
        "ajax": "get_yeardata_1103.jsp",
        "columns": [
            {
                "class":          "details-control",
                "orderable":      false,
                "data":           null,
                "defaultContent": ""
            },
			{ "data": "COUNTRY",
			"render": function(data, type, row, meta){
            if(type === 'display'){
			 //data = '<a href="test.jsp?STATE_CD='+row.information+'">' + data + '</a>';
                data = '<a href="test.jsp">' + data + '</a>';
            }

            return data;
         }
			 },
            { "data": "NO_OF_APP" },
            { "data": "RET_BY_AGENCY" },
            { "data": "PENDING_AGENCY" },
            { "data": "BANK_FORD" },
			{ "data": "LOAN_SANC" },
			{ "data": "CLAIM_BY_BANK_NO" },
			{ "data": "CLAIM_BY_BANK_MM" },
			{ "data": "MM_REL_NO" },
			{ "data": "MM_REL_AMT" },
			{ "data": "FOR_DECISION" },
			{ "data": "BANK_REJ" },
			{ "data": "LOANDIS_MM" }
        ],
        "order": [[1, 'asc']]
    } );
 
    // Array to track the ids of the details displayed rows
    var detailRows = [];
 
    $('#example tbody').on( 'click', 'tr td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = dt.row( tr );
        var idx = $.inArray( tr.attr('id'), detailRows );
 
        if ( row.child.isShown() ) {
            tr.removeClass( 'details' );
            row.child.hide();
 
            // Remove from the 'open' array
            detailRows.splice( idx, 1 );
        }
        else {
            tr.addClass( 'details' );
            row.child( format( row.data() ) ).show();
 
            // Add to the 'open' array
            if ( idx === -1 ) {
                detailRows.push( tr.attr('id') );
            }
        }
    } );
 
    // On each draw, loop over the `detailRows` array and show any child rows
    dt.on( 'draw', function () {
        $.each( detailRows, function ( i, id ) {
            $('#'+id+' td.details-control').trigger( 'click' );
        } );
    } );
} );
</SCRIPT>

</HEAD>

<BODY onLoad="todaydt();" id="page-top">
<FORM name="form" id="form" >

							  <TABLE id="example" class="display" style="width:100%">
                                    <THEAD>
                                        <TR>
                                          <TH>Sr. No. </TH>
										 
										 
										  <TH>State</TH>
										
										 
                                            <TH>No. of App. </TH>
                                            <TH>Returned by Agency</TH>
                                            <TH>Forwaded to Bank</TH>
                                            <TH>Pending at Agency</TH>
                                            <TH>Loan Sanct.</TH>
                                            <TH>Loan Disb. </TH>
                                            <TH>Pending for Claim </TH>
                                            <TH>Claimed by Bank (in No.)</TH>
                                            <TH>Claimed by Bank (MM. in Cr.)</TH>
                                            <TH>MM Released (in No.)</TH>
                                            <TH>MM Released (Amt. in Cr.)</TH>
                                            <TH>Pending for credit decision at Bank</TH>
                                            <TH>% Decided by Bank </TH>
                                            <TH>Rejected by Bank</TH>
                                            <TH>Bankwise Detail </TH>
                                        </TR>
                                    </THEAD>
                                    <TFOOT>
                                        <TR>
                                          <TH>Sr. No. </TH>
										
										  
										  <TH>State</TH>
										 
                                            <TH>No. of App. </TH>
                                            <TH>Returned by Agency</TH>
                                            <TH>Forwaded to Bank</TH>
                                            <TH>Pending at Agency</TH>
                                            <TH>Loan Sanctioned</TH>
                                            <TH>Loan Disb. </TH>
                                            <TH>Pending for Claim </TH>
                                            <TH>Claim by Bank (in No.)</TH>
                                            <TH>Claim by Bank (MM. in Cr.)</TH>
                                            <TH>MM Released (in No.)</TH>
                                            <TH>MM Released (Amt. in Cr.)</TH>
                                            <TH>Pending for decision by Bank</TH>
                                            <TH>% Decided by Bank </TH>
                                            <TH>Rejected by Bank</TH>
                                            <TH>Bankwise Detail </TH>
                                        </TR>
                                    </TFOOT>
                                    <TBODY>
				
									
										
                                        </TR>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </DIV>
                    </DIV>

                </DIV>
                <!-- /.container-fluid -->

            </DIV>
                                                
                                                
                                                
                                                
                                                 
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <DIV class="container my-auto">
                    <DIV class="copyright text-center my-auto">
                        <SPAN>Copyright &copy; KVIC 2021</SPAN>
                    </DIV>
                </DIV>
            </footer>
            <!-- End of Footer -->

        </DIV>
        <!-- End of Content Wrapper -->

    </DIV>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <A class="scroll-to-top rounded" href="#page-top">
        <I class="fas fa-angle-up"></I>
    </A>


<SCRIPT>
function myFunction() {
  var x = document.getElementById("myDIV");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
</SCRIPT>
    <!-- Bootstrap core JavaScript-->
    <SCRIPT src="vendor/jquery/jquery.min.js"></SCRIPT>
    <SCRIPT src="vendor/bootstrap/js/bootstrap.bundle.min.js"></SCRIPT>

    <!-- Core plugin JavaScript-->
    <SCRIPT src="vendor/jquery-easing/jquery.easing.min.js"></SCRIPT>

    <!-- Custom scripts for all pages-->
    <SCRIPT src="js/sb-admin-2.min.js"></SCRIPT>

    <!-- Page level plugins -->
    <SCRIPT src="vendor/datatables/jquery.dataTables.min.js"></SCRIPT>
    <SCRIPT src="vendor/datatables/dataTables.bootstrap4.min.js"></SCRIPT>

    <!-- Page level custom scripts -->
    <SCRIPT src="js/demo/datatables-demo.js"></SCRIPT>
</FORM>
</BODY>

</HTML>