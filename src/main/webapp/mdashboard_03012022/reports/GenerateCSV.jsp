<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,pkgPmegpNew.DBCon"  %>
     
	       <%	
		DBCon db= new DBCon();
db.connect();
		   String myrul="";
		   String vwherecls="";
		   
String vFname=request.getParameter("REP_NM")==null?"":request.getParameter("REP_NM");
	String STATE_CD=request.getParameter("STATE_CD")==null?"":request.getParameter("STATE_CD");
	String STATE_NM=request.getParameter("STATE_NM")==null?"":request.getParameter("STATE_NM");
	String QRYCODE=request.getParameter("QRYCODE")==null?"":request.getParameter("QRYCODE");
	String YEAR_ID=request.getParameter("YEAR_ID")==null?"":request.getParameter("YEAR_ID");
	String vGenID="100";
	String vcls="";

	
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"a/reports/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String fnm=vFname+".csv";
	
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
			 if(vFname.equals("dashboardreportdistrict")){
		//	 hm.put("wrcls",vcls);
			  hm.put("STATE_CD",STATE_CD);
			  hm.put("STATE_NM",STATE_NM);
			 }
		//	 out.print(vcls);
	
			//SALES_ALLMAINGROUPWISE_PRODUCT_EX
			//SALES_ALLMAINGROUPWISE_PRODUCT_EX
			 //out.print(GSTR1_EXCEL_REP_HO_RTSALES);
		  JRExporter  exporter = new JRXlsExporter(); 
          JasperPrint jasperPrint = JasperFillManager.fillReport(fileName, hm,conn); 
		  
	 /*	  JRCsvExporter exporterCSV = new JRCsvExporter();
exporterCSV.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
exporterCSV.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, outFileName);
exporterCSV.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, true);
exporterCSV.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, true);
exporterCSV.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, true);
exporterCSV.setParameter(JRXlsExporterParameter.IS_AUTO_DETECT_CELL_TYPE, true);
exporterCSV.exportReport();*/
		  
JRXlsExporter exporterCSV = new JRXlsExporter();
 exporterCSV.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
 exporterCSV.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE); 
 exporterCSV.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
 exporterCSV.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
 exporterCSV.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
 exporterCSV.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);
 exporterCSV.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.TRUE); 
 exporterCSV.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
 exporterCSV.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,outFileName);
 
exporterCSV.exportReport();
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
%>
          