<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>

<%@ page import="pkgPmegpNew.DBCon"%>



<%
String vAppid=  session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");

DBCon db= new DBCon();

db.connect(); 



String AGENCY_UPLOAD="";
String media_url="";


       
 ResultSet rsMANU= db.execSQL("SELECT  max(media_url) as media_url, max(media_type) media_type from geotag_attch BD where  attachment_name='BankDocument' and media_url like'Bank%' AND  BD.APP_ID='"+vAppid+"' ");
		   while (rsMANU.next()) {  //3
           AGENCY_UPLOAD=rsMANU.getString("media_type")==null?"":rsMANU.getString("media_type");
		   media_url=rsMANU.getString("media_url")==null?"":rsMANU.getString("media_url");
           } //3  
		   rsMANU.close();
		  
	    out.print(AGENCY_UPLOAD);
	 
	  if (!AGENCY_UPLOAD.equals("")){
	   response.sendRedirect ("http://www.kviconline.net.in/pmegpgeoapi/api/GTDocumentsgovBank.jsp?APP_ID="+vAppid);
	    
	  } else {
		   response.sendRedirect ("AgnmsgGeo.jsp");
		  
	  }

	 %> 
	 


<HTML>Save me!</HTML>



	   
	   
	   
	   