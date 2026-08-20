<html>
<head>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="msgwindow.js"></script>
<link rel="stylesheet" type="text/css" href="loadingbox.css">
<script type="text/javascript">
$.hideprogress = function()
{
    $("#processing_container").remove();
    $("#processing_overlay").remove();
}

function fillinbox(){
     $.showprogress('PMEGP e-Tracking Monitoring Report','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post("../pmegpdashboardmr.jsp",{action:'PMEGP Monitoring Report Loading...',page:'1'},
         function(ret){
          $("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
      $.hideprogress();
}


</script>
</head>
<div id="divResult" >
</div>

</body>
</html>