<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />

</head>

<body>
<form name="form" id="form" class="form" method="post">
  <p>
    <% 

    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();

qrysb.append(" SELECT RM.REJ_ID, RM.REJ_DESC, RM.SEV_YN FROM REJECTION_MAST RM " );

 ResultSet rsMain = db.execSQL(qrysb.toString());

  %>
  
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th> Code </th>
      <th> <div align="left">Reason for Return/Rejection </div></th>
      <th>&nbsp;</th>
    </tr>
	
	</thead>
	
	<%
	String REJ_ID="";
	String REJ_DESC="";
	String SEV_YN="";
	
	while (rsMain.next()){
REJ_ID=rsMain.getString("REJ_ID")==null?"":rsMain.getString("REJ_ID");
REJ_DESC=rsMain.getString("REJ_DESC")==null?"":rsMain.getString("REJ_DESC");
SEV_YN=rsMain.getString("SEV_YN")==null?"":rsMain.getString("SEV_YN");
	%>
	
    <tr>
      <td><%= REJ_ID %></td>
      <td>
        <div align="left">     <%= REJ_DESC %>   </div></td>
      <td><input name="btnSelectBank" type="button" class="button1" id="btnSelectBank" value="Select"></td>
    </tr>
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>
</table>
