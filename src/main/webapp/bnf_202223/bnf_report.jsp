<%@ page contentType="text/html; charset=iso-8859-1" buffer="100kb" language="java"  import="javax.naming.*,java.sql.*,javax.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>FO::REPORT</title>
<link rel="stylesheet" type="text/css" href="main1.css">
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/tdemes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
 
  <script>
  function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMontd()+1;
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

  

  </script>
<style type="text/css">
.myButton {
	background-color:#2e823c;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
</style>
</head>

<body>
<form  name="form" id="form" method="post" >
<div align="center">
 <%@ include file = "sessionoutinc.jsp" %>

  <%

//String USER_TYPE=SUSER_TYPE;
String OFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
String FROMDT="1-APR-2018";
String TODT="";

%> 
<H2>FO REPORTS</H2>
</div>
<!--<table width="58%" align="center">
  <tr>
    <td><div align="center">Statements From </div></td>
    <td><div align="center">
      <input name="FROMDT" type="text" id="FROMDT"  value="<%=FROMDT%>" autocomplete="off" onClick="popUpCalendar(this, this.form.FROMDT,'dd-mmm-yyyy');return false;">
</div></td>
    <td><div align="center">to</div></td>
    <td><div align="center">
      <input name="TODT" type="text" id="TODT"  value="<%=TODT%>"  autocomplete="off" onClick="popUpCalendar(this, this.form.TODT,'dd-mmm-yyyy');return false;">
	       </div></td>
  </tr>
</table>-->
<table width="39%"  align="center" id="customers2">
  <tr bordercolor="#FFFFFF">
    <th colspan="3"><div align="center">REPORTS MENU</div></th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td width="10%" nowrap><DIV align="center">1</DIV></td>
    <td width="60%" nowrap><DIV align="center">Monthly Progress Report </DIV></td>
    <td width="30%"><div align="center"><a href="jasperReports/bnfreportach.jsp?REPNM=MPR_BFL&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=0" class="myButton" target="_blank">View</a></div>    </td>
    <!--	<a href="../kimisreports/Accounts/GenerateRepAccount.jsp?REPNAME=list_of_accountsMast&CUSTCODE=<%//= CUSTCODE%>" class="buttonMerun" target="_blank">View</a> -->
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">2</DIV></td>
    <td><DIV align="center">EDP</DIV></td>
    <td>
      <div align="center">
        <a href="jasperReports/bnfreportach.jsp?REPNM=EDPREPO&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=1" class="myButton" target="_blank">View</a>
		<!--.-->
        </div></td></tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">3</DIV></td>
    <td><DIV align="center">Physical Verification</DIV></td>
    <td><div align="center">  <a href="jasperReports/bnfreportach.jsp?REPNM=EDPREPO&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=2" class="myButton" target="_blank">View</a>
            <!--jasperReports/bnfreportach.jsp?REPNM=&OFF_CD=<%=OFF_CD%>&QRYCODE=0-->
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td nowrap><DIV align="center">4</DIV></td>
    <td nowrap><DIV align="center">Dist. Level Awareness Camps</DIV></td>
    <td>
      <div align="center">
       <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=3" class="myButton" target="_blank">View</a>        </div></td></tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">5</DIV></td>
    <td><DIV align="center">State Level Workshop</DIV></td>
    <td>
      <div align="center">
       <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=4" class="myButton" target="_blank">View</a>        </div></td></tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">6</DIV></td>
    <td><DIV align="center">Dist. Level Exhibitions</DIV></td>
    <td>
      <div align="center">
       <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=5" class="myButton" target="_blank">View</a>        </div></td></tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">7</DIV></td>
    <td><DIV align="center">State Level Exhibition</DIV></td>
    <td><div align="center">
    <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=6" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">8</DIV></td>
    <td><DIV align="center">Zonal Level Exhibition</DIV></td>
    <td><div align="center">
     <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=7" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">9</DIV></td>
    <td><DIV align="center">Zonal Level Review Meeting</DIV></td>
    <td><div align="center">
     <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=8" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td nowrap><DIV align="center">10</DIV></td>
    <td nowrap><DIV align="center">Quarterly Bankers Review Meeting</DIV></td>
    <td><div align="center">
      <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=9" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td nowrap><DIV align="center">11</DIV></td>
    <td nowrap><DIV align="center">State Level Monitoring Committee Meeting</DIV></td>
    <td><div align="center">
      <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=10" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">12</DIV></td>
    <td><DIV align="center">Staff Training Workshops</DIV></td>
    <td><div align="center">
      <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=11" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">13</DIV></td>
    <td><DIV align="center">TA/DA of staff &amp; officers</DIV></td>
    <td><div align="center">
    <a href="jasperReports/bnfreportach.jsp?REPNM=TA_DA&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=12" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">14</DIV></td>
    <td><DIV align="center">PROMOTIONAL AND PUBLICITY</DIV></td>
    <td><div align="center">
      <a href="jasperReports/bnfreportach.jsp?REPNM=PUBLICITY&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=13" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td><DIV align="center">15</DIV></td>
    <td><DIV align="center">Data Entry Operators</DIV></td>
    <td>
      <div align="center">
	     <a href="jasperReports/bnfreportach.jsp?REPNM=EDPREPO&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=14" class="myButton" target="_blank">View</a>
     <!-- <a href="../jasperrop/bnf_report.jsp?REPNM=MPR_BFL&OFF_CD=<%=OFF_CD%>&QRYCODE=0" class="buttonGreen" target="_blank">View</a>-->
		</div></td></tr>
	  <tr bordercolor="#FFFFFF" >
	    <td><DIV align="center">16</DIV></td>
    <td><DIV align="center">Consolidated utlisition of Fund</DIV></td>
    <td>
      <div align="center">
	  
	     <a href="jasperReports/bnfreportach.jsp?REPNM=ACH&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=15" class="myButton" target="_blank">View</a>
     <!-- <a href="../jasperrop/bnf_report.jsp?REPNM=MPR_BFL&OFF_CD=<%=OFF_CD%>&QRYCODE=0" class="buttonGreen" target="_blank">View</a>-->
		</div></td>
	</tr>	
		  <tr bordercolor="#FFFFFF" >
		    <td><DIV align="center">17</DIV></td>
    <td><DIV align="center">Allocation and Utilisition of Fund </DIV></td>
    <td>
      <div align="center">
	  	     <a href="jasperReports/GenerateXLS.jsp?REPNM=BNFALLO_ACHV&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>" class="myButton">Download</a>
     <!-- <a href="../jasperrop/bnf_report.jsp?REPNM=MPR_BFL&OFF_CD=<%=OFF_CD%>&QRYCODE=0" class="buttonGreen" target="_blank">View</a>-->
		</div></td>
		
		</tr>
		
		  <tr bordercolor="#FFFFFF">
    <td nowrap><DIV align="center">18</DIV></td>
    <td nowrap><DIV align="center">District Level Monitoring Committee Meeting</DIV></td>
    <td><div align="center">
      <a href="jasperReports/bnfreportach.jsp?REPNM=reportbnf&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&QRYCODE=45" class="myButton" target="_blank">View</a>
    </div></td>
  </tr>
			 
</table>
</form>
</body>
</html>
