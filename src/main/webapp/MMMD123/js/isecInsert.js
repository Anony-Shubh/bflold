
function formIsec_submit() {
var ISEC_NO = document.form.ISEC_NO.value;  
var ISEC_DT = document.form.ISEC_DT.value; 
var LOAN_AMT = document.form. LOAN_AMT.value; 
var LOAN_PURPOSE = document.form.LOAN_PURPOSE.value; 
var ISEC_ISSUEDBY= document.form.ISEC_ISSUEDBY.value; 
var BID = document.form.BID.value; 
var PER_ID = document.form.PER_ID.value; 
var INT_RATE = document.form.INT_RATE.value; 
var INT_AMT = document.form.INT_AMT.value; 
var ISEC_AMT = document.form.ISEC_AMT.value; 
var BANK_ADV_NO = document.form.BANK_ADV_NO.value; 
var BANK_ADV_DT = document.form.BANK_ADV_DT.value; 
var INST_SUBMIT_DT = document.form.INST_SUBMIT_DT.value; 
var SO_ADMIT_DT = document.form.SO_ADMIT_DT.value; 
var SO_ADMIT_AMT = document.form.SO_ADMIT_AMT.value; 
var SO_REMARKS = document.form.SO_REMARKS.value; 
var SO_FORD_DT = document.form.SO_FORD_DT.value; 
var FILEUPLOAD_NM = document.form.FILEUPLOAD_NM.value; 

   var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
  var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
  var messageRegex = new RegExp(/<\/?\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)\/?>/gim);
  var numberOnly=/^[0-9]*$/;
  
  if(ISEC_NO == "") {
    inlineMsg('ISEC_NO','You must enter ISEC NUMBER',2);
    return false;
  }
 
    if(ISEC_DT== "") {
    inlineMsg('ISEC_DT','You must enter ISEC DATE in DD-MON-YYYY',2);
    return false;
  }
 if(LOAN_AMT== "") {
    inlineMsg('LOAN_AMT','Enter LOAN AMOUNT',2);
    return false;
  }
  if(!numberOnly.test(LOAN_AMT))
    {
	    inlineMsg('LOAN_AMT','Enter AMOUNT in numbers ONLY',2);
        return false;
    }
 
  
   if(BID == "") {
    inlineMsg('BID','Select Bank Account Details',2);
    return false;
  }
   if(PER_ID == "") {
    inlineMsg('PER_ID','Select Period',2);
    return false;
  }

 
  if(ISEC_AMT== "") {
    inlineMsg('ISEC_AMT','You must enter ISEC AMOUNT',2);
    return false;
  }
   if(!numberOnly.test(ISEC_AMT))
    {
	    inlineMsg('ISEC_AMT','Enter ISEC AMOUNT in numbers ONLY',2);
        return false;
    }
 
 
 document.form.ins.value='I';
document.form.submit();


  }