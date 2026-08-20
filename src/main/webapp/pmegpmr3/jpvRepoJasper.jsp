<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter"  %>
     
	       <%	
		   
	  
		   
		   
		   
		   
		   String myrul="";
		   String txtSearch="";


   
   
   		   String vFname=request.getParameter("REPNM")==null?"appdetails":(String)request.getParameter("REPNM");
  String vQryCode=request.getParameter("QRYCODE")==null?"0":(String) request.getParameter("QRYCODE"); 
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
 String vsStatecd=request.getParameter("STATECD")==null?"%%":(String)request.getParameter("STATECD");


String vUsrnm= (String) session.getAttribute("suser_detail");

String vfldQryDesc="";
String vCurStatus="";
txtSearch=" ";


 
 if (vQryCode.equals("1")){

 txtSearch = txtSearch + "  and ms.state_nm='"+vsStatecd+"'  ";
} else if (vQryCode.equals("2")){
 txtSearch = txtSearch + " and   ms.state_nm='"+vsStatecd+"' and gto.enum_cd is not null " ;

}
else if (vQryCode.equals("3")){
 txtSearch = txtSearch + " and ms.state_nm='"+vsStatecd+"' and gto.enum_cd IS NOT NULL AND GTO.qc_ver_dt IS NULL  " ;

}

else if (vQryCode.equals("4")){
 txtSearch = txtSearch + " and  ms.state_nm='"+vsStatecd+"' and  gto.qc_ver_dt is not null  " ;

}


String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmr3/jasper/";
	
	
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xlsx";
	
	
	String outFileName =folderpath+"jaspxls/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
	   
			 hm.put("enumcd",txtSearch);
			 
			out.print(txtSearch);
		  JRExporter  exporter = new JRXlsExporter(); 
          JasperPrint jasperPrint = JasperFillManager.fillReport(fileName, hm,conn); 
		  
			//JRXlsExporter exporterXLS = new JRXlsExporter();
			
			JRXlsxExporter exporterXLS = new JRXlsxExporter();
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
 
 //out.print(outFileName);
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