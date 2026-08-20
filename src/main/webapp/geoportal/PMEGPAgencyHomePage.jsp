
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
 .blink_me{
	margin-bottom: 68px;
	margin-left: -30px;
 }
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
</style>	
</head>
<body>
<%@ include file="includeHeaderPage.jsp" %>
<%

String user_id= vUserID;

DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT count(*) AS APP_REC,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  (ad.ACT_ID IN (3, 7)"      );
qrysb.append("       OR ad.ACT_YN    = 'N')"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_REJ,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  ad.ACT_ID                          IN (0, 1, 2, 4)"      );
qrysb.append("       AND SysDate    - TRUNC(ad.ONLINE_SUBDT) <= 26 AND AD.ACT_YN='Y' "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_UP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND ad.ACT_YN = 'Y'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN TRUNC(ad.ONLINE_SUBDT) BETWEEN '01-APR-2016' AND SysDate"      );
qrysb.append("       AND SysDate                          - TRUNC(ad.ONLINE_SUBDT) > 26 AND AD.ACT_YN='Y' "      );
qrysb.append("       AND ad.ACT_ID                       IN (0, 1, 2, 4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PEND_APP"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     dataentry_user du"      );
qrysb.append("   WHERE ad.OFF_CD = mom.OFF_CD "      );
qrysb.append("   AND mom.USER_ID = du.USER_ID"      );
qrysb.append("   AND du.user_id="+user_id+" "      );

//out.print(qrysb.toString());
ResultSet rsApp = db.execSQL(qrysb.toString());
String APP_REC="";
String APP_REJ="";
String APP_UP="";
String BANK_FORD="";
String PEND_APP="";
while (rsApp.next()){
APP_REC=rsApp.getString("APP_REC")==null?"":rsApp.getString("APP_REC");
APP_REJ=rsApp.getString("APP_REJ")==null?"":rsApp.getString("APP_REJ");
APP_UP=rsApp.getString("APP_UP")==null?"":rsApp.getString("APP_UP");
BANK_FORD=rsApp.getString("BANK_FORD")==null?"":rsApp.getString("BANK_FORD");
PEND_APP=rsApp.getString("PEND_APP")==null?"":rsApp.getString("PEND_APP");
}

rsApp.close();


%>
<br/>
 <div align="center"><a href="edp_training_content_23022021.rar"  class="buttonMarun">Download Approved EDP Content</a><IMG src="new-gif.gif" width="70px" height="50px"></div>
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
				<small>Forwarded to Bank</small>
				<p><%=BANK_FORD%></p>
			</div>
			<div class="detail-section">
				<a href="dashboardDetail.jsp?T=BS">More Info </a>
			</div>
		</div>		
		<div class="dashbord dashbord-red">
			<div class="icon-section">
<br/><br/>			
				<div id="blink_me">Pending Beyond Timeline </div>
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
 <center> <h2>For Technical issues contact email: pmegpeportal.kvic@gov.in and PMEGP Scheme related queries contact email: pmegp.kvic@gov.in</h2>
 </center>
  </th>
  </tr>
  </table>
</body>
</html>