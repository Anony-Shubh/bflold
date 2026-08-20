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

</head>

<body>
<form  method="post">
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
  txtSearch = txtSearch + " and TRUNC (bd.EDP_CERT_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  bd.EDP_CERT_DT IS NOT NULL AND bd.act_id=11 ";
 }else if (vQryCode.equals("11")){
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
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date)  between '"+FromDt+"' and '"+ToDt+"' and  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5   ";

 }else if (vQryCode.equals("40")){
 // CLAIMS REFERRED TO FIELD OFFICES
  txtSearch = txtSearch + " and TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  BD.PACT_ID=30 AND ad.act_id=5   ";
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
 

 StringBuffer sb= new StringBuffer();
 
 StringBuffer sb1=new StringBuffer();
 

sb.append("   SELECT ad.APP_ID,  ad.APP_NAME,    mom.AGENCY_TYPE,  mom.OFF_NAME,  NVL(ad.REMARKS, '') AS Remraks_up_rej,  ad.UNIT_LOC, ").
append("  bd.TDR_ACNO,  TO_CHAR(bd.TDR_ADJ_DT, 'DD-MON-RRRR') AS TDR_ADJ_DT,  ms.STATE_NM,  DECODE(ad.mob_no2,NULL,NULL, '*****'    || substr(ad.mob_no2,6,length(ad.mob_no2)-5))  AS TEL_NO,  ad.E_MAIL, ").
append("  DECODE(ad.aadhar_no,NULL,NULL, '*****'     || substr(ad.aadhar_no,7,length(ad.aadhar_no)-6)) AADHAR_NO,  TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') ONLINESUBDT,  ad.BENF_SPECAT_CD,  bd.PAY_STATUS,  bd.UTRN_NO, ").
append("  bd.FAIL_REASON,  ad.APP_POST_ADDR  || ' , '  || ad.APP_TALUK_BLOCK  || ' '  || ' Dist:'  || bend.DISTRICT_NAME  || ' Pin:'  || ad.APP_PIN        AS app_addr, ").
append("   DECODE(ad.mob_no1,NULL,NULL, '*****'     || substr(ad.mob_no1,6,length(ad.mob_no1)-5))          AS ONLINEMOBNO,  MMINVOLVE_SEC(ad.APP_ID) AS MM_INV,    bcm.BENF_CATEGORY_DESC,  ad.GENDER, ").
append("  CASE    WHEN ad.ACT_ID <> 5    THEN asm.ACT_DESC    ELSE bas.ACT_DESC  END               AS current_status,  udm.DISTRICT_NAME AS Unit_district, ").
append("  ad.UNIT_POST_ADDR  || ' '  || ad.UNIT_TALUK_BLOCK  || ' Dist:'  || udm.DISTRICT_NAME  || ' Pin:'  || ad.UNIT_PIN                                       AS unit_addr, ").
append("  UPPER(ad.UNIT_TALUK_BLOCK)                           AS UNIT_TALUK_BLOCK,  DECODE(ad.IND_TYPE, 'S', 'Service', 'Manufacturing') AS ind_type, ").
append("  igm.IND_GRP_LONG_DESC,  am.ACTIVITY_NAME  || ' / '  || ad.PROD_DESC   AS activity_name, ").
append("  NVL(ad.WORKSHED_COST, 0) + NVL(ad.PRE_OPE_EXP, 0) + NVL(ad.MACHINARY_COST, 0) + NVL(ad.WORKING_CAPITAL, 0) AS proj_cost, ").
append("  ad.BANK_NAME  || ' , '  || ad.BANK_POST_ADDR  || ','  || ad.BANK_TALUK_BLOCK  || 'IFSC Code:'  || ad.IFSC_CODE AS bank_addr,  ( ").
append(" CASE    WHEN bd.ACT_ID = 3    THEN 'No'    WHEN bd.ACT_ID = 11    THEN '-Yes-'    WHEN bd.ACT_ID = 8    THEN '-'  END) bank_Status, ").
append("  TO_CHAR(ad.APP_REC_DATE, 'dd-mon-RRRR') AS app_rec_date, ").
append("  TO_CHAR(ad.BANK_F_DATE, 'dd-mon-RRRR')                   AS bank_f_date, ").
append("  TO_CHAR(bd.BANK_REC_DT, 'dd-mon-RRRR')                   AS bank_rec_date, ").
append("  DECODE(bd.ACT_ID, 3, bd.BANK_REMARKS, '')                AS bank_remarks, ").
append("  TO_CHAR(bd.LOAN_SANC_DT, 'dd-mon-RRRR')                  AS loan_sanc_dt, ").
append("  (NVL(bd.MACHINARY_COST, 0))                              AS CE,  NVL(bd.WORKING_CAPITAL, 0)                               AS WORKING_CAPITAL, ").
append("  (NVL(bd.MACHINARY_COST, 0) + NVL(bd.WORKING_CAPITAL, 0)) AS total_sanc, ").
append("  bd.OWN_CONTRIBUTION,  0 AS bank_loan,  bd.MM_CLAIM_AMT,  ''   AS Nodal_bank, ").
append("  NVL(bd.CE_SANC_FB, 0)                         AS CE_SANC_FB,  NVL(bd.WC_SANC_FB, 0)                         AS WC_SANC_FB, ").
append("  NVL(bd.CE_SANC_FB, 0) + NVL(bd.WC_SANC_FB, 0) AS TOT_SANC_FB,  bd.IST_LOAN_AMT, ").
append("  TO_CHAR(bd.IST_LOAN_DT, 'dd-mon-RRRR') AS ist_loan_dt,  bd.CGTSI,  bd.MM_CLAIM_LRNO, ").
append("  TO_CHAR(bd.MM_CLAIM_DT, 'dd-mon-RRRR') AS mm_claim_dt,  bd.MM_CLAIM_AMT,  bd.MM_REL_AMT,  TO_CHAR(bd.MM_REL_DT, 'dd-mon-RRRR') AS mm_rel_dt,  ").
append("  MRT.CO_REMARKS,  bd.PROD,  bd.SALES,  TO_CHAR(bd.PV_DT, 'dd-mon-RRRR') AS pv_dt,  bd.PV_VER_OFF,  bd.MM_ADJ_BY,  bd.MM_ADJ_AMT, ").
append("  TO_CHAR(bd.MM_ADJ_DT, 'dd-mon-RRRR') AS mm_adj_dt,   bd.PH_YN,  bd.PV_STATUS,  bd.OWN_CONTRIBUTION,  TO_CHAR(bd.OWN_CONT_DT, 'dd-mon-RRRR') AS OWN_CONT_DT, ").
append("  bd.PHY_PROD,  bd.PHY_SALES,  bd.PHY_EMP,  bd.PHY_INV ").
append(" FROM app_detail_second ad,  bank_dataentry_second bd,  m_district dm,  mas_off_mast mom,  m_state ms,  benf_category_mast bcm,  m_district bend,  ").
append("  m_district udm,  app_status_mast asm,  bank_app_status bas,  activity_mast am,  ind_grp_mast igm,").
append("  MM_REMARKS_TRANS_second MRT,  zone_mast zm").
append(" WHERE ms.ZONE_CD        = zm.ZONE_CD  AND bd.REMTRID  = MRT.REMTR_ID(+) AND ad.APP_ID= bd.APP_ID(+)").
append(" AND ad.UNIT_DIST_CD     = dm.DISTRICT_CD AND dm.STATE_CD= ms.STATE_CD AND ad.ACT_ID = asm.ACT_ID").
append(" AND bd.ACT_ID           = bas.ACT_ID(+) AND ad.APP_DIST_CD      = bend.DISTRICT_CD").
append(" and ad.benf_catagory_cd=bcm.benf_category_cd and ad.unit_dist_cd=udm.district_cd ").
append(" "+txtSearch+"  AND upper(zm.zone_nm) like upper('"+vZoneCD+"') and upper(ms.state_nm) like upper('"+vStateCd+"') ").
append(" AND MOM.AGENCY_TYPE like '"+vAgency+"' AND MOM.OFF_NAME1 LIKE '"+vOffname+"' AND DM.district_name  LIKE UPPER('"+vDist+"') ").
append(" AND AD.BANK_NAME LIKE UPPER('"+vBankName+"') ").
append(" and ad.off_cd=mom.off_cd and ad.activity_cd=am.activity_cd and am.ind_grp_cd=igm.ind_grp_cd ");


//out.print (sb.toString());
ResultSet rsinst = db.execSQL(sb.toString());

//out.print (sb.toString());
//response.setContentType("application/vnd.ms-excel");
//response.setHeader("Content-Disposition", "inline; filename=" + "excel.xls"); 
%>
  <table border="2" align="center" bordercolor="#000000">
  <tr>
    <th colspan="66" align="left" nowrap="nowrap"><div align="left">PMEGP Detail Report for the period from <%= FromDt %> to <%= ToDt %>of Agency :<%= vAgency %></div></th>
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
    <th rowspan="2" align="left">AADHAAR</th>

    <th rowspan="2" align="left">Gender</th>
    <th rowspan="2" align="left">Category</th>
    <th rowspan="2" align="left">Special Category </th>
 
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
    <th rowspan="2" align="left">Remarks for MM Process at PMEGP,CO,Mumbai </th>
    <th rowspan="2" align="left">MM Release Date</th>
    <th rowspan="2" align="left">MM Release Amount </th>
    <th rowspan="2" align="left">Payment Status (Fail/Sucess) </th>
    <th rowspan="2" align="left">MM disbursement Transaction id </th>
    <th rowspan="2" align="left">Fail Reason </th>

    <th rowspan="2" align="left">Physical Verification Conducted Date</th>
    <th rowspan="2" align="left">Physical Verification Status </th>
	<th rowspan="2" align="left">MM Final Adjustment Date </th>
    <th rowspan="2" align="left">MM Final Adjustment Amount </th>
	<th rowspan="2" align="left">TDR Account No </th>    
	<th rowspan="2" align="left">TDR Date</th>
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
 
    <th align="left" >19</th>

    <th align="left" >20</th>
    <th align="left" >21</th>
    <th align="left" >22</th>
    <th align="left" >23</th>

    <th align="left" >24</th>
    <th align="left" >25</th>

    <th align="left" >28(A)</th>
    <th align="left" >28(B)</th>
    <th align="left" >29</th>
	<th align="left" >30</th>
    <th align="left" >31</th>
    <th align="left" >32</th>
    <th align="left" >33</th>

    <th align="left" >34</th>
    <th align="left" >35</th>
    <th align="left" >36</th>
    <th align="left" >37</th>
    <th align="left" >38</th>
    <th align="left" >39</th>
    <th align="left" >40</th>

    <th align="left" >41</th>
    <th align="left" >42</th>

    <th align="left" >43</th>
    <th align="left" >44</th>
    <th align="left" >45</th>
    <th align="left" >46</th>
	<th align="left" >47</th>
    <th align="left" >48</th>
	
	
	   <th align="left" >49</th>
    <th align="left" >50</th>  
    <th align="left" >51</th>
	<th align="left" >52</th>
    <th align="left" >53</th>
 <th align="left" >54</th>
	

    <th align="left" >55</th>
    <th align="left" >56</th>
	<th align="left" >57</th>
    <th align="left" >58</th>
    <th align="left" >59</th>
   
	
	
	
	
	
	
	
	
  </tr>
   <% while (rsinst.next()) {
  srn=srn+1;
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
    <td align="left" ><%=getNum( rsinst.getString("Gender") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("benf_category_desc") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("BENF_SPECAT_CD") )%></td>

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
    <td align="left" ><%=getNum( rsinst.getString("PV_DT") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("PV_STATUS") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_adj_dt") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("mm_adj_amt") )%></td>
	<td align="left" ><%=getNum( rsinst.getString("TDR_ACNO") )%></td>
    <td align="left" ><%=getNum( rsinst.getString("TDR_ADJ_DT") )%></td>
  </tr>
 <%
}
rsinst.close();
db.close();
%>
</table>
</form>

</body>
</html>
