<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>Message for reset Password</title>
 <link rel="stylesheet" type="text/css" href="../css/dis.css">

<style>
.outer{
width:325px;
height:325px;
border: 2px solid blue; 
padding: 5px;
margin:0 auto;	
margin-top:150px;
text-align:center;
}
.style1 {color: #FF0000}
</style> 
 
</head>

<body>

<form name ="form">
<%@ include file="IncludeHeader.jsp" %>
<%
String WRD_PW="";

 DBCon db= new DBCon();
 db.connect();
  List values=new ArrayList();


   StringBuffer qry = new StringBuffer();
         qry.append(" SELECT BU.USER_NM, ");
		   qry.append(" BM.PSSWD  ");		   
			  qry.append("FROM BANK_BR_MAST BM,BU_USERMAST BU  ");
			   qry.append(" WHERE BM.N_IFSC_CODE=BU.IFSL_CODE AND BM.BR_IFSL_CODE = ?  ");
		
			  values.add(IFSC_CODE);
		  ResultSet rsApp = db.executeSQL(qry.toString(),values);
		  values.clear();
		   while (rsApp.next()){
		WRD_PW=rsApp.getString("PSSWD")==null?"":rsApp.getString("PSSWD");
		   }
		   			rsApp.close();
					db.close();
%>

<center><img src="../images/data.jpeg" width="30%"></center><br/><br/>
<b><center>
  <p>Data Saved Successfully</p>
  </center>
</b><BR/>
<table align="center">
  <tr>
    <th colspan="2"><p>Your New Password  is <span class="style1"><%=WRD_PW%></span> </p>
     <BR/>      
  </tr>
<tr><td><input name="Button" type="button" class="button" onclick=" closeAndRefresh();" value="Close"/><td>
 
</tr>
</table>
  

</form>
</body>

</html>
