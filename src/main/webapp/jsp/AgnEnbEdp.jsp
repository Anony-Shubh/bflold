<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
</head>

<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>
<body>
<%
String  vAPP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String ENB_YN="";
DBCon db= new DBCon();
db.connect();
 session.setAttribute("APP_ID", vAPP_ID);	
StringBuffer qrysb= new StringBuffer();

qrysb.append(" SELECT ENB_YN FROM EDP_CONDUCT_TRANS WHERE APP_ID='"+vAPP_ID+"' ");

ResultSet rsMain = db.execSQL(qrysb.toString());

while (rsMain.next()){
ENB_YN=rsMain.getString("ENB_YN")==null?"":rsMain.getString("ENB_YN");
}
rsMain.close();

if (ENB_YN.equals("Y")){
response.sendRedirect("AgnedpDetail.jsp");
}
else if (ENB_YN.equals("N")){
response.sendRedirect("AgnedpDetailN.jsp");
}
else {
out.print("<div align=center class=redLebel>EDP Option Not Updated By the Applicant</div>");
}

%>
</body>
</html>