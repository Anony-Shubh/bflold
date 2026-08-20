<%@ page session="true" buffer="500kb" import="java.sql.*,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
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
<script language="javascript" src="../js/popcalendar.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script>
function loan_calc(){
	var ce=document.form1.MACHINARY_COST.value;
	var we=document.form1.WORKING_CAPITAL.value;
	var tcewe=Number(ce)+Number(we);
	document.form1.TOT_SANC.value=tcewe;
	//alert(tcewe);
	}
	function loan_sanc(){
	var ce=document.form1.CE_SANC_FB.value;
	var we=document.form1.WC_SANC_FB.value;
	var tcewe=Number(ce)+Number(we);
	document.form1.TOT_SANC_FB.value=tcewe;
	//alert(tcewe);
	}
	</script>
</head>
<body onload ="loan_calc(); loan_sanc();">
<form  method="post"  name="form1" id="form1"  >
  
  <%
  int ACT=11;
  String MMCLAIM=request.getParameter("MMCLAIM")==null?"Y":(String)request.getParameter("MMCLAIM") ;
  String ins=request.getParameter("ins")==null?"I":(String)request.getParameter("ins") ;
String flg="Y";
String APP_NAME="";
String BENF_TYPE="";
//String APP_ID = "DIUT16177108-1279576";
//(String)session.getAttribute("SAPP_ID");
String APP_ID = (String)session.getAttribute("SAPP_ID");
String IFSC_CODE=(String)session.getAttribute("bank_id");
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
String REMTRID="";
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
String RECOM_CE="";
String RECOM_WC="";
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
String LOAN_DOCFNAME="";
String EVENT="onClick";

String a="" ;
ArrayList msg = new ArrayList();

String stage="";
String verror="";

 String NEFT_IFSC="";
 String TRANS_ACNO="";
 String TOTAL_SANC_FB="";
String MOB_NO1="";
String E_MAIL="";
 String EDPUPLOAD_YN ="N";
	 String DOC_NAME="";
DBCon db= new DBCon();
db.connect();
ResultSet rsTrno=null;
try {



StringBuffer av= new StringBuffer();
av.append("SELECT a.tr_id,a.REMTRID, b.app_id,a.LOAN_DOCFNAME,a.act_id, to_char(a.bank_rec_dt,'DD-MON-YYYY') AS  bank_rec_dt, bank_remarks,AM.activity_name,100-OWNCONT_PER(B.APP_ID) AS BANK_LOAN_PER,a.RINT,a.LOAN_PERIOD, ").
append(" b.gender,b.unit_loc,C.benf_category_cd,C.benf_category_desc,d.edu_desc||' (Tech: '||b.tech_quali ||')' as quali,DECODE(B.ind_type,'M','Manufacturing','Service') as ind_type,A.LOAN_REMARKS, "). 
append(" CASE WHEN NVL(B.DLTFC_CE,0)+ NVL(B.DLTFC_WC,0)>100 THEN NVL(B.DLTFC_CE,0) ELSE nvl(B.machinary_cost,0) END AS Proj_cost_CE,B.MOB_NO1,B.E_MAIL, ").
append(" CASE WHEN NVL(B.DLTFC_CE,0)+ NVL(B.DLTFC_WC,0)>100 THEN NVL(B.DLTFC_WC,0) ELSE nvl(B.working_capital,0) END AS Proj_cost_WC,  ").
append(" CASE WHEN NVL(B.DLTFC_CE,0)+ NVL(B.DLTFC_WC,0)>100 THEN NVL(B.DLTFC_WC,0)+NVL(B.DLTFC_CE,0) ELSE nvl(B.working_capital,0)+nvl(B.machinary_cost,0) END AS Proj_cost,  ").
append(" OWNCONT_PER(B.APP_ID) AS OWN_CONT_PER,MM_PER(B.APP_ID) AS MM_ELIG_PER,").
append(" a.EDP_TRG_NAME, to_char(a.EDP_FR_DT,'DD-MON-RRRR') AS EDP_FR_DT,to_char(a.EDP_TO_DT,'DD-MON-RRRR') AS EDP_TO_DT , to_char(a.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT, ").
append(" a.APPLOAN_ACCNO,a.FB_ACNO,a.FB_ACNAME,a.TDR_ACNO,to_char(a.TDR_ADJ_DT,'DD-MON-RRRR') AS TDR_ADJ_DT,A.MOR_PER,A.MM_ADJ_AMT ,TO_CHAR(A.MM_ADJ_DT,'DD-MON-YYYY') AS MM_ADJ_DT ,").
append(" CASE WHEN LENGTH(B.AADHAR_NO)=12  THEN B.AADHAR_NO ELSE 0 END AADHAR_NO ,A.CE_SANC_FB,A.WC_SANC_FB,  nvl(A.CE_SANC_FB,0)+nvl(A.WC_SANC_FB,0) TOTAL_SANC_FB ,").
append(" CASE WHEN LENGTH(B.PAN_NO)=10  THEN B.PAN_NO ELSE '-' END PAN_NO, ").
append(" to_char(a.loan_sanc_dt,'DD-MON-YYYY') AS loan_sanc_dt, a.workshed_cost, a.working_capital, a.machinary_cost, a.pre_ope_cost, nvl(a.working_capital,0)+ nvl(a.machinary_cost,0) AS TOTPRJ_BANK_ADMIT,").
append ( " a.own_contribution, to_char(a.own_cont_dt,'DD-MON-YYYY') AS own_cont_dt, a.ist_loan_amt, to_char(a.ist_loan_dt,'DD-MON-YYYY') AS ist_loan_dt, a.cgtsi," ).
append ( " a.mm_claim_lrno, to_char(a.mm_claim_dt,'DD-MON-YYYY') AS  mm_claim_dt, a.mm_claim_amt, a.mm_rel_amt, ").
append ( " to_char(a.mm_rel_dt,'DD-MON-YYYY') as  mm_rel_dt, UPPER(b.app_name) AS APP_NAME, a.emp, a.prod, a.sales, " ).
append ( " to_char(a.tdr_adj_dt,'DD-MON-YYYY') as tdr_adj_dt, a.tdr_adj_amt,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,B.IFSC_CODE, " ).
 append ( " a.bank_comment,  to_char(a.time_stamp,'DD-MON-YYYY:HH:MM:SS') as time_stamp ").
  append (" FROM bank_dataentry a, app_detail b,BENF_CATEGORY_MAST C,education_mast d , ACTIVITY_MAST AM WHERE B.ACTIVITY_CD=AM.ACTIVITY_CD AND  b.APP_ID=? AND B.IFSC_CODE=?").
  append ("  and b.app_id=a.app_id and b.benf_catagory_cd=C.benf_category_cd and b.EDU_ID=d.edu_id AND A.PACT_ID=30 AND A.APPRV_YN='A' ");
			
			List values=new ArrayList();
     values.add (APP_ID); 
	 values.add (IFSC_CODE);
			
ResultSet rsApp = db.executeSQL(av.toString(),values);


values.clear();
values.add (IFSC_CODE); 
values.add (IFSC_CODE); 

rsTrno= db.executeSQL("SELECT NVL(NEFT_IFSC,BR_IFSL_CODE) AS NEFT_IFSC,TRANS_ACNO FROM BANK_BR_MAST  WHERE BR_IFSL_CODE=? UNION SELECT BTM.NEFT_IFSC_CODE|| '('||BTM.AC_DESC||')' AS NEFT_IFSC, BTM.TRAC_NO  AS TRANS_ACNO FROM BANK_TRANS_ACMAST BTM WHERE ACT_YN='Y' AND  BTM.NEFT_IFSC_CODE=?",values);
values.clear();

 values.add (APP_ID); 
	 
	 ResultSet rsEDPDOC= db.executeSQL("SELECT UP_ID,DOC_NAME FROM APP_UPLOAD_TRANS WHERE UP_ID IN (SELECT MAX(UP_ID) FROM  APP_UPLOAD_TRANS WHERE APP_ID=?  AND UPM_CD=8) AND DOC_ACTYN='Y'",values);
	 values.clear();
	
	 while (rsEDPDOC.next()) {
	 EDPUPLOAD_YN ="Y";
	 DOC_NAME=rsEDPDOC.getString(2)==null?"":rsEDPDOC.getString(2);
	 }
	 rsEDPDOC.close();
	 
String ACTWHR=" ACT_ID in (8,11,3) OR ";

while (rsApp.next()) {
           

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
	REMTRID=rsApp.getString("REMTRID")==null?"":rsApp.getString("REMTRID");
	RECOM_CE=rsApp.getString("Proj_cost_CE")==null?"":rsApp.getString("Proj_cost_CE");
    RECOM_WC=rsApp.getString("Proj_cost_WC")==null?"":rsApp.getString("Proj_cost_WC");

	
	AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
	PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
	
	CE_SANC_FB=rsApp.getString("CE_SANC_FB")==null?"":rsApp.getString("CE_SANC_FB");
	WC_SANC_FB=rsApp.getString("WC_SANC_FB")==null?"":rsApp.getString("WC_SANC_FB");
    TOTAL_SANC_FB=rsApp.getString("TOTAL_SANC_FB")==null?"":rsApp.getString("TOTAL_SANC_FB");
	E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
	MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
	LOAN_DOCFNAME=rsApp.getString("LOAN_DOCFNAME")==null?"":rsApp.getString("LOAN_DOCFNAME");
	
	} //end of resultset	
	//END OF BANK DATA
	
	//out.print(ACT_ID);
	StringBuffer sv= new StringBuffer();
sv.append("INSERT INTO BANK_DATAENTRY_REFER(    ");
sv.append("SELECT * FROM BANK_DATAENTRY WHERE APP_ID='"+APP_ID+"' AND REMTRID='"+REMTRID+"'  AND APPRV_YN='A'  ");
sv.append("AND PACT_ID=30 AND APP_ID NOT IN ( ");
sv.append("SELECT APP_ID FROM BANK_DATAENTRY_REFER WHERE APP_ID='"+APP_ID+"' AND REMTRID ='"+REMTRID+"' AND APPRV_YN='A'  ");
sv.append("AND PACT_ID=30))  ");
// out.print(sv.toString());

ResultSet rsReff = db.executeSQL(sv.toString(),values);


	if ((String)request.getParameter("ins")!=null){
	if (request.getParameter("ACT_ID") != null){
			ACT_ID = (String) request.getParameter("ACT_ID");
			vACT_ID =Integer.parseInt(ACT_ID);
		}else{
			ACT_ID = "0";
		}
		/*if (request.getParameter("BANK_REC_DT") != null){
			BANK_REC_DT = (String) request.getParameter("BANK_REC_DT");
		}else{
			BANK_REC_DT = "";
		}*/
		
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
		CE_SANC_FB=(String) request.getParameter("CE_SANC_FB")==null?"":(String) request.getParameter("CE_SANC_FB").trim();
		WC_SANC_FB=(String) request.getParameter("WC_SANC_FB")==null?"":(String) request.getParameter("WC_SANC_FB").trim();
		TOTAL_SANC_FB=(String) request.getParameter("TOT_SANC_FB")==null?"":(String) request.getParameter("TOT_SANC_FB").trim();
		
		
		String validateqry="SELECT * FROM TABLE(GET_PMEGP_BANKERROR_MM(?,?,?,?,?,?,?,?,?,?,?,? ,?,?,?,? ,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?) )";

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

CallableStatement cs = conn.prepareCall("{call  PMEGPNEW_UPDATE_BANKDATA_MM (?,?,?,?,?,?,?,?,?,?,?,? ,?,?,?,? ,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?)}");



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
cs.executeQuery();
response.sendRedirect("ReferBankFinalSubmissionClaim.jsp");
session.setAttribute("SAPP_ID",APP_ID);
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
  
  <table align="center">
    <tr>
      <th colspan="4" nowrap><div align="center" class="style29 style39">BANK DETAIL UPDATION FORM </div></th>
    </tr>
    <tr>
      <th colspan="4" ><div align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <input name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %> and Amount in Rs) </div></th>
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
      <th  ><%= BENF_CATEGORY_DESC %>
      <input name="MMCLAIM" type="hidden" id="MMCLAIM" value="<%= MMCLAIM %>"></th>
    </tr>
    <tr>
      <th  ><div align="right">Aadhaar Card No: </div></th>
      <th  ><%= AADHAR_NO %></th>
      <th  ><div align="right">PAN NO: </div></th>
      <th  ><%= PAN_NO %></th>
    </tr>
    <tr>
      <th  ><div align="right">Applicant Contact No: </div></th>
      <th  ><%= MOB_NO1  %></th>
      <th  ><div align="right">Applicant email:</div></th>
      <th  ><%= E_MAIL %></th>
    </tr>
    <tr>
      <th  ><div align="right"><span class="style29 ">Unit Location</span><span class="style29 style33">: </span></div></th>
      <th  ><div align="left"><%= UNIT_LOC %></div></th>
      <th  > <div align="right">Project Cost Recomended : </div></th>
      <th  >Rs.
        <input name="PROJ_COST" type="hidden"  id="PROJ_COST" tabindex="0" value="<%=PROJ_COST %>" size="15" readonly="true">
        <%=PROJ_COST %>
        <input name="OWN_CONT_PER" type="hidden"  id="OWN_CONT_PER" tabindex="0" value="<%= OWN_CONT_PER %>" >
        (CE:<%= RECOM_CE %>,WC:<%= RECOM_WC %>)</th>
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
   <% if (!verror.equals("")) {%>
<div class="error">

<%
out.print (verror);
%> </div>
<%}%>

 



  <table align="center">
    <tr>
      <th colspan="5" ><div align="center" >Application  Status Updation (Stage 1)
          <input name="ACT_ID" id="ACT_ID" type="radio" value="0" checked="checked" disabled="disabled" <% if (vACT_ID==0){out.print("Checked");}%> onChange="Status_change();">
      </div></th>
    <tr>
      <th> (1) </th>
      <th> Select Current Status at Bank:*</th>
      <td colspan="3" nowrap><input name="ACT_ID" type="radio"  id="ACT_ID" onChange="Status_change();" value="11" checked  <% if (vACT_ID==11){out.print("Checked");}%> >
        <span class="GreenLebel">Loan Sanctioned</span>
        <span class="redLebel"> </span></td>
    <tr>
      <th colspan="5"><div align="center">
      </div></th>
    <tr>
      <td colspan="5"><div align="center"><span class="GreenLebel">Total Project Cost and Loan Sanction (Stage-2)
        </span>
        <input name="ins" type="hidden" id="ins">
              <input name="WORKSHED_COST" type="hidden" tabindex="5"   value="<%= WORKSHED_COST %>" >
              <input name="PRE_OPE_COST" type="hidden" tabindex="7"   value="<%= PRE_OPE_COST %>"  >
              <input name="TOT_CE" type="hidden"  id="TOT_CE" style="background-color:#CC9900" value="">
      </div></td>
    <tr>
      <th>(2)</th>
      <th>Project Cost Detail: </th>
      <th colspan="2"> <div align="center">Total Project Cost Approved by Bank </div></th>
      <th> <div align="center">Bank Finance / Loan Sanction (<%= BANK_LOAN_PER %>%) </div></th>
    <tr>
      <th nowrap>&nbsp;</th>
      <th nowrap>(a) Capital Expenditure/Term Loan (in Rs) </th>
      <td colspan="2" nowrap><div align="center">
        <input name="MACHINARY_COST" id="MACHINARY_COST" type="text"  tabindex="6"      value="<%= MACHINARY_COST %>" size="12" maxlength="7" onChange="loan_calc();">
      </div></td>
      <td nowrap><div align="center">
        <input name="CE_SANC_FB" id="CE_SANC_FB" type="text"  tabindex="6"      value="<%= CE_SANC_FB %>" size="12" maxlength="7" onChange="loan_sanc();" >
      </div></td>
    <tr>
      <th>&nbsp;</th>
      <th>(b) Working Capital/Cash Credit (in Rs.) </th>
      <td colspan="2"><div align="center">
        <input name="WORKING_CAPITAL" id="WORKING_CAPITAL" type="text"  tabindex="8"     value="<%= WORKING_CAPITAL %>" size="12" maxlength="7" onChange="loan_calc();">
      </div></td>
      <td><div align="center">
        <input name="WC_SANC_FB" id="WC_SANC_FB" type="text"  tabindex="8"     value="<%= WC_SANC_FB %>" size="12" maxlength="7" onChange="loan_sanc();" >
      </div></td>
    <tr>
      <th>&nbsp;</th>
      <th> (c) Total  Project Cost  (a+b) </th>
      <th colspan="2"><div align="center">
        <input name="TOT_SANC" id="TOT_SANC" type="text" size="12" readonly="true" value="">
</div></th>
      <th><div align="center">
        <input name="TOT_SANC_FB" type="text"  id="TOT_SANC_FB"  size="12" readonly="true" value="">
</div></th>
    <tr>
      <th>(3 )</th>
      <th>Loan Sanction Date :</th>
      <td colspan="3"><input name="LOAN_SANC_DT" type="text"  id="LOAN_SANC_DT" onClick="popUpCalendar(this, this.form.LOAN_SANC_DT,'dd-mmm-yyyy');return false;" value="<%= LOAN_SANC_DT %>" size="12" maxlength="11" autocomplete="off"></td>
    <tr>
      <th>(4)</th>
      <th>Whether Covered under CGTMS :</th>
      <td colspan="3"><select name="CGTSI" id="CGTSI">
          <option value="N" <% if (CGTSI.equals("N")||CGTSI.equals("")){ out.println("selected");}%>>No</option>
          <option value="Y" <% if (CGTSI.equals("Y")){ out.println("selected");}%>>Yes</option>
      </select></td>
    <tr>
      <th>(5)</th>
      <th><div align="right">Rate of Interest on Loan ( in %): </div></th>
      <td colspan="3"><input name="RINT"  id="RINT" type="text"  size="12" maxlength="5" value="<%= RINT %>" autocomplete="off">
        %</td>
    <tr>
      <th>(6)</th>
      <th><div align="right">(A) Loan Repayment Period: </div></th>
      <td colspan="3"><input name="LOAN_PERIOD"  id="LOAN_PERIOD" type="text"   size="12" maxlength="3" value="<%= LOAN_PERIOD %>" autocomplete="off" >
        ( In Months) </td>
    <tr>
      <th>&nbsp;</th>
      <th> <div align="right">(B) Moratorium period:</div></th>
      <th colspan="3"><input name="MOR_PER"  id="MOR_PER" type="text"   size="12" maxlength="3" value="<%= MOR_PER %>" autocomplete="off" >
        (in Months)</th>
    <tr>
      <th>&nbsp;</th>
      <th> <div align="right">Remarks if any: </div></th>
      <th colspan="3"><input name="LOAN_REMARKS" type="text"  id="LOAN_REMARKS" size="70" maxlength="100" value="<%= LOAN_REMARKS %>" autocomplete="off"></th>
    <tr>
      <td colspan="5"><div align="center" class="GreenLebel">Own Contribution Deposit Details by Beneficiary (Stage-3)</div></td>
    <tr>
      <th>(7)</th>
      <th>Deposit date: </th>
      <td colspan="3"><input name="OWN_CONT_DT" type="text"  id="OWN_CONT_DT" tabindex="9"  <%= EVENT%>="popUpCalendar(this, this.form.OWN_CONT_DT,'dd-mmm-yyyy');return false;" value="<%=OWN_CONT_DT %>" size="12" maxlength="11"></td>
    <tr>
      <th>(8)</th>
      <th>Amount (in Rs.): </th>
      <td colspan="3"><input name="OWN_CONTRIBUTION" type="text"  id="OWN_CONTRIBUTION" tabindex="10"    value="<%=OWN_CONTRIBUTION %>" size="12" maxlength="7"></td>
    <tr>
      <td colspan="5"><div align="center" class="GreenLebel">EDP Training Detail</div></td>
    <tr>
      <th colspan="5">&nbsp;</th>
    <tr>
      <th>&nbsp;</th>
      <th><div align="right">LATEST EDP CERTIFICATE UPLOAD/VIEW/MODIFY: </div></th>
      <td><div align="center">
	 <%  if (!DOC_NAME.equals("")) { %>
	   <a href="../jsp/doctransfertoNas.jsp?docname=<%=DOC_NAME %>" class="greenButtonRound">VIEW EDP CERTIFICATE </a>
	<%   } %>
	  </div></td>
      <td colspan="2"><div align="center">
        <input name="btnEDP" type="button" class="buttonGreen" id="btnEDP" value="UPLOAD / UPDATE EDP CERTIFICATE" onClick="uploadCert('<%= APP_ID %>')"> 
        </div></td>
    <tr>
      <th colspan="5">&nbsp;</th>
    <tr>
      <th>(9)</th>
      <th>Training Center Name: </th>
      <td colspan="3"><input name="EDP_TRG_NAME" id="EDP_TRG_NAME" type="text" size="50" maxlength="50" value="<%= EDP_TRG_NAME %>">
        <input name="btnEDP" type="button" class="buttonBlue" id="btnEDP" value="Select  EDP Centers" onClick="ShowEdpList();"></td>
    <tr>
      <th>(10)</th>
      <th>Training  Date From: </th>
      <td><input name="EDP_FR_DT" type="text" id="EDP_FR_DT" value="<%= EDP_FR_DT %>" size="12" maxlength="11" onClick="popUpCalendar(this, this.form.EDP_FR_DT,'dd-mmm-yyyy');return false;"></td>
      <th><div align="right">To: </div></th>
      <td><input name="EDP_TO_DT"type="text" id="EDP_TO_DT" value="<%= EDP_TO_DT %>" size="12" maxlength="11" onClick="popUpCalendar(this, this.form.EDP_TO_DT,'dd-mmm-yyyy');return false;"></td>
    <tr>
      <th>(11)</th>
      <th>Certificate Issue Date: </th>
      <td colspan="3"><input name="EDP_CERT_DT" type="text"  id= "EDP_CERT_DT" value="<%= EDP_CERT_DT %>" size="12" maxlength="11" autocomplete="off" onClick="popUpCalendar(this, this.form.EDP_CERT_DT,'dd-mmm-yyyy');return false;"></td>
    <tr>
      <td colspan="5"><div align="center"><span class="GreenLebel">Loan Released (Stage-4)</span>        <input name="MM_CLAIM_DT" type="hidden" tabindex="14" value="<%= MM_CLAIM_DT %>">
              <input name="MM_REL_DT" type="hidden" tabindex="17">
              <input name="MM_REL_AMT" type="hidden" tabindex="18"  value="<%= MM_REL_AMT %>">
              <input name="PROD" type="hidden" tabindex="19"  value="<%= PROD %>">
              <input name="SALES" type="hidden" tabindex="20"  value="<%= SALES %>">
              <input name="EMP" type="hidden" tabindex="21"  value="<%= EMP %>">
      </div></td>
    <tr>
      <th>(12)</th>
      <th>Last Date of Loan Release:</th>
      <td colspan="3"><input name="IST_LOAN_DT" id="IST_LOAN_DT" type="text"   value="<%= IST_LOAN_DT %>" size="12" maxlength="11"  <%= EVENT %>="popUpCalendar(this, this.form.IST_LOAN_DT,'dd-mmm-yyyy');return false;" autocomplete="off"></td>
    <tr>
      <th>(13)</th>
      <th>Total Loan Amount Released (in Rs.): </th>
      <td colspan="3"><input name="IST_LOAN_AMT" id="IST_LOAN_AMT" type="text"  tabindex="12"   value="<%= IST_LOAN_AMT %>" size="12" maxlength="12" autocomplete="off"></td>
    <tr>
      <th>(14)</th>
      <th>Loan Account No. of Beneficiary </th>
      <td colspan="3"><input name="APPLOAN_ACCNO" type="text" id="APPLOAN_ACCNO"  value="<%= APPLOAN_ACCNO %>"    size="20" maxlength="20" autocomplete="off"></td>
    <tr>
      <th colspan="5">&nbsp;</th>
    <tr>
      <th>&nbsp;</th>
      <th><div align="right">LATEST LOAN DOCUMENT UPLOAD/VIEW/MODIFY: </div></th>
      <td><div align="center">
          <%  if (!LOAN_DOCFNAME.equals("")) { %>
          <a href="doctransfertonas_L.jsp?docname=<%=LOAN_DOCFNAME %>"  class="greenButtonRound">VIEW LOAN STATEMENT </a> 
          <%   } %>
      </div></td>
      <td colspan="2"><div align="center">
          <input name="btnEDP" type="button" class="buttonGreen" id="btnEDP" value="UPLOAD / UPDATE REVISED LOAN STATEMENT" onClick="uploadLoan('<%= APP_ID %>')">
      </div></td>
    <tr>
      <th colspan="5">&nbsp;</th>
    <tr>
      <td colspan="5"><div align="center" class="GreenLebel">Govt. Subsidy (MM) Online Claim (Stage -5) </div></td>
    <tr>
      <td colspan="5"><div align="center" class="redLebel">( Please Verify Transient Account No of Branch before Submit Online MM Claim) </div></td>
    <tr>
      <th rowspan="2">(15)</th>
      <th> (A) Transient A/c. or Intermediatory A/c or Intersole A/c No of Bank: 
        <input name="FB_ACNAME" type="hidden" id="FB_ACNAME" tabindex="15" value="<%= FB_ACNAME %>"  >      </th>
      <td colspan="3">
	  <% 
		
		  while (rsTrno.next()) {
	 NEFT_IFSC=rsTrno.getString("NEFT_IFSC")==null?"":rsTrno.getString("NEFT_IFSC");
	TRANS_ACNO=rsTrno.getString("TRANS_ACNO")==null?"":rsTrno.getString("TRANS_ACNO");
		  
		   %>
	  <input name="FB_ACNO" type="text" id="FB_ACNO" value="<%= TRANS_ACNO %>" readonly="true"  >  
	    	  	
		  
	
	  <%  } rsTrno.close(); %>
( Non customer A/c)	</td>
    <tr>
      <th>(B)Margin Money (Govt. Subsidy) Claimed: </th>
      <td colspan="3"><input name="MM_CLAIM_AMT" id="MM_CLAIM_AMT" type="text" tabindex="15" value="<%=MM_CLAIM_AMT %>" size="10" maxlength="6" autocomplete="off" >
        ( In Rupees) </td>
    <tr>
      <th>&nbsp;</th>
      <th colspan="4"><div align="center">
        <input name="btnClaim" type="submit" class="buttonBlue" id="btnClaim" value="Final MM Claim Submission">
      </div></th>
  </table>
 
</form>
<% db.close();%>
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowEdpList(){
var urlpar='edplov.jsp?STATE_CD=';
 modalWin.ShowURL(urlpar,700,900,'EDP LIST',null,null);
 }
 
 function getEdpName(OFFNAME){
 form1.EDP_TRG_NAME.value=OFFNAME;

}

 function uploadCert(pAppid) {
var url ='edpAppUplodadByAgency.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload EDP Certificate',null,null);
 
}

 function uploadLoan(pAppid) {
var url ='uploadLoanDocumentReffer.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload Loan Disbursement Statement',null,null);
 
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data() {
   form1.submit(); 
}

</script>
</body>
</html>
