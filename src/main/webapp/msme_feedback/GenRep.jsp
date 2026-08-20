<html>
<title>::PMEGP ::REPORT</title>
<head>
<%@ page  import="java.io.*"%> 
<%@ page  import="java.sql.Connection"%> 
<%@ page  import="java.sql.DriverManager"%>
<%@ page  import="java.util.HashMap"%>
<%@ page  import="java.util.Map,java.math.*"%>
<%@ page  import="net.sf.jasperreports.engine.*"%>
<%@ page  import="org.krysalis.barcode4j.*"%>
<%@ page  import="java.io.PrintStream"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
        <%
			String vAPP_ID=request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
		
		String vrepname="PMEGP_FEEDBCK";//request.getParameter("REPNAME")==null?"":(String) request.getParameter("REPNAME");
	String VWHRCLS="";

if( !( vAPP_ID.equals("") || vAPP_ID.equals("0") )){

VWHRCLS="and ad.app_id='"+vAPP_ID+"'";

}


		try {
		String filepath=application.getRealPath("/msme_feedback/"+vrepname+".jasper");
            Connection conn = null;
            try {
                Class.forName("oracle.jdbc.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "PMEGPNEW", "PMEGP123");
            } catch (Exception ex) {
               out.print (ex.toString());//  CERTIFICATE_FORMAT
            }
            File reportFile = new File(filepath);//your report_name.jasper file
		
            Map hm = new HashMap();
			if(vrepname.equals("PMEGP_FEEDBCK"))
			{
			hm.put("PWHRCLS",  VWHRCLS);			
			}
			

			
			
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), hm, conn);
            conn.close();
           response.setContentType("application/pdf");
           response.setContentLength(bytes.length);
           ServletOutputStream outStream = response.getOutputStream();
           outStream.write(bytes, 0, bytes.length);
           outStream.flush();
           outStream.close();
		   }catch (Exception e) {out.print(e.toString());}
		   
        %>
