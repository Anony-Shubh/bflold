<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%! 

public String getParm(String p_val) {

if (p_val.equals("ALL")||p_val.equals("null")||p_val.equals("Total")||p_val.equals("")||p_val.equals("%%")){
p_val="%%";
}
return (p_val);
  }

public String getNum(String p_val1) {
try {
if (p_val1==null){
p_val1="-";
}
}catch (Exception e) {}
return (p_val1);
  }
 
 %>
<HEAD>
<TITLE>PMEGP Portal Monitoring Report</TITLE>
<LINK rel="stylesheet" type="text/css" href="css/indexr.css">

</HEAD>

<BODY>
<FORM  method="post">
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();

String txtSearch="";

String vStateCd=request.getParameter("STATECD")==null?"":(String) request.getParameter("STATECD");  
 String vOffname=request.getParameter("OFFNAMECD")==null?"":(String) request.getParameter("OFFNAMECD"); 
 String vZoneCD=request.getParameter("ZONECD")==null?"":(String) request.getParameter("ZONECD"); 
 String vAgency=request.getParameter("AGENCY")==null?"":(String) request.getParameter("AGENCY"); 
  String vDist=request.getParameter("DISTCD")==null?"":(String) request.getParameter("DISTCD"); 
    String vBankName=request.getParameter("BANKNAME")==null?"":(String) request.getParameter("BANKNAME"); 

  vBankName=getParm(vBankName);
  vStateCd=getParm(vStateCd);  
  vOffname=getParm(vOffname); 
 vZoneCD=getParm(vZoneCD); 
 vAgency=getParm(vAgency); 
   vDist=getParm(vDist); 
  
     
   
   
  String vQryCode=request.getParameter("QRYCODE")==null?"0":(String) request.getParameter("QRYCODE"); 
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");


String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;
vBankName=vBankName.equals("zTotal")?"%%":vBankName;

String vfldQryDesc="";
String vCurStatus="";
txtSearch=" ";

txtSearch=" and upper(zm.zone_nm) like upper('"+vsZonecd+"') and upper(ms.state_nm) like upper('"+vsStatecd+"') and MOM.AGENCY_TYPE like '"+vsAgency+"' ";
 
 if (vQryCode.equals("0")){
 //ALL APPLICATION
 txtSearch = txtSearch + " and TRUNC(ad.online_subdt) between '"+FromDt+"' and  '"+ToDt+"' " ;
} else if (vQryCode.equals("1")){
// UNDER PROCESS AT AGENCY
  txtSearch = txtSearch + " and ad.act_id=1 " ;
  // PLACED BEFORE DLTFC COMMITTEE
  }else if (vQryCode.equals("2")){
  txtSearch = txtSearch + " and TRUNC(ad.FORD_DT_DLTFC) BETWEEN '"+FromDt+"' and '"+ToDt+"' ";
 }else if (vQryCode.equals("3")){
 // REJECTED BY DLTFC COMMITTEE
  txtSearch = txtSearch + " and TRUNC(AMM.MT_DATE)  BETWEEN '"+FromDt+"' and '"+ToDt+"' and ad.act_id=7 ";
 }else if (vQryCode.equals("4")){
 // Sanctioned by DLTFC COMMITTEE
  txtSearch = txtSearch + " and TRUNC(AMM.MT_DATE)  BETWEEN '"+FromDt+"' and '"+ToDt+"' and ( ad.act_id<>7 AND AD.ACT_ID>=4) ";
 
  }else if (vQryCode.equals("5")){
 // Forwarded to Bank
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=5 ";
  }else if (vQryCode.equals("6")){
 // Sanctioned by Bank
  txtSearch = txtSearch + " and bd.LOAN_SANC_DT BETWEEN '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 ";
}else if (vQryCode.equals("7")){
 // Rejected by Bank
  txtSearch = txtSearch + " and  bd.act_id=3 AND TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"'  ";
 }else if (vQryCode.equals("8")){
 // Own Contribution Deposited
  txtSearch = txtSearch + " and   TRUNC(bd.OWN_CONT_DT) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("9")){
 //  LOAN RELEASED
  txtSearch = txtSearch + " and TRUNC(bd.ist_loan_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
  }else if (vQryCode.equals("10")){
 // EDP TRANING COMPLETED
  txtSearch = txtSearch + " and TRUNC (bd.EDP_CERT_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and nvl(bd.off_cd,0) = 9246 and  bd.EDP_CERT_DT IS NOT NULL AND bd.act_id=11 ";
 }
 else if (vQryCode.equals("95")){
   txtSearch = txtSearch + " and TRUNC (bd.EDP_CERT_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and nvl(bd.off_cd,0) <> 9246 and  bd.EDP_CERT_DT IS NOT NULL AND bd.act_id=11 ";
 }
 else if (vQryCode.equals("11")){
 // MM CLAIMED
  txtSearch = txtSearch + " and bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL  AND TRUNC(bd.MM_CLAIM_DT) BETWEEN  '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("12")){
 // MM RELEASED
  txtSearch = txtSearch + " and TRUNC(bd.mm_rel_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A' ";
 }else if (vQryCode.equals("13")){
 // Physical Vefification completed
  txtSearch = txtSearch + " and bd.pv_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("14")){
 // MM final adjustment
  txtSearch = txtSearch + " and  TRUNC(bd.mm_adj_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("15")){
 // Pending for Bank Sanction
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=8  ";
 }else if (vQryCode.equals("16")){
 // Pending for MM Release
  txtSearch = txtSearch + " and TRUNC(bd.mm_claim_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.mm_rel_dt is null and bd.act_id=11  ";
 }else if (vQryCode.equals("20")){
 // Pending for MM Release
  txtSearch = txtSearch + " and TRUNC(ad.online_subdt)  between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=3  ";
   }else if (vQryCode.equals("35")){
 // Pending EDP TRANING
  txtSearch = txtSearch + "  AND TRUNC(bd.LOAN_SANC_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"'and  bd.edp_cert_dt IS NULL and bd.act_id=11   ";

 }else if (vQryCode.equals("38")){
 // Pending BANK SANCTION
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date)  between '"+FromDt+"' and '"+ToDt+"' and  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5  AND AD.ACT_YN='Y' ";

 }else if (vQryCode.equals("40")){
 // CLAIMS REFERRED TO FIELD OFFICES
  txtSearch = txtSearch + " and TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  BD.PACT_ID=30 AND BD.APPRV_YN='A'  AND ad.act_id=5   ";
 }
else if (vQryCode.equals("45")){
 // CLAIMS REFERRED TO FIELD OFFICES
  txtSearch = txtSearch + " and TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  BD.PACT_ID=34 AND ad.act_id=5 and BD.APPRV_YN='A' AND BD.PAY_STATUS LIKE 'F%'   ";
 }
else if (vQryCode.equals("27")){
 // TDR UPDATED
  txtSearch = txtSearch + " and TRUNC(bd.mm_rel_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 AND bd.PACT_ID = 34 AND bd.APPRV_YN = 'A'  AND  bd.TDR_ADJ_DT IS NOT NULL ";
 }
 else if (vQryCode.equals("24")){
 // TDR NOT UPDATED
  txtSearch = txtSearch + " and TRUNC(bd.mm_rel_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 AND bd.PACT_ID = 34 AND bd.APPRV_YN = 'A' AND  bd.TDR_ADJ_DT IS NULL  ";
 }
 else if (vQryCode.equals("55")){
 // PENDING AT AGENCY
  txtSearch = txtSearch + " and TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FromDt+"' and '"+ToDt+"'  AND ad.ACT_ID IN(0,1,4,2) AND ad.ACT_YN='Y' ";
 }
 
 StringBuffer sb= new StringBuffer();
 
 StringBuffer sb1=new StringBuffer();
//DECODE(ad.mob_no2,NULL,NULL, '*****'    || substr(ad.mob_no2,6,length(ad.mob_no2)-5))
//DECODE(ad.mob_no1,NULL,NULL, '*****'     || substr(ad.mob_no1,6,length(ad.mob_no1)-5))
//DECODE(ad.aadhar_no,NULL,NULL, '*****'     || substr(ad.aadhar_no,7,length(ad.aadhar_no)-6))
sb.append(" SELECT ad.app_id,ad.app_name,UPPER(ad.fh_name) AS FH_NAME,mom.agency_type, mom.off_name, NVL(ad.remarks,'') AS Remraks_up_rej ,AD.UNIT_LOC, BD.TDR_ACNO,TO_CHAR(BD.TDR_ADJ_DT,'DD-MON-RRRR') AS TDR_ADJ_DT,").
append(" ms.state_nm,DECODE(ad.mob_no2,NULL,NULL, '*****'    || substr(ad.mob_no2,6,length(ad.mob_no2)-5)) AS TEL_NO,ad.E_MAIL,DECODE(ad.aadhar_no,NULL,NULL, '*****'     || substr(ad.aadhar_no,7,length(ad.aadhar_no)-6)) AADHAR_NO,TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR') ONLINESUBDT,  AD.BENF_SPECAT_CD,BD.PAY_STATUS,BD.UTRN_NO,BD.FAIL_REASON, ").
append(" ad.app_post_addr||' , '||ad.app_taluk_block||' '|| ' Dist:'||bend.district_name||'").
append(" Pin:'||ad.app_pin as app_addr,DECODE(ad.mob_no1,NULL,NULL, '*****'     || substr(ad.mob_no1,6,length(ad.mob_no1)-5)) AS ONLINEMOBNO ,MMINVOLVE(AD.APP_ID) AS MM_INV, ").
append(" BTM.benf_type_desc,bcm.benf_category_desc,ad.gender,to_char(ad.dob,'dd-mon-RRRR') as dob, ").
append(" decode (ad.act_id ,1,asm.act_desc||' At Agency-'||ad.remarks) as dltfc_remarks, ").
append(" case when ad.dob is not null then round(months_between(ad.app_rec_date,ad.dob)/12,0) end as age, ").
append(" (case when ad.act_id=7 then '-No-' when ad.act_id=5 then '-Yes-' end) as DLTFC_REJ_yn,decode ").
append(" (ad.act_id ,7,ad.remarks) as dltfc_status, case when ad.act_id<>5 then asm.act_desc else ").
append(" bas.act_desc end as current_status,udm.district_name as Unit_district, edm.edu_desc, ").
append(" ad.unit_post_addr||' '||ad.unit_taluk_block||' Dist:'||udm.district_name||' Pin:'||ad.unit_pin as unit_addr,UPPER(ad.unit_taluk_block) AS UNIT_TALUK_BLOCK, ").
append(" decode (ad.ind_type,'S','Service','Manufacturing') As ind_type, ").
append(" igm.ind_grp_long_desc,am.activity_name||' / '||PROD_DESC AS activity_name,nvl(ad.workshed_cost,0)+nvl(ad.pre_ope_exp,0) ").
append(" +nvl(ad.machinary_cost,0)+nvl(ad.working_capital,0) as proj_cost, ad.bank_name||' ,  ").
append(" '||ad.bank_post_addr||','||ad.bank_taluk_block||'IFSC Code:'|| ad.IFSC_CODE as bank_addr,ad.IFSC_CODE,  ").
append(" (case when bd.act_id=3 then 'No' when bd.act_id=11 then '-Yes-' when bd.act_id=8 then '-' end) ").
append(" bank_Status, to_char(ad.app_rec_date,'dd-mon-RRRR') as app_rec_date,to_char(amm.mt_date,'dd-mon-RRRR') ").
append(" as mt_date,amm.mtg_place,to_char(ad.bank_f_date,'dd-mon-RRRR') as bank_f_date, to_char(bd.bank_rec_dt,'dd-mon-RRRR') ").
append(" as bank_rec_date, DECODE(BD.ACT_ID,3,bd.bank_remarks,'')||'/'|| RM.REJ_DESC as bank_remarks, to_char(bd.loan_sanc_dt,'dd-mon-RRRR') as loan_sanc_dt, ").
append(" (Nvl(bd.machinary_cost,0)) AS ").
append(" CE, nvl(bd.working_capital,0) as WORKING_CAPITAL,(NVL(bd.machinary_cost,0)+ NVL(bd.working_capital,0)) ").
append(" As total_sanc, bd.own_contribution, 0  AS bank_loan, bd.MM_CLAIM_AMT,edpom.off_name, ").
append(" BD.EDP_TRG_NAME AS edp_trg_nm, to_char(bd.edp_fr_dt,'dd-mon-RRRR') as edp_fr_dt, to_char(bd.edp_to_dt,'dd-mon-RRRR') ").
append(" as edp_to_dt, to_char(bd.EDP_CERT_DT,'dd-mon-RRRR') as ").
append(" EDP_CERT_DT,'' as Nodal_bank,NVL(BD.CE_SANC_FB,0) AS CE_SANC_FB ,NVL(BD.WC_SANC_FB,0) AS WC_SANC_FB ,NVL(BD.CE_SANC_FB,0)+NVL(BD.WC_SANC_FB,0) AS TOT_SANC_FB, ").
append(" bd.ist_loan_amt, case when bd.edp_to_dt is not null then (bd.edp_to_dt-bd.edp_fr_dt)+1 end as edp_days, ").
append(" to_char(bd.IST_LOAN_dt,'dd-mon-RRRR') AS ist_loan_dt, bd.cgtsi, bd.mm_claim_lrno, to_char(bd.mm_claim_dt,'dd-mon-RRRR') ").
append(" as mm_claim_dt, bd.mm_claim_amt, bd.mm_rel_amt,to_char(bd.MM_REL_dt,'dd-mon-RRRR') AS mm_rel_dt, bd.emp,MRT.CO_REMARKS, ").
append(" bd.prod, bd.sales, to_char(bd.pv_dt,'dd-mon-RRRR') as pv_dt , bd.pv_ver_off,bd.mm_adj_by, bd.mm_adj_amt,to_char(bd.MM_ADJ_DT,'dd-mon-RRRR') ").
append(" AS mm_adj_dt, bd.edp_yn, bd.ph_yn, bd.pv_status, bd.OWN_CONTRIBUTION, to_char(bd.OWN_CONT_DT,'dd-mon-RRRR') AS OWN_CONT_DT, ").
append(" bd.phy_prod, bd.phy_sales, bd.phy_emp, bd.phy_inv FROM app_detail ad, bank_dataentry bd, m_district dm, ").
append(" mas_off_mast mom,m_state ms,app_meeting_mast amm,benf_type_mast BTM, benf_category_mast bcm,m_district bend, ").
append(" education_mast edm,m_district udm,app_status_mast asm,bank_app_status bas, activity_mast am, ").
append(" ind_grp_mast igm, ").
append(" mas_off_mast edpom,MM_REMARKS_TRANS MRT,REJECTION_MAST RM, ").
append(" zone_mast zm where ms.zone_cd=zm.zone_cd and BD.REMTRID=MRT.REMTR_ID (+) AND ").
append(" ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd and bd.rej_id=RM.rej_id(+) and   ").
append(" ad.mtg_id=amm.mtg_id(+) and ad.act_id=asm.act_id and bd.act_id=bas.act_id(+) and ").
append("  ad.app_dist_cd=bend.district_cd and AD.benf_type_cd=BTM.benf_type_cd ").
append(" and ad.benf_catagory_cd=bcm.benf_category_cd and ad.edu_id=edm.edu_id and ad.unit_dist_cd=udm.district_cd ").
append(" and bd.tr_id=edpom.off_cd(+) and ad.RET_YN='Y'   ").
 append(" "+txtSearch+"  AND upper(zm.zone_nm) like upper('"+vZoneCD+"') and upper(ms.state_nm) like upper('"+vStateCd+"') ").
append(" AND MOM.AGENCY_TYPE like '"+vAgency+"' AND MOM.OFF_NAME1 LIKE '"+vOffname+"' AND DM.district_name  LIKE ('"+vDist+"') ").
append(" AND AD.BANK_NAME LIKE UPPER('"+vBankName+"') ").
append(" and ad.off_cd=mom.off_cd and ad.activity_cd=am.activity_cd and am.ind_grp_cd=igm.ind_grp_cd and  ad.ACT_YN='Y' ");

out.print(vBankName);


//out.print (sb.toString());
ResultSet rsinst = db.execSQL(sb.toString());

//out.print (sb.toString());
//response.setContentType("application/vnd.ms-excel");
//response.setHeader("Content-Disposition", "inline; filename=" + "excel.xls"); 
%>
  <TABLE border="2" align="center" bordercolor="#000000">
  <TR>
    <TH colspan="66" align="left" nowrap="nowrap"><DIV align="left">PMEGP Detail Report for the period from <%= FromDt %> to <%= ToDt %>of Agency :<%= vAgency %></DIV></TH>
    </TR>
  <TR>
   <TH rowspan="2" align="left">     srno</TH>
    <TH rowspan="2" align="left">Current Status </TH>
    <TH rowspan="2" align="left">Under Process /Rejection by Agency Reason </TH>
    <TH rowspan="2" align="left">Office Name </TH>
    <TH rowspan="2" align="left">Agency Type </TH>
    <TH rowspan="2" align="left">State</TH>
    <TH rowspan="2" align="left">Applicant ID      </TH>
    <TH rowspan="2" align="left"> Applicant Name </TH>
    <TH rowspan="2" align="left">Applicant Address </TH>
    <TH rowspan="2" align="left">Mobile No. </TH>
    <TH rowspan="2" align="left">Alternative Mobile No </TH>
    <TH rowspan="2" align="left">eMail</TH>
    <TH rowspan="2" align="left">AADHAAR</TH>
    <TH rowspan="2" align="left">Legal Status </TH>
    <TH rowspan="2" align="left">Gender</TH>
    <TH rowspan="2" align="left">Category</TH>
    <TH rowspan="2" align="left">Special Category </TH>
    <TH rowspan="2" align="left">
      Qualification</TH>
    <TH rowspan="2" align="left">Date of Birth </TH>
    <TH rowspan="2" align="left">Age</TH>
    <TH rowspan="2" align="left">Unit Location </TH>
    <TH rowspan="2" align="left">Unit Address </TH>
    <TH rowspan="2" align="left">Taluk/block</TH>
    <TH rowspan="2" align="left">Unit District </TH>
    <TH rowspan="2" align="left">Industry Type </TH>
    <TH rowspan="2" align="left">Product Desc/Activity </TH>
    <TH rowspan="2" align="left">Proposed Project Cost </TH>
    <TH rowspan="2" align="left">MM Involve </TH>
	<TH rowspan="2" align="left">Financing Branch IFSC CODE </TH>
    <TH rowspan="2" align="left">Financing Branch Address </TH>
    <TH rowspan="2" align="left">Online Submission Date </TH>
    <TH rowspan="2" align="left">DLTFC Meeting  </TH>
    <TH rowspan="2" align="left">DLTFC Meeting Place </TH>
    <TH rowspan="2" align="left">Forwarding Date to Bank </TH>
    <TH rowspan="2" align="left">Bank Remarks </TH>
    <TH rowspan="2" align="left">Date of Document Received at Bank </TH>
    <TH colspan="3" align="left">Project Cost Approved by Bank</TH>
    <TH colspan="4" align="left">Sanctioned by Bank </TH>
    <TH rowspan="2" align="left"> Date of Deposit Own Contribution </TH>
    <TH rowspan="2" align="left">Own Contribution amount Deposited </TH>
    <TH rowspan="2" align="left">Covered Under CGTSI </TH>
    <TH rowspan="2" align="left">Date of Loan Release</TH>
    <TH rowspan="2" align="left">Loan Release Amount</TH>
    <TH rowspan="2" align="left">MM Claim Date </TH>
    <TH rowspan="2" align="left">MM Claim Amount </TH>
    <TH rowspan="2" align="left">Remarks for MM Process at PMEGP,CO,Mumbai </TH>
    <TH rowspan="2" align="left">MM Release Date</TH>
    <TH rowspan="2" align="left">MM Release Amount </TH>
    <TH rowspan="2" align="left">Payment Status (Fail/Sucess) </TH>
    <TH rowspan="2" align="left">MM disbursement Transaction id </TH>
    <TH rowspan="2" align="left">Fail Reason </TH>
    <TH rowspan="2" align="left">EDP Training Center Name </TH>
    <TH rowspan="2" align="left">Training Start Date</TH>
    <TH rowspan="2" align="left">Training End Date </TH>
    <TH rowspan="2" align="left">Duration of Training <BR />
        ( No of Days) </TH>
    <TH rowspan="2" align="left">Certificate Issue Date </TH>
    <TH rowspan="2" align="left">Physical Verification Conducted Date</TH>
    <TH rowspan="2" align="left">Physical Verification Status </TH>
    <TH rowspan="2" align="left">MM Final Adjustment Date </TH>
    <TH rowspan="2" align="left">MM Final Adjustment Amount </TH>
	<TH rowspan="2" align="left">TDR Account No</TH>
	<TH rowspan="2" align="left">TDR Date</TH>
  </TR>
  <TR>
    <TH align="left">CE</TH>
    <TH align="left">WC</TH>
    <TH align="left"><STRONG>TOTAL</STRONG></TH>
    <TH align="left">Date</TH>
    <TH align="left">CE</TH>
    <TH align="left">WC</TH>
    <TH align="left">Total</TH>
  </TR>
 
  <TR>
    <TH align="left" >
      1</TH>
    <TH align="left" >2</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >3</TH>
    <TH align="left" >4</TH>
    <TH align="left" >5</TH>
    <TH align="left" >
      6</TH>
    <TH align="left" >7</TH>
    <TH align="left">8</TH>
    <TH align="left" >9</TH>
    <TH align="left" >10</TH>
    <TH align="left" >11</TH>
    <TH align="left" >12</TH>
    <TH align="left" >
      13</TH>
    <TH align="left" >14</TH>
    <TH align="left" >
      15</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >
      16</TH>
    <TH align="left" >17</TH>
    <TH align="left" >18</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >19</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >20</TH>
    <TH align="left" >21</TH>
    <TH align="left" >22</TH>
    <TH align="left" >23</TH>
    <TH align="left" >&nbsp;</TH>
	<TH align="left" >24 (a) </TH>
    <TH align="left" >24 (b)</TH>
    <TH align="left" >25</TH>
    <TH align="left" >26</TH>
    <TH align="left" >27</TH>
    <TH align="left" >28(A)</TH>
    <TH align="left" >28(B)</TH>
    <TH align="left" >29</TH>
    <TH align="left" >31</TH>
    <TH align="left" >32</TH>
    <TH align="left" >33</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >34</TH>
    <TH align="left" >35</TH>
    <TH align="left" >36</TH>
    <TH align="left" >37</TH>
    <TH align="left" >38</TH>
    <TH align="left" >39</TH>
    <TH align="left" >40</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >41</TH>
    <TH align="left" >42</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >&nbsp;</TH>
    <TH align="left" >43</TH>
    <TH align="left" >44</TH>
    <TH align="left" >45</TH>
    <TH align="left" >46</TH>
    <TH align="left" >47</TH>
    <TH align="left" >48</TH>
    <TH align="left" >49</TH>
    <TH align="left" >50</TH>
    <TH align="left" >51</TH>
	<TH align="left" >52</TH>
    <TH align="left" >53</TH>
  </TR>
   <% while (rsinst.next()) {
  srn=srn+1;
   %>
  <TR>
    <TD align="left" ><%=srn%>)</TD>
    <TD align="left" ><%=getNum( rsinst.getString("current_status") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("Remraks_up_rej") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("off_name") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("agency_type") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("state_nm") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("app_id") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("APP_NAME") )%></TD>
    <TD align="left"><%=getNum( rsinst.getString("app_addr") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("ONLINEMOBNO") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("TEL_NO") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("E_MAIL") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("AADHAR_NO") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("benf_type_desc") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("Gender") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("benf_category_desc") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("BENF_SPECAT_CD") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("EDU_DESC") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("dob") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("age") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("UNIT_LOC") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("UNIT_ADDR") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("unit_taluk_block") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("UNIT_DISTRICT") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("ind_type") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("ACTIVITY_NAME") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("PROJ_COST") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("MM_INV") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("IFSC_CODE") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("bank_addr") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("ONLINESUBDT") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mt_date") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mtg_place") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("bank_f_date") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("bank_remarks") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("bank_rec_date") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("CE") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("working_capital") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("total_sanc") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("loan_sanc_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("CE_SANC_FB") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("WC_SANC_FB") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("TOT_SANC_FB") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("OWN_CONT_DT") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("OWN_CONTRIBUTION") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("cgtsi") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("Ist_loan_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("Ist_loan_amt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mm_claim_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mm_claim_amt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("CO_REMARKS") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mm_rel_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mm_rel_amt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("PAY_STATUS") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("UTRN_NO") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("FAIL_REASON") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("edp_trg_nm") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("edp_fr_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("edp_to_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("edp_days") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("EDP_CERT_DT") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("PV_DT") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("PV_STATUS") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mm_adj_dt") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("mm_adj_amt") )%></TD>
	<TD align="left" ><%=getNum( rsinst.getString("TDR_ACNO") )%></TD>
    <TD align="left" ><%=getNum( rsinst.getString("TDR_ADJ_DT") )%></TD>
  </TR>
 <%
}
rsinst.close();
db.close();
%>
</TABLE>
</FORM>

</BODY>
</HTML>
