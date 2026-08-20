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
	 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/pmegpdashboard.css">

 <script type = "text/javascript" src = "http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		

</head>
<body>


<div id="header" align="center">
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
</div>
<br />
<div>
<div class="row">
<div class="col-md-11">

 <center> 
   <img src="../images/pmegpetrackN.png" align="middle" />
 </center>
 </div>
 
 <div class="col-md-1">
 <center>
   <p><a href="index.jsp" class="greenButtonRound" >
   <img src="images/back.png" height="5%">
   Back</a></p>
   <p>&nbsp;</p>
 </center>

</div>
  </div>

<div class="col-md-3">
  <center>
    <p><a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE_1819" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2018-19)</a>	<br>
        <br>
        <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport_1819" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2018-19)</a>  <br>
      <br>
      
      
        <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2019-20) </a>	<br>
        <br>
        <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2019-20)</a>  </p>
    <p><a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE2021" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2020-21) </a> <br>
      <br>
      <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport2021" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2020-21)</a> <br>
      <br>
	   <p><a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE2122" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2021-22) </a> <br>
      <br>
      <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport2122" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2021-22)</a> <br>
      <br>
	  
	    <br>
	   <p><a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE2223" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2022-23) </a> <br>
      <br>
      <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport2223" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2022-23)</a> <br>
      <br>
	  
	  
	  	    <br>
	   <p><a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE2324" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2023-24) </a> <br>
      <br>
      <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport2324" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2023-24)</a> <br>
      <br>
	  
	  
	  
	  	    <br>
	   <p><a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE2425" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT BE (2024-25) </a> <br>
      <br>
     <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=summaryreport2425" target="_blank" class="button">PMEGP MM TARGET SUMMARISED REPORT (2024-25)</a> <br>
      <br>
	  
	  
        <!-- <a href="../jasperrop/jaspergen_mmdetailreport.jsp?RNAME=PMEGPNEW_TARGET_ONLINE_RE" target="_blank" class="button">PMEGP MM TARGET BIWEEKLY REPORT RE</a>	<br>-->
      </p>
  </center>
  </div>
  

  </div>

</body>

</html>