<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <link rel="stylesheet" type="text/css" href="../css/lov.css" />
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
			 window.parent.getEdpName(edpname+' ('+edpcode+')', edpcode);
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
  String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":(String)request.getParameter("DISTRICT_CD"); 
  String PINCODE=request.getParameter("PINCODE")==null?"":(String)request.getParameter("PINCODE"); 
  String CITY=request.getParameter("CITY")==null?"":(String)request.getParameter("CITY"); 
  
String OFF_CD = "";  
String OFF_NAME = "";
String CITY1 = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String PINCODE1="";
String OFF_LONG_DESC="";
String vWherecls=""; 
String OFF_ADDR2="";


      
  
    if (!CITY.equals("")){
       vWherecls=vWherecls+" AND TRIM(UPPER(OFF_ADDR2)) ||' '||TRIM(UPPER(MOM.CITY))||' '||TRIM(UPPER(MD.DISTRICT_NAME)) ||' '||MOM.PINCODE||' '||TRIM(UPPER(OFF_LONG_DESC))||' '||TRIM(UPPER(MS.STATE_NM))||' '||TRIM(UPPER(MOM.OFF_NAME))||' '||TRIM(UPPER(MOM.OFF_CD))   LIKE  TRIM(UPPER('%"+CITY+"%')) ";

   }
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  
  qrysb.append("   SELECT MOM.OFF_LONG_DESC,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     MOM.CITY,"      );
qrysb.append("     MD.DISTRICT_NAME"      );
qrysb.append("     || ' '"      );
qrysb.append("     || MS.STATE_NM"      );
qrysb.append("     || ' ('"      );
qrysb.append("     || MD.DISTRICT_CD"      );
qrysb.append("     || ')' AS DISTRICT_NAME,"      );
qrysb.append("     MOM.OFF_ADDR2,"      );
qrysb.append("     MD.DISTRICT_CD,"      );
qrysb.append("     MOM.PINCODE,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     MOM.OFF_CD,"      );
qrysb.append("     MOTC.OFF_TYPE_SHORT_DESC"      );
qrysb.append("   FROM MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     MAS_OFF_TYPE_CDMAST MOTC"      );
qrysb.append("   WHERE MD.DISTRICT_CD  = MOM.DISTRICT_CD"      );
qrysb.append("   AND MOTC.OFF_TYPE_CD  = MOM.OFF_TYPE_CD"      );
qrysb.append("   AND MOM.DISTRICT_CD   = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD       = MD.STATE_CD"      );
qrysb.append("   AND MOTC.OFF_CATEGORY = 100 AND MOM.ACT_YN='Y' "      );
qrysb.append("   "+vWherecls+"  " );

/*
qrysb.append(" SELECT MOM.OFF_CD, MOM.OFF_LONG_DESC,MOM.OFF_NAME,MOM.CITY,MD.DISTRICT_NAME|| ' '|| MS.STATE_NM||' ('||MD.DISTRICT_CD ||')' AS DISTRICT_NAME,OFF_ADDR2,  " );
qrysb.append(" MD.DISTRICT_CD,MOM.PINCODE,MS.STATE_NM FROM MAS_OFF_MAST MOM,  " );
qrysb.append(" M_DISTRICT MD,M_STATE MS WHERE MOM.OFF_TYPE_CD = 26  " );
qrysb.append(" AND MD.DISTRICT_CD=MOM.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD" );
*/

//out.print (qrysb.toString());

 ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
 <input name="CITY" type="text" size="20" maxlength="20" value="" id="CITY" placeholder="Search">
  <input name="btnFind" type="submit" class="button" id="btnFind" value="Search">
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>EDP  ID </th>
      <th>&nbsp;</th>
      <th>Short name </th>
      <th><div align="center">Training Center Name </div></th>
      <th>Address</th>
      <th><div align="center">CITY</div></th>     
      <th><div align="center">DISTRICT</div></th>
	  <th><div align="center">PINCODE </div></th>
	  <th><div align="center">State</div></th>
	  </tr>
	
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
CITY1=rsMain.getString("CITY")==null?"":rsMain.getString("CITY");
STATE=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
PINCODE1=rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
OFF_LONG_DESC=rsMain.getString("OFF_LONG_DESC")==null?"":rsMain.getString("OFF_LONG_DESC");
OFF_ADDR2=rsMain.getString("OFF_ADDR2")==null?"":rsMain.getString("OFF_ADDR2");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
edpcount=edpcount+1;
	
	%>
	<tr>
	  <td><%=OFF_CD  %></td>
      <td> <input name="btnSelectBank" type="button" class="button1" id="btnSelectBank" value="Select"></td>
      <td><%=OFF_NAME  %></td>
      <td><div align="left"><%=OFF_LONG_DESC  %></div></td>      
      <td><%=OFF_ADDR2  %></td>
      <td><div align="left"><%=CITY1  %></div></td> 
      <td><div align="left"><%= DISTRICT_NAME %></div></td>		
      <td><div align="left"><%= PINCODE1 %></div></td>	  
	  <td><div align="left"><%= STATE %></div></td>
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
