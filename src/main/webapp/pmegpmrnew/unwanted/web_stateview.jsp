<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>PMEGP Beneficiary statewise projects</title>
<!--link rel="stylesheet" href="css/legal2.css"-->
<link rel="stylesheet" type="text/css" href="css/indexr.css">
</head>

<body>
<p>&nbsp;</p>
<table width="335" align="center">
  <tr>
    <th colspan="3">No. of Projects for which Margin Money released (From 1-4-2008 till today) </th>
  </tr>
  <tr>
    <th width="50">Sr. No </th>
    <th width="165">Name of the State</th>
    <th width="81">No. of Projects </th>
  </tr>
  <tr>
  <%
  String str= "select nvl(state_nm,'TOTAL') as state_nm,proj_no from ( ";
 str=str+"  SELECT c.STATE_NM, count(a.app_id) AS proj_no from app_detail a, m_district b , m_state c ,bank_detail d, activity_mast e ";
 str=str+" where a.APP_DIST_CD=b.DISTRICT_CD and b.STATE_CD=c.STATE_CD and a.ind_activity=e.ACTIVITY_CD ";
 str=str+" and a.app_id=d.app_id and trunc(d.mm_rel_dt)  between '01-apr-2008' and sysdate and d.act_id=11 ";
 str=str+" GROUP BY ROLLUP (c.STATE_NM)  ) ";
 
 DBCon db= new DBCon();
 db.connect();
  ResultSet rs = db.execSQL(str);
  int cnt=0;  
  while (rs.next()){
  cnt=cnt+1;
  String stnm="";
  stnm=rs.getString("state_nm");
 if(!stnm.equals("TOTAL")){
   %>
    <th> <div align="center"><%= cnt %> </div></th>
  <%}else { %>
     <th> <div align="center">     </div></th> <%}%>
     <th> <div align="left"><%= rs.getString("state_nm") %> </div></th> 
	 <th> <a href="web_statewiseBenview.jsp?pstate=<%= rs.getString("state_nm") %> "><div align="center"><%= rs.getString("proj_no")%> </a></div></th>  
	
  </tr>
  <%  }
   rs.close();
   db.close(); %>
</table>
</body>
</html>
