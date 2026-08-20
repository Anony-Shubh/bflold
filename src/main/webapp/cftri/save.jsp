<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,CovidPackage.DBCon"  %>
<%@ include file="menu.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" href="css/bootstrap.min.css" /> 

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
String sub_sector = "";
String mfg_product = "";
String trng_month = "";
String cftri_visit_yn = "";

String process_yn = "";
String machy_yn = "";
String raw_mat_yn = "";
String processing_yn = "";

String innov_yn = "";
String tot_yn = "";
String pck_yn = "";
String mlc_yn = "";
String lc_yn = "";
String gl_mfg_yn = "";
String qs_yn = "";
String any_remark = "";

String add_update="I";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");


 
StringBuffer qrysb = new StringBuffer();



qrysb.append("SELECT ad.app_id as app_id1, ad.app_name, ad.mob_no1,  ct.app_id,  ct.mob_no,");
qrysb.append("ct.email_id,  ct.annual_turnover,  ct.sub_sector, ct.mfg_product, ");
qrysb.append("ct.trng_month,  ct.cftri_visit_yn, ct.process_yn,  ct.machy_yn, ");
qrysb.append("ct.raw_mat_yn,  ct.processing_yn,  ct.innov_yn, ");
qrysb.append("ct.tot_yn,   ct.pck_yn,   ct.mlc_yn,   ct.lc_yn,  ct.gl_mfg_yn, ");
qrysb.append("ct.qs_yn, ct.any_remark  ");
qrysb.append("FROM app_detail ad,cftri_trg  ct ");
qrysb.append("WHERE ad.app_id = ct.app_id (+) AND ad.app_id ='KVMP16176576-1246429' ");


//out.print(qrysb.toString());

//values.add(app_id);
ResultSet rsMain = db.execSQL(qrysb.toString());

while (rsMain.next()){
app_id1=rsMain.getString("app_id1")==null?"":rsMain.getString("app_id1");
app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
mob_no1=rsMain.getString("mob_no1")==null?"":rsMain.getString("mob_no1");

mob_no=rsMain.getString("mob_no")==null?"":rsMain.getString("mob_no");

email_id=rsMain.getString("email_id")==null?"":rsMain.getString("email_id");
annual_turnover=rsMain.getString("annual_turnover")==null?"":rsMain.getString("annual_turnover");
sub_sector=rsMain.getString("sub_sector")==null?"":rsMain.getString("sub_sector");
mfg_product=rsMain.getString("mfg_product")==null?"":rsMain.getString("mfg_product");
trng_month=rsMain.getString("trng_month")==null?"":rsMain.getString("trng_month");

cftri_visit_yn=rsMain.getString("cftri_visit_yn")==null?"":rsMain.getString("cftri_visit_yn");
process_yn=rsMain.getString("process_yn")==null?"":rsMain.getString("process_yn");
machy_yn=rsMain.getString("machy_yn")==null?"":rsMain.getString("machy_yn");
raw_mat_yn=rsMain.getString("raw_mat_yn")==null?"":rsMain.getString("raw_mat_yn");
processing_yn=rsMain.getString("processing_yn")==null?"":rsMain.getString("processing_yn");

innov_yn=rsMain.getString("innov_yn")==null?"":rsMain.getString("innov_yn");
tot_yn=rsMain.getString("tot_yn")==null?"":rsMain.getString("tot_yn");
pck_yn=rsMain.getString("pck_yn")==null?"":rsMain.getString("pck_yn");
mlc_yn=rsMain.getString("mlc_yn")==null?"":rsMain.getString("mlc_yn");

lc_yn=rsMain.getString("lc_yn")==null?"":rsMain.getString("lc_yn");
gl_mfg_yn=rsMain.getString("gl_mfg_yn")==null?"":rsMain.getString("gl_mfg_yn");
qs_yn=rsMain.getString("qs_yn")==null?"":rsMain.getString("qs_yn");

any_remark=rsMain.getString("any_remark")==null?"":rsMain.getString("any_remark");




}
rsMain.close();




%>

<div class="container">
<FORM  name="form" id="form" method="post" >


<table align="center"  width="100%" id="customers" >
<th><center>
  <h1>DATA SUCCESSFULLY SAVED...</h1>
  </center></th></table>
<br />


<div class="container table-bordered" style="background-color:#FFECD9;">

<div class="row">
<div class="col" >
<label><strong>Beneficiary Id  :</strong></label>
&nbsp;&nbsp;<%=app_id1%>
</div>

<div class="col" >
<label><strong>Benefiary Name:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=app_name%>
</div>
</div>
<div class="row">
<div class="col" >
<label><strong>Contact Number :</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=mob_no%>
</div>
<div class="col" >
<label><strong>E-mail ID:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=email_id%>
</div>
</div>
<div class="row">
<div class="col" >
<label><strong>Annual turnover of unit if existing beneficary:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=annual_turnover%>
</div>
<div class="col">
<label><strong>Food Processing Sub-sector:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%= sub_sector %>
</div>
</div>
<div class="row">
<div class="col" >
<label><strong>What are the food products manufactured by your unit:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=mfg_product%>
</div>
</div>
<div class="row">
<div class="col">
<label><strong>Suitable moths for training:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=trng_month%>
</div>
<div class="col" >
<label><strong>Whether unit visit required by CFTRI experts for expert suggestions on unit upgradation(All Expenses to be borne by PMEGP beneficiary) :
<input type="radio" name="cftri_visit_yn" id="cftri_visit_yn1" value="Y" <%if(cftri_visit_yn.equals("Y")){out.print("checked");}%>>
</strong>YES<strong>
<input type="radio" name="cftri_visit_yn" id="cftri_visit_yn" value="N" <%if(cftri_visit_yn.equals("N")||cftri_visit_yn.equals("")){out.print("checked");}%>>
</strong>NO</label>
</div>
</div>
<div class="row">
<div class="col">
<label><strong>Training Required for(Select atleast 3):</strong></label>
<br />
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name ="process_yn" id="myCheck" value="Y" <%if(process_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox1">Process</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="pck_yn" id="myCheck" value="Y" <%if(pck_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Packaging</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="machy_yn" id="myCheck" value="Y" <%if(machy_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Machinery</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="raw_mat_yn" id="myCheck" value="Y" <%if(raw_mat_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Raw material procurement</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="processing_yn" id="myCheck" value="Y" <%if(processing_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Processing</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="innov_yn" id="myCheck" value="Y"<%if(innov_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Innovation</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="tot_yn" id="myCheck" value="Y" <%if(tot_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">ToT</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="mlc_yn" id="myCheck" value="Y" <%if(mlc_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Market linkages and collaborations</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="lc_yn" id="myCheck" value="Y" <%if(lc_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Licensing & Certifications</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="gl_mfg_yn" id="myCheck" value="Y" <%if(gl_mfg_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Global Manufacturing Practices</label>
</div>
<div class="form-check form-check-inline">
  <input class="myCheck" type="checkbox" name="qs_yn" id="myCheck" value="Y" <%if(qs_yn.equals("Y")){out.print("checked");}%> >
  <label class="form-check-label" for="inlineCheckbox2">Quality & Sustainability</label>
</div>
</div>
</div>
<% if (!any_remark.equals("") ){ %>
<div class="row">
<div class="col">
<label><strong>Any other specific requirements by the beneficiary:</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;<%=any_remark%>
</div>
</div>
<% }%>



</div>
</FORM>
</div>
</body>
<script src="js/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="js/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>


