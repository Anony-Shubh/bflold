<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<style>
td_one{
border-top: 2px solid #ddd;
border-right: 2px solid #ddd;}

#content {
    padding:25px;
}

#fade {
    display: none;
    position:absolute;
    top: 0%;
    left: 0%;
    width: 100%;
    height: 1000%;
    background-color: #ababab;
    z-index: 1001;
    -moz-opacity: 0.8;
    opacity: .70;
    filter: alpha(opacity=80);
}

#modal {
    display: none;
    position: absolute;
    top: 45%;
    left: 45%;
    width: 120px;
    height: 67px;
    padding:30px 15px 0px;
    border: 3px solid #ababab;
    box-shadow:1px 1px 10px #ababab;
    border-radius:20px;
    background-color: white;
    z-index: 1002;
    text-align:center;
    overflow: auto;
}

#results {
    font-size:1.25em;
    color:red
}

</style>

<script>
function openModal() {
        document.getElementById('modal').style.display = 'block';
        document.getElementById('fade').style.display = 'block';
}
function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.getElementById('fade').style.display = 'none';
}
function closeAndRefresh(){
   window.parent.refresh_data();  
    }
</script>
</head>

<body onLoad="closeAndRefresh();">
<form name="form" id="form" class="form" method="post">
<br><br><br><br><br>
<div align="center">
<img id="loader" src="../images/nwloading.gif" />
<br/><br/><br/><br/>
<span style="color:#0000FF;font-size:16px;font-weight:bold">Please wait...</span></div>
	 
            
			

<%
 session.setAttribute("STATE", "AP");
    session.setAttribute("STATUS", "32");
%>
		
		
	
</form>
</body>
</html>
