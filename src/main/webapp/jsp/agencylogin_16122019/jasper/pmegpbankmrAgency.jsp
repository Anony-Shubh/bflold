<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon" %>
<%
  String vUsrnm= (String) session.getAttribute("sponc_banknm");
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
String urlrep="BankRepGenerate.jsp?TODT="+ToDt+"&FROMDT="+FromDt+"&BRNAME="+vUsrnm;

if (flagC.equals("Y") ){
String ReportDesc=" PMEGP Performance Report for the Period from "+FromDt +" to "+ToDt+" " ; 
 StringBuffer sb= new StringBuffer();
 sb.append(" SELECT ").
 append(" INITCAP(HIRONE) AS ZONE_NM,INITCAP(HIRTWO) AS OFF_NAME1, ").
append(" sum( nvl(case when  ad.act_id=5  then 1 end,0))  as  bank_ford , ").
append(" sum( nvl(case when ad.act_id=5 then round(mminvolve(ad.app_id)/100000,2) end ,0)) as bankfordmminv, ").
append("  sum( nvl(case when  bd.act_id>=11 then 1 end ,0))  as  bank_sanc, ").
append(" sum( nvl(case when  bd.act_id>=11 then round(mminvolvebank(bd.app_id)/100000,2) end ,0)) as bank_sanc_mm, ").
 append(" sum( nvl(case when  bd.act_id>=23 then 1 end ,0)) as mm_claim , ").
append(" sum( nvl(case when  bd.act_id>=23 then nvl(round(bd.mm_claim_amt/100000,2),0) end ,0)) as mm_claim_amt , ").
append(" sum( nvl(case when bd.act_id>=24 then 1 end ,0)) as mm_rel , ").
append(" sum( nvl(case when  bd.act_id>=24 then nvl(round(bd.mm_rel_amt/100000,2),0) end ,0)) as mm_rel_amt , ").
append(" sum( nvl(case when  bd.act_id=3 then 1 end ,0)) as bank_rej, ").
 append(" sum( nvl(case when  bd.act_id=3 then round(mminvolve(bd.app_id)/100000,2) end ,0)) as b_rej_mm, ").
  append("  sum( nvl(case when  bd.act_id IS NULL OR bd.act_id=8   then 1 end ,0)) as pend_sanc_no, ").
 append("   sum( nvl(case when    bd.act_id IS NULL OR bd.act_id=8   then round(mminvolve(ad.app_id)/100000,2) end ,0)) as pend_san_mm, ").
 append(" sum( nvl(case when  bd.act_id=23 then 1 end ,0)) as pend_rel, ").
append(" sum( nvl(case when bd.act_id=23  then nvl(round(bd.mm_claim_amt/100000,2),0) end ,0)) as pend_mm ").
append("  FROM  ").
 append(" app_detail ad, bank_dataentry bd,bank_br_mast bbm ").
append("  where ad.app_id=bd.app_id (+) and ").
append(" ad.br_code=bbm.br_ifsl_code and ").
 append(" ad.bank_f_date between '"+FromDt+"' and '"+ToDt+"' ").
 append(" AND AD.ACT_ID=5 AND BBM.spon_bank_name= '"+vUsrnm+"' ").
append("  group by ROLLUP(HIRONE,HIRTWO) ");
//out.print(sb.toString());
%>
<%
ResultSet rsinst = db.execSQL(sb.toString());
try{
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Performance Report</title>
	<link rel="stylesheet" type="text/css" href="css/indexr.css">
	
	<script language="javascript">
	function pmegp_popup(url) {
	var title='pmegp';
	var w=270;
	var h=270;
    // Fixes dual-screen position                         Most browsers      Firefox
    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

    width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
    var top = ((height / 2) - (h / 2)) + dualScreenTop;
    var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

    // Puts focus on the newWindow
    if (window.focus) {
        newWindow.focus();
    }
}
	
	</script>

</head>

<body>
<%@ include file="includeRepMenu.jsp" %> 
<form method="post" >
<div id="printme">
 <table align="center">
<tr>
  <td colspan="6"><div align="center">PMEGP e-Traking Performance Report for Bank</div></td>
</tr>
<tr>
<th>Bank Name </th>
<td><%= vUsrnm %></td>
<th>From Date </th>
<td><%=FromDt  %></td>
<th>To Date </th>
<td><%=ToDt  %></td>
</tr>
</table>
 <table width="800" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#666666">
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
vnmdw=rsinst.getString("off_name1")==null?"Total":rsinst.getString("off_name1");
%>
<th ><div align="left"><%=vnmdw  %></div></th>
<td><div align="right"><a href="<%=urladd  %>&QCODE=0"  onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("bank_ford")));%>
</a></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("bankfordmminv")));%></div></td>
<td><div align="right"><a href="<%=urladd  %>&QCODE=1" onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("bank_sanc")));%>
</a></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("bank_sanc_mm")));%></div></td>
<td><div align="right"><a href="<%=urladd  %>&QCODE=2" onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("mm_claim")));%>
</a></div></td>
<td><div align="right"><% out.print(dfd.format(rsinst.getDouble("mm_claim_amt")));%></div></td>
<td><div align="right">
  <a href="<%=urladd  %>&QCODE=3" onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
  <% out.print(dfn.format(rsinst.getDouble("mm_rel")));%>
  </a></div></td>
<td> <div align="right"><% out.print(dfd.format(rsinst.getDouble("mm_rel_amt")));%></div></td>
<td><div align="right">
      <a href="<%=urladd  %>&QCODE=4" onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
      <% out.print(dfn.format(rsinst.getDouble("bank_rej")));%>
      </a></div></td>
<td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("b_rej_mm")));%>
</div></td>
<td><div align="right">
      <a href="<%=urladd  %>&QCODE=5" onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format">
      <% out.print(dfn.format(rsinst.getDouble("pend_sanc_no")));%>
      </a></div></td>
<td><div align="right">
      <% out.print(dfd.format(rsinst.getDouble("pend_san_mm")));%>
</div></td>
<td><div align="right">
      <a href="<%=urladd  %>&QCODE=6" onclick="pmegp_popup(this.href);return(false)" title="Click here to get detailed Report in excel format" class="dwlink">
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
</div>   
</div>
</form>
</body>
</html>
