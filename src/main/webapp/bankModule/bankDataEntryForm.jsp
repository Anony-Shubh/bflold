<%@ page session="true" buffer="500kb" import="java.sql.*,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%@ page import="cdacuidai.VerifyAadhaarByID"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Bank Data Entry Form</TITLE>
<%@ include file="headerfile.jsp" %>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT type="text/javascript" src="../js/datetimepicker_css.js"></SCRIPT>
<SCRIPT language="javascript" src="../js/bankModule.js"></SCRIPT>
<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>
<SCRIPT src="../js/ModalPopupWindow.js" type="text/javascript"></SCRIPT>
 <SCRIPT language="javascript" src="../js/jquery-1.12.4.js"></SCRIPT>  
<SCRIPT type="text/javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
<SCRIPT type="text/javascript">
function show(){
var SCHEME_NM=document.form1.BANK_COMMENT.value;
//alert(SCHEME_NM);
    if (SCHEME_NM == "TDR"){
 	 TDR.style.display = "block"; 
	  TDR1.style.display = "block"; 
	}
	else {
		TDR.style.display = "none"; 
		 TDR1.style.display = "none"; 
		
	}
 if (SCHEME_NM == "SRF"){
	 // alert(SCHEME_NM);
 	 SRF.style.display = "block";
	 SRF1.style.display = "block"; 
	}
  else{
	   SRF.style.display = "none"; 
	   SRF1.style.display = "none"; 
  }
}
function clearEDP(){
      
        document.getElementById("EDP_TRG_NAME").value = "";
        document.getElementById("EDP_FR_DT").value = "";
		 document.getElementById("EDP_TO_DT").value = "";
        document.getElementById("EDP_CERT_DT").value = "";
		insUpdate();
    }
</SCRIPT>
<STYLE type="text/css">
<!--
.style1 {color: #FF0000}
.style2 {
	color: #000000;
	font-weight: bold;
	font-size: 20px;

}
-->
</STYLE>
</HEAD>
<BODY onLoad="loan_calc();Status_change();show();">
<FORM  method="post"  name="form1" id="form1" action="bankDataEntryForm.jsp" >
  
  <%
  int ACT=0;
  String CLIENT_IP= (String)session.getAttribute("SCLIENTIP");
  String MMCLAIM=request.getParameter("MMCLAIM")==null?"N":(String)request.getParameter("MMCLAIM") ;
  String ins=request.getParameter("ins")==null?"":(String)request.getParameter("ins") ;
String flg="Y";
String APP_NAME="";
String BENF_TYPE="";
String APP_ID = (String)session.getAttribute("SAPP_ID");
String IFSC_CODE=(String)session.getAttribute("bank_id");
  String adhvalid="F";

try {
VerifyAadhaarByID v= new VerifyAadhaarByID();	
adhvalid=v.VerifyAad(APP_ID, "AG");
}catch (Exception e) {}
String REJ_ID="";
String REJ_DESC="";
String AADHAR_NO="";
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
String PAN_NO="";
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
String OFF_CD="";
String QUALI = "";
String BENF_CATEGORY_CD = "";
String BENF_CATEGORY_DESC = "";
String IND_TYPE="";
String PROJ_COST="";
String OWN_CONT_PER="";
String MM_ELIG_PER="";
String BANK_LOAN_PER="";
String RECOM_CE="";
String RECOM_WC="";
String RINT="";
String LOAN_PERIOD="";
String LOAN_REMARKS="";
String BOFFCD="";
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
String STATE_CD="";
 String NEFT_IFSC="";
 String TRANS_ACNO="";
 String TOTAL_SANC_FB="";
String MOB_NO1="";
String E_MAIL="";
String mmeligible="";
String online_subdt="";
String APP_TYPE="";
String DMMELGB="";
DBCon db= new DBCon();
db.connect();
ResultSet rsTrno=null;
try {

StringBuffer av= new StringBuffer();
av.append("SELECT a.tr_id,a.OFF_CD, b.app_id,a.act_id, to_char(a.bank_rec_dt,'DD-MON-YYYY') AS  bank_rec_dt, MS.STATE_CD,bank_remarks,AM.activity_name,100-OWNCONT_PER(B.APP_ID) AS BANK_LOAN_PER,a.RINT,a.LOAN_PERIOD, ").
append(" b.gender,b.unit_loc,C.benf_category_cd,C.benf_category_desc,d.edu_desc||' (Tech: '||b.tech_quali ||')' as quali,DECODE(B.ind_type,'M','Manufacturing','Service') as ind_type,A.LOAN_REMARKS, "). 
append(" CASE WHEN NVL(B.DLTFC_CE,0)+ NVL(B.DLTFC_WC,0)>100 THEN NVL(B.DLTFC_CE,0) ELSE nvl(B.machinary_cost,0) END AS Proj_cost_CE,B.MOB_NO1,B.E_MAIL,a.REJ_ID,(SELECT REJ_DESC FROM REJECTION_MAST WHERE REJ_ID=a.REJ_ID) AS REJ_DECS,  ").
append(" CASE WHEN NVL(B.DLTFC_CE,0)+ NVL(B.DLTFC_WC,0)>100 THEN NVL(B.DLTFC_WC,0) ELSE nvl(B.working_capital,0) END AS Proj_cost_WC,  ").
append(" CASE WHEN NVL(B.DLTFC_CE,0)+ NVL(B.DLTFC_WC,0)>100 THEN NVL(B.DLTFC_WC,0)+NVL(B.DLTFC_CE,0) ELSE nvl(B.working_capital,0)+nvl(B.machinary_cost,0) END AS Proj_cost,  ").
append(" OWNCONT_PER(B.APP_ID) AS OWN_CONT_PER,MM_PER(B.APP_ID) AS MM_ELIG_PER,mmeligible(a.app_id) as mmeligible,MMINV_BANKADMIT(a.APP_ID) as DMMELGB, ").
append(" a.EDP_TRG_NAME, to_char(a.EDP_FR_DT,'DD-MON-RRRR') AS EDP_FR_DT,to_char(a.EDP_TO_DT,'DD-MON-RRRR') AS EDP_TO_DT , to_char(a.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT, ").
append(" a.APPLOAN_ACCNO,a.FB_ACNO,a.FB_ACNAME,a.TDR_ACNO,to_char(a.TDR_ADJ_DT,'DD-MON-RRRR') AS TDR_ADJ_DT,A.MOR_PER,A.MM_ADJ_AMT ,TO_CHAR(A.MM_ADJ_DT,'DD-MON-YYYY') AS MM_ADJ_DT ,to_char(B.online_subdt,'dd-mon-rrrr') as online_subdt,case when trunc(b.online_subdt) > '31-MAY-2022' THEN '(NEW)' ELSE '(OLD)' END AS APP_TYPE,").
append(" CASE WHEN LENGTH(B.AADHAR_NO)=12  THEN B.AADHAR_NO ELSE 0 END AADHAR_NO ,A.CE_SANC_FB,A.WC_SANC_FB,  nvl(A.CE_SANC_FB,0)+nvl(A.WC_SANC_FB,0) TOTAL_SANC_FB ,").
append(" CASE WHEN LENGTH(B.PAN_NO)=10  THEN B.PAN_NO ELSE '-' END PAN_NO, ").
append(" to_char(a.loan_sanc_dt,'DD-MON-YYYY') AS loan_sanc_dt, a.workshed_cost, a.working_capital, a.machinary_cost, a.pre_ope_cost, nvl(a.working_capital,0)+ nvl(a.machinary_cost,0) AS TOTPRJ_BANK_ADMIT,").
append ( " a.own_contribution, to_char(a.own_cont_dt,'DD-MON-YYYY') AS own_cont_dt, a.ist_loan_amt, to_char(a.ist_loan_dt,'DD-MON-YYYY') AS ist_loan_dt, a.cgtsi," ).
append ( " a.mm_claim_lrno, to_char(a.mm_claim_dt,'DD-MON-YYYY') AS  mm_claim_dt, a.mm_claim_amt, a.mm_rel_amt, ").
append ( " to_char(a.mm_rel_dt,'DD-MON-YYYY') as  mm_rel_dt, UPPER(b.app_name) AS APP_NAME, a.emp, a.prod, a.sales, " ).
append ( " to_char(a.tdr_adj_dt,'DD-MON-YYYY') as tdr_adj_dt, a.tdr_adj_amt,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,B.IFSC_CODE, " ).
 append ( " a.bank_comment,  to_char(a.time_stamp,'DD-MON-YYYY:HH:MM:SS') as time_stamp "). 
  append (" FROM bank_dataentry a, app_detail b,BENF_CATEGORY_MAST C,education_mast d , ACTIVITY_MAST AM,M_DISTRICT MD,M_STATE MS WHERE B.ACTIVITY_CD=AM.ACTIVITY_CD AND  b.APP_ID=? AND B.IFSC_CODE=?").
  append ("  AND B.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD and b.app_id=a.app_id(+) and b.benf_catagory_cd=C.benf_category_cd and b.EDU_ID=d.edu_id ");
			
			List values=new ArrayList();
     values.add (APP_ID); 
	 values.add (IFSC_CODE);
			
ResultSet rsApp = db.executeSQL(av.toString(),values);


values.clear();
values.add (IFSC_CODE); 
values.add (IFSC_CODE); 
out.print ("IFSCCODE"+IFSC_CODE);
rsTrno= db.executeSQL("SELECT NVL(NEFT_IFSC,BR_IFSL_CODE) AS NEFT_IFSC,TRANS_ACNO FROM BANK_BR_MAST  WHERE BR_IFSL_CODE=? UNION SELECT BTM.NEFT_IFSC_CODE|| '('||BTM.AC_DESC||')' AS NEFT_IFSC, BTM.TRAC_NO  AS TRANS_ACNO FROM BANK_TRANS_ACMAST BTM WHERE ACT_YN='Y' AND  BTM.NEFT_IFSC_CODE=?",values);
values.clear();



 values.add (APP_ID); 
ResultSet rsEDPOFF=db.executeSQL("SELECT regexp_replace(REGEXP_SUBSTR(EDP_TRG_NAME, '\\((.+)\\)', 1, 1, NULL, 1),'[^0-9]') AS OFF_CD FROM  BANK_DATAENTRY WHERE APP_ID=?",values);
	 values.clear();
	
	 while (rsEDPOFF.next()) {
	
	 BOFFCD=rsEDPOFF.getString(1)==null?"":rsEDPOFF.getString(1);
	 }
	 rsEDPOFF.close();
	 
	  List pstm=new ArrayList();
	StringBuffer sb= new StringBuffer();
		sb.append("   UPDATE BANK_DATAENTRY SET OFF_CD=? ").
		append("    WHERE APP_ID=? AND EDP_TRG_NAME IS NOT NULL  ");		
		db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		values.add (BOFFCD);pstm.add ("D"); 
		values.add (APP_ID);pstm.add ("D"); 
		db.executeUpdate();		
		values.clear();
        pstm.clear();
		
		 
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
	
	if (rsApp.getString("REJ_ID") != null){
		REJ_ID = rsApp.getString("REJ_ID");
	}else{
		REJ_ID = "";
	}
	if (rsApp.getString("REJ_DECS") != null){
		REJ_DESC = rsApp.getString("REJ_DECS");
	}else{
		REJ_DESC = "";
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
	
	
	if (rsApp.getString("MM_ADJ_AMT") != null){
		MM_ADJ_AMT = rsApp.getString("MM_ADJ_AMT");
	}else{
		MM_ADJ_AMT = "";
	}
	
	if (rsApp.getString("MM_ADJ_DT") != null){
		MM_ADJ_DT = rsApp.getString("MM_ADJ_DT");
	}else{
		MM_ADJ_DT = "";
	}
	
	 OWN_CONT_PER=rsApp.getString("OWN_CONT_PER")==null?"0":rsApp.getString("OWN_CONT_PER");
	 MM_ELIG_PER=rsApp.getString("MM_ELIG_PER")==null?"0":rsApp.getString("MM_ELIG_PER");
	 BANK_LOAN_PER=rsApp.getString("BANK_LOAN_PER")==null?"0":rsApp.getString("BANK_LOAN_PER");
	RINT=rsApp.getString("RINT")==null?"":rsApp.getString("RINT");
	LOAN_PERIOD=rsApp.getString("LOAN_PERIOD")==null?"0":rsApp.getString("LOAN_PERIOD");
	LOAN_REMARKS=rsApp.getString("LOAN_REMARKS")==null?"":rsApp.getString("LOAN_REMARKS");	
	
	OFF_CD=rsApp.getString("OFF_CD")==null?"":rsApp.getString("OFF_CD");
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
	
	RECOM_CE=rsApp.getString("Proj_cost_CE")==null?"":rsApp.getString("Proj_cost_CE");
    RECOM_WC=rsApp.getString("Proj_cost_WC")==null?"":rsApp.getString("Proj_cost_WC");

	
	AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
	PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
	
	CE_SANC_FB=rsApp.getString("CE_SANC_FB")==null?"":rsApp.getString("CE_SANC_FB");
	WC_SANC_FB=rsApp.getString("WC_SANC_FB")==null?"":rsApp.getString("WC_SANC_FB");
    TOTAL_SANC_FB=rsApp.getString("TOTAL_SANC_FB")==null?"":rsApp.getString("TOTAL_SANC_FB");
	E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
	MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
	STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");
	
	online_subdt=rsApp.getString("online_subdt")==null?"":rsApp.getString("online_subdt");
	APP_TYPE=rsApp.getString("APP_TYPE")==null?"":rsApp.getString("APP_TYPE");
	mmeligible=rsApp.getString("mmeligible")==null?"":rsApp.getString("mmeligible");
	DMMELGB=rsApp.getString("DMMELGB")==null?"":rsApp.getString("DMMELGB");
	
	} //end of resultset	
	//END OF BANK DATA
	rsApp.close();
//	out.print(ACT_ID);
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
		
		OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
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
		CE_SANC_FB=(String) request.getParameter("CE_SANC_FB")==null?"":(String) request.getParameter("CE_SANC_FB").trim();
		WC_SANC_FB=(String) request.getParameter("WC_SANC_FB")==null?"":(String) request.getParameter("WC_SANC_FB").trim();
		TOTAL_SANC_FB=(String) request.getParameter("TOT_SANC_FB")==null?"":(String) request.getParameter("TOT_SANC_FB").trim();
		STATE_CD=(String) request.getParameter("STATE_CD")==null?"":(String) request.getParameter("STATE_CD").trim();
		REJ_ID=(String) request.getParameter("REJ_ID")==null?"":(String) request.getParameter("REJ_ID").trim();
		REJ_DESC=(String) request.getParameter("REJ_DESC")==null?"":(String) request.getParameter("REJ_DESC").trim();
		
		
		
		
		String validateqry="SELECT * FROM TABLE(GET_PMEGP_BANKERROR(?,?,?,?,?,?,?,?,?,?,?,? ,?,?,?,? ,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?) )";

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
		values.add (IFSC_CODE);
		values.add (WC_SANC_FB);
		values.add (CE_SANC_FB);
		values.add (MM_CLAIM_AMT);
		values.add (TR_ID);
		values.add (FB_ACNO);
		values.add (TDR_ADJ_DT);
		values.add (TDR_ACNO);
		values.add (EDP_TRG_NAME);
		values.add (EDP_FR_DT);
		values.add (EDP_TO_DT);
		values.add (EDP_CERT_DT);
		values.add (MM_ADJ_DT);
		values.add (MM_ADJ_AMT);
		values.add (REJ_ID);

ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;

while (rsValidate.next()){
errcount =errcount+1;
verror=verror+""+rsValidate.getString(2)+"<br>";
}
rsValidate.close();


if (errcount<1){

try {
 Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
Connection conn=ds.getConnection(); 

CallableStatement cs = conn.prepareCall("{call  PMEGPNEW_UPDATE_BANKDATA (?,?,?,?,?,?,?,?,?,?,?,? ,?,?,?,? ,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?)}");



 cs.setString(1,APP_ID); 
	cs.setInt(2,Integer.parseInt(ACT_ID));
	cs.setString(3,BANK_REC_DT);
	cs.setString(4,LOAN_SANC_DT);
	cs.setString(5,WORKING_CAPITAL);
	cs.setString(6,MACHINARY_COST);
	cs.setString(7,CGTSI);
	cs.setString(8,RINT);
	cs.setString(9,LOAN_PERIOD);
	cs.setString(10,MOR_PER);
	cs.setString(11,LOAN_REMARKS);
	cs.setString(12,BANK_REMARKS);
		cs.setString(13,OWN_CONT_PER);
		cs.setString(14,MM_ELIG_PER);
		cs.setString(15,OWN_CONT_DT);
		cs.setString(16,OWN_CONTRIBUTION);
		cs.setString(17,IST_LOAN_DT);
		cs.setString(18,IST_LOAN_AMT);
		cs.setString(19,APPLOAN_ACCNO);
		cs.setString(20,IFSC_CODE);
		cs.setString(21,WC_SANC_FB);
		cs.setString(22,CE_SANC_FB);
		cs.setString(23,MM_CLAIM_AMT);
		cs.setString(24,TR_ID);
		
		
		cs.setString(25,FB_ACNO);
		cs.setString(26,TDR_ADJ_DT);
		cs.setString(27,TDR_ACNO);
		cs.setString(28,EDP_TRG_NAME);
		cs.setString(29,EDP_FR_DT);
		cs.setString(30,EDP_TO_DT);
		cs.setString(31,EDP_CERT_DT);
		cs.setString(32,MM_ADJ_DT);
		cs.setString(33,MM_ADJ_AMT);
		cs.setString(34,REJ_ID);
		cs.setString(35,OFF_CD);
		cs.setString(36,CLIENT_IP);

cs.executeQuery();
cs.close();
conn.close();

}catch (Exception b) {
out.print (b.toString());
}


}


		
		}//end of ins
	}catch (Exception e) {
	
	out.print (e.toString());
	}	
		
%>
  
  <TABLE width="100%">
    <TR>
      <TH colspan="4" nowrap><DIV align="center" class="style29 style39">BANK DETAIL UPDATION FORM </DIV></TH>
    </TR>
    <TR>
      <TH colspan="4" ><DIV align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <INPUT name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %> and Amount in Rs) </DIV></TH>
    </TR>
    <TR>
      <TH  ><DIV align="right">
        <INPUT name="STATE_CD" type="hidden"  id="STATE_CD" value="<%= STATE_CD %>">
        Applicant ID : </DIV></TH>
      <TH  > <DIV align="left">
          <INPUT name="APP_ID" type="hidden"  id="APP_ID" value="<%= APP_ID %>" size="15" >
          <%= APP_ID %> </DIV></TH>
      <TH   ><DIV align="right">Applicant Name:</DIV></TH>
      <TH ><INPUT name="APP_NAME" type="hidden"  id="APP_NAME" value="<%= APP_NAME %>" >
        <%= APP_NAME %> </TH>
    </TR>
    <TR>
      <TH  ><DIV align="right" class="style29 ">Gender:</DIV></TH>
      <TH  ><DIV align="left"><%= GENDER %>&nbsp;</DIV></TH>
      <TH  ><DIV align="right">Category:</DIV></TH>
      <TH  ><%= BENF_CATEGORY_DESC %>
      <INPUT name="MMCLAIM" type="hidden" id="MMCLAIM" value="<%= MMCLAIM %>"></TH>
    </TR>
    <TR>
      <TH  ><DIV align="right">Aadhaar Card No: </DIV></TH>
      <TH  ><%= AADHAR_NO %></TH>
      <TH  ><DIV align="right">PAN NO: </DIV></TH>
      <TH  ><%= PAN_NO %></TH>
    </TR>
    <TR>
      <TH  ><DIV align="right">Applicant Contact No: </DIV></TH>
      <TH  ><%= MOB_NO1  %></TH>
      <TH  ><DIV align="right">Applicant email:</DIV></TH>
      <TH  ><%= E_MAIL %></TH>
    </TR>
    <TR>
      <TH  ><DIV align="right"><SPAN class="style29 ">Unit Location</SPAN><SPAN class="style29 style33">: </SPAN></DIV></TH>
      <TH  ><DIV align="left"><%= UNIT_LOC %></DIV></TH>
      <TH  > <DIV align="right">Project Cost Recomended : </DIV></TH>
      <TH  >Rs.
        <INPUT name="PROJ_COST" type="hidden"  id="PROJ_COST" tabindex="0" value="<%=PROJ_COST %>" size="15" readonly="true">
        <%=PROJ_COST %>
        <INPUT name="OWN_CONT_PER" type="hidden"  id="OWN_CONT_PER" tabindex="0" value="<%= OWN_CONT_PER %>" >
        (CE:<%= RECOM_CE %>,WC:<%= RECOM_WC %>)</TH>
    </TR>
    <TR>
      <TH  ><DIV align="right" class="style29 ">Industry Type: </DIV></TH>
      <TH  ><DIV align="left"><%= IND_TYPE %></DIV></TH>
      <TH  > <DIV align="right">Beneficary Contribution (Own Contribution) 
          <INPUT name="MM_ELIG_PER" type="hidden"  id="MM_ELIG_PER" tabindex="0" value="<%= MM_ELIG_PER %>" size="2" maxlength="2" readonly="true">
      :</DIV></TH>
      <TH> <%= OWN_CONT_PER %>% </TH>
    </TR>
    <TR>
      <TH  ><DIV align="right" >Industry:</DIV></TH>
      <TH  ><%= ACTIVITY_NAME %></TH>
      <TH  ><DIV align="right">Bank Finance / Loan Sanction</DIV></TH>
      <TH  ><%= BANK_LOAN_PER %>%</TH>
    </TR>
   <TR>
      <TH  ><DIV align="right">Online Submission Date:</DIV></TH>
      <TH  ><DIV align="left"><%= online_subdt %><%=APP_TYPE%></DIV></TH>
      <TH  ><DIV align="right">Maximum Project Cost For Margin Money:</DIV></TH>
      <TH  ><%=mmeligible%></TH>
    </TR>
    <TR>
      <TH  ><DIV align="right">Qualification</DIV></TH>
      <TH  ><DIV align="left"><%= QUALI %></DIV></TH>
      <TH  ><DIV align="right">Govt. Subsidy(MM) Eligible:</DIV></TH>
      <TH  ><%= MM_ELIG_PER %>%</TH>
    </TR>
  </TABLE>
  <% if (!verror.equals("")) {%>
<DIV class="error style2">

<%
out.print (verror);
%> </DIV>
<%}%>

 <% if (verror.equals("") && ins.equals("I")) {%>
<DIV class="success"> 

<%
if (MMCLAIM.equals("Y")){
response.sendRedirect("bankfinalsubmissionClaim.jsp");
}
out.print (" Sucessfully Updated....");
%> </DIV>
<%}%>


  <TABLE>
    <TR>
      <TH colspan="5" ><DIV align="center" >Application  Status Updation (Stage 1)
          <INPUT name="ACT_ID" id="ACT_ID" type="radio" value="0" checked="checked" disabled="disabled" <% if (vACT_ID==0){out.print("Checked");}%> onChange="Status_change();">
      </DIV></TH>
      <TH  nowrap > <DIV align="center" >Guideline/Description </DIV></TH>
    <TR>
      <TH> (1)</TH>
	
      <TH>Application / Documents Received Date:*</TH>
      <TD colspan="3">
<INPUT name="BANK_REC_DT" id="BANK_REC_DT" type="text"  tabindex="0" value="<%= BANK_REC_DT %>" onClick="javascript:NewCssCal('BANK_REC_DT','ddMMMyyyy')" size="12" PLACEHOLDER="dd-mom-yyyy" AUTOCOMPLETE="off" ></TD>
      <TH>(1) Enter Date on which Application and Documents of Beneficiary Received. </TH>
    <TR>
      <TH> (2) </TH>
      <TH> Select Current Status at Bank:*</TH>
      <TD colspan="3" nowrap><INPUT name="ACT_ID" id="ACT_ID" type="radio" value="8" <% if (vACT_ID==8){out.print("Checked");}%> onChange="Status_change();">
        Under Process
        <INPUT name="ACT_ID"  id="ACT_ID" type="radio" value="11"  <% if (vACT_ID==11){out.print("Checked");}%> onChange="Status_change();" >
        <SPAN class="GreenLebel">Loan Sanctioned</SPAN>
        <INPUT name="ACT_ID" id="ACT_ID" type="radio" value="3" <% if (vACT_ID==3){out.print("Checked");}%> onChange="Status_change();">
        <SPAN class="redLebel"> Rejected/Return</SPAN></TD>
      <TH>(2) Select Application Status ( Under Process/Rejected/Loan Sanctioned   )	  </TH>
    <TR>
      <TH>a)</TH>
      <TH>Select Rejection Reason </TH>
      <TD colspan="3" nowrap><INPUT name="REJ_DESC" type="text" id="REJ_DESC" value="<%= REJ_DESC %>" size="50" maxlength="50" >
	  <INPUT name="REJ_ID" type="hidden" id="REJ_ID" value="<%= REJ_ID %>" size="50" maxlength="50" >
        <INPUT name="btnREJL" type="button" class="buttonBlue" id="btnREJL" value="Select Rejection Reason" style="background-color:#CCFF00;color:#FF0000;" onClick="ShowRejList();">		</TD>
      <TH nowrap>&nbsp;</TH>
    <TR>
      <TH>(3)</TH>
      <TH>Remarks ( Rejection / Under Process ) :</TH>
      <TD colspan="3" nowrap><INPUT name="BANK_REMARKS" id="BANK_REMARKS" type="text"  tabindex="3" value="<%=BANK_REMARKS %>" size="50" maxlength="100" AUTOCOMPLETE="off" ></TD>
      <TH nowrap>(3) Enter Remarks for Rejection/ Under Process </TH>
    <TR>
      <TH colspan="5"><DIV align="center">
        <INPUT name="btnStatusSave" type="button" class="button" id="btnStatusSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </DIV></TH>
      <TH>-</a></TH>
    <TR>
      <TD colspan="5"><DIV align="center"><SPAN class="GreenLebel">Total Project Cost and Loan Sanction (Stage-2)
        </SPAN>
        <INPUT name="ins" type="hidden" id="ins">
              <INPUT name="WORKSHED_COST" type="hidden" tabindex="5"   value="<%= WORKSHED_COST %>" >
              <INPUT name="PRE_OPE_COST" type="hidden" tabindex="7"   value="<%= PRE_OPE_COST %>"  >
              <INPUT name="TOT_CE" type="hidden"  id="TOT_CE" style="background-color:#CC9900" value="">
      </DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TH>(4)</TH>
      <TH>Project Cost Detail: </TH>
      <TH colspan="2"> <DIV align="center">Total Project Cost Approved by Bank </DIV></TH>
      <TH> <DIV align="center">Bank Finance / Loan Sanction (<%= BANK_LOAN_PER %>%) </DIV></TH>
      <TH rowspan="4">(4) Bank can reduce project cost on the basis of Economic viability. Enter admitted project Cost details. </TH>
    <TR>
      <TH nowrap>&nbsp;</TH>
      <TH nowrap>(a) Capital Expenditure/Term Loan (in Rs) </TH>
      <TD colspan="2" nowrap><DIV align="center">
        <INPUT name="MACHINARY_COST" id="MACHINARY_COST" type="text"  tabindex="6"      value="<%= MACHINARY_COST %>" size="12" maxlength="7" onChange="loan_calc();">
      </DIV></TD>
      <TD nowrap><DIV align="center">
        <INPUT name="CE_SANC_FB" id="CE_SANC_FB" type="text"  tabindex="6"      value="<%= CE_SANC_FB %>" size="12" maxlength="7" onChange="loan_sanc();" >
      </DIV></TD>
    <TR>
      <TH>&nbsp;</TH>
      <TH>(b) Working Capital/Cash Credit (in Rs.) </TH>
      <TD colspan="2"><DIV align="center">
        <INPUT name="WORKING_CAPITAL" id="WORKING_CAPITAL" type="text"  tabindex="8"     value="<%= WORKING_CAPITAL %>" size="12" maxlength="7" onChange="loan_calc();">
      </DIV></TD>
      <TD><DIV align="center">
        <INPUT name="WC_SANC_FB" id="WC_SANC_FB" type="text"  tabindex="8"     value="<%= WC_SANC_FB %>" size="12" maxlength="7" onChange="loan_sanc();" >
      </DIV></TD>
    <TR>
      <TH>&nbsp;</TH>
      <TH> (c) Total  Project Cost  (a+b) </TH>
      <TH colspan="2"><DIV align="center">
        <INPUT name="TOT_SANC" id="TOT_SANC" type="text" size="12" readonly="true" value="">
</DIV></TH>
      <TH><DIV align="center">
        <INPUT name="TOT_SANC_FB" type="text"  id="TOT_SANC_FB"  size="12" readonly="true" value="<%= TOTAL_SANC_FB %>">
        </DIV></TH>
    <TR>
      <TH>(5 )</TH>
      <TH>Loan Sanction Date :</TH>
      <TD colspan="3"><INPUT name="LOAN_SANC_DT" type="text"  id="LOAN_SANC_DT" PLACEHOLDER="DD-MON-YYYY"   onClick="javascript:NewCssCal('LOAN_SANC_DT','ddMMMyyyy')"  value="<%= LOAN_SANC_DT %>" size="12" maxlength="12" AUTOCOMPLETE="off"></TD>
      <TH>(5) Enter Loan Sanction Date </TH>
    <TR>
      <TH>(6)</TH>
      <TH>Whether Covered under CGTMS :</TH>
      <TD colspan="3"><SELECT name="CGTSI" id="CGTSI">
          <OPTION value="N" <% if (CGTSI.equals("N")||CGTSI.equals("")){ out.println("selected");}%>>No</OPTION>
          <OPTION value="Y" <% if (CGTSI.equals("Y")){ out.println("selected");}%>>Yes</OPTION>
      </SELECT></TD>
      <TH>(6) Select (Yes/No) for project covered under CGTMS </TH>
    <TR>
      <TH>(7)</TH>
      <TH><DIV align="right">Rate of Interest on Loan ( in %): </DIV></TH>
      <TD colspan="3"><INPUT name="RINT"  id="RINT" type="text"  size="12" maxlength="5" value="<%= RINT %>" AUTOCOMPLETE="off">
        %</TD><INPUT name="DMMELGB"  id="DMMELGB" type="hidden" size="12" value="<%= DMMELGB %>" >
      <TH>(7) Enter Rate of Interest </TH>
    <TR>
      <TH>(8)</TH>
      <TH><DIV align="right">(A) Loan Repayment Period: </DIV></TH>
      <TD colspan="3"><INPUT name="LOAN_PERIOD"  id="LOAN_PERIOD" type="text"   size="12" maxlength="3" value="<%= LOAN_PERIOD %>" AUTOCOMPLETE="off" >
        ( In Months) </TD>
      <TH>(8) Loan Repayment Period in Months </TH>
    <TR>
      <TH>&nbsp;</TH>
      <TH> <DIV align="right">(B) Moratorium period:</DIV></TH>
      <TH colspan="3"><INPUT name="MOR_PER"  id="MOR_PER" type="text"   size="12" maxlength="3" value="<%= MOR_PER %>" AUTOCOMPLETE="off" >
        (in Months)</TH>
      <TH>&nbsp;</TH>
    <TR>
      <TH>&nbsp;</TH>
      <TH> <DIV align="right">Remarks if any: </DIV></TH>
      <TH colspan="3"><INPUT name="LOAN_REMARKS" type="text"  id="LOAN_REMARKS" size="70" maxlength="100" value="<%= LOAN_REMARKS %>" AUTOCOMPLETE="off"></TH>
      <TH>Enter Remarks for Sanction condition if any. </TH>
    <TR>
      <TH>(9)</TH>
      <TH colspan="4"><DIV align="center">
          <INPUT name="btnSancSave" type="button" class="button" id="btnSancSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </DIV></TH>
      <TH>(9) Click on Generate Sanction Letter and Sanction letter will generate in pdf format. You can get Printed in Bank Letter head . </TH>
    <TR>
      <TD colspan="5"><DIV align="center" class="GreenLebel">Own Contribution Deposit Details by Beneficiary (Stage-3)</DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TH>(10)</TH>
      <TH>Deposit date: </TH>
      <TD colspan="3"><INPUT name="OWN_CONT_DT" type="text"  id="OWN_CONT_DT" PLACEHOLDER="DD-MON-YYYY" tabindex="9"  onClick="javascript:NewCssCal('OWN_CONT_DT','ddMMMyyyy')"  value="<%=OWN_CONT_DT %>" size="12" maxlength="11"></TD>
      <TH>(10) Enter Beneficiary Contribution Deposit Date </TH>
    <TR>
      <TH>(11)</TH>
      <TH>Amount (in Rs.): </TH>
      <TD colspan="3"><INPUT name="OWN_CONTRIBUTION" type="text"  id="OWN_CONTRIBUTION" tabindex="10"    value="<%=OWN_CONTRIBUTION %>" size="12" maxlength="12"></TD>
      <TH>(11) Enter Beneficiary Contribution Deposit Amount in Rupees </TH>
    <TR>
      <TD colspan="5"><DIV align="center" class="GreenLebel">EDP Training Detail</DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TH>&nbsp;</TH>
      <TD colspan="4"><DIV align="center" class="mtextarea"></DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TH>(12)</TH>
      <TH>Training Center Name: </TH>
      <TD colspan="3"><INPUT name="EDP_TRG_NAME" type="text" id="EDP_TRG_NAME" value="<%= EDP_TRG_NAME %>" size="50" maxlength="50" readonly="true">
	   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD%>" size="50" maxlength="50" >
        <INPUT name="btnEDP" type="button" class="buttonBlue" id="btnEDP" style="background-color:#0000CC" value="Select  EDP Centers" onClick="ShowEdpList();"></TD>
      <TH>(12) Enter EDP training center name. </TH>
    <TR>
      <TH>(13)</TH>
      <TH>Training  Date From:      </TH>
      <TD><INPUT name="EDP_FR_DT" type="text" id="EDP_FR_DT" PLACEHOLDER="DD-MON-YYYY" onClick="javascript:NewCssCal('EDP_FR_DT','ddMMMyyyy')" value="<%= EDP_FR_DT %>" size="12" maxlength="12" ></TD>
      <TH><DIV align="right">To: </DIV></TH>
      <TD><INPUT name="EDP_TO_DT"type="text" id="EDP_TO_DT" PLACEHOLDER="DD-MON-YYYY" onClick="javascript:NewCssCal('EDP_TO_DT','ddMMMyyyy')" value="<%= EDP_TO_DT %>" size="12" maxlength="12" ></TD>
      <TH>(13) Enter completed training from To period. </TH>
    <TR>
      <TH>(14)</TH>
      <TH>Certificate Issue Date: </TH>
      <TD><INPUT name="EDP_CERT_DT" type="text"  id= "EDP_CERT_DT" PLACEHOLDER="DD-MON-YYYY" onClick="javascript:NewCssCal('EDP_CERT_DT','ddMMMyyyy')" value="<%= EDP_CERT_DT %>" size="12" maxlength="12" AUTOCOMPLETE="off" ></TD>
      <TD colspan="2"><INPUT name="Button" type="button" class="buttonMerun" onClick="clearEDP();" style="background-color:#0000CC" value="CLEAR EDP DATA" title="After Clear Data Please Click on Save Button"></TD>
      <TH>(14) Enter Date of issue of Certificate. </TH>
    <TR>
      <TH colspan="5"><DIV align="center">
        <INPUT name="btnSancSave" type="button" class="button" id="btnSancSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </DIV></TH>
      <TH>&nbsp;</TH>
    <TR>
      <TD colspan="5"><DIV align="center"><SPAN class="GreenLebel">Loan Released (Stage-4)</SPAN>        <INPUT name="MM_CLAIM_DT" type="hidden" tabindex="14" value="<%= MM_CLAIM_DT %>">
              <INPUT name="MM_REL_DT" type="hidden" tabindex="17">
              <INPUT name="MM_REL_AMT" type="hidden" tabindex="18"  value="<%= MM_REL_AMT %>">
              <INPUT name="PROD" type="hidden" tabindex="19"  value="<%= PROD %>">
              <INPUT name="SALES" type="hidden" tabindex="20"  value="<%= SALES %>">
              <INPUT name="EMP" type="hidden" tabindex="21"  value="<%= EMP %>">
      </DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TH>(15)</TH>
      <TH>Last Date of Loan Release:</TH>
      <TD colspan="3"><INPUT name="IST_LOAN_DT" id="IST_LOAN_DT" PLACEHOLDER="DD-MON-YYYY" type="text"  onClick="javascript:NewCssCal('IST_LOAN_DT','ddMMMyyyy')"  value="<%= IST_LOAN_DT %>" size="12" maxlength="12"   autocomplete="off"></TD>
      <TH>(15) Enter Loan Release Date: </TH>
    <TR>
      <TH>(16)</TH>
      <TH>Total Loan Amount Released (in Rs.): </TH>
      <TD colspan="3"><INPUT name="IST_LOAN_AMT" id="IST_LOAN_AMT" type="text"  tabindex="12"   value="<%= IST_LOAN_AMT %>" size="12" maxlength="7" AUTOCOMPLETE="off"></TD>
      <TH>(16) Enter Loan Release Amount: </TH>
    <TR>
      <TH>(17)</TH>
      <TH>Loan Account No. of Beneficiary </TH>
      <TD colspan="3"><INPUT name="APPLOAN_ACCNO" type="text" id="APPLOAN_ACCNO"  value="<%= APPLOAN_ACCNO %>"    size="20" maxlength="20" AUTOCOMPLETE="off"></TD>
      <TH>(17) Enter Beneficiary  Loan Account No. </TH>
    <TR>
      <TD colspan="5"><DIV align="center" class="GreenLebel">Govt. Subsidy (MM) Online Claim (Stage -5) </DIV></TD>
      <TH>Note: Please Enter Valid Financing Branch Account No. </TH>
    <TR>
      <TD colspan="5"><DIV align="center" class="warning">
        <P>( Please Verify Transient Account No (Non-Customer A/c No.) of Your Branch before Submit Online MM Claim,</P>
        <P><BR>
            In Case Your Branch Account No. not Showing in the list, Please Send email to <EM class="mtextarea">pmegpeportal.kvic@gov.in</EM> for  registration of Transient Account No. with the details of IFS Code, Account No. and Branch Name from your branch email id) </P>
        </DIV></TD>
      <TH>Transient A/c No is Non-Customer A/c of your Branch. </TH>
    <TR>
      <TH rowspan="3">(17)</TH>
      <TH> (A) Transient A/c. or Intermediatory A/c or Intersole A/c No /parking A/c / Govt. Subsidy Ac.  of Bank: 
      <INPUT name="FB_ACNAME" type="hidden" id="FB_ACNAME" tabindex="15" value="<%= FB_ACNAME %>"  >      </TH>
      <TD colspan="3">
        <SELECT name="FB_ACNO" id="FB_ACNO">
          <OPTION value="">Select</OPTION>
          <% 
		
		 
		  while (rsTrno.next()) {
	 NEFT_IFSC=rsTrno.getString("NEFT_IFSC")==null?"":rsTrno.getString("NEFT_IFSC");
	TRANS_ACNO=rsTrno.getString("TRANS_ACNO")==null?"":rsTrno.getString("TRANS_ACNO");
	
		  
		   %>
          <OPTION value="<%= TRANS_ACNO %>"<% if (FB_ACNO.equals(TRANS_ACNO)){out.print("selected");}%>><%= TRANS_ACNO %> ( NEFT IFSC:<%= NEFT_IFSC %>) )</OPTION>
          <%  } rsTrno.close();
	  String trmsg=TRANS_ACNO.equals("")?"Note: Your Transient A/c ( Non-Customer A/c) is not Registered.....<br> To register please send email to pmegpeportal.kvic@gov.in <br> with IFS Code , account No":"";
	   %>
        </SELECT></TD>
      <TH rowspan="3"><P>(18) Please Ente Valid Financing Branch Account No. Government Subsidy (MM) Will Transfer through to Financing Bank Account after Validation. </P>      </TH>
    <TR>
      <TD colspan="4"><DIV align="center" class="redLebel"><%= trmsg %></DIV></TD>
    <TR>
      <TH>(B)Margin Money (Govt. Subsidy) Claimed: </TH>
      <TD colspan="3"><INPUT name="MM_CLAIM_AMT" id="MM_CLAIM_AMT" type="text" tabindex="15" value="<%=MM_CLAIM_AMT %>" size="10" maxlength="7" AUTOCOMPLETE="off" >
        ( In Rupees) <SPAN class="style1">Note: Rs.500 will be Deducted as Application Fees</SPAN> </TD>
    <TR>
      <TH>(18)</TH>
      <TH>&nbsp;</TH>
      <TH colspan="3"><%if (!adhvalid.equals("S") ){%>
	  
 <span class="redLebel">Aadhaar Details are invalid! Please ensure Aadhaar No, Name, Date Of Birth , Gender and mobile No Details are as per Aadhaar Card....... ! Kindly Contact Concern Agency to Update Correct  Details in Applicant Data form </span>
		<%} else{%>
	  <INPUT name="btnClaim" type="button" class="buttonBlue" id="btnClaim" style="background-color:#0000CC" value=" Submit  Online Govt Subsidy (MM) Claim" onClick="openMM('<%= APP_ID %>');">
		<%}%></TH>
      <TH> (19) Click on &quot;Submit Online Subsidy(MM) Claim&quot; button for Final Submission </TH>
    <TR>
      <TD>(19</TD>
      <TD colspan="4"><DIV align="center" class="GreenLebel">Details of Margin Money (Subsidy) Claim Transfer through Indian. Bank to Your Bank</DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TD>&nbsp;</TD>
      <TD><DIV align="right">Transfer    Date: </DIV></TD>
      <TD colspan="3">&nbsp;</TD>
      <TD rowspan="3"> After Online Receipt of MM Claim , eligible Amount will be transfer to Transient Bank Account of Your Branch </TD>
    <TR>
      <TD>&nbsp;</TD>
      <TD><DIV align="right">MM Amount: </DIV></TD>
      <TD colspan="3">&nbsp;</TD>
    <TR>
      <TD>&nbsp;</TD>
      <TD><DIV align="right"> Reference No: </DIV></TD>
      <TD colspan="3">&nbsp;</TD>
    <TR>
      <TD colspan="5">  <DIV align="center" class="GreenLebel">TDR/SRF Account Detail (stage 6) </DIV></TD>
      <TH> On Receipt of Margin Money Claim, Financing Branch needs to be Deposit the same in the TDR Account of the Applicant as per Scheme Guidelines </TH>
    <TR>
      <TH>19</TH>
	  <TH >Select TDR/SRF: </TH>
      <TD colspan="3"><INPUT name="BANK_COMMENT" type="radio" id="BANK_COMMENT"  onchange="show()"; value="TDR" checked >
      TDR
        <INPUT name="BANK_COMMENT"  id="BANK_COMMENT" type="radio" onChange="show()"; value="SRF"  >
       SRF</th>
      <TH>&nbsp;</TH>
    <TR>
      <TH>(21)</TH>
      <TH nowrap>Beneficiary  <SPAN id="TDR" style="display:none">TDR</SPAN><SPAN id="SRF" style="display:none">SRF</SPAN>  Account No: </TH>
      <TD colspan="3"><INPUT name="TDR_ACNO" type="text" id="TDR_ACNO"  value="<%= TDR_ACNO %>" size="20" maxlength="20" readonly="true"></TD>
      <TH>(22)TDR/SRF Account No of the Beneficiary </TH>
    <TR>
      <TH>(23)</TH>
      <TH nowrap>Deposit Date in  <SPAN id="TDR1" style="display:none">TDR</SPAN><SPAN id="SRF1" style="display:none">SRF</SPAN> </TH>
      <TD colspan="3"><INPUT name="TDR_ADJ_DT" type="text" id="TDR_ADJ_DT"  placeholder="DD-MON-YYYY" onClick="javascript:NewCssCal('TDR_ADJ_DT','ddMMMyyyy')" value="<%= TDR_ADJ_DT %>" size="20" maxlength="20" readonly="true"></TD>
      <TH>(24)Deposit Date in TDR/SRF by Financing Branch </TH>
    <TR>
      <TD colspan="5"><DIV align="center" class="GreenLebel">Margin Money (Subsidy) Adjustment against TDR (Stage-7) </DIV></TD>
      <TH>&nbsp;</TH>
    <TR>
      <TH>(24)</TH>
      <TH>Adjustment Date: </TH>
      <TD colspan="3"><INPUT name="MM_ADJ_DT" type="text" PLACEHOLDER="DD-MON-YYYY" id="MM_ADJ_DT" onClick="javascript:NewCssCal('MM_ADJ_DT','ddMMMyyyy')"  value="<%= MM_ADJ_DT%>" size="12" maxlength="11" readonly="true"></TD>
      <TH>(25) Enter Date of Final adjustment of  Margin Money (Subsidy) againest Loan </TH>
    <TR>
      <TH>(26)</TH>
      <TH>Adjustment Amount</TH>
      <TD colspan="3"><INPUT name="MM_ADJ_AMT" type="text" id="MM_ADJ_AMT" tabindex="23" value="<%=MM_ADJ_AMT %>" size="12" maxlength="7" readonly="true"></TD>
      <TH>(27) Enter Amount in Rupees of Final Adjustment of Margin Money </TH>
    <TR>
      <TH colspan="5"><DIV align="center">
          <INPUT name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="insUpdate();"  value="Save Data">
      </DIV></TH>
      <TH>Finally Save Data. </TH>
  </TABLE>
 <% db.close();%>
</FORM>

<SCRIPT>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowEdpList(){
var urlpar='edplov.jsp?STATE_CD=';
 modalWin.ShowURL(urlpar,700,900,'EDP LIST',null,null);
 }
 
 function getEdpName(OFFNAME,OFF_CD){
 form1.EDP_TRG_NAME.value=OFFNAME;
form1.OFF_CD.value=OFF_CD;
}
 function ShowRejList(){
var urlpar='Rejlst.jsp';
 modalWin.ShowURL(urlpar,700,900,'REJECTION LIST',null,null);
 }
 function getRejName(OFFNAME,OFF_CD){
 form1.REJ_DESC.value=OFFNAME;
 form1.REJ_ID.value=OFF_CD;
}
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}


</SCRIPT>
</BODY>
</HTML>
