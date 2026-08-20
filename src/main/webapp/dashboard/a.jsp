<%@ page  import="java.io.*"%> 
<%@ page  import="javax.sql.*"%> 
<%@ page  import="javax.naming.*"%> 
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page  import="java.sql.Connection"%> 
<%@ page  import="java.sql.DriverManager"%>
<%@ page  import="java.util.HashMap"%>
<%@ page  import="java.util.Map"%>
<%@ page  import="net.sf.jasperreports.engine.export.*"%>

<%@ page  import="net.sf.jasperreports.engine.*"%>
<%@ page  import="net.sf.jasperreports.engine.JRChart"%>
<%@ page  import="net.sf.jasperreports.charts.fill.*"%>
<%@ page  import="org.jfree.chart.JFreeChart"%>

		<%		
			String js=request.getParameter("fn");
			Connection conn = null;	
			  Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        
          HashMap hm = new HashMap(); 
		 //hm.put("PAPPID",vAPPID);
		 ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"dashboard/";
		  // File reportFile = new File("E:\\tomcat5\\webapps\\pmegpeportal\\dashboard\\"+js+".jasper");//your report_name.jasper file
		  File reportFile = new File(folderpath+js+".jasper");//your report_name.jasper file
            JasperPrint print = JasperFillManager.fillReport(reportFile.getPath(), hm,conn); 
            JRExporter exporter = new JRHtmlExporter(); 
           //exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, "E:\\tomcat5\\webapps\\pmegpeportal\\dashboard\\"+js+".html"); 
		   
		   exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,folderpath+js+".html"); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
			
			String ft=js+".html";
        %>
		
		<jsp:include page ='<%=ft%>'/>
  