<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Dashboard</title>

<head>
<style>
<!--
.style4 {font-family: "Times New Roman", Times, serif}
-->

.box{background-color: #00FFFF;
  width: 300px;
  border: 15px solid #000000;
  padding: 26px;
  margin: 5px;}
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-style: italic;
	font-weight: bold;
}
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}

.btn {
  background:linear-gradient(#ffc477, #fb9e25);
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
</style>

</head>

<body>


<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
String username=session.getAttribute("username")==null?"0":(String)session.getAttribute("username");

if(username.equals("0")){
response.sendRedirect("../logout.jsp");
}

String final_sub_dt="";
String ALLTOT="";


StringBuffer poR = new StringBuffer();

poR.append(" SELECT ");
poR.append("(SELECT COUNT(APP_ID) FROM PMEGP_AWARD ) AS ALLTOT, ");
poR.append("(SELECT COUNT(final_sub_dt) AS submited FROM PMEGP_AWARD WHERE final_sub_dt is not null) AS final_sub_dt ");
poR.append("FROM DUAL ");

ResultSet rsMain = db.execSQL(poR.toString());
while (rsMain.next()){

final_sub_dt=rsMain.getString("final_sub_dt")==null?"":rsMain.getString("final_sub_dt");
ALLTOT=rsMain.getString("ALLTOT")==null?"":rsMain.getString("ALLTOT");
}

rsMain.close();
//out.print(final_sub_dt);
%>


<img src="../images/nomination.jpeg" width="100%" border="" >
<div align="center">
<br><br>
<a href="dashboard.jsp" class="btn">Home</a>

<a href="../logout.jsp" class="btn">Logout</a>

<h1>PMEGP NATIONAL AWARD STATEWISE SUMMARY</h1></div>

<table width="60%" align="center" >

<tr>
<td align="center" >
<DIV align="center" class="box" >
  <h2 class="style4">No. of applications <br>Registered  </h2>
  <p class="style4">&nbsp;</p>
  <h2> <%=ALLTOT %></h2>
</DIV>
</td>
<td  align="center">
<DIV align="center" class="box" >
  <h2 class="style4">No. of applications Submitted</h2>
  <p class="style4">&nbsp;</p>
  <h2> <%=final_sub_dt %> </h2></DIV>
</tr>
<tr>
<td>
</td>
<td>

<div align="right" >
  <a href="state.jsp"><h2 >Read more...</h2></a>
</div>
</td>
</tr>
</table>
<% db.close(); %>
</body>

</html>
