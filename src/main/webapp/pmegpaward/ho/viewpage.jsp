<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>
<SCRIPT language="javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<script language="javascript" src="../js/fontawesome.js"></script>
<link rel="stylesheet" href="css/font-awesome.min.css" >
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

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
.btn {
font-size:15px;
  font-family:Arial;
  width:150px;
  height:30px;
  border-width:1px;
  color:#fff;
  border-color:#d02718;
  font-weight:bold;
  border-top-left-radius:18px;
  border-top-right-radius:18px;
  border-bottom-left-radius:18px;
  border-bottom-right-radius:18px;
  box-shadow: 3px 4px 0px 0px #8a2a21;
  text-shadow: 0px 1px 0px #810e05;
  background:linear-gradient(#c62d1f, #f24437);
}

.btn:hover {
  background: linear-gradient(#f24437, #c62d1f);
}

.btnnew {
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

.btnnew:hover {
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
	<script>
	 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
	function ShowReport(app_id,typenew){
 modalWin.ShowURL('../genrep.jsp?REP_NM=pmegpaward_report&app_id='+app_id+'&typenew='+typenew,900,1200,'PMEGP Nomination Award Report',null,null);
 }
 
 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function EnrollLater(){
modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}

function refreshpage(){
window.parent.location.reload();
}

	</script>
<body>

<img src="../images/nomination.jpeg" width="100%" >
<br><br>
<center>
<a href="dashboard.jsp" class="btnnew">Home</a>

<a href="../logout.jsp" class="btnnew">Logout</a>
</center>

<br>
<center><a href="state.jsp">Go Back</a></center>
 <table class="table table-striped" width="100%" id="container-fluid">

        <%
List values=new ArrayList();
String unit_state="";
String state_cd =request.getParameter("state_cd")==null?"":(String) request.getParameter("state_cd");
String app_id=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
String app_name = "";
String unit_dist ="";
String final_sub_dt ="";
//String STATE="";


     DBCon db= new DBCon();
      db.connect(); 


 StringBuffer qrysb = new StringBuffer();

qrysb.append(" SELECT ms.state_cd, ms.state_nm AS unit_state, pa.app_id   AS app_id, ");
qrysb.append(" pa.final_sub_dt , ad.app_name, md.district_name AS unit_dist");
qrysb.append(" FROM m_district   md, m_state      ms, app_detail   ad, pmegp_award  pa ");
qrysb.append(" WHERE md.district_cd = ad.unit_dist_cd AND md.state_cd = ms.state_cd AND ad.app_id = pa.app_id AND pa.final_sub_dt is not null AND md.state_cd =? ");

/*qrysb.append(" SELECT pa.app_id, pa.final_sub_dt, pv.app_name, pv.unit_state,  pv.unit_dist");
qrysb.append(" FROM pmegpaward_view PV,PMEGP_AWARD PA ");
qrysb.append(" WHERE pv.app_id=pa.app_id AND pa.final_sub_dt is not null AND pv.unit_state=? ");
*/
values.add(state_cd);
ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
//out.print(state_cd); 
 %>
 <thead width="85%" style="background-color:#3cb0fd; color:#000000">
    <tr>
	<th scope="col"><center>Applicant ID</center></th>
	<th scope="col"><center>Applicant Name</center></th>
      <th scope="col"><center>State</center></th>
      <th scope="col"><center>District</center></th>
      <th scope="col"><center>Report</center></th>
	  <th scope="col"><center>Documents</center></th>
    </tr>
  </thead>
<%	   
  while(rsMain.next())
{
app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
unit_state=rsMain.getString("unit_state")==null?"":rsMain.getString("unit_state");
unit_dist=rsMain.getString("unit_dist")==null?"":rsMain.getString("unit_dist");

%>  
<tbody width="100%">
        <tr>
		<td><div align="center" ><%=app_id %></div></td>
		<td><div align="center" ><%=app_name %></div></td>
		<td><div align="center" ><%=unit_state %></div></td>
          <td><div align="center" ><%=unit_dist %></div></td>
          <td><div align="center" ><input name="button" type="button" class="btn"  onClick="ShowReport('<%=app_id%>','1')" value="View Report"></div></td>
          <td><div align="center"><div align="center" ><a href="viewdocument.jsp?app_id=<%=app_id%>&app_name=<%= app_name %>"><input name="button" type="button" class="btn" value="View Documents"></a></div></td>
        </tr>
</tbody>
	   <%
 
  }
  rsMain.close();
//  values.clear();
  db.close();
  
  
 %>
    </table>
</body>


		
</HTML>
