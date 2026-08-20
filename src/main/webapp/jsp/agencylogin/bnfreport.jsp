<%@ page session="true"  import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
<% 
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");

	String vtype="pdf";
	  String vooff_cd=session.getAttribute("off_cd")==null?"0":(String) session.getAttribute("off_cd");// (String) session.getAttribute("off_cd");
    String vBankName=request.getParameter("BANKNAME")==null?"":(String) request.getParameter("BANKNAME"); 

	String vFname=request.getParameter("REPNM")==null?"":request.getParameter("REPNM");
	String vOFF_CD=request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD");
	String vQryCode=request.getParameter("QRYCODE")==null?"":request.getParameter("QRYCODE");
	String vGenID="100";
	String vcls="";
	
	 
 if (vQryCode.equals("0")){
 //ALL APPLICATION
 txtSearch = txtSearch + " and TRUNC(ad.online_subdt) between '"+FromDt+"' and  '"+ToDt+"' " ;
} else if (vQryCode.equals("1")){
// UNDER PROCESS AT AGENCY
  txtSearch = txtSearch + " and ad.act_id=1 " ;
  // PLACED BEFORE DLTFC COMMITTEE
  }else if (vQryCode.equals("2")){
  txtSearch = txtSearch + " and TRUNC(ad.FORD_DT_DLTFC) BETWEEN '"+FromDt+"' and '"+ToDt+"' ";
 }else if (vQryCode.equals("3")){
 // REJECTED BY DLTFC COMMITTEE
  txtSearch = txtSearch + " and TRUNC(AMM.MT_DATE)  BETWEEN '"+FromDt+"' and '"+ToDt+"' and ad.act_id=7 ";
 }else if (vQryCode.equals("4")){
 // Sanctioned by DLTFC COMMITTEE
  txtSearch = txtSearch + " and TRUNC(AMM.MT_DATE)  BETWEEN '"+FromDt+"' and '"+ToDt+"' and ( ad.act_id<>7 AND AD.ACT_ID>=4) ";
 
  }else if (vQryCode.equals("5")){
 // Forwarded to Bank
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=5 ";
  }else if (vQryCode.equals("6")){
 // Sanctioned by Bank
  txtSearch = txtSearch + " and bd.LOAN_SANC_DT BETWEEN '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 ";
}else if (vQryCode.equals("7")){
 // Rejected by Bank
  txtSearch = txtSearch + " and  bd.act_id=3 AND TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"'  ";
 }else if (vQryCode.equals("8")){
 // Own Contribution Deposited
  txtSearch = txtSearch + " and   TRUNC(bd.OWN_CONT_DT) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("9")){
 //  LOAN RELEASED
  txtSearch = txtSearch + " and TRUNC(bd.ist_loan_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
  }else if (vQryCode.equals("10")){
 // EDP TRANING COMPLETED
  txtSearch = txtSearch + " and TRUNC (bd.EDP_CERT_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  bd.EDP_CERT_DT IS NOT NULL AND bd.act_id=11 ";
 }else if (vQryCode.equals("11")){
 // MM CLAIMED
  txtSearch = txtSearch + " and bd.MM_CLAIM_AMT>0 AND BD.LOAN_DOCFNAME IS NOT NULL  AND TRUNC(bd.MM_CLAIM_DT) BETWEEN  '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("12")){
 // MM RELEASED
  txtSearch = txtSearch + " and TRUNC(bd.mm_rel_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A' ";
 }else if (vQryCode.equals("13")){
 // Physical Vefification completed
  txtSearch = txtSearch + " and bd.pv_dt between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("14")){
 // MM final adjustment
  txtSearch = txtSearch + " and  TRUNC(bd.mm_adj_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11  ";
 }else if (vQryCode.equals("15")){
 // Pending for Bank Sanction
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=8  ";
 }else if (vQryCode.equals("16")){
 // Pending for MM Release
  txtSearch = txtSearch + " and TRUNC(bd.mm_claim_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.mm_rel_dt is null and bd.act_id=11  ";
 }else if (vQryCode.equals("20")){
 // Pending for MM Release
  txtSearch = txtSearch + " and TRUNC(ad.online_subdt)  between '"+FromDt+"' and '"+ToDt+"' and ad.act_id=3  ";
   }else if (vQryCode.equals("35")){
 // Pending EDP TRANING
  txtSearch = txtSearch + "  AND TRUNC(bd.LOAN_SANC_DT)  BETWEEN '"+FromDt+"' and '"+ToDt+"'and  bd.edp_cert_dt IS NULL and bd.act_id=11   ";

 }else if (vQryCode.equals("38")){
 // Pending BANK SANCTION
  txtSearch = txtSearch + " and TRUNC(ad.bank_f_date)  between '"+FromDt+"' and '"+ToDt+"' and  nvl(bd.ACT_ID,0)  in (0,8) and ad.act_id=5  AND AD.ACT_YN='Y' ";

 }else if (vQryCode.equals("40")){
 // CLAIMS REFERRED TO FIELD OFFICES
  txtSearch = txtSearch + " and TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  BD.PACT_ID=30 AND ad.act_id=5   ";
 }
else if (vQryCode.equals("45")){
 // CLAIMS REFERRED TO FIELD OFFICES
  txtSearch = txtSearch + " and TRUNC(bd.MM_CLAIM_DT) BETWEEN '"+FromDt+"' and '"+ToDt+"' and  BD.PACT_ID=34 AND ad.act_id=5 and BD.APPRV_YN='A' AND BD.PAY_STATUS LIKE 'F%'   ";

 }
else if (vQryCode.equals("27")){
 // TDR UPDATED
  txtSearch = txtSearch + " and TRUNC(bd.mm_rel_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 AND bd.PACT_ID = 34 AND bd.APPRV_YN = 'A'  AND  bd.TDR_ADJ_DT IS NOT NULL ";
 }
 else if (vQryCode.equals("24")){
 // TDR NOT UPDATED
  txtSearch = txtSearch + " and TRUNC(bd.mm_rel_dt) between '"+FromDt+"' and '"+ToDt+"' and bd.act_id=11 AND bd.PACT_ID = 34 AND bd.APPRV_YN = 'A' AND  bd.TDR_ADJ_DT IS NULL  ";
 }
 


	Connection conn=null;
	ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"jasperrop/";
	//String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	String outFileName =folderpath+"/jaspdf/"+vFname+vGenID+".pdf"; 
	String fname=vFname+vGenID+".pdf";
	
   	Context ctx=new InitialContext();
	Context envCtx = (Context) ctx.lookup("java:comp/env");
 	DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 	conn=ds.getConnection(); 
    HashMap hm = new HashMap(); 
		 if (!vFname.equals("Agency_dwstatewise")){
	       hm.put("vBankName",PBANK_NAME);
		   hm.put("vooff_cd",POFF_CD);
		     hm.put("txtSearch",PTXTSEARCH);
		 }
		 else if  (vFname.equals("MPR_BFL")){
			 hm.put("wrcls",vcls);
		 }
		 //PBANK_NAME
		 //POFF_CD
		 //PTXTSEARCH
		 
		
          JasperPrint print = JasperFillManager.fillReport(fileName, hm,conn); 
			 JRExporter exporter = new JRPdfExporter(); 
           exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, outFileName); 
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, print); 
            exporter.exportReport(); 
     response.sendRedirect("../jasperrop/jaspdf/"+fname);
				conn.close();
			
	//localhost/pmegpeportal/bnf/jasperReports/bnfreport.jsp?REP_NM=bnfconsolidatetarget&BGTID=4
	//localhost/pmegpeportal/bnf/jasperReports/jaspdf/bnfconsolidatetarget100.pdf	 
			
%>


