function submitform() {
var PH_KVIC= document.form.PH_KVIC.value;
var FIN_KVIC= document.form.FIN_KVIC.value;
var PH_KVIB= document.form.PH_KVIB.value;
var FIN_KVIB= document.form.FIN_KVIB.value;
var PH_DIC= document.form.PH_DIC.value;
var FIN_DIC= document.form.FIN_DIC.value;
var BNF_PLACE = document.form.BNF_PLACE.value;
var ADD_RMRK = document.form.ADD_RMRK.value;
var TR_DATE = document.form.TR_DATE.value;



if(TR_DATE == "")
{	inlineMsg('TR_DATE','Enter Transaction Date!',2);
    return false;
}

if(BNF_PLACE == "")
{	inlineMsg('BNF_PLACE','Enter Venue',2);
    return false;
}

if(PH_KVIC == "" && FIN_KVIC=="" && PH_KVIB=="" && FIN_KVIB=="" && PH_DIC=="" && FIN_DIC==""){
inlineMsg('PH_KVIC',"Enter atleast one field",2);	
return(false);
}
if (!PH_KVIC == "" || !PH_KVIC == 0) 
{		if (FIN_KVIC==""||FIN_KVIC==0){
inlineMsg('FIN_KVIC',"Finacial amount must be entered.",2);		
return (false);
}
}

if (!FIN_KVIC=="" || !FIN_KVIC==0 ) {
	if (PH_KVIC=="" || PH_KVIC==0){
inlineMsg('PH_KVIC',"Physical No must be entered.",2);			
return (false);
}
}


if (!PH_KVIB == "" || !PH_KVIB == 0) 
{		if (FIN_KVIB==""||FIN_KVIB==0){
inlineMsg('FIN_KVIB',"Finacial amount must be entered.",2);		
return (false);
}
}

if (!FIN_KVIB=="" || !FIN_KVIB==0 ) {
	if (PH_KVIB=="" || PH_KVIB==0){
inlineMsg('PH_KVIB',"Physical No must be entered.",2);			
return (false);
}
}


if (!PH_DIC == "" || !PH_DIC == 0) 
{		if (FIN_DIC==""||FIN_DIC==0){
inlineMsg('FIN_DIC',"Finacial amount must be entered.",2);		
return (false);
}
}

if (!FIN_DIC=="" || !FIN_DIC==0 ) {
	if (PH_DIC=="" || PH_DIC==0){
inlineMsg('PH_DIC',"Physical No must be entered.",2);			
return (false);
}
}

document.form.ins.value='I';
document.form.submit();
}

function calculate_phytotal() {
var PH_KVIC= document.form.PH_KVIC.value;
var PH_KVIB= document.form.PH_KVIB.value;
var PH_DIC= document.form.PH_DIC.value;

var phytotal =Number(PH_KVIC)+Number(PH_KVIB)+Number(PH_DIC);

document.form.PH_TOTAL.value=phytotal;
}

function calculate_amttotal() {
var FIN_KVIC= document.form.FIN_KVIC.value;
var FIN_KVIB= document.form.FIN_KVIB.value;
var FIN_DIC= document.form.FIN_DIC.value;

var amttotal =Number(FIN_KVIC)+Number(FIN_KVIB)+Number(FIN_DIC);

document.form.FIN_TOTAL.value=amttotal;
}

function onlyAlphabets(e, t) {
            try {
                if (window.event) {
                    var BNF_PLACE = window.event.keyCode;
                }
               else if (e) {
                    var BNF_PLACE = e.which;
                }
                else { return true; }
                if ((BNF_PLACE > 64 && BNF_PLACE < 91) || (BNF_PLACE > 96 && BNF_PLACE < 123))
                    return true;
                else
                    return false;
            }
            catch (err) {
                alert(err.Description);
            }
        }	

 function isNumberNoDec(evt)
      {
         var PH_KVIC = (evt.which) ? evt.which : event.keyCode
		 var PH_KVIB = (evt.which) ? evt.which : event.keyCode
		 var PH_DIC = (evt.which) ? evt.which : event.keyCode
		 if (PH_KVIC > 31 && (PH_KVIC < 48 || PH_KVIC > 57))
		 if (PH_KVIB > 31 && (PH_KVIB < 48 || PH_KVIB > 57))
		 if (PH_DIC > 31 && (PH_DIC < 48 || PH_DIC > 57))
		 return false;
         return true;
      }		
 function isNumber(evt) {
   var FIN_KVIC = (evt.which) ? evt.which : evt.keyCode
		var FIN_KVIB = (evt.which) ? evt.which : evt.keyCode
		var FIN_DIC = (evt.which) ? evt.which : evt.keyCode
		if (FIN_KVIC != 46 && FIN_KVIC > 31 && (FIN_KVIC < 48 || FIN_KVIC > 57))
		if (FIN_KVIB != 46 && FIN_KVIB > 31 && (FIN_KVIB < 48 || FIN_KVIB > 57))
		if (FIN_DIC != 46 && FIN_DIC > 31 && (FIN_DIC < 48 || FIN_DIC > 57))
        return false;
        return true;
    }    
	
	
