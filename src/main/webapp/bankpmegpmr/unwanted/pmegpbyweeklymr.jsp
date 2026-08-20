<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"%>
<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String vAgency=(String) request.getParameter("AGENCY");
String vGender=(String) request.getParameter("GENDER");
String vCategory=(String) request.getParameter("CATEGORY");
String vfields = (String) request.getParameter("REPTP");

String ReportName="";
String qryField="";
String qryGroup="";

if (vfields.equals("1")){
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


String ReportDesc=" PMEGP e-Tracking "+ReportName+" Performance Report for the Period from "+FromDt +"to"+ToDt+" <br>( AGENCY:- "+vAgency+", SOCIAL CATEGORY:-"+vCategory+", GENDER:-"+vGender+" )" ; 

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
append(" ,sum( nvl(case whenad.app_rec_date between '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as APP_REC ").
 append(" ,sum( nvl(case whenamm.mt_date between '"+FromDt+"' and '"+ToDt+"' then 1 end ,0)) as dtfc_place ").
append(" ,sum( nvl(case whenamm.mt_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id<>7 then 1 end ,0)) as dtfc_sanction ").
append(" ,sum( nvl(case whenad.bank_f_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=5 then 1 end ,0)) as bank_ford ").
append(" ,sum( nvl(case whenbd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=5 then round(bd.elig_mm/100000,2) end ,0)) as bank_ford_mm").
append(",sum( nvl(case whenbd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as bank_sanc").
append(" ,sum( nvl(case whenbd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then round(bd.elig_mm/100000,2) end ,0)) as bank_sanc_mm").
append(",sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as mm_rel ").
 append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt ").
append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then ad.emp_env end ,0)) as emp "). 
 append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and (upper(aD.gender))='FEMALE' then 1 end ,0)) as mm_rel_wo ").
 append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and (upper(aD.gender))='FEMALE' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_wo").
 append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd IN ('HA','ST') then 1 end ,0)) as mm_rel_ST ").
 append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd IN ('HA','ST') then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_ST "). 
 append(" ,sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd ='SC' then 1 end ,0)) as mm_rel_sc ").
append(",sum( nvl(case whenbd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 and aD.benf_catagory_cd ='SC' then round(bd.mm_rel_amt/100000,2) end ,0)) as mm_rel_amt_sc ").
 append(" ,sum( nvl(case whenbd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then (NVL(BD.workshed_cost,0)+NVL(BD.working_capital,0)+NVL(BD.machinary_cost,0)+NVL(BD.machinary_cost,0))/100000 end ,0)) as TOT_PROJ").
 append(",sum( nvl(case whenbd.edp_cert_iss_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 then 1 end ,0)) as edp_cert_iss").
 append(",sum( nvl(case whenbd.bank_rec_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=3 then 1 end ,0)) as bank_reject ").
append(" FROM app_detail ad, bank_detail bd, m_district dm, mas_off_mast mom,m_state ms,app_meeting_mast amm,ZONE_MAST ZM ").
append(" where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd and ad.mtg_id=amm.mtg_id(+) AND MOM.AGENCY_TYPE LIKE '"+vAgency+"' ").
append("ANDTRIM(UPPER(AD.GENDER)) LIKE '"+vGender+"'and TRIM(UPPER(AD.benf_catagory_cd)) LIKE '"+vCategory+"' AND AD.BANK_NAME IS NOT NULL ").
append(" and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cdgroup by "+qryGroup+" )A ");

 out.print(sb.toString());


//out.print(txtSearch);
ResultSet rsinst = db.execSQL(sb.toString());
boolean rsinst_isEmpty = !rsinst.next();
boolean rsinst_hasData = !rsinst_isEmpty;
Object rsinst_data;
int rsinst_numRows = 0;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Bi-weekly Report</title>
<link rel="stylesheet" type="text/css" href="css/reportmr.css">
</head>
<body>
<form method="post" name="form1">
 <table>
<tr>
<td></td>
<td>Khadi and Village Industries commission</td>
<td>&nbsp;</td>
</tr>
<tr>
<td colspan="3"><%= ReportDesc %></td>
</tr>
</table>
<table>
<thead>
<tr>
<td>Row<br />
ID</td>
<td > Name</td>
<td >Received</td>
<td > Placed <br />
Before <br />
DLTFC</td>
<td >Recom-<br />
mended <br />
by DLTFC</td>
<td ><br />
Forwarded <br />
to Bank</td>
<td >No of <br />
Prj.</td>
<td >MM<br />
(In Lakh)</td>
<td >No of <br />
Prj.</td>
<td >MM<br />
(In Lakh)</td>
<td >Emp.<br />
(in No)</td>
<td >No of <br />
Prj.</td>
<td >MM<br />
(In Lakh)</td>
<td >No of <br />
Prj.</td>
<td >MM<br />
(In Lakh)</td>
<td >EDP <br>
Training<br> 
given</td>
<td >Average <br />
MM per <br />
Project<br />
(Rs. in<br /> 
lakh)
<br /></td>
<td >Average <br />
Project <br />
Cost<br />
(in Lakh)</td>
<td >No of <br />
Applications<br /> 
Rejected<br /> 
by Bank</td>
<td >No of <br />
Prj.</td>
<td >MM<br />
(In Lakh)</td>
</tr>

<tr>
<td >
(A)
</td>
<td>(B)</td>
<td>
(C)
</td>
<td >
(D)
</td>
<td>
(E)
</td>
<td>(F)</td>
<td>(G)</td>
<td>(H)</td>
<td>(I)</td>
<td>(J)</td>
<td>(K)</td>
<td>(L)</td>
<td>(M)</td>
<td>(N)</td>
<td>(O)</td>
<td>(P)</td>
<td>(Q)</td>
<td>(R)</td>
<td>(S)</td>
<td>(T)</td>
<td>(U)</td>
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
 <td>&nbsp;</td>
 <td colspan="20"><%=firstcolold%></span></td>
</tr>
	 <% }%>
 <tr>
<td><%=srn%>)</td>
<td ><%=(((rsinst_data = rsinst.getObject("off_name1"))==null || rsinst.wasNull())?"-":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("APP_REC"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("dtfc_place"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("dtfc_sanction"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("bank_ford"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("bank_sanc"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("bank_sanc_MM"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_AMT"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("EMP"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_SC"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_AMT_SC"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_ST"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_AMT_ST"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_WO"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("mm_rel_AMT_WO"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("edp_cert_iss"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("AVG_MM"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("AVG_PROJ"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
<td><%=(((rsinst_data = rsinst.getObject("bank_reject"))==null || rsinst.wasNull())?"0":rsinst_data)%></td>
</tr>
<%
rsinst_hasData = rsinst.next();
}
rsinst.close();
%>
</tbody>
</table>
</form>
</body>
</html>
