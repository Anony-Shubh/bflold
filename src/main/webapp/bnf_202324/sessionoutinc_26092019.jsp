
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


</style>

<div class="topnav">
  <a class="active" href="logout.jsp">LOGOUT</a>
   <a class="active" href="change_password.jsp">CHANGE PASSWORD</a>
  <a href="UM1.pdf" target="_blank">USER MANUAL </a>
  <% if (SFO_HO.equals("HO")) {%>
 <a href="bnfReportView.jsp">HO REPORT </a>
   <a href="fundposition.jsp">FUND POSITION</a>
  <a href="cotargetview.jsp">TARGET</a>
    <a href="drin.jsp">DETAILED REPORT</a>
  <%}%>
  <% if (!SFO_HO.equals("HO")) {%>
	<a href="fofunddetails.jsp">FUND DETAILS</a>
  <%}%>
<a href="applicant.jsp">PHYSICAL VERIFICATION</a>

    <a href="bnf_report.jsp">FO REPORT </a>
	<a href="dataentry.jsp">UPDATE PERFORMANCE</a>
	
    
  <a href="bnfHome.jsp">HOME</a>
 
</div>

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




