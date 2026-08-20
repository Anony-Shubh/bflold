<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,pkgPmegpNew.DBCon"  %>
     
	       <%	
		DBCon db= new DBCon();
db.connect();
		   String myrul="";
		   String vwherecls="";
		   
		  


		   
String vFname=request.getParameter("REPNM")==null?"pendingMISBank":request.getParameter("REPNM");
	String vBANK_NAME=request.getParameter("BANKNAME")==null?"":request.getParameter("BANKNAME");
	String QRYCODE=request.getParameter("QRYCODE")==null?"":request.getParameter("QRYCODE");
	String FromDt=request.getParameter("FROMDT")==null?"":request.getParameter("FROMDT");
     String ToDt=request.getParameter("TODT")==null?"":request.getParameter("TODT");
	String vGenID="100";
	String vcls="";
	if(QRYCODE.equals("1"))
	{
		vcls=vcls + "  AND RBI.BANK_NAME='"+vBANK_NAME+"' AND  NVL(BD.ACT_ID, 0) IN (0, 8) AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+FromDt+"' AND '"+ToDt+"' ";
	}
	else{
		vcls=vcls + "  AND RBI.BANK_NAME='"+vBANK_NAME+"' AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL  AND BD.MM_CLAIM_DT IS NULL AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FromDt+"' AND '"+ToDt+"' ";
	}
	
	out.print(vcls);
	
	
	
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"jasperrop/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String fnm=vFname+".xlsx";
	
	String outFileName =folderpath+"/jasper/jasperxls/"+fnm; 
	//out.print(outFileName);

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
			 
			 hm.put("wrcls",vcls);
			 
	
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
  myrul="jasperrop/jasper/jasperxls/"+fnm;
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
          