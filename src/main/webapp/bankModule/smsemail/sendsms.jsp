<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<HTML>

<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<TITLE></TITLE>
	<SCRIPT>
        function submitform() {
		//alert ("sms sending");
            document.form.ins.value = 'I';
            document.form.submit();
        }

    </SCRIPT>
    <STYLE type="text/css">
<!--
.style9 {font-size: 18px}

-->
    </STYLE>
</HEAD>



<BODY>
  <FORM method="post" name="form" id="form">

 <P>
   <%
String PBATCH_ID=request.getParameter("PBATCH_ID")==null?"":(String) request.getParameter("PBATCH_ID");
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String APP_NAME="";
String MM_REL_AMT="";
String MM_REL_DT="";
String UTRN_NO="";
String NETMMRELAMT="";
String MOB_NO1="";
String add_update=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String SMS_SENT="";
String EMAIL_SENT="";





DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 

StringBuffer poR = new StringBuffer();

poR.append(" SELECT SUBSTR(UPPER(B.APP_NAME),1,30) AS APP_NAME, "      );
poR.append(" B.APP_ID, "      );
poR.append(" A.BATCH_DATE, "      );
poR.append(" A.PBATCH_ID, "      );
poR.append(" 'xxx'||SUBSTR(A.FB_ACNO,3,LENGTH(A.FB_ACNO)) AS TRANS_ACNO, "      );
poR.append(" A.UTRN_NO, "      );
poR.append(" A.PAY_STATUS, "      );
poR.append(" A.MM_CLAIM_DT, "      );
poR.append(" A.MM_CLAIM_AMT, "      );
poR.append(" TO_CHAR(A.MM_REL_DT, 'DD-MON-YYYY') AS MM_REL_DT, "      );
poR.append(" A.MM_REL_AMT, "      );
poR.append(" CASE WHEN A.PBATCH_ID > 562 THEN 500ELSE 0 END APPFEES, "      );
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
poR.append(" AND A.APP_ID=? "      );

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
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
NETMMRELAMT=rsMain.getString("NETMMRELAMT")==null?"":rsMain.getString("NETMMRELAMT");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
UTRN_NO=rsMain.getString("UTRN_NO")==null?"":rsMain.getString("UTRN_NO");



ResultSet rsMain1 = db.executeSQL(poR1.toString(),values);

while (rsMain1.next()){
APP_ID=rsMain1.getString("APP_ID")==null?"":rsMain1.getString("APP_ID");
SMS_SENT=rsMain1.getString("SMS_SENT")==null?"":rsMain1.getString("SMS_SENT");
EMAIL_SENT=rsMain1.getString("EMAIL_SENT")==null?"":rsMain1.getString("EMAIL_SENT");
add_update="U";

}
rsMain1.close();

}
rsMain.close();

 StringBuffer qrysb = new StringBuffer();
 
 
   qrysb.append(" Dear "+APP_NAME+" Your Applicant ID is  "+APP_ID+". Your PMEGP Margin Money");
   qrysb.append("( Govt. Subsidy) of Rs. "+NETMMRELAMT+" is released on "+MM_REL_DT+ " "); 
    qrysb.append(" to transient (non-customer) Ac of your Bank. Application fees of Rs. 500 ");
   qrysb.append("  has been deducted. Payment UTRN No. is "+UTRN_NO+ ". ");
   qrysb.append(" Contact financing branch for TDR as per PMEGP guidelines from KVIC");
 
 String pwd="Panda@1974";
 
 

%>
   
   <BR>
   <BR>
   <BR>
   <BR>
   <LABEL>AA
   <INPUT name="APP_ID" type="text" id="APP_ID" value="<%= APP_ID %>" readonly="true">
   <BR>
      <INPUT name="PBATCH_ID" type="text" id="PBATCH_ID" value="<%= PBATCH_ID %>" readonly="true">
   </LABEL>
   <BR>
 </P>
 <CENTER>
  
   
   <BR>
<BR>
	
 <TABLE id="example" class="display"  border="1">
 <TR>
 <TD>
 <%= qrysb.toString() %>
  <%
  
  if (add_update.equals("I")) {
  SMSServices sms1=new SMSServices();
 
sms1.sendSingleSMS("KVICDIT", pwd ,qrysb.toString(), "KVICIT", MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007661140349407696");


 }



 %>
 <INPUT name="ins" id="ins" type="hidden" value="<%= add_update %>">
	
   </TD>
 </TR>
 <TR>
 <td>
   <DIV align="center">
     <INPUT type="button" name="Submit" onClick="submitform();" value="Send">
     </DIV></td>
 </TR>

 </TABLE>
<%

if ((String)request.getParameter("ins")!=null){ 
values.clear();
APP_ID =(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
SMS_SENT =(String) request.getParameter("SMS_SENT")==null?"":(String) request.getParameter("SMS_SENT").trim();

StringBuffer qryUpdate = new StringBuffer();

if (!add_update.equals("U")) {
//INSERT INTO LOG
qryUpdate.append(" INSERT INTO SMSEMAIL_SEND_LOG ");
qryUpdate.append("( SMS_SENT ,");
qryUpdate.append(" APP_ID");
qryUpdate.append( ") VALUES (SYSDATE,?) ");

}
else
{


qryUpdate.append("	UPDATE SMSEMAIL_SEND_LOG SET ");
qryUpdate.append("	SMS_SENT= SYSDATE ");
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
