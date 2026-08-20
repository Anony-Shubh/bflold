function loan_calc(){
	var ce=document.form.SKILLED_EMPLOYEES.value;
	var we=document.form.SEMI_SKILLED_EMPLOYEES.value;
	var pe=document.form.UNSKILLED_EMPLOYEES.value;
	var tcewe=Number(ce)+Number(we)+Number(pe);
	document.form.TOTAL_SKILLED.value=tcewe;
	//alert(tcewe);
	}
	function loan_calc1(){
	var ce=document.form.FULLTIME_EMPLOYEES.value;
	var we=document.form.PART_TIME_EMPLOYEES.value;
	var pe=document.form.SEASONAL_EMPLOYEES.value;
	var tcewe=Number(ce)+Number(we)+Number(pe);
	document.form.TOTAL_SEASONAL.value=tcewe;
	//alert(tcewe);
	}
	function loan_calc2(){
	var ce=document.form.GENERAL.value;
	var we=document.form.SC.value;
	var pe=document.form.ST.value;
	var te=document.form.OBC.value;
	var re=document.form.MINORITY.value;
	
	
	var tcewe=Number(ce)+Number(we)+Number(pe)+Number(te)+Number(re);
	document.form.TOTAL_MINORITY.value=tcewe;
	//alert(tcewe);
	}
		function loan_calc3(){
	var ce=document.form.MALE_EMPLOYEES.value;
	var we=document.form.FEMALE_EMPLOYEES.value;
	var pe=document.form.TRANSGENDER_EMPLOYEES.value;
	var tcewe=Number(ce)+Number(we)+Number(pe);
	document.form.TOTAL_GENDER.value=tcewe;
	//alert(tcewe);
	}

function form_submit(){

var numberOnly = /[0-9]|\./;

	// var form = document.getElementById("form");
 //var UNIT_NAME=form.elements["QC_APPRV"].value; 
var UNIT_NAME = document.form.UNIT_NAME.value;
var UNIT_ADDRESS = document.form.UNIT_ADDRESS.value;
var UNIT_ESTABLISHMENT_DATE = document.form.UNIT_ESTABLISHMENT_DATE.value;
var DATE_OF_WATER_CONNECTION = document.form.DATE_OF_WATER_CONNECTION.value;
var DATE_OF_ELECTRIC_CONNECTION = document.form.DATE_OF_ELECTRIC_CONNECTION.value;
var OTHER_CLEARANCE = document.form.OTHER_CLEARANCE.value;
var GST_REGISTRATION_NUMBER = document.form.GST_REGISTRATION_NUMBER.value;
var GST_REGISTRATION_DATE = document.form.GST_REGISTRATION_DATE.value;
var UDYAM_REGISTRATION_NUMBER = document.form.UDYAM_REGISTRATION_NUMBER.value;
var UDYAM_REGISTRATION_DATE = document.form.UDYAM_REGISTRATION_DATE.value;
var PAN_OR_TAN_NUMBER = document.form.PAN_OR_TAN_NUMBER.value;
var KVIC_REGISTRATION_NUMBER = document.form.KVIC_REGISTRATION_NUMBER.value;
var KVIC_REGISTRATION_DATE = document.form.KVIC_REGISTRATION_DATE.value;
var REGISTERED_BRAND_NAME = document.form.REGISTERED_BRAND_NAME.value;
var PATENT_OWNERSHIP = document.form.PATENT_OWNERSHIP.value;
var HANDHOLDING_DETAILS = document.form.HANDHOLDING_DETAILS.value;
var ANNUAL_PRODUCTION_QUANTITY= document.form.ANNUAL_PRODUCTION_QUANTITY.value;
var ANNUAL_PRODUCTION_VALUE = document.form.ANNUAL_PRODUCTION_VALUE.value;
var PRESENT_PRODUCTION_QUANTITY = document.form.PRESENT_PRODUCTION_QUANTITY.value;
var PRESENT_PRODUCTION_VALUE = document.form.PRESENT_PRODUCTION_VALUE.value;
var MACHINERY_TYPE = document.form.MACHINERY_TYPE.value;
var RAW_MATERIAL_DETAILS = document.form.RAW_MATERIAL_DETAILS.value;
var RAW_MATERIAL_IMPORT = document.form.RAW_MATERIAL_IMPORT.value;


/*ME*/

var COUNTRY_OF_IMPORT = document.form.COUNTRY_OF_IMPORT.value;
var RAW_MATERIAL_STOCK_VALUE= document.form.RAW_MATERIAL_STOCK_VALUE.value;
var SEMI_FIN_RM_STOCK= document.form.SEMI_FIN_RM_STOCK.value;
var FINISHED_RAW_MATERIAL_STOCK= document.form.FINISHED_RAW_MATERIAL_STOCK.value;
var CAPITAL_COST_OF_BUILDING= document.form.CAPITAL_COST_OF_BUILDING.value;
var CAPITAL_COST_OF_MACHINERY= document.form.CAPITAL_COST_OF_MACHINERY.value;
var ANNUAL_SALES_QUANTITY= document.form.ANNUAL_SALES_QUANTITY.value;
var ANNUAL_SALES_VALUE= document.form.ANNUAL_SALES_VALUE.value;
var PRESENT_SALES_QUANTITY= document.form.PRESENT_SALES_QUANTITY.value;
var PRESENT_SALES_VALUE= document.form.PRESENT_SALES_VALUE.value;
var MAIN_PRODUCT= document.form.MAIN_PRODUCT.value;
var BY_PRODUCT= document.form.BY_PRODUCT.value;
var EXPORT_QUANTITY= document.form.EXPORT_QUANTITY.value;
var EXPORT_VALUE= document.form.EXPORT_VALUE.value;
var COUNTRY_OF_EXPORT= document.form.COUNTRY_OF_EXPORT.value;
var MODE_OF_EXPORT= document.form.MODE_OF_EXPORT.value;


var SKILLED_EMPLOYEES= document.form.SKILLED_EMPLOYEES.value;
var SEMI_SKILLED_EMPLOYEES= document.form.SEMI_SKILLED_EMPLOYEES.value;
var UNSKILLED_EMPLOYEES= document.form.UNSKILLED_EMPLOYEES.value;
var TOTAL_SKILLED= document.form.TOTAL_SKILLED.value;

var FULLTIME_EMPLOYEES= document.form.FULLTIME_EMPLOYEES.value;
var PART_TIME_EMPLOYEES= document.form.PART_TIME_EMPLOYEES.value;
var SEASONAL_EMPLOYEES= document.form.SEASONAL_EMPLOYEES.value;
var TOTAL_SEASONAL=document.form.TOTAL_SEASONAL.value;

var GENERAL= document.form.GENERAL.value;
var SC= document.form.SC.value;
var ST= document.form.ST.value;
var OBC= document.form.OBC.value;
var MINORITY= document.form.MINORITY.value;
var TOTAL_MINORITY= document.form.TOTAL_MINORITY.value;



var MALE_EMPLOYEES= document.form.MALE_EMPLOYEES.value;
var FEMALE_EMPLOYEES= document.form.FEMALE_EMPLOYEES.value;
var TRANSGENDER_EMPLOYEES= document.form.TRANSGENDER_EMPLOYEES.value;
var TOTAL_GENDER= document.form.TOTAL_GENDER.value;

var PHYSICALLY_CHALLENGED_EMPLOYEE= document.form.PHYSICALLY_CHALLENGED_EMPLOYEE.value;
var AVERAGE_WAGES_PAID= document.form.AVERAGE_WAGES_PAID.value;

var PENDING_LOAN_AMOUNT= document.form.PENDING_LOAN_AMOUNT.value;
var ROI_LOAN= document.form.ROI_LOAN.value;
var TDR_AMOUNT= document.form.TDR_AMOUNT.value;
var TDR_NUMBER= document.form.TDR_NUMBER.value;
var IS_MARGIN_MONEY_ELIGIBLE_FOR_A= document.form.IS_MARGIN_MONEY_ELIGIBLE_FOR_A.value;
var IS_INTEREST_CHARGED= document.form.IS_INTEREST_CHARGED.value;
var IS_COLLATERAL_SECURITY= document.form.IS_COLLATERAL_SECURITY.value;

var VALUE_OF_COLLATERAL_SECURITY= document.form.VALUE_OF_COLLATERAL_SECURITY.value;
var IS_REPAYMENT_REGULAR= document.form.IS_REPAYMENT_REGULAR.value;
var NPA_PERIOD= document.form.NPA_PERIOD.value;
var OUTSTANDING_LOAN_AMOUNT= document.form.OUTSTANDING_LOAN_AMOUNT.value;
var PER_CAPITA_INVESTMENT_NORM_SAT= document.form.PER_CAPITA_INVESTMENT_NORM_SAT.value;
var PROMINENT_SIGN_BOARD_INSTALLED= document.form.PROMINENT_SIGN_BOARD_INSTALLED.value;

var VERIFICATION_STATUS= document.form.VERIFICATION_STATUS.value;
var VERIFICATION_DATETIME= document.form.VERIFICATION_DATETIME.value;
var VERIFICATION_BY= document.form.VERIFICATION_BY.value;
var VERIFIER_REMARKS= document.form.VERIFIER_REMARKS.value;
//alert(TOTAL_SKILLED);

if(VERIFICATION_STATUS==""){
 swal ( 'Note:','Please enter VERIFICATION_STATUS','error');	
 return (false);
}

if ((VERIFICATION_STATUS!="") && (VERIFICATION_STATUS=="Working")) { 

if(VERIFICATION_DATETIME==""){
 swal ( 'Note:','Please enter VERIFICATION_DATETIME','error');	
 return (false);
}
if(VERIFICATION_BY==""){
 swal ( 'Note:','Please enter VERIFICATION_BY','error');	
 return (false);
}
if(VERIFIER_REMARKS==""){
 swal ( 'Note:','Please enter VERIFIER_REMARKS','error');	
 return (false);
}


if(UNIT_NAME==""){
 swal ( 'Note:','Please enter unit name','error');	
 return (false);
}
if(UNIT_ADDRESS==""){
 swal ( 'Note:','Please enter unit address','error');	
 return (false);
}
if(UNIT_ESTABLISHMENT_DATE==""){
 swal ( 'Note:','Please enter establishment date','error');	
 return (false);
}

if(ANNUAL_PRODUCTION_QUANTITY==""){
 swal ( 'Note:','Please enter annual production quantity','error');	
 return (false);
}
if(ANNUAL_PRODUCTION_VALUE==""){
 swal ( 'Note:','Please enter annual production value','error');	
 return (false);
}
if(PRESENT_PRODUCTION_QUANTITY==""){
 swal ( 'Note:','Please enter present production quantity','error');	
 return (false);
}
if(PRESENT_PRODUCTION_VALUE==""){
 swal ( 'Note:','Please enter present production value','error');	
 return (false);
}
if(ANNUAL_SALES_QUANTITY==""){
 swal ( 'Note:','Please enter ANNUAL_SALES_QUANTITY','error');	
 return (false);
}
if(ANNUAL_SALES_VALUE==""){
 swal ( 'Note:','Please enter ANNUAL_SALES_VALUE','error');	
 return (false);
}

if(PRESENT_SALES_QUANTITY==""){
 swal ( 'Note:','Please enter PRESENT_SALES_QUANTITY','error');	
 return (false);
}

if(PRESENT_SALES_VALUE==""){
 swal ( 'Note:','Please enter PRESENT_SALES_VALUE','error');	
 return (false);
}

if(MAIN_PRODUCT==""){
 swal ( 'Note:','Please enter MAIN_PRODUCT','error');	
 return (false);
}
if (TOTAL_SKILLED != TOTAL_SEASONAL){
swal ( 'Note:','Total SEASONAL EMPLOYEES should be equal to TOTAL SKILLED EMPLOYEES','error');
 return (false);
}
if (TOTAL_SKILLED != TOTAL_MINORITY){
swal ( 'Note:','Total  EMPLOYEES should be equal to TOTAL SKILLED EMPLOYEES','error');
 return (false);
}
if (TOTAL_SKILLED != TOTAL_GENDER){
swal ( 'Note:','Total of Male/Female/Transgender EMPLOYEES should be equal to TOTAL SKILLED EMPLOYEES','error');
 return (false);
}

if(AVERAGE_WAGES_PAID==""){
 swal ( 'Note:','Please enter AVERAGE_WAGES_PAID','error');	
 return (false);
}

if(ROI_LOAN==""){
 swal ( 'Note:','Please enter ROI_LOAN','error');	
 return (false);
}
if(TDR_AMOUNT==""){
 swal ( 'Note:','Please enter TDR_AMOUNT','error');	
 return (false);
}
if(TDR_NUMBER==""){
 swal ( 'Note:','Please enter TDR_NUMBER','error');	
 return (false);
}

if(PER_CAPITA_INVESTMENT_NORM_SAT==""){
 swal ( 'Note:','Please enter PER_CAPITA_INVESTMENT_NORM_SAT','error');	
 return (false);
}
if(PROMINENT_SIGN_BOARD_INSTALLED==""){
 swal ( 'Note:','Please enter PROMINENT_SIGN_BOARD_INSTALLED','error');	
 return (false);
}
}

if(SEMI_FIN_RM_STOCK !=""){
 if(!numberOnly.test(SEMI_FIN_RM_STOCK)) {
 swal ( 'Note:','SEMI_FIN_RM_STOCK should be in number','error');	
 return (false);
 }
}
if(RAW_MATERIAL_STOCK_VALUE !=""){
  if(!numberOnly.test(RAW_MATERIAL_STOCK_VALUE)) {
 swal ( 'Note:','RAW_MATERIAL_STOCK_VALUE should be in number','error');	
 return (false);
 }
}
if(FINISHED_RAW_MATERIAL_STOCK !=""){
  if(!numberOnly.test(FINISHED_RAW_MATERIAL_STOCK)) {
 swal ( 'Note:','FINISHED_RAW_MATERIAL_STOCK should be in number','error');	
 return (false);
 }
}


if(CAPITAL_COST_OF_MACHINERY !=""){
 if(!numberOnly.test(CAPITAL_COST_OF_MACHINERY)) {
 swal ( 'Note:','CAPITAL_COST_OF_MACHINERY should be in number','error');	
 return (false);
 }
}
/*
if(MARGIN_MONEY_ADJUSTMENT_AMOUNT !=""){
 if(!numberOnly.test(MARGIN_MONEY_ADJUSTMENT_AMOUNT)) {
 swal ( 'Note:','MARGIN_MONEY_ADJUSTMENT_AMOUNT should be in number','error');	
 return (false);
 }
} */
if(VALUE_OF_COLLATERAL_SECURITY !=""){
 if(!numberOnly.test(VALUE_OF_COLLATERAL_SECURITY)) {
 swal ( 'Note:','VALUE_OF_COLLATERAL_SECURITY should be in number','error');	
 return (false);
 } 
 }
 if(PRESENT_PRODUCTION_VALUE !=""){
 if(!numberOnly.test(PRESENT_PRODUCTION_VALUE)) {
 swal ( 'Note:','PRESENT_PRODUCTION_VALUE should be in number','error');	
 return (false);
 } 
 }
 if(TDR_AMOUNT !=""){
 if(!numberOnly.test(TDR_AMOUNT)) {
 swal ( 'Note:','TDR_AMOUNT should be in number','error');	
 return (false);
 }
 }
if(EXPORT_VALUE !=""){
  if(!numberOnly.test(EXPORT_VALUE)) {
 swal ( 'Note:','EXPORT_VALUE should be in number','error');	
 return (false);
 }
 }
 if(ANNUAL_PRODUCTION_VALUE !=""){
 if(!numberOnly.test(ANNUAL_PRODUCTION_VALUE)) {
 swal ( 'Note:','ANNUAL_PRODUCTION_VALUE should be in number','error');	
 return (false);
 }} 
 
 if(PRESENT_SALES_VALUE !=""){
 if(!numberOnly.test(PRESENT_SALES_VALUE)) {
 swal ( 'Note:','PRESENT_SALES_VALUE should be in number','error');	
 return (false);
 }
}
if(NPA_PERIOD !=""){
 if(!numberOnly.test(NPA_PERIOD)) {
 swal ( 'Note:','NPA_PERIOD should be in number','error');	
 return (false);
 } 
 }
 if(ROI_LOAN !=""){
 if(!numberOnly.test(ROI_LOAN)) {
 swal ( 'Note:','ROI_LOAN should be in number','error');	
 return (false);
 }
 }

 if(AVERAGE_WAGES_PAID !=""){
 if(!numberOnly.test(AVERAGE_WAGES_PAID)) {
 swal ( 'Note:','AVERAGE_WAGES_PAID should be in number','error');	
 return (false);
 }
 }
 


document.form.ins.value='I';
document.form.submit();
}