<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="pkgPmegpNew.DBCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PVJOINT</title>
 
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
 <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.7.0/css/select.dataTables.min.css" />
 <script type="text/javascript" language="javascript" src="../js/jquery-3.7.0.js"></script>
  <script type="text/javascript" language="javascript" src="../js/jquery.dataTables.min.js"></script>
 <SCRIPT type="text/javascript" language="javascript" src="https://cdn.datatables.net/colreorder/1.7.0/js/dataTables.colReorder.min.js" ></SCRIPT>
 
 <link rel="stylesheet" type="text/css" href="js/jquery.dataTables.min.css" />


 <script type="text/javascript" language="javascript" src="js/jquery-3.7.0.js"></script>
  <script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
</head>

<body>

<div>
&nbsp;
</div>
<table id="example" class="display nowrap dt[-head|-body]-center" style="width:100%"  >
<thead>
<tr >

<th ><div align="center">Sr No.</div></th>
<th><div align="center">Office Name</div></th>
<th> <div align="center">PV to be conduct</div></th>
<th><div align="center">Assigned for Joint PV</div></th>
<th><div align="center">Under Process for Joint PV </div></th>
<th><div align="center">Joint PV Completed</div></th>
</tr>
</thead>
<tbody >
<%




 DBCon db= new DBCon();
db.connect();

int SRNO=0;
String state_nm="";
String noofapp="";
String NOOFASSIGN="";
String PENDIN="";
String noofcpmpleted="";
StringBuffer qrysb = new StringBuffer();



qrysb.append("select ms.state_nm , count(ms.state_nm) as noofapp, sum(DECODE(gto.enum_cd,NULL,'0','1')) AS NOOFASSIGN,sum(DECODE(gto.qc_ver_dt,null,'0','1')) as noofcpmpleted,SUM(CASE WHEN ");
qrysb.append("gto.enum_cd IS NOT NULL AND GTO.qc_ver_dt IS NULL THEN 1 ELSE 0 END ) PENDIN ");
 qrysb.append("from PMEGPGEOTAG.geotag_trans_online gto, pmegpnew.app_detail ad,pmegpnew.m_state ms,pmegpnew.m_district md "); 
qrysb.append("where gto.app_id=ad.app_id and ad.unit_dist_cd=md.district_cd and ms.state_cd=md.state_cd  group by  rollup(ms.state_nm) "); 





ResultSet rsMain = db.execSQL(qrysb.toString());



while (rsMain.next()){

state_nm=rsMain.getString("state_nm")==null?"":rsMain.getString("state_nm");
noofapp=rsMain.getString("noofapp")==null?"":rsMain.getString("noofapp");
NOOFASSIGN=rsMain.getString("NOOFASSIGN")==null?"":rsMain.getString("NOOFASSIGN");
noofcpmpleted=rsMain.getString("noofcpmpleted")==null?"":rsMain.getString("noofcpmpleted");
PENDIN=rsMain.getString("PENDIN")==null?"":rsMain.getString("PENDIN");
SRNO++;
%>



<tr >
<td><div align="center"><%=SRNO%></div></td>
<td><div align="center"><%=state_nm%></div></td>
<td><div align="center"><a href="jpvRepoJasper.jsp?STATECD=<%=state_nm%>&QRYCODE=1"><%=noofapp%></a></div></td>
<td><div align="center"><a href="jpvRepoJasper.jsp?STATECD=<%=state_nm%>&QRYCODE=2"><%=NOOFASSIGN%></a></div></td>
<td><div align="center"><a href="jpvRepoJasper.jsp?STATECD=<%=state_nm%>&QRYCODE=3"><%= PENDIN %></a></div></td>
<td><div align="center"><a href="jpvRepoJasper.jsp?STATECD=<%=state_nm%>&QRYCODE=4"><%=noofcpmpleted%></a></div></td>

</tr>
<%
}
rsMain.close();

db.close();
%></tbody>
</table>

</body>
<script>
new DataTable('#example', {
    colReorder: true,
    responsive: true
});</script>
</html>
