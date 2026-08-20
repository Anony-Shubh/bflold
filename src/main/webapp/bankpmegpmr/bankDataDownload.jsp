<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<HEAD>
<TITLE>PMEGP Portal Monitoring Report</TITLE>



</HEAD>

<BODY>
<FORM  method="post">
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();

String txtSearch="";


String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");


 String vUsrnm= (String) session.getAttribute("sponc_banknm");




 
 StringBuffer qrysb=new StringBuffer();

qrysb.append("   SELECT   /*+ PARALLEL(AUTO) */  "      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NVL(a.ACT_ID, 0) IN (0,8)"      );
qrysb.append("       THEN 'Under Process at Bank'"      );
qrysb.append("       WHEN a.ACT_ID = 3"      );
qrysb.append("       THEN 'Rejected'"      );
qrysb.append("       ELSE 'Sanctioned'"      );
qrysb.append("     END AS status,"      );
qrysb.append("     b.APP_ID,"      );
qrysb.append("     OM.AGENCY_TYPE,"      );
qrysb.append("     OM.OFF_NAME1      AS AGENCY_STATE,"      );
qrysb.append("     UPPER(b.APP_NAME) AS APP_NAME,"      );
qrysb.append("     b.UNIT_POST_ADDR"      );
qrysb.append("     || ', '"      );
qrysb.append("     || b.UNIT_TALUK_BLOCK"      );
qrysb.append("     || ', '"      );
qrysb.append("     || UD.DISTRICT_NAME"      );
qrysb.append("     || ', '"      );
qrysb.append("     || b.UNIT_PIN AS communication_address,"      );
qrysb.append("     DECODE(b.aadhar_no,NULL,NULL, '*****' || substr(b.aadhar_no,7,length(b.aadhar_no)-6)) AADHAR_NO,"      );
qrysb.append("     b.MOB_NO1 AS TEL_NO,"      );
qrysb.append("    b.PAN_NO,"      );
qrysb.append("     b.E_MAIL,"      );
qrysb.append("     b.PAN_NO,"      );
qrysb.append("     b.UNIT_LOC,"      );
qrysb.append("     b.UNIT_POST_ADDR,"      );
qrysb.append("     b.UNIT_TALUK_BLOCK,"      );
qrysb.append("     UD.DISTRICT_NAME,"      );
qrysb.append("     b.UNIT_PIN,"      );
qrysb.append("     DECODE(upper(b.GENDER), 'MALE', 'M', 'F') AS Gender,"      );
qrysb.append("    C.BENF_CATEGORY_CD AS cat,"      );
qrysb.append("      b.BENF_SPECAT_CD,"      );
qrysb.append("   "      );
qrysb.append("       CASE"      );
qrysb.append("       WHEN  b.IND_TYPE = 'M'"      );
qrysb.append("       THEN 'MANNUFACTURING'"      );
qrysb.append("       WHEN b.IND_TYPE = 'T'"      );
qrysb.append("       THEN 'TRADING'"      );
qrysb.append("       WHEN b.IND_TYPE = 'S'"      );
qrysb.append("       THEN 'SERVICE'"      );
qrysb.append("       ELSE 'Sanctioned'"      );
qrysb.append("     END AS IND_TYPE,"      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("      AM.ACTIVITY_NAME,"      );
qrysb.append("     b.PROD_DESC,"      );
qrysb.append("     CASE when nvl(b.dltfc_ce,0)+nvl(b.dltfc_wc,0) > 0 then"      );
qrysb.append("     nvl(b.dltfc_ce,0)+nvl(b.dltfc_wc,0)"      );
qrysb.append("     else"      );
qrysb.append("      NVL(b.MACHINARY_COST, 0) + NVL(b.WORKING_CAPITAL,0)"      );
qrysb.append("      end  Prop_proj_cost,"      );
qrysb.append("     MMINVOLVE(b.APP_ID)                                                                                      AS MMINV_PRJCOST,"      );
qrysb.append("     b.BANK_F_DATE                                                                                            AS bank_f_date,"      );
qrysb.append("     b.IFSC_CODE                                                                                              AS br_code,"      );
qrysb.append("     RBI.BANK_NAME                                                                                              AS bank_name,"      );
qrysb.append("     RBI.BRANCHNAME AS BRANCH_NAME,"      );
qrysb.append("     a.BANK_REC_DT,"      );
qrysb.append("     a.BANK_REMARKS                                       AS REJ_REASON,"      );
qrysb.append("     NVL(a.MACHINARY_COST, 0)                             AS ce_apprv_bank,"      );
qrysb.append("     NVL(a.WORKING_CAPITAL, 0)                            AS wc_apprv_bank,"      );
qrysb.append("     NVL(a.MACHINARY_COST, 0) + NVL(a.WORKING_CAPITAL, 0) AS total_apprv_bank,"      );
qrysb.append("     NVL(a.CE_SANC_FB, 0)                                 AS sanc_total_ce,"      );
qrysb.append("     NVL(a.WC_SANC_FB, 0)                                 AS sanc_wc,"      );
qrysb.append("     NVL(a.CE_SANC_FB, 0) + NVL(a.WC_SANC_FB, 0)          AS total_loan_sanc,"      );
qrysb.append("     a.LOAN_SANC_DT                                       AS loan_sanc_dt,"      );
qrysb.append("     TO_CHAR(a.OWN_CONT_DT, 'DD-MON-YYYY')                AS own_cont_dt,"      );
qrysb.append("     a.OWN_CONTRIBUTION,"      );
qrysb.append("     a.EDP_TRG_NAME,"      );
qrysb.append("     a.EDP_FR_DT,"      );
qrysb.append("     a.EDP_TO_DT,"      );
qrysb.append("     (TRUNC(a.EDP_TO_DT)-TRUNC(a.EDP_FR_DT)) AS EDP_TRAIN_DURATION,"      );
qrysb.append("     a.EDP_CERT_DT,"      );
qrysb.append("     TO_CHAR(a.IST_LOAN_DT, 'DD-MON-YYYY') AS loan_rel_dt,"      );
qrysb.append("     a.IST_LOAN_AMT                        AS loan_rel_amt,"      );
qrysb.append("     a.APPLOAN_ACCNO,"      );
qrysb.append("     a.CGTSI,"      );
qrysb.append("     TO_CHAR(a.MM_CLAIM_DT, 'DD-MON-YYYY') AS mm_claim_dt,"      );
qrysb.append("     a.MM_CLAIM_AMT,"      );
qrysb.append("     TO_CHAR(a.MM_REL_DT, 'DD-MON-YYYY') AS mm_rel_dt,"      );
qrysb.append("     a.MM_REL_AMT,"      );
qrysb.append("     a.PAY_STATUS AS MM_DIS_STATUS,"      );
qrysb.append("     a.UTRN_NO AS MM_DIS_REF_NO,"      );
qrysb.append("     a.FAIL_REASON,"      );
qrysb.append("     TO_CHAR(a.TDR_ADJ_DT, 'DD-MON-YYYY') AS tdr_adj_dt,"      );
qrysb.append("     a.TDR_ADJ_AMT,"      );
qrysb.append("   a.FB_ACNO,BM.NEFT_IFSC,"      );
qrysb.append("     BM.HIRONE,"      );
qrysb.append("     BM.HIRTWO,"      );
qrysb.append("     TO_CHAR(a.TIME_STAMP, 'DD-MON-YYYY:HH:MM:SS') AS LAST_UPDATE_DT"      );
qrysb.append("     FROM bank_dataentry a,"      );
qrysb.append("     app_detail b,"      );
qrysb.append("     BENF_CATEGORY_MAST C,"      );
qrysb.append("     M_DISTRICT UD,"      );
qrysb.append("     M_STATE UST,"      );
qrysb.append("     bank_br_mast BM,"      );
qrysb.append("     MAS_OFF_MAST OM,"      );
qrysb.append("     ACTIVITY_MAST AM,RBIBANKLIST RBI"      );
qrysb.append("   WHERE b.APP_ID         = a.APP_ID(+)"      );
qrysb.append("   AND b.BENF_CATAGORY_CD = C.BENF_CATEGORY_CD"      );
qrysb.append("   AND b.UNIT_DIST_CD     = UD.DISTRICT_CD"      );
qrysb.append("   AND b.OFF_CD           = OM.OFF_CD"      );
qrysb.append("   AND UD.STATE_CD        = UST.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD      = B.ACTIVITY_CD"      );
qrysb.append("   AND b.IFSC_CODE        = BM.BR_IFSL_CODE"      );
qrysb.append("   AND BM.BR_IFSL_CODE=RBI.IFSC_CODE"      );
qrysb.append("   AND b.ACT_YN='Y'"      );
qrysb.append("   AND b.ACT_ID           = 5  "      );
qrysb.append("   AND UPPER(BM.SPON_BANK_NAME) LIKE UPPER('"+vUsrnm+"')"      );
qrysb.append("   AND TRUNC(b.BANK_F_DATE) BETWEEN '"+FromDt+"' AND '"+ToDt+"' "      );


//out.print(vBankName);


//out.print (sb.toString());
ResultSet rsinst = db.execSQL(qrysb.toString());


response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename=" + "BANKDATA.xls");
%> 
  <TABLE border="2" align="center" bordercolor="#000000">

  <TR>
   <TH align="left"> SRNO</TH>
   <TH align="left"> STATUS</TH>
<TH align="left">APP_ID</TH>
<TH align="left">AGENCY_TYPE</TH>
<TH align="left">AGENCY_STATE</TH>
<TH align="left">APP_NAME</TH>
<TH align="left">COMMUNICATION_ADDRESS</TH>
<TH align="left">AADHAR_NO</TH>
<TH align="left">TEL_NO</TH>
<TH align="left">PAN_NO</TH>
<TH align="left">E_MAIL</TH>

<TH align="left">UNIT_LOC</TH>
<TH align="left">UNIT_POST_ADDR</TH>
<TH align="left">UNIT_TALUK_BLOCK</TH>
<TH align="left">DISTRICT_NAME</TH>
<TH align="left">UNIT_PIN</TH>
<TH align="left">GENDER</TH>
<TH align="left">CAT</TH>
<TH align="left">BENF_SPECAT_CD</TH>
<TH align="left">IND_TYPE</TH>
<TH align="left">ACTIVITY_NAME</TH>
<TH align="left">PROD_DESC</TH>
<TH align="left">PROP_PROJ_COST</TH>
<TH align="left">MMINV_PRJCOST</TH>
<TH align="left">BANK_F_DATE</TH>
<TH align="left">BR_CODE</TH>
<TH align="left">BANK_NAME</TH>
<TH align="left">BRANCH_NAME</TH>
<TH align="left">BANK_REC_DT</TH>
<TH align="left">REJ_REASON</TH>
<TH align="left">CE_APPRV_BANK</TH>
<TH align="left">WC_APPRV_BANK</TH>
<TH align="left">TOTAL_APPRV_BANK</TH>
<TH align="left">SANC_TOTAL_CE</TH>
<TH align="left">SANC_WC</TH>
<TH align="left">TOTAL_LOAN_SANC</TH>
<TH align="left">LOAN_SANC_DT</TH>
<TH align="left">WN_CONT_DT</TH>
<TH align="left">OWN_CONTRIBUTION</TH>
<TH align="left">EDP_TRG_NAME</TH>
<TH align="left">EDP_FR_DT</TH>
<TH align="left">EDP_TO_DT</TH>
<TH align="left">EDP_TRAIN_DURATION</TH>
<TH align="left">EDP_CERT_DT</TH>
<TH align="left">LOAN_REL_DT</TH>
<TH align="left">LOAN_REL_AMT</TH>
<TH align="left">APPLOAN_ACCNO</TH>
<TH align="left">CGTSI</TH>
<TH align="left">MM_CLAIM_DT</TH>
<TH align="left">MM_CLAIM_AMT</TH>
<TH align="left">MM_REL_DT</TH>
<TH align="left">MM_REL_AMT</TH>
<TH align="left">MM_DIS_STATUS</TH>
<TH align="left">MM_DIS_REF_NO</TH>
<TH align="left">FAIL_REASON</TH>
<TH align="left">TDR_ADJ_DT</TH>
<TH align="left">TDR_ADJ_AMT</TH>
<TH align="left">FB_ACNO</TH>
<TH align="left">NEFT_IFSC</TH>
<TH align="left">HIRONE</TH>
<TH align="left">HIRTWO</TH>
<TH align="left">LAST_UPDATE_DT</TH>

  </TR>
   <% while (rsinst.next()) {
  srn=srn+1;
   %>
  <TR>
    <TD align="left" ><%=srn%>)</TD>
    <TD align="left" ><%= rsinst.getString("STATUS") %></TD>
<TD align="left" ><%= rsinst.getString("APP_ID") %></TD>
<TD align="left" ><%= rsinst.getString("AGENCY_TYPE") %></TD>
<TD align="left" ><%= rsinst.getString("AGENCY_STATE") %></TD>
<TD align="left" ><%= rsinst.getString("APP_NAME") %></TD>
<TD align="left" ><%= rsinst.getString("COMMUNICATION_ADDRESS") %></TD>
<TD align="left" ><%= rsinst.getString("AADHAR_NO") %></TD>
<TD align="left" ><%= rsinst.getString("TEL_NO") %></TD>
<TD align="left" ><%= rsinst.getString("PAN_NO") %></TD>
<TD align="left" ><%= rsinst.getString("E_MAIL") %></TD>

<TD align="left" ><%= rsinst.getString("UNIT_LOC") %></TD>
<TD align="left" ><%= rsinst.getString("UNIT_POST_ADDR") %></TD>
<TD align="left" ><%= rsinst.getString("UNIT_TALUK_BLOCK") %></TD>
<TD align="left" ><%= rsinst.getString("DISTRICT_NAME") %></TD>
<TD align="left" ><%= rsinst.getString("UNIT_PIN") %></TD>
<TD align="left" ><%= rsinst.getString("GENDER") %></TD>
<TD align="left" ><%= rsinst.getString("CAT") %></TD>
<TD align="left" ><%= rsinst.getString("BENF_SPECAT_CD") %></TD>
<TD align="left" ><%= rsinst.getString("IND_TYPE") %></TD>
<TD align="left" ><%= rsinst.getString("ACTIVITY_NAME") %></TD>
<TD align="left" ><%= rsinst.getString("PROD_DESC") %></TD>
<TD align="left" ><%= rsinst.getString("PROP_PROJ_COST") %></TD>
<TD align="left" ><%= rsinst.getString("MMINV_PRJCOST") %></TD>
<TD align="left" ><%= rsinst.getString("BANK_F_DATE") %></TD>
<TD align="left" ><%= rsinst.getString("BR_CODE") %></TD>
<TD align="left" ><%= rsinst.getString("BANK_NAME") %></TD>
<TD align="left" ><%= rsinst.getString("BRANCH_NAME") %></TD>
<TD align="left" ><%= rsinst.getString("BANK_REC_DT") %></TD>
<TD align="left" ><%= rsinst.getString("REJ_REASON") %></TD>
<TD align="left" ><%= rsinst.getString("CE_APPRV_BANK") %></TD>
<TD align="left" ><%= rsinst.getString("WC_APPRV_BANK") %></TD>
<TD align="left" ><%= rsinst.getString("TOTAL_APPRV_BANK") %></TD>
<TD align="left" ><%= rsinst.getString("SANC_TOTAL_CE") %></TD>
<TD align="left" ><%= rsinst.getString("SANC_WC") %></TD>
<TD align="left" ><%= rsinst.getString("TOTAL_LOAN_SANC") %></TD>
<TD align="left" ><%= rsinst.getString("LOAN_SANC_DT") %></TD>
<TD align="left" ><%= rsinst.getString("OWN_CONT_DT") %></TD>
<TD align="left" ><%= rsinst.getString("OWN_CONTRIBUTION") %></TD>
<TD align="left" ><%= rsinst.getString("EDP_TRG_NAME") %></TD>
<TD align="left" ><%= rsinst.getString("EDP_FR_DT") %></TD>
<TD align="left" ><%= rsinst.getString("EDP_TO_DT") %></TD>
<TD align="left" ><%= rsinst.getString("EDP_TRAIN_DURATION") %></TD>
<TD align="left" ><%= rsinst.getString("EDP_CERT_DT") %></TD>
<TD align="left" ><%= rsinst.getString("LOAN_REL_DT") %></TD>
<TD align="left" ><%= rsinst.getString("LOAN_REL_AMT") %></TD>
<TD align="left" ><%= rsinst.getString("APPLOAN_ACCNO") %></TD>
<TD align="left" ><%= rsinst.getString("CGTSI") %></TD>
<TD align="left" ><%= rsinst.getString("MM_CLAIM_DT") %></TD>
<TD align="left" ><%= rsinst.getString("MM_CLAIM_AMT") %></TD>
<TD align="left" ><%= rsinst.getString("MM_REL_DT") %></TD>
<TD align="left" ><%= rsinst.getString("MM_REL_AMT") %></TD>
<TD align="left" ><%= rsinst.getString("MM_DIS_STATUS") %></TD>
<TD align="left" ><%= rsinst.getString("MM_DIS_REF_NO") %></TD>
<TD align="left" ><%= rsinst.getString("FAIL_REASON") %></TD>
<TD align="left" ><%= rsinst.getString("TDR_ADJ_DT") %></TD>
<TD align="left" ><%= rsinst.getString("TDR_ADJ_AMT") %></TD>
<TD align="left" ><%= rsinst.getString("FB_ACNO") %></TD>
<TD align="left" ><%= rsinst.getString("NEFT_IFSC") %></TD>
<TD align="left" ><%= rsinst.getString("HIRONE") %></TD>
<TD align="left" ><%= rsinst.getString("HIRTWO") %></TD>
<TD align="left" ><%= rsinst.getString("LAST_UPDATE_DT") %></TD>

  </TR>
 <%
}
rsinst.close();
db.close();

%>

</TABLE>
</FORM>

</BODY>
</HTML>
