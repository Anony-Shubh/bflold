<%@ page buffer="1000kb"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="menu.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" href="css/bootstrap.min.css" /> 
<link href="js/jquery.multiselect.css" rel="stylesheet" />
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="js/jquery.multiselect.js"></script>
<script src="js/inlinemsg.js"></script>
<script src="js/sweetalert.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<style>


#form{
  font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
 
  border-style: ridge;
  background-color:#FAF5EF;
  padding: 2px;
  font-size:15px;
      display: inline-block;
    margin-left: auto;
    margin-right: auto;
    text-align: left;
}

#msg {display:none; position:absolute; z-index:200; background:url(../cftri/images/msg_arrow.gif) left center no-repeat; padding-left:7px}
#msgcontent {display:block; font:Arial, Helvetica, sans-serif; font-weight:bold;color: #FF0000;font-size: 16px;background:#f3e6e6; border:2px solid #FF0000; border-left:none; padding:5px; min-width:150px; max-width:250px}


</style>

<script>
function submitform() {
var mob_no = document.form.mob_no.value;
var email_id = document.form.email_id.value;
var annual_turnover = document.form.annual_turnover.value; 
var sub_activity_cd = document.form.sub_activity_cd.value;
var trng_month = document.form.trng_month.value; 
   const myCheck = document.querySelectorAll('.myCheck:checked');
 if (mob_no == "")  {	 swal({title:"Please Enter Mobile No."}); return (false);}
	 if (email_id == "")   {	 swal({title:"Please Enter Email Id "});	return (false);} 
	 if (annual_turnover == "") {	 swal({title:"Please Select Annual turnover"});	return (false);}
	 if (sub_activity_cd == "") {swal({title: "Please Select Food processing sub-sector"});	return (false);}
	 if (trng_month == "") {swal({title:"Please Select Training Months"});	return (false);}
	  if (myCheck.length < 1){swal({title:"Please Select Training Required for"});	return (false);}
	 


document.form.ins.value='I';
document.form.submit();
}
</SCRIPT>
<script>
function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<46||unicode>57) //if not a number
return false //disable key press
}


}
</script>
<script>// Dealing with Input width
function textAreaAdjust(element) {
  element.style.height = "1px";
  element.style.height = (25+element.scrollHeight)+"px";
}
</script>

</head>

<body>
<%
 DBCon db= new DBCon();
db.connect();

List values=new ArrayList();

String app_id1 =request.getParameter("KVMP16176576-1246429")==null?"":(String) request.getParameter("KVMP16176576-1246429");
String app_name = "";
String mob_no1 = "";
String app_id = "";
String mob_no = "";
String email_id = "";

String annual_turnover = "";
String sub_activity_cd = "";
String mfg_product = "";
String trng_month = "";
String cftri_visit_yn = "";

String FOOD_PROCESS_YN = "";
String FOOD_EVAL_YN = "";
String FOOD_MICRO_YN = "";
String FOOD_PCK_YN = "";

String FOOD_SAFETY_YN = "";
String INFESTATION_CONTROL_YN = "";
String FLOUR_TECH_YN = "";
String GRAIN_PROCESSING_YN = "";
String MEAT_MARINE_YN = "";
String FOOD_BIOTECHNOLOGY_YN = "";
String POST_HANDLING_YN = "";
String any_remark = "";
String total_projectCost="";
String loan_sanc_dt="";
String IND_TYPE="";
String activity_cd="";
String PROCESS_SPICES_YN="";
String ELECTRI_IN_YN="";
String add_update="I";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");


 
StringBuffer qrysb = new StringBuffer();

qrysb.append("SELECT ad.app_id as app_id1, CT.sub_activity_cd, ad.activity_cd, ad.app_name, ad.mob_no1,  ct.app_id,  ct.mob_no, ");
qrysb.append("ct.email_id,  ct.annual_turnover,   ct.mfg_product, ct.trng_month, ");
qrysb.append("ct.cftri_visit_yn, ct.FOOD_PROCESS_YN,  ct.FOOD_EVAL_YN,ct.FOOD_MICRO_YN,  ct.FOOD_PCK_YN,  ct.FOOD_SAFETY_YN, ");
qrysb.append("ct.INFESTATION_CONTROL_YN,   ct.FLOUR_TECH_YN,   ct.GRAIN_PROCESSING_YN,   ct.MEAT_MARINE_YN,  ct.FOOD_BIOTECHNOLOGY_YN, ");
qrysb.append("ct.POST_HANDLING_YN, ct.PROCESS_SPICES_YN, ct.ELECTRI_IN_YN,ct.any_remark ,to_char(bd.loan_sanc_dt,'DD-MON-YYYY') as loan_sanc_dt,   NVL(bd.MACHINARY_COST, 0) + NVL(bd.WORKING_CAPITAL, 0) AS total_projectCost, ");
qrysb.append("DECODE(ad.ind_type,'M','Manufacturing','Service-Trading') as IND_TYPE ");
qrysb.append("FROM bank_dataentry  bd, app_detail ad, cftri_trg  ct ");
qrysb.append(" where ad.app_id=bd.app_id and ad.app_id = ct.app_id (+) ");
qrysb.append(" and ad.app_id='KVMP16176576-1246429' ");







//out.print(qrysb.toString());

//values.add(app_id1);
ResultSet rsMain = db.execSQL(qrysb.toString());
//ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

while (rsMain.next()){
app_id1=rsMain.getString("app_id1")==null?"":rsMain.getString("app_id1");
app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
mob_no1=rsMain.getString("mob_no1")==null?"":rsMain.getString("mob_no1");

mob_no=rsMain.getString("mob_no")==null?"":rsMain.getString("mob_no");

email_id=rsMain.getString("email_id")==null?"":rsMain.getString("email_id");
annual_turnover=rsMain.getString("annual_turnover")==null?"":rsMain.getString("annual_turnover");
mfg_product=rsMain.getString("mfg_product")==null?"":rsMain.getString("mfg_product");
trng_month=rsMain.getString("trng_month")==null?"":rsMain.getString("trng_month");

cftri_visit_yn=rsMain.getString("cftri_visit_yn")==null?"":rsMain.getString("cftri_visit_yn");
FOOD_PROCESS_YN=rsMain.getString("FOOD_PROCESS_YN")==null?"":rsMain.getString("FOOD_PROCESS_YN");
FOOD_EVAL_YN=rsMain.getString("FOOD_EVAL_YN")==null?"":rsMain.getString("FOOD_EVAL_YN");
FOOD_MICRO_YN=rsMain.getString("FOOD_MICRO_YN")==null?"":rsMain.getString("FOOD_MICRO_YN");
FOOD_PCK_YN=rsMain.getString("FOOD_PCK_YN")==null?"":rsMain.getString("FOOD_PCK_YN");

FOOD_SAFETY_YN=rsMain.getString("FOOD_SAFETY_YN")==null?"":rsMain.getString("FOOD_SAFETY_YN");
INFESTATION_CONTROL_YN=rsMain.getString("INFESTATION_CONTROL_YN")==null?"":rsMain.getString("INFESTATION_CONTROL_YN");
FLOUR_TECH_YN=rsMain.getString("FLOUR_TECH_YN")==null?"":rsMain.getString("FLOUR_TECH_YN");
GRAIN_PROCESSING_YN=rsMain.getString("GRAIN_PROCESSING_YN")==null?"":rsMain.getString("GRAIN_PROCESSING_YN");

MEAT_MARINE_YN=rsMain.getString("MEAT_MARINE_YN")==null?"":rsMain.getString("MEAT_MARINE_YN");
FOOD_BIOTECHNOLOGY_YN=rsMain.getString("FOOD_BIOTECHNOLOGY_YN")==null?"":rsMain.getString("FOOD_BIOTECHNOLOGY_YN");
POST_HANDLING_YN=rsMain.getString("POST_HANDLING_YN")==null?"":rsMain.getString("POST_HANDLING_YN");
sub_activity_cd=rsMain.getString("sub_activity_cd")==null?"":rsMain.getString("sub_activity_cd");
any_remark=rsMain.getString("any_remark")==null?"":rsMain.getString("any_remark");
loan_sanc_dt=rsMain.getString("loan_sanc_dt")==null?"":rsMain.getString("loan_sanc_dt");
total_projectCost=rsMain.getString("total_projectCost")==null?"":rsMain.getString("total_projectCost");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
activity_cd=rsMain.getString("activity_cd")==null?"":rsMain.getString("activity_cd");
PROCESS_SPICES_YN=rsMain.getString("PROCESS_SPICES_YN")==null?"":rsMain.getString("PROCESS_SPICES_YN");
ELECTRI_IN_YN=rsMain.getString("ELECTRI_IN_YN")==null?"":rsMain.getString("ELECTRI_IN_YN");

}
rsMain.close();




%>
<div align="center" >

<table height="38" align="center"  id="container" >
  <th height="32"  ><center>
    <h3>Application Form</h3>
  </center></th>
</table>

<FORM  name="form" id="form" method="post" class="container">
<input type="hidden" id="ins" name="ins">


<div class="row">
<div class="col">
<label >Beneficiary Id :&nbsp;&nbsp;<strong><%=app_id1%></strong></label>

</div>
<div class="col" >
<label>Beneficiary Name:&nbsp;&nbsp;<strong><%=app_name%></strong></label>
</div>
</div>
<div class="row">
<div class="col">
<label>Industry type:&nbsp;&nbsp;<strong><%=IND_TYPE%></strong></label>

</div>
<div class="col" >
<label>Project cost:&nbsp;&nbsp;<strong><%=total_projectCost%></strong></label>

</div>
<div class="col">
<label>Sanction date:&nbsp;&nbsp;<strong><%=loan_sanc_dt%></strong></label>


</div>

</div>
<div class="row">
<div class="col" >
<label>Contact Number :</label>
<input  name="mob_no" type="text" class="form-control form-control-sm" id="mob_no"  value="<%= mob_no1 %>"/>
</div>
<div class="col" >
<label>E-mail ID:</label>
<input  name="email_id" type="text" class="form-control form-control-sm" id="email_id"  value="<%= email_id %>"/>
</div>
</div>


<div class="row">
<div class="col" >
<label>Annual Turnover:</label>
<select class="form-control form-control-sm" name="annual_turnover" id="annual_turnover">
 <option value="" disabled selected >Select here</option>
  <option value="10L" <% if (annual_turnover.equals("10L")){ out.print("selected");}%> >Less than 10Lacs</option>
  <option value="25L" <% if (annual_turnover.equals("25L")){ out.print("selected");}%>>10-25 lacs</option>
  <option value="50L" <% if (annual_turnover.equals("50L")){ out.print("selected");}%> >26-50 lacs</option>
  <option value="80L" <% if (annual_turnover.equals("80L")){ out.print("selected");}%> >51-80 lacs</option>
  <option value="80LM" <% if (annual_turnover.equals("80LM")){ out.print("selected");}%> >More than 80 lacs</option>
</select>

</div>

<div class="col">
<label>Main Product :</label>

<input  name="sub_product"  class="form-control form-control-sm" id="sub_product"  value="Food based industry"/>
</div>

</div>
<div class="row">

<div class="col">
<label>Food Processing Sub-sector:</label>

<select class="form-control form-control-sm" name="sub_activity_cd" id="sub_activity_cd">
 <option value="" disabled selected >Select here</option>
<% 
	  String activity_cd1="";
	  String activity_name="";
ResultSet rsUp=db.execSQL("select activity_cd,activity_name from activity_mast where status='Y' and ind_grp_cd=4 AND ACTIVITY_CD NOT IN(263,261)");
  while (rsUp.next()){ 
	     activity_cd1=rsUp.getString("activity_cd")==null?"":rsUp.getString("activity_cd");
		 activity_name=rsUp.getString("activity_name")==null?"":rsUp.getString("activity_name");

%>
  <option value="<%=activity_cd1%>"  <% if (sub_activity_cd.equals(activity_cd1)){ out.print("selected");}%>><%=activity_name%></option><%}%>
</select>

</div>

<div class="col">
<label>Preferred Months for training:</label>
<select class="form-control form-control-sm 3col active" name="trng_month" id="trng_month" multiple="multiple" required >

  <option value="Any Month" <% if (trng_month.equals("Any Month")){ out.print("selected");}%>  >Any Month</option>
  <option value="January" <% if (trng_month.equals("January")){ out.print("selected");}%>  >January</option>
  <option value="February" <% if (trng_month.equals("February")){ out.print("selected");}%>>February</option>
  <option value="March" <% if (trng_month.equals("March")){ out.print("selected");}%> >March</option>
  <option value="April" <% if (trng_month.equals("April")){ out.print("selected");}%> >April</option>
  <option value="May" <% if (trng_month.equals("May")){ out.print("selected");}%> >May</option>
  <option value="June" <% if (trng_month.equals("June")){ out.print("selected");}%> >June</option>
  <option value="July" <% if (trng_month.equals("July")){ out.print("selected");}%>>July</option>
  <option value="August" <% if (trng_month.equals("August")){ out.print("selected");}%> >August</option>
  <option value="September" <% if (trng_month.equals("September")){ out.print("selected");}%> >September</option>
  <option value="October" <% if (trng_month.equals("October")){ out.print("selected");}%> >October</option>
    <option value="November" <% if (trng_month.equals("November")){ out.print("selected");}%> >November</option>
  <option value="December" <% if (trng_month.equals("December")){ out.print("selected");}%> >December</option>
</select>

</div>
</div>
<div class="row">
<div class="col" >
<label>What are the food products manufactured by your unit:</label>
<textarea type="text" name="mfg_product" class="form-control form-control-sm" placeholder="Enter product"  id="mfg_product" onMouseOver="textAreaAdjust(this)" style="overflow:hidden"   rows="3" cols="100" ><%=mfg_product%></textarea>

</div>
</div>
<div class="row">
<div class="col">
<div>&nbsp;</div>
<label>Whether unit visit required by CFTRI experts for expert suggestions on unit upgradation(<strong>All Expenses to be borne by PMEGP beneficiary</strong>) :</label>
<input type="radio" name="cftri_visit_yn" id="cftri_visit_yn1" value="Y" <%if(cftri_visit_yn.equals("Y")){out.print("checked");}%> >YES
<input type="radio" name="cftri_visit_yn" id="cftri_visit_yn" value="N" <%if(cftri_visit_yn.equals("N")||cftri_visit_yn.equals("")){out.print("checked");}%>  >NO
</div>
</div>
<div class="row">
<div class="col">
<label>Training Required for:</label>
<br />
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name ="FOOD_PROCESS_YN" id="myCheck" value="Y" <%if(FOOD_PROCESS_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox1">Food processing Machineries</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="FLOUR_TECH_YN" id="myCheck" value="Y" <%if(FLOUR_TECH_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Flour Milling Baking and Confectionary Technology</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="FOOD_EVAL_YN" id="myCheck" value="Y" <%if(FOOD_EVAL_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Food flavours & sensory evaluations</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="FOOD_MICRO_YN" id="myCheck" value="Y" <%if(FOOD_MICRO_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Food microbiology & Fermentation</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="FOOD_PCK_YN" id="myCheck" value="Y" <%if(FOOD_PCK_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Food packaging</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="FOOD_SAFETY_YN" id="myCheck" value="Y"<%if(FOOD_SAFETY_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Food safety & quality control</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="INFESTATION_CONTROL_YN" id="myCheck" value="Y" <%if(INFESTATION_CONTROL_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Infestation control and pesticides</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="GRAIN_PROCESSING_YN" id="myCheck" value="Y" <%if(GRAIN_PROCESSING_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Grain processing</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="MEAT_MARINE_YN" id="myCheck" value="Y" <%if(MEAT_MARINE_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Meat & Marine products</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="FOOD_BIOTECHNOLOGY_YN" id="myCheck" value="Y" <%if(FOOD_BIOTECHNOLOGY_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Food biotechnology</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="POST_HANDLING_YN" id="myCheck" value="Y" <%if(POST_HANDLING_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Post-harvest handling & processing of fresh produce</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="PROCESS_SPICES_YN" id="myCheck" value="Y" <%if(PROCESS_SPICES_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Processing of Spices and plantation products</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="ELECTRI_IN_YN" id="myCheck" value="Y" <%if(ELECTRI_IN_YN.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Electrical Safety in Food Processing Industry</label>
</div>

</div>
</div>
<div>&nbsp;</div>
<div class="row">
<div class="col">
<label>Any other specific requirements by the beneficiary:</label>

<textarea type="text" name="any_remark" class="form-control form-control-sm" placeholder="Enter Any other specific requirements" onMouseOver="textAreaAdjust(this)" id="any_remark" style="height: 55px"><%= any_remark %></textarea>

</div>
</div>

<div>&nbsp;</div>
<% if (app_id.equals("")){ %>
<div align="center">
<input class="btn btn-primary" onClick="submitform();"  type="button" value="Submit">
</div>
<%}%>
</FORM>

<%



out.print (ins);
if (ins.equals("I")) {
app_id=(String) request.getParameter("app_id")==null?"":(String) request.getParameter("app_id").trim();
mob_no=(String) request.getParameter("mob_no")==null?"":(String) request.getParameter("mob_no").trim();
email_id=(String) request.getParameter("email_id")==null?"":(String) request.getParameter("email_id").trim();
annual_turnover=(String) request.getParameter("annual_turnover")==null?"":(String) request.getParameter("annual_turnover").trim();
sub_activity_cd=(String) request.getParameter("sub_activity_cd")==null?"":(String) request.getParameter("sub_activity_cd").trim();
mfg_product=(String) request.getParameter("mfg_product")==null?"":(String) request.getParameter("mfg_product").trim();
String[] trng_months = request.getParameterValues("trng_month");
PROCESS_SPICES_YN=(String) request.getParameter("PROCESS_SPICES_YN")==null?"":(String) request.getParameter("PROCESS_SPICES_YN").trim();
cftri_visit_yn=(String) request.getParameter("cftri_visit_yn")==null?"":(String) request.getParameter("cftri_visit_yn").trim();
FOOD_PROCESS_YN=(String) request.getParameter("FOOD_PROCESS_YN")==null?"":(String) request.getParameter("FOOD_PROCESS_YN").trim();
FOOD_EVAL_YN=(String) request.getParameter("FOOD_EVAL_YN")==null?"":(String) request.getParameter("FOOD_EVAL_YN").trim();
FOOD_MICRO_YN=(String) request.getParameter("FOOD_MICRO_YN")==null?"":(String) request.getParameter("FOOD_MICRO_YN").trim();
FOOD_PCK_YN=(String) request.getParameter("FOOD_PCK_YN")==null?"":(String) request.getParameter("FOOD_PCK_YN").trim();
FOOD_SAFETY_YN=(String) request.getParameter("FOOD_SAFETY_YN")==null?"":(String) request.getParameter("FOOD_SAFETY_YN").trim();
INFESTATION_CONTROL_YN=(String) request.getParameter("INFESTATION_CONTROL_YN")==null?"":(String) request.getParameter("INFESTATION_CONTROL_YN").trim();
FLOUR_TECH_YN=(String) request.getParameter("FLOUR_TECH_YN")==null?"":(String) request.getParameter("FLOUR_TECH_YN").trim();
GRAIN_PROCESSING_YN=(String) request.getParameter("GRAIN_PROCESSING_YN")==null?"":(String) request.getParameter("GRAIN_PROCESSING_YN").trim();
MEAT_MARINE_YN=(String) request.getParameter("MEAT_MARINE_YN")==null?"":(String) request.getParameter("MEAT_MARINE_YN").trim();
FOOD_BIOTECHNOLOGY_YN=(String) request.getParameter("FOOD_BIOTECHNOLOGY_YN")==null?"":(String) request.getParameter("FOOD_BIOTECHNOLOGY_YN").trim();
POST_HANDLING_YN=(String) request.getParameter("POST_HANDLING_YN")==null?"":(String) request.getParameter("POST_HANDLING_YN").trim();
any_remark=(String) request.getParameter("any_remark")==null?"":(String) request.getParameter("any_remark").trim();
ELECTRI_IN_YN=(String) request.getParameter("ELECTRI_IN_YN")==null?"":(String) request.getParameter("ELECTRI_IN_YN").trim();
String months="";
if(trng_months != null){
	  StringBuffer sb = new StringBuffer();
      for(int i = 0; i < trng_months.length; i++) {
         sb.append(trng_months[i]+" ");
      }
      months = sb.toString();
out.print(months);
}
        List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		
	
if (add_update.equals("I")) {
qryUpdate.append(" INSERT INTO cftri_trg (");
qryUpdate.append("mob_no,");
qryUpdate.append("email_id,");
qryUpdate.append("annual_turnover,");
qryUpdate.append("sub_activity_cd,");
qryUpdate.append("mfg_product,");
qryUpdate.append("trng_month,");
qryUpdate.append("cftri_visit_yn,");
qryUpdate.append("FOOD_PROCESS_YN,");
qryUpdate.append("FOOD_EVAL_YN,");
qryUpdate.append("FOOD_MICRO_YN,");
qryUpdate.append("FOOD_PCK_YN,");
qryUpdate.append("FOOD_SAFETY_YN,");
qryUpdate.append("INFESTATION_CONTROL_YN,");
qryUpdate.append("FLOUR_TECH_YN,");
qryUpdate.append("GRAIN_PROCESSING_YN,");
qryUpdate.append("MEAT_MARINE_YN,");
qryUpdate.append("FOOD_BIOTECHNOLOGY_YN,");
qryUpdate.append("POST_HANDLING_YN,");
qryUpdate.append("any_remark,");
qryUpdate.append("PROCESS_SPICES_YN,");
qryUpdate.append("ELECTRI_IN_YN,");
qryUpdate.append("app_id");

qryUpdate.append( ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");
}



values.add(mob_no); pstm.add ("L");
values.add(email_id); pstm.add ("L");
values.add(annual_turnover); pstm.add ("L");
values.add(sub_activity_cd); pstm.add ("L");
values.add(mfg_product); pstm.add ("L");
values.add(months); pstm.add ("L");
values.add(cftri_visit_yn); pstm.add ("L");
values.add(FOOD_PROCESS_YN); pstm.add ("L");
values.add(FOOD_EVAL_YN); pstm.add ("L");
values.add(FOOD_MICRO_YN); pstm.add ("L");
values.add(FOOD_PCK_YN); pstm.add ("L");
values.add(FOOD_SAFETY_YN); pstm.add ("L");
values.add(INFESTATION_CONTROL_YN); pstm.add ("L");
values.add(FLOUR_TECH_YN); pstm.add ("L");
values.add(GRAIN_PROCESSING_YN); pstm.add ("L");
values.add(MEAT_MARINE_YN); pstm.add ("L");
values.add(FOOD_BIOTECHNOLOGY_YN); pstm.add ("L");
values.add(POST_HANDLING_YN); pstm.add ("L");
values.add(any_remark); pstm.add ("L");
values.add(PROCESS_SPICES_YN); pstm.add ("L");
values.add(ELECTRI_IN_YN); pstm.add ("L");
values.add(app_id1); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("view.jsp?app_id="+app_id1);
}

%>


</body>
 <script>
    $(function () {
        $('select[multiple].active.3col').multiselect({
            columns: 3,
            placeholder: 'Select Months',
            search: false,
            searchOptions: {
                'default': 'Search months'
            },
            selectAll: false
        });

    });
</script>  
<script src="js/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="js/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>
