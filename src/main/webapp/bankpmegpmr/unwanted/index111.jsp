<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Creating Popup Div | istockphp.com</title>
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"> </script>
<script type="text/javascript" src="js/script.js"></script>
</head>

<body>
	<a href="#" class="topopup">Click Here Trigger</a>
    
    <div id="toPopup"> 
    	
        <div class="close"></div>
       	<span class="ecs_tooltip">Press Esc to close <span class="arrow"></span></span>
		<div id="popup_content"> <!--your content start-->
           hello
              
            <p align="center"><a href="jasper/jaspxls/" class="livebox">click here to open</a></p>
        </div> <!--your content end-->
    
    </div> <!--toPopup end-->
    
	<div class="loader"></div>
   	<div id="backgroundPopup"></div>
</body>
</html>