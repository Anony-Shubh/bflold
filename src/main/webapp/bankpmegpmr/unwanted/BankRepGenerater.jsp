<%@ page session="true"  autoFlush="false" buffer="1094kb" import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<%@ taglib uri="taglib144.tld" prefix="w" %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/indexr.css">

<style type="text/css" media="screen"><!--
.centered {
  position: fixed;
  top: 50%;
  left: 50%;
  margin-top: -30px;
  margin-left: -80px;
}

--></style>
</head>
</head>

<form id="form1">
<w:wait>
<w:infoPage>
    <div id="content">
	
	
	<table  align="center" cellpadding="10" cellspacing="10" class="centered">
  <tr>
    <th>PMEGP e-Tracking Report Generation </th>
  </tr>
  <tr>
    <td><div align="center">
      <input type="image" src="img/loading.gif" width="100" height="100" />
    </div></td>
  </tr>
  <tr>
    <th> Page is being loaded, Please wait</th>
  </tr>
</table>
</div>

</w:infoPage>
<w:realPage>

    <%
  String vTodt=request.getParameter("TODT");
		   String vFrdt=request.getParameter("FROMDT");
		    String vBrnm=request.getParameter("BRNAME");
			 String vqcode=request.getParameter("QCODE");
			 String flag=request.getParameter("flag")==null?"N":(String) request.getParameter("flag");
%>
    <input type="text" name="TODT" id="TODT" value="<%= vTodt %>" />
               <input type="text" name="FROMDT" id="FROMDT" value="<%= vFrdt %>"/>
               <input type="text" name="BRNAME" id="BRNAME" value="<%= vBrnm %>"/>
               <input type="text" name="QCODE" id="QCODE" value="<%= vqcode %>"/>
			   <input name="flag" type="text" id="flag" value="Y"/>
           <%	
		//if (flag.equals("Y")) {  
		   String vFname="BDataToxlsBank";
String vGenID="SBIN";
Connection conn=null;
	String folderpath="E:\\Tomcat5\\webapps\\pmegp\\bankpmegpmr\\jasper\\";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	//vGenID=t;
	String fnm=vFname+t+".xls";
	String outFileName =folderpath+"\\jaspxls\\"+fnm; 
	String fname=vFname+vGenID+".pdf";	 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDS");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap(); 
		    JRExporter  exporter = new JRXlsExporter(); 
          JasperPrint jasperPrint = JasperFillManager.fillReport(fileName, hm,conn); 
		  
			JRXlsExporter exporterXLS = new JRXlsExporter();
 exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
 exporterXLS.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,outFileName);
 exporterXLS.exportReport();
 String myrul="jasper//jaspxls//"+fnm;
 flag="Y";
 %>
 <br>
           <a href="jasper/jaspxls/<%=fnm  %>" target="_parent" class="centered">clichre to download excel file</a> 
		<br>  
           <%

			conn.close();
     
				}catch (Exception e){
				out.print (e.toString());
				
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}
				}
//}//end of flag
%>
</w:realPage>
</w:wait> 
</form>
</html>
</body>
</html>