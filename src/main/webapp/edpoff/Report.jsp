<%@ page contentType="text/html; charset=iso-8859-1" buffer="100kb" language="java"  import="javax.naming.*,java.sql.*,javax.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>GRIVANCES REPORT</title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="../js/inlineMsgMain.js"></script>

  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

  <script>
 
  </script>
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
  var GRV_TYPE=document.getElementById("GRV_TYPE").value;
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
window.location.href = 'edpRepGenerate.jsp?REPNM=EDPTRAINING&FROMDT='+frm+'&TODT='+toDT+'&GRV_TYPE='+GRV_TYPE;
}

 
 
  
  
  </script>
<style type="text/css">
<!--
.style6 {color: #990000}
-->
</style>
</head>

<body>



<p>
  <%


String FROMDT="";
String TODT="";

%>
</p>
  <%@include file="includeHeaderedp.jsp"%><BR/>
<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <td><div align="center">Statements From* </div></td>
    <td><div align="center">
      <input name="FROMDT" type="text" id="FROMDT" value="31-AUG-2020" placeholder="DD-MON-YYYY" >
    </div></td>
    <td><div align="center">to</div></td>
    <td><div align="center">
      <input name="TODT" type="text" id="TODT"  value="" placeholder="DD-MON-YYYY"  >
	        </div></td>
    <td>Edp Training Mode :</td>
    <td><select name="GRV_TYPE" id="GRV_TYPE">
	  <option value="0" selected="selected"> ALL</option>
      <option value="1"> Paid Online EDP</option>
      <option value="2"> Free Online EDP</option>
	    <option value="3">Paid Offline EDP</option>		
		 <option value="4">Free Offline EDP </option>
		
      </select></td>
  </tr>
</table>
<br/>
<table  width="50%" border="1" cellpadding="3" cellspacing="3" class="bordered" align="center">

  
  <tr bordercolor="#FFFFFF">
   
    <th  colspan="2"><div align="center">
	
	<input type="button" class="button"  onClick="view();" value="Download Pmegp Applicant Details" > </div>   </th>
  </tr>
  
 
</table>


</body>
</html>
