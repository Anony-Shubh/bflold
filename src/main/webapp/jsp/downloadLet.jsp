 <%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,java.net.URL"  %>  
 <%


 String Path=session.getAttribute("AGENCY_UPLOAD")==null?"":(String) session.getAttribute("AGENCY_UPLOAD");
String media_url =session.getAttribute("media_url")==null?"":(String) session.getAttribute("media_url");

	




           
          

 // response.setContentType("image/jpeg");
			//response.setContentType("application/octet-stream");
           // response.setHeader("Content-Disposition", "attachment; filename="+media_url);
 
  response.setContentType("APPLICATION/OCTET-STREAM");   
  //response.setHeader("Content-Disposition","attachment; filename=\"" + media_url + "\"");   
  response.setHeader("Content-Disposition", "attachment; filename="+media_url);
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(Path);  
            
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    out.write(i);   
  }   
  fileInputStream.close();   
			
			
%>