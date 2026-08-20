<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<html>
<head>
	
</head>
</head>
    <%
  String vTodt=request.getParameter("TODT");
		   String vFrdt=(String)request.getParameter("FROMDT");
		    String vBrnm=(String)request.getParameter("BRNAME");
			 String vqcode=(String)request.getParameter("QCODE");
			 String vHirone=request.getParameter("HIRONE")==null||request.getParameter("HIRONE")==""?"%%":(String)request.getParameter("HIRONE");
			  //out.print (vHirone);
			  String vHirtwo=request.getParameter("HIRTWO")==null||request.getParameter("HIRTWO")==""?"%%":(String) request.getParameter("HIRTWO");
			 String vwherecls="";
			 String flag=request.getParameter("flag")==null?"N":(String) request.getParameter("flag");
%>
    <input name="TODT" type="text" id="TODT" value="<%= vTodt %>" />
               <input type="text" name="FROMDT" id="FROMDT" value="<%= vFrdt %>"/>
               <input type="text" name="BRNAME" id="BRNAME" value="<%= vBrnm %>"/>
               <input type="text" name="QCODE" id="QCODE" value="<%= vqcode %>"/>
			    <input type="text" name="HIRONE" id="HIRONE" value="<%= vHirone %>"/>
				 <input type="text" name="HIRTWO" id="HIRTWO" value="<%= vHirtwo %>"/>
			  
           <%	
		   String myrul="";
		   String vFname="BDataToxlsBankSec";
String vGenID="SBIN";
Connection conn=null;
ServletContext context=request.getServletContext();
String folderpath= context.getRealPath("")+"bankpmegpmr/jasper/";

	//String folderpath="E:\\Tomcat5\\webapps\\pmegpeportal\\bankpmegpmr\\jasper\\";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	
	String fnm=vFname+t.nextInt(1000000)+".xls";
	out.print (fnm);
	String outFileName =folderpath+"/jaspxls/"+fnm; 
	//String outFileName =folderpath+"\\jaspxls\\"+fnm; 
	String fname=vFname+vGenID+".pdf";	 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
        HashMap hm = new HashMap();
		hm.put("PFROMDT",new Date(vFrdt));
		  hm.put("PSPONS_BANKNM",vBrnm);
		  hm.put("PTODT",new Date(vTodt));
		  
		  
			if (vqcode.equals("0")){
			vwherecls=" and  b.act_id=5 AND b.ACT_YN='Y' ";
			}else if (vqcode.equals("1")){
			vwherecls=" and  a.act_id>=11 ";
			}else if (vqcode.equals("2")){
			vwherecls=" and a.MM_CLAIM_DT  IS NOT NULL and a.MM_CLAIM_AMT   > 0 and  a.LOAN_DOCFNAME IS NOT NULL ";
			}else if (vqcode.equals("3")){
			vwherecls=" and a.pact_id=34 ";
			}else if (vqcode.equals("10")){
			vwherecls=" and a.act_id=11 AND a.PACT_ID = 34 AND a.APPRV_YN = 'A'  AND  a.TDR_ADJ_DT IS NOT NULL ";
			}else if (vqcode.equals("4")){
			vwherecls=" and a.act_id=3  ";
			}else if (vqcode.equals("5")){
			vwherecls=" and (a.act_id is NULL or a.act_id=8) and b.act_yn='Y' ";
			}else if (vqcode.equals("6")){
			vwherecls=" and a.MM_CLAIM_DT  IS NOT NULL and a.MM_CLAIM_AMT   > 0 and  a.LOAN_DOCFNAME IS NOT NULL and a.pact_id <>34  ";
			}else{
			vwherecls="";
			}
			
			if (!(vHirone.equals("%%")||vHirone.equals("")||vHirone.equals(null))){
			vwherecls = vwherecls +  " AND  UPPER(BM.HIRONE) LIKE UPPER('"+vHirone+"') ";
			}
			
			if (!(vHirtwo.equals("%%")||vHirtwo.equals("")||vHirtwo.equals(null))){
			vwherecls = vwherecls +  " AND  UPPER(BM.HIRTWO) LIKE UPPER('"+vHirtwo+"') ";
			}
			out.print (vwherecls);
					//out.print (vwherecls);
			 hm.put("PWHERECLS",vwherecls);
		  
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
 myrul="jasper/jaspxls/"+fnm;
 flag="Y";

			conn.close();
    response.sendRedirect(myrul);
				}catch (Exception e){
				out.print (e.toString());
				
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}
				}
				
%>
           <a href="<%= myrul %>">download in excel file </a>
		    </form>
    </html>
</body>
</html>