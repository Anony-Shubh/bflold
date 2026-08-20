<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<html>
<head>
	<title>Generate Excel Report for Bank</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/msgwindow.js"></script>
<link rel="stylesheet" type="text/css" href="css/loadingbox.css">
<script type="text/javascript">

 function fillinboxnew(){
 var vfrdt=document.getElementsByName("FROMDT")[0].value;
var vtodt=document.getElementsByName("TODT")[0].value;
var vQcode=document.getElementsByName("QCODE")[0].value;
var vbrName=document.getElementsByName("BRNAME")[0].value;
var purl='BankRepGenerate.jsp?FROMDT='+vfrdt+'&TODT='+vtodt+'&QCODE='+vQcode+'&BRNAME='+vbrName+'&flag=Y';

//alert (purl);

     $.showprogress('PMEGP e-Tracking Monitoring Report','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post(purl,{action:'PMEGP Monitoring Report Loading...',page:'1'},
		 
        function(ret){
          //$("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
     // $.hideprogress();
	
}

jQuery(document).ready(function($) {
    jQuery('a.popup').live('click', function(){
        newwindow=window.open($(this).attr('href'),'','height=200,width=150');
        if (window.focus) {newwindow.focus()}
        return false;
    });
});
</script>
</head>
<body onLoad="fillinboxnew()">
<form name="form1" method="post">
  <p>
    <%
  String vTodt=request.getParameter("TODT");
		   String vFrdt=request.getParameter("FROMDT");
		    String vBrnm=request.getParameter("BRNAME");
			 String vqcode=request.getParameter("QCODE");
			 String flag=request.getParameter("flag")==null?"N":(String) request.getParameter("flag");
%>
    <input type="hidden" name="TODT" id="TODT" value="<%= vTodt %>" />
               <input type="hidden" name="FROMDT" id="FROMDT" value="<%= vFrdt %>"/>
               <input type="hidden" name="BRNAME" id="BRNAME" value="<%= vBrnm %>"/>
               <input type="hidden" name="QCODE" id="QCODE" value="<%= vqcode %>"/>
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
			 if (flag.equals("Y")) {

	
	try {
	response.setContentType("application/vnd.ms-excel");
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
response.sendRedirect("jasper/jaspxls/"+fnm);
			conn.close();
     
				}catch (Exception e){
				out.print (e.toString());
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){}
				}

%>
  <%}//end if flag if%>     
<div id="divResult" align="center" >
<%
 if (flag.equals("Y")) {
//response.sendRedirect("jasper/jaspxls/"+fnm);
}
%>
  </div>    
    
</form>  
</body>
</html>