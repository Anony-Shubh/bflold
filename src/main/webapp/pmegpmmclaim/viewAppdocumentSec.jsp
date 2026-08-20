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
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String LOAN_DOCFNAME="";
		
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append(" UPPER(A.APP_NAME) AS APP_NAME, BD.LOAN_DOCFNAME, ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL_SECOND A ,BANK_DATAENTRY_SECOND BD ");
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
        }
			rsApp.close();
			StringBuffer qryUp = new StringBuffer();	
			
		qryUp.append("  SELECT AUT.UP_ID,");
		qryUp.append("   AUT.DOC_NAME,");
		 qryUp.append("   NVL(AUT.DOC_REMARKS,'-') AS DOC_REMARKS,");
		qryUp.append("   TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT,");
		qryUp.append("  AUM.DOC_DESC");
		qryUp.append("  FROM APP_UPLOAD_TRANS_SECOND AUT,APP_UPLOAD_MAST_SECOND AUM");
		qryUp.append("   WHERE  AUT.UPM_CD = AUM.UPM_CD AND ");
		qryUp.append("   AUT.DOC_ACTYN='Y' AND AUM.UPM_CD NOT IN (17) AND AUT.APP_ID='"+APP_ID+"' ");
			
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
      
         
         <td colspan="2"><a href="../jsp/docView.jsp?docname=<%= vDOC_NAME %>" class="greenButtonRound"><%= vDOC_DESC %> </a> </td>
       
        <%
  }
  rsUp.close();
  
   String refqry=  " SELECT MRT.CO_REMARKS AS CO_REMARKS1, TO_CHAR(trunc(MRT.PROC_DT),'DD-MON-RRRR') AS PROC_DT1 FROM MM_REMARKS_TRANS_SECOND MRT,BANK_DATAENTRY_SECOND BD WHERE BD.PACT_ID =30 ";
			refqry =refqry+ " AND MRT.APP_ID=BD.APP_ID AND BD.PACT_ID=MRT.PACT_ID AND BD.IFSC_CODE=MRT.IFSC_CODE AND MRT.APP_ID='"+APP_ID+"' GROUP BY  MRT.CO_REMARKS,MRT.PROC_DT  ";
			refqry =refqry+ " ";

			String CO_REMARKS1="";
			String PROC_DT1="";
			ResultSet rsRef = db.execSQL(refqry);
			while ( rsRef.next()) {
			CO_REMARKS1 =rsRef.getString("CO_REMARKS1");
			PROC_DT1 =rsRef.getString("PROC_DT1");
			out.print("<u><H3>Process Date: "+PROC_DT1+"</H3></u> :");
			out.print("<H2>Remarks "+CO_REMARKS1+"</H2>");
			
			}
			rsRef.close();
			
  db.close();
  %>
   </tr>
      </table>
	  

      <table width="100%"  border="1">
        <tr>
          <th nowrap><div align="center"><a href="../jsp/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>&RNAME=SecondLoanApplication" class="blueRound">Application Form</a> </div></th>
		  
          <th nowrap><div align="center"><a href="../jsp/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>&RNAME=marginmoneySecond" class="marunRound">Margin Money (Govt. Subsidy) claim form </a></div></th>
		  
          <th nowrap><div align="center"> <a href="../bankModule/docviewSec.jsp?docname=<%= LOAN_DOCFNAME %>" class="greenButtonRound">Loan Disbursment Statement </a></div></th>
		  
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="100%"  border="1">
        <tr>
          <th>Applicant Name: </th>
          <td><h2><%= APP_ID %></h2></td>
          <th>Applicant ID: </th>
          <td><h2><%= APP_NAME %></h2></td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p align="center" class="GreenLebel">Click on the Link to View the Applicant Data online and </p>
      <p align="center" class="GreenLebel">(To go Back click Alt+Left Arrow ) </p>
<p>&nbsp;</p>
</body>
</html>
