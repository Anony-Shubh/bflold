<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

<style type="text/css">
<!--
.style2 {
	color: #0000A0;
	font-size: xx-large;
}
-->
</style>
</head>

<body>
<div align="center"><img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
  <%
DBCon db= new DBCon();
db.connect();
Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();
qrysb.append("     SELECT COUNT(PFO.APP_ID) AS NO_OF_FEED_REC,MAX(MOM.OFF_CD) AS OFF_CD,NVL(MOM.OFF_NAME1 ,'TOTAL') AS OFF_NAME1 FROM PMEGPNEW_FEEDBACK_ONLINE PFO, "      );
qrysb.append("     APP_DETAIL AD,MAS_OFF_MAST MOM WHERE AD.APP_ID = PFO.APP_ID AND AD.OFF_CD   = MOM.OFF_CD"      );
qrysb.append("     GROUP BY ROLLUP(  MOM.OFF_NAME1) "      );

//out.print (qrysb.toString());

 
String  OFF_NAME1 = "";
String  NO_OF_FEED_REC = "";
String OFF_CD="0";
ResultSet rsMain = db.execSQL(qrysb.toString());


%>
  <center>
  <span class="style2">
  <h2>Feedback From PMEGP Beneficiares 2016-17</div>
<table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th><div align="center">SRNO</div></th>   
    <th><div align="center">OFFICE NAME</div></th>
	<th><div align="center">NO OF FEEDBACK RECIEVED</div></th>	
  </tr>
  </thead>
  <%
  int srno =0;
  while (rsMain.next()) { 

OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"Grand Total":rsMain.getString("OFF_NAME1");
NO_OF_FEED_REC = rsMain.getString("NO_OF_FEED_REC")==null?"Grand Total":rsMain.getString("NO_OF_FEED_REC");
OFF_CD= rsMain.getString("OFF_CD")==null?"0":rsMain.getString("OFF_CD");
srno =srno+1;	
%>




<tbody>

  <tr>
    <td><%=srno %></td>
	<td nowrap><%=OFF_NAME1 %></td>	
    <td><a href="detailFeedBackrepo.jsp?OFF_NAME=<%=OFF_NAME1 %>"><%=NO_OF_FEED_REC%></td>
	
  </tr>
  </tbody>
   
  <%  }
  rsMain.close();
  db.close();
    %>
   
</table>

</body>
</html>
