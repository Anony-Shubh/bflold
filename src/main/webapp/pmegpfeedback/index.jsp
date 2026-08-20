
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<html>
<head>

<script  type="text/javascript" src="../js/jquery.min.js" ></script>
<script type="text/javascript" src="../js/jquery.easy-ticker.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
.vticker{
	width: 400px;
}
.vticker ul{
	padding: 0;
}
.vticker li{
	list-style: none;
	border-bottom: 1px solid green;
	padding: 10px;
}
.et-run{
	background: red;
}

.wrapper {
	width:960px;
	margin:150px auto;
}
.demof {
border: 1px solid #ccc;
margin: 25px 0;
}
.demof ul {
padding: 0;
list-style: none;
}
.demof li {
padding: 500px;
border-bottom: 1px dashed #ccc;
}
.demof li.odd {
background: #fafafa;
}
.demof li:after {
content: '';
display: block;
clear: both;
}
.demof img {
float: left;
width: 177px;
margin: 5px 15px 0 0;
}
.demof a {
font-family: Arial, sans-serif;
font-size: 20px;
font-weight: bold;
color: #06f;
}
.demof p {
margin: 15px 0 0;
font-size: 14px;
}


.demo5 {
border: 1px solid #7E0479;
margin-top: 10px;
border-radius: 10px;
width: 500px;
-webkit-box-shadow: inset 0px 0px 10px 1px rgba(0, 0, 0, 0.3);
-moz-box-shadow: inset 0px 0px 10px 1px rgba(0, 0, 0, 0.3);
box-shadow: inset 0px 0px 10px 1px rgba(0, 0, 0, 0.3);
}
.demo5 ul {
padding: 0;
}
.demo5 ul li {
padding: 10px 10px 10px 10px;
border-bottom: 1px solid #FF3333;
border-radius: 10px;
list-type: none;
margin: 0;
}
.et-run {
background-color: #0cf;
color: white;
border: 1px solid black;
}
.app_name {

font-size:18px; color:#0000CC}
.feed_desc {
color: #003333;
font-size:30px;
}
.style7 {font-size: 36px}

        <style>
            /* header/copyright link */
.link {
  text-decoration: none;
  color: white;
  border-bottom: 2px dotted #55acee;
  transition: .3s;
  -webkit-transition: .3s;
  -moz-transition: .3s;
  -o-transition: .3s;
  cursor: url(http://cur.cursors-4u.net/symbols/sym-1/sym46.cur), auto;
}
.link:hover {
  color: white;
  border-bottom: 2px dotted #2ecc71;
}

/* button div */
#buttons {
  padding-top: 50px;
  text-align: center;
}

/* start da css for da buttons */
.btn {
  border-radius: 5px;
  padding: 15px 25px;
  font-size: 22px;
  text-decoration: none;
  margin: 20px;
  color: #fff;
  position: relative;
  display: inline-block;
}

.btn:active {
  transform: translate(0px, 5px);
  -webkit-transform: translate(0px, 5px);
  box-shadow: 0px 1px 0px 0px;
  color: white;
}

.blue {
    background-color: #003399;
  box-shadow: 0px 5px 0px 0px #3C93D5;
  color: white;
}

.blue:hover {
  background-color: #003399;
  color: white;
}


.red {
  background-color: #e74c3c;
  box-shadow: 0px 5px 0px 0px #CE3323;
}

.red:hover {
  background-color: #FF6656;
}

.purple {
    background-color: #009999;
  box-shadow: 0px 5px 0px 0px #82409D;
}

.purple:hover {
  background-color: #009999;
}

.fontstl {font:Verdana, Arial, Helvetica, sans-serif; font-weight:bold; font-size:24px;

}

</style>
 <link rel="stylesheet" href="../pmegphome/css/pmegpdashboard3.css">
</head>
<body style="background-color:#F7DEF8 ">
<p><img src="../images/pmegponlineN.jpg" width="100%">
<form>
  <%
DBCon db= new DBCon();
db.connect();
Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();
qrysb.append("     SELECT  UPPER(AD.APP_NAME) AS APP_NAME,MS.STATE_NM,PFO.FEEDBACK ");
qrysb.append("     FROM PMEGPNEW_FEEDBACK_ONLINE PFO,M_STATE MS,M_DISTRICT MD,APP_DETAIL AD");
qrysb.append("     WHERE AD.APP_ID=PFO.APP_ID");
qrysb.append("     AND AD.UNIT_DIST_CD=MD.DISTRICT_CD");
qrysb.append("     AND MD.STATE_CD=MS.STATE_CD");
qrysb.append("     AND PFO.COMPUB_YN='Y'");


//out.print (qrysb.toString());
ResultSet rssb = db.execSQL("SELECT COUNT(APP_ID) AS RECV FROM PMEGPNEW_FEEDBACK_ONLINE");
 String RECV="";
String  APP_NAME = "";
String  STATE_NM= "";
String FEEDBACK ="";
ResultSet rsMain = db.execSQL(qrysb.toString());
while (rssb.next()) {
RECV=rssb.getString("RECV")==null?"":rssb.getString("RECV");
}
%>
</p>
<h3 align="center" >Feedback From  PMEGP Beneficiares As on <%=curdt%></h3> 

<div style="padding-left: 5%;padding-right:5%">

<center><a href="../jasperrop/PMEGPGenAppForm.jsp?RNAME=PMEGP_GRAPH" class="btn red">Feedback Graph</a>    <a href="feedbackReport.jsp" class="btn blue">Feedback Details</a></center>

<table align="center" cellspacing="10">
  <tr valign="top">
    <td>
	<div class="demo5 demof" style="background-color:#FFFFFF ">
 
<ul>
<% 
 while (rsMain.next()) { 
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
FEEDBACK=rsMain.getString("FEEDBACK")==null?"":rsMain.getString("FEEDBACK");
%>
<li>
  <div align="left"><span class="app_name"><b><%=APP_NAME%> , </b></span>&nbsp;&nbsp;&nbsp;<span class="app_name"><%=STATE_NM%></span>
  </div>
  <p align="left" class="feed_desc"><h2 align="justify" class="fontstl"><%=FEEDBACK%></h2></p>
   </li>
   <% }rsMain.close();%>
 </ul>

</div>
<div class="box3">
			  <div align="center"><a href="#" class="list-group-item btnUp">Move Up</a>
			      <a href="#" class="list-group-item btnDown">Move Down</a>
			      <a href="#" class="list-group-item btnToggle">Play / Pause</a>
          </div>
</div>
</td>
    <td bgcolor="#FFFFFF">
      <div id="piechart_3d" style="width: 600px; height: 500px;"></div></td>

  </tr>
</table>

<%
StringBuffer sbdt= new StringBuffer();
sbdt.append("  SELECT FMOV.OPT_DESC   AS ONLINE_VIEW,COUNT(PFO.APP_ID) AS NO_OF_APP FROM PMEGPNEW_FEEDBACK_ONLINE PFO, ");
sbdt.append("  PMEGPNEW_FEEDBACK_MASTER FMOV WHERE ");
sbdt.append("  FMOV.OPT_ID  = PFO.ONLINE_VIEW group by FMOV.OPT_DESC ");

ResultSet rsDt = db.execSQL(sbdt.toString());

String EX="0";
String VG="0";
String GD="0";
String FA="0";
String US="0";
String HU="0";
String ONLINE_VIEW="0";
String NO_OF_APP="0";
 while (rsDt.next()) {
		ONLINE_VIEW=rsDt.getString(1);
		//out.print(ONLINE_VIEW);
        NO_OF_APP=rsDt.getString(2);
		//out.print(NO_OF_APP);
		 if (ONLINE_VIEW.equals("Excellent")) {
        EX=NO_OF_APP;
		//out.print(EX);
         }
		 if (ONLINE_VIEW.equals("V Good")) {
        VG=NO_OF_APP;
		//out.print(VG);
         }
		 if (ONLINE_VIEW.equals("Good")) {
        GD=NO_OF_APP;
         }
		 if (ONLINE_VIEW.equals("Fair")) {
        FA=NO_OF_APP;
         }		 
		 if (ONLINE_VIEW.equals("Unsatisfactory")) {
        US=NO_OF_APP;
         }
		 if (ONLINE_VIEW.equals("Highly Unsatisfactory")) {
        HU=NO_OF_APP;
         }

		}
		
		rsDt.close();
	db.close();
%>
</form>
<script type="text/javascript">
$(function(){
	
	$('.demo5').easyTicker({
		direction: 'up',
		visible: 2,		
		interval: 7000,
		controls: {
			up: '.btnUp',
			down: '.btnDown',
			toggle: '.btnToggle'
		}
	});
});

 
   
 
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Online View','No of Application'],
		  ['Excellent',      <%= EX %>],
          ['V.good',      <%= VG %>],
          ['Good',  <%= GD %>],
          ['Fair',  <%= FA %>],
          ['Unsatisfactory',     <%= US %>]	  
        ]);

        var options = {
          title: 'FEEDBACK (Total:'+<%=RECV%>+')',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }

  
     
    </script>
	
</body>
</html>
