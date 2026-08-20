<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page buffer="200kb" %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
  
    <link rel="stylesheet" type="text/css" href="css/jquery-steps.css">
    <link rel="stylesheet" type="text/css" href="css/geoformstyle.css"> 
  <SCRIPT language="javascript" src="../js/sweetalert.min.js"></SCRIPT>
	<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<SCRIPT language="javascript" src="js/geoUpdate.js"></SCRIPT>
	<SCRIPT language="javascript">

 $(document).ready(
            function() {
                $('#show').call(callfun());
            });
			
			function isNumeric (evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode (key);
    var regex = /[0-9]|\./;
    if ( !regex.test(key) ) {
      theEvent.returnValue = false;
      if(theEvent.preventDefault) theEvent.preventDefault();
    }
  }
			

</SCRIPT>



    <title>PMEGP Unit Inspection Form</title>
    
     <style type="text/css">
        
        body 
        {        
            background-color: white;         
        }

        .step-btn 
        {
            display: inline-block;
            padding: 8px 12px;
            font-size: 15px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px #999;
        }

        .step-btn:hover 
        {
            background-color: #3e8e41
        }

        .step-btn:active 
        {
            background-color: #3e8e41;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
        .sticky {
            position: fixed;
            top: 0;
            width: 100%;
        }

        .sticky + .content {
            padding-top: 102px;
        }
		 color:#FF0000;
 font-size:20px;
 font-weight:bold;

}

 .redLebel
{
 color:#FF0000;
 font-size:20px;
 font-weight:bold;

}
    .style1 {color: #0000FF}
     </style>   

</head>
<%
	

DBCon db= new DBCon();
db.connect();
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =(String) session.getAttribute("SAPP_ID");
String  PMEGPGEOTAGID =(String) session.getAttribute("SPGID");

//String  APP_ID =request.getParameter("APP_ID")==null?"DIJK1920253-8699467":(String)request.getParameter("APP_ID");
//String  PMEGPGEOTAGID =request.getParameter("PMEGPGEOTAGID")==null?"8699467":(String)request.getParameter("PMEGPGEOTAGID");

//String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");
//String  APP_ID=(String)session.getAttribute("SAPP_ID");
//String  PMEGPGEOTAGID=(String)session.getAttribute("SPMEGPGEOTAGID");
//String APP_ID="KVAP16175722-1516494";
//String PMEGPGEOTAGID="2530494";

String QC_APPRV="";
String MAX_AMT="";
String QC_REMARK ="";
     String LATITUDE ="";
     String UNIT_ADDRESS ="";
     String LONGITUDE ="";
     String MARGIN_MONEY_ADJUSTMENT_AMOUNT ="";
     String PERIOD_OF_INTEREST ="";
     String RATE_OF_INTEREST ="";
     String REPAYMENT_PERIOD ="";
    String CGTMSE_COVERAGE ="";
     String CALLBACK_REASON ="";
     String VALUE_OF_COLLATERAL_SECURITY ="";
     String TDR_NUMBER ="";
     String OUTSTANDING_LOAN_AMOUNT ="";
     String PENDING_LOAN_AMOUNT ="";
     String MARGIN_MONEY_ADJUSTMENT_DATE ="";
     String NATURE_OF_COLLATERAL_SECURITY ="";
      String ROI_LOAN ="";
     String CALLBACK_AMOUNT ="";
     String TDR_AMOUNT ="";
     String DATE_OF_ISSUE ="";
     String NPA_PERIOD ="";
      String INTEREST_AMOUNT ="";
     String MAIN_PRODUCT ="";
     String PRESENT_SALES_QUANTITY ="";
     String EXPORT_VALUE ="";
     String RAW_MATERIAL_IMPORT_COUNTRY ="";
     String PRESENT_SALES_VALUE ="";
     String ANNUAL_PRODUCTION_QUANTITY ="";
     String PRESENT_PRODUCTION_VALUE ="";
     String MACHINERY_TYPE ="";
     String MODE_OF_EXPORT ="";
     String ANNUAL_PRODUCTION_VALUE ="";
     String COUNTRY_OF_EXPORT ="";
     String EXPORT_QUANTITY ="";
     String BY_PRODUCT ="";
     String RAW_MATERIAL_DETAILS ="";
     String PRESENT_PRODUCTION_QUANTITY ="";
     String PRODUCTION_SALES_YEAR ="";
     String RAW_MATERIAL_IMPORT ="";
     String ANNUAL_SALES_VALUE ="";
     String COUNTRY_OF_IMPORT ="";
     String ANNUAL_SALES_QUANTITY ="";
       String VERIFICATION_STATUS ="";
     String VERIFICATION_BY ="";
     String VERIFIER_REMARKS ="";
       String LOAN_TYPE ="";
     String TOTAL_EMPLOYEES ="";
     String KVIC_REGISTRATION_NUMBER ="";
     String OTHER_CLEARANCE ="";
     String TRANSGENDER_EMPLOYEES ="";
     String SC ="";
     String OBC ="";
     String UNIT_ESTABLISHMENT_DATE ="";
     String DATE_OF_WATER_CONNECTION ="";
     String MALE_EMPLOYEES ="";
     String FULLTIME_EMPLOYEES ="";
     String PHYSICALLY_CHALLENGED_EMPLOYEE ="";
     String KVIC_REGISTRATION_DATE ="";
     String MINORITY ="";
     String GST_REGISTRATION_NUMBER ="";
     String PART_TIME_EMPLOYEES ="";
     String REGISTERED_BRAND_NAME ="";
     String UDYAM_REGISTRATION_NUMBER ="";
     String UNIT_SETUP_ON ="";
     String ST ="";
     String UNIT_NAME ="";
     String DATE_OF_ELECTRIC_CONNECTION ="";
     String HANDHOLDING_DETAILS ="";
     String UDYAM_REGISTRATION_DATE ="";
     String PRODUCTION_COMMENCEMENT_DATE ="";
     String PATENT_OWNERSHIP ="";
     String PAN_OR_TAN_NUMBER ="";
     String CERTIFICATION ="";
     String POLLUTION_CLEARANCE_BOARD ="";
     String SEASONAL_EMPLOYEES ="";
     String SEMI_SKILLED_EMPLOYEES ="";
     String SKILLED_EMPLOYEES ="";
     String GST_REGISTRATION_DATE ="";
     String UNSKILLED_EMPLOYEES ="";
     String GENERAL ="";
     String AVERAGE_WAGES_PAID ="";
     String FEMALE_EMPLOYEES ="";
     String CAPITAL_COST_OF_BUILDING ="";
     String CAPITAL_COST_OF_MACHINERY ="";
     String FINISHED_RAW_MATERIAL_STOCK ="";
     String SEMI_FIN_RM_STOCK ="";
     String RAW_MATERIAL_STOCK_VALUE ="";
     String IS_MARGIN_MONEY_CALLBACK_ ="";
     String IS_MARGIN_MONEY_ELIGIBLE_FOR_A =""; 
      String TDR_DATE ="";
       String IS_INTEREST_CHARGED ="";
       String IS_REPAYMENT_REGULAR ="";
    String IS_COLLATERAL_SECURITY ="";
    String DATE_OF_VERIFICATION ="";
     String PROMINENT_SIGN_BOARD_INSTALLED ="";
      String PER_CAPITA_INVESTMENT_NORM_SAT="";
       String VERIFICATION_DATETIME ="";
	        String APP_NAME ="";
     String GENDER ="";
     String BENF_CATAGORY_CD ="";
     String BENF_SPECAT_CD ="";
     String E_MAIL ="";
     String MOB_NO1 ="";
     String UNIT_LOC ="";
     String UNIT_DISTRICT ="";
     String OFF_NAME ="";
     String AGENCY_TYPE ="";
     String UNIT_POST_ADDR ="";
     String UNIT_TALUK_BLOCK ="";
     String UNIT_PIN ="";
     String DISTRICT_NAME ="";
     String STATE_NM ="";
     String IND_TYPE ="";
     String IND_GRP_LONG_DESC ="";
     String ACTIVITY_NAME ="";
     String PROD_DESC ="";
     String EDP_TRG_NAME ="";
     String EDP_FR_DT ="";
     String EDP_TO_DT="";
     String LOAN_SANC_DT ="";
     String WC_SANC_FB ="";
     String CE_SANC_FB ="";
     String MACHINARY_COST ="";
     String WORKING_CAPITAL ="";
     String OWN_CONTRIBUTION ="";
     String BANK_NAME ="";
     String BRANCHNAME ="";
     String ADDRESS ="";
     String IFSC_CODE ="";
     String MM_REL_DT ="";
     String MM_REL_AMT ="";
     String UTRN_NO ="";
     String PAY_STATUS ="";
     String IST_LOAN_AMT ="";
     String IST_LOAN_DT ="";
     String BANK_APPRV_PRJCOST ="";
     String BANK_SANC_PRJCOST ="";
   String TOTAL_SKILLED ="";
     String TOTAL_GENDER ="";
     String TOTAL_SEASONAL ="";
     String TOTAL_MINORITY ="";



StringBuffer qrysb= new StringBuffer();
	
qrysb.append("   SELECT"      );
qrysb.append("   'PMEGP IST LOAN' AS LOAN_TYPE,GEOALLOWAMT(GT.PMEGPGEOTAGID) AS MAX_AMT,"      );
qrysb.append("   AD.APP_NAME,GT.QC_APPRV,GT.QC_REMARK,"      );
qrysb.append("     AD.GENDER,"      );
qrysb.append("     AD.BENF_CATAGORY_CD,"      );
qrysb.append("     AD.BENF_SPECAT_CD,"      );
qrysb.append("     AD.E_MAIL,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.UNIT_LOC,"      );
qrysb.append("     MD.DISTRICT_NAME AS UNIT_DISTRICT,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     AD.UNIT_POST_ADDR,"      );
qrysb.append("     AD.UNIT_TALUK_BLOCK,"      );
qrysb.append("     AD.UNIT_PIN,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     DECODE(AD.IND_TYPE,'M', 'Manufacturing', 'T', 'Trading', 'O', 'Others', 'S', 'Service', '-') IND_TYPE,"      );
qrysb.append("     IGM.IND_GRP_LONG_DESC,"      );
qrysb.append("     AM.ACTIVITY_NAME,"      );
qrysb.append("     AD.PROD_DESC,"      );
qrysb.append("     BD.EDP_TRG_NAME,"      );
qrysb.append("     TO_CHAR(BD.EDP_FR_DT,'DD-MON-RRRR') AS EDP_FR_DT,"      );
qrysb.append("     TO_CHAR(BD.EDP_TO_DT,'DD-MON-RRRR') AS EDP_TO_DT,"      );
qrysb.append("     to_char(BD.LOAN_SANC_DT,'DD-MON-RRRR') AS LOAN_SANC_DT,"      );
qrysb.append("     BD.WC_SANC_FB,"      );
qrysb.append("     BD.CE_SANC_FB,"      );
qrysb.append("     BD.MACHINARY_COST,"      );
qrysb.append("     BD.WORKING_CAPITAL,"      );
qrysb.append("     BD.OWN_CONTRIBUTION,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.BRANCHNAME,"      );
qrysb.append("     RBL.ADDRESS,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT, "      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     BD.UTRN_NO,"      );
qrysb.append("     BD.PAY_STATUS,"      );
qrysb.append("     BD.IST_LOAN_AMT,"      );
qrysb.append("     TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,"      );
qrysb.append("     GT.PMEGPGEOTAGID,"      );
qrysb.append("     GT.LATITUDE,"      );
qrysb.append("     GT.UNIT_ADDRESS,"      );
qrysb.append("     GT.LONGITUDE,"      );
qrysb.append("     GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT,"      );
qrysb.append("     GT.PERIOD_OF_INTEREST,"      );
qrysb.append("     GT.RATE_OF_INTEREST,"      );
qrysb.append("     GT.REPAYMENT_PERIOD,"      );
qrysb.append("     GT.CGTMSE_COVERAGE,"      );
qrysb.append("     GT.CALLBACK_REASON,"      );
qrysb.append("     GT.VALUE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("     GT.TDR_NUMBER,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("    GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.OUTSTANDING_LOAN_AMOUNT,"      );
qrysb.append("     GT.PENDING_LOAN_AMOUNT,"      );
qrysb.append("     TO_CHAR(GT.MARGIN_MONEY_ADJUSTMENT_DATE,'DD-MON-RRRR') AS MARGIN_MONEY_ADJUSTMENT_DATE,"      );
qrysb.append("     GT.NATURE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("     TO_CHAR(GT.TDR_DATE,'DD-MON-RRRR') AS TDR_DATE,"      );
qrysb.append("     GT.ROI_LOAN,"      );
qrysb.append("     GT.CALLBACK_AMOUNT,"      );
qrysb.append("     GT.TDR_AMOUNT,"      );
qrysb.append("     GT.DATE_OF_ISSUE,"      );
qrysb.append("    GT.IS_INTEREST_CHARGED,"      );
qrysb.append("     GT.NPA_PERIOD,"      );
qrysb.append("     GT.IS_REPAYMENT_REGULAR,"      );
qrysb.append("     GT.IS_COLLATERAL_SECURITY,"      );
qrysb.append("     GT.INTEREST_AMOUNT,"      );
qrysb.append("     GT.MAIN_PRODUCT,"      );
qrysb.append("     GT.PRESENT_SALES_QUANTITY,"      );
qrysb.append("     GT.EXPORT_VALUE,"      );
qrysb.append("     GT.RAW_MATERIAL_IMPORT_COUNTRY,"      );
qrysb.append("     GT.PRESENT_SALES_VALUE,"      );
qrysb.append("     GT.ANNUAL_PRODUCTION_QUANTITY,"      );
qrysb.append("     GT.PRESENT_PRODUCTION_VALUE,"      );
qrysb.append("     GT.MACHINERY_TYPE,"      );
qrysb.append("     GT.MODE_OF_EXPORT,"      );
qrysb.append("     GT.ANNUAL_PRODUCTION_VALUE,"      );
qrysb.append("     GT.COUNTRY_OF_EXPORT,"      );
qrysb.append("     GT.EXPORT_QUANTITY,"      );
qrysb.append("     GT.BY_PRODUCT,"      );
qrysb.append("     GT.RAW_MATERIAL_DETAILS,"      );
qrysb.append("     GT.PRESENT_PRODUCTION_QUANTITY,"      );
qrysb.append("     GT.PRODUCTION_SALES_YEAR,"      );
qrysb.append("     GT.RAW_MATERIAL_IMPORT,"      );
qrysb.append("     GT.ANNUAL_SALES_VALUE,"      );
qrysb.append("     GT.COUNTRY_OF_IMPORT,"      );
qrysb.append("     GT.ANNUAL_SALES_QUANTITY,"      );
qrysb.append("     TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,"      );
qrysb.append("     GT.PROMINENT_SIGN_BOARD_INSTALLED,"      );
qrysb.append("     GT.VERIFICATION_STATUS,"      );
qrysb.append("     GT.VERIFICATION_BY,"      );
qrysb.append("     GT.VERIFIER_REMARKS,"      );
qrysb.append("     GT.PER_CAPITA_INVESTMENT_NORM_SAT,"      );
qrysb.append("     GT.APP_ID,"      );
qrysb.append("     GT.TOTAL_EMPLOYEES,"      );
qrysb.append("     GT.KVIC_REGISTRATION_NUMBER,"      );
qrysb.append("     GT.OTHER_CLEARANCE,"      );
qrysb.append("     GT.TRANSGENDER_EMPLOYEES,"      );
qrysb.append("     GT.SC,"      );
qrysb.append("     GT.OBC,"      );
qrysb.append("     TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("     TO_CHAR(GT.DATE_OF_WATER_CONNECTION,'DD-MON-RRRR') AS DATE_OF_WATER_CONNECTION , "      );
qrysb.append("     GT.MALE_EMPLOYEES,"      );
qrysb.append("     GT.FULLTIME_EMPLOYEES,"      );
qrysb.append("     GT.PHYSICALLY_CHALLENGED_EMPLOYEE,"      );
qrysb.append("     TO_CHAR(GT.KVIC_REGISTRATION_DATE,'DD-MON-RRRR') AS KVIC_REGISTRATION_DATE,"      );
qrysb.append("     GT.MINORITY,"      );
qrysb.append("     GT.GST_REGISTRATION_NUMBER,"      );
qrysb.append("     GT.PART_TIME_EMPLOYEES,"      );
qrysb.append("     GT.REGISTERED_BRAND_NAME,"      );
qrysb.append("     GT.UDYAM_REGISTRATION_NUMBER,"      );
qrysb.append("     GT.UNIT_SETUP_ON,"      );
qrysb.append("     GT.ST,"      );
qrysb.append("     GT.UNIT_NAME,"      );
qrysb.append("     TO_CHAR(GT.DATE_OF_ELECTRIC_CONNECTION,'DD-MON-RRRR') AS DATE_OF_ELECTRIC_CONNECTION,"      );
qrysb.append("     GT.HANDHOLDING_DETAILS,"      );
qrysb.append("     TO_CHAR(GT.UDYAM_REGISTRATION_DATE,'DD-MON-RRRR') AS UDYAM_REGISTRATION_DATE,"      );
qrysb.append("     TO_CHAR(GT.PRODUCTION_COMMENCEMENT_DATE,'DD-MON-RRRR') AS PRODUCTION_COMMENCEMENT_DATE,"      );
qrysb.append("     GT.PATENT_OWNERSHIP,"      );
qrysb.append("     GT.PAN_OR_TAN_NUMBER,"      );
qrysb.append("     GT.CERTIFICATION,"      );
qrysb.append("     GT.POLLUTION_CLEARANCE_BOARD,"      );
qrysb.append("     GT.SEASONAL_EMPLOYEES,"      );
qrysb.append("     GT.SEMI_SKILLED_EMPLOYEES,"      );
qrysb.append("     GT.SKILLED_EMPLOYEES,"      );
qrysb.append("     TO_CHAR(GT.GST_REGISTRATION_DATE,'DD-MON-RRRR') AS GST_REGISTRATION_DATE,"      );
qrysb.append("     GT.UNSKILLED_EMPLOYEES,"      );
qrysb.append("     GT.GENERAL,"      );
qrysb.append("     GT.AVERAGE_WAGES_PAID,"      );
qrysb.append("     GT.FEMALE_EMPLOYEES,"      );
qrysb.append("     GT.CAPITAL_COST_OF_BUILDING,"      );
qrysb.append("     GT.CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("     GT.FINISHED_RAW_MATERIAL_STOCK,"      );
qrysb.append("     GT.SEMI_FIN_RM_STOCK,"      );
qrysb.append("     GT.RAW_MATERIAL_STOCK_VALUE,"      );
qrysb.append("     TO_CHAR(GT.VERIFICATION_DATETIME,'DD-MON-RRRR') AS VERIFICATION_DATETIME,"      );
qrysb.append("     TO_CHAR(GT.LAST_UPDATE_DT,'DD-MON-RRRR') AS LAST_UPDATE_DT,"      );
qrysb.append("   NVL( BD.MACHINARY_COST,0)+ NVL(BD.WORKING_CAPITAL,0) AS BANK_APPRV_PRJCOST,"      );
qrysb.append("    NVL( BD.WC_SANC_FB,0)+ NVL(BD.CE_SANC_FB,0) AS BANK_SANC_PRJCOST,"      );
qrysb.append("   AD.UNIT_PIN"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     GEOTAG_TRANS GT,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM"      );
qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );
qrysb.append("   AND AD.APP_ID       = GT.APP_ID"      );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD"      );
qrysb.append("   AND BD.PACT_ID      = 34 "      );
qrysb.append("   AND GT.APP_ID=? AND GT.PMEGPGEOTAGID=?     "      );
qrysb.append("  UNION ");
qrysb.append("   SELECT"      );
qrysb.append("   'PMEGP IST LOAN' AS LOAN_TYPE,GEOALLOWAMT(GT.PMEGPGEOTAGID) AS MAX_AMT,"      );
qrysb.append("   AD.APP_NAME,GT.QC_APPRV,GT.QC_REMARK,"      );
qrysb.append("     AD.GENDER,"      );
qrysb.append("     AD.BENF_CATAGORY_CD,"      );
qrysb.append("     AD.BENF_SPECAT_CD,"      );
qrysb.append("     AD.E_MAIL,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.UNIT_LOC,"      );
qrysb.append("     MD.DISTRICT_NAME AS UNIT_DISTRICT,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     AD.UNIT_POST_ADDR,"      );
qrysb.append("     AD.UNIT_TALUK_BLOCK,"      );
qrysb.append("     AD.UNIT_PIN,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     DECODE(AD.IND_TYPE,'M', 'Manufacturing', 'T', 'Trading', 'O', 'Others', 'S', 'Service', '-') IND_TYPE,"      );
qrysb.append("     IGM.IND_GRP_LONG_DESC,"      );
qrysb.append("     AM.ACTIVITY_NAME,"      );
qrysb.append("     AD.PROD_DESC,"      );
qrysb.append("     BD.EDP_TRG_NAME,"      );
qrysb.append("     TO_CHAR(BD.EDP_FR_DT,'DD-MON-RRRR') AS EDP_FR_DT,"      );
qrysb.append("     TO_CHAR(BD.EDP_TO_DT,'DD-MON-RRRR') AS EDP_TO_DT,"      );
qrysb.append("     to_char(BD.LOAN_SANC_DT,'DD-MON-RRRR') AS LOAN_SANC_DT,"      );
qrysb.append("     BD.WC_SANC_FB,"      );
qrysb.append("     BD.CE_SANC_FB,"      );
qrysb.append("     BD.MACHINARY_COST,"      );
qrysb.append("     BD.WORKING_CAPITAL,"      );
qrysb.append("     BD.OWN_CONTRIBUTION,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.BRANCHNAME,"      );
qrysb.append("     RBL.ADDRESS,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT, "      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     BD.UTRN_NO,"      );
qrysb.append("     BD.PAY_STATUS,"      );
qrysb.append("     BD.IST_LOAN_AMT,"      );
qrysb.append("     TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,"      );
qrysb.append("     GT.PMEGPGEOTAGID,"      );
qrysb.append("     GT.LATITUDE,"      );
qrysb.append("     GT.UNIT_ADDRESS,"      );
qrysb.append("     GT.LONGITUDE,"      );
qrysb.append("     GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT,"      );
qrysb.append("     GT.PERIOD_OF_INTEREST,"      );
qrysb.append("     GT.RATE_OF_INTEREST,"      );
qrysb.append("     GT.REPAYMENT_PERIOD,"      );
qrysb.append("     GT.CGTMSE_COVERAGE,"      );
qrysb.append("     GT.CALLBACK_REASON,"      );
qrysb.append("     GT.VALUE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("     GT.TDR_NUMBER,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("    GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.OUTSTANDING_LOAN_AMOUNT,"      );
qrysb.append("     GT.PENDING_LOAN_AMOUNT,"      );
qrysb.append("     TO_CHAR(GT.MARGIN_MONEY_ADJUSTMENT_DATE,'DD-MON-RRRR') AS MARGIN_MONEY_ADJUSTMENT_DATE,"      );
qrysb.append("     GT.NATURE_OF_COLLATERAL_SECURITY,"      );
qrysb.append("     TO_CHAR(GT.TDR_DATE,'DD-MON-RRRR') AS TDR_DATE,"      );
qrysb.append("     GT.ROI_LOAN,"      );
qrysb.append("     GT.CALLBACK_AMOUNT,"      );
qrysb.append("     GT.TDR_AMOUNT,"      );
qrysb.append("     GT.DATE_OF_ISSUE,"      );
qrysb.append("    GT.IS_INTEREST_CHARGED,"      );
qrysb.append("     GT.NPA_PERIOD,"      );
qrysb.append("     GT.IS_REPAYMENT_REGULAR,"      );
qrysb.append("     GT.IS_COLLATERAL_SECURITY,"      );
qrysb.append("     GT.INTEREST_AMOUNT,"      );
qrysb.append("     GT.MAIN_PRODUCT,"      );
qrysb.append("     GT.PRESENT_SALES_QUANTITY,"      );
qrysb.append("     GT.EXPORT_VALUE,"      );
qrysb.append("     GT.RAW_MATERIAL_IMPORT_COUNTRY,"      );
qrysb.append("     GT.PRESENT_SALES_VALUE,"      );
qrysb.append("     GT.ANNUAL_PRODUCTION_QUANTITY,"      );
qrysb.append("     GT.PRESENT_PRODUCTION_VALUE,"      );
qrysb.append("     GT.MACHINERY_TYPE,"      );
qrysb.append("     GT.MODE_OF_EXPORT,"      );
qrysb.append("     GT.ANNUAL_PRODUCTION_VALUE,"      );
qrysb.append("     GT.COUNTRY_OF_EXPORT,"      );
qrysb.append("     GT.EXPORT_QUANTITY,"      );
qrysb.append("     GT.BY_PRODUCT,"      );
qrysb.append("     GT.RAW_MATERIAL_DETAILS,"      );
qrysb.append("     GT.PRESENT_PRODUCTION_QUANTITY,"      );
qrysb.append("     GT.PRODUCTION_SALES_YEAR,"      );
qrysb.append("     GT.RAW_MATERIAL_IMPORT,"      );
qrysb.append("     GT.ANNUAL_SALES_VALUE,"      );
qrysb.append("     GT.COUNTRY_OF_IMPORT,"      );
qrysb.append("     GT.ANNUAL_SALES_QUANTITY,"      );
qrysb.append("     TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,"      );
qrysb.append("     GT.PROMINENT_SIGN_BOARD_INSTALLED,"      );
qrysb.append("     GT.VERIFICATION_STATUS,"      );
qrysb.append("     GT.VERIFICATION_BY,"      );
qrysb.append("     GT.VERIFIER_REMARKS,"      );
qrysb.append("     GT.PER_CAPITA_INVESTMENT_NORM_SAT,"      );
qrysb.append("     GT.APP_ID,"      );
qrysb.append("     GT.TOTAL_EMPLOYEES,"      );
qrysb.append("     GT.KVIC_REGISTRATION_NUMBER,"      );
qrysb.append("     GT.OTHER_CLEARANCE,"      );
qrysb.append("     GT.TRANSGENDER_EMPLOYEES,"      );
qrysb.append("     GT.SC,"      );
qrysb.append("     GT.OBC,"      );
qrysb.append("     TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("     TO_CHAR(GT.DATE_OF_WATER_CONNECTION,'DD-MON-RRRR') AS DATE_OF_WATER_CONNECTION , "      );
qrysb.append("     GT.MALE_EMPLOYEES,"      );
qrysb.append("     GT.FULLTIME_EMPLOYEES,"      );
qrysb.append("     GT.PHYSICALLY_CHALLENGED_EMPLOYEE,"      );
qrysb.append("     TO_CHAR(GT.KVIC_REGISTRATION_DATE,'DD-MON-RRRR') AS KVIC_REGISTRATION_DATE,"      );
qrysb.append("     GT.MINORITY,"      );
qrysb.append("     GT.GST_REGISTRATION_NUMBER,"      );
qrysb.append("     GT.PART_TIME_EMPLOYEES,"      );
qrysb.append("     GT.REGISTERED_BRAND_NAME,"      );
qrysb.append("     GT.UDYAM_REGISTRATION_NUMBER,"      );
qrysb.append("     GT.UNIT_SETUP_ON,"      );
qrysb.append("     GT.ST,"      );
qrysb.append("     GT.UNIT_NAME,"      );
qrysb.append("     TO_CHAR(GT.DATE_OF_ELECTRIC_CONNECTION,'DD-MON-RRRR') AS DATE_OF_ELECTRIC_CONNECTION,"      );
qrysb.append("     GT.HANDHOLDING_DETAILS,"      );
qrysb.append("     TO_CHAR(GT.UDYAM_REGISTRATION_DATE,'DD-MON-RRRR') AS UDYAM_REGISTRATION_DATE,"      );
qrysb.append("     TO_CHAR(GT.PRODUCTION_COMMENCEMENT_DATE,'DD-MON-RRRR') AS PRODUCTION_COMMENCEMENT_DATE,"      );
qrysb.append("     GT.PATENT_OWNERSHIP,"      );
qrysb.append("     GT.PAN_OR_TAN_NUMBER,"      );
qrysb.append("     GT.CERTIFICATION,"      );
qrysb.append("     GT.POLLUTION_CLEARANCE_BOARD,"      );
qrysb.append("     GT.SEASONAL_EMPLOYEES,"      );
qrysb.append("     GT.SEMI_SKILLED_EMPLOYEES,"      );
qrysb.append("     GT.SKILLED_EMPLOYEES,"      );
qrysb.append("     TO_CHAR(GT.GST_REGISTRATION_DATE,'DD-MON-RRRR') AS GST_REGISTRATION_DATE,"      );
qrysb.append("     GT.UNSKILLED_EMPLOYEES,"      );
qrysb.append("     GT.GENERAL,"      );
qrysb.append("     GT.AVERAGE_WAGES_PAID,"      );
qrysb.append("     GT.FEMALE_EMPLOYEES,"      );
qrysb.append("     GT.CAPITAL_COST_OF_BUILDING,"      );
qrysb.append("     GT.CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("     GT.FINISHED_RAW_MATERIAL_STOCK,"      );
qrysb.append("     GT.SEMI_FIN_RM_STOCK,"      );
qrysb.append("     GT.RAW_MATERIAL_STOCK_VALUE,"      );
qrysb.append("     TO_CHAR(GT.VERIFICATION_DATETIME,'DD-MON-RRRR') AS VERIFICATION_DATETIME,"      );
qrysb.append("     TO_CHAR(GT.LAST_UPDATE_DT,'DD-MON-RRRR') AS LAST_UPDATE_DT,"      );
qrysb.append("   NVL( BD.MACHINARY_COST,0)+ NVL(BD.WORKING_CAPITAL,0) AS BANK_APPRV_PRJCOST,"      );
qrysb.append("    NVL( BD.WC_SANC_FB,0)+ NVL(BD.CE_SANC_FB,0) AS BANK_SANC_PRJCOST,"      );
qrysb.append("   AD.UNIT_PIN"      );
qrysb.append("   FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     GEOTAG_TRANS GT,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM"      );
qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );
qrysb.append("   AND AD.APP_ID       = GT.APP_ID"      );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD"      );
qrysb.append("   AND BD.PACT_ID      = 34 "      );
qrysb.append("   AND GT.APP_ID=? AND GT.PMEGPGEOTAGID=?     "      );
//out.print(qrysb.toString());AND GT.ACT_ID=1 AND GT.MM_ADJUSTMENT_STATUS='RU'
ResultSet  rs;

//out.print(APP_ID);
//out.print(PMEGPGEOTAGID);
List values=new ArrayList();

values.add(APP_ID);
values.add(PMEGPGEOTAGID);

values.add(APP_ID);
values.add(PMEGPGEOTAGID);
  
    rs = db.executeSQL(qrysb.toString(),values);
   values.clear();




	while (rs.next()){
	  APP_NAME =rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	  MAX_AMT =rs.getString("MAX_AMT")==null?"":rs.getString("MAX_AMT");
	 // out.print(APP_NAME);
      GENDER =rs.getString("GENDER")==null?"":rs.getString("GENDER");
      BENF_CATAGORY_CD =rs.getString("BENF_CATAGORY_CD")==null?"":rs.getString("BENF_CATAGORY_CD");
      BENF_SPECAT_CD =rs.getString("BENF_SPECAT_CD")==null?"":rs.getString("BENF_SPECAT_CD");
      E_MAIL =rs.getString("E_MAIL")==null?"":rs.getString("E_MAIL");
      MOB_NO1 =rs.getString("MOB_NO1")==null?"":rs.getString("MOB_NO1");
      UNIT_LOC =rs.getString("UNIT_LOC")==null?"":rs.getString("UNIT_LOC");
      UNIT_DISTRICT =rs.getString("UNIT_DISTRICT")==null?"":rs.getString("UNIT_DISTRICT");
      OFF_NAME =rs.getString("OFF_NAME")==null?"":rs.getString("OFF_NAME");
      AGENCY_TYPE =rs.getString("AGENCY_TYPE")==null?"":rs.getString("AGENCY_TYPE");
      UNIT_POST_ADDR =rs.getString("UNIT_POST_ADDR")==null?"":rs.getString("UNIT_POST_ADDR");
      UNIT_TALUK_BLOCK =rs.getString("UNIT_TALUK_BLOCK")==null?"":rs.getString("UNIT_TALUK_BLOCK");
      UNIT_PIN =rs.getString("UNIT_PIN")==null?"":rs.getString("UNIT_PIN");
      DISTRICT_NAME =rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
      STATE_NM =rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
      IND_TYPE =rs.getString("IND_TYPE")==null?"":rs.getString("IND_TYPE");
      IND_GRP_LONG_DESC =rs.getString("IND_GRP_LONG_DESC")==null?"":rs.getString("IND_GRP_LONG_DESC");
      ACTIVITY_NAME =rs.getString("ACTIVITY_NAME")==null?"":rs.getString("ACTIVITY_NAME");
      PROD_DESC =rs.getString("PROD_DESC")==null?"":rs.getString("PROD_DESC");
      EDP_TRG_NAME =rs.getString("EDP_TRG_NAME")==null?"":rs.getString("EDP_TRG_NAME");
      EDP_FR_DT =rs.getString("EDP_FR_DT")==null?"":rs.getString("EDP_FR_DT");
      EDP_TO_DT=rs.getString("EDP_TO_DT")==null?"":rs.getString("EDP_TO_DT");
      LOAN_SANC_DT =rs.getString("LOAN_SANC_DT")==null?"":rs.getString("LOAN_SANC_DT");
      WC_SANC_FB =rs.getString("WC_SANC_FB")==null?"":rs.getString("WC_SANC_FB");
      CE_SANC_FB =rs.getString("CE_SANC_FB")==null?"":rs.getString("CE_SANC_FB");
      MACHINARY_COST =rs.getString("MACHINARY_COST")==null?"":rs.getString("MACHINARY_COST");
      WORKING_CAPITAL =rs.getString("WORKING_CAPITAL")==null?"":rs.getString("WORKING_CAPITAL");
      OWN_CONTRIBUTION =rs.getString("OWN_CONTRIBUTION")==null?"":rs.getString("OWN_CONTRIBUTION");
      BANK_NAME =rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
      BRANCHNAME =rs.getString("BRANCHNAME")==null?"":rs.getString("BRANCHNAME");
      ADDRESS =rs.getString("ADDRESS")==null?"":rs.getString("ADDRESS");
      IFSC_CODE =rs.getString("IFSC_CODE")==null?"":rs.getString("IFSC_CODE");
      MM_REL_DT =rs.getString("MM_REL_DT")==null?"":rs.getString("MM_REL_DT");
      MM_REL_AMT =rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
      UTRN_NO =rs.getString("UTRN_NO")==null?"":rs.getString("UTRN_NO");
      PAY_STATUS =rs.getString("PAY_STATUS")==null?"":rs.getString("PAY_STATUS");
      IST_LOAN_AMT =rs.getString("IST_LOAN_AMT")==null?"":rs.getString("IST_LOAN_AMT");
      IST_LOAN_DT =rs.getString("IST_LOAN_DT")==null?"":rs.getString("IST_LOAN_DT");
      BANK_APPRV_PRJCOST =rs.getString("BANK_APPRV_PRJCOST")==null?"":rs.getString("BANK_APPRV_PRJCOST");
      BANK_SANC_PRJCOST =rs.getString("BANK_SANC_PRJCOST")==null?"":rs.getString("BANK_SANC_PRJCOST");
      UNIT_PIN =rs.getString("UNIT_PIN")==null?"":rs.getString("UNIT_PIN");
	 //  PMEGPGEOTAGID =rs.getString("CO_REMARKS")==null?"":rs.getString("CO_REMARKS");
      LATITUDE =rs.getString("LATITUDE")==null?"":rs.getString("LATITUDE");
      UNIT_ADDRESS =rs.getString("UNIT_ADDRESS")==null?"":rs.getString("UNIT_ADDRESS");
      LONGITUDE =rs.getString("LONGITUDE")==null?"":rs.getString("LONGITUDE");
      MARGIN_MONEY_ADJUSTMENT_AMOUNT =rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT")==null?"":rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT");
      PERIOD_OF_INTEREST =rs.getString("PERIOD_OF_INTEREST")==null?"":rs.getString("PERIOD_OF_INTEREST");
      RATE_OF_INTEREST =rs.getString("RATE_OF_INTEREST")==null?"":rs.getString("RATE_OF_INTEREST");
      REPAYMENT_PERIOD =rs.getString("REPAYMENT_PERIOD")==null?"":rs.getString("REPAYMENT_PERIOD");
     CGTMSE_COVERAGE =rs.getString("CGTMSE_COVERAGE")==null?"":rs.getString("CGTMSE_COVERAGE");
      CALLBACK_REASON =rs.getString("CALLBACK_REASON")==null?"":rs.getString("CALLBACK_REASON");
      VALUE_OF_COLLATERAL_SECURITY =rs.getString("VALUE_OF_COLLATERAL_SECURITY")==null?"":rs.getString("VALUE_OF_COLLATERAL_SECURITY");
      TDR_NUMBER =rs.getString("TDR_NUMBER")==null?"":rs.getString("TDR_NUMBER");
      OUTSTANDING_LOAN_AMOUNT =rs.getString("OUTSTANDING_LOAN_AMOUNT")==null?"":rs.getString("OUTSTANDING_LOAN_AMOUNT");
      PENDING_LOAN_AMOUNT =rs.getString("PENDING_LOAN_AMOUNT")==null?"":rs.getString("PENDING_LOAN_AMOUNT");
      MARGIN_MONEY_ADJUSTMENT_DATE =rs.getString("MARGIN_MONEY_ADJUSTMENT_DATE")==null?"":rs.getString("MARGIN_MONEY_ADJUSTMENT_DATE");
      NATURE_OF_COLLATERAL_SECURITY =rs.getString("NATURE_OF_COLLATERAL_SECURITY")==null?"":rs.getString("NATURE_OF_COLLATERAL_SECURITY");
       ROI_LOAN =rs.getString("ROI_LOAN")==null?"":rs.getString("ROI_LOAN");
      CALLBACK_AMOUNT =rs.getString("CALLBACK_AMOUNT")==null?"":rs.getString("CALLBACK_AMOUNT");
      TDR_AMOUNT =rs.getString("TDR_AMOUNT")==null?"":rs.getString("TDR_AMOUNT");
      DATE_OF_ISSUE =rs.getString("DATE_OF_ISSUE")==null?"":rs.getString("DATE_OF_ISSUE");
      NPA_PERIOD =rs.getString("NPA_PERIOD")==null?"":rs.getString("NPA_PERIOD");
       INTEREST_AMOUNT =rs.getString("INTEREST_AMOUNT")==null?"":rs.getString("INTEREST_AMOUNT");
      MAIN_PRODUCT =rs.getString("MAIN_PRODUCT")==null?"":rs.getString("MAIN_PRODUCT");
      PRESENT_SALES_QUANTITY =rs.getString("PRESENT_SALES_QUANTITY")==null?"":rs.getString("PRESENT_SALES_QUANTITY");
      EXPORT_VALUE =rs.getString("EXPORT_VALUE")==null?"":rs.getString("EXPORT_VALUE");
      RAW_MATERIAL_IMPORT_COUNTRY =rs.getString("RAW_MATERIAL_IMPORT_COUNTRY")==null?"":rs.getString("RAW_MATERIAL_IMPORT_COUNTRY");
      PRESENT_SALES_VALUE =rs.getString("PRESENT_SALES_VALUE")==null?"":rs.getString("PRESENT_SALES_VALUE");
      ANNUAL_PRODUCTION_QUANTITY =rs.getString("ANNUAL_PRODUCTION_QUANTITY")==null?"":rs.getString("ANNUAL_PRODUCTION_QUANTITY");
      PRESENT_PRODUCTION_VALUE =rs.getString("PRESENT_PRODUCTION_VALUE")==null?"":rs.getString("PRESENT_PRODUCTION_VALUE");
      MACHINERY_TYPE =rs.getString("MACHINERY_TYPE")==null?"":rs.getString("MACHINERY_TYPE");
      MODE_OF_EXPORT =rs.getString("MODE_OF_EXPORT")==null?"":rs.getString("MODE_OF_EXPORT");
      ANNUAL_PRODUCTION_VALUE =rs.getString("ANNUAL_PRODUCTION_VALUE")==null?"":rs.getString("ANNUAL_PRODUCTION_VALUE");
      COUNTRY_OF_EXPORT =rs.getString("COUNTRY_OF_EXPORT")==null?"":rs.getString("COUNTRY_OF_EXPORT");
      EXPORT_QUANTITY =rs.getString("EXPORT_QUANTITY")==null?"":rs.getString("EXPORT_QUANTITY");
      BY_PRODUCT =rs.getString("BY_PRODUCT")==null?"":rs.getString("BY_PRODUCT");
      RAW_MATERIAL_DETAILS =rs.getString("RAW_MATERIAL_DETAILS")==null?"":rs.getString("RAW_MATERIAL_DETAILS");
      PRESENT_PRODUCTION_QUANTITY =rs.getString("PRESENT_PRODUCTION_QUANTITY")==null?"":rs.getString("PRESENT_PRODUCTION_QUANTITY");
      PRODUCTION_SALES_YEAR =rs.getString("PRODUCTION_SALES_YEAR")==null?"":rs.getString("PRODUCTION_SALES_YEAR");
      RAW_MATERIAL_IMPORT =rs.getString("RAW_MATERIAL_IMPORT")==null?"":rs.getString("RAW_MATERIAL_IMPORT");
      ANNUAL_SALES_VALUE =rs.getString("ANNUAL_SALES_VALUE")==null?"":rs.getString("ANNUAL_SALES_VALUE");
      COUNTRY_OF_IMPORT =rs.getString("COUNTRY_OF_IMPORT")==null?"":rs.getString("COUNTRY_OF_IMPORT");
      ANNUAL_SALES_QUANTITY =rs.getString("ANNUAL_SALES_QUANTITY")==null?"":rs.getString("ANNUAL_SALES_QUANTITY");
        VERIFICATION_STATUS =rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
      VERIFICATION_BY =rs.getString("VERIFICATION_BY")==null?"":rs.getString("VERIFICATION_BY");
      VERIFIER_REMARKS =rs.getString("VERIFIER_REMARKS")==null?"":rs.getString("VERIFIER_REMARKS");
      //   APP_ID =rs.getString("CO_REMARKS")==null?"":rs.getString("CO_REMARKS");
      TOTAL_EMPLOYEES =rs.getString("TOTAL_EMPLOYEES")==null?"":rs.getString("TOTAL_EMPLOYEES");
      KVIC_REGISTRATION_NUMBER =rs.getString("KVIC_REGISTRATION_NUMBER")==null?"":rs.getString("KVIC_REGISTRATION_NUMBER");
      OTHER_CLEARANCE =rs.getString("OTHER_CLEARANCE")==null?"":rs.getString("OTHER_CLEARANCE");
      TRANSGENDER_EMPLOYEES =rs.getString("TRANSGENDER_EMPLOYEES")==null?"":rs.getString("TRANSGENDER_EMPLOYEES");
      SC =rs.getString("SC")==null?"":rs.getString("SC");
      OBC =rs.getString("OBC")==null?"":rs.getString("OBC");
      UNIT_ESTABLISHMENT_DATE =rs.getString("UNIT_ESTABLISHMENT_DATE")==null?"":rs.getString("UNIT_ESTABLISHMENT_DATE");
      DATE_OF_WATER_CONNECTION =rs.getString("DATE_OF_WATER_CONNECTION")==null?"":rs.getString("DATE_OF_WATER_CONNECTION");
      MALE_EMPLOYEES =rs.getString("MALE_EMPLOYEES")==null?"":rs.getString("MALE_EMPLOYEES");
      FULLTIME_EMPLOYEES =rs.getString("FULLTIME_EMPLOYEES")==null?"":rs.getString("FULLTIME_EMPLOYEES");
      PHYSICALLY_CHALLENGED_EMPLOYEE =rs.getString("PHYSICALLY_CHALLENGED_EMPLOYEE")==null?"":rs.getString("PHYSICALLY_CHALLENGED_EMPLOYEE");
      KVIC_REGISTRATION_DATE =rs.getString("KVIC_REGISTRATION_DATE")==null?"":rs.getString("KVIC_REGISTRATION_DATE");
      MINORITY =rs.getString("MINORITY")==null?"":rs.getString("MINORITY");
      GST_REGISTRATION_NUMBER =rs.getString("GST_REGISTRATION_NUMBER")==null?"":rs.getString("GST_REGISTRATION_NUMBER");
      PART_TIME_EMPLOYEES =rs.getString("PART_TIME_EMPLOYEES")==null?"":rs.getString("PART_TIME_EMPLOYEES");
      REGISTERED_BRAND_NAME =rs.getString("REGISTERED_BRAND_NAME")==null?"":rs.getString("REGISTERED_BRAND_NAME");
      UDYAM_REGISTRATION_NUMBER =rs.getString("UDYAM_REGISTRATION_NUMBER")==null?"":rs.getString("UDYAM_REGISTRATION_NUMBER");
      UNIT_SETUP_ON =rs.getString("UNIT_SETUP_ON")==null?"":rs.getString("UNIT_SETUP_ON");
      ST =rs.getString("ST")==null?"":rs.getString("ST");
      UNIT_NAME =rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
      DATE_OF_ELECTRIC_CONNECTION =rs.getString("DATE_OF_ELECTRIC_CONNECTION")==null?"":rs.getString("DATE_OF_ELECTRIC_CONNECTION");
      HANDHOLDING_DETAILS =rs.getString("HANDHOLDING_DETAILS")==null?"":rs.getString("HANDHOLDING_DETAILS");
      UDYAM_REGISTRATION_DATE =rs.getString("UDYAM_REGISTRATION_DATE")==null?"":rs.getString("UDYAM_REGISTRATION_DATE");
      PRODUCTION_COMMENCEMENT_DATE =rs.getString("PRODUCTION_COMMENCEMENT_DATE")==null?"":rs.getString("PRODUCTION_COMMENCEMENT_DATE");
      PATENT_OWNERSHIP =rs.getString("PATENT_OWNERSHIP")==null?"":rs.getString("PATENT_OWNERSHIP");
      PAN_OR_TAN_NUMBER =rs.getString("PAN_OR_TAN_NUMBER")==null?"":rs.getString("PAN_OR_TAN_NUMBER");
      CERTIFICATION =rs.getString("CERTIFICATION")==null?"":rs.getString("CERTIFICATION");
      POLLUTION_CLEARANCE_BOARD =rs.getString("POLLUTION_CLEARANCE_BOARD")==null?"":rs.getString("POLLUTION_CLEARANCE_BOARD");
      SEASONAL_EMPLOYEES =rs.getString("SEASONAL_EMPLOYEES")==null?"":rs.getString("SEASONAL_EMPLOYEES");
      SEMI_SKILLED_EMPLOYEES =rs.getString("SEMI_SKILLED_EMPLOYEES")==null?"":rs.getString("SEMI_SKILLED_EMPLOYEES");
      SKILLED_EMPLOYEES =rs.getString("SKILLED_EMPLOYEES")==null?"":rs.getString("SKILLED_EMPLOYEES");
      GST_REGISTRATION_DATE =rs.getString("GST_REGISTRATION_DATE")==null?"":rs.getString("GST_REGISTRATION_DATE");
      UNSKILLED_EMPLOYEES =rs.getString("UNSKILLED_EMPLOYEES")==null?"":rs.getString("UNSKILLED_EMPLOYEES");
      GENERAL =rs.getString("GENERAL")==null?"":rs.getString("GENERAL");
      AVERAGE_WAGES_PAID =rs.getString("AVERAGE_WAGES_PAID")==null?"":rs.getString("AVERAGE_WAGES_PAID");
      FEMALE_EMPLOYEES =rs.getString("FEMALE_EMPLOYEES")==null?"":rs.getString("FEMALE_EMPLOYEES");
      CAPITAL_COST_OF_BUILDING =rs.getString("CAPITAL_COST_OF_BUILDING")==null?"":rs.getString("CAPITAL_COST_OF_BUILDING");
      CAPITAL_COST_OF_MACHINERY =rs.getString("CAPITAL_COST_OF_MACHINERY")==null?"":rs.getString("CAPITAL_COST_OF_MACHINERY");
      FINISHED_RAW_MATERIAL_STOCK =rs.getString("FINISHED_RAW_MATERIAL_STOCK")==null?"":rs.getString("FINISHED_RAW_MATERIAL_STOCK");
      SEMI_FIN_RM_STOCK =rs.getString("SEMI_FIN_RM_STOCK")==null?"":rs.getString("SEMI_FIN_RM_STOCK");
      RAW_MATERIAL_STOCK_VALUE =rs.getString("RAW_MATERIAL_STOCK_VALUE")==null?"":rs.getString("RAW_MATERIAL_STOCK_VALUE");
      IS_MARGIN_MONEY_CALLBACK_ =rs.getString("IS_MARGIN_MONEY_CALLBACK_")==null?"":rs.getString("IS_MARGIN_MONEY_CALLBACK_");
      IS_MARGIN_MONEY_ELIGIBLE_FOR_A = rs.getString("IS_MARGIN_MONEY_ELIGIBLE_FOR_A")==null?"":rs.getString("IS_MARGIN_MONEY_ELIGIBLE_FOR_A");
       TDR_DATE =rs.getString("TDR_DATE")==null?"":rs.getString("TDR_DATE");
        IS_INTEREST_CHARGED =rs.getString("IS_INTEREST_CHARGED")==null?"":rs.getString("IS_INTEREST_CHARGED");
        IS_REPAYMENT_REGULAR =rs.getString("IS_REPAYMENT_REGULAR")==null?"":rs.getString("IS_REPAYMENT_REGULAR");
		IS_COLLATERAL_SECURITY =rs.getString("IS_COLLATERAL_SECURITY")==null?"":rs.getString("IS_COLLATERAL_SECURITY");
		DATE_OF_VERIFICATION =rs.getString("DATE_OF_VERIFICATION")==null?"":rs.getString("DATE_OF_VERIFICATION");
      PROMINENT_SIGN_BOARD_INSTALLED =rs.getString("PROMINENT_SIGN_BOARD_INSTALLED")==null?"":rs.getString("PROMINENT_SIGN_BOARD_INSTALLED");
       PER_CAPITA_INVESTMENT_NORM_SAT=rs.getString("PER_CAPITA_INVESTMENT_NORM_SAT")==null?"":rs.getString("PER_CAPITA_INVESTMENT_NORM_SAT");
        VERIFICATION_DATETIME =rs.getString("VERIFICATION_DATETIME")==null?"":rs.getString("VERIFICATION_DATETIME");
		QC_REMARK=rs.getString("QC_REMARK")==null?"":rs.getString("QC_REMARK");
        QC_APPRV =rs.getString("QC_APPRV")==null?"":rs.getString("QC_APPRV");

		}
	  rs.close();
String verror="";


%>

<body onLoad="loan_calc();loan_calc1();loan_calc2();loan_calc3();">
 <h2 align="center">PMEGP Unit Inspection Form</h2> <br>
  <form  class="form-horizontal" name="form" id="form"> 
  <h3 align="center"><span class="style1">Margin Money Eligible As on Pv Date: Rs. <%=MAX_AMT%></span></h3>
  
<input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
	  <input name="PMEGPGEOTAGID" type="hidden" id="PMEGPGEOTAGID" value="<%= PMEGPGEOTAGID %>">
	   <input name="ins" type="hidden" id="ins">
	  
	   <%
	
	String validateqry="SELECT * FROM TABLE(GEOPHYSICAL_ERROR(?,?))";

    values.add(APP_ID);
values.add(PMEGPGEOTAGID);




  ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;

while (rsValidate.next()){
errcount =errcount+1;
verror=verror+""+rsValidate.getString(2)+"<br>";
//sout.print (verror);
}
rsValidate.close();
			
	
	%>
 
    <% if (!verror.equals("")) {%>
	 
	 <table class="table">
    <tr >
      <th colspan="9" ><h2 align="CENTER"><strong>System Validation Report</strong></h2></th>
    </tr>
    <tr>
      <td colspan="9"  >
        <font color="#FF0000"><h3><strong><% out.print (verror);%></strong></h3></font></td>
    </tr>
    <%}%>
	</table>
  
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>Beneficiary Id</th>
                    <th>Beneficiary Name</th>
                    <th>Verification Status</th>
                    <th>Unit District</th>
                    <th>State</th>
                    <th>IA</th>
                </tr>
            </thead>
            <tbody>
                <tr class="success">
                    <td> <%=APP_ID%> </td>
                    <td> <%=APP_NAME%> </td>
                    <td> <%=VERIFICATION_STATUS%> </td>
                    <td> <%=UNIT_DISTRICT%> </td>
                    <td> <%=STATE_NM%> </td>
                    <td> <%=AGENCY_TYPE%> </td>
                </tr>
            </tbody>
        </table>
    </div>    
      
    <div class="step-app" id="demo">
        
        <ul class="step-steps" align="center">
            <li data-step-target="step1"> BENEFICIARY DETAIL </li>
            <li data-step-target="step2"> UNIT DETAIL </li>
            <li data-step-target="step3"> PROJECT DETAIL </li>
	        <li data-step-target="step4"> PRODUCTION/SALES</li>            
	        <li data-step-target="step5"> EMPLOYMENT DETAIL </li>
			<li data-step-target="step6"> DOCUMENTS</li>
			<li data-step-target="step7" > REPORT </li>
		    <li data-step-target="step8"> MARGIN MONEY </li>		 	
			
			<!--<li data-step-target="step9"> VERIFICATION DETAIL </li>-->
	   </ul>    
        
        <div class="step-content">
      <!--
    <div class="step-header" align="center" id="myHeader">
            <button type="button" data-step-action="prev" class="step-btn">Previous</button>
            <button type="button" data-step-action="next" class="step-btn">Next</button>
      </div>
     -->
        
      <div class="step-tab-panel" data-step="step1">
	  <div class="container"> <br>
            <div class="form-group">
                    <label class="col-md-3">Geo Tagging Id : </label>
                    <div class="col-md-3"> <%=PMEGPGEOTAGID%> </div>          
                    <label class="col-md-3"> Beneficiary Id : </label>
                    <div class="col-md-3"> <%=APP_ID%></div>
            </div>
            <div class="form-group">
                    <label class="col-md-3">Beneficiary Name: </label>
                    <div class="col-md-3"> <%=APP_NAME%></div>          
                    <label class="col-md-3"> Gender : </label>
                    <div class="col-md-3"> <%=GENDER%> </div>
            </div>
            <div class="form-group">
                    <label class="col-md-3">Social Category : </label>
                    <div class="col-md-3"> <%=BENF_CATAGORY_CD%> </div>          
                    <label class="col-md-3"> Special Category : </label>
                    <div class="col-md-3"> <%=BENF_SPECAT_CD%> </div>
            </div>
            <div class="form-group">
                    <label class="col-md-3"> Mobile : </label>
                    <div class="col-md-3"> <%=MOB_NO1%> </div>          
                    <label class="col-md-3"> Email Id : </label>
                    <div class="col-md-3"><%=E_MAIL%></div>
            </div> <br>
            <div class="form-group">
                    <label class="col-md-12"> <u>EDP Training Details</u> </label>
            </div>
            <div class="form-group">
                    <label class="col-md-3"> EDP Training Period From : </label>
                    <div class="col-md-3"> <%=EDP_FR_DT%> </div>          
                    <label class="col-md-3"> EDP Training Period To </label>
                    <div class="col-md-3"> <%=EDP_TO_DT%> </div>
            </div>
            <div class="form-group">
                    <label class="col-md-3"> Name Of Institute : </label>
                    <div class="col-md-9"><%=EDP_TRG_NAME%></div>
            </div>		
		</div> <br>
	   </div>	
		
        <div class="step-tab-panel" data-step="step2">
        <div class="container"> <br>
		  <div class="form-group">
                    <label class="col-md-3">Unit Location : </label>
                    <div class="col-md-9"> <%=UNIT_LOC%> </div>
          </div>
          <div class="form-group">
                    <label class="col-md-3"> Unit Sponsored By : </label>
                    <div class="col-md-3"> <%=AGENCY_TYPE%> </div>
                    <label class="col-md-3">Agency Office : </label>
                    <div class="col-md-3"> <%=OFF_NAME%></div>
          </div>
          <div class="form-group">
                    <label class="col-md-3">PMEGP Eportal Unit Address : </label>
                    <div class="col-md-9"> <%=UNIT_ADDRESS%> </div>
          </div>
          <div class="form-group">
                    <label class="col-md-3">Taluka : </label>
                    <div class="col-md-3"> <%=UNIT_TALUK_BLOCK%> </div>          
                    <label class="col-md-3"> Unit District : </label>
                    <div class="col-md-3"> <%=UNIT_DISTRICT%> </div>
          </div>
          <div class="form-group">
                    <label class="col-md-3">State : </label>
                    <div class="col-md-3"> <%=STATE_NM%></div>          
                    <label class="col-md-3"> Pincode : </label>
                    <div class="col-md-3"> <%=UNIT_PIN%> </div>
          </div> <br>
            
          <div class="form-group">
                    <label class="col-md-3">Industry Type : </label>
                    <div class="col-md-9"> <%=IND_TYPE%> </div>
          </div>
          <div class="form-group">
                    <label class="col-md-3">Latitude : </label>
                    <div class="col-md-3"> <%=LATITUDE%> </div>          
                    <label class="col-md-3"> Longitude : </label>
                    <div class="col-md-3"> <%=LONGITUDE%> </div>
          </div>
          <div class="form-group">
                    <label class="col-md-3">Industry Activity : </label>
                    <div class="col-md-9"> <%=ACTIVITY_NAME%></div>
          </div>
          <div class="form-group">
                    <label class="col-md-3">Product Description : </label>
                    <div class="col-md-9"> <%=PROD_DESC%></div>
          </div> <br>              
            
          
			
			   <div class="form-group" align="center">
                    <label class="col-md-12"><u> Verification Detail </u></label>
          </div>                
                
                <div class="form-group">
                    <label class="col-md-3">Per Capita Investment  Norm Satisfied : </label>
					<div class="col-md-3">
                        <label class="radio-inline"><input type="radio" name="PER_CAPITA_INVESTMENT_NORM_SAT" value='Y' <% if (PER_CAPITA_INVESTMENT_NORM_SAT.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="PER_CAPITA_INVESTMENT_NORM_SAT" value='N' <% if (PER_CAPITA_INVESTMENT_NORM_SAT.equals("N")){out.print("checked");}%>>No</label>                       
                    </div>                    
                    <label class="col-md-3">Prominent Sign Board  Installed  : </label>
                    <div class="col-md-3">
						<label class="radio-inline"><input type="radio" name="PROMINENT_SIGN_BOARD_INSTALLED" value='Y'  <% if (PROMINENT_SIGN_BOARD_INSTALLED.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="PROMINENT_SIGN_BOARD_INSTALLED" value='N' <% if (PROMINENT_SIGN_BOARD_INSTALLED.equals("N")){out.print("checked");}%> >No</label>
					</div>                                    
                </div>
                
                <div class="form-group">
                    <label class="col-md-2"> Verification Status : </label>
                    <div class="col-md-4">
						<label class="radio-inline"><input type="radio" name="VERIFICATION_STATUS" value='Working' <% if (VERIFICATION_STATUS.equals("Working")){out.print("checked");}%> >Working</label>
                        <label class="radio-inline"><input type="radio" name="VERIFICATION_STATUS" value='Defunct'  <% if (VERIFICATION_STATUS.equals("Defunct")){out.print("checked");}%> >Defunct</label>
						<label class="radio-inline"><input type="radio" name="VERIFICATION_STATUS" value='Non-Traceble'  <% if (VERIFICATION_STATUS.equals("Non-Traceble")){out.print("checked");}%> >Non-Traceble</label>
					</div>
                    
                    <label class="col-md-3"> Verification Date : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"   onClick="javascript:NewCssCal('VERIFICATION_DATETIME','ddMMMyyyy')" id="VERIFICATION_DATETIME" value="<%=VERIFICATION_DATETIME%>" name="VERIFICATION_DATETIME" maxlength="50" required readonly="true">                  
                    </div>                                                      
                </div>
				
				<div class="form-group">
                    <label class="col-md-3"> Verification Agency Name : </label>
                    <div class="col-md-4">
						<input type="text" class="form-control" id="VERIFICATION_BY" value="<%=VERIFICATION_BY%>" name="VERIFICATION_BY" placeholder="Verification Agency Name" maxlength="100" required readonly="true">            

					</div>
				</div>
                
				<div class="form-group">				
                    <label class="col-md-3"> Verification Agency  Remarks : </label>
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="VERIFIER_REMARKS" id="VERIFIER_REMARKS" value="<%=VERIFIER_REMARKS%>" placeholder="Enter Remarks" maxlength="500" required>                  
                    </div>                                                      
                </div>
			
			  <div class="form-group">
                <div class="col-md-12" align="center">
                    <label> <u> Unit Details </u></label>
                </div>            
            </div> <br>
			
			
			
			
            <div class="form-group">
                <div class="col-md-3">
                    <label for="unitName">Unit Name* :</label>
                </div>
                <div class="col-md-9">
<input type="text" class="form-control" name="UNIT_NAME"  id="UNIT_NAME" maxlength="150" value="<%=UNIT_NAME%>" placeholder="Enter Unit Name"  required>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-3">
                    <label for="unitAdd">Updated Unit Address as per Physical Verification *:</label> 
                </div>
                <div class="col-md-9">
                    <input class="form-control" name="UNIT_ADDRESS" type="text" id="UNIT_ADDRESS" maxlength="1000" value="<%=UNIT_ADDRESS%>" placeholder="Enter Unit Address"  height="150px" required></input>
                </div>
            </div>
            <div class="form-group">
                <label for="unitEstDate" class="col-md-3">Unit Establishment Date* :</label>
                <div class="col-md-3">
 <input  class="form-control" name="UNIT_ESTABLISHMENT_DATE" type="text" id="UNIT_ESTABLISHMENT_DATE" onClick="javascript:NewCssCal('UNIT_ESTABLISHMENT_DATE','ddMMMyyyy')" value="<%=UNIT_ESTABLISHMENT_DATE%>" placeholder="Enter Establishment Date"  height="150px" required>
                </div>            
                <label for="unitAdd" class="col-md-3">Unit setup On* :</label>
                <div class="col-md-3">
                    <label class="radio-inline"><input type="radio" value="Rental" name="UNIT_SETUP_ON" <% if (UNIT_SETUP_ON.equals("Rental")){out.print("checked");}%>>Rental</label>
                    <label class="radio-inline"><input type="radio" value="Lease" name="UNIT_SETUP_ON" <% if (UNIT_SETUP_ON.equals("Lease")){out.print("checked");}%>>Lease</label>
                    <label class="radio-inline"><input type="radio" value="own premises" name="UNIT_SETUP_ON" <% if (UNIT_SETUP_ON.equals("own premises")){out.print("checked");}%>>Own Premises</label> 
                </div>
            </div>
            <div class="form-group">
                <label for="dateWater" class="col-md-3">Date of Water connection :</label>
                <div class="col-md-3">
                    <input class="form-control"   onClick="javascript:NewCssCal('DATE_OF_WATER_CONNECTION','ddMMMyyyy')" id="DATE_OF_WATER_CONNECTION" value="<%=DATE_OF_WATER_CONNECTION%>" name="DATE_OF_WATER_CONNECTION" required>                   
                </div>            
                <label for="dateWater" class="col-md-3">Date of Electricity connection:</label>
                <div class="col-md-3">
                    <input  class="form-control"  onClick="javascript:NewCssCal('DATE_OF_ELECTRIC_CONNECTION','ddMMMyyyy')"  id="DATE_OF_ELECTRIC_CONNECTION" value="<%=DATE_OF_ELECTRIC_CONNECTION%>" name="DATE_OF_ELECTRIC_CONNECTION" required>                   
                </div> 
            </div>
            
            <div class="form-group">
                <label for="dateWater" class="col-md-3">Clearance From Pollution :</label>
                <div class="col-md-3">
                    <label class="radio-inline"><input type="radio" name="POLLUTION_CLEARANCE_BOARD" value="State"  <% if (POLLUTION_CLEARANCE_BOARD.equals("State")){out.print("checked");}%> >State</label>
                    <label class="radio-inline"><input type="radio" name="POLLUTION_CLEARANCE_BOARD" value="Central"  <% if (POLLUTION_CLEARANCE_BOARD.equals("Central")){out.print("checked");}%>  >Central</label>                   
                </div>            
                <label for="dateWater" class="col-md-3">Any other Clearance obtained : </label>
                <div class="col-md-3">
                    <input type="text" class="form-control"  id="OTHER_CLEARANCE" value="<%=OTHER_CLEARANCE%>" name="OTHER_CLEARANCE" placeholder="Enter Other Clearance obtained" maxlength="100" required>                   
                </div> 
            </div>
            
            <div class="form-group">
                <label for="dateWater" class="col-md-3">GST Registration Number :</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="GST_REGISTRATION_NUMBER" value="<%=GST_REGISTRATION_NUMBER%>" name="GST_REGISTRATION_NUMBER" placeholder="Enter GST Registration Number" maxlength="15" required>                  
                </div>            
                <label for="dateWater" class="col-md-3">GST Registration Date : </label>
                <div class="col-md-3">
                    <input type="text" class="form-control" onClick="javascript:NewCssCal('GST_REGISTRATION_DATE','ddMMMyyyy')"  id="GST_REGISTRATION_DATE" value="<%=GST_REGISTRATION_DATE%>" name="GST_REGISTRATION_DATE" required>  
                </div> 
            </div>
            
            <div class="form-group">
                <label for="dateWater" class="col-md-3">UDYAM Registration :</label>
                <div class="col-md-3">
                    <input type="text" class="form-control"  id="UDYAM_REGISTRATION_NUMBER" value="<%=UDYAM_REGISTRATION_NUMBER%>" name="UDYAM_REGISTRATION_NUMBER" placeholder="Enter UDYAM Registration Number" maxlength="12" required>                  
                </div>            
                <label for="dateWater" class="col-md-3">UDYAM Registration Date : </label>
                <div class="col-md-3">
                    <input  class="form-control" onClick="javascript:NewCssCal('UDYAM_REGISTRATION_DATE','ddMMMyyyy')"  id="UDYAM_REGISTRATION_DATE" value="<%=UDYAM_REGISTRATION_DATE%>" name="UDYAM_REGISTRATION_DATE" required>  
                </div> 
            </div>
           
            <div class="form-group">
                <label for="dateWater" class="col-md-3">PAN/TAN Number (if any) :</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="PAN_OR_TAN_NUMBER" value="<%=PAN_OR_TAN_NUMBER%>" name="PAN_OR_TAN_NUMBER" placeholder="Enter PAN/TAN Number" maxlength="10">                  
                </div>
            </div>
            
            <div class="form-group">
                <label for="dateWater" class="col-md-3">KVIC Registration Number: : </label>
                <div class="col-md-3">
                    <input type="text" class="form-control"  id="KVIC_REGISTRATION_NUMBER" value="<%=KVIC_REGISTRATION_NUMBER%>" name="KVIC_REGISTRATION_NUMBER" placeholder="Enter KVIC Registration Number" maxlength="10" required>                  
                </div> 
                <label for="dateWater" class="col-md-3">KVIC Registration Date : </label>
                <div class="col-md-3">
                    <input  class="form-control" onClick="javascript:NewCssCal('KVIC_REGISTRATION_DATE','ddMMMyyyy')"  id="KVIC_REGISTRATION_DATE" value="<%=KVIC_REGISTRATION_DATE%>" name="KVIC_REGISTRATION_DATE" required>  
                </div> 
            </div>
            
            <div class="form-group">
                <label class="col-md-3">Certification :</label>
                <div class="col-md-9">
                    <label class="radio-inline"><input type="radio" name="CERTIFICATION" value="FSSAI"  <% if (CERTIFICATION.equals("FSSAI")){out.print("checked");}%>>FSSAI</label>
                    <label class="radio-inline"><input type="radio" name="CERTIFICATION" value="AGMARK"  <% if (CERTIFICATION.equals("AGMARK")){out.print("checked");}%> >AGMARK</label>
                    <label class="radio-inline"><input type="radio" name="CERTIFICATION"value="BIS"  <% if (CERTIFICATION.equals("BIS")){out.print("checked");}%>>BIS</label>
                    <label class="radio-inline"><input type="radio" name="CERTIFICATION" value="Other"  <% if (CERTIFICATION.equals("Other")){out.print("checked");}%>>Other</label>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-md-3">Registered Brand Name : </label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="REGISTERED_BRAND_NAME" value="<%=REGISTERED_BRAND_NAME%>" name="REGISTERED_BRAND_NAME" placeholder="Enter Registered Brand Name" maxlength="100" required>                  
                </div> 
                
                <label class="col-md-3">Patent Ownership (if any) : </label>
                <div class="col-md-3">
                    <input type="text" class="form-control"  id="PATENT_OWNERSHIP" value="<%=PATENT_OWNERSHIP%>" name="PATENT_OWNERSHIP" placeholder="Enter Patent Ownership" maxlength="100">                  
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-md-3">Details of Handholding  :</label>
                <div class="col-md-9">
                    <input type="text" class="form-control"  id="HANDHOLDING_DETAILS" value="<%=HANDHOLDING_DETAILS%>" name="HANDHOLDING_DETAILS" placeholder="Enter Details of Handholding" maxlength="100" required>                  
                </div>                 
            </div>          
		</div> <br>
	</div>
       
        
	<div class="step-tab-panel" data-step="step3">
	  		<div class="container"> <br>
                <div class="form-group">
                    <label class="col-md-12"><u>Financing Bank Details </u></label>
                </div>
				<div class="form-group">
                    <label class="col-md-3">Financing Bank : </label>
                    <div class="col-md-9"> <%=BANK_NAME%></div>
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">Bank Branch : </label>
                    <div class="col-md-9"> <%=BRANCHNAME%> </div>
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">Branch Address : </label>
                    <div class="col-md-9"> <%=ADDRESS%> </div>
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">IFSC Code : </label>
                    <div class="col-md-9"> <%=IFSC_CODE%> </div>
                </div> <br><br>
                
                <div class="form-group">
                    <label class="col-md-12"><u>Project Details </u></label>
                </div>
				<div class="form-group">
                    <label class="col-md-4">Project Sanctioned Date :</label>
                    <div class="col-md-2"> <%=LOAN_SANC_DT%> </div>               
                    <label class="col-md-4">Scheme under which  project got sanctioned :</label>
                    <div class="col-md-2"> <%=LOAN_TYPE%> </div>
                </div>
                <div class="form-group">
                    <label class="col-md-4">Capital Expenditure :</label>
                    <div class="col-md-2"> <%= MACHINARY_COST %></div>               
                    <label class="col-md-4">Capital Expenditure Sanction :</label>
                    <div class="col-md-2"> <%= CE_SANC_FB %> </div>
                </div>
                <div class="form-group">
                    <label class="col-md-4">Working Capital :</label>
                    <div class="col-md-2"> <%= WORKING_CAPITAL %> </div>               
                    <label class="col-md-4">Working Capital Sanction :</label>
                    <div class="col-md-2"> <%= WC_SANC_FB %> </div>
                </div>
                <div class="form-group">
                    <label class="col-md-4">Total Project Cost :</label>
                    <div class="col-md-2"> <%= BANK_APPRV_PRJCOST %> </div>               
                    <label class="col-md-4">Total Sanction :</label>
                    <div class="col-md-2"> <%= BANK_SANC_PRJCOST %> </div>
                </div>
                <div class="form-group">
                    <label class="col-md-4">Own Contribution :</label>
                    <div class="col-md-2"> <%=OWN_CONTRIBUTION%> </div>               
                    <label class="col-md-4">MM Released :</label>
                    <div class="col-md-2"> <%=MM_REL_AMT%> </div>
                </div>
                <div class="form-group">
                    <label class="col-md-4">Balance Loan to be released as on PV Date : </label>
                    <div class="col-md-8"> <%=PENDING_LOAN_AMOUNT%> </div>
                </div>                      
			</div> <br>
		</div>
		 <div class="step-tab-panel" data-step="step4">
	  		<div class="container"><br>
                <div class="form-group">
                    <label class="col-md-12"><u> Production/Sales Details </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-12"><u> Annual Production </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Quantity* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="ANNUAL_PRODUCTION_QUANTITY" value="<%=ANNUAL_PRODUCTION_QUANTITY%>" name="ANNUAL_PRODUCTION_QUANTITY" placeholder="Enter Annual Production Quantity" maxlength="50" min="0"  required>
                    </div>
                
                    <label class="col-md-3">Value (in Rupees)* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="ANNUAL_PRODUCTION_VALUE" value="<%=ANNUAL_PRODUCTION_VALUE%>" name="ANNUAL_PRODUCTION_VALUE" placeholder="Enter Annual Production Value" maxlength="50" min="0"  onkeypress="return isNumeric(event)" required>                  
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-12"><u> Present Production </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Quantity* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control" id="PRESENT_PRODUCTION_QUANTITY" value="<%=PRESENT_PRODUCTION_QUANTITY%>" name="PRESENT_PRODUCTION_QUANTITY" placeholder="Enter Annual Production Quantity" maxlength="50" min="0"  required>
                    </div> 
                
                    <label class="col-md-3">Value (in Rupees)* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="PRESENT_PRODUCTION_VALUE" value="<%=PRESENT_PRODUCTION_VALUE%>" name="PRESENT_PRODUCTION_VALUE" placeholder="Enter Annual Production Value" maxlength="50" min="0" onKeyPress="return isNumeric(event)" required>                  
                    </div>
                </div><br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Machinery Details </u></label>
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">Type of Machinary : </label>
                    <div class="col-md-9">
                        <input type="text" class="form-control"  id="MACHINERY_TYPE" value="<%=MACHINERY_TYPE%>" name="MACHINERY_TYPE" placeholder="Enter Machinery Details" maxlength="100" required>
                    </div>  
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Raw Material Details </u></label>
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">Details of Raw Material : </label>
                    <div class="col-md-9">
                        <input type="text" class="form-control"  id="RAW_MATERIAL_DETAILS" value="<%=RAW_MATERIAL_DETAILS%>" name="RAW_MATERIAL_DETAILS" placeholder="Enter Raw Material Details" maxlength="500" required>
                    </div>  
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">Import of Raw Material (if any) : </label>
                    <div class="col-md-9">
                        <input type="text" class="form-control"  id="RAW_MATERIAL_IMPORT" value="<%=RAW_MATERIAL_IMPORT%>" name="RAW_MATERIAL_IMPORT" placeholder="Enter Import Details" maxlength="100">
                    </div>  
                </div>
                
                <div class="form-group">
                    <label class="col-md-3">Country of Import : </label>
                    <div class="col-md-9">
                        <input type="text" class="form-control"  id="COUNTRY_OF_IMPORT" value="<%=COUNTRY_OF_IMPORT%>" name="COUNTRY_OF_IMPORT" placeholder="Enter Country of Import" maxlength="50" required>
                    </div>  
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Value of Stock on the Day of Visit (In Rupees) </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-2">Raw : </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control"  id="RAW_MATERIAL_STOCK_VALUE"  onkeypress="return isNumeric(event)" value="<%=RAW_MATERIAL_STOCK_VALUE%>" name="RAW_MATERIAL_STOCK_VALUE" placeholder="Enter value" maxlength="50" min="0" required>
                    </div> 
                
                    <label class="col-md-2">Semi-Finished : </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control"  id="SEMI_FIN_RM_STOCK"  onkeypress="return isNumeric(event)" value="<%=SEMI_FIN_RM_STOCK%>" name="SEMI_FIN_RM_STOCK" placeholder="Enter value" maxlength="50" required>                  
                    </div>
                    
                    <label class="col-md-2">Finished : </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onKeyPress="return isNumeric(event)"  id="FINISHED_RAW_MATERIAL_STOCK" value="<%=FINISHED_RAW_MATERIAL_STOCK%>" name="FINISHED_RAW_MATERIAL_STOCK" placeholder="Enter value" maxlength="50" min="0" required>                  
                    </div>
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Cost of Capital Items Procured (In Rupees) </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Building: </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="CAPITAL_COST_OF_BUILDING" value="<%=CAPITAL_COST_OF_BUILDING%>" name="CAPITAL_COST_OF_BUILDING" placeholder="Enter value" maxlength="50" min="0" onKeyPress="return isNumeric(event)" required>
                    </div>                
                    <label class="col-md-3">Machine Equipment : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="CAPITAL_COST_OF_MACHINERY" value="<%=CAPITAL_COST_OF_MACHINERY%>" name="CAPITAL_COST_OF_MACHINERY" placeholder="Enter value" maxlength="50" min="0" onKeyPress="return isNumeric(event)" required>
                    </div>  
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Annual Sales Projection </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Quantity : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="ANNUAL_SALES_QUANTITY" value="<%=ANNUAL_SALES_QUANTITY%>" name="ANNUAL_SALES_QUANTITY" placeholder="Enter value" maxlength="50" min="0"  required>
                    </div>                
                    <label class="col-md-3">Value (In Rupees)* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control" id="ANNUAL_SALES_VALUE" value="<%=ANNUAL_SALES_VALUE%>" name="ANNUAL_SALES_VALUE" placeholder="Enter value" maxlength="50" min="0" onKeyPress="return isNumeric(event)" required>
                    </div>  
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Present Sale </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Quantity* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"id="PRESENT_SALES_QUANTITY" value="<%=PRESENT_SALES_QUANTITY%>" name="PRESENT_SALES_QUANTITY" placeholder="Enter value" maxlength="50" min="0"  required>
                    </div>                
                    <label class="col-md-3">Value (In Rupees)* : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control"  id="PRESENT_SALES_VALUE" value="<%=PRESENT_SALES_VALUE%>" name="PRESENT_SALES_VALUE" placeholder="Enter value" maxlength="50" min="0"  onkeypress="return isNumeric(event)" required>
                    </div>  
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Product Detail </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Main Product *: </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"  id="MAIN_PRODUCT" value="<%=MAIN_PRODUCT%>" name="MAIN_PRODUCT" placeholder="Enter Product Detail" maxlength="100" required>
                    </div>                
                    <label class="col-md-3">By-product : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"  id="BY_PRODUCT" value="<%=BY_PRODUCT%>" name="BY_PRODUCT" placeholder="Enter By-product Detail" maxlength="100" required>
                    </div>  
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Export Detail </u></label>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Quantity : </label>
                    <div class="col-md-3">
                        <input type="TEXT" class="form-control" id="EXPORT_QUANTITY" value="<%=EXPORT_QUANTITY%>" name="EXPORT_QUANTITY" placeholder="Enter value" maxlength="50" min="0" required>
                    </div>                
                    <label class="col-md-3">Value (In Rupees) : </label>
                    <div class="col-md-3">
                        <input type="TEXT" onKeyPress="return isNumeric(event)" class="form-control"  id="EXPORT_VALUE" value="<%=EXPORT_VALUE%>" name="EXPORT_VALUE" placeholder="Enter value" maxlength="50" min="0" required>
                    </div>  
                </div>
                <div class="form-group">
                    <label class="col-md-3">Country of : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"  id="COUNTRY_OF_EXPORT" value="<%=COUNTRY_OF_EXPORT%>" name="COUNTRY_OF_EXPORT" placeholder="Enter Country Of" maxlength="50" required>
                    </div>
                                        
                    <label class="col-md-2">Mode of Export :</label>
                    <div class="col-md-4">
					<input type="TEXT" class="form-control" name="MODE_OF_EXPORT" id="MODE_OF_EXPORT" value="<%=MODE_OF_EXPORT%>"  placeholder="Enter value" maxlength="10" min="0" required>
                                         
                    </div>
                </div>               
            </div> <br><br>
        </div>
   <div class="step-tab-panel" data-step="step5">
	  	    <div class="container"> <br>
                <div class="form-group" align="center">
                    <label class="col-md-12"><u> Employment Detail </u></label>
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Type of Man Power </u></label>
                </div>                
                
                <div class="form-group">
                    <label class="col-md-1">Skilled </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onKeyPress="return isNumeric(event)"  onBlur="loan_calc()" id="SKILLED_EMPLOYEES" value="<%=SKILLED_EMPLOYEES%>" name="SKILLED_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>
                    </div> 
                
                    <label class="col-md-1">Semi-Skilled </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control"  onBlur="loan_calc()" id="SEMI_SKILLED_EMPLOYEES" value="<%=SEMI_SKILLED_EMPLOYEES%>" name="SEMI_SKILLED_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0"   onkeypress="return isNumeric(event)" required>                  
                    </div>
                    
                    <label class="col-md-1">Unskilled </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onBlur="loan_calc()"  onkeypress="return isNumeric(event)" id="UNSKILLED_EMPLOYEES" value="<%=UNSKILLED_EMPLOYEES%>" name="UNSKILLED_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>                    
              
                    <label class="col-md-1"> Total </label>
                    *
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onKeyPress="return isNumeric(event)"  id="TOTAL_SKILLED" value="<%=TOTAL_SKILLED%>" name="TOTAL_SKILLED" placeholder="Enter value" maxlength="10" min="0" required>  
						<input type="HIDDEN" class="form-control"   id="DATE_OF_VERIFICATION" value="<%=DATE_OF_VERIFICATION%>" name="DATE_OF_VERIFICATION">                  
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-md-12"><u> Currently Employed Man Power </u></label>
                </div>                
                
                <div class="form-group">
                    <label class="col-md-1">Full-time </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control"  onkeypress="return isNumeric(event)" onBlur="loan_calc1()" id="FULLTIME_EMPLOYEES" value="<%=FULLTIME_EMPLOYEES%>" name="FULLTIME_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>
                    </div> 
                
                    <label class="col-md-1">Part-time </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onKeyPress="return isNumeric(event)" onBlur="loan_calc1()"  id="PART_TIME_EMPLOYEES" value="<%=PART_TIME_EMPLOYEES%>" name="PART_TIME_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>                                    
                    <label class="col-md-1">Seasonal </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onKeyPress="return isNumeric(event)" onBlur="loan_calc1()"  id="SEASONAL_EMPLOYEES" value="<%=SEASONAL_EMPLOYEES%>" name="SEASONAL_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                    
                    <label class="col-md-1"> Total </label>
                    <div class="col-md-2">
                        <input type="TEXT" class="form-control" onKeyPress="return isNumeric(event)"  id="TOTAL_SEASONAL" value="<%=TOTAL_SEASONAL%>" name="TOTAL_SEASONAL" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-2">General </label>
                    <div class="col-md-2">
                        <input type="text" onKeyPress="return isNumeric(event)" class="form-control" onBlur="loan_calc2()" id="GENERAL" value="<%=GENERAL%>" name="GENERAL" placeholder="Enter value" maxlength="10" min="0" required>
                    </div> 
                
                    <label class="col-md-2">SC </label>
                    <div class="col-md-2">
                        <input type="text" onKeyPress="return isNumeric(event)" class="form-control" onBlur="loan_calc2()"  id="SC" value="<%=SC%>" name="SC" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                    
                    <label class="col-md-2">ST </label>
                    <div class="col-md-2">
                        <input type="text" onKeyPress="return isNumeric(event)" class="form-control" onBlur="loan_calc2()"  id="ST" value="<%=ST%>" name="ST" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-md-2">OBC </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" onKeyPress="return isNumeric(event)" onBlur="loan_calc2()"  id="OBC" value="<%=OBC%>" name="OBC" placeholder="Enter value" maxlength="10" min="0" required>
                    </div> 
                
                    <label class="col-md-2">Minority </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" onKeyPress="return isNumeric(event)" onBlur="loan_calc2()"  id="MINORITY" value="<%=MINORITY%>" name="MINORITY" placeholder="Enter value" maxlength="10" min="0" required>       
                    </div>
                    <label class="col-md-2"> Total </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control"  onkeypress="return isNumeric(event)" id="TOTAL_MINORITY" value="<%=TOTAL_MINORITY%>" name="TOTAL_MINORITY" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>                   
                </div> <br>
                
                <div class="form-group">
                    <label class="col-md-1">Male </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" onBlur="loan_calc3()" onKeyPress="return isNumeric(event)" id="MALE_EMPLOYEES" value="<%=MALE_EMPLOYEES%>" name="MALE_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>
                    </div> 
                
                    <label class="col-md-1">Female </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" onBlur="loan_calc3()" onKeyPress="return isNumeric(event)"  id="FEMALE_EMPLOYEES" value="<%=FEMALE_EMPLOYEES%>" name="FEMALE_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>                    
                    <label class="col-md-1">Transgender </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control"  onBlur="loan_calc3()" onKeyPress="return isNumeric(event)" id="TRANSGENDER_EMPLOYEES" value="<%=TRANSGENDER_EMPLOYEES%>" name="TRANSGENDER_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                    <label class="col-md-1"> Total </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control"  id="TOTAL_GENDER"  onkeypress="return isNumeric(event)" value="<%=TOTAL_GENDER%>" name="TOTAL_GENDER" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div> 
                </div> <br>                
                
                <div class="form-group">
                    <label class="col-md-4">Number of Physically Challenged Employees </label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="PHYSICALLY_CHALLENGED_EMPLOYEE" onKeyPress="return isNumeric(event)" value="<%=PHYSICALLY_CHALLENGED_EMPLOYEE%>" name="PHYSICALLY_CHALLENGED_EMPLOYEE" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>               
                </div>
                <div class="form-group">
                    <label class="col-md-4">Total Number of Employees </label>
                    <div class="col-md-8">
                        <input type="hidden" class="form-control" id="TOTAL_EMPLOYEES"  onkeypress="return isNumeric(event)" value="<%=TOTAL_EMPLOYEES%>" name="TOTAL_EMPLOYEES" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-md-4">Average Wages paid per Month </label>
                    *
                    <div class="col-md-8">
                        <input type="text" class="form-control"  id="AVERAGE_WAGES_PAID" onKeyPress="return isNumeric(event)" value="<%=AVERAGE_WAGES_PAID%>" name="AVERAGE_WAGES_PAID" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                </div>               
            </div> <br>
        </div>                
		               
		
       
		
		
		  <%
		 StringBuffer qry= new StringBuffer();
	

qry.append("   SELECT ga.ATTACHMENT_NAME, ga.MEDIA_TYPE, ga.APP_ID FROM geotag_attch ga  where  ga.APP_ID=?"      );

int count=0;



values.add(APP_ID);
  
   rs = db.executeSQL(qry.toString(),values);
   values.clear();
		
		
		
		%>
		
		 <div class="step-tab-panel" data-step="step6">
	  	    <div class="container"> <br>
                <div class="form-group" align="center">
                    <label class="col-md-12"><u> Documents</u></label>
                </div>    

  <div class="form-group">
  <%
  String MEDIA_TYPE="";
   String ATTACHMENT_NAME="";
while (rs.next()){	
	ATTACHMENT_NAME=rs.getString("ATTACHMENT_NAME")==null?"":rs.getString("ATTACHMENT_NAME");
	MEDIA_TYPE=rs.getString("MEDIA_TYPE")==null?"":rs.getString("MEDIA_TYPE");	
	
  %>
                    <div class="col-md-6"><%=ATTACHMENT_NAME%> </div>
                    <div class="col-md-6"> <A href="<%=MEDIA_TYPE%>" class="step-btn" target="_blank">View</A>  </div>  <br>                
                   
<%}
rs.close();
%>           
              </div>  				
              
		   </div>
	      </div>
				    <div class="step-tab-panel" data-step="step7">
	  	    <div class="container"> <br>
                <div class="form-group" align="center">
                    <label class="col-md-12"><u><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=GEOTAGREPORT&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound"> Report</A></u></label>
                </div>    

  <div class="form-group">

 
         </div>  				
              
				   </div>
				   </div>
				   
				   
				    <div class="step-tab-panel" data-step="step8">
	  	    <div class="container"><br>
                
        
                <div class="form-group" align="center">
                    <label class="col-md-12"><u> Margin Money Detail </u></label>
                </div> <br>                
                
                <div class="form-group">
                    <label class="col-md-3">Margin Money Release Amount : </label>
                    <div class="col-md-3"> <%=MM_REL_AMT%> </div>
                    
                    <label class="col-md-3">First Installment Date : </label>
                    <div class="col-md-3"> <%=IST_LOAN_DT%></div>                                    
                </div>
                
                <div class="form-group">
                    <label class="col-md-3"> Balance Loan to be released as on PV Date  : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"  id="PENDING_LOAN_AMOUNT"  onkeypress="return isNumeric(event)" value="<%=PENDING_LOAN_AMOUNT%>" name="PENDING_LOAN_AMOUNT" placeholder="Enter Balance Loan amount" maxlength="10" min="0" required>                  
                    </div>
                    
                    <label class="col-md-3"> Rate of Interest on Loan* : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="ROI_LOAN" id="ROI_LOAN" onKeyPress="return isNumeric(event)" value="<%=ROI_LOAN%>"  placeholder="Enter value" maxlength="5" min="0" required>                  
                    </div>                                                      
                </div>
                
                <div class="form-group">
                    <label class="col-md-2"> TDR Amount* : </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" id="TDR_AMOUNT" value="<%=TDR_AMOUNT%>" onKeyPress="return isNumeric(event)" name="TDR_AMOUNT" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>
                    
                    <label class="col-md-2"> TDR Numer* : </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control"  id="TDR_NUMBER" value="<%=TDR_NUMBER%>" name="TDR_NUMBER" placeholder="Enter value" maxlength="50" min="0" required>                  
                    </div>
                    
                    <label class="col-md-2"> TDR Date* : </label>
                    <div class="col-md-2">
                        <input type="text" class="form-control" onClick="javascript:NewCssCal('TDR_DATE','ddMMMyyyy')" id="TDR_DATE" value="<%=TDR_DATE%>" name="TDR_DATE" maxlength="50" required>                  
                    </div>
                </div>
				
				<div class="form-group">
                    <label class="col-md-4"> CGTMSE  Coverage : </label>
                    <div class="col-md-2">
                        <label class="radio-inline"><input type="radio" name="CGTMSE_COVERAGE" value='Y' <% if (CGTMSE_COVERAGE.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="CGTMSE_COVERAGE" value='N' <% if (CGTMSE_COVERAGE.equals("N")){out.print("checked");}%>>No</label>                        
                    </div>
                    
                    <label class="col-md-4"> Margin Money Call : </label>
                    <div class="col-md-2">
                        <label class="radio-inline"><input type="radio" name="IS_MARGIN_MONEY_CALLBACK_" value='Y' <% if (IS_MARGIN_MONEY_CALLBACK_.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="IS_MARGIN_MONEY_CALLBACK_" value='N' <% if (IS_MARGIN_MONEY_CALLBACK_.equals("N")){out.print("checked");}%>>No</label>                        
                    </div>                                                     
                </div>
				
				<div class="form-group">
                    <label class="col-md-4"> Margin Money Eligible  For Adjustment : </label>
                    <div class="col-md-2">
                        <label class="radio-inline"><input type="radio" name="IS_MARGIN_MONEY_ELIGIBLE_FOR_A" value='Y' <% if (IS_MARGIN_MONEY_ELIGIBLE_FOR_A.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="IS_MARGIN_MONEY_ELIGIBLE_FOR_A" value='N' <% if (IS_MARGIN_MONEY_ELIGIBLE_FOR_A.equals("N")){out.print("checked");}%>>No</label>                        
                    </div>
                    
                    <label class="col-md-4"> Whether interest charged on the  corresponding amount of Margin : </label>
                    <div class="col-md-2">
                        <label class="radio-inline"><input type="radio" name="IS_INTEREST_CHARGED" value='Y' <% if (IS_INTEREST_CHARGED.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="IS_INTEREST_CHARGED" value='N' <% if (IS_INTEREST_CHARGED.equals("N")){out.print("checked");}%>>No</label>                        
                    </div>                                                     
                </div>
				
				<div class="form-group">
                    <label class="col-md-4"> Collateral Security  Obtained?  : </label>
                    <div class="col-md-2">
                        <label class="radio-inline"><input type="radio" name="IS_COLLATERAL_SECURITY" value='Y' <% if (IS_COLLATERAL_SECURITY.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="IS_COLLATERAL_SECURITY" value='N' <% if (IS_COLLATERAL_SECURITY.equals("N")){out.print("checked");}%>>No</label>                        
                    </div>
                    
                    <label class="col-md-3"> Value of Collateral  Security : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"  id="VALUE_OF_COLLATERAL_SECURITY" value="<%=VALUE_OF_COLLATERAL_SECURITY%>" name="VALUE_OF_COLLATERAL_SECURITY" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>                                                     
                </div>
                
                <div class="form-group">
                    <label class="col-md-4"> Whether Repayment of  Loan is regular? : </label>
                    <div class="col-md-2">
                        <label class="radio-inline"><input type="radio" name="IS_REPAYMENT_REGULAR" value='Y' <% if (IS_REPAYMENT_REGULAR.equals("Y")){out.print("checked");}%>>Yes</label>
                        <label class="radio-inline"><input type="radio" name="IS_REPAYMENT_REGULAR" value='N' <% if (IS_REPAYMENT_REGULAR.equals("N")){out.print("checked");}%>>No</label>                        
                    </div>
                    
                    <label class="col-md-3"> NPA Period (Year) : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control"  id="NPA_PERIOD" value="<%=NPA_PERIOD%>" onKeyPress="return isNumeric(event)"  name="NPA_PERIOD" placeholder="Enter value" maxlength="5" min="0" required>                  
                    </div>                                                     
                </div>
				
				<div class="form-group">                    
                    <label class="col-md-6"> Outstanding Loan to be released as on PV Date  : </label>
                    <div class="col-md-6">
                        <input type="text" class="form-control" onKeyPress="return isNumeric(event)" id="OUTSTANDING_LOAN_AMOUNT" value="<%=OUTSTANDING_LOAN_AMOUNT%>" name="OUTSTANDING_LOAN_AMOUNT" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div>                                                     
              </div>				
				
				
				<!--<div class="form-group">
                    <label class="col-md-3"> Callback Amount  : </label>
                    <div class="col-md-3">
                        <input type="hidden" class="form-control" onKeyPress="return isNumeric(event)"  id="CALLBACK_AMOUNT" value="<%=CALLBACK_AMOUNT%>" name="CALLBACK_AMOUNT" placeholder="Enter Callback Amount" maxlength="10" min="0" required>                  
                    </div> 
                    <label class="col-md-3"> Callback Reason  : </label>
                    <div class="col-md-3">
						<input class="form-control"  name="CALLBACK_REASON" type="text" id="CALLBACK_REASON" size="50" maxlength="1000" value="<%=CALLBACK_REASON%>" placeholder="Enter Callback Reason"  required>
                    </div>                                                     
                </div>
				
				<div class="form-group">
                    <label class="col-md-3"> Margin Money  Adjustment Amount : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="MARGIN_MONEY_ADJUSTMENT_AMOUNT" onKeyPress="return isNumeric(event)" value="<%=MARGIN_MONEY_ADJUSTMENT_AMOUNT%>" name="MARGIN_MONEY_ADJUSTMENT_AMOUNT" placeholder="Enter value" maxlength="10" min="0" required>                  
                    </div> 
                    <label class="col-md-3"> Margin Money  Adjustment Date : </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control" onClick="javascript:NewCssCal('MARGIN_MONEY_ADJUSTMENT_DATE','ddMMMyyyy')" id="MARGIN_MONEY_ADJUSTMENT_DATE" value="<%=MARGIN_MONEY_ADJUSTMENT_DATE%>" name="MARGIN_MONEY_ADJUSTMENT_DATE" placeholder="" maxlength="50" min="0" required>                  
                    </div>                                                     
                </div>	-->			
            </div> <br>	
		</div>
      
       
		 
        
				   		
        
			
    <div class="step-footer" align="center" style="position:inherit;" id="myFooter">
      <button type="button" data-step-action="prev" class="step-btn">Previous</button>
      <button type="button" data-step-action="next" class="step-btn">Next</button>
	 <!-- <input name="Button" type="button" class="step-btn" onClick="form_submit()" value="Finish">-->
     <button type="button" data-step-action="finish" onClick="form_submit()" class="step-btn">Final Submit</button>
    </div>
</div>
</div>
<% if (ins.equals("I")){


	  PMEGPGEOTAGID =(String) request.getParameter("PMEGPGEOTAGID")==null?"":(String) request.getParameter("PMEGPGEOTAGID");
      LATITUDE =(String) request.getParameter("LATITUDE")==null?"":(String) request.getParameter("LATITUDE");
      UNIT_ADDRESS =(String) request.getParameter("UNIT_ADDRESS")==null?"":(String) request.getParameter("UNIT_ADDRESS");
      LONGITUDE =(String) request.getParameter("LONGITUDE")==null?"":(String) request.getParameter("LONGITUDE");
      MARGIN_MONEY_ADJUSTMENT_AMOUNT =(String) request.getParameter("MARGIN_MONEY_ADJUSTMENT_AMOUNT")==null?"":(String) request.getParameter("MARGIN_MONEY_ADJUSTMENT_AMOUNT");
      PERIOD_OF_INTEREST =(String) request.getParameter("PERIOD_OF_INTEREST")==null?"":(String) request.getParameter("PERIOD_OF_INTEREST");
      RATE_OF_INTEREST =(String) request.getParameter("RATE_OF_INTEREST")==null?"":(String) request.getParameter("RATE_OF_INTEREST");
      REPAYMENT_PERIOD =(String) request.getParameter("REPAYMENT_PERIOD")==null?"":(String) request.getParameter("REPAYMENT_PERIOD");
      CGTMSE_COVERAGE = (String) request.getParameter("CGTMSE_COVERAGE")==null?"":(String) request.getParameter("CGTMSE_COVERAGE");
      CALLBACK_REASON =(String) request.getParameter("CALLBACK_REASON")==null?"":(String) request.getParameter("CALLBACK_REASON");
      VALUE_OF_COLLATERAL_SECURITY =(String) request.getParameter("VALUE_OF_COLLATERAL_SECURITY")==null?"":(String) request.getParameter("VALUE_OF_COLLATERAL_SECURITY");
      TDR_NUMBER =(String) request.getParameter("TDR_NUMBER")==null?"":(String) request.getParameter("TDR_NUMBER");
      OUTSTANDING_LOAN_AMOUNT =(String) request.getParameter("OUTSTANDING_LOAN_AMOUNT")==null?"":(String) request.getParameter("OUTSTANDING_LOAN_AMOUNT");
      PENDING_LOAN_AMOUNT =(String) request.getParameter("PENDING_LOAN_AMOUNT")==null?"":(String) request.getParameter("PENDING_LOAN_AMOUNT");
      MARGIN_MONEY_ADJUSTMENT_DATE =(String) request.getParameter("MARGIN_MONEY_ADJUSTMENT_DATE")==null?"":(String) request.getParameter("MARGIN_MONEY_ADJUSTMENT_DATE");
      NATURE_OF_COLLATERAL_SECURITY =(String) request.getParameter("NATURE_OF_COLLATERAL_SECURITY")==null?"":(String) request.getParameter("NATURE_OF_COLLATERAL_SECURITY");
       ROI_LOAN =(String) request.getParameter("ROI_LOAN")==null?"":(String) request.getParameter("ROI_LOAN");
      CALLBACK_AMOUNT =(String) request.getParameter("CALLBACK_AMOUNT")==null?"":(String) request.getParameter("CALLBACK_AMOUNT");
      TDR_AMOUNT =(String) request.getParameter("TDR_AMOUNT")==null?"":(String) request.getParameter("TDR_AMOUNT");
      DATE_OF_ISSUE =(String) request.getParameter("DATE_OF_ISSUE")==null?"":(String) request.getParameter("DATE_OF_ISSUE");
      NPA_PERIOD =(String) request.getParameter("NPA_PERIOD")==null?"":(String) request.getParameter("NPA_PERIOD");
       INTEREST_AMOUNT =(String) request.getParameter("INTEREST_AMOUNT")==null?"":(String) request.getParameter("INTEREST_AMOUNT");
      MAIN_PRODUCT =(String) request.getParameter("MAIN_PRODUCT")==null?"":(String) request.getParameter("MAIN_PRODUCT");
      PRESENT_SALES_QUANTITY =(String) request.getParameter("PRESENT_SALES_QUANTITY")==null?"":(String) request.getParameter("PRESENT_SALES_QUANTITY");
      EXPORT_VALUE =(String) request.getParameter("EXPORT_VALUE")==null?"":(String) request.getParameter("EXPORT_VALUE");
      RAW_MATERIAL_IMPORT_COUNTRY =(String) request.getParameter("RAW_MATERIAL_IMPORT_COUNTRY")==null?"":(String) request.getParameter("RAW_MATERIAL_IMPORT_COUNTRY");
      PRESENT_SALES_VALUE =(String) request.getParameter("PRESENT_SALES_VALUE")==null?"":(String) request.getParameter("PRESENT_SALES_VALUE");
      ANNUAL_PRODUCTION_QUANTITY =(String) request.getParameter("ANNUAL_PRODUCTION_QUANTITY")==null?"":(String) request.getParameter("ANNUAL_PRODUCTION_QUANTITY");
      PRESENT_PRODUCTION_VALUE =(String) request.getParameter("PRESENT_PRODUCTION_VALUE")==null?"":(String) request.getParameter("PRESENT_PRODUCTION_VALUE");
      MACHINERY_TYPE =(String) request.getParameter("MACHINERY_TYPE")==null?"":(String) request.getParameter("MACHINERY_TYPE");
      MODE_OF_EXPORT =(String) request.getParameter("MODE_OF_EXPORT")==null?"":(String) request.getParameter("MODE_OF_EXPORT");
      ANNUAL_PRODUCTION_VALUE =(String) request.getParameter("ANNUAL_PRODUCTION_VALUE")==null?"":(String) request.getParameter("ANNUAL_PRODUCTION_VALUE");
      COUNTRY_OF_EXPORT =(String) request.getParameter("COUNTRY_OF_EXPORT")==null?"":(String) request.getParameter("COUNTRY_OF_EXPORT");
      EXPORT_QUANTITY =(String) request.getParameter("EXPORT_QUANTITY")==null?"":(String) request.getParameter("EXPORT_QUANTITY");
      BY_PRODUCT =(String) request.getParameter("BY_PRODUCT")==null?"":(String) request.getParameter("BY_PRODUCT");
      RAW_MATERIAL_DETAILS =(String) request.getParameter("RAW_MATERIAL_DETAILS")==null?"":(String) request.getParameter("RAW_MATERIAL_DETAILS");
      PRESENT_PRODUCTION_QUANTITY =(String) request.getParameter("PRESENT_PRODUCTION_QUANTITY")==null?"":(String) request.getParameter("PRESENT_PRODUCTION_QUANTITY");
      PRODUCTION_SALES_YEAR =(String) request.getParameter("PRODUCTION_SALES_YEAR")==null?"":(String) request.getParameter("PRODUCTION_SALES_YEAR");
      RAW_MATERIAL_IMPORT =(String) request.getParameter("RAW_MATERIAL_IMPORT")==null?"":(String) request.getParameter("RAW_MATERIAL_IMPORT");
      ANNUAL_SALES_VALUE =(String) request.getParameter("ANNUAL_SALES_VALUE")==null?"":(String) request.getParameter("ANNUAL_SALES_VALUE");
      COUNTRY_OF_IMPORT =(String) request.getParameter("COUNTRY_OF_IMPORT")==null?"":(String) request.getParameter("COUNTRY_OF_IMPORT");
      ANNUAL_SALES_QUANTITY =(String) request.getParameter("ANNUAL_SALES_QUANTITY")==null?"":(String) request.getParameter("ANNUAL_SALES_QUANTITY");
        VERIFICATION_STATUS =(String) request.getParameter("VERIFICATION_STATUS")==null?"":(String) request.getParameter("VERIFICATION_STATUS");
      VERIFICATION_BY =(String) request.getParameter("VERIFICATION_BY")==null?"":(String) request.getParameter("VERIFICATION_BY");
      VERIFIER_REMARKS =(String) request.getParameter("VERIFIER_REMARKS")==null?"":(String) request.getParameter("VERIFIER_REMARKS");
        APP_ID =(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
      TOTAL_EMPLOYEES =(String) request.getParameter("TOTAL_EMPLOYEES")==null?"":(String) request.getParameter("TOTAL_EMPLOYEES");
      KVIC_REGISTRATION_NUMBER =(String) request.getParameter("KVIC_REGISTRATION_NUMBER")==null?"":(String) request.getParameter("KVIC_REGISTRATION_NUMBER");
      OTHER_CLEARANCE =(String) request.getParameter("OTHER_CLEARANCE")==null?"":(String) request.getParameter("OTHER_CLEARANCE");
      TRANSGENDER_EMPLOYEES =(String) request.getParameter("TRANSGENDER_EMPLOYEES")==null?"":(String) request.getParameter("TRANSGENDER_EMPLOYEES");
      SC =(String) request.getParameter("SC")==null?"":(String) request.getParameter("SC");
      OBC =(String) request.getParameter("OBC")==null?"":(String) request.getParameter("OBC");
      UNIT_ESTABLISHMENT_DATE =(String) request.getParameter("UNIT_ESTABLISHMENT_DATE")==null?"":(String) request.getParameter("UNIT_ESTABLISHMENT_DATE");
      DATE_OF_WATER_CONNECTION =(String) request.getParameter("DATE_OF_WATER_CONNECTION")==null?"":(String) request.getParameter("DATE_OF_WATER_CONNECTION");
      MALE_EMPLOYEES =(String) request.getParameter("MALE_EMPLOYEES")==null?"":(String) request.getParameter("MALE_EMPLOYEES");
      FULLTIME_EMPLOYEES =(String) request.getParameter("FULLTIME_EMPLOYEES")==null?"":(String) request.getParameter("FULLTIME_EMPLOYEES");
      PHYSICALLY_CHALLENGED_EMPLOYEE =(String) request.getParameter("PHYSICALLY_CHALLENGED_EMPLOYEE")==null?"":(String) request.getParameter("PHYSICALLY_CHALLENGED_EMPLOYEE");
      KVIC_REGISTRATION_DATE =(String) request.getParameter("KVIC_REGISTRATION_DATE")==null?"":(String) request.getParameter("KVIC_REGISTRATION_DATE");
      MINORITY =(String) request.getParameter("MINORITY")==null?"":(String) request.getParameter("MINORITY");
      GST_REGISTRATION_NUMBER =(String) request.getParameter("GST_REGISTRATION_NUMBER")==null?"":(String) request.getParameter("GST_REGISTRATION_NUMBER");
      PART_TIME_EMPLOYEES =(String) request.getParameter("PART_TIME_EMPLOYEES")==null?"":(String) request.getParameter("PART_TIME_EMPLOYEES");
      REGISTERED_BRAND_NAME =(String) request.getParameter("REGISTERED_BRAND_NAME")==null?"":(String) request.getParameter("REGISTERED_BRAND_NAME");
      UDYAM_REGISTRATION_NUMBER =(String) request.getParameter("UDYAM_REGISTRATION_NUMBER")==null?"":(String) request.getParameter("UDYAM_REGISTRATION_NUMBER");
      UNIT_SETUP_ON =(String) request.getParameter("UNIT_SETUP_ON")==null?"":(String) request.getParameter("UNIT_SETUP_ON");
      ST =(String) request.getParameter("ST")==null?"":(String) request.getParameter("ST");
      UNIT_NAME =(String) request.getParameter("UNIT_NAME")==null?"":(String) request.getParameter("UNIT_NAME");
      DATE_OF_ELECTRIC_CONNECTION =(String) request.getParameter("DATE_OF_ELECTRIC_CONNECTION")==null?"":(String) request.getParameter("DATE_OF_ELECTRIC_CONNECTION");
      HANDHOLDING_DETAILS =(String) request.getParameter("HANDHOLDING_DETAILS")==null?"":(String) request.getParameter("HANDHOLDING_DETAILS");
      UDYAM_REGISTRATION_DATE =(String) request.getParameter("UDYAM_REGISTRATION_DATE")==null?"":(String) request.getParameter("UDYAM_REGISTRATION_DATE");
      PRODUCTION_COMMENCEMENT_DATE =(String) request.getParameter("PRODUCTION_COMMENCEMENT_DATE")==null?"":(String) request.getParameter("PRODUCTION_COMMENCEMENT_DATE");
      PATENT_OWNERSHIP =(String) request.getParameter("PATENT_OWNERSHIP")==null?"":(String) request.getParameter("PATENT_OWNERSHIP");
      PAN_OR_TAN_NUMBER =(String) request.getParameter("PAN_OR_TAN_NUMBER")==null?"":(String) request.getParameter("PAN_OR_TAN_NUMBER");
      CERTIFICATION =(String) request.getParameter("CERTIFICATION")==null?"":(String) request.getParameter("CERTIFICATION");
      POLLUTION_CLEARANCE_BOARD =(String) request.getParameter("POLLUTION_CLEARANCE_BOARD")==null?"":(String) request.getParameter("POLLUTION_CLEARANCE_BOARD");
      SEASONAL_EMPLOYEES =(String) request.getParameter("SEASONAL_EMPLOYEES")==null?"":(String) request.getParameter("SEASONAL_EMPLOYEES");
      SEMI_SKILLED_EMPLOYEES =(String) request.getParameter("SEMI_SKILLED_EMPLOYEES")==null?"":(String) request.getParameter("SEMI_SKILLED_EMPLOYEES");
      SKILLED_EMPLOYEES =(String) request.getParameter("SKILLED_EMPLOYEES")==null?"":(String) request.getParameter("SKILLED_EMPLOYEES");
      GST_REGISTRATION_DATE =(String) request.getParameter("GST_REGISTRATION_DATE")==null?"":(String) request.getParameter("GST_REGISTRATION_DATE");
      UNSKILLED_EMPLOYEES =(String) request.getParameter("UNSKILLED_EMPLOYEES")==null?"":(String) request.getParameter("UNSKILLED_EMPLOYEES");
      GENERAL =(String) request.getParameter("GENERAL")==null?"":(String) request.getParameter("GENERAL");
      AVERAGE_WAGES_PAID =(String) request.getParameter("AVERAGE_WAGES_PAID")==null?"":(String) request.getParameter("AVERAGE_WAGES_PAID");
      FEMALE_EMPLOYEES =(String) request.getParameter("FEMALE_EMPLOYEES")==null?"":(String) request.getParameter("FEMALE_EMPLOYEES");
      CAPITAL_COST_OF_BUILDING =(String) request.getParameter("CAPITAL_COST_OF_BUILDING")==null?"":(String) request.getParameter("CAPITAL_COST_OF_BUILDING");
      CAPITAL_COST_OF_MACHINERY =(String) request.getParameter("CAPITAL_COST_OF_MACHINERY")==null?"":(String) request.getParameter("CAPITAL_COST_OF_MACHINERY");
      FINISHED_RAW_MATERIAL_STOCK =(String) request.getParameter("FINISHED_RAW_MATERIAL_STOCK")==null?"":(String) request.getParameter("FINISHED_RAW_MATERIAL_STOCK");
      SEMI_FIN_RM_STOCK =(String) request.getParameter("SEMI_FIN_RM_STOCK")==null?"":(String) request.getParameter("SEMI_FIN_RM_STOCK");
      RAW_MATERIAL_STOCK_VALUE =(String) request.getParameter("RAW_MATERIAL_STOCK_VALUE")==null?"":(String) request.getParameter("RAW_MATERIAL_STOCK_VALUE");
      IS_MARGIN_MONEY_CALLBACK_ =(String) request.getParameter("IS_MARGIN_MONEY_CALLBACK_")==null?"":(String) request.getParameter("IS_MARGIN_MONEY_CALLBACK_");
      IS_MARGIN_MONEY_ELIGIBLE_FOR_A = (String) request.getParameter("IS_MARGIN_MONEY_ELIGIBLE_FOR_A")==null?"":(String) request.getParameter("IS_MARGIN_MONEY_ELIGIBLE_FOR_A");
       TDR_DATE =(String) request.getParameter("TDR_DATE")==null?"":(String) request.getParameter("TDR_DATE");
        IS_INTEREST_CHARGED =(String) request.getParameter("IS_INTEREST_CHARGED")==null?"":(String) request.getParameter("IS_INTEREST_CHARGED");
        IS_REPAYMENT_REGULAR =(String) request.getParameter("IS_REPAYMENT_REGULAR")==null?"":(String) request.getParameter("IS_REPAYMENT_REGULAR");
     IS_COLLATERAL_SECURITY =(String) request.getParameter("IS_COLLATERAL_SECURITY")==null?"":(String) request.getParameter("IS_COLLATERAL_SECURITY");
     DATE_OF_VERIFICATION =(String) request.getParameter("DATE_OF_VERIFICATION")==null?"":(String) request.getParameter("DATE_OF_VERIFICATION");
      PROMINENT_SIGN_BOARD_INSTALLED =(String) request.getParameter("PROMINENT_SIGN_BOARD_INSTALLED")==null?"":(String) request.getParameter("PROMINENT_SIGN_BOARD_INSTALLED");
 PER_CAPITA_INVESTMENT_NORM_SAT=(String) request.getParameter("PER_CAPITA_INVESTMENT_NORM_SAT")==null?"":(String) request.getParameter("PER_CAPITA_INVESTMENT_NORM_SAT");
        VERIFICATION_DATETIME =(String) request.getParameter("VERIFICATION_DATETIME")==null?"":(String) request.getParameter("VERIFICATION_DATETIME");









 StringBuffer qryUpdate = new StringBuffer();
 try{
qryUpdate.append(" UPDATE GEOTAG_TRANS SET  ");

//qryUpdate.append("   LATITUDE = ?,"      );
qryUpdate.append("         UNIT_ADDRESS = ?,"      );
//qryUpdate.append("         LONGITUDE = ?,"      );
//qryUpdate.append("         MARGIN_MONEY_ADJUSTMENT_AMOUNT = ?,"      );
qryUpdate.append("         PERIOD_OF_INTEREST = ?,"      );
qryUpdate.append("         RATE_OF_INTEREST = ?,"      );
qryUpdate.append("         REPAYMENT_PERIOD = ?,"      );
qryUpdate.append("        CGTMSE_COVERAGE = ?,"      );
//qryUpdate.append("         CALLBACK_REASON = ?,"      );
qryUpdate.append("         VALUE_OF_COLLATERAL_SECURITY = ?,"      );
qryUpdate.append("         TDR_NUMBER = ?,"      );
qryUpdate.append("         OUTSTANDING_LOAN_AMOUNT = ?,"      );
qryUpdate.append("         PENDING_LOAN_AMOUNT = ?,"      );
//qryUpdate.append("         MARGIN_MONEY_ADJUSTMENT_DATE = ?,"      );
qryUpdate.append("         NATURE_OF_COLLATERAL_SECURITY = ?,"      );
qryUpdate.append("          ROI_LOAN = ?,"      );
//qryUpdate.append("         CALLBACK_AMOUNT = ?,"      );
qryUpdate.append("         TDR_AMOUNT = ?,"      );
qryUpdate.append("         DATE_OF_ISSUE = ?,"      );
qryUpdate.append("         NPA_PERIOD = ?,"      );
qryUpdate.append("          INTEREST_AMOUNT = ?,"      );
qryUpdate.append("         MAIN_PRODUCT = ?,"      );
qryUpdate.append("         PRESENT_SALES_QUANTITY = ?,"      );
qryUpdate.append("         EXPORT_VALUE = ?,"      );
qryUpdate.append("         RAW_MATERIAL_IMPORT_COUNTRY = ?,"      );
qryUpdate.append("         PRESENT_SALES_VALUE = ?,"      );
qryUpdate.append("         ANNUAL_PRODUCTION_QUANTITY = ?,"      );
qryUpdate.append("         PRESENT_PRODUCTION_VALUE = ?,"      );
qryUpdate.append("         MACHINERY_TYPE = ?,"      );
qryUpdate.append("         MODE_OF_EXPORT = ?,"      );
qryUpdate.append("         ANNUAL_PRODUCTION_VALUE = ?,"      );

qryUpdate.append("         COUNTRY_OF_EXPORT = ?,"      );
qryUpdate.append("         EXPORT_QUANTITY = ?,"      );
qryUpdate.append("         BY_PRODUCT = ?,"      );
qryUpdate.append("         RAW_MATERIAL_DETAILS = ?,"      );


qryUpdate.append("         PRESENT_PRODUCTION_QUANTITY = ?,"      );
qryUpdate.append("         PRODUCTION_SALES_YEAR = ?,"      );

qryUpdate.append("         RAW_MATERIAL_IMPORT = ?,"      );
qryUpdate.append("         ANNUAL_SALES_VALUE = ?,"      );

qryUpdate.append("         COUNTRY_OF_IMPORT = ?,"      );
qryUpdate.append("         ANNUAL_SALES_QUANTITY = ?,"      );
//qryUpdate.append("         VERIFICATION_STATUS = ?,"      );
qryUpdate.append("         VERIFICATION_BY = ?,"      );
qryUpdate.append("         VERIFIER_REMARKS = ?,"      );


qryUpdate.append("         TOTAL_EMPLOYEES = ?,"      );
qryUpdate.append("         KVIC_REGISTRATION_NUMBER = ?,"      );
qryUpdate.append("         OTHER_CLEARANCE = ?,"      );
qryUpdate.append("         TRANSGENDER_EMPLOYEES = ?,"      );
qryUpdate.append("         SC = ?,"      );
qryUpdate.append("         OBC = ?,"      );
qryUpdate.append("         UNIT_ESTABLISHMENT_DATE = ?,"      );
qryUpdate.append("         DATE_OF_WATER_CONNECTION = ?,"      );
qryUpdate.append("         MALE_EMPLOYEES = ?,"      );
qryUpdate.append("         FULLTIME_EMPLOYEES = ?,"      );
qryUpdate.append("         PHYSICALLY_CHALLENGED_EMPLOYEE = ?,"      );
qryUpdate.append("         KVIC_REGISTRATION_DATE = ?,"      );
qryUpdate.append("         MINORITY = ?,"      );
qryUpdate.append("         GST_REGISTRATION_NUMBER = ?,"      );
qryUpdate.append("         PART_TIME_EMPLOYEES = ?,"      );
qryUpdate.append("         REGISTERED_BRAND_NAME = ?,"      );
qryUpdate.append("         UDYAM_REGISTRATION_NUMBER = ?,"      );
qryUpdate.append("         UNIT_SETUP_ON = ?,"      );
qryUpdate.append("         ST = ?,"      );
qryUpdate.append("         UNIT_NAME = ?,"      );
qryUpdate.append("         DATE_OF_ELECTRIC_CONNECTION = ?,"      );
qryUpdate.append("         HANDHOLDING_DETAILS = ?,"      );
qryUpdate.append("         UDYAM_REGISTRATION_DATE = ?,"      );
qryUpdate.append("         PRODUCTION_COMMENCEMENT_DATE = ?,"      );
qryUpdate.append("         PATENT_OWNERSHIP = ?,"      );
qryUpdate.append("         PAN_OR_TAN_NUMBER = ?,"      );
qryUpdate.append("         CERTIFICATION = ?,"      );
qryUpdate.append("         POLLUTION_CLEARANCE_BOARD = ?,"      );
qryUpdate.append("         SEASONAL_EMPLOYEES = ?,"      );
qryUpdate.append("         SEMI_SKILLED_EMPLOYEES = ?,"      );
qryUpdate.append("         SKILLED_EMPLOYEES = ?,"      );
qryUpdate.append("         GST_REGISTRATION_DATE = ?,"      );
qryUpdate.append("         UNSKILLED_EMPLOYEES = ?,"      );
qryUpdate.append("         GENERAL = ?,"      );
qryUpdate.append("         AVERAGE_WAGES_PAID = ?,"      );
qryUpdate.append("         FEMALE_EMPLOYEES = ?,"      );
qryUpdate.append("         CAPITAL_COST_OF_BUILDING = ?,"      );
qryUpdate.append("         CAPITAL_COST_OF_MACHINERY = ?,"      );
qryUpdate.append("         FINISHED_RAW_MATERIAL_STOCK = ?,"      );
qryUpdate.append("         SEMI_FIN_RM_STOCK = ?,"      );
qryUpdate.append("         RAW_MATERIAL_STOCK_VALUE = ?,"      );
qryUpdate.append("         IS_MARGIN_MONEY_CALLBACK_ = ?,"      );
qryUpdate.append("         IS_MARGIN_MONEY_ELIGIBLE_FOR_A = ?, "      );
qryUpdate.append("          TDR_DATE = ?,"      );
qryUpdate.append("           IS_INTEREST_CHARGED = ?,"      );
qryUpdate.append("           IS_REPAYMENT_REGULAR = ?,"      );
qryUpdate.append("        IS_COLLATERAL_SECURITY = ?,"      );
qryUpdate.append("        DATE_OF_VERIFICATION = ?,"      );
qryUpdate.append("         PROMINENT_SIGN_BOARD_INSTALLED = ?, "      );
qryUpdate.append("          PER_CAPITA_INVESTMENT_NORM_SAT= ?, "      );
qryUpdate.append("   VERIFICATION_DATETIME =?,LAST_UPDATE_DT=SYSDATE,MM_ADJUSTMENT_STATUS=NULL, ");
qryUpdate.append(" MM_ADJUSTMENT_AMT_S=NULL,NODAL_OFFICER_REMARK=NULL,DOC_NAME=NULL,");
qryUpdate.append(" ACT_ID=NULL,REMTRID=NULL,MM_ADJ_DATE=NULL,AGENCY_UPLOAD=NULL,");
qryUpdate.append(" AGN_CALLBACK=NULL,BANK_ADJ_DT=NULL,BANK_ADJ_AMT=NULL,BANK_REF_NO=NULL,BANK_REM=NULL  "      );
qryUpdate.append("  WHERE APP_ID=? AND PMEGPGEOTAGID=?  ");

//List values=new ArrayList();
List pstm=new ArrayList();




    //values.add(LATITUDE); pstm.add ("L");
     values.add(UNIT_ADDRESS); pstm.add ("L");
    // values.add(LONGITUDE); pstm.add ("L");
    // values.add(MARGIN_MONEY_ADJUSTMENT_AMOUNT); pstm.add ("L");
     values.add(PERIOD_OF_INTEREST); pstm.add ("L");
     values.add(RATE_OF_INTEREST); pstm.add ("L");
     values.add(REPAYMENT_PERIOD); pstm.add ("L");
     values.add(CGTMSE_COVERAGE); pstm.add ("L");
    // values.add(CALLBACK_REASON); pstm.add ("L");
     values.add(VALUE_OF_COLLATERAL_SECURITY); pstm.add ("L");
     values.add(TDR_NUMBER); pstm.add ("L");
     values.add(OUTSTANDING_LOAN_AMOUNT); pstm.add ("L");
     values.add(PENDING_LOAN_AMOUNT); pstm.add ("L");
    // values.add(MARGIN_MONEY_ADJUSTMENT_DATE); pstm.add ("L");
     values.add(NATURE_OF_COLLATERAL_SECURITY); pstm.add ("L");
      values.add(ROI_LOAN); pstm.add ("L");
    // values.add(CALLBACK_AMOUNT); pstm.add ("L");
     values.add(TDR_AMOUNT); pstm.add ("L");
     values.add(DATE_OF_ISSUE); pstm.add ("L");
     values.add(NPA_PERIOD); pstm.add ("L");
      values.add(INTEREST_AMOUNT); pstm.add ("L");
     values.add(MAIN_PRODUCT); pstm.add ("L");
     values.add(PRESENT_SALES_QUANTITY); pstm.add ("L");
     values.add(EXPORT_VALUE); pstm.add ("L");
     values.add(RAW_MATERIAL_IMPORT_COUNTRY); pstm.add ("L");
     values.add(PRESENT_SALES_VALUE); pstm.add ("L");
     values.add(ANNUAL_PRODUCTION_QUANTITY); pstm.add ("L");
     values.add(PRESENT_PRODUCTION_VALUE); pstm.add ("L");
     values.add(MACHINERY_TYPE); pstm.add ("L");
     values.add(MODE_OF_EXPORT); pstm.add ("L");
     values.add(ANNUAL_PRODUCTION_VALUE); pstm.add ("L");
	
     values.add(COUNTRY_OF_EXPORT); pstm.add ("L");
     values.add(EXPORT_QUANTITY); pstm.add ("L");
     values.add(BY_PRODUCT); pstm.add ("L");
     values.add(RAW_MATERIAL_DETAILS); pstm.add ("L");
	 
     values.add(PRESENT_PRODUCTION_QUANTITY); pstm.add ("L");
     values.add(PRODUCTION_SALES_YEAR); pstm.add ("L");
	
     values.add(RAW_MATERIAL_IMPORT); pstm.add ("L");
     values.add(ANNUAL_SALES_VALUE); pstm.add ("L");
	 
	
     values.add(COUNTRY_OF_IMPORT); pstm.add ("L");
     values.add(ANNUAL_SALES_QUANTITY); pstm.add ("L");
    // values.add(VERIFICATION_STATUS); pstm.add ("L");
     values.add(VERIFICATION_BY); pstm.add ("L");
     values.add(VERIFIER_REMARKS); pstm.add ("L");
      
     values.add(TOTAL_EMPLOYEES); pstm.add ("L");
     values.add(KVIC_REGISTRATION_NUMBER); pstm.add ("L");
     values.add(OTHER_CLEARANCE); pstm.add ("L");
     values.add(TRANSGENDER_EMPLOYEES); pstm.add ("L");
     values.add(SC); pstm.add ("L");
     values.add(OBC); pstm.add ("L");
     values.add(UNIT_ESTABLISHMENT_DATE); pstm.add ("L");
     values.add(DATE_OF_WATER_CONNECTION); pstm.add ("L");
     values.add(MALE_EMPLOYEES); pstm.add ("L");
     values.add(FULLTIME_EMPLOYEES); pstm.add ("L");
     values.add(PHYSICALLY_CHALLENGED_EMPLOYEE); pstm.add ("L");
     values.add(KVIC_REGISTRATION_DATE); pstm.add ("L");
     values.add(MINORITY); pstm.add ("L");
     values.add(GST_REGISTRATION_NUMBER); pstm.add ("L");
     values.add(PART_TIME_EMPLOYEES); pstm.add ("L");
     values.add(REGISTERED_BRAND_NAME); pstm.add ("L");
     values.add(UDYAM_REGISTRATION_NUMBER); pstm.add ("L");
     values.add(UNIT_SETUP_ON); pstm.add ("L");
     values.add(ST); pstm.add ("L");
     values.add(UNIT_NAME); pstm.add ("L");
     values.add(DATE_OF_ELECTRIC_CONNECTION); pstm.add ("L");
     values.add(HANDHOLDING_DETAILS); pstm.add ("L");
     values.add(UDYAM_REGISTRATION_DATE); pstm.add ("L");
     values.add(PRODUCTION_COMMENCEMENT_DATE); pstm.add ("L");
     values.add(PATENT_OWNERSHIP); pstm.add ("L");
     values.add(PAN_OR_TAN_NUMBER); pstm.add ("L");
     values.add(CERTIFICATION); pstm.add ("L");
     values.add(POLLUTION_CLEARANCE_BOARD); pstm.add ("L");
     values.add(SEASONAL_EMPLOYEES); pstm.add ("L");
     values.add(SEMI_SKILLED_EMPLOYEES); pstm.add ("L");
     values.add(SKILLED_EMPLOYEES); pstm.add ("L");
     values.add(GST_REGISTRATION_DATE); pstm.add ("L");
     values.add(UNSKILLED_EMPLOYEES); pstm.add ("L");
     values.add(GENERAL); pstm.add ("L");
     values.add(AVERAGE_WAGES_PAID); pstm.add ("L");
     values.add(FEMALE_EMPLOYEES); pstm.add ("L");
     values.add(CAPITAL_COST_OF_BUILDING); pstm.add ("L");
     values.add(CAPITAL_COST_OF_MACHINERY); pstm.add ("L");
     values.add(FINISHED_RAW_MATERIAL_STOCK); pstm.add ("L");
     values.add(SEMI_FIN_RM_STOCK); pstm.add ("L");
     values.add(RAW_MATERIAL_STOCK_VALUE); pstm.add ("L");
     values.add(IS_MARGIN_MONEY_CALLBACK_); pstm.add ("L");
     values.add(IS_MARGIN_MONEY_ELIGIBLE_FOR_A); pstm.add ("L"); 
      values.add(TDR_DATE); pstm.add ("L");
       values.add(IS_INTEREST_CHARGED); pstm.add ("L");
       values.add(IS_REPAYMENT_REGULAR); pstm.add ("L");
    values.add(IS_COLLATERAL_SECURITY); pstm.add ("L");
    values.add(DATE_OF_VERIFICATION); pstm.add ("L");
     values.add(PROMINENT_SIGN_BOARD_INSTALLED); pstm.add ("L");
      values.add(PER_CAPITA_INVESTMENT_NORM_SAT); pstm.add ("L");
       values.add(VERIFICATION_DATETIME); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
values.clear();
pstm.clear();
}
catch (Exception e) {
out.print (e.toString());
}
    
	  
response.sendRedirect("index.jsp");
}
//out.print(qryUpdate.toString());



    
   
%>

  <script src="js/jquery-steps.min.js"></script>
  <script>      
      
    $('#demo').steps({
      onFinish: function () {
       // alert('Wizard Completed');
      }
    });
  </script>
</form>
</body>
</html>
