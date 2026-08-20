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

  <%@ include file = "sessionoutinc.jsp" %>
   
<%
DBCon db= new DBCon();
db.connect(); 

String UPSTOP="";

ResultSet rs1=db.execSQL("select case when HO_FORW_DATE is null then 'N' else 'Y' end as UPSTOP from bnf_uc  where  off_cd = "+SOFF_CD+"    ");
	while (rs1.next()) {
UPSTOP=rs1.getString(1);
}
rs1.close();  
//out.print(UPSTOP);
  
List values=new ArrayList();

//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();
sb.append("   SELECT BBM.OFF_CD,"      );
sb.append("         nvl(BBM.FIN_AMT_KVIC,0) + nvl(BBM.FIN_AMT_DIC,0) + nvl(BBM.FIN_AMT_KVIB,0) AS FIN_AMT,"      );
sb.append("         nvl(BBM.PHY_NO_KVIC,0)  + nvl(BBM.PHY_NO_KVIB,0) + nvl(BBM.PHY_NO_DIC,0)   AS PHY_NO,"      );
sb.append("         BBM.BNF_HDID,"      );
sb.append("         BBM.BNF_BUDID,"      );
sb.append("         BHM.BNF_SUB_HEAD_SH_DESC"      );
sb.append("       FROM BNF_BUDGET_MAST BBM,"      );
sb.append("         BNF_HEAD_MAST BHM"      );
sb.append("       WHERE BBM.BNF_HDID = BHM.BNF_HDID AND BBM.YEAR_ID='"+sselect+"' AND OFF_CD=? "      );




values.add(SOFF_CD);

//out.print(sb.toString());
ResultSet rs = db.executeSQL(sb.toString(),values);

String OFF_CD="";
String PHY_NO="";
String FIN_AMT="";
String BNF_BUDID="";
String BNF_HDID="";
String BNF_SUB_HEAD_SH_DESC="";


%>
<BR>
<TABLE border="1" align="center" id="customers">
  
  <TR hidden>
    <TH colspan="3"><DIV align="center">TOTAL PHYSICAL BALANCE= <%= SNO_BAL %></DIV></TH>
    <TH colspan="3"><DIV align="center">TOTAL FINANCIAL BALANCE= <%= SAMT_BAL %></DIV></TH>
    </TR>
  <TR>
    <TH width="5%"><DIV align="center">Srno</DIV></TH>
    <TH width="6%" hidden><DIV align="center">Office Code</DIV></TH>
    <TH width="26%"><DIV align="center">Budget Head Detail</DIV></TH>
	
	<TH width="22%"><DIV align="center">Physical Target </DIV></TH>
	<TH width="18%"><DIV align="center">Financial Target</DIV></TH>
	<%if(!sselect.equals("2021-22"))      {%>
	<TH width="6%"><DIV align="center">View</DIV></TH>
	<%} else {%>
	
	
	<TH width="17%"><DIV align="center">Add/Update</DIV></TH>
	<%}%>
	
	
	
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
BNF_HDID=rs.getString("BNF_HDID");
OFF_CD=rs.getString("OFF_CD");
FIN_AMT=rs.getString("FIN_AMT");
PHY_NO=rs.getString("PHY_NO");
BNF_BUDID=rs.getString("BNF_BUDID");
BNF_SUB_HEAD_SH_DESC=rs.getString("BNF_SUB_HEAD_SH_DESC");

%>
  <TR>
    <TD height="40"><DIV align="center"><%= count %></DIV></TD>
	<TD hidden><DIV align="center"><%= OFF_CD %></DIV></TD>
    <TD><DIV align="center"><%= BNF_SUB_HEAD_SH_DESC %></DIV></TD>
	<TD><%= PHY_NO %></TD>
	<TD><%= FIN_AMT %></TD>
	<%if(!sselect.equals("2021-22")){%>
	<TD><DIV align="center"><A href="deviewform.jsp?PBNF_HDID=<%=BNF_HDID  %>&BNF_SUB_HEAD_SH_DESC=<%= BNF_SUB_HEAD_SH_DESC %>" class="myButton">View</A></DIV></TD>
	<%} else {%>

	
	
	<TD><DIV align="center">
	<%if(UPSTOP.equals("N")){%>
	<A href="deviewform.jsp?PBNF_HDID=<%=BNF_HDID  %>&BNF_SUB_HEAD_SH_DESC=<%= BNF_SUB_HEAD_SH_DESC %>" class="myButton">Add/Update</A>
	<%}else{%>
	-
	<%}%>
	</DIV></TD>
	
	
	<%}%>
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