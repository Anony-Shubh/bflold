<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="../css/select.dataTables.min.css"/>
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<script language="javascript" src="../js/datatables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>

<script language="javascript" src="../js/inlinemsg.js"></script>

<style type="text/css">
<!--
.style2 {color: #084A14}
-->
</style>
<script>
  
	 function submit_update(){
	  
			 if (validate(form)){
				  
				var answer = confirm ("Once Clicked On 'OK' Button, You will not be able to revert the application.")
				
					if (answer){
					 //document.form.ins.value='I'; 
					document.form.submit(); 
					}
	}
	  }
	
	function validate(form) {
	
	var DEL_REMARKS = document.form.DEL_REMARKS.value;
	 if(DEL_REMARKS == "") {
			inlineMsg('DEL_REMARKS','You must enter your Remarks.',2);
			return false;
		  } 
		  return true;
		  
}






	
</script>
</head>
<body>

<form id="form" name="form" method="post">
    <div align="center">

<p>
  
  <%
String BATCHIDPAYID=request.getParameter("BATCHIDPAYID")==null?"0":(String) request.getParameter("BATCHIDPAYID") ;

String APP_ID =(String)session.getAttribute("SAPP_ID");
//out.print(CUSTCODE);
String PMEGPGEOTAGID = (String)session.getAttribute("PMEGPGEOTAGID");
//out.print(PMEGPGEOTAGID);
String APPNAME = (String)session.getAttribute("APPNAME");


String MSG="";

String DEL_REMARKS="";
String ins="1";
DBCon db= new DBCon();
db.connect();
	 List values=new ArrayList();	
    List pstm=new ArrayList();
%>
<table width="50%" align="center" class="shadow">
  <tr>
    <th colspan="2"><p> (1) Once Pulled Back Option is Executed, the PV Claim will be Return to DCO login and DCO Need to reprocess  as Fresh Claim.</p>
      <p>(2) This option Can be executed by Approver Untill PV Claim is adjusted by Financing Bank.  </p></th>
  </tr>
  <tr>
    <th colspan="2"><div align="center">Are You Sure You want to Pull Back this ID: <%=APP_ID%>:  
      <input name="PMEGPGEOTAGID" type="hidden" id="PMEGPGEOTAGID" value="<%=PMEGPGEOTAGID%>" >
	   <input name="APP_ID" type="HIDDEN" id="APP_ID" value="<%=APP_ID%>" >
    </div></th>
	    </tr>
   <tr>
     <td >Application ID: </td>
	  <td ><%=APP_ID%> </td>
   </tr>
   <tr>
     <td >Applicant Name: </td>
     <td><%=APPNAME%></td>
   </tr>
   <tr>
    <td > 
		Enter Remarks:</td>
    <td>  <input name="DEL_REMARKS" type="TEXT" id="DEL_REMARKS" value="<%=DEL_REMARKS%>" size="100" maxlength="200" >    </td>
    </tr>
  
  <tr>
    <td colspan="2"> <div align="center">
      	 
    </div></td>
    </tr>
  
 
  <tr>
    <td colspan="2"> <div align="center">
      <input name="Button" type="button" class="button" value="PullBack" onClick="submit_update();">	
	   <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="window.parent.HideModalWindow();">	 
    </div></td>
    </tr>
</table>
  <input name="ins" type="hidden" id="ins">
  
   <%
   if ((String)request.getParameter("ins")!=null){
   
   APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim(); 
   PMEGPGEOTAGID=(String) request.getParameter("PMEGPGEOTAGID")==null?"":(String) request.getParameter("PMEGPGEOTAGID").trim(); 
   DEL_REMARKS=(String) request.getParameter("DEL_REMARKS")==null?"":(String) request.getParameter("DEL_REMARKS").trim(); 
   try{
StringBuffer qrysb = new StringBuffer();

/*qryEXR.append("INSERT INTO APAYTEST_DEL (TR_ID,CUSTCODE,ARTID,LEDID,PAIDAMT,PAYLEDID,PAYMENT_DT,CHQNO,BATCHIDPAYID,VOCHBID,TIMESTAMP,PROCESS_TYPE,DEL_TIMESTAMP) SELECT A.*,SYSDATE AS DEL_TIMESTAMP FROM APAYTEST A WHERE BATCHIDPAYID=?");
*/
qrysb.append("   INSERT INTO GEOTAG_PULLBCK ("      );
qrysb.append("   PMEGPGEOTAGID,"      );
qrysb.append("   LATITUDE,"      );
qrysb.append("   UNIT_ADDRESS,"      );
qrysb.append("   LONGITUDE,"      );
qrysb.append("   ATTACHMENT_NAME,"      );
qrysb.append("   MEDIA_URL,"      );
qrysb.append("   MEDIA_TYPE,"      );
qrysb.append("   MARGIN_MONEY_ADJUSTMENT_AMOUNT,"      );
qrysb.append("   PERIOD_OF_INTEREST,"      );
qrysb.append("   RATE_OF_INTEREST,"      );
qrysb.append("   REPAYMENT_PERIOD,"      );
qrysb.append("   CGTMSE_COVERAGE,"      );
qrysb.append("   CALLBACK_REASON,"      );
qrysb.append("   VALUE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("   TDR_NUMBER,"      );
qrysb.append("   IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("   IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("   OUTSTANDING_LOAN_AMOUNT,"      );
qrysb.append("   PENDING_LOAN_AMOUNT,"      );
qrysb.append("   MARGIN_MONEY_ADJUSTMENT_DATE,"      );
qrysb.append("   NATURE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("   TDR_DATE,"      );
qrysb.append("   ROI_LOAN,"      );
qrysb.append("   CALLBACK_AMOUNT,"      );
qrysb.append("   TDR_AMOUNT,"      );
qrysb.append("   DATE_OF_ISSUE,"      );
qrysb.append("   IS_INTEREST_CHARGED,"      );
qrysb.append("   NPA_PERIOD,"      );
qrysb.append("   IS_REPAYMENT_REGULAR,"      );
qrysb.append("   IS_COLLATERAL_SECURITY,"      );
qrysb.append("   INTEREST_AMOUNT,"      );
qrysb.append("   MAIN_PRODUCT,"      );
qrysb.append("   PRESENT_SALES_QUANTITY,"      );
qrysb.append("   EXPORT_VALUE,"      );
qrysb.append("   RAW_MATERIAL_IMPORT_COUNTRY,"      );
qrysb.append("   PRESENT_SALES_VALUE,"      );
qrysb.append("   ANNUAL_PRODUCTION_QUANTITY,"      );
qrysb.append("   PRESENT_PRODUCTION_VALUE,"      );
qrysb.append("   MACHINERY_TYPE,"      );
qrysb.append("   MODE_OF_EXPORT,"      );
qrysb.append("   ANNUAL_PRODUCTION_VALUE,"      );
qrysb.append("   COUNTRY_OF_EXPORT,"      );
qrysb.append("   EXPORT_QUANTITY,"      );
qrysb.append("   BY_PRODUCT,"      );
qrysb.append("   RAW_MATERIAL_DETAILS,"      );
qrysb.append("   PRESENT_PRODUCTION_QUANTITY,"      );
qrysb.append("   PRODUCTION_SALES_YEAR,"      );
qrysb.append("   RAW_MATERIAL_IMPORT,"      );
qrysb.append("   ANNUAL_SALES_VALUE,"      );
qrysb.append("   COUNTRY_OF_IMPORT,"      );
qrysb.append("   ANNUAL_SALES_QUANTITY,"      );
qrysb.append("   DATE_OF_VERIFICATION,"      );
qrysb.append("   PROMINENT_SIGN_BOARD_INSTALLED,"      );
qrysb.append("   VERIFICATION_STATUS,"      );
qrysb.append("   VERIFICATION_BY,"      );
qrysb.append("   VERIFIER_REMARKS,"      );
qrysb.append("   PER_CAPITA_INVESTMENT_NORM_SAT,"      );
qrysb.append("   APP_ID,"      );
qrysb.append("   TOTAL_EMPLOYEES,"      );
qrysb.append("   KVIC_REGISTRATION_NUMBER,"      );
qrysb.append("   OTHER_CLEARANCE,"      );
qrysb.append("   TRANSGENDER_EMPLOYEES,"      );
qrysb.append("   SC,"      );
qrysb.append("   OBC,"      );
qrysb.append("   UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("   DATE_OF_WATER_CONNECTION,"      );
qrysb.append("   MALE_EMPLOYEES,"      );
qrysb.append("   FULLTIME_EMPLOYEES,"      );
qrysb.append("   PHYSICALLY_CHALLENGED_EMPLOYEE,"      );
qrysb.append("   KVIC_REGISTRATION_DATE,"      );
qrysb.append("   MINORITY,"      );
qrysb.append("   GST_REGISTRATION_NUMBER,"      );
qrysb.append("   PART_TIME_EMPLOYEES,"      );
qrysb.append("   REGISTERED_BRAND_NAME,"      );
qrysb.append("   UDYAM_REGISTRATION_NUMBER,"      );
qrysb.append("   UNIT_SETUP_ON,"      );
qrysb.append("   ST,"      );
qrysb.append("   UNIT_NAME,"      );
qrysb.append("   DATE_OF_ELECTRIC_CONNECTION,"      );
qrysb.append("   HANDHOLDING_DETAILS,"      );
qrysb.append("   UDYAM_REGISTRATION_DATE,"      );
qrysb.append("   PRODUCTION_COMMENCEMENT_DATE,"      );
qrysb.append("   PATENT_OWNERSHIP,"      );
qrysb.append("   PAN_OR_TAN_NUMBER,"      );
qrysb.append("   CERTIFICATION,"      );
qrysb.append("   POLLUTION_CLEARANCE_BOARD,"      );
qrysb.append("   SEASONAL_EMPLOYEES,"      );
qrysb.append("   SEMI_SKILLED_EMPLOYEES,"      );
qrysb.append("   SKILLED_EMPLOYEES,"      );
qrysb.append("   GST_REGISTRATION_DATE,"      );
qrysb.append("   UNSKILLED_EMPLOYEES,"      );
qrysb.append("   GENERAL,"      );
qrysb.append("   AVERAGE_WAGES_PAID,"      );
qrysb.append("   FEMALE_EMPLOYEES,"      );
qrysb.append("   CAPITAL_COST_OF_BUILDING,"      );
qrysb.append("   CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("   FINISHED_RAW_MATERIAL_STOCK,"      );
qrysb.append("   SEMI_FIN_RM_STOCK,"      );
qrysb.append("   RAW_MATERIAL_STOCK_VALUE,"      );
qrysb.append("   VERIFICATION_DATETIME,"      );
qrysb.append("   LAST_UPDATE_DT,"      );
qrysb.append("   PHYSICAL_VERIFICATION_STATUS,"      );
qrysb.append("   MM_ADJUSTMENT_STATUS,"      );
qrysb.append("   MM_ADJUSTMENT_AMT_S,"      );
qrysb.append("   NODAL_OFFICER_REMARK,"      );
qrysb.append("   DOC_NAME,"      );
qrysb.append("   ACT_ID,"      );
qrysb.append("   REMTRID,"      );
qrysb.append("   QC_APPRV,"      );
qrysb.append("   QC_REMARK,"      );
qrysb.append("   QC_TIMESTAMP,"      );
qrysb.append("   MM_ADJ_DATE,"      );
qrysb.append("   VALID_YN,VALID_REMARKS,VALID_TIMESTAMP,"      );
qrysb.append("   AGENCY_UPLOAD,"      );
qrysb.append("   AGN_CALLBACK,"      );
qrysb.append("   BANK_ADJ_DT,"      );
qrysb.append("   BANK_ADJ_AMT,"      );
qrysb.append("   BANK_REF_NO,"      );
qrysb.append("   BANK_REM,PULLBCK_TIMESTAMP,PULLBCK_REMARKS )"      );
qrysb.append("   (select "      );
qrysb.append("   PMEGPGEOTAGID,"      );
qrysb.append("   LATITUDE,"      );
qrysb.append("   UNIT_ADDRESS,"      );
qrysb.append("   LONGITUDE,"      );
qrysb.append("   ATTACHMENT_NAME,"      );
qrysb.append("   MEDIA_URL,"      );
qrysb.append("   MEDIA_TYPE,"      );
qrysb.append("   MARGIN_MONEY_ADJUSTMENT_AMOUNT,"      );
qrysb.append("   PERIOD_OF_INTEREST,"      );
qrysb.append("   RATE_OF_INTEREST,"      );
qrysb.append("   REPAYMENT_PERIOD,"      );
qrysb.append("   CGTMSE_COVERAGE,"      );
qrysb.append("   CALLBACK_REASON,"      );
qrysb.append("   VALUE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("   TDR_NUMBER,"      );
qrysb.append("   IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("   IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("   OUTSTANDING_LOAN_AMOUNT,"      );
qrysb.append("   PENDING_LOAN_AMOUNT,"      );
qrysb.append("   TO_CHAR(MARGIN_MONEY_ADJUSTMENT_DATE,'DD-MON-RRRR') AS MARGIN_MONEY_ADJUSTMENT_DATE ,"      );
qrysb.append("   NATURE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("   TO_CHAR(TDR_DATE,'DD-MON-RRRR') AS TDR_DATE,"      );
qrysb.append("   ROI_LOAN,"      );
qrysb.append("   CALLBACK_AMOUNT,"      );
qrysb.append("   TDR_AMOUNT,"      );
qrysb.append("   DATE_OF_ISSUE,"      );
qrysb.append("   IS_INTEREST_CHARGED,"      );
qrysb.append("   NPA_PERIOD,"      );
qrysb.append("   IS_REPAYMENT_REGULAR,"      );
qrysb.append("   IS_COLLATERAL_SECURITY,"      );
qrysb.append("   INTEREST_AMOUNT,"      );
qrysb.append("   MAIN_PRODUCT,"      );
qrysb.append("   PRESENT_SALES_QUANTITY,"      );
qrysb.append("   EXPORT_VALUE,"      );
qrysb.append("   RAW_MATERIAL_IMPORT_COUNTRY,"      );
qrysb.append("   PRESENT_SALES_VALUE,"      );
qrysb.append("   ANNUAL_PRODUCTION_QUANTITY,"      );
qrysb.append("   PRESENT_PRODUCTION_VALUE,"      );
qrysb.append("   MACHINERY_TYPE,"      );
qrysb.append("   MODE_OF_EXPORT,"      );
qrysb.append("   ANNUAL_PRODUCTION_VALUE,"      );
qrysb.append("   COUNTRY_OF_EXPORT,"      );
qrysb.append("   EXPORT_QUANTITY,"      );
qrysb.append("   BY_PRODUCT,"      );
qrysb.append("   RAW_MATERIAL_DETAILS,"      );
qrysb.append("   PRESENT_PRODUCTION_QUANTITY,"      );
qrysb.append("   PRODUCTION_SALES_YEAR,"      );
qrysb.append("   RAW_MATERIAL_IMPORT,"      );
qrysb.append("   ANNUAL_SALES_VALUE,"      );
qrysb.append("   COUNTRY_OF_IMPORT,"      );
qrysb.append("   ANNUAL_SALES_QUANTITY,"      );
qrysb.append("   TO_CHAR(DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,"      );
qrysb.append("   PROMINENT_SIGN_BOARD_INSTALLED,"      );
qrysb.append("   VERIFICATION_STATUS,"      );
qrysb.append("   VERIFICATION_BY,"      );
qrysb.append("   VERIFIER_REMARKS,"      );
qrysb.append("   PER_CAPITA_INVESTMENT_NORM_SAT,"      );
qrysb.append("   APP_ID,"      );
qrysb.append("   TOTAL_EMPLOYEES,"      );
qrysb.append("   KVIC_REGISTRATION_NUMBER,"      );
qrysb.append("   OTHER_CLEARANCE,"      );
qrysb.append("   TRANSGENDER_EMPLOYEES,"      );
qrysb.append("   SC,"      );
qrysb.append("   OBC,"      );
qrysb.append("   TO_CHAR(UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("   TO_CHAR(DATE_OF_WATER_CONNECTION,'DD-MON-RRRR') AS DATE_OF_WATER_CONNECTION,"      );
qrysb.append("   MALE_EMPLOYEES,"      );
qrysb.append("   FULLTIME_EMPLOYEES,"      );
qrysb.append("   PHYSICALLY_CHALLENGED_EMPLOYEE,"      );
qrysb.append("   TO_CHAR(KVIC_REGISTRATION_DATE,'DD-MON-RRRR') AS KVIC_REGISTRATION_DATE,"      );
qrysb.append("   MINORITY,"      );
qrysb.append("   GST_REGISTRATION_NUMBER,"      );
qrysb.append("   PART_TIME_EMPLOYEES,"      );
qrysb.append("   REGISTERED_BRAND_NAME,"      );
qrysb.append("   UDYAM_REGISTRATION_NUMBER,"      );
qrysb.append("   UNIT_SETUP_ON,"      );
qrysb.append("   ST,"      );
qrysb.append("   UNIT_NAME,"      );
qrysb.append("    TO_CHAR(DATE_OF_ELECTRIC_CONNECTION,'DD-MON-RRRR') AS  DATE_OF_ELECTRIC_CONNECTION,"      );
qrysb.append("   HANDHOLDING_DETAILS,"      );
qrysb.append("   TO_CHAR(UDYAM_REGISTRATION_DATE,'DD-MON-RRRR') AS UDYAM_REGISTRATION_DATE,"      );
qrysb.append("   TO_CHAR(PRODUCTION_COMMENCEMENT_DATE,'DD-MON-RRRR') AS PRODUCTION_COMMENCEMENT_DATE,"      );
qrysb.append("   PATENT_OWNERSHIP,"      );
qrysb.append("   PAN_OR_TAN_NUMBER,"      );
qrysb.append("   CERTIFICATION,"      );
qrysb.append("   POLLUTION_CLEARANCE_BOARD,"      );
qrysb.append("   SEASONAL_EMPLOYEES,"      );
qrysb.append("   SEMI_SKILLED_EMPLOYEES,"      );
qrysb.append("   SKILLED_EMPLOYEES,"      );
qrysb.append("   TO_CHAR(GST_REGISTRATION_DATE,'DD-MON-RRRR') AS GST_REGISTRATION_DATE,"      );
qrysb.append("   UNSKILLED_EMPLOYEES,"      );
qrysb.append("   GENERAL,"      );
qrysb.append("   AVERAGE_WAGES_PAID,"      );
qrysb.append("   FEMALE_EMPLOYEES,"      );
qrysb.append("   CAPITAL_COST_OF_BUILDING,"      );
qrysb.append("   CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("   FINISHED_RAW_MATERIAL_STOCK,"      );
qrysb.append("   SEMI_FIN_RM_STOCK,"      );
qrysb.append("   RAW_MATERIAL_STOCK_VALUE,"      );
qrysb.append("    TO_CHAR(VERIFICATION_DATETIME,'DD-MON-RRRR') AS VERIFICATION_DATETIME,"      );
qrysb.append("   TO_CHAR(LAST_UPDATE_DT,'DD-MON-RRRR') AS LAST_UPDATE_DT,"      );
qrysb.append("   PHYSICAL_VERIFICATION_STATUS,"      );
qrysb.append("   MM_ADJUSTMENT_STATUS,"      );
qrysb.append("   MM_ADJUSTMENT_AMT_S,"      );
qrysb.append("   NODAL_OFFICER_REMARK,"      );
qrysb.append("   DOC_NAME,"      );
qrysb.append("   ACT_ID,"      );
qrysb.append("   REMTRID,"      );
qrysb.append("   QC_APPRV,"      );
qrysb.append("   QC_REMARK,"      );
qrysb.append("    TO_CHAR(QC_TIMESTAMP,'DD-MON-RRRR') AS QC_TIMESTAMP,"      );
qrysb.append("   TO_CHAR(MM_ADJ_DATE,'DD-MON-RRRR') AS MM_ADJ_DATE,"      );
qrysb.append("   VALID_YN,VALID_REMARKS,TO_CHAR(VALID_TIMESTAMP,'DD-MON-RRRR') AS VALID_TIMESTAMP, "      );
qrysb.append("   AGENCY_UPLOAD,"      );
qrysb.append("   AGN_CALLBACK,"      );
qrysb.append("    TO_CHAR(BANK_ADJ_DT,'DD-MON-RRRR') AS BANK_ADJ_DT,"      );
qrysb.append("   BANK_ADJ_AMT,"      );
qrysb.append("   BANK_REF_NO,"      );
qrysb.append("   BANK_REM, "      );
qrysb.append("   SYSDATE AS PULLBCK_TIMESTAMP,? AS PULLBCK_REMARKS FROM GEOTAG_TRANS  WHERE BANK_ADJ_DT IS NULL AND " );
qrysb.append("   APP_ID NOT IN (SELECT UDF1 FROM INDBANK_REQUEST) AND ACT_ID=1 AND APP_ID=? AND PMEGPGEOTAGID =?)"      );

values.add(DEL_REMARKS); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();


StringBuffer qryDel = new StringBuffer();

qryDel.append(" UPDATE GEOTAG_TRANS SET LAST_UPDATE_DT=SYSDATE,MM_ADJUSTMENT_STATUS=NULL ,MM_ADJUSTMENT_AMT_S=NULL ,NODAL_OFFICER_REMARK=NULL ,DOC_NAME=NULL , ");
qryDel.append(" ACT_ID=NULL ,REMTRID=NULL ,MM_ADJ_DATE=NULL ,AGENCY_UPLOAD=NULL ,AGN_CALLBACK=NULL ,BANK_ADJ_DT=NULL ,BANK_ADJ_AMT=NULL, ");
qryDel.append(" BANK_REF_NO=NULL WHERE APP_ID=? AND PMEGPGEOTAGID =? AND BANK_ADJ_DT IS NULL AND " );
qryDel.append("  APP_ID NOT IN (SELECT UDF1 FROM INDBANK_REQUEST WHERE UDF1=?)   ");

values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryDel.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();






db.close();
}
catch(Exception e){
out.print(e.toString());
}
response.sendRedirect("savepage.jsp");	 
}


%>

	
	        
	




	
</form>

 </html>