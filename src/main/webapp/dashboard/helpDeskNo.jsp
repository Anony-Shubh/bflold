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
        "displayLength": 50,
        "drawCallback": function ( settings ) {
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
 
            api.column(0, {page:'current'} ).data().each( function ( group, i ) {
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group"><td colspan="6">'+group+'</td></tr>'
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

qrysb.append("   SELECT "      );
qrysb.append("   PHD.OFF_CD,"      );
qrysb.append("   BOM.ZONE_NM,"      );
qrysb.append("     BOM.STATE_NM,"      );
qrysb.append("     PHD.OFF_NAME,"      );
qrysb.append("     PHD.MOB_NO1,"      );
qrysb.append("     PHD.EMAIL1"      );
qrysb.append("   FROM pmegphelpdeskia PHD,"      );
qrysb.append("     bnf_off_mast BOM"      );
qrysb.append("   WHERE PHD.OFF_CD = BOM.OFF_CD"      );
qrysb.append("   AND (BOM.ACT_YN  = 'Y')"      );
qrysb.append("   ORDER BY bom.zone_nm"      );

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
<center>
  <h1> PMEGP HELPDESK CONTACT DETAIL </h1>
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a>
</h1></center>

 <table id="example" class="display" style="width:100%">
 <thead>
 <tr>
 
    <th>Zone</th>
    <th> State </th>
    <th>State UT</th>
    <th>Help Desk No</th>
    <th>Official Email ID</th>
  </tr>
   </thead>
  
<tbody>
<% 

String ZONE_NM="";
String STATE_NM="";
String OFF_NAME="";
String MOB_NO1="";
String EMAIL1="";



int srno =0;
 while (rsMain.next()) { 
 
  ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
 MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
EMAIL1=rsMain.getString("EMAIL1")==null?"":rsMain.getString("EMAIL1");

srno=srno+1;

%>
  <tr>
    
    <td><%= ZONE_NM %></td>
    <td> <%= STATE_NM %> </td>
    <td><%= OFF_NAME %></td>
    <td><%= MOB_NO1 %></td>
    <td><%= EMAIL1 %></td>
     
  </tr>
 
   <%  }
  rsMain.close();
  db.close();
    %>
	 </tbody>
	<tfoot>
 <tr>
   
   <th>Zone</th>
    <th> State </th>
    <th>State UT</th>
    <th>Help Desk No</th>
    <th>Official Email ID</th>
  </tr>
   </tfoot>
</table>

</body>
</html>
