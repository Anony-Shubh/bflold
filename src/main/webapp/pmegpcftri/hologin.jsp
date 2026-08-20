<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
 <SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>


  <script type="text/javascript" language="javascript" src="js/jquery-3.5.1.js"></script>
 <script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
 <script type="text/javascript" language="javascript" src="js/dataTables.bootstrap4.min.js"></script>
<script type="text/javascript" language="javascript" src="js/dataTables.fixedColumns.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.min.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Untitled Document</title>

<style>
.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
td,th{
  border-top: 1px solid #dddddd;
  border-bottom: 1px solid #dddddd;
  border-right: 1px solid #dddddd;
    border-left: 1px solid #dddddd;

}
h2:hover{
 font-size: 30px;
}

</style>

</head>


<body>



<img src="images/cftri.jpeg" width="100%" height="200" border="" ></div>
<div align="center" style="padding-left:20px;"> 
      <h2><a href="logout.jsp" class="previous"><strong>Logout</strong></a></h2>
	   <h2><a href="cftriReport.jsp" class="previous"><strong>Download Applicant List</strong></a></h2>
</div>
<div>&nbsp;</div>
<% 
String name=session.getAttribute("kvic@123")==null?"":(String) session.getAttribute("kvic@123");
if (name.equals("")) {
                    session.invalidate();
                    request.setAttribute("errorMessage", "Session Out Login Again.....");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response); 
					response.sendRedirect("index.jsp");
}
%>
<table id="example" class="table"  style="width:98%">
  <thead >
    <tr>
      <th style="background-color:#3399FF; color:#FFFFFF;">Srno</th>             
      <th style="background-color:#3399FF; color:#FFFFFF;"><div align="center">
        <h3>Beneficiary Id</h3>
      </div></th>
	  <th  style="background-color:#3399FF; color:#FFFFFF;"><div align="center">
	    <h3>Beneficiary Name</h3>
	  </div></th>
	 
<th  style="background-color:#3399FF; color:#FFFFFF;"><div align="center">
  <h3>Date of Submission</h3>
</div></th>
<th  style="background-color:#3399FF; color:#FFFFFF;"><div align="center">
  <h3>Report</h3>
</div></th>
    </tr>
  </thead>

<tbody>
<%
 DBCon db= new DBCon();
db.connect();

List values=new ArrayList();

String app_id ="";
String app_name = "";
String mob_no1 = "";

String mob_no = "";
String email_id = "";

String annual_turnover = "";
String sub_activity_cd = "";
String trng = "";
String trng_month = "";
String cftri_visit_yn = "";


String APP_TIMESTAMP ="";

String add_update="I";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");


 
StringBuffer qrysb = new StringBuffer();



qrysb.append("SELECT rownum as srno, to_char(ct.APP_TIMESTAMP,'dd-mm-yyyy') as APP_TIMESTAMP,  ad.app_name,  ct.app_id,  ct.mob_no, ");
qrysb.append("ct.email_id,  decode(ct.annual_turnover, '10L','Less than 10Lacs','25L','10-25 lacs','50L','26-50 lacs','80L','51-80 lacs','80LM','More than 80 lacs') as annual_turnover,  ct.sub_activity_cd, ct.mfg_product, ");
qrysb.append("ct.trng_month, decode(ct.cftri_visit_yn,'Y','Yes','N','No') as cftri_visit_yn ,ct.any_remark ");
qrysb.append("FROM app_detail ad,cftri_trg  ct,activity_mast am ");
qrysb.append("WHERE ad.app_id = ct.app_id (+)  and am.activity_cd=ct.sub_activity_cd ");


//out.print(qrysb.toString());

//values.add(app_id);
ResultSet rsMain = db.execSQL(qrysb.toString());
String srno="0";
while (rsMain.next()){
srno=rsMain.getString("srno")==null?"":rsMain.getString("srno");
app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");


mob_no=rsMain.getString("mob_no")==null?"":rsMain.getString("mob_no");

email_id=rsMain.getString("email_id")==null?"":rsMain.getString("email_id");
APP_TIMESTAMP=rsMain.getString("APP_TIMESTAMP")==null?"":rsMain.getString("APP_TIMESTAMP");

trng_month=rsMain.getString("trng_month")==null?"":rsMain.getString("trng_month");
//trng=rsMain.getString("trng")==null?"":rsMain.getString("trng");


session.setAttribute("sAPP_ID",app_id);




%>   
 <tr >
   <td ><%=srno%></td>
      <td ><div align="center"><%=app_id%></div></td>
	 <td ><div align="center"><%=app_name%></div></td>

      <td><div align="center"><%=APP_TIMESTAMP%></div></td>
	        <td><div align="center">  <input name="button" type="button" class="button"  onClick="ShowReport('<%=app_id%>')" value="View Report"></div></td>
    </tr>


  <%
 
  }
  rsMain.close();
  db.close();
%>
</tbody>
</table>

</body>
	<script>
	 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 
	function ShowReport(app_id){
 modalWin.ShowURL('appgen.jsp?app_id='+app_id,900,1200,'CFTRI Report',null,null);
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
<script>
new DataTable('#example', {
    
    fixedColumns: true,
    paging: false,
    scrollCollapse: false,
    scrollX: false,
    scrollY: 500,
	 deferRender:    false,
	 info:false
});


</script>
</html>
