<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,pkgPmegpNew.DBCon"  %>
     
	       <%	
		DBCon db= new DBCon();
db.connect();
		   String myrul="";
		   String vwherecls="";
		   
String vFname=request.getParameter("REPNM")==null?"":request.getParameter("REPNM");
	String vOFF_CD=request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD");
	String QRYCODE=request.getParameter("QRYCODE")==null?"":request.getParameter("QRYCODE");
	String YEAR_ID=request.getParameter("YEAR_ID")==null?"":request.getParameter("YEAR_ID");
	String vGenID="100";
	String vcls="";
	if(!vOFF_CD.equals("9999"))
	{
		vcls=vcls + "  OFF_CD='"+vOFF_CD+"' ";
	}
	else{
		vcls=vcls + "  OFF_CD like '%%' ";
	}
	
	
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"bnf_202122/jasperReports/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String fnm=vFname+".xls";
	
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
			 if(vFname.equals("BNFALLO_ACHV")){
			 hm.put("wrcls",vcls);
			  hm.put("YEAR_ID",YEAR_ID);
			 }
			 out.print(vcls);
	
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
          