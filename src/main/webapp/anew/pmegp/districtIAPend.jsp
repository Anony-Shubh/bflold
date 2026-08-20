<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<HEAD>
<STYLE type="text/css">
.myButton {
	background-color:#4e73df;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}

* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
   
}



#customers td, #customers th {
    border: 1px solid #000000;
    padding: 4px;
	font-size:16px;
	font-weight:bold;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: #4e73df;
    color: white;
}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.style1 {color: #FF0000}
</STYLE>

  
</HEAD>

<BODY>
<IMG src="../img/banner3.jpg" width="100%">
<FORM method="post">
<% 
String STATE_NM="";
String STATE_CD="";

String REC_NO = "";
String REC_MM = "";
String SANC_NO = "";
String SANC_MM = "";
String DISB_NO = "";
String DISB_MM = "";
String wcls="";
String srno ="";
String rFromdt="";
String rTodt="";

String YR=request.getParameter("YR")==null?"2020-21":(String) request.getParameter("YR");
String AGENCY=request.getParameter("Agency")==null?"":(String) request.getParameter("Agency");
String vcls="";
String ORG =request.getParameter("Org")==null?"":(String) request.getParameter("Org"); 

if (!AGENCY.equals("TOTAL")) {
vcls= vcls+ " and ms.state_nm='"+AGENCY+"'  and mom.AGENCY_TYPE='"+ORG+"' ";
}
else{

vcls= vcls+ " and ms.state_nm='"+AGENCY+"'  and mom.AGENCY_TYPE='"+ORG+"'   ";

}


if (YR.equals("2016-17")) {
rFromdt ="1-APR-2016";
rTodt="31-MAR-2017";
}

if (YR.equals("2017-18")) {
rFromdt ="1-APR-2017";
rTodt="31-MAR-2018";}

if (YR.equals("2018-19")) {
rFromdt ="1-APR-2018";
rTodt="31-MAR-2019";
}
if (YR.equals("2019-20")) {
rFromdt ="1-APR-2019";
rTodt="31-MAR-2020";
}

if (YR.equals("2020-21")) {
rFromdt ="1-APR-2020";
rTodt="31-MAR-2021";
}
if (YR.equals("ALL")) {
rFromdt ="1-JUL-2016";
rTodt="31-MAR-2020";
}


 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT NVL(AGENCY_TYPE,'TOTAL') AS AGENCY_TYPE,"      );
qrysb.append("     TOT_APP,"      );
qrysb.append("     AGN_REJ,"      );
qrysb.append("   round( ( nvl(agn_rej,0)/nvl(tot_app,0)*100),2) as rej_per,"      );
qrysb.append("     bank_for"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT md.district_name as AGENCY_TYPE,COUNT(*),"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TOT_APP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN AD.ACT_ID = 3"      );
qrysb.append("         AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS AGN_REJ,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN AD.ACT_ID = 5"      );
qrysb.append("         AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+rFromdt+"' AND '"+rTodt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS bank_for"      );
qrysb.append("     FROM APP_DETAIL AD,"      );
qrysb.append("       MAS_OFF_MAST MOM,"      );
qrysb.append("       BANK_DATAENTRY BD,M_DISTRICT MD,M_STATE MS "      );
qrysb.append("     WHERE AD.APP_ID = BD.APP_ID(+)"      );
qrysb.append("     AND AD.OFF_CD   = MOM.OFF_CD(+)"      );
qrysb.append("     AND ad.unit_dist_cd=md.district_cd "      );
qrysb.append("     and md.state_cd=ms.state_cd "+vcls+"   "      );
qrysb.append("     GROUP BY ROLLUP (md.district_name) ORDER BY COUNT(*) DESC "      );
qrysb.append("     )WHERE TOT_APP >0"      );

DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<CENTER>
  <H1>  Status of Application Approved for the period from <%= rFromdt %> to <%= rTodt %> of <%=AGENCY%> for <%=ORG%>
<A href="../pmegp/index.jsp" class="button" >Back</A></H1>
</CENTER>

<%= srno %>
<DIV id="wrapper">
<TABLE align="center" cellpadding="2" cellspacing="10" id="customers">
 <THEAD>
    <TR>
	 <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">Sr No</DIV></TH>
	 <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">Name</DIV></TH>
    <TH colspan="3" bgcolor="#FCDCF4"><DIV align="center">Nos. of Application recieved during current year </DIV></TH>
    <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">No of Application rejected by the IA</DIV></TH>
    <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">% of the Application rejected by IA of the total recieved</DIV></TH>
	 <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">No of application forwarded to bank by the IA</DIV></TH>
    </TR>
    <TR>
      <TH bgcolor="#FCDCF4"><%=rFromdt%></TH>
      <TH bgcolor="#FCDCF4">To</TH>
      <TH bgcolor="#FCDCF4"><%=rTodt%></TH>
    </TR>
   </THEAD>
  
<TBODY>
<% 
int cnt=0;
 while (rsMain.next()) { 
 STATE_NM=rsMain.getString("agency_type")==null?"":rsMain.getString("agency_type");
//STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
REC_NO=rsMain.getString("TOT_APP")==null?"":rsMain.getString("TOT_APP");
REC_MM=rsMain.getString("AGN_REJ")==null?"":rsMain.getString("AGN_REJ");
SANC_NO=rsMain.getString("rej_per")==null?"":rsMain.getString("rej_per");
SANC_MM=rsMain.getString("bank_for")==null?"":rsMain.getString("bank_for");
//DISB_NO=rsMain.getString("DISB_NO")==null?"":rsMain.getString("DISB_NO");
//DISB_MM=rsMain.getString("DISB_MM")==null?"":rsMain.getString("DISB_MM");

cnt=cnt+1;

%>
  <TR>
    <TD><DIV align="center"><%= cnt %></DIV></TD>
     <TD><DIV align="left"><%= STATE_NM %></DIV></TD>
    <TD colspan="3"><DIV align="center"><%= REC_NO %></DIV></TD>
    <TD><DIV align="center"><%= REC_MM %></DIV></TD>
	<TD><DIV align="center"><%= SANC_NO %></DIV></TD>
		<TD><DIV align="center"><%= SANC_MM %></DIV></TD>
	</TR>
  </TBODY>
   <%  }
  rsMain.close();
  db.close();
    %>
	<TFOOT>
	<TR>
    <TH bgcolor="#FCDCF4"><DIV align="center">Sr No</DIV></TH>
    <TH bgcolor="#FCDCF4"><DIV align="center">Name</DIV></TH>
   <TH colspan="3" bgcolor="#FCDCF4"><DIV align="center">Nos. of Application recieved during current year </DIV></TH>
   <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">No of Application rejected by the IA</DIV></TH>
    <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">% of the Application rejected by IA of the total recieved</DIV></TH>
	 <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">No of application forwarded to bank by the IA</DIV></TH>
   </TFOOT>
</TABLE>
</DIV>
<SCRIPT type="text/javascript">
$(function(){
  $('#keywords').tablesorter(); 
});
</SCRIPT>
</FORM>
</BODY>
</HTML>
