<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
<%@ include file="headerfile.jsp" %>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
</head>
<body>
<br> 
 <form name="form" id="form"  class="form" method="post">
	    <%		
		String IFS_CODE=(String)session.getAttribute("bank_id");
		
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		
		/*
   qrysb.append("  SELECT MOM.OFF_NAME1,  MOM.AGENCY_TYPE, MD.DISTRICT_NAME,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,FGETNEFTIFSCODE(BD.APP_ID) AS IFSC_CODE," );
   qrysb.append("  RBL.BANK_NAME,   RBL.BRANCHNAME, BD.MM_CLAIM_AMT,TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO," );
   qrysb.append("  BD.PAY_STATUS,  BD.FB_ACNO,  BD.MM_REL_AMT,TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT  , BD.PACT_ID,BD.APPRV_YN ," );
   qrysb.append("  CASE    WHEN BD.PACT_ID = 30  AND BD.APPRV_YN='A'   THEN MRT.CO_REMARKS ELSE  BD.FAIL_REASON  END CO_REMARKS" );
   qrysb.append("  FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  MM_REMARKS_TRANS MRT,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL" );
   qrysb.append("  WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD" );
   qrysb.append("  AND BD.REMTRID = MRT.REMTR_ID(+)AND AD.IFSC_CODE= RBL.IFSC_CODE AND BD.MM_CLAIM_AMT   > 0" );
   qrysb.append("  AND BD.MM_CLAIM_DT IS NOT NULL AND BD.LOAN_DOCFNAME IS NOT NULL AND RBL.IFSC_CODE='"+IFS_CODE+"' " );
		*/
		
		
 qrysb.append(" SELECT MOM.OFF_NAME1,  MOM.AGENCY_TYPE, MD.DISTRICT_NAME,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,FGETNEFTIFSCODE(BD.APP_ID) AS IFSC_CODE, BD.MM_CLAIM_AMT as MM_CLAIM_AMT , " );
 qrysb.append("      RBL.BANK_NAME,   RBL.BRANCHNAME, " );
 qrysb.append("      CASE WHEN BD.PBATCH_ID >= 563 THEN " );
 qrysb.append("       BD.MM_REL_AMT-500 " );
 qrysb.append("      ELSE " );
 qrysb.append("       BD.MM_REL_AMT END MM_REL_AMT , " );
 qrysb.append("     CASE WHEN BD.PBATCH_ID >= 563 THEN " );
 qrysb.append("      500 " );
 qrysb.append("      ELSE " );
 qrysb.append("      0 END APP_FEE , " );
 qrysb.append("      TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO, " );
 qrysb.append("      BD.PAY_STATUS,  BD.FB_ACNO,  BD.MM_REL_AMT,TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT  , BD.PACT_ID,BD.APPRV_YN , " );
 qrysb.append("      CASE    WHEN BD.PACT_ID = 30  AND BD.APPRV_YN='A'   THEN MRT.CO_REMARKS ELSE  BD.FAIL_REASON  END CO_REMARKS " );
 qrysb.append("      FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  MM_REMARKS_TRANS MRT,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL " );
 qrysb.append("      WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD " );
 qrysb.append("      AND BD.REMTRID = MRT.REMTR_ID(+)AND AD.IFSC_CODE= RBL.IFSC_CODE AND BD.MM_CLAIM_AMT   > 0 " );
 qrysb.append("      AND BD.MM_CLAIM_DT IS NOT NULL AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.ACT_ID=11 AND RBL.IFSC_CODE='"+IFS_CODE+"'  " );
		

		ResultSet rsMain = db.execSQL(qrysb.toString());		
		
String OFF_NAME1="";
String AGENCY_TYPE="";
String DISTRICT_NAME="";
String APP_ID="";
String APP_NAME="";
String MOB_NO1="";
String IFSC_CODE="";
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
String APP_FEE="";

  
			
        %>

  <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#666666" class="bordered" id="example">
    <thead>
    <tr>
      <th>Sr No </th>
      <th><div align="center">Application ID</div></th>
	  <th><div align="center">Applicant Name</div></th>
	  <th><div align="center">NEFT IFS Code</div></th>
	  <th><div align="center">MM Claim Amt</div></th> 
      <th><div align="center">MM Claim Date</div></th>
      <th><div align="center">Batch Id</div></th>     
      <th><div align="center">Batch Date</div></th>
	  <th><div align="center">UTRN No </div></th>
	  <th><div align="center">MM Disbursement Status</div></th>
	  <th><div align="center">Branch Account No </div></th>
	  <th><div align="center">MM Release Amt</div></th>
	  <th>Application Fee </th>
	  <th><div align="center">MM Release Date</div></th>	  
	  <th>Update</th>
	  <th><div align="center">Fail Disbursement Remarks/ Refer by CO,Mumbai to KVC Field office Remarks</div></th>
      </tr>
	</thead>
	<%
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
	  MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
	  MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
	  PACT_ID=rsMain.getString("PACT_ID")==null?"":rsMain.getString("PACT_ID");
	  CO_REMARKS=rsMain.getString("CO_REMARKS")==null?"":rsMain.getString("CO_REMARKS");
	  APPRV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
	   APP_FEE=rsMain.getString("APP_FEE")==null?"":rsMain.getString("APP_FEE");
	  edpcount=edpcount+1;
	 
			
			%>
			<tr>
	  <td><%= edpcount %></td>
      <td><div align="left"><%= APP_ID %></div></td>	  
	  <td><div align="left"><%= APP_NAME %></div></td>
	  <td><div align="left"><%=IFSC_CODE  %></div></td>      
      <td><div align="left"><%=MM_CLAIM_AMT %></div></td>	  
	  <td><div align="left"><%=MM_CLAIM_DT%></div></td>
	  <td><div align="left"><%=PBATCH_ID  %></div></td>      
      <td><div align="left"><%=BATCH_DATE  %></div></td> 
      <td><div align="left"><%=UTRN_NO %></div></td>		
      <td><div align="left"><%=PAY_STATUS %></div></td>	  
	  <td><div align="left"><%=FB_ACNO %></div></td>
	  <td><div align="left"><%=MM_REL_AMT %></div></td>      
      <td><%= APP_FEE %></td>
      <td><div align="left"><%=MM_REL_DT  %></div></td>     
	  <td>
	  <% if ((PACT_ID.equals("34")) && (APPRV_YN.equals("A"))){ %>
	  <input name="btnBank1" id="btnBank1" type="button" class="button" onClick="ShowNewPage('<%=APP_ID%>','bankDetailUpdation.jsp');"  value="TDR DETAIL" />
	  
	    <input name="btnBank1" id="btnBank1" type="button" class="button" onClick="ShowNewPage('<%=APP_ID%>','DisbDetailUpdation.jsp');"  value="LOAN DISBURSEMENT" />
		<input name="btnBank1" id="btnBank1" type="button" class="button" onClick="ShowNewPage('<%=APP_ID%>','NpaDetailUpdation.jsp');"  value="NPA Details" />
	<%} else if ( PACT_ID.equals("30") && APPRV_YN.equals("A") ) {%>
	<a href="appidSnRef.jsp?APP_ID=<%= APP_ID %>" class="buttonGray"> Reforward Referred  MM Claim	 </a>
	<input name="btnBank1" id="btnBank1" type="button" class="buttonMerun" onClick="ShowNewPage('<%=APP_ID%>','appRet.jsp');"  value="Cancel MM Claim" />
	 <%}	else if (PAY_STATUS.equals("FAILED")){%>
	FAILED
	<%} else {%>
	-
	<%}%>
	</span>	  </td>
      <td><div align="left"><%= CO_REMARKS %></div></td>	  
	 </tr>
	 <% 
	
	}
rsMain.close();
db.close();
	
	 %>	
</table>
  <p>&nbsp;</p>
   <p class="mtextarea"></p>
  <p class="mtextarea">For MM Claim related queries (PMEGP,MUMBAI) contact No: # 022-26713686 and send email to<span class="OrangeLebel"><em>
  <bold>pmegp.kvic@gov.in</bold> </em></span></p>
  <p class="mtextarea">For Govt. Subsidy Release</p>
  <p class="mtextarea">(1) claim before 30th June,2020 contact  ( Corp. Bank) queries contact :022-22835701 ( cb0511@unionbankofindia.com) </p>
  <p class="mtextarea">(2) claim after 30th June,2020 contact (Indian Bank) queries email : pmegp.narimanpoint@indianbank.co.in </p>
  <p>&nbsp;
   </p>
  <p align="center"> 
    <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowNewPage(vappid,filename){
var urlpar=filename+'?APP_ID='+vappid;
var callbackFunctionArray = new Array(refresh_data);

 modalWin.ShowURL(urlpar,750,1100,'View Application',null,null);
 }//end of bank
  function ShowNewPage1(vappid,filename){
var urlpar=filename+'?APP_ID='+vappid;
 var callbackFunctionArray = new Array(refresh_data);

 modalWin.ShowURL(urlpar,750,1100,'View Application',null,null);
 }//end of bank
function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refresh_data() {
   form.submit(); 
}


  </script>
    
</p>
 </form>
</body>
</html>