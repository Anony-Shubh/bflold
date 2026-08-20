<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%
 StringBuffer sb= new StringBuffer();
 sb.append(" select STATE_NM from M_STATE");

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
    <th height="25%" colspan="15" bgcolor="#F0F0F0"><div align="center">
      <blockquote>&nbsp; </blockquote>
    </div>      <blockquote><p align="center"> STATE AND AGENCYWISE TENTATIVE BUDGET/ACTION PLAN OF AWARENESS CAMPS FOR THE YEAR 2018-19 (BE) UNDER PRIME MINISTER EMPLOYMENT GENERATION PROGRAMME </p>
    </blockquote></th>
    </tr>
  
  <tr>
    <td height="36%"><div align="center">Sr. No </div></td>
    <td><div align="center">Name of the state </div></td>
    <td colspan="3"><div align="center">TOTAL REQUIREMENT 2018-19 </div></td>
    <td colspan="8"><div align="center">ACTION PLAN/BGT. ALLOCATION OF DIST. AWARENESS CAMPS IN RS.40CR. </div></td>
    </tr>
  <tr>
    
    <td width="35" height="36%"><div align="center"></div></td>
    <td width="76"><div align="center"></div></td>
	<td width="55"><div align="center">NO OF DIST </div></td>
	<td width="68"><div align="center">Required DAC </div></td>
	<td width="51"><div align="center">AMT.</div></td>
	<td colspan="2"><div align="center">KVIC</div></td>
	<td colspan="2"><div align="center">KVIB</div></td>
	<td colspan="2"><div align="center">DIC</div></td>
	<td colspan="2"><div align="center">TOTAL</div></td>
	</tr>
  <tr>
    <td height="36%"><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td width="42"><div align="center">No.</div></td>
    <td width="46"><div align="center">Amt.</div></td>
    <td width="40"><div align="center">No.</div></td>
    <td width="38"><div align="center">Amt.</div></td>
    <td width="34"><div align="center">No.</div></td>
    <td width="38"><div align="center">Amt.</div></td>
    <td width="78">
      <div align="center">No.</div></td>
    <td width="84"><div align="center">Amt.</div></td>
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
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
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
