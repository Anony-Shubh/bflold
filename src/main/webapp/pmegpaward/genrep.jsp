<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	
	String vFname=request.getParameter("REP_NM")==null?"REP_NM":request.getParameter("REP_NM");
	String PRINTWHN=request.getParameter("PRINTWHN")==null?"":request.getParameter("PRINTWHN");
	//String app_id=request.getParameter("app_id")==null?"":request.getParameter("app_id");
	String app_id=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");
	
	String app_idnew=request.getParameter("app_id")==null?"":request.getParameter("app_id");
	
	String typenew=request.getParameter("typenew")==null?"":request.getParameter("typenew");


	String vGenID=app_id;
	Connection conn=null;
	
	ServletContext context = request.getServletContext();
String folderpath= context.getRealPath("")+"/pmegpaward/reports/";
	String fileName = folderpath+vFname+".jasper"; //
	String outFileName =folderpath+"/jaspdf/"+vFname+vGenID+".pdf";
	 
    String fname=vFname+vGenID+".pdf";
	
  	Context ctx=new InitialContext();
	Context envCtx = (Context) ctx.lookup("java:comp/env");
			DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 	conn=ds.getConnection(); 

                                                                        
	   HashMap hm = new HashMap(); 
		
		  	if (vFname.equals("pmegpaward_report")){ 
		   hm.put("app_id",app_id);
		   }
		   
		   		  	if (typenew.equals("1")){ 
		   hm.put("app_id",app_idnew);
		   }
		   
		   
		  
		  
		  
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
		  JRExporter exporter = new JRPdfExporter(); 
	 exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
     exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
     exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
     exporter.exportReport(); 
		  response.sendRedirect("../pmegpaward/reports/jaspdf/"+fname);
		  //response.sendRedirect("..\\reports/jaspdf\\"+fname);
		  conn.close();
 
			
%>


