<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
     
	       <%
		   Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
DateFormat df1 = new SimpleDateFormat("dd-MMMM-yyyy");
String todayDt=df1.format(now);
String curdt = df.format(now);
		   
		   	
		   String myrul="";
		   String vwherecls="";

		   String vFname=request.getParameter("REPNM")==null?"EDPTRAINING":(String)request.getParameter("REPNM");
		    String EDP_TYPE=request.getParameter("GRV_TYPE")==null?"":(String)request.getParameter("GRV_TYPE");
		    String pfrom=request.getParameter("FROMDT")==null?"":(String)request.getParameter("FROMDT");
			String pto=request.getParameter("TODT")==null?"":(String)request.getParameter("TODT");
			String OFFCD=session.getAttribute("SOFF_CD")==null?"":(String) session.getAttribute("SOFF_CD");
			
			if (pfrom.equals("")){
			pfrom="31-AUG-2020";
			}
			else
			{
			pfrom=pfrom;
			}
			
			if (pto.equals("")){
			pto=todayDt ;
			}
			else
			{
			pto=pto;
			}
			
			
			
		  if(EDP_TYPE.equals("0")){
		  vwherecls=vwherecls+" EDPOFF_CD="+OFFCD+" AND EDPTIMESTAMP BETWEEN '"+pfrom+"' AND '"+pto+"' ";
		   }
		   else if(EDP_TYPE.equals("-1")){ 
		   vwherecls=vwherecls+"OFF_TYPE_CD=17  AND EDPTIMESTAMP BETWEEN '"+pfrom+"' AND '"+pto+"' AND FREE_EDPYN='YES' ";
		   }
		   else{
		   vwherecls=vwherecls+"  EDPOFF_CD="+OFFCD+" AND  EDP_TYPE="+EDP_TYPE+" AND EDPTIMESTAMP BETWEEN '"+pfrom+"' AND '"+pto+"'  ";
		   }
		   
		
		
		out.print(vwherecls);
		
String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"edpoff/jasper/";
	
	//opt/tomcat5/webapps/pmegpeportal/jasperrop/
	//String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xls";
	//String outFileName =folderpath+"jaspdf/"+vAPPID+rnd+".pdf"; 
	
	String outFileName =folderpath+"jaspdf/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
			
			 hm.put("WHERECLS",vwherecls);
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
          