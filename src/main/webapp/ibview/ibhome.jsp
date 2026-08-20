
<%@ page session="true" import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<title>FB Profile View Page</title>
 <link rel="stylesheet" type="text/css" href="../css/dis.css">
  <script>
  function form_submit(){  
	var APP_ID = document.form.APP_ID.value;
	if (APP_ID== "") {	 inlineMsg ( 'APP_ID','ENTER APPLICATION ID',2);	return (false);}    	
	document.form.submit();

}


</script>
</head>
<body >

<form  method="post"  name="form" action="ibhome.jsp" >
<%@ include file="IncludeHeader.jsp" %>
    <div align="center">
      <p>
        <%
  String APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
  
String TR_ID = "";

String APP_NAME = "";
String MOB_NO1 = "";
String GENDER = "";
String E_MAIL = "";
String UNIT_LOC = "";
String AADHAR_NO = "";
String PAN_NO = "";
String DISTRICT_NAME = "";
String STATE_NM = "";
String IFSC_CODE = "";
String BANK_NAME = "";
String BRANCHNAME = "";
String MM_CLAIM_DT = "";
String MM_CLAIM_AMT = "";
String APP_FEES = "";
String PBATCH_ID = "";
String BATCH_DATE = "";
String MM_REL_AMT = "";
String MM_REL_DT = "";
String UTRN_NO = "";
String PAY_STATUS = "";
String MMCLAIM_TRANSACNO = "";
String FAIL_REASON = "";
String CREENT_NEFT_IFSC = "";
String CURRENT_TRACCNO = "";
String PAYBLE_MM = "";
String BR_IFSL_CODE = "";
String SANC_YR="";

String NODAL_BANK = "";
String PFMS_TRANS_ACNO = "";
String PFMS_BENCODE = "";
String PFMS_NEFT = "";
String PFMS_BANKNAME = "";
String PFMS_UPDATE = "";
String VALIDATION_REMARKS = "";
String PFMS_BENNM_PASSBOOK = "";
String EMAIL = "";
String CONT_NO = "";


DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT BD.TR_ID,"      );
qrysb.append("     BD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.GENDER,"      );
qrysb.append("     AD.E_MAIL,"      );
qrysb.append("     AD.UNIT_LOC,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     AD.PAN_NO,"      );
qrysb.append("      MD.DISTRICT_NAME,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.BRANCHNAME,"      );
qrysb.append("     TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-RRRR') AS MM_CLAIM_DT, "      );
qrysb.append("     BD.MM_CLAIM_AMT,"      );
qrysb.append("     500 AS APP_FEES,"      );
qrysb.append("     BD.PBATCH_ID,"      );
qrysb.append("     TO_CHAR(BD.BATCH_DATE,'DD-MON-RRRR') AS BATCH_DATE, "      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT, "      );
qrysb.append("     BD.UTRN_NO,"      );
qrysb.append("     BD.PAY_STATUS,"      );
qrysb.append("     BD.FB_ACNO AS MMCLAIM_TRANSACNO,"      );
qrysb.append("     BD.FAIL_REASON,"      );
qrysb.append("     FGETNEFTIFSCODE(AD.APP_ID) AS CREENT_NEFT_IFSC,"      );
qrysb.append("     BBM.TRANS_ACNO             AS CURRENT_TRACCNO,"      );
qrysb.append("     BD.MM_CLAIM_AMT - 500      AS PAYBLE_MM,getfinyr(bd.loan_sanc_dt) AS SANC_YR, "      );

qrysb.append("  CASE WHEN BD.PBATCH_ID>700 THEN'Indian Bank' ELSE 'Corporation Bank' end NODAL_BANK ,"      );

qrysb.append(" BBM.PFMS_TRANS_ACNO,  "      );
 qrysb.append("  BBM.PFMS_BENCODE,  "      );
 qrysb.append("  BBM.PFMS_NEFT,  "      );
  qrysb.append(" BBM.PFMS_BANKNAME,  "      );
 qrysb.append("  BBM.PFMS_UPDATE,  "      );
 qrysb.append("  BBM.VALIDATION_REMARKS,  "      );
 qrysb.append("  BBM.PFMS_BENNM_PASSBOOK , "      );
 qrysb.append("  BBM.EMAIL,  "      );
  qrysb.append("   BBM.CONT_NO  "      );
qrysb.append("   FROM BANK_DATAENTRY BD,"      );
qrysb.append("     APP_DETAIL AD,"      );
qrysb.append("     BANK_BR_MAST BBM,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS"      );
qrysb.append("   WHERE AD.APP_ID      = BD.APP_ID"      );
qrysb.append("   AND AD.UNIT_DIST_CD  = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD      = MS.STATE_CD"      );
qrysb.append("   AND BBM.BR_IFSL_CODE = AD.IFSC_CODE"      );
qrysb.append("   AND BBM.BR_IFSL_CODE = RBL.IFSC_CODE"      );
//qrysb.append("   AND BD.PBATCH_ID     > 700"      );
qrysb.append("   AND BD.FAIL_REASON  IS NOT NULL AND TO_NUMBER(substr(BD.APP_ID,instr(BD.APP_ID,'-')+1,length(BD.APP_ID)))=?"      );

BR_IFSL_CODE=BR_IFSL_CODE.toUpperCase();
List values=new ArrayList();
values.add(APP_ID);		
 int count=0;
			
ResultSet rsMain =db.executeSQL(qrysb.toString(),values); 
values.clear();

 while (rsMain.next()) {
  TR_ID=rsMain.getString("TR_ID")==null?"":rsMain.getString("TR_ID");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
UNIT_LOC=rsMain.getString("UNIT_LOC")==null?"":rsMain.getString("UNIT_LOC");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
APP_FEES=rsMain.getString("APP_FEES")==null?"":rsMain.getString("APP_FEES");
PBATCH_ID=rsMain.getString("PBATCH_ID")==null?"":rsMain.getString("PBATCH_ID");
BATCH_DATE=rsMain.getString("BATCH_DATE")==null?"":rsMain.getString("BATCH_DATE");
MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
UTRN_NO=rsMain.getString("UTRN_NO")==null?"":rsMain.getString("UTRN_NO");
PAY_STATUS=rsMain.getString("PAY_STATUS")==null?"":rsMain.getString("PAY_STATUS");
MMCLAIM_TRANSACNO=rsMain.getString("MMCLAIM_TRANSACNO")==null?"":rsMain.getString("MMCLAIM_TRANSACNO");
FAIL_REASON=rsMain.getString("FAIL_REASON")==null?"":rsMain.getString("FAIL_REASON");
CREENT_NEFT_IFSC=rsMain.getString("CREENT_NEFT_IFSC")==null?"":rsMain.getString("CREENT_NEFT_IFSC");
CURRENT_TRACCNO=rsMain.getString("CURRENT_TRACCNO")==null?"":rsMain.getString("CURRENT_TRACCNO");
PAYBLE_MM=rsMain.getString("PAYBLE_MM")==null?"":rsMain.getString("PAYBLE_MM");
SANC_YR=rsMain.getString("SANC_YR")==null?"":rsMain.getString("SANC_YR");

NODAL_BANK=rsMain.getString("NODAL_BANK")==null?"":rsMain.getString("NODAL_BANK");
PFMS_TRANS_ACNO=rsMain.getString("PFMS_TRANS_ACNO")==null?"":rsMain.getString("PFMS_TRANS_ACNO");
PFMS_BENCODE=rsMain.getString("PFMS_BENCODE")==null?"":rsMain.getString("PFMS_BENCODE");
PFMS_NEFT=rsMain.getString("PFMS_NEFT")==null?"":rsMain.getString("PFMS_NEFT");
PFMS_BANKNAME=rsMain.getString("PFMS_BANKNAME")==null?"":rsMain.getString("PFMS_BANKNAME");
PFMS_UPDATE=rsMain.getString("PFMS_UPDATE")==null?"":rsMain.getString("PFMS_UPDATE");
VALIDATION_REMARKS=rsMain.getString("VALIDATION_REMARKS")==null?"":rsMain.getString("VALIDATION_REMARKS");
PFMS_BENNM_PASSBOOK=rsMain.getString("PFMS_BENNM_PASSBOOK")==null?"":rsMain.getString("PFMS_BENNM_PASSBOOK");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
CONT_NO=rsMain.getString("CONT_NO")==null?"":rsMain.getString("CONT_NO");


count=count+1;
}
rsMain.close();
db.close();

		
%>
      </p>
      <p>&nbsp;</p>
    </div>
	<p></p>
<p></p>
<p></p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th colspan="4"><div align="center">Nodal Bank View for failed Case only ( <%= USER_NM%> Login)
     
  </div></th>
  </tr>
 <tr>
  <th height="43" align="left" nowrap bgcolor="#CCCCCC" >   <input name="ins" type="hidden" id="ins" value="">	
  APPLICATION ID*(Please Enter digits after dash(-))</th>
   
	<td bgcolor="#CCCCCC"><input name="APP_ID" type="number" id="APP_ID" placeholder="SEARCH" size="12" maxlength="12">	</td>
    <td bgcolor="#CCCCCC"><input name="Button" type="button" class="button" onClick="form_submit();" value="SEARCH"></td>
 </tr>
	
	<tr>
	<th colspan="4">&nbsp;</th>                              
	</tr>
  </table> 
  
  
  <% if (!APP_ID.equals("")) { if (count > 0){ %>
  
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th colspan="3"><div align="center">Nodal Bank View for failed Case only (<%= USER_NM%>)  
  </div></th>
  </tr>
       
    <tr>
      <td bgcolor="#CCCCCC" colspan="3">&nbsp;</td>
    </tr>
     <tr bgcolor="#FF9966"><th colspan="3"><div align="center">Applicant detail</tH>
    </tr>
    
    <tr>
      <td align="right">1</td>
      <td>Transaction ID :</td>
      <td><%=TR_ID%></td>
    </tr>
    <tr>
      <td align="right">2</td>
      <td>Applicant ID :</td>
      <td><%=APP_ID%></td>
    </tr>
    <tr>
      <td align="right">3</td>
      <td>Applicant Name :</td>
      <td><%=APP_NAME%></td>
    </tr>
    <tr>
      <td align="right">4</td>
      <td>District :</td>
      <td><%=DISTRICT_NAME%></td>
    </tr>
    <tr>
      <td align="right">5</td>
      <td>State :</td>
      <td><%=STATE_NM%></td>
    </tr>
    <tr>
      <td align="right">6</td>
      <td>Sanction Year :</td>
      <td><%=SANC_YR%></td>
    </tr>
    
     <tr bgcolor="#FF9966"><th colspan="3"><div align="center">Financing Branch</tH>
    </tr>
   
    <tr>
      <td align="right">1</td>
      <td>Bank Name :</td>
      <td><%=BANK_NAME%></td>
    </tr>
    <tr>
      <td align="right">2</td>
      <td>IFS code :</td>
      <td><%=IFSC_CODE%></td>
    </tr>
    <tr>
      <td align="right">3</td>
      <td>Branch Name :</td>
      <td><%=BRANCHNAME%></td>
    </tr>
   
    <tr bgcolor="#FF9966"><th colspan="3"><div align="center">Marging Money(Govt.Subsidy)</tH>
    </tr>
   
    <tr>
      <td align="right">1</td>
      <td>Claim Date :</td>
      <td><%=MM_CLAIM_DT%></td>
    </tr>
    <tr>
      <td align="right">2</td>
      <td>MM Claim (in Rs) :</td>
      <td><%=MM_CLAIM_AMT%></td>
    </tr>
    <tr>
      <td align="right">3</td>
      <td>(Less)Application    Fees :</td>
      <td>(-)<%=APP_FEES%></td>
    </tr>
    <tr>
      <td align="right">4</td>
      <td>MM to be Release&nbsp; to FB:</td>
      <td><%=PAYBLE_MM%></td>
    </tr>
    <tr>
      <td align="right">5</td>
      <td>Trans Ac No (previous):</td>
      <td><%=MMCLAIM_TRANSACNO%></td>
    </tr>
    
    <tr>
      <td align="right">7</td>
      <td>MM Release Amount :</td>
      <td><%=MM_REL_AMT%></td>
    </tr>
    <tr>
      <td align="right">8</td>
      <td>MM Rease Date :</td>
      <td><%=MM_REL_DT%></td>
    </tr>
    <tr>
      <td align="right">9</td>
      <td>UTRN/Transaction no.:</td>
      <td><%=UTRN_NO%></td>
    </tr>
    
    <tr>
      <td align="right">11</td>
      <td>Pay Status :</td>
      <td><%=PAY_STATUS%></td>
    </tr>
    <tr>
      <td align="right">12</td>
      <td>Fail Reason :</td>
      <td><%=FAIL_REASON%></td>
    </tr>
    
      <tr bgcolor="#FF9966"><th colspan="3"><div align="center">Current Financing Branch A/C Detail</tH>   
    </tr>
    
    <tr>
      <td align="right">1</td>
      <td>Current Trans A/C No :</td>
      <th><%=CURRENT_TRACCNO%></th>
    </tr>
	









	 <tr>
      <td align="right">2</td>
      <td>Nodal Bank Name</td>
      <th><%=NODAL_BANK%></th>
    </tr>
	 <tr>
      <td align="right">3</td>
      <td>PFMS Registered Transient Ac No</td>
      <th><%=PFMS_TRANS_ACNO%></th>
    </tr>
	 <tr>
      <td align="right">4</td>
      <td>NEFT IFS Code</td>
      <th><%=PFMS_NEFT%></th>
    </tr>
	
	<tr>
      <td align="right">5</td>
      <td>PFMS Beneficiary Code</td>
      <th><%=PFMS_BENCODE%></th>
    </tr>
	
	
	 <tr>
      <td align="right">6</td>
      <td>Bank Name as Per PFMS</td>
      <th><%=PFMS_BANKNAME%></th>
    </tr>
	 <tr>
      <td align="right">7</td>
      <td>PFMS Update Date</td>
      <th><%=PFMS_UPDATE%></th>
    </tr>
	 <tr>
      <td align="right">8</td>
      <td>PFMS Validation Remark</td>
      <th><%=VALIDATION_REMARKS%></th>
    </tr>
	 <tr>
      <td align="right">9</td>
      <td>Account Name As per Passbook PFMS</td>
      <th><%=PFMS_BENNM_PASSBOOK%></th>
    </tr>
	 <tr>
      <td align="right">10</td>
      <td>Email</td>
      <th><%=EMAIL%></th>
    </tr>
	 <tr>
      <td align="right">11</td>
      <td>Contact No</td>
      <th><%=CONT_NO%></th>
    </tr>
	
	
  </table>
  <%} else{ %>
   <div align="center"><H2>ID is invalid/Not Yet Processed by IB/It is sucess Case</H2></div>
  <%}}%>
</form>
 
</body>
</html>
