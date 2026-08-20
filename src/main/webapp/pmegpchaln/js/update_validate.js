function form_submit(){
  var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
  var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
  var messageRegex = new RegExp(/<\/?\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)\/?>/gim);
  var numberOnly=/^[0-9 \.-]+$/;

  
var OFF_TYPE_CD = document.form.OFF_TYPE_CD.value; 
var DISTRICT_CD = document.form.DISTRICT_CD.value; 
var OFF_ADDR1 = document.form.OFF_ADDR1.value; 
var OFF_ADDR2 = document.form.OFF_ADDR2.value; 
var CITY = document.form.CITY .value; 
var PINCODE = document.form.PINCODE.value; 
var OFF_TEL_NO = document.form.OFF_TEL_NO.value; 
var OFF_FAX_NO = document.form.OFF_FAX_NO.value; 
var OFF_EMAIL_ADDR = document.form.OFF_EMAIL_ADDR .value; 
var OFF_NAME = document.form.OFF_NAME.value; 
var OFF_LONG_DESC = document.form.OFF_LONG_DESC.value; 
var CONT_PER1 = document.form.CONT_PER1.value; 
var PER1_NO = document.form.PER1_NO .value;
var PER1_EMAIL = document.form.PER1_EMAIL.value;

if(OFF_TYPE_CD == "") {
    inlineMsg('OFF_TYPE_CD','You must select EDP Center Type',2);
    return false;
}
if(OFF_NAME == "") {
    inlineMsg('OFF_NAME','You must enter a OFFICE NAME',2);
    return false;
}
 if(OFF_LONG_DESC == "") {
    inlineMsg('OFF_LONG_DESC','You must enter a OFFICE LONG NAME',2);
    return false;
}

 if(OFF_ADDR1 == "") {
    inlineMsg('OFF_ADDR1','You must enter a OFFICE ADDRESS',2);
    return false;
}
if(CITY == "") {
    inlineMsg('CITY','You must enter a CITY',2);
    return false;
	}
if (!nameRegex.test(CITY)) {
	inlineMsg ( 'CITY','InValid CITY name',2);	
	return (false);
	}
 if(DISTRICT_CD == "") {
    inlineMsg('DISTRICT_CD','You must select a DISTRICT_CD',2);
    return false;
    }
 if(PINCODE == "") {
    inlineMsg('PINCODE','You must enter a PINCODE',2);
    return false;
	}
else if (!numberOnly.test(PINCODE)) {
	inlineMsg ( 'PINCODE','InValid Pin code',2);	
	return (false);
	}	
 if(PINCODE.length !=6) { 
    inlineMsg('PINCODE','Enter 6 digit Pin Code',2);
    return false;
    }
else if(OFF_TEL_NO == "") {
    inlineMsg('OFF_TEL_NO','You must enter a OFF_TEL_NO',2);
    return false;
    }
 if (!numberOnly.test(OFF_TEL_NO)) {
	inlineMsg ( 'OFF_TEL_NO','InValid TELEPHONE NO',2);	
	return (false);
	}
 if(OFF_EMAIL_ADDR == "") {
    inlineMsg('OFF_EMAIL_ADDR','You must enter an email address',2);
    return false;
    }
 if (!emailRegex.test(OFF_EMAIL_ADDR)) {
	inlineMsg ( 'OFF_EMAIL_ADDR','InValid EMAIL ADDRESS',2);	
	return (false);
	}

	
 if(CONT_PER1 == "") {
    inlineMsg('CONT_PER1','You must enter CONTACT PERSON NAME',2);
    return false;
    }	
 if(PER1_NO == "") {
    inlineMsg('PER1_NO','You must enter CONTACT DETAILS',2);
    return false;
    }
if (!numberOnly.test(PER1_NO)) {
	inlineMsg ( 'PER1_NO','InValid TELEPHONE NO',2);	
	return (false);
	}
 if(PER1_EMAIL == "") {
    inlineMsg('PER1_EMAIL','You must enter an email address',2);
    return false;
    }

	document.form.ins.value='I'; 
	document.form.submit();


}

