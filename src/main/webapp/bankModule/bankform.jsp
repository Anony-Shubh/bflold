<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<!--<script language="JavaScript" src="js/fontawesome.js" type="text/javascript"></script> -->
<!--<link href="css/icons.css" rel="stylesheet" > --> 
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<!--<script type="text/javascript" src="js/isec.css"></script> -->
<script language="javascript" src="../js/inlinemsg.js"></script>
<style>
#customers {
 font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
  width: 80%;
  border-style: inset;
  background-color:#FFFFFF;
  
  
}

#customers td, #customers th {
  border: 1px solid #ddd;

}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 2px;
  padding-bottom: 2px;
  font-size: 20px;
  text-align: left;
  background-color: #5476B4;
  color:#FFFFFF;
  text-shadow: 5px 2px 5px #000000;
}
input[type=text] {
  width: 45%;  
  box-sizing: border-box;
  align: center;
  font-weight: bold;
  font-size:medium;
  font-style:arial black;
  
}
.button1:hover{
background-color: #5476B4;
color:#FFFFFF;
text-decoration: underline;
border-color:#FFFFFF;
box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}
.style1 {font-size: 16px}
.button1 {  background-color: #5476B4;
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

#msg {display:none; position:absolute; z-index:200; background:url(../images/msg_arrow.gif) left center no-repeat; padding-left:7px}
#msgcontent {display:block; font:Arial, Helvetica, sans-serif; font-weight:bold;color: #FF0000;font-size: 16px;background:#f3e6e6; border:2px solid #FF0000; border-left:none; padding:5px; min-width:150px; max-width:250px}

.input-icons i {
            position: absolute;
        }

.button11 {background-color: #FFCC99;
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
</style>
<script>
function calculation(){
var TOTAL_LOAN_SANC_CE,TOTAL_LOAN_SANC_WC;
TOTAL_LOAN_SANC_CE=Number(document.getElementById("TOTAL_LOAN_SANC_CE").value);
TOTAL_LOAN_SANC_WC=Number(document.getElementById("TOTAL_LOAN_SANC_WC").value);
TOTAL_LOAN_SANC= TOTAL_LOAN_SANC_CE + TOTAL_LOAN_SANC_WC ;
document.getElementById("TOTAL_LOAN_SANC").value= TOTAL_LOAN_SANC;

var LOAN_REL_CE,LOAN_REL_WC;
LOAN_REL_CE=Number(document.getElementById("LOAN_REL_CE").value);
LOAN_REL_WC=Number(document.getElementById("LOAN_REL_WC").value);
TOTAL_LOAN_REL= LOAN_REL_CE + LOAN_REL_WC ;
document.getElementById("TOTAL_LOAN_REL").value= TOTAL_LOAN_REL;

var TOTAL_LOAN_SANC,TOTAL_LOAN_REL;
TOTAL_LOAN_SANC=Number(document.getElementById("TOTAL_LOAN_SANC").value);
TOTAL_LOAN_REL=Number(document.getElementById("TOTAL_LOAN_REL").value);
TOTAL_BALANCE_LOAN= TOTAL_LOAN_SANC - TOTAL_LOAN_REL;
document.getElementById("TOTAL_BALANCE_LOAN").value= TOTAL_BALANCE_LOAN;
}

</script>
<script type="text/javascript">
function perc(that){
if (that.value == "Y"){
document.getElementById("WHE_CC_PERC").value = '100';
}
if (that.value == "N"){
document.getElementById("WHE_CC_PERC").value = '';
}
}//end of func

function perc1(that){
if (that.value == "Y"){
document.getElementById("COLL_SEC_OBT_VAL").disabled = false;
}else{
document.getElementById("COLL_SEC_OBT_VAL").disabled = true;
}

}//end of func
function perc2(that){
if (that.value == "Y"){
document.getElementById("WHE_UNIT_NPA_DT").disabled = false;
}else{
document.getElementById("WHE_UNIT_NPA_DT").disabled = true;
}

}//end of func
</script>
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

<script language="JavaScript" type="text/javascript">
 function sub_form(){
	  
			 if (validate(form)){
				  
				var answer = confirm ("Once Clicked On 'OK' Button,You Cannot modify the Application.")
					if (answer){
					 document.form.ins.value='I'; 
					document.form.submit(); }
	}
	  }
	

function validate(form) {
var UNIT_ST_ES_DT = document.form.UNIT_ST_ES_DT.value; 
var BANK_PH_NO = document.form.BANK_PH_NO.value;
var NO_EMP = document.form.NO_EMP.value; 
var BEN_CON_NO = document.form.BEN_CON_NO.value;
var TOTAL_LOAN_SANC_CE = document.form.TOTAL_LOAN_SANC_CE.value;
var TOTAL_LOAN_SANC_WC = document.form.TOTAL_LOAN_SANC_WC.value;
var LOAN_REL_CE = document.form.LOAN_REL_CE.value;
var LOAN_REL_WC = document.form.LOAN_REL_WC.value;
var WHE_CC = document.form.WHE_CC.value;
var WHE_CC_PERC = document.form.WHE_CC_PERC.value;
var RATE_OF_INT = document.form.RATE_OF_INT.value;
var TDR_SUBS_AMT = document.form.TDR_SUBS_AMT.value;
var TDR_SUBS_NO = document.form.TDR_SUBS_NO.value;
var TDR_SUBS_DT = document.form.TDR_SUBS_DT.value;
var CGTMSE_COV = document.form.CGTMSE_COV.value;
var WHE_INT_CHR = document.form.WHE_INT_CHR.value;
var COLL_SEC_OBT = document.form.COLL_SEC_OBT.value;
var COLL_SEC_OBT_VAL = document.form.COLL_SEC_OBT_VAL.value;
var WHE_REPAY_LOAN = document.form.WHE_REPAY_LOAN.value;
var WHE_UNIT_NPA = document.form.WHE_UNIT_NPA.value;
var WHE_UNIT_NPA_DT = document.form.WHE_UNIT_NPA_DT.value;
var UNIT_STATUS = document.form.UNIT_STATUS.value;
var ANN_TO_UNIT_PROD = document.form.ANN_TO_UNIT_PROD.value;
var ANN_TO_UNIT_SALES = document.form.ANN_TO_UNIT_SALES.value;



 	if (UNIT_ST_ES_DT == "") { 
	inlineMsg('UNIT_ST_ES_DT','Please Select Unit Establishment date',2); 
	return (false);}
	if (BANK_PH_NO == "") { 
	inlineMsg('BANK_PH_NO','Please Enter Bank Phone number',2); 
	return (false);}
	if (NO_EMP == "") { 
	inlineMsg('NO_EMP','Please Enter No of Employment',2); 
	return (false);}
	if (BEN_CON_NO == "") { 
	inlineMsg('BEN_CON_NO','Please Enter Benefitiary Contact number',2); 
	return (false);}
	if (TOTAL_LOAN_SANC_CE == "") { 
	inlineMsg('TOTAL_LOAN_SANC_CE','Please Enter Total term loan Sanction CE Amount',2); 
	return (false);}
	if (TOTAL_LOAN_SANC_WC == "") { 
	inlineMsg('TOTAL_LOAN_SANC_WC','Please Enter Total term loan Sanction WC Amount',2); 
	return (false);}
	if (LOAN_REL_CE == "") { 
	inlineMsg('LOAN_REL_CE','Please Enter Loan Released CE Amount',2); 
	return (false);}
	if (LOAN_REL_WC == "") { 
	inlineMsg('LOAN_REL_WC','Please Enter Loan Released WC Amount',2); 
	return (false);}
	if (WHE_CC == "") { 
	inlineMsg('WHE_CC','Please Select  Whether Cash Credit limit utilized',2); 
	return (false);}
	if ((WHE_CC == "N")&(WHE_CC_PERC == "")){ 
	inlineMsg('WHE_CC_PERC','Please Enter Percentage of utilization',2); 
	return (false);}
	if (RATE_OF_INT == "") { 
	inlineMsg('RATE_OF_INT','Please Enter Rate of Interest',2); 
	return (false);}
	if (TDR_SUBS_AMT == "") { 
	inlineMsg('TDR_SUBS_AMT','Please Enter TDR/Subsidy Reserve Fund Amount',2); 
	return (false);}
	if (TDR_SUBS_NO == "") { 
	inlineMsg('TDR_SUBS_NO','Please Enter TDR/Subsidy Reserve Fund Number',2); 
	return (false);}
	if (TDR_SUBS_DT == "") { 
	inlineMsg('TDR_SUBS_DT','Please Select TDR/Subsidy Reserve Fund DATE',2); 
	return (false);}
	if (CGTMSE_COV == "") { 
	inlineMsg('CGTMSE_COV','Please Select CGTMSE Coverage',2); 
	return (false);}
	if (WHE_INT_CHR == "") { 
	inlineMsg('WHE_INT_CHR','Please Select Whether Interest Charged on Correspondind amount of Margin Money',2); 
	return (false);}
	if (COLL_SEC_OBT == "") { 
	inlineMsg('COLL_SEC_OBT','Please Select Collateral Security obtained',2); 
	return (false);}
	if (COLL_SEC_OBT == "Y"){
	if (COLL_SEC_OBT_VAL == "") { 
	inlineMsg('COLL_SEC_OBT_VAL','Please Enter Value of Collateral Security',2); 
	return (false);}}
	if (WHE_REPAY_LOAN == "") { 
	inlineMsg('WHE_REPAY_LOAN','Please select Whether Repayment of Loan is Regular',2); 
	return (false);}
	
	if (WHE_UNIT_NPA == "") { 
	inlineMsg('WHE_UNIT_NPA','Please select whether unit comes under NPA?',2); 
	return (false);}
	if (WHE_UNIT_NPA == "Y"){
	if (WHE_UNIT_NPA_DT == "") { 
	inlineMsg('WHE_UNIT_NPA_DT','Please select NPA Date',2); 
	return (false);}}
	if (UNIT_STATUS == "") { 
	inlineMsg('UNIT_STATUS','Please select Unit status',2); 
	return (false);}
	/*if (ANN_TO_UNIT_SALES == "") { 
	inlineMsg('ANN_TO_UNIT_SALES','Please Enter Annual turnover of the Production unit',2); 
	return (false);}
	if (ANN_TO_UNIT_PROD == "") { 
	inlineMsg('ANN_TO_UNIT_PROD','Please Enter Annual turnover of the Sales unit',2); 
	return (false);}*/

return true;
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<%

 DBCon db= new DBCon();
      db.connect(); 
	  
List values=new ArrayList(); 

String APP_ID1=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String APP_ID="";
String UNIT_ST_ES_DT="";
String BANK_PH_NO="";
String NO_EMP="";
String BEN_CON_NO="";
String TOTAL_LOAN_SANC_CE="";
String TOTAL_LOAN_SANC_WC="";
String LOAN_REL_CE="";
String LOAN_REL_WC="";
String WHE_CC="";
String WHE_CC_PERC="";
String RATE_OF_INT="";
String TDR_SUBS_AMT="";
String TDR_SUBS_NO="";
String TDR_SUBS_DT="";
String CGTMSE_COV="";
String WHE_INT_CHR="";
String COLL_SEC_OBT="";
String COLL_SEC_OBT_VAL="";
String WHE_REPAY_LOAN="";
String WHE_UNIT_NPA="";
String WHE_UNIT_NPA_DT="";
String UNIT_STATUS="";
String ANN_TO_UNIT_PROD="";
String ANN_TO_UNIT_SALES="";
String REMARKS_UNIT="";
String BANK_NAME="";
String ADDRESS="";
String BRANCHNAME="";
String IFSC_CODE="";
String TOTAL_LOAN_SANC="";
String TOTAL_LOAN_REL="";
String TOTAL_BALANCE_LOAN="";
String loan_sanc_dt="";
String unit_loc="";
String mm_rel_amt="";
String district_name="";
String state_nm="";
String apploan_accno="";
String app_name="";
String activity_name="";
String UNIT_ADDRS="";
String total_projectcost_fb="";
String own_contribution="";
String agency_type="";
String surl="";
String bank_fin_loan="";




String add_update="I";
String ins=request.getParameter("ins")==null?"":(String)request.getParameter("ins");

if(!APP_ID1.equals("")){

StringBuffer poR = new StringBuffer();

poR.append("SELECT ");
poR.append("    rb.ifsc_code, ");
poR.append("    rb.bank_name, ");
poR.append("    rb.address, ");
poR.append("    rb.branchname, ");
poR.append("    bd.app_id AS app_id1, ");
poR.append("    ad.app_name, ");
poR.append("    TO_CHAR(bd.loan_sanc_dt,'DD-MON-RRRR') AS loan_sanc_dt, ");
poR.append("    bd.apploan_accno,");
poR.append("    mom.agency_type, ");
poR.append("    am.activity_name, ");
poR.append("    mdunit.district_name, ");
poR.append("    msunit.state_nm, ");
poR.append("    ad.unit_loc, ");
poR.append("    ad.unit_post_addr || ' ' || ad.unit_taluk_block AS unit_addrs, ");
poR.append("    bd.mm_rel_amt, ");
poR.append("    nvl(bd.machinary_cost, 0) + nvl(bd.working_capital, 0) AS total_projectcost_fb, ");
poR.append("    bd.own_contribution, ");
poR.append("    nvl(bd.wc_sanc_fb, 0) + nvl(bd.ce_sanc_fb, 0) AS bank_fin_loan, ");
poR.append("    to_char(pv.unit_st_es_dt,'DD-MON-RRRR') AS unit_st_es_dt, ");
poR.append("    PV.app_id, ");
poR.append("    pv.bank_ph_no, ");
poR.append("    pv.no_emp, ");
poR.append("    DECODE(pv.ben_con_no,NULL, AD.MOB_NO1,pv.ben_con_no) AS ben_con_no, ");
poR.append("    CASE WHEN nvl(pv.total_loan_sanc_ce, 0) + nvl(pv.total_loan_sanc_wc, 0) > 0 THEN ");
poR.append("    pv.total_loan_sanc_ce ELSE nvl(bd.ce_sanc_fb, 0) END AS total_loan_sanc_ce, ");
poR.append("    CASE WHEN nvl(pv.total_loan_sanc_ce, 0) + nvl(pv.total_loan_sanc_wc, 0) > 0 THEN ");
poR.append("    pv.total_loan_sanc_wc ELSE  ");
poR.append("    nvl(bd.wc_sanc_fb, 0) END AS total_loan_sanc_wc, ");
poR.append("    pv.total_loan_sanc, ");
poR.append("    pv.loan_rel_ce, ");
poR.append("    pv.loan_rel_wc, ");
poR.append("    pv.total_loan_rel, ");
poR.append("    pv.total_balance_loan, ");
poR.append("    pv.whe_cc, ");
poR.append("    to_char(pv.whe_cc_perc, '999990D00') AS whe_cc_perc, ");
poR.append("    decode (to_char(pv.rate_of_int, '999990D00'),null,bd.RINT,to_char(pv.rate_of_int, '999990D00')) AS rate_of_int, ");
poR.append("  DECODE(pv.tdr_subs_amt,NULL,BD.mm_rel_amt,pv.tdr_subs_amt) AS tdr_subs_amt,");
poR.append("  DECODE(pv.tdr_subs_no,NULL,BD.TDR_ACNO,pv.tdr_subs_no) AS tdr_subs_no,");
poR.append("  TO_CHAR(DECODE(pv.tdr_subs_dt,NULL,BD.TDR_ADJ_DT,pv.tdr_subs_dt),'DD-MON-RRRR') AS tdr_subs_dt,");
poR.append("  DECODE(pv.cgtmse_cov,NULL,BD.CGTSI,pv.cgtmse_cov) AS cgtmse_cov, ");
poR.append("    pv.whe_int_chr, ");
poR.append("    pv.coll_sec_obt, ");
poR.append("    pv.coll_sec_obt_val, ");
poR.append("    pv.whe_repay_loan, ");
poR.append("    pv.whe_unit_npa, ");
poR.append("    TO_CHAR(pv.whe_unit_npa_dt,'DD-MON-RRRR') AS whe_unit_npa_dt, ");
poR.append("    pv.unit_status, ");
poR.append("    pv.ann_to_unit_prod, ");
poR.append("    pv.ann_to_unit_sales, ");
poR.append("    pv.remarks_unit ");
poR.append("    FROM app_detail       ad, ");
poR.append("    mas_off_mast     mom, ");
poR.append("    bankform_pv      pv, ");
poR.append("    bank_dataentry   bd, ");
poR.append("    m_district       mdunit, ");
poR.append("    m_state          msunit, ");
poR.append("    activity_mast    am, ");
poR.append("    rbibanklist      rb  WHERE ");
poR.append("    bd.app_id = pv.app_id(+) ");
poR.append("    and ad.app_id = bd.app_id ");
poR.append("    AND ad.unit_dist_cd = mdunit.district_cd ");
poR.append("    AND mdunit.state_cd = msunit.state_cd ");
poR.append("    AND ad.activity_cd = am.activity_cd ");
poR.append("    AND mdunit.state_cd = msunit.state_cd ");
poR.append("    AND ad.off_cd = mom.off_cd ");
poR.append("    AND bd.ifsc_code = rb.ifsc_code ");
poR.append("    AND bd.app_id = ? ");

//out.print (poR.toString());

//out.print (app_id); //for display selected data
values.add(APP_ID1);
ResultSet rsMain = db.executeSQL(poR.toString(),values);
//try (ResultSet rsMain = db.execSQL(poR.toString())) {

//ResultSet rsMain = db.executeSQL(poR.toString());

while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
bank_fin_loan=rsMain.getString("bank_fin_loan")==null?"":rsMain.getString("bank_fin_loan");
agency_type=rsMain.getString("agency_type")==null?"":rsMain.getString("agency_type");
own_contribution=rsMain.getString("own_contribution")==null?"":rsMain.getString("own_contribution");
total_projectcost_fb=rsMain.getString("total_projectcost_fb")==null?"":rsMain.getString("total_projectcost_fb");
UNIT_ADDRS=rsMain.getString("UNIT_ADDRS")==null?"":rsMain.getString("UNIT_ADDRS");
activity_name=rsMain.getString("activity_name")==null?"":rsMain.getString("activity_name");
apploan_accno=rsMain.getString("apploan_accno")==null?"":rsMain.getString("apploan_accno");
loan_sanc_dt=rsMain.getString("loan_sanc_dt")==null?"":rsMain.getString("loan_sanc_dt");
district_name=rsMain.getString("district_name")==null?"":rsMain.getString("district_name");
state_nm=rsMain.getString("state_nm")==null?"":rsMain.getString("state_nm"); 
mm_rel_amt=rsMain.getString("mm_rel_amt")==null?"":rsMain.getString("mm_rel_amt");
unit_loc=rsMain.getString("unit_loc")==null?"":rsMain.getString("unit_loc");
app_name=rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
APP_ID1=rsMain.getString("APP_ID1")==null?"":rsMain.getString("APP_ID1");
UNIT_ST_ES_DT=rsMain.getString("UNIT_ST_ES_DT")==null?"":rsMain.getString("UNIT_ST_ES_DT");
BANK_PH_NO=rsMain.getString("BANK_PH_NO")==null?"":rsMain.getString("BANK_PH_NO");
NO_EMP=rsMain.getString("NO_EMP")==null?"":rsMain.getString("NO_EMP");
BEN_CON_NO=rsMain.getString("BEN_CON_NO")==null?"":rsMain.getString("BEN_CON_NO");
TOTAL_LOAN_SANC_CE=rsMain.getString("TOTAL_LOAN_SANC_CE")==null?"":rsMain.getString("TOTAL_LOAN_SANC_CE");
TOTAL_LOAN_SANC_WC=rsMain.getString("TOTAL_LOAN_SANC_WC")==null?"":rsMain.getString("TOTAL_LOAN_SANC_WC");
LOAN_REL_CE=rsMain.getString("LOAN_REL_CE")==null?"":rsMain.getString("LOAN_REL_CE");
LOAN_REL_WC=rsMain.getString("LOAN_REL_WC")==null?"":rsMain.getString("LOAN_REL_WC");
WHE_CC=rsMain.getString("WHE_CC")==null?"":rsMain.getString("WHE_CC");
WHE_CC_PERC=rsMain.getString("WHE_CC_PERC")==null?"":rsMain.getString("WHE_CC_PERC");
RATE_OF_INT=rsMain.getString("RATE_OF_INT")==null?"":rsMain.getString("RATE_OF_INT");
TDR_SUBS_AMT=rsMain.getString("TDR_SUBS_AMT")==null?"":rsMain.getString("TDR_SUBS_AMT");
TDR_SUBS_NO=rsMain.getString("TDR_SUBS_NO")==null?"":rsMain.getString("TDR_SUBS_NO");
TDR_SUBS_DT=rsMain.getString("TDR_SUBS_DT")==null?"":rsMain.getString("TDR_SUBS_DT");
CGTMSE_COV=rsMain.getString("CGTMSE_COV")==null?"":rsMain.getString("CGTMSE_COV");
WHE_INT_CHR=rsMain.getString("WHE_INT_CHR")==null?"":rsMain.getString("WHE_INT_CHR");
COLL_SEC_OBT=rsMain.getString("COLL_SEC_OBT")==null?"":rsMain.getString("COLL_SEC_OBT");
COLL_SEC_OBT_VAL=rsMain.getString("COLL_SEC_OBT_VAL")==null?"":rsMain.getString("COLL_SEC_OBT_VAL");
WHE_REPAY_LOAN=rsMain.getString("WHE_REPAY_LOAN")==null?"":rsMain.getString("WHE_REPAY_LOAN");
WHE_UNIT_NPA=rsMain.getString("WHE_UNIT_NPA")==null?"":rsMain.getString("WHE_UNIT_NPA");
WHE_UNIT_NPA_DT=rsMain.getString("WHE_UNIT_NPA_DT")==null?"":rsMain.getString("WHE_UNIT_NPA_DT");
UNIT_STATUS=rsMain.getString("UNIT_STATUS")==null?"":rsMain.getString("UNIT_STATUS");
ANN_TO_UNIT_PROD=rsMain.getString("ANN_TO_UNIT_PROD")==null?"":rsMain.getString("ANN_TO_UNIT_PROD");
ANN_TO_UNIT_SALES=rsMain.getString("ANN_TO_UNIT_SALES")==null?"":rsMain.getString("ANN_TO_UNIT_SALES");
REMARKS_UNIT=rsMain.getString("REMARKS_UNIT")==null?"":rsMain.getString("REMARKS_UNIT");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
ADDRESS=rsMain.getString("ADDRESS")==null?"":rsMain.getString("ADDRESS");
BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
TOTAL_LOAN_SANC=rsMain.getString("TOTAL_LOAN_SANC")==null?"":rsMain.getString("TOTAL_LOAN_SANC");
TOTAL_LOAN_REL=rsMain.getString("TOTAL_LOAN_REL")==null?"":rsMain.getString("TOTAL_LOAN_REL");
TOTAL_BALANCE_LOAN=rsMain.getString("TOTAL_BALANCE_LOAN")==null?"":rsMain.getString("TOTAL_BALANCE_LOAN");

if (!APP_ID.equals("")) {
add_update="U";
}


}

rsMain.close();

}
//out.print("add_update");


%>
<body <%if (!COLL_SEC_OBT.equals("Y")&!WHE_UNIT_NPA.equals("Y")){%> onLoad="perc1(this);perc2(this);" <%}%>> 


<form name="form" id="form" method="post">
<h1></h1>
<input name="ins" type="hidden" id="ins">

<input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID1 %>" />
<table id="customers" align="center">
  <tr>
    <th colspan="6"><div align="center">
      <h1><strong>Bank Form for Physical Verification</strong></h1>
    </div></th>
  </tr>
  <tr>
    <td>
      <strong><div align="center">(1)</div>
    </strong></td>
    <td colspan="2"><strong>Bank Name:</strong><%= BANK_NAME %></td>
    <td><strong>
      <div align="center">(2)</div>
    </strong></td>
    <td colspan="5"><strong>IFSC Code:</strong> <%= IFSC_CODE %></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(3)</strong></div></td>
    <td colspan="5"><strong>Bank Address:</strong> <%= ADDRESS %></td>
  </tr>
  <tr>
    <td><strong>
      <div align="center"><strong>(4)</strong></div>
    </strong></td>
    <td colspan="2"><strong>Branch Name:<%= BRANCHNAME %></strong></td>
    <td width="182"><div align="center"><strong>(5)</strong></div></td>
    <td colspan="3"><strong>Loan Release Date: </strong><%=loan_sanc_dt%></td>
  </tr>
  <tr>
    <td width="45"><div align="center"><strong>(6)</strong></div></td>
    <td colspan="2"><strong>Beneficiary Name:</strong><%=app_name%></td>
    <td width="182"><div align="center"><strong>(7)</strong></div></td>
    <td colspan="3"><strong>Application ID:</strong> <%=APP_ID1%></td>
  </tr>
  <tr>
    <td width="45"><div align="center"><strong>(8)</strong></div></td>
    <td colspan="2"><strong>Beneficiary Loan Acount No:</strong><%=apploan_accno%></td>
    <td width="182"><div align="center"><strong>(9)</strong></div></td>
    <td colspan="2"><strong>Activity/Industry name: </strong><%=activity_name%></td>
  </tr>
  <tr>
    <td width="45"><div align="center"><strong>(10)</strong></div></td>
    <td colspan="2" ><strong>Implementing Agency:</strong><%=agency_type%></td>
    <td width="182"><div align="center"><strong>(11)</strong></div></td>
    <td colspan="2"><strong>Beneficiary Unit <br />
      District/State :</strong><%=state_nm %>/<%=district_name %></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(12)</strong></div></td>
    <td colspan="5"><strong>Unit Location:</strong><%=unit_loc%></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(13)</strong></div></td>
    <td colspan="5"><strong>Proposed unit addresss:</strong><%=UNIT_ADDRS%></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(14)</strong></div></td>
    <td colspan="2"><strong>Margin Money amount Received:</strong></td>
    <td colspan="3"><%=mm_rel_amt%></td>
  </tr>
  <tr>
    <td rowspan="2"><div align="center"> <strong>(15)</strong></div></td>
    <td colspan="2" rowspan="2" ><div align="center"><strong>Project Detail <br />
      ( in Rs) </strong></div></td>
    <td width="182"><div align="center"><strong>Total Project Cost </strong></div></td>
    <td width="206"><div align="center"><strong>Own Contribution</strong></div></td>
    <td><div align="center"><strong>Bank Financing /Loan</strong></div></td>
  </tr>
  <tr>
    <td width="182"><div align="center"><%=total_projectcost_fb%></div></td>
    <td><div align="center"><%=own_contribution %></div></td>
    <td><div align="center"><%=bank_fin_loan%></div></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(16)</strong></div></td>
    <td colspan="2"><p><strong>Unit Start/ Establishment date:*<br />
              <input  name="UNIT_ST_ES_DT" type="text" id="UNIT_ST_ES_DT" onclick="javascript:NewCssCal('UNIT_ST_ES_DT','ddMMMyyyy')" value="<%=UNIT_ST_ES_DT%>"/>
      <i class="fa fa-calendar" aria-hidden="true" style="font-size:25px" onclick="javascript:NewCssCal('UNIT_ST_ES_DT','ddMMMyyyy')"></i>(DD-MON-YYYY)</strong></p></td>
    <td><div align="center"><strong>(17)</strong></div></td>
    <td colspan="2"><strong>Bank Phone No.:*</strong>
        <input name="BANK_PH_NO" type="text" id="BANK_PH_NO" size="20" maxlength="10"  onKeyPress="return isNumberKey(event);" value="<%=BANK_PH_NO%>" />
        <br /></td>
  </tr>
  <tr>
    <td width="45" ><div align="center"><strong>(18)</strong></div></td>
    <td colspan="2"><p> <strong>No of Employment:</strong>
            <input name="NO_EMP" type="text" id="NO_EMP" size="20" maxlength="20" value="<%=NO_EMP%>" />
    </p></td>
    <td><div align="center"><strong>(19)</strong></div></td>
    <td colspan="2"><p><strong>Beneficiary Contact No.*:</strong>
            <input name="BEN_CON_NO" type="text" id="BEN_CON_NO" size="20" maxlength="10" onKeyPress="return isNumberKey(event);" value="<%=BEN_CON_NO%>" />
    </p></td>
  </tr>
  <tr> </tr>
  <tr>
    <td ><div align="center"></div></td>
    <td colspan="2">&nbsp;</td>
    <td><div align="center"><strong>Term Loan(CE) (in Rs.) </strong></div></td>
    <td width="206"><div align="center"><strong>Cash Credit(WC) (in Rs.)</strong></div></td>
    <td width="296"><div align="center"><strong>Total (in Rs)</strong></div></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(20)</strong></div></td>
    <td colspan="2"><div align="center"><strong>Total Loan Sanctioned (A) </strong></div></td>
    <td width="182"><div align="center">
      <input name="TOTAL_LOAN_SANC_CE" type="text" readonly="true" id="TOTAL_LOAN_SANC_CE" size="20" maxlength="40" value="<%=TOTAL_LOAN_SANC_CE%>" onkeypress="return numbersonly(event);" onblur="calculation();" />
    </div></td>
    <td><div align="center">
      <input name="TOTAL_LOAN_SANC_WC" type="text"  readonly="true" id="TOTAL_LOAN_SANC_WC" size="20" maxlength="40" value="<%=TOTAL_LOAN_SANC_WC%>" onkeypress="return numbersonly(event);" onblur="calculation();" />
    </div></td>
    <td><div align="center">
      <input name="TOTAL_LOAN_SANC" type="text" id="TOTAL_LOAN_SANC" size="20" maxlength="40"  value="<%=TOTAL_LOAN_SANC%>" onkeypress="return numbersonly(event);" onblur="calculation();" readonly="true"/>
    </div></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(21)</strong></div></td>
    <td colspan="2"><div align="center"><strong>Loan Released (B)/Disbursed</strong>*</div></td>
    <td><div align="center">
      <input name="LOAN_REL_CE" type="text" id="LOAN_REL_CE" size="20" maxlength="40" value="<%=LOAN_REL_CE%>" onkeypress="return numbersonly(event);" onblur="calculation();"/>
    </div></td>
    <td><div align="center">
      <input name="LOAN_REL_WC" type="text" id="LOAN_REL_WC" size="20" maxlength="40" value="<%=LOAN_REL_WC%>" onkeypress="return numbersonly(event);" onblur="calculation();"/>
    </div></td>
    <td><div align="center">
      <input name="TOTAL_LOAN_REL" type="text" id="TOTAL_LOAN_REL" size="20" maxlength="40" value="<%=TOTAL_LOAN_REL%>" onkeypress="return numbersonly(event);" onblur="calculation();" readonly="true" />
    </div></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(22)</strong></div></td>
    <td colspan="2"><div align="center"><strong>Balance Loan to be Released to Beneficiary (A-B) </strong></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="center">
      <input name="TOTAL_BALANCE_LOAN" type="text" id="TOTAL_BALANCE_LOAN" size="20" maxlength="40" value="<%=TOTAL_BALANCE_LOAN%>" onkeypress="return numbersonly(event);" onblur="calculation();" readonly="true" />
    </div></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(23)</strong></div></td>
    <td colspan="2"><p><strong>Whether Cash Credit limit utilized by 100% of sanctioned amount 
      and not less than 75% during lock-in period of 3 years</strong> </p>
        <p><strong>(Mention %age utilization in case of No.)*:</strong></p>
        <input type="radio" name="WHE_CC" id="WHE_CC" value="Y" <%if(WHE_CC.equals("Y")){out.print("checked");}%>  onchange="perc(this);" />
      Yes
      <input type="radio" name="WHE_CC" id="WHE_CC" value="N" <%if(WHE_CC.equals("N")){out.print("checked");} %> onchange="perc(this);" />
      No </td>
    <td><div align="center"><strong>(24)</strong></div></td>
    <td colspan="2"><strong>Percentage of utilization*:</strong>
        <input  name="WHE_CC_PERC" type="text" id="WHE_CC_PERC" size="20" maxlength="40" value="<%=WHE_CC_PERC%>" />
      % </td>
  </tr>
  <tr>
    <td><div align="center"><strong>(25)</strong></div></td>
    <td colspan="2"><strong>Rate of Interest*:</strong>
      <input name="RATE_OF_INT" type="text" id="RATE_OF_INT" size="20" maxlength="40" value="<%=RATE_OF_INT%>" />
      %</td>
    <td><div align="center"><strong>(26)</strong></div></td>
    <td colspan="2"><p><strong>TDR/Subsidy Reserve<br />
      Fund Amount*:</strong>&nbsp
      <input name="TDR_SUBS_AMT" type="text" id="TDR_SUBS_AMT" size="20" maxlength="40" value="<%=TDR_SUBS_AMT%>" />
    </p></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(27)</strong></div></td>
    <td colspan="2"><strong>TDR/Subsidy Reserve Fund Number*:</strong>
        <input name="TDR_SUBS_NO" type="text" id="TDR_SUBS_NO" size="20" maxlength="40" value="<%=TDR_SUBS_NO%>" />    </td>
    <td><div align="center"><strong>(28)</strong></div></td>
	 
    <td colspan="2"><p><strong>TDR/Subsidy Reserve Fund Date*:<br />
	<input name="TDR_SUBS_DT" type="text" id="TDR_SUBS_DT" onclick="javascript:NewCssCal('TDR_SUBS_DT','ddMMMyyyy')" value="<%=TDR_SUBS_DT%>" />
      <i class="fa fa-calendar" aria-hidden="true" style="font-size:25px" onclick="javascript:NewCssCal('TDR_SUBS_DT','ddMMMyyyy')" ></i>(DD-MON-YYYY)</strong> </p></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(29)</strong></div></td>
    <td colspan="2"><strong>CGTMSE Coverage*:</strong>&nbsp
      <input type="radio" name="CGTMSE_COV" id="CGTMSE_COV" value="Y" <%if(CGTMSE_COV.equals("Y")){out.print("checked");}%> />
      Yes
      <input type="radio" name="CGTMSE_COV" id="CGTMSE_COV" value="N" <%if(CGTMSE_COV.equals("N")){out.print("checked");}%> />
      No </td>
    <td><div align="center"><strong>(30)</strong></div></td>
    <td colspan="3"><p><strong>Whether Interest Charged on <br />
      Correspondind amount of Margin Money*:</strong></p>
      &nbsp
      <input type="radio" name="WHE_INT_CHR" id="WHE_INT_CHR" value="Y" <%if(WHE_INT_CHR.equals("Y")){out.print("checked");}%> />
      Yes
      <input type="radio" name="WHE_INT_CHR" id="WHE_INT_CHR" value="N" <%if(WHE_INT_CHR.equals("N")){out.print("checked");}%> />
      No </td>
  </tr>
  <tr>
    <td><div align="center"><strong>(31)</strong></div></td>
    <td colspan="2"><strong>Collateral Security obtained*:&nbsp </strong>
        <input type="radio" name="COLL_SEC_OBT" id="COLL_SEC_OBT" value="Y" <%if(COLL_SEC_OBT.equals("Y")){out.print("checked");}%> onchange="perc1(this);" />
      Yes
      <input type="radio" name="COLL_SEC_OBT" id="COLL_SEC_OBT"  value="N" <%if(COLL_SEC_OBT.equals("N")){out.print("checked");}%> onchange="perc1(this);" />
      No </td>
    <td><div align="center"><strong>(32)</strong></div></td>
    <td colspan="2"><strong>If Yes, Value of Collateral Security*:</strong>
	
      <input name="COLL_SEC_OBT_VAL" type="text" id="COLL_SEC_OBT_VAL" size="20" maxlength="40" value="<%= COLL_SEC_OBT_VAL %>" />    </td>
  </tr>
  <tr>
    <td><div align="center"><strong>(33)</strong></div></td>
    <td colspan="5"><strong>Whether Repayment of Loan is Regular*:</strong><input type="radio" name="WHE_REPAY_LOAN" id="WHE_REPAY_LOAN" value="Y" <%if(WHE_REPAY_LOAN.equals("Y")){out.print("checked");}%> />
      Yes
      <input type="radio" name="WHE_REPAY_LOAN"  id="WHE_REPAY_LOAN" value="N" <%if(WHE_REPAY_LOAN.equals("N")){out.print("checked");}%> />
      No </td>
  </tr>
  <tr>
    <td><div align="center"><strong>(34)</strong></div></td>
    <td colspan="2"><strong>Whether unit comes under NPA?*:</strong>&nbsp
      <input type="radio" name="WHE_UNIT_NPA" id="WHE_UNIT_NPA" value="Y" <%if(WHE_UNIT_NPA.equals("Y")){out.print("checked");}%> onchange="perc2(this);" />
      Yes
      <input type="radio" name="WHE_UNIT_NPA" id="WHE_UNIT_NPA" value="N" <%if(WHE_UNIT_NPA.equals("N")){out.print("checked");}%> onchange="perc2(this);" />
      No </td>
    <td><div align="center"><strong>(35)</strong></div></td>
	
    <td colspan="2"><p><strong>If Yes, NPA w.e.f.:<br />
          <input name="WHE_UNIT_NPA_DT" type="text" id="WHE_UNIT_NPA_DT" onclick="javascript:NewCssCal('WHE_UNIT_NPA_DT','ddMMMyyyy')" value="<%=WHE_UNIT_NPA_DT%>" /> 
      <i class="fa fa-calendar" aria-hidden="true" style="font-size:25px" onclick="javascript:NewCssCal('WHE_UNIT_NPA_DT','ddMMMyyyy')" ></i>(DD-MON-YYYY)</strong>
            
    </p></td>
  </tr>
  <tr>
    <td rowspan="2"><div align="center"><strong>(36)</strong></div></td>
    <td colspan="2" rowspan="2"><strong>Unit Status*:</strong></td>
    <td colspan="3"><input type="radio"  name="UNIT_STATUS" id="UNIT_STATUS" value="W" "unit_status" <%if(UNIT_STATUS.equals("W")){out.print("checked");}%> />
      Working</td>
  </tr>
  <tr>
    <td colspan="4"><input type="radio"  name="UNIT_STATUS" id="UNIT_STATUS" value="N" <%if(UNIT_STATUS.equals("N")){out.print("checked");}%> />
      Not Working/defunct</td>
  </tr>
  <tr>
    <td rowspan="2"><div align="center"><strong>(37)</strong></div></td>
    <td colspan="2" rowspan="2"><strong>Annual Turnover of the Unit:</strong></td>
    <td colspan="2" ><div align="center"><strong>Production (in Rs.) </strong></div></td>
    <td width="296"><div align="center"><strong>Sales (in Rs.) </strong></div></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input name="ANN_TO_UNIT_PROD" type="text" id="ANN_TO_UNIT_PROD" size="20" maxlength="40" value="<%=ANN_TO_UNIT_PROD%>" placeholder="Type Here"/>
    </div></td>
    <td><div align="center">
      <input name="ANN_TO_UNIT_SALES" type="text" id="ANN_TO_UNIT_SALES" size="20" maxlength="40" value="<%=ANN_TO_UNIT_SALES%>" placeholder="Type Here"/>
    </div></td>
  </tr>
  <tr>
    <td><div align="center"><strong>(38)</strong></div></td>
    <td colspan="2"><strong>Any other Remark on the Functioning of the Unit:</strong></td>
    <td colspan="6"><textarea type="text"  name="REMARKS_UNIT"  rows="4" cols="50"><%=REMARKS_UNIT%></textarea></td>
  </tr>
  <tr>
    <td colspan="6"><div align="center">
      <input name="button" type="button" class="button1"  onclick="sub_form();" value="Submit" />
    </div></td>
  </tr>
</table>
</form>

<% 

  if (ins.equals("I")){
try {
//out.print ("insde");

 
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
APP_ID1=(String) request.getParameter("APP_ID1")==null?"":(String) request.getParameter("APP_ID1").trim();
UNIT_ST_ES_DT=(String) request.getParameter("UNIT_ST_ES_DT")==null?"":(String) request.getParameter("UNIT_ST_ES_DT").trim();
BANK_PH_NO=(String) request.getParameter("BANK_PH_NO")==null?"":(String) request.getParameter("BANK_PH_NO").trim();
NO_EMP=(String) request.getParameter("NO_EMP")==null?"":(String) request.getParameter("NO_EMP").trim();
BEN_CON_NO=(String) request.getParameter("BEN_CON_NO")==null?"":(String) request.getParameter("BEN_CON_NO").trim();
TOTAL_LOAN_SANC_CE=(String) request.getParameter("TOTAL_LOAN_SANC_CE")==null?"":(String) request.getParameter("TOTAL_LOAN_SANC_CE").trim();
TOTAL_LOAN_SANC_WC=(String) request.getParameter("TOTAL_LOAN_SANC_WC")==null?"":(String) request.getParameter("TOTAL_LOAN_SANC_WC").trim();
LOAN_REL_CE=(String) request.getParameter("LOAN_REL_CE")==null?"":(String) request.getParameter("LOAN_REL_CE").trim();
LOAN_REL_WC=(String) request.getParameter("LOAN_REL_WC")==null?"":(String) request.getParameter("LOAN_REL_WC").trim();
WHE_CC=(String) request.getParameter("WHE_CC")==null?"":(String) request.getParameter("WHE_CC").trim();
WHE_CC_PERC=(String) request.getParameter("WHE_CC_PERC")==null?"":(String) request.getParameter("WHE_CC_PERC").trim();
RATE_OF_INT=(String) request.getParameter("RATE_OF_INT")==null?"":(String) request.getParameter("RATE_OF_INT").trim();
TDR_SUBS_AMT=(String) request.getParameter("TDR_SUBS_AMT")==null?"":(String) request.getParameter("TDR_SUBS_AMT").trim();
TDR_SUBS_NO=(String) request.getParameter("TDR_SUBS_NO")==null?"":(String) request.getParameter("TDR_SUBS_NO").trim();
TDR_SUBS_DT=(String) request.getParameter("TDR_SUBS_DT")==null?"":(String) request.getParameter("TDR_SUBS_DT").trim();
CGTMSE_COV=(String) request.getParameter("CGTMSE_COV")==null?"":(String) request.getParameter("CGTMSE_COV").trim();
WHE_INT_CHR=(String) request.getParameter("WHE_INT_CHR")==null?"":(String) request.getParameter("WHE_INT_CHR").trim();
COLL_SEC_OBT=(String) request.getParameter("COLL_SEC_OBT")==null?"":(String) request.getParameter("COLL_SEC_OBT").trim();
COLL_SEC_OBT_VAL=(String) request.getParameter("COLL_SEC_OBT_VAL")==null?"":(String) request.getParameter("COLL_SEC_OBT_VAL").trim();
WHE_REPAY_LOAN=(String) request.getParameter("WHE_REPAY_LOAN")==null?"":(String) request.getParameter("WHE_REPAY_LOAN").trim();
WHE_UNIT_NPA=(String) request.getParameter("WHE_UNIT_NPA")==null?"":(String) request.getParameter("WHE_UNIT_NPA").trim();
WHE_UNIT_NPA_DT=(String) request.getParameter("WHE_UNIT_NPA_DT")==null?"":(String) request.getParameter("WHE_UNIT_NPA_DT").trim();
UNIT_STATUS=(String) request.getParameter("UNIT_STATUS")==null?"":(String) request.getParameter("UNIT_STATUS").trim();
ANN_TO_UNIT_PROD=(String) request.getParameter("ANN_TO_UNIT_PROD")==null?"":(String) request.getParameter("ANN_TO_UNIT_PROD").trim();
ANN_TO_UNIT_SALES=(String) request.getParameter("ANN_TO_UNIT_SALES")==null?"":(String) request.getParameter("ANN_TO_UNIT_SALES").trim();
REMARKS_UNIT=(String) request.getParameter("REMARKS_UNIT")==null?"":(String) request.getParameter("REMARKS_UNIT").trim();
TOTAL_LOAN_SANC=(String) request.getParameter("TOTAL_LOAN_SANC")==null?"":(String) request.getParameter("TOTAL_LOAN_SANC").trim();
TOTAL_LOAN_REL=(String) request.getParameter("TOTAL_LOAN_REL")==null?"":(String) request.getParameter("TOTAL_LOAN_REL").trim();
TOTAL_BALANCE_LOAN=(String) request.getParameter("TOTAL_BALANCE_LOAN")==null?"":(String) request.getParameter("TOTAL_BALANCE_LOAN").trim();





        List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		
		
		/*
ResultSet rsMax = db.execSQL("SELECT nvl(max(app_id),0)+1 as app_id  FROM pmegp_award");
while (rsMax.next()) {
app_id=rsMax.getString("app_id")==null?"":rsMax.getString("app_id");
}
*/


	//rsMax.close();
	
if (add_update.equals("I")) {
  
qryUpdate.append(" INSERT INTO bankform_pv (");
qryUpdate.append("UNIT_ST_ES_DT,");
qryUpdate.append("BANK_PH_NO,");
qryUpdate.append("NO_EMP,");
qryUpdate.append("BEN_CON_NO,");
qryUpdate.append("TOTAL_LOAN_SANC_CE,");
qryUpdate.append("TOTAL_LOAN_SANC_WC,");
qryUpdate.append("LOAN_REL_CE,");
qryUpdate.append("LOAN_REL_WC,");
qryUpdate.append("WHE_CC,");
qryUpdate.append("WHE_CC_PERC,");
qryUpdate.append("RATE_OF_INT,");
qryUpdate.append("TDR_SUBS_AMT,");
qryUpdate.append("TDR_SUBS_NO,");
qryUpdate.append("TDR_SUBS_DT,");
qryUpdate.append("CGTMSE_COV,");
qryUpdate.append("WHE_INT_CHR,");
qryUpdate.append("COLL_SEC_OBT,");
qryUpdate.append("COLL_SEC_OBT_VAL,");
qryUpdate.append("WHE_REPAY_LOAN,");
qryUpdate.append("WHE_UNIT_NPA,");
qryUpdate.append("WHE_UNIT_NPA_DT,");
qryUpdate.append("UNIT_STATUS,");
qryUpdate.append("ANN_TO_UNIT_PROD,");
qryUpdate.append("ANN_TO_UNIT_SALES,");
qryUpdate.append("REMARKS_UNIT,");
qryUpdate.append("TOTAL_LOAN_SANC,");
qryUpdate.append("TOTAL_LOAN_REL,");
qryUpdate.append("TOTAL_BALANCE_LOAN,");
qryUpdate.append("APP_ID");
qryUpdate.append( ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");


}else {


qryUpdate.append("	UPDATE bankform_pv SET ");
qryUpdate.append(" UNIT_ST_ES_DT=?, ");
qryUpdate.append(" BANK_PH_NO=?, ");
qryUpdate.append(" NO_EMP=?, ");
qryUpdate.append(" BEN_CON_NO=?, ");
qryUpdate.append(" TOTAL_LOAN_SANC_CE=?, ");
qryUpdate.append(" TOTAL_LOAN_SANC_WC=?, ");
qryUpdate.append(" LOAN_REL_CE=?, ");
qryUpdate.append(" LOAN_REL_WC=?, ");
qryUpdate.append(" WHE_CC=?, ");
qryUpdate.append(" WHE_CC_PERC=?, ");
qryUpdate.append(" RATE_OF_INT=?, ");
qryUpdate.append(" TDR_SUBS_AMT=?, ");
qryUpdate.append(" TDR_SUBS_NO=?, ");
qryUpdate.append(" TDR_SUBS_DT=?, ");
qryUpdate.append(" CGTMSE_COV=?,  ");
qryUpdate.append(" WHE_INT_CHR=?, ");
qryUpdate.append(" COLL_SEC_OBT=?, ");
qryUpdate.append(" COLL_SEC_OBT_VAL=?,");
qryUpdate.append(" WHE_REPAY_LOAN=?,");
qryUpdate.append(" WHE_UNIT_NPA=?,");
qryUpdate.append(" WHE_UNIT_NPA_DT=?,");
qryUpdate.append(" UNIT_STATUS=?,");
qryUpdate.append(" ANN_TO_UNIT_PROD=?,");
qryUpdate.append(" ANN_TO_UNIT_SALES=?,");
qryUpdate.append(" REMARKS_UNIT=?,");
qryUpdate.append(" TOTAL_LOAN_SANC=?, ");
qryUpdate.append(" TOTAL_LOAN_REL=?, ");
qryUpdate.append(" TOTAL_BALANCE_LOAN=? ");
qryUpdate.append(" WHERE APP_ID=? ");

}

out.print (qryUpdate.toString());

values.add(UNIT_ST_ES_DT); pstm.add ("L");
values.add(BANK_PH_NO); pstm.add ("L");
values.add(NO_EMP); pstm.add ("L");
values.add(BEN_CON_NO); pstm.add ("L");
values.add(TOTAL_LOAN_SANC_CE); pstm.add ("L");
values.add(TOTAL_LOAN_SANC_WC); pstm.add ("L");
values.add(LOAN_REL_CE); pstm.add ("L");
values.add(LOAN_REL_WC); pstm.add ("L");
values.add(WHE_CC); pstm.add ("L");
values.add(WHE_CC_PERC); pstm.add ("L");
values.add(RATE_OF_INT); pstm.add ("L");
values.add(TDR_SUBS_AMT); pstm.add ("L");
values.add(TDR_SUBS_NO); pstm.add ("L");
values.add(TDR_SUBS_DT); pstm.add ("L");
values.add(CGTMSE_COV); pstm.add ("L");
values.add(WHE_INT_CHR); pstm.add ("L");
values.add(COLL_SEC_OBT); pstm.add ("L");
values.add(COLL_SEC_OBT_VAL); pstm.add ("L");
values.add(WHE_REPAY_LOAN); pstm.add ("L");
values.add(WHE_UNIT_NPA); pstm.add ("L");
values.add(WHE_UNIT_NPA_DT); pstm.add ("L");
values.add(UNIT_STATUS); pstm.add ("L");
values.add(ANN_TO_UNIT_PROD); pstm.add ("L");
values.add(ANN_TO_UNIT_SALES); pstm.add ("L");
values.add(REMARKS_UNIT); pstm.add ("L");
values.add(TOTAL_LOAN_SANC); pstm.add ("L");
values.add(TOTAL_LOAN_REL); pstm.add ("L");
values.add(TOTAL_BALANCE_LOAN); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();
surl="index.jsp?APP_ID1="+APP_ID;

}catch (Exception e) {

out.print (e.toString());
}
}

try {
 db.close();
 }catch (Exception e) {}finally {
 //db.close();
 }
 
if (surl !="") {response.sendRedirect("bankWiseReport.jsp");}

%>
</body>
</FORM>
</html>
