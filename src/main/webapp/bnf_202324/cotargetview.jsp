<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>TARGET</TITLE>
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


</STYLE>

<BODY>

<FORM method="post" name="form">

  <%@ include file = "sessionoutinc.jsp" %>
    
  <%
//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();

 

if(sselect.equals("2021-22")){
 sb.append(" select BNF_HDID,BNF_SUB_HEAD_LONG_DESC from bnf_head_mast where ACT_YN='Y' AND BNF_HDID in (select BNF_HDID from bnf_mis_yearwise)");

}else {
sb.append(" select BNF_HDID,BNF_SUB_HEAD_LONG_DESC from bnf_head_mast where ACT_YN='Y'    ");
}

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

<H2 align="center">TARGET</H2>

<TABLE border="1" align="center" id="customers2">
  
  <TR>
    <TH width="13%"><DIV align="center">Srno</DIV></TH>
    <TH width="63%"><DIV align="center">Budget Head Detail </DIV></TH>
    <TH width="24%"><DIV align="center">Office</DIV></TH>
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
BNF_HDID=rs.getString("BNF_HDID");
BNF_SUB_HEAD_LONG_DESC=rs.getString("BNF_SUB_HEAD_LONG_DESC");
%>
  <TR>
    <TD height="40"><DIV align="center"><%= count %></DIV></TD>
    <TD><DIV align="center"><%= BNF_SUB_HEAD_LONG_DESC %></DIV></TD>
    <TD><DIV align="center"><A href="OfficeWiseHead.jsp?PBUDID=<%= BNF_HDID %>&PBNF_NAME=<%= BNF_SUB_HEAD_LONG_DESC %>" class="myButton">View</A> </DIV></TD>
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