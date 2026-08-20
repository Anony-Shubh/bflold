<html>
<head>
<TITLE>PMEGP e-Tracking Monitoring Home Page</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="css/indexr.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/datetimepicker.js"></script>

<script type="text/javascript" src="js/msgwindow.js"></script>
<link rel="stylesheet" type="text/css" href="css/loadingbox.css">
<script type="text/javascript">
function dateChange(){
vYR=document.getElementsByName("SEL_YEAR")[0].value
var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

if (vYR=='2016-17'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2016';
document.getElementsByName("RTODATE")[0].value='31-MAR-2017';
}else if  (vYR=='2017-18'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2017';
document.getElementsByName("RTODATE")[0].value='31-MAR-2018';
}
else if  (vYR=='2018-19'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2018';
document.getElementsByName("RTODATE")[0].value='31-MAR-2019';
}
else if  (vYR=='2019-20'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2019';
document.getElementsByName("RTODATE")[0].value=showdt;
}




}

$.hideprogress = function()
{
    $("#processing_container").remove();
    $("#processing_overlay").remove();
}

function urlparam(){
var vfrdt=document.getElementsByName("RFROMDT")[0].value;
var vtodt=document.getElementsByName("RTODATE")[0].value;
var pars   ='?FROMDT=' + vfrdt+ '&TODT=' + vtodt;
return(pars);
//alert (pars);
}

function fillinbox(repnm){
     $.showprogress('PMEGP e-Tracking Monitoring Report','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post(repnm+urlparam(),{action:'PMEGP Monitoring Report Loading...',page:'1'},
         function(ret){
          $("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
     // $.hideprogress();
}

function openPage(repnm){
       
  location.href=repnm+urlparam();    
}

</script>

</head>

<body onLoad="dateChange();">
<%
String vsZonecd =session.getAttribute("szone")==null?"":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency_type")==null?"":(String) session.getAttribute("sagency_type");
String vsStatecd =session.getAttribute("sstate_cd")==null?"":(String) session.getAttribute("sstate_cd");
out.print(vsAgency+"vsAgency");
String voffname=(String) session.getAttribute("off_name");
	   String vUsrnm= (String) session.getAttribute("suser_detail");
	  

	     String vooff_cd= (String) session.getAttribute("off_cd");

	   if (vooff_cd.equals(null)||vooff_cd.equals("")) {
	   response.sendRedirect("index.jsp");	
	  }
%>
 <form name="form1" method="post">

<table width="1008" align="center">
    <tr>
      <th colspan="9"><img src="../images/pmegponline.jpg" width="1200" height="204"></th>
    </tr>
    <tr>
      <td colspan="9"><div align="center"><img src="../images/pmegpetrackN.png" width="699" height="83">
      </div></td>
    </tr>
    <tr>
      <th colspan="9" nowrap><div align="center">Login  User ( <%= voffname %>)</div></th>
    </tr>
    <tr>
      <td ><div align="right"> Year</div></td>
      <td ><select name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
	   <option value="2019-20" selected>2019-20</option>
	    <option value="2018-19">2018-19</option>
	   <option value="2017-18">2017-18</option>
	   <option value="2016-17" >2016-17</option>
	  
      
                  </select></td>
      <td> <div align="right">From Date: </div></td>
      <td >
        <input name="RFROMDT" type="text"  id="RFROMDT" onClick="javascript:NewCal('RFROMDT','ddmmmyyyy')" size="11" maxlength="11"> </td>
      <td ><div align="right">To </div></td>
      <td  colspan="4">
      <input name="RTODATE" type="text"  id="RTODATE" onClick="javascript:NewCal('RTODATE','ddmmmyyyy')" size="11" maxlength="11"></td>
    </tr>
    
    <tr>
      <td colspan="9"><table width="1000" align="center" cellpadding="4" cellspacing="4">
        <tr>
          <th>
		  <div align="center"><a href="../PMEGPAgencyHomePage.jsp" target="_blank" class="button">Home</a></div>

		</th>
          <th>
		  
		  <input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr1.jsp');" value="Report"></th>
		  <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('PendingPmegpReport.jsp');" value="Pending Report"></th>

		     <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pendingBankReport.jsp');" value="Bank Pending Report"></th>
          <th><input name="msreport"  id="msreport" class="button" type="button" onClick="javascript:location.replace('logout.jsp')" value="Logout"></th>
        
        </tr>
      </table>
	  </td>
    </tr>
  </table>
 
  <center>
<div id="divResult" >

Please Read the User Manual Before Using the System.................................
</div>
</center>
 </form>
</body>
</html>



