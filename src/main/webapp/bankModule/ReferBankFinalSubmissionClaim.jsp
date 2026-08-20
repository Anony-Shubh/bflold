<%@ page buffer="500kb" %>
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
<%@ page import="cdacuidai.VerifyAadhaarByID"%>
  
<HTML>
<HEAD>
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
    <TITLE>upload </TITLE>
	<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
	<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>
	
<SCRIPT language="javascript">

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
</SCRIPT>
</HEAD>

<BODY>
<FORM method="post" action="ReferBankFinalSubmissionClaim.jsp" name="form" id="form" class="form"  >
	
	    <%
		String CLIENT_IP= (String)session.getAttribute("SCLIENTIP");
		String APP_ID = (String)session.getAttribute("SAPP_ID");
		
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
		String NEFT_IFSC="";
		String mm_claim_valid="";

        DBCon db= new DBCon();
        db.connect();
		 String adhvalid="F";

try {
VerifyAadhaarByID v= new VerifyAadhaarByID();	
adhvalid=v.VerifyAad(APP_ID, "AG");
}catch (Exception e) {}
		
        StringBuffer qrysb = new StringBuffer();
			qrysb.append("   SELECT AD.APP_ID,"      );
			qrysb.append("     AD.APP_NAME,"      );
			qrysb.append("     AD.AADHAR_NO,"      );
			qrysb.append("     BD.APPLOAN_ACCNO,"      );
			qrysb.append("     TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,"      );
			qrysb.append("     BD.IST_LOAN_AMT,"      );
			qrysb.append("     AD.IFSC_CODE,"      );
			qrysb.append("     BD.FB_ACNO,LOAN_DOCFNAME,"      );
			qrysb.append("     BD.MM_CLAIM_AMT, FGETNEFTIFSCODE(BD.APP_ID)  AS NEFT_IFSC, "      );
			qrysb.append(" CASE  WHEN nvl(bd.mm_claim_amt, 0) = 0  THEN "      );
           qrysb.append(" 'Govt. Subsidy Claim Amount is Zero' "      );
       qrysb.append(" WHEN nvl(bd.mm_claim_amt, 0) <> mminv_bankadmit(bd.app_id) THEN "      );
          qrysb.append("  'Govt. Subsidy Claim Amount Mismatch' "      );
           qrysb.append("  WHEN FGETTRANSACNO(BD.APP_ID) IS NULL THEN "      );
          qrysb.append("   'Non-Customer Account No mismatch or blank' "      );
   qrysb.append("   WHEN FGETNEFTIFSCODE(BD.APP_ID) IS NULL THEN "      );
         qrysb.append("    'NEFT IFSC CODE MISMATCH OR BLANK'  "      );       
       qrysb.append(" ELSE  'S' "      );
    qrysb.append(" END mm_claim_valid"      );	
			
			qrysb.append("   FROM APP_DETAIL AD,"      );
			qrysb.append("     BANK_DATAENTRY BD"      );
			qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID  "      );
			qrysb.append("   AND AD.APP_ID       = ? "      );
			qrysb.append("   AND BD.IST_LOAN_DT IS NOT NULL"      );
			qrysb.append("   AND AD.IFSC_CODE    = ?"      );
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
		NEFT_IFSC=rsMain.getString("NEFT_IFSC")==null?"":rsMain.getString("NEFT_IFSC");
		FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
		MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
		LOAN_DOCFNAME=rsMain.getString("LOAN_DOCFNAME")==null?"":rsMain.getString("LOAN_DOCFNAME");
		mm_claim_valid=rsMain.getString("mm_claim_valid")==null?"":rsMain.getString("mm_claim_valid");

        }
		rsMain.close();
					
        %>
  </p>
	  <TABLE align="center">
        <TR>
          <TH colspan="4" scope="col"><DIV align="center">ONLINE MARGIN MONEY (GOVT. SUBSIDY) FINAL SUBMISSION </DIV></TH>
        </TR>
        <TR>
          <TD colspan="4" scope="col"><DIV align="right"><A href="bankApplicationView.jsp" class="greenButtonRound">go Back: </A></DIV></TD>
        </TR>
        <TR>
          <TH scope="col">Applicant ID: </TH>
          <TH scope="col"><%= APP_ID %></TH>
          <TH scope="col">Applicant Name </TH>
          <TH scope="col"><%= APP_NAME %></TH>
		  
        </TR>
        <TR>
          <TH scope="col">Aadhaar No: </TH>
          <TH scope="col"><%= AADHAR_NO %></TH>
          <TH scope="col">Loan Account No: </TH>
          <TD class="redLebel" scope="col"><H1><%= APPLOAN_ACCNO %></H1></TD>
        </TR>
        <TR>
          <TH scope="col">Loan Release Date: </TH>
          <TH scope="col"><%= IST_LOAN_DT %></TH>
          <TH scope="col">Total Loan Release Amount </TH>
          <TH scope="col"><%= IST_LOAN_AMT %></TH>
        </TR>
        <TR>
          <TH scope="col">NEFT IFS Code:
              <INPUT id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>">
			    <INPUT id="IFSC_CODE" name="IFSC_CODE" type="hidden" value="<%=IFSC_CODE%>">
			  </TH>
          <TD class="GreenLebel" scope="col"><%= NEFT_IFSC %></TD>
          <TH scope="col">Bank Transient A/c No: </TH>
          <TD class="GreenLebel" scope="col"><H1><%= FB_ACNO %></H1></TD>
        </TR>
        <TR>
          <TH colspan="2" scope="col">Margin Money (Govt. Subsidy) Claim Amount: </TH>
          <TD class="GreenLebel" scope="col"><H1><%= MM_CLAIM_AMT %></H1></TD>
          <TD class="GreenLebel" scope="col">&nbsp;</TD>
        </TR>
        <TR class="redLebel">
          <TD colspan="4" scope="col"><DIV align="center">NOTE</DIV></TD>
        </TR>
        <TR class="redLebel">
          <TD colspan="4" scope="col"> (1) Please verify the Margin Money (Govt. Subidy) Details before &quot;FINAL RESUBMISSION OF GOVT. SUBSIDY CLAIM&quot; </TD>
        </TR>
        <TR class="redLebel">
          <TD colspan="4" scope="col">(2) Verify Transient Account No of Your Bank And NEFT IFS Code Before Final Submission</TD>
        </TR>
        <TR class="redLebel">
          <TD colspan="4" scope="col">(3) After Final Submission Data cannot be Updated
              <INPUT name="ins" type="hidden" id="ins" value="<%= ins %>">
             
        </TR>
        <TR>
          <TH colspan="4"><DIV align="center">
		  <%if (!adhvalid.equals("S") ){%>
	  
 <span class="redLebel">Aadhaar Details are invalid! Please ensure Aadhaar No, Name, Date Of Birth , Gender and mobile No Details are as per Aadhaar Card....... ! Kindly Contact Concern Agency to Update Correct  Details in Applicant Data form </span>
		<%} else{%>
		  <% if (mm_claim_valid.equals("S")){%>	
		  
		  
              <INPUT name="btnUpload" type="button" class="buttonBlue" id="btnUpload" style="background-color:#0033FF" value="FINAL RESUBMISSION OF GOVT. SUBSIDY CLAIM" onClick="submit_form();">
			  <%} else { %>
			
		<span class="redLebel"><%out.print(mm_claim_valid); %></span> <%   }} %>
			
          </DIV></TH>
        </TR>
      </TABLE>
	  <%
	 
	 if (ins.equals("I")){
	 try {
     
						APP_ID=(String)session.getAttribute("SAPP_ID");
						IFSC_CODE=(String)session.getAttribute("bank_id");

						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" UPDATE BANK_DATAENTRY BD SET MM_CLAIM_DT=SYSDATE,CLIENT_IP=?,   ");
						qryUpdate.append(" PACT_ID=null, APPRV_YN='N' , REMTRID = null  ");
				qryUpdate.append(" WHERE APP_ID=? AND IFSC_CODE=? AND PACT_ID=30 AND APPRV_YN='A' AND APP_ID IN (SELECT APP_ID FROM APP_DETAIL WHERE APP_ID=? AND ACT_YN='Y')  ");
				qryUpdate.append(" AND MM_CLAIM_AMT>0  AND FB_ACNO IS NOT NULL ");
				
				
				/* AND MM_CLAIM_AMT=MMINV_BANKADMIT(APP_ID) ");
qryUpdate.append("  AND FB_ACNO IN (SELECT TRANS_ACNO FROM BANK_BR_MAST WHERE BR_IFSL_CODE=BD.IFSC_CODE)  ");
qryUpdate.append("	AND FGETNEFTIFSCODE(BD.APP_ID) IN (SELECT NEFT_IFSC FROM BANK_BR_MAST WHERE BR_IFSL_CODE=BD.IFSC_CODE)	");		
	*/					
						
						values.add (CLIENT_IP);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						values.add (IFSC_CODE);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate();
						db.close();
						pstm.clear();
						values.clear();	
							out.print("aa");
						response.sendRedirect("bankApplicationView.jsp");
						
						}catch (Exception e) {
out.print (e.toString());
}finally{

//db.close();

}}
	
	   %>
</FORM>
</BODY>
</HTML>