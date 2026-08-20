<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   
		String sZonecd =session.getAttribute("szone")==null?"%%":(String) session.getAttribute("szone");
//out.print(vsZonecd);
String sAgency=session.getAttribute("sagency")==null?"%%":(String) session.getAttribute("sagency");
//out.print(vsAgency);
String sStatecd =session.getAttribute("sstate_cd")==null?"%%":(String) session.getAttribute("sstate_cd");
out.print(sStatecd);
if(sStatecd.equals("ALL")){
sStatecd="%%";
}
else{
sStatecd=sStatecd;
}   
		   
		   
		   
		   
		   String myrul="";
		   String vwherecls="";



String txtSearch="";
 String vFname=request.getParameter("REPNM")==null?"SAMADHANEDP2":(String)request.getParameter("REPNM");
String vStateCd=request.getParameter("STATECD")==null?"%%":(String) request.getParameter("STATECD");  
 String vOffname=request.getParameter("OFFNAMECD")==null?"%%":(String) request.getParameter("OFFNAMECD"); 
 String vZoneCD=request.getParameter("ZONECD")==null?"%%":(String) request.getParameter("ZONECD"); 
 String vAgency=request.getParameter("AGENCY")==null?"%%":(String) request.getParameter("AGENCY"); 
  String vDist=request.getParameter("DISTCD")==null?"%%":(String) request.getParameter("DISTCD"); 
   // String vBankName=request.getParameter("BANKNAME")==null?"":(String) request.getParameter("BANKNAME"); 
   
    if (vZoneCD.equals("ALL")||vZoneCD.equals("null")||vZoneCD.equals("Total")||vZoneCD.equals("")||vZoneCD.equals("%%")){
				vZoneCD="%%";				
			}
			else{

					vZoneCD=vZoneCD;
			}
			if(!vAgency.equals("Total")){
				vAgency=vAgency;				
			}
			else{
				vAgency="%%";	
			}
			if(!vStateCd.equals("Total")){
				vStateCd=vStateCd;				
			}
			else if ((vStateCd.equals("%%")) || (vStateCd.equals("Total"))) {
				vStateCd="%%";	
			}
			
			if(!vDist.equals("Total")){
				vDist=vDist;				
			}
			else if ((vDist.equals("%%")) || (vDist.equals("Total"))) {
				vDist="%%";	
			}
			
			
			

 // vBankName=getParm(vBankName);
  //vStateCd=getParm(vStateCd);  
 // vOffname=getParm(vOffname); 
// vZoneCD=getParm(vZoneCD); 
// vAgency=getParm(vAgency); 
 //  vDist=getParm(vDist); 
   
   
  String vQryCode=request.getParameter("QRYCODE")==null?"0":(String) request.getParameter("QRYCODE"); 
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");


String vUsrnm= (String) session.getAttribute("suser_detail");

String vfldQryDesc="";
String vCurStatus="";
txtSearch=" ";

txtSearch="  upper(A.zone_nm) like upper('"+vZoneCD+"') and upper(A.state_nm) like upper('"+vStateCd+"') and A.AGENCY_TYPE like '"+vAgency+"' and upper(A.DISTRICT_NAME) like upper('"+vDist+"')  and upper(A.state_nm) like upper('"+sStatecd+"') and upper(A.OFF_NAME2) LIKE UPPER('"+vOffname+"') ";
 
 if (vQryCode.equals("1")){
 txtSearch = txtSearch  + " and A.ACTUAL_EDP >0 AND LAST_DAY(A.cert_dt) BETWEEN LAST_DAY('"+FromDt+"') AND LAST_DAY( '"+ToDt+"' ) " ; 
}
out.print(txtSearch);

String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmr3/jasper/";
	
	
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xls";
	
	
	String outFileName =folderpath+"jaspxls/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
	   
			 hm.put("vcls",txtSearch);
			 
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