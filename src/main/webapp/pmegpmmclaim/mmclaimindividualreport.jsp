<%@ page  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*"  %>

<html>
<head>
    <%
	
	//* paybill parameters.......................//
	
	String vFname=request.getParameter("RNAME")==null?"pmegpOnlineIndividualReport":(String) request.getParameter("RNAME");
	String vFRDT= request.getParameter("RFROMDT")==null?"":(String) request.getParameter("RFROMDT");
	String vTODT= request.getParameter("RTODATE")==null?"":(String) request.getParameter("RTODATE");
	
	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmmclaim/";
	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\pmegpmmclaim\\";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =folderpath+"jasperrop/jaspdf/"+vFname+".pdf"; 
	
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
		  hm.put("PFRDT",vFRDT);
		  hm.put("PTODT",vTODT);
		  
            JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
            JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
			response.sendRedirect("jasperrop/jaspdf/"+vFname+".pdf");
			conn.close();
				}catch (Exception e){
				
				out.print (e.toString());
				}finally{ 
				
				try{
				conn.close();
				}catch (Exception e){}
 }

%>
  
