<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
	//	DBCon db= new DBCon();
//db.connect();
		   String myrul="";
		   String vwherecls="";
		   
	String vFname=request.getParameter("REPNM")==null?"":request.getParameter("REPNM");

	
	String FROM_DT=request.getParameter("FROM_DT")==null?"10-Jun-2021":request.getParameter("FROM_DT");
	String TO_DT=request.getParameter("TO_DT")==null?"17-Jul-2021":request.getParameter("TO_DT");
	
	String vGenID="100";


	
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();
	//String folderpath= context.getRealPath("");
	String folderpath= context.getRealPath("")+"bnf_202223/jasperReports/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String fnm=vFname+".xls";
	
	String outFileName =folderpath+"/jasper/jasperxls/"+fnm; 
	
	//out.print(fileName);

	try {
	
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();
		
		
	   	if(vFname.equals("edpreport")){
	hm.put("FROM_DT",FROM_DT);
	hm.put("TO_DT",TO_DT);
	}
			
			 

			
	 
			 out.print(vFname);
	
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
          