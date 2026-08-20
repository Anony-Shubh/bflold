<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<!DOCTYPE html>
<HTML>
<HEAD>
<META CHARSET="ISO-8859-1">
<TITLE>Bank Form For Physical Verification</TITLE>
 <script type="text/javascript">
    function  numbersonly(event)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
 
         return true;
      }
</script>
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

  
document.form.ins.value='I'; 
document.form.submit(); 

 }
	
</SCRIPT>
</HEAD>
<BODY onLoad="loan_calc2();loan_calc3();loan_calc4();">
<H1 align="center">Bank Form for PMEGP Physical Verification</H1>
<form name="form" method="post" action="validate.jsp" id="form">
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


<table id="customers" align="center">
<tr>
  <th colspan="7"><div align="center">PMEGP Beneficiary Detail </div></th>
  </tr>
<tr>
  <td><DIV align="center">(1)</DIV></td>
  <td colspan="2">Bank Name</td>
  <td colspan="4"><INPUT type="hidden"  id="GPV_ID" name="GPV_ID" value="<%=GPV_ID%>"/><INPUT type="HIDDEN"  id="BANK_NAME" name="BANK_NAME" value="<%=BANK_NAME%>"/><%=BANK_NAME%></td>
</tr>
<tr>
  <td><DIV align="center">(2)</DIV></td>
  <td colspan="2">Bank Address</td>
  <td colspan="4"><INPUT type="hidden"  id="BANK_ADDRS" name="BANK_ADDRS" value="<%=BANK_ADDRS%>"/><INPUT type="hidden"  id="TOT_SANC" name="TOT_SANC" value="<%=TOT_SANC%>"/><%=BANK_ADDRS%></td>
</tr>
<tr>
  <td><DIV align="center">(3)</DIV></td>
  <td colspan="2">Branch Name</td>
  <td colspan="4"><INPUT type="hidden"  id="BRANCHNAME" name="BRANCHNAME" value="<%=BRANCHNAME%>"/><%=BRANCHNAME%></td>
</tr>
<tr>
  <td><DIV align="center">(4)</DIV></td>
  <td colspan="2">IFS Code</td>
  <td colspan="4"><INPUT type="hidden"  id="IFSC_CODE" name="IFSC_CODE" value="<%=IFSC_CODE%>"/><%=IFSC_CODE%></td>
</tr>
<tr>
  <td><DIV align="center">(5)</DIV></td>
  <td colspan="2">Bank Phone No.*</td>
  <td colspan="4"><INPUT type="text"  id="BANK_CONT_NO" name="BANK_CONT_NO" maxlength="10" value="<%=BANK_CONT_NO%>"></td>
</tr>
<tr>
  <td><DIV align="center">(6)</DIV></td>
  <td colspan="2">Beneficiary Name</td>
  <td colspan="4"><INPUT type="hidden"  id="APP_NAME" name="APP_NAME" value="<%=APP_NAME%>"/><%=APP_NAME%></td>
</tr>
<tr>
  <td><DIV align="center">(7)</DIV></td>
  <td colspan="2">Application ID</td>
  <td colspan="4"><INPUT type="hidden"  id="APP_ID" name="APP_ID" value="<%=APP_ID%>"/><INPUT type="hidden"  id="ACT_ID" name="ACT_ID" value="<%=ACT_ID%>"/><%=APP_ID%></td>
</tr>
<tr>
  <td><DIV align="center">(8)</DIV></td>
  <td colspan="2">Beneficiary Contact No.*</td>
  <td colspan="4"><INPUT type="text"  name="MOB_NO1" Id="MOB_NO1"  maxlength="10" value="<%=MOB_NO1%>"></td>
</tr>
<tr>
  <th colspan="7"><div align="center">BANK  DETAIL </div></th>
  </tr>
<tr>
  <td rowspan="2">&nbsp;</td>
  <td colspan="2" rowspan="2">First Installment Release </td>
  <td colspan="2">Date</td>
  <td colspan="2">Amount (In Rs.) </td>
</tr>
<tr><INPUT type="hidden"  id="ins" name="ins" value=""/>
  <td colspan="2"><INPUT type="hidden"  id="IST_LOAN_DT" name="IST_LOAN_DT" value="<%=IST_LOAN_DT%>"/><%=IST_LOAN_DT%></td>
  <td colspan="2"><INPUT type="hidden"  id="IST_LOAN_AMT" name="IST_LOAN_AMT" value="<%=IST_LOAN_AMT%>"/><%=IST_LOAN_AMT%></td>
</tr>
<tr>
  <td colspan="2">&nbsp;</td>
  <td><DIV align="center">Term Loan (CE) (in Rs.) </DIV></td>
  <td colspan="2"><DIV align="center">Cash Credit(WC) (in Rs.)</DIV></td>
  <td colspan="2"><DIV align="center">Total (in Rs)</DIV></td>
</tr>
<tr>
  <td><DIV align="center">(9)</DIV></td>
  <td>Total Loan Sanctioned (A) </td>
  <td><INPUT type="text"  name="CE_SANC_FB" id="CE_SANC_FB" value="<%=CE_SANC_FB%>" onKeyPress="return numbersonly(event);"></td>
  <td colspan="2"><INPUT type="text"  name="WC_SANC_FB" id="WC_SANC_FB" value="<%=WC_SANC_FB%>" onKeyPress="return numbersonly(event);"></td>
  <td colspan="2"><INPUT  name="TOT_SANC_FB"  id="TOT_SANC_FB" type="text" onBlur="loan_calc2()"  readonly="true"></td>
</tr>
<tr>
  <td><DIV align="center">(10)</DIV></td>
  <td>Total Loan Disbursed (B) </td>
  <td><INPUT type="text"  name="CE_DISB_FB" id="CE_DISB_FB" value="<%=CE_DISB_FB%>" onKeyPress="return numbersonly(event);"></td>
  <td colspan="2"><INPUT type="text"  name="WC_DISB_FB" id="WC_DISB_FB" value="<%=WC_DISB_FB%>" onKeyPress="return numbersonly(event);"></td>
  <td colspan="2"><INPUT  name="TOT_DISB_FB" id="TOT_DISB_FB" value="" type="text" onBlur="loan_calc3()" readonly="true"></td>
</tr>
<tr>
  <td><DIV align="center">(11)</DIV></td>
  <td colspan="4">Balance Loan to be Disbursed to Beneficiary (A-B) </td>
  <td colspan="2"><INPUT type="text"  name="TOT_BAL_FB" id="TOT_BAL_FB" value="<%=TOT_BAL_FB%>" onBlur="loan_calc4()"readonly="true"></td>
</tr>
<tr>
  <td rowspan="2"><DIV align="center">(12)</DIV></td>
  <td colspan="2"><P>Whether Unit has availed 100% of Cash Credit (WC) </P>    </td>
  <td colspan="4"><input type="radio" name="CC_AVAIL_100PER_YN" id="CC_AVAIL_100PER_YN_Y" class="check3"  value="Y" <% if (CC_AVAIL_100PER_YN.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <input type="radio" name="CC_AVAIL_100PER_YN" id="CC_AVAIL_100PER_YN_N" class="check3"  value="N" <% if (CC_AVAIL_100PER_YN.equals("N")) {out.print("CHECKED");} %> />
No</td>
</tr>
<tr>
  <td colspan="2">If No, then Average Cash Credit availed during last 3 years (in %) </td>
  <td><INPUT type="text"  name="CC_UTILISE_3YR_PER" id="CC_UTILISE_3YR_PER" value="<%=CC_UTILISE_3YR_PER%>"></td>
  <td>&nbsp;</td>
  <td>%</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td><DIV align="center">(13)</DIV></td>
  <td colspan="2">Rate of Interest*</td>
  <td colspan="4"><INPUT type="text"  name="RINT" id="RINT" value="<%=RINT%>"></td>
</tr>
<tr>
  <td rowspan="2"><DIV align="center">(14)</DIV></td>
  <td colspan="2" rowspan="2">Govt. Subsidy (Margin Money) Received</td>
  <td colspan="2">Date</td>
  <td colspan="2">Amount</td>
</tr>
<tr>
  <td colspan="2"><INPUT type="hidden"  id="MM_REL_DT" name="MM_REL_DT" value="<%=MM_REL_DT%>"/><%=MM_REL_DT%></td>
  <td colspan="2"><INPUT type="hidden"  id="MM_REL_AMT" name="MM_REL_AMT" value="<%=MM_REL_AMT%>"/><%=MM_REL_AMT%></td>
</tr>

<tr>
  <td rowspan="2"><DIV align="center">(16)</DIV></td>
  <td colspan="2" rowspan="2">TDR/Subsidy Reserve Fund </td>
  <td><div align="center">Date</div></td>
  <td colspan="2"><div align="center">Amount</div></td>
  <td><div align="center">Reference No. </div></td>
</tr>

<tr>
  <td><INPUT type="text"  name="TDR_ADJ_DT" id="TDR_ADJ_DT" value="<%=TDR_ADJ_DT%>" onClick="javascript:NewCssCal('TDR_ADJ_DT','ddMMMyyyy')"></td>
  <td colspan="2"><INPUT type="text"  name="TDR_ADJ_AMT" id="TDR_ADJ_AMT" onKeyPress="return numbersonly(event);" value="<%=TDR_ADJ_AMT%>"></td>
  <td><INPUT type="text"  name="TDR_ACNO" value="<%=TDR_ACNO%>"  id="TDR_ACNO"></td>
</tr>
<tr>
  <td><DIV align="center">(19)</DIV></td>
  <td colspan="2">CGTMSE Coverage*</td>
  <td colspan="4"><input type="radio" name="CGTSI" id="CGTSI_Y" class="check3"  value="Y" <% if (CGTSI.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <input type="radio" name="CGTSI" id="CGTSI_N" class="check3"  value="N" <% if (CGTSI.equals("N")) {out.print("CHECKED");} %> />
No </td>
</tr>
<tr>
  <td><DIV align="center">(20)</DIV></td>
  <td colspan="2">Whether Interest Charged on Correspondind amount of Margin Money*</td>
  <td colspan="4"><input type="radio" name="INTCHARGE_ONMM" id="INTCHARGE_ONMM_Y" class="check3"  value="Y" <% if (INTCHARGE_ONMM.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <input type="radio" name="INTCHARGE_ONMM" id="INTCHARGE_ONMM_N" class="check3"  value="N" <% if (INTCHARGE_ONMM.equals("N")) {out.print("CHECKED");} %> />
No
  </td>
</tr>
<tr>
  <td><DIV align="center">(21)</DIV></td>
  <td colspan="2">Collateral Security obtained*</td>
  <td colspan="4"><input type="radio" name="COL_SEC_YN" id="COL_SEC_YN_Y" class="check3"  value="Y" <% if (COL_SEC_YN.equals("Y")) {out.print("CHECKED");} %> />
Yes
  <input type="radio" name="COL_SEC_YN" id="COL_SEC_YN_N" class="check3"  value="N" <% if (COL_SEC_YN.equals("N")) {out.print("CHECKED");} %> />
No
</td>
</tr>
<tr>

  <td><DIV align="center">(22)</DIV></td>
  <td colspan="2">If Yes, Value of Collateral Security</td>
  <td colspan="4"><INPUT type="text"  name="COL_SEC_AMT" id="COL_SEC_AMT" onKeyPress="return numbersonly(event);" value="<%=COL_SEC_AMT%>"></td>
</tr>
<tr>
  <td><DIV align="center">(23)</DIV></td>
  <td colspan="2">Whether Repayment of Loan is Regular</td>
  <td colspan="4"><input type="radio" name="REPAY_LOAN_YN" id="REPAY_LOAN_YN_Y" class="check3"  value="Y" <% if (REPAY_LOAN_YN.equals("Y")) {out.print("CHECKED");} %> />
    Yes
   
   <input type="radio" name="REPAY_LOAN_YN" id="REPAY_LOAN_YN_N" class="check3"  value="N" <% if (REPAY_LOAN_YN.equals("N")) {out.print("CHECKED");} %> />
    No
  </input></td>
</tr>
<tr>
  <td rowspan="2"><DIV align="center">(24)</DIV></td>
  <td colspan="2">Whether unit comes under NPA?<BR></td>
  <td colspan="4"><input type="radio" name="NPA_YN" id="NPA_YN_Y" class="check3"  value="Y" <% if (NPA_YN.equals("Y")) {out.print("CHECKED");} %> />
    Yes
    </input>
      <input type="radio" name="NPA_YN" id="NPA_YN_N" class="check3"  value="N" <% if (NPA_YN.equals("N")) {out.print("CHECKED");} %> />
    No
    </input></td>
</tr>
<tr>
  <td colspan="2">
If Yes, NPA w.e.f. Date </td>
  <td colspan="4"><INPUT type="text"  name="NPA_DT" value="<%=NPA_DT%>"  id="NPA_DT" onClick="javascript:NewCssCal('NPA_DT','ddMMMyyyy')"></td>
</tr>

<tr>
  <th colspan="7"><div align="center">UNIT DETAIL </div></th>
  </tr>
<tr>
  <td><DIV align="center">(25)</DIV></td>
  <td colspan="2">Unit Status*</td>
  <td colspan="4"> <input type="radio" name="UNIT_CUR_STATUS" id="UNIT_CUR_STATUS1" class="check"  value="W" <% if (UNIT_CUR_STATUS.equals("W")) {out.print("CHECKED");} %> />
Working</td>
  </tr>
<tr>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
  <td colspan="4"> <input type="radio" name="UNIT_CUR_STATUS" id="UNIT_CUR_STATUS2" class="check"  value="D" <% if (UNIT_CUR_STATUS.equals("D")) {out.print("CHECKED");} %> />
Not Working/defunct</td>
  </tr>
<tr>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
  <td colspan="4"> <input type="radio" name="UNIT_CUR_STATUS" id="UNIT_CUR_STATUS3" class="check"  value="NT" <% if (UNIT_CUR_STATUS.equals("NT")) {out.print("CHECKED");} %> />
Non-Traceable</td>
  </tr>
<tr>
  <td>(27)</td>
  <td colspan="2">Date of Commencement of Business: </td>
  <td colspan="2"><INPUT type="text"  name="BUSINESS_COM_DT" value="<%=BUSINESS_COM_DT%>"  id="BUSINESS_COM_DT" onClick="javascript:NewCssCal('BUSINESS_COM_DT','ddMMMyyyy')"></td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td rowspan="2">(26)</td>
  <td colspan="2" rowspan="2">Annual Turnover of the Unit</td>
  <td colspan="2"><DIV align="center">Production (in Rs.) </DIV></td>
  <td colspan="2"><DIV align="center">Sales (in Rs.) </DIV></td>
</tr>
<tr>
  <td colspan="2"><INPUT type="text"  name="ANNL_PROD" value="<%=ANNL_PROD%>"  onKeyPress="return numbersonly(event);" id="ANNL_PROD"></td>
  <td colspan="2"><INPUT type="text"  name="ANNL_SALE" value="<%=ANNL_SALE%>"  onKeyPress="return numbersonly(event);" id="ANNL_SALE"></td>
</tr>

<tr>
  <td>(28)</td>
  <td colspan="2">Any other Remark on the Functioning of the Unit</td>
  <td colspan="4"><input type="text"  name="ANY_OTH_REMARKS" id="ANY_OTH_REMARKS" value="<%=ANY_OTH_REMARKS%>"></td>
</tr>
<tr>
  <td colspan="7"><label>
    <input type="checkbox" name="ACT_ID" id="ACT_ID" value="-1" checked >
  </label>
    It is hereby declared that all details furnished above are correct as per  PMEGP Scheme guidelines</td>
</tr>
<tr>
  <td colspan="7"><div align="center"><input type="button" value="Submit" onClick="submit_offupdate();" class="buttongreen"></div></td>
  </tr>
</table>
 

</form>
</BODY>
</HTML>