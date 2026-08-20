<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vFname=request.getParameter("REPNM")==null?"":(String)request.getParameter("REPNM");
		    String vMonth=request.getParameter("MONTH")==null?"":(String)request.getParameter("MONTH");
			String month_dt=session.getAttribute("sInvDt")==null?"11":(String) session.getAttribute("sInvDt");
	   if (!month_dt.equals("")) {
String vGenID=month_dt;
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();

String folderpath= context.getRealPath("")+"/samadhanedp/jasper/";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+vGenID+".xls";
	
	String outFileName =folderpath+"jasperxls/"+fnm; 
  out.print(month_dt);
	try {
   Context ctx=new InitialContext();
 Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
	 if (vFname.equals("SAMADHANEDP_SUMMARY")) {
	 	hm.put("PMINVDT",month_dt);
	 }else if (vFname.equals("samrecomamount")){
			 hm.put("MONTH_DT",vMonth);
		
			 } 
		
	 else {
		hm.put("PINVMONTH",month_dt);
		}

		
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
				}else {
			out.print ("select Month");	
			}	
				//end if
%>
          