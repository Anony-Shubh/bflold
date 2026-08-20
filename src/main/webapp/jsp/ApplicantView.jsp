SELECT AD.APP_ID,
  AD.APP_NAME,
  mom.AGENCY_TYPE,
  mom.OFF_NAME,
  ms.STATE_NM,
  AD.UNIT_LOC,
  AD.PROD_DESC,
  AD.ACT_ID,
  BTM.BENF_TYPE_DESC,
  bcm.BENF_CATEGORY_DESC,
  AD.GENDER,
  CASE
    WHEN AD.DOB IS NOT NULL
    THEN ROUND(months_between(AD.APP_REC_DATE, AD.DOB) / 12, 0)
  END AS age,
  CASE
    WHEN  BD.ACT_ID > 7
    THEN bas.ACT_DESC
	
	
    ELSE asm.ACT_DESC
  END AS current_status,
  AD.UNIT_POST_ADDR,
  AD.UNIT_TALUK_BLOCK,
  udm.DISTRICT_NAME AS UNIT_DIST,
  AD.UNIT_PIN,
  AD.IND_TYPE,
  am.ACTIVITY_NAME,
  NVL(AD.MACHINARY_COST, 0) + NVL(AD.WORKING_CAPITAL, 0) AS PROP_proj_cost,
  AD.BANK_NAME,
  AD.BANK_POST_ADDR,
  AD.BANK_TALUK_BLOCK,
  AD.IFSC_CODE                            AS BANK_CODE,
  TO_CHAR(AD.APP_REC_DATE, 'dd-mon-RRRR') AS app_rec_date,
  TO_CHAR(amm.MT_DATE, 'dd-mon-RRRR')     AS mgt_date,
  amm.MTG_PLACE,
  TO_CHAR(AD.BANK_F_DATE, 'dd-mon-RRRR') AS bank_f_date,
  TO_CHAR(bd.BANK_REC_DT, 'dd-mon-RRRR') AS bank_rec_date,
  bd.BANK_REMARKS,
  TO_CHAR(bd.LOAN_SANC_DT, 'dd-mon-RRRR') AS loan_sanc_dt,
  (bd.MACHINARY_COST)                     AS CE,
  bd.WORKING_CAPITAL,
  (bd.MACHINARY_COST + bd.WORKING_CAPITAL) AS total_Loan,
  bd.EDP_TRG_NAME                          AS edp_trg_nm,
  TO_CHAR(bd.EDP_FR_DT, 'dd-mon-RRRR')     AS edp_fr_dt,
  TO_CHAR(bd.EDP_TO_DT, 'dd-mon-RRRR')     AS edp_to_dt,
  TO_CHAR(bd.EDP_CERT_DT, 'dd-mon-RRRR')   AS edp_cert_iss_dt,
  bd.IST_LOAN_AMT,
  CASE
    WHEN bd.EDP_TO_DT IS NOT NULL
    THEN (bd.EDP_TO_DT - bd.EDP_FR_DT) + 1
  END                                    AS edp_days,
  TO_CHAR(bd.IST_LOAN_DT, 'dd-mon-RRRR') AS ist_loan_dt,
  TO_CHAR(bd.MM_CLAIM_DT, 'dd-mon-RRRR') AS mm_claim_dt,
  bd.MM_CLAIM_AMT,
  AD.REMARKS,
  bd.MM_REL_AMT,
  TO_CHAR(bd.MM_REL_DT, 'dd-mon-RRRR') AS mm_rel_dt,
  bd.OWN_CONTRIBUTION,
  TO_CHAR(bd.OWN_CONT_DT, 'dd-mon-RRRR') AS own_dep_dt,
  AD.DLTFC_CE,
  AD.DLTFC_WC,
 
  bd.EDP_CERT_DT,
 
  bd.OWN_CONT_DT,
 
  bd.MM_CLAIM_LRNO,
  bd.TDR_ADJ_DT,
  bd.TDR_ADJ_AMT,
  bd.BANK_COMMENT
FROM app_detail AD,
  BANK_DATAENTRY bd,
  m_district dm,
  mas_off_mast mom,
  m_state ms,
  app_meeting_mast amm,
  benf_type_mast BTM,
  benf_category_mast bcm,
  m_district udm,
  m_district bdma,
  app_status_mast asm,
  bank_app_status bas,
  activity_mast am
WHERE AD.APP_ID         = bd.APP_ID(+)
AND AD.UNIT_DIST_CD     = dm.DISTRICT_CD
AND dm.STATE_CD         = ms.STATE_CD
AND AD.MTG_ID           = amm.MTG_ID(+)
AND AD.ACT_ID           = asm.ACT_ID(+)
AND bd.ACT_ID           = bas.ACT_ID(+)
AND AD.BANK_DIST_CD     = bdma.DISTRICT_CD(+)
AND AD.BENF_TYPE_CD     = BTM.BENF_TYPE_CD
AND AD.BENF_CATAGORY_CD = bcm.BENF_CATEGORY_CD
AND AD.UNIT_DIST_CD     = udm.DISTRICT_CD
AND AD.OFF_CD           = mom.OFF_CD
AND AD.ACTIVITY_CD      = am.ACTIVITY_CD
AND upper(AD.APP_ID)    = UPPER('E137-1')