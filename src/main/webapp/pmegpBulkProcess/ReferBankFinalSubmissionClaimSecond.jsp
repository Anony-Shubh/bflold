<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>

  
<html>
<head>
<%@ include file="headerfile.jsp" %>

<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}
 %>
    <title>upload </title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
	<script language="javascript" src="../js/inlineMsgMain.js"></script>
	
<script language="javascript">

function getFilePathExtension(path) {
	var filename = path.split('\\').pop().split('/').pop();
	var lastIndex = filename.lastIndexOf(".");
	if (lastIndex < 1) return "";
	return filename.substr(lastIndex + 1);
}

		function submit_form() {
		
			
	document.form.ins.value='I';
	document.form.submit();
}
</script>
</head>

<body>
<form method="post" action="ReferBankFinalSubmissionClaimSecond.jsp" name="form" id="form" class="form"  >
	
	    <%
		
		String APP_ID = (String)session.getAttribute("SAPP_ID");
		//out.print(APP_ID);
		
        String IFSC_CODE=(String)session.getAttribute("bank_id");
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
	//out.print(IFSC_CODE);
		String APP_NAME="";
		String AADHAR_NO = "";
		String APPLOAN_ACCNO = "";
		String IST_LOAN_DT = "";
		String IST_LOAN_AMT = "";
		String FB_ACNO = "";
		String MM_CLAIM_AMT = "";
		String LOAN_DOCFNAME="";
		

        DBCon db= new DBCon();
        db.connect();
        StringBuffer qrysb = new StringBuffer();
			qrysb.append("   SELECT AD.APP_ID,"      );
			qrysb.append("     AD.APP_NAME,"      );
			qrysb.append("     AD.AADHAR_NO,"      );
			qrysb.append("     BD.APPLOAN_ACCNO,"      );
			qrysb.append("     TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,"      );
			qrysb.append("     BD.IST_LOAN_AMT,"      );
			qrysb.append("     AD.IFSC_CODE,"      );
			qrysb.append("     BD.FB_ACNO,LOAN_DOCFNAME,"      );
			qrysb.append("     BD.MM_CLAIM_AMT  "      );
			qrysb.append("   FROM APP_DETAIL_SECOND AD,"      );
			qrysb.append("     BANK_DATAENTRY_SECOND BD,BANK_BR_MAST BRM"      );
			qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
			qrysb.append("   AND AD.APP_ID       = ? "      );
			qrysb.append("   AND BD.IST_LOAN_DT IS NOT NULL AND AD.IFSC_CODE = BRM.BR_IFSL_CODE "      );
			qrysb.append("   AND BRM.CIRCLE_IFSC    = ?"      );
			qrysb.append("   AND BD.MM_CLAIM_AMT > 0"      );
			qrysb.append("   AND BD.ACT_ID       = 11 AND BD.PACT_ID=30 AND BD.APPRV_YN='A'  "      );
			
			
			List valuesq = new ArrayList();
			valuesq.add(APP_ID);
			valuesq.add(IFSC_CODE);

		  ResultSet rsMain = db.executeSQL(qrysb.toString(),valuesq);
        while (rsMain.next()){
		//APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
		APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
		AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
		APPLOAN_ACCNO=rsMain.getString("APPLOAN_ACCNO")==null?"":rsMain.getString("APPLOAN_ACCNO");
		IST_LOAN_DT=rsMain.getString("IST_LOAN_DT")==null?"":rsMain.getString("IST_LOAN_DT");
		IST_LOAN_AMT=rsMain.getString("IST_LOAN_AMT")==null?"":rsMain.getString("IST_LOAN_AMT");
		//IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
		FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
		MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
		LOAN_DOCFNAME=rsMain.getString("LOAN_DOCFNAME")==null?"":rsMain.getString("LOAN_DOCFNAME");

        }
		rsMain.close();
					
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="4" scope="col"><div align="center">ONLINE MARGIN MONEY (GOVT. SUBSIDY) FINAL SUBMISSION 123</div></th>
        </tr>
        <tr>
          <td colspan="4" scope="col"><div align="right"><a href="bankApplicationViewSecond.jsp" class="greenButtonRound">go Back: </a></div></td>
        </tr>
        <tr>
          <th scope="col">Applicant ID: </th>
          <th scope="col"><%= APP_ID %></th>
          <th scope="col">Applicant Name </th>
          <th scope="col"><%= APP_NAME %></th>
		  
        </tr>
        <tr>
          <th scope="col">Aadhaar No: </th>
          <th scope="col"><%= AADHAR_NO %></th>
          <th scope="col">Loan Account No: </th>
          <td class="redLebel" scope="col"><h1><%= APPLOAN_ACCNO %></h1></td>
        </tr>
        <tr>
          <th scope="col">Loan Release Date: </th>
          <th scope="col"><%= IST_LOAN_DT %></th>
          <th scope="col">Total Loan Release Amount </th>
          <th scope="col"><%= IST_LOAN_AMT %></th>
        </tr>
        <tr>
          <th scope="col">NEFT IFS Code:
              <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>">
			    <input id="IFSC_CODE" name="IFSC_CODE" type="hidden" value="<%=IFSC_CODE%>">
			  </th>
          <td class="GreenLebel" scope="col"><%= IFSC_CODE %></td>
          <th scope="col">Bank Transient A/c No: </th>
          <td class="GreenLebel" scope="col"><h1><%= FB_ACNO %></h1></td>
        </tr>
        <tr>
          <th colspan="2" scope="col">Margin Money (Govt. Subsidy) Claim Amount: </th>
          <td class="GreenLebel" scope="col"><h1><%= MM_CLAIM_AMT %></h1></td>
          <td class="GreenLebel" scope="col">&nbsp;</td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col"><div align="center">NOTE</div></td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col"> (1) Please verify the Margin Money (Govt. Subidy) Details before &quot;FINAL RESUBMISSION OF GOVT. SUBSIDY CLAIM&quot; </td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col">(2) Verify Transient Account No of Your Bank And NEFT IFS Code Before Final Submission</td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col">(3) After Final Submission Data cannot be Updated
              <input name="ins" type="hidden" id="ins" value="<%= ins %>">
             
        </tr>
        <tr>
          <th colspan="4"><div align="center">
              <input name="btnUpload" type="button"  style="color:#FF0000" class="buttonMerun" id="btnUpload" value="FINAL RESUBMISSION OF GOVT. SUBSIDY CLAIM" onClick="submit_form();">
          </div></th>
        </tr>
      </table>
	  <%
	 
	 if (ins.equals("I")){
	 try {
     
						APP_ID=(String)session.getAttribute("SAPP_ID");
						IFSC_CODE=(String)session.getAttribute("bank_id");

						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" UPDATE BANK_DATAENTRY_SECOND BD SET BD.MM_CLAIM_DT=SYSDATE,   ");
						qryUpdate.append(" BD.PACT_ID=null, BD.APPRV_YN='N' , BD.REMTRID = null  ");
						qryUpdate.append(" WHERE BD.APP_ID IN ");
						qryUpdate.append(" (SELECT APP_ID FROM APP_DETAIL_SECOND WHERE APP_ID=? AND ACT_YN='Y')  AND IFSC_CODE IN ");qryUpdate.append(" (select br.BR_IFSL_CODE from BANK_BR_MAST br where br.circle_ifsc=?)  ");
						qryUpdate.append(" AND BD.PACT_ID=30 AND BD.APPRV_YN='A' AND ");
						qryUpdate.append(" BD.MM_CLAIM_AMT>0 AND BD.FB_ACNO IN (SELECT CIRCLE_TRANS_ACNO FROM BANK_BR_MAST br WHERE br.BR_IFSL_CODE=BD.IFSC_CODE)");

						
						
						values.add (APP_ID);pstm.add ("S");
						values.add (IFSC_CODE);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate();
						db.close();
						pstm.clear();
						values.clear();	
							//out.print("aa");
						response.sendRedirect("bankApplicationViewSecond.jsp");
						
						}catch (Exception e) {
out.print (e.toString());
}finally{

//db.close();

}}
	
	   %>
</form>
</body>
</html>