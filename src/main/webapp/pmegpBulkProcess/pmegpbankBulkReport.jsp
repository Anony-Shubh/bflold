<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.BankDataValidation,pkgPmegpNew.DBCon"  %>
<%@ include file="headerfile.jsp" %>

<html>
<head>
<title>PMEGP Performance Report</title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script src="js/jquery-1.12.4.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.scroller.min.js" type="text/javascript"></script>
<link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="css/scroller.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="js/ModalPopupWindow.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/pmegpNewLt.css" />
<style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {color: #FF0000}
.style3 {
	color: #000000;
	font-weight: bold;
}
.style4 {font-size: large}
.style5 {
	color: #FF0000;
	font-size: large;
	font-weight: bold;
}
-->
</style>


<script>

function dateChange(){
vYR=document.getElementsByName("SEL_YEAR")[0].value
var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

var FROMDT=document.getElementsByName("FROMDT")[0].value;

 if  (vYR=='2016-17'){


document.getElementsByName("FROMDT")[0].value='01-JUL-2016';
document.getElementsByName("TODT")[0].value=showdt;

}

}


$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>
<style type="text/css">
<!--
.style6 {color: #A05454; font-weight: bold; }
-->
</style>
</head>

<body onLoad="dateChange();">
<form  name="form"   method="post" action="pmegpbankBulkReport.jsp" >
<%
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");

%>
  <table width="100%" class="pmegpTable"  >
    
    <tr>
      <th>Year : </th>
      <th><select name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
        <option value="2016-17" selected>2016-17</option>
      </select></th>
      <th>From Dt: </th>
      <th><input name="FROMDT" type="text"  id="FROMDT" size="13" maxlength="11" value="<%= FromDt %>"></th>
      <th>To Dt:</th>
      <th><input name="TODT" type="text"  id="TODT" size="14" maxlength="11" value="<%= ToDt %>"></th>
      <th><input type="submit" id="submit" name="submit" value="GO" class="buttonOrange"></th>
    </tr>
  </table>
   <h1 align="center">PMEGP Portal MIS Report for Bank</h1>
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
  <th colspan="2" ><div align="center">TDR Detail Updated</div></th>
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
<th >MM Involve (In Lakh)<br />
</th>
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
<th>(Q)</th>
<th>(R)</th>
</tr>
</thead>
<%

//IFSL_CODE
 
  
  
  String sIFSL_CODE=(String) session.getAttribute("bank_id");
//  out.print(sIFSL_CODE+"sIFSL_CODE");
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
String urlrep="BankRepGenerate.jsp?TODT="+ToDt+"&FROMDT="+FromDt+"&IFSL_CODE="+sIFSL_CODE; 

if (flagC.equals("Y") ){
String ReportDesc=" PMEGP Performance Report for the Period from "+FromDt +" to "+ToDt+" " ; 
 StringBuffer sb= new StringBuffer();
 sb.append(" SELECT ").
 append(" INITCAP(HIRONE) AS ZONE_NM,INITCAP(HIRTWO) AS OFF_NAME1, ").
append(" sum( nvl(case when  ad.act_id=5  AND AD.ACT_YN='Y' then 1 end,0))  as  bank_ford , ").
append(" sum( nvl(case when ad.act_id=5 AND AD.ACT_YN='Y' then round(mminvolve(ad.app_id)/100000,2) end ,0)) as bankfordmminv, ").
append("  sum( nvl(case when  bd.act_id>=11 then 1 end ,0))  as  bank_sanc, ").
append(" sum( nvl(case when  bd.act_id>=11 then round(mminvolvebank(bd.app_id)/100000,2) end ,0)) as bank_sanc_mm, ").
 append(" sum( nvl(case when  BD.MM_CLAIM_DT  IS NOT NULL and BD.MM_CLAIM_AMT   > 0 and  BD.LOAN_DOCFNAME IS NOT NULL then 1 end ,0)) as mm_claim , ").
append(" sum( nvl(case when  BD.MM_CLAIM_DT  IS NOT NULL and BD.MM_CLAIM_AMT   > 0 and  BD.LOAN_DOCFNAME IS NOT NULL then nvl(round(bd.mm_claim_amt/100000,2),0) end ,0)) as mm_claim_amt , ").
append(" sum( nvl(case when bd.PACT_ID=34 then 1 end ,0)) as mm_rel , ").
append(" sum( nvl(case when  bd.PACT_ID=34 then nvl(round(bd.mm_rel_amt/100000,2),0) end ,0)) as mm_rel_amt , ").
append(" sum( nvl(case when  bd.act_id=3 then 1 end ,0)) as bank_rej, ").
 append(" sum( nvl(case when  bd.act_id=3 then round(mminvolve(bd.app_id)/100000,2) end ,0)) as b_rej_mm, ").
  append("  sum( nvl(case when  (bd.act_id IS NULL OR bd.act_id=8) and ad.act_yn='Y'   then 1 end ,0)) as pend_sanc_no, ").
 append("   sum( nvl(case when    (bd.act_id IS NULL OR bd.act_id=8) and ad.act_yn='Y'   then round(mminvolve(ad.app_id)/100000,2) end ,0)) as pend_san_mm, ").
 append(" sum( nvl(case when bd.act_id=11 AND bd.PACT_ID = 34 AND bd.APPRV_YN = 'A'  AND  bd.TDR_ADJ_DT IS NOT NULL then 1 end ,0)) as TDR_UPDATE, ").
  append(" sum( nvl(case when bd.act_id=11 AND bd.PACT_ID = 34 AND bd.APPRV_YN = 'A'  AND  bd.TDR_ADJ_DT IS NOT NULL then  nvl(round(bd.mm_rel_amt/100000,2),0) end ,0)) as TDR_MM, ").
  append(" sum( nvl(case when   bd.MM_CLAIM_DT  IS NOT NULL and bd.MM_CLAIM_AMT   > 0 and  bd.LOAN_DOCFNAME IS NOT NULL and bd.pact_id <>34  then 1 end ,0)) as pend_rel, ").
append(" sum( nvl(case when bd.MM_CLAIM_DT  IS NOT NULL and bd.MM_CLAIM_AMT   > 0 and  bd.LOAN_DOCFNAME IS NOT NULL and bd.pact_id <>34   then nvl(round(bd.mm_claim_amt/100000,2),0) end ,0)) as pend_mm ").
append("  FROM  ").
 append(" app_detail ad, bank_dataentry bd,bank_br_mast bbm ").
append("  where ad.app_id=bd.app_id (+) and ").
append(" ad.IFSC_CODE=bbm.br_ifsl_code and ").
 append(" TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"' ").
 append(" AND AD.ACT_ID=5   and bbm.CIRCLE_IFSC='"+sIFSL_CODE+"' ").
append("  group by ROLLUP(HIRONE,HIRTWO) ");

//out.print (sb.toString());
try{
 ResultSet rsinst = db.execSQL(sb.toString());

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
 <th  colspan="18">
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
  <a href="<%=urladd  %>&QCODE=10" onClick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
<% out.print(dfd.format(rsinst.getDouble("TDR_UPDATE")));%></a></div></td>
<td><% out.print(dfd.format(rsinst.getDouble("TDR_MM")));%></td>
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
//out.print (e.toString());
}
}//end if
%>
</tbody>
</table>
</form>
</body>
</html>
