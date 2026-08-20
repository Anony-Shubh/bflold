<%@ page import="javax.sql.*,java.math.BigDecimal"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
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

<HEAD>
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
<FORM method="post">
<% 
String vSTATENM= session.getAttribute("STATE_NM")==null?"H":(String) session.getAttribute("STATE_NM");
String vSTATECD= session.getAttribute("STATE_CD")==null?"H":(String) session.getAttribute("STATE_CD");
String FROMDT= session.getAttribute("FROMDT")==null?"":(String) session.getAttribute("FROMDT");
String TODT= session.getAttribute("TODT")==null?"":(String) session.getAttribute("TODT");
String vDISTRICT= session.getAttribute("DISTRICT_NAME")==null?"":(String) session.getAttribute("DISTRICT_NAME");
String AGENTYPE= session.getAttribute("AGENTYPE")==null?"":(String) session.getAttribute("AGENTYPE");
//out.print(AGENTYPE);
//String STATE_NM="";
//String STATE_CD="";
String AGN_RECV="";
String AGN_REJECT="";
  String agency_up="";
    String bank_ford_tot="";
  String bank_ford_MM_tot="";
  String bank_ford="";
  String bank_ford_MM="";
  String PRV_BANK_FORD_PEN="";
  String PRV_BANK_FORD_PEN_MM="";
  
   String bank_recv_tot="";
  String bank_recv_MM_tot="";
  String bank_recv="";
  String bank_recv_MM="";
  String PRV_bank_recv="";
  String PRV_bank_recv_MM="";
  
   String bank_pend_tot="";
  String bank_pend_MM_tot="";
  String bank_pend="";
  String bank_pend_MM="";
  String PRV_bank_pend="";
  String PRV_bank_pend_MM="";
  
   String bank_reject_tot="";
  String bank_reject_MM_tot="";
  String bank_reject="";
  String bank_reject_MM="";
  String PRV_bank_reject="";
  String PRV_bank_reject_MM="";
  
  String bank_sanc_tot="";
  String bank_sanc_MM_tot="";
  String bank_sanc="";
  String bank_sanc_MM="";
  String PRV_bank_sanc="";
  String PRV_bank_sanc_MM="";
  
   String OWN_CONT_tot="";
  String OWN_CONT_MM_tot="";
  String OWN_CONT="";
  String OWN_CONT_MM="";
  String  PRV_OWN_CONT="";
  String PRV_OWN_CONT_MM="";
  
  String IST_LOANSANC_tot="";
   String  IST_LOANSANC_MM_tot="";
  String  IST_LOANSANC_MM="";
  String PRV_IST_LOANSANC="";
  String IST_LOANSANC="";
  String PRV_IST_LOANSANC_MM="";
  
  String MM_REL_NO_OLD="";
  String MM_REL_AMT_OLD="";
  String mm_claim_tot="";
  String mm_claim_AMT_tot="";
   
  String mm_claim="";
  String mm_claim_AMT="";
  String PRV_mm_claim="";
  String PRV_mm_claim_AMT="";
  
    String mm_rel_AMT_tot="";
  String mm_rel_tot="";
  String mm_rel_AMT="";
  String mm_rel="";
  String  PRV_mm_rel_AMT="";
  String  PRV_mm_rel="";
  
    String mm_rel_AMT_tot_s="";
  String mm_rel_tot_s="";
  String mm_rel_AMT_s="";
  String mm_rel_s="";
  String  PRV_mm_rel_AMT_s="";
  String  PRV_mm_rel_s="";
  
   String mm_release_tot="";
  String mm_release_amt_tot="";
   String rel_no="";
    String rel_amt="";
     String prv_rel="";
      String pre_rel_amt="";
  
  
  String  edp_cert_iss="";
  String  edp_cert_iss_c="";
  String  edp_cert_iss_p="";

String wcls="";
String srno ="";
String rFromdt="";
String rTodt="";

String DLEVEL=request.getParameter("DLEVEL")==null?"":(String)request.getParameter("DLEVEL");
String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":(String)request.getParameter("DISTRICT_CD");
String DISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"":(String)request.getParameter("DISTRICT_NAME");


String STATE_CD=request.getParameter("STATE_CD")==null?"":(String) request.getParameter("STATE_CD");
String STATE_NM=request.getParameter("STATE_NM")==null?"":(String) request.getParameter("STATE_NM");
String ORG =request.getParameter("Org")==null?"":(String) request.getParameter("Org"); 
String AGN=request.getParameter("AGN")==null?"":(String) request.getParameter("AGN");
String vcls="";
String Wcls="";
 StringBuffer qrysb= new StringBuffer();
qrysb.append("   select "      );

if(DLEVEL.equals("2")){
qrysb.append("   STATE_NM,STATE_CD,"      );
}

if(DLEVEL.equals("3")){
qrysb.append("   DISTRICT_NAME,DISTRICT_CD, "      );
}


qrysb.append("  SUM(AGN_RECV) AS AGN_RECV, SUM(AGN_REJECT) AS AGN_REJECT,"      );
qrysb.append("   SUM(agency_up) AS agency_up ,"      );
qrysb.append("   "      );
qrysb.append("   SUM(bank_ford_tot) AS bank_ford_tot,"      );
qrysb.append("     SUM(bank_ford_MM_tot) AS bank_ford_MM_tot ,  "      );
qrysb.append("   SUM(bank_ford) AS bank_ford,"      );
qrysb.append("     SUM(bank_ford_MM) AS bank_ford_MM ,"      );
qrysb.append("     SUM(PRV_BANK_FORD_PEN) AS PRV_BANK_FORD_PEN,"      );
qrysb.append("     SUM(PRV_BANK_FORD_PEN_MM) AS PRV_BANK_FORD_PEN_MM,"      );
qrysb.append("     "      );
qrysb.append("     SUM(bank_recv_tot) AS bank_recv_tot,"      );
qrysb.append("     SUM(bank_recv_MM_tot) AS bank_recv_MM_tot,"      );
qrysb.append("     SUM(bank_recv) AS bank_recv,"      );
qrysb.append("     SUM(bank_recv_MM) AS bank_recv_MM,"      );
qrysb.append("     SUM(PRV_bank_recv) AS PRV_bank_recv,"      );
qrysb.append("     SUM(PRV_bank_recv_MM) AS PRV_bank_recv_MM,"      );
qrysb.append("     "      );
qrysb.append("     SUM(bank_pend_tot) AS bank_pend_tot,"      );
qrysb.append("     SUM(bank_pend_mm_tot) AS bank_pend_mm_tot,"      );
qrysb.append("     SUM(bank_pend) AS bank_pend,"      );
qrysb.append("     SUM(bank_pend_mm) AS bank_pend_mm,"      );
qrysb.append("     SUM(PRV_bank_pend) AS PRV_bank_pend,"      );
qrysb.append("     SUM(PRV_bank_pend_MM) AS PRV_bank_pend_MM,"      );
qrysb.append("     "      );
qrysb.append("      SUM(bank_reject_tot) AS bank_reject_tot,"      );
qrysb.append("     SUM(bank_reject_MM_tot) AS bank_reject_MM_tot,"      );
qrysb.append("     SUM(bank_reject) AS bank_reject,"      );
qrysb.append("     SUM(bank_reject_MM) AS bank_reject_MM,"      );
qrysb.append("     SUM(PRV_bank_reject) AS PRV_bank_reject,"      );
qrysb.append("     SUM(PRV_bank_reject_MM) AS PRV_bank_reject_MM,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("      SUM(bank_sanc_tot) AS bank_sanc_tot,"      );
qrysb.append("     SUM(bank_sanc_MM_tot) AS bank_sanc_MM_tot ,"      );
qrysb.append("     SUM(bank_sanc) AS bank_sanc,"      );
qrysb.append("     SUM(bank_sanc_MM) AS bank_sanc_MM ,"      );
qrysb.append("     SUM(PRV_bank_sanc) AS PRV_bank_sanc,"      );
qrysb.append("     SUM(PRV_bank_sanc_MM) AS PRV_bank_sanc_MM ,"      );
qrysb.append("     "      );
qrysb.append("      SUM(OWN_CONT_tot) AS OWN_CONT_tot,"      );
qrysb.append("     SUM(OWN_CONT_MM_tot) AS OWN_CONT_MM_tot ,"      );
qrysb.append("     SUM(OWN_CONT) AS OWN_CONT,"      );
qrysb.append("     SUM(OWN_CONT_MM) AS OWN_CONT_MM ,"      );
qrysb.append("     SUM(PRV_OWN_CONT) AS PRV_OWN_CONT,"      );
qrysb.append("     SUM(PRV_OWN_CONT_MM) AS PRV_OWN_CONT_MM,"      );
qrysb.append("     "      );
qrysb.append("       SUM(IST_LOANSANC_tot) AS IST_LOANSANC_tot,"      );
qrysb.append("     SUM(IST_LOANSANC_MM_tot) AS IST_LOANSANC_MM_tot,"      );
qrysb.append("       SUM(IST_LOANSANC) AS IST_LOANSANC,"      );
qrysb.append("     SUM(IST_LOANSANC_MM) AS IST_LOANSANC_MM,"      );
qrysb.append("     SUM(PRV_IST_LOANSANC) AS PRV_IST_LOANSANC ,"      );
qrysb.append("     SUM(PRV_IST_LOANSANC_MM) AS PRV_IST_LOANSANC_MM,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("      SUM(mm_claim_tot) AS mm_claim_tot,"      );
qrysb.append("     SUM(mm_claim_AMT_tot) AS mm_claim_AMT_tot,"      );
qrysb.append("     SUM(mm_claim) AS mm_claim,"      );
qrysb.append("     SUM(mm_claim_AMT) AS mm_claim_AMT,"      );
qrysb.append("     SUM(PRV_mm_claim) AS PRV_mm_claim,"      );
qrysb.append("     SUM(PRV_mm_claim_AMT) AS PRV_mm_claim_AMT,"      );
qrysb.append("     "      );
qrysb.append("     SUM(mm_rel_tot_f) AS mm_rel_tot,"      );
qrysb.append("     SUM(mm_rel_AMT_tot_f) AS mm_rel_AMT_tot ,  "      );
qrysb.append("     SUM(mm_rel_f) AS mm_rel,"      );
qrysb.append("     SUM(mm_rel_AMT_f) AS mm_rel_AMT ,  "      );
qrysb.append("     SUM(PRV_mm_rel_AMT_f) AS PRV_mm_rel_AMT ,"      );
qrysb.append("     SUM(PRV_mm_rel_f) AS PRV_mm_rel,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("      SUM(mm_rel_tot_s) AS mm_rel_tot_s,"      );
qrysb.append("     SUM(mm_rel_AMT_tot_s) AS mm_rel_AMT_tot_s ,  "      );
qrysb.append("     SUM(mm_rel_s) AS mm_rel_s,"      );
qrysb.append("     SUM(mm_rel_AMT_s) AS mm_rel_AMT_s ,  "      );
qrysb.append("     SUM(PRV_mm_rel_AMT_s) AS PRV_mm_rel_AMT_s ,"      );
qrysb.append("     SUM(PRV_mm_rel_s) AS PRV_mm_rel_s,"      );
qrysb.append("     "      );
qrysb.append("     SUM(mm_rel_tot_f+mm_rel_tot_s+MM_REL_NO_OLD) as mm_release_tot,"      );
qrysb.append("      SUM(mm_rel_AMT_tot_s+mm_rel_AMT_tot_f+MM_REL_AMT_OLD) as mm_release_amt_tot,"      );
qrysb.append("       SUM(mm_rel_s+mm_rel_f) as rel_no,"      );
qrysb.append("        SUM(mm_rel_AMT_s+mm_rel_AMT_f) as rel_amt,"      );
qrysb.append("         SUM(PRV_mm_rel_AMT_s+PRV_mm_rel_AMT_f+MM_REL_AMT_OLD) AS pre_rel_amt ,"      );
qrysb.append("          SUM(PRV_mm_rel_s+PRV_mm_rel_f+MM_REL_NO_OLD) as  prv_rel,"      );
qrysb.append("     "      );
qrysb.append("     SUM(edp_cert_iss) AS edp_cert_iss,SUM(edp_cert_iss_c) AS edp_cert_iss_c,SUM(edp_cert_iss_p) AS edp_cert_iss_p,SUM(MM_REL_NO_OLD) AS MM_REL_NO_OLD,SUM(MM_REL_AMT_OLD) AS MM_REL_AMT_OLD "      );
qrysb.append("     "      );
qrysb.append("   from ("      );
qrysb.append("   (SELECT  /*+ PARALLEL(AUTO) */ "      );


if(DLEVEL.equals("2")){
qrysb.append("   (MS.STATE_NM) AS STATE_NM,(MS.STATE_CD) AS STATE_CD ,  "      );
}

if(DLEVEL.equals("3")){
qrysb.append("   DM.DISTRICT_NAME,DM.DISTRICT_CD,"      );
}

qrysb.append("   SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS AGN_RECV,"      );
qrysb.append("    SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' AND ad.ACT_ID IN (3,7)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS AGN_REJECT,"      );
qrysb.append("   SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' AND ad.ACT_ID in(0,1,2,4) AND AD.ACT_YN='Y' "      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS agency_up,"      );
qrysb.append("      SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  ad.ACT_ID = 5 AND trunc(ad.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford_tot,"      );
qrysb.append("      SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  ad.ACT_ID = 5 AND trunc(ad.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford_MM_tot,"      );
qrysb.append("   "      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"' AND ad.ACT_ID = 5 AND ad.BANK_F_DATE BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford,"      );
qrysb.append("      SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"' AND ad.ACT_ID = 5 AND ad.BANK_F_DATE BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID             = 5"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND ad.BANK_F_DATE BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PRV_BANK_FORD_PEN,"      );
qrysb.append("       SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID             = 5"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND ad.BANK_F_DATE BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PRV_BANK_FORD_PEN_MM,"      );
qrysb.append("     "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 8"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_recv_tot,"      );
qrysb.append("     "      );
qrysb.append("        SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 8"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_recv_MM_tot,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 8"      );
qrysb.append("       AND ad.ACT_ID  = 5  AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_recv,"      );
qrysb.append("     "      );
qrysb.append("        SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 8"      );
qrysb.append("       AND ad.ACT_ID  = 5  AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_recv_MM,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 8"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_bank_recv,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 8"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_bank_recv_MM,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  NVL(BD.ACT_ID,0) NOT IN (11,3)"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_pend_tot,"      );
qrysb.append("     "      );
qrysb.append("        SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  NVL(BD.ACT_ID,0) NOT IN (11,3)"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_pend_MM_tot,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  NVL(BD.ACT_ID,0) NOT IN (11,3)"      );
qrysb.append("       AND ad.ACT_ID  = 5  AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_pend,"      );
qrysb.append("     "      );
qrysb.append("        SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  NVL(BD.ACT_ID,0) NOT IN (11,3)"      );
qrysb.append("       AND ad.ACT_ID  = 5  AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_pend_MM,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  NVL(BD.ACT_ID,0) NOT IN (11,3)"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_bank_pend,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  NVL(BD.ACT_ID,0) NOT IN (11,3)"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_bank_pend_MM,"      );
qrysb.append("     "      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_reject_tot,"      );
qrysb.append("     "      );
qrysb.append("         SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5 "      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_reject_MM_tot,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5 AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_reject,"      );
qrysb.append("     "      );
qrysb.append("         SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5 AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_reject_MM,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("         SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5"      );
qrysb.append("        AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_bank_reject,  "      );
qrysb.append("     "      );
qrysb.append("           SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5"      );
qrysb.append("        AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(mminvolve(ad.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_bank_reject_MM,"      );
qrysb.append("     "      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 "      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_sanc_tot,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_sanc_MM_tot,"      );
qrysb.append("    "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(ad.BANK_F_DATE) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_sanc,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(ad.BANK_F_DATE) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS bank_sanc_MM,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(ad.BANK_F_DATE) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_bank_sanc,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(ad.BANK_F_DATE) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_bank_sanc_MM,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 "      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS OWN_CONT_tot,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 "      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS OWN_CONT_MM_tot,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(bd.LOAN_SANC_DT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS OWN_CONT,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(bd.LOAN_SANC_DT) >= '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS OWN_CONT_MM,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(bd.LOAN_SANC_DT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_OWN_CONT,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11 AND TRUNC(bd.LOAN_SANC_DT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN  ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_OWN_CONT_MM,"      );
qrysb.append("     "      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("      "      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS IST_LOANSANC_tot,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("      "      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS IST_LOANSANC_MM_tot,"      );
qrysb.append("    "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );

qrysb.append("       AND TRUNC(bd.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) >= '"+FROMDT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS IST_LOANSANC,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) >= '"+FROMDT+"'"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS IST_LOANSANC_MM,"      );
qrysb.append("    "      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) < '"+FROMDT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_IST_LOANSANC,  "      );
qrysb.append("     "      );
qrysb.append("        SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );

qrysb.append("       AND TRUNC(bd.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) < '"+FROMDT+"'"      );
qrysb.append("       THEN  ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_IST_LOANSANC_MM,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("      "      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS mm_claim_tot,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("      "      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS mm_claim_AMT_tot,"      );
qrysb.append("     "      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS mm_claim,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS mm_claim_AMT,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_mm_claim,"      );
qrysb.append("     "      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       THEN  ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_mm_claim_AMT,"      );
qrysb.append("     "      );
qrysb.append("     "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN 1"      );
qrysb.append("     END, 0)) AS mm_rel_tot_f,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"' "      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS mm_rel_AMT_tot_f,"      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"' AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN 1"      );
qrysb.append("     END, 0)) AS mm_rel_f,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"' AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS mm_rel_AMT_f,"      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       "      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_mm_rel_f,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       "      );
qrysb.append("       THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_mm_rel_AMT_f,"      );
qrysb.append("     "      );
qrysb.append("    "      );
qrysb.append("    0 AS mm_rel_tot_s,"      );
qrysb.append("     0 AS mm_rel_AMT_tot_s ,  "      );
qrysb.append("     0 AS mm_rel_s,"      );
qrysb.append("     0 AS mm_rel_AMT_s ,  "      );
qrysb.append("    0 AS PRV_mm_rel_s  ,"      );
qrysb.append("    0 AS PRV_mm_rel_AMT_s,"      );
qrysb.append("     "      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.EDP_CERT_DT  BETWEEN '"+FROMDT+"' AND '"+TODT+"' AND (bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID = 11"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS edp_cert_iss,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.EDP_CERT_DT  BETWEEN '"+FROMDT+"' AND '"+TODT+"' AND (bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       and TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"' AND bd.ACT_ID = 11"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS edp_cert_iss_c,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.EDP_CERT_DT  BETWEEN '"+FROMDT+"' AND '"+TODT+"' AND (bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"' AND bd.ACT_ID = 11"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS edp_cert_iss_p,0 AS MM_REL_NO_OLD,0 AS MM_REL_AMT_OLD"      );

qrysb.append("   "      );
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

//////////////////////////////////////////agency
qrysb.append("   and  MOM.AGENCY_TYPE like '%"+AGENTYPE+"%'"      );

 


if(DLEVEL.equals("1")){
qrysb.append(" )     "      );

}

if(DLEVEL.equals("2")){
qrysb.append("   GROUP BY  (MS.STATE_NM,MS.STATE_CD))"      );

}

if(DLEVEL.equals("3")){
qrysb.append("   GROUP BY  dm.DISTRICT_NAME, dm.DISTRICT_CD    "      );
}

qrysb.append("   UNION ALL"      );
qrysb.append("   ("      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   SELECT  /*+ PARALLEL(AUTO) */ "      );

if(DLEVEL.equals("2")){
qrysb.append("   (MS.STATE_NM) AS STATE_NM,(MS.STATE_CD) AS STATE_CD ,  "      );
}

if(DLEVEL.equals("3")){
qrysb.append("   DM.DISTRICT_NAME,DM.DISTRICT_CD,"      );
}

qrysb.append("   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  "      );
qrysb.append("     0,0,0,0,0,0,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN 1"      );
qrysb.append("     END, 0)) AS mm_rel_tot_s,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"' "      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS mm_rel_AMT_tot_s,"      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"' AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN 1"      );
qrysb.append("     END, 0)) AS mm_rel_s,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN   TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"' AND TRUNC(ad.ONLINE_SUBDT) >= '"+FROMDT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
qrysb.append("       AND bd.MM_CLAIM_DT    IS NOT NULL    THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS mm_rel_AMT_s,"      );
qrysb.append("      SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"' "      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       "      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS PRV_mm_rel_s,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  TRUNC(ad.ONLINE_SUBDT) < '"+FROMDT+"'"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) BETWEEN  '"+FROMDT+"' AND '"+TODT+"'"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       "      );
qrysb.append("       THEN ROUND(bd.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END, 0)) AS PRV_mm_rel_AMT_s,"      );
qrysb.append("    0 AS edp_cert_iss,0,0,0,0"      );
qrysb.append("   "      );
qrysb.append("   FROM app_detail_SECOND ad,"      );
qrysb.append("     bank_dataentry_SECOND bd,"      );
qrysb.append("     m_district dm,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     m_state ms,"      );
qrysb.append("     ZONE_MAST ZM"      );
qrysb.append("   WHERE ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("   AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("   AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("   AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("   AND ms.ZONE_CD      = ZM.ZONE_CD"      );

//////////////////////////////////////////agency
qrysb.append("   and  MOM.AGENCY_TYPE like '%"+AGENTYPE+"%'"      );


if(DLEVEL.equals("1")){
qrysb.append("   )    "      );

}

if(DLEVEL.equals("2")){
qrysb.append("   GROUP BY  (MS.STATE_NM,MS.STATE_CD))"      );

}

if(DLEVEL.equals("3")){
qrysb.append(" GROUP BY  (dm.DISTRICT_NAME, dm.DISTRICT_CD ))    "      );
}

qrysb.append("   UNION ALL (select  /*+ PARALLEL(AUTO) */ "      );
if(DLEVEL.equals("2")){
qrysb.append("   (MS.STATE_NM) AS STATE_NM,(MS.STATE_CD) AS STATE_CD ,  "      );
}

if(DLEVEL.equals("3")){
qrysb.append("   DM.DISTRICT_NAME,DM.DISTRICT_CD,"      );
}


qrysb.append("   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  "      );
qrysb.append("     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN  apr_year=( select getfinyr('"+FROMDT+"')  from dual) "      );
qrysb.append("        "      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS MM_REL_NO_OLD  ,"      );
qrysb.append("        SUM(NVL( CASE"      );
qrysb.append("         WHEN  apr_year=( select getfinyr('"+FROMDT+"')  from dual) "      );
qrysb.append("        "      );
qrysb.append("         THEN ROUND(cf.MARGIN_AMOUNT_CLAIMED / 100000, 2)"      );
qrysb.append("       END, 0)) AS MM_REL_AMT_OLD  "      );
qrysb.append("     FROM pmegponline.app_detail ad,"      );
qrysb.append("       pmegponline.corpdata_final cf,"      );
qrysb.append("       m_district dm,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ad.APP_ID     = cf.APP_ID"      );
qrysb.append("     AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("     AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("     AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("     AND ms.ZONE_CD      = ZM.ZONE_CD"      );
qrysb.append("     "      );

//////////////////////////////////////////agency
qrysb.append("   and  MOM.AGENCY_TYPE like '%"+AGENTYPE+"%'"      );


if(DLEVEL.equals("1")){
qrysb.append("  )    "      );

}

if(DLEVEL.equals("2")){
qrysb.append("   GROUP BY  (MS.STATE_NM,MS.STATE_CD))"      );

}

if(DLEVEL.equals("3")){
qrysb.append(" GROUP BY  (dm.DISTRICT_NAME, dm.DISTRICT_CD )) )   "      );
}


qrysb.append("   )"      );

if(DLEVEL.equals("2")){
qrysb.append("   where state_cd='"+STATE_CD+"' GROUP BY  (STATE_NM,STATE_CD)    "      );
}

if(DLEVEL.equals("3")){
qrysb.append("   where DISTRICT_CD='"+DISTRICT_CD+"' GROUP BY  (DISTRICT_CD,DISTRICT_NAME)    "      );
}

//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();
ResultSet rsMain = db.execSQL(qrysb.toString());
 %>
 

 <%if(DLEVEL.equals("1")){%>
 <DIV align="center"><H2>Application Status (INDIA)<A class="btn btn-primary" href="index22.jsp">Back</A></H2></DIV>
<%}%>
 <%if(DLEVEL.equals("2")){%>
 <DIV align="center"><H2>Application Status (<%= STATE_NM %>)<A class="btn btn-primary" href="index22_stnew.jsp">Back</A></H2></DIV>
<%}%>
 <%if(DLEVEL.equals("3")){%>
 <DIV align="center"><H2>Application Status (<%= DISTRICT_NAME %> , <%= STATE_NM %>) <A class="btn btn-primary" href="index22_ds.jsp?STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>">Back</A></H2></DIV>
<%}%>

<TABLE  align="center" width="70%" cellpadding="2" cellspacing="10" id="customers">
 <THEAD>
    <TR>
	 <TH ><DIV align="center">AGENCY</DIV></TH>
	 <TD><DIV align="center">
	 <%if(AGENTYPE.equals("")){%>
	 All
	 <%}%>
	 <%=AGENTYPE%>
	 
	 </DIV></TD>
	 <TH ><DIV align="center">FROM</DIV></TH>
	 <TD><DIV align="center"><%=FROMDT%></DIV></TD>
	  <TH ><DIV align="center">TO</DIV></TH>
	 <TD><DIV align="center"><%=TODT%></DIV></TD>
	 <% if(DLEVEL.equals("2")){%>
	  <TH ><DIV align="center">STATE</DIV></TH>
	 <TD><DIV align="center"><%=STATE_NM%></DIV></TD>
	 <%}%>
	 <% if(DLEVEL.equals("3")){%>
	  <TH ><DIV align="center">DISTRICT</DIV></TH>
	 <TD><DIV align="center"><%=vDISTRICT%></DIV></TD>
	 <%}%>
    </TR>
	</THEAD>
	<TBODY>
	<TR>
	</TR>
	</TBODY>
  </TABLE>
<P>&nbsp;</P>
<DIV id="wrapper">
<TABLE align="center" width="80%" cellpadding="2" cellspacing="10" id="customers">
 <THEAD>
    <TR>
	 <TH rowspan="2" ><DIV align="center">Sr No</DIV></TH>
	 <TH rowspan="2" ><DIV align="center">Particulars</DIV></TH>
	  <TH colspan="2" ><DIV align="center"> Current Year</DIV> </TH>
	    <TH colspan="2" ><DIV align="center">Previous Year </DIV></TH>
		 <TH colspan="2" ><DIV align="center">Total </DIV></TH>
		  <TH rowspan="2" ><DIV align="center">In % </DIV></TH>
    </TR>
    <TR>
      <TH ><DIV align="center">No. of Project </DIV></TH>
      <TH ><DIV align="center">MM Involved </DIV></TH>
     <TH ><DIV align="center">No. of Project </DIV></TH>
      <TH ><DIV align="center">MM Involved</DIV></TH>
	    <TH ><DIV align="center">No. of Project </DIV></TH>
      <TH ><DIV align="center">MM Involved</DIV></TH>
    </TR>
   </THEAD>
  
<TBODY>
<% 
int cnt=0;
 while (rsMain.next()) { 
 
 if(DLEVEL.equals("2")){

 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
 
 }
 
 AGN_REJECT =rsMain.getString("AGN_REJECT")==null?"":rsMain.getString("AGN_REJECT");
 agency_up =rsMain.getString("agency_up")==null?"":rsMain.getString("agency_up");
 AGN_RECV =rsMain.getString("AGN_RECV")==null?"":rsMain.getString("AGN_RECV"); 
 bank_ford_tot =rsMain.getString("bank_ford_tot")==null?"":rsMain.getString("bank_ford_tot");
 bank_ford_MM_tot =rsMain.getString("bank_ford_MM_tot")==null?"":rsMain.getString("bank_ford_MM_tot");
 bank_ford =rsMain.getString("bank_ford")==null?"":rsMain.getString("bank_ford");
 bank_ford_MM =rsMain.getString("bank_ford_MM")==null?"":rsMain.getString("bank_ford_MM");
 PRV_BANK_FORD_PEN =rsMain.getString("PRV_BANK_FORD_PEN")==null?"":rsMain.getString("PRV_BANK_FORD_PEN");
 PRV_BANK_FORD_PEN_MM =rsMain.getString("PRV_BANK_FORD_PEN_MM")==null?"":rsMain.getString("PRV_BANK_FORD_PEN_MM");
 
 bank_recv_tot =rsMain.getString("bank_recv_tot")==null?"":rsMain.getString("bank_recv_tot");
 bank_recv_MM_tot =rsMain.getString("bank_recv_MM_tot")==null?"":rsMain.getString("bank_recv_MM_tot");
 bank_recv =rsMain.getString("bank_recv")==null?"":rsMain.getString("bank_recv");
 bank_recv_MM =rsMain.getString("bank_recv_MM")==null?"":rsMain.getString("bank_recv_MM");
 PRV_bank_recv =rsMain.getString("PRV_bank_recv")==null?"":rsMain.getString("PRV_bank_recv");
 PRV_bank_recv_MM =rsMain.getString("PRV_bank_recv_MM")==null?"":rsMain.getString("PRV_bank_recv_MM");
 
  bank_pend_tot =rsMain.getString("bank_pend_tot")==null?"":rsMain.getString("bank_pend_tot");
  bank_pend_MM_tot =rsMain.getString("bank_pend_MM_tot")==null?"":rsMain.getString("bank_pend_MM_tot"); 
  bank_pend =rsMain.getString("bank_pend")==null?"":rsMain.getString("bank_pend");
 bank_pend_MM =rsMain.getString("bank_pend_MM")==null?"":rsMain.getString("bank_pend_MM");
 PRV_bank_pend =rsMain.getString("PRV_bank_pend")==null?"":rsMain.getString("PRV_bank_pend");
 PRV_bank_pend_MM =rsMain.getString("PRV_bank_pend_MM")==null?"":rsMain.getString("PRV_bank_pend_MM");
 

 bank_reject_tot =rsMain.getString("bank_reject_tot")==null?"":rsMain.getString("bank_reject_tot");
 bank_reject_MM_tot =rsMain.getString("bank_reject_MM_tot")==null?"":rsMain.getString("bank_reject_MM_tot");
 bank_reject =rsMain.getString("bank_reject")==null?"":rsMain.getString("bank_reject");
 bank_reject_MM =rsMain.getString("bank_reject_MM")==null?"":rsMain.getString("bank_reject_MM");
 PRV_bank_reject =rsMain.getString("PRV_bank_reject")==null?"":rsMain.getString("PRV_bank_reject");
 PRV_bank_reject_MM =rsMain.getString("PRV_bank_reject_MM")==null?"":rsMain.getString("PRV_bank_reject_MM");
 
  bank_sanc_tot =rsMain.getString("bank_sanc_tot")==null?"":rsMain.getString("bank_sanc_tot");
 bank_sanc_MM_tot =rsMain.getString("bank_sanc_MM_tot")==null?"":rsMain.getString("bank_sanc_MM_tot");
 bank_sanc =rsMain.getString("bank_sanc")==null?"":rsMain.getString("bank_sanc");
 bank_sanc_MM =rsMain.getString("bank_sanc_MM")==null?"":rsMain.getString("bank_sanc_MM");
 PRV_bank_sanc =rsMain.getString("PRV_bank_sanc")==null?"":rsMain.getString("PRV_bank_sanc");
 PRV_bank_sanc_MM =rsMain.getString("PRV_bank_sanc_MM")==null?"":rsMain.getString("PRV_bank_sanc_MM");
 
 
  OWN_CONT_tot =rsMain.getString("OWN_CONT_tot")==null?"":rsMain.getString("OWN_CONT_tot");
 OWN_CONT_MM_tot =rsMain.getString("OWN_CONT_MM_tot")==null?"":rsMain.getString("OWN_CONT_MM_tot");
  OWN_CONT =rsMain.getString("OWN_CONT")==null?"":rsMain.getString("OWN_CONT");
 OWN_CONT_MM =rsMain.getString("OWN_CONT_MM")==null?"":rsMain.getString("OWN_CONT_MM");
 PRV_OWN_CONT =rsMain.getString("PRV_OWN_CONT")==null?"":rsMain.getString("PRV_OWN_CONT");
 PRV_OWN_CONT_MM =rsMain.getString("PRV_OWN_CONT_MM")==null?"":rsMain.getString("PRV_OWN_CONT_MM");
 
 
   IST_LOANSANC_tot =rsMain.getString("IST_LOANSANC_tot")==null?"":rsMain.getString("IST_LOANSANC_tot");
   IST_LOANSANC_MM_tot =rsMain.getString("IST_LOANSANC_MM_tot")==null?"":rsMain.getString("IST_LOANSANC_MM_tot");
  IST_LOANSANC =rsMain.getString("IST_LOANSANC")==null?"":rsMain.getString("IST_LOANSANC");
   IST_LOANSANC_MM =rsMain.getString("IST_LOANSANC_MM")==null?"":rsMain.getString("IST_LOANSANC_MM");
 PRV_IST_LOANSANC =rsMain.getString("PRV_IST_LOANSANC")==null?"":rsMain.getString("PRV_IST_LOANSANC");
 PRV_IST_LOANSANC_MM =rsMain.getString("PRV_IST_LOANSANC_MM")==null?"":rsMain.getString("PRV_IST_LOANSANC_MM");
 
 
 mm_claim_tot =rsMain.getString("mm_claim_tot")==null?"":rsMain.getString("mm_claim_tot");
 mm_claim_AMT_tot =rsMain.getString("mm_claim_AMT_tot")==null?"":rsMain.getString("mm_claim_AMT_tot");
 mm_claim =rsMain.getString("mm_claim")==null?"":rsMain.getString("mm_claim");
 mm_claim_AMT =rsMain.getString("mm_claim_AMT")==null?"":rsMain.getString("mm_claim_AMT");
 PRV_mm_claim =rsMain.getString("PRV_mm_claim")==null?"":rsMain.getString("PRV_mm_claim");
 PRV_mm_claim_AMT =rsMain.getString("PRV_mm_claim_AMT")==null?"":rsMain.getString("PRV_mm_claim_AMT");
 MM_REL_NO_OLD=rsMain.getString("MM_REL_NO_OLD")==null?"":rsMain.getString("MM_REL_NO_OLD");
 MM_REL_AMT_OLD=rsMain.getString("MM_REL_AMT_OLD")==null?"":rsMain.getString("MM_REL_AMT_OLD");
 
 mm_rel_AMT_tot =rsMain.getString("mm_rel_AMT_tot")==null?"":rsMain.getString("mm_rel_AMT_tot");
 mm_rel_tot =rsMain.getString("mm_rel_tot")==null?"":rsMain.getString("mm_rel_tot");
 mm_rel_AMT =rsMain.getString("mm_rel_AMT")==null?"":rsMain.getString("mm_rel_AMT");
 mm_rel =rsMain.getString("mm_rel")==null?"":rsMain.getString("mm_rel");
 PRV_mm_rel_AMT =rsMain.getString("PRV_mm_rel_AMT")==null?"":rsMain.getString("PRV_mm_rel_AMT");
 
  PRV_mm_rel =rsMain.getString("PRV_mm_rel")==null?"":rsMain.getString("PRV_mm_rel");
  
  
   mm_rel_AMT_tot_s =rsMain.getString("mm_rel_AMT_tot_s")==null?"":rsMain.getString("mm_rel_AMT_tot_s");
 mm_rel_tot_s =rsMain.getString("mm_rel_tot_s")==null?"":rsMain.getString("mm_rel_tot_s");
 mm_rel_AMT_s =rsMain.getString("mm_rel_AMT_s")==null?"":rsMain.getString("mm_rel_AMT_s");
 mm_rel_s =rsMain.getString("mm_rel_s")==null?"":rsMain.getString("mm_rel_s");
 PRV_mm_rel_AMT_s =rsMain.getString("PRV_mm_rel_AMT_s")==null?"":rsMain.getString("PRV_mm_rel_AMT_s");
 
  PRV_mm_rel_s =rsMain.getString("PRV_mm_rel_s")==null?"":rsMain.getString("PRV_mm_rel_s");
  
  
  
  
  
     mm_release_tot= rsMain.getString("mm_release_tot")==null?"":rsMain.getString("mm_release_tot");
   mm_release_amt_tot =rsMain.getString("mm_release_amt_tot")==null?"":rsMain.getString("mm_release_amt_tot");
    rel_no =rsMain.getString("rel_no")==null?"":rsMain.getString("rel_no");
     rel_amt =rsMain.getString("rel_amt")==null?"":rsMain.getString("rel_amt");
      prv_rel =rsMain.getString("prv_rel")==null?"":rsMain.getString("prv_rel");
       pre_rel_amt =rsMain.getString("pre_rel_amt")==null?"":rsMain.getString("pre_rel_amt");
  
  
 edp_cert_iss =rsMain.getString("edp_cert_iss")==null?"":rsMain.getString("edp_cert_iss");
   
 edp_cert_iss_c =rsMain.getString("edp_cert_iss_c")==null?"":rsMain.getString("edp_cert_iss_c");
   
 edp_cert_iss_p =rsMain.getString("edp_cert_iss_p")==null?"":rsMain.getString("edp_cert_iss_p");



%>
  <TR>
    <TH colspan="9">AGENCY LEVEL</TH>
  </TR>
  <TR>
    <TD><DIV align="center">1</DIV></TD>
     <TD ><DIV align="center">Application Received </DIV></TD>
    <TD><DIV align="right"><%= AGN_RECV %></DIV></TD>
   
	<TD><DIV align="right"></DIV></TD>
	<TD><DIV align="right"></DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
	<TD> <DIV align="right"><%= AGN_RECV %>  </DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
	<TD> <DIV align="right"><%=calculatePercentage(AGN_RECV,AGN_RECV)%>  </DIV></TD>
  </TR>
    <TR>
    <TD><DIV align="center">2</DIV></TD>
     <TD ><DIV align="center">Returned By Agency </DIV></TD>
    <TD><DIV align="right"><%= AGN_REJECT %></DIV></TD>
   
	<TD><DIV align="right"></DIV></TD>
	<TD><DIV align="right"></DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
	<TD> <DIV align="right"><%= AGN_REJECT %>  </DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
	<TD><DIV align="right"><%=calculatePercentage(AGN_REJECT,AGN_RECV)%></DIV></TD>
  </TR>
   <TR>
    <TD><DIV align="center">3</DIV></TD>
     <TD ><DIV align="center">Under Process At Agency </DIV></TD>
    <TD><DIV align="right"><%= agency_up %></DIV></TD>
   
	<TD><DIV align="right"></DIV></TD>
	<TD><DIV align="right"></DIV></TD>
		<TD>   <DIV align="right"></DIV></TD>
	<TD><DIV align="right"><%= agency_up %>   </DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
	<TD> <DIV align="right"><%=calculatePercentage(agency_up,AGN_RECV)%>  </DIV></TD>
  </TR>
   
    <TR>
    <TD><DIV align="center">4</DIV></TD>
     <TD ><DIV align="center">Forwarded to Bank </DIV></TD>
    <TD><DIV align="right"><%= bank_ford %></DIV></TD>
   
	<TD><DIV align="right"><%= bank_ford_MM %></DIV></TD>
	<TD><DIV align="right"><%= PRV_BANK_FORD_PEN %></DIV></TD>
		<TD> <DIV align="right"><%=PRV_BANK_FORD_PEN_MM%>  </DIV></TD>
	<TD><DIV align="right"><%= bank_ford_tot %></DIV></TD>
   
	<TD><DIV align="right"><%= bank_ford_MM_tot %></DIV></TD>
	<TD> <DIV align="right"><%=calculatePercentage(bank_ford,AGN_RECV)%>  </DIV></TD>
  </TR>
  <TR>
    <Th colspan="9">BANK LEVEL</Th>
  </TR>
    <TR>
    <TD><DIV align="center">5</DIV></TD>
     <TD ><DIV align="center">Received By Bank </DIV></TD>
   <!-- <TD><DIV align="center"><%= bank_recv %></DIV></TD>  
   
    <TD><DIV align="center"><%= bank_recv_MM %></DIV></TD>
 	<TD><DIV align="center"><%= PRV_bank_recv %>   </DIV></TD>
	<TD><DIV align="center"><%= PRV_bank_recv_MM %>   </DIV></TD>
	 <TD><DIV align="center"><%= bank_recv_tot %></DIV></TD>  
   
    <TD><DIV align="center"><%= bank_recv_MM_tot %></DIV></TD>
	 <TD><DIV align="center">   </DIV></TD>-->
	 <TD><DIV align="right"><%= bank_ford %></DIV></TD>
   
	<TD><DIV align="right"><%= bank_ford_MM %></DIV></TD>
	<TD><DIV align="right"><%= PRV_BANK_FORD_PEN %></DIV></TD>
		<TD> <DIV align="right"><%=PRV_BANK_FORD_PEN_MM%>  </DIV></TD>
	<TD><DIV align="right"><%= bank_ford_tot %></DIV></TD>
   
	<TD><DIV align="right"><%= bank_ford_MM_tot %></DIV></TD>
	<TD><DIV align="right"><%=calculatePercentage(bank_ford_MM_tot,bank_ford_MM_tot)%>    </DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="center">6</DIV></TD>
     <TD ><DIV align="center">Pending at Bank for Credit Decision </DIV></TD>
    <TD><DIV align="right"><%= bank_pend %></DIV></TD>
   
    
    <TD><DIV align="right"><%= bank_pend_MM %></DIV></TD>
 	<TD><DIV align="right"><%= PRV_bank_pend %></DIV></TD>
   
    
    <TD><DIV align="right"><%= PRV_bank_pend_MM %></DIV></TD>
	<TD><DIV align="right"><%= bank_pend_tot %></DIV></TD>
   
    
    <TD><DIV align="right"><%=bank_pend_MM_tot %></DIV></TD>
	<TD>  <DIV align="right"><%=calculatePercentage(bank_pend_tot,bank_ford_tot)%>   </DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="center">7</DIV></TD>
     <TD ><DIV align="center">Rejected/Returned By Bank </DIV></TD>
    <TD><DIV align="right"><%= bank_reject %></DIV></TD>
   
    
    <TD><DIV align="right"><%= bank_reject_MM %></DIV></TD>
 	<TD>  <DIV align="right"><%= PRV_bank_reject %> </DIV></TD>
	<TD> <DIV align="right"><%= PRV_bank_reject_MM %>  </DIV></TD>
	 <TD><DIV align="right"><%= bank_reject_tot %></DIV></TD>
   
    
    <TD><DIV align="right"><%= bank_reject_MM_tot %></DIV></TD>
	<TD>  <DIV align="right"><%=calculatePercentage(bank_reject_tot,bank_ford_tot)%>  </DIV></TD>
  </TR>
 
  <TR>
    <TD><DIV align="center">8</DIV></TD>
     <TD ><DIV align="center">Sanctioned By Bank </DIV></TD>
    <TD ><DIV align="right"><%= bank_sanc %></DIV></TD>
   
 <TD><DIV align="right"><%= bank_sanc_MM %></DIV></TD>
 	<TD> <DIV align="right"><%= PRV_bank_sanc %>  </DIV></TD>
	<TD><DIV align="right"><%= PRV_bank_sanc_MM %>   </DIV></TD>
	 <TD ><DIV align="right"><%= bank_sanc_tot %></DIV></TD>
   
 <TD><DIV align="right"><%= bank_sanc_MM_tot %></DIV></TD>
 	
	<TD> <DIV align="right"><%=calculatePercentage(bank_sanc_tot,bank_ford_tot)%>   </DIV></TD>
  </TR>
    <TR>
    <Th colspan="9"></Th>
  </TR>
  
      
   <TR>
    <TD><DIV align="center">9</DIV></TD>
     <TD ><DIV align="center">Own Contribution Deposited </DIV></TD>
    <TD><DIV align="right"><%= OWN_CONT %></DIV></TD>
     <TD><DIV align="right"><%= OWN_CONT_MM %></DIV></TD>
	 	<TD> <DIV align="right"><%=PRV_OWN_CONT%>  </DIV></TD>
	<TD> <DIV align="right"><%=PRV_OWN_CONT_MM%>  </DIV></TD>
	 <TD><DIV align="right"><%= OWN_CONT_tot %></DIV></TD>
     <TD><DIV align="right"><%= OWN_CONT_MM_tot%></DIV></TD>
	<TD><DIV align="right"><%=calculatePercentage(OWN_CONT_tot,bank_sanc_tot)%>    </DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="center">10</DIV></TD>
     <TD><DIV align="center">Loan Disbursement </DIV></TD>
    <TD ><DIV align="right"><%= IST_LOANSANC %></DIV></TD>
    <TD><DIV align="right"><%= IST_LOANSANC_MM %></DIV></TD>
		<TD><DIV align="right"><%= PRV_IST_LOANSANC %>   </DIV></TD>
	<TD><DIV align="right"><%= PRV_IST_LOANSANC_MM %>   </DIV></TD>
	  <TD ><DIV align="right"><%= IST_LOANSANC_tot %></DIV></TD>
    <TD><DIV align="right"><%= IST_LOANSANC_MM_tot %></DIV></TD>
	<TD><DIV align="right"><%=calculatePercentage(IST_LOANSANC_tot,bank_sanc_tot)%>   </DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="center">11</DIV></TD>
     <TD><DIV align="center">EDP Completed </DIV></TD>
    <TD ><DIV align="right"><%= edp_cert_iss_c %></DIV></TD>
   
	 <TD><DIV align="right"></DIV></TD>
	 	<TD><DIV align="right"><%= edp_cert_iss_p %> </DIV></TD>
	   <TD ><DIV align="right"></DIV></TD>
	
	<TD><DIV align="right"><%= edp_cert_iss %></DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
	<TD><DIV align="right"><%=calculatePercentage(edp_cert_iss,bank_sanc_tot)%>    </DIV></TD>
  </TR> 
  
  
   <TR>
    <TD><DIV align="center">12</DIV></TD>
     <TD><DIV align="center">Margin Money Claim </DIV></TD>
    <TD ><DIV align="right"><%= mm_claim %></DIV></TD>
   
	<TD><DIV align="right"><%= mm_claim_AMT %></DIV></TD>
		<TD><DIV align="right"><%=PRV_mm_claim%>   </DIV></TD>
	<TD><DIV align="right"><%=PRV_mm_claim_AMT%>   </DIV></TD>
	<TD ><DIV align="right"><%= mm_claim_tot %></DIV></TD>
   
	<TD><DIV align="right"><%= mm_claim_AMT_tot %></DIV></TD>
	<TD><DIV align="right"><%=calculatePercentage(mm_claim_tot,bank_sanc_tot)%>    </DIV></TD>
  </TR>
   <TR>
    <Th colspan="9">MARGIN MONEY RELEASED</Th>
  </TR>
    
    <TR>
    <TD><DIV align="center">a)</DIV></TD>
     <TD><DIV align="center">First Loan </DIV></TD>
    <TD ><DIV align="right"><%= mm_rel %></DIV></TD>
   
	 <TD><DIV align="right"><%= mm_rel_AMT %></DIV></TD>
	 <TD ><DIV align="right"><%= PRV_mm_rel %></DIV></TD>
   
	 <TD><DIV align="right"><%= PRV_mm_rel_AMT %></DIV></TD>
	<TD ><DIV align="right"><%= mm_rel_tot %></DIV></TD>
   
	 <TD><DIV align="right"><%= mm_rel_AMT_tot %></DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
  </TR>
  
    <TR>
    <TD><DIV align="center">b)</DIV></TD>
     <TD><DIV align="center">Second Loan </DIV></TD>
    <TD ><DIV align="right"><%= mm_rel_s %></DIV></TD>
   
	 <TD><DIV align="right"><%= mm_rel_AMT_s %></DIV></TD>
	 	<TD><DIV align="right"><%=PRV_mm_rel_s%>   </DIV></TD>
	<TD><DIV align="right"><%=PRV_mm_rel_AMT_s%>   </DIV></TD>
	<TD><DIV align="right"><%=mm_rel_tot_s%>   </DIV></TD>
	<TD><DIV align="right"><%=mm_rel_AMT_tot_s%>   </DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
  </TR>
  
    <TR>
    <TD><DIV align="center">c)</DIV></TD>
     <TD><DIV align="center">Old Claim </DIV></TD>
    <TD><DIV align="right">0</DIV></TD>
   
	 <TD><DIV align="right">0</DIV></TD>
	 	<TD><DIV align="right"><%=MM_REL_NO_OLD%></DIV></TD>
	<TD> <DIV align="right"><%=MM_REL_AMT_OLD %> </DIV></TD>
	<TD><DIV align="right"><%=MM_REL_NO_OLD%>   </DIV></TD>
	<TD> <DIV align="right"><%=MM_REL_AMT_OLD %>   </DIV></TD>
	 <TD><DIV align="right"></DIV></TD>
  </TR>
  <TR>
    <TD><DIV align="center">13</DIV></TD>
     <TD><DIV align="center">Total Margin Money Release </DIV></TD>
    <TD><DIV align="right"><%= rel_no %></DIV></TD>
   
	 <TD><DIV align="right"><%= rel_amt %></DIV></TD>
	 	<TD><DIV align="right"><%=prv_rel%>   </DIV></TD>
	<TD><DIV align="right"><%=pre_rel_amt%>   </DIV></TD>
	 <TD><DIV align="right"><%= mm_release_tot %></DIV></TD>
   
	 <TD><DIV align="right"><%= mm_release_amt_tot %></DIV></TD>
	<TD>   <DIV align="right"></DIV></TD>
  </TR>
    </TBODY>
   <% 
    }
  rsMain.close();
  db.close();
    %>
</TABLE>
</DIV>
<SCRIPT type="text/javascript">
$(function(){
  $('#keywords').tablesorter(); 
});
</SCRIPT>
</FORM>
</BODY>
</HTML>

