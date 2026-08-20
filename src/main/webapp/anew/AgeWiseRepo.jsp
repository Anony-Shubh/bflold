<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<HEAD>
    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <LINK href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
</HEAD>

<BODY>

<% 
String STATE_NM="";
String STATE_CD=request.getParameter("STATE_CD")==null?"MH":(String)request.getParameter("STATE_CD");
String id=request.getParameter("id")==null?"":(String)request.getParameter("id");

String AGENCY_UP = "";
String APP_UP_AVG = "";
String AGN_REJECT = "";
String APP_REJ_AVG = "";
String BANK_FORD = "";
String BANK_FORD_AVG = "";

String BANK_SANC = "";
String BANK_SANC_AVG = "";
String OWN_CONT = "";
String OWN_CONT_AVG = "";
String IST_LOANSANC = "";
String IST_LOANSANC_AVG = "";

String MM_CLAIM = "";
String MM_CLAIM_AVG = "";
String MM_REL = "";
String MM_REL_AVG = "";
String BANK_REJECT = "";
String BANK_REJECT_AVG = "";
String EDP_CERT_ISS = "";
String EDP_CERT_ISS_AVG = "";





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
if (!AGN.equals("ALL")) {
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


 StringBuffer qrysb= new StringBuffer();

qrysb.append("   select "      );
qrysb.append("   STATE_NM,STATE_CD,"      );
qrysb.append("   max(agency_up) as agency_up,"      );
qrysb.append("   round(max(no_of_days_up/agency_up),0) as app_up_avg,"      );
qrysb.append("   max(AGN_REJECT) as AGN_REJECT,"      );
qrysb.append("   round(max(no_of_days_REJECT/AGN_REJECT),0) as APP_REJ_AVG,"      );

qrysb.append("   max(bank_ford) as bank_ford,"      );
qrysb.append("   round(max(no_of_days_bank_f/bank_ford),0) as bank_ford_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(bank_sanc) as bank_sanc,"      );
qrysb.append("   round(max(no_of_days_bank_LOAN_SAN/bank_sanc),0) as bank_sanc_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(OWN_CONT) as OWN_CONT,"      );
qrysb.append("   round(max(no_of_days_bank_OWN/OWN_CONT),0) as OWN_CONT_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(IST_LOANSANC) as IST_LOANSANC,"      );
qrysb.append("   round(max(no_of_days_bank_LOAN_SAN_FIRST/IST_LOANSANC),0) as IST_LOANSANC_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(mm_claim) as mm_claim,"      );
qrysb.append("   round(max(no_of_days_bank_MM_CLAIMS/mm_claim),0) as mm_claim_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(mm_rel) as mm_rel,"      );
qrysb.append("   round(max(no_of_days_bank_MM_REL/mm_rel),0) as mm_rel_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(edp_cert_iss) as edp_cert_iss,"      );
qrysb.append("   round(max(no_of_days_bank_EDP/edp_cert_iss),0) as edp_cert_iss_avg,"      );
qrysb.append("   "      );
qrysb.append("   max(bank_reject) as bank_reject,"      );
qrysb.append("   round(max(no_of_days_bank_R/bank_reject),0) as bank_reject_avg"      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   from ("      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   SELECT MS.STATE_NM,MS.STATE_CD,SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID in(0,1,2,4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS agency_up,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID in(0,1,2,4)"      );
qrysb.append("       THEN (TRUNC(sysdate) - TRUNC(ad.ONLINE_SUBDT))+1   "      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_up,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID=3"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS AGN_REJECT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID=3 and TRUNC(AD.APP_REC_DATE) <> TRUNC(AD.ONLINE_SUBDT)"      );
qrysb.append("       THEN (TRUNC(NVL(ad.APP_REC_DATE, ad.TIME_STAMP)) - TRUNC(ad.ONLINE_SUBDT))+1"      );
qrysb.append("      "      );
qrysb.append("       ELSE  (TRUNC(ad.ONLINE_SUBDT)+ SUBSTR(AD.APP_ID, -1)- TRUNC(ad.ONLINE_SUBDT))+1"      );
qrysb.append("     END) AS no_of_days_REJECT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  ad.ACT_ID = 5 AND ad.BANK_F_DATE IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE) IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_reject,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 3"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.BANK_REC_DT) - TRUNC(ad.BANK_F_DATE))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_R,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("          THEN (TRUNC(ad.BANK_F_DATE) - TRUNC(ad.ONLINE_SUBDT))+1 "      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_f,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_sanc,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT)  IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.LOAN_SANC_DT) - TRUNC(ad.BANK_F_DATE))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_LOAN_SAN,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS OWN_CONT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.OWN_CONT_DT) - TRUNC(bd.LOAN_SANC_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_OWN,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT) IS NOT NULL"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS IST_LOANSANC,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.IST_LOAN_DT) - TRUNC(bd.OWN_CONT_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_LOAN_SAN_FIRST,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS mm_claim,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID        = 11"      );
qrysb.append("       AND bd.MM_CLAIM_AMT   > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.MM_CLAIM_DT) - TRUNC(bd.IST_LOAN_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_MM_CLAIMS,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_REL_DT IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.APPRV_YN = 'A'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS mm_rel,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID    = 11"      );
qrysb.append("       AND bd.MM_REL_DT IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) IS NOT NULL"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.APPRV_YN = 'A'"      );
qrysb.append("       THEN (TRUNC(bd.MM_REL_DT) - TRUNC(bd.MM_CLAIM_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_MM_REL,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.EDP_CERT_DT IS NOT NULL AND (bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID = 11"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS edp_cert_iss,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID      = 11"      );
qrysb.append("       AND bd.EDP_CERT_DT IS NOT NULL   "      );
qrysb.append("       THEN (TRUNC(bd.EDP_CERT_DT) - TRUNC(bd.LOAN_SANC_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_EDP"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     bank_dataentry bd,"      );
qrysb.append("     m_district dm,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     m_state ms,"      );
qrysb.append("     ZONE_MAST ZM"      );
qrysb.append("   WHERE ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("   AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("   AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("   AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("   AND ms.ZONE_CD      = ZM.ZONE_CD"      );
qrysb.append("   AND TRUNC(ad.ONLINE_SUBDT) BETWEEN '01-APR-2020' AND SysDate"      );
qrysb.append("   AND MS.STATE_CD=?"      );
qrysb.append("   GROUP BY MS.STATE_NM,MS.STATE_CD"      );
qrysb.append("   )GROUP BY (STATE_CD), (STATE_NM)"      );

//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();

values.add(STATE_CD);


ResultSet rs = db.executeSQL(qrysb.toString(),values);
 %>
 

<INPUT name="STATE_CD" type="hidden" id="STATE_CD" value="<%= STATE_CD %>">
 <INPUT type="hidden" name="bookId" value=""/>
 
 
<CENTER>
  <H3>Age Wise Report For The Period From 01-apr-2020 to till date </H3>
</CENTER>

<%= srno %>

<P>&nbsp;</P>
<DIV id="wrapper">
<TABLE class="table table-striped" id="dataTable" width="40%">
 <THEAD>
    <TR>
	 <TH rowspan="2"><DIV align="center">Sr No</DIV></TH>
	 <TH rowspan="2"><DIV align="center">Particulars</DIV></TH>
    </TR>
    <TR>
      <TH><DIV align="center">No of Prj </DIV></TH>
      <TH><DIV align="center">Average no of days taken </DIV></TH>
    </TR>
   </THEAD>
  
<TBODY>
<% 
int cnt=0;
 while (rsMain.next()) { 
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
 AGENCY_UP =rsMain.getString("AGENCY_UP")==null?"":rsMain.getString("AGENCY_UP");
 APP_UP_AVG =rsMain.getString("APP_UP_AVG")==null?"":rsMain.getString("APP_UP_AVG");
 AGN_REJECT =rsMain.getString("AGN_REJECT")==null?"":rsMain.getString("AGN_REJECT");
 APP_REJ_AVG =rsMain.getString("APP_REJ_AVG")==null?"":rsMain.getString("APP_REJ_AVG");
 BANK_FORD =rsMain.getString("BANK_FORD")==null?"":rsMain.getString("BANK_FORD");
 BANK_FORD_AVG =rsMain.getString("BANK_FORD_AVG")==null?"":rsMain.getString("BANK_FORD_AVG");
 
 


 BANK_SANC =rsMain.getString("BANK_SANC")==null?"":rsMain.getString("BANK_SANC");
 BANK_SANC_AVG =rsMain.getString("BANK_SANC_AVG")==null?"":rsMain.getString("BANK_SANC_AVG");
 OWN_CONT =rsMain.getString("OWN_CONT")==null?"":rsMain.getString("OWN_CONT");
 OWN_CONT_AVG =rsMain.getString("OWN_CONT_AVG")==null?"":rsMain.getString("OWN_CONT_AVG");
 IST_LOANSANC =rsMain.getString("IST_LOANSANC")==null?"":rsMain.getString("IST_LOANSANC");
 IST_LOANSANC_AVG =rsMain.getString("IST_LOANSANC_AVG")==null?"":rsMain.getString("IST_LOANSANC_AVG");

 MM_CLAIM =rsMain.getString("MM_CLAIM")==null?"":rsMain.getString("MM_CLAIM");
 MM_CLAIM_AVG =rsMain.getString("MM_CLAIM_AVG")==null?"":rsMain.getString("MM_CLAIM_AVG");
 MM_REL =rsMain.getString("MM_REL")==null?"":rsMain.getString("MM_REL");
 MM_REL_AVG =rsMain.getString("MM_REL_AVG")==null?"":rsMain.getString("MM_REL_AVG");
 BANK_REJECT =rsMain.getString("BANK_REJECT")==null?"":rsMain.getString("BANK_REJECT");
 BANK_REJECT_AVG =rsMain.getString("BANK_REJECT_AVG")==null?"":rsMain.getString("BANK_REJECT_AVG");
 EDP_CERT_ISS =rsMain.getString("EDP_CERT_ISS")==null?"":rsMain.getString("EDP_CERT_ISS");
 EDP_CERT_ISS_AVG =rsMain.getString("EDP_CERT_ISS_AVG")==null?"":rsMain.getString("EDP_CERT_ISS_AVG");
 }
  rsMain.close();

%>
  <TR>
    <TD><DIV align="center">1</DIV></TD>
     <TD><DIV align="center">Under Process at Agency </DIV></TD>
    <TD><DIV align="center"><%= AGENCY_UP %></DIV></TD>
   
	<TD><DIV align="center"><%= APP_UP_AVG %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">2</DIV></TD>
     <TD><DIV align="center">Rejected By Agency </DIV></TD>
    <TD><DIV align="center"><%= AGN_REJECT %></DIV></TD>
   
	<TD><DIV align="center"><%= APP_REJ_AVG %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">3</DIV></TD>
     <TD><DIV align="center">Forwarded to Bank </DIV></TD>
    <TD><DIV align="center"><%= BANK_FORD %></DIV></TD>
   
	<TD><DIV align="center"><%= BANK_FORD_AVG %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">4</DIV></TD>
     <TD><DIV align="center">Sanctioned By Bank </DIV></TD>
    <TD><DIV align="center"><%= BANK_SANC %></DIV></TD>
   
 <TD><DIV align="center"><%= BANK_SANC_AVG %></DIV></TD>
  </TR>  <TR>
    <TD><DIV align="center">5</DIV></TD>
     <TD><DIV align="center">Own Contribution Deposited </DIV></TD>
    <TD><DIV align="center"><%= OWN_CONT %></DIV></TD>
     <TD><DIV align="center"><%= OWN_CONT_AVG %></DIV></TD>
  </TR>  <TR>
    <TD><DIV align="center">6</DIV></TD>
     <TD><DIV align="center">First Loan Disbursement </DIV></TD>
    <TD><DIV align="center"><%= IST_LOANSANC %></DIV></TD>
    <TD><DIV align="center"><%= IST_LOANSANC_AVG %></DIV></TD>
  </TR>  <TR>
    <TD><DIV align="center">7</DIV></TD>
     <TD><DIV align="center">MM Claim </DIV></TD>
    <TD><DIV align="center"><%= MM_CLAIM %></DIV></TD>
   
	<TD><DIV align="center"><%= MM_CLAIM_AVG %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">8</DIV></TD>
     <TD><DIV align="center">MM Release </DIV></TD>
    <TD><DIV align="center"><%= MM_REL %></DIV></TD>
   
	 <TD><DIV align="center"><%= MM_REL_AVG %></DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">9</DIV></TD>
     <TD><DIV ALI_GN="center">
       <DIV align="center">EDP Certificate Issue </DIV>
     </DIV></TD>
    <TD><DIV align="center"><%= EDP_CERT_ISS %></DIV></TD>
   
	 <TD><DIV align="center"><%= EDP_CERT_ISS_AVG %></DIV></TD>
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
    <TH><DIV align="center">Average no of days taken </DIV></TH>
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
