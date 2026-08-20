<%@ page  import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ page import="net.sf.jasperreports.engine.export.*"%>
<%@ page  import="java.io.*"%> 
<%@ page import="java.util.*"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="javax.naming.*"%>
<%@ page import ="javax.sql.*"%>
<%@ page  import="java.util.HashMap"%>
<%@ page  import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PRODUCTION/MARGIN_MONEY TARGET FOR THE TEAR 2016-17</title>
    </head>
    <body>
       
        <%
 String vFname="PMEGP_MMTARGET_ONLINE";
 Context ctx=new InitialContext();
 Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds = (DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 Connection  conn=ds.getConnection();
 //String parameters=null;
 ServletContext context=request.getServletContext();
String folderpath= context.getRealPath("")+"jasperrop/";
String fileName = folderpath+vFname+".jasper"; 
 //File reportFile = new File(application.getRealPath("E:\\tomcat5\\webapps\\pmegpeportal\\jasperrop\\PMEGP_MMTARGET_ONLINE.jasper"));
          Map parameters = new HashMap();
			parameters.put("OFF_NM", "-");
            byte[] bytes = JasperRunManager.runReportToPdf(fileName, parameters,conn);
 
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
			conn.close();
			
			
        %>
    </body>
</html>