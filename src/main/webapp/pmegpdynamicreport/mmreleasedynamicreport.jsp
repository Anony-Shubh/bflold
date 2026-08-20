<%@ page contentType="text/html; charset=iso-8859-1" buffer="100kb" language="java"  import="javax.naming.*,java.sql.*,javax.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Sales Dynamic Report</title>
<script type="text/javascript" src="../js/inlinemsg.js"></script>

<link rel="stylesheet" type="text/css" href="pmegpNew.css" />
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="../resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  function toggle(source) {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i] != source)
            checkboxes[i].checked = source.checked;
    }
}
  </script>
 
    <script language="javascript">
function submit_update(){
document.form.ins.value='I';
document.form.submit();
}
</script>
<style type="text/css">
<!--
.style5 {color: #990000}
-->
</style>
</head>

<body>
<br>
<%
String vUsrnm="";
%>
<form method="post"  id="form" name="form" >

<table width="50%" align="center">
  <tr> <input type="HIDDEN" name="CUSTCODE" value="<%=vUsrnm%>" id="CUSTCODE">
  
    <td>Select Financial year: </td>
    <td>
        <select name="APR_YR_DD" id="APR_YR_DD">
		 <option value="2024-25"> 2024-25 </option>
		  <option value="2023-24"> 2023-24 </option>
		   <option value="2022-23"> 2022-23 </option>
		    <option value="2021-22"> 2021-22 </option>
			 <option value="2020-21"> 2020-21 </option>
			 <option value="2019-20"> 2019-20 </option>
			 <option value="2018-19"> 2018-19 </option>
			 <option value="2017-18"> 2017-18 </option>
			 <option value="2016-17"> 2016-17 ( From July-2016) </option> 
        </select>
    </td>
    <td>Loan Type </td>
    <td><select name="LOAN_TYPE_DD" id="LOAN_TYPE_DD">
	  <option value="ALL"> ALL</option>
      <option value="I"> IST LOAN </option>
      <option value="II"> II LOAN </option>
      <option value="OLD"> OLD </option>     
    </select></td>
  </tr>  
</table>

<br>
<table width="100%"  align="center">
  <tr bordercolor="#FFFFFF">
    <td colspan="5"><div align="center">PMEGP BENEFICIARY MARGIN MONEY RELEASE DETAIL ( From July 2016 online data) </div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input name="checkbox" type="checkbox"   onClick="toggle(this);" />
      Select All</th>
    <td colspan="4"><span style="color:#990000">(*Please select columns required for your Report)</span> </td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox" name="SR_NO"  value="A">
      Sr Number </th>
    <th><input type="checkbox"   name="Off_NAME" value="A">
    Office Name </th>
    <th><input type="checkbox"   name="AGENCY_TYPE" value="A">
      Agency Type </th>
    <th><input type="checkbox"   name="STATE_NM" value="A">
    State</th>
    <input type="hidden" name="REPNAME" value="msmepmegpdata">
    <th><input type="checkbox"   name="APP_ID" value="A"> 
    Applicant Id
</th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="APP_NAME" value="A">
      Applicant Name </th>
    <th><input type="checkbox"   name="BENF_TYPE_DESC" value="A">
    Legal Status  </th>
    <th><input type="checkbox"   name="GENDER" value="A"> 
    Gender
</th>
    <th><input type="checkbox"   name="BENF_CATEGORY_DESC" value="A"> 
    Social Catagory
</th>
    <th><input type="checkbox"   name="BENF_SPECAT_CD" value="A"> 
    Special Category
</th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="DOB" value="A">
      Date of Birth </th>
    <th><input type="checkbox"   name="UNIT_LOC" value="A">
      Unit Location </th>
    <th><input type="checkbox"   name="UNIT_ADDR" value="A">
      Unit Address </th>
    <th><input type="checkbox"   name="UNIT_TALUK_BLOCK" value="A">
    Unit Taluka/Block </th>
    <th><input type="checkbox"   name="DISTRICT_NAME" value="A"> 
      Unit District </th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="IND_TYPE" value="A">
Industry Type </th>
    <th><input type="checkbox"   name="ACTIVITY_NAME" value="A">
    Activity name </th>
    <th><input type="checkbox"   name="PROD_DESC" value="A">
  Product Desc </th>
    <th><input type="checkbox"   name="IFSC_CODE" value="A">
  IFS Code </th>
    <th><input type="checkbox"   name="BANK_NAME" value="A">
      Bank Name </th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th>&nbsp;</th>
    <th><input type="checkbox"   name="BANK_ADDR" value="A">
      Bank Address </th>
    <th><input type="checkbox"   name="BANK_F_DATE" value="A">
      Bank Forward Date </th>
    <th><input type="checkbox"   name="PROJ_COST" value="A">
    Project Cost </th>
    <th><input type="checkbox"   name="TOT_SANC_FB" value="A">
    Loan Sanction Amount </th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="CGTSI" value="A"> 
    Cover under 
      CGTMS</th>
    <th><input type="checkbox"   name="IST_LOAN_REL" value="A">
    Loan Release Amt </th>
    <th><input type="checkbox"   name="MM_CLAIM_DT" value="A">
      Claim Date </th>
    <th><input type="checkbox"   name="MM_CLAIM_AMT" value="A">
      Claim Amount </th>
    <th><input type="checkbox"   name="MM_REL_DT" value="A">
      Release Date </th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="MM_REL_AMT" value="A">
      MM Release Amount </th>
    <th><input type="checkbox"   name="EDP_TRG_NAME" value="A">
      EDP Center Name </th>
    <th><input type="checkbox"   name="EDP_CERT_DT" value="A">
      EDP Certificate Date </th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td colspan="5">&nbsp;</td>
    </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="LOAN_TYPE" value="A">
      Loan Type </th>
    <th><input type="checkbox"   name="APR_YR" value="A">
    APR Year </th>
    <th><input type="checkbox"   name="ONLINEMOBNO" value="A">
    Contact Number</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
  </tr>
  <tr bordercolor="#FFFFFF">
    <th><input type="checkbox"   name="TEL_NO" value="A"> 
    Alternative Contact Number</th>
    <th><input type="checkbox"   name="E_MAIL" value="A"> 
    Email ID
</th>
    <th><input type="checkbox"   name="CURRENT_STATUS" value="A"> 
      Current Status </th>
  
  <tr bordercolor="#FFFFFF">
    <td colspan="5"><div align="center">
      <input name="sve" type="button" id="sve" onClick="submit_update();" value="Download in Excel" class="buttonGreen">
    </div></td>
    </tr>
  <input type="hidden" name="ins" id="ins" value="">
</table>
<%	
  	if ((String)request.getParameter("ins")!=null){

		   String myrul="";
		   String vwherecls="";

String LOAN_TYPE_DD=request.getParameter("LOAN_TYPE_DD")==null?"":(String)request.getParameter("LOAN_TYPE_DD");
		   String vREPNAME=request.getParameter("REPNAME")==null?"":(String)request.getParameter("REPNAME");
		   String APR_YR_DD=request.getParameter("APR_YR_DD")==null?"":(String)request.getParameter("APR_YR_DD");
		   String vCUSTCODE=(String)session.getAttribute("vUsrnm");
		   String vAPR_YR=request.getParameter("APR_YR")==null?"false":(String)request.getParameter("APR_YR");
		   String vLOAN_TYPE=request.getParameter("LOAN_TYPE")==null?"false":(String)request.getParameter("LOAN_TYPE");
		   String vSR_NO=request.getParameter("SR_NO")==null?"false":(String)request.getParameter("SR_NO");
		   String vOff_NAME=request.getParameter("Off_NAME")==null?"false":(String)request.getParameter("Off_NAME");
		   String vAGENCY_TYPE=request.getParameter("AGENCY_TYPE")==null?"false":(String)request.getParameter("AGENCY_TYPE");
		   String vAPP_NAME=request.getParameter("APP_NAME")==null?"false":(String)request.getParameter("APP_NAME");
		   String vBENF_TYPE_DESC=request.getParameter("BENF_TYPE_DESC")==null?"false":(String)request.getParameter("BENF_TYPE_DESC");			
		   String vBENF_SPECAT_CD=request.getParameter("BENF_SPECAT_CD")==null?"false":(String)request.getParameter("BENF_SPECAT_CD");
		   String vGENDER=request.getParameter("GENDER")==null?"false":(String)request.getParameter("GENDER");
		   String vDOB=request.getParameter("DOB")==null?"false":(String)request.getParameter("DOB");
		   String vUNIT_LOC=request.getParameter("UNIT_LOC")==null?"false":(String)request.getParameter("UNIT_LOC");
		   String vUNIT_ADDR=request.getParameter("UNIT_ADDR")==null?"false":(String)request.getParameter("UNIT_ADDR");		   
		   String vUNIT_TALUK_BLOCK=request.getParameter("UNIT_TALUK_BLOCK")==null?"false":(String)request.getParameter("UNIT_TALUK_BLOCK");
		   String vPROD_DESC=request.getParameter("PROD_DESC")==null?"false":(String)request.getParameter("PROD_DESC");
		   String vIFSC_CODE=request.getParameter("IFSC_CODE")==null?"false":(String)request.getParameter("IFSC_CODE");
		   String vBANK_NAME=request.getParameter("BANK_NAME")==null?"false":(String)request.getParameter("BANK_NAME");
		   String vBANK_ADDR=request.getParameter("BANK_ADDR")==null?"false":(String)request.getParameter("BANK_ADDR");			
		   String vBANK_F_DATE=request.getParameter("BANK_F_DATE")==null?"false":(String)request.getParameter("BANK_F_DATE");
		    String vPROJ_COST=request.getParameter("PROJ_COST")==null?"false":(String)request.getParameter("PROJ_COST");
		   String vTOTAL_GST_AMT=request.getParameter("TOT_SANC_FB")==null?"false":(String)request.getParameter("TOT_SANC_FB");
		    String vSTATE_NM=request.getParameter("STATE_NM")==null?"false":(String)request.getParameter("STATE_NM");
		   String vKVICSR=request.getParameter("KVICSR")==null?"false":(String)request.getParameter("KVICSR");
		   
		    String vCGTSI=request.getParameter("CGTSI")==null?"false":(String)request.getParameter("CGTSI");
		   String vIST_LOAN_REL=request.getParameter("IST_LOAN_REL")==null?"false":(String)request.getParameter("IST_LOAN_REL");
		    String vMM_CLAIM_DT=request.getParameter("MM_CLAIM_DT")==null?"false":(String)request.getParameter("MM_CLAIM_DT");
		   String vMM_CLAIM_AMT=request.getParameter("MM_CLAIM_AMT")==null?"false":(String)request.getParameter("MM_CLAIM_AMT");
		    String vMM_REL_DT=request.getParameter("MM_REL_DT")==null?"false":(String)request.getParameter("MM_REL_DT");
			
		  
		    String vEDP_TRG_NAME=request.getParameter("EDP_TRG_NAME")==null?"false":(String)request.getParameter("EDP_TRG_NAME");
		   String vEDP_CERT_DT=request.getParameter("EDP_CERT_DT")==null?"false":(String)request.getParameter("EDP_CERT_DT");
		    String vBENF_CATEGORY_DESC=request.getParameter("BENF_CATEGORY_DESC")==null?"false":(String)request.getParameter("BENF_CATEGORY_DESC");
		   String vAPP_ID=request.getParameter("APP_ID")==null?"false":(String)request.getParameter("APP_ID");
		   
		    String vONLINEMOBNO=request.getParameter("ONLINEMOBNO")==null?"false":(String)request.getParameter("ONLINEMOBNO");
		   String vTEL_NO=request.getParameter("TEL_NO")==null?"false":(String)request.getParameter("TEL_NO");
		    String vE_MAIL=request.getParameter("E_MAIL")==null?"false":(String)request.getParameter("E_MAIL");
			
					    String vCURRENT_STATUS=request.getParameter("CURRENT_STATUS")==null?"false":(String)request.getParameter("CURRENT_STATUS");
						 String vMANG_AMT=request.getParameter("MANG_AMT")==null?"false":(String)request.getParameter("MANG_AMT");
					 String vPACK_CHR=request.getParameter("PACK_CHR")==null?"false":(String)request.getParameter("PACK_CHR");
		   String vPOST_CHR=request.getParameter("POST_CHR")==null?"false":(String)request.getParameter("POST_CHR");
		    String vINSUR_CHR=request.getParameter("INSUR_CHR")==null?"false":(String)request.getParameter("INSUR_CHR");
			
		    String vMISC_CHR=request.getParameter("MISC_CHR")==null?"false":(String)request.getParameter("MISC_CHR");
			String vDISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"false":(String)request.getParameter("DISTRICT_NAME");
			String vIND_TYPE=request.getParameter("IND_TYPE")==null?"false":(String)request.getParameter("IND_TYPE");
			String vACTIVITY_NAME=request.getParameter("ACTIVITY_NAME")==null?"false":(String)request.getParameter("ACTIVITY_NAME");
			String flag="Y";
Connection conn=null;
	ServletContext context=request.getServletContext(); 
	String folderpath=context.getRealPath("")+"";
	String fileName = folderpath+vREPNAME+".jasper"; 
	String fnm=vREPNAME+vBENF_CATEGORY_DESC+".xls";
	
		String outFileName =folderpath+"/jasper/jasperxls/"+fnm; 
String WHRCLS="";
	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();
	

if(LOAN_TYPE_DD.equals("ALL")){
WHRCLS="";
}else{
WHRCLS=" and LOAN_TYPE in ('"+LOAN_TYPE_DD+"') ";
}
out.print(WHRCLS);
//LOAN_TYPE_DD
 hm.put("PWHRCLS",WHRCLS);
			 hm.put("PLOAN_TYPE_DD",LOAN_TYPE_DD);

			 hm.put("PAPR_YR_DD",APR_YR_DD);
			 hm.put("PAPR_YR",vAPR_YR);
			 hm.put("PLOAN_TYPE",vLOAN_TYPE);			 
			 hm.put("PSR_NO",vSR_NO);
			 hm.put("POff_NAME",vOff_NAME);
			 hm.put("PAGENCY_TYPE",vAGENCY_TYPE);
			 
			 hm.put("PAPP_NAME",vAPP_NAME);
			 hm.put("PBENF_TYPE_DESC",vBENF_TYPE_DESC);		 
			 hm.put("PBENF_SPECAT_CD",vBENF_SPECAT_CD);
			 hm.put("PGENDER",vGENDER);
			 hm.put("PDOB",vDOB);
			 
			 hm.put("PUNIT_LOC",vUNIT_LOC);
			 hm.put("PUNIT_ADDR",vUNIT_ADDR);			 
			 hm.put("PUNIT_TALUK_BLOCK",vUNIT_TALUK_BLOCK);
			 hm.put("PPROD_DESC",vPROD_DESC);
			 hm.put("PIFSC_CODE",vIFSC_CODE);
			 
			 hm.put("PBANK_NAME",vBANK_NAME);
			 hm.put("PBANK_ADDR",vBANK_ADDR);
			 hm.put("PBANK_F_DATE",vBANK_F_DATE);
			 hm.put("PROJ_COST",vPROJ_COST);
			 
			 hm.put("PSTATE_NM",vSTATE_NM);
			 hm.put("PCGTSI",vCGTSI);
			 hm.put("PIST_LOAN_REL",vIST_LOAN_REL);			 
			 hm.put("PMM_CLAIM_DT",vMM_CLAIM_DT);			 			 
			 hm.put("PMM_CLAIM_AMT",vMM_CLAIM_AMT);
			 
			 hm.put("PMM_REL_DT",vMM_REL_DT);			 
			 hm.put("PMM_REL_DT",vMM_REL_DT);			 
			 hm.put("PEDP_TRG_NAME",vEDP_TRG_NAME);			 
			 hm.put("PEDP_CERT_DT_DISC",vEDP_CERT_DT);			 
			 hm.put("PBENF_CATEGORY_DESC",vBENF_CATEGORY_DESC);
			 
			 hm.put("PCUSTOMER_GST_NO",vAPP_ID); 
			  hm.put("PLOAN_TYPE",vLOAN_TYPE);
			 hm.put("PRECEIVED_FROM",vONLINEMOBNO);			 
			 hm.put("PTEL_NO",vTEL_NO);			 
			 hm.put("PE_MAIL",vE_MAIL);
			 
			 hm.put("PCURRENT_STATUS",vCURRENT_STATUS);		
			 hm.put("PDISTRICT_NAME",vDISTRICT_NAME);
			 hm.put("PIND_TYPE",vIND_TYPE);
			 hm.put("PACTIVITY_NAME",vACTIVITY_NAME);
			 
			 
		  JRExporter  exporter = new JRXlsExporter(); 
          JasperPrint jasperPrint = JasperFillManager.fillReport(fileName, hm,conn); 
		  
			JRXlsExporter exporterXLS = new JRXlsExporter();
 exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
  exporterXLS.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE); 
 exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);
  exporterXLS.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.TRUE); 
 exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
 exporterXLS.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,outFileName);
 
 exporterXLS.exportReport();
  myrul="jasper/jasperxls/"+fnm;
  response.sendRedirect(myrul);
			conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}
				}  
				}  
%>
</form>
</body>
</html>
