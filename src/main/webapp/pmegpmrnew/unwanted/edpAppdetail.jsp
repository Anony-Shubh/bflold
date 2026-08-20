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
<head>
<title>PMEGP eTracking Monitoring Report</title>
<link rel="stylesheet" type="text/css" href="css/indexr.css">

<style type="text/css">
<!--
.style1 {font-size: 14px}
-->
</style>
</head>

<body>
<form  method="post">
  <div align="right">
    <%
	
	
 DBCon db= new DBCon();
 int srn =0;
db.connect();

String txtSearch="";
String p3="";

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
   String EDPOFF_CD=(String) request.getParameter("off_cd");
   
  String vQryCode=request.getParameter("QRYCODE")==null?"0":(String) request.getParameter("QRYCODE"); 
  out.print(vQryCode);
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");


String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;




//txtSearch=" and upper(zm.zone_nm) like upper('"+vsZonecd+"') and upper(ms.state_nm) like upper('"+vsStatecd+"') and MOM.AGENCY_TYPE like '"+vsAgency+"' ";
 
 if (vQryCode.equals("1")){
 
 txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE=1 AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
} else if (vQryCode.equals("2")){
// UNDER PROCESS AT AGENCY
  txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE=2 AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
  // PLACED BEFORE DLTFC COMMITTEE
  }else if (vQryCode.equals("3")){
  txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE IN (1,2) AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
 }else if (vQryCode.equals("4")){
 // REJECTED BY DLTFC COMMITTEE
   txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE=3 AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
 }else if (vQryCode.equals("5")){
 // Sanctioned by DLTFC COMMITTEE
 txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE=4 AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
 
  }else if (vQryCode.equals("6")){
 // Forwarded to Bank
   txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE IN(3,4) AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
  }else if (vQryCode.equals("7")){
 // Sanctioned by Bank
  txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
}else if (vQryCode.equals("8")){
 // Rejected by Bank
 txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE IN (1,2) AND ED.EDP_CERT_DT IS NOT NULL AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
 }else if (vQryCode.equals("9")){
 // Own Contribution Deposited
txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE IN (3,4) AND ED.EDP_CERT_DT IS NOT NULL AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
 }else if (vQryCode.equals("10")){
 //  LOAN RELEASED
 txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE IN (1,2) AND ED.EDP_CERT_DT IS  NULL AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
  }else if (vQryCode.equals("11")){
 // EDP TRANING COMPLETED
txtSearch = txtSearch + " and TRUNC(ED.EDPTIMESTAMP) between '"+FromDt+"' and  '"+ToDt+"' AND ED.EDP_TYPE IN (3,4) AND ED.EDP_CERT_DT IS NULL AND MS.STATE_CD='"+vStateCd+"'AND ED.EDPOFF_CD="+EDPOFF_CD+" " ;
 }else{
 // MM CLAIMED
  txtSearch = txtSearch + " and bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL  AND TRUNC(ad.online_subdt)  between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }
 StringBuffer sb= new StringBuffer();
 
 StringBuffer sb1=new StringBuffer();
 
sb.append("   SELECT ad.APP_ID,"      );
sb.append("     ad.APP_NAME,"      );
sb.append("     UPPER(ad.FH_NAME) AS FH_NAME,"      );
sb.append("     mom.AGENCY_TYPE,"      );
sb.append("     mom.OFF_NAME,"      );
sb.append("     ad.BANK_NAME,"      );
sb.append("     NVL(ad.REMARKS, '') AS Remraks_up_rej,"      );
sb.append("     ad.UNIT_LOC,"      );
sb.append("     ms.STATE_NM,ad.mob_no2 AS TEL_NO, "      );
//sb.append("     DECODE(ad.mob_no2,NULL,NULL, '*****'    || substr(ad.mob_no2,6,length(ad.mob_no2)-5)) AS TEL_NO,"      );
sb.append("     ad.E_MAIL,"      );
sb.append("     DECODE(ad.aadhar_no,NULL,NULL, '*****'     || substr(ad.aadhar_no,7,length(ad.aadhar_no)-6)) AADHAR_NO,"      );
sb.append("     TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') ONLINESUBDT,"      );
sb.append("     ad.BENF_SPECAT_CD,"      );
sb.append("     bd.PAY_STATUS,"      );
sb.append("     bd.UTRN_NO,"      );
sb.append("     bd.FAIL_REASON,"      );
sb.append("     ad.APP_POST_ADDR"      );
sb.append("     || ' , '"      );
sb.append("     || ad.APP_TALUK_BLOCK"      );
sb.append("     || ' '"      );
sb.append("     || ' Dist:'"      );
sb.append("     || bend.DISTRICT_NAME"      );
sb.append("     || ' Pin:'"      );
sb.append("     || ad.APP_PIN        AS app_addr,ad.mob_no2 AS ONLINEMOBNO,"      );
//sb.append("     DECODE(ad.mob_no1,NULL,NULL, '*****'    || substr(ad.mob_no1,6,length(ad.mob_no2)-5)) AS ONLINEMOBNO,"      );
sb.append("     MMINVOLVE(ad.APP_ID) AS MM_INV,"      );
sb.append("     BTM.BENF_TYPE_DESC,"      );
sb.append("     bcm.BENF_CATEGORY_DESC,"      );
sb.append("     ad.GENDER,"      );
sb.append("     TO_CHAR(ad.DOB, 'dd-mon-RRRR') AS dob,"      );
sb.append("     DECODE(ad.ACT_ID, 1, asm.ACT_DESC"      );
sb.append("     || ' At Agency-'"      );
sb.append("     || ad.REMARKS) AS dltfc_remarks,"      );
sb.append("     CASE"      );
sb.append("       WHEN ad.DOB IS NOT NULL"      );
sb.append("       THEN ROUND(months_between(ad.APP_REC_DATE, ad.DOB) / 12, 0)"      );
sb.append("     END AS age,"      );
sb.append("     ("      );
sb.append("     CASE"      );
sb.append("       WHEN ad.ACT_ID = 7"      );
sb.append("       THEN '-No-'"      );
sb.append("       WHEN ad.ACT_ID = 5"      );
sb.append("       THEN '-Yes-'"      );
sb.append("     END)                             AS DLTFC_REJ_yn,"      );
sb.append("     DECODE(ad.ACT_ID, 7, ad.REMARKS) AS dltfc_status,"      );
sb.append("     CASE"      );
sb.append("       WHEN ad.ACT_ID <> 5"      );
sb.append("       THEN asm.ACT_DESC"      );
sb.append("       ELSE bas.ACT_DESC"      );
sb.append("     END               AS current_status,"      );
sb.append("     udm.DISTRICT_NAME AS Unit_district,"      );
sb.append("     edm.EDU_DESC,"      );
sb.append("     ad.UNIT_POST_ADDR"      );
sb.append("     || ' '"      );
sb.append("     || ad.UNIT_TALUK_BLOCK"      );
sb.append("     || ' Dist:'"      );
sb.append("     || udm.DISTRICT_NAME"      );
sb.append("     || ' Pin:'"      );
sb.append("     || ad.UNIT_PIN                                       AS unit_addr,"      );
sb.append("     UPPER(ad.UNIT_TALUK_BLOCK)                           AS UNIT_TALUK_BLOCK,"      );
sb.append("     DECODE(ad.IND_TYPE, 'S', 'Service', 'Manufacturing') AS ind_type,"      );
sb.append("     igm.IND_GRP_LONG_DESC,"      );
sb.append("     am.ACTIVITY_NAME"      );
sb.append("     || ' / '"      );
sb.append("     || ad.PROD_DESC                                                                                            AS activity_name,"      );
sb.append("     NVL(ad.WORKSHED_COST, 0) + NVL(ad.PRE_OPE_EXP, 0) + NVL(ad.MACHINARY_COST, 0) + NVL(ad.WORKING_CAPITAL, 0) AS proj_cost,"      );
sb.append("     ad.BANK_NAME"      );
sb.append("     || ' , '"      );
sb.append("     || ad.BANK_POST_ADDR"      );
sb.append("     || ','"      );
sb.append("     || ad.BANK_TALUK_BLOCK"      );
sb.append("     || 'IFSC Code:'"      );
sb.append("     || ad.IFSC_CODE AS bank_addr,"      );
sb.append("     ("      );
sb.append("     CASE"      );
sb.append("       WHEN bd.ACT_ID = 3"      );
sb.append("       THEN 'No'"      );
sb.append("       WHEN bd.ACT_ID = 11"      );
sb.append("       THEN '-Yes-'"      );
sb.append("       WHEN bd.ACT_ID = 8"      );
sb.append("       THEN '-'"      );
sb.append("     END) bank_Status,"      );
sb.append("     TO_CHAR(ad.APP_REC_DATE, 'dd-mon-RRRR') AS app_rec_date,"      );
sb.append("     TO_CHAR(amm.MT_DATE, 'dd-mon-RRRR')     AS mt_date,"      );
sb.append("     amm.MTG_PLACE,"      );
sb.append("     TO_CHAR(ad.BANK_F_DATE, 'dd-mon-RRRR')                   AS bank_f_date,"      );
sb.append("     TO_CHAR(bd.BANK_REC_DT, 'dd-mon-RRRR')                   AS bank_rec_date,"      );
sb.append("     DECODE(bd.ACT_ID, 3, bd.BANK_REMARKS, '')                AS bank_remarks,"      );
sb.append("     TO_CHAR(bd.LOAN_SANC_DT, 'dd-mon-RRRR')                  AS loan_sanc_dt,"      );
sb.append("     (NVL(bd.MACHINARY_COST, 0))                              AS CE,"      );
sb.append("     NVL(bd.WORKING_CAPITAL, 0)                               AS WORKING_CAPITAL,"      );
sb.append("     (NVL(bd.MACHINARY_COST, 0) + NVL(bd.WORKING_CAPITAL, 0)) AS total_sanc,"      );
sb.append("     bd.OWN_CONTRIBUTION,"      );
sb.append("     0 AS bank_loan,"      );
sb.append("     bd.MM_CLAIM_AMT,"      );
sb.append("     ed.EDP_TRG_NAME                               AS edp_trg_nm,"      );
sb.append("     TO_CHAR(ed.EDP_FR_DT, 'dd-mon-RRRR')          AS edp_fr_dt,"      );
sb.append("     TO_CHAR(ed.EDP_TO_DT, 'dd-mon-RRRR')          AS edp_to_dt,"      );
sb.append("     TO_CHAR(ed.EDP_CERT_DT, 'dd-mon-RRRR')        AS EDP_CERT_DT,"      );
sb.append("     ''                                            AS Nodal_bank,"      );
sb.append("     NVL(bd.CE_SANC_FB, 0)                         AS CE_SANC_FB,"      );
sb.append("     NVL(bd.WC_SANC_FB, 0)                         AS WC_SANC_FB,"      );
sb.append("     NVL(bd.CE_SANC_FB, 0) + NVL(bd.WC_SANC_FB, 0) AS TOT_SANC_FB,"      );
sb.append("     bd.IST_LOAN_AMT,"      );
sb.append("     CASE"      );
sb.append("       WHEN ed.EDP_TO_DT IS NOT NULL"      );
sb.append("       THEN (ed.EDP_TO_DT - ed.EDP_FR_DT) + 1"      );
sb.append("     END                                    AS edp_days,"      );
sb.append("     TO_CHAR(bd.IST_LOAN_DT, 'dd-mon-RRRR') AS ist_loan_dt,"      );
sb.append("     bd.CGTSI,"      );
sb.append("     bd.MM_CLAIM_LRNO,"      );
sb.append("     TO_CHAR(bd.MM_CLAIM_DT, 'dd-mon-RRRR') AS mm_claim_dt,"      );
sb.append("     bd.MM_CLAIM_AMT,"      );
sb.append("     bd.MM_REL_AMT,"      );
sb.append("     TO_CHAR(bd.MM_REL_DT, 'dd-mon-RRRR') AS mm_rel_dt,"      );
sb.append("     bd.EMP,"      );
sb.append("     MRT.CO_REMARKS,"      );
sb.append("     bd.PROD,"      );
sb.append("     bd.SALES,"      );
sb.append("     TO_CHAR(bd.PV_DT, 'dd-mon-RRRR') AS pv_dt,"      );
sb.append("     bd.PV_VER_OFF,"      );
sb.append("     bd.MM_ADJ_BY,"      );
sb.append("     bd.MM_ADJ_AMT,"      );
sb.append("     TO_CHAR(bd.MM_ADJ_DT, 'dd-mon-RRRR') AS mm_adj_dt,"      );
sb.append("     bd.EDP_YN,"      );
sb.append("     bd.PH_YN,"      );
sb.append("     bd.PV_STATUS,"      );
sb.append("     bd.OWN_CONTRIBUTION,"      );
sb.append("     TO_CHAR(bd.OWN_CONT_DT, 'dd-mon-RRRR') AS OWN_CONT_DT,"      );
sb.append("     bd.PHY_PROD,"      );
sb.append("     bd.PHY_SALES,"      );
sb.append("     bd.PHY_EMP,"      );
sb.append("     bd.PHY_INV"      );
sb.append("   FROM app_detail  AD,"      );
sb.append("     bank_dataentry bd,"      );
sb.append("     edp_conduct_trans ed,"      );
sb.append("     m_district dm,"      );
sb.append("     mas_off_mast mom,"      );
sb.append("     m_state ms,"      );
sb.append("     app_meeting_mast amm,"      );
sb.append("     benf_type_mast BTM,"      );
sb.append("     benf_category_mast bcm,"      );
sb.append("     m_district bend,"      );
sb.append("     education_mast edm,"      );
sb.append("     m_district udm,"      );
sb.append("     app_status_mast asm,"      );
sb.append("     bank_app_status bas,"      );
sb.append("     activity_mast am,"      );
sb.append("     ind_grp_mast igm,"      );
sb.append("     MM_REMARKS_TRANS MRT,"      );
sb.append("     zone_mast zm"      );
sb.append("   WHERE  ad.APP_Id = ed.APP_ID"      );
sb.append("   AND ms.ZONE_CD          = zm.ZONE_CD"      );
sb.append("   AND bd.REMTRID          = MRT.REMTR_ID(+)"      );
sb.append("   AND ad.APP_ID           = bd.APP_ID(+)"      );
sb.append("   AND ad.app_dist_cd     = dm.DISTRICT_CD"      );
sb.append("   AND dm.STATE_CD         = ms.STATE_CD"      );
sb.append("   AND ad.MTG_ID           = amm.MTG_ID(+)"      );
sb.append("   AND ad.ACT_ID           = asm.ACT_ID"      );
sb.append("   AND bd.ACT_ID           = bas.ACT_ID(+)"      );
sb.append("   AND ad.APP_DIST_CD      = bend.DISTRICT_CD"      );
sb.append("   AND ad.BENF_TYPE_CD     = BTM.BENF_TYPE_CD"      );
sb.append("   AND ad.BENF_CATAGORY_CD = bcm.BENF_CATEGORY_CD"      );
sb.append("   AND ad.EDU_ID           = edm.EDU_ID"      );
sb.append("   AND ad.UNIT_DIST_CD     = udm.DISTRICT_CD"      );
sb.append("   AND ed.EDPOFF_CD        = mom.OFF_CD"      );
sb.append("   AND ad.ACTIVITY_CD      = am.ACTIVITY_CD"      );
sb.append("   AND am.IND_GRP_CD       = igm.IND_GRP_CD AND ED.ACT_YN='Y' "      );
sb.append("   "+txtSearch+"  "      );
sb.append("   "      );
sb.append("   UNION "      );
sb.append("   "      );
sb.append("   SELECT ad.APP_ID,"      );
sb.append("     ad.APP_NAME,"      );
sb.append("     UPPER(ad.FH_NAME) AS FH_NAME,"      );
sb.append("     mom.AGENCY_TYPE,"      );
sb.append("     mom.OFF_NAME,"      );
sb.append("     ad.BANK_NAME,"      );
sb.append("     NVL(ad.REMARKS, '') AS Remraks_up_rej,"      );
sb.append("     ad.UNIT_LOC,"      );
sb.append("     ms.STATE_NM,"      );
sb.append("     DECODE(ad.mob_no2,NULL,NULL, '*****'    || substr(ad.mob_no2,6,length(ad.mob_no2)-5)) AS TEL_NO,"      );
sb.append("     ad.E_MAIL,"      );
sb.append("     DECODE(ad.aadhar_no,NULL,NULL, '*****'     || substr(ad.aadhar_no,7,length(ad.aadhar_no)-6)) AADHAR_NO,"      );
sb.append("     TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') ONLINESUBDT,"      );
sb.append("     ad.BENF_SPECAT_CD,"      );
sb.append("     bd.PAY_STATUS,"      );
sb.append("     bd.UTRN_NO,"      );
sb.append("     bd.FAIL_REASON,"      );
sb.append("     ad.APP_POST_ADDR"      );
sb.append("     || ' , '"      );
sb.append("     || ad.APP_TALUK_BLOCK"      );
sb.append("     || ' '"      );
sb.append("     || ' Dist:'"      );
sb.append("     || bend.DISTRICT_NAME"      );
sb.append("     || ' Pin:'"      );
sb.append("     || ad.APP_PIN        AS app_addr,"      );
sb.append("   DECODE(ad.mob_no1,NULL,NULL, '*****'    || substr(ad.mob_no1,6,length(ad.mob_no2)-5))         AS ONLINEMOBNO,"      );
sb.append("     MMINVOLVE(ad.APP_ID) AS MM_INV,"      );
sb.append("     BTM.BENF_TYPE_DESC,"      );
sb.append("     bcm.BENF_CATEGORY_DESC,"      );
sb.append("     ad.GENDER,"      );
sb.append("     TO_CHAR(ad.DOB, 'dd-mon-RRRR') AS dob,"      );
sb.append("     DECODE(ad.ACT_ID, 1, asm.ACT_DESC"      );
sb.append("     || ' At Agency-'"      );
sb.append("     || ad.REMARKS) AS dltfc_remarks,"      );
sb.append("     CASE"      );
sb.append("       WHEN ad.DOB IS NOT NULL"      );
sb.append("       THEN ROUND(months_between(ad.APP_REC_DATE, ad.DOB) / 12, 0)"      );
sb.append("     END AS age,"      );
sb.append("     ("      );
sb.append("     CASE"      );
sb.append("       WHEN ad.ACT_ID = 7"      );
sb.append("       THEN '-No-'"      );
sb.append("       WHEN ad.ACT_ID = 5"      );
sb.append("       THEN '-Yes-'"      );
sb.append("     END)                             AS DLTFC_REJ_yn,"      );
sb.append("     DECODE(ad.ACT_ID, 7, ad.REMARKS) AS dltfc_status,"      );
sb.append("     CASE"      );
sb.append("       WHEN ad.ACT_ID <> 5"      );
sb.append("       THEN asm.ACT_DESC"      );
sb.append("       ELSE bas.ACT_DESC"      );
sb.append("     END               AS current_status,"      );
sb.append("     udm.DISTRICT_NAME AS Unit_district,"      );
sb.append("     edm.EDU_DESC,"      );
sb.append("     ad.UNIT_POST_ADDR"      );
sb.append("     || ' '"      );
sb.append("     || ad.UNIT_TALUK_BLOCK"      );
sb.append("     || ' Dist:'"      );
sb.append("     || udm.DISTRICT_NAME"      );
sb.append("     || ' Pin:'"      );
sb.append("     || ad.UNIT_PIN                                       AS unit_addr,"      );
sb.append("     UPPER(ad.UNIT_TALUK_BLOCK)                           AS UNIT_TALUK_BLOCK,"      );
sb.append("     DECODE(ad.IND_TYPE, 'S', 'Service', 'Manufacturing') AS ind_type,"      );
sb.append("     igm.IND_GRP_LONG_DESC,"      );
sb.append("     am.ACTIVITY_NAME"      );
sb.append("     || ' / '"      );
sb.append("     || ad.PROD_DESC                                                                                            AS activity_name,"      );
sb.append("     NVL(ad.WORKSHED_COST, 0) + NVL(ad.PRE_OPE_EXP, 0) + NVL(ad.MACHINARY_COST, 0) + NVL(ad.WORKING_CAPITAL, 0) AS proj_cost,"      );
sb.append("     ad.BANK_NAME"      );
sb.append("     || ' , '"      );
sb.append("     || ad.BANK_POST_ADDR"      );
sb.append("     || ','"      );
sb.append("     || ad.BANK_TALUK_BLOCK"      );
sb.append("     || 'IFSC Code:'"      );
sb.append("     || ad.IFSC_CODE AS bank_addr,"      );
sb.append("     ("      );
sb.append("     CASE"      );
sb.append("       WHEN bd.ACT_ID = 3"      );
sb.append("       THEN 'No'"      );
sb.append("       WHEN bd.ACT_ID = 11"      );
sb.append("       THEN '-Yes-'"      );
sb.append("       WHEN bd.ACT_ID = 8"      );
sb.append("       THEN '-'"      );
sb.append("     END) bank_Status,"      );
sb.append("     TO_CHAR(ad.APP_REC_DATE, 'dd-mon-RRRR') AS app_rec_date,"      );
sb.append("     TO_CHAR(amm.MT_DATE, 'dd-mon-RRRR')     AS mt_date,"      );
sb.append("     amm.MTG_PLACE,"      );
sb.append("     TO_CHAR(ad.BANK_F_DATE, 'dd-mon-RRRR')                   AS bank_f_date,"      );
sb.append("     TO_CHAR(bd.BANK_REC_DT, 'dd-mon-RRRR')                   AS bank_rec_date,"      );
sb.append("     DECODE(bd.ACT_ID, 3, bd.BANK_REMARKS, '')                AS bank_remarks,"      );
sb.append("     TO_CHAR(bd.LOAN_SANC_DT, 'dd-mon-RRRR')                  AS loan_sanc_dt,"      );
sb.append("     (NVL(bd.MACHINARY_COST, 0))                              AS CE,"      );
sb.append("     NVL(bd.WORKING_CAPITAL, 0)                               AS WORKING_CAPITAL,"      );
sb.append("     (NVL(bd.MACHINARY_COST, 0) + NVL(bd.WORKING_CAPITAL, 0)) AS total_sanc,"      );
sb.append("     bd.OWN_CONTRIBUTION,"      );
sb.append("     0 AS bank_loan,"      );
sb.append("     bd.MM_CLAIM_AMT,"      );
sb.append("     ed.EDP_TRG_NAME                               AS edp_trg_nm,"      );
sb.append("     TO_CHAR(ed.EDP_FR_DT, 'dd-mon-RRRR')          AS edp_fr_dt,"      );
sb.append("     TO_CHAR(ed.EDP_TO_DT, 'dd-mon-RRRR')          AS edp_to_dt,"      );
sb.append("     TO_CHAR(ed.EDP_CERT_DT, 'dd-mon-RRRR')        AS EDP_CERT_DT,"      );
sb.append("     ''                                            AS Nodal_bank,"      );
sb.append("     NVL(bd.CE_SANC_FB, 0)                         AS CE_SANC_FB,"      );
sb.append("     NVL(bd.WC_SANC_FB, 0)                         AS WC_SANC_FB,"      );
sb.append("     NVL(bd.CE_SANC_FB, 0) + NVL(bd.WC_SANC_FB, 0) AS TOT_SANC_FB,"      );
sb.append("     bd.IST_LOAN_AMT,"      );
sb.append("     CASE"      );
sb.append("       WHEN ed.EDP_TO_DT IS NOT NULL"      );
sb.append("       THEN (ed.EDP_TO_DT - ed.EDP_FR_DT) + 1"      );
sb.append("     END                                    AS edp_days,"      );
sb.append("     TO_CHAR(bd.IST_LOAN_DT, 'dd-mon-RRRR') AS ist_loan_dt,"      );
sb.append("     bd.CGTSI,"      );
sb.append("     bd.MM_CLAIM_LRNO,"      );
sb.append("     TO_CHAR(bd.MM_CLAIM_DT, 'dd-mon-RRRR') AS mm_claim_dt,"      );
sb.append("     bd.MM_CLAIM_AMT,"      );
sb.append("     bd.MM_REL_AMT,"      );
sb.append("     TO_CHAR(bd.MM_REL_DT, 'dd-mon-RRRR') AS mm_rel_dt,"      );
sb.append("     bd.EMP,"      );
sb.append("     MRT.CO_REMARKS,"      );
sb.append("     bd.PROD,"      );
sb.append("     bd.SALES,"      );
sb.append("     TO_CHAR(bd.PV_DT, 'dd-mon-RRRR') AS pv_dt,"      );
sb.append("     bd.PV_VER_OFF,"      );
sb.append("     bd.MM_ADJ_BY,"      );
sb.append("     bd.MM_ADJ_AMT,"      );
sb.append("     TO_CHAR(bd.MM_ADJ_DT, 'dd-mon-RRRR') AS mm_adj_dt,"      );
sb.append("     bd.EDP_YN,"      );
sb.append("     bd.PH_YN,"      );
sb.append("     bd.PV_STATUS,"      );
sb.append("     bd.OWN_CONTRIBUTION,"      );
sb.append("     TO_CHAR(bd.OWN_CONT_DT, 'dd-mon-RRRR') AS OWN_CONT_DT,"      );
sb.append("     bd.PHY_PROD,"      );
sb.append("     bd.PHY_SALES,"      );
sb.append("     bd.PHY_EMP,"      );
sb.append("     bd.PHY_INV"      );
sb.append("   FROM app_detail_online  AD,"      );
sb.append("     bank_dataentry bd,"      );
sb.append("     edp_conduct_trans ed,"      );
sb.append("     m_district dm,"      );
sb.append("     mas_off_mast mom,"      );
sb.append("     m_state ms,"      );
sb.append("     app_meeting_mast amm,"      );
sb.append("     benf_type_mast BTM,"      );
sb.append("     benf_category_mast bcm,"      );
sb.append("     m_district bend,"      );
sb.append("     education_mast edm,"      );
sb.append("     m_district udm,"      );
sb.append("     app_status_mast asm,"      );
sb.append("     bank_app_status bas,"      );
sb.append("     activity_mast am,"      );
sb.append("     ind_grp_mast igm,"      );
sb.append("     MM_REMARKS_TRANS MRT,"      );
sb.append("     zone_mast zm"      );
sb.append("   WHERE  ad.APP_Id = ed.APP_ID"      );
sb.append("   AND ms.ZONE_CD          = zm.ZONE_CD"      );
sb.append("   AND bd.REMTRID          = MRT.REMTR_ID(+)"      );
sb.append("   AND ad.APP_ID           = bd.APP_ID(+)"      );
sb.append("   AND ad.app_dist_cd     = dm.DISTRICT_CD"      );
sb.append("   AND dm.STATE_CD         = ms.STATE_CD"      );
sb.append("   AND ad.MTG_ID           = amm.MTG_ID(+)"      );
sb.append("   AND ad.ACT_ID           = asm.ACT_ID"      );
sb.append("   AND bd.ACT_ID           = bas.ACT_ID(+)"      );
sb.append("   AND ad.APP_DIST_CD      = bend.DISTRICT_CD"      );
sb.append("   AND ad.BENF_TYPE_CD     = BTM.BENF_TYPE_CD"      );
sb.append("   AND ad.BENF_CATAGORY_CD = bcm.BENF_CATEGORY_CD"      );
sb.append("   AND ad.EDU_ID           = edm.EDU_ID"      );
sb.append("   AND ad.UNIT_DIST_CD     = udm.DISTRICT_CD"      );
sb.append("   AND ed.EDPOFF_CD        = mom.OFF_CD"      );
sb.append("   AND ad.ACTIVITY_CD      = am.ACTIVITY_CD"      );
sb.append("   AND am.IND_GRP_CD       = igm.IND_GRP_CD"      );
sb.append("   AND AD.APP_ID NOT IN (SELECT APP_ID FROM APP_DETAIL WHERE ACT_ID > =0 AND APP_ID=AD.APP_ID)"      );
sb.append("   and ad.act_id=-1 AND ED.ACT_YN='Y' "      );
sb.append("   "+txtSearch+"  "      );



//out.print (sb.toString());
ResultSet rsinst = db.execSQL(sb.toString());

//out.print (sb.toString());
//response.setContentType("application/vnd.ms-excel");
//response.setHeader("Content-Disposition", "inline; filename=" + "excel.xls"); 
 
    %>
   
    

  
  </div>
  <table border="2" align="center" bordercolor="#000000">
  <tr>
    <th colspan="64" align="left" nowrap="nowrap"><div align="left">PMEGP Detail Report for the period from <%= FromDt %> to <%= ToDt %>of Agency :<%= vAgency %></div></th>
    </tr>
  <tr>
   <th rowspan="2" align="left">     srno</th>
    <th rowspan="2" align="left">Current Status </th>
    <th rowspan="2" align="left">Under Process /Rejection by Agency Reason </th>
    <th rowspan="2" align="left">Office Name </th>
    <th rowspan="2" align="left">Agency Type </th>
    <th rowspan="2" align="left">State</th>
    <th rowspan="2" align="left">Applicant ID      </th>
    <th rowspan="2" align="left"> Applicant Name </th>
    <th rowspan="2" align="left">Applicant Address </th>
    <th rowspan="2" align="left">Mobile No. </th>
    <th rowspan="2" align="left">Alternative Mobile No </th>
    <th rowspan="2" align="left">eMail</th>
    <th rowspan="2" align="left">AADHAR</th>
    <th rowspan="2" align="left">Legal Status </th>
    <th rowspan="2" align="left">Gender</th>
    <th rowspan="2" align="left">Category</th>
    <th rowspan="2" align="left">Special Category </th>
    <th rowspan="2" align="left">
      Qualification</th>
    <th rowspan="2" align="left">Date of Birth </th>
    <th rowspan="2" align="left">Age</th>
    <th rowspan="2" align="left">Unit Location </th>
    <th rowspan="2" align="left">Unit Address </th>
    <th rowspan="2" align="left">Taluk/block</th>
    <th rowspan="2" align="left">Unit District </th>
    <th rowspan="2" align="left">Industry Type </th>
    <th rowspan="2" align="left">Product Desc/Activity </th>
    <th rowspan="2" align="left">Proposed Project Cost </th>
    <th rowspan="2" align="left">MM Involve </th>
    <th rowspan="2" align="left">Financing Branch Address </th>
    <th rowspan="2" align="left">Online Submission Date </th>
    <th rowspan="2" align="left">DLTFC Meeting  </th>
    <th rowspan="2" align="left">DLTFC Meeting Place </th>
    <th rowspan="2" align="left">Forwarding Date to Bank </th>
    <th rowspan="2" align="left">Bank Remarks </th>
    <th rowspan="2" align="left">Date of Document Received at Bank </th>
    <th colspan="3" align="left">Project Cost Approved by Bank</th>
    <th colspan="4" align="left">Sanctioned by Bank </th>
    <th rowspan="2" align="left"> Date of Deposit Own Contribution </th>
    <th rowspan="2" align="left">Own Contribution amount Deposited </th>
    <th rowspan="2" align="left">Covered Under CGTSI </th>
    <th rowspan="2" align="left">Date of Loan Release</th>
    <th rowspan="2" align="left">Loan Release Amount</th>
    <th rowspan="2" align="left">MM Claim Date </th>
    <th rowspan="2" align="left">MM Claim Amount </th>
    <th rowspan="2" align="left">Remraks for MM Process at PMEGP,CO,Mumbai </th>
    <th rowspan="2" align="left">MM Release Date</th>
    <th rowspan="2" align="left">MM Release Amount </th>
    <th rowspan="2" align="left">Payment Status (Fail/Sucess) </th>
    <th rowspan="2" align="left">MM disbursement Transation id </th>
    <th rowspan="2" align="left">Fail Reason </th>
    <th rowspan="2" align="left">EDP Training Center Name </th>
    <th rowspan="2" align="left">Training Start Date</th>
    <th rowspan="2" align="left">Training End Date </th>
    <th rowspan="2" align="left">Duration of Training <br />
        ( No of Days) </th>
    <th rowspan="2" align="left">Certficate Issue Date </th>
    <th rowspan="2" align="left">Physical Verification Conducted Date</th>
    <th rowspan="2" align="left">Physical Verification Status </th>
    <th rowspan="2" align="left">MM Final Adjustment Date </th>
    <th rowspan="2" align="left">MM Final Adjustment Amount </th>
  </tr>
  <tr>
    <th align="left">CE</th>
    <th align="left">WC</th>
    <th align="left"><strong>TOTAL</strong></th>
    <th align="left">Date</th>
    <th align="left">CE</th>
    <th align="left">WC</th>
    <th align="left">Total</th>
  </tr>
 
  <tr>
    <th align="left" >
      1</th>
    <th align="left" >2</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >3</th>
    <th align="left" >4</th>
    <th align="left" >5</th>
    <th align="left" >
      6</th>
    <th align="left" >7</th>
    <th align="left">8</th>
    <th align="left" >9</th>
    <th align="left" >10</th>
    <th align="left" >11</th>
    <th align="left" >12</th>
    <th align="left" >
      13</th>
    <th align="left" >14</th>
    <th align="left" >
      15</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >
      16</th>
    <th align="left" >17</th>
    <th align="left" >18</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >19</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >20</th>
    <th align="left" >21</th>
    <th align="left" >22</th>
    <th align="left" >23</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >24</th>
    <th align="left" >25</th>
    <th align="left" >26</th>
    <th align="left" >27</th>
    <th align="left" >28(A)</th>
    <th align="left" >28(B)</th>
    <th align="left" >29</th>
    <th align="left" >31</th>
    <th align="left" >32</th>
    <th align="left" >33</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >34</th>
    <th align="left" >35</th>
    <th align="left" >36</th>
    <th align="left" >37</th>
    <th align="left" >38</th>
    <th align="left" >39</th>
    <th align="left" >40</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >41</th>
    <th align="left" >42</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >&nbsp;</th>
    <th align="left" >43</th>
    <th align="left" >44</th>
    <th align="left" >45</th>
    <th align="left" >46</th>
    <th align="left" >47</th>
    <th align="left" >48</th>
    <th align="left" >49</th>
    <th align="left" >50</th>
    <th align="left" >51</th>
  </tr>
   <% while (rsinst.next()) {
  srn=srn+1;
  //p3=addUrl+"&BANKNAME="+rsinst.getString("BANK_NAME")+"&QRYCODE="+vQryCode;
   %>
  <tr>
    <td align="left" ><%=srn%>)</td>
    <td align="left" ><%=getNum( rsinst.getString("current_status") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("Remraks_up_rej") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("off_name") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("agency_type") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("state_nm") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("app_id") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("APP_NAME") )%></td>
    <td align="left"><%=getNum( rsinst.getString("app_addr") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("ONLINEMOBNO") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("TEL_NO") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("E_MAIL") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("AADHAR_NO") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("benf_type_desc") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("Gender") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("benf_category_desc") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("BENF_SPECAT_CD") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("EDU_DESC") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("dob") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("age") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("UNIT_LOC") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("UNIT_ADDR") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("unit_taluk_block") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("UNIT_DISTRICT") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("ind_type") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("ACTIVITY_NAME") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("PROJ_COST") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("MM_INV") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("bank_addr") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("ONLINESUBDT") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mt_date") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mtg_place") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("bank_f_date") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("bank_remarks") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("bank_rec_date") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("CE") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("working_capital") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("total_sanc") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("loan_sanc_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("CE_SANC_FB") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("WC_SANC_FB") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("TOT_SANC_FB") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("OWN_CONT_DT") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("OWN_CONTRIBUTION") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("cgtsi") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("Ist_loan_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("Ist_loan_amt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_claim_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_claim_amt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("CO_REMARKS") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_rel_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_rel_amt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("PAY_STATUS") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("UTRN_NO") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("FAIL_REASON") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("edp_trg_nm") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("edp_fr_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("edp_to_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("edp_days") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("EDP_CERT_DT") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("PV_DT") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("PV_STATUS") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_adj_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_adj_amt") )%></td>
  </tr>
 <%
 
}
rsinst.close();
db.close();
//out.print(vQryCode);

%>
</table>
 
</form>

</body>
</html>
