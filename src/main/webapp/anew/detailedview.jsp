<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>Update Performance</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">
</HEAD>

<STYLE>
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

.myButton {
	background-color:#2e823c;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
</STYLE>

<BODY>

<FORM method="post" name="form">

   
  <%
List values=new ArrayList();
String STATE_CD=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
String id=request.getParameter("id")==null?"":(String)request.getParameter("id");
//String id=request.getParameter("count"); 
//String buffer="<TD id='STATE_NM' ></TD>";

out.print(id); 
//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();
sb.append("   SELECT MD.DISTRICT_NAME, MS.STATE_NM FROM M_DISTRICT MD, M_STATE MS WHERE MD.STATE_CD = MS.STATE_CD and MS.STATE_CD='MH' order by MS.STATE_NM    "      );

DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());
//ResultSet rs = db.executeSQL(sb.toString(),values);
ResultSet rs = db.execSQL(sb.toString());

String DISTRICT_NAME="";
String STATE_NM="";


%>
<TABLE border="1" align="center" id="customers">
  
  <TR>
    <TH width="5%"><DIV align="center">Srno</DIV></TH>
    <TH width="6%" hidden><DIV align="center">Office Code</DIV></TH>
  
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");


%>
  <TR>
    <TD height="40"><DIV align="center"><%= DISTRICT_NAME %></DIV></TD>
	<TD ><DIV align="center"><%= STATE_NM %></DIV></TD>
  
  </TR>
  <%

}
rs.close();
db.close();
%>
</TABLE>
</FORM>

</BODY>
</HTML>