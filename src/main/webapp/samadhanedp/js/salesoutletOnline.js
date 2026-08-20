function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<48||unicode>57) //if not a number
return false //disable key press
}
}
function form_submit(){
//var MKT_SAL_ID = form.MKT_SAL_ID.value;
var SALES_OUT_NAME = form.SALES_OUT_NAME.value;
var SALES_TYPE = form.SALES_TYPE.value;
var SALES_ADDR1 = form.SALES_ADDR1.value;
var SALES_CITY = form.SALES_CITY.value;
var SALES_PIN = form.SALES_PIN.value;
var SALES_DIST_CD = form.SALES_DIST_CD.value;
var SALES_TELNO = form.SALES_TELNO.value;
var SALES_EMAL = form.SALES_EMAL.value;
var SALES_CONTNM = form.SALES_CONTNM.value;
var ACTIVE_YN = form.ACTIVE_YN.value;
var SALES_OUT_TYPE = form.SALES_OUT_TYPE.value;
var AVG_ANNUAL_SALES = form.AVG_ANNUAL_SALES.value;
var SALES_OUT_AREA = form.SALES_OUT_AREA.value;
var SALES_NOFLOR = form.SALES_NOFLOR.value;
var CR_YN = form.CR_YN.value;
var COMP_YN = form.COMP_YN.value;
var MOD_YN = form.MOD_YN.value;
var AC_YN = form.AC_YN.value;
var REMARK = form.REMARK.value;

//if (PROF_STATE_CD== "") {	 inlineMsg ( 'PROF_STATE_CD','State Must be Selected',2);	return (false);}
//if (LEG_STAT_ID== "") {	 inlineMsg ( 'LEG_STAT_ID','Legal status of Instiute Must be Entered',2);	return (false);}
if (SALES_OUT_NAME== "") {	 inlineMsg ( 'SALES_OUT_NAME','Name of Sales Outlet Must be Entered',2);	return (false);}
if (SALES_ADDR1== "") {	 inlineMsg ( 'SALES_ADDR1','Address Must be Entered',2);	return (false);}
if (SALES_CITY== "") {	 inlineMsg ( 'SALES_CITY','City Must be Entered',2);	return (false);}
if (SALES_PIN== "") {	 inlineMsg ( 'SALES_PIN','Pincode Must be Entered',2);	return (false);}
if (SALES_DIST_CD== "") {	 inlineMsg ( 'SALES_DIST_CD','District Name Must be Entered',2);	return(false);}
if (SALES_CONTNM== "") {	 inlineMsg ( 'SALES_CONTNM','Contact Person Name Must be Entered',2);	return (false);}
if (SALES_OUT_TYPE== "") { inlineMsg ( 'SALES_OUT_TYPE','Type of Saleoutlet Must be Entered',2);	return (false);}
if (AVG_ANNUAL_SALES== "") { inlineMsg ( 'AVG_ANNUAL_SALES','Annual sales Must be Entered',2);	return (false);}



document.form.ins.value='I';
document.form.submit();

}