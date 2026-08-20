
<img src="../images/01.jpg" width="100%" height="23%" />
<%

String vlogin =session.getAttribute("slogin")==null?"N":(String)session.getAttribute("slogin");
String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
String SFO_HO=session.getAttribute("SFO_HO")==null?"":(String)session.getAttribute("SFO_HO");
String SOFF_NAME1=session.getAttribute("SOFF_NAME1")==null?"":(String)session.getAttribute("SOFF_NAME1");	
String SSTATE_NM=session.getAttribute("SSTATE_NM")==null?"":(String)session.getAttribute("SSTATE_NM");	
String SZONE_NM=session.getAttribute("SZONE_NM")==null?"":(String)session.getAttribute("SZONE_NM");		
String SNO_BAL=session.getAttribute("SNO_BAL")==null?"":(String)session.getAttribute("SNO_BAL");		
String SAMT_BAL=session.getAttribute("SAMT_BAL")==null?"":(String)session.getAttribute("SAMT_BAL");		
String SSTATE_CD=session.getAttribute("SSTATE_CD")==null?"":(String)session.getAttribute("SSTATE_CD");		
String sselect=session.getAttribute("sselect")==null?"":(String)session.getAttribute("sselect");
String SSTATEALLOWED=session.getAttribute("SSTATEALLOWED")==null?"":(String)session.getAttribute("SSTATEALLOWED");			
		
if (vlogin.equals("N")) {

response.sendRedirect("soutmsg.jsp");
}
%>
<style>
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}


.myButton23 {
	-moz-box-shadow:inset 0px 1px 0px 0px #a6827e;
	-webkit-box-shadow:inset 0px 1px 0px 0px #a6827e;
	box-shadow:inset 0px 1px 0px 0px #a6827e;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7d5d3b), color-stop(1, #634b30));
	background:-moz-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-webkit-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-o-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:-ms-linear-gradient(top, #7d5d3b 5%, #634b30 100%);
	background:linear-gradient(to bottom, #7d5d3b 5%, #634b30 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7d5d3b', endColorstr='#634b30',GradientType=0);
	background-color:#7d5d3b;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	border:1px solid #54381e;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:7px 12px;
	text-decoration:none;
	text-shadow:0px 1px 0px #4d3534;
}
.myButton23:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #634b30), color-stop(1, #7d5d3b));
	background:-moz-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-webkit-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-o-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:-ms-linear-gradient(top, #634b30 5%, #7d5d3b 100%);
	background:linear-gradient(to bottom, #634b30 5%, #7d5d3b 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#634b30', endColorstr='#7d5d3b',GradientType=0);
	background-color:#634b30;
}
.myButton23:active {
	position:relative;
	top:1px;
}

.mygreen {
	background-color:#990000;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:7px 12px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}


</style>

<center>
<br />

  <a class="myButton23"  href="bnfHome.jsp">HOME</a>
	<a class="myButton23"  href="dataentry.jsp">UPDATE PERFORMANCE</a>
    <a class="myButton23"  href="bnf_report.jsp">FO REPORT </a>
  <a class="myButton23"  href="applicant.jsp">PHYSICAL VERIFICATION</a>
   <% if (!SFO_HO.equals("HO")) {%>
<!--  <a   href="samadhan_view.jsp" class="mygreen" style="background-color:#9933CC;">ONLINE EDP PAYMENT</a>-->
  <a   href="bnf_ucview.jsp" class="mygreen" >ONLINE UC</a>
  
  <%} else {%>
   <a   href="houcView.jsp" class="mygreen" >ONLINE UC REPORT </a>
<!--   <a  href="#" class="mygreen" >ONLINE EDP PAYMENT</a>-->
   <%}%>
  <% if (!SFO_HO.equals("HO")) {%>
	<a class="myButton23"  href="fofunddetails.jsp">FUND DETAILS</a>
  <%}%>
	  <% if (SFO_HO.equals("HO")) {%>
	      <a class="myButton23"  href="drin.jsp">DETAILED REPORT</a>
  <a class="myButton23"  href="cotargetview.jsp">TARGET</a>
    <a class="myButton23"  href="fundposition.jsp">FUND POSITION</a>
 <a class="myButton23" href="bnfReportView.jsp">HO REPORT </a>
  <%}%>
  <a class="myButton23"  href="UM1.pdf" target="_blank">USER MANUAL </a>
   <a class="myButton23" href="change_password.jsp">CHANGE PASSWORD</a>
  <a class="myButton23" href="logout.jsp">LOGOUT</a>


    
 
</center>

<div style="padding-left:16px">
 
</div> 	


<br />
<table width="100%" border="1">
  <tr>
    <td hidden><div align="center"><%= SOFF_CD %></div></td>
    <td hidden><div align="center"><%= SFO_HO %></div></td>
	<td><div align="center"><%= sselect %></div></td>
    <td><div align="center"><%= SOFF_NAME1 %></div></td>
    <td><div align="center"><%= SSTATE_NM %></div></td>
    <td><div align="center"><%= SZONE_NM %></div></td>
	
  </tr>
</table>




