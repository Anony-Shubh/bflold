<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vwherecls="";

		   String vFname=request.getParameter("REPNM")==null?"PENDINGEDPTRAINING":(String)request.getParameter("REPNM");
		   String vState=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
		   
		   if (!vState.equals("ALL")){
		   vwherecls=" AND MS.STATE_NM='"+vState+"'";
		   }
		   else{
		    vwherecls=" AND MS.STATE_NM like '%%' ";
		   }
		  out.print(vwherecls);
		   
String vGenID=vFname;
String flag="Y";
Connection conn=null;
ServletContext context=request.getServletContext();
String folderpath= context.getRealPath("")+"pmegpmr1/jasper/";
	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\edp\\jasper\\";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+".xls";
	
	String outFileName =folderpath+"jaspxls/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();
			 hm.put("vwherecls",vwherecls);
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
  myrul="jasper/jaspxls/"+fnm;
  response.sendRedirect(myrul);
  
  out.print (folderpath);
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
          
