 <%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<HTML>
<HEAD>
  <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
</HEAD>
<BODY>
 
 <%
 ArrayList aerror = new ArrayList();
         DBCon db= new DBCon();
         db.connect();

 String BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME").trim();
 String IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();
 String BRANCHNAME=(String) request.getParameter("BRANCHNAME")==null?"":(String) request.getParameter("BRANCHNAME").trim();
 String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim(); 

 String APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
 String IST_LOAN_AMT=(String) request.getParameter("IST_LOAN_AMT")==null?"":(String) request.getParameter("IST_LOAN_AMT").trim();
 String IST_LOAN_DT=(String) request.getParameter("IST_LOAN_DT")==null?"":(String) request.getParameter("IST_LOAN_DT").trim();
 String MM_REL_AMT=(String) request.getParameter("MM_REL_AMT")==null?"":(String) request.getParameter("MM_REL_AMT").trim(); 
 String MM_REL_DT=(String) request.getParameter("MM_REL_DT")==null?"":(String) request.getParameter("MM_REL_DT").trim(); 
 
 
 String BANK_CONT_NO=(String) request.getParameter("BANK_CONT_NO")==null?"":(String) request.getParameter("BANK_CONT_NO").trim();
 String MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
 String CE_SANC_FB=(String) request.getParameter("CE_SANC_FB")==null?"":(String) request.getParameter("CE_SANC_FB").trim();
 String WC_SANC_FB=(String) request.getParameter("WC_SANC_FB")==null?"":(String) request.getParameter("WC_SANC_FB").trim();
 String CE_DISB_FB=(String) request.getParameter("CE_DISB_FB")==null?"":(String) request.getParameter("CE_DISB_FB").trim();
 String WC_DISB_FB=(String) request.getParameter("WC_DISB_FB")==null?"":(String) request.getParameter("WC_DISB_FB").trim();
 String TOT_BAL_FB=(String) request.getParameter("TOT_BAL_FB")==null?"":(String) request.getParameter("TOT_BAL_FB").trim();
 String CC_AVAIL_100PER_YN=(String) request.getParameter("CC_AVAIL_100PER_YN")==null?"":(String) request.getParameter("CC_AVAIL_100PER_YN").trim();
 String CC_UTILISE_3YR_PER=(String) request.getParameter("CC_UTILISE_3YR_PER")==null?"":(String) request.getParameter("CC_UTILISE_3YR_PER").trim();
 String RINT=(String) request.getParameter("RINT")==null?"":(String) request.getParameter("RINT").trim();
 


 String TDR_ADJ_AMT=(String) request.getParameter("TDR_ADJ_AMT")==null?"":(String) request.getParameter("TDR_ADJ_AMT").trim();
 String TDR_ADJ_DT=(String) request.getParameter("TDR_ADJ_DT")==null?"":(String) request.getParameter("TDR_ADJ_DT").trim();
 String TDR_ACNO=(String) request.getParameter("TDR_ACNO")==null?"":(String) request.getParameter("TDR_ACNO").trim();
 String CGTSI=(String) request.getParameter("CGTSI")==null?"":(String) request.getParameter("CGTSI").trim();
 String INTCHARGE_ONMM=(String) request.getParameter("INTCHARGE_ONMM")==null?"":(String) request.getParameter("INTCHARGE_ONMM").trim();
 String COL_SEC_YN=(String) request.getParameter("COL_SEC_YN")==null?"":(String) request.getParameter("COL_SEC_YN").trim();
 String COL_SEC_AMT=(String) request.getParameter("COL_SEC_AMT")==null?"":(String) request.getParameter("COL_SEC_AMT").trim();
 String REPAY_LOAN_YN=(String) request.getParameter("REPAY_LOAN_YN")==null?"":(String) request.getParameter("REPAY_LOAN_YN").trim();
 String NPA_YN=(String) request.getParameter("NPA_YN")==null?"":(String) request.getParameter("NPA_YN").trim();



 String NPA_DT=(String) request.getParameter("NPA_DT")==null?"":(String) request.getParameter("NPA_DT").trim();
 String UNIT_CUR_STATUS=(String) request.getParameter("UNIT_CUR_STATUS")==null?"":(String) request.getParameter("UNIT_CUR_STATUS").trim();
 String ANNL_PROD=(String) request.getParameter("ANNL_PROD")==null?"":(String) request.getParameter("ANNL_PROD").trim();
 String ANNL_SALE=(String) request.getParameter("ANNL_SALE")==null?"":(String) request.getParameter("ANNL_SALE").trim();
 String BUSINESS_COM_DT=(String) request.getParameter("BUSINESS_COM_DT")==null?"":(String) request.getParameter("BUSINESS_COM_DT").trim();
 String ANY_OTH_REMARKS=(String) request.getParameter("ANY_OTH_REMARKS")==null?"":(String) request.getParameter("ANY_OTH_REMARKS").trim();
 String GPV_ID=(String) request.getParameter("GPV_ID")==null?"":(String) request.getParameter("GPV_ID").trim(); 
 String ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
 String TOT_SANC=(String) request.getParameter("TOT_SANC")==null?"":(String) request.getParameter("TOT_SANC").trim();
 out.print(ACT_ID);
 
 List values=new ArrayList();
List pstm=new ArrayList();
String VALID_DATA="Y";
int BANK_CONT_NO_L=BANK_CONT_NO.length(); 
int MOB_NO2=MOB_NO1.length(); 

  if (BANK_CONT_NO.equals("") || BANK_CONT_NO.equals("0")) {
aerror.add("Bank Contact No Cannot be empty...... ");
}

 if ((!BANK_CONT_NO.equals("")) || (!BANK_CONT_NO.equals("0"))) {
if (BANK_CONT_NO_L != 10) {
	
aerror.add("Bank Contact No Not correct...... ");	
}
}

  if (MOB_NO1.equals("") || MOB_NO1.equals("0")) {
aerror.add("Applicant Contact No Cannot be empty...... ");
}

 if (!MOB_NO1.equals("") || (!MOB_NO1.equals("0"))) {
if (MOB_NO2 != 10) {
	
aerror.add("Applicant Contact No Not correct...... ");	
}
}
 
   if (CE_SANC_FB.equals("") || CE_SANC_FB.equals("0") ) {
aerror.add("Term Loan (CE) cannot be empty or 0...... ");
}
 
   if (WC_SANC_FB.equals("")|| WC_SANC_FB.equals("0") ) {
aerror.add("Cash Credit(WC) Cannot be empty or 0...... ");
}

try {
  if ((Integer.parseInt(CE_SANC_FB)+Integer.parseInt(WC_SANC_FB)) > Integer.parseInt(TOT_SANC) ) {
   aerror.add("Total Projest Cost Mentioned is greater than Actual total sanction:"+TOT_SANC);
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is greater than Actual total sanction:"+TOT_SANC);
   }
  
  

 
   if (CE_DISB_FB.equals("") || CE_DISB_FB.equals("0") ) {
aerror.add("Term Loan Disbursement (CE) cannot be empty or 0...... ");
}
 
   if (WC_DISB_FB.equals("")|| WC_DISB_FB.equals("0") ) {
aerror.add("Cash Credit(WC) Cannot be empty or 0...... ");
}

try {
  if ((Integer.parseInt(CE_DISB_FB)+Integer.parseInt(WC_DISB_FB)) > (Integer.parseInt(CE_SANC_FB)+ Integer.parseInt(WC_SANC_FB) )) {
   aerror.add("Total Project Cost Disbursed should not be greater than total sanction :"+TOT_SANC);    
  }
  }catch (Exception n){
  aerror.add("Total Project Cost Mentioned is Too Low:");
   }
   
  if (CC_AVAIL_100PER_YN.equals("")) {
aerror.add("Whether Unit has availed 100% of Cash Credit (WC) Cannot be empty...... ");
}
 if (CC_AVAIL_100PER_YN.equals("N")) {
  if (CC_UTILISE_3YR_PER.equals("")) {
aerror.add(" Average Cash Credit availed during last 3 years Cannot be empty...... ");
}
}
 
 
 
   if (RINT.equals("") || RINT.equals("0")) {
aerror.add("Rate of Intrest Cannot be empty...... ");
}
  if (TDR_ADJ_AMT.equals("") || TDR_ADJ_AMT.equals("0")) {
aerror.add("TDR Adjustment amount Cannot be empty...... ");
}
  if (TDR_ADJ_DT.equals("") || TDR_ADJ_DT.equals("0"))  {
aerror.add("TDR Adjustment Date Cannot be empty...... ");
}
  if (TDR_ACNO.equals("") ) {
aerror.add("TDR Adjustment  No Cannot be empty...... ");
}
   if (CGTSI.equals("")) {
aerror.add("CGTMSE Coverage cannot  be empty...... ");
}
  if (INTCHARGE_ONMM.equals("")) {
aerror.add(" Interest Charged Cannot be empty...... ");
}
  if (COL_SEC_YN.equals("")) {
aerror.add("Collateral Security Cannot be empty...... ");
}
  if (COL_SEC_YN.equals("Y")) {
  if (COL_SEC_AMT.equals("") || COL_SEC_AMT.equals("0")) {
aerror.add("Collateral Security amount Cannot be empty...... ");
}
 }
 
    if (REPAY_LOAN_YN.equals("")) {
aerror.add(" Repayment of Loan  Cannot be empty...... ");
}
  if (NPA_YN.equals("")) {
aerror.add("Unit comes under NPA Cannot be empty...... ");
}
 if (NPA_YN.equals("Y")) {
  if (NPA_DT.equals("")) {
aerror.add("NPA Date Cannot be empty...... ");
}
}
  if (UNIT_CUR_STATUS.equals("")) {
aerror.add("Unit Status Cannot be empty...... ");
}
if (UNIT_CUR_STATUS.equals("W")) {

   if (ANNL_PROD.equals("") || ANNL_PROD.equals("0")) {
aerror.add("Annual Turnover (production)of the Unit Cannot be empty...... ");
}
  if (ANNL_SALE.equals("") || ANNL_SALE.equals("0")) {
aerror.add("Annual Turnover(sales) of the Unit Cannot be empty...... ");
}
  if (BUSINESS_COM_DT.equals("")) {
aerror.add("Date of Commencement of Business Cannot be empty...... ");
}
}
  if (ANY_OTH_REMARKS.equals("")) {
aerror.add("Remarks Cannot be empty...... ");
} 
 
 if (ACT_ID.equals("")) {
aerror.add("Self Declaration Cannot be empty...... ");
}
 
 
 
 %>
 <table align="center" class="pmegpTable">
  <tr>
    <th colspan="4" scope="row"><div align="center">PMEGP SYSTEM VALIDATION REPORT </div></th>
  </tr>
  <tr>
    <td colspan="4" class="warning" scope="row"><h2 class="error">  Final submission failed due to following reason: </h2></td>
  </tr>
  
  <%
   ListIterator itr=aerror.listIterator();
   int cnterro=0;
   while(itr.hasNext()){ VALID_DATA="N"; 
cnterro=cnterro+1;   %>
  
  <tr class="redLebel">
    <td class="OrangeLebel" scope="row">
	
	  <div align="right"><%= cnterro %></div></td>
    <td colspan="3" class="warning" scope="row"><h3><%= itr.next()%></h3></td>
  </tr>
 
<%			
        }
		
		%>
		</table>
		<%
		
out.print(VALID_DATA);
out.print("GPV_ID"+GPV_ID);
 if (VALID_DATA.equals("Y")){
 
 
  try {
 
 StringBuffer qryUpdate= new StringBuffer();
 


if (GPV_ID.equals("0"))  {
	try{

 ResultSet rsMax= db.execSQL("SELECT GEOBANK_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
     while (rsMax.next()) {
     GPV_ID=rsMax.getString(1);
	 
     }
rsMax.close();
out.print(GPV_ID);


qryUpdate.append(" INSERT INTO GEOTAG_PVBANKFORM( ");
qryUpdate.append(" BANK_NAME,IFSC_CODE,BRANCHNAME,BANK_PHONE_NO,APP_NAME, ");
qryUpdate.append(" APP_ID,MOB_NO1,IST_LOAN_AMT,IST_LOAN_DT,CE_SANC_FB,WC_SANC_FB,CE_DISB_FB,WC_DISB_FB,TOT_BAL_FB,"); 
qryUpdate.append(" CC_AVAIL_100PER_YN,CC_UTILISE_3YR_PER,RINT,MM_REL_DT,MM_REL_AMT, ");
qryUpdate.append(" TDR_ADJ_AMT,TDR_ADJ_DT,TDR_ACNO,CGTSI,INTCHARGE_ONMM,COL_SEC_YN,COL_SEC_AMT, ");
qryUpdate.append(" REPAY_LOAN_YN,NPA_YN,NPA_DT,UNIT_CUR_STATUS,ANNL_PROD,ANNL_SALE,BUSINESS_COM_DT,ANY_OTH_REMARKS,UPDATE_TIMESTAMPDT,ACT_ID,GPV_ID)");

qryUpdate.append("VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,SYSDATE,?,?) ");

values.add(BANK_NAME); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(BRANCHNAME); pstm.add ("L");

values.add(BANK_CONT_NO); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(MOB_NO1); pstm.add ("L");
values.add(IST_LOAN_AMT); pstm.add ("L");
values.add(IST_LOAN_DT); pstm.add ("L");

values.add(CE_SANC_FB); pstm.add ("L");
values.add(WC_SANC_FB); pstm.add ("L");
values.add(CE_DISB_FB); pstm.add ("L");
values.add(WC_DISB_FB); pstm.add ("L");
values.add(TOT_BAL_FB); pstm.add ("L");
values.add(CC_AVAIL_100PER_YN); pstm.add ("L");
values.add(CC_UTILISE_3YR_PER); pstm.add ("L");
values.add(RINT); pstm.add ("L");
values.add(MM_REL_DT); pstm.add ("L");
values.add(MM_REL_AMT); pstm.add ("L");

values.add(TDR_ADJ_AMT); pstm.add ("L");
values.add(TDR_ADJ_DT); pstm.add ("L");
values.add(TDR_ACNO); pstm.add ("L");
values.add(CGTSI); pstm.add ("L");
values.add(INTCHARGE_ONMM); pstm.add ("L");
values.add(COL_SEC_YN); pstm.add ("L");
values.add(COL_SEC_AMT); pstm.add ("L");
values.add(REPAY_LOAN_YN); pstm.add ("L");
values.add(NPA_YN); pstm.add ("L");
values.add(NPA_DT); pstm.add ("L");


values.add(UNIT_CUR_STATUS); pstm.add ("L");
values.add(ANNL_PROD); pstm.add ("L");
values.add(ANNL_SALE); pstm.add ("L");
values.add(BUSINESS_COM_DT); pstm.add ("L");
values.add(ANY_OTH_REMARKS); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(GPV_ID); pstm.add ("L");
}
catch(Exception e)
{
out.print(e.toString());
}

}
else{
qryUpdate.append("  UPDATE GEOTAG_PVBANKFORM SET  ");
qryUpdate.append("  BANK_PHONE_NO=?,MOB_NO1=?,CE_SANC_FB=?,WC_SANC_FB=?,CE_DISB_FB=?, ");
qryUpdate.append("  WC_DISB_FB=?,TOT_BAL_FB=?,CC_AVAIL_100PER_YN=?,CC_UTILISE_3YR_PER=?,RINT=?,TDR_ADJ_AMT=?,TDR_ADJ_DT=?,TDR_ACNO=?,CGTSI=?,");
qryUpdate.append("  INTCHARGE_ONMM=?,COL_SEC_YN=?,COL_SEC_AMT=?,REPAY_LOAN_YN=?,NPA_YN=?,");
qryUpdate.append("  NPA_DT=?,UNIT_CUR_STATUS=?,ANNL_PROD=?,ANNL_SALE=?,BUSINESS_COM_DT=?,ANY_OTH_REMARKS=?,UPDATE_TIMESTAMPDT=SYSDATE,ACT_ID=? WHERE GPV_ID=? ");

values.add(BANK_CONT_NO); pstm.add ("L");
values.add(MOB_NO1); pstm.add ("L");
values.add(CE_SANC_FB); pstm.add ("L");
values.add(WC_SANC_FB); pstm.add ("L");
values.add(CE_DISB_FB); pstm.add ("L");
values.add(WC_DISB_FB); pstm.add ("L");
values.add(TOT_BAL_FB); pstm.add ("L");
values.add(CC_AVAIL_100PER_YN); pstm.add ("L");
values.add(CC_UTILISE_3YR_PER); pstm.add ("L");
values.add(RINT); pstm.add ("L");


values.add(TDR_ADJ_AMT); pstm.add ("L");
values.add(TDR_ADJ_DT); pstm.add ("L");
values.add(TDR_ACNO); pstm.add ("L");
values.add(CGTSI); pstm.add ("L");
values.add(INTCHARGE_ONMM); pstm.add ("L");
values.add(COL_SEC_YN); pstm.add ("L");
values.add(COL_SEC_AMT); pstm.add ("L");
values.add(REPAY_LOAN_YN); pstm.add ("L");
values.add(NPA_YN); pstm.add ("L");
values.add(NPA_DT); pstm.add ("L");


values.add(UNIT_CUR_STATUS); pstm.add ("L");
values.add(ANNL_PROD); pstm.add ("L");
values.add(ANNL_SALE); pstm.add ("L");
values.add(BUSINESS_COM_DT); pstm.add ("L");
values.add(ANY_OTH_REMARKS); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(GPV_ID); pstm.add ("L");


}
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;
db.close();
values.clear();
pstm.clear();
session.setAttribute("sAPP_ID",APP_ID);
 session.setAttribute("sGPV_ID",GPV_ID);
response.sendRedirect("FinalSubmit.jsp");

} //end ins



catch(Exception e)
{
out.print(e.toString());
}
finally{
//db.close();
}
}

  %>
  
</body>
</html>
