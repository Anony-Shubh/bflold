 <%@ page session="true" buffer="500kb" import="java.sql.*,java.util.Date,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon,java.math.*"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>
<head>
<title>PMEGP Bank Data Entry Form</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/inlineMsgMain.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript">


function abc(){
 var rupeesonly=/^\d+\.\d{0,2}$/;
 var numberOnly=/^[0-9]*$/;

 var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
				 
	            var EMI_DT = document.form.EMI_DT.value; 
				//alert(NPA_DT);

 
		if(EMI_DT=="" || EMI_DT=="0"){
	inlineMsg('EMI_DT',"Please Select Date",2);
    return false;
	}
	
		if  (!dtRegex.test(EMI_DT)){
	inlineMsg('EMI_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
	
	
		if((!EMI_DT=="") || (!EMI_DT=="0")){
			
var NO_EMI = document.form.NO_EMI.value; 
var EMI_AMT = document.form.EMI_AMT.value; 
var REMARKS	=document.form.REMARKS.value; 	

if(NO_EMI=="" ){
	inlineMsg('NO_EMI',"Please enter no of emi",2);
    return false;
	}
	if(EMI_AMT==""){
	inlineMsg('EMI_AMT',"Please enter emi amount",2);
    return false;
	}
	if(REMARKS =="" ){
	inlineMsg('REMARKS',"Please enter remarks",2);
    return false;
	}

			
		}

document.form.ins.value='I';
	document.form.submit();

}


</script> 
<style type="text/css">
<!--
.style3 {font-size: 18px}
.style8 {font-size: 17px; }
.style9 {color: #008000; font-size: 17px; }
.style10 {color: #FF0000}
-->
</style>
</head>
 <body>
<form id="form" name="form" method="post">
  <%		
		String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
        String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins"); 
		String IFS_CODE=(String)session.getAttribute("bank_id");
String IFSC_CODE="";
		
String TR_ID="";
String NPA_DT ="";
String NPA_YN ="";
String DISB_AMT="";
String DISB_REF_NO="";
String REMARKS="";
String RTIMESTAMP="";		
String OFF_NAME1="";
String AGENCY_TYPE="";
String DISTRICT_NAME="";
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
String TODAYDT="";
String TDR_ACNO="";
String TDR_ADJ_DT="";
String MM_ADJ_DT="";
String MM_ADJ_AMT ="";
String AADHAR_NO="";
String PAN_NO="";
String E_MAIL="";
String EDP_FR_DT="";
String EDP_TRG_NAME="";
String EDP_TO_DT="";
String EDP_CERT_DT="";
String verror="";
String IST_LOAN_AMT="";
String IST_LOAN_DT="";
		String PROJECT_COST="";
  String   SANCT_AMT="";
  String DISB_TYPE="";
  
  
String EMI_AMT="";
String EMI_DT="";
String NO_EMI ="";
String RNO_EMI ="";
String REMI_AMT ="";
String REMI_DATE ="";
 	
	
		DBCon db= new DBCon();
        db.connect();
        List values=new ArrayList();
        List pstm=new ArrayList();
			 
     
	
	 ResultSet rsMain=db.execSQL(" SELECT  NVL(BD.WORKSHED_COST,0) + NVL(BD.WORKING_CAPITAL,0) + NVL(BD.MACHINARY_COST,0) + NVL(BD.PRE_OPE_COST,0) PROJECT_COST, NVL(BD.CE_SANC_FB,0) + NVL(BD.WC_SANC_FB,0) SANCT_AMT ,BD.IST_LOAN_AMT,to_char(BD.IST_LOAN_DT,'DD-MON-YYYY') IST_LOAN_DT, MOM.OFF_NAME1,BD.EDP_TRG_NAME,TO_CHAR(BD.EDP_FR_DT,'DD-MON-YYYY') AS EDP_FR_DT,BD.TDR_ACNO,TO_CHAR(BD.TDR_ADJ_DT,'DD-MON-YYYY') AS TDR_ADJ_DT,      TO_CHAR(BD.EDP_TO_DT,'DD-MON-YYYY') AS EDP_TO_DT,TO_CHAR(BD.EDP_CERT_DT,'DD-MON-YYYY') AS EDP_CERT_DT,      MOM.AGENCY_TYPE,AD.E_MAIL,AD.AADHAR_NO,AD.PAN_NO,  MD.DISTRICT_NAME,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,  BD.IFSC_CODE,       RBL.BANK_NAME,   RBL.BRANCHNAME, BD.MM_CLAIM_AMT,TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO,      BD.PAY_STATUS,  BD.FB_ACNO,  BD.MM_REL_AMT,TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT  , BD.PACT_ID,BD.APPRV_YN ,     CASE    WHEN BD.PACT_ID = 30    THEN MRT.CO_REMARKS ELSE  BD.FAIL_REASON  END CO_REMARKS     FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  MM_REMARKS_TRANS MRT,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL      WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD      AND BD.REMTRID = MRT.REMTR_ID(+)AND AD.IFSC_CODE= RBL.IFSC_CODE AND BD.MM_CLAIM_AMT   > 0      AND BD.MM_CLAIM_DT IS NOT NULL AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.APP_ID='"+APP_ID+"'  ");
	 

while(rsMain.next())
  {	 
  PROJECT_COST=rsMain.getString("PROJECT_COST")==null?"":rsMain.getString("PROJECT_COST");	
   SANCT_AMT=rsMain.getString("SANCT_AMT")==null?"":rsMain.getString("SANCT_AMT");
		
      	IST_LOAN_AMT=rsMain.getString("IST_LOAN_AMT")==null?"":rsMain.getString("IST_LOAN_AMT");	
		IST_LOAN_DT=rsMain.getString("IST_LOAN_DT")==null?"":rsMain.getString("IST_LOAN_DT");	
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
	  TODAYDT=rsMain.getString("TODAYDT")==null?"":rsMain.getString("TODAYDT");
	  AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
	  PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
	  E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
	  EDP_FR_DT=rsMain.getString("EDP_FR_DT")==null?"":rsMain.getString("EDP_FR_DT");
	  EDP_TRG_NAME=rsMain.getString("EDP_TRG_NAME")==null?"":rsMain.getString("EDP_TRG_NAME");
	  EDP_TO_DT=rsMain.getString("EDP_TO_DT")==null?"":rsMain.getString("EDP_TO_DT");
	  EDP_CERT_DT=rsMain.getString("EDP_CERT_DT")==null?"":rsMain.getString("EDP_CERT_DT");
	  TDR_ACNO=rsMain.getString("TDR_ACNO")==null?"":rsMain.getString("TDR_ACNO");
	  TDR_ADJ_DT=rsMain.getString("TDR_ADJ_DT")==null?"":rsMain.getString("TDR_ADJ_DT");
	  
	
  }
 rsMain.close();
 //Validation query

 %>
   
  
    <table width="100%">
    <tr>
      <th height="23" colspan="6" nowrap><div align="center" class="style29 style39 style3">Installment Details </div></th>
	  <input name="ins" type="hidden" id="ins" value="<%= ins %>   ">
	  <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>   ">
	  <input name="IFS_CODE" type="hidden" id="IFS_CODE" value="<%= IFS_CODE %>   ">
	  </tr>
	  <tr>
      <th colspan="6" ><div align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <input name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %> and Amount in Rs) </div></th>
    </tr>
    <tr>
      <th  ><div align="right">Applicant ID : </div></th>
      <th > <%= APP_ID %> </th>
       <th colspan="3"  ><div align="right">Applicant Name:</div></th>
      <th  ><%= APP_NAME %> </th>
    </tr>
    <tr>
      <th  ><div align="right">Aadhaar Card No: </div></th>
      <th  ><%= AADHAR_NO %></th>
      <th colspan="3"  ><div align="right">MM Claimed:</div></th>
      <th  ><span class="style9"><%= MM_CLAIM_AMT %></span>    </tr>
    <tr>
      <th class="style8"  ><div align="right">Project Cost: </div></th>
      <th class="style9" ><%= PROJECT_COST %></th>
      <th colspan="3" class="style8"  ><div align="right">Sanctioned Amt: </div></th>
      <th class="style9" ><%= SANCT_AMT %></th>
    </tr>
   </table>
  
    <table width="100%">

	   <tr>
        <td colspan="3"></td>
    </tr>
	
       <tr >
         <th colspan="3">Loan Installment Detail </th>
       </tr>
       <tr >
         <th>1)</th>
         <th>EMI Start Date : </th>
         <td><input name="EMI_DT" id="EMI_DT" type="text"  placeholder="DD-MON-YYYY" size="20" maxlength="20" onClick="javascript:NewCssCal('EMI_DT','ddMMMyyyy')" value="<%= EMI_DT%>"></td>
       </tr>
      <tr >
        <th><div align="center">2)</div></th>
        <th>No of EMI : </th>
        <td><input name="NO_EMI" id="NO_EMI" type="text"  size="20" maxlength="10"  value="<%= NO_EMI%>"></td>
      </tr>
      <tr >
        <th>3)</th>
        <th>EMI Amount: </th>
        <td>
		
		<input name="EMI_AMT" id="EMI_AMT" type="text"   size="20" maxlength="10" value="<%= EMI_AMT%>"></td>
      </tr>
	 
	  <tr >
	    <th colspan="3">Revised Loan Installment Detail </th>
      </tr>
	    <tr >
         <th>5)</th>
         <th>EMI Start Date : </th>
         <td><input name="REMI_DATE" id="REMI_DATE" type="text"  placeholder="DD-MON-YYYY" size="20" maxlength="20" onClick="javascript:NewCssCal('REMI_DATE','ddMMMyyyy')" value="<%= REMI_DATE%>"></td>
       </tr>
      <tr >
        <th><div align="center">6)</div></th>
        <th>No of EMI : </th>
        <td><input name="RNO_EMI" id="RNO_EMI" type="text"   size="20" maxlength="20" value="<%= RNO_EMI%>"></td>
      </tr>
      <tr >
        <th>7)</th>
        <th>EMI Amount: </th>
        <td>
		
		<input name="REMI_AMT" id="REMI_AMT" type="text"  size="20" maxlength="10"  value="<%= REMI_AMT%>"></td>
      </tr>
	  <tr >
	    <th colspan="3"> </th>
      </tr>
	  <tr >
        <th>8)</th>
        <th>Remarks (if Any): </th>
        <td>
		<textarea name="REMARKS" cols="80" rows="2" id="REMARKS"><%= REMARKS %></textarea>
		</td>
      </tr>
	  <tr >
	    <th colspan="3"><div align="center">
	      <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="abc();"  value="Add Isntallment Details">
	      </div></th>
      </tr>
    </table>
	
	<%
	
	

   if ((String)request.getParameter("ins")!=null){ //1

					ResultSet rsMax= db.execSQL("SELECT SEQ_LOAN_DISB_DET.NEXTVAL FROM DUAL");
		   while (rsMax.next()) {  //6
           TR_ID=rsMax.getString(1);
           }  rsMax.close();
       
APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
IFS_CODE=request.getParameter("IFS_CODE")==null?"":request.getParameter("IFS_CODE");
REMARKS=request.getParameter("REMARKS")==null?"":request.getParameter("REMARKS");
NO_EMI=request.getParameter("NO_EMI")==null?"":request.getParameter("NO_EMI");
EMI_DT=request.getParameter("EMI_DT")==null?"":request.getParameter("EMI_DT");
EMI_AMT=request.getParameter("EMI_AMT")==null?"":request.getParameter("EMI_AMT");
RNO_EMI=request.getParameter("RNO_EMI")==null?"":request.getParameter("RNO_EMI");
REMI_DATE=request.getParameter("REMI_DATE")==null?"":request.getParameter("REMI_DATE");
REMI_AMT=request.getParameter("REMI_AMT")==null?"":request.getParameter("REMI_AMT");
	
StringBuffer sb = new StringBuffer();
 





sb.append(" INSERT INTO LOAN_INST_DETAIL (INSTR_ID,APP_ID,EMI_DT,IFSC_CODE,REMARKS,RTIMESTAMP,NO_EMI,EMI_AMT,RNO_EMI,REMI_DATE,REMI_AMT) VALUES (?,?,?,?,?,SYSDATE,?,?,?,?,?) ");           


	
  values.add(TR_ID);pstm.add("D");
  values.add(APP_ID);pstm.add("D");
  values.add(EMI_DT);pstm.add("D");
  values.add(IFS_CODE);pstm.add("D");
  values.add(REMARKS);pstm.add("D");
  values.add(NO_EMI);pstm.add("D");
  values.add(EMI_AMT);pstm.add("D");
  values.add(RNO_EMI);pstm.add("D");
  values.add(REMI_DATE);pstm.add("D");
  values.add(REMI_AMT);pstm.add("D");
  


try{
			db.setSqlValue(sb.toString());
			db.setValues(values,pstm);
			db.executeUpdate() ;
		//	out.print(qry.toString());
	}catch(Exception e) { 
	
	out.print(e.toString()); 
	}
		pstm.clear();
    values.clear();	

response.sendRedirect("LoanInstDetail.jsp?APP_ID="+APP_ID);


  }


	%>
	
	
	  <table align="center"  width="100%" class="display" id="example">
    <thead>
      
      <tr>
        <td colspan="6"><div align="center" class="GreenLebel"> Installment  Detail </div></td>
      </tr>
      <tr>
        <th><div align="left">Sr.No</div></th>
        <th><div align="left">EMI Start Date</div></th>
        <th><div align="left">No of EMI </div></th>
       <th><div align="left">EMI Amt</div></th>
        <th><div align="left">Revised EMI Start Date</div></th>
		 <th><div align="left">Revised No of EMI </div></th>
		  <th><div align="left">Revised EMI Amt</div></th>
		  <th><div align="left">Remarks</div></th>
        <th>          </th>
      </tr>
    <thead>
 <tbody>
	 
      <%


			 

	  

		
  
String TINSTR_ID = "";
String TAPP_ID = "";
String TEMI_DT = "";
String TIFSC_CODE = "";
String TREMARKS = "";
String TNO_EMI = "";
String TEMI_AMT= "";
String TRNO_EMI= "";
String TREMI_DATE= "";
String TREMI_AMT= "";

int cnt=0;
          StringBuffer qry = new StringBuffer();
  	 

	

 
 qry.append("  select  INSTR_ID,APP_ID,to_char(EMI_DT,'DD-MON-RRRR') as EMI_DT,IFSC_CODE,REMARKS,RTIMESTAMP,NO_EMI,EMI_AMT,RNO_EMI,to_char(REMI_DATE,'DD-MON-RRRR') as REMI_DATE, REMI_AMT ");
 qry.append("  from LOAN_INST_DETAIL WHERE APP_ID=? ");
values.clear();	
 values.add (APP_ID); 
   
 ResultSet rsMaiNew = db.executeSQL(qry.toString(),values);



 
  while(rsMaiNew.next())
  {
  cnt=cnt+1;
TINSTR_ID=rsMaiNew.getString("INSTR_ID")==null?"":rsMaiNew.getString("INSTR_ID");
TAPP_ID=rsMaiNew.getString("APP_ID")==null?"":rsMaiNew.getString("APP_ID");
TEMI_DT=rsMaiNew.getString("EMI_DT")==null?"":rsMaiNew.getString("EMI_DT");
TIFSC_CODE=rsMaiNew.getString("IFSC_CODE")==null?"":rsMaiNew.getString("IFSC_CODE");
TNO_EMI=rsMaiNew.getString("NO_EMI")==null?"":rsMaiNew.getString("NO_EMI");
TREMARKS=rsMaiNew.getString("REMARKS")==null?"":rsMaiNew.getString("REMARKS");
TEMI_AMT=rsMaiNew.getString("EMI_AMT")==null?"":rsMaiNew.getString("EMI_AMT");
TRNO_EMI=rsMaiNew.getString("RNO_EMI")==null?"":rsMaiNew.getString("RNO_EMI");
TREMI_DATE=rsMaiNew.getString("REMI_DATE")==null?"":rsMaiNew.getString("REMI_DATE");
TREMI_AMT=rsMaiNew.getString("REMI_AMT")==null?"":rsMaiNew.getString("REMI_AMT");

}


	  
	    %>
     
	  <tr>
        <td><div align="left"><%=cnt%></div></td>
        <td><div align="left"><%=TEMI_DT%></div></td>
        <td class="style9"><div align="left"><%=TNO_EMI%></div></td>
       
        <td><div align="left"><%=TEMI_AMT%></div></td>
		<td><div align="left"><%=TREMI_DATE%></div></td>
        <td><div align="left"><%=TRNO_EMI%></div></td>
        <td class="style9"><div align="left"><%=TREMI_AMT%></div></td>
       
        <td><div align="left"><%=TREMARKS%></div></td>
        <td>
		<% if (!TINSTR_ID.equals("")){%>
		<input type="button" id="BUTTON"  class="button"  name="BUTTON" value="DELETE" onClick="DELETETRID('<%= TINSTR_ID %>');">
		<%}%>
		</td>
      </tr>
     
   


 
 
 <%
rsMaiNew.close();
db.close();

 %>
   </tbody>
  </table>
	
</form>

<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
   function DELETETRID(TTR_ID){

  modalWin.ShowURL("DelInsTrans.jsp?TR_ID="+TTR_ID,300,650,'Delete',null,null);

 }
 
function refreshpage() {
   form.submit(); 
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}



</script>
</body>
</html>
