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
  <img src="../images/04_01.png" width="998" height="135">
 
  
  <center><h4>BFL DATA ENTRY FORM</h4></center>


<div class="topnav">

  <a class="active" href="../logout.jsp">Logout</a>
   <a href="bnfReportView.jsp">Report</a>
    <a href="indexdetail.jsp">BFL Enter Details</a>

  
</div>

<div style="padding-left:16px">
 
</div> 	


<p>
  <%@ include file = "sessionoutinc.jsp" %>
  
  
  
  <%




//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();
 sb.append(" select BNF_HDID,BNF_SUB_HEAD_LONG_DESC from bnf_head_mast");
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
String BNF_HDID="";
String BNF_SUB_HEAD_LONG_DESC="";
%>
</p>

<table border="1" align="center">
  
  <tr>
    <th width="13%">Srno</th>
    <th width="63%">Budget Head Detail </th>
    <th width="24%">Office</th>
  </tr>
  <%
int count=0;
while (rs.next()) {
count=count+1;
BNF_HDID=rs.getString("BNF_HDID");
BNF_SUB_HEAD_LONG_DESC=rs.getString("BNF_SUB_HEAD_LONG_DESC");
%>
  <tr>
    <td height="40"><%= count %></td>
    <td><%= BNF_SUB_HEAD_LONG_DESC %></td>
    <td><a href="OfficeWiseHead.jsp?PBUDID=<%= BNF_HDID %>&PBNF_NAME=<%= BNF_SUB_HEAD_LONG_DESC %>">View</a> </td>
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