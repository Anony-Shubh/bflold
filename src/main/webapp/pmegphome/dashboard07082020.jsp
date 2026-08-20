<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
<link rel="stylesheet" href="css/pmegpdashboard2.css">
    <title>pmegp home</title>
    <!-- Bootstrap Core CSS --><link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <link rel="stylesheet" type="text/css" href="assets/css/Header-Nightsky.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
  .table_row
 {
 color: white;
 font-weight: 700;
 text-align: center;
 font-size: 16px;
 padding: 1%;
 }</style>
</head>

<body style="background-color: #ECD5E7">
<%
 DBCon db= new DBCon();
db.connect();
%>
<img src="images/04.jpg" width="100%">


  <!-- Fixed navbar -->
  <div class="header-nightsky">
    <nav class="navbar navbar-default">
            <div class="container">
                <a class="navbar-brand" href="#"><span style="color: #990000;font-size: 20px"><b>PMEGP e-Portal </b></span><span style="color: #000">  Dashboard</span></a>
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div> 
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="index.jsp"> <div class="button_home">
  HOME
  <div></div>
  <i class="fa fa-home"></i>
</div></a></li>
                        <li>
                          
                         <a href="../pmegpmr/index.jsp"> <div class="button_home">
  MIS-Report
  <div></div>
  <i class="glyphicon glyphicon-signal"></i>
</div></a>
                        </li>
                        <li>
                          
                            <a href="../dashboard/statewisedwdb_dltfc_mtgdetail.jsp"> <div class="button_home">
  DLTFC
  <div></div>
  <i class="glyphicon glyphicon-adjust"></i>
</div></a>
                        </li>
                        <li>
                          
                            <a href="../edp/index.jsp"> <div class="button_home">
  EDP
  <div></div>
  <i class="glyphicon glyphicon-adjust"></i>
</div></a>
                        </li>
                        
                        <li class="dropdown">
                            
                            <a  data-toggle="dropdown" href="#" > <div class="button_home">
  More
  <div></div>
  <i class="glyphicon glyphicon-adjust"></i>
</div></a>
                            <ul class="dropdown-menu">
                                <li>  <a href="../dashboard/agencystatewise_pendReport.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Pending at Agency</a></li>
   <li> <a href="../dashboard/dltfcstatewise_pendReport.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Pending at DLTFC</a></li>
  <li>  <a href="../../pmegp/pmegpmr/pmegpOldRepo.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> PMEGP old performance</a></li>
   <li> <a href="../dashboard/daywisedwdb_claim_repo.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Daywise MM Disbursesmenrt </a></li>
    <li> <a href="../dashboard/aadharwisedetail.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> AadharWise MM Disbursement Details </a></li>
  <li> <a href="../dashboard/pmegpMMtarget.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Live Performance(biweekly)</a></li>
  <!-- <li> <a href="dashboard_UM.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Live Performance (2018-19)</a></li>-->
    <li> <a href="../dashboard/pmegp_failcases_bank.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Bank Rejection Officewise</a></li>                          
         <li> <a href="../dashboard/bankwise_pmegp_failcases_bank.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Bank Rejection Bankwise</a></li>                          
           <li> <a href="../dashboard/PerformanceRepo1718.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2017-18)</a></li>  
		    <li> <a href="../dashboard/PerformanceRepo1819.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2018-19)</a></li>    
			<li> <a href="../dashboard/PerformanceRepo1920.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2019-20)</a></li>    
		    <li> <a href="../dashboard/ministry.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Ministry Report</a></li>        
							<li><a href="../dashboard/bankWiseSanction.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px">Bank Sanction Pending For Claim(till Date)</a> </li>
                            </ul>
                        </li>
                       
    </ul>
  </div>
                        </li>
                    </ul>
    </div>
    </nav>
</div>

 
  
  
  <%
		
		String FNAME="";

String FNAME_201617="";
String APP_REC_201617="";
String DTFC_PLACE_201617="";
String BANK_FORD_201617="";
String BANK_SANC_201617="";
String MMCLAIMED_201617="";
String MMRELEASE_201617="";


String FNAME_201718="";
String APP_REC_201718="";
String DTFC_PLACE_201718="";
String BANK_FORD_201718="";
String BANK_SANC_201718="";
String MMCLAIMED_201718="";
String MMRELEASE_201718="";

String FNAME_TOT="";
String APP_REC_TOT="";
String DTFC_PLACE_TOT="";
String BANK_FORD_TOT="";
String BANK_SANC_TOT="";
String MMCLAIMED_TOT="";
String MMRELEASE_TOT="";

String FNAME_201819="";
String APP_REC_201819="";
String DTFC_PLACE_201819="";
String BANK_FORD_201819="";
String BANK_SANC_201819="";
String MMCLAIMED_201819="";
String MMRELEASE_201819="";

String FNAME_201920="";
String APP_REC_201920="";
String DTFC_PLACE_201920="";
String BANK_FORD_201920="";
String BANK_SANC_201920="";
String MMCLAIMED_201920="";
String MMRELEASE_201920="";

String FNAME_202021="";
String APP_REC_202021="";
String DTFC_PLACE_202021="";
String BANK_FORD_202021="";
String BANK_SANC_202021="";
String MMCLAIMED_202021="";
String MMRELEASE_202021="";

 StringBuffer qrysb= new StringBuffer();



ResultSet rsMain = db.execSQL("SELECT * FROM PMEGP_DASHBOARD");


while (rsMain.next()) {
FNAME=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");

if (FNAME.equals("2016-17")) {

FNAME_201617=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_201617=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_201617=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_201617=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_201617=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_201617=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_201617=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}//2016-17


if (FNAME.equals("2017-18")) {

FNAME_201718=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_201718=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_201718=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_201718=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_201718=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_201718=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_201718=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}//2017-18

if (FNAME.equals("TOTAL")) {

FNAME_TOT=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_TOT=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_TOT=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_TOT=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_TOT=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_TOT=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_TOT=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}//TOTAL
if (FNAME.equals("2018-19")) {

FNAME_201819=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_201819=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_201819=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_201819=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_201819=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_201819=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_201819=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}

if (FNAME.equals("2019-20")) {

FNAME_201920=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_201920=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_201920=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_201920=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_201920=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_201920=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_201920=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}

if (FNAME.equals("2020-21")) {

FNAME_202021=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_202021=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_202021=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_202021=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_202021=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_202021=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_202021=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}



}
rsMain.close();
%>
<table width="90%" border="0" align="center">
  <tr>
    <td><div class="box box1 shadow1">
            <h3 align="left">Application Received
        <br><br>
        <table width="80%" border="0" align="center"> 
  <tr>
      <td class="table_row">2016-17</td>
    <td class="table_row"><%=APP_REC_201617%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2017-18</td>
    <td class="table_row"><%=APP_REC_201718%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2018-19</td>
    <td class="table_row"><%=APP_REC_201819%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
      <td class="table_row">2019-20</td>
    
    <td class="table_row"><%=APP_REC_201920%></td>
    <td><a href="../dashboard/statewisedwdb.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
   <tr>
      <td class="table_row">2020-21</td>
    
    <td class="table_row"><%=APP_REC_202021%></td>
    <td><a href="../dashboard/statewisedwdb.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
</table>
    </h3>
  </div></td>
    <td rowspan="3">
        <p align="center" style="color: #000;font-weight: 600;font-size: 18px;"><i>PMEGP e-Portal has been implemented from 1st July 2016</i></p>
		<%
		
		
		 StringBuffer sbdt= new StringBuffer();
		 
		 
sbdt.append(" SELECT TO_CHAR(TRUNC(ONLINE_SUBDT),'DD-MON') AS ONLINE_DT, COUNT(APP_ID) AS NO_OF_APP FROM APP_DETAIL ").
append(" WHERE TRUNC(ONLINE_SUBDT) BETWEEN ").
append(" TRUNC(SYSDATE-9) AND SYSDATE ").
append(" GROUP BY TRUNC(ONLINE_SUBDT) ").
append(" ORDER BY TRUNC(ONLINE_SUBDT) ");
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
        width: 500,
        height: 200,
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
		   width:300,height:200,
          title: 'Social Category wise No of Application',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>

        <div align="center"> <div id="columnchart_values"></div><br><br>
            <div id="piechart_3d"></div>
</div>
     </div>
    </td>
    <td><div class="box box2 shadow2">
    <h3 align="right">Placed Before DLTFC
        <br><br>
        <table width="80%" border="0" align="center"> 
  <tr>
      <td class="table_row">2016-17</td>
    <td class="table_row"><%=DTFC_PLACE_201617%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_dltfc.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2017-18</td>
    <td class="table_row"><%=DTFC_PLACE_201718%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_dltfc.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
   <tr>
    <td class="table_row">2018-19</td>
    <td class="table_row"><%=DTFC_PLACE_201819%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_dltfc.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
 <tr>
      <td class="table_row">2019-20</td>
    
    <td class="table_row"><%=DTFC_PLACE_201920%></td>
    <td><a href="../dashboard/statewisedwdb_dltfc.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  
   <tr>
      <td class="table_row">2020-21</td>
    
    <td class="table_row"><%=DTFC_PLACE_202021%></td>
    <td><a href="../dashboard/statewisedwdb_dltfc.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
</table>
</h3>
            
  </div></td>
  </tr>
  <tr>
    <td><div class="box box3 shadow3">
            <h3 align="left">Forwarded to Banks
			<br><br>
        <table width="80%" border="0" align="center"> 
  <tr>
      <td class="table_row">2016-17</td>
    <td class="table_row"><%=BANK_FORD_201617%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2017-18</td>
    <td class="table_row"><%=BANK_FORD_201718%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
   <tr>
    <td class="table_row">2018-19</td>
    <td class="table_row"><%=BANK_FORD_201819%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
      <td class="table_row">2019-20</td>
    
    <td class="table_row"><%=BANK_FORD_201920%></td>
    <td><a href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  
   <tr>
      <td class="table_row">2020-21</td>
    
    <td class="table_row"><%=BANK_FORD_202021%></td>
    <td><a href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
</table></h3>
  </div></td>
    <td><div class="box box4 shadow4">
            <h3 align="right">Sanctioned by Banks
			<br><br>
        <table width="80%" border="0" align="center"> 
  <tr>
      <td class="table_row">2016-17</td>
    <td class="table_row"><%=BANK_SANC_201617%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_sanction.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2017-18</td>
    <td class="table_row"><%=BANK_SANC_201718%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_sanction.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
<tr>
    <td class="table_row">2018-19</td>
    <td class="table_row"><%=BANK_SANC_201819%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_sanction.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>


 <tr>
      <td class="table_row">2019-20</td>
    
    <td class="table_row"><%=BANK_SANC_201920%></td>
    <td><a href="../dashboard/statewisedwdb_sanction.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
   <tr>
      <td class="table_row">2020-21</td>
    
    <td class="table_row"><%=BANK_SANC_202021%></td>
    <td><a href="../dashboard/statewisedwdb_sanction.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
</table>
</h3>
  </div></td>
  </tr>
  <tr>
    <td> <div class="box box5 shadow5">
            <h3 align="left">Margin Money Claimed
			<br><br>
        <table width="80%" border="0" align="center"> 
  <tr>
      <td class="table_row">2016-17</td>
    <td class="table_row"><%=MMCLAIMED_201617%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_claim.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2017-18</td>
    <td class="table_row"><%=MMCLAIMED_201718%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_claim.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
   <tr>
    <td class="table_row">2018-19</td>
    <td class="table_row"><%=MMCLAIMED_201819%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_claim.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  
 <tr>
      <td class="table_row">2019-20</td>
    
    <td class="table_row"><%=MMCLAIMED_201920%></td>
    <td><a href="../dashboard/statewisedwdb_claim.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
   <tr>
      <td class="table_row">2020-21</td>
    
    <td class="table_row"><%=MMCLAIMED_202021%></td>
    <td><a href="../dashboard/statewisedwdb_claim.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  
  
  
  
</table>
</h3>
  </div></td>
    <td> <div class="box box6 shadow6">
            <h3 align="right">Margin Money Released
			<br><br>
        <table width="80%" border="0" align="center"> 
  <tr>
      <td class="table_row">2016-17</td>
    <td class="table_row"><%=MMRELEASE_201617%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_release.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2017-18</td>
    <td class="table_row"><%=MMRELEASE_201718%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_release.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  <tr>
    <td class="table_row">2018-19</td>
    <td class="table_row"><%=MMRELEASE_201819%></td>
    <td style="padding: 1%;"><a href="../dashboard/statewisedwdb_release.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
 
 
<tr>
      <td class="table_row">2019-20</td>
    
    <td class="table_row"><%=MMRELEASE_201920%></td>
    <td><a href="../dashboard/statewisedwdb_release.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
  
  <tr>
      <td class="table_row">2020-21</td>
    
    <td class="table_row"><%=MMRELEASE_202021%></td>
    <td><a href="../dashboard/statewisedwdb_release.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></a></td>
  </tr>
</table>
</h3>
  </div> </td>
  </tr>
</table>
  <br>


</form>


  <div style="
  right: 0;
  bottom: 0;
  left: 0;
  padding: 0.5rem;
  background-color: #990000;
  text-align: center;
  color:  #FFFFFF;border-top: 1px solid #000"><B>DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI</B></div>
</body>
  


</html>
