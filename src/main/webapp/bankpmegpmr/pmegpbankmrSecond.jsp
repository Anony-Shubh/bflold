<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.BankDataValidation,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>PMEGP Performance Report</title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script type="text/javascript">
function dateChange(){
vYR=document.getElementsByName("SEL_YEAR")[0].value
var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

if (vYR=='2016-17'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2016';
document.getElementsByName("RTODATE")[0].value='31-MAR-2017';
}else if  (vYR=='2017-18'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2017';
document.getElementsByName("RTODATE")[0].value=showdt;
}
}

function urlparam(){
var vfrdt=document.getElementsByName("RFROMDT")[0].value;
var vtodt=document.getElementsByName("RTODATE")[0].value;
var pars   ='?FROMDT=' + vfrdt+ '&TODT=' + vtodt;
return(pars);
//alert (pars);
}




<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>
</head>

<body>
<form method="post" >
<table width="4" align="center">
  </table>
 <table  id="tableid" align="center" class="bordered">
<thead>
<tr>
  <th rowspan="2"><div align="center">Row<br />
  ID</div></th>
  <th rowspan="2" > Name</th>
  <th colspan="2" >Fordwarded to Bank </th>
  <th colspan="2" >Sanctioned by Bank </th>
  <th colspan="2" >Margin Money Claimed </th>
  <th colspan="2" >Margin Money Disbursement by <br />
Nodal Branches</th>
  <th colspan="2" >No of <br />
Applications Rejected<br />
by Bank</th>
  <th colspan="2" >Pending for Sanction</th>
  <th colspan="2" >Pending for MM Disbursement </th>
  </tr>
<tr>
<th ><br /> 
  No of Prj.
</th>
<th >MM Involve (In Lakh)<br />  </th>
<th >No of <br />
Prj.</th>
<th >MM Involve (In Lakh)<br /></th>
<th >No of <br />
Prj.</th>
<th >MM (In Lakh)<br /></th>
<th >No of <br />
Prj.</th>
<th >MM (In Lakh)<br /></th>
<th ><br />
  No of Prj. </th>
<th >MM Involve (In Lakh)<br />  </th>
<th >No of Prj.</th>
<th >MM Involve (In Lakh)<br /></th>
<th >No of Prj. </th>
<th >MM (In Lakh)<br /></th>
</tr>
<tr>
<th >
 (A)
 </th>
<th>(B)</th>
<th>(C)</th>
<th>(D)</th>
<th>(E)</th>
<th>(F)</th>
<th>(G)</th>
<th>(H)</th>
<th>(I)</th>
<th>(J)</th>
<th>(K)</th>
<th>(L)</th>
<th>(M)</th>
<th>(N)</th>
<th>(O)</th>
<th>(P)</th>
</tr>
</thead>
<%
  String vUsrnm= (String) session.getAttribute("sponc_banknm");
 //out.print(vUsrnm);
  String br_type= (String) session.getAttribute("br_type");
 //out.print(br_type);
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";
String flagC="Y";
String p1="";
String p2="";
String rowcol="";
int lrow=0;
String vnmdw="";
String qryField="";
String qryGroup="";
String urladd="";
String url1="";
String url2="";
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String urlrep="BankRepGenerateSec.jsp?TODT="+ToDt+"&FROMDT="+FromDt+"&BRNAME="+vUsrnm;

if (flagC.equals("Y") ){
String ReportDesc=" PMEGP Performance Report for the Period from "+FromDt +" to "+ToDt+" " ; 
 StringBuffer sb= new StringBuffer();
 sb.append(" SELECT ").
 append(" INITCAP(HIRONE) AS ZONE_NM,INITCAP(HIRTWO) AS OFF_NAME1, ").
append(" sum( nvl(case when  ad.act_id=5  then 1 end,0))  as  bank_ford , ").
append(" sum( nvl(case when ad.act_id=5 then round(mminvolve(ad.app_id)/100000,2) end ,0)) as bankfordmminv, ").
append("  sum( nvl(case when  bd.act_id>=11 then 1 end ,0))  as  bank_sanc, ").
append(" sum( nvl(case when  bd.act_id>=11 then round(mminvolvebank(bd.app_id)/100000,2) end ,0)) as bank_sanc_mm, ").
 append(" sum( nvl(case when  BD.MM_CLAIM_DT  IS NOT NULL and BD.MM_CLAIM_AMT   > 0 and  BD.LOAN_DOCFNAME IS NOT NULL then 1 end ,0)) as mm_claim , ").
append(" sum( nvl(case when  BD.MM_CLAIM_DT  IS NOT NULL and BD.MM_CLAIM_AMT   > 0 and  BD.LOAN_DOCFNAME IS NOT NULL then nvl(round(bd.mm_claim_amt/100000,2),0) end ,0)) as mm_claim_amt , ").
append(" sum( nvl(case when bd.PACT_ID=34 and bd.act_id=11 and bd.APPRV_YN='A' then 1 end ,0)) as mm_rel , ").
append(" sum( nvl(case when bd.PACT_ID=34 and bd.act_id=11 and bd.APPRV_YN='A' then nvl(round(bd.mm_rel_amt/100000,2),0) end ,0)) as mm_rel_amt , ").
append(" sum( nvl(case when  bd.act_id=3 then 1 end ,0)) as bank_rej, ").
 append(" sum( nvl(case when  bd.act_id=3 then round(mminvolve(bd.app_id)/100000,2) end ,0)) as b_rej_mm, ").
  append("  sum( nvl(case when  (bd.act_id IS NULL OR bd.act_id=8) AND AD.ACT_YN='Y'  then 1 end ,0)) as pend_sanc_no, ").
 append("   sum( nvl(case when   (bd.act_id IS NULL OR bd.act_id=8) AND AD.ACT_YN='Y'  then round(mminvolve(ad.app_id)/100000,2) end ,0)) as pend_san_mm, ").
 append("  sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL and bd.act_id=11 AND NVL(BD.PACT_ID,0) <> 34 AND BD.MM_REL_DT IS NULL  then 1 end ,0)) as pend_rel, ").
append("  sum( nvl(case when bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL and bd.act_id=11 AND NVL(BD.PACT_ID,0) <> 34 AND BD.MM_REL_DT IS NULL then nvl(round(bd.mm_claim_amt/100000,2),0) end ,0)) as pend_mm ").
append("  FROM  ").
 append(" app_detail_second ad, bank_dataentry_second bd,bank_br_mast bbm ").
append("  where ad.app_id=bd.app_id (+) and ").
append(" ad.IFSC_CODE=bbm.br_ifsl_code and ").
 append(" TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"' ").
 append(" AND AD.ACT_ID=5 AND BBM.spon_bank_name= '"+vUsrnm+"'  ").   // AND BBM.BR_TYPE='"+br_type+"'
append("  group by ROLLUP(HIRONE,HIRTWO) ");
//out.print (sb.toString());
ResultSet rsinst = db.execSQL(sb.toString());
try{
 
 String Head="";
 String firstcolnew="";
 String firstcolold="";
 String flag="Y";
 DecimalFormat dfd = new DecimalFormat("##.##");
  DecimalFormat dfn = new DecimalFormat("####");
while (rsinst.next()) {
	firstcolnew=(rsinst.getString(1)==null)?"":rsinst.getString(1);
	srn=srn+1;
	if (firstcolnew.equals(firstcolold)){
	flag="N";
	}else{
	firstcolold=(rsinst.getString(1)==null)?"":rsinst.getString(1);
	flag="Y";
	}
 %>
<% if (flag.equals("Y")){%>
<tbody>
 <tr>
 <th  colspan="16">
   <div align="center"><%=firstcolold%></div></th>
 </tr>
	 <%}%>
     <tr>
<td><div align="center"><%=srn%>)</div></td>
<%
vnmdw=rsinst.getString("off_name1");


url1=firstcolold.equals("")?"":firstcolold;
url2=rsinst.getString("off_name1")==null?"":rsinst.getString("off_name1");
urladd=urlrep+"&HIRONE="+url1+"&HIRTWO="+url2;
//out.print(urladd);
vnmdw=rsinst.getString("off_name1")==null?"Total":rsinst.getString("off_name1");
%>
<th nowrap ><div align="left"><%=vnmdw  %></div></th>
<td><div align="right"><a href="<%=urladd  %>&QCODE=0"  onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("bank_ford")));%>
</a></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("bankfordmminv")));%></div></td>
<td><div align="right"><a href="<%=urladd  %>&QCODE=1" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%></div></td>
<td><div align="right"><a href="<%=urladd  %>&QCODE=2" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("mm_claim")));%>
</a></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("mm_claim_amt")));%></div></td>
<td><div align="right">
  <a href="<%=urladd  %>&QCODE=3" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("mm_rel")));%>
  </a></div></td>
<td> <div align="right"><% out.print(dfd.format(rsinst.getDouble("mm_rel_amt")));%></div></td>
<td><div align="right">
      <a href="<%=urladd  %>&QCODE=4" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
      <% out.print(dfn.format(rsinst.getDouble("bank_rej")));%>
      </a></div></td>
<td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("b_rej_mm")));%>
</div></td>
<td><div align="right">
      <a href="<%=urladd  %>&QCODE=5" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
      <% out.print(dfn.format(rsinst.getDouble("pend_sanc_no")));%>
      </a></div></td>
<td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("pend_san_mm")));%>
</div></td>
<td><div align="right">
      <a href="<%=urladd  %>&QCODE=6" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format" class="dwlink">
      <% out.print(dfn.format(rsinst.getDouble("pend_rel")));%>
      </a></div></td>
<td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("pend_mm")));%>
</div></td>
</tr>
<%
}
rsinst.close();
db.close();
}catch (Exception e) {
out.print (e.toString());
}
}//end if
%>
</tbody>
</table>
</form>
</body>
</html>
