<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*"%>
<%@ page import="globalp.*"%>
<%
String APP_ID= (String) session.getAttribute("sAPP_ID");
String fileExistinNas="Y";
String DOC_NAME=request.getParameter("docname")==null?"":(String) request.getParameter("docname");
String REDPATH="";

 DBCon db= new DBCon();
        db.connect();

        
           StringBuffer qry = new StringBuffer();

 qry.append(" SELECT  APP_ID,'scorecardupload'||'/'||substr(app_id,1,instr(app_id,'-')-1)||'/'||substr(app_id,instr(app_id,'-')+1,length(app_id))||'/'  as redpath "); 
 qry.append(" FROM EDP_CONDUCT_TRANS WHERE APP_ID='"+APP_ID+"' ");

ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		
		REDPATH=rsApp.getString("REDPATH")==null?"":rsApp.getString("REDPATH");
        }
			rsApp.close();
           db.close();
		
	out.print("../../pmegpeportalappdoc/"+REDPATH+DOC_NAME);	

response.sendRedirect("../../pmegpeportalappdoc/"+REDPATH+DOC_NAME);

%>

