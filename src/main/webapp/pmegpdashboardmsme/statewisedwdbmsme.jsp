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

String YR=request.getParameter("YR")==null?"":(String) request.getParameter("YR");

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

if (YR.equals("ALL")) {
rFromdt ="1-JUL-2016";
rTodt="31-MAR-2020";
}


 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT /*+ parallel(auto) */"      );
qrysb.append("       sq.state_nm, MAX(sq.state_cd) AS STATE_CD,"      );
qrysb.append("     SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.app_rec_date) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("   1"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) AS REC_NO,"      );
qrysb.append("       "      );
qrysb.append("     round(SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.app_rec_date) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               rec_mm"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0))/100000,2) AS REC_MM,"      );
qrysb.append("        SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.Loan_sanc_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               sanc_no"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) AS SANC_NO,"      );
qrysb.append("       "      );
qrysb.append("    round( SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.Loan_sanc_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               rec_mm"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) /100000,2)AS SANC_MM,"      );
qrysb.append("       SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.mm_rel_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               disb_no"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) AS DISB_NO,"      );
qrysb.append("       "      );
qrysb.append("    round( SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.mm_rel_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               disb_mm"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0))/100000,2) AS DISB_MM"      );
qrysb.append("      "      );
qrysb.append("   FROM"      );
qrysb.append("       ("      );
qrysb.append("           SELECT /*+ parallel(auto) */"      );
qrysb.append("               ms.state_cd,"      );
qrysb.append("               ms.state_nm,"      );
qrysb.append("               ad.online_subdt as app_rec_date,"      );
qrysb.append("               bd.mm_rel_dt,"      );
qrysb.append("               ad.app_id,"      );
qrysb.append("               bd.loan_sanc_dt,"      );
qrysb.append("               rb.bank_name,"      );
qrysb.append("               md.district_name,"      );
qrysb.append("               md.district_cd,"      );
qrysb.append("               1 AS rec_no,"      );
qrysb.append("               pm.inv AS rec_mm,"      );
qrysb.append("               DECODE(bd.act_id, 11, 1, 0) AS sanc_no,"      );
qrysb.append("               DECODE(bd.act_id, 11, pm.inv) AS sanc_mm,"      );
qrysb.append("               DECODE(bd.pact_id, 34, 1, 0) AS disb_no,"      );
qrysb.append("               DECODE(bd.pact_id, 34, bd.mm_rel_amt) AS disb_mm"      );
qrysb.append("           FROM"      );
qrysb.append("               PMEGPNEW.app_detail       ad,"      );
qrysb.append("               PMEGPNEW.bank_dataentry   bd,"      );
qrysb.append("               PMEGPNEW.pmegp_mminv      pm,"      );
qrysb.append("               PMEGPNEW.m_state          ms,"      );
qrysb.append("               PMEGPNEW.m_district       md,"      );
qrysb.append("               PMEGPNEW.rbibanklist      rb,"      );
qrysb.append("               PMEGPNEW.mas_off_mast     mom"      );
qrysb.append("           WHERE"      );
qrysb.append("               ad.app_id = pm.app_id"      );
qrysb.append("               AND ad.off_cd = mom.off_cd"      );
qrysb.append("               AND ad.unit_dist_cd = md.district_cd"      );
qrysb.append("               AND md.state_cd = ms.state_cd"      );
qrysb.append("               AND ad.ifsc_code = rb.ifsc_code"      );
qrysb.append("               AND ad.app_id = bd.app_id (+)  "      );
qrysb.append("       ) sq"      );
qrysb.append("       GROUP BY  ROLLUP(sq.state_nm)"      );
qrysb.append("       ORDER BY STATE_NM"      );



DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<center>
  <h1> State/District wise PMEGP Portal Report for the period from <%= rFromdt %> to <%= rTodt %> ( <%= YR %> )
<a href="../pmegphome/index.jsp" class="button" ></a></h1>
</center>

<%= srno %>
<div id="wrapper">
<table align="center" cellpadding="2" cellspacing="10" id="customers">
 <thead>
    <tr>
	 <th bgcolor="#FCDCF4"><div align="center">Sr No</div></th>
	 <th bgcolor="#FCDCF4"><div align="center">Name</div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Prj. Received</div></th>
    <th bgcolor="#FCDCF4"><div align="center">MM Involve (In Lakh) On Received </div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Prj. Sanctioned</div></th>
    <th bgcolor="#FCDCF4"><div align="center">MM (in Lakh) On Sanction </div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Prj. Disbursed</div></th>
    <th bgcolor="#FCDCF4"><div align="center">MM (in Lakh) on Disbursement </div></th>
    </tr>
   </thead>
  
<tbody>
<% 
int cnt=0;
 while (rsMain.next()) { 
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
REC_NO=rsMain.getString("REC_NO")==null?"":rsMain.getString("REC_NO");
REC_MM=rsMain.getString("REC_MM")==null?"":rsMain.getString("REC_MM");
SANC_NO=rsMain.getString("SANC_NO")==null?"":rsMain.getString("SANC_NO");
SANC_MM=rsMain.getString("SANC_MM")==null?"":rsMain.getString("SANC_MM");
DISB_NO=rsMain.getString("DISB_NO")==null?"":rsMain.getString("DISB_NO");
DISB_MM=rsMain.getString("DISB_MM")==null?"":rsMain.getString("DISB_MM");

cnt=cnt+1;

%>
  <tr>
    <td><div align="center"><%= cnt %></div></td>
     <td><div align="left"><a href="districtdwdbmsme.jsp?STATECD=<%= STATE_CD %>&YR=<%=YR%>" target="_parent"><%= STATE_NM %></a></div></td>
    <td><div align="right"><%= REC_NO %></div></td>
    <td><div align="right"><%= REC_MM %></div></td>
	<td><div align="right"><%= SANC_NO %></div></td>
	<td><div align="right"><%= SANC_MM %></div></td>
	<td><div align="right"><%= DISB_NO %></div></td>
	<td><div align="right"><%= DISB_MM %></div></td>
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
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Prj. Received</div></th>
    <th bgcolor="#FCDCF4"><div align="center">MM Involve (In Lakh) On Received </div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Prj. Sanctioned</div></th>
    <th bgcolor="#FCDCF4"><div align="center">MM (in Lakh) On Sanction </div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Prj. Disbursed</div></th>
    <th bgcolor="#FCDCF4"><div align="center">MM (in Lakh) on Disbursement </div></th>
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
