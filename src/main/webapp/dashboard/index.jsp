<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<html>
<head>
<title>
PMEGP ePortal Dash Board
</title>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/pmegpdashboard.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</head>
<body>
<form>

<%

 DBCon db= new DBCon();
db.connect();
 StringBuffer sb= new StringBuffer();

sb.append(" SELECT COUNT(ad.APP_ID) APP_REC, ").
 append("  SUM(CASE WHEN  (AD.FORD_DT_DLTFC IS NOT NULL OR AD.MTG_ID IS NOT NULL)  THEN 1 ELSE 0 END)  as dtfc_place , ").
 append(" sum( nvl(case when ad.act_id=5 then 1 end ,0)) as bank_ford, ").
 append(" sum( nvl(case when bd.act_id=11 then 1 end ,0)) as bank_sanc, ").
  append(" sum( nvl(case when bd.act_id=11 AND bd.loan_docfname IS NOT NULL AND bd.MM_CLAIM_AMT>0  then 1 end ,0)) as mmclaimed, ").
    append(" sum( nvl(case when bd.act_id=11 AND bd.loan_docfname IS NOT NULL AND bd.MM_CLAIM_AMT>0 AND BD.APPRV_YN='A' AND PBATCH_ID>0 then 1 end ,0)) as mmFordward, ").
    append(" sum( nvl(case when bd.act_id=11 AND bd.loan_docfname IS NOT NULL AND bd.MM_CLAIM_AMT>0 AND BD.APPRV_YN='A' AND PBATCH_ID>0 then 1 end ,0)) as MMRELEASE ").

append(" FROM app_detail ad,bank_dataentry bd, ").
 append("  app_meeting_mast amm ").
append(" WHERE ad.MTG_ID = amm.MTG_ID(+) ").
append(" and ad.app_ID=BD.APP_ID(+) ");

String APP_REC="0";
String DLTFC_PLACE="0";
String BANK_FORD="0";
String BANK_SANC="0";
String MMCLAIMED="0";
String MMFORWARD="0";
String MMRELEASE="0";

ResultSet rsMain = db.execSQL(sb.toString());
while (rsMain.next()) {
 APP_REC=rsMain.getString(1);
 DLTFC_PLACE=rsMain.getString(2);
 BANK_FORD=rsMain.getString(3);
 BANK_SANC=rsMain.getString(4);
  MMCLAIMED=rsMain.getString(5);
  MMFORWARD=rsMain.getString(6);
  MMRELEASE=rsMain.getString(7);
}
rsMain.close();

 StringBuffer sbdt= new StringBuffer();
sbdt.append(" SELECT TO_CHAR(TRUNC(ONLINE_SUBDT),'DD-MON') AS ONLINE_DT, COUNT(APP_ID) AS NO_OF_APP FROM APP_DETAIL ").
append(" WHERE TRUNC(ONLINE_SUBDT) BETWEEN ").
append(" TRUNC(SYSDATE-9) AND SYSDATE ").
append(" GROUP BY TRUNC(ONLINE_SUBDT) ").
append(" ORDER BY TRUNC(ONLINE_SUBDT) ");

%>
<div id="header" align="center">
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
</div>
<br />
<center><img src="../images/misportal.png" align="middle" /></center>
<div>
<div class="row">
<div class="col-md-2">
 <center><a href="../jsp/loginPage.jsp" class="greenButtonRound" >
 <img src="images/icon_home_large.gif" height="5%">
 
 Home</a></center>

</div>

<div class="col-md-2">
 <center><a href="../pmegpmr2/index.jsp" class="greenButtonRound" >
 <img src="images/misreportimage.png" height="5%">
 
 MIS Report</a></center>

</div>

 <div class="col-md-2">
 <center><a href="dbmoregraph.jsp" class="greenButtonRound" >
 <img src="images/mgraph.ico" height="5%">
 More Graph</a></center>
</div>

 <div class="col-md-2">
 <center><a href="statewisedwdb_dltfc_mtgdetail.jsp" class="greenButtonRound" >
 <img src="images/dltfcmeeting.jpg" height="5%">
 DLTFC</a></center>
</div>

 <div class="col-md-2">
 <center><a href="agencystatewise_pendReport.jsp" class="greenButtonRound" >
 <img src="images/pendingicon.png" height="5%">
 Pending at Agency  </a></center>
</div>

<div class="col-md-2">
 <center><a href="dltfcstatewise_pendReport.jsp" class="greenButtonRound" >
 <img src="images/pendingicon.png" height="5%">
 Pending at DLTFC  </a></center>
</div>

 <div class="col-md-2">
 <center>
   <a href="../edp/index.jsp" class="greenButtonRound" >
 <img src="images/pendingicon.png" height="5%">
  EDP </a>
 </center>
</div>

<div class="col-md-4">
 <center>
   <a href="../../pmegp/pmegpmr/pmegpOldRepo.jsp" class="greenButtonRound" >
 <img src="images/pendingicon.png" height="5%">
  PMEGP OLD PERFORMANCE </a>
 </center>
</div>

<div class="col-md-4">
 <center>
   <a href="daywisedwdb_claim_repo.jsp" class="greenButtonRound" >
 <img src="images/pendingicon.png" height="5%">
  Daywise MM Disbursesment </a>
 </center>
</div>

<div class="col-md-4">
 <center>
   <a href="pmegpMMtarget.jsp" class="greenButtonRound" >
 <img src="images/pendingicon.png" height="5%">
  Live Performance(2017-18) </a>
 </center>
</div>

  </div>

  </div>
<center>

<div class="dash-item">
  <div class="dash-title">
    Application Received
  </div>
  <div class="dash-content">
    <%= APP_REC %>
  </div>
  <div class="dash-measure"></div>
  <div class="dash-details">
 <a href="statewisedwdb.jsp" class="MBT-readmore">Read More >></a>  
  </div>
</div>

<div class="dash-item homes">
  <div class="dash-title">
   Placed Before DLTFC
  </div>
  <div class="dash-content">
  <%=  DLTFC_PLACE %>
  </div>
  <div class="dash-measure"></div>
  <div class="dash-details">
  
 <a href="statewisedwdb_dltfc.jsp" class="MBT-readmore">Read More >></a>  
  </div>
</div>

<div class="dash-item parks">
  <div class="dash-title">
    Forwarded to Bank
  </div>
  <div class="dash-content">
  <%= BANK_FORD %>
  </div>
  <div class="dash-measure"></div>
  <div class="dash-details">
  <a href="statewisedwdb_fwdbank.jsp" class="MBT-readmore">Read More >></a>
  </div>
</div>

<div class="dash-item revenue">
  <div class="dash-title">
    Sanctioned by Bank
  </div>
  <div class="dash-content">
    <%= BANK_SANC %>
  </div>
  <div class="dash-measure"></div>
  <div class="dash-details">
  <a href="statewisedwdb_sanction.jsp" class="MBT-readmore">Read More >></a>
  </div>
</div>

<div class="dash-item revenue">
  <div class="dash-title">
    Margin Money Claimed
  </div>
  <div class="dash-content">
    <%= MMCLAIMED %>
  </div>
  <div class="dash-measure"></div>
  <div class="dash-details">
  <a href="statewisedwdb_claim.jsp" class="MBT-readmore">Read More >></a>
  </div>
</div>
<div class="dash-item revenue">
  <div class="dash-title">
    Margin Money Released
  </div>
  <div class="dash-content">
    <%= MMRELEASE %>
  </div>
  <div class="dash-measure"></div>
  <div class="dash-details">
  <a href="statewisedwdb_release.jsp" class="MBT-readmore">Read More >></a>
  </div>
  
</center>

<div class="container">
<div class="row">
<div class="col-md-7">
	 <div id="columnchart_values"></div>

</div>
<div class="col-md-5">
<br>
<br>
<div id="piechart_3d"></div>

</div>

</div>
</div>

<%
ResultSet rsDt = db.execSQL(sbdt.toString());

String Subdt="";
String appno="0";
String grpdt="";

 while (rsDt.next()) {
		Subdt=rsDt.getString(1);
		appno=rsDt.getString(2);
		
		grpdt=grpdt+","+"[\""+Subdt+"\","+appno+","+"\"#003399"+"\"] ";
		}
		//out.print (grpdt);
		rsDt.close();
		
		ResultSet rsCat = db.execSQL("SELECT SYSDATE AS TODT,BENF_CATAGORY_CD, COUNT(APP_ID) AS NO_OF_APP FROM APP_DETAIL GROUP BY BENF_CATAGORY_CD");
		
		String MN ="0";
		String GEN ="0";
		String SC ="0";
		String OBC ="0";
		String ST ="0";
		
		String todt="";
		String BENF_CATAGORY_CD="";
		String NO_OF_APP="0";
		

 while (rsCat.next()) {
 todt=rsCat.getString("TODT");
  BENF_CATAGORY_CD=rsCat.getString("BENF_CATAGORY_CD");
		 NO_OF_APP=rsCat.getString("NO_OF_APP");
 if (BENF_CATAGORY_CD.equals("GEN")) {
 GEN=NO_OF_APP;
 }

if (BENF_CATAGORY_CD.equals("MN")) {
 MN=NO_OF_APP;
 }


if (BENF_CATAGORY_CD.equals("SC")) {
 SC=NO_OF_APP;
 }

if (BENF_CATAGORY_CD.equals("OBC")) {
 OBC=NO_OF_APP;
 }

if (BENF_CATAGORY_CD.equals("ST")) {
 ST=NO_OF_APP;
 }
}//END IF....
	rsCat.close();	
db.close();

%>

  <script type="text/javascript">
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Element", "Application", { role: "style" } ]
		<%= grpdt %>
		/*
        ,["Copper", 8.94, "#b87333"],
        ["Silver", 10.49, "silver"],
        ["Gold", 19.30, "gold"],
        ["Platinum", 21.45, "color: #e5e4e2"]
		*/
		
		
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "No. of Applications Received During last 10 days",
        width: 700,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
  }
  </script>


<script language="javascript">
      //google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Social Category', 'No of Application'],
          ['General',     <%= GEN %>],
          ['Minority',     <%= MN %>],
          ['OBC',  <%= OBC %>],
          ['SC', <%= SC %>],
          ['ST',    <%= ST %>]
        ]);

        var options = {
		   width:600,height:400,
          title: 'Social Category wise No of Application',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>

</form>

</body>

</html>