<%@ page  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*"  %>

<html>
<head>
    <%
	
	//* paybill parameters.......................//
	
	String vFname="MIS_CAT_REPORT_DB";
	String vWherecls= request.getParameter("WHERECLS")==null?" ":(String) request.getParameter("WHERECLS");
	String vAPPID="220";
	String vrepTitle="";
	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"jasperrop/";
	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =fileName+"/jaspdf/"+vAPPID+".html"; 
	
	try{
	String[] dir = new java.io.File(folderpath+"jaspdf/"+".").list(); // Get list of names
    java.util.Arrays.sort(dir); // Sort it (Data Structuring chapter))
	int i=0;
   while (i < dir.length){
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
		 hm.put("PWHERECLS",vWherecls);
		  
            JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
            JRExporter exporter = new JRHtmlExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
			String url="../jasperrop/jaspdf/"+vAPPID+".html";
			response.sendRedirect(url);
			conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}finally{ 
				
				try{
				conn.close();
				}catch (Exception h){
				out.print (h.toString());
				}
 }

%>
  
