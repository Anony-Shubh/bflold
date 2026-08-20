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
			 
			 var IFSC=table.cell( idx, 0 ).data();
			 var BRNAME=table.cell( idx, 2 ).data();
			 var ADDR=table.cell( idx, 3 ).data();
			 var DISTRICT=table.cell( idx, 4 ).data();
			 window.parent.getBankLOV(IFSC,BRNAME,ADDR,DISTRICT);
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
  
  String BANK_NAME =request.getParameter("BANK_NAME")==null?"Please Select Bank":(String)request.getParameter("BANK_NAME"); 
  String SDISTRICT=request.getParameter("SDISTRICT")==null?"0":(String)request.getParameter("SDISTRICT"); 
    String BRIFSC=request.getParameter("BRIFSC")==null?"":(String)request.getParameter("BRIFSC"); 
  String BRADDR=request.getParameter("BRADDR")==null?"":(String)request.getParameter("BRADDR"); 

    String vstate =request.getParameter("state")==null?"":(String)request.getParameter("state"); 
	
	String vStateqry="";
	
	if (vstate.equals("TG")||vstate.equals("AP")) {
  vStateqry="  RBI.STATE_CD IN ('TG','AP')";
  }else{
   vStateqry=" RBI.STATE_CD='"+vstate+"'";
  }

  
String IFSC_CODE = "";
String BRANCHNAME = "";
String ADDRESS = "";
String CENTRE = "";
String DISTRICT = "";
String DISTRICT_CD = "";
String BANK_PINCD="";
String vWherecls="";
  if (!BRIFSC.equals("")) {
  
   vWherecls=vWherecls+" AND UPPER(RBI.IFSC_CODE) LIKE UPPER('"+BRIFSC+"')  ";
  }
  
   if (!SDISTRICT.equals("0")){
    vWherecls=vWherecls+"  AND UPPER(RBI.DISTRICT||' '||RBI.ADDRESS||' '||RBI.BRANCHNAME) LIKE  UPPER('%"+SDISTRICT+"%')   ";
   }
  
   if (!BRADDR.equals("")){
       vWherecls=vWherecls+" AND UPPER(RBI.ADDRESS||' '||RBI.BRANCHNAME) LIKE  UPPER('%"+BRADDR+"%')  ";

   }
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  

qrysb.append(" SELECT RBI.BANK_NAME, " );
qrysb.append("RBI.IFSC_CODE,  " );
qrysb.append("RBI.BRANCHNAME, " );
qrysb.append(" RBI.ADDRESS, " );
qrysb.append("  RBI.CENTRE,  " );
qrysb.append(" RBI.DISTRICT,  " );
qrysb.append(" RBI.DISTRICT_CD,RBI.BANK_PINCD " );
qrysb.append(" FROM RBIBANKLIST RBI " );
qrysb.append(" WHERE RBI.ACT_YN='Y' AND BANK_NAME LIKE '"+BANK_NAME+"'  AND "+vStateqry+"   "+vWherecls+"  " );
//out.print (qrysb.toString());

 ResultSet rsMain = db.execSQL(qrysb.toString());
 
 
 ResultSet rsDist=db.execSQL(" SELECT DISTRICT_CD,DISTRICT_NAME,MS.STATE_NM FROM M_DISTRICT MD,M_STATE MS WHERE MD.DISTRICT_STATUS='A' AND MD.STATE_CD=MS.STATE_CD AND MS.STATE_CD='"+vstate+"' ORDER BY DISTRICT_NAME");
  %>
  
  <table align="center" class="bordered">
    <tr>
      <th colspan="5"><div align="center">PMEGP e-Portal Financing Branch List of <span class="GreenLebel"><%= BANK_NAME %></span></div></th>
    </tr>
    
    <tr>
      <td><select name="SDISTRICT" id="SDISTRICT">
	          <option value="0"> Search by District</option>

	  <%
	 String vstatenm="";
	   while (rsDist.next()) { %>
        <option value="<%= rsDist.getString(2) %>"><%= rsDist.getString(2) %></option>
		<%
		vstatenm=rsDist.getString(3);
		
		}
		out.print (vstatenm);
		rsDist.close();
		%>
      </select>
        Or</td>
      <td><input name="BRIFSC" id="BRIFSC" type="text" size="11" maxlength="11" value="" placeholder="Search by IFS Code" title="IFS code must be of first 4 of alphabets after that 0 and last 6 of alpha-numeric">
        Or</td>
      <td><input name="BRADDR" type="text" size="20" maxlength="20" value="" placeholder="Search branch Name"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search"></td>
      <td><input name="reset" type="reset" class="button" id="reset" value="Reset"></td>
    </tr>
</table>
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>IFS Code </th>
      <th>&nbsp;</th>
      <th>Branch Name </th>
      <th>Address</th>
      <th>District</th>
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
	
	%>
	
    <tr>
      <td><%= IFSC_CODE %></td>
      <td><div align="center">
        <input name="btnSelectBank" type="button" class="button1" id="btnSelectBank" value="Select">
      </div></td>
      <td><%= BRANCHNAME %></td>
      <td><%= ADDRESS %></td>
      <td><%= DISTRICT %></td>
      <td><%= BANK_PINCD %></td>
    </tr>
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>
</table>
