<%@ page session="true" buffer="1000kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.math.*"   %>


<HTML>
<HEAD>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>

    <TITLE>upload </TITLE>
<script src="js/sweetalert.min.js"></script>
<SCRIPT language="javascript">

	
	
function submit_form() {

	document.form.ins.value='I';
	document.form.submit();
	
}

</SCRIPT>
<script language="javascript" src="js/fontawesome.js"></script>
<script language="javascript" src="js/ModalPopupWindow.js"></script>
<style>
#container{
  font-family: Arial, Helvetica, sans-serif;
  width: 80%;
  border-style: inset;
}
#container td {
  padding:6px;
  font-family: Arial bold, Helvetica, sans-serif;
  fond-size: 50px;
  color:#FF0000;
 
}

#container tr:hover, #container tr:active {text-decoration: underline; background-color: #ddd;} 

#container th {
  font-family: Arial black, Helvetica, sans-serif
  font-weight: bold;
  padding: 12px;
  text-align: center;
  border-style: inset;
   background-color: #3f506e;
  color:#FFFFFF;
  
}
input[type=text] {
  width: 85%;
  box-sizing: border-box;
  color: white;
}

.SR {
border: 1px solid #221F1F;
background-color: #8B9DC3;
text-align: center;

}

.button1 {  background-color: #8B9DC3;
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
  font-weight: bold;
}


.button11 { background-color: #3f506e;
  color:#FFFFFF;
  border: none;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
  font-weight: bold;
}
</style>
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
<%@ include file="pmegp_menu.jsp"%>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</HEAD>

<BODY>
<FORM method="post" name="form" id="form"  >

<%

DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();
String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");
String app_id1=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String iso_cert_yn="";
String gst_cert_yn="";
String udyam_cert_yn="";
String trademark_cert_yn="";
String gem_cert_yn="";
String ecom_cert_yn="";
String mob_no_n="";
String email_n="";
String unit_name="";
String est_date="";
String anl_sales_amt1="";
String anl_emp1="";
String anl_updoc1="";
String anl_sales_amt2="";
String anl_emp2="";
String anl_updoc2="";
String anl_sales_amt3="";
String anl_emp3="";
String anl_updoc3="";
String iso_updoc="";
String gst_updoc="";
String udyam_updoc="";
String trademark_updoc="";
String gem_updoc="";
String ecom_updoc="";
String final_sub_dt="";
String supply_cert_yn ="";
String supply_updoc ="";
String partic_cert_yn ="";
String partic_updoc  ="";
String FINAL_SUB_DT="";
String add_update="I";

if(!sAPP_ID.equals("")){
StringBuffer poR = new StringBuffer();

poR.append(" select app_id, mob_no_n, email_n, unit_name, to_char(est_date,'DD-MON-YYYY')est_date, anl_sales_amt1, anl_emp1,");
poR.append(" ANL_UPDOC1, anl_sales_amt2, anl_emp2, ANL_UPDOC2,  ");
poR.append(" anl_sales_amt3, anl_emp3, ANL_UPDOC3,  iso_cert_yn, iso_updoc, ");
poR.append(" gst_cert_yn, gst_updoc,  udyam_cert_yn, udyam_updoc, ");
poR.append("trademark_cert_yn, trademark_updoc, gem_cert_yn , gem_updoc,");
poR.append(" ecom_cert_yn, ecom_updoc, final_sub_dt, supply_cert_yn, supply_updoc, partic_cert_yn, partic_updoc from pmegp_award ");
poR.append(" where app_id= ? ");

//out.print (poR.toString());
values.add(sAPP_ID);


ResultSet rsMain = db.executeSQL(poR.toString(),values);

while (rsMain.next()){

app_id1=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
iso_cert_yn=rsMain.getString("iso_cert_yn")==null?"":rsMain.getString("iso_cert_yn");
gst_cert_yn=rsMain.getString("gst_cert_yn")==null?"":rsMain.getString("gst_cert_yn");
udyam_cert_yn=rsMain.getString("udyam_cert_yn")==null?"":rsMain.getString("udyam_cert_yn");
trademark_cert_yn=rsMain.getString("trademark_cert_yn")==null?"":rsMain.getString("trademark_cert_yn");
gem_cert_yn=rsMain.getString("gem_cert_yn")==null?"":rsMain.getString("gem_cert_yn");
ecom_cert_yn=rsMain.getString("ecom_cert_yn")==null?"":rsMain.getString("ecom_cert_yn");
mob_no_n=rsMain.getString("mob_no_n")==null?"":rsMain.getString("mob_no_n");
email_n=rsMain.getString("email_n")==null?"":rsMain.getString("email_n");
unit_name=rsMain.getString("unit_name")==null?"":rsMain.getString("unit_name");
est_date=rsMain.getString("est_date")==null?"":rsMain.getString("est_date");
anl_sales_amt1=rsMain.getString("anl_sales_amt1")==null?"":rsMain.getString("anl_sales_amt1");
anl_emp1=rsMain.getString("anl_emp1")==null?"":rsMain.getString("anl_emp1");
anl_updoc1=rsMain.getString("anl_updoc1")==null?"":rsMain.getString("anl_updoc1");
anl_sales_amt2=rsMain.getString("anl_sales_amt2")==null?"":rsMain.getString("anl_sales_amt2");
anl_emp2=rsMain.getString("anl_emp2")==null?"":rsMain.getString("anl_emp2");
anl_updoc2=rsMain.getString("anl_updoc2")==null?"":rsMain.getString("anl_updoc2");
anl_sales_amt3=rsMain.getString("anl_sales_amt3")==null?"":rsMain.getString("anl_sales_amt3");
anl_emp3=rsMain.getString("anl_emp3")==null?"":rsMain.getString("anl_emp3");
anl_updoc3=rsMain.getString("anl_updoc3")==null?"":rsMain.getString("anl_updoc3");
iso_updoc=rsMain.getString("iso_updoc")==null?"":rsMain.getString("iso_updoc");
gst_updoc=rsMain.getString("gst_updoc")==null?"":rsMain.getString("gst_updoc");
udyam_updoc=rsMain.getString("udyam_updoc")==null?"":rsMain.getString("udyam_updoc");
trademark_updoc=rsMain.getString("trademark_updoc")==null?"":rsMain.getString("trademark_updoc");
gem_updoc=rsMain.getString("gem_updoc")==null?"":rsMain.getString("gem_updoc");
ecom_updoc=rsMain.getString("ecom_updoc")==null?"":rsMain.getString("ecom_updoc");
FINAL_SUB_DT=rsMain.getString("FINAL_SUB_DT")==null?"":rsMain.getString("FINAL_SUB_DT");
supply_cert_yn=rsMain.getString("supply_cert_yn")==null?"":rsMain.getString("supply_cert_yn");
supply_updoc=rsMain.getString("supply_updoc")==null?"":rsMain.getString("supply_updoc");
partic_cert_yn=rsMain.getString("partic_cert_yn")==null?"":rsMain.getString("partic_cert_yn");
partic_updoc=rsMain.getString("partic_updoc")==null?"":rsMain.getString("partic_updoc");




}
rsMain.close();

}





%>

<table id="container" align="center">
  <tr>
    <th ><div align="center"><strong> FINAL VALIDATION </strong></div></th>
  </tr>
  <tr>
    <td colspan="4"><p align="center" class="text_header">
      <input name="FINAL_SUB_DT" type="hidden" id="FINAL_SUB_DT"  value="<%= FINAL_SUB_DT %>">
      <input name="app_id" type="hidden" id="app_id"  value="<%= sAPP_ID %>">
      <input name="ins" type="hidden" id="ins"  value="<%= ins %>">
    </p></td>
  </tr>
  <% if (mob_no_n.equals("") ){ %>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21; Please Enter Your Mobile Number </td>
  </tr>
  <%}%>
  <% if (email_n.equals("") ){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter Your Email ID </td>
  </tr>
  <%}%>
  <%if(unit_name.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter Unit Name </td>
  </tr>
  <%}%>
  <%if(est_date.equals("")){%>
  <tr> </tr>
  <%}%>
  <%if(anl_sales_amt1.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter annual sales amount for 2018-19 </td>
  </tr>
  <%}%>
  <%if(anl_emp1.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter Annual Employee Generation for  2018-19 </td>
  </tr>
  <%}%>
  <%if(anl_updoc1.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload CA Certificate for 2018-19 </td>
  </tr>
  <%}%>
  <%if(anl_sales_amt2.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter annual sales amount for 2019-20 </td>
  </tr>
  <%}%>
  <%if(anl_emp2.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter Annual Employee Generation for  2019-20 </td>
  </tr>
  <%}%>
  <%if(anl_updoc2.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload CA Certificate for 2019-20 </td>
  </tr>
  <%}%>
  <%if(anl_sales_amt3.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter annual sales amount for 2020-21 </td>
  </tr>
  <%}%>
  <%if(anl_emp3.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Enter Annual Employee Generation for 2020-21 </td>
  </tr>
  <%}%>
  <%if(anl_updoc3.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload CA Certificate for 2020-21 </td>
  </tr>
  <%}%>
  <%if(iso_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select ISO Certificate </td>
  </tr>
  <%}%>
  <%if(iso_cert_yn.equals("Y")&(iso_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload ISO certificate </td>
  </tr>
  <%}%>
  <%if(gst_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select GST Certificate</td>
  </tr>
  <%}%>
  <%if(gst_cert_yn.equals("Y")&(gst_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload GST certificate </td>
  </tr>
  <%}%>
  <%if(udyam_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select UDYAM Certificate</td>
  </tr>
  <%}%>
  <%if(udyam_cert_yn.equals("Y")&(udyam_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload UDYAM certificate </td>
  </tr>
  <%}%>
  <%if(trademark_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select Trademark Certificate</td>
  </tr>
  <%}%>
  <%if(trademark_cert_yn.equals("Y")&(trademark_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload Trademark certificate </td>
  </tr>
  <%}%>
  <%if(gem_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select Gem Certificate</td>
  </tr>
  <%}%>
  <%if(gem_cert_yn.equals("Y")&(gem_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload Gem certificate </td>
  </tr>
  <%}%>
  <%if(ecom_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select E-commerce Certificate </td>
  </tr>
  <%}%>
  <%if(ecom_cert_yn.equals("Y")&(ecom_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload E-commerce certificate </td>
  </tr>
  <%}%>
    <%if(supply_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select Supply to Government/Public Offices/Corporates Certificate </td>
  </tr>
  <%}%>
  <%if(supply_cert_yn.equals("Y")&(supply_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload Supply to Government/Public Offices/Corporates certificate </td>
  </tr>
  <%}%>
    <%if(partic_cert_yn.equals("")){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please select Participation in national/ local level exhibitions,trade fairs ect. Certificate </td>
  </tr>
  <%}%>
  <%if(partic_cert_yn.equals("Y")&(partic_updoc.equals(""))){%>
  <tr>
    <td><i class='fas fa-exclamation'></i> &#x21;  Please Upload Participation in national/ local level exhibitions,trade fairs ect. certificate </td>
  </tr>
  <%}%>

  <% if (!mob_no_n.equals("")&!email_n.equals("")&!unit_name.equals("")&!anl_sales_amt1.equals("")&!anl_emp1.equals("")&!anl_updoc1.equals("")&!anl_sales_amt2.equals("")&!anl_emp2.equals("")&!anl_updoc2.equals("")&!anl_sales_amt3.equals("")&!anl_emp3.equals("")&!anl_updoc3.equals("")&(iso_cert_yn.equals("Y")&!iso_updoc.equals("")||!iso_cert_yn.equals("Y")&iso_updoc.equals(""))&(gst_cert_yn.equals("Y")&!gst_updoc.equals("")||!gst_cert_yn.equals("Y")&gst_updoc.equals(""))&(udyam_cert_yn.equals("Y")&!udyam_updoc.equals("")||!udyam_cert_yn.equals("Y")&udyam_updoc.equals(""))&(trademark_cert_yn.equals("Y")&!trademark_updoc.equals("")||!trademark_cert_yn.equals("Y")&trademark_updoc.equals(""))&(gem_cert_yn.equals("Y")&!gem_updoc.equals("")||!gem_cert_yn.equals("Y")&gem_updoc.equals(""))&(ecom_cert_yn.equals("Y")&!ecom_updoc.equals("")||!ecom_cert_yn.equals("Y")&ecom_updoc.equals(""))&(supply_cert_yn.equals("Y")&!supply_updoc.equals("")||!supply_cert_yn.equals("Y")&supply_updoc.equals(""))&(partic_cert_yn.equals("Y")&!partic_updoc.equals("")||!partic_cert_yn.equals("Y")&partic_updoc.equals(""))) { %>
  
  <tr>
    <% if (FINAL_SUB_DT.equals("")){%>
    <td><div style="text-align:center; padding:6px; font-weight:bold; font-size:24px">Once forwarded to agency, you will not be able to update data!</div>
        <center>
          <input name="button" type="button" class="button11" onClick="submit_form();" value="FORWARD TO AGENCY">
        </center>
      <%}else{%>
    <td><div style="text-align:center; padding:6px; font-weight:bold; font-size:24px">Data Successfully Forwarded to Agency</div></td>
    <!--<td><div align="center"><INPUT type="button" class="button" value="View Report"  onClick="ShowReport('<//%=app_id %>')"></div> -->
    <%}%>
  </tr>
  <%}%>
  </table>
<%
if (ins.equals("I")) {

app_id1=(String) request.getParameter("app_id")==null?"":(String) request.getParameter("app_id").trim();
FINAL_SUB_DT=(String) request.getParameter("FINAL_SUB_DT")==null?"":(String) request.getParameter("FINAL_SUB_DT").trim();


		
		
        //List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		

qryUpdate.append("UPDATE pmegp_award SET ");
qryUpdate.append("FINAL_SUB_DT=SYSDATE");

qryUpdate.append(" WHERE app_id=?");

out.print (qryUpdate.toString());

values.add(sAPP_ID); pstm.add ("L");


try{

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
}
 catch(Exception e){
out.print(e.toString());
	

}

response.sendRedirect("savepage.jsp");
}
%>

</FORM>



</BODY>
</HTML>