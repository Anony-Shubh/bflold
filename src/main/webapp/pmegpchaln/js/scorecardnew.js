function submitform() {

var NO_DEPENDENCIES = document.form.NO_DEPENDENCIES.value;
var OWN_HOUSE = document.form.OWN_HOUSE.value;
var RESIDING_SAME_ADD = document.form.RESIDING_SAME_ADD.value;
var EXPERIENCE = document.form.EXPERIENCE.value;
var ANY_O_SOI = document.form.ANY_O_SOI.value;
var ASSESED_IT = document.form.ASSESED_IT.value;
var LI_POLICY = document.form.LI_POLICY.value;
var CREDIT_HISTORY = document.form.CREDIT_HISTORY.value;
var LOCATION_ADV = document.form.LOCATION_ADV.value;
var SKILL_CERTIFICATION = document.form.SKILL_CERTIFICATION.value;
var MARKETING_TU = document.form.MARKETING_TU.value;
var REG_GOV_AUTH = document.form.REG_GOV_AUTH.value;
var REPAY_PER = document.form.REPAY_PER.value;
var AVG_DSCR = document.form.AVG_DSCR.value;
var COLLATERAL_SEC_COV = document.form.COLLATERAL_SEC_COV.value;
var COVERED_UNDER = document.form.COVERED_UNDER.value;
var RL_LENDING_BANK_MARK = document.form.RL_LENDING_BANK_MARK.value;
var RELATION_W_LEND_BANK = document.form.RELATION_W_LEND_BANK.value;
var ONLINE_SUBDT = document.form.ONLINE_SUBDT.value;

//var TOTAL_SCORE = document.form.TOTAL_SCORE.value;


//var red = document.form.red.value;
//var blue = document.form.blue.value;
//var COLLATERAL_SEC_COV = document.form.COLLATERAL_SEC_COV.value;
//var APP_AGREE_YN = document.form.APP_AGREE_YN.value;
var checkbox = document.form.checkbox.value;


if(NO_DEPENDENCIES==""){
 swal ( 'Note:','Please Enter No. of dependencies.','error');	
 return (false);
}
if(OWN_HOUSE==""){
 swal ( 'Note:','Please Enter Owning a house/parental house.','error');	
 return (false);
}
if(RESIDING_SAME_ADD==""){
 swal ( 'Note:','Please Enter Residing at the same address.','error');	
 return (false);
}
if(EXPERIENCE==""){
 swal ( 'Note:','Please Enter Experience in the line of trade.','error');	
 return (false);
}
if(ANY_O_SOI==""){
 swal ( 'Note:','Please Enter Any other source of income including family.','error');	
 return (false);
}
if(ASSESED_IT==""){
 swal ( 'Note:','Please Enter Assessed for Income Tax.','error');	
 return (false);
}
if(LI_POLICY==""){
 swal ( 'Note:','Please Enter Having Life Insurance policy.','error');	
 return (false);
}
if((RELATION_W_LEND_BANK=="")&&(RL_LENDING_BANK_MARK=="")){
 swal ( 'Note:','Please Enter Relationship with lending bank.','error');	
 return (false);
}
if(CREDIT_HISTORY==""){
 swal ( 'Note:','Please Enter Credit History.','error');	
 return (false);
}
if(LOCATION_ADV==""){
 swal ( 'Note:','Please Enter Location Advantage.','error');	
 return (false);
}
if(SKILL_CERTIFICATION==""){
 swal ( 'Note:','Please Enter Skill Certification.','error');	
 return (false);
}
if(MARKETING_TU==""){
 swal ( 'Note:','Please Enter Marketing Tie ups for sale of products.','error');	
 return (false);
}
if(REG_GOV_AUTH==""){
 swal ( 'Note:','Please Enter Registered with Govt. Authorities.','error');	
 return (false);
}
if(REPAY_PER==""){
 swal ( 'Note:','Please Enter Repayment Period.','error');	
 return (false);
}
if(AVG_DSCR==""){
 swal ( 'Note:','Please Enter Avg DSCR.','error');	
 return (false);
}
if((COLLATERAL_SEC_COV=="")&&(COVERED_UNDER=="")){
 swal ( 'Note:','Choose Collateral Security Option.','error');	
 return (false);
}


/*

if(!TOTAL_SCORE>60){
 swal ( 'Note:','Score should be greater than 60.','error');	
 return (false);
}


if(COLLATERAL_SEC_COV==""){
 swal ( 'Note:','Choose Collateral Security Option.','error');	
 return (false);
}

if(APP_AGREE_YN==""){
 swal ( 'Note:','Please Agree to the Terms and Conditions.','error');	
 return (false);
}
*/

if(!this.form.checkbox.checked)
{
swal ( 'Note:','Please Agree to the Terms and Conditions','error');	
return (false);
}	

document.form.ins.value='I';
document.form.submit();
}
/*
function enableTxtBox1()
        {
            if (document.getElementById("radio1").checked)
            {
                document.getElementById("RELATION_W_LEND_BANK").disabled = true;

            }

}
function abcenableTxtBox1()
        {
            if (document.getElementById("radio2").checked)
            {
                document.getElementById("RELATION_W_LEND_BANK").disabled = false;

            }


}

       function enableclr()
        {
           // document.getElementById("COLLATERAL_SEC_COV").disabled = !document.getElementById("blue").checked;


            document.getElementById("COLLATERAL_SEC_COV").disabled = document.getElementById("red").checked;
			 document.getElementById("COLLATERAL_SEC_COV2").disabled = document.getElementById("red").checked;
			  document.getElementById("COLLATERAL_SEC_COV3").disabled = document.getElementById("red").checked;
			  
			   document.getElementById("COVERED_UNDER").disabled = document.getElementById("blue").checked;
			  

        }*/
		
		function enableTxtBox1()
        {
            if (document.getElementById("radio1").checked)
            {
                document.getElementById("RELATION_W_LEND_BANK").disabled = true;
				 document.getElementById("RELATION_W_LEND_BANK").value = '';

            }

}
function abcenableTxtBox1()
        {
            if (document.getElementById("radio2").checked)
            {
                document.getElementById("RELATION_W_LEND_BANK").disabled = false;

            }

}

       function enableclr()
        {
           // document.getElementById("COLLATERAL_SEC_COV").disabled = !document.getElementById("blue").checked;


            document.getElementById("COLLATERAL_SEC_COV").disabled = document.getElementById("red").checked;
			 document.getElementById("COLLATERAL_SEC_COV2").disabled = document.getElementById("red").checked;
			  document.getElementById("COLLATERAL_SEC_COV3").disabled = document.getElementById("red").checked;
			  
			  document.getElementById("COLLATERAL_SEC_COV").checked = false;
			 document.getElementById("COLLATERAL_SEC_COV2").checked = false;
			  document.getElementById("COLLATERAL_SEC_COV3").checked = false;
			  
			   document.getElementById("COVERED_UNDER").disabled = document.getElementById("blue").checked;
			  document.getElementById("COVERED_UNDER").checked = false;
			  
			  
			   if (document.getElementById("red").checked)
            {
               document.getElementById("COVERED_UNDER").checked = true;

            }
			  

        }
		
		
		
		
function days(){
//var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;
var RELATION_W_LEND_BANK = document.form.RELATION_W_LEND_BANK.value;

var ONLINE_SUBDT = document.form.ONLINE_SUBDT.value;

var today = new Date();


	

//if (BNF_AFROMDT == "") {
//			 inlineMsg('BNF_AFROMDT',"Please select From Date.",2);
//            return (false);
//			}
			
	

var startDate = Date.parse(RELATION_W_LEND_BANK);
var endDate = Date.parse(ONLINE_SUBDT );			
	
	if(startDate > endDate )
	{
 swal ( 'Note:','Invalid Date.','error');	
 document.getElementById("RELATION_W_LEND_BANK").value = '';
            return (false);	
	}		
			
           // var timeDiff = endDate - startDate;
           // daysDiff = Math.floor((timeDiff / (1000 * 60 * 60 * 24))+1);
			//alert(timeDiff);
           // document.form.BNF_ATOURDYS.value=Number(daysDiff);
}		
		