<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE></TITLE>
    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" re<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE></TITLE>
    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

</HEAD>


<BODY>




<IMG src="img/banner3.jpg" width="100%" > 
<BR><BR>
	
  <%
List values=new ArrayList();
String STATE_NM=request.getParameter("STATE_NM")==null?"MH":(String)request.getParameter("STATE_NM");
String STATE_CD=request.getParameter("STATE_CD")==null?"MH":(String)request.getParameter("STATE_CD");
String id=request.getParameter("id")==null?"":(String)request.getParameter("id");

String DLEVEL=request.getParameter("DLEVEL")==null?"":(String)request.getParameter("DLEVEL");

String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":(String)request.getParameter("DISTRICT_CD");
String DISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"":(String)request.getParameter("DISTRICT_NAME");

String OFF_NAME1 = "";
String TOTAL_NO_APP_BANKREJ = "";
String NOT_VIAABLE_NO = "";

String NOT_VIAABLE_NO_PER = "";
String TARGET_ACHIEV = "";
String TARGET_ACHIEV_PER = "";
String OUT_SERV_AREA = "";
String OUT_SERV_AREA_PER = "";
String APP_NOTINST = "";
String APP_NOTINST_PER = "";
String CIBIL = "";
String CIBIL_PER = "";
String DEFAULTER = "";
String DEFAULTER_PER = "";
String EXIST_UNIT = "";
String EXIST_UNIT_PER = "";
String OWN_CON = "";
String OWN_CON_PER = "";
String INADQ_KNWLD = "";
String INADQ_KNWLD_PER = "";
String ACT_NEG = "";
String ACT_NEG_PER = "";
String GOV_EMP = "";
String GOV_EMP_PER = "";
String DOC_INCOMP = "";
String DOC_INCOMP_PER = "";
String PMEGP_LOAN_AVAIL = "";
String PMEGP_LOAN_AVAIL_PER = "";
String IMP_APP = "";
String IMP_APP_PER = "";
String REV_APP = "";
String REV_APP_PER = "";
String OTHER_BANK = "";
String OTHER_BANK_PER = "";
String OTHER_REASON = "";
String OTHER_REASON_PER = "";
String RET_APP = "";
String RET_APP_PER = "";


String wcls="";
String srno ="";
String rFromdt="";
String rTodt="";

String YR=request.getParameter("YR")==null?"2020-21":(String) request.getParameter("YR");
String AGENCY=request.getParameter("Agency")==null?"":(String) request.getParameter("Agency");
String ORG =request.getParameter("Org")==null?"":(String) request.getParameter("Org"); 
String AGN=request.getParameter("AGN")==null?"":(String) request.getParameter("AGN");
String vcls="";
String Wcls="";
/*if (!AGN.equals("ALL")) {
Wcls= Wcls+ " and mom.agency_type='"+AGN+"'  ";
}
else{

Wcls= Wcls+ " and mom.agency_type like '%%'  ";

}

if (!AGENCY.equals("TOTAL")) {
vcls= vcls+ " and ms.state_nm='"+AGENCY+"' and RBI.bank_name='"+ORG+"' ";
}
else{

vcls= vcls+ " and ms.state_nm like '%%' and RBI.bank_name='"+ORG+"'  ";

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
*/

 StringBuffer qrysb= new StringBuffer();

qrysb.append("    SELECT "      );

if(DLEVEL.equals("2")){
qrysb.append("   NVL(STATE_NM,'TOTAL') AS OFF_NAME1,"      );
}
if(DLEVEL.equals("3")){
qrysb.append("     DISTRICT_NAME,  DISTRICT_CD,    "      );
}
qrysb.append("     TOTAL_NO_APP_BANKREJ,NOT_VIAABLE_NO, ROUND((NOT_VIAABLE_NO/TOTAL_NO_APP_BANKREJ)*100,2) AS NOT_VIAABLE_NO_PER,"      );
qrysb.append("      TARGET_ACHIEV,"      );
qrysb.append("      ROUND((TARGET_ACHIEV/TOTAL_NO_APP_BANKREJ)*100,2) AS TARGET_ACHIEV_PER,"      );
qrysb.append("      OUT_SERV_AREA,"      );
qrysb.append("      ROUND((OUT_SERV_AREA/TOTAL_NO_APP_BANKREJ)*100,2) AS OUT_SERV_AREA_PER,"      );
qrysb.append("      APP_NOTINST,"      );
qrysb.append("      ROUND((APP_NOTINST/TOTAL_NO_APP_BANKREJ)*100,2) AS APP_NOTINST_PER,"      );
qrysb.append("      CIBIL,"      );
qrysb.append("      ROUND((CIBIL/TOTAL_NO_APP_BANKREJ)*100,2) AS CIBIL_PER,"      );
qrysb.append("      DEFAULTER,"      );
qrysb.append("      ROUND((DEFAULTER/TOTAL_NO_APP_BANKREJ)*100,2) AS DEFAULTER_PER,"      );
qrysb.append("      EXIST_UNIT,"      );
qrysb.append("      ROUND((EXIST_UNIT/TOTAL_NO_APP_BANKREJ)*100,2) AS EXIST_UNIT_PER,"      );
qrysb.append("      OWN_CON,"      );
qrysb.append("      ROUND((OWN_CON/TOTAL_NO_APP_BANKREJ)*100,2) AS OWN_CON_PER,"      );
qrysb.append("      INADQ_KNWLD,"      );
qrysb.append("      ROUND((INADQ_KNWLD/TOTAL_NO_APP_BANKREJ)*100,2) AS INADQ_KNWLD_PER,"      );
qrysb.append("      ACT_NEG,"      );
qrysb.append("      ROUND((ACT_NEG/TOTAL_NO_APP_BANKREJ)*100,2) AS ACT_NEG_PER,"      );
qrysb.append("      GOV_EMP,"      );
qrysb.append("      ROUND((GOV_EMP/TOTAL_NO_APP_BANKREJ)*100,2) AS GOV_EMP_PER,"      );
qrysb.append("      DOC_INCOMP,"      );
qrysb.append("      ROUND((DOC_INCOMP/TOTAL_NO_APP_BANKREJ)*100,2) AS DOC_INCOMP_PER,"      );
qrysb.append("      PMEGP_LOAN_AVAIL,"      );
qrysb.append("      ROUND((PMEGP_LOAN_AVAIL/TOTAL_NO_APP_BANKREJ)*100,2) AS PMEGP_LOAN_AVAIL_PER,"      );
qrysb.append("      IMP_APP,"      );
qrysb.append("      ROUND((IMP_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS IMP_APP_PER,"      );
qrysb.append("      REV_APP,"      );
qrysb.append("      ROUND((REV_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS REV_APP_PER,"      );
qrysb.append("      OTHER_BANK,"      );
qrysb.append("      ROUND((OTHER_BANK/TOTAL_NO_APP_BANKREJ)*100,2) AS OTHER_BANK_PER,"      );
qrysb.append("      OTHER_REASON,"      );
qrysb.append("      ROUND((OTHER_REASON/TOTAL_NO_APP_BANKREJ)*100,2) AS OTHER_REASON_PER,"      );
qrysb.append("       RET_APP,"      );
qrysb.append("      ROUND((RET_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS RET_APP_PER "      );
qrysb.append("      FROM"      );
qrysb.append("      (SELECT MS.STATE_NM,   MD.DISTRICT_NAME,  MD.DISTRICT_CD , COUNT(AD.APP_ID) AS TOTAL_NO_APP_BANKREJ,"      );




qrysb.append("      SUM(CASE WHEN RM.REJ_ID=42 THEN 1 ELSE 0 END) AS NOT_VIAABLE_NO,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=41 THEN 1 ELSE 0 END) AS TARGET_ACHIEV,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=40 THEN 1 ELSE 0 END) AS OUT_SERV_AREA,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=33 THEN 1 ELSE 0 END) AS APP_NOTINST,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=35 THEN 1 ELSE 0 END) AS CIBIL,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=36 THEN 1 ELSE 0 END) AS DEFAULTER,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=37 THEN 1 ELSE 0 END) AS EXIST_UNIT,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=45 THEN 1 ELSE 0 END) AS OWN_CON,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=38 THEN 1 ELSE 0 END) AS INADQ_KNWLD,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=31 THEN 1 ELSE 0 END) AS ACT_NEG,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=32 THEN 1 ELSE 0 END) AS GOV_EMP,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=44 THEN 1 ELSE 0 END) AS DOC_INCOMP,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=43 THEN 1 ELSE 0 END) AS PMEGP_LOAN_AVAIL,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=15 THEN 1 ELSE 0 END) AS IMP_APP,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=16 THEN 1 ELSE 0 END) AS REV_APP,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=34 THEN 1 ELSE 0 END) AS OTHER_BANK,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=39 OR RM.REJ_ID IS NULL THEN 1 ELSE 0 END) AS OTHER_REASON,"      );
qrysb.append("      SUM(CASE WHEN RM.REJ_ID=14 OR RM.REJ_ID IS NULL THEN 1 ELSE 0 END) AS RET_APP "      );
qrysb.append("      FROM BANK_DATAENTRY BD,"      );
qrysb.append("      APP_DETAIL AD,MAS_OFF_MAST MOM,REJECTION_MAST RM,M_DISTRICT MD,M_STATE MS"      );
qrysb.append("      WHERE AD.APP_ID=BD.APP_ID(+) "      );
qrysb.append("      AND AD.OFF_CD=MOM.OFF_CD"      );
qrysb.append("      AND BD.REJ_ID=RM.REJ_ID"      );
qrysb.append("      AND ad.unit_dist_cd=MD.DISTRICT_CD"      );
qrysb.append("      AND MD.STATE_CD=MS.STATE_CD"      );

if(DLEVEL.equals("2")){
qrysb.append("   AND MS.STATE_CD='"+STATE_CD+"'  "      );
}
if(DLEVEL.equals("3")){
qrysb.append("   AND MD.DISTRICT_CD='"+DISTRICT_CD+"'  "      );
}
qrysb.append("   "      );
qrysb.append("      AND BD.ACT_ID=3"      );

if(DLEVEL.equals("2")){
qrysb.append("   GROUP BY ROLLUP(MS.STATE_NM),  MD.DISTRICT_NAME, MD.DISTRICT_CD   "      );
}
if(DLEVEL.equals("3")){
qrysb.append("   GROUP BY  MS.STATE_NM, MD.DISTRICT_NAME, MD.DISTRICT_CD "      );
}

qrysb.append("      )"      );

//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();

//values.add(STATE_CD);

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
 
  <%if(DLEVEL.equals("1")){%>
 <DIV align="center"><A class="btn btn-primary" href="index22.jsp">Back</A></DIV>
<%}%>
 <%if(DLEVEL.equals("2")){%>
 <DIV align="center"><A class="btn btn-primary" href="index22_stnew.jsp">Back</A></DIV>
<%}%>
 <%if(DLEVEL.equals("3")){%>
 <DIV align="center"><A class="btn btn-primary" href="index22_ds.jsp?STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>">Back</A></DIV>
<%}%>

 <%if(DLEVEL.equals("1")){%>
 <DIV align="center"><h2>INDIA</h2></DIV>
<%}%>
 <%if(DLEVEL.equals("2")){%>
 <DIV align="center"><h2><%= STATE_NM %></h2></DIV>
<%}%>
 <%if(DLEVEL.equals("3")){%>
 <DIV align="center"><h2><%= DISTRICT_NAME %> , <%= STATE_NM %></h2></DIV>
<%}%>

<INPUT name="STATE_CD" type="hidden" id="STATE_CD" value="<%= STATE_CD %>">
 <INPUT type="hidden" name="bookId" value=""/>
 
 
<CENTER>
  <H3>Application Rejected/Returned by Bank</H3>
</CENTER>

<%= srno %>

<DIV id="wrapper">
<TABLE id="customers" width="70%" align="center">
 <THEAD>
    <TR>
	 <TH rowspan="2"><DIV align="center">Sr No</DIV></TH>
	 <TH rowspan="2"><DIV align="center">Particulars</DIV></TH>
    </TR>
    <TR>
      <TH><DIV align="center">No of Prj </DIV></TH>
      <TH><DIV align="center">in %</DIV></TH>
    </TR>
   </THEAD>
  
<TBODY>
<% 
int cnt=0;
 while (rsMain.next()) { 
 



   if(DLEVEL.equals("2")){
 OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
 }
 TOTAL_NO_APP_BANKREJ=rsMain.getString("TOTAL_NO_APP_BANKREJ")==null?"":rsMain.getString("TOTAL_NO_APP_BANKREJ");
 NOT_VIAABLE_NO=rsMain.getString("NOT_VIAABLE_NO")==null?"":rsMain.getString("NOT_VIAABLE_NO");
 NOT_VIAABLE_NO_PER=rsMain.getString("NOT_VIAABLE_NO_PER")==null?"":rsMain.getString("NOT_VIAABLE_NO_PER");
 TARGET_ACHIEV=rsMain.getString("TARGET_ACHIEV")==null?"":rsMain.getString("TARGET_ACHIEV");
 TARGET_ACHIEV_PER=rsMain.getString("TARGET_ACHIEV_PER")==null?"":rsMain.getString("TARGET_ACHIEV_PER");
 OUT_SERV_AREA=rsMain.getString("OUT_SERV_AREA")==null?"":rsMain.getString("OUT_SERV_AREA");
 OUT_SERV_AREA_PER=rsMain.getString("OUT_SERV_AREA_PER")==null?"":rsMain.getString("OUT_SERV_AREA_PER");
 APP_NOTINST=rsMain.getString("APP_NOTINST")==null?"":rsMain.getString("APP_NOTINST");
 APP_NOTINST_PER=rsMain.getString("APP_NOTINST_PER")==null?"":rsMain.getString("APP_NOTINST_PER");
 CIBIL=rsMain.getString("CIBIL")==null?"":rsMain.getString("CIBIL");
 CIBIL_PER=rsMain.getString("CIBIL_PER")==null?"":rsMain.getString("CIBIL_PER");
 DEFAULTER=rsMain.getString("DEFAULTER")==null?"":rsMain.getString("DEFAULTER");
 DEFAULTER_PER=rsMain.getString("DEFAULTER_PER")==null?"":rsMain.getString("DEFAULTER_PER");
 EXIST_UNIT=rsMain.getString("EXIST_UNIT")==null?"":rsMain.getString("EXIST_UNIT");
 EXIST_UNIT_PER=rsMain.getString("EXIST_UNIT_PER")==null?"":rsMain.getString("EXIST_UNIT_PER");
 OWN_CON=rsMain.getString("OWN_CON")==null?"":rsMain.getString("OWN_CON");
 OWN_CON_PER=rsMain.getString("OWN_CON_PER")==null?"":rsMain.getString("OWN_CON_PER");
 INADQ_KNWLD=rsMain.getString("INADQ_KNWLD")==null?"":rsMain.getString("INADQ_KNWLD");
 INADQ_KNWLD_PER=rsMain.getString("INADQ_KNWLD_PER")==null?"":rsMain.getString("INADQ_KNWLD_PER");
 ACT_NEG=rsMain.getString("ACT_NEG")==null?"":rsMain.getString("ACT_NEG");
 ACT_NEG_PER=rsMain.getString("ACT_NEG_PER")==null?"":rsMain.getString("ACT_NEG_PER");
 GOV_EMP=rsMain.getString("GOV_EMP")==null?"":rsMain.getString("GOV_EMP");
 GOV_EMP_PER=rsMain.getString("GOV_EMP_PER")==null?"":rsMain.getString("GOV_EMP_PER");
 DOC_INCOMP=rsMain.getString("DOC_INCOMP")==null?"":rsMain.getString("DOC_INCOMP");
 DOC_INCOMP_PER=rsMain.getString("DOC_INCOMP_PER")==null?"":rsMain.getString("DOC_INCOMP_PER");
 PMEGP_LOAN_AVAIL=rsMain.getString("PMEGP_LOAN_AVAIL")==null?"":rsMain.getString("PMEGP_LOAN_AVAIL");
 PMEGP_LOAN_AVAIL_PER=rsMain.getString("PMEGP_LOAN_AVAIL_PER")==null?"":rsMain.getString("PMEGP_LOAN_AVAIL_PER");
 IMP_APP=rsMain.getString("IMP_APP")==null?"":rsMain.getString("IMP_APP");

 IMP_APP_PER=rsMain.getString("IMP_APP_PER")==null?"":rsMain.getString("IMP_APP_PER");
 REV_APP=rsMain.getString("REV_APP")==null?"":rsMain.getString("REV_APP");
 REV_APP_PER=rsMain.getString("REV_APP_PER")==null?"":rsMain.getString("REV_APP_PER");
 OTHER_BANK=rsMain.getString("OTHER_BANK")==null?"":rsMain.getString("OTHER_BANK");
 OTHER_BANK_PER=rsMain.getString("OTHER_BANK_PER")==null?"":rsMain.getString("OTHER_BANK_PER");
 OTHER_REASON=rsMain.getString("OTHER_REASON")==null?"":rsMain.getString("OTHER_REASON");
 OTHER_REASON_PER=rsMain.getString("OTHER_REASON_PER")==null?"":rsMain.getString("OTHER_REASON_PER");
 RET_APP=rsMain.getString("RET_APP")==null?"":rsMain.getString("RET_APP");
 RET_APP_PER=rsMain.getString("RET_APP_PER")==null?"":rsMain.getString("RET_APP_PER");

 
 }
  rsMain.close();

%>
  <TR>
    <TD><DIV align="center">1</DIV></TD>
     <TD><DIV align="left">Total No of Application Rejected/Returned by Bank</DIV></TD>
    <TD><DIV align="center"><%= TOTAL_NO_APP_BANKREJ %></DIV></TD>
   
	<TD><DIV align="center"></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">2</DIV></TD>
     <TD><DIV align="left">Other Reason</DIV></TD>
    <TD><DIV align="center"><%= OTHER_REASON %></DIV></TD>
   
	<TD><DIV align="center"><%= OTHER_REASON_PER %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">3</DIV></TD>
     <TD><DIV align="left">Project Not viable/Feasible</DIV></TD>
    <TD><DIV align="center"><%= NOT_VIAABLE_NO %></DIV></TD>
   
	<TD><DIV align="center"><%= NOT_VIAABLE_NO_PER %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">4</DIV></TD>
     <TD><DIV align="left">Applicant not Interested</DIV></TD>
    <TD><DIV align="center"><%= APP_NOTINST %></DIV></TD>
   
 <TD><DIV align="center"><%= APP_NOTINST_PER %></DIV></TD>
  </TR>  <TR>
    <TD><DIV align="center">5</DIV></TD>
     <TD><DIV align="left">Unable to Complete Bank Formalities</DIV></TD>
    <TD><DIV align="center"></DIV></TD>
     <TD><DIV align="center"></DIV></TD>
  </TR>  <TR>
    <TD><DIV align="center">6</DIV></TD>
     <TD> <DIV align="left">Out of Service Area</DIV></TD><TD><DIV align="center"><%= OUT_SERV_AREA %></DIV></TD>
    <TD><DIV align="center"><%= OUT_SERV_AREA_PER %></DIV></TD>
  </TR>  <TR>
    <TD><DIV align="center">7</DIV></TD>
     <TD><DIV align="left">CIBIL Report not Satisfactory</DIV></TD>
    <TD><DIV align="center"><%= CIBIL %></DIV></TD>
   
	<TD><DIV align="center"><%= CIBIL_PER %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">8</DIV></TD>
     <TD><DIV align="left">Existing Unit</DIV></TD>
    <TD><DIV align="center"><%= EXIST_UNIT %></DIV></TD>
   
	 <TD><DIV align="center"><%= EXIST_UNIT_PER %></DIV></TD>
  </TR>
    <TR>
      <TD><DIV align="center">9</DIV></TD>
      <TD>Inadequate Knowledge in Proposed Industry</TD>
      <TD><DIV align="center"><%= INADQ_KNWLD %></DIV></TD>
      <TD><DIV align="center"><%= INADQ_KNWLD_PER %></DIV></TD>
    </TR>
    <TR>
      <TD><DIV align="center">10</DIV></TD>
      <TD>Defaulter</TD>
      <TD><DIV align="center"><%= DEFAULTER %></DIV></TD>
      <TD><DIV align="center"><%= DEFAULTER_PER %></DIV></TD>
    </TR>
    <TR>
      <TD><DIV align="center">11</DIV></TD>
      <TD>PMEGP Target Achieved for the Current Year</TD>
      <TD><DIV align="center"><%= TARGET_ACHIEV %></DIV></TD>
      <TD><DIV align="center"><%= TARGET_ACHIEV_PER %></DIV></TD>
    </TR>
    <TR>
      <TD><DIV align="center">12</DIV></TD>
      <TD>applicant Willing to Avail PMEGP Loan from other Bank/Branch</TD>
      <TD><DIV align="center"><%= PMEGP_LOAN_AVAIL %></DIV></TD>
      <TD><DIV align="center"><%= PMEGP_LOAN_AVAIL_PER %></DIV></TD>
    </TR>
    <TR>
      <TD><DIV align="center">13</DIV></TD>
      <TD>Activity in Negative list as per PMEGP Scheme</TD>
      <TD><DIV align="center"><%= ACT_NEG %></DIV></TD>
      <TD><DIV align="center"><%= ACT_NEG_PER %></DIV></TD>
    </TR>
    <TR>
      <TD><DIV align="center">14</DIV></TD>
      <TD>Already employee</TD>
      <TD><DIV align="center"><%= GOV_EMP %></DIV></TD>
      <TD><DIV align="center"><%= GOV_EMP_PER %></DIV></TD>
    </TR>
    <TR>
      <TD><DIV align="center">15</DIV></TD>
      <TD>Spouse PMEGP/REGP Loan availed</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
    </TR>
    <TR>
    <TD><DIV align="center">16</DIV></TD>
     <TD><DIV ALI_GN="center">
       <DIV align="left">Unable to Deposit Own Contribution</DIV>
     </DIV></TD>
    <TD><DIV align="center"><%= OWN_CON %></DIV></TD>
   
	 <TD><DIV align="center"><%= OWN_CON_PER %></DIV></TD>
  </TR> 
  </TBODY>
   <% 
  db.close();
    %>
	<TFOOT>
	<TR>
    <TH><DIV align="center">Sr No</DIV></TH>
    <TH><DIV align="center">Name</DIV></TH>
    <TH><DIV align="center">No of Prj </DIV></TH>
    <TH><DIV align="center">in %</DIV></TH>
	</TFOOT>
</TABLE>
</DIV>
<SCRIPT type="text/javascript">
$(function(){
  $('#keywords').tablesorter(); 
});
</SCRIPT>

</BODY>
</HTML>