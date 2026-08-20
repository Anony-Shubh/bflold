<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal,pkgPmegpNew.DBCon"  %>
     
	       <%	
		DBCon db= new DBCon();
db.connect();
		   String myrul="";
		   String vwherecls="";
		   
String vFname=request.getParameter("REP_NM")==null?"":request.getParameter("REP_NM");
	String STATE_CD=request.getParameter("STATE_CD")==null?"":request.getParameter("STATE_CD");
	String STATE_NM=request.getParameter("STATE_NM")==null?"":request.getParameter("STATE_NM");
	String QRYCODE=request.getParameter("QRYCODE")==null?"":request.getParameter("QRYCODE");
	String YEAR_ID=request.getParameter("YEAR_ID")==null?"":request.getParameter("YEAR_ID");
	
	String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":request.getParameter("DISTRICT_CD");
	String DISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"":request.getParameter("DISTRICT_NAME");
	
	String AGENTYPE=request.getParameter("AGENTYPE")==null?"":request.getParameter("AGENTYPE");
	
	String REPTYPE=request.getParameter("REPTYPE")==null?"":request.getParameter("REPTYPE");
	
	String TYPE=request.getParameter("TYPE")==null?"":request.getParameter("TYPE");
	
	String FROMDT=request.getParameter("FROMDT")==null?"":request.getParameter("FROMDT");
	String TODT=request.getParameter("TODT")==null?"":request.getParameter("TODT");
	
	String vGenID="100";
	String vcls="";
	
		String vwhercls ="";
	String vtitle = "";
	String vwherclspara = "";
	String vwherclsparatitle = "";
	
	String vwherclsdatetitle = "";
	String vwherclsdateqry = "";
	
	String wheragen = "";
	
	
	if(AGENTYPE.equals("")){
	wheragen="";
	}else {
	wheragen=" AND MOM.AGENCY_TYPE='"+AGENTYPE+"'   ";
	}
	

	if(TYPE.equals("A")){
	vwherclspara="";
	vwherclsparatitle="INDIA";
	}else if(TYPE.equals("S")){
	vwherclspara="  AND MS.STATE_CD='"+STATE_CD+"'";
	vwherclsparatitle=""+STATE_NM+"";
	}else if(TYPE.equals("D")){
	vwherclspara="  AND MD.DISTRICT_CD='"+DISTRICT_CD+"'";
	vwherclsparatitle=""+DISTRICT_NAME+","+STATE_NM+"";
	}
	
if(REPTYPE.equals("1")){
vwhercls=" AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Total No. of Applications)" ;
}else if(REPTYPE.equals("2")){
vwhercls=  "  AND AD.ACT_ID IN (3,7) AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Returned by Agency)" ;
}else if(REPTYPE.equals("3")){
vwhercls=  "  AND AD.ACT_ID =5 AND TRUNC(BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Forwaded to Bank)" ;
}else if(REPTYPE.equals("4")){
vwhercls=  "  AND AD.ACT_ID  NOT IN (3,7,5) AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Pending at Agency)" ;
}else if(REPTYPE.equals("5")){
vwhercls=  "  AND BD.ACT_ID=11 AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";   
vtitle="(Loan Sanctioned)" ;
}else if(REPTYPE.equals("6")){
vwhercls=  "  AND BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Claim by Bank (in No.))" ;
}else if(REPTYPE.equals("7")){
vwhercls=  "  AND BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Claim by Bank (MM. in Cr.))" ;
}else if(REPTYPE.equals("8")){
vwhercls=  "  AND BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(MM Released (in No.))" ;
}else if(REPTYPE.equals("9")){
vwhercls=  "  AND BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(MM Released (Amt. in Cr.))" ;
}else if(REPTYPE.equals("10")){
vwhercls=  "  AND AD.ACT_ID =5 AND NVL(BD.ACT_ID,0) IN (0,8) AND TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Pending for decision by Bank)" ;
}else if(REPTYPE.equals("11")){
vwhercls=  "  AND AD.ACT_ID =5 AND BD.ACT_ID=3 AND TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Rejected by Bank)" ;
}else if(REPTYPE.equals("12")){
vwhercls=  "  AND TRUNC(BD.IST_LOAN_DT)  BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";  
vtitle="(Rejected by Bank)" ;
}

	
String flag="Y";
Connection conn=null;
ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"mdashboard/reports/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String fnm=vFname+".xls";
	
	String outFileName =folderpath+"/jasper/jasperxls/"+fnm; 
	//out.print(outFileName);

	try {
	
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();

			 if(vFname.equals("dashboardreportdistrict")){

			  hm.put("STATE_CD",STATE_CD);
			  hm.put("STATE_NM",STATE_NM);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
			 if(vFname.equals("dashboardreportstate")){
		//	 hm.put("wrcls",vcls);
			  //hm.put("STATE_NM",STATE_NM);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
			 if(vFname.equals("dashboardreport")){
		//	 hm.put("wrcls",vcls);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
			  if(vFname.equals("bankwisestate")){
		//	 hm.put("wrcls",vcls);
			  hm.put("STATE_CD",STATE_CD);
			  hm.put("STATE_NM",STATE_NM);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
			 if(vFname.equals("bankwise")){
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
			  if(vFname.equals("bankwisedistrict")){
		//	 hm.put("wrcls",vcls);
			  hm.put("STATE_NM",STATE_NM);
			  hm.put("DISTRICT_CD",DISTRICT_CD);
			  hm.put("DISTRICT_NAME",DISTRICT_NAME);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
			 if(vFname.equals("detailed")){
			  hm.put("vwhercls",vwhercls);
			  hm.put("vtitle",vtitle);
			  hm.put("vwherclspara",vwherclspara);
			  hm.put("vwherclsparatitle",vwherclsparatitle);
			  hm.put("wheragen",wheragen);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);    
			 }
			 
		//	 out.print(vcls);
	
			//SALES_ALLMAINGROUPWISE_PRODUCT_EX
			//SALES_ALLMAINGROUPWISE_PRODUCT_EX
			 //out.print(GSTR1_EXCEL_REP_HO_RTSALES);
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
%>
          