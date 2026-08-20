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
 String vFname=request.getParameter("REPNM")==null?"PMEGPAWARD_1208":(String)request.getParameter("REPNM");
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
			
			
			

   
   
  String vQryCode=request.getParameter("QRYCODE")==null?"0":(String) request.getParameter("QRYCODE"); 
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");


String vUsrnm= (String) session.getAttribute("suser_detail");

String vfldQryDesc="";
String vCurStatus="";
txtSearch=" ";

txtSearch=" and upper(zm.zone_nm) like upper('"+vZoneCD+"') and upper(ms.state_nm) like upper('"+vStateCd+"') and mom.AGENCY_TYPE like '"+vAgency+"' and upper( md.district_name) like upper('"+vDist+"')  and upper(ms.state_nm) like upper('"+sStatecd+"')";
 
 if (vQryCode.equals("1")){

 txtSearch = txtSearch ;
} else if (vQryCode.equals("2")){
 txtSearch = txtSearch + " and pa.final_sub_dt is not null " ;

}
else if (vQryCode.equals("3")){
 txtSearch = txtSearch + " and  pa.dco_approv_date is not null and and pa.final_sub_dt is not null " ;

}

else if (vQryCode.equals("4")){
 txtSearch = txtSearch + "  and pa.dco_approv_yn='Y' " ;

}

else if (vQryCode.equals("5")){
 txtSearch = txtSearch + " and pa.dco_approv_yn='N'   " ;

}

else if (vQryCode.equals("6")){
 txtSearch = txtSearch + " and pa.dco_approv_yn='Y' AND pa.app_approv_yn ='Y'   " ;

}

out.print(txtSearch);

String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmr/jasper/";
	
	
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