
function submit_form() {	
	 var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
	var EDP_FR_DT= form.EDP_FR_DT.value;
	var EDP_TO_DT= form.EDP_TO_DT.value;	
	var EDP_CERT_DT= form.EDP_CERT_DT.value;
	var uploadfile= form.uploadfile.value;
	var EDP_TRG_NAME= form.EDP_TRG_NAME.value;
	
	var EDPTODT = new Date( EDP_TO_DT );
	var EDPFRDT = new Date( EDP_FR_DT );
	var EDPCERTDT= new Date( EDP_CERT_DT );
    var today = new Date();
	if (EDP_TRG_NAME== "") {inlineMsg ('EDP_TRG_NAME1','Select EDP Training Center',2);	return (false);}
	if (EDP_FR_DT== "") {inlineMsg ('EDP_FR_DT','Enter Training Date',2);	return (false);}
	 if (EDP_FR_DT != "") {
	if  (!dtRegex.test(EDP_FR_DT)){
	inlineMsg('EDP_FR_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
	 }
	
	if (EDPFRDT > today)    {inlineMsg ( 'EDP_FR_DT','You Cannot Enter A Future Date!',2);	return (false);}
	if (EDP_TO_DT== "") {inlineMsg ('EDP_TO_DT','Enter Training Date',2);	return (false);}
	 if (EDP_TO_DT != "") {
	if  (!dtRegex.test(EDP_TO_DT)){
	inlineMsg('EDP_TO_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
	 }
	if (EDPTODT > today)    {inlineMsg ( 'EDP_TO_DT','You Cannot Enter A Future Date!',2);	return (false);}
	if (EDPTODT < EDPFRDT){inlineMsg ('EDP_TO_DT','Enter Valid To Training Date',2);	return (false);}
	if (EDP_CERT_DT== "") {inlineMsg ('EDP_CERT_DT','Enter Certificate Issued Date',2);	return (false);}
	 if (EDP_CERT_DT != "") {
	if  (!dtRegex.test(EDP_CERT_DT)){
	inlineMsg('EDP_CERT_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
	}
  }
	if (EDPCERTDT > today) {inlineMsg ('EDP_CERT_DT','You Cannot Enter Future Certificate Issued Date',2);	return (false);}
	//if (EDPCERTDT > EDPFRDT) {inlineMsg ('EDP_CERT_DT','Enter valid Certificate Issued Date',2);	return (false);}
	//if (EDPCERTDT > EDPTODT) {inlineMsg ('EDP_CERT_DT','Enter valid Certificate Issued Date',2);	return (false);}

	if (uploadfile== "") {inlineMsg ('uploadfile','Upload EDP Certificate',2);	return (false);}
	
	
	document.form.ins.value='I';
	document.form.submit();
	

}
var _validFileExtensions = [".jpg", ".jpeg", ".pdf"];    
function ValidateSingleInput(oInput) {
    if (oInput.type == "file") {
        var sFileName = oInput.value;
         if (sFileName.length > 0) {
            var blnValid = false;
            for (var j = 0; j < _validFileExtensions.length; j++) {
                var sCurExtension = _validFileExtensions[j];
                if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                    blnValid = true;
                    break;
                }
            }
             
            if (!blnValid) {
				inlineMsg ( 'uploadfile','Invalid File Extension .Upload File With Extension jpeg OR jpeg OR pdf',2);
               // alert("SORRY, " + sFileName + " IS INVALID, ALLOWED EXTENSIONS ARE: " + _validFileExtensions.join(", "));
                oInput.value = "";
                return false;
            }
        }
    }
    return true;
}