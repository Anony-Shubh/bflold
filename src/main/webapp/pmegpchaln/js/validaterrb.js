function form_submit(){
 var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
  var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/; 
  var numberOnly = /^[0-9 \.-]+$/;
   ifsvalidreg=/^[A-Z|a-z]{4}[0][\d]{6}$/;


var IFSC_CODE = document.form.IFSC_CODE.value; 
//var MICR_CODE = document.form.MICR_CODE.value; 
//var IFSC_ID = document.form.IFSC_ID.value; 
var NEFT_IFSC = document.form.NEFT_IFSC.value;
var BANK_NAME = document.form.BANK_NAME.value; 
var ADDRESS = document.form.ADDRESS.value;
var BRANCHNAME = document.form.BRANCHNAME .value; 
var EMAIL = document.form.EMAIL.value; 
var STATE = document.form.STATE.value; 
var DISTRICT_NAME = document.form.DISTRICT_NAME.value; 
var BANK_PINCD = document.form.BANK_PINCD .value; 
var TEL_NO = document.form.TEL_NO.value; 
var FAX_NO = document.form.FAX_NO.value; 
var EMAIL = document.form.EMAIL.value; 
//var CONT_NAME = document.form.CONT_NAME .value; 
//var MOBNO = document.form.MOBNO.value; 
//var  DESIGN = document.form. DESIGN.value; 


if(IFSC_CODE != "") {
	
if (IFSC_CODE.length !=11) {
inlineMsg ('IFSC_CODE' ,"Length of IFS Code is 11 digit and Charters.");
return (false);
}

}

/*if(NEFT_IFSC != "") {	
if (NEFT_IFSC.length !=11) {
inlineMsg ('NEFT_IFSC' ,"Length of IFS Code is 11 digit and Charters.");
return (false);
}

if (!ifsvalidreg.test(NEFT_IFSC)) {
	inlineMsg('NEFT_IFSC' ,"In Correct IFS Code first 4  Charcter, 5th Place is Zero and last 6 may be number or charcter ( Total 11 digit/Charter)");
return (false);

}
}*/
if(BANK_NAME == "") {
    inlineMsg('BANK_NAME','You must enter a BANK NAME',2);
    return false;
}
if (!nameRegex.test(BANK_NAME)) {
inlineMsg('BANK_NAME' ,'Please Enter Correct Bank Name');
return (false);
}

if(ADDRESS == "") {
    inlineMsg('ADDRESS','You must ENTER BRANCH ADDRESS',2);
    return false;
    }

 if(BRANCHNAME == "") {
    inlineMsg('BRANCHNAME','You must ENTER BRANCH NAME',2);
    return false;
    }

if(STATE == "") {
    inlineMsg('STATE','You must select a STATE',2);
    return false;
	}
	
if(DISTRICT_NAME == "") {
    inlineMsg('DISTRICT_NAME','You must ENTER DISTRICT NAME',2);
    return false;
    }
if(BANK_PINCD == "") {
    inlineMsg('BANK_PINCD','You must ENTER BANK PINCODE',2);
    return false;
    }
if (!numberOnly.test( BANK_PINCD)) {
	inlineMsg ( 'BANK_PINCD','InValid Pin code',2);	
	return (false);
	}	
if(BANK_PINCD.length !=6) { 
    inlineMsg('BANK_PINCD','Enter 6 digit Pin Code',2);
    return false;
    }
if(TEL_NO != "") {
    
if (!numberOnly.test(TEL_NO)) {
	inlineMsg ('TEL_NO','Invalid Telephone No',2);	
	return (false);
	}
}
if(EMAIL == "") {
    inlineMsg('EMAIL','You must Enter an Email Id',2);
    return false;
    }
if (!emailRegex.test(EMAIL)) {
	inlineMsg ('EMAIL','Invalid EMAIL ID',2);	
	return (false);
    }
if(FAX_NO != "") {
    if (!numberOnly.test(FAX_NO)) {
	inlineMsg ('FAX_NO','Invalid FAX_NO',2);	
	return (false);
    }
	
}

document.form.ins.value='I'; 
document.form.submit();
}

