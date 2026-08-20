<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>

<html>
<head>
<SCRIPT TYPE="text/javascript" LANGUAGE="javascript">

<!-- PreLoad Wait - Script -->
<!-- This script and more from http://www.rainbow.arch.scriptmania.com 

function waitPreloadPage() { //DOM
if (document.getElementById){
document.getElementById('prepage').style.visibility='hidden';
}else{
if (document.layers){ //NS4
document.prepage.visibility = 'hidden';
}
else { //IE4
document.all.prepage.style.visibility = 'hidden';
}
}
}
// End -->
</SCRIPT>

</head>

<BODY onLoad="waitPreloadPage();">
<DIV id="prepage" style="position:absolute; font-family:arial; font-size:16; left:0px; top:0px; background-color:white; layer-background-color:white; height:100%; width:100%;"> 
<TABLE width=100%><TR><TD>
  <div align="center">
    <input name="imageField" type="image" src="img/loading.gif" width="100" height="100" border="0">
  </div>
  <p align="center">&nbsp;</p>
  <p align="center"><B>Loading ... ... Please wait!</B></p></TD></TR></TABLE>
</DIV>

<div id="printme">


<%
String vFname="BDataToxlsBank";
String vGenID="SBIN";

Connection conn=null;
//E:\tomcat5\webapps\pmegp\bankpmegpmr\jasper
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
		
		
		  //hm.put("POFFCD",voffcd);
		 
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
		  
		  %>
		<a href="jasper/jaspxls/<%=fnm  %>" target="_parent">please download this page</a>
		<%
			conn.close();
         response.sendRedirect("jasper/jaspxls/"+fnm);
				
				
				}catch (Exception e){
				out.print (e.toString());
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){}
				}

%>
</div>
</body>
</html>

