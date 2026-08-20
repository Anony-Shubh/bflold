<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<html>
<head>
	
</head>
</head>
    <%
	String vBrnm="";
  String vTodt=request.getParameter("TODT");
		   String vFrdt=(String)request.getParameter("FROMDT");
		    String vIFSL_CODE=(String)request.getParameter("IFSL_CODE");
		
			 String vqcode=(String)request.getParameter("QCODE");
			 String PBATCH_ID=request.getParameter("PBATCH_ID")==null||request.getParameter("PBATCH_ID")==""?"%%":(String)request.getParameter("PBATCH_ID");
			  //out.print (vHirone);
			  String vHirtwo=request.getParameter("HIRTWO")==null||request.getParameter("HIRTWO")==""?"%%":(String) request.getParameter("HIRTWO");
			 String vwherecls="";
			 String flag=request.getParameter("flag")==null?"N":(String) request.getParameter("flag");
%>
         
			  
           <%	
		   String myrul="";
		   String vFname="pmegpmr_pfmsbatch";

Connection conn=null;
ServletContext context=request.getServletContext();
String folderpath= context.getRealPath("")+"pmegpmr/jasper/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\bankpmegpmr\\jasper\\";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	
	String fnm=vFname+t.nextInt(1000000)+".xls";
	
	String outFileName =folderpath+"/jaspxls/"+fnm; 
	//String fname=vFname+vGenID+".pdf";	 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();
	
		  hm.put("PBATCH_ID",PBATCH_ID);

		  
		    JRExporter  exporter = new JRXlsExporter(); 
          JasperPrint jasperPrint = JasperFillManager.fillReport(fileName, hm,conn); 
		  JRXlsExporter exp = new JRXlsExporter();
		  
		  
		  exp.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	//exp.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
	 exp.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,outFileName);
	exp.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
	exp.setParameter(JRXlsExporterParameter.OFFSET_X, 0);
	exp.setParameter(JRXlsExporterParameter.IS_IGNORE_CELL_BORDER, Boolean.FALSE);
	exp.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, true);
	exp.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, false);
      	exp.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, false);
      	exp.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,Integer.decode("65000"));
  	exp.exportReport();
		  
		  
		  /*
			JRXlsExporter exporterXLS = new JRXlsExporter();
 exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
 exporterXLS.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,outFileName);
 exporterXLS.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET, 60000);
 exporterXLS.exportReport();
 */
 myrul="jasper/jaspxls/"+fnm;
 flag="Y";

			conn.close();
			//out.print(vwherecls.toString());
    response.sendRedirect(myrul);
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
           <a href="./jasper/jaspxls/<%= fnm %>">download in excel file </a>
		    </form>
    </html>
</body>
</html>
