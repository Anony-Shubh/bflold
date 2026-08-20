<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%
 StringBuffer sb= new StringBuffer();
 sb.append(" select STATE_NM from M_STATE");
/*
BNF_HDID                NOT NULL NUMBER(3)    
BNF_MAIN_HEAD_LONG_DESC NOT NULL VARCHAR2(90) 
BNF_MAIN_HEAD_SH_DESC   NOT NULL VARCHAR2(90) 
BNF_SUB_HEAD_LONG_DESC  NOT NULL VARCHAR2(90) 
BNF_SUB_HEAD_SH_DESC    NOT NULL VARCHAR2(90) 
ACT_YN                           VARCHAR2(1)  
*/
DBCon db= new DBCon();
db.connect();
ResultSet rs = db.execSQL(sb.toString());
String STATE_NM="";

%>
<head>
<title>EDP 10 DAYS</title>
<link rel="stylesheet" href="art.css"/>
</head>

<body>

<form method="post" name="form">
<table height="60%" border="1" align="center">
  <tr>
    <th height="25%" colspan="6" bgcolor="#F0F0F0"><blockquote>PRIME MINISTER'S EMPLOYMENT GENERATION PROGRAMME </blockquote></th>
    </tr>
  <tr>
    <th height="26%" colspan="6" bgcolor="#F0F0F0">BUDGET/ACTION PLAN OF PHYSICAL VERIFICATION FOR THE YEAR 2018-19 (BE) (OF PMEGP UNITS SANCTIONED DURING 2014-15) </th>
  </tr>
  <tr>
    <th height="26%" colspan="6" bgcolor="#F0F0F0"><div align="right">(Rs. In lakhs)</div></th>
  </tr>
  <tr>
    <th height="26%" colspan="6" bgcolor="#F0F0F0"> <div align="right">Average Rs.650/- per unit. </div></th>
  </tr>
  <tr>
    <td height="36%"><div align="center">Sr. No </div></td>
    <td><div align="center">State/UT</div></td>
    <td><div align="center">No. of project financed during 2014-15 </div></td>
    <td><div align="center">Amt. (Rs. Lakhs) - Physical verification </div></td>
    </tr>
  <tr>
    
    <td width="26" height="36%">&nbsp;</td>
    <td width="51">&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	</tr>
  <tr>
    <td height="36%">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
<%

while (rs.next()) {
STATE_NM=rs.getString("STATE_NM");

%>

  <tr>
    <td height="13%">&nbsp;</td>
	<td><%= STATE_NM  %></td>
	<td></td>
	<td></td>
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
