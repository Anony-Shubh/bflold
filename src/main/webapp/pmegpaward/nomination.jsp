<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="pmegp_menu.jsp"%>

<head>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/sweetalert.min.js"></script>
<SCRIPT language="javascript">

 $(document).ready(
            function() {
                $('#show').call(callfun());
            });
			
			function isNumeric (evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode (key);
    var regex = /[0-9]|\./;
    if ( !regex.test(key) ) {
      theEvent.returnValue = false;
      if(theEvent.preventDefault) theEvent.preventDefault();
    }
  }
			

</SCRIPT>


<style>
body{background-color:#FAF5EF}

.h1{border-style: inset;}
#container{
  font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
  width: 85%;
  border-style: inset;
  background-color:#FFFFFF;
 
}
#container td,container tr{
  border: 1px solid black;
  border-collapse: collapse;
 background-color:#FFFFFF;
}
#container td:hover, td:active {text-decoration: underline; background-color: #ddd;} 

#container th {
  font-family: Arial black, Helvetica, sans-serif;
  padding: 6px;
  text-align: center;
  border-style: inset;
  background-color: #3f506e;
  color:#FFFFFF;
}
input[type=text] {
  width: 80%;
  box-sizing: border-box;
}
.button{
  background-color: #8B9DC3;
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
}
.next1 {
  background-color: #999999;
  color:#000000;
  font-size: 25px;
}
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

a:hover {
  background-color: #ddd;
  color: black;
}
.button1 {  background-color: #3f506e;
  border: none;
  color: #FFFFFF;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
}
</style>
<script type="text/javascript">
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
 function checkFilled() {
    var inputVal = document.getElementById("subEmail");
    if (inputVal.value == "") {
        inputVal.style.backgroundColor = "yellow";
    }
    else{
        inputVal.style.backgroundColor = "";
    }
}
</script>


<title></title>

<SCRIPT language="javascript">

function submitform(){
var mob_no_n = form.mob_no_n.value; 
var email_n = form.email_n.value;
var unit_name = form.unit_name.value; 
var anl_sales_amt1 = form.anl_sales_amt1.value;
var anl_emp1 = form.anl_emp1.value;
var anl_sales_amt2 = form.anl_sales_amt2.value;
var anl_emp2 = form.anl_emp2.value;
var anl_sales_amt3 = form.anl_sales_amt3.value;
var anl_emp3 = form.anl_emp3.value;
var iso_cert_yn = form.iso_cert_yn.value;
var gst_cert_yn = form.gst_cert_yn.value;
var udyam_cert_yn = form.udyam_cert_yn.value;
var trademark_cert_yn = form.trademark_cert_yn.value;
var gem_cert_yn = form.gem_cert_yn.value;
var ecom_cert_yn = form.ecom_cert_yn.value;
var supply_cert_yn = form.supply_cert_yn.value;
var partic_cert_yn = form.partic_cert_yn.value;

 
 
	 if (mob_no_n == "")  {	 swal({title:"Please Enter Mobile No."}); return (false);}
	 if (email_n == "")   {	 swal({title:"Please Enter Email Id "});	return (false);} 
	 if (unit_name == "") {	 swal({title:"Please Enter Unit Name"});	return (false);}
	 if (anl_sales_amt1 == "") {swal({title: "Please Enter annual sales amount of Year 2018-19"});	return (false);}
	 if (anl_emp1 == "") {swal({title:"Please Enter No of employees generated in Year 2018-19"});	return (false);}
	  if (anl_sales_amt2 == "") {	swal({title:"Please Enter annual sales amount of Year 2019-20"});	return (false);}
	 if (anl_emp2 == "") {swal({title:"Please No of employees generated in Year 2019-20"});	return (false);}
	  if (anl_sales_amt3 == "") {swal({title:"Please Enter annual sales amount of Year 2020-21"});	return (false);}
	 if (anl_emp3 == "") {swal({title:"Please No of employees generated in Year 2020-21"});	return (false);}
	 if (iso_cert_yn == "") {swal({title:"Please select ISO Certificate"});	return (false);}
	 if (gst_cert_yn == "") {swal({title:"Please select GST Certificate"});	return (false);}
	 if (udyam_cert_yn == "") {swal({title:"Please select Udyam Certificate"});	return (false);}
	 if (trademark_cert_yn == "") {swal({title:"Please select Trademark Certificate"});	return (false);}
	 if (gem_cert_yn == "") {swal({title:"Please select GEM Certificate"});	return (false);}
	 if (ecom_cert_yn == "") {swal({title:"Please select ECOM Certificate"});	return (false);}
	 if (supply_cert_yn == "") {swal({title:"Please select Supply to Government/Public Offices/Corporates Certificate"});	return (false);}
	 if (partic_cert_yn == "") {swal({title:"Please select Participation in national/ local level exhibitions,trade fairs ect. Certificate"});	return (false);}

document.form.ins.value='I';
document.form.submit();
}
</script>
</head>
<body>



<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();

String surl="";
String app_id1=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");
String sAPP_NAME=session.getAttribute("sAPP_NAME")==null?"0":(String)session.getAttribute("sAPP_NAME");

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
String FINAL_SUB_DT="";
String supply_cert_yn ="";
String supply_updoc ="";
String partic_cert_yn ="";
String partic_updoc  ="";

String app_name= "";
String gender = ""; 
String agency_type = "";
String legal_type= "";
String social_cat= "";
String benf_category_desc= "";
String unit_loc= "";
String off_name= "";
String unit_addrs= "";
String unit_taluka= "";
String unit_dist = "";
String unit_state= "";
String unit_pin= "";
String ind_type = "";
String activity_name = "";
String prod_desc = "";
String loan_sanc_dt= "";
String scheme_type= "";
String machinary_cost="";
String ce_sanc_fb= "";
String working_capital="";
String wc_sanc_fb="";
String total_projectcost_fb= "";
String total_sanction_bank = "";
String own_contribution = "";
String mm_rel_amt = "";
String mm_rel_dt = "";
String bank_name = "";
String branchname = "";
String address="";
String ifsc_code="";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String anl_sales_yr1="2018-19";
String anl_sales_yr2="2019-20";
String anl_sales_yr3="2020-21";
//String supply_cert_yn="";
//String partic_cert_yn="";
String add_update="I";
//String ins=request.getParameter("ins")==null?"":(String)request.getParameter("ins");

if(!sAPP_ID.equals("")){

StringBuffer poR = new StringBuffer();

poR.append(" SELECT pa.FINAL_SUB_DT, ");
poR.append(" pa.app_id,pa.unit_name, pa.mob_no_n, pa.email_n, to_char(pa.est_date,'DD-MON-YYYY') AS est_date, pa.anl_sales_yr1, ");
poR.append(" pa.anl_sales_amt1, pa.anl_emp1, pa.anl_updoc1, pa.anl_sales_yr2, pa.anl_sales_amt2, pa.anl_emp2,  pa.anl_updoc2, ");
poR.append(" pa.anl_sales_yr3,pa.anl_sales_amt3, pa.anl_emp3, pa.anl_updoc3, pa.iso_cert_yn, pa.iso_updoc, pa.gst_cert_yn, pa.gst_updoc, ");
poR.append(" pa.udyam_cert_yn, pa.udyam_updoc, pa.trademark_cert_yn,  pa.trademark_updoc,  pa.gem_cert_yn, pa.gem_updoc, ");
poR.append(" pa.ecom_updoc,pa.ecom_cert_yn, pv.legal_type, pv.scheme_type, pv.app_name,  pv.gender,  pv.agency_type,  pv.social_cat, ");
poR.append(" pv.benf_category_desc, pv.mob_no1, pv.e_mail, pv.unit_loc, pv.off_name, pv.unit_addrs,  pv.unit_taluka,  pv.unit_dist, ");
poR.append(" pv.unit_state, pv.unit_pin, pv.ind_type, pv.activity_name, pv.prod_desc, TO_CHAR(pv.loan_sanc_dt,'DD-MON-YYYY') AS loan_sanc_dt , pv.machinary_cost,");
poR.append(" pv.ce_sanc_fb, pv.working_capital, pv.wc_sanc_fb,  pv.total_projectcost_fb,  pv.total_sanction_bank,  pv.own_contribution, ");
poR.append(" pv.mm_rel_amt,  to_char(pv.mm_rel_dt,'DD-MON-YYYY')AS mm_rel_dt,  pv.bank_name, pv.branchname, pv.address, pv.ifsc_code, pa.supply_cert_yn, pa.partic_cert_yn ");
poR.append(" FROM  pmegpaward_view  pv, pmegp_award  pa WHERE  pv.app_id = pa.app_id(+) ");
poR.append("  AND pa.app_id = ? ");

values.add(sAPP_ID);


try (ResultSet rsMain = db.executeSQL(poR.toString(),values);) {

while (rsMain.next()){

// award table......
//app_id=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");

//original appid
app_id1=rsMain.getString("app_id")==null?"":rsMain.getString("app_id");
FINAL_SUB_DT=rsMain.getString("FINAL_SUB_DT")==null?"":rsMain.getString("FINAL_SUB_DT");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
gender=rsMain.getString("gender")==null?"":rsMain.getString("gender");
agency_type=rsMain.getString("agency_type")==null?"":rsMain.getString("agency_type");
legal_type=rsMain.getString("legal_type")==null?"":rsMain.getString("legal_type");
social_cat=rsMain.getString("social_cat")==null?"":rsMain.getString("social_cat");
benf_category_desc=rsMain.getString("benf_category_desc")==null?"":rsMain.getString("benf_category_desc");
unit_loc=rsMain.getString("unit_loc")==null?"":rsMain.getString("unit_loc");
off_name=rsMain.getString("off_name")==null?"":rsMain.getString("off_name");
unit_addrs=rsMain.getString("unit_addrs")==null?"":rsMain.getString("unit_addrs");
unit_taluka=rsMain.getString("unit_taluka")==null?"":rsMain.getString("unit_taluka");
unit_dist=rsMain.getString("unit_dist")==null?"":rsMain.getString("unit_dist");
unit_state=rsMain.getString("unit_state")==null?"":rsMain.getString("unit_state");
unit_pin=rsMain.getString("unit_pin")==null?"":rsMain.getString("unit_pin");
ind_type=rsMain.getString("ind_type")==null?"":rsMain.getString("ind_type");
activity_name=rsMain.getString("activity_name")==null?"":rsMain.getString("activity_name");
prod_desc=rsMain.getString("prod_desc")==null?"":rsMain.getString("prod_desc");
loan_sanc_dt=rsMain.getString("loan_sanc_dt")==null?"":rsMain.getString("loan_sanc_dt");
scheme_type=rsMain.getString("scheme_type")==null?"":rsMain.getString("scheme_type");
machinary_cost=rsMain.getString("machinary_cost")==null?"":rsMain.getString("machinary_cost");
ce_sanc_fb=rsMain.getString("ce_sanc_fb")==null?"":rsMain.getString("ce_sanc_fb");
working_capital=rsMain.getString("working_capital")==null?"":rsMain.getString("working_capital");
wc_sanc_fb=rsMain.getString("wc_sanc_fb")==null?"":rsMain.getString("wc_sanc_fb");
total_projectcost_fb=rsMain.getString("total_projectcost_fb")==null?"":rsMain.getString("total_projectcost_fb");
total_sanction_bank=rsMain.getString("total_sanction_bank")==null?"":rsMain.getString("total_sanction_bank");
own_contribution=rsMain.getString("own_contribution")==null?"":rsMain.getString("own_contribution");
mm_rel_amt=rsMain.getString("mm_rel_amt")==null?"":rsMain.getString("mm_rel_amt");
mm_rel_dt=rsMain.getString("mm_rel_dt")==null?"":rsMain.getString("mm_rel_dt");
bank_name=rsMain.getString("bank_name")==null?"":rsMain.getString("bank_name");
branchname=rsMain.getString("branchname")==null?"":rsMain.getString("branchname");
address=rsMain.getString("address")==null?"":rsMain.getString("address");
ifsc_code=rsMain.getString("ifsc_code")==null?"":rsMain.getString("ifsc_code");
unit_name=rsMain.getString("unit_name")==null?"":rsMain.getString("unit_name");
mob_no_n=rsMain.getString("mob_no_n")==null?"":rsMain.getString("mob_no_n");
email_n=rsMain.getString("email_n")==null?"":rsMain.getString("email_n");
est_date=rsMain.getString("est_date")==null?"":rsMain.getString("est_date");
anl_sales_yr1=rsMain.getString("anl_sales_yr1")==null?"":rsMain.getString("anl_sales_yr1");
anl_sales_amt1=rsMain.getString("anl_sales_amt1")==null?"":rsMain.getString("anl_sales_amt1");
anl_emp1=rsMain.getString("anl_emp1")==null?"":rsMain.getString("anl_emp1");
anl_updoc1=rsMain.getString("anl_updoc1")==null?"":rsMain.getString("anl_updoc1");
anl_sales_yr2=rsMain.getString("anl_sales_yr2")==null?"":rsMain.getString("anl_sales_yr2");
anl_sales_amt2=rsMain.getString("anl_sales_amt2")==null?"":rsMain.getString("anl_sales_amt2");
anl_emp2=rsMain.getString("anl_emp2")==null?"":rsMain.getString("anl_emp2");
anl_updoc2=rsMain.getString("anl_updoc2")==null?"":rsMain.getString("anl_updoc2");
anl_sales_yr3=rsMain.getString("anl_sales_yr3")==null?"":rsMain.getString("anl_sales_yr3");
anl_sales_amt3=rsMain.getString("anl_sales_amt3")==null?"":rsMain.getString("anl_sales_amt3");
anl_emp3=rsMain.getString("anl_emp3")==null?"":rsMain.getString("anl_emp3");
anl_updoc3=rsMain.getString("anl_updoc3")==null?"":rsMain.getString("anl_updoc3");
iso_updoc=rsMain.getString("iso_updoc")==null?"":rsMain.getString("iso_updoc");
gst_updoc=rsMain.getString("gst_updoc")==null?"":rsMain.getString("gst_updoc");
udyam_updoc=rsMain.getString("udyam_updoc")==null?"":rsMain.getString("udyam_updoc");
trademark_updoc=rsMain.getString("trademark_updoc")==null?"":rsMain.getString("trademark_updoc");
gem_updoc=rsMain.getString("gem_updoc")==null?"":rsMain.getString("gem_updoc");
ecom_updoc=rsMain.getString("ecom_updoc")==null?"":rsMain.getString("ecom_updoc");
supply_cert_yn=rsMain.getString("supply_cert_yn")==null?"":rsMain.getString("supply_cert_yn");
partic_cert_yn=rsMain.getString("partic_cert_yn")==null?"":rsMain.getString("partic_cert_yn");

ecom_cert_yn=rsMain.getString("ecom_cert_yn")==null?"":rsMain.getString("ecom_cert_yn");
iso_cert_yn=rsMain.getString("iso_cert_yn")==null?"":rsMain.getString("iso_cert_yn");
gst_cert_yn=rsMain.getString("gst_cert_yn")==null?"":rsMain.getString("gst_cert_yn");
udyam_cert_yn=rsMain.getString("udyam_cert_yn")==null?"":rsMain.getString("udyam_cert_yn");
trademark_cert_yn=rsMain.getString("trademark_cert_yn")==null?"":rsMain.getString("trademark_cert_yn");
gem_cert_yn=rsMain.getString("gem_cert_yn")==null?"":rsMain.getString("gem_cert_yn");

if (!app_id1.equals("") ) {
add_update="U";
}
rsMain.close();
}

}catch (Exception e){}finally {

}


}
%>

<FORM name="form" id="form" method="post">
<div align="center">
<u><h1>Nomination Form</h1></u></div>
<table id="container" align="center">
<input name="ins" type="hidden" id="ins" >

  <tr>

    <td  colspan="4"> <strong>Application ID: </strong>  <%=sAPP_ID%> </td>
    <td colspan="3"><strong>Beneficiary name:</strong><%=sAPP_NAME%></td>
  </tr>
    <tr>
    <td colspan="4"><strong>Mobile No*:</strong>
      <input  type="text" name="mob_no_n" id="mob_no_n" value="<%=mob_no_n%>" maxlength="10" onKeyPress="return isNumberKey(event); checkFilled();"  >    </td>
    <td width="282" colspan="3"><strong>Email ID*:</strong>
      <input type="text"  name="email_n"  id="email_n" value="<%=email_n%>" ></td>
    </tr>
	  <tr>
    <td colspan="6"><strong>Unit Name*:</strong>
      <input type="text"  name="unit_name"  id="unit_name" value="<%=unit_name%>">    </td>
	  
  </tr>
	<td></td>
      <td colspan="14" ><div align="center"><strong><strong>Annual  Sales Turnover/Employment Generated</strong></div></td>
  </tr>
  <tr>
    <td align="center" ><strong>Sr No.</strong></td>
    <td align="center" ><strong>Financial Year</strong></td>
    <td  colspan="2" align="center"><strong>Annual Sales Turnover (In Rs.)*:</strong></td>
    <td colspan="2" align="center"  ><strong>No. of employement provided*:</strong></td>
  </tr>
  <tr>
    <td align="center">1.</td>
    <td width="226" align="center"> 2018-19*</td>
    <td align="center" colspan="2"><input type="text"  name="anl_sales_amt1" value="<%=anl_sales_amt1%>" onKeyPress="return isNumberKey(event);" required></td>
    <td align="center" colspan="2"><input type="text"  name="anl_emp1" value="<%=anl_emp1%>"  onKeyPress="return isNumberKey(event);" required></td>
  </tr>
  <tr>
    <td align="center">2.</td>
    <td align="center">2019-20*</td>
    <td  align="center" colspan="2" ><input type="text"  name="anl_sales_amt2"  value="<%=anl_sales_amt2%>" onKeyPress="return isNumberKey(event);" required></td>
    <td  align="center" colspan="2"><input type="text"  name="anl_emp2" value="<%=anl_emp2%>" onKeyPress="return isNumberKey(event);" required></td>
  </tr>
  <tr>
    <td align="center">3.</td>
    <td align="center">2020-21*</td>
    <td  align="center" colspan="2"><input type="text"  name="anl_sales_amt3" value="<%=anl_sales_amt3%>" onKeyPress="return isNumberKey(event);" required></td>
    <td align="center" colspan="2"><input type="text"  name="anl_emp3" value="<%=anl_emp3%>"  onKeyPress="return isNumberKey(event);" required></td>
  </tr>

	<tr><td align="center"><strong>Sr No.</strong></td>
	  <td colspan="14"><div align="center"><strong>Standardization/Trademark/Quality Certification</strong></div></td>
  </tr>

  <tr>
    <td align="center">1.</td>
    <td colspan="2">ISO Certification*:</td>
    <td align="center" colspan="3"><input type="radio" id="radio" name="iso_cert_yn" value="Y" <% if (iso_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio" name="iso_cert_yn" value="N" <% if (iso_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <tr>
    <td align="center">2.</td>
    <td colspan="2">GST Registration*:</td>
    <td align="center" colspan="3"><input type="radio" id="radio2" name="gst_cert_yn" value="Y" <% if (gst_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="gst_cert_yn" value="N" <% if (gst_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <tr>
    <td align="center">3.
    <td colspan="2">Udyam/UAM Registration*:</td>
    <td align="center" colspan="3"><input type="radio" id="radio2" name="udyam_cert_yn" value="Y" <% if (udyam_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="udyam_cert_yn" value="N" <% if (udyam_cert_yn.equals("N")) {out.print("checked");}%> >
      NO </td>
  </tr>
  <tr>
    <td align="center">4.
    <td colspan="2">Trademark Registration*:</td>
    <td align="center" colspan="4"><input type="radio" id="radio2" name="trademark_cert_yn" value="Y" <% if (trademark_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="trademark_cert_yn" value="N" <% if (trademark_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <tr>
  </tr>
	  <tr>
	  <td align="center"><strong>Sr No.</strong></td>
	  <td colspan="6" align="center"><strong>Utilization of marketing  channels 
      (local marketing ,procurement & social media)</strong></td>
    
  </tr>
  <tr>
    <td align="center">1.</td>
    <td colspan="2">Gem Registration*:</td>
    <td align="center" colspan="4"><input type="radio" id="radio2" name="gem_cert_yn" value="Y" <% if (gem_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="gem_cert_yn" value="N" <% if (gem_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <tr>
    <td align="center">2.</td>
    <td colspan="2">E-commerce collaboration*:</td>
    <td align="center" colspan="4"><input type="radio" id="radio2" name="ecom_cert_yn" value="Y" <% if (ecom_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="ecom_cert_yn" value="N" <% if (ecom_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <tr>
    <td align="center">3.</td>
    <td colspan="2">Supply to Government/Public Offices/Corporates:</td>
    <td align="center" colspan="4"><input type="radio" id="radio2" name="supply_cert_yn" value="Y" <% if (supply_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="supply_cert_yn" value="N" <% if (supply_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <tr>
    <td align="center">4.</td>
    <td colspan="2">Participation in national/ local level exhibitions,trade fairs ect.:</td>
    <td align="center" colspan="4"><input type="radio" id="radio2" name="partic_cert_yn" value="Y" <% if (partic_cert_yn.equals("Y")) {out.print("checked");}%>>
      YES
      <input type="radio" id="radio1" name="partic_cert_yn" value="N" <% if (partic_cert_yn.equals("N")) {out.print("checked");}%>>
      NO </td>
  </tr>
  <input name="anl_updoc1" type="hidden" id="anl_updoc1" value="<%=anl_updoc1%>">
  <input name="anl_updoc2" type="hidden" id="anl_updoc2" value="<%=anl_updoc2%>">
  <input name="anl_updoc3" type="hidden" id="anl_updoc3" value="<%=anl_updoc3%>">
  <input name="iso_updoc" type="hidden" id="iso_updoc" value="<%=iso_updoc%>">
  <input name="gst_updoc" type="hidden" id="gst_updoc" value="<%=gst_updoc%>">
  <input name="udyam_updoc" type="hidden" id="udyam_updoc" value="<%=udyam_updoc%>">
  <input name="trademark_updoc" type="hidden" id="trademark_updoc" value="<%=trademark_updoc%>">
  <input name="gem_updoc" type="hidden" id="gem_updoc" value="<%=gem_updoc%>">
  <input name="ecom_updoc" type="hidden" id="ecom_updoc" value="<%=ecom_updoc%>">
  <tr>
    <td></td>
    <td colspan="20">
      <center>
	  <%if (FINAL_SUB_DT.equals("") ){%>
        <input name="button" type="button" class="button1" onClick="submitform();" value="Save">
		<%}%>
      </center>

    </td>
  </tr>
</table>
</FORM>


<% 

  if (ins.equals("I")){
try {
out.print ("insde");
 
app_id1=(String) request.getParameter("app_id")==null?"":(String) request.getParameter("app_id").trim();
unit_name=(String) request.getParameter("unit_name")==null?"":(String) request.getParameter("unit_name").trim();
mob_no_n=(String) request.getParameter("mob_no_n")==null?"":(String) request.getParameter("mob_no_n").trim();
email_n=(String) request.getParameter("email_n")==null?"":(String) request.getParameter("email_n").trim();
unit_loc=(String) request.getParameter("unit_loc")==null?"":(String) request.getParameter("unit_loc").trim();
est_date=(String) request.getParameter("est_date")==null?"":(String) request.getParameter("est_date").trim();
anl_sales_yr1=(String) request.getParameter("anl_sales_yr1")==null?"":(String) request.getParameter("anl_sales_yr1").trim();
anl_sales_amt1=(String) request.getParameter("anl_sales_amt1")==null?"":(String) request.getParameter("anl_sales_amt1").trim();
anl_emp1=(String) request.getParameter("anl_emp1")==null?"":(String) request.getParameter("anl_emp1").trim();
anl_updoc1=(String) request.getParameter("anl_updoc1")==null?"":(String) request.getParameter("anl_updoc1").trim();
anl_sales_yr2=(String) request.getParameter("anl_sales_yr2")==null?"":(String) request.getParameter("anl_sales_yr2").trim();
anl_sales_amt2=(String) request.getParameter("anl_sales_amt2")==null?"":(String) request.getParameter("anl_sales_amt2").trim();
anl_emp2=(String) request.getParameter("anl_emp2")==null?"":(String) request.getParameter("anl_emp2").trim();
anl_updoc2=(String) request.getParameter("anl_updoc2")==null?"":(String) request.getParameter("anl_updoc2").trim();
anl_sales_yr3=(String) request.getParameter("anl_sales_yr3")==null?"":(String) request.getParameter("anl_sales_yr2").trim();
anl_sales_amt3=(String) request.getParameter("anl_sales_amt3")==null?"":(String) request.getParameter("anl_sales_amt3").trim();
anl_emp3=(String) request.getParameter("anl_emp3")==null?"":(String) request.getParameter("anl_emp3").trim();
anl_updoc3=(String) request.getParameter("anl_updoc3")==null?"":(String) request.getParameter("anl_updoc3").trim();
iso_cert_yn=(String) request.getParameter("iso_cert_yn")==null?"":(String) request.getParameter("iso_cert_yn").trim();
iso_updoc=(String) request.getParameter("iso_updoc")==null?"":(String) request.getParameter("iso_updoc").trim();
gst_cert_yn=(String) request.getParameter("gst_cert_yn")==null?"":(String) request.getParameter("gst_cert_yn").trim();
gst_updoc=(String) request.getParameter("gst_updoc")==null?"":(String) request.getParameter("gst_updoc").trim();
udyam_cert_yn=(String) request.getParameter("udyam_cert_yn")==null?"":(String) request.getParameter("udyam_cert_yn").trim();
udyam_updoc=(String) request.getParameter("udyam_updoc")==null?"":(String) request.getParameter("udyam_updoc").trim();
trademark_cert_yn=(String) request.getParameter("trademark_cert_yn")==null?"":(String) request.getParameter("trademark_cert_yn").trim();
trademark_updoc=(String) request.getParameter("trademark_updoc")==null?"":(String) request.getParameter("trademark_updoc").trim();
gem_cert_yn=(String) request.getParameter("gem_cert_yn")==null?"":(String) request.getParameter("gem_cert_yn").trim();
gem_updoc=(String) request.getParameter("gem_updoc")==null?"":(String) request.getParameter("gem_updoc").trim();
ecom_cert_yn=(String) request.getParameter("ecom_cert_yn")==null?"":(String) request.getParameter("ecom_cert_yn").trim();
ecom_updoc=(String) request.getParameter("ecom_updoc")==null?"":(String) request.getParameter("ecom_updoc").trim();
supply_cert_yn=(String) request.getParameter("supply_cert_yn")==null?"":(String) request.getParameter("supply_cert_yn").trim(); 
partic_cert_yn=(String) request.getParameter("partic_cert_yn")==null?"":(String) request.getParameter("partic_cert_yn").trim(); 




        List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		
	
if (add_update.equals("I")) {
  
qryUpdate.append(" INSERT INTO pmegp_award (");
qryUpdate.append("unit_name,");
qryUpdate.append("mob_no_n,");
qryUpdate.append("email_n,");
qryUpdate.append("est_date,");
qryUpdate.append("anl_sales_yr1,");
qryUpdate.append("anl_sales_amt1,");
qryUpdate.append("anl_emp1,");
qryUpdate.append("anl_updoc1,");
qryUpdate.append("anl_sales_yr2,");
qryUpdate.append("anl_sales_amt2,");
qryUpdate.append("anl_emp2,");
qryUpdate.append("anl_updoc2,");
qryUpdate.append("anl_sales_yr3,");
qryUpdate.append("anl_sales_amt3 ,");
qryUpdate.append("anl_emp3,");
qryUpdate.append("anl_updoc3,");
qryUpdate.append("iso_cert_yn,");
qryUpdate.append("iso_updoc,");
qryUpdate.append("gst_cert_yn,");
qryUpdate.append("gst_updoc,");
qryUpdate.append("udyam_cert_yn,");
qryUpdate.append("udyam_updoc,");
qryUpdate.append("trademark_cert_yn,");
qryUpdate.append("trademark_updoc,");
qryUpdate.append("gem_cert_yn,");
qryUpdate.append("gem_updoc,");
qryUpdate.append("ecom_cert_yn,");
qryUpdate.append("ecom_updoc,");
qryUpdate.append("supply_cert_yn,");
qryUpdate.append("partic_cert_yn,");
qryUpdate.append("app_id");
qryUpdate.append( ") VALUES (?,?,?,?,'2018-19',?,?,?,'2019-20',?,?,?,'2020-21',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");

}else {


qryUpdate.append("	UPDATE pmegp_award SET ");
qryUpdate.append("	unit_name = ?, ");
qryUpdate.append("	mob_no_n = ?, ");
qryUpdate.append("	email_n = ?, ");
qryUpdate.append("	est_date = ?, ");
qryUpdate.append("	anl_sales_yr1 = '2018-19', ");
qryUpdate.append("	anl_sales_amt1 = ?, ");
qryUpdate.append("	anl_emp1 = ?, ");
qryUpdate.append("	anl_updoc1 = ?, ");
qryUpdate.append("	anl_sales_yr2 = '2019-20', ");
qryUpdate.append("	anl_sales_amt2 = ?, ");
qryUpdate.append("	anl_emp2 = ?, ");
qryUpdate.append("	anl_updoc2 = ?, ");
qryUpdate.append("	anl_sales_yr3 = '2020-21', ");
qryUpdate.append("	anl_sales_amt3 = ?, ");
qryUpdate.append("	anl_emp3 = ?, ");
qryUpdate.append("	anl_updoc3 = ?, ");
qryUpdate.append("	iso_cert_yn = ?, ");
qryUpdate.append("	iso_updoc = ?, ");
qryUpdate.append("	gst_cert_yn = ?, ");
qryUpdate.append("	gst_updoc = ?, ");
qryUpdate.append("	udyam_cert_yn = ?, ");
qryUpdate.append("	udyam_updoc= ?, ");
qryUpdate.append("	trademark_cert_yn = ?, ");
qryUpdate.append("	trademark_updoc = ?, ");
qryUpdate.append("	gem_cert_yn = ?, ");
qryUpdate.append("	gem_updoc = ?, ");
qryUpdate.append("	ecom_cert_yn = ?, ");
qryUpdate.append("	ecom_updoc = ?, ");
qryUpdate.append("	supply_cert_yn = ?, ");
qryUpdate.append("	partic_cert_yn = ? ");
qryUpdate.append("  WHERE app_id = ? ");

}
out.print (qryUpdate.toString());

values.add(unit_name); pstm.add ("L");
values.add(mob_no_n); pstm.add ("L");
values.add(email_n); pstm.add ("L");
values.add(est_date); pstm.add ("L");
//values.add(anl_sales_yr1); pstm.add ("L");
values.add(anl_sales_amt1); pstm.add ("L");
values.add(anl_emp1); pstm.add ("L");
values.add(anl_updoc1); pstm.add ("L");
//values.add(anl_sales_yr2); pstm.add ("L");
values.add(anl_sales_amt2); pstm.add ("L");
values.add(anl_emp2); pstm.add ("L");
values.add(anl_updoc2); pstm.add ("L");
//values.add(anl_sales_yr3); pstm.add ("L");
values.add(anl_sales_amt3); pstm.add ("L");
values.add(anl_emp3); pstm.add ("L");
values.add(anl_updoc3); pstm.add ("L");
values.add(iso_cert_yn); pstm.add ("L");
values.add(iso_updoc); pstm.add ("L");
values.add(gst_cert_yn); pstm.add ("L");
values.add(gst_updoc); pstm.add ("L");
values.add(udyam_cert_yn); pstm.add ("L");
values.add(udyam_updoc); pstm.add ("L");
values.add(trademark_cert_yn); pstm.add ("L");
values.add(trademark_updoc); pstm.add ("L");
values.add(gem_cert_yn); pstm.add ("L");
values.add(gem_updoc); pstm.add ("L");
values.add(ecom_cert_yn); pstm.add ("L");
values.add(ecom_updoc); pstm.add ("L");
values.add(supply_cert_yn); pstm.add ("L");
values.add(partic_cert_yn); pstm.add ("L");
values.add(sAPP_ID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ; 

values.clear();
pstm.clear();

surl="save_page.jsp";

}catch (Exception e) {

out.print (e.toString());
}
}

try {
 db.close();
 }catch (Exception e) {}finally {
 //db.close();
 }
 
if (surl !="") {response.sendRedirect("save_page.jsp?app_id="+app_id1);}

%>
</FORM>

</BODY>
</HTML>
