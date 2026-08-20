<html>
<head>
<TITLE>PMEGP e-Tracking Monitoring Home Page</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<link rel="stylesheet" type="text/css" href="css/indexr.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/msgwindow.js"></script>
<link rel="stylesheet" type="text/css" href="css/loadingbox.css">

<style>
.redLebel
{
 color:#FF0000;
 font-size:24px;
 font-weight:bold;

}

</style>

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

 if  (vYR=='ALL'){
document.getElementsByName("RFROMDT")[0].value='01-JUL-2016';
document.getElementsByName("RTODATE")[0].value=showdt;
}


 if  (vYR=='2016-17'){
document.getElementsByName("RFROMDT")[0].value='01-JUL-2016';
document.getElementsByName("RTODATE")[0].value='31-MAR-2017';
}

 if  (vYR=='2017-18'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2017';
document.getElementsByName("RTODATE")[0].value='31-MAR-2018';
}

 if  (vYR=='2018-19'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2018';
document.getElementsByName("RTODATE")[0].value='31-MAR-2019';
}

 if  (vYR=='2019-20'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2019';
document.getElementsByName("RTODATE")[0].value='31-MAR-2020';
}

if  (vYR=='2020-21'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2020';
document.getElementsByName("RTODATE")[0].value='31-MAR-2021';
}
if  (vYR=='2021-22'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2021';
document.getElementsByName("RTODATE")[0].value='31-MAR-2022';
}

if  (vYR=='2022-23'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2022';
document.getElementsByName("RTODATE")[0].value='31-MAR-2023';
}

if  (vYR=='2023-24'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2023';
document.getElementsByName("RTODATE")[0].value='31-MAR-2024';
}
if  (vYR=='2024-25'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2024';
document.getElementsByName("RTODATE")[0].value='31-MAR-2025';
}

if  (vYR=='2025-26'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2025';
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
     $.showprogress('PMEGP ePortal  Monitoring Report Of Bank ','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post(repnm+urlparam(),{action:'PMEGP ePortal Bank Monitoring Report Loading...',page:'1'},
         function(ret){
          $("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
    // $.hideprogress();
}

function fillinSq(repnm){
     $.showprogress('PMEGP ePortal  Monitoring Report Of Bank ','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post(repnm+urlparam(),{action:'PMEGP ePortal Bank Monitoring Report Loading...',page:'1'},
         function(ret){
          $("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
     $.hideprogress();
}



function printDiv(divID) {
            //Get the HTML of div
            var divElements = document.getElementById(divID).innerHTML;
            //Get the HTML of whole page
            var oldPage = document.body.innerHTML;

            //Reset the page's HTML with div's HTML only
            document.body.innerHTML = 
              "<html><head><title></title></head><body>" + 
              divElements + "</body>";

            //Print Page
            window.print();

            //Restore orignal HTML
            document.body.innerHTML = oldPage;

          
        }
</script>
<style type="text/css">
<!--
.style6 {color: #A05454; font-weight: bold; }
-->
</style>
</head>

<body onLoad="dateChange();">
<%
	  
	   String vUsrnm= (String) session.getAttribute("sponc_banknm");
	 	   
	   if (vUsrnm.equals(null)||vUsrnm.equals("")) {
	   response.sendRedirect("index.jsp");	
	   }
%>
 <form name="form1" method="post">
<img src="../images/pmegponlineN.jpg" width="100%">
<table align="center" width="100%">
    <tr>
      <th colspan="9"></th>
    </tr>
    <tr>
      <td colspan="9"><div align="center">
        <span class="style6"><img src="../images/pmegpetrackN.png" width="699" height="83"></span>      </div></td>
    </tr>
      <th colspan="9" nowrap><div align="center" class="headings"><strong>Login  User ( <%= vUsrnm %>)</strong></div></th>
    </tr>
    <tr>
      <td ><div align="right"> Year</div></td>
      <td ><select name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
	   <option value="ALL" >ALL YEAR</option>
        <option value="2016-17">2016-17</option>
		  <option value="2017-18" >2017-18</option>
		   <option value="2018-19">2018-19</option>
		      <option value="2019-20" >2019-20</option>
			   <option value="2020-21" >2020-21</option>
			     <option value="2021-22">2021-22</option> 
				  <option value="2022-23"  >2022-23</option>  
 <option value="2023-24" >2023-24</option> 
<option value="2024-25"  >2024-25</option>  
<option value="2025-26" selected >2025-26</option>  
                  </select></td>
      <td> <div align="right">From Date: </div></td>
      <td >
        <input name="RFROMDT" type="text"  id="RFROMDT" size="13" maxlength="11"> </td>
      <td ><div align="right">To </div></td>
      <td  colspan="4">
      <input name="RTODATE" type="text"  id="RTODATE" size="14" maxlength="11"></td>
    </tr>
    
    <tr>
      <td colspan="9"><table  align="center" cellpadding="4" cellspacing="4" width="100%">
        <tr>
          <th><input name="msreport"  id="msreport" class="button" type="submit"  value="Home"></th>
          <th>
		  
		  <input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('pmegpbankmr.jsp');" value="Report"></th>

		   <th> <input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('pmegpbankmrSecond.jsp');" value="Second Loan Report"></th>
		 <!-- <th> <input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('bankDataDownload.jsp');" value="BulkReport"></th>-->
		  <th><input name="msreport"  id="msreport" class="button" type="button" onClick="javascript:window.open('misc/bankmonitoring_usermanual.pdf')" value="User Manual"></th>
          <th><input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('BankMRFAQ.jsp');" value="FAQ"></th>
		   <th><input name="msreport"  id="msreport" class="button" type="button" onClick="location.replace('FindByID.jsp');" value="FindBy TranAcno"></th>
          <th><input name="msreport"  id="msreport" class="button" type="button" onClick="location.replace('logout.jsp')" value="Logout"></th>
        </tr>
      </table></td>
    </tr>
  </table>
  <h1 align="center" class="redLebel">Note:At a time only 65000 data can be downloaded.</h1>
  <h1 align="center">&nbsp;</h1>
  <h1 align="center">PMEGP Portal MIS Report for Bank</h1>
  </center>
  </p>
  <center>
<div id="divResult" >
</div>
</center>
 </form>
</body>
</html>



