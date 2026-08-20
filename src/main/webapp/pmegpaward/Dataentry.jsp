<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="pmegp_menu.jsp"%>

<head>
<script type="text/javascript" src="js/datetimepicker_css.js"></script>
<script src="js/sweetalert.min.js"></script>
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
#container td, #container tr {
  padding:6px;
   border: 1px solid black;
  border-collapse: collapse;
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
.SR {
background-color: #8B9DC3;
text-align: center;

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
</head>
<body>

<%

DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
String surl="";

String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");

String app_id1=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");

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
String anl_sales_yr1="2018-19";
String anl_sales_yr2="2019-20";
String anl_sales_yr3="2020-21";
String ist_loan_dt="";

String add_update="I";




StringBuffer poR = new StringBuffer();

poR.append(" SELECT ");
poR.append(" pv.app_id as app_id1, pa.unit_name, pa.mob_no_n, pa.email_n, to_char(pa.est_date,'DD-MON-YYYY') AS est_date, pa.anl_sales_yr1, ");
poR.append(" pa.anl_sales_amt1, pa.anl_emp1, pa.anl_updoc1, pa.anl_sales_yr2, pa.anl_sales_amt2, pa.anl_emp2,  pa.anl_updoc2, ");
poR.append(" pa.anl_sales_yr3,pa.anl_sales_amt3, pa.anl_emp3, pa.anl_updoc3, pa.iso_cert_yn, pa.iso_updoc, pa.gst_cert_yn, pa.gst_updoc, ");
poR.append(" pa.udyam_cert_yn, pa.udyam_updoc, pa.trademark_cert_yn,  pa.trademark_updoc,  pa.gem_cert_yn, pa.gem_updoc, ");
poR.append(" pa.ecom_updoc,pa.ecom_cert_yn, pv.legal_type, pv.scheme_type, pv.app_name,  pv.gender,  pv.agency_type,  pv.social_cat, ");
poR.append(" pv.benf_category_desc, pv.mob_no1, pv.e_mail, pv.unit_loc, pv.off_name, pv.unit_addrs,  pv.unit_taluka,  pv.unit_dist, ");
poR.append(" pv.unit_state, pv.unit_pin, pv.ind_type, pv.activity_name, pv.prod_desc, TO_CHAR(pv.loan_sanc_dt,'DD-MON-YYYY') AS loan_sanc_dt , pv.machinary_cost,");
poR.append(" pv.ce_sanc_fb, pv.working_capital, pv.wc_sanc_fb,  pv.total_projectcost_fb,  pv.total_sanction_bank,  pv.own_contribution,pv.mm_rel_amt,   ");
poR.append(" to_char(pv.mm_rel_dt,'DD-MON-YYYY')AS mm_rel_dt,  pv.bank_name, pv.branchname, pv.address, pv.ifsc_code, to_char(bd.ist_loan_dt,'DD-MON-YYYY')AS ist_loan_dt ");
poR.append(" FROM  pmegpaward_view  pv, pmegp_award pa  ,bank_dataentry bd  WHERE BD.APP_ID=PV.APP_ID and pv.app_id = pa.app_id(+) AND pv.app_id = ?  ");


//out.print (poR.toString());
values.add(sAPP_ID);
ResultSet rsMain = db.executeSQL(poR.toString(),values);

while (rsMain.next()){

app_id1=rsMain.getString("app_id1")==null?"":rsMain.getString("app_id1");
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
ist_loan_dt=rsMain.getString("ist_loan_dt")==null?"":rsMain.getString("ist_loan_dt");
add_update="U";
}
rsMain.close();


%>

<FORM name="form" id="form" method="post">
<div align="center"><h1><u>Unit Profile</u></h1></div>

<table id="container" align="center">
<input name="ins" type="hidden" id="ins" >

  <tr>
    <th colspan="4" >Beneficiary Details</th>
  </tr>
  <tr>
    <td  colspan="2"><strong>Application ID: </strong> <%=app_id1%> </td>
    <td colspan="2"><strong>Beneficiary name:</strong><%=app_name%></td>
  </tr>
  <tr>
    <td colspan="4"><strong>Gender:</strong> <%=gender%>  </tr>
  <tr>
    <td colspan="2"><strong>Sponsoring Agency:</strong> <%=agency_type%>    </td>
    <td colspan="2"><strong>Legal Type:</strong> <%=legal_type%>             </tr>
  <tr>
    <td colspan="2"><strong>Social Category:</strong> <%=social_cat%></td>
    <td colspan="2"><strong>Special Category:</strong> <%=benf_category_desc%></td>
    </tr>
  <tr>
    <th colspan="4">Unit Details    </tr>
  <tr>
    <td colspan="2"><strong>Unit Sponsored office name:</strong><%=off_name%></td>
    <td colspan="2"><strong>Unit location:</strong> <%=unit_loc%></td>
    </tr>
  <tr>
    <td colspan="4" ><strong>PMEGP Unit address:</strong> <%=unit_addrs%></td>
  </tr>
  <tr>
    <td colspan="2"><strong>Taluka/Block:</strong> <%=unit_taluka%></td>
    <td colspan="2"><strong>District:</strong> <%=unit_dist%></td>
    </tr>
  <tr>
    <td colspan="2"><strong>State:</strong> <%=unit_state%></td>
    <td colspan="2"><strong>Pin Code:</strong> <%=unit_pin%></td>
    </tr>
  <tr>
    <td colspan="2"><strong>industry Type:</strong> <%=ind_type%></td>
    <td colspan="2"><strong>Industry activity: </strong><%=activity_name%></td>
    </tr>
  <tr>
    <td colspan="4"><strong>Product Description:</strong> <%=prod_desc%></td>
  </tr>
  <tr>
    <th colspan="4">Financing Bank Details    </tr>
  <tr>
    <td colspan="2"><strong>Financing Bank:</strong> <%=bank_name%></td>
    <td colspan="2"><strong>Bank Branch:</strong> <%=branchname%></td>
    </tr>
  <tr>
    <td colspan="2"><strong>Bank Address:</strong> <%=address%> </td>
    <td colspan="2"><strong>IFSC Code:</strong> <%=ifsc_code%></td>
    </tr>
  <tr>
    <th colspan="4">Project Details</th>
  </tr>
  <tr>
    <td colspan="2"><strong>Sanction Date:</strong><%=loan_sanc_dt%></td>
    <td colspan="2"><strong>1st Loan Release date :</strong> <%=ist_loan_dt %></td>
  </tr>
  
  <tr>
    <td width="359" align="center"><strong>Project Cost</strong></td>
    <td><strong>Amount</strong></td>
    <td width="249" align="center"><strong>Means of Finance</strong></td>
    <td><div align="center"><strong>Amount</strong></div></td>
  </tr>
  <tr>
    <td align="center">Capital Expenditure:</td>
    <td width="125"><div align="center"><%=machinary_cost%></div></td>
    <td align="center"> Own Contribution:</td>
    <td width="199"><div align="center"><%=own_contribution%></div></td>
  </tr>
  <tr>
    <td align="center">Working capital:</td>
    <td><div align="center"><%=working_capital%></div></td>
    <td align="center">Bank Finance / Loan:</td>
    <td><div align="center"><%=total_sanction_bank%></div></td>
  </tr>
  <tr>
    <td align="right"><strong>Total Project Cost(In Rs.) ::</strong></td>
    <td><div align="center"><%=total_projectcost_fb%></div></td>
    <td align="right"><strong>TOTAL:</strong></td>
    <td><div align="center"><%=total_projectcost_fb%></div></td>
  </tr>
  <tr>
    <td colspan="2" ><strong>MM Released Date:</strong><%=mm_rel_dt%></td>
    <td colspan="2"><strong>MM Released(In Rs.):</strong> <%=mm_rel_amt%></td>
  </tr>
 
</table>
</FORM>

<%db.close();%>

</BODY>
</HTML>