<%@ page contentType="text/html; charset=iso-8859-1" buffer="100kb" language="java"  import="javax.naming.*,java.sql.*,javax.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>MINISTRY REPORT</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>

  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

  <script>
 
  </script>
  <style>
  .buttongreenBu {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
  </style>
  
  
  
  <script>
  
  function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

return (showdt);
}
 
 function todaydt() {
 test = new Date()
document.getElementById("TODT").value=now();
 }


   $(document).ready(function() {
 
todaydt();
            //option A
            $("form").submit(function(e){
			if (document.form.ins !='I'){
               e.preventDefault(e);
			   showProduct();
			   }
            });
        });
 
  var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
 


    function view()
  {
	  
  var frm= document.getElementById("FROMDT").value;
  var toDT=document.getElementById("TODT").value;
   if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  if (toDT == "") {
  inlineMsg('toDT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/ministryjasper.jsp?REPNM=MINISTRYREPORT&FROMDT='+frm+'&TODT='+toDT;
}

  function viewall()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/ministryjasper.jsp?REPNM=MINISTRYREPORTALL&FROMDT='+frm+'&TODT='+toDT;
}
  
  
   function viewDayw()
  {
	  
  var frm= document.getElementById("FROMDT").value;
  var toDT=document.getElementById("TODT").value;
   if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  if (toDT == "") {
  inlineMsg('toDT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/ministryjasper.jsp?REPNM=daywiseminisRepo&FROMDT='+frm+'&TODT='+toDT;
}
 
  
  
  function viewAatma()
  {
	  
  var frm= document.getElementById("FROMDT").value;
  var toDT=document.getElementById("TODT").value;
   if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  if (toDT == "") {
  inlineMsg('toDT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/ministryjasper.jsp?REPNM=pmegpMinisAatma&FROMDT='+frm+'&TODT='+toDT;
}
 
  
  
  
  
  
  
  
  
  
  
 

   function viewallNITI()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/ministryjasper.jsp?REPNM=MINISTRYREPORT_NITI&FROMDT='+frm+'&TODT='+toDT;
}
  

  
  
  function view1()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minisjasperpdf.jsp?REPNM=IASTASTUS&FROMDT='+frm+'&TODT='+toDT;
}
  
 
 function view2()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minisjasperpdf.jsp?REPNM=IAPENDING&FROMDT='+frm+'&TODT='+toDT;
}
  
 function view3()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minisjasperpdf.jsp?REPNM=BANKDETAILREPO&FROMDT='+frm+'&TODT='+toDT;
}
  

 function view4()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minisjasperpdf.jsp?REPNM=BANKSTATUSMINIS&FROMDT='+frm+'&TODT='+toDT;
}
  

  
  function view5()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minis3Repojasper.jsp?REPNM=BANKREPO3ST&FROMDT='+frm+'&TODT='+toDT+'&QRY=1';
}
  

  
  function view6()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minis3Repojasper.jsp?REPNM=BANKREPO3ST&FROMDT='+frm+'&TODT='+toDT+'&QRY=2';
}
  
  
  
  function view7()
  {
  var frm= document.getElementById("FROMDT").value;
var toDT=document.getElementById("TODT").value;
 if (frm == "") {
  inlineMsg('FROMDT',"PLEASE ENTER FROM DATE (DD-MON-YYYY)",2);
    return false;
   }


if (frm != "") {
	if  (!dtRegex.test(frm)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
  }
  
   if (toDT == "") {
  inlineMsg('TODT',"PLEASE ENTER TO DATE (DD-MON-YYYY)",2);
    return false;
   }
  if (toDT != "") {
   if  (!dtRegex.test(toDT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
  }
  }
window.location.href = '../jasperrop/minis3Repojasper.jsp?REPNM=BANKREPO3ST&FROMDT='+frm+'&TODT='+toDT+'&QRY=3';
}
  
 
  
  
  </script>
<style type="text/css">
<!--
.style6 {color: #990000}
-->
</style>
</head>

<body>

<div id="header" align="center">
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
</div>

<p>
  <%


String FROMDT="";
String TODT="";

%>
</p>
<table width="50%" align="center" >
  <tr>
    <td><div align="center">Statements From* </div></td>
    <td><div align="center">
      <input name="FROMDT" type="text" id="FROMDT" value="1-APR-2020" placeholder="DD-MON-YYYY" >
    </div></td>
    <td><div align="center">to</div></td>
    <td><div align="center">
      <input name="TODT" type="text" id="TODT"  value="" placeholder="DD-MON-YYYY"  >
	        </div></td>
  </tr>
</table><br>
<p align="center">REPORTS MENU</p>
<table width="50%"  align="center">
  <tr bordercolor="#FFFFFF">
    <td colspan="2"><div align="center"><span class="style6">Select dates for (*)Marked Fields</span></div></td>
  </tr>
  
  <tr bordercolor="#FFFFFF">
    <th>1) For 104 Districts </th>
    <th><div align="center"><input type="button" class="button" onClick="view();" value="View" > </div>    </th>
  </tr>
  
  <tr bordercolor="#FFFFFF">
    <th>2) For All Districts </th>
    <th><div align="center"><input type="button" class="button" onClick="viewall();"  value="View" ></div></th> 
  </tr>
  <tr bordercolor="#FFFFFF">
    <th>3) For 115 Districts (NITI AAYOG) </th>
    <th><div align="center">
      <input name="button" type="button" class="button" onClick="viewallNITI();"  value="View" >
    </div></th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th>4) For 116 Districts (AATMA NIRBHAR BHARAT) </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="viewAatma();"  value="View" >
    </div></th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th>5) Bankwise Daywise Sanction </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="viewDayw();"  value="View" >
    </div></th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th>6)Application Status with Implementing Agency </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view1();"  value="View" >
    </div></th>
  </tr>
   <tr bordercolor="#FFFFFF">
    <th>7)Status of Application Approved by Implementing Agency</th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view2();"  value="View" >
    </div></th>
  </tr>
   <tr bordercolor="#FFFFFF">
    <th>8)Applications Handled by Bank </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view3();"  value="View" >
    </div></th>
  </tr>
   <tr bordercolor="#FFFFFF">
    <th>9)Status of Application with bank pending decision </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view4();"  value="View" >
    </div></th>
  </tr>
   <tr bordercolor="#FFFFFF">
    <th>10)Application sanctioned but pending for MM Claim </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view5();"  value="View" >
    </div></th>
  </tr>
   <tr bordercolor="#FFFFFF">
    <th>11)Claims Under Process </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view6();"  value="View" >
    </div></th>
  </tr>
   <tr bordercolor="#FFFFFF">
    <th>12)Claims ready for disbursement </th>
    <th><div align="center">
      <input name="button2" type="button" class="button" onClick="view7();"  value="View" >
    </div></th>
  </tr>
</table>


</body>
</html>
