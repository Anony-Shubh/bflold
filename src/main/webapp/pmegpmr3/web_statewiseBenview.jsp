<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"  %>
<%String vstate= request.getParameter("pstate")==null?"":(String) request.getParameter("pstate"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>PMEGP Beneficiary statewise projects</title>
<!--link rel="stylesheet" href="css/legal2.css"-->
<link rel="stylesheet" type="text/css" href="css/indexr.css">
</head>

<body>
<p>&nbsp;</p>
<table align="center">
  <tr>
    <th colspan="7"><div align="center">Details of Benficieries under PMEGP</div></th>
  </tr>
  <tr>
    <td width="5%">Sr. No </td>
    <td width="20%">Name and Address of the Beneficiary</td>
    <td width="16%">Bank Branch </td>
	<td width="13%">Bank Loan </td>
	<td width="14%"> Margin Money released by Nodal Bank </td>
	<td width="19%">Date of Margin Money release</td>
	<td width="13%">Product category</td>
  </tr>
  <tr>
  <%
  String str= "  select  a.app_id, initcap(a.app_prix)||'. '||initcap(a.app_name)|| ',  '||  ";
 str=str+"  a.app_post_addr||', '||initcap(b.DISTRICT_NAME)||', '||initcap(c.STATE_NM) as addr , ";
 str=str+" initcap(bank_name)||', '||initcap(bank_post_addr) as banknm,d.bank_loan,d.mm_rel_amt,TO_CHAR(MM_REL_DT,'DD-MM-YYYY') AS MM_REL_DT,  ";
 str=str+ " initcap(nvl(prod_desc,'-')) as prod_desc, initcap(e.ACTIVITY_NAME) as activity_name ";
 str=str+" from app_detail a, m_district b , m_state c ,bank_detail d, activity_mast e ";
 str=str+" where a.APP_DIST_CD=b.DISTRICT_CD and b.STATE_CD=c.STATE_CD and a.ind_activity=e.ACTIVITY_CD ";
  str=str+" and a.app_id=d.app_id  and c.state_nm= '"+vstate+"' ";
   str=str+"   and d.mm_rel_dt  between '01-apr-2008' and sysdate and d.act_id=11   ";

 
 DBCon db= new DBCon();
 db.connect();
  ResultSet rs = db.execSQL(str);
  int cnt=0;  
  while (rs.next()){
  cnt=cnt+1;
  %>
  <th> <div align="center"><%= cnt %> </div></th>
  <th><%= rs.getString("addr") %></div></th>
  <th><%= rs.getString("banknm") %></div></th>
  <th> <div align="center"></div><div align="center"><%= rs.getString("bank_loan") %></div></th>
  <th> <div align="center"></div><div align="center"><%= rs.getString("mm_rel_amt") %></div></th>
  <th><%= rs.getString("mm_rel_dt") %>    </div></th>
  <th><%= rs.getString("activity_name") %>    </div></th>
  
  </tr>
  <%  }
   rs.close();
   db.close(); %>
</table>
</body>
</html>
