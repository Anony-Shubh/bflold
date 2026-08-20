<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"  %>
<html>
<head>
<title>Untitled Document</title>
<style>
.outer{
width:250px;
height:200px;
border: 2px solid blue; 
padding: 5px;
margin:0 auto;	
margin-top:150px;
text-align:center;
}
</style> 
 <script language="javascript">
function closeAndRefresh(){
     window.parent.refresh_data();
    }

	</script>
</head>

<body>
<form name ="form">
<div class="outer"><br/>
<center><img src="../images/data.jpeg" width="30%"></center><br/><br/>
<b><center>Data Saved Successfully.......</center></b>
<br/><input name="btnsave" type="button" value="close" onclick="closeAndRefresh();">
</div>
</form>
</body>

</html>
