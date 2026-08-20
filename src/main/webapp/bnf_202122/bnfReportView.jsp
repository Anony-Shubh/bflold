<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="main1.css">

<title>HO::Report</title>
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

<%@ include file = "sessionoutinc.jsp" %>
<center>
  <H2>HO REPORT</H2>
</center>


<form method="post" name="form" id="form">
  <table border="1" align="center" id="customers2">
    <tbody>
      <tr>
        <th width="13%"><div align="center">Srno</div></th>
        <th width="63%"><div align="center">Budget Head Detail</div></th>
        <th width="24%"><div align="center">Report</div></th>
      </tr>
      <tr>
        <td height="40"><div align="center">1</div></td>
        <td><div align="center">EDP 10 DAYS</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=1&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">2</div></td>
        <td><div align="center">Physical Verification</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=2&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">3</div></td>
        <td><div align="center">Dist. Level Awareness Camps</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=awarness&BGTID=3&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">4</div></td>
        <td><div align="center">State Level Workshop</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=4&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">5</div></td>
        <td><div align="center">Dist. Level Exhibitions</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=5&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">6</div></td>
        <td><div align="center">State Level Exhibition</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=6&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">7</div></td>
        <td><div align="center">Zonal Level Exhibition</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=7&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">8</div></td>
        <td><div align="center">Zonal Level Review Meeting</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=8&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">9</div></td>
        <td><div align="center">Quarterly Bankers Review Meeting</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=9&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">10</div></td>
        <td><div align="center">State Level Monitoring Committee Meeting</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=10&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">11</div></td>
        <td><div align="center">Staff Training Workshops</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=11&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">12</div></td>
        <td><div align="center">TA/DA of staff &amp; officers</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=12&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">13</div></td>
        <td><div align="center">PROMOTIONAL AND PUBLICITY</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=13&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
      <tr>
        <td height="40"><div align="center">14</div></td>
        <td><div align="center">Data Entry Operators</div></td>
        <td><div align="center"><a href="jasperReports/bnfreportbudget.jsp?REP_NM=bnfconsolidatetarget&BGTID=14&YEAR_ID=<%= sselect %>" target="_blank" class="myButton">View</a></div></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
