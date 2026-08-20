<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	    //String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
		String SOFF_CD=request.getParameter("SOFF_CD")==null?"":(String)request.getParameter("SOFF_CD");
		String month_dt=request.getParameter("MONTHDT")==null?"":(String)request.getParameter("MONTHDT");
        String invupid =request.getParameter("INVUPID")==null?"0":(String)request.getParameter("INVUPID");
	String vFname=request.getParameter("REP_NM")==null?"":request.getParameter("REP_NM");
	String vBGTID=request.getParameter("BGTID")==null?"0":request.getParameter("BGTID");
	String YEAR_ID=request.getParameter("YEAR_ID")==null?"0":request.getParameter("YEAR_ID");
	String VUC_ID=request.getParameter("UC_ID")==null?"":request.getParameter("UC_ID");
	
	
	String vGenID="100";
	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"bnf/jasperReports/";
	//String folderpath="E:\\tomcat5\\webapps\\pmegpeportal\\bnf1\\jasperReports\\";
	String fileName = folderpath+vFname+".jasper"; 
	//String outFileName =folderpath+"\\jaspdf\\"+vFname+vGenID+".pdf"; 
		String outFileName =folderpath+"jaspdf/"+vFname+vGenID+".pdf";
	String fname=vFname+vGenID+".pdf";
	
   	Context ctx=new InitialContext();
	Context envCtx = (Context) ctx.lookup("java:comp/env");
 	DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 	conn=ds.getConnection(); 
	   HashMap hm = new HashMap(); 
		
	//if (vFname.equals("report2")){ 
	if ((vFname.equals("report2"))||(vFname.equals("APR"))){ 
		   hm.put("YEAR_ID",YEAR_ID);
		 }
		 else if (vFname.equals("samadhanedprecom")){
			 hm.put("PINVUPID",invupid);
			 
			 if 	(SOFF_CD.equals("5707")) {
	SOFF_CD="10";
	}
	
	if 	(SOFF_CD.equals("6466")) {
	SOFF_CD="25";
	}
	
	if 	(SOFF_CD.equals("15")) {
	SOFF_CD="6029";
	}
			 
			 
			 
			 
			 
 hm.put("POFFCD",SOFF_CD);	
 hm.put("PMONTHDT",month_dt);	 
			 
		 }
		    else	if (vFname.equals("bnf_uc")){ 
		  hm.put("PUC_ID",VUC_ID);
		  }
		   
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
		 
			 JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
        //  response.sendRedirect("..\\jasperReports\\jaspdf\\"+fname);
		 if (vFname.equals("samadhanedprecom")){
		 response.sendRedirect("../../bnf/jasperReports/jaspdf/"+fname);
		 }else{
		 
 response.sendRedirect("../jasperReports/jaspdf/"+fname);
 }
				conn.close();
			
	//localhost/pmegpeportal/bnf/jasperReports/bnfreport.jsp?REP_NM=bnfconsolidatetarget&BGTID=4
	//localhost/pmegpeportal/bnf/jasperReports/jaspdf/bnfconsolidatetarget100.pdf	 
			
%>



