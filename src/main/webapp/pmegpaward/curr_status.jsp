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
.style2 {font-size: 24px}

.buttonClass {
  font-size:15px;
  font-family:Arial;
  width:140px;
  height:50px;
  border-width:1px;
  color:#ffffff;
  border-color:#124d77;
  border-top-left-radius:3px;
  border-top-right-radius:3px;
  border-bottom-left-radius:3px;
  border-bottom-right-radius:3px;
  box-shadow:inset 0px 1px 0px 0px #54a3f7;
  text-shadow:inset 0px 1px 0px #154682;
  background:linear-gradient(#007dc1, #0061a7);
}

.buttonClass:hover {
  background: linear-gradient(#0061a7, #007dc1);
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

<%@ include file="pmegp_menu.jsp"%>


<% 

String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");
String sAPP_NAME=session.getAttribute("sAPP_NAME")==null?"0":(String)session.getAttribute("sAPP_NAME");

String final_sub_dt="";
String app_id="";
String inst_mda_sub_dt = "";
String app_name ="";
String unit_state="";
String unit_dist="";


DBCon db= new DBCon();
db.connect(); 
List values=new ArrayList();


 StringBuffer qrysb = new StringBuffer();



qrysb.append(" SELECT pv.app_id, pv.app_name,");
qrysb.append(" pv.unit_dist, pv.unit_state,pa.final_sub_dt ");
qrysb.append(" FROM  pmegpaward_view  pv, pmegp_award  pa WHERE  pv.app_id = pa.app_id(+) ");
qrysb.append("  AND pv.app_id =?");	

values.add(sAPP_ID);

ResultSet rsMain=db.executeSQL(qrysb.toString(),values);

	   
  while(rsMain.next())
{
//app_id1=rsMain.getString("app_id1")==null?"":rsMain.getString("app_id1");
app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
unit_state=rsMain.getString("unit_state")==null?"":rsMain.getString("unit_state");
unit_dist=rsMain.getString("unit_dist")==null?"":rsMain.getString("unit_dist");
final_sub_dt=rsMain.getString("final_sub_dt")==null?"":rsMain.getString("final_sub_dt");

  }
  rsMain.close();

%>

<br><br>


<table align="center" border="1px;">
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="style2"><em><strong>Applicant Name : <%= sAPP_NAME %></strong></em></span>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="style2"><em><strong>Applicant ID : <%= sAPP_ID %></strong></em></span>&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</table>

<%
if(!final_sub_dt.equals("")){

%>



<br><br>

<center> 
<h2>Current Status: Forwarded To Agency</h2><br>
<input name="button" type="button" class="buttonClass"  onClick="ShowReport('<%=app_id%>')" value="View Report">
</center>


<%}db.close();%>




</body>


		
</HTML>



