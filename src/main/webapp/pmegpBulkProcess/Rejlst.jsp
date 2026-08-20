<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css">
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
			 
			 var edpname=table.cell( idx, 2 ).data();
			 var edpcode=table.cell( idx, 0 ).data();
			 
			 //var BRNAME=table.cell( idx, 2 ).data();
			 //var ADDR=table.cell( idx, 3 ).data();
			// var DISTRICT=table.cell( idx, 4 ).data();
			 window.parent.getRejName(edpname,edpcode);
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
  <% 
  
  String REJ_DESC =request.getParameter("REJ_DESC")==null?"":(String)request.getParameter("REJ_DESC"); 
 
String REJ_ID = "";  

String vWherecls="";
      
  
    if (!REJ_DESC.equals("")){
       vWherecls=vWherecls+" AND UPPER(REJ_DESC)   LIKE  TRIM(UPPER('%"+REJ_DESC+"%')) ";

   }
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  


qrysb.append(" SELECT REJ_ID,REJ_DESC FROM REJECTION_MAST WHERE ACT_YN='Y'  ORDER BY REJ_ID  " );

qrysb.append("   "+vWherecls+"  " );

 ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
  <table  id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>REJ ID </th>
      <th>&nbsp;</th>
      <th>Rejection Reason</th>    
	  </tr>
	
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
REJ_ID=rsMain.getString("REJ_ID")==null?"":rsMain.getString("REJ_ID");
REJ_DESC=rsMain.getString("REJ_DESC")==null?"":rsMain.getString("REJ_DESC");

edpcount=edpcount+1;
	
	%>
	<tr>
	  <td><%=REJ_ID  %></td>
      <td> <input name="btnSelectBank" type="button" class="button1" id="btnSelectBank" value="Select"></td>
      <td><%=REJ_DESC  %></td>
      
	  </tr>
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>	
</table>
</form>
</body>
</html>
