package pmegpgeotag.pmegpgeo;


import java.util.*;
import java.util.Collections;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import pmegpgeotag.pmegpgeo.geoDatamodel;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeType;

public class ApiCallhttpMain {
	
	private static int rowid=0;
	private static List<geoDatamodel> list = new ArrayList<geoDatamodel>();
	 
	  public static void main(String[] args) throws IOException, Exception, SQLException {
	  
	    ApiCallhttpMain em= new ApiCallhttpMain();
	    em.batchUpdateUsingPreparedStatement("1","2021-06-05","2021-06-07");  //2021-06-07
	    
	      
	  }

	  private static void traverse(JsonNode node, int level) {
	      if (node.getNodeType() == JsonNodeType.ARRAY) {
	          traverseArray(node, level);
	      } else if (node.getNodeType() == JsonNodeType.OBJECT) {
	          traverseObject(node, level);
	      } else {
	         throw new RuntimeException("Not yet implemented");
	      }
	  }

	  private static void traverseObject(JsonNode node, int level) {
	      node.fieldNames().forEachRemaining((String fieldName) -> {
	          JsonNode childNode = node.get(fieldName);
	          printNode(childNode, fieldName, level);
	          //for nested object or arrays
	          if (traversable(childNode)) {
	              traverse(childNode, level + 1);
	          }
	      });
	  }

	  private static void traverseArray(JsonNode node, int level) {
	      for (JsonNode jsonArrayNode : node) {
	          printNode(jsonArrayNode, "arrayElement", level);
	          if (traversable(jsonArrayNode)) {
	              traverse(jsonArrayNode, level + 1);
	          }
	      }
	  }

	  private static boolean traversable(JsonNode node) {
	      return node.getNodeType() == JsonNodeType.OBJECT ||
	              node.getNodeType() == JsonNodeType.ARRAY;
	  }

	  private static void printNode(JsonNode node, String keyName, int level) {

			
			 
		  Object APP_ID="";
	         
          Object UNIT_ADDRESS="";
          Object LATITUDE ="";
          Object LONGITUDE  ="";
          Object MEDIA_TYPE ="";
          Object ATTACHMENT_NAME="";
          Object AVERAGE_WAGES_PAID="";
          Object TRANSGENDER_EMPLOYEES="";
          Object FEMALE_EMPLOYEES="";
          Object MALE_EMPLOYEES="";
          Object UDYAM_REGISTRATION_DATE="";
          Object UDYAM_REGISTRATION_NUMBER="";
          Object DATE_OF_ELECTRIC_CONNECTION="";
          Object UNIT_ESTABLISHMENT_DATE="";
          Object DATE_OF_WATER_CONNECTION="";
          Object GENERAL="";
          Object MINORITY="";
          Object OBC="";
          Object SC="";
          Object ST="";
          Object FULLTIME_EMPLOYEES="";
          Object PART_TIME_EMPLOYEES="";
          Object PHYSICALLY_CHALLENGED_EMPLOYEE="";
          Object SEASONAL_EMPLOYEES="";
          Object SEMI_SKILLED_EMPLOYEES="";
          Object SKILLED_EMPLOYEES="";
          Object UNSKILLED_EMPLOYEES="";
          Object TOTAL_EMPLOYEES="";
          Object REGISTERED_BRAND_NAME="";
          Object PRODUCTION_COMMENCEMENT_DATE="";
          Object PATENT_OWNERSHIP="";
          Object GST_REGISTRATION_DATE="";
          Object POLLUTION_CLEARANCE_BOARD="";
          Object HANDHOLDING_DETAILS="";
          Object UNIT_SETUP_ON="";
          Object UNIT_NAME="";
          Object CERTIFICATION="";
          Object GST_REGISTRATION_NUMBER="";
          Object KVIC_REGISTRATION_DATE="";
          Object KVIC_REGISTRATION_NUMBER="";
          Object PAN_OR_TAN_NUMBER="";
          Object OTHER_CLEARANCE="";
          Object NATURE_OF_COLLATERAL_SECURITY="";
          Object CALLBACK_AMOUNT="";
          Object CALLBACK_REASON="";
          Object CGTMSE_COVERAGE="";
          Object VALUE_OF_COLLATERAL_SECURITY="";
          Object DATE_OF_ISSUE="";
          Object INTEREST_AMOUNT="";
          Object IS_COLLATERAL_SECURITY="";
          Object IS_INTEREST_CHARGED="";
          Object IS_MARGIN_MONEY_CALLBACK_="";
          Object IS_MARGIN_MONEY_ELIGIBLE_FOR_A="";
          Object MARGIN_MONEY_ADJUSTMENT_AMOUNT="";
          Object MARGIN_MONEY_ADJUSTMENT_DATE="";
          Object NPA_PERIOD="";
          Object OUTSTANDING_LOAN_AMOUNT="";
          Object PENDING_LOAN_AMOUNT="";
          Object PERIOD_OF_INTEREST="";
          Object IS_REPAYMENT_REGULAR="";
          Object REPAYMENT_PERIOD="";
          Object RATE_OF_INTEREST="";
          Object ROI_LOAN="";
          Object TDR_AMOUNT="";
          Object TDR_DATE="";
          Object TDR_NUMBER="";
          Object EXPORT_QUANTITY ="";
          Object MACHINERY_TYPE="";
          Object EXPORT_VALUE="";
          Object COUNTRY_OF_EXPORT="";
          Object COUNTRY_OF_IMPORT="";
          Object PRESENT_PRODUCTION_QUANTITY="";
          Object PRESENT_PRODUCTION_VALUE="";
          Object RAW_MATERIAL_DETAILS="";
          Object RAW_MATERIAL_IMPORT="";
          Object RAW_MATERIAL_IMPORT_COUNTRY="";
          Object ANNUAL_SALES_VALUE="";
          Object BY_PRODUCT="";
          Object ANNUAL_PRODUCTION_VALUE="";
          Object ANNUAL_PRODUCTION_QUANTITY="";
          Object PRESENT_SALES_QUANTITY="";
          Object PRESENT_SALES_VALUE="";
          Object MODE_OF_EXPORT="";
          Object PRODUCTION_SALES_YEAR="";
          Object MAIN_PRODUCT="";
          Object ANNUAL_SALES_QUANTITY="";
          Object PROMINENT_SIGN_BOARD_INSTALLED="";
          Object VERIFIER_REMARKS="";
          Object VERIFICATION_STATUS="";
          Object PER_CAPITA_INVESTMENT_NORM_SAT="";
          Object DATE_OF_VERIFICATION="";
          Object VERIFICATION_BY="";
          
          Object CAPITAL_COST_OF_BUILDING    ="";                  
          Object  CAPITAL_COST_OF_MACHINERY    ="";                  
          Object  FINISHED_RAW_MATERIAL_STOCK  ="";               
          Object SEMI_FIN_RM_STOCK  ="";                            
          Object RAW_MATERIAL_STOCK_VALUE   ="";                     
          Object  VERIFICATION_DATETIME   ="";                     
          Object LAST_UPDATE_DT    ="";                     
          
          Object MEDIA_URL="";
        
		    
	      if (traversable(node)) {
	         //System.out.printf("%" + (level * 4 - 3) + "s|-- %s=%s type=%s%n", "", keyName, node.toString(), node.getNodeType());

	      } else {
	          Object value = null;
	          if (node.isTextual()) {
	              value = node.textValue();
	          } else if (node.isNumber()) {
	              value = node.numberValue();
	          }//todo add more types
	       // System.out.printf("%" + (level * 4 - 3) + "s|-- %s=%s type=%s%n", "", keyName, value, node.getNodeType());
	         
	         
	          
	          if (keyName.equals("app_id")) {
	        	  rowid=rowid+1;
	        	  list.add( new geoDatamodel(APP_ID, "app_id",value,rowid));
	          }
	          
	          
	           if (keyName.equals("unit_address") ) { 
	        	   
	        	   rowid=rowid+1;
	        	   UNIT_ADDRESS= value ;
	        	   list.add( new geoDatamodel(APP_ID, "unit_address",value,rowid));	  
	        		   
	        		   }
	           if (keyName.equals("latitude") ) {  LATITUDE= value ;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "latitude",value,rowid));	
	           }
	         
	           if (   keyName.equals("longitude")){ LONGITUDE  =value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "longitude",value,rowid));	
	           }
	           if (   keyName.equals("Media Type")){ MEDIA_TYPE =value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Media Type",value,rowid));	
	           }
	           if (   keyName.equals("Attachment Name")){ ATTACHMENT_NAME=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Attachment Name",value,rowid));	
	           }

	           if (   keyName.equals("Average Wages Paid")){ AVERAGE_WAGES_PAID=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Average Wages Paid",value,rowid));	
	           }
	           if (   keyName.equals("Transgender employees")){ TRANSGENDER_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Transgender employees",value,rowid));	
	           }
	           if (   keyName.equals("Female Employees")){ FEMALE_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Female Employees",value,rowid));	
	           }
	           if (   keyName.equals("Male Employees")){ MALE_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Male Employees",value,rowid));	
	           }
	           if (   keyName.equals("UDYAM Registration Date")){ UDYAM_REGISTRATION_DATE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "UDYAM Registration Date",value,rowid));	
	           }
	           if (   keyName.equals("UDYAM Registration Number")){
	        	   UDYAM_REGISTRATION_NUMBER=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "UDYAM Registration Number",value,rowid));	
	           }
	           if (   keyName.equals("Date of Electric Connection")){ DATE_OF_ELECTRIC_CONNECTION=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Date of Electric Connection",value,rowid));	
	           }
	           if (   keyName.equals("Unit Establishment Date")){ UNIT_ESTABLISHMENT_DATE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Unit Establishment Date",value,rowid));	
	           }
	           if (   keyName.equals("Date of Water Connection")){ DATE_OF_WATER_CONNECTION=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Date of Water Connection",value,rowid));	
	           }
	           if (   keyName.equals("General")){ GENERAL=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "General",value,rowid));	
	           }
	           if (   keyName.equals("Minority")){ MINORITY=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Minority",value,rowid));	
	           }
	           if (   keyName.equals("OBC")){ OBC=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "OBC",value,rowid));	
	           }
	           if (   keyName.equals("SC")){ SC=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "SC",value,rowid));	
	           }
	           if (   keyName.equals("ST")){ ST=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "ST",value,rowid));	
	           }
	           if (   keyName.equals("Fulltime Employees")){ FULLTIME_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Fulltime Employees",value,rowid));	
	           }
	           if (   keyName.equals("Part time Employees")){ PART_TIME_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Part time Employees",value,rowid));	
	           }
	           if (   keyName.equals("Physically Challenged Employees")){ PHYSICALLY_CHALLENGED_EMPLOYEE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Physically Challenged Employees",value,rowid));	
	           }
	           if (   keyName.equals("Seasonal Employees")){ SEASONAL_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Seasonal Employees",value,rowid));	
	           }
	           if (   keyName.equals("Semi-skilled Employees")){ SEMI_SKILLED_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Semi-skilled Employees",value,rowid));	
	           }
	           if (   keyName.equals("Skilled Employees")){ SKILLED_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Skilled Employees",value,rowid));	
	           }
	           if (   keyName.equals("Unskilled Employees")){ UNSKILLED_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Unskilled Employees",value,rowid));	
	           }
	           if (   keyName.equals("Total Employees")){ TOTAL_EMPLOYEES=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Total Employees",value,rowid));	
	           }
	           if (   keyName.equals("Registered Brand Name")){ REGISTERED_BRAND_NAME=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Registered Brand Name",value,rowid));	
	           }
	           if (   keyName.equals("Production Commencement Date")){ PRODUCTION_COMMENCEMENT_DATE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Production Commencement Date",value,rowid));	
	           }
	           if (   keyName.equals("Patent Ownership")){ PATENT_OWNERSHIP=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Patent Ownership",value,rowid));	
	           }
	           if (   keyName.equals("GST Registration Date")){ GST_REGISTRATION_DATE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "GST Registration Date",value,rowid));	
	           }
	           if (   keyName.equals("Pollution Clearance Board")){ POLLUTION_CLEARANCE_BOARD=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Pollution Clearance Board",value,rowid));	
	           }
	           if (   keyName.equals("Handholding Details")){ HANDHOLDING_DETAILS=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Handholding Details",value,rowid));	
	           }
	           if (   keyName.equals("Unit Setup on")){ UNIT_SETUP_ON=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Unit Setup on",value,rowid));	
	           }
	           if (   keyName.equals("Unit Name")){ UNIT_NAME=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Unit Name",value,rowid));	
	           }
	           if (   keyName.equals("Certification")){ CERTIFICATION=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Certification",value,rowid));	
	           }
	           if (   keyName.equals("GST Registration Number")){ GST_REGISTRATION_NUMBER=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "GST Registration Number",value,rowid));	
	           }
	           if (   keyName.equals("KVIC Registration Date")){ KVIC_REGISTRATION_DATE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "KVIC Registration Date",value,rowid));	
	           }
	           if (   keyName.equals("KVIC Registration Number")){ KVIC_REGISTRATION_NUMBER=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "KVIC Registration Number",value,rowid));	
	           }
	           if (   keyName.equals("PAN or TAN Number")){ PAN_OR_TAN_NUMBER=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "PAN or TAN Number",value,rowid));	
	           }
	           if (   keyName.equals("Other Clearance")){ OTHER_CLEARANCE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Other Clearance",value,rowid));	
	           }
	           if (   keyName.equals("Nature of Collateral Security")){ 
	        	   NATURE_OF_COLLATERAL_SECURITY=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Nature of Collateral Security",value,rowid));	
	           }
	           if (   keyName.equals("Callback Amount")){ CALLBACK_AMOUNT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Callback Amount",value,rowid));	
	           }
	           if (   keyName.equals("Callback Reason")){ CALLBACK_REASON=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Callback Reason",value,rowid));	
	           }
	           if (   keyName.equals("CGTMSE Coverage")){ CGTMSE_COVERAGE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "CGTMSE Coverage",value,rowid));	
	           }
	           if (   keyName.equals("Value of Collateral Security")){ VALUE_OF_COLLATERAL_SECURITY=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Value of Collateral Security",value,rowid));	
	           }
	           if (   keyName.equals("Date of Issue")){ DATE_OF_ISSUE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Date of Issue",value,rowid));	
	           }
	           if (   keyName.equals("Interest Amount")){ INTEREST_AMOUNT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Interest Amount",value,rowid));	
	           }
	           if (   keyName.equals("Is Collateral Security")){ IS_COLLATERAL_SECURITY=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Is Collateral Security",value,rowid));	
	           }
	           if (   keyName.equals("Is Interest Charged")){ IS_INTEREST_CHARGED=value;
	           rowid=rowid+1;
	           
	           list.add( new geoDatamodel(APP_ID, "Is Interest Charged",value,rowid));	
	           }
	           if (   keyName.equals("Is Margin Money Callback?")){ IS_MARGIN_MONEY_CALLBACK_=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Is Margin Money Callback?",value,rowid));	
	           }
	           if (   keyName.equals("Is Margin Money eligible for Adjustment")){ 
	        	   
	        	   IS_MARGIN_MONEY_ELIGIBLE_FOR_A=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Is Margin Money eligible for Adjustment",value,rowid));	  
	           }
	           if (   keyName.equals("Margin Money Adjustment Amount")){ 
	        	   MARGIN_MONEY_ADJUSTMENT_AMOUNT=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Margin Money Adjustment Amount",value,rowid));	  
	           }
	           if (   keyName.equals("Margin Money Adjustment Date")){ 
	        	   MARGIN_MONEY_ADJUSTMENT_DATE=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Margin Money Adjustment Date",value,rowid));	  
	           }
	           if (   keyName.equals("NPA Period")){ NPA_PERIOD=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "NPA Period",value,rowid));	
	           }
	           if (   keyName.equals("Outstanding Loan Amount")){ 
	        	   OUTSTANDING_LOAN_AMOUNT=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Outstanding Loan Amount",value,rowid));	 
	           }
	           if (   keyName.equals("Pending Loan Amount")){
	        	   PENDING_LOAN_AMOUNT=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Pending Loan Amount",value,rowid));	   
	           }
	           if (   keyName.equals("Period of Interest")){
	        	   PERIOD_OF_INTEREST=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Period of Interest",value,rowid));	   
	           }
	           if (   keyName.equals("Is Repayment Regular")){ 
	        	   IS_REPAYMENT_REGULAR=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Is Repayment Regular",value,rowid));	   
	           }
	           if (   keyName.equals("Repayment Period")){ 
	        	   REPAYMENT_PERIOD=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Repayment Period",value,rowid));	 
	           }
	           if (   keyName.equals("Rate of Interest")){ 
	        	   RATE_OF_INTEREST=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Rate of Interest",value,rowid));	  
	           }
	           if (   keyName.equals("roi_loan")){
	        	   ROI_LOAN=value;
	        	   rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "roi_loan",value,rowid));	
	           }
	           if (   keyName.equals("TDR Amount")){ TDR_AMOUNT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "TDR Amount",value,rowid));	
	           }
	           if (   keyName.equals("TDR Date")){ TDR_DATE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "TDR Date",value,rowid));	
	           }
	           if (   keyName.equals("TDR Number")){ TDR_NUMBER=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "TDR Number",value,rowid));	
	           }
	           if (   keyName.equals("Export Quantity")){ EXPORT_QUANTITY =value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Export Quantity",value,rowid));	 
	           }
	           if (   keyName.equals("Machinery Type")){ MACHINERY_TYPE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Machinery Type",value,rowid));	
	           }
	           if (   keyName.equals("Export Value")){ EXPORT_VALUE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Export Value",value,rowid));	
	           }
	           if (   keyName.equals("Country of Export")){ COUNTRY_OF_EXPORT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Country of Export",value,rowid));	
	           }
	           if (   keyName.equals("Country of Import")){ COUNTRY_OF_IMPORT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Country of Import",value,rowid));	
	           }
	           if (   keyName.equals("Present Production Quantity")){ 
	        	   PRESENT_PRODUCTION_QUANTITY=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Present Production Quantity",value,rowid));	  
	           }
	           if (   keyName.equals("Present Production Value")){ PRESENT_PRODUCTION_VALUE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Present Production Value",value,rowid));	
	           }
	           if (   keyName.equals("Raw Material Details")){ RAW_MATERIAL_DETAILS=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Raw Material Details",value,rowid));	
	           }
	           if (   keyName.equals("Raw Material Import")){ RAW_MATERIAL_IMPORT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Raw Material Import",value,rowid));	
	           }
	           if (   keyName.equals("Raw Material Import Country")){ RAW_MATERIAL_IMPORT_COUNTRY=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Raw Material Import Country",value,rowid));	
	           }
	           if (   keyName.equals("Annual Sales Value")){ ANNUAL_SALES_VALUE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Annual Sales Value",value,rowid));	
	           }
	           if (   keyName.equals("By Product")){ BY_PRODUCT=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "By Product",value,rowid));	
	           }
	           if (   keyName.equals("Annual Production Value")){ ANNUAL_PRODUCTION_VALUE=value;
	           rowid=rowid+1;
	           list.add( new geoDatamodel(APP_ID, "Annual Production Value",value,rowid));	
	           }
	           if (   keyName.equals("Annual Production Quantity")){ 
	        	   ANNUAL_PRODUCTION_QUANTITY=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Annual Production Quantity",value,rowid));	  
	           }
	           if (   keyName.equals("Present Sales Quantity")){ 
	        	   PRESENT_SALES_QUANTITY=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Present Sales Quantity",value,rowid));	
	           }
	           if (   keyName.equals("Present Sales Value")){ 
	        	   PRESENT_SALES_VALUE=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Present Sales Value",value,rowid));	 
	           }
	           if (   keyName.equals("Mode of Export")){
	        	   MODE_OF_EXPORT=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Mode of Export",value,rowid));	  
	           }
	           if (   keyName.equals("Production & Sales Year")){ 
	        	   PRODUCTION_SALES_YEAR=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Production & Sales Year",value,rowid));	  
	           }
	           if (   keyName.equals("Main Product")){
	        	   MAIN_PRODUCT=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Main Product",value,rowid));	  
	           }
	           if (   keyName.equals("Annual Sales Quantity")){
	        	   ANNUAL_SALES_QUANTITY=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Annual Sales Quantity",value,rowid));	 
	           }
	           if (   keyName.equals("Prominent Sign Board Installed")){ 
	        	   
	        	   PROMINENT_SIGN_BOARD_INSTALLED=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Prominent Sign Board Installed",value,rowid));	   
	           }
	           if (   keyName.equals("Verifier Remarks")){ 
	        	   VERIFIER_REMARKS=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Verifier Remarks",value,rowid));	 
	           }
	           if (   keyName.equals("Verification Status")){ 
	        	   VERIFICATION_STATUS=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Verification Status",value,rowid));	  
	           }
	           if (   keyName.equals("Per Capita Investment Norm Satisfied")){        	   
	        	   PER_CAPITA_INVESTMENT_NORM_SAT=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Per Capita Investment Norm Satisfied",value,rowid));	   
	           }
	           if (   keyName.equals("Date of Verification")){ 
	        	   DATE_OF_VERIFICATION=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Date of Verification",value,rowid));	   
	           }
	           if (   keyName.equals("Verification By")){ 
	        	   
	        	   VERIFICATION_BY=value;
	        	   rowid=rowid+1;
	        	   list.add( new geoDatamodel(APP_ID, "Verification By",value,rowid));	   
	           }	
	           
	           

// NEW ADDED


if (   keyName.equals("Capital Cost of Building (Rs.)")){ 
	   
	CAPITAL_COST_OF_BUILDING=value;
	   rowid=rowid+1;
	   list.add( new geoDatamodel(APP_ID, "Capital Cost of Building (Rs.)",value,rowid));	   
}	

if (   keyName.equals("Capital Cost of Machinery (Rs.)")){ 
	   
	CAPITAL_COST_OF_MACHINERY=value;
	   rowid=rowid+1;
	   list.add( new geoDatamodel(APP_ID, "Capital Cost of Machinery (Rs.)",value,rowid));	   
}	

if (   keyName.equals("Finished Raw material Stock Value (Rs.)")){ 
	   
	FINISHED_RAW_MATERIAL_STOCK=value;
	   rowid=rowid+1;
	   list.add( new geoDatamodel(APP_ID, "Finished Raw material Stock Value (Rs.)",value,rowid));	   
}	

if (   keyName.equals("Semi-finished Raw material Stock Value (Rs.)")){ 
	   
	SEMI_FIN_RM_STOCK=value;
	   rowid=rowid+1;
	   list.add( new geoDatamodel(APP_ID, "Semi-finished Raw material Stock Value (Rs.)",value,rowid));	   
}	
	           
if (   keyName.equals("Raw Material Stock Value (Rs.)")){ 
	   
	RAW_MATERIAL_STOCK_VALUE=value;
	   rowid=rowid+1;
	   list.add( new geoDatamodel(APP_ID, "Raw Material Stock Value (Rs.)",value,rowid));	   
}	

if (   keyName.equals("Media URL")){ 
	   
	MEDIA_URL=value;
	   rowid=rowid+1;
	   list.add( new geoDatamodel(APP_ID, "Media URL",value,rowid));	   
}	



	      }
	      
	    
	      
	     
	      
	    
	  }
	  
	  
	  
	    static String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	    static String DB_CONNECTION = "jdbc:oracle:thin:@192.168.50.86:1521:IASDB";
	    static String DB_USER = "PMEGPNEW"; 
	    static String DB_PASSWORD = "PMEGP123";
	 
	   
	    
	    public void batchUpdateUsingPreparedStatement(String APP_ID,String FROMDT,String TODT) throws SQLException, ClassNotFoundException,IOException {
	    	Connection connection = null;
	        Class.forName(DB_DRIVER);
	        connection = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
	    	 
	        int[] result = null;
	        
	        String SQL = "INSERT INTO GEOTAGTEMP (APP_ID,COL_DESC,COL_VAL,ROWNUMB) VALUES(?,?,?,?)"; 
	        // '?' is the placeholder for the parameter
	        
	        apiCallhttp obj = new apiCallhttp();
	        String a =obj.sendGETSync(APP_ID,FROMDT,TODT);
	              	    
	      ObjectMapper objectMapper = new ObjectMapper();
	      JsonNode rootNode = objectMapper.readTree(a);   
	      traverse(rootNode, 1);
	      Collections.reverse(list); 
	        
	        try {
	        	
	        	String SQL_DELETE="Delete from GEOTAGTEMP";
	           
	            
	            PreparedStatement PSDEL = connection.prepareStatement(SQL_DELETE);
	            
	            int row1 = PSDEL.executeUpdate();
	            
	            System.out.println(row1);
	            PSDEL.close();
	            
	            
	            PreparedStatement stmt = connection.prepareStatement(SQL);
	            connection.setAutoCommit(false);
	            
	            Object VAPP_ID="";
	            Object COL_DESC="";
	            Object COL_VAL="";
	            Object ROWNUMB="";
	  	      
	  	      for (geoDatamodel s : list) //Iterates as long as there are elements in the list. An object s is created of type Employee class.
	  	      {
	  	    	  
	  	    	  if (s.getColdesc()=="app_id") { 
	  	    		  VAPP_ID= s.getColval();
	  	    		  
	  	    	  }
	  	          System.out.print("ID, Name and City of the employee are : ");
	  	          System.out.println(VAPP_ID+", "+s.getColdesc()+" , " +s.getColval()+" , " +s.getRowid());
	  	      
	  	        stmt.setString(1, (String) VAPP_ID); // Value for the first parameter, namely 'firstName'
	            stmt.setString(2, (String) s.getColdesc() ); // Value for the second parameter, namely 'lastName'
	            stmt.setObject(3, s.getColval()); 
	            stmt.setInt(4,  s.getRowid()); // Value for the third parameter, namely 'id'
	            stmt.addBatch(); // Add to Batch
	  	      
	  	      }  
	          
	            result = stmt.executeBatch(); // execute the Batch and commit
	            connection.commit();
	        } catch (SQLException e) {
	            connection.rollback();
	            e.printStackTrace();
	        } finally {
	            if (connection != null)
	                connection.close();
	        }
	      //  System.out.println("Number of rows affected: " + result.length);
	    }
	  
	 
	  
	}
