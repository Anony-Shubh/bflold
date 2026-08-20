<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="kvic.inputvalid.*"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>

<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

<style type="text/css">
<!--
.style2 {color: #FF8000}
.style3 {
	font-size: xx-large;
	color: #0000CC;
}
-->
</style>
</head>

<body>
<form name="form" id="form" class="form" method="post">

  <div align="center"><img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
    <%
jspinputvalid js = new jspinputvalid();
String OFF_NAME=request.getParameter("OFF_NAME")== null?"%%": js.getOnlyTextspc(request.getParameter("OFF_NAME"),70);
String vcls="";
if (!OFF_NAME.equals("TOTAL")) {
vcls=vcls+"  AND MOM.OFF_NAME1 = '"+OFF_NAME+"'  ";
}





Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
String curdt = df.format(now);
StringBuffer qrysb= new StringBuffer();
 
 

qrysb.append("   SELECT PFO.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     MOM.OFF_NAME1,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     MS.STATE_NM"      );
qrysb.append("   FROM PMEGPNEW_FEEDBACK_ONLINE PFO,"      );
qrysb.append("     APP_DETAIL AD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS"      );
qrysb.append("   WHERE PFO.APP_ID    = AD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD     = MD.STATE_CD  "+vcls+"  "      );



	
	
	


String  STATE_NM="";
String  OFF_NAME1="";
String  AGENCY_TYPE="";
String  APP_ID = "";
String  APP_NAME = "";
String  DISTRICT_NAME= "";










DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
//out.print(qrysb.toString());

%>
    <center>
    <h1>
    <span class="style3">    DETAIL FEEDBACK/VERIFICATION OF PMEGP BENEFICIARY TILL</span><span class="style2"><%= curdt %></span>


  </div>
  <table id="tableid" align="center" class="bordered">
 
  <tr>
    <th><div align="center">Sr.No</div></th>    
    <th><div align="center">Applicant ID </div></th>
    <th><div align="center">Applicant name </div></th>  
    <th><div align="center">Agency</div></th>
	<th><div align="center">Office Name</div></th>
	<th><div align="center">District</div></th>  
    <th><div align="center">State</div></th> 
    <th><div align="center">Detail</div></th>

	</tr>
  
  
   <% 

int srno =0;
 while (rsMain.next()) { 
 
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
srno =srno+1;

%>
<tr>
    <td><div align="center"><%=srno %></div></td>   
    <td><div align="center"><%=APP_ID %></div></td>
    <td><div align="center"><%=APP_NAME %></div></td>    
    <td><div align="center"><%=AGENCY_TYPE%></div></td>
	<td><div align="center"><%=OFF_NAME1%></div></td>   
	<td><div align="center"><%=DISTRICT_NAME%></div></td>
	<td><div align="center"><%=STATE_NM %></div></td>
	<td>
	
	
	<a href="../jsp/PMEGPGenAppForm.jsp?RNAME=PMEGPNEW_ONLINE_FEEDBACK&APP_ID=<%= APP_ID %>">Detail</td>
    </tr>
  
   
  <% }
  rsMain.close();
  db.close();
 
    %>
  
</table>

</form>

</body>
</html>
