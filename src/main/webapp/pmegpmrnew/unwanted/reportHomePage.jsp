<HTML>
<HEAD>
<TITLE>PMEGP e-Tracking Monitoring Home Page</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK rel="stylesheet" type="text/css" href="css/indexr.css">
<SCRIPT type="text/javascript" src="js/jquery.js"></SCRIPT>
<SCRIPT type="text/javascript" src="js/datetimepicker.js"></SCRIPT>

<SCRIPT type="text/javascript" src="js/msgwindow.js"></SCRIPT>
<LINK rel="stylesheet" type="text/css" href="css/loadingbox.css">

<SCRIPT type="text/javascript">

function STATEREPO()
 {
  var frm= document.getElementById("RFROMDT").value;
var to=document.getElementById("RTODATE").value;
//alert(frm);
window.location.href = '../jasperrop/GenerateMinis.jsp?REPNAME=pmegpMinisRepo&FROMDT='+frm+'&TODT='+to;
 }
 function STATEREPO1()
 {
  var frm= document.getElementById("RFROMDT").value;
var to=document.getElementById("RTODATE").value;
//alert(frm);
window.location.href = '../jasperrop/GenerateMinis.jsp?REPNAME=SANC_PEN_MM&FROMDT='+frm+'&TODT='+to;
 }

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
document.getElementsByName("RTODATE")[0].value='31-MAR-2020';
}

else if  (vYR=='2020-21'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2020';
document.getElementsByName("RTODATE")[0].value='31-MAR-2021';
}

else if  (vYR=='2021-22'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2021';
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

</SCRIPT>

</HEAD>

<BODY onLoad="dateChange();">
<%
String vsZonecd =session.getAttribute("szone")==null?"":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")==null?"":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")==null?"":(String) session.getAttribute("sstate_cd");
out.print(vsStatecd);
	   String vUsrnm= (String) session.getAttribute("suser_detail");
	   
	   

	   if (vUsrnm.equals(null)||vUsrnm.equals("")) {
	   response.sendRedirect("index.jsp");	
	   }
%>
 <FORM name="form1" method="post">

<TABLE width="1008" align="center">
    <TR>
      <TH colspan="9"><IMG src="../images/pmegponline.jpg" width="1200" height="204"></TH>
    </TR>
    <TR>
      <TD colspan="9"><DIV align="center"><IMG src="../images/pmegpetrackN.png" width="699" height="83">
      </DIV></TD>
    </TR>
    <TR>
      <TH colspan="9" nowrap><DIV align="center">Login  User ( <%= vUsrnm %>)</DIV></TH>
    </TR>
    <TR>
      <TD ><DIV align="right"> Year</DIV></TD>
      <TD ><SELECT name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
	   <OPTION value="2021-22" selected>2021-22</OPTION>
	    <OPTION value="2020-21" >2020-21</OPTION>
	   <OPTION value="2019-20">2019-20</OPTION>
	    <OPTION value="2018-19">2018-19</OPTION>
	   <OPTION value="2017-18">2017-18</OPTION>
	   <OPTION value="2016-17" >2016-17</OPTION>
	  
      
                  </SELECT></TD>
      <TD> <DIV align="right">From Date: </DIV></TD>
      <TD >
        <INPUT name="RFROMDT" type="text"  id="RFROMDT" onClick="javascript:NewCal('RFROMDT','ddmmmyyyy')" size="11" maxlength="11"> </TD>
      <TD ><DIV align="right">To </DIV></TD>
      <TD  colspan="4">
      <INPUT name="RTODATE" type="text"  id="RTODATE" onClick="javascript:NewCal('RTODATE','ddmmmyyyy')" size="11" maxlength="11"></TD>
    </TR>
    
    <TR>
      <TD colspan="9"><TABLE width="1000" align="center" cellpadding="4" cellspacing="4">
        <TR>
          <TH><INPUT name="msreport"  id="msreport" class="button" type="submit"  value="Home"></TH>
          <TH>
		  
		  <INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr1.jsp');" value="Report"></TH>
		  <th><input name="msreport"  id="msreport" class="button" type="button" onClick="STATEREPO();" value="DistrictWise Report"></th>
		   <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardedp.jsp');" value="EDP"></th>
		    <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardgeoPhy.jsp');" value="Physical Verification"></th>
		 <!--  <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('PendingEdpSan.jsp');" value="Pending EDP Report"></th>-->
		   <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardedpType.jsp');" value="Detail EDP Report"></th>
		   <th><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardGriv.jsp');" value="Grievance"></th>
		  <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('agencyscdashboard_new.jsp');" value="Score Card"></TH>
		  <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('PendingPmegpReport.jsp');" value="Pending Report"></TH>
		   <th><input name="msreport"  id="msreport" class="button" type="button" onClick="STATEREPO1();" value="Other Report"></th>
		  <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegAnalytical.jsp');" value="Analysis"></TH>
		  <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr2.jsp');" value="Second Loan"></TH>
		     <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pendingBankReport.jsp');" value="Bank Pending Report"></TH>
		   <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr3.jsp');" value="Performance Report For SC ST"></TH>
          <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="javascript:window.open('../pmegpeportaltutorialdoc/mis_user_manual.pdf')" value="User Manual"></TH>
         <!-- <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('AgencyMRFAQ.jsp');" value="FAQ"></TH>-->
          <TH><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="javascript:location.replace('logout.jsp')" value="Logout"></TH>
          <TH><A href="edpRepGenerate.jsp?REPNM=EDPTRAININGCENTERLIST&STATE_CD=<%=vsStatecd%>"  class="button">Download Edp Training List </A></TH>
          <TH><%if(vsZonecd.equals("ALL") && vsAgency.equals("ALL") &&  vsStatecd.equals("ALL") ){%>
		  <INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pfms_report.jsp');" value="Pfms">
		  <%}%></TH>
        </TR>
      </TABLE></TD>
    </TR>
  </TABLE>
 
  <CENTER>
<DIV id="divResult" >

Please Read the User Manual Before Using the System.................................
</DIV>
</CENTER>
 </FORM>
</BODY>
</HTML>



