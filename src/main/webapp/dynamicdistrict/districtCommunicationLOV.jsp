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
			 
			 var districtname=table.cell( idx, 1 ).data();
			 //var edpcode=table.cell( idx, 2 ).data();
			 
			 //var BRNAME=table.cell( idx, 2 ).data();
			 //var ADDR=table.cell( idx, 3 ).data();
			// var DISTRICT=table.cell( idx, 4 ).data();
			 window.parent.getDistrictName(districtname)
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
  
  String STATE =request.getParameter("STATE")==null?"":(String)request.getParameter("STATE"); 
  
  

String DISTRICT_NAME = "";
String DISTRICT_CD = "";     
  
   
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  


ResultSet rsMain= db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD='"+STATE+"'   ");
 %>
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
	<th>Srno</th>
      <th>DISTRICT NAME</th>
      <th>SELECT</th>            
	  </tr>
	
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){

DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
edpcount=edpcount+1;
	
	%>
	<tr>
	<td><%=edpcount%>
	 <td><%=DISTRICT_NAME  %></td>  
	      
	   <td> <input name="btnSelectBank" type="button" class="button1" id="btnSelectBank" value="Select"></td>
        
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
