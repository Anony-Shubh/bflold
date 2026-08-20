<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/pdfobject.js"></script>
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>

<script language="javascript">
function getmoviename(id){
 document.getElementById('my-container').innerHTML = '<img src=../images/'+id+'>';
}

</script>
</head>
<body>
<form>
  <p>
      <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		session.setAttribute("sAPP_ID",APP_ID);
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String APPRV_YN="";
		
		
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String LOAN_DOCFNAME="";
		
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,BD.APPRV_YN,");
		  qry.append(" UPPER(A.APP_NAME) AS APP_NAME, BD.LOAN_DOCFNAME, ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A ,BANK_DATAENTRY BD ");
			  qry.append(" WHERE A.APP_ID=BD.APP_ID AND A.APP_ID = '"+APP_ID+"' AND BD.MM_CLAIM_AMT> 0 AND BD.LOAN_DOCFNAME IS NOT NULL  ");
		 

        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		 LOAN_DOCFNAME=rsApp.getString("LOAN_DOCFNAME")==null?"":rsApp.getString("LOAN_DOCFNAME");
		 APPRV_YN=rsApp.getString("APPRV_YN")==null?"":rsApp.getString("APPRV_YN");
        }
			rsApp.close();
			StringBuffer qryUp = new StringBuffer();	
			
		qryUp.append("  SELECT AUT.UP_ID,");
		qryUp.append("   AUT.DOC_NAME,");
		 qryUp.append("   NVL(AUT.DOC_REMARKS,'-') AS DOC_REMARKS,");
		qryUp.append("   TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT,");
		qryUp.append("  AUM.DOC_DESC");
		qryUp.append("  FROM APP_UPLOAD_TRANS AUT,APP_UPLOAD_MAST AUM");
		qryUp.append("   WHERE  AUT.UPM_CD = AUM.UPM_CD AND ");
		qryUp.append("   AUT.DOC_ACTYN='Y' AND AUT.APP_ID='"+APP_ID+"' ");
			
	ResultSet rsUp = db.execSQL(qryUp.toString());		
        %>
		  <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>">
</p>
<table width="100%"  border="1">
  <tr>
      <th><div align="center">PMEGP Applicant document View Form </div></th>
  </tr>
</table>
  <table align="center" class="blueRound">
  <tr>      
		
        <% 
  
  String vDOC_NAME="";
  String vDOC_DESC="";
  String vDOC_REMARKS="";
  int srno=0;
  while (rsUp.next()) {
  srno=srno+1;
    vDOC_NAME=rsUp.getString("DOC_NAME");
   vDOC_DESC=rsUp.getString("DOC_DESC");
   vDOC_REMARKS=rsUp.getString("DOC_REMARKS");
  
  %>
      
         
         <td colspan="2"><a href="../jsp/doctransfertoNas.jsp?docname=<%= vDOC_NAME %>" class="greenButtonRound"><%= vDOC_DESC %> </a> </td>
       
        <%
  }
  rsUp.close();
  
   StringBuffer qryRemarks = new StringBuffer();
  
  qryRemarks.append(" SELECT MRT.APP_ID, ");
qryRemarks.append(" MAX(MRT.REMTR_ID) AS REMTR_ID, ");
qryRemarks.append(" APS.ACT_ID, ");
qryRemarks.append(" APS.ACT_DESC,");
qryRemarks.append("   MRT.CO_REMARKS, ");
  qryRemarks.append(" TO_CHAR(TRUNC(MRT.PROC_DT)) AS PROC_DT ");
qryRemarks.append(" FROM MM_REMARKS_TRANS MRT, ");
 qryRemarks.append("  BANK_APP_STATUS APS, ");
 qryRemarks.append("  BANK_DATAENTRY BD ");
qryRemarks.append(" WHERE MRT.PACT_ID = APS.ACT_ID ");
qryRemarks.append(" AND  APS.ACT_ID IN (30) AND MRT.REMTR_ID<>61  AND MRT.APP_ID ='"+APP_ID+"' ");
qryRemarks.append(" AND BD.APP_ID=MRT.APP_ID ");
qryRemarks.append(" GROUP BY ");
qryRemarks.append("  MRT.APP_ID, ");
qryRemarks.append(" APS.ACT_ID, ");
qryRemarks.append(" APS.ACT_DESC, ");
  qryRemarks.append(" MRT.CO_REMARKS, ");
  qryRemarks.append(" TO_CHAR(TRUNC(MRT.PROC_DT)) ");
  
  
  
  
  
  
 
  %>
   </tr>
</table>
	  

      <table width="100%"  border="1">
        <tr>
          <th nowrap><div align="center"><a href="../jsp/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="blueRound">Application Form</a> </div></th>
		  
          <th nowrap><div align="center"><a href="../jsp/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>&RNAME=marginmoney" class="marunRound">Margin Money (Govt. Subsidy) claim form </a></div></th>
		  <th nowrap><A href="PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>&RNAME=LetterHeadOfBank" class="buttonOrange" target="_blank">Sanction letter</A></th>
          <th nowrap><div align="center"><a href="../bankModule/docview.jsp?docname=<%= LOAN_DOCFNAME %>" class="greenButtonRound">Loan Disbursment Statement  </a> 
<!--<a href="../bankModule/uploadclaim/<%= LOAN_DOCFNAME %>" class="greenButtonRound">Loan Disbursment Statement </a>-->
</div></th>
        </tr>
</table>
      <table width="100%"  border="1">
        <tr>
          <th>Applicant Name: </th>
          <td><h2><%= APP_ID %></h2></td>
          <th>Applicant ID: </th>
          <td><h2><%= APP_NAME %></h2></td>
        </tr>
      </table>
     <%
	 String  ORG_CD=(String) session.getAttribute("org_cd");
	 if (ORG_CD.equals("KV")) {
	 %>
      <p align="center"><a href="upload_app_doc_mm.jsp?APP_ID=<%= APP_ID %>" class="buttonOrange">UPLOAD DOCUMENT (FOR SO/DO) </a></p>
	  <%}%>
      <p align="center">&nbsp;</p>
	  <% if (APPRV_YN.equals("A")){%>
      <table  border="1" align="center" cellpadding="3" cellspacing="3">
        <tr>
          <th colspan="3" scope="row"><div align="center" class="redLebel">Remarks of PMEGP, CO, KVIC, Mumbai </div></th>
        </tr>
		 <tr>
          <th scope="row">Status</th>
          <th scope="row">Date</th>
          <td>PMEGP Remarks </td>
        </tr>
		<% 
		  ResultSet rsRemarks = db.execSQL(qryRemarks.toString());		
			String ACT_DESC="";
			String CO_REMARKS="";
			String PROC_DT="";
		while (rsRemarks.next()) { 
		 ACT_DESC=rsRemarks.getString("ACT_DESC");
		  CO_REMARKS=rsRemarks.getString("CO_REMARKS");
		  PROC_DT=rsRemarks.getString("PROC_DT");
		 
		%>
       
        <tr>
          <th scope="row"><%= ACT_DESC %></th>
          <th scope="row"><%= PROC_DT %></th>
          <td><%= CO_REMARKS %></td>
        </tr>
		
		<%}
		rsRemarks.close();
		
		db.close();
		 %>
      </table>
     
	
      <p align="center" class="GreenLebel">Click on the Link to View the Applicant Data online and </p>
      <p align="center" class="GreenLebel">(To go Back click Alt+Left Arrow ) </p>
<p>&nbsp;</p>
<%}%>
</body>
</html>
