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
    <style type="text/css">
<!--
.style9 {font-size: 18px}

-->
    </style>
</HEAD>



<BODY>
  <FORM method="post" name="form" id="form">

 <p>
   <%
String PBATCH_ID=request.getParameter("PBATCH_ID")==null?"":(String) request.getParameter("PBATCH_ID");
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String APP_NAME="";
String MM_REL_AMT="";
String MM_REL_DT="";
String UTRN_NO="";
String NETMMRELAMT="";
String MOB_NO1="";
String add_update=request.getParameter("ins")==null?"":(String) request.getParameter("ins");;




DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT UPPER(B.APP_NAME) AS APP_NAME, "      );
poR.append(" B.APP_ID, "      );
poR.append(" A.BATCH_DATE, B.MOB_NO1, "      );
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
poR.append(" AND A.PBATCH_ID   = ? AND A.APP_ID=? "      );

values.add(PBATCH_ID);
values.add(APP_ID);
ResultSet rsMain = db.executeSQL(poR.toString(),values);


while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
UTRN_NO=rsMain.getString("UTRN_NO")==null?"":rsMain.getString("UTRN_NO");
NETMMRELAMT=rsMain.getString("NETMMRELAMT")==null?"":rsMain.getString("NETMMRELAMT");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
}
rsMain.close();
db.close();
 StringBuffer qrysb = new StringBuffer();
 
   qrysb.append(" Dear "+APP_NAME+" ( "+APP_ID+") your PMEGP Margin Money");
   qrysb.append(" ( Govt. Subsidy) of Rs. "+NETMMRELAMT+" is released on "+MM_REL_DT+ " "); 
    qrysb.append(" to transient (non-customer) A/c of Your Financing Branch. Application fees of Rs. 500 ");
   qrysb.append("  has been deducted. Payment UTRN No. is "+UTRN_NO+ ". ");
   qrysb.append(" Contact financing branch for TDR as per PMEGP guidelines from KVIC");
 
 
 
 

%>
   
   <br>
   <br>
   <br>
   <br>
   <label>AA
   <input name="APP_ID" type="text" id="APP_ID" value="<%= APP_ID %>" readonly="true">
   <br>
      <input name="PBATCH_ID" type="text" id="PBATCH_ID" value="<%= PBATCH_ID %>" readonly="true">
   </label>
   <br>
 </p>
 <CENTER>
  
   
   <br>
<br>
	
 <table id="example" class="display"  border="1">
 <tr>
 <td>
 <%= qrysb.toString() %>
  <%
  
  if (add_update.equals("I")) {
  SMSServices sms1=new SMSServices();
 //MOB_NO1="9987402341,9987875805,"+MOB_NO1;

sms1.sendSingleSMS("KVICDIT", "Panda@1974",qrysb.toString(), "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d");
response.sendRedirect("savemsg.jsp");
 }



 %>
 <INPUT name="ins" id="ins" type="hidden" value="<%= add_update %>">
<INPUT type="button" name="Submit" onClick="submitform();" value="Send">	
   </td>
 </tr>

 </table>
   

</FORM>


</CENTER>
</BODY>

</HTML>
