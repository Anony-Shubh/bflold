<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<HEAD>
<STYLE type="text/css">
.myButton {
	background-color:#4e73df;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}

* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
  
}



#customers td, #customers th {
    border: 1px solid #000000;
    padding: 4px;
	font-size:16px;
	font-weight:bold;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: #2e7d22;
    color: white;
}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.style1 {color: #FF0000}
</STYLE>

    <!-- Custom fonts for this template -->
    <LINK href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="../css/sb-admin-2.min.css" rel="stylesheet">

	
	
<SCRIPT src="../js/inlineMsgMain.js"></SCRIPT>

  <SCRIPT src="https://code.jquery.com/jquery-1.12.4.js"></SCRIPT>


  <SCRIPT>
  
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
 
function view1 ()
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
window.location.href = 'IAstatus.jsp?FROMDT='+frm+'&TODT='+toDT;
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
window.location.href = 'IAPending.jsp?FROMDT='+frm+'&TODT='+toDT;
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
window.location.href = 'BankDetail.jsp?FROMDT='+frm+'&TODT='+toDT;
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
window.location.href = 'Bstatus.jsp?FROMDT='+frm+'&TODT='+toDT;
}
  

</SCRIPT>


  
</HEAD>

<BODY>
<IMG src="../img/banner3.jpg" width="100%">
<FORM method="post" name="form" id="form">
<% 
String STATE_NM="";
String STATE_CD="";

String REC_NO = "";
String REC_MM = "";
String SANC_NO = "";
String SANC_MM = "";
String DISB_NO = "";
String DISB_MM = "";
String wcls="";
String srno ="";
String rFromdt="";
String rTodt="";

String YR=request.getParameter("YR")==null?"2020-21":(String) request.getParameter("YR");
String AGN=request.getParameter("AGN")==null?"ALL":(String) request.getParameter("AGN");
String vcls="";
if (!AGN.equals("ALL")){
vcls= vcls+ " and mom.agency_type='"+AGN+"' ";
}
else{
vcls= vcls+ " and mom.agency_type like '%%' ";
}


if (YR.equals("2016-17")) {
rFromdt ="1-APR-2016";
rTodt="31-MAR-2017";
}

if (YR.equals("2017-18")) {
rFromdt ="1-APR-2017";
rTodt="31-MAR-2018";}

if (YR.equals("2018-19")) {
rFromdt ="1-APR-2018";
rTodt="31-MAR-2019";
}
if (YR.equals("2019-20")) {
rFromdt ="1-APR-2019";
rTodt="31-MAR-2020";
}

if (YR.equals("2020-21")) {
rFromdt ="1-APR-2020";
rTodt="31-MAR-2021";
}

if (YR.equals("ALL")) {
rFromdt ="1-JUL-2016";
rTodt="31-MAR-2020";
}


 
 %>
 <br>
 <DIV align="center">			
	<A class="btn btn-primary" href="../index.jsp">Home</A>
	<A class="btn btn-primary" href="../index22.jsp">Summarized Report</A>
	<A class="btn btn-primary" href="../pmegp/index.jsp">Pending Reports</A>
    <A HIDDEN class="btn btn-primary" href="../analyticalrep.jsp">Analytical Reports</A>
	<A  class="btn btn-primary" href="../logout.jsp">Logout</A>
</DIV>
	
<CENTER>
    <H1>Pending Reports</H1>
   
  <TABLE width="50%" align="center">
  <TR>
    <TD><DIV align="center">Statements From* </DIV></TD>
    <TD><DIV align="center">
      <INPUT name="FROMDT" type="text" id="FROMDT" value="1-APR-2020" PLACEHOLDER="DD-MON-YYYY" >
    </DIV></TD>
    <TD><DIV align="center">to</DIV></TD>
    <TD><DIV align="center">
      <INPUT name="TODT" type="text" id="TODT"  value="" PLACEHOLDER="DD-MON-YYYY"  >
	        </DIV></TD>
  </TR>
</TABLE><BR>
</CENTER>


<DIV id="wrapper">
<TABLE align="center" cellpadding="2" cellspacing="10" width="50%" id="customers">

 <TR>
    <TD >1)Application Status with Implementing Agency </TD>
    <TD><DIV align="center">
      <INPUT name="button2" type="button" class="myButton" onClick="view1();"  value="View" >
    </DIV></TD>
  </TR>
   <TR>
    <TD>2)Status of Application Approved by Implementing Agency</TD>
    <TD><DIV align="center">
      <INPUT name="button2" type="button" class="myButton" onClick="view2();"  value="View" >
    </DIV></TD>
  </TR>
   <TR>
    <TD>3)Applications Handled by Bank </TD>
    <TD><DIV align="center">
      <INPUT name="button2" type="button" class="myButton" onClick="view3();"  value="View" >
    </DIV></TD>
  </TR>
   <TR >
    <TD>4)Status of Application with bank pending decision </TD>
    <TD><DIV align="center">
      <INPUT name="button2" type="button" class="myButton" onClick="view4();"  value="View" >
    </DIV></TD>
  </TR>
</TABLE>
   
</DIV>
<SCRIPT type="text/javascript">
$(function(){
  $('#keywords').tablesorter(); 
});
</SCRIPT>
</FORM>
</BODY>
</HTML>
