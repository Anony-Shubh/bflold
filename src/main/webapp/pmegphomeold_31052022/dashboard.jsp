<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<HTML>

<HEAD>

    <META CHARSET="utf-8">
    <META http-equiv="X-UA-Compatible" content="IE=edge">
    <META name="viewport" content="width=device-width, initial-scale=1">
    <META name="description" content="">
    <META name="author" content="">
<LINK rel="stylesheet" href="css/pmegpdashboard2.css">
<LINK rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <TITLE>pmegp home</TITLE>
    <!-- Bootstrap Core CSS --><LINK rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<SCRIPT type="text/javascript" src=".././js/ModalPopupWindow.js"></SCRIPT>
  <SCRIPT src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></SCRIPT>
  <SCRIPT src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></SCRIPT>
     <LINK rel="stylesheet" type="text/css" href="assets/css/Header-Nightsky.css">
<SCRIPT type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></SCRIPT>
<STYLE>
  .table_row
 {
 color: white;
 font-weight: 700;
 text-align: center;
 font-size: 16px;
 padding: 1%;
 }</STYLE>
</HEAD>

<BODY style="background-color: #ECD5E7">
<%
 DBCon db= new DBCon();
db.connect();
%>
<IMG src="images/04.jpg" width="100%">


  <!-- Fixed navbar -->
  <DIV class="header-nightsky">
    <nav class="navbar navbar-default">
            <DIV class="container">
                <A class="navbar-brand" href="#"><SPAN style="color: #990000;font-size: 20px"><B>PMEGP Portal</B></SPAN><SPAN style="color: #000">  Dashboard</SPAN></A>
                <DIV class="navbar-header">
                    <BUTTON type="button" class="navbar-toggle" DATA-TOGGLE="collapse" DATA-TARGET="#myNavbar">
                        <SPAN class="icon-bar"></SPAN>
                        <SPAN class="icon-bar"></SPAN>
                        <SPAN class="icon-bar"></SPAN>
                    </BUTTON>
                </DIV> 
                <DIV class="collapse navbar-collapse" id="myNavbar">
                    <UL class="nav navbar-nav navbar-right">
                        <LI><A href="index.jsp"> <DIV class="button_home">
  HOME
  <DIV></DIV>
  <I class="fa fa-home"></I>
</DIV></A></LI>
                        <LI>
                          
                         <A href="../pmegpmr/index.jsp"> <DIV class="button_home">
  MIS-Report
  <DIV></DIV>
  <I class="glyphicon glyphicon-signal"></I>
</DIV></A>                        </LI>
                        <LI>
                          
                           <A href="#"  style="color: #FFFFFF"  onClick="ShowNewPage ()";>  <DIV class="button_home">
Online EDP Training
  <DIV></DIV>
  <I class="glyphicon glyphicon-adjust"></I>
</DIV></A>                        </LI>
                        <LI>
                          
                            <A href="../edpoff"> <DIV class="button_home">
  EDP
  <DIV></DIV>
  <I class="glyphicon glyphicon-adjust"></I>
</DIV></A>                        </LI>
                        
                        <LI class="dropdown">
                            
                            <A  data-toggle="dropdown" href="#" > <DIV class="button_home">
  More
  <DIV></DIV>
  <I class="glyphicon glyphicon-adjust"></I>
</DIV></A>
                            <UL class="dropdown-menu">
                                <LI>  <A href="../dashboard/agencystatewise_pendReport.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Pending at Agency</A></LI>
 
  <LI>  <A href="../../pmegp/pmegpmr/pmegpOldRepo.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> PMEGP old performance</A></LI>
   <LI> <A href="../dashboard/daywisedwdb_claim_repo.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Daywise MM Disbursesmenrt </A></LI>
    <LI> <A href="../dashboard/grievance.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Daywise Grievance </A></LI>
    <LI> <A href="../dashboard/aadharwisedetail.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> AadharWise MM Disbursement Details </A></LI>
  <LI> <A href="../dashboard/pmegpMMtarget.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Live Performance(biweekly)</A></LI>
  <!-- <li> <a href="dashboard_UM.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Live Performance (2018-19)</a></li>-->
    <LI> <A href="../dashboard/pmegp_failcases_bank.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Bank Rejection Officewise</A></LI>                          
         <LI> <A href="../dashboard/bankwise_pmegp_failcases_bank.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Bank Rejection Bankwise</A></LI>                          
           <LI> <A href="../dashboard/PerformanceRepo1718.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2017-18)</A></LI>  
		    <LI> <A href="../dashboard/PerformanceRepo1819.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2018-19)</A></LI>    
			<LI> <A href="../dashboard/PerformanceRepo1920.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2019-20)</A></LI>    
		    <LI> <A href="../dashboard/PerformanceRepo2021.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2020-21)</A></LI>
			<LI> <A href="../dashboard/PerformanceRepo2122.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Annual Progress Report (2021-22)</A></LI>
		    <LI> <A href="../dashboard/ministry.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px"> Ministry Report</A></LI>        
							<LI><A href="../dashboard/bankWiseSanction.jsp" class="glyphicon glyphicon-hourglass" style="font-size: 18px">Bank Sanction Pending For Claim(till Date)</A> </LI>
                            </UL>
                        </LI>
    </UL>
  </DIV>
                        </li>
                    </ul>
    </DIV>
    </nav>
</DIV>

 
  
  
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


String FNAME_202122="";
String APP_REC_202122="";
String DTFC_PLACE_202122="";
String BANK_FORD_202122="";
String BANK_SANC_202122="";
String MMCLAIMED_202122="";
String MMRELEASE_202122="";


String FNAME_202223="";
String APP_REC_202223="";
String DTFC_PLACE_202223="";
String BANK_FORD_202223="";
String BANK_SANC_202223="";
String MMCLAIMED_202223="";
String MMRELEASE_202223="";



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


if (FNAME.equals("2021-22")) {

FNAME_202122=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_202122=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_202122=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_202122=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_202122=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_202122=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_202122=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}

if (FNAME.equals("2022-23")) {

FNAME_202223=rsMain.getString("FNAME")==null?"":rsMain.getString("FNAME");
APP_REC_202223=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
DTFC_PLACE_202223=rsMain.getString("DTFC_PLACE")==null?"":rsMain.getString("DTFC_PLACE");
BANK_FORD_202223=rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
BANK_SANC_202223=rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
MMCLAIMED_202223=rsMain.getString("MMCLAIMED")==null?"":rsMain.getString("MMCLAIMED");
MMRELEASE_202223=rsMain.getString("MMRELEASE")==null?"":rsMain.getString("MMRELEASE");

}



}
rsMain.close();
%>
<TABLE width="90%" border="0" align="center">
  <TR>
    <TD><DIV class="box box1 shadow1">
            <H3 align="left">Application Received
       <BR>
        <TABLE width="80%" border="0" align="center"> 
  <TR>
      <TD class="table_row">2016-17</TD>
    <TD class="table_row"><%=APP_REC_201617%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2017-18</TD>
    <TD class="table_row"><%=APP_REC_201718%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2018-19</TD>
    <TD class="table_row"><%=APP_REC_201819%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
      <TD class="table_row">2019-20</TD>
    
    <TD class="table_row"><%=APP_REC_201920%></TD>
    <TD><A href="../dashboard/statewisedwdb.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
      <TD class="table_row">2020-21</TD>
    
    <TD class="table_row"><%=APP_REC_202021%></TD>
    <TD><A href="../dashboard/statewisedwdb.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
      <TD class="table_row">2021-22</TD>
    
    <TD class="table_row"><%=APP_REC_202122%></TD>
    <TD><A href="../dashboard/statewisedwdb.jsp?YR=2021-22" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
   <TR>
      <TD class="table_row">2022-23</TD>
    
    <TD class="table_row"><%=APP_REC_202223%></TD>
    <TD><A href="../dashboard/statewisedwdb.jsp?YR=2022-23" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
  
</TABLE>
    </H3>
  </DIV></TD>
    <TD rowspan="3">
        <P align="center" style="color: #000;font-weight: 600;font-size: 18px;"><I>PMEGP Portal has been implemented from 1st July 2016</I></P>
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

  <SCRIPT type="text/javascript">
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
  </SCRIPT>


<SCRIPT language="javascript">
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
    </SCRIPT>

        <DIV align="center"> <DIV id="columnchart_values"></DIV><BR><BR>
            <DIV id="piechart_3d"></DIV>
</DIV>
     </div>
    </TD>
    

  
    <TD><DIV class="box box3 shadow3">
            <H3 align="left">Forwarded to Banks
			<BR>
        <TABLE width="80%" border="0" align="center"> 
  <TR>
      <TD class="table_row">2016-17</TD>
    <TD class="table_row"><%=BANK_FORD_201617%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2017-18</TD>
    <TD class="table_row"><%=BANK_FORD_201718%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
    <TD class="table_row">2018-19</TD>
    <TD class="table_row"><%=BANK_FORD_201819%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
      <TD class="table_row">2019-20</TD>
    
    <TD class="table_row"><%=BANK_FORD_201920%></TD>
    <TD><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
   <TR>
      <TD class="table_row">2020-21</TD>
    
    <TD class="table_row"><%=BANK_FORD_202021%></TD>
    <TD><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
      <TD class="table_row">2021-22</TD>
    
    <TD class="table_row"><%=BANK_FORD_202122%></TD>
    <TD><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2021-22" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
   <TR>
      <TD class="table_row">2022-23</TD>
    
    <TD class="table_row"><%=BANK_FORD_202223%></TD>
    <TD><A href="../dashboard/statewisedwdb_fwdbank.jsp?YR=2022-23" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
  
</TABLE></H3>
  </DIV></TD>
  </TR>
  <TR>
    <TD><DIV class="box box4 shadow4">
            <H3 align="right">Sanctioned by Banks
			<BR>
        <TABLE width="80%" border="0" align="center"> 
  <TR>
      <TD class="table_row">2016-17</TD>
    <TD class="table_row"><%=BANK_SANC_201617%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2017-18</TD>
    <TD class="table_row"><%=BANK_SANC_201718%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
<TR>
    <TD class="table_row">2018-19</TD>
    <TD class="table_row"><%=BANK_SANC_201819%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>


 <TR>
      <TD class="table_row">2019-20</TD>
    
    <TD class="table_row"><%=BANK_SANC_201920%></TD>
    <TD><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
      <TD class="table_row">2020-21</TD>
    
    <TD class="table_row"><%=BANK_SANC_202021%></TD>
    <TD><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
     <TR>
      <TD class="table_row">2021-22</TD>
    
    <TD class="table_row"><%=BANK_SANC_202122%></TD>
    <TD><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2021-22" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
      <TD class="table_row">2022-23</TD>
    
    <TD class="table_row"><%=BANK_SANC_202223%></TD>
    <TD><A href="../dashboard/statewisedwdb_sanction.jsp?YR=2022-23" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
  
  
</TABLE>
</H3>
  </DIV></TD>
  

    <TD> <DIV class="box box5 shadow5">
            <H3 align="left">Margin Money Claimed
			<BR>
        <TABLE width="80%" border="0" align="center"> 
  <TR>
      <TD class="table_row">2016-17</TD>
    <TD class="table_row"><%=MMCLAIMED_201617%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_claim.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2017-18</TD>
    <TD class="table_row"><%=MMCLAIMED_201718%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_claim.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
    <TD class="table_row">2018-19</TD>
    <TD class="table_row"><%=MMCLAIMED_201819%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_claim.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
 <TR>
      <TD class="table_row">2019-20</TD>
    
    <TD class="table_row"><%=MMCLAIMED_201920%></TD>
    <TD><A href="../dashboard/statewisedwdb_claim.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
   <TR>
      <TD class="table_row">2020-21</TD>
    
    <TD class="table_row"><%=MMCLAIMED_202021%></TD>
    <TD><A href="../dashboard/statewisedwdb_claim.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
    <TR>
      <TD class="table_row">2021-22</TD>
    
    <TD class="table_row"><%=MMCLAIMED_202122%></TD>
    <TD><A href="../dashboard/statewisedwdb_claim.jsp?YR=2021-22" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
  <TR>
      <TD class="table_row">2022-23</TD>
    
    <TD class="table_row"><%=MMCLAIMED_202223%></TD>
    <TD><A href="../dashboard/statewisedwdb_claim.jsp?YR=2022-23" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
  
</TABLE>
</H3>
  </DIV></TD>
  </TR>
  <TR>
    <TD> <div class="box box6 shadow6">
            <H3 align="right">Margin Money Released
			<BR>
        <TABLE width="80%" border="0" align="center"> 
  <TR>
      <TD class="table_row">2016-17</TD>
    <TD class="table_row"><%=MMRELEASE_201617%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_release.jsp?YR=2016-17" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2017-18</TD>
    <TD class="table_row"><%=MMRELEASE_201718%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_release.jsp?YR=2017-18" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  <TR>
    <TD class="table_row">2018-19</TD>
    <TD class="table_row"><%=MMRELEASE_201819%></TD>
    <TD style="padding: 1%;"><A href="../dashboard/statewisedwdb_release.jsp?YR=2018-19" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
 
 
<TR>
      <TD class="table_row">2019-20</TD>
    
    <TD class="table_row"><%=MMRELEASE_201920%></TD>
    <TD><A href="../dashboard/statewisedwdb_release.jsp?YR=2019-20" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
  </TR>
  
  <TR>
      <TD class="table_row">2020-21</TD>
    
    <TD class="table_row"><%=MMRELEASE_202021%></TD>
    <TD><A href="../dashboard/statewisedwdb_release.jsp?YR=2020-21" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
 </TR>
   <TR>
      <TD class="table_row">2021-22</TD>
    
    <TD class="table_row"><%=MMRELEASE_202122%></TD>
    <TD><A href="../dashboard/statewisedwdb_release.jsp?YR=2021-22" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
 </TR>
 
   <TR>
      <TD class="table_row">2022-23</TD>
    
    <TD class="table_row"><%=MMRELEASE_202223%></TD>
    <TD><A href="../dashboard/statewisedwdb_release.jsp?YR=2022-23" class="glyphicon glyphicon-expand" style="color: #FFFFFF"></A></TD>
 </TR>
 
 
 
 </TABLE>
</H3>
</TD>
  <TD><DIV class="box box2 shadow2">
    <H3 align="right">        
        <TABLE width="80%" border="0" align="center"> 
		<BR>
  <TR>
      <TD colspan="4" class="table_row">Online EDP Training
	
	    <!--<a href="#" onClick="document.getElementById('id01').style.display='block'" style="color: #FFFFFF">Register</a>-->	<A href="#" style="color: #FFFFFF"></A></TD>
    </TR>
  
   <TR>
    <TD class="table_row"></TD>
    <TD class="table_row"></TD>
    <TD style="padding: 1%;"><A href="#"  style="color: #FFFFFF"></A></TD>
  </TR>
 <TR>
      <TD colspan="3" class="table_row" style="color: #FFFFFF"><A href="#"  style="color: #FFFFFF"  onClick="ShowNewPage ()";> Register</A>
	  </TD>
    </TR>
  
   <TR>
      <TD class="table_row"></TD>
    
    <TD class="table_row"></TD>
    <TD><A href="#"  style="color: #FFFFFF"></A></TD>
  </TR>
</TABLE>
</H3>
            
  </DIV></TD>
  </TR>
</TABLE>
</h3>
  </td>
  </tr>
</table>
  <BR>


</form>


  <DIV style="
  right: 0;
  bottom: 0;
  left: 0;
  padding: 0.5rem;
  background-color: #990000;
  text-align: center;
  color:  #FFFFFF;border-top: 1px solid #000"><B>DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI</B></DIV>
</BODY>
  

<SCRIPT language="javascript">
  var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");


 function ShowNewPage(){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("edp_doc.jsp",500,800,'',null,null);
 }//end of bank

 function refreshpage() {
  location.reload();
}

</SCRIPT>

</HTML>
