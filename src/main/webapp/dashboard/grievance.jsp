<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<HEAD>
<LINK rel="stylesheet" type="text/css" href="../css/lov.css"/>
<SCRIPT src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/jquery.freezeheader.js"></SCRIPT>
<SCRIPT>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</SCRIPT>

<STYLE type="text/css">
<!--
.style1 {
	color: #804000;
	font-size: 16px;
}
.style2 {color: #0000A0}
-->
</STYLE>
</HEAD>

<BODY>
<IMG src="../images/pmegponlineN.jpg"  height="20%" width="100%">


<%
DBCon db= new DBCon();
db.connect();

String  GRIV_DT = "";
String  IA_GRIV = "";
String  IA_CLOSED = "";
String  IA_PENDING = "";
String  BANK_GRIV = "";
String  BANK_CLOSED = "";
String  BANK_PENDING = "";
String  OTH_GRIV = "";
String  OTH_CLOSED = "";
String  OTH_PENDING = "";
String  IT_GRIV = "";
String  IT_CLOSED = "";
String  IT_PENDING = "";
String  NO_OF_GRI = "";
String  CLOSED = "";
String  PENDING = "";

 StringBuffer qrysb= new StringBuffer();
 
qrysb.append("   SELECT TO_CHAR(GRIV_DT,'DD-MON-RRRR') AS GRIV_DT, IA_GRIV, IA_CLOSED, IA_PENDING, BANK_GRIV, BANK_CLOSED, BANK_PENDING, "      );
qrysb.append("     OTH_GRIV,  OTH_CLOSED, OTH_PENDING, IT_GRIV, IT_CLOSED, IT_PENDING, NO_OF_GRI, CLOSED, PENDING FROM ( "      );

qrysb.append("   SELECT trunc(P.GR_TIMESTAMP) GRIV_DT,"      );
qrysb.append("      "      );
qrysb.append("      SUM(DECODE(G.SUB_ID,1,1,0)) AS IA_GRIV,"      );
qrysb.append("       sum( nvl(case when   P.act_id=3 AND G.SUB_ID=1  then 1 end ,0)) as IA_CLOSED,"      );
qrysb.append("         sum( nvl(case when   P.act_id<>3 AND G.SUB_ID=1  then 1 end ,0)) as IA_PENDING,"      );
qrysb.append("      SUM(DECODE(G.SUB_ID,2,1,0)) AS BANK_GRIV,"      );
qrysb.append("        sum( nvl(case when   P.act_id=3 AND G.SUB_ID=2  then 1 end ,0)) as BANK_CLOSED,"      );
qrysb.append("         sum( nvl(case when   P.act_id<>3 AND G.SUB_ID=2  then 1 end ,0)) as BANK_PENDING,"      );
qrysb.append("      SUM(DECODE(G.SUB_ID,3,1,0)) AS OTH_GRIV,"      );
qrysb.append("      sum( nvl(case when   P.act_id=3 AND G.SUB_ID=3  then 1 end ,0)) as OTH_CLOSED,"      );
qrysb.append("       sum( nvl(case when   P.act_id<>3 AND G.SUB_ID=3  then 1 end ,0)) as OTH_PENDING,"      );
qrysb.append("      SUM(DECODE(G.SUB_ID,4,1,0)) AS IT_GRIV,"      );
qrysb.append("       sum( nvl(case when   P.act_id=3 AND G.SUB_ID=4  then 1 end ,0)) as IT_CLOSED,"      );
qrysb.append("        sum( nvl(case when   P.act_id<>3 AND G.SUB_ID=4  then 1 end ,0)) as IT_PENDING,"      );
qrysb.append("      COUNT(*) AS NO_OF_GRI ,"      );
qrysb.append("    "      );
qrysb.append("      sum( nvl(case when   P.act_id=3  then 1 end ,0)) as CLOSED ,"      );
qrysb.append("       sum( nvl(case when   P.act_id<>3  then 1 end ,0)) as PENDING  "      );
qrysb.append("    "      );
qrysb.append("      FROM pmegp_grivences P,griv_sub_mast g,"      );
qrysb.append("      APP_DETAIL_online AD,M_DISTRICT MD,M_STATE MS"      );
qrysb.append("      WHERE P.APP_ID=AD.APP_ID AND p.sub_id=g.sub_id and  "      );
qrysb.append("      ad.unit_dist_cd=md.district_cd"      );
qrysb.append("      AND md.state_cd=ms.state_cd"      );
qrysb.append("      group by ROLLUP(TRUNC(P.GR_TIMESTAMP))"      );
qrysb.append("      order by TRUNC(P.GR_TIMESTAMP) desc ) "      );
qrysb.append("   "      );
qrysb.append("    "      );

 
ResultSet rsMain = db.execSQL(qrysb.toString());


%>

<center>
  <H1> Grievance
<A href="../pmegphome/dashboard.jsp" class="button" >
 <IMG src="../images/back_image.jpg" height="5%"></A> </H1>
</center>

 <TABLE id="tableid" align="center" class="bordered">
 <TR>
   <TH><DIV align="center"></DIV></TH>
   <TH colspan="3"><DIV align="center">Implementing Agency</DIV></TH>
   <TH colspan="3"><DIV align="center">Bank</DIV></TH>
   <TH colspan="3"><DIV align="center">Others</DIV></TH>
   <TH colspan="3"><DIV align="center">Information Techonology </DIV></TH>
   <TH colspan="3"><DIV align="center">Total</DIV>     <DIV align="center"></DIV>     <DIV align="center"></DIV></TH>
   </TR>
 <TR>
   <TH><DIV align="center">Grievance Date</DIV></TTHD>
   <TH><DIV align="center">Grievance</DIV></TH>
   <TH><DIV align="center">Closed</DIV></TH>
    <TH><DIV align="center">Pending</DIV></TH>
    <TH><DIV align="center">Grievance</DIV></TH>
   <TH><DIV align="center">Closed</DIV></TH>
    <TH><DIV align="center">Pending</DIV></TH>
    <TH><DIV align="center">Grievance</DIV></TH>
   <TH><DIV align="center">Closed</DIV></TH>
   <TH><DIV align="center">Pending</DIV></TH>
    <TH><DIV align="center">Grievance</DIV></TH>
    <TH><DIV align="center">Closed</DIV></TH>
    <TH><DIV align="center">Pending</DIV></TH>
    <TH><DIV align="center">No. of Grievance </DIV></TH>
    <TH><DIV align="center">Closed</DIV></TH>
    <TH><DIV align="center">Pending</DIV></TH>
   </TR>
 
   <% 

String bgcolor="";
int srno =0;
while (rsMain.next()) { 
GRIV_DT=rsMain.getString("GRIV_DT")==null?"Grand Total":rsMain.getString("GRIV_DT");
IA_GRIV=rsMain.getString("IA_GRIV")==null?"":rsMain.getString("IA_GRIV");
IA_CLOSED=rsMain.getString("IA_CLOSED")==null?"":rsMain.getString("IA_CLOSED");
IA_PENDING=rsMain.getString("IA_PENDING")==null?"":rsMain.getString("IA_PENDING");
BANK_GRIV=rsMain.getString("BANK_GRIV")==null?"":rsMain.getString("BANK_GRIV");
BANK_CLOSED=rsMain.getString("BANK_CLOSED")==null?"":rsMain.getString("BANK_CLOSED");
BANK_PENDING=rsMain.getString("BANK_PENDING")==null?"":rsMain.getString("BANK_PENDING");
OTH_GRIV=rsMain.getString("OTH_GRIV")==null?"":rsMain.getString("OTH_GRIV");
OTH_CLOSED=rsMain.getString("OTH_CLOSED")==null?"":rsMain.getString("OTH_CLOSED");
OTH_PENDING=rsMain.getString("OTH_PENDING")==null?"":rsMain.getString("OTH_PENDING");
IT_GRIV=rsMain.getString("IT_GRIV")==null?"":rsMain.getString("IT_GRIV");
IT_CLOSED=rsMain.getString("IT_CLOSED")==null?"":rsMain.getString("IT_CLOSED");
IT_PENDING=rsMain.getString("IT_PENDING")==null?"":rsMain.getString("IT_PENDING");
NO_OF_GRI=rsMain.getString("NO_OF_GRI")==null?"":rsMain.getString("NO_OF_GRI");
CLOSED=rsMain.getString("CLOSED")==null?"":rsMain.getString("CLOSED");
PENDING=rsMain.getString("PENDING")==null?"":rsMain.getString("PENDING");

srno =srno+1;

if ( srno==1){bgcolor="#FFFF66";
}else if (srno==2){
bgcolor="#FFCC99";
}else{
bgcolor="";
}

%>
 
 <TR bgcolor="<%=  bgcolor %>">
  <TD><%= GRIV_DT %></TD>
  <TD><%= IA_GRIV %></TD>
  <TD><%= IA_CLOSED %></TD>
  <TD><%= IA_PENDING %></TD>
  <TD><%= BANK_GRIV %></TD>
  <TD><%= BANK_CLOSED %></TD>
  <TD><%= BANK_PENDING %></TD>
  <TD><%= OTH_GRIV %></TD>
  <TD><%= OTH_CLOSED %></TD>
  <TD><%= OTH_PENDING %></TD>
  <TD><%= IT_GRIV %></TD>
  <TD><%= IT_CLOSED %></TD>
  <TD><%= IT_PENDING %></TD>
  <TD><%= NO_OF_GRI %></TD>
  <TD><%= CLOSED %></TD>
   <TD><%= PENDING %></TD>
  </TR>
  
  <%
  }
  rsMain.close();
  db.close();
  %>
 </TABLE>


</BODY>
</HTML>
