  <%@page language="java" import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

		<%
		
	String IFSC_CODE=(String)session.getAttribute("bank_id");
	String VERIFYAPP_CNT="";	
		DBCon db= new DBCon();
        db.connect();
		String BR_UPDATE_YN="";
		
        StringBuffer qrysb = new StringBuffer();
   qrysb.append("  SELECT MOM.OFF_NAME1,  MOM.AGENCY_TYPE, MD.DISTRICT_NAME,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,FGETNEFTIFSCODE(BD.APP_ID) AS IFSC_CODE," );
   qrysb.append("  RBL.BANK_NAME,   RBL.BRANCHNAME, BD.MM_CLAIM_AMT,TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO," );
   qrysb.append("  BD.PAY_STATUS,  BD.FB_ACNO, TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT  , BD.PACT_ID,BD.APPRV_YN ,BBM.BR_UPDATE_YN," );
   qrysb.append("      CASE WHEN BD.PBATCH_ID >= 563 THEN " );
 qrysb.append("       BD.MM_REL_AMT-500 " );
 qrysb.append("      ELSE " );
 qrysb.append("       BD.MM_REL_AMT END MM_REL_AMT , " );
 qrysb.append("     CASE WHEN BD.PBATCH_ID >= 563 THEN " );
 qrysb.append("      500 " );
 qrysb.append("      ELSE " );
 qrysb.append("      0 END APP_FEE ,(select  count(*) from indbank_request where " );
 qrysb.append(" substr(txnid,3,length(txnid))=substr(AD.app_id,instr(AD.app_id,'-')+1,length(AD.app_id)) AND UPPER(STATUS) " );
 qrysb.append("  NOT IN ('NOT  FOUND' ,'FAILURE')  and PRODUCTINFO='Margin Money Refund'  ) as verifyapp_cnt, " );
   qrysb.append("  CASE    WHEN BD.PACT_ID = 30  AND BD.APPRV_YN='A'   THEN MRT.CO_REMARKS ELSE  BD.FAIL_REASON  END CO_REMARKS" );
   qrysb.append("  FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  MM_REMARKS_TRANS MRT,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL,BANK_BR_MAST BBM" );
   qrysb.append("  WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD AND AD.ACT_YN='Y' ");
   qrysb.append("  AND BD.REMTRID = MRT.REMTR_ID(+)AND AD.IFSC_CODE= RBL.IFSC_CODE and RBL.ifsc_code=BBM.BR_IFSL_CODE(+) AND BD.MM_CLAIM_AMT   > 0" );
   qrysb.append("  AND BD.MM_CLAIM_DT IS NOT NULL AND BD.LOAN_DOCFNAME IS NOT NULL AND BBM.CIRCLE_IFSC=? " );
		
		
	List values=new ArrayList();
     values.add (IFSC_CODE);	 
	
		//ResultSet rsMain = db.execSQL(qrysb.toString());		
		
String OFF_NAME1="";
String AGENCY_TYPE="";
String DISTRICT_NAME="";
String APP_ID="";
String APP_NAME="";
String MOB_NO1="";
String BANK_NAME="";
String BRANCHNAME="";
String MM_CLAIM_AMT="";
String MM_CLAIM_DT="";
String PBATCH_ID="";
String BATCH_DATE="";
String UTRN_NO="";
String PAY_STATUS="";
String FB_ACNO="";
String MM_REL_AMT="";
String MM_REL_DT="";
String PACT_ID="";
String APPRV_YN="";
String CO_REMARKS="";	
		
		
	try{
JSONArray list = new JSONArray();
ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

out.print ("{ \"data\":");
int edpcount=0;
while(rsMain.next())
  { 	
		
 
      	
	  OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");	
	  AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
	  DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
	  APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	  MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
	  IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
	  BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
	  BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
	  MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
	  MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
	  PBATCH_ID=rsMain.getString("PBATCH_ID")==null?"":rsMain.getString("PBATCH_ID");
	  BATCH_DATE=rsMain.getString("BATCH_DATE")==null?"":rsMain.getString("BATCH_DATE");
	  UTRN_NO=rsMain.getString("UTRN_NO")==null?"":rsMain.getString("UTRN_NO");
	  PAY_STATUS=rsMain.getString("PAY_STATUS")==null?"":rsMain.getString("PAY_STATUS");
	  FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
	  MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"0":rsMain.getString("MM_REL_AMT");
	  MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
	  PACT_ID=rsMain.getString("PACT_ID")==null?"":rsMain.getString("PACT_ID");
	  CO_REMARKS=rsMain.getString("CO_REMARKS")==null?"":rsMain.getString("CO_REMARKS");
	  APPRV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
	  VERIFYAPP_CNT=rsMain.getString("verifyapp_cnt")==null?"0":rsMain.getString("verifyapp_cnt");
	  BR_UPDATE_YN=rsMain.getString("BR_UPDATE_YN")==null?"0":rsMain.getString("BR_UPDATE_YN");
	  edpcount=edpcount+1;		


JSONObject obj=new JSONObject();

 	


 obj.put("SRNO", edpcount);
 obj.put("APP ID", APP_ID);
 
  obj.put("APP NAME", APP_NAME); 
  
   obj.put("IFSCODE", IFSC_CODE);
   
  obj.put("AMOUNT", MM_CLAIM_AMT); 
  
 obj.put("MMDT", MM_CLAIM_DT); 
 
 obj.put("BATCHID",PBATCH_ID);
 

 obj.put("BATCHDATE",BATCH_DATE);
 
  
 
 
	 
	  obj.put("UTRNNO",UTRN_NO);
	 
  
  obj.put("STATUS",PAY_STATUS);
  
  obj.put("ACCNO", FB_ACNO);   
  
	    
	  obj.put("MMRELAMT",MM_REL_AMT);	 
	
  
   
  obj.put("MMRELDT",MM_REL_DT); 
	
	
	
  if ((PACT_ID.equals("34")) && (APPRV_YN.equals("A"))){
	obj.put("UPDATE","<input name=btnBank1 id=btnBank1 type=button class=button style=color:black onClick=ShowNewPage('"+APP_ID+"','bankDetailUpdation.jsp');  value=UPDATE TDR DETAIL />");
	}  else if ( PACT_ID.equals("30") && APPRV_YN.equals("A") )    {  
	obj.put("UPDATE","<a href=appidSnRef.jsp?APP_ID="+APP_ID+" class=greenButtonRound>Resubmit Referred Claim</a> <br>"
	+"<input name=btnBank1 id=btnBank1 type=button class=button style=color:Red onClick=ShowNewPage('"+APP_ID+"','appRet.jsp');  value=CancelMMClaim />"
	);
	}
		else if (PAY_STATUS.equals("FAILED")){
			obj.put("UPDATE","FAILED");
		}
			 else{
	  obj.put("UPDATE","-");
	  }
	
	 
	if	((!MM_REL_AMT.equals("0")) && ((VERIFYAPP_CNT.equals("0") || VERIFYAPP_CNT.equals("")))) { 
obj.put("GENERATE","<A  href=BankPvGenCkBl.jsp?APP_ID="+APP_ID+"&TYPE=R&VERIFYC="+VERIFYAPP_CNT+" class=greenButtonRound>Generate Challan For Refund</A>");
	} else if ((!MM_REL_AMT.equals("0")) && (!VERIFYAPP_CNT.equals("0"))  ) {
obj.put("GENERATE","<DIV align=center><A  href=BankPvGenCkBl.jsp?APP_ID="+APP_ID+" class=greenButtonRound>Verify Payment Status</A></DIV>");	
	  }
	  else{
	  obj.put("GENERATE","-");
	  }
	

			
		 
			
			obj.put("FAILREMARKS",CO_REMARKS);
			
 
  list.add(obj);
  } out.print(list);
		
    out.print ("}");
}
    catch(Exception ex)
    {
        //out.println("<h1>"+ex+"</g1>");
    }

 
 %>
        