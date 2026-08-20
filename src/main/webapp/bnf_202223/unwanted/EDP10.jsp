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
    <th height="25%" colspan="17" bgcolor="#F0F0F0"><blockquote>
      <p align="center"> STATEMENT SHOWING CATEGORIWISE TARGETS OF TEN DAYS EDP TRAINING OF PMEGP FOR THE YEAR 2018-19 (BE) (APPOX. 52% OF TOTAL REQUIREMENT FOR THE YEAR 2018-19 @ RS.500/- PER TRAINEE PER DAY.) </p>
    </blockquote></th>
    </tr>
  <tr>
    <th height="26%" colspan="17" bgcolor="#F0F0F0"> <div align="right">(Rs. In lakhs)</div></th>
  </tr>
  <tr>
    <td height="36%"><div align="center">Sr. No </div></td>
    <td><div align="center">SO/DO</div></td>
    <td colspan="2"><div align="center">TOTAL REQUIREMENT 2018-19 </div></td>
    <td colspan="9"><div align="center">PROPOSED ACTION PLAN/BUDGET ALLOCATION WITH IN 40.00 CR. </div></td>
    <td colspan="2" rowspan="2"><div align="center">TOTAL</div></td>
  </tr>
  <tr>
    
    <td width="26" height="36%">&nbsp;</td>
    <td width="51">&nbsp;</td>
	<td width="64"><div align="center">NO.</div></td>
	<td width="56"><div align="center">AMT.</div></td>
	<td width="58"><div align="center">52% OF REOMT NO. </div></td>
	<td colspan="2"><div align="center">STATEWISE SC/ST% </div></td>
	<td colspan="2"><div align="center">SC</div></td>
	<td colspan="2"><div align="center">ST</div></td>
	<td colspan="2">OTHERS</td>
	</tr>
  <tr>
    <td height="36%">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td width="53"><div align="center">SC%</div></td>
    <td width="39"><div align="center">ST%</div></td>
    <td width="39"><div align="center">NOS.</div></td>
    <td width="38"><div align="center">AMT.</div></td>
    <td width="39"><div align="center">NOS.</div></td>
    <td width="38"><div align="center">AMT.</div></td>
    <td width="39"><div align="center">NOS.</div></td>
    <td width="38"><div align="center">AMT.</div></td>
    <td width="40"><div align="center">NOS.</div></td>
    <td width="55"><div align="center">AMT.</div></td>
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
