<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html>
<HTML lang="en">

<HEAD>

    <META CHARSET="utf-8">
    <META http-equiv="X-UA-Compatible" content="IE=edge">
    <META name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <META name="description" content="">
    <META name="author" content="">

    <TITLE>PMEGP DASHBOARD</TITLE>

    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <LINK href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<SCRIPT type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></SCRIPT>




  <SCRIPT type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Year', 'Target', 'Achievement'],
		  
		 
          ['2016-17', 1082.9, 1280.94],
		   ['2017-18', 1170.00, 1312.40],
		    ['2018-19', 2068.80, 2070.00],
			 ['2019-20', 2396.44, 1950.81],
			  ['2020-21', 2120.81, 1500.00],
		 
        ]);

        var options = {
          chart: {
            title: 'Year wise Govt. Subsidy(MM) Target and Achievement',
			
            subtitle: 'Target, Achievement',
          },
          bars: 'Vertical' ,// Required for Material Bar Charts.
		   colors: ['#003BA2','#1FBF30'],
		  // backgroundColor: '#F6FAC5',
		   
        
        };

        var chart = new google.charts.Bar(document.getElementById('barchart_material'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
	  
	      				function openModal() {
        document.getElementById('modal').style.display = 'block';
        document.getElementById('fade').style.display = 'block';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.getElementById('fade').style.display = 'none';
}

    </SCRIPT>

  <STYLE type="text/css">
<!--
.style1 {font-size: 18px}
.style2 {font-size: 18px; font-weight: bold; }
.style3 {font-size: 24px; }
-->
  </STYLE>
</HEAD>

<BODY id="page-top">


    <!-- Page Wrapper -->
    <DIV id="wrapper">

     

        <!-- Content Wrapper -->
        <DIV id="content-wrapper" class="d-flex flex-column">
<IMG src="img/banner3.jpg" > 
            <!-- Main Content -->
            <DIV id="content">

<BR>

                <!-- Begin Page Content -->
                <DIV class="container-fluid">
	<DIV align="center">			
	<A class="btn btn-primary" href="index.jsp">Home</A>
	<A class="btn btn-primary" href="index22.jsp">Summarized Report</A>
	<A class="btn btn-primary" href="pmegp/index.jsp">Pending Reports</A>
	<A class="btn btn-primary" href="analyticalrep.jsp">Analytical Reports</A>
	
	<A class="btn btn-primary" href="agewise_Ind.jsp">Agewise Report</A>

	
	</DIV>



<BR><CENTER>


<DIV class="row">
        
        <DIV class="col-sm-6">
		
		<BR><BR><BR><TABLE class="table table-striped table-dark">
<TR>
  <TH><DIV align="center">Year</DIV></TH>
  <TH><DIV align="center">Target (In Crs)</DIV></TH>
  <TH><DIV align="center">Achievement (In Crs)</DIV></TH>
  <TH><DIV align="center">Achievement%</DIV></TH>
  <TH><DIV align="center">Emp. Opp. created</DIV></TH>
</TR>
<TR>
  <TD><DIV align="center">2016-17</DIV></TD>
  <TD><DIV align="right">1082.90</DIV></TD>
  <TD><DIV align="right">1280.94</DIV></TD>
  <TD><DIV align="right"><STRONG>118.29%</STRONG></DIV></TD>
  <TD><DIV align="right">407840</DIV></TD>
</TR>
<TR>
  <TD><DIV align="center">2017-18</DIV></TD>
  <TD><DIV align="right">1170.00</DIV></TD>
  <TD><DIV align="right">1312.40</DIV></TD>
  <TD><DIV align="right"><STRONG>112.17%</STRONG></DIV></TD>
  <TD><DIV align="right">387184</DIV></TD>
</TR>
<TR>
  <TD><DIV align="center">2018-19</DIV></TD>
  <TD><DIV align="right">2068.80</DIV></TD>
  <TD><DIV align="right">2070.00</DIV></TD>
  <TD><DIV align="right"><STRONG>100.06%</STRONG></DIV></TD>
  <TD><DIV align="right">587416</DIV></TD>
</TR>
<TR>
  <TD><DIV align="center">2019-20</DIV></TD>
  <TD><DIV align="right">2396.44</DIV></TD>
  <TD><DIV align="right">1950.81</DIV></TD>
  <TD><DIV align="right"><STRONG>81.40%</STRONG></DIV></TD>
  <TD><DIV align="right">533224</DIV></TD>
</TR>
<TR>
  <TD><DIV align="center" class="style1">2020-21</DIV></TD>
  <TD><DIV align="right" class="style1">2120.81</DIV></TD>
  <TD><DIV align="right" class="style1">1500.00</DIV></TD>
  <TD><DIV align="right" class="style2">70.73%</DIV></TD>
  <TD><DIV align="right" class="style1">352776</DIV></TD>
</TR>
<TR>
  <TD><DIV align="center" class="style3">Total</DIV></TD>
  <TD><DIV align="right" class="style3">8838.95</DIV></TD>
  <TD><DIV align="right" class="style3">8114.15</DIV></TD>
  <TD><DIV align="right" class="style3"></DIV></TD>
  <TD><DIV align="right" class="style3">2268440</DIV></TD>
</TR>
</TABLE></DIV>
<DIV class="col-sm-6"><DIV id="barchart_material" style="width: 700px; height: 500px;border:1px solid #990000; padding:15px;"></DIV></DIV>
    </DIV>





</CENTER><BR>

                    

                </DIV>
                <!-- /.container-fluid -->

            </DIV>
                                                
                                                
                                                
                                                
                                                 
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <DIV class="container my-auto">
                    <DIV class="copyright text-center my-auto">
                        <SPAN>Copyright &copy; KVIC 2021</SPAN>
                    </DIV>
                </DIV>
            </footer>
            <!-- End of Footer -->

        </DIV>
        <!-- End of Content Wrapper -->

    </DIV>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <A class="scroll-to-top rounded" href="#page-top">
        <I class="fas fa-angle-up"></I>
    </A>


<SCRIPT>
function myFunction() {
  var x = document.getElementById("myDIV");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
</SCRIPT>
    <!-- Bootstrap core JavaScript-->
    <SCRIPT src="vendor/jquery/jquery.min.js"></SCRIPT>
    <SCRIPT src="vendor/bootstrap/js/bootstrap.bundle.min.js"></SCRIPT>

    <!-- Core plugin JavaScript-->
    <SCRIPT src="vendor/jquery-easing/jquery.easing.min.js"></SCRIPT>

    <!-- Custom scripts for all pages-->
    <SCRIPT src="js/sb-admin-2.min.js"></SCRIPT>

    <!-- Page level plugins -->
    <SCRIPT src="vendor/datatables/jquery.dataTables.min.js"></SCRIPT>
    <SCRIPT src="vendor/datatables/dataTables.bootstrap4.min.js"></SCRIPT>

    <!-- Page level custom scripts -->
    <SCRIPT src="js/demo/datatables-demo.js"></SCRIPT>
</FORM>
</BODY>

</HTML>