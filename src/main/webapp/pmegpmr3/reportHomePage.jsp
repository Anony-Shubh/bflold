<HTML>
<HEAD>
<TITLE>PMEGP e-Tracking Monitoring Home Page</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK rel="stylesheet" type="text/css" href="css/indexr.css">
<SCRIPT type="text/javascript" src="js/jquery.js"></SCRIPT>
<SCRIPT type="text/javascript" src="js/datetimepicker.js"></SCRIPT>

<SCRIPT type="text/javascript" src="js/msgwindow.js"></SCRIPT>
<LINK rel="stylesheet" type="text/css" href="css/loadingbox.css">
<STYLE>
/* CSS Document */

@import url(https://fonts.googleapis.com/css?family=Open+Sans);
@import url(https://fonts.googleapis.com/css?family=Bree+Serif);

h1 {
	font-size: 60px;
	text-align: center;
	color: #FFF;
}	

h3 {
	font-size: 30px;
	text-align: center;
	color: #FFF;
}

h3 a {
	color: #FFF;
}

a {
	color: #FFF;
}

h1 {
	margin-top: 100px;
	text-align:center;
	font-size:60px;
	font-family: 'Bree Serif', 'serif';
	}

#container {
	margin: 0 auto;
}

p {
	text-align: center;
}

nav {
	margin: 10px 0;
	background-color: #d8c0d5;
	
}

nav ul {
	padding: 0;
 	margin: 0;
	list-style: none;
	position: relative;
	z-index: 6;
	}
	
nav ul li {
	display:inline-block;
	background-color: #d8c0d5;
	border: 1px solid black;
	
	}

nav a {
	display:block;
	padding:0 10px;	
	color:black;
	font-size:20px;
	line-height: 60px;
	text-decoration:none;
}

nav a:hover { 
	background-color: #000000; 
	color:#FFFFFF;
}

/* Hide Dropdowns by Default */
nav ul ul {
	display: none;
	position: absolute; 
	top: 60px; /* the height of the main nav */
}
	
/* Display Dropdowns on Hover */
nav ul li:hover > ul {
	display:inherit;
}
	
/* Fisrt Tier Dropdown */
nav ul ul li {
	width:auto;
	float:none;
	display:list-item;
	position: relative;
}

/* Second, Third and more Tiers	*/
nav ul ul ul li {
	position: relative;
	top:-60px; 
	left:170px;
}

	
/* Change this in order to change the Dropdown symbol */
li > a:after { content:  ' +'; }
li > a:only-child:after { content: ''; }
</STYLE>


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
document.getElementsByName("RTODATE")[0].value='31-MAR-2022';
}

else if  (vYR=='2022-23'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2022';
document.getElementsByName("RTODATE")[0].value='31-MAR-2023';
}

else if  (vYR=='2023-24'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2023';
document.getElementsByName("RTODATE")[0].value='31-MAR-2024';
}

else if  (vYR=='2024-25'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2024';
document.getElementsByName("RTODATE")[0].value='31-MAR-2025';
}
else if  (vYR=='2025-26'){
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
<%-- <%
out.println("Session ID: " + session.getId() + "<br>");
out.println("suser_detail = " + session.getAttribute("suser_detail") + "<br>");
out.println("sstate_cd = " + session.getAttribute("sstate_cd") + "<br>");
%> --%>
<%
String vsZonecd =session.getAttribute("szone")==null?"":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")==null?"":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")==null?"":(String) session.getAttribute("sstate_cd");
out.print(vsStatecd);
	   String vUsrnm= session.getAttribute("suser_detail")==null?"":(String) session.getAttribute("suser_detail");
	   
	   

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
	   <OPTION value="2025-26" selected>2025-26</OPTION>
	   <OPTION value="2024-25" >2024-25</OPTION>
	   <OPTION value="2023-24" >2023-24</OPTION>
	   <OPTION value="2022-23" >2022-23</OPTION>
	    <OPTION value="2021-22" >2021-22</OPTION>
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
           
		  </TR>
         
      </TABLE></TD>
    </TR>
  </TABLE>
		  
		  <DIV align="center">
    <nav>
        <UL>
			<LI><A href="#">Home </A></LI>
            <LI><A href="#">Report </A>
			<UL>
			<LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr1.jsp');" value="First Loan"></LI>
			<LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr2.jsp');" value="Second Loan"></LI><LI>
			</UL>
			</LI>
			
			
			 <LI><A href="#">ONLINE EDP </A>
			 <UL>
			<LI><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpsamadhanmis.jsp');" value="ONLINE EDP"></LI>
			</UL>
			</LI>
			<!-- <LI><A href="#">EDP </A>
			 <UL>
			<LI><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardedp.jsp');" value="EDP"></LI>
			</UL>
			</LI>-->
			 <LI><A href="#">Physical Verification</A>
			 <UL>
			<LI><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardgeoPhyREv.jsp');" value="Physical Verification">            
            </LI>
			</UL>
			</LI>
			 <LI><A href="#">Analysis </A>
			 <UL>
			<LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegAnalytical.jsp');" value="Analysis"></LI>
		 </UL>
		 </LI>
		 <LI><A href="#">PMEGP Award </A>
			 <UL>
			<LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpAward.jsp');" value="PMEGP Award"></LI>
		 </UL>
		 </LI>

		 <!--   <LI><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('PendingEdpSan.jsp');" value="Pending EDP Report"></th>-->
		  <LI><A href="#">Other Report</A>
		
		 <UL>
		  <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('PendingPmegpReport.jsp');" value="Pending Report"> </LI>
		  <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpofflinedashbr.jsp');" value="PMEGP Offline Report"> </LI>
		   <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('agencyscdashboard_new.jsp');" value="Score Card"> </LI>
		     <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pendingBankReport.jsp');" value="Bank Pending Report"> </LI>
			  <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardmr3.jsp');" value="Performance Report For SC ST"> </LI>
			 <LI><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('ValidePmegpReport.jsp');" value="Claim Detail Report"></LI>
		<!-- <LI> <input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardedpType.jsp');" value="Detail EDP Report"></LI>-->
		 <LI> <input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('jpv_reportview.jsp');" value="Joint PV"></LI>
		   
		  
		 <LI><A href="edpRepGenerate.jsp?REPNM=EDPTRAININGCENTERLIST&STATE_CD=<%=vsStatecd%>" >Download Edp Training List </A> </LI>
		  
		  <LI><%if(vsZonecd.equals("ALL") && vsAgency.equals("ALL") &&  vsStatecd.equals("ALL") ){%>
		  <INPUT name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pfms_report.jsp');" value="Pfms">
		  <%}%> </LI>
		   
           <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="javascript:window.open('../pmegpeportaltutorialdoc/mis_user_manual.pdf')" value="User Manual"> </LI>
		   <LI><input name="msreport"  id="msreport" class="button" type="button" onClick="openPage('pmegpdashboardGriv.jsp');" value="Grievance"></LI>
		   <LI><A href="generepexcel.jsp?REPNAME=apr202223" >APR (2022-23) </A> </LI> 
		  <!--  <LI><A href="generepexcel.jsp?REPNAME=MONTHWISE_SAM" >samadhan edp payment </A> </LI> -->
			 <LI><A href="generepexcel.jsp?REPNAME=newinterest" >Bankwise Intrest Rate </A> </LI>
         <!--  <LI><INPUT name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('AgencyMRFAQ.jsp');" value="FAQ"> </LI>
		 
		 <input name="msreport"  id="msreport" class="button" type="button" onClick="STATEREPO1();" value="Other Report">-->     
		  </UL>
		  </LI>
		  <LI><A href="logout.jsp">Logout </A></LI>
		 
		  </UL>
         </nav>
</DIV>
 
  <CENTER>
<DIV id="divResult" >

Please Read the User Manual Before Using the System.................................
</DIV>
</CENTER>
 </FORM>
</BODY>
</HTML>



