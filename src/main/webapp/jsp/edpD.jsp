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
			 window.parent.getEdpName(edpname+' ('+edpcode+')',edpcode);
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
  String DIST_CD=request.getParameter("DIST_CD")==null?"":(String)request.getParameter("DIST_CD");
  String STATE =request.getParameter("STATE")==null?"":(String)request.getParameter("STATE"); 
  String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"ALL":(String)request.getParameter("DISTRICT_CD"); 
  String PINCODE=request.getParameter("PINCODE")==null?"":(String)request.getParameter("PINCODE"); 
  String CITY=request.getParameter("CITY")==null?"":(String)request.getParameter("CITY"); 
    String ADDRESS=request.getParameter("ADDRESS")==null?"":(String)request.getParameter("ADDRESS"); 
  String AGENCY_TYPE=request.getParameter("AGENCY_TYPE")==null?"ALL":(String)request.getParameter("AGENCY_TYPE"); 
  
String OFF_CD = "";  
String OFF_NAME = "";
String CITY1 = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String PINCODE1="";
String OFF_LONG_DESC="";
String vWherecls=""; 
String OFF_ADDR2="";
String sn="";
String snD="";

 if (!AGENCY_TYPE.equals("ALL")) {
       vWherecls=vWherecls+" AND (MOM.OFF_TYPE_CD) = "+AGENCY_TYPE ;
   }
   
   if (!DISTRICT_CD.equals("ALL")) {
       vWherecls=vWherecls+"  AND MD.DISTRICT_CD="+DISTRICT_CD;

   }
   
    if (!ADDRESS.equals("")){
       vWherecls=vWherecls+"AND TRIM(UPPER(OFF_ADDR2)) ||' '||TRIM(UPPER(MOM.CITY))||' '||TRIM(UPPER(MD.DISTRICT_NAME)) ||' '||MOM.PINCODE||' '||TRIM(UPPER(OFF_LONG_DESC))||' '||TRIM(UPPER(MS.STATE_NM))||' '||TRIM(UPPER(MOM.OFF_NAME))||' '||TRIM(UPPER(MOM.OFF_CD))  LIKE (UPPER('%"+ADDRESS+"%')) ";
      
  }
  
  
 //out.print(vWherecls);
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  


qrysb.append(" SELECT MOM.OFF_CD, MOM.OFF_LONG_DESC,MOM.OFF_NAME,MOM.CITY,MD.DISTRICT_NAME|| ' '|| MS.STATE_NM||' ('||MD.DISTRICT_CD ||')' AS DISTRICT_NAME,OFF_ADDR2,  " );
qrysb.append(" MD.DISTRICT_CD,MOM.PINCODE,MS.STATE_NM FROM MAS_OFF_MAST MOM,MAS_OFF_TYPE_CDMAST MOC,  " );
qrysb.append(" M_DISTRICT MD,M_STATE MS WHERE   " );
qrysb.append("  MD.DISTRICT_CD=MOM.DISTRICT_CD AND MOC.OFF_TYPE_CD=MOM.OFF_TYPE_CD AND  MD.STATE_CD=MS.STATE_CD AND MOM.ACT_YN='Y' AND MOC.OFF_CATEGORY=100  AND " );
qrysb.append(" MS.STATE_CD=(SELECT STATE_CD FROM M_DISTRICT WHERE DISTRICT_CD="+DIST_CD+")  " );
qrysb.append("  "+vWherecls+"  " );

//out.print(qrysb.toString());
 ResultSet rsMain = db.execSQL(qrysb.toString());
 ResultSet rsState=db.execSQL(" SELECT MS.DISTRICT_CD,MS.DISTRICT_NAME FROM M_DISTRICT MS  WHERE STATE_CD=(SELECT STATE_CD FROM M_DISTRICT WHERE DISTRICT_CD="+DIST_CD+")  ORDER BY MS.DISTRICT_NAME ");
 %>
 <!--<input name="CITY" type="text" size="20" maxlength="20" value="" id="CITY" placeholder="Search">
  <input name="btnFind" type="submit" class="button" id="btnFind" value="Search">-->
   <table width="98%" align="center" class="bordered">
    <tr bgcolor="#DFBFD7">
      <td colspan="8"><div align="center">EDP Center</div></td>
    </tr>
 
    <tr>
	<td width="23%">Edp Center Type : <select name="AGENCY_TYPE" id="AGENCY_TYPE">
	        
			
        <option value="ALL">ALL</option>

      <% 
	   String vOFF_TYPE_CD = "";
		  String vOFF_TYPE_LONG_DESC= "";
  
          ResultSet rsUp= db.execSQL("SELECT OFF_TYPE_CD ,OFF_TYPE_LONG_DESC FROM MAS_OFF_TYPE_CDMAST WHERE OFF_CATEGORY=100 ");
		 
		  while (rsUp.next()){
	      vOFF_TYPE_CD =rsUp.getString("OFF_TYPE_CD")==null?"":rsUp.getString("OFF_TYPE_CD");
		  vOFF_TYPE_LONG_DESC =rsUp.getString("OFF_TYPE_LONG_DESC")==null?"":rsUp.getString("OFF_TYPE_LONG_DESC");
		 
  %>
     <option value="<%=vOFF_TYPE_CD %>" <% if (vOFF_TYPE_CD.equals(AGENCY_TYPE)){out.print("selected");} %>><%= vOFF_TYPE_LONG_DESC%></option>
<% }
rsUp.close();
%>
     </select>Or</td>
	
      <td width="21%">District : <select name="DISTRICT_CD" id="DISTRICT_CD">
	          <option value="ALL">ALL</option>
		<%
	  // String sn="";
	   while (rsState.next()) {
	   snD=rsState.getString(1);	
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=snD  %>" <% if (snD.equals(DISTRICT_CD)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>Or</td>
		
      <td width="30%"><div align="center">
        <input name="ADDRESS" type="text" id="ADDRESS" placeholder="Search By ADDRESS" value="<%=ADDRESS %>"  size="30" maxlength="30">
           </div></td>
		 
       <td width="26%"><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     
    </tr>
</table>
  <table width="100%" id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>EDP  ID </th>
      <th>&nbsp;</th>
      <th>Short name </th>
	   <th><div align="center">DISTRICT</div></th>
      <th><div align="center">Training Center Name </div></th>
      <th>Address</th>
      <th><div align="center">CITY</div></th>     
     
	  <th><div align="center">PINCODE </div></th>
	  <!--<th><div align="center">State</div></th>-->
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
	  <td><div align="left"><%= DISTRICT_NAME %></div></td>	
      <td><div align="left"><%=OFF_LONG_DESC  %></div></td>      
      <td><%=OFF_ADDR2  %></td>
      <td><div align="left"><%=CITY1  %></div></td>      	
      <td><div align="left"><%= PINCODE1 %></div></td>	  
	  <!--<td><div align="left"><%= STATE %></div></td>-->
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
