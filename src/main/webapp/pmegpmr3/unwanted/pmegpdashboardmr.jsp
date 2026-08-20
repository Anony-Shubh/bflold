<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"%>


<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch=""+"  AND ZM.zone_CD LIKE '%%'";
//String FromDt=(String) request.getParameter("FROMDT");
String FromDt="01-APR-2013";
String ToDt="15-NOV-2013";
String vAgency="ALL";
String vfields ="0";
String vCategory="";
String vGender="";

//String ToDt=(String) request.getParameter("TODT");
//String vAgency=(String) request.getParameter("AGENCY");
//String vGender=(String) request.getParameter("GENDER");
//String vCategory=(String) request.getParameter("CATEGORY");
//String vfields = (String) request.getParameter("REPTP");

String ReportName="";
String qryField="";
String qryGroup="";

if (vfields.equals("0")){
ReportName="Agency Wise";
qryField=" ZM.zone_nm || DECODE(ZM.zone_nm,NULL,'',' Zone ') as zone_nm , nvl(MOM.AGENCY_TYPE, Nvl(ZM.zone_nm,'All ') || ' Zone Total:') as off_name1 ";
qryGroup=" ZM.zone_nm,ROLLUP(MOM.AGENCY_TYPE) ORDER BY ZM.zone_nm,MOM.AGENCY_TYPE ";

} else if (vfields.equals("1")){
ReportName="Zone and Office Wise ";
qryField=" ZM.zone_nm || DECODE(ZM.zone_nm,NULL,'',' Zone ') as zone_nm , nvl(mom.off_name1, Nvl(ZM.zone_nm,'All ') || ' Zone Total:') as off_name1 ";
qryGroup=" ROLLUP(ZM.zone_nm,mom.off_name1) ORDER BY ZM.zone_nm,mom.off_name1 ";
}else if (vfields.equals("2")){
ReportName="Zone and State Wise ";
qryField=" ZM.zone_nm || DECODE(ZM.zone_nm,NULL,'',' Zone ') as zone_nm , nvl(MS.STATE_NM, Nvl(ZM.zone_nm,'All ') || ' Zone Total:') as off_name1 ";
qryGroup=" ROLLUP(ZM.zone_nm,MS.STATE_NM) ORDER BY ZM.zone_nm,MS.STATE_NM ";
}else if (vfields.equals("3")){
ReportName="State and District Wise ";
qryField=" MS.STATE_NM || DECODE(MS.STATE_NM,NULL,'',' State ') as zone_nm , nvl(DM.district_name, Nvl(MS.STATE_NM,'All ') || ' State Total:') as off_name1 ";
qryGroup=" ROLLUP(MS.STATE_NM,DM.district_name) ORDER BY MS.STATE_NM,DM.district_name ";
}else if (vfields.equals("4")){
ReportName="All India Financing Bank wise ";
qryField="max('') as zone_nm , ad.bank_name as off_name1 ";
qryGroup=" ROLLUP(ad.bank_name) ORDER BY ad.bank_name ";
}else if (vfields.equals("6")){
ReportName="State andFinancing Bank wise ";
qryField=" MS.STATE_NM || DECODE(MS.STATE_NM,NULL,'',' State ') as zone_nm , nvl(ad.bank_name, Nvl(MS.STATE_NM,'All ') || ' State Total:') as off_name1 ";

qryGroup=" ROLLUP(MS.STATE_NM,ad.bank_name) ORDER BY MS.STATE_NM,ad.bank_name ";
}else if (vfields.equals("5")){
ReportName="State andFinancing Bank wise ";
qryField=" ad.bank_name || DECODE(ad.bank_name,'',' Bank ') as zone_nm , nvl(MS.STATE_NM, Nvl(ad.bank_name,'All ') || ' Bank Total:') as off_name1 ";

qryGroup=" ROLLUP(ad.bank_name,MS.STATE_NM) ORDER BY ad.bank_name,MS.STATE_NM ";
}


String ReportDesc=" PMEGP e-Tracking "+ReportName+" Performance Report for the Period from "+FromDt +"to"+ToDt+" ( AGENCY:- "+vAgency+" )" ; 

if (vAgency.equals("ALL")){
vAgency="%%";
}
if (vGender.equals("ALL")){
vGender="%%";
}
if (vCategory.equals("ALL")){
vCategory="%%";
}
 StringBuffer sb= new StringBuffer();
 
 sb.append("SELECT A.*, ").
 append("NVL((CASE WHEN MM_REL>0 THEN").
append(" ROUND(MM_REL_AMT/MM_REL,2) END),0) AS AVG_MM,").
 append("NVL((CASE WHEN TOT_PROJ>0 THEN").
append(" ROUND(TOT_PROJ/BANK_SANC,2) END),0) AS AVG_PROJ").
append(" FROM (").
append(" SELECT"+qryField+"").
 append(" ,COUNT(*) as TOTALDATAENTERED").
append(" ,sum( nvl(case when ad.app_rec_date between '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as APP_REC ").
 append(" ,sum( nvl(case when amm.mt_date between '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as dtfc_place ").
append(" ,sum( nvl(case when amm.mt_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id<>7 then 1 end ,0)) as dtfc_sanction ").
append(" ,sum( nvl(case when ad.bank_f_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=5 then 1 end ,0)) as bank_ford ").
append(" ,sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=5 then round(bd.elig_mm/100000,2) end ,0)) as bank_ford_mm").
append(",sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as bank_sanc").
append(" ,sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then round(bd.elig_mm/100000,2) end ,0)) as bank_sanc_mm").
append(",sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as mm_rel ").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt ").
append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then ad.emp_env end ,0)) as emp "). 
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and (upper(aD.gender))='FEMALE' then 1 end ,0)) as mm_rel_wo ").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and (upper(aD.gender))='FEMALE' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_wo").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd IN ('HA','ST') then 1 end ,0)) as mm_rel_ST ").
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd IN ('HA','ST') then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_ST "). 
 append(" ,sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd ='SC' then 1 end ,0)) as mm_rel_sc ").
append(",sum( nvl(case when bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd ='SC' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_sc ").
 append(" ,sum( nvl(case when bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then (NVL(BD.workshed_cost,0)+NVL(BD.working_capital,0)+NVL(BD.machinary_cost,0)+NVL(BD.machinary_cost,0))/100000 end ,0)) as TOT_PROJ").
 append(",sum( nvl(case when bd.edp_cert_iss_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as edp_cert_iss").
 append(",sum( nvl(case when bd.bank_rec_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=3 then 1 end ,0)) as bank_reject ").
append(" FROM app_detail ad, bank_detail bd, m_district dm, mas_off_mast mom,m_state ms,app_meeting_mast amm,ZONE_MAST ZM ").
append(" where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd and ad.mtg_id=amm.mtg_id(+) AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' ").
append(" AND AD.BANK_NAME IS NOT NULL  "+txtSearch+" ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd group by "+qryGroup+" )A ");

// out.print(sb.toString());
%>
<%
//out.print(txtSearch);
ResultSet rsinst = db.execSQL(sb.toString());
boolean rsinst_isEmpty = !rsinst.next();
boolean rsinst_hasData = !rsinst_isEmpty;
Object rsinst_data;
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/indexr.css">
 
 
</head>

<body>



 <table align="center">
<tr>
<td></td>
<th>Khadi and Village Industries commission</th>
</tr>
<tr>
<td colspan="2"><div align="center"><%= ReportDesc %></div></td>
</tr>
</table>
<table align="center">
<thead>
<tr>
  <th rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th rowspan="2" > Name</th>
  <th colspan="4" >No of Applications </th>
  <th colspan="2" >Sanctioned by Bank </th>
  <th colspan="3" >MM Released </th>
  </tr>
<tr>
<th >Received</th>
<th > Placed <br />
Before <br />
DLTFC</th>
<th >Recom-<br />
mended <br />
by DLTFC</th>
<th ><br />
Forwarded <br />
to Bank</th>
<th >No of <br />
Prj.</th>
<th >MM<br />
(In Lakh)</th>
<th >No of <br />
Prj.</th>
<th >MM<br />
(In Lakh)</th>
<th >Emp.<br />
(in No)</th>
</tr>

<tr>
<th >
  <div align="center">(A)
  </div></th>
<th>(B)</th>
<th>
(C)
</th>
<th >
(D)
</th>
<th>
(E)
</th>
<th>(F)</th>
<th>(G)</th>
<th>(H)</th>
<th>(I)</th>
<th>(J)</th>
<th>(K)</th>
</tr>
</thead>
 <%
 String Head="";
 String firstcolnew="";
 String firstcolold="";
 String flag="Y";
 
while (rsinst_hasData) {
	firstcolnew=(rsinst.getString(1)==null || rsinst.wasNull())?"":rsinst.getString(1);
	srn=srn+1;
	if (firstcolnew.equals(firstcolold)){
	flag="N";
	}else{
	//srn=srn-1;
	firstcolold=(rsinst.getString(1)==null || rsinst.wasNull())?"":rsinst.getString(1);
	flag="Y";
	}
 %>
<% if (flag.equals("Y")){%>
<tbody>
 <tr>
 <th><div align="center"></div></th>
 <th colspan="10"><%=firstcolold%></span></th>
</tr>
	 <% }%>
 <tr>
<td><div align="center"><%=srn%>)</div></td>
<td ><div align="left"><%=(((rsinst_data = rsinst.getObject("off_name1"))==null || rsinst.wasNull())?"-":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("APP_REC"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("dtfc_place"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("dtfc_sanction"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("bank_ford"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("bank_sanc"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("bank_sanc_MM"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("mm_rel"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("mm_rel_AMT"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
<td><div align="right"><%=(((rsinst_data = rsinst.getObject("EMP"))==null || rsinst.wasNull())?"0":rsinst_data)%></div></td>
</tr>
<%
rsinst_hasData = rsinst.next();
}
rsinst.close();
%>
</tbody>
</table>
</body>
</html>

