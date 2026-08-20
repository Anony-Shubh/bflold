<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP National Award</title>
<style>
#cont {
background:#993333;
padding-top:20px;
font-size:x-large;
text-shadow: 2px 2px 5px #F95502;
color:#FFFFFF;
}
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 70%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #3cb0fd;
  color: white;
}
.btn {
  background:linear-gradient(#ffc477, #fb9e25);
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
</style>

	</HEAD>
<body>
<img src="../images/nomination.jpeg" width="100%" >
<br><br>
<center>
<a href="dashboard.jsp" class="btn">Home</a>

<a href="../logout.jsp" class="btn">Logout</a>
</center>

<br> 
<%
String username=session.getAttribute("username")==null?"0":(String)session.getAttribute("username");

if(username.equals("0")){
response.sendRedirect("../logout.jsp");
}

String state_nm="";
String APP_ID = "";
String APP_SUBMITTED ="";
String state_cd ="";


     DBCon db= new DBCon();
      db.connect(); 


 StringBuffer qrysb = new StringBuffer();





qrysb.append(" SELECT MAX(ms.state_cd) as state_cd ,MAX(ms.state_nm) as state_nm ,COUNT(DISTINCT pa.app_id) AS APP_ID, COUNT(pa.final_sub_dt) AS APP_SUBMITTED  ");
qrysb.append(" FROM m_district   md, m_state   ms, app_detail   ad, pmegp_award  pa ");
qrysb.append(" WHERE md.district_cd = ad.unit_dist_cd AND md.state_cd = ms.state_cd AND ad.app_id = pa.app_id ");
qrysb.append(" GROUP BY ms.state_cd, ms.state_nm order by ms.state_nm"); 
%>

<table id="customers" align="center">
<thead style="background-color:#00FFFF; color:#000000">
    <tr>
	
      <th scope="col"><center>State</center></th>
      <th scope="col"><center>No. of applications Registered  </center></th>
      <th scope="col"><center>No. of applications Submitted</center></th>
    </tr>
  </thead>

<%	 
 
ResultSet rsMain=db.execSQL(qrysb.toString());  
	   
  while(rsMain.next())
{
state_cd=rsMain.getString("state_cd")==null?"":rsMain.getString("state_cd");
state_nm=rsMain.getString("state_nm")==null?"":rsMain.getString("state_nm");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_SUBMITTED=rsMain.getString("APP_SUBMITTED")==null?"":rsMain.getString("APP_SUBMITTED");

 
%>  
<tbody width="100%">

        <tr>
		 
          <td><div align="left" ><a href="viewpage.jsp?state_cd=<%=state_cd%>" ><%=state_nm %></a></div></td>
          <td><div align="center"><%= APP_ID %></div></td>
          <td><div align="center"><%= APP_SUBMITTED %></div></td>
        </tr>	 
</tbody>
<%}
 rsMain.close();
  db.close();%>
    </table>
</body>


		
</HTML>