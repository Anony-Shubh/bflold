<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon,java.math.BigDecimal"  %>
<%@ include file="includesessionpage.jsp" %>
<%!
  public String calculatePercentage(String a, String b)
{

float inum=Float.parseFloat(a);
float inum2=Float.parseFloat(b);
 float result=inum/inum2 * 100; 
  BigDecimal bd = new BigDecimal(result);
  bd = bd.setScale(2 ,BigDecimal.ROUND_HALF_UP);
 String result1=String.valueOf(bd);   
 return result1;
}
%>

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

String AGENTYPE= session.getAttribute("AGENTYPE")==null?"":(String) session.getAttribute("AGENTYPE");

String DLEVEL=request.getParameter("DLEVEL")==null?"":(String)request.getParameter("DLEVEL");
String FROMDT= session.getAttribute("FROMDT")==null?"":(String) session.getAttribute("FROMDT");
String TODT= session.getAttribute("TODT")==null?"":(String) session.getAttribute("TODT");
String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":(String)request.getParameter("DISTRICT_CD");
String DISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"":(String)request.getParameter("DISTRICT_NAME");

String REJ_DESC = "";
String NO_OF_PRJ = "";
String PER_CENT = "";
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
String TOT_APP="";
DBCon db= new DBCon();
db.connect();

 StringBuffer qry= new StringBuffer();
 
 
qry.append(" SELECT COUNT(*) AS TOT_APP FROM BANK_DATAENTRY BD,app_detail ad,mas_Off_mast mom,m_state ms ,m_district MD,");
qry.append(" zone_MAST zm,rejection_mast rm"      );
qry.append("    WHERE ad.APP_ID     = bd.APP_ID(+) AND ad.UNIT_DIST_CD = MD.DISTRICT_CD AND MD.STATE_CD= ms.STATE_CD AND ad.OFF_CD = mom.OFF_CD"      );
qry.append("     AND ms.ZONE_CD      = ZM.ZONE_CD"      );
qry.append("     and bd.rej_id= rm.rej_id"      );
qry.append("     and rm.act_YN='Y'"      );
qry.append("     AND BD.ACT_ID=3"      );
qry.append("     AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND  '"+TODT+"'  "      );

//////////////////////////////////////////agency
qry.append("   and  MOM.AGENCY_TYPE like '%"+AGENTYPE+"%'"      );

if(DLEVEL.equals("2")){
qry.append("   AND MS.STATE_CD='"+STATE_CD+"'  "      );
}
if(DLEVEL.equals("3")){
qry.append("   AND MD.DISTRICT_CD='"+DISTRICT_CD+"'  "      );
}


ResultSet rsTOT = db.execSQL(qry.toString());

 while (rsTOT.next()) { 
 
 TOT_APP=rsTOT.getString("TOT_APP")==null?"":rsTOT.getString("TOT_APP");
 }

 StringBuffer qrysb= new StringBuffer();

qrysb.append("    SELECT "      );

qrysb.append("   NVL(RM.REJ_DESC,'TOTAL') AS REJ_DESC,COUNT(*) AS NO_OF_PRJ from bank_dataentry bd,app_detail ad,mas_Off_mast mom,m_state ms ,m_district MD,zone_MAST zm,rejection_mast rm"      );
qrysb.append("    WHERE ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("     AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("     AND MD.STATE_CD     = ms.STATE_CD"      );
qrysb.append("     AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("     AND ms.ZONE_CD      = ZM.ZONE_CD"      );
qrysb.append("     and bd.rej_id= rm.rej_id"      );
qrysb.append("      AND AD.ACT_ID=5 "      );
qrysb.append("     AND BD.ACT_ID=3"      );
qrysb.append("     AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND  '"+TODT+"' "      );

//////////////////////////////////////////agency
qrysb.append("   and  MOM.AGENCY_TYPE like '%"+AGENTYPE+"%'"      );


if(DLEVEL.equals("2")){
qrysb.append("   AND MS.STATE_CD='"+STATE_CD+"'  "      );
}
if(DLEVEL.equals("3")){
qrysb.append("   AND MD.DISTRICT_CD='"+DISTRICT_CD+"'  "      );
}

qrysb.append("  GROUP BY ROLLUP(RM.REJ_DESC) ORDER BY COUNT(*) DESC ");



//out.print(qrysb.toString());




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
 <DIV align="center"><H2>INDIA</H2></DIV>
<%}%>
 <%if(DLEVEL.equals("2")){%>
 <DIV align="center"><H2><%= STATE_NM %></H2></DIV>
<%}%>
 <%if(DLEVEL.equals("3")){%>
 <DIV align="center"><H2><%= DISTRICT_NAME %> , <%= STATE_NM %></H2></DIV>
<%}%>

<INPUT name="STATE_CD" type="hidden" id="STATE_CD" value="<%= STATE_CD %>">
 <INPUT type="hidden" name="bookId" value=""/>
 

<CENTER>
  <H3>Application Rejected/Returned by Bank From <%= FROMDT %> to <%= TODT %> (Agency: 
   <%if(AGENTYPE.equals("")){%>
	 All
	 <%}%>
	 <%=AGENTYPE%>)
	 </H3>
</CENTER>

<%= srno %>

<DIV id="wrapper">
<TABLE id="customers" width="70%" align="center">
 <THEAD>
    <TR>
	 <TH rowspan="2"><DIV align="center">Sr. No.</DIV></TH>
	 <TH rowspan="2"><DIV align="center">Particulars</DIV></TH>
    </TR>
    <TR>
      <TH><DIV align="center">No. of Project</DIV></TH>
      <TH><DIV align="center">in %</DIV></TH>
    </TR>
   </THEAD>
  
<TBODY>
<% 
int cnt=0;
 while (rsMain.next()) { 
 



  /* if(DLEVEL.equals("2")){
 OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
 }*/
  REJ_DESC=rsMain.getString("REJ_DESC")==null?"":rsMain.getString("REJ_DESC");
 NO_OF_PRJ=rsMain.getString("NO_OF_PRJ")==null?"":rsMain.getString("NO_OF_PRJ");

 
 
 /*
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

 */

cnt=cnt+1;
%>
  <TR>
    <TD><DIV align="center"><%=cnt%></DIV></TD>
     <TD><DIV align="left"><%=REJ_DESC%></DIV></TD>
    <TD><DIV align="right"><%= NO_OF_PRJ %></DIV></TD>
   
	<TD><DIV align="right"><%=calculatePercentage(NO_OF_PRJ,TOT_APP)%> </DIV></TD>
  </TR>
    
  </TBODY>
   <% } 
  rsMain.close();
  rsTOT.close();
  db.close();
    %>
	<TFOOT>
	<TR>
    <TH><DIV align="center">Sr. No.</DIV></TH>
    <TH><DIV align="center">Particulars</DIV></TH>
    <TH><DIV align="center">No. of Project</DIV></TH>
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