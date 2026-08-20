<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.BankDataValidation,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>

<head>
<title>PMEGP Bank Data Entry Form</title>
<%@ include file="headerfile.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<style>
body{
font-family:Arial, Helvetica, sans-serif; 
font-size:18px;
font-weight:bold;
}
.info, .success, .warning, .error, .validation {
border: 1px solid;
margin: 10px 0px;
padding:15px 10px 15px 50px;
background-repeat: no-repeat;
background-position: 10px center;
}
.info {
color: #00529B;
background-color: #BDE5F8;
background-image: url('info.png');
}
.success {
color: #4F8A10;
background-color: #DFF2BF;
background-image:url('success.png');
}
.warning {
color: #9F6000;
background-color: #FEEFB3;
background-image: url('warning.png');
}
.error {
color: #D8000C;
background-color: #FFBABA;
background-image: url('../images/error.png');
}
</style>

<script language="javascript" src="../js/popcalendar.js"></script>

<script language="javascript">

function loan_calc(){
var ws=document.form1.WORKSHED_COST.value;
var mc=document.form1.MACHINARY_COST.value;
var poc=document.form1.PRE_OPE_COST.value;
var tce=Number(ws)+Number(mc)+Number(poc);
document.form1.TOT_CE.value=tce;
var wc=document.form1.WORKING_CAPITAL.value;
document.form1.TOT_SANC.value= Number(tce) + Number(wc);
}



function GetSelectedItem() {
chosen = ""
len = document.form1.ACT_ID.length
for (i = 0; i <len; i++) {
if (document.form1.ACT_ID[i].checked) {
chosen = document.form1.ACT_ID[i].value
}
}
return chosen;
}


function Status_change(){
//i=document.form1.ACT_ID.selectedIndex; 
vst=GetSelectedItem();
//alert (vst);
//document.form1.ACT_ID.options[i].value;
var flag='N';

      if (vst==3||vst=='0'||vst=='8'){
		f_disable();
        document.form1.BANK_REMARKS.style.backgroundColor='white';
		document.form1.BANK_REMARKS.disabled=false;
	  }else if	(vst==11){
		 f_enable();
		 }else if	(vst==8){
		 f_disable();
		 document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
		document.form1.BANK_REMARKS.disabled=true;
		}else{
		f_enable();
		document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
		document.form1.BANK_REMARKS.disabled=true;
		}
	}
	function  f_disable(){
//document.form1.BANK_REMARKS.disabled = true;
//document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.LOAN_SANC_DT.disabled = true;
document.form1.BANK_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.WORKSHED_COST.disabled = true;
document.form1.WORKING_CAPITAL.disabled = true;
document.form1.MACHINARY_COST.disabled = true;
document.form1.PRE_OPE_COST.disabled = true;
document.form1.OWN_CONTRIBUTION.disabled = true;
document.form1.OWN_CONT_DT.disabled = true;
document.form1.IST_LOAN_AMT.disabled = true;
document.form1.IST_LOAN_DT.disabled = true;
document.form1.CGTSI.disabled = true;
//document.form1.MM_CLAIM_LRNO.disabled = true;
document.form1.MM_CLAIM_DT.disabled = true;
document.form1.MM_CLAIM_AMT.disabled = true;
document.form1.PROD.disabled = true;
document.form1.MM_REL_DT.disabled = true;
document.form1.MM_REL_AMT.disabled = true;
document.form1.EMP.disabled = true;
document.form1.SALES.disabled = true;
document.form1.MM_ADJ_AMT.disabled = true;
document.form1.MM_ADJ_DT.disabled = true;
document.form1.TOT_CE.disabled = true;
document.form1.TOT_SANC.disabled = true;


document.form1.RINT.disabled = true;
document.form1.LOAN_PERIOD.disabled = true;
document.form1.LOAN_REMARKS.disabled = true;
document.form1.APPLOAN_ACCNO.disabled = true;
document.form1.FB_ACNO.disabled = true;
document.form1.FB_ACNAME.disabled = true;
document.form1.TDR_ACNO.disabled = true;
document.form1.TDR_ADJ_DT.disabled = true;

document.form1.MOR_PER.disabled = true;




//CHANGE THE COLOUR

document.form1.LOAN_SANC_DT.style.backgroundColor='#C0C0C0';
document.form1.WORKSHED_COST.style.backgroundColor='#C0C0C0';
document.form1.WORKING_CAPITAL.style.backgroundColor='#C0C0C0';
document.form1.MACHINARY_COST.style.backgroundColor='#C0C0C0';
document.form1.PRE_OPE_COST.style.backgroundColor='#C0C0C0';
document.form1.OWN_CONTRIBUTION.style.backgroundColor='#C0C0C0';
document.form1.OWN_CONT_DT.style.backgroundColor='#C0C0C0';
document.form1.IST_LOAN_AMT.style.backgroundColor='#C0C0C0';
document.form1.IST_LOAN_DT.style.backgroundColor='#C0C0C0';
document.form1.CGTSI.style.backgroundColor='#C0C0C0';
//document.form1.MM_CLAIM_LRNO.style.backgroundColor='#C0C0C0';
document.form1.MM_CLAIM_DT.style.backgroundColor='#C0C0C0';
document.form1.MM_CLAIM_AMT.style.backgroundColor='#C0C0C0';
document.form1.PROD.style.backgroundColor='#C0C0C0';
document.form1.MM_REL_DT.style.backgroundColor='#C0C0C0';
document.form1.MM_REL_AMT.style.backgroundColor='#C0C0C0';
document.form1.EMP.style.backgroundColor='#C0C0C0';
document.form1.SALES.style.backgroundColor='#C0C0C0';
document.form1.MM_ADJ_AMT.style.backgroundColor='#C0C0C0';
document.form1.MM_ADJ_DT.style.backgroundColor='#C0C0C0';
document.form1.TOT_CE.style.backgroundColor='#C0C0C0';
document.form1.TOT_SANC.style.backgroundColor='#C0C0C0';

document.form1.RINT.style.backgroundColor='#C0C0C0';
document.form1.LOAN_PERIOD.style.backgroundColor='#C0C0C0';
document.form1.LOAN_REMARKS.style.backgroundColor='#C0C0C0';
document.form1.APPLOAN_ACCNO.style.backgroundColor='#C0C0C0';
document.form1.FB_ACNO.style.backgroundColor='#C0C0C0';
document.form1.FB_ACNAME.style.backgroundColor='#C0C0C0';
document.form1.TDR_ACNO.style.backgroundColor='#C0C0C0';
document.form1.TDR_ADJ_DT.style.backgroundColor='#C0C0C0';
document.form1.MOR_PER.style.backgroundColor='#C0C0C0';



		}
		
		function  f_enable(){

document.form1.LOAN_SANC_DT.disabled = false;
document.form1.WORKSHED_COST.disabled = false;
document.form1.WORKING_CAPITAL.disabled = false;
document.form1.MACHINARY_COST.disabled = false;
document.form1.PRE_OPE_COST.disabled = false;
document.form1.OWN_CONTRIBUTION.disabled = false;
document.form1.OWN_CONT_DT.disabled = false;
document.form1.IST_LOAN_AMT.disabled = false;
document.form1.IST_LOAN_DT.disabled = false;
document.form1.CGTSI.disabled = false;
//document.form1.MM_CLAIM_LRNO.disabled = false;
document.form1.MM_CLAIM_DT.disabled = false;
document.form1.MM_CLAIM_AMT.disabled = false;
document.form1.PROD.disabled = false;
document.form1.MM_REL_DT.disabled = false;
document.form1.MM_REL_AMT.disabled = false;
document.form1.EMP.disabled = false;
document.form1.SALES.disabled = false;
document.form1.MM_ADJ_AMT.disabled = false;
document.form1.MM_ADJ_DT.disabled = false;
document.form1.TOT_CE.disabled = false;
document.form1.TOT_SANC.disabled = false;


document.form1.RINT.disabled = false;
document.form1.LOAN_PERIOD.disabled = false;
document.form1.LOAN_REMARKS.disabled = false;
document.form1.APPLOAN_ACCNO.disabled = false;
document.form1.FB_ACNO.disabled = false;
document.form1.FB_ACNAME.disabled = false;
document.form1.TDR_ACNO.disabled = false;
document.form1.TDR_ADJ_DT.disabled = false;
document.form1.MOR_PER.disabled = false;



//background color
document.form1.LOAN_SANC_DT.style.backgroundColor='White';
document.form1.WORKSHED_COST.style.backgroundColor='White';
document.form1.WORKING_CAPITAL.style.backgroundColor='White';
document.form1.MACHINARY_COST.style.backgroundColor='White';
document.form1.PRE_OPE_COST.style.backgroundColor='White';
document.form1.OWN_CONTRIBUTION.style.backgroundColor='White';
document.form1.OWN_CONT_DT.style.backgroundColor='White';
document.form1.IST_LOAN_AMT.style.backgroundColor='White';
document.form1.IST_LOAN_DT.style.backgroundColor='White';
document.form1.CGTSI.style.backgroundColor='White';
//document.form1.MM_CLAIM_LRNO.style.backgroundColor='White';
document.form1.MM_CLAIM_DT.style.backgroundColor='White';
document.form1.MM_CLAIM_AMT.style.backgroundColor='White';
document.form1.PROD.style.backgroundColor='White';
document.form1.MM_REL_DT.style.backgroundColor='White';
document.form1.MM_REL_AMT.style.backgroundColor='White';
document.form1.EMP.style.backgroundColor='White';
document.form1.SALES.style.backgroundColor='White';
document.form1.MM_ADJ_AMT.style.backgroundColor='White';
document.form1.MM_ADJ_DT.style.backgroundColor='White';
document.form1.TOT_CE.style.backgroundColor='White';
document.form1.TOT_SANC.style.backgroundColor='White';


document.form1.RINT.style.backgroundColor='White';
document.form1.LOAN_PERIOD.style.backgroundColor='White';
document.form1.LOAN_REMARKS.style.backgroundColor='White';
document.form1.APPLOAN_ACCNO.style.backgroundColor='White';
document.form1.FB_ACNO.style.backgroundColor='White';
document.form1.FB_ACNAME.style.backgroundColor='White';
document.form1.TDR_ACNO.style.backgroundColor='White';
document.form1.TDR_ADJ_DT.style.backgroundColor='White';
document.form1.MOR_PER.style.backgroundColor='White';

		}




function openSancReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=LetterHeadOfBank';
 window.open(url);
 
}

function openMM(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoney';
 window.open(url);
 
}

function insUpdate(){
document.form1.ins.value='I';
form1.submit();
}//end




</script>
</head>
<body onLoad="loan_calc();Status_change();">
<form  method="post"  name="form1" action="bankDataEntryForm1.jsp" >
  
  <%
  int ACT=0;
String flg="Y";
String APP_NAME="";
String BENF_TYPE="";
String APP_ID = (String) request.getParameter("APP_ID");
String IFSC_CODE=(String)session.getAttribute("bank_id");
  
String ACT_ID = "";
String BANK_REC_DT = "";
String BANK_REMARKS = "";
String LOAN_SANC_LRNO = "";
String LOAN_SANC_DT = "";
String WORKSHED_COST ="";
String WORKING_CAPITAL = "";
String MACHINARY_COST = "";
String PRE_OPE_COST = "";
String OWN_CONTRIBUTION = "";
String OWN_CONT_DT = "";
String BANK_LOAN = "";
int vACT_ID=0;
String TR_ID = "";
String BANK_CODE = "";
String IST_LOAN_AMT = "";
String IST_LOAN_DT = "";
String CGTSI = "";
String MM_CLAIM_LRNO = "";
String MM_CLAIM_DT = "";
String MM_CLAIM_AMT = "";
String PROD = "";
String MM_REL_DT = "";
String MM_REL_AMT = "";
String EMP = "";
String SALES = "";
String MM_ADJ_AMT = "";
String MM_ADJ_DT = "";
String TIME_STAMP = "";
String TODAYDT="";
String ACTIVITY_NAME="";
String GENDER = "";
String  UNIT_LOC = "";
String QUALI = "";
String BENF_CATEGORY_CD = "";
String BENF_CATEGORY_DESC = "";
String IND_TYPE="";
String PROJ_COST="";
String OWN_CONT_PER="";
String MM_ELIG_PER="";
String BANK_LOAN_PER="";

String RINT="";
String LOAN_PERIOD="";
String LOAN_REMARKS="";

String EDP_TRG_NAME = "";
String EDP_FR_DT = "";
String EDP_TO_DT = "";
String EDP_CERT_DT = "";

String APPLOAN_ACCNO = "";
String FB_ACNO = "";
String FB_ACNAME = "";
String TDR_ACNO = "";
String TDR_ADJ_DT = "";

String CE_SANC_FB="";
String WC_SANC_FB="";

String MOR_PER="";

String READONLY="";
String EVENT="onClick";

String a="" ;
ArrayList msg = new ArrayList();

String stage="";
String verror="";
try {
DBCon db= new DBCon();
db.connect();


StringBuffer av= new StringBuffer();
av.append("SELECT a.tr_id, b.app_id, a.act_id, to_char(a.bank_rec_dt,'DD-MON-YYYY') AS  bank_rec_dt, bank_remarks,AM.activity_name,100-OWNCONT_PER(B.APP_ID) AS BANK_LOAN_PER,a.RINT,a.LOAN_PERIOD, ").
append(" b.gender,b.unit_loc,C.benf_category_cd,C.benf_category_desc,d.edu_desc||' (Tech: '||b.tech_quali ||')' as quali,DECODE(B.ind_type,'M','Manufacturing','Service') as ind_type,A.LOAN_REMARKS, "). 
append(" (nvl(B.workshed_cost,0)+nvl(B.pre_ope_exp,0)+nvl(B.machinary_cost,0)+nvl(B.working_capital,0)) as Proj_cost, OWNCONT_PER(B.APP_ID) AS OWN_CONT_PER,MM_PER(B.APP_ID) AS MM_ELIG_PER,").
append(" a.EDP_TRG_NAME, to_char(a.EDP_FR_DT,'DD-MON-RRRR') AS EDP_FR_DT,to_char(a.EDP_TO_DT,'DD-MON-RRRR') AS EDP_TO_DT , to_char(a.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT, ").
append(" a.APPLOAN_ACCNO,a.FB_ACNO,a.FB_ACNAME,a.TDR_ACNO,to_char(a.TDR_ADJ_DT,'DD-MON-RRRR') AS TDR_ADJ_DT,A.MOR_PER, ").
append(" to_char(a.loan_sanc_dt,'DD-MON-YYYY') AS loan_sanc_dt, a.workshed_cost, a.working_capital, a.machinary_cost, a.pre_ope_cost, ").
append ( " a.own_contribution, to_char(a.own_cont_dt,'DD-MON-YYYY') AS own_cont_dt, a.ist_loan_amt, to_char(a.ist_loan_dt,'DD-MON-YYYY') AS ist_loan_dt, a.cgtsi," ).
append ( " a.mm_claim_lrno, to_char(a.mm_claim_dt,'DD-MON-YYYY') AS  mm_claim_dt, a.mm_claim_amt, a.mm_rel_amt, ").
append ( " to_char(a.mm_rel_dt,'DD-MON-YYYY') as  mm_rel_dt, UPPER(b.app_name) AS APP_NAME, a.emp, a.prod, a.sales, " ).
append ( " to_char(a.tdr_adj_dt,'DD-MON-YYYY') as tdr_adj_dt, a.tdr_adj_amt,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,B.IFSC_CODE, " ).
 append ( " a.bank_comment,  to_char(a.time_stamp,'DD-MON-YYYY:HH:MM:SS') as time_stamp ").
  append (" FROM bank_dataentry a, app_detail b,BENF_CATEGORY_MAST C,education_mast d , ACTIVITY_MAST AM WHERE B.ACTIVITY_CD=AM.ACTIVITY_CD AND  b.APP_ID=? AND B.IFSC_CODE=?").
  append ("  and b.app_id=a.app_id(+) and b.benf_catagory_cd=C.benf_category_cd and b.EDU_ID=d.edu_id ");
			
			List values=new ArrayList();
     values.add (APP_ID); 
	 values.add (IFSC_CODE);
			
			
			
ResultSet rsApp = db.executeSQL(av.toString(),values);
values.clear();

String ACTWHR=" ACT_ID in (8,11,3) OR ";

while (rsApp.next()) {
           
if (rsApp.getString("ACT_ID") != null){
		ACT_ID = rsApp.getString("ACT_ID");
	}else{
		ACT_ID = "0";
	}
	if ( Integer.parseInt(ACT_ID)>22 ){
	READONLY="readonly=true";
	ACTWHR="";
	EVENT="";
	}
         
		 try {  
     vACT_ID=Integer.parseInt(ACT_ID);
	 
	 if (vACT_ID>10)	{
	 vACT_ID=11;
	 }	
}catch (Exception e){
vACT_ID=0;
}
//APPLICANT DATA DISPLAY
if (rsApp.getString("TODAYDT") != null){
		TODAYDT = rsApp.getString("TODAYDT");
	}else{
		TODAYDT = "";
	}
if (rsApp.getString("PROJ_COST") != null){
		PROJ_COST = rsApp.getString("PROJ_COST");
	}else{
		PROJ_COST = "0";
	}
	
if (rsApp.getString("IND_TYPE") != null){
		IND_TYPE = rsApp.getString("IND_TYPE");
	}else{
		IND_TYPE = "";
	}
if (rsApp.getString("QUALI") != null){
		QUALI = rsApp.getString("QUALI");
	}else{
		QUALI = "";
	}

if (rsApp.getString("IFSC_CODE") != null){
		IFSC_CODE = rsApp.getString("IFSC_CODE");
	}else{
		IFSC_CODE = "";
	}

if (rsApp.getString("BENF_CATEGORY_CD") != null){
		BENF_CATEGORY_CD = rsApp.getString("BENF_CATEGORY_CD");
	}else{
		BENF_CATEGORY_CD = "";
	}


if (rsApp.getString("BENF_CATEGORY_DESC") != null){
		BENF_CATEGORY_DESC = rsApp.getString("BENF_CATEGORY_DESC");
	}else{
		BENF_CATEGORY_DESC = "";
	}

if (rsApp.getString("activity_name") != null){
		ACTIVITY_NAME = rsApp.getString("activity_name");
	}else{
		ACTIVITY_NAME = "";
	}

if (rsApp.getString("UNIT_LOC") != null){
		UNIT_LOC = rsApp.getString("UNIT_LOC");
	}else{
		UNIT_LOC = "";
	}



if (rsApp.getString("GENDER") != null){
		GENDER = rsApp.getString("GENDER");
	}else{
		GENDER = "";
	}


if (rsApp.getString("TR_ID") != null){
		TR_ID = rsApp.getString("TR_ID");
	}else{
		TR_ID = "";
	}


	if (rsApp.getString("APP_NAME") != null){
		APP_NAME = rsApp.getString("APP_NAME");
	}else{
		APP_NAME = "";
	}
	
	if (rsApp.getString("BANK_REC_DT") != null){
		BANK_REC_DT = rsApp.getString("BANK_REC_DT");
	}else{
		BANK_REC_DT ="";
	}
	if (rsApp.getString("BANK_REMARKS") != null){
		BANK_REMARKS = rsApp.getString("BANK_REMARKS");
	}else{
		BANK_REMARKS = "";
	}
	
	if (rsApp.getString("LOAN_SANC_DT") != null){
		LOAN_SANC_DT = rsApp.getString("LOAN_SANC_DT");
	}else{
		LOAN_SANC_DT = "";
	}
   
	
	if (rsApp.getString("WORKSHED_COST") != null){
		WORKSHED_COST = rsApp.getString("WORKSHED_COST");
	}else{
		WORKSHED_COST = "0";
	}
	
	if (rsApp.getString("MACHINARY_COST") != null){
		MACHINARY_COST = rsApp.getString("MACHINARY_COST");
	}else{
		MACHINARY_COST = "0";
	}
	if (rsApp.getString("PRE_OPE_COST") != null){
		PRE_OPE_COST = rsApp.getString("PRE_OPE_COST");
	}else{
		PRE_OPE_COST = "0";
	}
	
	if (rsApp.getString("WORKING_CAPITAL") != null){
		WORKING_CAPITAL = rsApp.getString("WORKING_CAPITAL");
	}else{
		WORKING_CAPITAL = "0";
	}
	
	if (rsApp.getString("OWN_CONTRIBUTION") != null){
		OWN_CONTRIBUTION = rsApp.getString("OWN_CONTRIBUTION");
	}else{
		OWN_CONTRIBUTION = "0";
	}
	
	if (rsApp.getString("OWN_CONT_DT") != null){
		OWN_CONT_DT = rsApp.getString("OWN_CONT_DT");
	}else{
		OWN_CONT_DT = "";
	}
	
	
	if (rsApp.getString("IST_LOAN_AMT") != null){
		IST_LOAN_AMT = rsApp.getString("IST_LOAN_AMT");
	}else{
		IST_LOAN_AMT = "0";
	}
	
	
	if (rsApp.getString("IST_LOAN_DT") != null){
		IST_LOAN_DT = rsApp.getString("IST_LOAN_DT");
	}else{
		IST_LOAN_DT = "";
	}
	if (rsApp.getString("CGTSI") != null){
		CGTSI = rsApp.getString("CGTSI");
	}else{
		CGTSI = "";
	}
	
	if (rsApp.getString("MM_CLAIM_LRNO") != null){
		MM_CLAIM_LRNO = rsApp.getString("MM_CLAIM_LRNO");
	}else{
		MM_CLAIM_LRNO = "";
	}
	if (rsApp.getString("MM_CLAIM_DT") != null){
		MM_CLAIM_DT = rsApp.getString("MM_CLAIM_DT");
	}else{
		MM_CLAIM_DT = "";
	}
	if (rsApp.getString("MM_CLAIM_AMT") != null){
		MM_CLAIM_AMT = rsApp.getString("MM_CLAIM_AMT");
	}else{
		MM_CLAIM_AMT = "0";
	}
		
	if (rsApp.getString("MM_REL_DT") != null){
		MM_REL_DT = rsApp.getString("MM_REL_DT");
	}else{
		MM_REL_DT = "";
	}
	
	if (rsApp.getString("MM_REL_AMT") != null){
		MM_REL_AMT = rsApp.getString("MM_REL_AMT");
	}else{
		MM_REL_AMT = "0";
	}
	
	if (rsApp.getString("EMP") != null){
		EMP = rsApp.getString("EMP");
	}else{
		EMP = "";
	}
	
	if (rsApp.getString("PROD") != null){
		PROD = rsApp.getString("PROD");
	}else{
		PROD = "";
	}
	
	if (rsApp.getString("SALES") != null){
		SALES = rsApp.getString("SALES");
	}else{
		SALES = "";
	}
	
	
	if (rsApp.getString("TDR_ADJ_AMT") != null){
		MM_ADJ_AMT = rsApp.getString("TDR_ADJ_AMT");
	}else{
		MM_ADJ_AMT = "";
	}
	
	if (rsApp.getString("TDR_ADJ_DT") != null){
		MM_ADJ_DT = rsApp.getString("TDR_ADJ_DT");
	}else{
		MM_ADJ_DT = "0";
	}
	
	if (rsApp.getString("TIME_STAMP") != null){
		TIME_STAMP = rsApp.getString("TIME_STAMP");
	}else{
		TIME_STAMP = "";
	}
	
	
	 OWN_CONT_PER=rsApp.getString("OWN_CONT_PER")==null?"0":rsApp.getString("OWN_CONT_PER");
	 MM_ELIG_PER=rsApp.getString("MM_ELIG_PER")==null?"0":rsApp.getString("MM_ELIG_PER");
	 BANK_LOAN_PER=rsApp.getString("BANK_LOAN_PER")==null?"0":rsApp.getString("BANK_LOAN_PER");
	RINT=rsApp.getString("RINT")==null?"":rsApp.getString("RINT");
	LOAN_PERIOD=rsApp.getString("LOAN_PERIOD")==null?"0":rsApp.getString("LOAN_PERIOD");
	LOAN_REMARKS=rsApp.getString("LOAN_REMARKS")==null?"":rsApp.getString("LOAN_REMARKS");	
	
	
	EDP_TRG_NAME=rsApp.getString("EDP_TRG_NAME")==null?"":rsApp.getString("EDP_TRG_NAME");
	EDP_FR_DT=rsApp.getString("EDP_FR_DT")==null?"":rsApp.getString("EDP_FR_DT");
	EDP_TO_DT=rsApp.getString("EDP_TO_DT")==null?"":rsApp.getString("EDP_TO_DT");
	EDP_CERT_DT=rsApp.getString("EDP_CERT_DT")==null?"":rsApp.getString("EDP_CERT_DT");
	
	
	APPLOAN_ACCNO=rsApp.getString("APPLOAN_ACCNO")==null?"":rsApp.getString("APPLOAN_ACCNO");
	FB_ACNO=rsApp.getString("FB_ACNO")==null?"":rsApp.getString("FB_ACNO");
	FB_ACNAME=rsApp.getString("FB_ACNAME")==null?"":rsApp.getString("FB_ACNAME");
	TDR_ACNO=rsApp.getString("TDR_ACNO")==null?"":rsApp.getString("TDR_ACNO");
	TDR_ADJ_DT=rsApp.getString("TDR_ADJ_DT")==null?"":rsApp.getString("TDR_ADJ_DT");
    MOR_PER=rsApp.getString("MOR_PER")==null?"":rsApp.getString("MOR_PER");


	
	
	
	} //end of resultset	
	//END OF BANK DATA
	
	
	
	
	
	
	if ((String)request.getParameter("ins")!=null){
	if (request.getParameter("ACT_ID") != null){
			ACT_ID = (String) request.getParameter("ACT_ID");
			vACT_ID =Integer.parseInt(ACT_ID);
		}else{
			ACT_ID = "0";
		}
		if (request.getParameter("BANK_REC_DT") != null){
			BANK_REC_DT = (String) request.getParameter("BANK_REC_DT");
		}else{
			BANK_REC_DT = "";
		}
		
		if (request.getParameter("BANK_REMARKS") != null){
			BANK_REMARKS = (String) request.getParameter("BANK_REMARKS");
		}else{
			BANK_REMARKS = "";
		}
		
		if (request.getParameter("LOAN_SANC_DT") != null){
			LOAN_SANC_DT = (String) request.getParameter("LOAN_SANC_DT");
		}else{
			LOAN_SANC_DT = "";
		}
		if (request.getParameter("WORKSHED_COST") != null){
			WORKSHED_COST = (String) request.getParameter("WORKSHED_COST");
		}else{
			WORKSHED_COST = "";
		}
		if (request.getParameter("WORKING_CAPITAL") != null){
			WORKING_CAPITAL = (String) request.getParameter("WORKING_CAPITAL");
		}else{
			WORKING_CAPITAL = "";
		}
		if (request.getParameter("MACHINARY_COST") != null){
			MACHINARY_COST = (String) request.getParameter("MACHINARY_COST");
		}else{
			MACHINARY_COST = "";
		}
		if (request.getParameter("PRE_OPE_COST") != null){
			PRE_OPE_COST = (String) request.getParameter("PRE_OPE_COST");
		}else{
			PRE_OPE_COST = "";
		}
		if (request.getParameter("OWN_CONTRIBUTION") != null){
			OWN_CONTRIBUTION = (String) request.getParameter("OWN_CONTRIBUTION");
		}else{
			OWN_CONTRIBUTION = "";
		}
		if (request.getParameter("OWN_CONT_DT") != null){
			OWN_CONT_DT = (String) request.getParameter("OWN_CONT_DT");
		}else{
			OWN_CONT_DT = "";
		}
		

		
		if (request.getParameter("IST_LOAN_AMT") != null){
			IST_LOAN_AMT = (String) request.getParameter("IST_LOAN_AMT");
		}else{
			IST_LOAN_AMT = "";
		} 
		
		if (request.getParameter("IST_LOAN_DT") != null){
			IST_LOAN_DT = (String) request.getParameter("IST_LOAN_DT");
		}else{
			IST_LOAN_DT = "";
		}
		if (request.getParameter("CGTSI") != null){
			CGTSI = (String) request.getParameter("CGTSI");
		}else{
			CGTSI = "";
		}
		if (request.getParameter("MM_CLAIM_LRNO") != null){
			MM_CLAIM_LRNO = (String) request.getParameter("MM_CLAIM_LRNO");
		}else{
			MM_CLAIM_LRNO = "";
		}
		if (request.getParameter("MM_CLAIM_DT") != null){
			MM_CLAIM_DT = (String) request.getParameter("MM_CLAIM_DT");
		}else{
			MM_CLAIM_DT = "";
		}
		if (request.getParameter("MM_CLAIM_AMT") != null){
			MM_CLAIM_AMT = (String) request.getParameter("MM_CLAIM_AMT");
		}else{
			MM_CLAIM_AMT ="";
		}
		if (request.getParameter("PROD") != null){
			PROD = (String) request.getParameter("PROD");
		}else{
			PROD ="";
		}
		if (request.getParameter("MM_REL_DT") != null){
			MM_REL_DT = (String) request.getParameter("MM_REL_DT");
		}else{
			MM_REL_DT = "";
		}
		if (request.getParameter("MM_REL_AMT") != null){
			MM_REL_AMT = (String) request.getParameter("MM_REL_AMT");
		}else{
			MM_REL_AMT = "";
		}
		if (request.getParameter("EMP") != null){
			EMP = (String) request.getParameter("EMP");
		}else{
			EMP = "";
		}
		
		if (request.getParameter("SALES") != null){
			SALES = (String) request.getParameter("SALES");
		}else{
			SALES = "";
		}
		
		
		if (request.getParameter("MM_ADJ_AMT") != null){
			MM_ADJ_AMT = (String) request.getParameter("MM_ADJ_AMT");
		}else{
			MM_ADJ_AMT = "";
		}
		if (request.getParameter("MM_ADJ_DT") != null){
			MM_ADJ_DT = (String) request.getParameter("MM_ADJ_DT");
		}else{
			MM_ADJ_DT = "";
		} 
		
		if (request.getParameter("RINT") != null){
			RINT = (String) request.getParameter("RINT");
		}else{
			RINT = "";
		} 
		
		if (request.getParameter("LOAN_PERIOD") != null){
			LOAN_PERIOD = (String) request.getParameter("LOAN_PERIOD");
		}else{
			LOAN_PERIOD = "";
		} 
		
		
		if (request.getParameter("LOAN_REMARKS") != null){
			LOAN_REMARKS = (String) request.getParameter("LOAN_REMARKS");
		}else{
			LOAN_REMARKS = "";
		} 
		
		
		EDP_TRG_NAME=(String) request.getParameter("EDP_TRG_NAME")==null?"":(String) request.getParameter("EDP_TRG_NAME").trim();
		EDP_FR_DT=(String) request.getParameter("EDP_FR_DT")==null?"":(String) request.getParameter("EDP_FR_DT").trim();
		EDP_TO_DT=(String) request.getParameter("EDP_TO_DT")==null?"":(String) request.getParameter("EDP_TO_DT").trim();
		EDP_CERT_DT=(String) request.getParameter("EDP_CERT_DT")==null?"":(String) request.getParameter("EDP_CERT_DT").trim();

		APPLOAN_ACCNO=(String) request.getParameter("APPLOAN_ACCNO")==null?"":(String) request.getParameter("APPLOAN_ACCNO").trim();
		FB_ACNO=(String) request.getParameter("FB_ACNO")==null?"":(String) request.getParameter("FB_ACNO").trim();
		FB_ACNAME=(String) request.getParameter("FB_ACNAME")==null?"":(String) request.getParameter("FB_ACNAME").trim();
		TDR_ACNO=(String) request.getParameter("TDR_ACNO")==null?"":(String) request.getParameter("TDR_ACNO").trim();
		TDR_ADJ_DT=(String) request.getParameter("TDR_ADJ_DT")==null?"":(String) request.getParameter("TDR_ADJ_DT").trim();
		MOR_PER=(String) request.getParameter("MOR_PER")==null?"":(String) request.getParameter("MOR_PER").trim();
		
		
		String validateqry="SELECT * FROM TABLE(GET_PMEGP_BANKERROR(?,?,?,?,?,?,?,?,?,?,?,? ,?,?,?,? ,?,?,?) )";

    values.add (APP_ID); 
	 values.add (ACT_ID);
	 values.add (BANK_REC_DT);
	 values.add (LOAN_SANC_DT);
	values.add (WORKING_CAPITAL);
	values.add (MACHINARY_COST);
	values.add (CGTSI);
	values.add (RINT);
	values.add (LOAN_PERIOD);
	values.add (MOR_PER);
	values.add (LOAN_REMARKS);
	values.add (BANK_REMARKS);
		values.add (OWN_CONT_PER);
		values.add (MM_ELIG_PER);
		values.add (OWN_CONT_DT);
		values.add (OWN_CONTRIBUTION);
		values.add (IST_LOAN_DT);
		values.add (IST_LOAN_AMT);
		values.add (APPLOAN_ACCNO);
		
	

ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	


while (rsValidate.next()){

verror=rsValidate.getString(2);
verror=verror+"<br>";
}


rsValidate.close();

		
		}//end of ins
	}catch (Exception e) {
	
	out.print (e.toString());
	}	
		
%>
  
  
  
  
  <table width="100%">
    <tr>
      <td colspan="4" nowrap><div align="center" class="style29 style39">BANK DETAIL UPDATION FORM </div></td>
    </tr>
    <tr>
      <td colspan="4" ><div align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <input name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %> and Amount in Rs) </div></td>
    </tr>
    <tr>
      <th  ><div align="right">Applicant ID : </div></th>
      <th  > <div align="left">
          <input name="APP_ID" type="hidden"  id="APP_ID" value="<%= APP_ID %>" size="15" >
          <%= APP_ID %> </div></th>
      <th   ><div align="right">Applicant Name:</div></th>
      <th ><input name="APP_NAME" type="hidden"  id="APP_NAME" value="<%= APP_NAME %>" >
        <%= APP_NAME %> </th>
    </tr>
    <tr>
      <th  ><div align="right" class="style29 ">Gender:</div></th>
      <th  ><div align="left"><%= GENDER %>&nbsp;</div></th>
      <th  ><div align="right">Category:</div></th>
      <th  ><%= BENF_CATEGORY_DESC %></th>
    </tr>
    <tr>
      <th  ><div align="right"><span class="style29 ">Unit Location</span><span class="style29 style33">: </span></div></th>
      <th  ><div align="left"><%= UNIT_LOC %></div></th>
      <th  > <div align="right">Project Cost Recomended by DLTFC: </div></th>
      <th  >Rs.
        <input name="PROJ_COST" type="hidden"  id="PROJ_COST" tabindex="0" value="<%=PROJ_COST %>" size="15" readonly="true">
        <%=PROJ_COST %>
        <input name="OWN_CONT_PER" type="hidden"  id="OWN_CONT_PER" tabindex="0" value="<%= OWN_CONT_PER %>" ></th>
    </tr>
    <tr>
      <th  ><div align="right" class="style29 ">Industry Type: </div></th>
      <th  ><div align="left"><%= IND_TYPE %></div></th>
      <th  > <div align="right">Beneficary Contribution (Own Contribution) 
          <input name="MM_ELIG_PER" type="hidden"  id="MM_ELIG_PER" tabindex="0" value="<%= MM_ELIG_PER %>" size="2" maxlength="2" readonly="true">
      :</div></th>
      <th> <%= OWN_CONT_PER %>% </th>
    </tr>
    <tr>
      <th  ><div align="right" >Industry:</div></th>
      <th  ><%= ACTIVITY_NAME %></th>
      <th  ><div align="right">Bank Finance / Loan Sanction</div></th>
      <th  ><%= BANK_LOAN_PER %>%</th>
    </tr>
    <tr>
      <th  ><div align="right">Qualification</div></th>
      <th  ><div align="left"><%= QUALI %></div></th>
      <th  ><div align="right">Govt. Subsidy(MM) Eligible:</div></th>
      <th  ><%= MM_ELIG_PER %>%</th>
    </tr>
  </table>
<div class="error">

<%
out.print (verror);
%> </div>
  <table>
    <tr>
      <th colspan="5" ><div align="center" >Application  Status Updation (Stage 1)
          <input name="ACT_ID" type="radio" value="0" checked="checked" disabled="disabled" <% if (vACT_ID==0){out.print("Checked");}%> onChange="Status_change();">
      </div></th>
      <th  nowrap > <div align="center" >Guideline/Description </div></th>
    <tr>
      <th> (1)</th>
	
      <th>Application / Documents Received Date:*</th>
      <td colspan="3">
<input name="BANK_REC_DT" type="text"  tabindex="0" value="<%= BANK_REC_DT %>"  size="12" placeholder="dd-mm-yyyy" autocomplete="off"  onClick="popUpCalendar(this, this.form.BANK_REC_DT,'dd-mmm-yyyy');return false;">
</td>
      <th>(1) Enter Date on which Application and Documents of Beneficiary Received. </th>
    <tr>
      <th> (2) </th>
      <th> Select Current Status at Bank:*</th>
      <td colspan="3" nowrap><input name="ACT_ID" type="radio" value="8" <% if (vACT_ID==8){out.print("Checked");}%> onChange="Status_change();">
        Under Process
        <input name="ACT_ID" type="radio" value="11"  <% if (vACT_ID==11){out.print("Checked");}%> onChange="Status_change();" >
        <span class="GreenLebel">Loan Sanctioned</span>
        <input name="ACT_ID" type="radio" value="3" <% if (vACT_ID==3){out.print("Checked");}%> onChange="Status_change();">
        <span class="redLebel"> Rejected</span></td>
      <th>(2) Select Application Status ( Under Process/Rejected/Loan Sanctioned   ) </th>
    <tr>
      <th>(3)</th>
      <th>Remarks ( Rejection / Under Process ) :</th>
      <td colspan="3" nowrap><input name="BANK_REMARKS" type="text"  tabindex="3" value="<%=BANK_REMARKS %>" size="50" maxlength="100" ></td>
      <th nowrap>(3) Enter Remarks for Rejection/ Under Process </th>
    <tr>
      <th colspan="5"><div align="center">
        <input name="btnStatusSave" type="button" class="button" id="btnStatusSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </div></th>
      <th>-</a></th>
    <tr>
      <th colspan="5"><div align="center">Total Project Cost and Loan Sanction (Stage-2)
        <input name="ins" type="hidden" id="ins">
              <input name="WORKSHED_COST" type="hidden" tabindex="5" onChange="loan_calc();" onKeyPress="return numbersonly(event);" value="<%= WORKSHED_COST %>" <%= READONLY %>>
              <input name="PRE_OPE_COST" type="hidden" tabindex="7" onChange="loan_calc();" onKeyPress="return numbersonly(event);" value="<%= PRE_OPE_COST %>"  <%= READONLY %>>
              <input name="TOT_CE" type="hidden"  id="TOT_CE" style="background-color:#CC9900 " value="">
      </div></th>
      <th>&nbsp;</th>
    <tr>
      <th>(4)</th>
      <th colspan="4">Project Cost Admitted by Bank </th>
      <th rowspan="4">(4) Bank can reduce project cost on the basis of Economic viability. Enter admitted project Cost details. </th>
    <tr>
      <th nowrap>&nbsp;</th>
      <th nowrap>(a) Capital Expenditure/Term Loan (in Rs) </th>
      <td colspan="3" nowrap><input name="MACHINARY_COST" type="text"  tabindex="6"    <%= READONLY %> onKeyPress="return numbersonly(event);" value="<%= MACHINARY_COST %>" size="12" maxlength="7"></td>
    <tr>
      <th>&nbsp;</th>
      <th>(b) Working Capital/Cash Credit (in Rs.) </th>
      <td colspan="3"><input name="WORKING_CAPITAL" type="text"  tabindex="8"   <%= READONLY %> onKeyPress="return numbersonly(event);" value="<%= WORKING_CAPITAL %>" size="12" maxlength="7"></td>
    <tr>
      <th>&nbsp;</th>
      <th> (c) Total  Project Cost Admitted (a+b) </th>
      <td colspan="3"><input name="TOT_SANC" type="text"  id="TOT_SANC"  size="12" readonly="true" style="background-color:#CC9900 "></td>
    <tr>
      <th>(5 )</th>
      <th>Loan Sanction Date :</th>
      <td colspan="3"><input name="LOAN_SANC_DT" type="text"  "<%= READONLY %>" <%= EVENT %>="popUpCalendar(this, this.form.LOAN_SANC_DT,'dd-mmm-yyyy');return false;" value="<%= LOAN_SANC_DT %>" size="12" maxlength="11"></td>
      <th>(5) Enter Loan Sanction Date </th>
    <tr>
      <th>(6)</th>
      <th>Whether Covered under CGTMS :</th>
      <td colspan="3"><select name="CGTSI" id="CGTSI">
          <option value="N" <% if (CGTSI.equals("N")||CGTSI.equals("")){ out.println("selected");}%>>No</option>
          <option value="Y" <% if (CGTSI.equals("Y")){ out.println("selected");}%>>Yes</option>
      </select></td>
      <th>(6) Select (Yes/No) for project covered under CGTMS </th>
    <tr>
      <th>(7)</th>
      <th><div align="right">Rate of Interest on Loan ( in %): </div></th>
      <td colspan="3"><input name="RINT"  id="RINT" type="text"  size="12" maxlength="5" value="<%= RINT %>">
        %</td>
      <th>(7) Enter Rate of Interest </th>
    <tr>
      <th>(8)</th>
      <th><div align="right">(A) Loan Repayment Period: </div></th>
      <td colspan="3"><input name="LOAN_PERIOD"  id="LOAN_PERIOD" type="text"   size="12" maxlength="3" value="<%= LOAN_PERIOD %>" >
        ( In Months) </td>
      <th>(8) Loan Repayment Period in Months </th>
    <tr>
      <th>&nbsp;</th>
      <th> <div align="right">(B) Moratorium period:</div></th>
      <th colspan="3"><input name="MOR_PER"  id="MOR_PER" type="text"   size="12" maxlength="3" value="<%= MOR_PER %>" >
        (in Months)</th>
      <th>&nbsp;</th>
    <tr>
      <th>&nbsp;</th>
      <th> <div align="right">Remarks if any: </div></th>
      <th colspan="3"><input name="LOAN_REMARKS" type="text"  id="LOAN_REMARKS" size="70" maxlength="100" value="<%= LOAN_REMARKS %>"></th>
      <th>Enter Remarks for Sanction condition if any. </th>
    <tr>
      <th>(9)</th>
      <th colspan="4"><div align="center">
          <input name="btnSanction" type="button" class="button" value="Download Sanction Letter" onClick=" openSancReport('<%= APP_ID %>');">
          <input name="btnSancSave" type="button" class="button" id="btnSancSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </div></th>
      <th>(9) Click on Generate Sanction Letter and Sanction letter will generate in pdf format. You can get Printed in Bank Letter head . </th>
    <tr>
      <th colspan="5"><div align="center">Own Contribution Deposit Details by Beneficiary (Stage-3)</div></th>
      <th>&nbsp;</th>
    <tr>
      <th>(10)</th>
      <th>Deposit date: </th>
      <td colspan="3"><input name="OWN_CONT_DT" type="text"  id="OWN_CONT_DT" tabindex="9" <%= READONLY %> <%= EVENT%>="popUpCalendar(this, this.form.OWN_CONT_DT,'dd-mmm-yyyy');return false;" value="<%=OWN_CONT_DT %>" size="12" maxlength="11"></td>
      <th>(10) Enter Beneficiary Contribution Deposit Date </th>
    <tr>
      <th>(11)</th>
      <th>Amount (in Rs.): </th>
      <td colspan="3"><input name="OWN_CONTRIBUTION" type="text"  id="OWN_CONTRIBUTION" tabindex="10"  <%= READONLY %> onKeyPress="return numbersonly(event);" value="<%=OWN_CONTRIBUTION %>" size="12" maxlength="6"></td>
      <th>(11) Enter Beneficiary Contribution Deposit Amount in Rupees </th>
    <tr>
      <th colspan="5"><div align="center">EDP Training Detail: </div></th>
      <th>&nbsp;</th>
    <tr>
      <th>(12)</th>
      <th>Training Center Name: </th>
      <td colspan="3"><input name="EDP_TRG_NAME" id="EDP_TRG_NAME" type="text" size="50" maxlength="50" value="<%= EDP_TRG_NAME %>"></td>
      <th>(12) Enter EDP training center name. </th>
    <tr>
      <th>(13)</th>
      <th>Training  Date From: </th>
      <td><input name="EDP_FR_DT" id="EDP_FR_DT" type="text" size="12" value="<%= EDP_FR_DT %>"></td>
      <th><div align="right">To: </div></th>
      <td><input name="EDP_TO_DT" id="EDP_TO_DT"type="text" size="12" value="<%= EDP_TO_DT %>"></td>
      <th>(13) Enter completed training from To period. </th>
    <tr>
      <th>(14)</th>
      <th>Certificate Issue Date: </th>
      <td colspan="3"><input name="EDP_CERT_DT"  id= "EDP_CERT_DT" type="text" size="12" value="<%= EDP_CERT_DT %>"></td>
      <th>(14) Enter Date of issue of Certificate. </th>
    <tr>
      <th colspan="5"><div align="center">Loan Released (Stage-4)
        <input name="MM_CLAIM_DT" type="hidden" tabindex="14" value="<%= MM_CLAIM_DT %>" <%= READONLY %> <%= EVENT %>="onClick=popUpCalendar(this, this.form.MM_CLAIM_DT,'dd-mmm-yyyy');return false;">
              <input name="MM_CLAIM_AMT" type="hidden" tabindex="16" onKeyPress="return numbersonly(event);" value="<%= MM_CLAIM_AMT %>" <%= READONLY %>>
              <input name="MM_REL_DT" type="hidden" tabindex="17" onClick="popUpCalendar(this, this.form.MM_REL_DT,'dd-mmm-yyyy');return false;" value="<%= MM_REL_DT %>">
              <input name="MM_REL_AMT" type="hidden" tabindex="18" onKeyPress="return numbersonly(event);" value="<%= MM_REL_AMT %>">
              <input name="PROD" type="hidden" tabindex="19" onKeyPress="return numbersonly(event);" value="<%= PROD %>">
              <input name="SALES" type="hidden" tabindex="20" onKeyPress="return numbersonly(event);" value="<%= SALES %>">
              <input name="EMP" type="hidden" tabindex="21" onKeyPress="return numbersonly(event);" value="<%= EMP %>">
      </div></th>
      <th>&nbsp;</th>
    <tr>
      <th>(15)</th>
      <th>Loan Release Date:</th>
      <td colspan="3"><input name="IST_LOAN_DT" type="text"   value="<%= IST_LOAN_DT %>" size="12" <%= READONLY %> <%= EVENT %>="popUpCalendar(this, this.form.IST_LOAN_DT,'dd-mmm-yyyy');return false;"></td>
      <th>(15) Enter Loan Release Date: </th>
    <tr>
      <th>(16)</th>
      <th>Loan Released Amount (in Rs.): </th>
      <td colspan="3"><input name="IST_LOAN_AMT" type="text"  tabindex="12" <%= READONLY %> onKeyPress="return numbersonly(event);" value="<%= IST_LOAN_AMT %>" size="12" maxlength="7"></td>
      <th>(16) Enter Loan Release Amount: </th>
    <tr>
      <th>(17)</th>
      <th>Loan Account No of Beneficiary </th>
      <td colspan="3"><input name="APPLOAN_ACCNO" id="APPLOAN_ACCNO" type="text"    size="20"  value="<%= APPLOAN_ACCNO %>"></td>
      <th>(17) Enter Beneficiary  Loan Account No. </th>
    <tr>
      <th colspan="5"><div align="center">Govt. Subsidy (MM) Online Claim (Stage -6) </div></th>
      <th>Note: Please Enter Valid Financing Branch Account No. </th>
    <tr>
      <th>(18)</th>
      <th> A/c No. of Financing Branch Account: </th>
      <td colspan="3"><input name="FB_ACNO"  id="FB_ACNO" type="text"  tabindex="15" <%= READONLY %> size="20" maxlength="20" value="<%= FB_ACNO %>"></td>
      <th><p>(18) Please Ente Valid Financing Branch Account No.Government Subsidy (MM) Will Transfer through PFMS System to Financing Bank Account after Validation. </p>      </th>
    <tr>
      <th>(19)</th>
      <th>A/c  Name: </th>
      <th colspan="3"><input name="FB_ACNAME" id="FB_ACNAME" type="text"  tabindex="15" <%= READONLY %> size="50" maxlength="100" value="<%= FB_ACNAME %>" ></th>
      <th>(19) Account Name of the Financing Branch </th>
    <tr>
      <th>(20)</th>
      <th>&nbsp;</th>
      <th colspan="3"><input name="btnClaim" type="button" class="button" id="btnClaim" value=" Submit  Online Govt Subsidy (MM) Claim" onClick="openMM('<%= APP_ID %>');">      </th>
      <th> (20) Click on &quot;Submit Online Subsidy(MM) Claim&quot; button for Final Submission </th>
    <tr>
      <th>(21)</th>
      <th colspan="4"><div align="center">Details of Margin Money (Subsidy) Claim Transfer through NEFT to Transient A/c of Bank </div></th>
      <th>&nbsp;</th>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">Transfer    Date: </div></td>
      <td colspan="3">&nbsp;</td>
      <td rowspan="3">(21) After Online Receipt of MM Claim , eligible Amount will be transfer to Transient Bank Account of Your Branch </td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">MM Amount: </div></td>
      <td colspan="3">&nbsp;</td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right"> Reference No: </div></td>
      <td colspan="3">&nbsp;</td>
    <tr>
      <th colspan="5">  <div align="center">TDR Account Detail (stage 7) </div></th>
      <th> On Receipt of Margin Money Claim, Financing Branch needs to be Deposit the same in the TDR Account of the Applicant as per Scheme Guidelines </th>
    <tr>
      <th>(22)</th>
      <th>Beneficiary TDR Account No: </th>
      <td colspan="3"><input name="TDR_ACNO" type="text" id="TDR_ACNO"  size="20" maxlength="20" value="<%= TDR_ACNO %>"></td>
      <th>(22)TDR Account No of the Beneficiary </th>
    <tr>
      <th>(23)</th>
      <th>Deposit Date in TDR: </th>
      <td colspan="3"><input name="TDR_ADJ_DT" id="TDR_ADJ_DT" type="text"  onClick="popUpCalendar(this, this.form.MM_ADJ_DT,'dd-mmm-yyyy');return false;" size="20" maxlength="20" value="<%= TDR_ADJ_DT %>"></td>
      <th>(23)Deposit Date in TDR by Financing Branch </th>
    <tr>
      <th colspan="5"><div align="center">Margin Money (Subsidy) Adjustment against TDR (Stage-7) </div></th>
      <th>&nbsp;</th>
    <tr>
      <th>(24)</th>
      <th>Adjustment Date: </th>
      <td colspan="3"><input name="MM_ADJ_DT" type="text"  onClick="popUpCalendar(this, this.form.MM_ADJ_DT,'dd-mmm-yyyy');return false;" value="<%= MM_ADJ_DT%>" size="12" maxlength="11"></td>
      <th>(24) Enter Date of Final adjustment of  Margin Money (Subsidy) againest Loan </th>
    <tr>
      <th>(25)</th>
      <th>Adjustment Amount</th>
      <td colspan="3"><input name="MM_ADJ_AMT" type="text"  tabindex="23" onKeyPress="return numbersonly(event);" value="<%=MM_ADJ_AMT %>" size="12" maxlength="7"></td>
      <th>(25) Enter Amount in Rupees of Final Adjustment of Margin Money </th>
    <tr>
      <th colspan="5"><div align="center">
          <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </div></th>
      <th>Finally Save Data. </th>
  </table>
 
</form>
</body>
</html>
