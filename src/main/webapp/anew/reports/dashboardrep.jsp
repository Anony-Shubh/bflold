<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	String vFname=request.getParameter("REP_NM")==null?"awarness":request.getParameter("REP_NM");
	String STATE_CD=request.getParameter("STATE_CD")==null?"":request.getParameter("STATE_CD");
	String STATE_NM=request.getParameter("STATE_NM")==null?"":request.getParameter("STATE_NM");
	
	String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":request.getParameter("DISTRICT_CD");
	String DISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"":request.getParameter("DISTRICT_NAME");
	
	String FROMDT=request.getParameter("FROMDT")==null?"":request.getParameter("FROMDT");
	String TODT=request.getParameter("TODT")==null?"":request.getParameter("TODT");
	
	String REPTYPE=request.getParameter("REPTYPE")==null?"":request.getParameter("REPTYPE");
	
	String TYPE=request.getParameter("TYPE")==null?"":request.getParameter("TYPE");
	
	String vwhercls ="";
	String vtitle = "";
	String vwherclspara = "";
	String vwherclsparatitle = "";
	
	String vwherclsdatetitle = "";
	String vwherclsdateqry = "";
	
	
	
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
}

	
	String vGenID="100";
	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"a/reports/";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =folderpath+"/jaspdf/"+vFname+vGenID+".pdf"; 
	//String outFileName =folderpath+"\\jaspdf\\"+vFname+vGenID+".pdf"; 
	String fname=vFname+vGenID+".pdf";
	
   	Context ctx=new InitialContext();
	Context envCtx = (Context) ctx.lookup("java:comp/env");
 	DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 	conn=ds.getConnection(); 
	   HashMap hm = new HashMap(); 
		
	//if (vFname.equals("dashboardreport")){ 
		  // hm.put("YEAR_ID",YEAR_ID);
		// }
		if(vFname.equals("dashboardreportdistrict")){
		//	 hm.put("wrcls",vcls);
			  hm.put("STATE_CD",STATE_CD);
			  hm.put("STATE_NM",STATE_NM);
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
			 
			 
			 if(vFname.equals("dashboardreportstate")){
		//	 hm.put("wrcls",vcls);
			  //hm.put("STATE_NM",STATE_NM);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
		    
			 
			  if(vFname.equals("detailed")){
			  hm.put("vwhercls",vwhercls);
			  hm.put("vtitle",vtitle);
			  hm.put("vwherclspara",vwherclspara);
			  hm.put("vwherclsparatitle",vwherclsparatitle);
			  hm.put("FROMDT",FROMDT);
			  hm.put("TODT",TODT);
			 }
			 
		
			 
			
		   
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
		 
			 JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
    //      response.sendRedirect("..\\reports\\jaspdf\\"+fname);
 	response.sendRedirect("../reports/jaspdf/"+fname);
				conn.close();
			
	//localhost/pmegpeportal/bnf/jasperReports/bnfreport.jsp?REP_NM=bnfconsolidatetarget&BGTID=4
	//localhost/pmegpeportal/bnf/jasperReports/jaspdf/bnfconsolidatetarget100.pdf	 
			
%>



