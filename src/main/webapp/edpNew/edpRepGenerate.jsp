<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vwherecls="";

		   String vFname=request.getParameter("REPNM")==null?"EDPTRAINING":(String)request.getParameter("REPNM");
		    String state=request.getParameter("STATE")==null?"":(String)request.getParameter("STATE");
		    String OFF_TYPE_CD=request.getParameter("OFFTYPE")==null?"":(String)request.getParameter("OFFTYPE");
			
			
		  if ((!state.equals("ALL")) && (!OFF_TYPE_CD.equals("ALL"))){
		  vwherecls=vwherecls+" AND MOM.OFF_TYPE_CD="+OFF_TYPE_CD+" AND MS.STATE_CD ='"+state+"' ";
		   }
		   else  if ((state.equals("ALL")) && (OFF_TYPE_CD.equals("ALL"))){
		  vwherecls=vwherecls+" AND MOM.OFF_TYPE_CD IN (26,17,18,19,28,29,30,31,32,33,34) AND MS.STATE_CD LIKE '%%'  ";
		   }
		   else  if ((!state.equals("ALL")) && (OFF_TYPE_CD.equals("ALL"))){
		  vwherecls=vwherecls+" AND MOM.OFF_TYPE_CD IN (26,17,18,19,28,29,30,31,32,33,34) AND MS.STATE_CD ='"+state+"'  ";
		   }
		   
		   else  if ((state.equals("ALL")) && (!OFF_TYPE_CD.equals("ALL"))){
		  vwherecls=vwherecls+" AND MOM.OFF_TYPE_CD= "+OFF_TYPE_CD+" AND MS.STATE_CD LIKE '%%'  ";
		   }
		   
		
		out.print(vwherecls);
		
String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"edpNew/jasper/";
	
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xls";
	
	String outFileName =folderpath+"jaspdf/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
			
			 hm.put("WHERCLS",vwherecls);
			  //hm.put("PUSERID",puserid);
			//out.print(vwherecls);
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
 myrul="jasper/jaspdf/"+fnm;
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
          