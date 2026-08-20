<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vwherecls="";


		   String vFname=request.getParameter("REPNM")==null?"EDPBANKNOTVERIFY":(String)request.getParameter("REPNM");
		 String vsAgency=request.getParameter("AGENCY")==null?"%%":(String)request.getParameter("AGENCY");
		    String pfrom=request.getParameter("FROMDT")==null?"":(String)request.getParameter("FROMDT");
			String pto=request.getParameter("TODT")==null?"":(String)request.getParameter("TODT");
			String vQry=request.getParameter("REPTP")==null?"0":(String)request.getParameter("REPTP");
			String EDP_TYPE=request.getParameter("EDP_TYPE")==null?"":(String)request.getParameter("EDP_TYPE");
			String vsZonecd=request.getParameter("ZONECD")==null?"%%":(String)request.getParameter("ZONECD");
		 String vsStatecd=request.getParameter("STATECD")==null?"%%":(String)request.getParameter("STATECD");
		    String OFF_NAME1=request.getParameter("OFF_NAME1")==null?"%%":(String)request.getParameter("OFF_NAME1");
			String vDISTCD=request.getParameter("DISTCD")==null?"%%":(String)request.getParameter("DISTCD");
			//out.print(vsZonecd);	
			String vsStatedc=request.getParameter("STATEDC")==null?"%%":(String)request.getParameter("STATEDC");
			String vQryCode=request.getParameter("QRYCODE")==null?"":(String)request.getParameter("QRYCODE");
			
			
			
			if(!vsAgency.equals("Total")){
				vsAgency=vsAgency;				
			}
			else{
				vsAgency="%%";	
			}
			
			if(!vsStatecd.equals("Total")){
				vsStatecd=vsStatecd;				
			}
			else if ((vsStatecd.equals("%%")) || (vsStatecd.equals("Total"))) {
				vsStatecd="%%";	
			}
			
			if(!vDISTCD.equals("Total")){
				vDISTCD=vDISTCD;				
			}
			else if ((vDISTCD.equals("%%")) || (vDISTCD.equals("Total"))) {
				vDISTCD="%%";	
			}
			
			
			 if (vsZonecd.equals("ALL")||vsZonecd.equals("null")||vsZonecd.equals("Total")||vsZonecd.equals("")||vsZonecd.equals("%%")){
				vsZonecd="%%";				
			}
			else{

					vsZonecd=vsZonecd;
			}
			
			
			
			
			
			
			
			
			if (vQry.equals("1")){
				
			if (vQryCode.equals("1")){
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' AND A.ACT_ID=11 AND TRUNC(A.LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + "  A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  = 9246 ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  <> 9246 ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS NOT NULL ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS  NULL ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"'   and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(A.LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND UPLOAD_YN='Y' "; 
			}
			
				
				

			}
			else if (vQry.equals("2")){
				
			if (vQryCode.equals("1")){
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  = 9246 AND A.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  <> 9246 AND A.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS NOT NULL AND A.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS  NULL AND A.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(A.LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND UPLOAD_YN='Y' AND A.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
			
					}
			else if (vQry.equals("3")){
				
					if (vQryCode.equals("1")){
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  = 9246 AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"'   ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  <> 9246 AND A.ZONE_NM LIKE '"+vsZonecd+"'   AND A.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'   AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"'and (A.EDP_CERT_DT) IS NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"'  and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS NOT NULL AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"'  and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS  NULL AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(A.LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND UPLOAD_YN='Y' AND A.ZONE_NM LIKE '"+vsZonecd+"'   AND A.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			

			}
				else if (vQry.equals("4")){
				
					if (vQryCode.equals("1")){
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"'  AND A.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  = 9246 AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"'  ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.OFF_CD  <> 9246 AND A.ZONE_NM LIKE '"+vsZonecd+"'   AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS NOT NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"'  AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS NOT NULL AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND TRUNC(A.MM_REL_DT) IS  NULL AND A.ZONE_NM LIKE '"+vsZonecd+"'  AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' and  (A.EDP_CERT_DT) IS  NULL AND A.ACT_ID=11 AND TRUNC(A.LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND UPLOAD_YN='Y' AND A.ZONE_NM LIKE '"+vsZonecd+"'   AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			

			}
			
			
			
			
			else if (vQry.equals("0")){
			
vwherecls=vwherecls + " A.AGENCY_TYPE LIKE '"+vsAgency+"' AND A.EDP_CERT_DT IS NOT NULL AND A.ACT_ID=11 AND TRUNC(A.LOAN_SANC_DT) BETWEEN  '"+pfrom+"' and  '"+pto+"' AND A.STATE_NM LIKE '"+vsStatecd+"' AND A.off_name1 LIKE '"+OFF_NAME1+"' AND A.ZONE_NM LIKE  '"+vsZonecd+"' AND A.STATE_NM LIKE '"+vsStatedc+"' ";
			}
			

	// 	
		 // out.print(vwherecls);
		   //out.print(pto);
String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmr/jasper/";
	
	//opt/tomcat5/webapps/pmegpeportal/jasperrop/
	//String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xls";
	//String outFileName =folderpath+"jaspdf/"+edp+rnd+".pdf"; 
	
	String outFileName =folderpath+"jaspxls/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
			 hm.put("WHERECLS",vwherecls);
			
			out.print(vwherecls);
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
          