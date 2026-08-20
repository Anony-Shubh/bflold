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
		
      <script type = "text/javascript" language = "javascript">
         $(document).ready(function() {
		 
            $("#driver").click(function(event){
               $.ajax( {
                  url:'a.jsp?fn=GENDER',
                  success:function(data) {
                     $('#stage').html(data);
                  }
               });
            });
			
			 $("#Agency").click(function(event){
               $.ajax( {
                  url:'a.jsp?fn=AGENCYGRAPH',
                  success:function(data) {
                     $('#stage').html(data);
                  }
               });
            });
			
			$("#Unit").click(function(event){
               $.ajax( {
                  url:'a.jsp?fn=UNIT_GRAPH',
                  success:function(data) {
                     $('#stage').html(data);
                  }
               });
            });
			
         });
      </script>

</head>
<body>


<div id="header" align="center">
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
</div>
<br />
<div>
<div class="row">
<div class="col-md-11">

 <center> <img src="../images/pmegpetrackN.png" align="middle" /></center>
 </div>
 
 <div class="col-md-1">
 <center><a href="index.jsp" class="greenButtonRound" >
 <img src="images/back.png" height="5%">
 Back</a></center>

</div>
  </div>

<div class="col-md-3">
<center>
<button type="button" id = "driver" class="btn btn-primary btn-block btn-warning">Gender Wise No of Application Received Graph</button>
<button name="button" id="Agency" class="btn btn-primary btn-block btn-info">Agency wise Graph</button>

<button name="button" id="Unit" class="btn btn-primary btn-block btn-warning">Unit Location wise Graph</button>

       
       
		 
		  
</center>
   </div>
   
   <div class="row">
<div class="col-md-5" align="center">
<center>
    <div id = "stage" align="center">
       SELECT GRAPH TYPE
      </div>
	</center>  
</div>
</div>

  </div>

</body>

</html>