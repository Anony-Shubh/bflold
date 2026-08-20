function insUpdate(){
document.form1.ins.value='I';
var alert_msg="";

var vTotSanc=document.form1.TOT_SANC.value;
var vRelAmt=document.form1.IST_LOAN_AMT.value;
var vProjCost=document.form1.PROJ_COST.value;
var vOwnContPer=document.form1.OWN_CONT_PER.value;
var vmmEligPer=document.form1.MM_ELIG_PER.value;
var vOwnContAmt=document.form1.OWN_CONTRIBUTION.value;
var vOwnContElg= Math.round(Number(vTotSanc)*Number(vOwnContPer)/100);
var vmmClaimAmt=document.form1.MM_CLAIM_AMT.value;
var vmmRelAmt=document.form1.MM_REL_AMT.value;
var vmmAdjAmt=document.form1.MM_ADJ_AMT.value;
var vmmElig=Math.round(Number(vProjCost)*Number(vmmEligPer)/100);
var vrecdt=document.form1.BANK_REC_DT.value;
var vactid=document.form1.ACT_ID.value;


if (vrecdt==''){
	alert ("Please Enter Application Receive Date");
	document.form1.BANK_REC_DT.focus();
	return (false);
	
} else if (vactid=='0'||vactid=='') {
	alert('Please Select Status.....');
	document.form1.ACT_ID.focus();
	return (false);
}else if (Number(vRelAmt)>Number(vTotSanc)){
alert_msg='Loan Release Amount Exceeded to Sanctioned Amount';
} else if (Number(vTotSanc)>2500000){
alert_msg='Loan Sanction Amount Should not Exceed 25 lakhs';
}else if (Number(vTotSanc)>Number(vProjCost)){
alert_msg='Loan Sanction Amount Should Not Exceed than Project Cost';
}else if ((Number(vOwnContAmt)<Number(vOwnContElg))&&(Number(vOwnContAmt)>0)){
alert_msg='Own Contribution Deposit should not less then </br>'+vOwnContPer+'% of Loan Sanctioned Amount i.e. Rs.'+vOwnContElg;
}else if (Number(vmmClaimAmt)>Number(vmmElig)){
alert_msg='Govt. Subsidy(MM) should not exceed then </br>'+vmmEligPer+'% i.e. Rs.'+vmmElig;
}else if (Number(vmmClaimAmt)<Number(vmmRelAmt)){
alert_msg='Govt. Subsidy(MM) Receive Amount Should not Exceed than Claimed Amount';
}else if (Number(vmmRelAmt)<Number(vmmAdjAmt)){
alert_msg='Govt. Subsidy(MM) Final Adjustment Amount </br> Should not Exceed than Received Amount';
}
var r=check_todayDt();

if (!r){return(false);}
if(alert_msg==''){
		document.form1.submit();
		}else{
		jConfirm(alert_msg,'Do you Want to Save Record anyway...?',function(r){if (r){document.form1.ins.value='I';document.form1.submit();}});
	}
	//return(true);
}//end function




function loan_calc(){
var ws=document.form1.WORKSHED_COST.value;
var mc=document.form1.MACHINARY_COST.value;
var poc=document.form1.PRE_OPE_COST.value;
var tce=Number(ws)+Number(mc)+Number(poc);
document.form1.TOT_CE.value=tce;
var wc=document.form1.WORKING_CAPITAL.value;
document.form1.TOT_SANC.value= Number(tce) + Number(wc);
}

function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<48||unicode>57) //if not a number
return false //disable key press
}
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
//i=document.form1.ACT_ID.selectedIndex; 
vst=GetSelectedItem();
//alert (vst);
//document.form1.ACT_ID.options[i].value;
var flag='N';

      if (vst==3||vst==''){
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
	}
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
document.form1.TOT_CE.disabled = true;
document.form1.TOT_SANC.disabled = true;


document.form1.RINT.disabled = true;
document.form1.LOAN_PERIOD.disabled = true;
document.form1.LOAN_REMARKS.disabled = true;
document.form1.APPLOAN_ACCNO.disabled = true;
document.form1.FB_ACNO.disabled = true;
document.form1.FB_ACNAME.disabled = true;
document.form1.TDR_ACNO.disabled = true;
document.form1.TDR_ADJ_DT.disabled = true;




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
document.form1.TOT_CE.style.backgroundColor='#C0C0C0';
document.form1.TOT_SANC.style.backgroundColor='#C0C0C0';

document.form1.RINT.style.backgroundColor='#C0C0C0';
document.form1.LOAN_PERIOD.style.backgroundColor='#C0C0C0';
document.form1.LOAN_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.APPLOAN_ACCNO.style.backgroundColor='#C0C0C0';
document.form1.FB_ACNO.style.backgroundColor='#C0C0C0';
document.form1.FB_ACNAME.style.backgroundColor='#C0C0C0';
document.form1.TDR_ACNO.style.backgroundColor='#C0C0C0';
document.form1.TDR_ADJ_DT.style.backgroundColor='#C0C0C0';



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
document.form1.TOT_CE.disabled = false;
document.form1.TOT_SANC.disabled = false;


document.form1.RINT.disabled = false;
document.form1.LOAN_PERIOD.disabled = false;
document.form1.LOAN_REMARKS.disabled = false;
document.form1.APPLOAN_ACCNO.disabled = false;
document.form1.FB_ACNO.disabled = false;
document.form1.FB_ACNAME.disabled = false;
document.form1.TDR_ACNO.disabled = false;
document.form1.TDR_ADJ_DT.disabled = false;



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
document.form1.MM_CLAIM_LRNO.style.backgroundColor='White';
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


document.form1.RINT.style.backgroundColor='White'
document.form1.LOAN_PERIOD.style.backgroundColor='White'
document.form1.LOAN_REMARKS.style.backgroundColor='White'
document.form1.APPLOAN_ACCNO.style.backgroundColor='White'
document.form1.FB_ACNO.style.backgroundColor='White'
document.form1.FB_ACNAME.style.backgroundColor='White'
document.form1.TDR_ACNO.style.backgroundColor='White'
document.form1.TDR_ADJ_DT.style.backgroundColor='White'





		}
		
function getDateObject(dateString,dateSeperator)
{
var curValue=dateString;
var sepChar=dateSeperator;
var curPos=0;
var cDate,cMonth,cYear;
//extract day portion
curPos=dateString.indexOf(sepChar);
cDate=dateString.substring(0,curPos);
//extract month portion 
endPos=dateString.indexOf(sepChar,curPos+1); 
cMonth=dateString.substring(curPos+1,endPos);
cMonth=cMonth.toUpperCase();
if (cMonth=="JAN"){cMonth="01";}
if (cMonth=="FEB"){cMonth="02";}
if (cMonth=="MAR"){cMonth="03";}
if (cMonth=="APR"){cMonth="04";}
if (cMonth=="MAY"){cMonth="05";}
if (cMonth=="JUN"){cMonth="06";}
if (cMonth=="JUL"){cMonth="07";}
if (cMonth=="AUG"){cMonth="08";}
if (cMonth=="SEP"){cMonth="09";}
if (cMonth=="OCT"){cMonth="10";}
if (cMonth=="NOV"){cMonth="11";}
if (cMonth=="DEC"){cMonth="12";}

//extract year portion 
curPos=endPos;
endPos=curPos+5; 
cYear=curValue.substring(curPos+1,endPos);

//Create Date Object
dtObject=new Date(cYear,cMonth,cDate); 
return dtObject;
}

function dtComp(startDt,endDt){
	//dtComp(document.form1.startDate.value,document.form1.endDate.value)
var startDate = getDateObject(startDt,"-");
var endDate = getDateObject(endDt,"-");
if(startDate < endDate){
return true;
}else{
return false;
}
}
function  check_todayDt(){
	var vtodayDt=document.form1.TODAYDT.value;
	msg="";
	var vPMEGPsd='01-APR-2008';
	var vsubMsg=" Date should between </BR> PMEGP Scheme Start Date: "+vPMEGPsd+" </BR> and  today Date:"+vtodayDt;
	var sd="";
	//check bank receive date
	var vDt=document.form1.BANK_REC_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Receive '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.BANK_REC_DT.focus();
    return(false);
	//return false;
	}
	}//vdt
	
	//check bank sanction date
	var vDt=document.form1.LOAN_SANC_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Sanction '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.LOAN_SANC_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	//checkOwn Contribution Deposit date
	var vDt=document.form1.OWN_CONT_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Own Contribution Deposit '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.OWN_CONT_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	//
	
	//1st Loan Relaese date
	var vDt=document.form1.IST_LOAN_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Loan Release '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.IST_LOAN_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	//1st Claim  date
	var vDt=document.form1.MM_CLAIM_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Govt Subsidy(MM) Claim </br> '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.MM_CLAIM_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	// MM Relaese date
	var vDt=document.form1.MM_REL_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Govt Subsidy(MM) Receive</br> '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.MM_REL_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	//1st MM final adjustment date
	var vDt=document.form1.MM_ADJ_DT.value;
	if (!vDt==''){
	sd=dtComp(vtodayDt,vDt);
	pd=dtComp(vPMEGPsd,vDt);
	if ((sd)||(!pd)){
	msg='Govt Subsidy(MM) Adjustment</br> '+ vsubMsg ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.MM_ADJ_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	
//comparision between receive date and sanction date-----------------------------------------
var vDt2=document.form1.BANK_REC_DT.value;
var vDt1=document.form1.LOAN_SANC_DT.value;
	if ( !vDt2=='' && !vDt1==''){
	sd=dtComp(vDt1,vDt2);
	if (sd){
	msg='Loan Sanction Date Should not  less than </br> Application Receive Date ' ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.BANK_REC_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	//comparision between sanction date and Own Contribution Deposit Date
var vDt2=document.form1.LOAN_SANC_DT.value;
var vDt1=document.form1.OWN_CONT_DT.value;

	if ( !vDt2=='' && !vDt1==''){
	sd=dtComp(vDt1,vDt2);
	if (sd){
	msg=' Own Contribution Date Should not </br>less than  Loan Sanction Date' ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.OWN_CONT_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	
	//comparision between sanction date and Own Contribution Deposit Date
var vDt2=document.form1.OWN_CONT_DT.value;
var vDt1=document.form1.IST_LOAN_DT.value;


	if ( !vDt2=='' && !vDt1==''){
	sd=dtComp(vDt1,vDt2);
	if (sd){
	msg=' Loan Release Date Should not less </br>than  Own Contribution Deposit Date' ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.IST_LOAN_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	//comparision between sanction date and Own Contribution Deposit Date
	var vDt2=document.form1.IST_LOAN_DT.value;
	var vDt1=document.form1.MM_CLAIM_DT.value;
    
	if ( !vDt2=='' && !vDt1==''){
	sd=dtComp(vDt1,vDt2);
	if (sd){
	msg=' Govt. Subsidy(MM) Claim Date Should not  </br> less than  Loan Release Date' ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.MM_CLAIM_AMT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	//comparision between sanction date and Own Contribution Deposit Date
	var vDt1=document.form1.MM_REL_DT.value;
	var vDt2=document.form1.MM_CLAIM_DT.value;
    
	if ( !vDt2=='' && !vDt1==''){
	sd=dtComp(vDt1,vDt2);
	if (sd){
	msg=' Govt. Subsidy(MM) Receive Date Should not  </br> less than  Govt. Subsidy(MM) Claim Date' ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.MM_REL_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	var vDt2=document.form1.MM_REL_DT.value;
	var vDt1=document.form1.MM_ADJ_DT.value;
    
	if ( !vDt2=='' && !vDt1==''){
	sd=dtComp(vDt1,vDt2);
	if (sd){
	msg=' Govt. Subsidy(MM) Final Adjustment Date Should not  </br> less than Govt. Subsidy(MM) Receive Date' ;
	jAlert(msg,'Record Could Not Save for:');
	document.form1.MM_REL_DT.focus();
    return(false);
	//return false;
	}
	}//vdate
	
	return (true);
}
	

 

