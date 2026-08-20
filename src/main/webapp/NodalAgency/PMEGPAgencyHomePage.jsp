
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
<%@ include file="includeHeaderPageDLTFC.jsp" %>
<%
String OFF_CD= (String) session.getAttribute("sOffCd");
out.print(OFF_CD);
String user_id= "";
String APP_apprv="";
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT  count(*) as APP_REC,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  gt.ACT_ID is null    "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_UP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  gt.ACT_ID =1 "      );

qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_apprv,"      );

qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  ad.ACT_ID  =2  "      );

qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS APP_rej"      );

qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     Geotag_trans gt "      );
qrysb.append("   WHERE ad.APP_ID = gt.APP_ID and ad.off_cd="+OFF_CD+" and  gt.MM_ADJUSTMENT_STATUS is not null and gt.qc_apprv='Y' "      );



//out.print(qrysb.toString());
ResultSet rsApp = db.execSQL(qrysb.toString());
String APP_REC="";
String APP_REJ="";
String APP_UP="";
String BANK_FORD="";
String PEND_APP="";
while (rsApp.next()){

APP_REJ=rsApp.getString("APP_REJ")==null?"0":rsApp.getString("APP_REJ");
APP_REC=rsApp.getString("APP_REC")==null?"0":rsApp.getString("APP_REC");
APP_UP=rsApp.getString("APP_UP")==null?"0":rsApp.getString("APP_UP");

APP_apprv=rsApp.getString("APP_apprv")==null?"0":rsApp.getString("APP_apprv");
}

rsApp.close();


%>
<div class="main-section">
<div class="dashbord dashbord-blue">
			<div class="icon-section">
				<br/><br/>
				<small>Application Recieved</small>
				<p><%=APP_UP%></p>
			</div>
			<div class="detail-section">
				<a href="#">More Info </a>
			</div>
</div>		
 		<div class="dashbord dashbord-green">
		
			<div class="icon-section">
				<br/><br/>
				<small>Approved</small>
				<p><%=APP_apprv%></p>
			</div>
			<div class="detail-section">
				<a href="#">More Info </a>
			</div>
		</div>
		<div class="dashbord dashbord-orange">
			<div class="icon-section">
				<br/><br/>
				Application Rejected/Returned
				<p><%=APP_REJ%></p>
			</div>
			<div class="detail-section">
				<a href="#">More Info </a>
			</div>
			
		</div>
		<br/><br/>
		<DIV class="dashbord dashbord-red">
			<DIV class="icon-section">
<BR/><BR/>			
					
				<DIV id="blink_me">Pending</DIV>
				<P><%=APP_UP%></P>
			</DIV>
			<DIV class="detail-section">
			<A href="#">More Info </A>
			</DIV>
		</DIV>
		
</DIV>

<BR>
<SPAN class="redLebel"><DIV align="center">Note :Please click on Update User Detail Tab , 
		fill in the necessary details in order to Approve/Return Beneficiary MM Adjustment Details.</DIV>.</SPAN> <strong></strong><br/>
		<br/><br/><br/>
		
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