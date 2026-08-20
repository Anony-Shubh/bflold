<%

String vlogin =session.getAttribute("slogin")==null?"N":(String)session.getAttribute("slogin");
String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
String SFO_HO=session.getAttribute("SFO_HO")==null?"":(String)session.getAttribute("SFO_HO");
String SOFF_NAME1=session.getAttribute("SOFF_NAME1")==null?"":(String)session.getAttribute("SOFF_NAME1");	
String SSTATE_NM=session.getAttribute("SSTATE_NM")==null?"":(String)session.getAttribute("SSTATE_NM");	
String SZONE_NM=session.getAttribute("SZONE_NM")==null?"":(String)session.getAttribute("SZONE_NM");		
String SNO_BAL=session.getAttribute("SNO_BAL")==null?"":(String)session.getAttribute("SNO_BAL");		
String SAMT_BAL=session.getAttribute("SAMT_BAL")==null?"":(String)session.getAttribute("SAMT_BAL");		
String sselect=session.getAttribute("sselect")==null?"":(String)session.getAttribute("sselect");		
	
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


<table width="100%">
  <tr>
    <td hidden><%= SOFF_CD %></td>
    <td hidden><%= SFO_HO %></td>
    <td><%= SOFF_NAME1 %></td>
    <td><%= SSTATE_NM %></td>
    <td><%= SZONE_NM %></td>
  </tr>
</table>




