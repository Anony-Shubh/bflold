<%@ page  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*"  %>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%!  
private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
public static String randomAlphaNumeric(int count) {
StringBuilder builder = new StringBuilder();
while (count-- != 0) {
int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
builder.append(ALPHA_NUMERIC_STRING.charAt(character));
}
return builder.toString();
}


%>
<html>
<head>
    <%
	
	//* paybill parameters.......................//
	
	String vFname=request.getParameter("RNAME")==null?"APPSTATUSVIEWD":(String) request.getParameter("RNAME");
	String vAPPID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
	String REDPATH= session.getAttribute("sREDPATH")==null?"":(String) session.getAttribute("sREDPATH");
	String DOC_NAME= session.getAttribute("sDOC_NAME")==null?"":(String) session.getAttribute("sDOC_NAME");
	out.print(REDPATH);
	out.print(DOC_NAME);
	Connection conn=null;
	
	String rnd=randomAlphaNumeric(10);
	String IMGPATH="pmegpeportalappdoc/"+REDPATH+"/"+DOC_NAME;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"edpoff/jasper/";

	
	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\";
	String fileName = folderpath+vFname+".jasper"; 
	//String outFileName ="E:\\Tomcat5\\webapps\\pmegpeportal\\jasperrop\\jaspdf\\"+vAPPID+rnd+".pdf"; 
	
	String outFileName =folderpath+"jaspdf/"+vFname+rnd+".pdf"; 
	
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
		 hm.put("PAPPID",vAPPID);
		 // hm.put("PDOCNM",IMGPATH);
		  
            JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
            JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
			response.sendRedirect("../edpoff/jasper/jaspdf/"+vFname+rnd+".pdf");
			
			conn.close();
				}catch (Exception e){
				
				out.print (e.toString());
				}finally{ 
				
				try{
				conn.close();
				}catch (Exception e){}
 }

%>
  
