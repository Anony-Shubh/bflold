<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vwherecls="";

		   String vFname=request.getParameter("REPNM")==null?"":(String)request.getParameter("REPNM");
		   String vUserID=(String)session.getAttribute("off_cd");
		    String PEND_TYPE=request.getParameter("PEND_TYPE")==null?"":(String)request.getParameter("PEND_TYPE");
			out.print(vUserID);
			
		  if (PEND_TYPE.equals("1")){
		  vwherecls=vwherecls+" WHERE MQR.APP_ID = SQR.APP_ID(+) ";
		   }
		   else  if (PEND_TYPE.equals("2")){
		  vwherecls=vwherecls+" WHERE MQR.APP_ID = SQR.APP_ID(+) AND MQR.ACT_ID=11 AND (MQR.EDP_CERT_DT IS NULL OR SQR.DOC_NAME IS NULL)";
		   }
		  else{
			  
			   vwherecls=vwherecls+" WHERE MQR.APP_ID     = SQR.APP_ID(+) AND MQR.EDP_TYPE   IN (1, 3) AND MQR.EDP_CERT_DT IS NULL "; 
		  }
		   
		
		out.print(vwherecls);
		
String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"jasperrop/";
	
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xls";
	
	String outFileName =folderpath+"jaspdf/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
			
			 hm.put("vcls",vwherecls);
			  hm.put("POFFCD",vUserID);
			//out.print(vwherecls);
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
 myrul="../jasperrop/jaspdf/"+fnm;
 response.sendRedirect(myrul);
 
 //out.print(outFileName);
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
          