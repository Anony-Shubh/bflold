<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<!DOCTYPE html>
<HTML>
<HEAD>
<META CHARSET="ISO-8859-1">
<TITLE>Bank Form For Physical Verification</TITLE>



 <SCRIPT type="text/javascript">
 

 
 
 
    function  numbersonly(event)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
 
         return true;
      }
</SCRIPT>
<STYLE>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 70%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
input[type=text] {
  width: 100%;
  padding: 8px 14px;
  margin: 8px 0;
  box-sizing: border-box;
}
.buttongreen {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
</STYLE>
<SCRIPT src="../js1/datetimepicker_css.js"></SCRIPT>
<SCRIPT src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT>
function loan_calc2(){
	var ce=document.form.CE_SANC_FB.value;
	var we=document.form.WC_SANC_FB.value;	
	var tcewe=Number(ce)+Number(we);
	document.form.TOT_SANC_FB.value=tcewe;
	//alert(tcewe);
	}
	function loan_calc3(){
	var ce=document.form.CE_DISB_FB.value;
	var we=document.form.WC_DISB_FB.value;	
	var tcewe=Number(ce)+Number(we);
	document.form.TOT_DISB_FB.value=tcewe;
	//alert(tcewe);
	}
	function loan_calc4(){
	var ce=document.form.TOT_SANC_FB.value;
	var we=document.form.TOT_DISB_FB.value;	
	var tcewe=Number(ce)-Number(we);
	document.form.TOT_BAL_FB.value=tcewe;
	//alert(tcewe);
	}
	
	
	function submit_offupdate() {
//int BANK_CONT_NO_L=BANK_CONT_NO.length(); 
//int MOB_NO2=MOB_NO1.length(); 
 var BANK_CONT_NO=document.form.BANK_CONT_NO.value;
 //var BANK_CONT_NO_L=document.form.BANK_CONT_NO_L.value;
 var MOB_NO1=document.form.MOB_NO1.value;
 //var MOB_NO2=document.form.MOB_NO2.value;
 var CE_SANC_FB=document.form.CE_SANC_FB.value;
 var WC_SANC_FB=document.form.WC_SANC_FB.value;
 var TOT_SANC=document.form.TOT_SANC.value;
 var CE_DISB_FB=document.form.CE_DISB_FB.value;
 var WC_DISB_FB=document.form.WC_DISB_FB.value;
 var CC_AVAIL_100PER_YN=document.form.CC_AVAIL_100PER_YN.value;
 var CC_UTILISE_3YR_PER=document.form.CC_UTILISE_3YR_PER.value;
 var RINT=document.form.RINT.value;
 var TDR_ADJ_AMT=document.form.TDR_ADJ_AMT.value;
 var TDR_ADJ_DT=document.form.TDR_ADJ_DT.value;
 var TDR_ACNO=document.form.TDR_ACNO.value;
 var CGTSI=document.form.CGTSI.value;
 var INTCHARGE_ONMM=document.form.INTCHARGE_ONMM.value;
 var COL_SEC_YN=document.form.COL_SEC_YN.value;
 var COL_SEC_AMT=document.form.COL_SEC_AMT.value;
 var REPAY_LOAN_YN=document.form.REPAY_LOAN_YN.value;
 var NPA_YN=document.form.NPA_YN.value;
 var NPA_DT=document.form.NPA_DT.value;
 var UNIT_CUR_STATUS=document.form.UNIT_CUR_STATUS.value;
 var ANNL_PROD=document.form.ANNL_PROD.value;
 var ANNL_SALE=document.form.ANNL_SALE.value;
 var BUSINESS_COM_DT=document.form.BUSINESS_COM_DT.value;
 var ANY_OTH_REMARKS=document.form.ANY_OTH_REMARKS.value;
 var ACT_ID=document.form.ACT_ID.value;

  if (BANK_CONT_NO=="" || BANK_CONT_NO=="0") {
inlineMsg('BANK_CONT_NO',"Bank Contact No Cannot be empty",2);			
return (false);
}
/*
 if ((!BANK_CONT_NO=="") || (!BANK_CONT_NO=="0")) {
if (BANK_CONT_NO_L != 10) {
	
inlineMsg('BANK_CONT_NO_L',"Bank Contact No Not correct",2);			
return (false);
}
}
*/
  if (MOB_NO1=="" || MOB_NO1=="0") {
inlineMsg('MOB_NO1',"Applicant Contact No Cannot be empty",2);			
return (false);
}
/*
 if ((!MOB_NO1=="" || (!MOB_NO1=="0")) {
if (MOB_NO2 != 10) {
	
inlineMsg('MOB_NO2',"Applicant Contact No Not correct",2);			
return (false);
}
}
 */
   if (CE_SANC_FB=="" || CE_SANC_FB=="0" ) {
inlineMsg('CE_SANC_FB',"Term Loan (CE) cannot be empty or 0",2);			
return (false);
}
 
   if (WC_SANC_FB==""|| WC_SANC_FB=="0" ) {
inlineMsg('WC_SANC_FB',"Cash Credit(WC) Cannot be empty or 0",2);			
return (false);
}

/*try {
  if ((Integer.parseInt(CE_SANC_FB)+Integer.parseInt(WC_SANC_FB)) > Integer.parseInt(TOT_SANC) ) {
 //  aerror.add(""+TOT_SANC);
   inlineMsg('TOT_SANC',"Total Projest Cost Mentioned is greater than Actual total sanction:",2);			
return (false);
    
  }
  }catch (Exception n){
  //aerror.add(""+TOT_SANC);
  inlineMsg('TOT_SANC',"Total Projest Cost Mentioned is greater than Actual total sanction:",2);			
return (false);
   }
  */ 
   if (CE_DISB_FB=="" || CE_DISB_FB=="0" ) {
inlineMsg('CE_DISB_FB',"Term Loan Disbursement (CE) cannot be empty or 0",2);			
return (false);
}
 
   if (WC_DISB_FB==""|| WC_DISB_FB=="0" ) {
inlineMsg('WC_DISB_FB',"Cash Credit(WC) Cannot be empty or 0",2);			
return (false);
}
/*
try {
  if ((Integer.parseInt(CE_DISB_FB)+Integer.parseInt(WC_DISB_FB)) > (Integer.parseInt(CE_SANC_FB)+ Integer.parseInt(WC_SANC_FB) )) {
   aerror.add(""+TOT_SANC);   
   inlineMsg('TOT_SANC',"Total Project Cost Disbursed should not be greater than total sanction :",2);			
return (false); 
  }
  }catch (Exception n){
  inlineMsg('TOT_SANC',"Total Project Cost Mentioned is Too Low:",2);			
return (false);
   }
 */  
  if (CC_AVAIL_100PER_YN=="") {
inlineMsg('CC_AVAIL_100PER_YN',"Whether Unit has availed 100% of Cash Credit (WC) Cannot be empty",2);			
return (false);
}
 if (CC_AVAIL_100PER_YN=="N") {
  if (CC_UTILISE_3YR_PER=="") {
inlineMsg('CC_UTILISE_3YR_PER',"Average Cash Credit availed during last 3 years Cannot be empty",2);			
return (false);
}
}
 
 
 
   if (RINT=="" || RINT=="0") {
inlineMsg('RINT',"Rate of Intrest Cannot be empty",2);			
return (false);
}
  if (TDR_ADJ_AMT=="" || TDR_ADJ_AMT=="0") {
inlineMsg('TDR_ADJ_AMT',"TDR Adjustment amount Cannot be empty",2);			
return (false);
}
  if (TDR_ADJ_DT=="" || TDR_ADJ_DT=="0")  {
inlineMsg('TDR_ADJ_DT',"TDR Adjustment Date Cannot be empty",2);			
return (false);
}
  if (TDR_ACNO=="" ) {
inlineMsg('TDR_ACNO',"TDR Adjustment  No Cannot be empty",2);			
return (false);
}
 /*  if (CGTSI=="") {
inlineMsg('CGTSI',"CGTMSE Coverage cannot  be empty",2);			
return (false);
}
  if (INTCHARGE_ONMM=="") {
inlineMsg('INTCHARGE_ONMM',"Interest Charged Cannot be empty",2);			
return (false);
}*/
  if (COL_SEC_YN=="") {
inlineMsg('COL_SEC_YN',"Collateral Security Cannot be empty",2);			
return (false);
}
  if (COL_SEC_YN=="Y") {
  if (COL_SEC_AMT=="" || COL_SEC_AMT=="0") {
inlineMsg('COL_SEC_AMT',"Collateral Security amount Cannot be empty",2);			
return (false);
}
 }
 
    if (REPAY_LOAN_YN=="") {
inlineMsg('REPAY_LOAN_YN',"Repayment of Loan  Cannot be empty",2);			
return (false);
}
  if (NPA_YN=="") {
inlineMsg('NPA_YN',"Unit comes under NPA Cannot be empty",2);			
return (false);
}
 if (NPA_YN=="Y") {
  if (NPA_DT=="") {
inlineMsg('NPA_DT',"NPA Date Cannot be empty",2);			
return (false);
}
}
  if (UNIT_CUR_STATUS=="") {
inlineMsg('UNIT_CUR_STATUS',"Unit Status Cannot be empty",2);			
return (false);
}
if (UNIT_CUR_STATUS=="W") {

   if (ANNL_PROD=="" || ANNL_PROD=="0") {
inlineMsg('ANNL_PROD',"Annual Turnover (production)of the Unit Cannot be empty",2);			
return (false);
}
  if (ANNL_SALE=="" || ANNL_SALE=="0") {
inlineMsg('ANNL_SALE',"Annual Turnover(sales) of the Unit Cannot be empty",2);			
return (false);
}
  if (BUSINESS_COM_DT=="") {
inlineMsg('BUSINESS_COM_DT',"Date of Commencement of Business Cannot be empty",2);			
return (false);
}
}
  if (ANY_OTH_REMARKS=="") {
inlineMsg('ANY_OTH_REMARKS',"Remarks Cannot be empty",2);			
return (false);
} 
 
 if (ACT_ID=="") {
inlineMsg('ACT_ID',"Self Declaration Cannot be empty",2);			
return (false);
}

 
document.form.ins.value='I'; 
document.form.submit(); 

 }
	
</SCRIPT>
</HEAD>
<BODY onLoad="loan_calc2();loan_calc3();loan_calc4();">
<H1 align="center">Bank Form for PMEGP Physical Verification</H1>
<FORM name="form" method="post" action="validate.jsp" id="form">
<%
DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
List pstm=new ArrayList();

String TOT_BAL_FB= "";
String BANK_NAME="";
String BANK_ADDRS="";
String BRANCHNAME="";
String IFSC_CODE="";
 String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim(); 
String APP_NAME="";
String BANK_CONT_NO="";
String MOB_NO1="";
String IST_LOAN_AMT="";
String IST_LOAN_DT="";


String CE_SANC_FB="";
String WC_SANC_FB="";
String CE_DISB_FB="";
String WC_DISB_FB="";
String CE_BAL_FB="";
String WC_BAL_FB="";
String CC_AVAIL_100PER_YN="";
String CC_UTILISE_3YR_PER="";
String RINT="";
String MM_REL_DT="";




String MM_REL_AMT="";
String TDR_ADJ_AMT="";
String TDR_ADJ_DT="";
String TDR_ACNO="";
String CGTSI="";
String INTCHARGE_ONMM="";
String COL_SEC_YN="";
String COL_SEC_AMT="";
String REPAY_LOAN_YN="";
String NPA_YN="";



String NPA_DT="";
String UNIT_CUR_STATUS="";
String ANNL_PROD="";
String ANNL_SALE="";
String BUSINESS_COM_DT="";
String ANY_OTH_REMARKS="";
String GPV_ID="";
String ACT_ID="";
String TOT_SANC="";
int srn=0;

 StringBuffer sb= new StringBuffer();
/*
sb.append(" SELECT TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,  AD.APP_ID,  AD.APP_NAME,  AD.MOB_NO1,  RBI.BANK_NAME,  RBI.IFSC_CODE,  RBI.BRANCHNAME, ").
append("   RBI.ADDRESS, decode(RBI.mobno,null,rbi.TEL_NO,RBI.mobno) AS CONTACT_DETAIL,  BD.IST_LOAN_AMT,  TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,  ").
append("   BD.CE_SANC_FB,  BD.WC_SANC_FB,  BD.RINT,  BD.MM_REL_AMT,  TO_CHAR(BD.TDR_ADJ_DT,'DD-MON-RRRR') AS TDR_ADJ_DT, ").
append("   DECODE(GP.TDR_ADJ_AMT,NULL,BD.MM_REL_AMT,GP.TDR_ADJ_AMT) AS TDR_ADJ_AMT,   BD.TDR_ACNO,  BD.CGTSI FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  RBIBANKLIST RBI  ").
append("  WHERE AD.APP_ID   = BD.APP_ID AND AD.IFSC_CODE  = RBI.IFSC_CODE AND BD.PACT_ID   = 34 ").
append("  AND BD.MM_REL_DT IS NOT NULL AND AD.APP_ID     = 'KBDL1718135-2535554' ");*/
sb.append(" SELECT TO_CHAR(BD.MM_REL_DT, 'DD-MON-RRRR') AS MM_REL_DT,").
append("  AD.APP_ID,  AD.APP_NAME,   RBI.BANK_NAME,  RBI.IFSC_CODE,").
append("  RBI.BRANCHNAME,  RBI.ADDRESS,   BD.IST_LOAN_AMT,(NVL(BD.CE_SANC_FB,0)+NVL(BD.WC_SANC_FB,0)) AS TOT_SANC,").
append("  TO_CHAR(BD.IST_LOAN_DT, 'DD-MON-RRRR') AS IST_LOAN_DT,").
append("  DECODE(GP.CE_SANC_FB,NULL,BD.CE_SANC_FB,GP.CE_SANC_FB) AS CE_SANC_FB,").
append("  DECODE(GP.WC_SANC_FB,NULL,BD.WC_SANC_FB,GP.WC_SANC_FB) AS WC_SANC_FB,").
append("  DECODE(GP.RINT,NULL,BD.RINT,GP.RINT) AS RINT,").
append("  BD.MM_REL_AMT, TO_CHAR(DECODE(GP.TDR_ADJ_DT,NULL,BD.TDR_ADJ_DT,GP.TDR_ADJ_DT),'DD-MON-RRRR') AS TDR_ADJ_DT,").
append("  DECODE(GP.TDR_ADJ_AMT,NULL,BD.mm_rel_amt,GP.TDR_ADJ_AMT) AS TDR_ADJ_AMT,").
append("  DECODE(GP.TDR_ACNO,NULL,BD.TDR_ACNO,GP.TDR_ACNO) AS TDR_ACNO,").
append("  DECODE(GP.CGTSI,NULL,BD.CGTSI,GP.CGTSI) AS CGTSI, ").
append("  GP.CE_DISB_FB,GP.WC_DISB_FB,GP.TOT_BAL_FB,  GP.CC_AVAIL_100PER_YN,").
append("  GP.CC_UTILISE_3YR_PER,  GP.INTCHARGE_ONMM,").
append("  GP.COL_SEC_YN,  GP.COL_SEC_AMT,  GP.REPAY_LOAN_YN,").
append("  GP.NPA_YN,  TO_CHAR(GP.NPA_DT,'DD-MON-RRRR') AS NPA_DT,   GP.ANNL_PROD,  GP.UNIT_CUR_STATUS,  GP.ANNL_SALE,").
append("  TO_CHAR(GP.BUSINESS_COM_DT,'DD-MON-RRRR') AS BUSINESS_COM_DT,   GP.ANY_OTH_REMARKS,  GP.UPDATE_TIMESTAMPDT,").
append("  GP.ACT_ID,  GP.GPV_ID,  DECODE(GP.MOB_NO1,NULL, AD.MOB_NO1,GP.MOB_NO1) AS MOB_NO1,").
append("  DECODE(GP.BANK_PHONE_NO,NULL,RBI.MOBNO,GP.BANK_PHONE_NO) AS CONTACT_DETAIL ").
append(" FROM APP_DETAIL AD,").
 append(" BANK_DATAENTRY BD,").
 append(" RBIBANKLIST RBI,").
 append(" GEOTAG_PVBANKFORM GP  WHERE AD.APP_ID   = BD.APP_ID AND AD.IFSC_CODE  = RBI.IFSC_CODE AND BD.APP_ID     = GP.APP_ID(+)").
append(" AND AD.APP_ID    = '"+APP_ID+"' AND BD.PACT_ID    = 34 AND BD.MM_REL_DT IS NOT NULL ");

//out.print(sb.toString());
ResultSet rsinst = db.execSQL(sb.toString());
while (rsinst.next()) {
srn=srn+1;	
 
 BANK_NAME=rsinst.getString("BANK_NAME")==null?"":rsinst.getString("BANK_NAME");
 BANK_ADDRS=rsinst.getString("ADDRESS")==null?"":rsinst.getString("ADDRESS");
 BRANCHNAME=rsinst.getString("BRANCHNAME")==null?"":rsinst.getString("BRANCHNAME");
 IFSC_CODE=rsinst.getString("IFSC_CODE")==null?"":rsinst.getString("IFSC_CODE");
 APP_ID=rsinst.getString("APP_ID")==null?"":rsinst.getString("APP_ID");
 APP_NAME=rsinst.getString("APP_NAME")==null?"":rsinst.getString("APP_NAME");
 BANK_CONT_NO=rsinst.getString("CONTACT_DETAIL")==null?"":rsinst.getString("CONTACT_DETAIL");
 MOB_NO1=rsinst.getString("MOB_NO1")==null?"":rsinst.getString("MOB_NO1");
 IST_LOAN_AMT=rsinst.getString("IST_LOAN_AMT")==null?"":rsinst.getString("IST_LOAN_AMT");
 IST_LOAN_DT=rsinst.getString("IST_LOAN_DT")==null?"":rsinst.getString("IST_LOAN_DT");
 CE_SANC_FB=rsinst.getString("CE_SANC_FB")==null?"":rsinst.getString("CE_SANC_FB");
 WC_SANC_FB=rsinst.getString("WC_SANC_FB")==null?"":rsinst.getString("WC_SANC_FB");
 RINT=rsinst.getString("RINT")==null?"":rsinst.getString("RINT");
 MM_REL_DT=rsinst.getString("MM_REL_DT")==null?"":rsinst.getString("MM_REL_DT");
 MM_REL_AMT=rsinst.getString("MM_REL_AMT")==null?"":rsinst.getString("MM_REL_AMT");
 TDR_ADJ_AMT=rsinst.getString("TDR_ADJ_AMT")==null?"":rsinst.getString("TDR_ADJ_AMT");
 TDR_ADJ_DT=rsinst.getString("TDR_ADJ_DT")==null?"":rsinst.getString("TDR_ADJ_DT");
 TDR_ACNO=rsinst.getString("TDR_ACNO")==null?"":rsinst.getString("TDR_ACNO");
 CGTSI=rsinst.getString("CGTSI")==null?"":rsinst.getString("CGTSI");
 
 
  CE_DISB_FB=rsinst.getString("CE_DISB_FB")==null?"0":rsinst.getString("CE_DISB_FB");
 WC_DISB_FB=rsinst.getString("WC_DISB_FB")==null?"0":rsinst.getString("WC_DISB_FB");
TOT_BAL_FB=rsinst.getString("TOT_BAL_FB")==null?"":rsinst.getString("TOT_BAL_FB");
 CC_AVAIL_100PER_YN=rsinst.getString("CC_AVAIL_100PER_YN")==null?"":rsinst.getString("CC_AVAIL_100PER_YN");
 CC_UTILISE_3YR_PER=rsinst.getString("CC_UTILISE_3YR_PER")==null?"":rsinst.getString("CC_UTILISE_3YR_PER");

 
 
 INTCHARGE_ONMM=rsinst.getString("INTCHARGE_ONMM")==null?"":rsinst.getString("INTCHARGE_ONMM");
 COL_SEC_YN=rsinst.getString("COL_SEC_YN")==null?"":rsinst.getString("COL_SEC_YN");
 COL_SEC_AMT=rsinst.getString("COL_SEC_AMT")==null?"":rsinst.getString("COL_SEC_AMT");
 REPAY_LOAN_YN=rsinst.getString("REPAY_LOAN_YN")==null?"":rsinst.getString("REPAY_LOAN_YN");
 NPA_YN=rsinst.getString("NPA_YN")==null?"":rsinst.getString("NPA_YN");



 NPA_DT=rsinst.getString("NPA_DT")==null?"":rsinst.getString("NPA_DT");
 UNIT_CUR_STATUS=rsinst.getString("UNIT_CUR_STATUS")==null?"":rsinst.getString("UNIT_CUR_STATUS");
 ANNL_PROD=rsinst.getString("ANNL_PROD")==null?"":rsinst.getString("ANNL_PROD");
 ANNL_SALE=rsinst.getString("ANNL_SALE")==null?"":rsinst.getString("ANNL_SALE");
 BUSINESS_COM_DT=rsinst.getString("BUSINESS_COM_DT")==null?"":rsinst.getString("BUSINESS_COM_DT");
 ANY_OTH_REMARKS=rsinst.getString("ANY_OTH_REMARKS")==null?"":rsinst.getString("ANY_OTH_REMARKS");
 //ANY_OTH_REMARKS=rsinst.getString("ANY_OTH_REMARKS")==null?"":rsinst.getString("ANY_OTH_REMARKS");
 GPV_ID=rsinst.getString("GPV_ID")==null?"0":rsinst.getString("GPV_ID");
 ACT_ID=rsinst.getString("ACT_ID")==null?"":rsinst.getString("ACT_ID");
 // ACT_ID=rsinst.getString("ACT_ID")==null?"":rsinst.getString(("ACT_ID");
 TOT_SANC=rsinst.getString("TOT_SANC")==null?"0":rsinst.getString("TOT_SANC");
 
 
 
 out.print(ANY_OTH_REMARKS);
 
}




%>


<TABLE id="customers" align="center">
<TR>
  <TH colspan="7"><DIV align="center">PMEGP Beneficiary Detail </DIV></TH>
  </TR>
<TR>
  <TD><DIV align="center">(1)</DIV></TD>
  <TD colspan="2">Bank Name</TD>
  <TD colspan="4"><INPUT type="hidden"  id="GPV_ID" name="GPV_ID" value="<%=GPV_ID%>"/><INPUT type="HIDDEN"  id="BANK_NAME" name="BANK_NAME" value="<%=BANK_NAME%>"/><%=BANK_NAME%></TD>
</TR>
<TR>
  <TD><DIV align="center">(2)</DIV></TD>
  <TD colspan="2">Bank Address</TD>
  <TD colspan="4"><INPUT type="hidden"  id="BANK_ADDRS" name="BANK_ADDRS" value="<%=BANK_ADDRS%>"/><INPUT type="hidden"  id="TOT_SANC" name="TOT_SANC" value="<%=TOT_SANC%>"/><%=BANK_ADDRS%></TD>
</TR>
<TR>
  <TD><DIV align="center">(3)</DIV></TD>
  <TD colspan="2">Branch Name</TD>
  <TD colspan="4"><INPUT type="hidden"  id="BRANCHNAME" name="BRANCHNAME" value="<%=BRANCHNAME%>"/><%=BRANCHNAME%></TD>
</TR>
<TR>
  <TD><DIV align="center">(4)</DIV></TD>
  <TD colspan="2">IFS Code</TD>
  <TD colspan="4"><INPUT type="hidden"  id="IFSC_CODE" name="IFSC_CODE" value="<%=IFSC_CODE%>"/><%=IFSC_CODE%></TD>
</TR>
<TR>
  <TD><DIV align="center">(5)</DIV></TD>
  <TD colspan="2">Bank Phone No.*</TD>
  <TD colspan="4"><INPUT type="text"  id="BANK_CONT_NO" name="BANK_CONT_NO" maxlength="10" value="<%=BANK_CONT_NO%>"></TD>
</TR>
<TR>
  <TD><DIV align="center">(6)</DIV></TD>
  <TD colspan="2">Beneficiary Name</TD>
  <TD colspan="4"><INPUT type="hidden"  id="APP_NAME" name="APP_NAME" value="<%=APP_NAME%>"/><%=APP_NAME%></TD>
</TR>
<TR>
  <TD><DIV align="center">(7)</DIV></TD>
  <TD colspan="2">Application ID</TD>
  <TD colspan="4"><INPUT type="hidden"  id="APP_ID" name="APP_ID" value="<%=APP_ID%>"/><INPUT type="hidden"  id="ACT_ID" name="ACT_ID" value="<%=ACT_ID%>"/><%=APP_ID%></TD>
</TR>
<TR>
  <TD><DIV align="center">(8)</DIV></TD>
  <TD colspan="2">Beneficiary Contact No.*</TD>
  <TD colspan="4"><INPUT type="text"  name="MOB_NO1" Id="MOB_NO1"  maxlength="10" value="<%=MOB_NO1%>"></TD>
</TR>
<TR>
  <TH colspan="7"><DIV align="center">BANK  DETAIL </DIV></TH>
  </TR>
<TR>
  <TD rowspan="2">&nbsp;</TD>
  <TD colspan="2" rowspan="2">First Installment Release </TD>
  <TD colspan="2">Date</TD>
  <TD colspan="2">Amount (In Rs.) </TD>
</TR>
<TR><INPUT type="hidden"  id="ins" name="ins" value=""/>
  <TD colspan="2"><INPUT type="hidden"  id="IST_LOAN_DT" name="IST_LOAN_DT" value="<%=IST_LOAN_DT%>"/><%=IST_LOAN_DT%></TD>
  <TD colspan="2"><INPUT type="hidden"  id="IST_LOAN_AMT" name="IST_LOAN_AMT" value="<%=IST_LOAN_AMT%>"/><%=IST_LOAN_AMT%></TD>
</TR>
<TR>
  <TD colspan="2">&nbsp;</TD>
  <TD><DIV align="center">Term Loan (CE) (in Rs.) </DIV></TD>
  <TD colspan="2"><DIV align="center">Cash Credit(WC) (in Rs.)</DIV></TD>
  <TD colspan="2"><DIV align="center">Total (in Rs)</DIV></TD>
</TR>
<TR>
  <TD><DIV align="center">(9)</DIV></TD>
  <TD>Total Loan Sanctioned (A) </TD>
  <TD><INPUT type="text"  name="CE_SANC_FB" id="CE_SANC_FB" value="<%=CE_SANC_FB%>" onKeyPress="return numbersonly(event);"></TD>
  <TD colspan="2"><INPUT type="text"  name="WC_SANC_FB" id="WC_SANC_FB" value="<%=WC_SANC_FB%>" onKeyPress="return numbersonly(event);"></TD>
  <TD colspan="2"><INPUT  name="TOT_SANC_FB"  id="TOT_SANC_FB" type="text" onBlur="loan_calc2()"  readonly="true"></TD>
</TR>
<TR>
  <TD><DIV align="center">(10)</DIV></TD>
  <TD>Total Loan Disbursed (B) </TD>
  <TD><INPUT type="text"  name="CE_DISB_FB" id="CE_DISB_FB" value="<%=CE_DISB_FB%>" onKeyPress="return numbersonly(event);"></TD>
  <TD colspan="2"><INPUT type="text"  name="WC_DISB_FB" id="WC_DISB_FB" value="<%=WC_DISB_FB%>" onKeyPress="return numbersonly(event);"></TD>
  <TD colspan="2"><INPUT  name="TOT_DISB_FB" id="TOT_DISB_FB" value="" type="text" onBlur="loan_calc3()" readonly="true"></TD>
</TR>
<TR>
  <TD><DIV align="center">(11)</DIV></TD>
  <TD colspan="4">Balance Loan to be Disbursed to Beneficiary (A-B) </TD>
  <TD colspan="2"><INPUT type="text"  name="TOT_BAL_FB" id="TOT_BAL_FB" value="<%=TOT_BAL_FB%>" onBlur="loan_calc4()"readonly="true"></TD>
</TR>
<TR>
  <TD rowspan="2"><DIV align="center">(12)</DIV></TD>
  <TD colspan="2"><P>Whether Unit has availed 100% of Cash Credit (WC) </P>    </TD>
  <TD colspan="4"><INPUT type="radio" name="CC_AVAIL_100PER_YN" id="CC_AVAIL_100PER_YN_Y" class="check3"  value="Y" <% if (CC_AVAIL_100PER_YN.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <INPUT type="radio" name="CC_AVAIL_100PER_YN" id="CC_AVAIL_100PER_YN_N" class="check3"  value="N" <% if (CC_AVAIL_100PER_YN.equals("N")) {out.print("CHECKED");} %> />
No</TD>
</TR>
<TR>
  <TD colspan="2">If No, then Average Cash Credit availed during last 3 years (in %) </TD>
  <TD><INPUT type="text"  name="CC_UTILISE_3YR_PER" id="CC_UTILISE_3YR_PER" value="<%=CC_UTILISE_3YR_PER%>"></TD>
  <TD>&nbsp;</TD>
  <TD>%</TD>
  <TD>&nbsp;</TD>
</TR>

<TR>
  <TD><DIV align="center">(13)</DIV></TD>
  <TD colspan="2">Rate of Interest*</TD>
  <TD colspan="4"><INPUT type="text"  name="RINT" id="RINT" value="<%=RINT%>"></TD>
</TR>
<TR>
  <TD rowspan="2"><DIV align="center">(14)</DIV></TD>
  <TD colspan="2" rowspan="2">Govt. Subsidy (Margin Money) Received</TD>
  <TD colspan="2">Date</TD>
  <TD colspan="2">Amount</TD>
</TR>
<TR>
  <TD colspan="2"><INPUT type="hidden"  id="MM_REL_DT" name="MM_REL_DT" value="<%=MM_REL_DT%>"/><%=MM_REL_DT%></TD>
  <TD colspan="2"><INPUT type="hidden"  id="MM_REL_AMT" name="MM_REL_AMT" value="<%=MM_REL_AMT%>"/><%=MM_REL_AMT%></TD>
</TR>

<TR>
  <TD rowspan="2"><DIV align="center">(16)</DIV></TD>
  <TD colspan="2" rowspan="2">TDR/Subsidy Reserve Fund </TD>
  <TD><DIV align="center">Date</DIV></TD>
  <TD colspan="2"><DIV align="center">Amount</DIV></TD>
  <TD><DIV align="center">Reference No. </DIV></TD>
</TR>

<TR>
  <TD><INPUT type="text"  name="TDR_ADJ_DT" id="TDR_ADJ_DT" value="<%=TDR_ADJ_DT%>" onClick="javascript:NewCssCal('TDR_ADJ_DT','ddMMMyyyy')"></TD>
  <TD colspan="2"><INPUT type="text"  name="TDR_ADJ_AMT" id="TDR_ADJ_AMT" onKeyPress="return numbersonly(event);" value="<%=TDR_ADJ_AMT%>"></TD>
  <TD><INPUT type="text"  name="TDR_ACNO" value="<%=TDR_ACNO%>"  id="TDR_ACNO"></TD>
</TR>
<TR>
  <TD><DIV align="center">(19)</DIV></TD>
  <TD colspan="2">CGTMSE Coverage*</TD>
  <TD colspan="4"><INPUT type="radio" name="CGTSI" id="CGTSI_Y" class="check3"  value="Y" <% if (CGTSI.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <INPUT type="radio" name="CGTSI" id="CGTSI_N" class="check3"  value="N" <% if (CGTSI.equals("N")) {out.print("CHECKED");} %> />
No </TD>
</TR>
<TR>
  <TD><DIV align="center">(20)</DIV></TD>
  <TD colspan="2">Whether Interest Charged on Correspondind amount of Margin Money*</TD>
  <TD colspan="4"><INPUT type="radio" name="INTCHARGE_ONMM" id="INTCHARGE_ONMM_Y" class="check3"  value="Y" <% if (INTCHARGE_ONMM.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <INPUT type="radio" name="INTCHARGE_ONMM" id="INTCHARGE_ONMM_N" class="check3"  value="N" <% if (INTCHARGE_ONMM.equals("N")) {out.print("CHECKED");} %> />
No
  </TD>
</TR>
<TR>
  <TD><DIV align="center">(21)</DIV></TD>
  <TD colspan="2">Collateral Security obtained*</TD>
  <TD colspan="4"><INPUT type="radio" name="COL_SEC_YN" id="COL_SEC_YN_Y" class="check3"  value="Y" <% if (COL_SEC_YN.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <INPUT type="radio" name="COL_SEC_YN" id="COL_SEC_YN_N" class="check3"  value="N" <% if (COL_SEC_YN.equals("N")) {out.print("CHECKED");} %> />
No
</TD>
</TR>
<TR>

  <TD><DIV align="center">(22)</DIV></TD>
  <TD colspan="2">If Yes, Value of Collateral Security</TD>
  <TD colspan="4"><INPUT type="text"  name="COL_SEC_AMT" id="COL_SEC_AMT" onKeyPress="return numbersonly(event);" value="<%=COL_SEC_AMT%>"></TD>
</TR>
<TR>
  <TD><DIV align="center">(23)</DIV></TD>
  <TD colspan="2">Whether Repayment of Loan is Regular</TD>
  <TD colspan="4"><INPUT type="radio" name="REPAY_LOAN_YN" id="REPAY_LOAN_YN_Y" class="check3"  value="Y" <% if (REPAY_LOAN_YN.equals("Y")) {out.print("CHECKED");} %> />
    Yes
   
   <INPUT type="radio" name="REPAY_LOAN_YN" id="REPAY_LOAN_YN_N" class="check3"  value="N" <% if (REPAY_LOAN_YN.equals("N")) {out.print("CHECKED");} %> />
    No
  </input></TD>
</TR>
<TR>
  <TD rowspan="2"><DIV align="center">(24)</DIV></TD>
  <TD colspan="2">Whether unit comes under NPA?<BR></TD>
  <TD colspan="4"><INPUT type="radio" name="NPA_YN" id="NPA_YN_Y" class="check3"  value="Y" <% if (NPA_YN.equals("Y")) {out.print("CHECKED");} %> />
    Yes
    </input>
      <INPUT type="radio" name="NPA_YN" id="NPA_YN_N" class="check3"  value="N" <% if (NPA_YN.equals("N")) {out.print("CHECKED");} %> />
    No
    </input></TD>
</TR>
<TR>
  <TD colspan="2">
If Yes, NPA w.e.f. Date </TD>
  <TD colspan="4"><INPUT type="text"  name="NPA_DT" value="<%=NPA_DT%>"  id="NPA_DT" onClick="javascript:NewCssCal('NPA_DT','ddMMMyyyy')"></TD>
</TR>

<TR>
  <TH colspan="7"><DIV align="center">UNIT DETAIL </DIV></TH>
  </TR>
<TR>
  <TD><DIV align="center">(25)</DIV></TD>
  <TD colspan="2">Unit Status*</TD>
  <TD colspan="4"> <INPUT type="radio" name="UNIT_CUR_STATUS" id="UNIT_CUR_STATUS1" class="check"  value="W" <% if (UNIT_CUR_STATUS.equals("W")) {out.print("CHECKED");} %> />
Working</TD>
  </TR>
<TR>
  <TD>&nbsp;</TD>
  <TD colspan="2">&nbsp;</TD>
  <TD colspan="4"> <INPUT type="radio" name="UNIT_CUR_STATUS" id="UNIT_CUR_STATUS2" class="check"  value="D" <% if (UNIT_CUR_STATUS.equals("D")) {out.print("CHECKED");} %> />
Not Working/defunct</TD>
  </TR>
<TR>
  <TD>&nbsp;</TD>
  <TD colspan="2">&nbsp;</TD>
  <TD colspan="4"> <INPUT type="radio" name="UNIT_CUR_STATUS" id="UNIT_CUR_STATUS3" class="check"  value="NT" <% if (UNIT_CUR_STATUS.equals("NT")) {out.print("CHECKED");} %> />
Non-Traceable</TD>
  </TR>
<TR>
  <TD>(27)</TD>
  <TD colspan="2">Date of Commencement of Business: </TD>
  <TD colspan="2"><INPUT type="text"  name="BUSINESS_COM_DT" value="<%=BUSINESS_COM_DT%>"  id="BUSINESS_COM_DT" onClick="javascript:NewCssCal('BUSINESS_COM_DT','ddMMMyyyy')"></TD>
  <TD colspan="2">&nbsp;</TD>
</TR>
<TR>
  <TD rowspan="2">(26)</TD>
  <TD colspan="2" rowspan="2">Annual Turnover of the Unit</TD>
  <TD colspan="2"><DIV align="center">Production (in Rs.) </DIV></TD>
  <TD colspan="2"><DIV align="center">Sales (in Rs.) </DIV></TD>
</TR>
<TR>
  <TD colspan="2"><INPUT type="text"  name="ANNL_PROD" value="<%=ANNL_PROD%>"  onKeyPress="return numbersonly(event);" id="ANNL_PROD"></TD>
  <TD colspan="2"><INPUT type="text"  name="ANNL_SALE" value="<%=ANNL_SALE%>"  onKeyPress="return numbersonly(event);" id="ANNL_SALE"></TD>
</TR>

<TR>
  <TD>(28)</TD>
  <TD colspan="2">Any other Remark on the Functioning of the Unit</TD>
  <TD colspan="4"><INPUT type="text"  name="ANY_OTH_REMARKS" id="ANY_OTH_REMARKS" value="<%=ANY_OTH_REMARKS%>"></TD>
</TR>
<TR>
  <TD colspan="7"><LABEL>
    <INPUT type="checkbox" name="ACT_ID" id="ACT_ID" value="-1" checked >
  </LABEL>
    It is hereby declared that all details furnished above are correct as per  PMEGP Scheme guidelines</TD>
</TR>
<TR>
  <TD colspan="7"><DIV align="center"><INPUT type="button" value="Submit" onClick="submit_offupdate();" class="buttongreen"></DIV></TD>
  </TR>
</TABLE>
 

</FORM>
</BODY>
</HTML>