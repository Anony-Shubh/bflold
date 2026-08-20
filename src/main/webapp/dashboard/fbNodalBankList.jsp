<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css" />
<style>
tr.group,
tr.group:hover {
    background-color: #ddd !important;
}
table, th, td, body,thead,tfoot {
  border: 1px solid;
  font-family:Arial, Helvetica, sans-serif;
  font-size:20px;
  font-weight:900;
  font-style:oblique;
  
  }
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.8/js/jquery.dataTables.min.js" ></script>
 
<script language="javascript">
$(document).ready(function() {
    var table = $('#example').DataTable({
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ],
        "order": [[ 0, 'asc' ]],
        "displayLength": 100,
        "drawCallback": function ( settings ) {
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
 
            api.column(0, {page:'current'} ).data().each( function ( group, i ) {
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group"><td colspan="3">'+group+'</td></tr>'
                    );
 
                    last = group;
                }
            } );
        }
    } );
 
    // Order by the grouping
    $('#example tbody').on( 'click', 'tr.group', function () {
        var currentOrder = table.order()[0];
        if ( currentOrder[0] === 2 && currentOrder[1] === 'asc' ) {
            table.order( [ 0, 'desc' ] ).draw();
        }
        else {
            table.order( [ 0, 'asc' ] ).draw();
        }
    } );
} );
</script>
</head>
<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">

<% 
 StringBuffer qrysb= new StringBuffer();

qrysb.append("  SELECT NB.BANK_TYPE,NB.BANK_NAME,NB.EMAIL FROM NODALBANKHELPDESK NB  "      );


DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
<center>
  <h1>PMEGP  Bank Nodal Officer List  </h1>
  <a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a>
</h1></center>

 <table id="example" class="display" style="width:100%">
 <thead>
 <tr>
 
    <th>Bank Type</th>
    <th> Bank Name </th>
    <th>Email</th>
    
  </tr>
   </thead>
  
<tbody>
<% 

String BANK_TYPE="";
String BANK_NAME="";
String EMAIL="";

int srno =0;
 while (rsMain.next()) { 
 
  BANK_TYPE=rsMain.getString("BANK_TYPE")==null?"":rsMain.getString("BANK_TYPE");
 BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
 EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
 
srno=srno+1;

%>
  <tr>
    
    <td><%= BANK_TYPE %></td>
    <td> <%= BANK_NAME %> </td>
    <td><%= EMAIL %></td>
    
  </tr>
 
   <%  }
  rsMain.close();
  db.close();
    %>
   </tbody>
	<tfoot>
 <tr>
   
   <th>Bank Type</th>
    <th> Bank Name </th>
    <th>Email</th>
  </tr>
   </tfoot>
</table>

</body>
</html>
