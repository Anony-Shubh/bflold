<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,java.math.*,pkgPmegpNew.DBCon"  %>
<%
	
DBCon db= new DBCon();
db.connect();

	 List values=new ArrayList();	

StringBuffer qrysb = new StringBuffer();

String LOAN_TYPE="";
String BATCHID="";
String NO_OF_PROJECT="0";
String MM_CLAIMED_AMT="0";
String IRG_AMT="0";
String ACTUAL_MM_CLAIMED="0";
String NO_OF_PROJECT_II="0";
String MM_CLAIMED_AMT_II="0";
String IRG_AMT_II="0";
String ACTUAL_MM_CLAIMED_II="0";
String TOT_MM_AMT="0";
String TOT_IRG_AMT="0";
String TOT_MARGIN_MONEY_CLAIMED_AMOUNT="0";
String TOT_PRJ="0";
//qrysb.append("  SELECT  "      );

qrysb.append("  SELECT /*+ PARALLEL(AUTO) */ SUM(MM_CLAIM_AMT_II) + SUM(MM_CLAIM_AMT) AS TOT_MM_AMT, SUM(IRG_AMT) + SUM(IRG_AMT_II) AS TOT_IRG_AMT,SUM(MARGIN_MONEY_CLAIMED_AMOUNT) + SUM(MARGIN_MONEY_CLAIMED_AMOUNT_II) TOT_MARGIN_MONEY_CLAIMED_AMT,SUM(CASE WHEN PMEGP_APPLICANTION_ID IS NOT NULL THEN 1 ELSE 0 END ) + SUM(CASE WHEN PMEGP_APPLICANTION_ID_II IS NOT NULL THEN 1 ELSE 0 END ) as TOT_PRJ, BATCHID,SUM(CASE WHEN PMEGP_APPLICANTION_ID IS NOT NULL THEN 1 ELSE 0 END ) NO_OF_PROJECT ,SUM(MARGIN_MONEY_CLAIMED_AMOUNT) MM_CLAIMED_AMT,SUM(IRG_AMT)  "      );
qrysb.append(" IRG_AMT,SUM(MM_CLAIM_AMT) ACTUAL_MM_CLAIMED "      );
qrysb.append("  ,SUM(CASE WHEN PMEGP_APPLICANTION_ID_II IS NOT NULL THEN 1 ELSE 0 END ) NO_OF_PROJECT_II,SUM(MARGIN_MONEY_CLAIMED_AMOUNT_II) MM_CLAIMED_AMT_II,SUM(IRG_AMT_II)  "      );
qrysb.append(" IRG_AMT_II,SUM(MM_CLAIM_AMT_II) ACTUAL_MM_CLAIMED_II "      );
qrysb.append("  FROM ( "      );
qrysb.append("  SELECT  "      );
qrysb.append("  "      );
qrysb.append("   AD.APP_ID AS PMEGP_APPLICANTION_ID, "      );
qrysb.append("   BD.MM_CLAIM_AMT - 500  AS MARGIN_MONEY_CLAIMED_AMOUNT,     "      );
qrysb.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE, "      );
qrysb.append("   BD.MM_CLAIM_AMT, "      );
qrysb.append("   500 IRG_AMT, "      );
qrysb.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID, "      );
qrysb.append("    "      );
qrysb.append("     '' AS PMEGP_APPLICANTION_ID_II, "      );
qrysb.append("   0  AS MARGIN_MONEY_CLAIMED_AMOUNT_II, "      );
qrysb.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE_II, "      );
qrysb.append("     0 MM_CLAIM_AMT_II, "      );
qrysb.append("   0 IRG_AMT_II, "      );
qrysb.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID_II "      );
qrysb.append("   FROM APP_DETAIL AD, "      );
qrysb.append("   BANK_DATAENTRY BD, "      );
qrysb.append("   MAS_OFF_MAST MOM, "      );
qrysb.append("   M_DISTRICT MD, "      );
qrysb.append("   M_STATE MS "      );
qrysb.append(" WHERE AD.APP_ID       = BD.APP_ID "      );
qrysb.append(" AND AD.OFF_CD         = MOM.OFF_CD "      );
qrysb.append(" AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD "      );
qrysb.append(" AND MS.STATE_CD       = MD.STATE_CD "      );
qrysb.append(" AND BD.MM_CLAIM_AMT   > 0 "      );
qrysb.append(" AND BD.LOAN_DOCFNAME IS NOT NULL "      );
qrysb.append(" AND BD.APPRV_YN='A' AND BD.MM_REL_DT IS NULL AND  "      );
qrysb.append("  BD.PBATCH_ID IS NULL AND AD.ACT_YN='Y' AND"      );
qrysb.append(" BD.PACT_ID=32 "      );
qrysb.append(" "      );   //--AND BD.EDP_CERT_DT IS NOT NULL 
qrysb.append(" AND BD.FB_ACNO IS NOT NULL "      );
qrysb.append(" AND BD.IFSC_CODE IS NOT NULL AND MATCHTRANSACNO(ad.app_id,1)='Y' AND length(ad.aadhar_no)=12 "      );
qrysb.append(" AND FGETNEFTIFSCODE(AD.APP_ID) IS NOT NULL  AND  mminv_bankadmit(AD.APP_ID)=BD.MM_CLAIM_AMT AND AD.APP_ID NOT IN  (SELECT CS.PMEGP_APPLICANTION_ID FROM CORPDATA_SENT_DETAIL CS WHERE TRUNC(CS.AUTHORISED_DATE)=trunc(SYSDATE)) "      );
qrysb.append("  UNION ALL "      );
qrysb.append("  SELECT  "      );
qrysb.append(" '' AS PMEGP_APPLICANTION_ID, "      );
qrysb.append("   0  AS MARGIN_MONEY_CLAIMED_AMOUNT,   "      );
qrysb.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE, "      );
qrysb.append("  0 MM_CLAIM_AMT, "      );
qrysb.append("   0 IRG_AMT, "      );
qrysb.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID, "      );
qrysb.append("  "      );
qrysb.append("   AD.APP_ID AS PMEGP_APPLICANTION_ID_II, "      );
qrysb.append("   BD.MM_CLAIM_AMT - 500  AS MARGIN_MONEY_CLAIMED_AMOUNT_II, "      );
qrysb.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE_II, "      );
qrysb.append("     BD.MM_CLAIM_AMT MM_CLAIM_AMT_II, "      );
qrysb.append("   500 IRG_AMT_II, "      );
qrysb.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID_II "      );
qrysb.append("   FROM APP_DETAIL_SECOND AD, "      );
qrysb.append("   BANK_DATAENTRY_SECOND BD, "      );
qrysb.append("   MAS_OFF_MAST MOM, "      );
qrysb.append("   M_DISTRICT MD, "      );
qrysb.append("   M_STATE MS "      );
qrysb.append(" WHERE AD.APP_ID       = BD.APP_ID "      );
qrysb.append(" AND AD.OFF_CD         = MOM.OFF_CD "      );
qrysb.append(" AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD "      );
qrysb.append(" AND MS.STATE_CD       = MD.STATE_CD "      );
qrysb.append(" AND BD.MM_CLAIM_AMT   > 0 "      );
qrysb.append(" AND BD.LOAN_DOCFNAME IS NOT NULL "      );
qrysb.append(" AND BD.APPRV_YN='A' AND BD.MM_REL_DT IS NULL AND AD.ACT_YN='Y' "      );
qrysb.append(" AND BD.PBATCH_ID IS NULL "      );
qrysb.append(" AND BD.PACT_ID=32 "      );
qrysb.append(" AND BD.FB_ACNO IS NOT NULL "      );
qrysb.append(" AND BD.IFSC_CODE IS NOT NULL AND MATCHTRANSACNO(ad.app_id,2)='Y' AND length(ad.aadhar_no)=12 "      );
qrysb.append(" AND FGETNEFTIFSCODE_SEC(AD.APP_ID) IS NOT NULL AND  mminv_bankadmit_SEC(AD.APP_ID)=BD.MM_CLAIM_AMT  AND AD.APP_ID NOT IN  (SELECT CS.PMEGP_APPLICANTION_ID FROM CORPDATA_SENT_DETAIL CS WHERE TRUNC(CS.AUTHORISED_DATE)=trunc(SYSDATE)) "      );
qrysb.append("   "      );
qrysb.append("   ) GROUP BY BATCHID "      );


   ResultSet rsMain = db.execSQL(qrysb.toString());
	values.clear();	
		
			while (rsMain.next()){

 BATCHID=rsMain.getString("BATCHID")==null?"":rsMain.getString("BATCHID");
 NO_OF_PROJECT=rsMain.getString("NO_OF_PROJECT")==null?"":rsMain.getString("NO_OF_PROJECT");
 MM_CLAIMED_AMT=rsMain.getString("MM_CLAIMED_AMT")==null?"":rsMain.getString("MM_CLAIMED_AMT");
 IRG_AMT=rsMain.getString("IRG_AMT")==null?"":rsMain.getString("IRG_AMT");
 ACTUAL_MM_CLAIMED=rsMain.getString("ACTUAL_MM_CLAIMED")==null?"":rsMain.getString("ACTUAL_MM_CLAIMED");
 NO_OF_PROJECT_II=rsMain.getString("NO_OF_PROJECT_II")==null?"":rsMain.getString("NO_OF_PROJECT_II");
 MM_CLAIMED_AMT_II=rsMain.getString("MM_CLAIMED_AMT_II")==null?"":rsMain.getString("MM_CLAIMED_AMT_II");
 IRG_AMT_II=rsMain.getString("IRG_AMT_II")==null?"":rsMain.getString("IRG_AMT_II");
 ACTUAL_MM_CLAIMED_II=rsMain.getString("ACTUAL_MM_CLAIMED_II")==null?"":rsMain.getString("ACTUAL_MM_CLAIMED_II");
 
 TOT_MM_AMT=rsMain.getString("TOT_MM_AMT")==null?"":rsMain.getString("TOT_MM_AMT");
 TOT_IRG_AMT=rsMain.getString("TOT_IRG_AMT")==null?"":rsMain.getString("TOT_IRG_AMT");
 TOT_MARGIN_MONEY_CLAIMED_AMOUNT=rsMain.getString("TOT_MARGIN_MONEY_CLAIMED_AMT")==null?"":rsMain.getString("TOT_MARGIN_MONEY_CLAIMED_AMT");
 TOT_PRJ=rsMain.getString("TOT_PRJ")==null?"":rsMain.getString("TOT_PRJ");
 
}
		rsMain.close();


String NNO_OF_PROJECT="";
String NMM_CLAIMED_AMT="";
String NIRG_AMT="";
String NACTUAL_MM_CLAIMED="";
String NNO_OF_PROJECT_II="";
String NMM_CLAIMED_AMT_II="";
String NIRG_AMT_II="";
String NACTUAL_MM_CLAIMED_II="";

String NTOT_MM_AMT="";
String NTOT_IRG_AMT="";
String NTOT_MARGIN_MONEY_CLAIMED_AMOUNT="";
String NTOT_PRJ="";


StringBuffer qrysb1 = new StringBuffer();
				
		//qrysb.append("  SELECT  "      );
qrysb1.append("  SELECT /*+ PARALLEL(AUTO) */  SUM(MM_CLAIM_AMT_II) + SUM(MM_CLAIM_AMT) AS TOT_MM_AMT, SUM(IRG_AMT) + SUM(IRG_AMT_II) AS TOT_IRG_AMT,SUM(MARGIN_MONEY_CLAIMED_AMOUNT) + SUM(MARGIN_MONEY_CLAIMED_AMOUNT_II) TOT_MARGIN_MONEY_CLAIMED_AMT,SUM(CASE WHEN PMEGP_APPLICANTION_ID IS NOT NULL THEN 1 ELSE 0 END ) + SUM(CASE WHEN PMEGP_APPLICANTION_ID_II IS NOT NULL THEN 1 ELSE 0 END ) as TOT_PRJ,BATCHID,SUM(CASE WHEN PMEGP_APPLICANTION_ID IS NOT NULL THEN 1 ELSE 0 END ) NO_OF_PROJECT ,SUM(MARGIN_MONEY_CLAIMED_AMOUNT) MM_CLAIMED_AMT,SUM(IRG_AMT)  "      );
qrysb1.append(" IRG_AMT,SUM(MM_CLAIM_AMT) ACTUAL_MM_CLAIMED "      );
qrysb1.append("  ,SUM(CASE WHEN PMEGP_APPLICANTION_ID_II IS NOT NULL THEN 1 ELSE 0 END ) NO_OF_PROJECT_II,SUM(MARGIN_MONEY_CLAIMED_AMOUNT_II) MM_CLAIMED_AMT_II,SUM(IRG_AMT_II)  "      );
qrysb1.append(" IRG_AMT_II,SUM(MM_CLAIM_AMT_II) ACTUAL_MM_CLAIMED_II "      );
qrysb1.append("  FROM ( "      );
qrysb1.append("  SELECT  /*+ PARALLEL(AUTO) */ "      );
qrysb1.append("  "      );
qrysb1.append("   AD.APP_ID AS PMEGP_APPLICANTION_ID, "      );
qrysb1.append("   BD.MM_CLAIM_AMT - 500  AS MARGIN_MONEY_CLAIMED_AMOUNT,     "      );
qrysb1.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE, "      );
qrysb1.append("   BD.MM_CLAIM_AMT, "      );
qrysb1.append("   500 IRG_AMT, "      );
qrysb1.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID, "      );
qrysb1.append("    "      );
qrysb1.append("     '' AS PMEGP_APPLICANTION_ID_II, "      );
qrysb1.append("   0  AS MARGIN_MONEY_CLAIMED_AMOUNT_II, "      );
qrysb1.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE_II, "      );
qrysb1.append("     0 MM_CLAIM_AMT_II, "      );
qrysb1.append("   0 IRG_AMT_II, "      );
qrysb1.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID_II "      );
qrysb1.append("   FROM APP_DETAIL AD, "      );
qrysb1.append("   BANK_DATAENTRY BD, "      );
qrysb1.append("   MAS_OFF_MAST MOM, "      );
qrysb1.append("   M_DISTRICT MD, "      );
qrysb1.append("   M_STATE MS "      );
qrysb1.append(" WHERE AD.APP_ID       = BD.APP_ID "      );
qrysb1.append(" AND AD.OFF_CD         = MOM.OFF_CD "      );
qrysb1.append(" AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD "      );
qrysb1.append(" AND MS.STATE_CD       = MD.STATE_CD "      );
qrysb1.append(" AND BD.MM_CLAIM_AMT   > 0 "      );
qrysb1.append(" AND BD.LOAN_DOCFNAME IS NOT NULL "      );
qrysb1.append(" AND BD.APPRV_YN<>'A' AND BD.MM_REL_DT IS NULL AND "      );
qrysb1.append("  BD.PBATCH_ID IS NULL AND "      );
qrysb1.append(" BD.PACT_ID=32 "      );
qrysb1.append(" "      );   //--AND BD.EDP_CERT_DT IS NOT NULL 
qrysb1.append(" AND BD.FB_ACNO IS NOT NULL "      );
qrysb1.append(" AND BD.IFSC_CODE IS NOT NULL "      );
qrysb1.append(" AND FGETNEFTIFSCODE(AD.APP_ID) IS NOT NULL  AND AD.APP_ID NOT IN  (SELECT CS.PMEGP_APPLICANTION_ID FROM CORPDATA_SENT_DETAIL CS WHERE TRUNC(CS.AUTHORISED_DATE)=trunc(SYSDATE)) "      );
qrysb1.append("  UNION ALL "      );
qrysb1.append("  SELECT /*+ PARALLEL(AUTO) */  "      );
qrysb1.append(" '' AS PMEGP_APPLICANTION_ID, "      );
qrysb1.append("   0  AS MARGIN_MONEY_CLAIMED_AMOUNT,   "      );
qrysb1.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE, "      );
qrysb1.append("  0 MM_CLAIM_AMT, "      );
qrysb1.append("   0 IRG_AMT, "      );
qrysb1.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID, "      );
qrysb1.append("  "      );
qrysb1.append("   AD.APP_ID AS PMEGP_APPLICANTION_ID_II, "      );
qrysb1.append("   BD.MM_CLAIM_AMT - 500  AS MARGIN_MONEY_CLAIMED_AMOUNT_II, "      );
qrysb1.append("   TO_CHAR(SYSDATE,'DD-MON-RRRR') AS AUTHORISED_DATE_II, "      );
qrysb1.append("     BD.MM_CLAIM_AMT MM_CLAIM_AMT_II, "      );
qrysb1.append("   500 IRG_AMT_II, "      );
qrysb1.append("   ( SELECT MAX(BD.PBATCH_ID)+1 FROM BANK_DATAENTRY BD ) BATCHID_II "      );
qrysb1.append("   FROM APP_DETAIL_SECOND AD, "      );
qrysb1.append("   BANK_DATAENTRY_SECOND BD, "      );
qrysb1.append("   MAS_OFF_MAST MOM, "      );
qrysb1.append("   M_DISTRICT MD, "      );
qrysb1.append("   M_STATE MS "      );
qrysb1.append(" WHERE AD.APP_ID       = BD.APP_ID "      );
qrysb1.append(" AND AD.OFF_CD         = MOM.OFF_CD "      );
qrysb1.append(" AND AD.UNIT_DIST_CD   = MD.DISTRICT_CD "      );
qrysb1.append(" AND MS.STATE_CD       = MD.STATE_CD "      );
qrysb1.append(" AND BD.MM_CLAIM_AMT   > 0 "      );
qrysb1.append(" AND BD.LOAN_DOCFNAME IS NOT NULL "      );
qrysb1.append(" AND BD.APPRV_YN<>'A' AND BD.MM_REL_DT IS NULL  "      );
qrysb1.append(" AND BD.PBATCH_ID IS NULL "      );
qrysb1.append(" AND BD.PACT_ID=32 "      );
qrysb1.append(" AND BD.FB_ACNO IS NOT NULL "      );
qrysb1.append(" AND BD.IFSC_CODE IS NOT NULL "      );
qrysb1.append(" AND FGETNEFTIFSCODE_SEC(AD.APP_ID) IS NOT NULL  AND AD.APP_ID NOT IN  (SELECT CS.PMEGP_APPLICANTION_ID FROM CORPDATA_SENT_DETAIL CS WHERE TRUNC(CS.AUTHORISED_DATE)=trunc(SYSDATE)) "      );
qrysb1.append("   "      );
qrysb1.append("   ) GROUP BY BATCHID "      );

//out.print(qrysb1.toString());

   ResultSet rsMain1 = db.execSQL(qrysb1.toString());
		values.clear();
		
			while (rsMain1.next()){

 NNO_OF_PROJECT=rsMain1.getString("NO_OF_PROJECT")==null?"0":rsMain1.getString("NO_OF_PROJECT");
 NMM_CLAIMED_AMT=rsMain1.getString("MM_CLAIMED_AMT")==null?"0":rsMain1.getString("MM_CLAIMED_AMT");
 NIRG_AMT=rsMain1.getString("IRG_AMT")==null?"0":rsMain1.getString("IRG_AMT");
 NACTUAL_MM_CLAIMED=rsMain1.getString("ACTUAL_MM_CLAIMED")==null?"0":rsMain1.getString("ACTUAL_MM_CLAIMED");
 NNO_OF_PROJECT_II=rsMain1.getString("NO_OF_PROJECT_II")==null?"0":rsMain1.getString("NO_OF_PROJECT_II");
 NMM_CLAIMED_AMT_II=rsMain1.getString("MM_CLAIMED_AMT_II")==null?"0":rsMain1.getString("MM_CLAIMED_AMT_II");
 NIRG_AMT_II=rsMain1.getString("IRG_AMT_II")==null?"0":rsMain1.getString("IRG_AMT_II");
 NACTUAL_MM_CLAIMED_II=rsMain1.getString("ACTUAL_MM_CLAIMED_II")==null?"0":rsMain1.getString("ACTUAL_MM_CLAIMED_II");
 
 NTOT_MM_AMT=rsMain1.getString("TOT_MM_AMT")==null?"0":rsMain1.getString("TOT_MM_AMT");
 NTOT_IRG_AMT=rsMain1.getString("TOT_IRG_AMT")==null?"0":rsMain1.getString("TOT_IRG_AMT");
 NTOT_MARGIN_MONEY_CLAIMED_AMOUNT=rsMain1.getString("TOT_MARGIN_MONEY_CLAIMED_AMT")==null?"0":rsMain1.getString("TOT_MARGIN_MONEY_CLAIMED_AMT");
 NTOT_PRJ=rsMain1.getString("TOT_PRJ")==null?"0":rsMain1.getString("TOT_PRJ");

}
		
		rsMain1.close();
		
 	 db.close();  

%>

<table  border="1" align="center">
  <tr>
    <td>&nbsp;</td>
    <th colspan="4" bgcolor="#DBF9E0"><div align="center">Approved</div></th>
    <td colspan="4"><div align="center">Not Approved </div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <th bgcolor="#DBF9E0"><div align="center">Prj No. </div></th>
    <th bgcolor="#DBF9E0"><div align="center">MM Amt</div></th>
    <th bgcolor="#DBF9E0"><div align="center">IRG</div></th>
    <th bgcolor="#DBF9E0"><div align="center">Actual MM Amt </div></th>
    <th><div align="center">Prj No. </div></th>
    <th><div align="center">MM Amt</div></th>
    <th><div align="center">IRG</div></th>
    <th><div align="center">Actual MM Amt </div></th>
  </tr>
  <tr>
    <td>I Loan </td>
    <td bgcolor="#DBF9E0"><div align="center"><%= NO_OF_PROJECT %></div></td>
    <td bgcolor="#DBF9E0"><div align="center"><%= MM_CLAIMED_AMT %></div></td>
    <td bgcolor="#DBF9E0"><div align="center"><%= IRG_AMT %></div></td>
    <td bgcolor="#DBF9E0"><div align="center"><%= ACTUAL_MM_CLAIMED %></div></td>
    <td><div align="center"><%= NNO_OF_PROJECT %></div></td>
    <td><div align="center"><%= NMM_CLAIMED_AMT %></div></td>
    <td><div align="center"><%= NIRG_AMT %></div></td>
    <td><div align="center"><%= NACTUAL_MM_CLAIMED %></div></td>
  </tr>
  <tr>
    <td>II Loan </td>
    <td bgcolor="#DBF9E0"><div align="center"><%= NO_OF_PROJECT_II %></div></td>
    <td bgcolor="#DBF9E0"><div align="center"><%= MM_CLAIMED_AMT_II %></div></td>
    <td bgcolor="#DBF9E0"><div align="center"><%= IRG_AMT_II %></div></td>
    <td bgcolor="#DBF9E0"><div align="center"><%= ACTUAL_MM_CLAIMED_II %></div></td>
    <td><div align="center"><%= NNO_OF_PROJECT_II %></div></td>
    <td><div align="center"><%= NMM_CLAIMED_AMT_II %></div></td>
    <td><div align="center"><%= NIRG_AMT_II %></div></td>
    <td><div align="center"><%= NACTUAL_MM_CLAIMED_II %></div></td>
  </tr>
  <tr>
    <th><strong>Total </strong></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= TOT_PRJ %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= TOT_MARGIN_MONEY_CLAIMED_AMOUNT %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= TOT_IRG_AMT %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= TOT_MM_AMT %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= NTOT_PRJ %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= NTOT_MARGIN_MONEY_CLAIMED_AMOUNT %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= NTOT_IRG_AMT %></strong></div></th>
    <th bgcolor="#DBF9E0"><div align="center"><strong><%= NTOT_MM_AMT %></strong></div></th>
  </tr>
  <tr>
    <td colspan="9"><div align="center">
      <input name="button" type="button" class="buttonGreen" id="button" onclick="submitfun();" value="Confirm" />
    </div></td>
  </tr>
</table>





