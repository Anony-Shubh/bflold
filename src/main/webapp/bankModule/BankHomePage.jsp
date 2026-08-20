<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="headerfile.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="custom.css">
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,200,400,500,600" rel="stylesheet" type="text/css">

<style>
 #blink_me {
        font-size: 18px;
        font-weight: bold;
        font-family: 'Raleway', sans-serif;
        
        transition: 0.4s;
      }
	  
</style>
	
	<script>
$(document).ready(function() {
     var blink = document.getElementById('blink_me');
      setInterval(function() {
        blink.style.opacity = (blink.style.opacity == 0 ? 5 : 0);
      }, 1000);
    
});
</script>



	<style>
	
	body{
        background:#ffffff;	
	font-size: 20px;
        font-weight: bold;
      
	font-family: 'Raleway', sans-serif;
}
.main-section{
	width:80%;
	margin:0 auto;
	text-align: center;
	padding: 0px 5px;
}
.dashbord{
	width:32%;
	display: inline-block;
	background-color:#34495E;
	color:#fff;
	margin-top: 50px; 
}
.icon-section i{
	font-size: 30px;
	padding:10px;
	border:1px solid #fff;
	border-radius:50%;
	margin-top:-25px;
	margin-bottom: 10px;
	background-color:#34495E;
	
}
.icon-section p{
	margin:0px;
	font-size: 20px;
	padding-bottom: 10px;
	
}
.detail-section{
	background-color: #2F4254;
	padding: 5px 0px;
}
.dashbord .detail-section:hover{
	background-color: #5a5a5a;
	cursor: pointer;
}
.detail-section a{
	color:#fff;
	text-decoration: none;
}
.dashbord-green .icon-section,.dashbord-green .icon-section i{
	background-color: #16A085;
}
.dashbord-green .detail-section{
	background-color: #149077;
}
.dashbord-orange .icon-section,.dashbord-orange .icon-section i{
	background-color: #F39C12;
}
.dashbord-orange .detail-section{
	background-color: #DA8C10;
}
.dashbord-blue .icon-section,.dashbord-blue .icon-section i{
	background-color: #2980B9;
}
.dashbord-blue .detail-section{
	background-color:#2573A6;
}
.dashbord-red .icon-section,.dashbord-red .icon-section i{
	background-color:#E74C3C;
}
.dashbord-red .detail-section{
	background-color:#CF4436;
}
.dashbord-skyblue .icon-section,.dashbord-skyblue .icon-section i{
	background-color:#8E44AD;
}
.dashbord-skyblue .detail-section{
	background-color:#803D9B;
}

.dashbord-sky .icon-section,.dashbord-sky .icon-section i{
	background-color:#489b3d;
}
.dashbord-sky .detail-section{
	background-color:#489b3d;
}




</style>	
</head>
<body>

<%

String user_id=(String) session.getAttribute("bank_id"); 
//out.print(user_id);
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT SUM("      );
qrysb.append("     CASE when"      );
qrysb.append("      "      );
qrysb.append("        ad.ACT_ID = 5 AND ad.ACT_YN='Y'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_REC,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE when"      );
qrysb.append("      "      );
qrysb.append("        bd.ACT_ID = 3 AND ad.ACT_YN='Y'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_REJ,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  nvl(bd.ACT_ID,0) in (8,0) AND SysDate - TRUNC(ad.BANK_F_DATE) <= 30 AND ad.ACT_YN='Y' "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_UP,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("      "      );
qrysb.append("       AND ad.ACT_ID = 5 AND AD.ACT_YN='Y' "      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_sanc,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0 AND AD.ACT_YN='Y'"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("     "      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS MMCLAIMED,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE when"      );
qrysb.append("      "      );
qrysb.append("        NVL(bd.ACT_ID, 0)               in( 0,8) AND ad.ACT_YN='Y' "      );
qrysb.append("       AND SysDate - TRUNC(ad.BANK_F_DATE) > 30"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PEND_APP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID        = 5 AND AD.ACT_YN='Y' "      );
qrysb.append("       AND bd.ACT_ID         = 11"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT   IS NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PEND_MM"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     bank_dataentry bd"      );
qrysb.append("   WHERE ad.APP_ID   = bd.APP_ID(+)"      );
qrysb.append("        AND AD.IFSC_CODE='"+user_id+"' "      );


//out.print(qrysb.toString());

ResultSet rsApp = db.execSQL(qrysb.toString());
String APP_REC="";
String APP_REJ="";
String APP_UP="";
String BANK_FORD="";
String PEND_APP="";
String PEND_MM="";
String MMCLAIMED="";
while (rsApp.next()){
APP_REC=rsApp.getString("APP_REC")==null?"":rsApp.getString("APP_REC");
APP_REJ=rsApp.getString("APP_REJ")==null?"":rsApp.getString("APP_REJ");
APP_UP=rsApp.getString("APP_UP")==null?"":rsApp.getString("APP_UP");
BANK_FORD=rsApp.getString("BANK_SANC")==null?"":rsApp.getString("BANK_SANC");
PEND_APP=rsApp.getString("PEND_APP")==null?"":rsApp.getString("PEND_APP");
PEND_MM=rsApp.getString("PEND_MM")==null?"":rsApp.getString("PEND_MM");
MMCLAIMED=rsApp.getString("MMCLAIMED")==null?"":rsApp.getString("MMCLAIMED");
}

rsApp.close();


%>

	<div class="main-section">
		<div class="dashbord">
			<div class="icon-section">
				<br/><br/>
				<small>Application Recieved</small>
				<p><%=APP_REC%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=ALL">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-green">
		
			<div class="icon-section">
				<br/><br/>
				<small>Application Under Process</small>
				<p><%=APP_UP%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=UP">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-orange">
			<div class="icon-section">
				<br/><br/>
				<small>Application Rejected/Returned</small>
				<p><%=APP_REJ%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=RJ">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-blue">
			<div class="icon-section">
				<br/><br/>
				<small>Sanctioned By Bank</small>
				<p><%=BANK_FORD%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=BS">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-sky">
			<div class="icon-section">
				<br/><br/>
				<small>MM Claimed</small>
				<p><%=MMCLAIMED%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=MC">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-skyblue">
			<div class="icon-section">
				<br/><br/>
				<small>Pending For MM Claim</small>
				<p><%=PEND_MM%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=PC">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-red">
			<div class="icon-section">
				<br/><br/>
				<div id="blink_me">Pending Beyond Timeline</div>
				<p><%=PEND_APP%></p>
			</div>
			<div class="detail-section">
			<a href="dashboardDetail.jsp?T=PD">More Info </a>
			</div>
		</div>
	
		
	
	</div>
	
	<table class="pmegpTable"><br>
<tr>
<th>
 <center> <h2>For Technical issues contact email: pmegpeportal.kvic@gov.in and PMEGP Scheme related queries contact email: pmegpeportal.kvic@gov.in</h2>
 </center>
  </th>
  </tr>
  </table>
</body>
</html>