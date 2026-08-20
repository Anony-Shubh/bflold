<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>Update Performance</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/main1.css">

<SCRIPT type="text/javascript">

// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=600,width=1000,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}




</SCRIPT>

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
	background-color:#247839;
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
String UPSTOP="";

ResultSet rs1=db.execSQL("select case when HO_FORW_DATE is null then 'Y' else 'Y' end as UPSTOP from bnf_uc  where  off_cd = "+SOFF_CD+"    ");
	while (rs1.next()) {
UPSTOP=rs1.getString(1);
}
rs1.close();  
//out.print(UPSTOP);

List values=new ArrayList();

//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();

sb.append("SELECT BF.BNF_ID,  BF.YEAR_ID,  TO_CHAR(BF.TR_DATE,'DD-MON-RRRR') AS TR_DATE,  BF.TR_TYPE,  BF.TR_OFFCDFR,  BF.TR_DETAILS, "      );
sb.append("  BF.REMARKS,  BF.TR_OFFCDTO,  BF.TR_AMT, BOM.OFF_NAME1 FROM BNF_FUND BF,BNF_OFF_MAST BOM WHERE BF.TR_OFFCDTO = BOM.OFF_CD AND BF.TR_OFFCDFR=?"      );




values.add(SOFF_CD);
//out.print(sb.toString());
ResultSet rs = db.executeSQL(sb.toString(),values);

String BNF_ID="";
String YEAR_ID="";
String TR_DATE="";
String TR_TYPE="";
String TR_OFFCDFR="";
String TR_DETAILS="";
String REMARKS="";
String TR_OFFCDTO="";
String TR_AMT="";
String OFF_NAME1="";

%>
<BR>
<%if(sselect.equals("2022-23")){%>
<DIV align="center">

<%//if(UPSTOP.equals("N")){%>
<A class="myButton" href="JavaScript:newPopup('releaasertfo.jsp');">ADD NEW</A>
<%//}%>



</DIV><BR>
<%}%>

<TABLE id="customers" border="1" align="center">

  <TR>
    <TH width="5%"><DIV align="center">Srno</DIV></TH>
    <TH width="6%" hidden><DIV align="center">Tr id </DIV></TH>
    <TH width="18%"><DIV align="center">Year</DIV></TH>
	
	<TH width="18%"><DIV align="center">Tr Date </DIV></TH>
	<TH width="20%"><DIV align="center">Transferred to Office </DIV></TH>
	<TH width="15%"><DIV align="center">Amount</DIV></TH>
	<TH width="18%"><DIV align="center">Update</DIV></TH>
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
BNF_ID=rs.getString("BNF_ID");
YEAR_ID=rs.getString("YEAR_ID");
TR_DATE=rs.getString("TR_DATE");
TR_TYPE=rs.getString("TR_TYPE");
TR_OFFCDFR=rs.getString("TR_OFFCDFR");
TR_DETAILS=rs.getString("TR_DETAILS");
REMARKS=rs.getString("REMARKS");
TR_OFFCDTO=rs.getString("TR_OFFCDTO");
TR_AMT=rs.getString("TR_AMT");
OFF_NAME1=rs.getString("OFF_NAME1");

%>
  <TR>
    <TD height="40"><DIV align="center"><%= count %></DIV></TD>
	<TD hidden><DIV align="center"><%= BNF_ID %></DIV></TD>
    <TD><DIV align="center"><%= YEAR_ID %></DIV></TD>
	<TD><DIV align="center"><%= TR_DATE %></DIV></TD>
	<TD><DIV align="center"><%= OFF_NAME1 %></DIV></TD>
	<TD><DIV align="center"><%= TR_AMT %></DIV></TD>
	<TD><DIV align="center">
	
	<%//if(UPSTOP.equals("N")){%>


	<A href="JavaScript:newPopup('releaasertfo.jsp?BNF_ID=<%=BNF_ID%>');" class="myButton">Update</A>
	
	<%//}%>

	</DIV></TD>
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