function loan_calc(){
var mc=document.form1.MACHINARY_COST.value;
var ws=document.form1.WORKING_CAPITAL.value;
var tce=Number(ws)+Number(mc);
document.form1.TOT_SANC.value= Number(tce);
}

function loan_sanc(){
var mc=document.form1.CE_SANC_FB.value;
var ws=document.form1.WC_SANC_FB.value;
var tce=Number(ws)+Number(mc);
document.form1.TOT_SANC_FB.value= Number(tce);
}

function GetSelectedItem() {
chosen = ""
len = document.form1.ACT_ID.length
for (i = 0; i <len; i++) {
if (document.form1.ACT_ID[i].checked) {
chosen = document.form1.ACT_ID[i].value
}
}
return chosen;
}


function Status_change(){
var y = document.getElementById("btnREJL");
//i=document.form1.ACT_ID.selectedIndex; 
vst=GetSelectedItem();
//alert (vst);
//document.form1.ACT_ID.options[i].value;
var flag='N';
 if (vst=='0'||vst=='8'){
		f_disable();
        document.form1.BANK_REMARKS.style.backgroundColor='white';
		document.form1.BANK_REMARKS.disabled=false;	
		document.form1.REJ_DESC.disabled = true;
document.form1.REJ_ID.disabled = true;	
document.form1.REJ_DESC.style.backgroundColor='#C0C0C0'; 
document.form1.REJ_ID.style.backgroundColor='#C0C0C0'; 	
   y.style.display = "none"; 
          
 
		
	  }
	  else if (vst==3){
		f_disable();
        document.form1.BANK_REMARKS.style.backgroundColor='white';
		document.form1.BANK_REMARKS.disabled=false;
		document.form1.REJ_DESC.disabled = false;
document.form1.REJ_DESC.style.backgroundColor='white';
document.form1.REJ_ID.disabled = false;
document.form1.REJ_ID.style.backgroundColor='white';
		   
            y.style.display = "block";
 
	  }
	  
	  else if	(vst==11){
		 f_enable();
		 		document.form1.REJ_DESC.disabled = true;
				document.form1.REJ_ID.disabled = true;
document.form1.REJ_DESC.style.backgroundColor='#C0C0C0'; 
document.form1.REJ_ID.style.backgroundColor='#C0C0C0';  
		
            y.style.display = "none";
		 }else if	(vst==8){
		 f_disable();
		
            y.style.display = "none";
		 document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
		document.form1.BANK_REMARKS.disabled=true;
				document.form1.REJ_DESC.disabled = true;
				document.form1.REJ_ID.disabled = true;
document.form1.REJ_DESC.style.backgroundColor='#C0C0C0'; 
document.form1.REJ_ID.style.backgroundColor='#C0C0C0';
	
		
		}else{
		f_enable();
		
            y.style.display = "none";
		document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
		document.form1.BANK_REMARKS.disabled=true;
		document.form1.REJ_DESC.disabled = true;		
document.form1.REJ_ID.disabled = true;		
document.form1.REJ_DESC.style.backgroundColor='#C0C0C0';  
document.form1.REJ_ID.style.backgroundColor='#C0C0C0';
		}
	}

/*
      if (vst==3||vst=='0'||vst=='8'){
		f_disable();
        document.form1.BANK_REMARKS.style.backgroundColor='white';
		document.form1.BANK_REMARKS.disabled=false;
	  }else if	(vst==11){
		 f_enable();
		 }else if	(vst==8){
		 f_disable();
		 document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
		document.form1.BANK_REMARKS.disabled=true;
		}else{
		f_enable();
		document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
		document.form1.BANK_REMARKS.disabled=true;
		}
	}*/
	function  f_disable(){
//document.form1.BANK_REMARKS.disabled = true;
//document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.LOAN_SANC_DT.disabled = true;
document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.WORKSHED_COST.disabled = true;
document.form1.WORKING_CAPITAL.disabled = true;
document.form1.MACHINARY_COST.disabled = true;
document.form1.PRE_OPE_COST.disabled = true;
document.form1.OWN_CONTRIBUTION.disabled = true;
document.form1.OWN_CONT_DT.disabled = true;
document.form1.IST_LOAN_AMT.disabled = true;
document.form1.IST_LOAN_DT.disabled = true;
document.form1.CGTSI.disabled = true;
//document.form1.MM_CLAIM_LRNO.disabled = true;
document.form1.MM_CLAIM_DT.disabled = true;
document.form1.MM_CLAIM_AMT.disabled = true;
document.form1.PROD.disabled = true;
document.form1.MM_REL_DT.disabled = true;
document.form1.MM_REL_AMT.disabled = true;
document.form1.EMP.disabled = true;
document.form1.SALES.disabled = true;
document.form1.MM_ADJ_AMT.disabled = true;
document.form1.MM_ADJ_DT.disabled = true;
//document.form1.TOT_CE.disabled = true;
document.form1.TOT_SANC.disabled = true;


document.form1.RINT.disabled = true;
document.form1.LOAN_PERIOD.disabled = true;
document.form1.LOAN_REMARKS.disabled = true;
document.form1.APPLOAN_ACCNO.disabled = true;
document.form1.FB_ACNO.disabled = true;
document.form1.FB_ACNAME.disabled = true;
document.form1.TDR_ACNO.disabled = true;
document.form1.TDR_ADJ_DT.disabled = true;
document.form1.MOR_PER.disabled = true;

document.form1.CE_SANC_FB.disabled = true;
document.form1.WC_SANC_FB.disabled = true;
document.form1.TOT_SANC_FB.disabled = true;


//CHANGE THE COLOUR

document.form1.LOAN_SANC_DT.style.backgroundColor='#C0C0C0';
document.form1.WORKSHED_COST.style.backgroundColor='#C0C0C0';
document.form1.WORKING_CAPITAL.style.backgroundColor='#C0C0C0';
document.form1.MACHINARY_COST.style.backgroundColor='#C0C0C0';
document.form1.PRE_OPE_COST.style.backgroundColor='#C0C0C0';
document.form1.OWN_CONTRIBUTION.style.backgroundColor='#C0C0C0';
document.form1.OWN_CONT_DT.style.backgroundColor='#C0C0C0';
document.form1.IST_LOAN_AMT.style.backgroundColor='#C0C0C0';
document.form1.IST_LOAN_DT.style.backgroundColor='#C0C0C0';
document.form1.CGTSI.style.backgroundColor='#C0C0C0';
//document.form1.MM_CLAIM_LRNO.style.backgroundColor='#C0C0C0';
document.form1.MM_CLAIM_DT.style.backgroundColor='#C0C0C0';
document.form1.MM_CLAIM_AMT.style.backgroundColor='#C0C0C0';
document.form1.PROD.style.backgroundColor='#C0C0C0';
document.form1.MM_REL_DT.style.backgroundColor='#C0C0C0';
document.form1.MM_REL_AMT.style.backgroundColor='#C0C0C0';
document.form1.EMP.style.backgroundColor='#C0C0C0';
document.form1.SALES.style.backgroundColor='#C0C0C0';
document.form1.MM_ADJ_AMT.style.backgroundColor='#C0C0C0';
document.form1.MM_ADJ_DT.style.backgroundColor='#C0C0C0';
//document.form1.TOT_CE.style.backgroundColor='#C0C0C0';
document.form1.TOT_SANC.style.backgroundColor='#C0C0C0';

document.form1.RINT.style.backgroundColor='#C0C0C0';
document.form1.LOAN_PERIOD.style.backgroundColor='#C0C0C0';
document.form1.LOAN_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.APPLOAN_ACCNO.style.backgroundColor='#C0C0C0';
document.form1.FB_ACNO.style.backgroundColor='#C0C0C0';
document.form1.FB_ACNAME.style.backgroundColor='#C0C0C0';
document.form1.TDR_ACNO.style.backgroundColor='#C0C0C0';
document.form1.TDR_ADJ_DT.style.backgroundColor='#C0C0C0';
document.form1.MOR_PER.style.backgroundColor='#C0C0C0';

document.form1.CE_SANC_FB.style.backgroundColor='#C0C0C0';
document.form1.WC_SANC_FB.style.backgroundColor='#C0C0C0';
document.form1.TOT_SANC_FB.style.backgroundColor='#C0C0C0';


		}
		
		function  f_enable(){

document.form1.LOAN_SANC_DT.disabled = false;
document.form1.WORKSHED_COST.disabled = false;
document.form1.WORKING_CAPITAL.disabled = false;
document.form1.MACHINARY_COST.disabled = false;
document.form1.PRE_OPE_COST.disabled = false;
document.form1.OWN_CONTRIBUTION.disabled = false;
document.form1.OWN_CONT_DT.disabled = false;
document.form1.IST_LOAN_AMT.disabled = false;
document.form1.IST_LOAN_DT.disabled = false;
document.form1.CGTSI.disabled = false;
//document.form1.MM_CLAIM_LRNO.disabled = false;
document.form1.MM_CLAIM_DT.disabled = false;
document.form1.MM_CLAIM_AMT.disabled = false;
document.form1.PROD.disabled = false;
document.form1.MM_REL_DT.disabled = false;
document.form1.MM_REL_AMT.disabled = false;
document.form1.EMP.disabled = false;
document.form1.SALES.disabled = false;
document.form1.MM_ADJ_AMT.disabled = false;
document.form1.MM_ADJ_DT.disabled = false;
//document.form1.TOT_CE.disabled = false;
document.form1.TOT_SANC.disabled = false;


document.form1.RINT.disabled = false;
document.form1.LOAN_PERIOD.disabled = false;
document.form1.LOAN_REMARKS.disabled = false;
document.form1.APPLOAN_ACCNO.disabled = false;
document.form1.FB_ACNO.disabled = false;
document.form1.FB_ACNAME.disabled = false;
document.form1.TDR_ACNO.disabled = false;
document.form1.TDR_ADJ_DT.disabled = false;
document.form1.MOR_PER.disabled = false;

document.form1.CE_SANC_FB.disabled = false;
document.form1.WC_SANC_FB.disabled = false;
document.form1.TOT_SANC_FB.disabled = false;

//background color
document.form1.LOAN_SANC_DT.style.backgroundColor='White';
document.form1.WORKSHED_COST.style.backgroundColor='White';
document.form1.WORKING_CAPITAL.style.backgroundColor='White';
document.form1.MACHINARY_COST.style.backgroundColor='White';
document.form1.PRE_OPE_COST.style.backgroundColor='White';
document.form1.OWN_CONTRIBUTION.style.backgroundColor='White';
document.form1.OWN_CONT_DT.style.backgroundColor='White';
document.form1.IST_LOAN_AMT.style.backgroundColor='White';
document.form1.IST_LOAN_DT.style.backgroundColor='White';
document.form1.CGTSI.style.backgroundColor='White';
//document.form1.MM_CLAIM_LRNO.style.backgroundColor='White';
document.form1.MM_CLAIM_DT.style.backgroundColor='White';
document.form1.MM_CLAIM_AMT.style.backgroundColor='White';
document.form1.PROD.style.backgroundColor='White';
document.form1.MM_REL_DT.style.backgroundColor='White';
document.form1.MM_REL_AMT.style.backgroundColor='White';
document.form1.EMP.style.backgroundColor='White';
document.form1.SALES.style.backgroundColor='White';
document.form1.MM_ADJ_AMT.style.backgroundColor='White';
document.form1.MM_ADJ_DT.style.backgroundColor='White';
document.form1.TOT_CE.style.backgroundColor='White';
document.form1.TOT_SANC.style.backgroundColor='White';


document.form1.RINT.style.backgroundColor='White';
document.form1.LOAN_PERIOD.style.backgroundColor='White';
document.form1.LOAN_REMARKS.style.backgroundColor='White';
document.form1.APPLOAN_ACCNO.style.backgroundColor='White';
document.form1.FB_ACNO.style.backgroundColor='White';
document.form1.FB_ACNAME.style.backgroundColor='White';
document.form1.TDR_ACNO.style.backgroundColor='White';
document.form1.TDR_ADJ_DT.style.backgroundColor='White';
document.form1.MOR_PER.style.backgroundColor='White';

document.form1.CE_SANC_FB.style.backgroundColor='White';
document.form1.WC_SANC_FB.style.backgroundColor='White';
document.form1.TOT_SANC_FB.style.backgroundColor='White';

		}



function openSancReport(pAppid) {
document.form1.ins.value='I';
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=LetterHeadOfBank';
 window.open(url);
 
}

function round(value, exp) {
  if (typeof exp === 'undefined' || +exp === 0)
    return Math.round(value);

  value = +value;
  exp  = +exp;

  if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0))
    return NaN;

  // Shift
  value = value.toString().split('e');
  value = Math.round(+(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp)));

  // Shift back
  value = value.toString().split('e');
  return +(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp));
}

function openMM(pAppid) {
	var ACT_ID= document.form1.ACT_ID.value;
	var IST_LOAN_DT= document.form1.IST_LOAN_DT.value;
	var MM_CLAIM_AMT= document.form1.MM_CLAIM_AMT.value;
		var EDP_CERT_DT= document.form1.EDP_CERT_DT.value;
		var OWN_CONT_DT= document.form1.OWN_CONT_DT.value;
 var LOAN_SANC_DT = document.form1.LOAN_SANC_DT.value;
 var FB_ACNO=document.form1.FB_ACNO.value;
 var MM_ELIG_PER=document.form1.MM_ELIG_PER.value;
 var TOT_SANC=document.form1.TOT_SANC.value;
  var IST_LOAN_AMT= Number(document.form1.IST_LOAN_AMT.value);
    var TOT_SANC= Number(document.form1.TOT_SANC.value);
	var STATE_CD=document.form1.STATE_CD.value;
  var vstatex = ['AR', 'AS', 'MN', 'MG','SK','TR','NG','MZ'];
  var mmmelig=document.form1.DMMELGB.value;
   var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');

		if (Number(ACT_ID) <10) {
			 inlineMsg('btnClaim',"<strong>To Claim Govt.Subsidy(MM) </strong><br>Details of Sanction,<br>Own Contribution Deposit,<br>Loan Release<br>Must be updated as per PMEGP Scheme Guidelines",10);
            return (false);
			}
			
			if (LOAN_SANC_DT==null) {
			 inlineMsg('LOAN_SANC_DT',"Incomplete Loan Sanction Detail incomplete",2);
            return (false);
			}
			
if (OWN_CONT_DT=="") {
	 inlineMsg('OWN_CONT_DT',"Please Enter Beneficiary Contribution Details ",2);
	return (false);
	}
	
	 if (OWN_CONT_DT != "") {
	if  (!dtRegex.test(OWN_CONT_DT)){
	inlineMsg('OWN_CONT_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
	 }
	
	

	if (IST_LOAN_DT=="") {
		 inlineMsg('IST_LOAN_DT',"Please Enter Loan Realease Datail......",3);
	return (false);
	}
	
	 if (IST_LOAN_DT != "") {
	if  (!dtRegex.test(IST_LOAN_DT)){
	inlineMsg('IST_LOAN_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
	 }
	
	
	//EDP TRAINNG RELAXED..............
	
	//if (vstatex.indexOf(STATE_CD) <0) {
	/*
	if (EDP_CERT_DT=="") {
		inlineMsg('EDP_CERT_DT',"Please Enter EDP Detail.....",2);
	return (false);
	} 
	*/
	
	 if (EDP_CERT_DT != "") {
	if  (!dtRegex.test(EDP_CERT_DT)){
	inlineMsg('EDP_CERT_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
	 }
	 
	 if (IST_LOAN_AMT=="") {
		 inlineMsg('IST_LOAN_AMT',"Please Enter Loan Amount......",3);
	return (false);
	}
	
	 if (IST_LOAN_AMT != "") {
	 if (IST_LOAN_AMT<mmmelig) {
	inlineMsg('IST_LOAN_AMT',"Loan Release Amount is less than Govt. Subsidy Eligible Amount of Rs."+mmmelig,5);
     return (false);
	  }
	 }
	
	
	//}//end
	
	if (MM_CLAIM_AMT=="") {
		 inlineMsg('MM_CLAIM_AMT',"Please Enter Margin Money (Govt. Subsidy) Claim Amount.",2);
	
	return (false);
	}
	
	
	
		
	
	if (FB_ACNO=="") {
		 inlineMsg('FB_ACNO',"Please Select Transient Ac.No. from list. Incase ac. No. Not Showing in List, Please Send email with Details of IFS Code,Ac No and Branch Name to <br> <bold> pmegpeportal.kvic@gov.in </bold> for One time registration",15);
	return (false);
	}
	
	if (MM_CLAIM_AMT != mmmelig){
		inlineMsg('MM_CLAIM_AMT',"Margin Money --(Govt. Subsidy) Should be Rs."+mmmelig+" As per Admitted Project Cost of Rs.",5);
		 return (false);
		}
	//+TOT_SANC
	
	document.form1.ins.value='I';
	document.form1.MMCLAIM.value='Y';
    form1.submit();
	
}

function insUpdate(){
document.form1.ins.value='I';
form1.submit();
}//end

