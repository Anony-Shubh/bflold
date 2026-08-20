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
	<script language="javascript">
        function closeAndRefresh() {
            window.parent.refreshpage();
        }

    </script>
    <style type="text/css">
<!--
.style9 {font-size: 18px}
.style12 {font-size: 18px; font-weight: bold; }
.style13 {font-size: 12px}

-->
    </style>
</HEAD>



<BODY>

 <p>
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
String BANK_NAME="";
String NETMMRELAMT="";




DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 


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
poR.append(" AND A.PBATCH_ID   = ? AND B.APP_ID=? "      );

values.add(PBATCH_ID);
values.add(APP_ID);
ResultSet rsMain = db.executeSQL(poR.toString(),values);


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
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
NETMMRELAMT=rsMain.getString("NETMMRELAMT")==null?"":rsMain.getString("NETMMRELAMT");
}
rsMain.close();


%>
   
   <br>

 </p>
 <CENTER>
  <FORM method="post" name="form" id="form">
  <INPUT name="ins" id="ins" type="hidden" value="">
   <INPUT type="button" name="Submit" class="style9" onClick="closeAndRefresh();" value="Send">	
   <br>
<br>
	
 <table id="example" class="display"  border="1" width="80%">
 <tr>
 <td><p align="center"><strong>KHADI AND VILLAGE INDUSTRIES COMMISSION
       <br>
Prime Minister Employment Generation Programme (PMEGP)
  </strong><br>
email: pmegpportal.kvic@gov.in/ pmegp.kvic@gov.in</p> 
<p><div align="left">No: PMEGP/MMREL/BN/<%=PBATCH_ID%></div>
<div align="right">Date: <%=BATCH_DATE%></div></p>
<br>
<br>
<p>
To
<br>
The Branch Manager,<br>
<%= BANK_NAME %><br>
<%=BRANCHNAME%>
<br>
IFS Code: <%=IFSC_CODE%>
<br>
Email: <%=EMAIL%><br>
</p>

<p><div align="center">Sub: PMEGP Margin Money(Govt. Subsidy) Release....reg.</div><br>
<div align="center">Ref: Batch No:<%=PBATCH_ID%>&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;Dated:<%=BATCH_DATE%></div></p> 
<p>Sir,<br>

PMEGP Margin Money (Govt. Subsidy) in respect of following beneficiary has been advised to release through Indian Bank ( Nodal Bank of KVIC ) to your transient(Non-Customer) Account No: <%=TRANS_ACNO%> and NEFT IFS Code:
<%=NEFT_IFSCODE%>.</p>
<p>The Details of Claim are given below:-
 <div align="center">
   <table id="example" class="display"  border="1" width="60%">
     <tr>
       <th><span class="style13">Sr No.</span></th>
     <th><span class="style13">Applicant Id</span></th>
     <th><span class="style13">Applicant Name</span></th>
     <th><span class="style13">Claim Date</span></th>
     <th><span class="style13">Claim Amount (A) </span></th>
     <th><span class="style13">Application Fees Deducted <br>
       (B)</span></th>
     <th><span class="style13">MM Release Amount (A-B) </span></th>
     <th><span class="style13">Release Date</span></th>
     <th><span class="style13">UTRN No.</span></th>
     <th><span class="style13">Payment Status</span></th>
     <th><div align="right" class="style13">
       <div align="center">Fail Reason</div>
     </div></th>
     </tr>
     <tr>
       <td><span class="style13"><%=ROWNUM%></span></td>
     <td><span class="style13"><%=APP_ID%></span></td>
     <td><span class="style13"><%=APP_NAME%></span></td>
     <td><span class="style13"><%=MM_CLAIM_DT%></span></td>
     <td><span class="style13"><%=MM_CLAIM_AMT%></span></td>
     <td><span class="style13"><%=APPFEES%></span></td>
     <td><%= NETMMRELAMT %></td>
     <td><span class="style13"><%=MM_REL_DT%></span></td>
     <td><span class="style13"><%=UTRN_NO%></span></td>
     <td><span class="style13"><%=PAY_STATUS%></span></td>
     <td><div align="center"><span class="style13"><%=FAIL_REASON%></span></div></td>
     </tr>
   </table>
 </div>
 <p align="center">You are requested please check the transaction in MM CLAIM STATUS tab in bank login of PMEGP portal and update the TDR details.</p>
 <p align="center">In case transaction is failed please contact Indian Bank (Nodal Bank of KVIC) and write to<br>
Email Id: pmegp.narimanpoint@indianbank.co.in under intimation to pmegp.kvic@gov.in</p>
<br>
<br>

 <p align="center" class="style12">This is system generated letter</p> </td>

</tr>
</table>



   

</FORM>
</CENTER>
</BODY>

</HTML>
