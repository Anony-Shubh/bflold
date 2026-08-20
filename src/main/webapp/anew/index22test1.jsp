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
	<LINK href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
	
	
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <LINK href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	
	


<SCRIPT src="https://code.jquery.com/jquery-3.5.1.js"></SCRIPT>   
<SCRIPT src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></SCRIPT>   

<SCRIPT>
function format ( d ) {
 
		
		 return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
        
        '<tr>'+
            '<td>Current Year:</td>'+
            '<td>'+d.BANK_FORD+'</td>'+
        '</tr>'+
		'<tr>'+
            '<td>Previous Year:</td>'+
            '<td>'+d.BANK_FORD_LASTYR+'</td>'+
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
        "ajax": "get_yeardata.jsp",
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

<STYLE>
td.details-control {
    background: url('img/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('img/details_close.png') no-repeat center center;
}
</STYLE>

</HEAD>

<BODY>
<!-- Page Wrapper -->
<DIV id="wrapper">
<!-- Content Wrapper -->
<DIV id="content-wrapper" class="d-flex flex-column">
<IMG src="img/banner3.jpg" > 
<!-- Main Content -->
<DIV id="content">
<BR>
<!-- Begin Page Content -->
<DIV class="container-fluid">

<TABLE id="example" class="display" style="width:100%">
        <THEAD>
            <TR>
                <TH></TH>
                <TH>Country</TH>
                <TH>Application Received</TH>
                <TH>Returned by Agency</TH>
                <TH>Pending at Agency</TH>
				<TH>Forwaded to Bank</TH>
				<TH>Loan Sanc. (in No )</TH>
				<TH>Claimed by Bank (in No.)</TH>
				<TH>Claimed by Bank (MM. in Cr.)</TH>
				<TH>MM Released (in No.)</TH>
				<TH>MM Released (Amt. in Cr.)</TH>
				<TH>Pending for credit decision at Bank</TH>
				<TH>Rejected by Bank</TH>
				<TH>Bankwise Detail </TH>
            </TR>
        </THEAD>
        <TFOOT>
            <TR>
                <TH></TH>
                <TH>Country</TH>
                <TH>Application Received</TH>
                <TH>Returned by Agency</TH>
                <TH>Pending at Agency</TH>
				<TH>Forwaded to Bank</TH>
				<TH>Loan Sanc. (in No )</TH>
				<TH>Claimed by Bank (in No.)</TH>
				<TH>Claimed by Bank (MM. in Cr.)</TH>
				<TH>MM Released (in No.)</TH>
				<TH>MM Released (Amt. in Cr.)</TH>
				<TH>Pending for credit decision at Bank</TH>
				<TH>Rejected by Bank</TH>
				<TH>Bankwise Detail </TH>
            </TR>
        </TFOOT>
    </TABLE>
	
</DIV>
</DIV>
</DIV>
</DIV>
	
</BODY>

</HTML>