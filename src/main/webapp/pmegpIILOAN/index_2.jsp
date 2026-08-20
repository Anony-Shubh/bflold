<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SECOND lOAN</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script language="javascript" src="../js/popcalendarN.js"></script>
  <script language="javascript" src="../js/jquery-1.12.4.js"></script>  
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery-customselect.js"></script>
<script type="text/javascript" src="../js/Pmegpsecondloan.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/autolist.css" />
<script type="text/javascript">
function Popup(url, title, w, h) {
// Fixes dual-screen position Most browsers Firefox
var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

var left = ((width / 2) - (w / 2)) + dualScreenLeft;
var top = ((height / 2) - (h / 2)) + dualScreenTop;
var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

// Puts focus on the newWindow
if (window.focus) {
newWindow.focus();
}
}
</script>






<script language="javascript" >

			
var xmlHttp   					//index
      var xmlHttp 
      function index(){ 
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('INDEX').innerHTML = '';
	   //openModal();
	 
	 
      var url="pmegponline.jsp"; 
      url +="?app_id=0";
	 
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
	 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	  //closeModal();  
	   var x=document.getElementById('INDEX');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }//m

 




 var xmlHttp   					//MUDRADETAILS
      var xmlHttp 
      function mudra(str1,PAN_NO,STATE,UAD,DISTRICT,app_id){ 
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('MUDRA').innerHTML = '';
	   //openModal();
	 
	  
      var url="mudraDetails.jsp"; 
       url +="?state="+STATE+"&aadhar="+str1+"&pan="+PAN_NO+"&appid="+app_id+"&UAD="+UAD+"&dis="+DISTRICT;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null);
	  
	  //alert("hello");
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 // closeModal();  
	
	   var x=document.getElementById('MUDRA');
	   
	   x.innerHTML=xmlHttp.responseText;
	   //alert(str);
	     
	
	 
      } //statechane1 function end 
  
      }//main function end.


	  	 
 
var xmlHttp   							//sanction details
      var xmlHttp 
      function sanction(str1,PAN_NO,STATE,UAD,DISTRICT){ 	
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('SANCTION').innerHTML = '';
	   //openModal();
	 //str = document.getElementById("APP_ID").value;
	 //alert(APP_ID);
	
	  
	 appid=document.getElementById("APP_ID").value;
	 
      var url="sanctionDetails.jsp"; 
      url +="?state="+STATE+"&aadhar="+str1+"&pan="+PAN_NO+"&appid="+appid+"&UAD="+UAD+"&dis="+DISTRICT;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
	 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	  //closeModal();  
	   var x=document.getElementById('SANCTION');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }
	  
	  
	  
	  
	//APPLICATION FORM


var xmlHttp   							//sanction details
      var xmlHttp 
      function pmegp(SESSION_ID) { 	
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('PMEGPONLINE').innerHTML = '';
	   //openModal();
	 //str = document.getElementById("APP_ID").value;
	 //alert(APP_ID);
	
	  
	 
	 
      var url="pmegponline1.jsp"; 
       url +="?SESSION_ID="+SESSION_ID;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
	 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	  //closeModal();  
	   var x=document.getElementById('PMEGPONLINE');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }	
	  
	  
	 var xmlHttp   							//UPLOAD
      var xmlHttp 
      function upload(){ 	
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('UPLOAD').innerHTML = '';
	   //openModal();
	 //str = document.getElementById("APP_ID").value;
	 //alert(APP_ID);
	
	  
	 
	 
      var url="upload_app_doc.jsp"; 
      url +="?app_id=0";
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
	 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	  //closeModal();  
	   var x=document.getElementById('UPLOAD');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }	 
	  
	  
	var xmlHttp   					//final submit
      var xmlHttp 
      function final_submit(){ 
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('FINAL').innerHTML = '';
	   //openModal();
	 
	  //appid=document.getElementById("APP_ID").value;
      var url="SecondapplicantFormValidation.jsp"; 
        url +="?app_id=0";
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null);
	  
	  //alert("hello");
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 // closeModal();  
	
	   var x=document.getElementById('FINAL');
	   
	   x.innerHTML=xmlHttp.responseText;
	   //alert(str);
	     
	
	 
      } //statechane1 function end 
  
      }//main function end.
  
	  
	  
	  //edit application
	  var xmlHttp   					
      var xmlHttp 
      function edit_app(appid){ 
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('EDIT').innerHTML = '';
	   //openModal();
	 
	  appid=document.getElementById("APP_ID").value;
      var url="editpmegpapplication.jsp"; 
        url +="?app_id="+appid;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null);
	  
	  //alert("hello");
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 // closeModal();  
	
	   var x=document.getElementById('EDIT');
	   
	   x.innerHTML=xmlHttp.responseText;
	   //alert(str);
	     
	
	 
      } //statechane1 function end 
  
      }//main function end.
  
	  
	  
	  
	  
	   
	  
	  //edit application
	  var xmlHttp   					
      var xmlHttp 
      function validate(){ 
	  try
    {
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 document.getElementById('VALID').innerHTML = '';
	   //openModal();
	 
	  appid=document.getElementById("APP_ID").value;
      var url="SecondapplicantFormValidation.jsp"; 
        url +="?app_id="+appid;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null);
	  
	  //alert("hello");
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 // closeModal();  
	
	   var x=document.getElementById('VALID');
	   
	   x.innerHTML=xmlHttp.responseText;
	   //alert(str);
	     
	
	 
      } //statechane1 function end 
  
      }//main function end.
   
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	    function getDistrict(val) {
	$.ajax({
	type: "GET",
	url: "district.jsp",
	data:'STATE='+val,
	success: function(data){
		$("#DISTRICT").html(data);
	}
	});
}
	
			</script>

<script>
function show(){
var SCHEME_NM=document.form.SCHEME_NM.value;

    if (SCHEME_NM == "PMEGP"){
 	 PMEGP.style.display = "block"; 
	}
	else {
		PMEGP.style.display = "none"; 
	}
 if (SCHEME_NM == "MUDRA"){
	 // alert(SCHEME_NM);
 	 text.style.display = "block"; 
	}
  else{
	   text.style.display = "none"; 
  }

}	
 
 
 
 
 function check(){
 var UPDATE=document.form.UPDATE.value;
  var APP_ID=document.form.APP.value;
 //alert(APP_ID);
 var SESSION_ID=document.form.SESSION_ID.value;
 //var SCHEME_NM=document.form.SCHEME.value;
	
 if (UPDATE==3)
 {   document.getElementById("REC").style.backgroundColor  = "RED";
	 
	pmegp(SESSION_ID); 
	document.getElementById("CON").style.backgroundColor  = "GREEN";
	
	  	 	}
 
 
 
 
 if (UPDATE == 4)
 {  
	 document.getElementById("REC").style.backgroundColor  = "RED";
	  document.getElementById("CON").style.backgroundColor  = "RED";
	  upload(); 
	  document.getElementById("CAL").style.backgroundColor  = "GREEN";
	 	}
		
		if (UPDATE == 5)
 {  	
      document.getElementById("REC").style.backgroundColor  = "RED";
	  document.getElementById("CON").style.backgroundColor  = "RED";
	  document.getElementById("CAL").style.backgroundColor  = "RED";
	edit_app(APP_ID);		
	document.getElementById("FS").style.backgroundColor  = "GREEN";
 
 
 }
	
			if (UPDATE == 10)
 {  	
      document.getElementById("REC").style.backgroundColor  = "RED";
	  document.getElementById("CON").style.backgroundColor  = "RED";
	  document.getElementById("CAL").style.backgroundColor  = "RED";	
    upload(); 
	  
	document.getElementById("FS").style.backgroundColor  = "GREEN";
 
 
 }
	
	
	
 
 }
 
 
function getfrequenttab (n){	
var currentTab =document.getElementById('FLAG').value;
//alert(currentTab);
if (n == 1){
	
 document.getElementById("CHR").style.backgroundColor  = "RED";
 index();
}

if (n == 2){
//alert(n);
document.getElementById("CHR").style.backgroundColor  = "RED";

var SCHEME_NM=document.form.SCHEME_NM.value;
var STATE=document.form.STATE.value;	
	  str1=document.getElementById("AADHAR_NO").value;
	  STATE=document.getElementById("STATE").value;
      PAN_NO=document.getElementById("PAN_NO").value; 
	  UAD=document.getElementById("UAD").value; 
	  DISTRICT=document.getElementById("DISTRICT").value; 
	  app_id=document.getElementById("APP_ID").value; 

  if (SCHEME_NM == ""){
	inlineMsg('SCHEME_NM','Please select SCHEME_NM',2);
return false;	
  }
  
    if (SCHEME_NM == "PMEGP"){		 
	
	 var vstatex = ['AR', 'AS', 'MN', 'MG','SK','TR','NG','MZ','JK'];
	   if (STATE == "-1"){ 		  
			inlineMsg('STATE','Please select State',2);
			return false;	   
		 
	 }
	 if (vstatex.indexOf(STATE) <0) {
  
		  if(str1 == "") {
			inlineMsg('AADHAR_NO','You must enter your Aadhaar Card No.',2);
			return false;
		  } 
		
			
  
			  if(str1.length !=12) {
				inlineMsg('AADHAR_NO','Enter 12 digit Aadhaar No...',2);
				return false;
			  }
 		
		}
	
	if (vstatex.indexOf(STATE) >-1) {
		
		if (str1 == "" && PAN_NO == "") {
			inlineMsg('AADHAR_NO','Valid Aadhaar Card  No OR Pan Card No Must be Entered...',2);
			return false;
			}
	

		
  
			  if(str1.length !=12&&str1 !="") {
				inlineMsg('AADHAR_NO','Enter 12 digit Aadhaar No...',2);
				return false;
			  }
		  
		  if(PAN_NO.length !=10 && PAN_NO != "") {
			inlineMsg('PAN_NO','Invalid PAN CARD NO, Length Must be 10 alphanumberic',2);
			return false;
		  }	
	}	
	
	
	 if(DISTRICT == "-1") {
			inlineMsg('DISTRICT','Please select District',2);
			return false;
		  }	
	 if(UAD == "") {
			inlineMsg('UAD','Please enter Udyog Aadhar No',2);
			return false;
		  }	
	
	
	sanction(str1,PAN_NO,STATE,UAD,DISTRICT);	
	document.getElementById("REC").style.backgroundColor  = "GREEN";
	}
	
	
	else {
		
			  //str1=document.getElementById("AADHAR_NO").value;
	 // STATE=document.getElementById("STATE").value;
      //PAN_NO=document.getElementById("PAN_NO").value; 
	   // UAD=document.getElementById("UAD").value; 
		// DISTRICT=document.getElementById("DISTRICT_CD").value; 
	  if(STATE == "-1") {
			inlineMsg('STATE','Select State.',2);
			return false;
		  } 
	 if(str1 == "") {
			inlineMsg('AADHAR_NO','You must enter your Aadhaar Card No.',2);
			return false;
		  } 
		  
		   if(PAN_NO == "") {
			inlineMsg('PAN_NO','You must enter your PAN Card No.',2);
			return false;
		  } 
	  
	   if(DISTRICT == "-1") {
			inlineMsg('DISTRICT','Please select District',2);
			return false;
		  }	
	 if(UAD == "") {
			inlineMsg('UAD','Please enter Udyog Aadhar No',2);
			return false;
		  }	
	  
	mudra(str1,PAN_NO,STATE,UAD,DISTRICT,app_id);	
	document.getElementById("REC").style.backgroundColor  = "GREEN";	
}
 
}
if (n == 3){
	 document.getElementById("REC").style.backgroundColor  = "GREEN";
	var SCHEME_NM=document.form.SCHEME.value;
	if (SCHEME_NM == 'PMEGP')
	
	{
	var UNIT_NM=document.form.UNIT_NM.value;	
	var GSTN_NO=document.form.GSTN_NO.value;	
	var REPAY_DT=document.form.REPAY_DT.value;	
	var REPAY_AMT=document.form.REPAY_AMT.value;	
	
	 if(UNIT_NM == "") {
			inlineMsg('UNIT_NM','Please enter unit name.',2);
			return false;
		  } 
		  
		   if(GSTN_NO == "") {
			inlineMsg('GSTN_NO','Please enter gstn no.',2);
			return false;
		  } 
	
	
	 if(REPAY_DT == "") {
			inlineMsg('REPAY_DT','You must select Loan Repayment Date.',2);
			return false;
		  } 
		  
		   if(REPAY_AMT == "") {
			inlineMsg('REPAY_AMT','You must enter Loan Repayment Amt',2);
			return false;
		  } 
	
	 document.getElementById("ins").value  = "3";
	 var TEST=document.form.ins.value;
	 //alert(TEST);
	 document.form.ins.value=TEST;
     document.form.submit();
	 document.getElementById("REC").style.backgroundColor  = "RED";
	}
	else{
		
	var APP_ID=document.form.APP_ID.value;	
	var UAD=document.form.UAD.value;	
	var APP_NAME=document.form.APP_NAME.value;	
	var STATE=document.form.STATE.value;	
	
	
	var MOB_NO1=document.form.MOB_NO1.value;	
	var AADHAR_NO=document.form.AADHAR_NO.value;	
	var PAN_NO=document.form.PAN_NO.value;	
	var E_MAIL=document.form.E_MAIL.value;	
	
	
	
	var UNIT_NM=document.form.UNIT_NM.value;	
	var GSTN_NO=document.form.GSTN_NO.value;	
	var ESTB_YR=document.form.ESTB_YR.value;	
	var UNIT_LOC=document.form.UNIT_LOC.value;	
	
	
	var UNIT_POST_ADDR=document.form.UNIT_POST_ADDR.value;	
	var UNIT_TALUK_BLOCK=document.form.UNIT_TALUK_BLOCK.value;	
	var DISTRICT=document.form.DISTRICT.value;	
	var UNIT_PIN=document.form.UNIT_PIN.value;	
	
	
		
	var IND_TYPE=document.form.IND_TYPE.value;	
	var ACTIVITY_CD=document.form.ACTIVITY_CD.value;	
	var IFSC_CODE=document.form.IFSC_CODE.value;	
	var IST_LOAN_DT=document.form.IST_LOAN_DT.value;	
	
	
			
	var CE_SANC_FB=document.form.CE_SANC_FB.value;	
	var EMP_ENV=document.form.EMP_ENV.value;	
	var REPAY_DT=document.form.REPAY_DT.value;	
	var REPAY_AMT=document.form.REPAY_AMT.value;
	
	
	
	 if(APP_ID == "") {
			inlineMsg('APP_ID','Please enter Applicant ID.',2);
			return false;
		  } 
		  
		   if(UAD == "") {
			inlineMsg('UAD','Please enter Udyog Aadhar Registration No.',2);
			return false;
		  } 
	
	
	 if(APP_NAME == "") {
			inlineMsg('APP_NAME','You must Applicant Name',2);
			return false;
		  } 
		  
		   if(STATE == "") {
			inlineMsg('STATE','Please select State Name',2);
			return false;
		  } 	
		
		
		  
		   if(MOB_NO1 == "") {
			inlineMsg('MOB_NO1','Please Enter Mobile No',2);
			return false;
		  } 	
		  
		  
		  
		   if(AADHAR_NO == "") {
			inlineMsg('AADHAR_NO','Please Enter Aadhar no',2);
			return false;
		  } 
		  
		  
		     if(PAN_NO == "") {
			inlineMsg('PAN_NO','Please Enter Pan No',2);
			return false;
		  } 	
		  
		   if(E_MAIL == "") {
			inlineMsg('E_MAIL','Please Enter Email id',2);
			return false;
		  } 
		  
		  
		  
		       if(UNIT_NM == "") {
			inlineMsg('UNIT_NM','Please Enter Unit Name',2);
			return false;
		  } 	
		  
		   if(GSTN_NO == "") {
			inlineMsg('GSTN_NO','Please Enter GSTN NO',2);
			return false;
		  }     

		  if(ESTB_YR == "") {
			inlineMsg('ESTB_YR','Please Enter Establishment Year',2);
			return false;
		  } 	
		  
		   if(UNIT_LOC == "") {
			inlineMsg('UNIT_LOC','Please Enter Unit Location',2);
			return false;
		  } 
		  
		  
		   if(UNIT_POST_ADDR == "") {
			inlineMsg('UNIT_POST_ADDR','Please Enter Unit Address',2);
			return false;
		  } 	
		  
		   if(UNIT_TALUK_BLOCK == "") {
			inlineMsg('UNIT_TALUK_BLOCK','Please Enter Unit Taluk',2);
			return false;
		  }     

		  if(DISTRICT == "") {
			inlineMsg('DISTRICT','Please Enter Unit District',2);
			return false;
		  } 	
		  
		   if(UNIT_PIN == "") {
			inlineMsg('UNIT_PIN','Please Enter Unit Pin',2);
			return false;
		  } 
		  

		  
		   if(IND_TYPE == "") {
			inlineMsg('IND_TYPE','Please Select Industry Type',2);
			return false;
		  } 
		  
		  
		   if(UNIT_POST_ADDR == "") {
			inlineMsg('UNIT_POST_ADDR','Please Enter Unit Address',2);
			return false;
		  } 	
		  
		   if(ACTIVITY_CD == "") {
			inlineMsg('ACTIVITY_CD','Please Select Activity Name',2);
			return false;
		  }     

		  if(BANK_NAME == "") {
			inlineMsg('BANK_NAME','Please Select bank name',2);
			return false;
		  } 	
		  
		   if(IFSC_CODE == "") {
			inlineMsg('IFSC_CODE','Please Enter Ifsc Code',2);
			return false;
		  } 
		  
		  if(CE_SANC_FB == "") {
			inlineMsg('CE_SANC_FB','Please enter Capital Expenditure',2);
			return false;
		  } 	
		  
		   if(EMP_ENV == "") {
			inlineMsg('EMP_ENV','Please Enter Employement',2);
			return false;
		  } 
		  
		  
		    if(REPAY_DT == "") {
			inlineMsg('REPAY_DT','Please enter Repayment Date',2);
			return false;
		  } 	
		  
		   if(REPAY_AMT == "") {
			inlineMsg('REPAY_AMT','Please Enter Repayment Amount',2);
			return false;
		  }   
		  
				
		
		
			
		document.getElementById("ins").value  = "3";
	 var TEST=document.form.ins.value;
	 //alert(TEST);
	 document.form.ins.value=TEST;
     document.form.submit();
	//document.getElementById("REC").style.backgroundColor  = "RED";
	
	}
	
	
	document.getElementById("REC").style.backgroundColor  = "GREEN";
	
}

if (n == 4){
	  sub_form();
	 //document.getElementById("ins").value  = "4";
	// var TEST=document.form.ins.value;
	 //alert(TEST);
	 //document.form.ins.value=TEST;
     //document.form.submit();
	
	
}

if (n == 5){
	//alert("hello");
	document.getElementById("REC").style.backgroundColor  = "RED";
	  document.getElementById("CON").style.backgroundColor  = "RED";
	  	  document.getElementById("CAL").style.backgroundColor  = "RED";
final_submit();

	 document.getElementById("FS").style.backgroundColor  = "GREEN";
}
if (n == 6){ 
	
	
	submit_offupdate();
}
if (n == 8){ 

    document.getElementById("ins").value  = "8";
	 var TEST=document.form.ins.value;
	 //alert(TEST);
	 document.form.ins.value=TEST;
     document.form.submit();	
}
if (n == 9){
	//alert("9");
	  sub_form_edit();
	}
	
	
}



function submit_offupdate(){
			 	document.getElementById("ins").value  = "6";
	 var TEST=document.form.ins.value;
	 //alert(TEST);
	 document.form.ins.value=TEST;
     document.form.submit();
}



  function sub_form(){
	  
			 if (validate(form)){
				  
				var answer = confirm ("Once Clicked On 'OK' Button, username and password will be sent to your registered mobile no."+ '\n' + "Using this Username and password, login to the system and make necessary corrections, if any and also upload necessary documents.  Once the application is completed in all respect,  click on final Submission button to forward your application to concerned agency.  After final submission you can print your application.")
					if (answer){
						
					 	document.getElementById("ins").value  = "4";
	 var TEST=document.form.ins.value;
	 //alert(TEST);
	 document.form.ins.value=TEST;
     document.form.submit();
					}
	}
	  }
	  
	  
	  
	  
	  
	  
	  
	  
	

	   function sub_form_edit(){
			 if (valid(form)){
				  
				var answer = confirm ("Once Clicked On 'OK' Button, username and password will be sent to your registered mobile no."+ '\n' + "Using this Username and password, login to the system and make necessary corrections, if any and also upload necessary documents.  Once the application is completed in all respect,  click on final Submission button to forward your application to concerned agency.  After final submission you can print your application.")
					if (answer){
						
					 	document.getElementById("ins").value  = "9";
	 var TEST=document.form.ins.value;
	// alert(TEST);
	 document.form.ins.value=TEST;
     document.form.submit();
					}
	}
}
	
	
	
	
	
	


var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(){

i=document.form.BANK_NAME.selectedIndex;
vbankCode=document.form.BANK_NAME.options[i].value;  
BANK_NM=document.form.BANK_NAME.options[i].text; 
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
    

if (vbankCode == "-1") {	
 inlineMsg ( 'BANK_NAME','Please Select Bank name',2);	
 return (false);
 }else
 if (vstate=='-1') {	        
inlineMsg('STATE','<Strong> Select State Name for Unit  From the List </Strong>',2);
return (false);
		} else {
var urlpar='APPRBIBANKLOV.jsp?BANK_NAME='+BANK_NM+'&state='+vstate;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank*/
 
 }//END OF FUNCTION
 
 
 
 function ShowNewPage2(){

i=document.form.BANK_NAME2.selectedIndex;
vbankCode=document.form.BANK_NAME2.options[i].value;  
BANK_NM=document.form.BANK_NAME2.options[i].text; 
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
    

if (vbankCode == "-1") {	
 inlineMsg ( 'BANK_NAME2','Please Select Alternative Financing Bank name',2);	
 return (false);
 }else
 if (vstate=='-1') {	        
inlineMsg('STATE','<Strong> Select State Name for Unit  From the List </Strong>',2);
return (false);
		} else {
var urlpar='APPRBIBANKLOV2.jsp?BANK_NAME='+BANK_NM+'&state='+vstate;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 }//END OF FUNCTION
 
 function activity_M(){

//var AGENCY= document.form.AGENCY.value;
var IND_TYPE= document.form.IND_TYPE.value;    


if (IND_TYPE == "") {	
 inlineMsg ( 'IND_TYPE','Please Select Type of Activicty',2);	
 return (false);
 } 
 else {
 var urlpar='mudraActivity.jsp';
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 }
 
 function activity(){

var AGENCY= document.form.AGENCY.value;
var IND_TYPE= document.form.IND_TYPE.value;    

if (AGENCY == "-1") {	
 inlineMsg ( 'AGENCY','Please Select Agency',2);	
 return (false);
 }
 else if (IND_TYPE == "") {	
 inlineMsg ( 'IND_TYPE','Please Select Type of Activicty',2);	
 return (false);
 } 
 else {
 var urlpar='PMEGPlovpage.jsp?AGENCY='+AGENCY;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 }
 

 
 
 
 
function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}


function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}


function getBankLOV(IFSC,BRNAME,ADDR,DIST){
 form.IFSC_CODE.value=IFSC;
 form.BRANCH_NAME.value=BRNAME;
 form.BANK_POST_ADDR.value=ADDR;
form.BANK_DISTRICT.value=DIST;

}

function changeComDistrict(){
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
var urlpar='districtCommunicationLOV.jsp?STATE='+vstate;
if (vstate=='-1') {	        
inlineMsg('STATE','<Strong> Select State Name</Strong>',2);
return (false);
		}
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,600,'Find Bank Details',null,callbackFunctionArray);
 }//end 
function getDistrictName(DISTRICT_NAME,DISTRICT_CD){
 form.UNIT_DIST_NM.value=DISTRICT_NAME;
form.APP_DIST_CD.value=DISTRICT_CD;
}
function getBankLOV2(IFSC){
 form.IFSC_CODE2.value=IFSC;
}

 
$(function() {
$("#BANK_NAME").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     20,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});

$(function() {
$("#BANK_NAME2").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     20,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});

function logout(){
 window.location.href='logout.jsp'
}

</script>
<style type="text/css">
<!--
.style13 {font-size: 16px}
.style4 {font-size: 14px; color: #990000; }
-->
</style>
</head>

<body onload="getfrequenttab(1);check();">
<form name="form" id="form"  class="form" method="post">
<%String ins = request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String UPDATE= (String) session.getAttribute("UPDATE");
String SESSION_ID=(String) session.getAttribute("SESSION_ID")==null?"":(String)session.getAttribute("SESSION_ID");
String APPID=(String)session.getAttribute("sAPP_ID");

DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();
 %>
  <img src="../images/04_01.png" width="100%" height="150" >
  <input name="UPDATE" type="hidden" id="UPDATE" value="<%=UPDATE%>" />
  <input name="SESSION_ID" type="hidden" id="SESSION_ID" value="<%=SESSION_ID%>" />	
   <input name="APP" type="HIDDEN" id="APP" value="<%=APPID%>">
 <input name="GSINV_NO" type="hidden" id="GSINV_NO" value="" />	
 <input name="TREC_TRID" type="hidden" id="TREC_TRID" value="" />	  
  <input name="CONS_TRID" type="hidden" id="CONS_TRID" value="" />
    <input name="ins" type="hidden" id="ins" value="">
 
<BR><table align="center">
  <tr><input name="FLAG" type="hidden" id="FLAG" value="1">
    <td colspan="3"><div align="left">
	
      <input name="Button"  type="button" disabled="true"  class="buttonOrange" id="CHR"  onclick="index();" value="Personal Details" />
      <input name="Button2" type="button" disabled="true" class="buttonOrange" id="REC"  onclick="sanction();" value="Previous Sanction Details" />
      <input name="Button3" type="button" disabled="true" class="buttonOrange" id="CON"  onclick="charges();" value="Apply Online" />
     <input name="Button3" type="button" disabled="true" class="buttonOrange" id="CAL"  onclick="finalCalc();" value="Upload Documents" />
	  
	 <input name="Button3" type="button" disabled="true" class="buttonOrange" id="FS"  onclick="finalCalc();" value="Final Submit" />
	 <%if (!SESSION_ID.equals("")){%>
	 <input name="Button3" type="button"  class="buttonOrange" id="LG"  onclick="logout();" value="Logout" />
	 <%}%>
    </div></td>
    </tr>
</table><BR>

<div id="INDEX"  ></div>
<div id="SANCTION" ></div>
<div id="MUDRA" ></div>
<div id="PMEGPONLINE" ></div>
<div id="UPLOAD" ></div>
<div id="FINAL" ></div>
<div id="EDIT" ></div>
<div id="VALID" ></div>
<div align="center">
   
    <br>
  </div>
  
  
  
  <%
  
 if (ins.equals("3")){
String UP="3";	 
	 //List values=new ArrayList();
	//List pstm=new ArrayList(); 
String SCHEME=(String) request.getParameter("SCHEME")==null?"0":(String) request.getParameter("SCHEME").trim();	 
String SECL_ID="";
	 
ResultSet rsRd = db.execSQL("select round(dbms_random.value(1000000,9999999),0) SECL_ID from dual ");
		
		while (rsRd.next()){
		  SECL_ID=rsRd.getString(1);
		}
		rsRd.close();


StringBuffer qrysb = new StringBuffer();


 if (SCHEME.equals("PMEGP")){
	 

String APP_ID=(String) request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID").trim();
String REPAY_DT=(String) request.getParameter("REPAY_DT")==null?"0":(String) request.getParameter("REPAY_DT").trim();
String REPAY_AMT=(String) request.getParameter("REPAY_AMT")==null?"0":(String) request.getParameter("REPAY_AMT").trim();	 
String GSTN_NO=(String) request.getParameter("GSTN_NO")==null?"0":(String) request.getParameter("GSTN_NO").trim();
String UNIT_NM=(String) request.getParameter("UNIT_NM")==null?"0":(String) request.getParameter("UNIT_NM").trim();	
String UAD=(String) request.getParameter("UAD")==null?"0":(String) request.getParameter("UAD").trim();	 
	
out.print(APP_ID);
out.print(REPAY_DT);
out.print(REPAY_AMT);out.print(GSTN_NO);out.print(UAD);out.print(UNIT_NM);

	

	qrysb.append(" INSERT INTO APP_SEC_LOAN( ");	
	qrysb.append(" SELECT 'PMEGP' AS SCHEME_NM,  BD.APP_ID,  AD.APP_NAME,  AD.IND_TYPE,  AD.EMP_ENV,  AD.OFF_CD,  AD.UNIT_DIST_CD,  MD.STATE_CD,   AD.UNIT_POST_ADDR AS UNIT_ADDR, ");	
 qrysb.append(" AD.UNIT_LOC,  AD.UNIT_TALUK_BLOCK,  AD.UNIT_PIN,  AD.ACTIVITY_CD,  AD.PROD_DESC,  AD.AADHAR_NO,  AD.MOB_NO1,  AD.E_MAIL,  AD.PAN_NO,  BD.IFSC_CODE,  AD.BANK_NAME, ");	
 qrysb.append(" AD.BANK_POST_ADDR,  AD.BRANCH_NAME,  AD.BANK_DISTRICT,  BD.CE_SANC_FB,  BD.WC_SANC_FB, BD.IST_LOAN_AMT,  BD.IST_LOAN_DT,  BD.APPLOAN_ACCNO,  BD.UTRN_NO,  BD.MM_REL_AMT, ");	
 qrysb.append(" BD.MM_REL_DT,? AS GSTN_NO,? AS UNIT_NM,? AS REPAY_DT,? AS REPAY_AMT,NULL AS ESTB_YR,SYSDATE AS SUB_DT,? AS UAD,? AS SECL_ID FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  M_DISTRICT MD WHERE AD.APP_ID     = BD.APP_ID(+) ");	
qrysb.append(" AND AD.UNIT_DIST_CD = MD.DISTRICT_CD AND BD.MM_REL_AMT  IS NOT NULL AND BD.MM_REL_DT IS NOT NULL  ");	
qrysb.append(" AND BD.PACT_ID = 34 AND BD.APPRV_YN= 'A' AND AD.APP_ID= ?) ");	
	
	
	
values.add(GSTN_NO);pstm.add ("L");
values.add(UNIT_NM);pstm.add ("L");	
values.add(REPAY_DT);pstm.add ("L");
values.add(REPAY_AMT);pstm.add ("L");
values.add(UAD);pstm.add ("L");
values.add(SECL_ID);pstm.add ("L");
values.add(APP_ID);pstm.add ("L");		
out.print(qrysb.toString());

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();
session.setAttribute("UPDATE","3");
session.setAttribute("SESSION_ID",SECL_ID);
response.sendRedirect("index.jsp");

}



else{
	
String APP_ID=(String) request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID").trim();
String APP_NAME=(String) request.getParameter("APP_NAME")==null?"0":(String) request.getParameter("APP_NAME").trim();
String STATE=(String) request.getParameter("STATE")==null?"0":(String) request.getParameter("STATE").trim();	 
String MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"0":(String) request.getParameter("MOB_NO1").trim();
String AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"0":(String) request.getParameter("AADHAR_NO").trim();	

String PAN_NO=(String) request.getParameter("PAN_NO")==null?"0":(String) request.getParameter("PAN_NO").trim();
String E_MAIL=(String) request.getParameter("E_MAIL")==null?"0":(String) request.getParameter("E_MAIL").trim();
String UNIT_NM=(String) request.getParameter("UNIT_NM")==null?"0":(String) request.getParameter("UNIT_NM").trim();	 
String GSTN_NO=(String) request.getParameter("GSTN_NO")==null?"0":(String) request.getParameter("GSTN_NO").trim();
String ESTB_YR=(String) request.getParameter("ESTB_YR")==null?"0":(String) request.getParameter("ESTB_YR").trim();	


String UNIT_LOC=(String) request.getParameter("UNIT_LOC")==null?"0":(String) request.getParameter("UNIT_LOC").trim();
String UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"0":(String) request.getParameter("UNIT_POST_ADDR").trim();
String UNIT_TALUK_BLOCK=(String) request.getParameter("UNIT_TALUK_BLOCK")==null?"0":(String) request.getParameter("UNIT_TALUK_BLOCK").trim();	 
String UNIT_DIST_CD=(String) request.getParameter("DISTRICT")==null?"":(String) request.getParameter("DISTRICT").trim();
String UNIT_PIN=(String) request.getParameter("UNIT_PIN")==null?"0":(String) request.getParameter("UNIT_PIN").trim();	


String IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"0":(String) request.getParameter("IND_TYPE").trim();
String ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"0":(String) request.getParameter("ACTIVITY_CD").trim();
String PROD_DESC=(String) request.getParameter("PROD_DESC")==null?"0":(String) request.getParameter("PROD_DESC").trim();	 
String BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"0":(String) request.getParameter("BANK_NAME").trim();
String IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"0":(String) request.getParameter("IFSC_CODE").trim();	

String BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"0":(String) request.getParameter("BRANCH_NAME").trim();
String BANK_POST_ADDR=(String) request.getParameter("BANK_POST_ADDR")==null?"0":(String) request.getParameter("BANK_POST_ADDR").trim();
String BANK_DISTRICT=(String) request.getParameter("BANK_DISTRICT")==null?"0":(String) request.getParameter("BANK_DISTRICT").trim();	 
String CE_SANC_FB=(String) request.getParameter("CE_SANC_FB")==null?"0":(String) request.getParameter("CE_SANC_FB").trim();
String WC_SANC_FB=(String) request.getParameter("WC_SANC_FB")==null?"0":(String) request.getParameter("WC_SANC_FB").trim();	
	
	
String EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"0":(String) request.getParameter("EMP_ENV").trim();
String REPAY_DT=(String) request.getParameter("REPAY_DT")==null?"0":(String) request.getParameter("REPAY_DT").trim();
String REPAY_AMT=(String) request.getParameter("REPAY_AMT")==null?"0":(String) request.getParameter("REPAY_AMT").trim();		
String IST_LOAN_DT=(String) request.getParameter("IST_LOAN_DT")==null?"":(String) request.getParameter("IST_LOAN_DT").trim();	

String UAD=(String) request.getParameter("UAD")==null?"":(String) request.getParameter("UAD").trim();	


qrysb.append(" INSERT INTO APP_SEC_LOAN( ");
qrysb.append(" SCHEME_NM, ");
qrysb.append(" APP_ID, ");
qrysb.append(" APP_NAME,");
qrysb.append(" IND_TYPE, ");
qrysb.append(" EMP_ENV, ");


qrysb.append(" UNIT_DIST_CD, ");
qrysb.append(" STATE_CD, ");
qrysb.append(" UNIT_ADDR, ");
qrysb.append(" UNIT_LOC, ");
qrysb.append(" UNIT_TALUK_BLOCK, ");
//10

qrysb.append(" UNIT_PIN, ");
qrysb.append(" ACTIVITY_CD, ");
qrysb.append(" PROD_DESC, ");
qrysb.append(" AADHAR_NO, ");
qrysb.append(" MOB_NO1, ");

qrysb.append(" E_MAIL, ");
qrysb.append(" PAN_NO, ");
qrysb.append(" IFSC_CODE, ");
qrysb.append(" BANK_NAME, ");
qrysb.append(" BANK_POST_ADDR, ");

//20
qrysb.append(" BRANCH_NAME, "); 
qrysb.append(" BANK_DISTRICT, ");
qrysb.append(" CE_SANC_FB, ");
qrysb.append(" WC_SANC_FB, ");
qrysb.append(" IST_LOAN_DT, ");


qrysb.append(" GSTN_NO, ");
qrysb.append(" UNIT_NM, ");
qrysb.append(" REPAY_DT, ");
qrysb.append(" REPAY_AMT, ");//30
qrysb.append(" ESTB_YR,SUB_DT,UAD,SECL_ID ) ");
qrysb.append("  VALUES ( ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,  ?,?,?,?,?,?,?,?,?,?, SYSDATE,?,?)");


values.clear();
pstm.clear();



values.add(SCHEME); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(STATE); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");


values.add(UNIT_PIN); pstm.add ("L");
values.add(ACTIVITY_CD); pstm.add ("L");
values.add(PROD_DESC); pstm.add ("L");
values.add(AADHAR_NO); pstm.add ("L");
values.add(MOB_NO1); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");
values.add(PAN_NO); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(BANK_POST_ADDR); pstm.add ("L");

values.add(BRANCH_NAME); pstm.add ("L");
values.add(BANK_DISTRICT); pstm.add ("L");
values.add(CE_SANC_FB); pstm.add ("L");
values.add(WC_SANC_FB); pstm.add ("L");
values.add(IST_LOAN_DT); pstm.add ("L");
values.add(GSTN_NO); pstm.add ("L");
values.add(UNIT_NM); pstm.add ("L");
values.add(REPAY_DT); pstm.add ("L");
values.add(REPAY_AMT); pstm.add ("L");
values.add(ESTB_YR); pstm.add ("L");
values.add(UAD); pstm.add ("L");
values.add(SECL_ID);pstm.add ("L");
db.setSqlValue(qrysb.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();

values.clear();
pstm.clear();
session.setAttribute("UPDATE","3");
session.setAttribute("SESSION_ID",SECL_ID);
response.sendRedirect("index.jsp?UPDATE=3");
 }
 }
 if (ins.equals("4")){

   try{
  
	
String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
String OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
String APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
String APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
String FH_NAME=(String) request.getParameter("FH_NAME")==null?"":(String) request.getParameter("FH_NAME").trim();
String BENF_TYPE_CD=(String) request.getParameter("BENF_TYPE_CD")==null?"":(String) request.getParameter("BENF_TYPE_CD").trim();
String BENF_CATAGORY_CD=(String) request.getParameter("BENF_CATAGORY_CD")==null?"":(String) request.getParameter("BENF_CATAGORY_CD").trim();
String GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
String DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
String UAD=(String) request.getParameter("UAD")==null?"":(String) request.getParameter("UAD").trim();
String MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
String APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
String APP_TALUK_BLOCK=(String) request.getParameter("APP_TALUK_BLOCK")==null?"":(String) request.getParameter("APP_TALUK_BLOCK").trim();
String APP_DIST_CD=(String) request.getParameter("APP_DIST_CD")==null?"":(String) request.getParameter("APP_DIST_CD").trim();
String APP_PIN=(String) request.getParameter("APP_PIN")==null?"":(String) request.getParameter("APP_PIN").trim();
String E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();

String UNIT_LOC=(String) request.getParameter("UNIT_LOC")==null?"":(String) request.getParameter("UNIT_LOC").trim();
String UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"":(String) request.getParameter("UNIT_POST_ADDR").trim();
String UNIT_TALUK_BLOCK=(String) request.getParameter("UNIT_TALUK_BLOCK")==null?"":(String) request.getParameter("UNIT_TALUK_BLOCK").trim();
String UNIT_DIST_CD=(String) request.getParameter("UNIT_DIST_CD")==null?"":(String) request.getParameter("UNIT_DIST_CD").trim();
String UNIT_PIN=(String) request.getParameter("UNIT_PIN")==null?"":(String) request.getParameter("UNIT_PIN").trim();
String BLDG_TYPE=(String) request.getParameter("BLDG_TYPE")==null?"":(String) request.getParameter("BLDG_TYPE").trim();
String S_ID=(String) request.getParameter("SESSION_ID")==null?"":(String) request.getParameter("SESSION_ID").trim();
String MACHINARY_COST=(String) request.getParameter("MACHINARY_COST")==null?"0":(String) request.getParameter("MACHINARY_COST").trim();

String WORKING_CAPITAL=(String) request.getParameter("WORKING_CAPITAL")==null?"0":(String) request.getParameter("WORKING_CAPITAL").trim();
String EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"":(String) request.getParameter("EMP_ENV").trim();
String BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME").trim();
String BANK_POST_ADDR=(String) request.getParameter("BANK_POST_ADDR")==null?"":(String) request.getParameter("BANK_POST_ADDR").trim();
String BANK_TALUK_BLOCK=(String) request.getParameter("BANK_TALUK_BLOCK")==null?"":(String) request.getParameter("BANK_TALUK_BLOCK").trim();
String BANK_PINCD=(String) request.getParameter("BANK_PINCD")==null?"":(String) request.getParameter("BANK_PINCD").trim();
String BANK_DIST_CD=(String) request.getParameter("BANK_DIST_CD")==null?"":(String) request.getParameter("BANK_DIST_CD").trim();

String PROD_DESC=(String) request.getParameter("PROD_DESC")==null?"":(String) request.getParameter("PROD_DESC").trim();
String IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();


String ACT_ID=(String) request.getParameter("ACT_ID")==null?"-1":(String) request.getParameter("ACT_ID").trim();
String BANK_F_DATE=(String) request.getParameter("BANK_F_DATE")==null?"":(String) request.getParameter("BANK_F_DATE").trim();

String IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
String ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
String BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME").trim();
String BANK_DISTRICT=(String) request.getParameter("BANK_DISTRICT")==null?"":(String) request.getParameter("BANK_DISTRICT").trim();
String AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO").trim();
String MOB_NO2=(String) request.getParameter("MOB_NO2")==null?"":(String) request.getParameter("MOB_NO2").trim();
String IFSC_CODE2=(String) request.getParameter("IFSC_CODE2")==null?"":(String) request.getParameter("IFSC_CODE2").trim();
String ACT_YN=(String) request.getParameter("ACT_YN")==null?"Y":(String) request.getParameter("ACT_YN").trim();
String PAN_NO=(String) request.getParameter("PAN_NO")==null?"":(String) request.getParameter("PAN_NO").trim();
String BENF_SPECAT_CD=(String) request.getParameter("BENF_SPECAT_CD")==null?"NA":(String) request.getParameter("BENF_SPECAT_CD").trim();


String PRE_OPE_EXP=(String) request.getParameter("PRE_OPE_EXP")==null?"0":(String) request.getParameter("PRE_OPE_EXP").trim();
String WORKSHED_COST=(String) request.getParameter("WORKSHED_COST")==null?"0":(String) request.getParameter("WORKSHED_COST").trim();

String APP_REC_DATE="";
String APP_PWD="";
String REMARKS="";




		
		ResultSet rsProMaxID = db.execSQL("SELECT FAPPIDSECGEN("+OFF_CD+") AS MAXID FROM DUAL ");
		
		while (rsProMaxID.next()){
		  APP_ID=rsProMaxID.getString(1);
		}
		rsProMaxID.close();
		
		
		ResultSet rsRd = db.execSQL("select round(dbms_random.value(100000,999999),0) APP_PWD from dual ");
		
		while (rsRd.next()){
		  APP_PWD=rsRd.getString(1);
		}
		rsRd.close();
		
		
		
       
		
		StringBuffer qryUpdate = new StringBuffer();
		      
qryUpdate.append(" INSERT INTO APP_DETAIL_ONLINE_SECOND ");
qryUpdate.append(" ( APP_ID,");
qryUpdate.append("OFF_CD,");
qryUpdate.append("APP_PRIX,");
qryUpdate.append("APP_NAME,");
qryUpdate.append("UAD,");
qryUpdate.append("GENDER,");
qryUpdate.append("MOB_NO1,");
qryUpdate.append("APP_POST_ADDR,");
qryUpdate.append("APP_TALUK_BLOCK,");   //9

qryUpdate.append("APP_DIST_CD,");
qryUpdate.append("APP_PIN,");
qryUpdate.append("E_MAIL,");
qryUpdate.append("UNIT_LOC,");
qryUpdate.append("UNIT_POST_ADDR,");
qryUpdate.append("UNIT_TALUK_BLOCK,");
qryUpdate.append("UNIT_DIST_CD,");
qryUpdate.append("UNIT_PIN,");
qryUpdate.append("BLDG_TYPE,");
qryUpdate.append("WORKSHED_COST,"); //19


qryUpdate.append("MACHINARY_COST,");
qryUpdate.append("PRE_OPE_EXP,");
qryUpdate.append("WORKING_CAPITAL,");
qryUpdate.append("EMP_ENV,");
qryUpdate.append("BANK_NAME,");
qryUpdate.append("BANK_POST_ADDR,");
qryUpdate.append("BANK_TALUK_BLOCK,");
qryUpdate.append("BANK_PINCD,");
qryUpdate.append("BANK_DIST_CD,");
qryUpdate.append("PROD_DESC,");//29


qryUpdate.append("IFSC_CODE,");
qryUpdate.append("APP_REC_DATE,");
qryUpdate.append("ACT_ID,");
qryUpdate.append("REMARKS,");
qryUpdate.append("IND_TYPE,");
qryUpdate.append("ACTIVITY_CD,");
qryUpdate.append("BRANCH_NAME,");
qryUpdate.append("BANK_DISTRICT,");
qryUpdate.append("AADHAR_NO,");   
qryUpdate.append("MOB_NO2,");//39


qryUpdate.append("IFSC_CODE2,");
qryUpdate.append("PAN_NO, ");
qryUpdate.append("BENF_SPECAT_CD, ");
qryUpdate.append("APP_PWD, ");
qryUpdate.append("ONLINE_SUBDT,S_ID,ACT_YN ) ");//44




qryUpdate.append("  VALUES ( ?,?,?,?,?,?,?,?,?,  ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,SYSDATE,?,? )");

values.clear();
pstm.clear();

values.add(APP_ID); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(UAD); pstm.add ("L");
values.add(GENDER); pstm.add ("L");
values.add(MOB_NO1); pstm.add ("L");
values.add(APP_POST_ADDR); pstm.add ("L");
values.add(APP_TALUK_BLOCK); pstm.add ("L");//9



values.add(APP_DIST_CD); pstm.add ("L");
values.add(APP_PIN); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");
values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");
values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(UNIT_PIN); pstm.add ("L");
values.add(BLDG_TYPE); pstm.add ("L");
values.add(WORKSHED_COST); pstm.add ("L");//19



values.add(MACHINARY_COST); pstm.add ("L");
values.add(PRE_OPE_EXP); pstm.add ("L");
values.add(WORKING_CAPITAL); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(BANK_POST_ADDR); pstm.add ("L");
values.add(BANK_TALUK_BLOCK); pstm.add ("L");
values.add(BANK_PINCD); pstm.add ("L");
values.add(BANK_DIST_CD); pstm.add ("L");
values.add(PROD_DESC); pstm.add ("L");



values.add(IFSC_CODE); pstm.add ("L");
values.add(APP_REC_DATE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(REMARKS); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(ACTIVITY_CD); pstm.add ("L");
values.add(BRANCH_NAME); pstm.add ("L");
values.add(BANK_DISTRICT); pstm.add ("L");
values.add(AADHAR_NO); pstm.add ("L");
values.add(MOB_NO2); pstm.add ("L");




values.add(IFSC_CODE2); pstm.add ("L");
values.add(PAN_NO); pstm.add ("L");
values.add(BENF_SPECAT_CD); pstm.add ("L");
values.add(APP_PWD); pstm.add ("L");
values.add(S_ID); pstm.add ("L");
values.add(ACT_YN); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();

try {

int cal=APP_ID.indexOf("-");
int len=APP_ID.length();
String tempUN=APP_ID.substring(cal+1,len);
String SmsText="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking Application is registered. User  ID is "+tempUN+" and password is: "+APP_PWD+".Please Login for Upload Documents and Final Submission. After Final Submission You can Print Application form. ";
//SendSMS.sendBulkSMS("KVICDIT", "Kvic@1974", "KVICIT", MOB_NO1, SmsText);
session.setAttribute("sAPP_ID",APP_ID);
session.setAttribute("UPDATE","4");
response.sendRedirect("index.jsp");
}catch(Exception e){

}

}//ins



catch(Exception e)
{out.println(e);}
finally{
//db.close();

}	 
 } 
 
  if (ins.equals("5")){	  
	response.sendRedirect("SecondapplicantFormValidation.jsp"); 
  }
 
 if (ins.equals("6")){	
String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
String APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
String MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
 try {
		
		
		
		values.clear();
        pstm.clear();

        values.add(APP_ID); pstm.add ("L");
		//UPDATING STATUS
		 
		 db.setSqlValue("UPDATE APP_DETAIL_ONLINE_SECOND SET ACT_ID=0,ONLINE_SUBDT=SYSDATE WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		
		//INSERTING INTO APP_ONLINE ON FINAL SUBMISSION
		 db.setSqlValue("INSERT INTO APP_DETAIL_SECOND  SELECT * FROM APP_DETAIL_ONLINE_SECOND WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		
		session.setAttribute("sACT_ID","0"); 
		}catch (Exception e) {
		//out.print ("Error in Excuting");
		}

		 
		//SmsText="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking  Application ID is "+APP_ID+". You have successfully Submitted Your Application. Please Print your Applicant form ";
		 		//SendSMS.sendBulkSMS("KVICDIT", "Kvic@1974", "KVICIT", MOB_NO1, SmsText);
           
		   
		   
		   
	response.sendRedirect("PMEGPGenAppForm.jsp?APP_ID="+APP_ID); 
  }
 
 
 if (ins.equals("8")){	

  
  //out.print(APP_ID+"HELLO");
session.setAttribute("UPDATE","5");

response.sendRedirect("index.jsp");
 
 }
 if (ins.equals("9")){	
  String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
 	

String OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
String APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
String APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
String FH_NAME=(String) request.getParameter("FH_NAME")==null?"":(String) request.getParameter("FH_NAME").trim();
String BENF_TYPE_CD=(String) request.getParameter("BENF_TYPE_CD")==null?"":(String) request.getParameter("BENF_TYPE_CD").trim();
String BENF_CATAGORY_CD=(String) request.getParameter("BENF_CATAGORY_CD")==null?"":(String) request.getParameter("BENF_CATAGORY_CD").trim();
String GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
String DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
String UAD=(String) request.getParameter("UAD")==null?"":(String) request.getParameter("UAD").trim();
String MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
String APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
String APP_TALUK_BLOCK=(String) request.getParameter("APP_TALUK_BLOCK")==null?"":(String) request.getParameter("APP_TALUK_BLOCK").trim();
String APP_DIST_CD=(String) request.getParameter("APP_DIST_CD")==null?"":(String) request.getParameter("APP_DIST_CD").trim();
String APP_PIN=(String) request.getParameter("APP_PIN")==null?"":(String) request.getParameter("APP_PIN").trim();
String E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();

String UNIT_LOC=(String) request.getParameter("UNIT_LOC")==null?"":(String) request.getParameter("UNIT_LOC").trim();
String UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"":(String) request.getParameter("UNIT_POST_ADDR").trim();
String UNIT_TALUK_BLOCK=(String) request.getParameter("UNIT_TALUK_BLOCK")==null?"":(String) request.getParameter("UNIT_TALUK_BLOCK").trim();
String UNIT_DIST_CD=(String) request.getParameter("UNIT_DIST_CD")==null?"":(String) request.getParameter("UNIT_DIST_CD").trim();
String UNIT_PIN=(String) request.getParameter("UNIT_PIN")==null?"":(String) request.getParameter("UNIT_PIN").trim();
String BLDG_TYPE=(String) request.getParameter("BLDG_TYPE")==null?"":(String) request.getParameter("BLDG_TYPE").trim();
String S_ID=(String) request.getParameter("SESSION_ID")==null?"":(String) request.getParameter("SESSION_ID").trim();
String MACHINARY_COST=(String) request.getParameter("MACHINARY_COST")==null?"0":(String) request.getParameter("MACHINARY_COST").trim();

String WORKING_CAPITAL=(String) request.getParameter("WORKING_CAPITAL")==null?"0":(String) request.getParameter("WORKING_CAPITAL").trim();
String EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"":(String) request.getParameter("EMP_ENV").trim();
String BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME").trim();
String BANK_POST_ADDR=(String) request.getParameter("BANK_POST_ADDR")==null?"":(String) request.getParameter("BANK_POST_ADDR").trim();
String BANK_TALUK_BLOCK=(String) request.getParameter("BANK_TALUK_BLOCK")==null?"":(String) request.getParameter("BANK_TALUK_BLOCK").trim();
String BANK_PINCD=(String) request.getParameter("BANK_PINCD")==null?"":(String) request.getParameter("BANK_PINCD").trim();
String BANK_DIST_CD=(String) request.getParameter("BANK_DIST_CD")==null?"":(String) request.getParameter("BANK_DIST_CD").trim();

String PROD_DESC=(String) request.getParameter("PROD_DESC")==null?"":(String) request.getParameter("PROD_DESC").trim();
String IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();


String ACT_ID=(String) request.getParameter("ACT_ID")==null?"-1":(String) request.getParameter("ACT_ID").trim();
String BANK_F_DATE=(String) request.getParameter("BANK_F_DATE")==null?"":(String) request.getParameter("BANK_F_DATE").trim();

String IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
String ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
String BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME").trim();
String BANK_DISTRICT=(String) request.getParameter("BANK_DISTRICT")==null?"":(String) request.getParameter("BANK_DISTRICT").trim();
String AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO").trim();
String MOB_NO2=(String) request.getParameter("MOB_NO2")==null?"":(String) request.getParameter("MOB_NO2").trim();
String IFSC_CODE2=(String) request.getParameter("IFSC_CODE2")==null?"":(String) request.getParameter("IFSC_CODE2").trim();
String ACT_YN=(String) request.getParameter("ACT_YN")==null?"Y":(String) request.getParameter("ACT_YN").trim();
String PAN_NO=(String) request.getParameter("PAN_NO")==null?"":(String) request.getParameter("PAN_NO").trim();
String BENF_SPECAT_CD=(String) request.getParameter("BENF_SPECAT_CD")==null?"NA":(String) request.getParameter("BENF_SPECAT_CD").trim();


String PRE_OPE_EXP=(String) request.getParameter("PRE_OPE_EXP")==null?"0":(String) request.getParameter("PRE_OPE_EXP").trim();
String WORKSHED_COST=(String) request.getParameter("WORKSHED_COST")==null?"0":(String) request.getParameter("WORKSHED_COST").trim();

String APP_REC_DATE="";
String APP_PWD="";
String REMARKS="";


StringBuffer qryUpdate = new StringBuffer();
	try{	      
qryUpdate.append(" UPDATE APP_DETAIL_ONLINE_SECOND SET ");
qryUpdate.append("OFF_CD=?,");
qryUpdate.append("APP_PRIX=?,");
qryUpdate.append("GENDER=?,");

qryUpdate.append("MOB_NO1=?,");
qryUpdate.append("APP_POST_ADDR=?,");
qryUpdate.append("APP_TALUK_BLOCK=?,");
qryUpdate.append("APP_DIST_CD=?,");
qryUpdate.append("APP_PIN=?,");
qryUpdate.append("E_MAIL=?,");

qryUpdate.append("UNIT_LOC=?,");
qryUpdate.append("UNIT_POST_ADDR=?,");
qryUpdate.append("UNIT_TALUK_BLOCK=?,");
qryUpdate.append("UNIT_DIST_CD=?,");
qryUpdate.append("UNIT_PIN=?,");
qryUpdate.append("MACHINARY_COST=?,");
qryUpdate.append("WORKING_CAPITAL=?,");
qryUpdate.append("EMP_ENV=?, ");
qryUpdate.append("BANK_NAME=?,");
qryUpdate.append("BANK_POST_ADDR=?,");
qryUpdate.append("BANK_TALUK_BLOCK=?,");
qryUpdate.append("BANK_PINCD=?,");
qryUpdate.append("BANK_DIST_CD=?,");

qryUpdate.append("PROD_DESC=?,");
qryUpdate.append("IFSC_CODE=?,");
qryUpdate.append("APP_REC_DATE=?,");
qryUpdate.append("ACT_ID=?,");
qryUpdate.append("IND_TYPE=?,");
qryUpdate.append("ACTIVITY_CD=?,");
qryUpdate.append("BRANCH_NAME=?,");
qryUpdate.append("BANK_DISTRICT=?,");
qryUpdate.append("MOB_NO2=?,");
qryUpdate.append("IFSC_CODE2=?,");

qryUpdate.append("PAN_NO=?, ");
qryUpdate.append("BENF_SPECAT_CD=?, AADHAR_NO=?, ");
qryUpdate.append(" ONLINE_SUBDT=SYSDATE WHERE APP_ID=?  ");





values.clear();
pstm.clear();


values.add(OFF_CD); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");

values.add(GENDER); pstm.add ("L");

values.add(MOB_NO1); pstm.add ("L");
values.add(APP_POST_ADDR); pstm.add ("L");
values.add(APP_TALUK_BLOCK); pstm.add ("L");
values.add(APP_DIST_CD); pstm.add ("L");
values.add(APP_PIN); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");

values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");
values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(UNIT_PIN); pstm.add ("L");
values.add(MACHINARY_COST); pstm.add ("L");
values.add(WORKING_CAPITAL); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(BANK_POST_ADDR); pstm.add ("L");
values.add(BANK_TALUK_BLOCK); pstm.add ("L");
values.add(BANK_PINCD); pstm.add ("L");
values.add(BANK_DIST_CD); pstm.add ("L");

values.add(PROD_DESC); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(APP_REC_DATE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(ACTIVITY_CD); pstm.add ("L");
values.add(BRANCH_NAME); pstm.add ("L");
values.add(BANK_DISTRICT); pstm.add ("L");
values.add(MOB_NO2); pstm.add ("L");
values.add(IFSC_CODE2); pstm.add ("L");

values.add(PAN_NO); pstm.add ("L");
values.add(BENF_SPECAT_CD); pstm.add ("L");
values.add(AADHAR_NO); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");


session.setAttribute("sAPP_ID",APP_ID);
session.setAttribute("UPDATE","10");
response.sendRedirect("index.jsp");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();


}//ins
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}





 
 }
 %>
 
 

 
</form>
 
</body>

</html>
