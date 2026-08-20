<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,pkgPmegpNew.DBCon"  %>
     
	       <%	
		DBCon db= new DBCon();
db.connect();
		   String myrul="";
		   String vwherecls="";
		   
String vtype="pdf";
	  String vooff_cd=session.getAttribute("off_cd")==null?"0":(String) session.getAttribute("off_cd");// (String) session.getAttribute("off_cd");
    String vBankName=request.getParameter("BANKNAME")==null?"%%":(String) request.getParameter("BANKNAME"); 
 
	String vFname=request.getParameter("REPNM")==null?"":request.getParameter("REPNM");
	String vOFF_CD=request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD");
	String vGenID="100";
	String vcls="";
	  String vQryCode=request.getParameter("QRYCODE")==null?"0":(String) request.getParameter("QRYCODE"); 
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String txtSearch="";
// txtSearch = txtSearch + "  AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt) between '"+FromDt+"' and  '"+ToDt+"' " ;


 if (vQryCode.equals("0")){
 //ALL APPLICATION
 txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt) between '"+FromDt+"' and  '"+ToDt+"' " ;
} else if (vQryCode.equals("1")){
// UNDER PROCESS AT AGENCY
  txtSearch = txtSearch + "  AND AD.BANK_NAME LIKE UPPER('"+vBankName+"') and ad.act_id=1 " ;
  // PLACED BEFORE DLTFC COMMITTEE
  }else if (vQryCode.equals("2")){
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and (ad.FORD_DT_DLTFC IS NOT NULL OR ad.MTG_ID IS NOT NULL)";
 }else if (vQryCode.equals("3")){
 // REJECTED BY DLTFC COMMITTEE
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt) between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=7 ";
 }else if (vQryCode.equals("4")){
 // Sanctioned by DLTFC COMMITTEE
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt) between '"+FromDt+"' and '"+ToDt+"' and ( ad.act_id<>7 AND AD.ACT_ID>=4) ";
 
  }else if (vQryCode.equals("5")){
 // Forwarded to Bank
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt) < '"+FromDt+"'  and ad.act_id=5  and NVL(BD.ACT_ID,0) NOT IN (11,3)";
  }else if (vQryCode.equals("6")){
 // Sanctioned by Bank 
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt) between '"+FromDt+"' AND '"+ToDt+"' and ad.act_id=5 ";
}

else if (vQryCode.equals("8")){
 // Rejected by Bank
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(AD.ONLINE_SUBDT) < '"+FromDt+"' and AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL   ";
 }else if (vQryCode.equals("9")){
 // Own Contribution Deposited
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and   TRUNC(AD.ONLINE_SUBDT) between '"+FromDt+"' AND '"+ToDt+"' and AD.ACT_ID=5 AND BD.ACT_ID=11 ";
 }
 
 
 else if (vQryCode.equals("11")){
 //  LOAN RELEASED
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(BD.MM_CLAIM_DT) < '"+FromDt+"'  and AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND NVL(BD.PACT_ID,0) <> 34  ";
  }else if (vQryCode.equals("12")){
 // EDP TRANING COMPLETED
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(BD.MM_CLAIM_DT) between '"+FromDt+"' AND '"+ToDt+"' and  AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND NVL(BD.PACT_ID,0) <> 34 ";
 }
 
 
 else if (vQryCode.equals("14")){
 // MM CLAIMED
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND NVL(BD.PACT_ID,0) = 34  AND TRUNC(BD.MM_REL_DT)  between '"+FromDt+"' AND '"+ToDt+"'   ";
 }else if (vQryCode.equals("1")){
 // MM RELEASED
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(BD.MM_CLAIM_DT) between '"+FromDt+"' AND '"+ToDt+"' and AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND BD.PACT_ID NOT IN(34,30) AND BD.APPRV_YN='A'  ";
 }
 

 else if (vQryCode.equals("18")){
   txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(BD.MM_CLAIM_DT) between '"+FromDt+"' and '"+ToDt+"' AND  AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND BD.MM_CLAIM_AMT >0 AND  BD.PACT_ID IS NULL ";
 }else if (vQryCode.equals("19")){
  txtSearch = txtSearch + " AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(BD.MM_CLAIM_DT) between '"+FromDt+"' and '"+ToDt+"' and AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.MM_CLAIM_DT IS NOT NULL AND BD.MM_CLAIM_AMT >0 AND BD.PACT_ID =30   ";
 
 }else if (vQryCode.equals("20")){
 // Pending for MM Release
  txtSearch = txtSearch + "  AND AD.BANK_NAME LIKE UPPER('"+vBankName+"')  and TRUNC(ad.online_subdt)  between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=3  ";
}
 
	
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"jsp/agencylogin/jasper/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String fnm=vFname+".xls";
	
	String outFileName =folderpath+"/jasperxls/"+fnm; 

	out.print("<BR>");
		out.print(vBankName+"vBankName");
		out.print("<BR>");
				out.print(vooff_cd);
				out.print("<BR>");
				out.print(txtSearch);	
				out.print("<BR>");
			
	try {
	
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();
		
		//if(vREPNAME.equals("SALES_GST_REP")){
		//	 hm.put("PCUSTCODE",vCUSTCODE);
		//	 hm.put("PFROMDT",vFROMDT);
		//	 hm.put("PTODT",vTODT);
			 //}else   SUPP_MAINGROUP_EX
			if (vFname.equals("Agency_dwstatewise_pen")){
	  
		   hm.put("POFF_CD",vooff_cd);
		     hm.put("PTXTSEARCH",txtSearch);
		 }
			
			//SALES_ALLMAINGROUPWISE_PRODUCT_EX
			//SALES_ALLMAINGROUPWISE_PRODUCT_EX
			 //out.print(GSTR1_EXCEL_REP_HO_RTSALES);
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
  myrul="jasperxls/"+fnm;
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
%>
          