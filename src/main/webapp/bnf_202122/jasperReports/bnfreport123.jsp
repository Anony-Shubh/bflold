<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	String vFname=request.getParameter("REPNM")==null?"":request.getParameter("REPNM");
	String vOFF_CD=request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD");
	String YEAR_ID=request.getParameter("YEAR_ID")==null?"":request.getParameter("YEAR_ID");
	String QRYCODE=request.getParameter("QRYCODE")==null?"":request.getParameter("QRYCODE");
	String vGenID="100";
	String vcls="";
	if(!vOFF_CD.equals("9999"))
	{
		vcls=vcls + "  OFF_CD='"+vOFF_CD+"' ";
	}
	else{
		vcls=vcls + "  OFF_CD like '%%' ";
	}
	
	//String vclsnew="";
	
	//vclsnew=vclsnew + " YEAR_ID='"+vYEAR_ID+"' ";
	
	out.print(vcls);out.print("<br/>");
	out.print(vFname);out.print("<br/>");
	out.print(QRYCODE);out.print("<br/>");
	
	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"bnf_202122/jasperReports/";
	//String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =folderpath+"/jaspdf/"+vFname+vGenID+".pdf"; 
	String fname=vFname+vGenID+".pdf";
	
   	Context ctx=new InitialContext();
	Context envCtx = (Context) ctx.lookup("java:comp/env");
 	DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 	conn=ds.getConnection(); 
    HashMap hm = new HashMap(); 
		
		   hm.put("YEAR_ID",YEAR_ID);
				
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
			 JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
     response.sendRedirect("../jasperReports/jaspdf/"+fname);
				conn.close();
			
	//localhost/pmegpeportal/bnf/jasperReports/bnfreport.jsp?REP_NM=bnfconsolidatetarget&BGTID=4
	//localhost/pmegpeportal/bnf/jasperReports/jaspdf/bnfconsolidatetarget100.pdf	 
			
%>


