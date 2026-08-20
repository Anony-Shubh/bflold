<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>BNF HOMEPAGE</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">

<STYLE type="text/css">
<!--
.style3 {font-size: 36px}
-->
</STYLE>
</HEAD>

<BODY>
<%@ include file = "sessionoutinc.jsp" %>

<CENTER>
<BR>
<BR>
<H1 style="font-family:'Lucida Calligraphy'">WELCOME! <BR>User Details:</H1>
  <TABLE width="63%" height="188" align="center" id="customers2">
 
  <TR>
    <TD width="20%"><DIV align="right"><SPAN style="font-family:'Castellar'">OFFICE CODE :</SPAN></DIV></TD>
    <TD width="20%"><DIV align="left"><SPAN style="font-family:'Castellar'"><%= SOFF_CD %></SPAN></DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="right"><SPAN style="font-family:'Castellar'">TYPE : </SPAN></DIV></TD>
    <TD><DIV align="left"><SPAN style="font-family:'Castellar'"><%= SFO_HO %></SPAN></DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="right"><SPAN style="font-family:'Castellar'">Office Name :</SPAN></DIV></TD>
    <TD><DIV align="left"><SPAN style="font-family:'Castellar'"><%= SOFF_NAME1 %></SPAN></DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="right"><SPAN style="font-family:'Castellar'">State :</SPAN></DIV></TD>
    <TD><DIV align="left"><SPAN style="font-family:'Castellar'"><%= SSTATE_NM %></SPAN></DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="right"><SPAN style="font-family:'Castellar'">Zone : </SPAN></DIV></TD>
    <TD><DIV align="left"><SPAN style="font-family:'Castellar'"><%= SZONE_NM %></SPAN></DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="right"><SPAN style="font-family:'Castellar'">Financial Year : </SPAN></DIV></TD>
    <TD><DIV align="left"><SPAN style="font-family:'Castellar'" class="style3"><%= sselect %></SPAN></DIV></TD>
  </TR>  
</TABLE>




<H1 style="font-family:'Castellar'">&nbsp;</H1>
<H2 hidden>&nbsp;</H2>
<H2 style="font-family:'Castellar'">&nbsp;</H2>
</CENTER>

</BODY>
</HTML>
