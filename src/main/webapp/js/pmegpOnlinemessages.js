// form validation function //

      var xmlHttp   
      var xmlHttp 
      function showDistrict(str){ 
	  try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
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
	 
	  
      var url="district.jsp"; 
      url +="?count=" +str;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('DISTRICT');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }//main function end.

       
	   function showOffice(str){ 

     try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
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
	  i=document.form.STATE.selectedIndex; 
      vstate=document.form.STATE.options[i].value;
	  i=document.form.DISTRICT.selectedIndex; 
      vdistcd=document.form.DISTRICT.options[i].value; 
	  i=document.form.AGENCY.selectedIndex; 
      vorgcd=document.form.AGENCY.options[i].value;  
      var url="office.jsp"; 
      
	  url +="?state=" +vstate+"&distcd="+vdistcd+"&orgcd="+vorgcd;
	  
      xmlHttp.onreadystatechange = districtChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function districtChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('office');
	   x.innerHTML=xmlHttp.responseText;
	   
	  // alert(vpg);
      } //statechane1 function end   
      }//main function end.
	  
	    function sub_form() {
			 if (validate(form)){
swal.fire({
    title: 'PMEGP Portal',
    html: `<div align="left">
           <ul>
  <li> I understand that the Margin Money shall be released subject to
        clearance of backlog and availability of funds without any time
        limits.</li>
  <li>I declare that me or my spouse has not availed subsidy benefit under
        PMEGP or any other similar scheme of state/ central government.</li>
  <li>I declare that all the infomation furnished
         by me is true to the best of my knowledge and belief.My application
          is liable to be cancelled in case the information furnished is found to be false.</li>
  <li>I will be blacklisted from any subsidy scheme 
        of Central Government in case the information furnished by me is 
        found to be fake and government subsidy released to me if any will
         be recovered.</li>
  <li>I agree to submit my application with the above terms and conditions.</li>
 </ul> 
</div>     `,
showCancelButton: true,
confirmButtonColor: "#38761d",
  cancelButtonColor: "#d33",
    focusConfirm: false,
    preConfirm: () => {
		
			 document.form.ins.value='I'; 
					document.form.submit();
      // alert ("hello");
    }
});

			 }
}
	  
	  function sub_form1(){
		  
		  var msgdata="";
		  
		  var  BENF_SPECAT_CD = document.form.BENF_SPECAT_CD.value;
		  	  var  BENF_CATAGORY_CD = document.form.BENF_CATAGORY_CD.value;
		  
		  if (BENF_SPECAT_CD=='NE' || BENF_CATAGORY_CD=='SC'||BENF_CATAGORY_CD=='ST' ) {
			  
			   msgdata= "Once Clicked On 'OK' Button, username and password will be sent to your registered mobile no. \n Using this Username and password, login to the system and make necessary corrections, if any and also upload necessary documents.  Once the application is completed in all respect,  click on final Submission button to forward your application to concerned agency.  After final submission you can print your application.";
			  
		  } else {			  
			   msgdata= "Your Application will be registered under waiting list.\n Margin Money shall be sanctioned subject to eligibility, admissibility and availability of funds and it is not guaranted or legaly binding to release the Margin Money. \n Click on Ok button to Proceed. \n Once Clicked On 'OK' Button, username and password will be sent to your registered mobile no. \n Using this Username and password, login to the system and make necessary corrections, if any and also upload necessary documents.  Once the application is completed in all respect,  click on final Submission button to forward your application to concerned agency.  After final submission you can print your application.";  
			  }
			  
			  
			 if (validate(form)){
				  
				var answer = confirm (msgdata)
					if (answer){
					 document.form.ins.value='I'; 
					document.form.submit(); }
	}
	  }
	
	
function validate(form) {
	
	var AADHAR_NO = document.form.AADHAR_NO.value; 
  var APP_PRIX = document.form.APP_PRIX.value;
  var STATE = document.form.STATE.value;
  var DISTRICT = document.form.DISTRICT.value;
  var AGENCY = document.form.AGENCY.value;
  var  BENF_TYPE_CD = document.form.BENF_TYPE_CD.value;
  var APP_NAME = document.form.APP_NAME.value;
  var DOB = document.form.DOB.value;
  var GENDER = document.form.GENDER.value;
  var BENF_SPECAT_CD = document.form.BENF_SPECAT_CD.value;
	var APP_POST_ADDR = document.form.APP_POST_ADDR.value;
	var APP_TALUK_BLOCK=document.form.APP_TALUK_BLOCK.value;
	var APP_DIST_CD = document.form.APP_DIST_CD.value;
	var APP_PIN = document.form.APP_PIN.value;
  	var E_MAIL = document.form.E_MAIL.value;
 	var UNIT_LOC =document.form.UNIT_LOC.value;
	var UNIT_POST_ADDR = document.form.UNIT_POST_ADDR.value;
	var UNIT_TALUK_BLOCK = document.form.UNIT_TALUK_BLOCK.value;
	var UNIT_DIST_CD = document.form.UNIT_DIST_CD.value;
	var UNIT_PIN = document.form.UNIT_PIN.value;
  //var BANK_TYPE = document.form.BANK_TYPE.value;
	var  BANK_NAME = document.form.BANK_NAME.value;
	var  IFSC_CODE = document.form.IFSC_CODE.value;
	var BANK_POST_ADDR = document.form.BANK_POST_ADDR.value;
	var BRANCH_NAME = document.form.BRANCH_NAME.value;
	var BANK_DISTRICT = document.form.BANK_DISTRICT.value;
	var EDU_ID = document.form.EDU_ID.value;
	//var BLDG_TYPE = document.form.BLDG_TYPE.value;
	var BENF_CATAGORY_CD = document.form.BENF_CATAGORY_CD.value;
	var OFF_CD=document.form.OFF_CD.value;
	var MOB_NO1=document.form.MOB_NO1.value;
	var EDP_YN=document.form.EDP_YN.value;
	var EDP_INST_ADDR =document.form.EDP_INST_ADDR.value;                              
	var BENF_CATAGORY_CD =document.form.BENF_CATAGORY_CD.value;  
	var IND_TYPE =document.form.IND_TYPE.value;  
	var ACTIVITY_CD=document.form.ACTIVITY_CD.value;
	var PAN_NO=document.form.PAN_NO.value;
	 
var EMP_ENV =document.form.EMP_ENV.value;
var MACHINARY_COST =document.form.MACHINARY_COST.value;
var TECH_QUALI =document.form.TECH_QUALI.value;
var BLDG_TYPE = document.form.BLDG_TYPE.value;



  var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
  var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
  var messageRegex = new RegExp(/<\/?\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)\/?>/gim);
  var numberOnly=/^[0-9]*$/;
  
  var vstatex = ['AR', 'AS', 'MN', 'MG','SK','TR','NG','MZ','JK'];
  var vstatec=  ['DL','CH'];
	 
	 
	 
	 
	//if (vstatex.indexOf(STATE) <0) {
  
		  if(AADHAR_NO == "") {
			inlineMsg('AADHAR_NO','You must enter your Aadhaar Card No.',2);
			return false;
		  }
		  
		  /*if(Number(AADHAR_NO) ==0) {
			inlineMsg('AADHAR_NO','Enter Proper 12 Digit Aadhaar No....',2);
			return false;
		  }
  
			  if(!numberOnly.test(AADHAR_NO)) {
				inlineMsg('AADHAR_NO','Aadhar No should be in Number....',2);
				return false;
			  }*/
  
			  if(AADHAR_NO.length !=12) {
				inlineMsg('AADHAR_NO','Enter 12 digit Aadhaar No...',2);
				return false;
			  }
 		
		//}
	
	/*if (vstatex.indexOf(STATE) >-1) {
		
		if (AADHAR_NO == "" && PAN_NO == "") {
			inlineMsg('AADHAR_NO','Valid Aadhaar Card  No OR Pan Card No Must be Entered...',2);
			return false;
			}
	
	if(Number(AADHAR_NO) ==0 &&AADHAR_NO !="") {
			inlineMsg('AADHAR_NO','Enter Proper 12 Digit Aadhaar No....',2);
			return false;
		  }
		
		if(!numberOnly.test(AADHAR_NO)&&AADHAR_NO !="") {
				inlineMsg('AADHAR_NO','Aadhar No should be in Number....',2);
				return false;
			  }
  
			  if(AADHAR_NO.length !=12&&AADHAR_NO !="") {
				inlineMsg('AADHAR_NO','Enter 12 digit Aadhaar No...',2);
				return false;
			  }*/
		  
		  if(PAN_NO.length !=10 && PAN_NO != "") {
			inlineMsg('PAN_NO','Invalid PAN CARD NO, Length Must be 10 alphanumberic',2);
			return false;
		  }	
	//}
  if(APP_PRIX == "") {
    inlineMsg('APP_PRIX','Select prefix of name from the list',2);
    return false;
  }
  
   if(APP_NAME == "") {
    inlineMsg('APP_NAME','You must enter your name.',2);
    return false;
  }
  
   if(!(AGENCY == "KV"||AGENCY == "KB"||AGENCY == "DI"||AGENCY == "CB")) {
    inlineMsg('AGENCY','Select Sponsoring Agency KVIC/KVIB/DIC',2);
    return false;
  }
  
 
 
  if(STATE == "-1") {
    inlineMsg('STATE','State Name Must be Selected......',2);
    return false;
  }
  
  if(DISTRICT == "-1") {
	  
    inlineMsg('DISTRICT','Select District Name......',2);
    return false;
  }
   
 
  
  var off_cd="-1";
  for (var i=0; i < document.form.OFF_CD.length; i++)
 {
   if (document.form.OFF_CD[i].checked)
   {
     off_cd=document.form.OFF_CD[i].value;
   }
 }
    if(off_cd=="-1") {
    inlineMsg('AGENCY','Select State,District and Agency automatically office Address will populate  then Select one Office',2);
    return false;
  }
  
  if(UNIT_LOC=="") {
    inlineMsg('UNIT_LOC','Select Unit Location Rural / Urban',2);
    return false;
  }
  
//alert(AGENCY);
//alert((vstatec.indexOf(STATE)));
/*
 if ((AGENCY !='CB') && (vstatec.indexOf(STATE) < 0)) {
  if ( UNIT_LOC=='Urban' && (AGENCY !='KB' || AGENCY !='DI')) {
    inlineMsg('AGENCY','For Unit Location at Urban Area in Delhi & Chandigarh-UT, Select KVIB as Sponsoring Agency ',2);
    return false;
  }*/
	
	/* if ( UNIT_LOC=='Urban' && (STATE =='DL' || STATE =='CH') )  {
if  (AGENCY == 'CB') {
    inlineMsg('AGENCY','For Unit Location at Urban Area, Select KVIB/KVIC/DIC as Sponsoring Agency',2);
   return false;
  }
 }
  
 if ((AGENCY !='CB') && (vstatec.indexOf(STATE) <=-1)) {
 if ( UNIT_LOC=='Urban' && AGENCY !='DI') {
    inlineMsg('AGENCY','For Unit Location in Urban Area, Select sponsoring Agency DIC ',2);
    return false;
  }
  }*/
   if(GENDER == "") {
    inlineMsg('GENDER','You must select your gender.',2);
    return false;
  }
  
  if(DOB == "") {
	  
    inlineMsg('DOB','Enter Date of Birth in DD-MON-YYYY Format',2);
    return false;
  }
 
 
  
 if(BENF_CATAGORY_CD=="") {
		  inlineMsg('BENF_CATAGORY_CD','Social Category Must be selected',2);
    return false;
	  }
	 
	  if(EDU_ID=="") {
    inlineMsg('EDU_ID','Please Select Educational Qualification',2);
    return false;
  }
  
 if(APP_POST_ADDR == "") {
    inlineMsg('APP_POST_ADDR','Must Enter Applicant Address',2);
    return false;
  }
 
 
  /*if(APP_DIST_CD == "") {
    inlineMsg('APP_DIST_CD','Must Enter Applicant District',2);
    return false;
  }*/
if(APP_TALUK_BLOCK == "") {
    inlineMsg('APP_TALUK_BLOCK','Must Enter Applicant Taluka/Block/City etc.',2);
    return false;
  }
  if(!numberOnly.test(APP_PIN))
    {
	    inlineMsg('APP_PIN','Enter Valid Pin Code 6 digit in numbers',2);
        return false;
    }
	if(APP_PIN.length !=6)
    {
	    inlineMsg('APP_PIN','Enter 6 digit PIN Code',2);
        return false;
    }
 
  if(!E_MAIL.match(emailRegex) && !E_MAIL == "") {
    inlineMsg('E_MAIL','<strong>Invalid e_Mail</strong><br />You have entered an invalid email.',2);
    return false;
  }
  if(!numberOnly.test(MOB_NO1))
    {
	    inlineMsg('MOB_NO1','Enter Valid mobile No. in numbers',2);
        return false;
    }
	if(MOB_NO1.length !=10)
    {
	    inlineMsg('MOB_NO1','Enter 10 digit Mobile No.',2);
        return false;
    }
  
 
  
 
   if(UNIT_POST_ADDR == "") {
    inlineMsg('UNIT_POST_ADDR','Must Enter Unit Address',2);
    return false;
  }
 if(UNIT_TALUK_BLOCK == "") {
    inlineMsg('UNIT_TALUK_BLOCK','Must Enter Applicant Taluka/Block/City etc.',2);
    return false;
  }
 if(UNIT_PIN == "") {
    inlineMsg('UNIT_PIN','Valid Pin Code Must Be Entered',2);
    return false;
  }
  
  
  if (IND_TYPE==""){
	inlineMsg('IND_TYPE','Select Industry Type Manufacturing/Service/Trading.......',2);
	return (false);
}
  
   if(ACTIVITY_CD == "" ) {
    inlineMsg('btnActList','Select the Industry & Activity from the list , In  Case No Suitable Industry Found, Select <strong> Other Industry </strong> from the List and Enter Product Description Manually',2);
    return false;
  }
  
  if(EDP_YN=="") {
    inlineMsg('EDP_YN','Select whether under gone EDP Training Yes/No',2);
    return false;
  }
 
  if(EDP_YN=="Y") {
	  
	  if(EDP_INST_ADDR == "") {
		  inlineMsg('EDP_INST_ADDR','Enter EDP Training Institution Name',2);
    return false;
	  }
  }//edp trg main
    
  

if (! proj_cal()){
	 return false;
	  }
  
 if(BANK_NAME == "" ) {
    inlineMsg('BANK_NAME',' Bank Name Must be Selected <Br>In Case: Bank Name not Found Select OTHER BANK From the List <Br> Enter Bank Name in the Branch Name',2);
    return false;
  }
  
  if(IFSC_CODE == "" ) {
    inlineMsg('btnBank',' Select IFS Code from List with Bank Address',2);
    return false;
  }
  
  if(BANK_POST_ADDR == "" ) {
    inlineMsg('BANK_POST_ADDR','Full Bank Address Must Be Entered/Select From RBI List....',2);
    return false;
  }
  
  if(BRANCH_NAME == "" ) {
    inlineMsg('BRANCH_NAME','Branch/Bank Name Must Be Entered...',2);
    return false;
  }
  
  if(BANK_DISTRICT == "" ) {
    inlineMsg('BANK_DISTRICT','Bank District Must Be Entered.',2);
    return false;
  }
  
 
 if(TECH_QUALI == "") {

 inlineMsg('TECH_QUALI','Select CGTSI Yes/No.',2);
	    return false;
  }
   if(BLDG_TYPE == "") {

inlineMsg('BLDG_TYPE','Select Where did you hear about PMEGP.',2);
	    return false;
  }

 
if(EMP_ENV == "") {
inlineMsg('EMP_ENV','You must enter your EMP_ENV.',2);
			return false;
		  }

if(!numberOnly.test(EMP_ENV)) {
				inlineMsg('EMP_ENV','Employment No should be in Number....',2);
				return false;
			  }
			  
			    if (EMP_ENV > 150){
			inlineMsg('EMP_ENV','No of Employment too large please verify ',2);
                    return false;
            }
			
			 if(MACHINARY_COST < 1 ) {
	  
    inlineMsg('MACHINARY_COST','Capital Expenditure should not be less than 1',2);
    return false;
  }
  
			  
if ((STATE == 'AR') || (STATE ==  'AS')||(STATE == 'MN')||(STATE ==  'MG') ||(STATE == 'SK')||(STATE == 'TR')||(STATE == 'NG')|| (STATE == 'MZ'))
	{
		var EMP_NS= (MACHINARY_COST%450000===0)?Math.round(MACHINARY_COST/450000):Math.round(( Number(MACHINARY_COST)+(450000-  (Number(MACHINARY_COST)   %Number  (450000))    ) )/450000) ;
		}
	//Math.round(TOTAL_PRJ/150000);}
	
	 if (STATE == 'AN') 
	{
		var EMP_NS= (MACHINARY_COST%450000===0)?Math.round(MACHINARY_COST/450000):Math.round(( Number(MACHINARY_COST)+(450000-  (Number(MACHINARY_COST)   %Number  (450000))    ) )/450000) ;
		}
	
		
	
	else
	{
	var EMP_NS= (MACHINARY_COST%300000===0)?Math.round(MACHINARY_COST/300000):Math.round(( Number(MACHINARY_COST)+(300000-  (Number(MACHINARY_COST)   %Number  (300000))    ) )/300000);
	}
	
 //alert(EMP_NS);
    if (EMP_ENV < EMP_NS){
			inlineMsg('EMP_ENV','No of Employment should be not less than '+ EMP_NS,2);
                    return false;
            }
 
return true;

}//end of function
// START OF MESSAGE SCRIPT //




function unitvalidation() {
	 var STATE = document.form.STATE.value;
     var AGENCY = document.form.AGENCY.value;
	 var UNIT_LOC = document.form.UNIT_LOC.value;
	
	}

var MSGTIMER = 20;
var MSGSPEED = 5;
var MSGOFFSET = 3;
var MSGHIDE = 3;

// build out the divs, set attributes and call the fade function //
function inlineMsg(target,string,autohide) {
  var msg;
  var msgcontent;
  if(!document.getElementById('msg')) {
    msg = document.createElement('div');
    msg.id = 'msg';
    msgcontent = document.createElement('div');
    msgcontent.id = 'msgcontent';
    document.body.appendChild(msg);
    msg.appendChild(msgcontent);
    msg.style.filter = 'alpha(opacity=0)';
    msg.style.opacity = 0;
    msg.alpha = 0;
  } else {
    msg = document.getElementById('msg');
    msgcontent = document.getElementById('msgcontent');
  }
  msgcontent.innerHTML = string;
  msg.style.display = 'block';
  var msgheight = msg.offsetHeight;
  var targetdiv = document.getElementById(target);
  targetdiv.focus();
  var targetheight = targetdiv.offsetHeight;
  var targetwidth = targetdiv.offsetWidth;
  var topposition = topPosition(targetdiv) - ((msgheight - targetheight) / 2);
  var leftposition = leftPosition(targetdiv) + targetwidth + MSGOFFSET;
  msg.style.top = topposition + 'px';
  msg.style.left = leftposition + 'px';
  clearInterval(msg.timer);
  msg.timer = setInterval("fadeMsg(1)", MSGTIMER);
  if(!autohide) {
    autohide = MSGHIDE;  
  }
  window.setTimeout("hideMsg()", (autohide * 3000));
}

// hide the form alert //
function hideMsg(msg) {
  var msg = document.getElementById('msg');
  if(!msg.timer) {
    msg.timer = setInterval("fadeMsg(0)", MSGTIMER);
  }
}

// face the message box //
function fadeMsg(flag) {
  if(flag == null) {
    flag = 1;
  }
  var msg = document.getElementById('msg');
  var value;
  if(flag == 1) {
    value = msg.alpha + MSGSPEED;
  } else {
    value = msg.alpha - MSGSPEED;
  }
  msg.alpha = value;
  msg.style.opacity = (value / 100);
  msg.style.filter = 'alpha(opacity=' + value + ')';
  if(value >= 99) {
    clearInterval(msg.timer);
    msg.timer = null;
  } else if(value <= 1) {
    msg.style.display = "none";
    clearInterval(msg.timer);
  }
}

// calculate the position of the element in relation to the left of the browser //
function leftPosition(target) {
  var left = 0;
  if(target.offsetParent) {
    while(1) {
      left += target.offsetLeft;
      if(!target.offsetParent) {
        break;
      }
      target = target.offsetParent;
    }
  } else if(target.x) {
    left += target.x;
  }
  return left;
}

// calculate the position of the element in relation to the top of the browser window //
function topPosition(target) {
  var top = 0;
  if(target.offsetParent) {
    while(1) {
      top += target.offsetTop;
      if(!target.offsetParent) {
        break;
      }
      target = target.offsetParent;
    }
  } else if(target.y) {
    top += target.y;
  }
  return top;
}

// preload the arrow //
if(document.images) {
  arrow = new Image(7,80); 
  arrow.src = "images/msg_arrow.gif"; 
}

function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<48||unicode>57) //if not a number
return false //disable key press
}
}
function tempSave() {
	
	 inlineMsg('btnSave','<Strong> Data Saved </Strong>',2);
	
	}
function rbilist_lov() 
{

i=document.form.BANK_NAME.selectedIndex;
vbankCode=document.form.BANK_NAME.options[i].value;  
vbankName=document.form.BANK_NAME.options[i].text; 
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
    
	if (vstate=='-1') {
		        
				 inlineMsg('STATE','<Strong> Select State Name for Unit  From the List </Strong>',2);
				
				 return (false);

		} else
	if (vbankCode=='-1'){
		 inlineMsg('BANK_NAME','Select Bank Name',2);
	//alert ('Please Select Bank Name');
	return(false);
	}else if (vbankName=='OTHER BANK') {
		 inlineMsg('BANK_NAME','For <Strong>OTHER BANK </strong> IFSC/BANK Code Not Required. Enter Bank Details Manully',2);
	return(false)
	 }else{
	 var mrl='APPRBIBANKLOV.jsp?BANKCODE='+vbankCode+'&BANK_NAME='+vbankName+'&state='+vstate;
	 window.open (mrl, "RBIEnlistedBanks","scrollbars=1,width=800,height=600");
	 return(false);
	 }
	
	 return(true);

}


function proj_cal(){
//i=document.form.BLDG_TYPE.selectedIndex; 
bl="";
//=document.form.BLDG_TYPE.options[i].value; 
i=document.form.IND_TYPE.selectedIndex; 
it=document.form.IND_TYPE.options[i].value; 
i=document.form.EDU_ID.selectedIndex; 
aq=document.form.EDU_ID.options[i].value; 
vws= 0;
//document.form.WORKSHED_COST.value ;
vmc= document.form.MACHINARY_COST.value;
vpoc=0;
//document.form.PRE_OPE_EXP.value ;
vwc= document.form.WORKING_CAPITAL.value ;
var vemp=0;
//Number(document.form.EMP_ENV.value);
tlprj=Number(vws)+Number(vmc)+Number(vpoc);
document.form.TOTAL_CE.value=tlprj;

tprj= Number(vws)+Number(vmc)+Number(vpoc)+Number(vwc);
document.form.TOTAL_PRJ.value=tprj;
//alert(tlprj);


/*
if (bl==""){
	inlineMsg('BLDG_TYPE','Select Building Type',2);
	return (false);
}

if (!(bl=="To construct") && (Number(vws)>0) ){
	inlineMsg('WORKSHED_COST','Workshed/Building Cost Required When Building Type is <Strong>To be Construct</Strong> Selected',2);
	return (false);
}
*/
if (tlprj<1 ){
	inlineMsg('MACHINARY_COST','Required Loan Amount Must be Entered......',2);
	return (false);
}

if (aq==""){
	inlineMsg('EDU_ID','Select Educational Qualification',2);
	return (false);
}

if (it==""){
	inlineMsg('IND_TYPE','Select Industry Type Manufacturing/Service/Trading.......',2);
	return (false);
}
// qualification validation
	// Under 8th 
 if (it=='M'  && aq=='5' && Number(tprj)>1000000){
	inlineMsg('TOTAL_PRJ','Total Project Cost for <Strong>Under 8th </Strong> for <Strong>Manufacturing Industry </Strong> should not exceed 10 lakhs',2);
	return (false);
}
// Under 8th 60% of ce

 if (it=='M'  && aq=='5' && Number(tlprj) < (60/100*Number(tprj))){
	inlineMsg('WORKING_CAPITAL',' FOR MANUFACTURING  UNIT  WORKING CAPITAL COMPONENT SHOULD NOT BE MORE THAN 40% OF THE TOTAL PJOECT COST.' ,2);
	return (false);
}



 if (it !='M' && aq=='5' && Number(tprj)>500000){
	inlineMsg('TOTAL_PRJ','Total Project Cost for <Strong>Under 8th </Strong> for <Strong>Service Industry </Strong> should not exceed 5 lakhs',2);
	return (false);
}

 if (it !='M'  && aq=='5' && Number(tlprj) < (40/100*Number(tprj))){
	inlineMsg('WORKING_CAPITAL','FOR SERVICE/TRADING UNIT  WORKING CAPITAL COMPONENT SHOULD NOT BE MORE THAN 60% OF THE TOTAL PJOECT COST.' ,2);
	return (false);
}

	

	//8th Pass and Above.
if (Number(tprj)>10000000){
	inlineMsg('TOTAL_PRJ','Total Project Cost for Micro Industry Unit should not exceed 1 corer',2);
	return (false);
}


/*	
if (it=='M' && Number(tprj)>5000000){
	inlineMsg('TOTAL_PRJ','Total Project Cost for Manufacturing Unit should not exceed 50 lakhs',2);
	return (false);
}
*/
 if (it=='M' &&  Number(tprj)>0 && Number(tlprj) < (60/100*Number(tprj))){
	inlineMsg('WORKING_CAPITAL','FOR MANUFACTURING  UNIT  WORKING CAPITAL COMPONENT SHOULD NOT BE MORE THAN 40% OF THE TOTAL PJOECT COST.' ,2);
	return (false);
}
/*
if (it!='M' && Number(tprj)>2000000){
		inlineMsg('TOTAL_PRJ','Total Project Cost for Service/Trade Unit should not exceed 20 lakhs',2);
return (false);
 }*/
 
  if (it !='M'  && Number(tprj)>0 && Number(tlprj) < (40/100*Number(tprj))){
	inlineMsg('WORKING_CAPITAL','FOR SERVICE/TRADING UNIT  WORKING CAPITAL COMPONENT SHOULD NOT BE MORE THAN 60% OF THE TOTAL PJOECT COST.' ,2);
	return (false);
}
 
	var result = Math.round(tlprj/100000*Math.pow(10,0))/Math.pow(10,0);
 return(true);
}//end of function


function copy_addres(){
document.form.UNIT_POST_ADDR.value=document.form.APP_POST_ADDR.value;
document.form.UNIT_TALUK_BLOCK.value=document.form.APP_TALUK_BLOCK.value;
document.form.UNIT_PIN.value=document.form.APP_PIN.value;
}

function copy_dist(){
i=document.form.DISTRICT.selectedIndex; 
vdistcd=document.form.DISTRICT.options[i].value; 
vdistval=document.form.DISTRICT.options[i].text; 
var distcd=document.form.APP_DIST_CD.value;
document.form.APP_DIST_CD.value=vdistcd;
document.form.UNIT_DIST_CD.value=vdistcd;
document.form.APP_DIST_NM.value=vdistval;
document.form.UNIT_DIST_NM.value=vdistval;
	}
	
	function isDate(txtDate) {
    var objDate,  // date object initialized from the txtDate string
        mSeconds, // txtDate in milliseconds
        day,      // day
        month,    // month
        year;     // year
    // date length should be 10 characters (no more no less)
    if (txtDate.length !== 10) {
        return false;
    }
    // third and sixth character should be '/'
    if (txtDate.substring(2, 3) !== '-' || txtDate.substring(5, 6) !== '-') {
        return false;
    }
    // extract month, day and year from the txtDate (expected format is mm/dd/yyyy)
    // subtraction will cast variables to integer implicitly (needed
    // for !== comparing)
    month = txtDate.substring(3, 5) - 1; // because months in JS start from 0
    day = txtDate.substring(0, 2) - 0;
    year = txtDate.substring(6, 10) - 0;
    // test year range
    if (year < 1000 || year > 3000) {
        return false;
    }
    // convert txtDate to milliseconds
    mSeconds = (new Date(year, month, day)).getTime();
    // initialize Date() object from calculated milliseconds
    objDate = new Date();
    objDate.setTime(mSeconds);
    // compare input date and parts from Date() object
    // if difference exists then date isn't valid
    if (objDate.getFullYear() !== year ||
        objDate.getMonth() !== month ||
        objDate.getDate() !== day) {
        return false;
    }
    // otherwise return true
    return true;
}

function checkDateAge(){
	var DOB='DOB';
    var t=document.getElementById(DOB+"").value;
        if (!isDate(t)){
    inlineMsg('DOB','<Strong><U>Invalid Date</U> </strong><br>Date Format should be DD-MM-YYYY <br> Ex:30-03-2011',2);
			}else{
				var now = new Date();
				bDay=t;
				bD = bDay.split('-');
				 born = new Date(bD[2], bD[1] * 1 - 1, bD[0]);
                 years = Math.floor((now.getTime() - born.getTime()) / (365.25 * 24 * 60 * 60 * 1000));
				 if (Number(years)<18){
				     inlineMsg('AGE','<Strong><U>Under Age:</U> </strong><br> Age Must be  18 Years or above..',2);

                 }
				 document.form.AGE.value=years;
				}

}
	

function edp_yn(){
	i=document.form.EDP_YN.selectedIndex; 
vedp=document.form.EDP_YN.options[i].value; 

if (vedp=="Y"){
document.form.EDP_INST_ADDR.disabled=false;
//document.form.EDP_INST_ADDR.style.backgroundColor='white'; 

}else{
	
//document.form.EDP_INST_ADDR.style.backgroundColor='#C0C0C0'; 
document.form.EDP_INST_ADDR.disabled=true;
		
			}
	
	
	}
	

	
	
	function RestrictSpecialChar(e)
    {
        var exp = String.fromCharCode(window.event.keyCode) 
        //var address=document.getElementById(txtName);
        var r = new RegExp("[-/\:().#,0-9a-zA-Z \r]", "g");
        if (exp.match(r) == null)
        {
            window.event.keyCode = 0;
            return false;
        }        
        
    }  
	
	function onlyDate(e)
    {
        var exp = String.fromCharCode(window.event.keyCode) 
        //var address=document.getElementById(txtName);
        var r = new RegExp("[-0-9 \r]", "g");
        if (exp.match(r) == null)
        {
            window.event.keyCode = 0;
            return false;
        }        
        
    }  