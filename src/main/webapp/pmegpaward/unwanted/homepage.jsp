<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>
<SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>
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
</style>

	</HEAD>
	<script>
	 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 
	function ShowReport(app_id){
 modalWin.ShowURL('genrep.jsp?REP_NM=pmegpaward_report&app_id='+app_id,900,1200,'PMEGP Nomination Award Report',null,null);
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
<table align="center" border="1" width="100%" id="container-fluid">
<tr>
<th></div><img src="images/nomination.jpeg" width="100%" ></div></th></tr></table>
 
    <DIV id="container-fluid" >
	<% String final_sub_dt=""; %>
 <table class="table table-striped" width="100%" id="container-fluid">
 
        <%

String app_id="";
String inst_mda_sub_dt = "";
String app_name ="";
String unit_state="";
String unit_dist="";


     DBCon db= new DBCon();
      db.connect(); 


 StringBuffer qrysb = new StringBuffer();



qrysb.append(" SELECT pv.app_id, pv.app_name,");
qrysb.append(" pv.unit_dist, pv.unit_state,pa.final_sub_dt ");
qrysb.append(" FROM  pmegpaward_view  pv, pmegp_award  pa WHERE  pv.app_id = pa.app_id(+) ");
qrysb.append("  AND pv.app_id IN ('KVTN16176970-1222110','KVTN16176896-1208353')");	
%>
<thead width="100%" style="background-color:#3f506e; color:#FFFFFF">
    <tr>
      <th scope="col"><center>Application ID</center></th>
      <th scope="col"><center>Application Name</center></th>
      <th scope="col"><center>State</center></th>
      <th scope="col"><center>District</center></th>
	  <th scope="col"><center>Current Status</center></th>
	  <% if(final_sub_dt.equals("")){%>
	  <th scope="col"><center>Add/Update</center></th><%}%>
	   <% if(!final_sub_dt.equals("")){%>
	  <th scope="col"><center>Report</center></th><%}%>
    </tr>
  </thead>

<%	 
 
ResultSet rsMain=db.execSQL(qrysb.toString());
	   
  while(rsMain.next())
{
//app_id1=rsMain.getString("app_id1")==null?"":rsMain.getString("app_id1");
app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
unit_state=rsMain.getString("unit_state")==null?"":rsMain.getString("unit_state");
unit_dist=rsMain.getString("unit_dist")==null?"":rsMain.getString("unit_dist");
final_sub_dt=rsMain.getString("final_sub_dt")==null?"":rsMain.getString("final_sub_dt");


%>  
<tbody width="100%">
        <tr>
          <td><div align="center" ><%=app_id %></div></td>
          <td><div align="center"><%= app_name %></div></td>
          <td><div align="center"><%= unit_state %></div></td>
          <td><div align="center"><%= unit_dist %></div></td>
          <td><div align="center" >
            <% if(final_sub_dt.equals("")){%>
            <% out.print("-");%>
              <%}else{%>
            <%out.print("Forwarded To Agency");}%>
          </div></td>
          <%if(final_sub_dt.equals("")){%>
          <td><div align="center" > <a href="award_guidelines.jsp?app_id=<%=app_id%>" class="button1"  value="Add/Update">Add Update</a> </div></td>
          <%}%>
          <%if(!final_sub_dt.equals("")){%>
          <td><div align="center">
            <input name="button" type="button" class="button1"  onClick="ShowReport('<%=app_id%>')" value="View Report">
          </div><%}%> </td>
        </tr>
		 <%
 
  }
  rsMain.close();
  db.close();
  %>

      </tbody>
    </table>
</body>


		
</HTML>



