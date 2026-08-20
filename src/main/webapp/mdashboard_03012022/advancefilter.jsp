<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%@ include file="includesessionpage.jsp" %>
<HTML>
<HEAD>
<TITLE></TITLE>
    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

<SCRIPT type="text/javascript" src="js/datetimepicker_css.js"></SCRIPT>
    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

<SCRIPT src="../js/jquery-customselect.js"></SCRIPT>

</HEAD>


<BODY>

<% DBCon db= new DBCon();
db.connect();

String AGENTYPE= session.getAttribute("AGENTYPE")==null?"":(String) session.getAttribute("AGENTYPE");
String FROMDT= session.getAttribute("FROMDT")==null?"":(String) session.getAttribute("FROMDT");
String TODT= session.getAttribute("TODT")==null?"":(String) session.getAttribute("TODT");

%>

<TABLE id="customers" width="95%" align="center">


<TR>
  <TH colspan="4"><DIV align="center">Advanced Filter </DIV></TH>
  </TR>

<TR>
  <TD width="20%">Agency</TD>
  <TD colspan="3">
<SELECT id="AGENTYPE" name="AGENTYPE">
<OPTION value="">All</OPTION>
<OPTION value="KVIC" <% if(AGENTYPE.equals("KVIC")){out.print("SELECTED");} %>>KVIC</OPTION>
<OPTION value="KVIB" <% if(AGENTYPE.equals("KVIB")){out.print("SELECTED");} %>>KVIB</OPTION>
<OPTION value="DIC" <% if(AGENTYPE.equals("DIC")){out.print("SELECTED");} %>>DIC</OPTION>
<OPTION value="COIR" <% if(AGENTYPE.equals("COIR")){out.print("SELECTED");} %>>COIR</OPTION>
</SELECT>  </TD>
  </TR>
<TR>
  <TD>From Date </TD>
  <TD width="30%"><INPUT name="FROMDT" type="text" id="FROMDT" value="<%= FROMDT %>" onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')"  maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="From date"></TD>
  <TD width="24%">To Date </TD>
  <TD width="26%"><INPUT name="TODT" type="text" id="TODT" value="<%= TODT %>" onClick="javascript:NewCssCal('TODT','ddMMMyyyy')"  maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="To date"></TD>
</TR>
<TR>
  <TD>State</TD>
  <TD>
  <SELECT>
         <OPTION value="">State</OPTION>
          <OPTION value="">All</OPTION>
         <OPTION value="AP">ANDHRA PRADESH</OPTION>
           <OPTION value="AR">ARUNACHAL PRADESH</OPTION>
           <OPTION value="AS">ASSAM</OPTION>
           <OPTION value="BH">BIHAR</OPTION>
           <OPTION value="GO">GOA</OPTION>
           <OPTION value="GJ">GUJARAT</OPTION>
           <OPTION value="HY">HARYANA</OPTION>
           <OPTION value="HP">HIMACHAL PRADESH</OPTION>
          
           <OPTION value="JK">JAMMU KASHMIR</OPTION>
           <OPTION value="KN">KARNATAKA</OPTION>
           <OPTION value="KL">KERALA</OPTION>
          
           <OPTION value="MP">MADHYA PRADESH</OPTION>
           <OPTION value="MH">MAHARASHTRA</OPTION>
           <OPTION value="MN">MANIPUR</OPTION>
          <OPTION value="MG">MEGHALAYA</OPTION>
          <OPTION value="OR">ODISHA</OPTION>
          <OPTION value="PJ">PUNJAB</OPTION>
          <OPTION value="RJ">RAJASTHAN</OPTION>
          <OPTION value="SK">SIKKIM</OPTION>
           <OPTION value="TN">TAMIL NADU</OPTION>
           <OPTION value="TR">TRIPURA</OPTION>
           <OPTION value="UP">UTTAR PRADESH</OPTION>
           <OPTION value="WB">WEST BENGAL</OPTION>
           <OPTION value="AN">ANDAMAN NICOBAR</OPTION>
           <OPTION value="CH">CHANDIGARH-UT</OPTION>
           <OPTION value="DN">DADRA NAGAR HAVELI</OPTION>
           <OPTION value="DD">DAMAN AND  DIU</OPTION>
           <OPTION value="DL">DELHI</OPTION>
          
          <OPTION value="LD">LAKSHADWEEP</OPTION>
          <OPTION value="PY">PUDUCHERRY</OPTION>
          <OPTION value="NG">NAGALAND</OPTION>
          <OPTION value="MZ">MIZORAM</OPTION>
          <OPTION value="UT">UTTARAKHAND</OPTION>
          <OPTION value="CG">CHHATTISGARH</OPTION>
          <OPTION value="JD">JHARKHAND</OPTION>
          <OPTION value="TG">TELANGANA</OPTION>
          <OPTION value="LK">LADAKH (UT)</OPTION>
     </SELECT>  </TD>
  <TD>District</TD>
  <TD>&nbsp;</TD>
</TR>
<TR>
  <TD>Social Category </TD>
  <TD>
  <SELECT name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
          <OPTION value="" selected>-Social Category-</OPTION>
          <OPTION value="GEN">General</OPTION>
          <OPTION value="OBC">Other Backward Caste</OPTION>
          <OPTION value="SC">Scheduled Caste</OPTION>
          <OPTION value="ST">Scheduled Tribe</OPTION>
          <OPTION value="MN">Minority</OPTION>
      </SELECT>  </TD>
  <TD>Special Social Category </TD>
  <TD>
  <SELECT name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
          <OPTION value="" selected>-Special Category-</OPTION>
          <OPTION value="NA" selected>Not Applicable</OPTION>
          <OPTION value="EX">Ex-Serviceman</OPTION>
          <OPTION value="PH">Physically Challenged</OPTION>
          <OPTION value="HA">Hill Boarder Region</OPTION>
          <OPTION value="NE">North East Region</OPTION>
      </SELECT>  </TD>
</TR>
<TR>
  <TD>Financing Bank </TD>
  <TD>
  <SELECT name="BANK_NAME"  id="BANK_NAME" class="custom-select">
          <OPTION value="-1" >-Select Bank Name-</OPTION>
          <%
String qrystr="";
   qrystr="SELECT DISTINCT (TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A WHERE A.ACT_YN = 'Y' ORDER BY (TRIM(UPPER(A.BANK_NAME)))";
	 ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   %>
          <OPTION value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></OPTION>
          <% } 
	  rs.close();
	   %>
        </SELECT>  </TD>
  <TD>Project Range </TD>
  <TD><INPUT type="text" ></TD>
</TR>
<TR>
  <TD>Gender</TD>
  <TD>
  <SELECT name="GENDER" class="button" id="GENDER">
          <OPTION value="" selected>Select</OPTION>
          <OPTION value ="Male">Male</OPTION>
          <OPTION value ="Female">Female</OPTION>
          <OPTION value="Transgender">Transgender</OPTION>
      </SELECT>  </TD>
  <TD>Industry Type </TD>
  <TD>&nbsp;</TD>
</TR>

<TR>
  <TD colspan="4"><DIV align="center">
    <INPUT type="submit" >
  </DIV></TD>
  </TR>
</TABLE> 



</BODY>
</HTML>
