<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>Samadhan</TITLE>
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

  <%@ include file = "sessionoutinc.jsp" %>
   
<%
DBCon db= new DBCon();
db.connect(); 

List values=new ArrayList();

//if (vlogin.equals("Y")){
StringBuffer sb= new StringBuffer();
sb.append("   SELECT  boi.INVUPID,bom.mis_off_cd,  TO_CHAR(boi.MONTH_DT,'DD-MON-RRRR') AS MONTH_DT,  boi.UPDOC_EDP,   boi.EDP_NO,  boi.TOTAL_AMT,    "      );
sb.append("   TO_CHAR(boi.FORWARD_DT,'DD-MON-RRRR') AS FORWARD_DT,  TO_CHAR(boi.FOPAY_DT,'DD-MON-RRRR') AS FOPAY_DT,  boi.FOPAY_AMT-boi.TDS_AMT-boi.FO_DISALLOWMENT AS NETPAMENT_SAMADHAN    "      );
sb.append("   FROM bnf_onlineedp_inf boi,bnf_off_mast bom WHERE bom.mis_off_cd = boi.OFF_CD AND TRUNC(boi.MONTH_DT)<='31-MAR-2023' AND bom.OFF_CD=?    "      );
  


values.add(SOFF_CD);

//out.print(sb.toString());
ResultSet rs = db.executeSQL(sb.toString(),values);

String INVUPID="";
String MONTH_DT="";
String UPDOC_EDP="";
String EDP_NO="";
String TOTAL_AMT="";
String FORWARD_DT="";
String FOPAY_DT="";
String NETPAMENT_SAMADHAN="";
String MIS_OFF_CD="";


%>

<div align="center"><h1>Online EDP Payment Details</h1></div>

<TABLE border="1" width="90%" align="center" id="customers">
  <TR>
    <TH width="3%"><DIV align="center">Id.</DIV></TH>
    <TH width="8%"><div align="center">EDP Month</div></TH>
    <TH width="10%"><div align="center">No. of EDP trained</div></TH>
    <TH width="11%"><div align="center">Total Amount payable</div></TH>
    <TH width="11%"><div align="center">Forwarded Date</div></TH>
    <TH width="12%"><DIV align="center">Payment Date</DIV></TH>
    <TH width="9%"><DIV align="center">Net Payment</DIV></TH>
	
	<TH width="11%"> <div align="center">Trainee List </div></TH>
	<TH width="11%"><DIV align="center">Download</DIV></TH>

	<TH width="14%"><DIV align="center">Update</DIV></TH>
	<TH width="14%"><DIV align="center">Certificate</DIV></TH>
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
INVUPID=rs.getString("INVUPID")==null?"":rs.getString("INVUPID");
MONTH_DT=rs.getString("MONTH_DT")==null?"":rs.getString("MONTH_DT");
UPDOC_EDP=rs.getString("UPDOC_EDP")==null?"":rs.getString("UPDOC_EDP");
EDP_NO=rs.getString("EDP_NO")==null?"":rs.getString("EDP_NO");
TOTAL_AMT=rs.getString("TOTAL_AMT")==null?"":rs.getString("TOTAL_AMT");
FORWARD_DT=rs.getString("FORWARD_DT")==null?"":rs.getString("FORWARD_DT");
FOPAY_DT=rs.getString("FOPAY_DT")==null?"":rs.getString("FOPAY_DT");
NETPAMENT_SAMADHAN=rs.getString("NETPAMENT_SAMADHAN")==null?"":rs.getString("NETPAMENT_SAMADHAN");
MIS_OFF_CD=rs.getString("MIS_OFF_CD")==null?"":rs.getString("MIS_OFF_CD");

%>
  <TR>
    <TD><DIV align="center"><%= INVUPID %></DIV></TD>
    <TD><DIV align="center"><%= MONTH_DT %></DIV></TD>
    <TD><DIV align="center"><%= EDP_NO %></DIV></TD>
    <TD><DIV align="center"><%= TOTAL_AMT %></DIV></TD>
    <TD><DIV align="center"><%= FORWARD_DT %></DIV></TD>
    <TD><DIV align="center"><%= FOPAY_DT %></DIV></TD>
    <TD><DIV align="center"><%= NETPAMENT_SAMADHAN %></DIV></TD>
	<TD><DIV align="center"><A href="jasperReports/GenerateExcel.jsp?REPNM=samadhan&STATECD=<%= SSTATE_CD %>&month_dt=<%= MONTH_DT %>&OFFCD=<%=MIS_OFF_CD%>" class="myButton">Download</A></DIV></TD>
	<TD><DIV align="center"><A download href="../../pmegpeportal/samadhanedp/otherdocu/<%= UPDOC_EDP %>" class="myButton">Invoice</A></DIV></TD>
	
	<TD><DIV align="center"><A href="fopay_details.jsp?invupid=<%= INVUPID %>&MONTH_DT=<%= MONTH_DT %>" class="myButton">Payment Details</A></DIV></TD>
	<TD><DIV align="center"><A href="edpCertDetail.jsp?STATECD=<%= SSTATE_CD %>&month_dt=<%= MONTH_DT %>&OFFCD=<%=MIS_OFF_CD%>" class="myButton">Download</A></DIV></TD>
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