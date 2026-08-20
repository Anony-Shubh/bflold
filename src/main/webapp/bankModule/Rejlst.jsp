<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<HTML>
<HEAD>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<LINK rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css">
<SCRIPT language="javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
<SCRIPT language="javascript" src="../js/jquery.dataTables.min.js"></SCRIPT>
<SCRIPT language="javascript">
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



</SCRIPT>
</HEAD>



<BODY>
<FORM name="form" id="form" class="form" method="post">


  <% 
  
  String REJ_DESC =request.getParameter("REJ_DESC")==null?"":(String)request.getParameter("REJ_DESC"); 
 
String REJ_ID ="";  

String vWherecls="";
      
  
  
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  
if (!REJ_DESC.equals("")){
       vWherecls=vWherecls+" AND UPPER(REJ_DESC ) LIKE  UPPER('%"+REJ_DESC+"%')  ";

   }
   else {
	  vWherecls=vWherecls+" AND (REJ_DESC ) LIKE  ('%%')  ";  
   }

qrysb.append(" SELECT REJ_ID,REJ_DESC FROM REJECTION_MAST WHERE ACT_YN='Y' AND REL_TP IN ('B','C') "+vWherecls+" ORDER BY REJ_ID    " );


 ResultSet rsMain = db.execSQL(qrysb.toString());
 
 
 %>
 
   <table align="center" class="bordered">
    <tr>
      <th colspan="3"><div align="center">REJECTION DETAIL SEARCH FORM </div></th>
    </tr>
 
    <tr>
      <td>SEARCH BY REJECTION REASON:</td>
      <td><input name="REJ_DESC" type="REJ_DESC" size="20" maxlength="20" value="<%= REJ_DESC %>" placeholder="Search by Rejection Reason"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     <!-- <td><input name="Submit" type="submit" class="button" id="reset" value="View All"></td>-->
    </tr>
</table>
  <TABLE width="95%"  id="example" align="center" class="bordered">
    <THEAD>
    <TR>
      <TH>REJ ID </TH>
      <TH>&nbsp;</TH>
      <TH>Rejection Reason</TH>    
	  </TR>
	
	</THEAD>
	<%
	int edpcount=0;
	while (rsMain.next()){
REJ_ID=rsMain.getString("REJ_ID")==null?"":rsMain.getString("REJ_ID");
REJ_DESC=rsMain.getString("REJ_DESC")==null?"":rsMain.getString("REJ_DESC");

edpcount=edpcount+1;
	
	%>
	<TR>
	  <TD><%=REJ_ID  %></TD>
      <TD> <INPUT name="btnSelectBank" type="button" class="greenButtonRound" id="btnSelectBank" value="Select"></TD>
      <TD><%=REJ_DESC  %></TD>
      
	  </TR>
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>	
</TABLE>
</FORM>
</BODY>
</HTML>
