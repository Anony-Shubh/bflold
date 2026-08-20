<%@ page  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.*"  %>

<html>
<head>
    <%
	
	//* paybill parameters.......................//
	
	String vFname=request.getParameter("RNAME")==null?"DLTFC_Proposal":(String) request.getParameter("RNAME");
	String vMTGID= request.getParameter("MTG_ID")==null?"0":(String) request.getParameter("MTG_ID");
	String vOffcd=session.getAttribute("off_cd")==null?"0":(String) session.getAttribute("off_cd");
	Connection conn=null;
	String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName ="/opt/tomcat5/webapps/pmegpeportal/jasperrop/jaspdf/"+vMTGID+".pdf"; 
	//************************************************
	// DELETING PDF EXISTING FILE FROM THE FOLDER JASPDF........
	try{
	String[] dir = new java.io.File(folderpath+"jaspdf/"+".").list(); // Get list of names
    java.util.Arrays.sort(dir); // Sort it (Data Structuring chapter))
	int i=0;
   while (i < dir.length){
     out.print(dir[i]); // Print the list
	 File f=new File(folderpath+"jaspdf/"+dir[i]);
    f.delete(); 
     i++;
	 }//while loop
	}catch(Exception e){
	//out.print(e.toString());
	}
	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
          HashMap hm = new HashMap(); 
		 hm.put("PMTGID",new BigDecimal(vMTGID));
		  hm.put("POFF_CD",new BigDecimal(vOffcd));
            JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
            JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
			response.sendRedirect("../jasperrop/jaspdf/"+vMTGID+".pdf");
			conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){}
 }

%>
  
