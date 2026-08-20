<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	/String vFname=request.getParameter("REP_NM")==null?"":request.getParameter("REP_NM");
	
	
	E:\tomcat5\webapps\pmegpeportal\bnf\jasperReports
	
	Connection conn=null;
	String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\bnf\\jasperReports\\";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =folderpath+"\\jaspdf\\"+vFname+vGenID+".pdf"; 
	String fname=vFname+vGenID+".pdf";
	
	
	
	/*
	
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap(); 
		
		
		 
		   hm.put("PBENCD",new BigDecimal(vBENCD));
		    }
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
			 JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
            response.sendRedirect("..\\claimReport\\jaspdf\\"+fname);
				conn.close();
			*/	
			
%>
