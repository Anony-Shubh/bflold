<%@ include file="includeHeaderPageDLTFC.jsp" %>
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<%@ page import="in.gov.mgov.SMSServices"%>


<HTML>
<HEAD>

<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />


<STYLE type="text/css">
<!--
.style1 {color: #FF0000}
-->
</STYLE>
</HEAD>

<BODY>
<FORM name="form1"  method="Post">
<% 
//String BEN_CD =  (String) session.getAttribute("SUSERID");
	 String STRID =  (String) session.getAttribute("STRID");
	 	 String SOTP =  (String) session.getAttribute("SOTP");
		 
		
	
	
%>




<TABLE align="center">
  <TR>
    <TD colspan="2">    </TD>
  </TR>

  <TR > 
    <TH colspan="2" > <DIV align="center" class="GreenLebel">
      <H2 class="style1">Approver Details not yet  registered       </H2>
    </DIV></TH>
    </TR>  

		
	
	<TR>
    <TH ><DIV align="right">1):</DIV></TH>
    <TD ><A href="agencyUpdate.jsp" ><h2>Click on Approver registration</h2></A>	</TD>
    </TR>
		<TR>
    <TH ><DIV align="right">2):</DIV></TH>
    <TD ><h2>Enter Approver name,designation,mobile no and email id</h2></TD>
    </TR>
		<TR>
    <TH ><DIV align="right">3):</DIV></TH>
    <TD ><h2>Click on send OTP</h2></TD>
    </TR>
		<TR>
    <TH ><DIV align="right">4):</DIV></TH>
    <TD ><h2>OTP will be sent to the registered mobile no</h2></TD>
    </TR>
		<TR>
    <TH ><DIV align="right">5):</DIV></TH>
    <TD ><h2>Enter OTP</h2></TD>
    </TR>
		<TR>
    <TH ><DIV align="right">6):</DIV></TH>
    <TD ><h2>After successful verification of OTP, physical verification details will be displayed</h2></TD>
    </TR>
	<TR>
    <TH colspan="2" >
          </TH>
    </TR>

	
   
      <TR > 
        
    <TH colspan="2" nowrap>
      <DIV align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </DIV></TH>
      </TR>
</TABLE>

</FORM>
</BODY>
</HTML>

