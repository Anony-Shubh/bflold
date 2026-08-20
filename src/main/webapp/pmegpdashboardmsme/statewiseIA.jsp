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

String YR=request.getParameter("YR")==null?"2020-21":(String) request.getParameter("YR");
out.print(YR);
String AGENCY=request.getParameter("Agency")==null?"":(String) request.getParameter("Agency");
String vcls="";

if (!AGENCY.equals("TOTAL")) {
vcls= vcls+ " and mom.agency_type='"+AGENCY+"' ";
}
else{

vcls= vcls+ " and mom.agency.type like '%%'  ";

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

qrysb.append(" SELECT  nvl(ms.state_nm,'TOTAL') agency_type,COUNT(*), "      );

qrysb.append(" SUM(CASE WHEN  ad.act_id IN (0,1,2,4) AND ad.act_yn='Y' AND trunc(SYSDATE)-TRUNC(AD.online_subdt) > 30  THEN 1 ELSE 0 END) AS PEND_1,"      );


qrysb.append(" SUM(CASE WHEN  ad.act_id IN (0,1,2,4) AND ad.act_yn='Y' AND  trunc(SYSDATE)-TRUNC(AD.online_subdt) BETWEEN 15 AND 30  THEN 1 ELSE 0 END) AS PEND_2,"      );

qrysb.append(" SUM(CASE WHEN  ad.act_id IN (0,1,2,4) AND ad.act_yn='Y' AND  trunc(SYSDATE)-TRUNC(AD.online_subdt) < 15  THEN 1 ELSE 0 END) AS PEND"      );


qrysb.append(" FROM APP_DETAIL AD,MAS_OFF_MAST MOM,M_STATE MS,M_DISTRICT MD WHERE AD.OFF_CD=MOM.OFF_CD and ad.unit_dist_cd=md.district_cd and md.state_cd=ms.state_cd "+vcls+"  "      );
qrysb.append(" AND TRUNC(ad.online_subdt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' GROUP BY  ROLLUP(ms.state_nm) ORDER BY COUNT(*) DESC"      );
//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
<center>
  <h1>  Application Status with Implementing Agency  for the period from <%= rFromdt %> to <%= rTodt %>  for <%=AGENCY%>
<a href="../pmegphome/index.jsp" class="button" ></a></h1>
</center>

<%= srno %>
<div id="wrapper">
<table align="center" cellpadding="2" cellspacing="10" id="customers">
 <thead>
    <tr>
	 <th bgcolor="#FCDCF4"><div align="center">Sr No</div></th>
	 <th bgcolor="#FCDCF4"><div align="center">Name</div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Application for more than one month. </div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Application 15 days to  one month. </div></th>
    <th bgcolor="#FCDCF4"><div align="center">No of Application less than 15 days</div></th>
   
    </tr>
   </thead>
  
<tbody>
<% 
int cnt=0;
 while (rsMain.next()) { 
 STATE_NM=rsMain.getString("agency_type")==null?"":rsMain.getString("agency_type");
//STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
REC_NO=rsMain.getString("PEND_1")==null?"":rsMain.getString("PEND_1");
REC_MM=rsMain.getString("PEND_2")==null?"":rsMain.getString("PEND_2");
SANC_NO=rsMain.getString("PEND")==null?"":rsMain.getString("PEND");
//SANC_MM=rsMain.getString("SANC_MM")==null?"":rsMain.getString("SANC_MM");
//DISB_NO=rsMain.getString("DISB_NO")==null?"":rsMain.getString("DISB_NO");
//DISB_MM=rsMain.getString("DISB_MM")==null?"":rsMain.getString("DISB_MM");

cnt=cnt+1;

%>
  <tr>
    <td><div align="center"><%= cnt %></div></td>
     <td><div align="left"><a href="districtIA.jsp?Agency=<%=STATE_NM%>&YR=<%=YR%>&Org=<%=AGENCY%>" target="_parent"><%= STATE_NM %></a></div></td>
    <td><div align="right"><%= REC_NO %></div></td>
    <td><div align="right"><%= REC_MM %></div></td>
	<td><div align="right"><%= SANC_NO %></div></td>
	
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
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Application for more than one month.</div></th>
    <th bgcolor="#FCDCF4"><div align="center">Nos. of Application 15 days to  one month. </div></th>
    <th bgcolor="#FCDCF4"><div align="center">No of Application less than 15 days</div></th>
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
