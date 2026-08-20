<%@ page  session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon,java.text.NumberFormat"  %>
<html>
<head>
<TITLE>PMEGP e-Tracking Analytical Report</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="css/indexr.css">

</head>
<%
//session ID COLLECTED FROM SESSION
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;

 
DBCon db= new DBCon();
 int srn =0;
db.connect();
String QryCaption="";
String qry1="";
String qry2="";
String fqry="";

double perTotal=0;
double perOut=0;
double perVal=0;

String FromDt=(request.getParameter("RFROMDT")==null) ? "01-APR-2013" :(String) request.getParameter("RFROMDT");
String ToDt=(request.getParameter("RTODATE")==null) ? "02-DEC-2013" :(String) request.getParameter("RTODATE");
String col1= (request.getParameter("COL1")==null) ? "" :(String) request.getParameter("COL1");
String row1= (request.getParameter("ROW1")==null) ? "" :(String) request.getParameter("ROW1");
String Val1= (request.getParameter("VAL1")==null) ? "" :(String) request.getParameter("VAL1");
String vQryCode= (request.getParameter("STATUSCODE")==null) ? "" :(String) request.getParameter("STATUSCODE");
String tabCaption="";
String vPER_YN=(request.getParameter("PER_YN")==null) ? "" :(String) request.getParameter("PER_YN");
//out.print(vQryCode);
String txtSearch="";
txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"'";

 if (vQryCode.equals("0")){
 QryCaption="Received Applications";
 txtSearch = txtSearch + " and ad.app_rec_date between '"+FromDt+"' and '"+ToDt+"' " ;
} else if (vQryCode.equals("1")){
QryCaption="Under Process/Pending at Agency";
  txtSearch = txtSearch + " and ad.act_id=1 and ad.app_rec_date between '"+FromDt+"' and '"+ToDt+"' " ;
  
  }else if (vQryCode.equals("2")){
  QryCaption="Placed before DLTFC";
  txtSearch = txtSearch + " and amm.mt_date between '"+FromDt+"' and '"+ToDt+"'";
 }else if (vQryCode.equals("3")){
 QryCaption="Rejected by DLTFC";
 // REJECTED BY DLTFC COMMITTEE
  txtSearch = txtSearch + " and amm.mt_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=7 ";
 }else if (vQryCode.equals("4")){
 QryCaption="Recommended by DLTFC";
 // Sanctioned by DLTFC COMMITTEE
  txtSearch = txtSearch + " and amm.mt_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id <>7 ";
 
  }else if (vQryCode.equals("5")){
  QryCaption="Forwarded by Bank";
 // Forwarded to Bank
  txtSearch = txtSearch + " and ad.bank_f_date between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=5 ";
  }else if (vQryCode.equals("6")){
  QryCaption="sanctioned by Bank";
 // Sanctioned by Bank
  txtSearch = txtSearch + " and bd.loan_sanc_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 ";
}else if (vQryCode.equals("7")){
 QryCaption="Rejected by Bank";
  txtSearch = txtSearch + " and  bd.bank_rec_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=3  ";
 }else if (vQryCode.equals("8")){
 QryCaption="Own Contribution Deposited";
 // Own Contribution Deposited
  txtSearch = txtSearch + " and   bd.own_dep_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("9")){
 QryCaption="Loan Released";
 //  LOAN RELEASED
  txtSearch = txtSearch + " and bd.ist_loan_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
  }else if (vQryCode.equals("10")){
  QryCaption="EDP Training Completed";
 // EDP TRANING COMPLETED
  txtSearch = txtSearch + " and bd.edp_cert_iss_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("11")){
 QryCaption="Margin Money Claimed";
  txtSearch = txtSearch + " and bd.mm_claim_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("12")){
 QryCaption="Margin Money Released";
  txtSearch = txtSearch + " and bd.mm_rel_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("13")){
 QryCaption="Physical Verification completed";
  txtSearch = txtSearch + " and bd.pv_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("14")){
 QryCaption="Margin Money Final Adjustment";
  txtSearch = txtSearch + " and bd.mm_adj_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }
 
int colCount=0;

String[] vCheck;
String initStr="";

if (col1.equals("")||col1.equals("")){
tabCaption="Select Row ,Column and Value then click on Generate Report";
}else{
tabCaption="PMEGP e-Tracking Summarised Report from " +FromDt + " to  "+ ToDt  + " of " + QryCaption ;
}
int LcolCnt=0;
 vCheck = request.getParameterValues("chkRow"); 
   if (vCheck != null)    {    
     for (int i = 0; i < vCheck.length; i++){ 
	      if (i== (vCheck.length-1) ){
		  initStr=initStr+ vCheck[i];
		  }else{
	        initStr=initStr+ vCheck[i]+",";} 
			 LcolCnt=LcolCnt+1; 
		 }// for loop
		
			}//if check 
//out.print(initStr);

%>
<body>
 <form action="pmegAnalytical.jsp"  method="post">
   <table border="1" align="center" >
  <tr>
    <td colspan="3" scope="col"><div align="center">PMEGP Analytical Reports </div></td>
    </tr>
  <tr>
    <th colspan="2" scope="col">Report in (%) 
          <select name="PER_YN" id="PER_YN">
            <option value="N" selected>No</option>
            <option value="OP_NP">No &amp; % on Overal Performance</option>
            <option value="ER_NP">No &amp; on each Row with Number</option>
            <option value="OP_P">Only % on Overal Performance </option>
            <option value="ER_P">Only % on each Row</option>
          </select></th>
    <th scope="col">Select Column </span></th>
  </tr>
  <tr>
    <td colspan="2" nowrap  scope="col">From: 
      <input name="RFROMDT" type="text"  id="RFROMDT" value="<%= FromDt %>" size="11" maxlength="11">
     
      To:
      <input name="RTODATE" type="text"  id="RTODATE" value="<%= ToDt %>" size="11" maxlength="11">
      Status:
      <select name="STATUSCODE" id="STATUSCODE">
        <option value="0" <% if (vQryCode.equals("0")){ out.println("Selected");}%>>Received by Agency</option>
        <option value="1" <% if (vQryCode.equals("1")){ out.println("Selected");}%>>Under Process/Pending At Agency</option>
        <option value="2"<% if (vQryCode.equals("2")){ out.println("Selected");}%>>Place Before DLTFC</option>
        <option value="3"<% if (vQryCode.equals("3")){ out.println("Selected");}%>>Rejected by DLTFC</option>
        <option value="4"<% if (vQryCode.equals("4")){ out.println("Selected");}%>>Sanctioned by DLTFC</option>
        <option value="5"<% if (vQryCode.equals("5")){ out.println("Selected");}%>>Forwarded to Bank</option>
		<option value="6"<% if (vQryCode.equals("6")){ out.println("Selected");}%>>Sanctioned by Bank</option>
        <option value="7"<% if (vQryCode.equals("7")){ out.println("Selected");}%>>Rejected by Bank</option>
        <option value="8"<% if (vQryCode.equals("8")){ out.println("Selected");}%>>Own Contribution</option>
        <option value="9"<% if (vQryCode.equals("9")){ out.println("Selected");}%>>Loan Relaese</option>
        <option value="10"<% if (vQryCode.equals("10")){ out.println("Selected");}%>>EDP Training</option>
        <option value="11"<% if (vQryCode.equals("11")){ out.println("Selected");}%>>MM Claimed</option>
        <option value="12"<% if (vQryCode.equals("12")){ out.println("Selected");}%>>MM Released</option>
        <option value="13"<% if (vQryCode.equals("13")){ out.println("Selected");}%>>Physical Verification</option>
        <option value="14"<% if (vQryCode.equals("14")){ out.println("Selected");}%>>MM Final Adjustment</option>
      </select>
     </td>
    <td rowspan="2" scope="col"><div align="center">
      <select name="COL1" id="COL1">
          <option value="">--Select Column--</option>
          <option value="mom.agency_type" >Agency Type</option>
          <option value="BTM.benf_type_desc">Beneficiary Type</option>
          <option value="bcm.benf_category_desc">Social Category</option>
          <option value="ad.gender">Gender</option>
          <option value="edm.edu_desc">Education Qualification</option>
          <option value="itm.ind_desc">Manufacturing/Service Ind</option>
          <option value="igm.ind_grp_short_desc">Industry</option>
          <option value="ad.unit_loc">Unit Location (Rural/Urban)</option>
          <option value="2">Range wise Project Size</option>
          <option value="3">Range wise Bank Sanction Project Size</option>
      </select>
    </div></td>
  </tr>
  <tr>
    <th colspan="2" >Select Rows</th>
  </tr>
  <tr>
    <td rowspan="2" >
      <input name="chkRow" type="checkbox" id="chkRow" value="ZM.ZONE_NM">
      Zone <br>
      <input name="chkRow" type="checkbox" id="chkRow" value="MS.STATE_NM">
      State <br>
      <input name="chkRow" type="checkbox" id="chkRow" value="UDM.DISTRICT_NAME">
      District </td>
    <td rowspan="2">
      <input name="chkRow" type="checkbox" value="BTM.benf_type_desc">
      Beneficiary Type
      <input name="chkRow" type="checkbox" value="bcm.benf_category_desc">
      Social Category
      <input name="chkRow" type="checkbox" value="ad.gender">
      Gender
      <br><input name="chkRow" type="checkbox" value="edm.edu_desc">
       Qualification
      <input name="chkRow" type="checkbox" value="itm.ind_desc">
      Manufacturing/Service <br>
      <input name="chkRow" type="checkbox" value="igm.ind_grp_short_desc">
      Industry
      <input name="chkRow" type="checkbox" value="am.activity_name">
      Activity Name
      <input name="chkRow" type="checkbox" disabled="true" value="btm.bank_type">
      <input name="chkRow" type="checkbox" value="ad.bank_name">
      Bank Name
      <br><input name="chkRow" type="checkbox" value="ad.unit_loc">
      Unit Location (Rural/Urban) 
      <input name="chkRow" type="checkbox" id="chkRow" value="MOM.AGENCY_TYPE">
      Agency Type </td>
    <th>Select Value: 
          <select name="VAL1" id="VAL1">
            <option value="1" selected>In No</option>
            <option value="bd.mm_rel_amt">MM Released Amount(In Rs)</option>
            <option value="round(bd.mm_rel_amt/100000,2)">MM Released Amount( Rs in Lakhs)</option>
            <option value="bd.emp">Employment (in Person)</option>
            <option value="round(bd.prod/100000,2)"> Production (Rs. in Lakhs)</option>
            <option value="round(bd.sales/100000,2)"> Sales (Rs. in Lakhs)</option>
          </select>
          <%
		  if (Val1.equals("1")){ tabCaption=tabCaption+"<br><br>"+"In No ";}
		   if (Val1.equals("bd.mm_rel_amt")){ tabCaption=tabCaption+"<br><br><right>"+" MM Released Amount(In Rs) <right>";}
		    if (Val1.equals("bd.emp")){ tabCaption=tabCaption+"<br><br>"+" Employment in Person ";}
		   if (Val1.equals("round(bd.mm_rel_amt/100000,2)")){ tabCaption=tabCaption+"<br><br>"+" MM Released Amount(Rs. In Lakhs) ";}
		    if (Val1.equals("round(bd.prod/100000,2)")){ tabCaption=tabCaption+"<br><br>"+" Production (Rs. in Lakhs) ";}
			 if (Val1.equals("round(bd.sales/100000,2)")){ tabCaption=tabCaption+"<br><br>"+" Sales (Rs. in Lakhs) ";}
		  %>
        
  <tr>
    <td colspan="3">
        <div align="center">
          <input name="Submit" type="submit" class="button" value="Generate Report">
        </div></td>
  </tr>
  <input name="printbtn" type="button" value="print this page" onClick="window.print();">
</table>

<center><%= tabCaption %></center>
<center>
 <table border="1" cellpadding="2" cellspacing="0">


<%
   StringBuffer qrb= new StringBuffer();
  qrb.append( "  app_detail ad, bank_detail bd, m_district dm, mas_off_mast mom,m_state ms, zone_mast zm, app_meeting_mast amm,benf_type_mast BTM, " ).
 append (" benf_category_mast bcm,m_district bend, education_mast edm,m_district udm,m_district bdma,app_status_mast asm,bank_app_status bas, ").
  append (" activity_mast am,ind_grp_mast igm,mas_off_mast edpom,bank_master bmnd,ind_type_mast itm,bank_type_mast btm ").
 append ("  where ad.app_id=bd.app_id(+) and ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd and ad.mtg_id=amm.mtg_id(+) ").
 append ("and ad.bank_type=btm.bank_type_cd and ad.ind_type=itm.ind_type and ad.act_id=asm.act_id and bd.act_id=bas.act_id(+)  and ms.zone_cd=zm.zone_cd ").
 append (" and ad.bank_dist_cd=bdma.district_cd AND ad.app_dist_cd=bend.district_cd and AD.benf_type=BTM.benf_type_cd and ad.benf_catagory_cd=bcm.benf_category_cd ").
append (" and ad.aca_quali=edm.edu_id and ad.unit_dist_cd=udm.district_cd and bd.tr_id=edpom.off_cd(+) and bd.bank_code=bmnd.bank_code(+) "). 
append (" and ad.off_cd=mom.off_cd and ad.ind_activity=am.activity_cd and am.ind_grp_cd=igm.ind_grp_cd "+txtSearch+"" );
//out.print(txtSearch);
 StringBuffer prjszqry= new StringBuffer();
if (col1.equals("") && row1.equals("") ){
out.print ("Row and Column  both  not selected");

} else {

 StringBuffer sb= new StringBuffer();
 
 StringBuffer totsb= new StringBuffer();
 
 
  if  (col1.equals("2")){
 
 prjszqry.append("SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).  
append(" BETWEEN 0 AND 50000 THEN 1 ELSE 0 END) \"Upto 50,000\", " ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 50001 AND 100000 THEN 1 ELSE 0 END) \"Above 50,000 to 1.00 lakh\" , " ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 100001 AND 200000 THEN 1 ELSE 0 END) \"Above 1.00 lakh to 2.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 200001 AND 300000 THEN 1 ELSE 0 END) \"Above 2.00 lakh to 3.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 300001 AND 400000 THEN 1 ELSE 0 END)  \"Above 3.00 lakh to 4.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 400001 AND 500000 THEN 1 ELSE 0 END)  \"Above 4.00 lakh to 5.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 500001 AND 1000000 THEN 1 ELSE 0 END)  \"Above 5.00 lakh to 10.00 lakh\"," ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0) " ).
append(" BETWEEN 1000001 AND 1500000 THEN 1 ELSE 0 END)  \"Above 10.00 lakh to 15.00 lakh\"," ).
append(" SUM(CASE WHEN nvl(ad.workshed_cost,0)+nvl(ad.machinary_cost,0)+nvl(ad.pre_ope_exp,0)+ nvl(ad.working_capital,0)>1500000 " ).
 append(" THEN 1 ELSE 0 END) \"Above 15.00\", COUNT(*) total " );
} else if (col1.equals("3")) {
 prjszqry.append("SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).  
append(" BETWEEN 1 AND 50000 THEN 1 ELSE 0 END) \"Upto 50,000\", " ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 50001 AND 100000 THEN 1 ELSE 0 END) \"Above 50,000 to 1.00 lakh\" , " ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 100001 AND 200000 THEN 1 ELSE 0 END) \"Above 1.00 lakh to 2.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 200001 AND 300000 THEN 1 ELSE 0 END) \"Above 2.00 lakh to 3.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 300001 AND 400000 THEN 1 ELSE 0 END)  \"Above 3.00 lakh to 4.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 400001 AND 500000 THEN 1 ELSE 0 END)  \"Above 4.00 lakh to 5.00 lakh\", " ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 500001 AND 1000000 THEN 1 ELSE 0 END)  \"Above 5.00 lakh to 10.00 lakh\"," ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0) " ).
append(" BETWEEN 1000001 AND 1500000 THEN 1 ELSE 0 END)  \"Above 10.00 lakh to 15.00 lakh\"," ).
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0)>1500000 " ).
 append(" THEN 1 ELSE 0 END) \"Above 15.00\", ").
append(" SUM(CASE WHEN nvl(bd.workshed_cost,0)+nvl(bd.machinary_cost,0)+nvl(bd.pre_ope_cost,0)+ nvl(bd.working_capital,0)>0 THEN 1 ELSE 0 END) TOTAL " );
 }

 totsb.append("select count(*) from   "+qrb.toString()+"");
 
  ResultSet rstot = db.execSQL(totsb.toString());
  
  while (rstot.next()){
  perTotal=rstot.getDouble(1);
  }
 //out.print(perTotal);
 sb.append(" SELECT  "+col1+" ").
 append ("  from  "+qrb.toString()+"  GROUP BY  "+col1+" ");
 
  ResultSet rscol1 = db.execSQL(sb.toString());
	boolean rscol1_isEmpty = !rscol1.next();
	boolean rscol1_hasData = !rscol1_isEmpty;
	Object rscol1_data;
	int rscol1_numRows = 0;
	
while (rscol1_hasData) {
	 
	 qry2= qry2+ " NVL(SUM(CASE WHEN "+col1+" ='"+rscol1.getString(1)+ "' THEN "+Val1+" END ),0) \"'"+rscol1.getString(1)+ "'\" ," ;
	 rscol1_hasData = rscol1.next();
	}
		 
	rscol1.close();
	
	if (Val1.equals("1")){
	fqry="SELECT  "+initStr+" "+row1+" , "+qry2+" COUNT( nvl("+col1+",0) ) TOTAL FROM "+qrb.toString()+" GROUP BY rollup( "+initStr+" "+row1+" )" ;
	
	}else{
	fqry="SELECT  "+initStr+" "+row1+" , "+qry2+" SUM( nvl("+Val1+",0) ) TOTAL FROM "+qrb.toString()+" GROUP BY rollup( "+initStr+" "+row1+" )" ;
	}//if end;
}


 if (col1.equals("2") ||col1.equals("3")) {
	
	fqry="SELECT  "+initStr+"  ,"+prjszqry.toString()+"  FROM "+qrb.toString()+" GROUP BY rollup( "+initStr+" )" ;
}

//out.print (initStr);
 //out.print(fqry);

if (!fqry.equals("")){

 ResultSet rsinst = db.execSQL(fqry);
//out.print(fqry);
boolean rsinst_isEmpty = !rsinst.next();
boolean rsinst_hasData = !rsinst_isEmpty;
Object rsinst_data;
int rsinst_numRows = 0;

ResultSetMetaData metaData = rsinst.getMetaData();
colCount=metaData.getColumnCount ( );

if  (colCount>0){
out.print("<thead bgcolor=#FFFFD7 align=center class=style7>");
out.print("<tr>");
for (int i=1;i<colCount+1;i++){
if (metaData.getColumnName(i).equals("ZONE_NM")){out.print("<td>");out.print ("Zone Name");out.print("</td>");
} else if (metaData.getColumnName(i).equals("AGENCY_TYPE")){out.print("<td>");out.print ("KVIC/KVIB/DIC");out.print("</td>");
} else if (metaData.getColumnName(i).equals("STATE_NM")){out.print("<td>");out.print ("State Name");out.print("</td>");
} else if (metaData.getColumnName(i).equals("DISTRICT_NAME")){out.print("<td>");out.print ("District Name");out.print("</td>");
} else if (metaData.getColumnName(i).equals("BENF_TYPE_DESC")){out.print("<td>");out.print ("Beneficiary Type");out.print("</td>");
} else if (metaData.getColumnName(i).equals("BENF_TYPE_DESC")){out.print("<td>");out.print ("Beneficiary Type");out.print("</td>");
} else if (metaData.getColumnName(i).equals("BENF_CATEGORY_DESC")){out.print("<td>");out.print ("Social Category");out.print("</td>");
} else if (metaData.getColumnName(i).equals("GENDER")){out.print("<td>");out.print ("Gender");out.print("</td>");
} else if (metaData.getColumnName(i).equals("EDU_DESC")){out.print("<td>");out.print ("Qualification");out.print("</td>");
} else if (metaData.getColumnName(i).equals("IND_DESC")){out.print("<td>");out.print ("Industry Type");out.print("</td>");
} else if (metaData.getColumnName(i).equals("IND_GRP_SHORT_DESC")){out.print("<td>");out.print ("Industry Group");out.print("</td>");
} else if (metaData.getColumnName(i).equals("ACTIVITY_NAME")){out.print("<td>");out.print ("Activity Name");out.print("</td>");
} else if (metaData.getColumnName(i).equals("BANK_NAME")){out.print("<td>");out.print ("Financing Bank Name");out.print("</td>");
} else if (metaData.getColumnName(i).equals("UNIT_LOC")){out.print("<td>");out.print ("Unit Location");out.print("</td>");
} else if (metaData.getColumnName(i).equals("BANK_TYPE")){out.print("<td>");out.print ("Bank Type");out.print("</td>");
}else{
out.print("<td>");
out.print (metaData.getColumnName(i));
out.print("</td>");
}

}
out.print("<tr>");
out.print("</thead>");
}//colCount
out.print("<tbody>");
out.print("<cfoutput>");
out.print("<cfloop>");
String rcFlag="";
String st="";
while (rsinst_hasData) {
rcFlag="";

//out.print(LcolCnt);
out.print("<tr>");

for (int i =1;i<colCount+1;i++){
//out.print(i);
rsinst_data = (((rsinst.getObject(i))==null || rsinst.wasNull())?"Total:":rsinst.getObject(i));

 
 NumberFormat percent = NumberFormat.getPercentInstance();

if (!vPER_YN.equals("N")){
 try{
 if (LcolCnt<i){
  percent.setMinimumFractionDigits(2);  
 if (vPER_YN.equals("OP_P") ){
 perOut = rsinst.getDouble(i)/perTotal; 
rsinst_data  = percent.format(perOut);
} else if (vPER_YN.equals("ER_P") ) {
perTotal=rsinst.getDouble(colCount);
perOut = rsinst.getDouble(i)/perTotal; 
rsinst_data  = percent.format(perOut);
} else if (vPER_YN.equals("ER_NP") ) {
perTotal=rsinst.getDouble(colCount);
perOut = rsinst.getDouble(i)/perTotal; 
rsinst_data  = rsinst_data +"<br>(" +percent.format(perOut)+")";
}else if (vPER_YN.equals("OP_NP") ){
 perOut = rsinst.getDouble(i)/perTotal; 
rsinst_data  =rsinst_data+"<br>("+ percent.format(perOut)+")";
}


} 
//out.print(perOut);
 }catch (Exception e){
 out.print("error");
 }

 }





if (rsinst_data.equals("Total:")){rcFlag="T";}

if ( i>LcolCnt &&( ! rcFlag.equals("T"))){
out.print("<td align=right>");
}else if (rcFlag.equals("T")){
out.print("<td bgcolor=#FFFFD7 align=right class=style7 >");
}else{
out.print("<td>");
}



out.print(rsinst_data);
out.print("</td>");
}// for loop

out.print("</tr>");
 rsinst_hasData = rsinst.next();
 int i=1;
}//while loop
out.print("<cfloop>");
out.print("</tbody>");
out.print("</cfoutput>");

rsinst.close();
}//if close
%>
</table>
</center>
</form>
</body>
</html>
