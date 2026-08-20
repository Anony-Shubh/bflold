<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>BNF2INDEX</title>
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

<img src="../images/04_01.png" width="1003" height="135">
<center>
<h4>LOGIN</h4>
</center>
<div class="topnav">
</div>

<div style="padding-left:16px">
 
</div> 	

<form method="post" name="form">
<p>
   
<%
  
//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();

sb.append("SELECT ZONE_NM, OFF_NAME1 FROM BNF_OFF_MAST"      );


DBCon db= new DBCon();
db.connect();
ResultSet rs = db.execSQL(sb.toString());
String ZONE_NM="";
String OFF_NAME1="";

%>
</p>

<table border="1" align="center">
  
  <tr>
    <th width="10%">Srno</th>
	<th width="20%">Zone</th>
    <th width="30%">Office</th>
	<th width="20%">Login</th>
    
  </tr>
  <%
int count=0;
while (rs.next()) {
count=count+1;
ZONE_NM=rs.getString("ZONE_NM");
OFF_NAME1=rs.getString("OFF_NAME1");

%>
  <tr>
    <td height="40"><%= count %></td>
	 <td><%= ZONE_NM %></td>
    <td><%= OFF_NAME1 %></td>
	<td><a href="index111.jsp">Login</a> </td>
   
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