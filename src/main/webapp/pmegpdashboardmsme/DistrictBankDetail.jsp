<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<STYLE type="text/css">
.myButton {
	background-color:#50c73e;
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
    width: 90%;
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
    background-color: #2e7d22;
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

  
</head>

<body>
<img src="image/04_01.png" width="100%">
<form method="post">
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
String AGENCY=request.getParameter("Agency")==null?"":(String) request.getParameter("Agency");
String ORG =request.getParameter("Org")==null?"":(String) request.getParameter("Org"); 
String AGN=request.getParameter("AGN")==null?"":(String) request.getParameter("AGN");
String vcls="";
String Wcls="";
if (!AGENCY.equals("TOTAL")) {
vcls= vcls+ " and ms.state_nm='"+AGENCY+"' and RBI.bank_name='"+ORG+"' ";
}
else{

vcls= vcls+ " and ms.state_nm like '%%' and RBI.bank_name='"+ORG+"'  ";

}
if (!AGN.equals("ALL")) {
Wcls= Wcls+ " and mom.agency_type='"+AGN+"'  ";
}
else{

Wcls= Wcls+ " and mom.agency_type like '%%'  ";

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

qrysb.append("   SELECT NVL(DISTRICT_NAME,'TOTAL') AS AGENCY_TYPE, "      );
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
qrysb.append("     (SELECT MD.DISTRICT_NAME,"      );
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
qrysb.append("     FROM app_detail ad,rbibanklist rbi,MAS_OFF_MAST MOM,"      );
qrysb.append("       bank_dataentry bd,M_STATE MS,M_DISTRICT MD"      );
qrysb.append("     WHERE ad.APP_ID = bd.APP_ID(+)"      );
qrysb.append("     and ad.ifsc_code=rbi.ifsc_code and ad.unit_dist_cd=md.district_cd and md.state_cd=ms.state_cd "+vcls+"   "+Wcls+" "      );
qrysb.append("     AND ad.ACT_ID  = 5 AND AD.OFF_CD   = MOM.OFF_CD "      );
qrysb.append("    AND TRUNC(ad.BANK_F_DATE) BETWEEN '"+rFromdt+"' AND '"+rTodt+"'  "      );
qrysb.append("     GROUP BY ROLLUP(MD.DISTRICT_NAME)"      );
qrysb.append("   "      );
qrysb.append("     ) order by bank_ford desc"      );
qrysb.append("   "      );
qrysb.append("   "      );

DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<center>
  <h1>  For the Application handled by the <%=ORG%> for the period from <%= rFromdt %> to <%= rTodt %> ( <%= YR %> ) for <%=AGENCY%> (<%=AGN%> Agency)
<a href="../pmegphome/index.jsp" class="button" ></a></h1>
</center>

<%= srno %>
<div id="wrapper">
<table align="center" cellpadding="2" cellspacing="10" id="customers">
 <thead>
    <tr>
	 <th rowspan="2" bgcolor="#FCDCF4"><div align="center">Sr No</div></th>
	 <th rowspan="2" bgcolor="#FCDCF4"><div align="center">Name</div></th>
    <th colspan="3" bgcolor="#FCDCF4"><div align="center">No of Application recieved by bank<br>
      for the period from </div></th>
    <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of application decided by bank</div></th>
    <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of Application Sanctioned</div></th>
	 <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of application Rejected by bank</div></th>
	  <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of application pending with bank for decision</div></th>
    </tr>
    <tr>
      <th bgcolor="#FCDCF4"><%=rFromdt%></th>
      <th bgcolor="#FCDCF4">To</th>
      <th bgcolor="#FCDCF4"><%=rTodt%></th>
      <th bgcolor="#FCDCF4">In No</th>
      <th bgcolor="#FCDCF4">In % </th>
      <th bgcolor="#FCDCF4">In No</th>
      <th bgcolor="#FCDCF4">In % </th>
      <th bgcolor="#FCDCF4">In No</th>
      <th bgcolor="#FCDCF4">In % </th>
	   <th bgcolor="#FCDCF4">In No</th>
      <th bgcolor="#FCDCF4">In % </th>
    </tr>
   </thead>
  
<tbody>
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
  <tr>
    <td><div align="center"><%= cnt %></div></td>
     <td><div align="left"><%= STATE_NM %></div></td>
    <td colspan="3"><div align="right"><%= STATE_CD %></div></td>
    <td><div align="right"><%= REC_NO %></div></td>
	<td><%=REC_MM%></td>
	<td><div align="right"><%= SANC_NO %></div></td>
		<td><%=SANC_MM%></td>
		<td><div align="right"><%= DISB_NO %></div></td>
	    <td><%=DISB_MM%></td>
		<td><div align="right"><%= PEND %></div></td>
	    <td><%=PEND_PER%></td>
  </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
	<tfoot>
	<tr>
    <th bgcolor="#FCDCF4"><div align="center">Sr No</div></th>
    <th bgcolor="#FCDCF4"><div align="center">Name</div></th>
  <th colspan="3" bgcolor="#FCDCF4"><div align="center">No of Application recieved by bank<br>
      for the period from </div></th>
    <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of application decided by bank</div></th>
    <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of Application Sanctioned</div></th>
	 <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of application Rejected by bank</div></th>
	  <th colspan="2" bgcolor="#FCDCF4"><div align="center">No of application pending with bank for decision</div></th>
   </tfoot>
</table>
</div>
<script type="text/javascript">
$(function(){
  $('#keywords').tablesorter(); 
});
</script>
</form>
</body>
</html>
