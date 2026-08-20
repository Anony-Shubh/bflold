<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vFname=request.getParameter("REPNM")==null?"":(String)request.getParameter("REPNM");
		   String month_dt=request.getParameter("month_dt")==null?"":(String)request.getParameter("month_dt");
		   String STATECD=request.getParameter("STATECD")==null?"":(String)request.getParameter("STATECD");
		   String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
		   String FROM_DT=request.getParameter("FROM_DT")==null?"":request.getParameter("FROM_DT");
	String TO_DT=request.getParameter("TO_DT")==null?"":request.getParameter("TO_DT");
	String OFFCD=request.getParameter("OFFCD")==null?"":(String)request.getParameter("OFFCD");
		   
		   
		   //String month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
	   if (!month_dt.equals("")) {
String vGenID=month_dt;
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();

//String folderpath= context.getRealPath("")+"/samadhanedp/jasper/";
String folderpath= context.getRealPath("")+"bnf_202223/jasperReports/";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+vGenID+".xls";
	
	//String outFileName =folderpath+"jasperxls/"+fnm; 
	String outFileName =folderpath+"/jasper/jasperxls/"+fnm; 
  out.print(vFname);
	try {
   Context ctx=new InitialContext();
 Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
	   
	   	if(vFname.equals("edpreport")){
	hm.put("FROM_DT",FROM_DT);
	hm.put("TO_DT",TO_DT);
	}
	   
	   
	 if (vFname.equals("SAMADHANEDP_SUMMARY")) {
	 	hm.put("PMINVDT",month_dt);
	 }else {
		hm.put("PINVMONTH",month_dt);
		hm.put("PSTATECD",STATECD);
		hm.put ("POFFCD",OFFCD);
		}
		
		 out.print(month_dt);
		  out.print(STATECD);
		   out.print(SOFF_CD);

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
          