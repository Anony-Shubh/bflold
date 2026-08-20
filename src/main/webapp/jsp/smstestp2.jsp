<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>


<html>
<head>

</head>
<body>
<form action="smstestp1.jsp" method="post">

  <p align="center">
  SMS Message: 
    <textarea name="smsmsg" cols="100" rows="4"></textarea>
  </p>
  <p align="center"><br>
    
   Mobile No: 
     <textarea name="MOB_NO1" cols="100" rows="10"></textarea>
  </p>
  <p align="center"></br>
    <input name="SENDSMS" type="submit" value="SENDSMS">
    </p>
</form>
</body>
</html>

    
    
		


