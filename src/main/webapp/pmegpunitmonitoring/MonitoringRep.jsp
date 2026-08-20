<%
String  VAPP_ID =  request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
if ( !VAPP_ID.equals("") ) {
session.setAttribute("SAPP_ID",VAPP_ID);
}
%>
<style type="text/css">
<!--
.style1 {
	color: #004000;
	font-weight: bold;
}
-->
</style>

<table width="100%"  align="center" class="pmegpTable">
  <tr>
    <td><a href="Entrepreneur_Prof.jsp" class="buttonMerun">ENTREPRENEUR PROFILE</a></td>
    <td><a href="Mont_ProjectProfile.jsp" class="buttonMerun">PROJECT PROFILE</a></td>
    <td><a href="monitoring.jsp" class="buttonMerun">MONITORING REPORT </a></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center">&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
