<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<link rel="stylesheet" type="text/css" href="../js/jquery.dataTables.min.css">
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript">


$(document).ready(function() {

var table = $('#example').DataTable();
 

 var table = $('#example').DataTable();
 
    $('#example tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
			
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
			
			 var idx = table.row( this ).index();
			 
			 var BR_NAME=table.cell( idx, 2 ).data();
			 var BRANCH_NAME=table.cell( idx, 3 ).data();
			 var BR_ADDR=table.cell( idx, 4 ).data();
			 var STATE=table.cell( idx, 6 ).data();
			 var DISTRICT=table.cell( idx, 5 ).data();
			  var PINCODE=table.cell( idx, 7 ).data();
			 window.parent.getBankLOV(BR_NAME,BRANCH_NAME,BR_ADDR,STATE,DISTRICT,PINCODE);
			 window.parent.HideModalWindow();
        }
    } );
 
    
    // Setup - add a text input to each footer cell
    $('#example tfoot th').each( function () {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
    } );
 
    // DataTable
    var table = $('#example').DataTable();
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            if ( that.search() !== this.value ) {
                that
                    .search( this.value )
                    .draw();
            }
        } );
    } );
} );



</script>
</head>

<body>
<form name="form" id="form" class="form" method="post">
  <p>
    <% 
  
    String BRIFSC=request.getParameter("BRIFSC")==null?"":(String)request.getParameter("BRIFSC"); 


String BANK_NAME="";  
String IFSC_CODE = "";
String BRANCHNAME = "";
String ADDRESS = "";
String CENTRE = "";
String DISTRICT = "";
String DISTRICT_CD = "";
String BANK_PINCD="";
String vWherecls="";
 String STATE="";
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  

qrysb.append(" SELECT RBI.BANK_NAME, " );
qrysb.append("  RBI.IFSC_CODE, MS.STATE_NM AS STATE,  " );
qrysb.append(" RBI.BRANCHNAME, " );
qrysb.append(" RBI.ADDRESS, " );
qrysb.append(" RBI.CENTRE,  " );
qrysb.append(" RBI.DISTRICT,  " );
qrysb.append(" RBI.DISTRICT_CD,RBI.BANK_PINCD " );
qrysb.append(" FROM RBIBANKLIST RBI, M_STATE MS " );
qrysb.append(" WHERE RBI.STATE_CD=MS.STATE_CD AND UPPER(RBI.IFSC_CODE)=UPPER('"+BRIFSC+"')" );

// out.print(qrysb.toString());
 
 ResultSet rsMain = db.execSQL(qrysb.toString());
 
  %>
  
  <table align="center" class="bordered">
    <tr>
      <th colspan="5"><div align="center">PMEGP e-Portal Financing Branch</div></th>
    </tr>
</table>
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>IFS Code </th>
      <th>&nbsp;</th>
      <th>Bank Name </th>
      <th>Branch Name </th>
      <th>Address</th>
      <th>District</th>
      <th>State</th>
      <th>PIN Code </th>
    </tr>
	</thead>
	
	<%
	while (rsMain.next()){
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
ADDRESS=rsMain.getString("ADDRESS")==null?"":rsMain.getString("ADDRESS");
CENTRE=rsMain.getString("CENTRE")==null?"":rsMain.getString("CENTRE");
DISTRICT=rsMain.getString("DISTRICT")==null?"":rsMain.getString("DISTRICT");
DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
BANK_PINCD=rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
STATE=rsMain.getString("STATE")==null?"":rsMain.getString("STATE");	
	%>
	
    <tr>
      <td><%= IFSC_CODE %></td>
      <td><div align="center">
        <input name="btnSelectBank" type="button" class="button1" id="btnSelectBank" value="Select">
      </div></td>
      <td><%= BANK_NAME %></td>
      <td><%= BRANCHNAME %></td>
      <td><%= ADDRESS %></td>
      <td><%= DISTRICT %></td>
      <td><%= STATE %></td>
      <td><%= BANK_PINCD %></td>
    </tr>
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>
</table>
