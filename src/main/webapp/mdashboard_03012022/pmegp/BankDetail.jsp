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
.style2 {font-size: 14px}
</STYLE>
<SCRIPT>
function submit_update(){

//document.form.ins.value='I';
document.form.submit();
}
</SCRIPT>
  
</HEAD>

<BODY>
<IMG src="../img/banner3.jpg" width="100%">
<FORM method="post" name="form" id="form">
<% 
String STATE_NM="";
String STATE_CD="";
String PEND="";
String PEND_PER="";
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
String AGN=request.getParameter("AGN")==null?"ALL":(String) request.getParameter("AGN");
String vcls="";
if (!AGN.equals("ALL")){
vcls= vcls+ " and mom.agency_type='"+AGN+"' ";
}
else{
vcls= vcls+ " and mom.agency_type like '%%' ";
}


if (YR.equals("2016-17")) {
rFromdt ="1-APR-2016";
rTodt="31-MAR-2017";
}

if (YR.equals("2020-21")) {
rFromdt ="1-APR-2020";
rTodt="31-MAR-2021";
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

if (YR.equals("ALL")) {
rFromdt ="1-JUL-2016";
rTodt="31-MAR-2020";
}


 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT  /*+ PARALLEL(AUTO) */ NVL(BANK_NAME,'TOTAL') AS AGENCY_TYPE, "      );
qrysb.append("    bank_ford,"      );
qrysb.append("     BANK_DEC,"      );
qrysb.append("     round(nvl(BANK_DEC,0)/nvl(bank_ford,0)*100,2) as BANK_DEC_PER,"      );
qrysb.append("     tot_sanc,"      );
qrysb.append("      round(nvl(tot_sanc,0)/nvl(bank_ford,0)*100,2) as tot_sanc_PER,"      );
qrysb.append("     BANK_REJ,"      );
qrysb.append("       round(nvl(BANK_REJ,0)/nvl(bank_ford,0)*100,2) as BANK_REJ_PER,"      );
qrysb.append("     PEND,"      );
qrysb.append("      round(nvl(PEND,0)/nvl(bank_ford,0)*100,2) as PEND_PER"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT rbi.BANK_NAME,"      );
qrysb.append("      COUNT(*) AS bank_ford,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) NOT IN (0, 8)"      );
qrysb.append("   "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_DEC,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) NOT IN (0, 8)"      );
qrysb.append("   "      );
qrysb.append("         THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_DEC_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+rFromdt+"' AND '"+rTodt+"'  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS tot_sanc,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID = 11"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+rFromdt+"' AND '"+rTodt+"'  "      );
qrysb.append("         THEN ROUND(MM_AMT_BANKSANC(ad.APP_ID) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS tot_sanc_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) = 3"      );
qrysb.append("   "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_REJ,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) = 3"      );
qrysb.append("   "      );
qrysb.append("         THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS BANK_REJ_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) IN (0, 8)"      );
qrysb.append("   "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PEND,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN NVL(bd.ACT_ID, 0) IN (0, 8)"      );
qrysb.append("   "      );
qrysb.append("         THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PEND_MM"      );
qrysb.append("     FROM app_detail ad,rbibanklist rbi,"      );
qrysb.append("       bank_dataentry bd, MAS_OFF_MAST MOM,M_DISTRICT MD,M_STATE MS"      );
qrysb.append("     WHERE ad.APP_ID = bd.APP_ID(+)"      );
qrysb.append("     and ad.ifsc_code=rbi.ifsc_code"      );
qrysb.append("     AND ad.ACT_ID  = 5  AND AD.OFF_CD   = MOM.OFF_CD  AND ad.unit_dist_cd=md.district_cd  and md.state_cd=ms.state_cd "+vcls+"  "      );
qrysb.append("    AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+rFromdt+"' AND '"+rTodt+"'  "      );
qrysb.append("     GROUP BY ROLLUP(rbi.BANK_NAME)"      );
qrysb.append("   "      );
qrysb.append("     ) order by bank_ford desc"      );
qrysb.append("   "      );
qrysb.append("   "      );

DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<CENTER>
  <H2>  For the Application handled by the bank for the period from <%= rFromdt %> to <%= rTodt %> ( <%= YR %> )for <%=AGN%>
<A href="../pmegp/index.jsp" class="button" >Back</A> </H2>
  <TABLE>
<TR><TH>SELECT AGENCY</TH><TH>
	   
     <SELECT name="AGN" size="1"  id="AGN" onChange="submit_update();">
	  <OPTION value="ALL" selected>ALL</OPTION>
	   <OPTION value="DIC" <% if (AGN.equals("DIC")){out.print("selected");}%> >DIC</OPTION>
	   <OPTION value="KVIC" <% if (AGN.equals("KVIC")){out.print("selected");}%>>KVIC</OPTION>
      <OPTION value="KVIB" <% if (AGN.equals("KVIB")){out.print("selected");}%> >KVIB</OPTION>
	   <OPTION value="COIR" <% if (AGN.equals("COIR")){out.print("selected");}%>>COIR</OPTION>
          </SELECT></TH>
	  </TR></TABLE>
</CENTER>

<%= srno %>
<DIV id="wrapper">
<TABLE align="center" cellpadding="2" cellspacing="10" id="customers">
 <THEAD>
    <TR>
	 <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">Sr No.</DIV></TH>
	 <TH rowspan="2" bgcolor="#FCDCF4"><DIV align="center">Name</DIV></TH>
    <TH colspan="3" bgcolor="#FCDCF4"><DIV align="center">No. of Application recieved by bank<BR>
      for the period from </DIV></TH>
    <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of application decided by bank</DIV></TH>
    <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of Application Sanctioned</DIV></TH>
	 <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of application Rejected by bank</DIV></TH>
	  <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of application pending with bank for decision</DIV></TH>
    </TR>
    <TR>
      <TH bgcolor="#FCDCF4"><DIV align="center" class="style2"><%=rFromdt%></DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center" class="style2">To</DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center" class="style2"><%=rTodt%></DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In No.</DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In % </DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In No.</DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In % </DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In No.</DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In % </DIV></TH>
	   <TH bgcolor="#FCDCF4"><DIV align="center">In No.</DIV></TH>
      <TH bgcolor="#FCDCF4"><DIV align="center">In % </DIV></TH>
    </TR>
   </THEAD>
  
<TBODY>
<% 
int cnt=0;
 while (rsMain.next()) { 
 STATE_NM=rsMain.getString("agency_type")==null?"":rsMain.getString("agency_type");
STATE_CD=rsMain.getString("bank_ford")==null?"":rsMain.getString("bank_ford");
REC_NO=rsMain.getString("BANK_DEC")==null?"":rsMain.getString("BANK_DEC");
REC_MM=rsMain.getString("BANK_DEC_PER")==null?"":rsMain.getString("BANK_DEC_PER");
SANC_NO=rsMain.getString("tot_sanc")==null?"":rsMain.getString("tot_sanc");
SANC_MM=rsMain.getString("tot_sanc_PER")==null?"":rsMain.getString("tot_sanc_PER");
DISB_NO=rsMain.getString("BANK_REJ")==null?"":rsMain.getString("BANK_REJ");
DISB_MM=rsMain.getString("BANK_REJ_PER")==null?"":rsMain.getString("BANK_REJ_PER");
PEND=rsMain.getString("PEND")==null?"":rsMain.getString("PEND");
PEND_PER=rsMain.getString("PEND_PER")==null?"":rsMain.getString("PEND_PER");
cnt=cnt+1;

%>
  <TR>
    <TD><DIV align="center"><%= cnt %></DIV></TD>
     <TD><DIV align="left"><A href="StateBankDetail.jsp?Agency=<%=STATE_NM%>&YR=<%=YR%>&ORG=<%=AGN%>" target="_parent"><%= STATE_NM %></A></DIV></TD>
    <TD colspan="3"><DIV align="center"><%= STATE_CD %></DIV></TD>
    <TD><DIV align="center"><%= REC_NO %></DIV></TD>
	<TD><DIV align="center"><%=REC_MM%></DIV></TD>
	<TD><DIV align="center"><%= SANC_NO %></DIV></TD>
		<TD><DIV align="center"><%=SANC_MM%></DIV></TD>
		<TD><DIV align="center"><%= DISB_NO %></DIV></TD>
	    <TD><DIV align="center"><%=DISB_MM%></DIV></TD>
		<TD><DIV align="center"><%= PEND %></DIV></TD>
	    <TD><DIV align="center"><%=PEND_PER%></DIV></TD>
  </TR>
  </TBODY>
   <%  }
  rsMain.close();
  db.close();
    %>
	<TFOOT>
	<TR>
    <TH bgcolor="#FCDCF4"><DIV align="center">Sr No.</DIV></TH>
    <TH bgcolor="#FCDCF4"><DIV align="center">Name</DIV></TH>
  <TH colspan="3" bgcolor="#FCDCF4"><DIV align="center">No. of Application recieved by bank<BR>
      for the period from </DIV></TH>
    <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of application decided by bank</DIV></TH>
    <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of Application Sanctioned</DIV></TH>
	 <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of application Rejected by bank</DIV></TH>
	  <TH colspan="2" bgcolor="#FCDCF4"><DIV align="center">No. of application pending with bank for decision</DIV></TH>
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
