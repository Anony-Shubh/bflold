<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<HTML>

<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<TITLE></TITLE>
	<SCRIPT language="javascript">
        function submitform() {	
            document.form.ins.value = 'I';
            document.form.submit();
        }

    </SCRIPT>
    <STYLE type="text/css">
<!--
.style9 {font-size: 18px}
.style12 {font-size: 18px; font-weight: bold; }
.style13 {font-size: 12px}

-->
    </STYLE>
</HEAD>



<BODY>

 <P>
   <%
String PBATCH_ID=request.getParameter("PBATCH_ID")==null?"":(String) request.getParameter("PBATCH_ID");
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String EMAIL="";
String APP_NAME="";
String MM_CLAIM_AMT="";
String MM_CLAIM_DT="";
String MM_REL_AMT="";
String MM_REL_DT="";
String UTRN_NO="";
String BATCH_DATE="";
String BRANCHNAME="";
String IFSC_CODE="";
String TRANS_ACNO="";
String NEFT_IFSCODE="";
String ROWNUM="";
String APPFEES="";
String PAY_STATUS="";
String FAIL_REASON="";
String EMAIL_SENT="";
String NETMMRELAMT="";
String add_update="N";
String SMS_SENT="";
String BANK_NAME="";




DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList();


StringBuffer poR = new StringBuffer();

poR.append(" SELECT ROWNUM, "      );
poR.append(" UPPER(B.APP_NAME) AS APP_NAME, "      );
poR.append(" B.APP_ID, "      );
poR.append(" TO_CHAR(A.BATCH_DATE, 'DD-MON-YYYY') AS BATCH_DATE, "      );
poR.append(" A.PBATCH_ID, "      );
poR.append(" 'xxx'||SUBSTR(A.FB_ACNO,3,LENGTH(A.FB_ACNO)) AS TRANS_ACNO, "      );
poR.append(" A.UTRN_NO, "      );
poR.append(" A.PAY_STATUS, "      );
poR.append(" TO_CHAR(A.MM_CLAIM_DT, 'DD-MON-YYYY') AS MM_CLAIM_DT, "      );
poR.append(" A.MM_CLAIM_AMT, "      );
poR.append(" TO_CHAR(A.MM_REL_DT, 'DD-MON-YYYY') AS MM_REL_DT, "      );
poR.append(" A.MM_REL_AMT, "      );
poR.append(" CASE WHEN A.PBATCH_ID > 562 THEN 500 ELSE 0 END APPFEES, "      );
poR.append(" CASE WHEN A.PBATCH_ID > 562 THEN NVL(A.MM_REL_AMT, 0) - 500 ELSE NVL(A.MM_REL_AMT, 0)END NETMMRELAMT, "      );
poR.append(" NVL(A.FAIL_REASON, '-') AS FAIL_REASON, "      );
poR.append(" RBL.BANK_NAME AS BANK_NAME, "      );
poR.append(" RBL.BRANCHNAME, "      );
poR.append(" BBM.EMAIL, "      );
poR.append(" MS.STATE_NM AS BANK_STATE, "      );
poR.append(" RBL.IFSC_CODE, "      );
poR.append(" FGETNEFTIFSCODE(A.APP_ID) AS NEFT_IFSCODE "      );
poR.append(" FROM BANK_DATAENTRY A, APP_DETAIL B, RBIBANKLIST RBL, BANK_BR_MAST BBM, M_STATE MS "      );
poR.append(" WHERE B.APP_ID    = A.APP_ID "      );
poR.append(" AND B.IFSC_CODE   = RBL.IFSC_CODE "      );
poR.append(" AND RBL.IFSC_CODE = BBM.BR_IFSL_CODE "      );
poR.append(" AND RBL.STATE_CD  = MS.STATE_CD "      );
poR.append(" AND B.APP_ID=? "      );

//values.add(PBATCH_ID);
values.add(APP_ID);
ResultSet rsMain = db.executeSQL(poR.toString(),values);

StringBuffer poR1 = new StringBuffer();

poR1.append(" SELECT SS.APP_ID, "      );
poR1.append(" SS.SMS_SENT, "      );
poR1.append(" SS.EMAIL_SENT "      );
poR1.append(" FROM SMSEMAIL_SEND_LOG SS"      );
poR1.append(" WHERE SS.APP_ID=? "      );



while (rsMain.next()){
PBATCH_ID=rsMain.getString("PBATCH_ID")==null?"":rsMain.getString("PBATCH_ID");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
ROWNUM=rsMain.getString("ROWNUM")==null?"":rsMain.getString("ROWNUM");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
UTRN_NO=rsMain.getString("UTRN_NO")==null?"":rsMain.getString("UTRN_NO");
BATCH_DATE=rsMain.getString("BATCH_DATE")==null?"":rsMain.getString("BATCH_DATE");
BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
TRANS_ACNO=rsMain.getString("TRANS_ACNO")==null?"":rsMain.getString("TRANS_ACNO");
NEFT_IFSCODE=rsMain.getString("NEFT_IFSCODE")==null?"":rsMain.getString("NEFT_IFSCODE");
PAY_STATUS=rsMain.getString("PAY_STATUS")==null?"":rsMain.getString("PAY_STATUS");
APPFEES=rsMain.getString("APPFEES")==null?"":rsMain.getString("APPFEES");
FAIL_REASON=rsMain.getString("FAIL_REASON")==null?"":rsMain.getString("FAIL_REASON");
NETMMRELAMT=rsMain.getString("NETMMRELAMT")==null?"":rsMain.getString("NETMMRELAMT");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");



ResultSet rsMain1 = db.executeSQL(poR1.toString(),values);

while (rsMain1.next()){
APP_ID=rsMain1.getString("APP_ID")==null?"":rsMain1.getString("APP_ID");
EMAIL_SENT=rsMain1.getString("EMAIL_SENT")==null?"":rsMain1.getString("EMAIL_SENT");
SMS_SENT=rsMain1.getString("SMS_SENT")==null?"":rsMain1.getString("SMS_SENT");
add_update="U";

}
rsMain1.close();

}
rsMain.close();


%>
   
   
   <BR>

 </P>
 <CENTER>
  <FORM method="post" name="form" id="form">
  <INPUT name="ins" id="ins" type="hidden" value="">
  <INPUT type="button" name="Submit" class="style9" onClick="submitform();" value="Send">	
   <BR>
<BR>
	
 <TABLE id="example" class="display"  border="1" width="80%">
 <TR>
 <TD><P align="center"><STRONG>KHADI AND VILLAGE INDUSTRIES COMMISSION
       <BR>
Prime Minister Employment Generation Programme (PMEGP)
  </STRONG><BR>
email: pmegpportal.kvic@gov.in/ pmegp.kvic@gov.in</P> 
<P><DIV align="left">No: PMEGP/MMREL/BN/<%=PBATCH_ID%></DIV>
<DIV align="right">Date: <%=BATCH_DATE%></DIV></p>
<BR>
<BR>
<P>
To
<BR>
The Branch Manager,<BR>
<%= BANK_NAME %><BR>
<%=BRANCHNAME%>
<BR>
IFS Code: <%=IFSC_CODE%>
<BR>
Email: <%=EMAIL%><BR>
</P>

<P><DIV align="center">Sub: PMEGP Margin Money(Govt. Subsidy) Release....reg.</DIV><BR>
<DIV align="center">Ref: Batch No:<%=PBATCH_ID%>&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;Dated:<%=BATCH_DATE%></DIV></p> 
<P>Sir,<BR>

PMEGP Margin Money (Govt. Subsidy) in respect of following beneficiary has been advised to release through Indian Bank ( Nodal Bank of KVIC ) to your transient(Non-Customer) Account No: <%=TRANS_ACNO%> and NEFT IFS Code:
<%=NEFT_IFSCODE%>.</P>
<P>The Details of Claim are given below:-
 <DIV align="center">
   <TABLE id="example" class="display"  border="1" width="60%">
     <TR>
       <TH><SPAN class="style13">Sr No.</SPAN></TH>
     <TH><SPAN class="style13">Applicant Id</SPAN></TH>
     <TH><SPAN class="style13">Applicant Name</SPAN></TH>
     <TH><SPAN class="style13">Claim Date</SPAN></TH>
     <TH><SPAN class="style13">Claim Amount (A) </SPAN></TH>
     <TH><SPAN class="style13">Application Fees Deducted <BR>
       (B)</SPAN></TH>
     <TH><SPAN class="style13">MM Release Amount (A-B) </SPAN></TH>
     <TH><SPAN class="style13">Release Date</SPAN></TH>
     <TH><SPAN class="style13">UTRN No.</SPAN></TH>
     <TH><SPAN class="style13">Payment Status</SPAN></TH>
     <TH><DIV align="right" class="style13">
       <DIV align="center">Fail Reason</DIV>
     </DIV></TH>
     </TR>
     <TR>
       <TD><SPAN class="style13"><%=ROWNUM%></SPAN></TD>
     <TD><SPAN class="style13"><%=APP_ID%></SPAN></TD>
     <TD><SPAN class="style13"><%=APP_NAME%></SPAN></TD>
     <TD><SPAN class="style13"><%=MM_CLAIM_DT%></SPAN></TD>
     <TD><SPAN class="style13"><%=MM_CLAIM_AMT%></SPAN></TD>
     <TD><SPAN class="style13"><%=APPFEES%></SPAN></TD>
     <TD><%= NETMMRELAMT %></TD>
     <TD><SPAN class="style13"><%=MM_REL_DT%></SPAN></TD>
     <TD><SPAN class="style13"><%=UTRN_NO%></SPAN></TD>
     <TD><SPAN class="style13"><%=PAY_STATUS%></SPAN></TD>
     <TD><DIV align="center"><SPAN class="style13"><%=FAIL_REASON%></SPAN></DIV></TD>
     </TR>
   </TABLE>
 </DIV>
 <P align="center">You are requested please check the transaction in MM CLAIM STATUS tab in bank login of PMEGP portal and update the TDR details.</P>
 <P align="center">In case transaction is failed please contact Indian Bank (Nodal Bank of KVIC) and write to<BR>
Email Id: pmegp.narimanpoint@indianbank.co.in under intimation to pmegp.kvic@gov.in</P>
<BR>
<BR>

 <P align="center" class="style12">This is system generated letter</P> </TD>

</TR>
</TABLE>
<%

if ((String)request.getParameter("ins")!=null){ 
values.clear();
APP_ID =(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
EMAIL_SENT =(String) request.getParameter("EMAIL_SENT")==null?"":(String) request.getParameter("EMAIL_SENT").trim();

StringBuffer qryUpdate = new StringBuffer();

if (!add_update.equals("U")) {
//INSERT INTO LOG
qryUpdate.append(" INSERT INTO SMSEMAIL_SEND_LOG ");
qryUpdate.append("( EMAIL_SENT ,");
qryUpdate.append(" APP_ID");
qryUpdate.append( ") VALUES (SYSDATE,?) ");

}
else
{


qryUpdate.append("	UPDATE SMSEMAIL_SEND_LOG SET ");
qryUpdate.append("	EMAIL_SENT= SYSDATE ");
qryUpdate.append(" WHERE APP_ID = ?");



}
values.add(APP_ID); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

values.clear();
pstm.clear();

db.close();

//out.print(qryUpdate.toString());
response.sendRedirect("savemsg.jsp");


}

%>




   

</FORM>
</CENTER>
</BODY>

</HTML>
