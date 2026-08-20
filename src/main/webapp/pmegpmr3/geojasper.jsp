<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter"  %>
     
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
 String vFname=request.getParameter("REPNM")==null?"GeoAppreport":(String)request.getParameter("REPNM");
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

 if (vQryCode.equals("16"))
   {
	vFname="GeoAppreportPEN";  
   }
   else if (vQryCode.equals("17"))
   {
	vFname="GeoAppreportREF";  
   }
   else {
	   vFname="GeoAppreport";
   }

String vUsrnm= (String) session.getAttribute("suser_detail");

String vfldQryDesc="";
String vCurStatus="";
txtSearch=" ";

txtSearch=" and upper(A.zone_nm) like upper('"+vZoneCD+"') and upper(A.state_nm) like upper('"+vStateCd+"') and A.AGENCY_TYPE like '"+vAgency+"' and upper(A.UNIT_DIST) like upper('"+vDist+"')  and upper(A.state_nm) like upper('"+sStatecd+"') AND (A.MM_RELDT) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  ";
 
 if (vQryCode.equals("1")){

 txtSearch = txtSearch ;
} else if (vQryCode.equals("2")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND UPPER(VERIFICATION_STATUS)='WORKING' " ;

}
else if (vQryCode.equals("3")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND UPPER(VERIFICATION_STATUS)='DEFUNCT' " ;

}

else if (vQryCode.equals("4")){
 txtSearch = txtSearch + "  and A.pmegpgeotagid IS NOT NULL AND UPPER(VERIFICATION_STATUS)='NON-TRACEABLE' " ;

}

else if (vQryCode.equals("5")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL  " ;

}

else if (vQryCode.equals("6")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS not NULL   " ;

}

else if (vQryCode.equals("7")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS  NULL     " ;

}
else if (vQryCode.equals("8")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS NOT  NULL AND A.ACT_ID=1   " ;

}

else if (vQryCode.equals("9")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND MM_ADJUSTMENT_STATUS IS NOT  NULL AND NVL(A.ACT_ID,0) IN (0,2) " ;

}
else if (vQryCode.equals("10")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND A.ACT_ID=1 AND A.MM_ADJUSTMENT_STATUS IS NOT NULL    " ;

}

else if (vQryCode.equals("11")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND A.ACT_ID=1 AND A.MM_ADJUSTMENT_STATUS IS NOT NULL AND A.AGENCY_UPLOAD IS NOT NULL " ;

}

else if (vQryCode.equals("12")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND A.ACT_ID=1 AND  A.MM_ADJUSTMENT_STATUS IS NOT NULL " ;

}
else if (vQryCode.equals("13")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND A.ACT_ID=1 AND A.AGENCY_UPLOAD IS NOT NULL AND NVL(A.AGN_CALLBACK, 0) > 0 " ;

}
else if (vQryCode.equals("14")){
 txtSearch = txtSearch + " and A.pmegpgeotagid IS NOT NULL AND A.ACT_ID=1 AND  A.MM_ADJUSTMENTSTATUS='RU' " ;

}

else if (vQryCode.equals("15")){
 txtSearch = txtSearch + " and B.status='success' and B.PRODUCTINFO='Margin Money Callback' " ;

}
else if (vQryCode.equals("16")){
 txtSearch = txtSearch + "  AND A.ACT_ID=1 AND A.AGENCY_UPLOAD IS NOT NULL AND NVL(A.AGN_CALLBACK, 0) > 0 "; 

}

else if (vQryCode.equals("17")){
 txtSearch = txtSearch ; 

}
//out.print(txtSearch);

String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmr3/jasper/";
	
	//opt/tomcat5/webapps/pmegpeportal/jasperrop/
	//String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xlsx";
	//String outFileName =folderpath+"jaspdf/"+edp+rnd+".pdf"; 
	
	String outFileName =folderpath+"jaspxls/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
	   
			 hm.put("vcls",txtSearch);
			 
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