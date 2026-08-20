<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	String vFname=request.getParameter("REP_NM")==null?"awarness":request.getParameter("REP_NM");
	String vBGTID=request.getParameter("BGTID")==null?"0":request.getParameter("BGTID");
	String YEAR_ID=request.getParameter("YEAR_ID")==null?"":request.getParameter("YEAR_ID");
	String vGenID="100";
	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"bnf/jasperReports/";
	out.print(folderpath);
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =folderpath+"/jaspdf/"+vFname+vGenID+".pdf"; 
	String fname=vFname+vGenID+".pdf";
	
   	Context ctx=new InitialContext();
	Context envCtx = (Context) ctx.lookup("java:comp/env");
 	DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 	conn=ds.getConnection(); 
	   HashMap hm = new HashMap(); 
		
	if (vFname.equals("report2")){ 
		//   hm.put("PBGTID",new BigDecimal(vBGTID));
		   hm.put("YEAR_ID",YEAR_ID);
		  }else{
		  hm.put("PBGTID",new BigDecimal(vBGTID));
		   hm.put("YEAR_ID",YEAR_ID);
		  }
		   
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
		 
			 JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
          //response.sendRedirect("../jasperReports/jaspdf/"+fname);
 response.sendRedirect("../jasperReports/jaspdf/"+fname);
				conn.close();
			
	//localhost/pmegpeportal/bnf/jasperReports/bnfreport.jsp?REP_NM=bnfconsolidatetarget&BGTID=4
	//localhost/pmegpeportal/bnf/jasperReports/jaspdf/bnfconsolidatetarget100.pdf	 
			
%>


