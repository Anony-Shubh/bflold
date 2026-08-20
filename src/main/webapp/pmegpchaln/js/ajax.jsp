<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
</head>
<body>
require_once 'config.php';
if($_POST['type'] == 'country_table'){
	$row_num = $_POST['row_num'];
	$name = $_POST['name_startsWith'];
	$query = "SELECT name, numcode, phonecode, iso3 FROM country where UPPER(name) LIKE '".strtoupper($name)."%'";
	$result = mysqli_query($con, $query);
	$data = array();
	while ($row = mysqli_fetch_assoc($result)) {
		$name = $row['name'].'|'.$row['numcode'].'|'.$row['phonecode'].'|'.$row['iso3'].'|'.$row_num;
		array_push($data, $name);	
	}	
	echo json_encode($data);
}

<% 
DBCon db= new DBCon();
   db.connect();
   List values=new ArrayList();
     values.add ((String) request.getParameter("name_startsWith"); 
	 
 StringBuffer sb= new StringBuffer();
	sb.append (" SELECT IFSC_CODE AS name,BANK_NAME NUMCODE,BRANCHNAME AS PHONECODE,DISTRICT AS ISO3 FROM RBIBANKLIST WHERE IFSC_CODE=? ");
	

 ResultSet rs = db.executeSQL(sbt,values);

 %>

</body>
</html>
