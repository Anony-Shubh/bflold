<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>PROPOSED ACTION PLAN</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
</head>

<style>
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}


</style>

<body>

<form method="post" name="form">



<p>
  <%@ include file = "sessionoutinc.jsp" %>
   
  <%
  
List values=new ArrayList();

//if (vlogin.equals("Y")){
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT BFT.OFF_CD,"      );
qrysb.append("     BFT.BNF_TRID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     BFT.TR_DATE,"      );
qrysb.append("      BFT.FIN_KVIC+BFT.FIN_KVIB+ BFT.FIN_DIC AS FIN_TOTAL,"      );
qrysb.append("     BFT.PH_KVIB+ BFT.PH_KVIC+BFT.PH_DIC AS PH_TOTAL,"      );
qrysb.append("    "      );
qrysb.append("     BFT.CB_FNO,"      );
qrysb.append("     BFT.BNF_PLACE,"      );
qrysb.append("     BFT.ADD_RMRK,"      );
qrysb.append("     BFT.TIMESTAMP"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );



DBCon db= new DBCon();
db.connect();

values.add(SOFF_CD);

ResultSet rs = db.executeSQL(sb.toString(),values);

String BNF_TRID = "";
String OFF_CD = "";
String BUD_ID = "";
String TR_DATE = "";
String PH_KVIC = "";
String PH_KVIB = "";
String PH_DIC = "";
String FIN_KVIC = "";
String FIN_KVIB = "";
String FIN_DIC = "";
String CB_FNO = "";
String BNF_PLACE = "";
String TIMESTAMP = "";
%>
</p>
<table border="1" align="center">
  <tr>
    <th width="6%">Srno</th>
    <th width="8%" hidden>BNF TRID</th>
    <th width="31%">Office Code</th>
	<th width="18%">Date</th>
	<th width="19%">Total Physical No</th>
	<th width="19%">Total Financial Amt</th>
	<th width="18%">CB FNO</th>
	<th width="18%">Date</th>
	<th width="18%">Place</th>
	<th width="18%">Timestam</th>
	<th width="18%">Add/Update</th>
  </tr>
  <%
int count=0;
while (rs.next()) {
count=count+1;
BNF_TRID=rs.getString("BNF_TRID");
OFF_CD=rs.getString("OFF_CD");
BUD_ID=rs.getString("BUD_ID");
TR_DATE=rs.getString("TR_DATE");
PH_KVIC=rs.getString("PH_KVIC");
PH_KVIB=rs.getString("PH_KVIB");
PH_DIC=rs.getString("PH_DIC");
FIN_KVIC=rs.getString("FIN_KVIC");
FIN_KVIB=rs.getString("FIN_KVIB");
FIN_DIC=rs.getString("FIN_DIC");
CB_FNO=rs.getString("CB_FNO");
BNF_PLACE=rs.getString("BNF_PLACE");
TIMESTAMP=rs.getString("TIMESTAMP");





%>
  <tr>
    <td height="40"><%= count %></td>
	<td><%= BNF_TRID %></td>
	<td><%= OFF_CD %></td>
	<td><%= BUD_ID %></td>
	<td><%= TR_DATE %></td>
	<td><%= PH_KVIC %></td>
	<td><%= PH_KVIB %></td>
	<td><%= PH_DIC %></td>
	<td><%= FIN_KVIC %></td>
	<td><%= FIN_KVIB %></td>
	<td><%= FIN_DIC %></td>
	<td><%= CB_FNO %></td>
	<td><%= BNF_PLACE %></td>
	<td><%= TIMESTAMP %></td>
	<td><a href="#">Add/Update</td>
	
    
  </tr>
  <%

}
rs.close();
db.close();
%>
</table>
</form>

</body>
</html>