<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/styleradiobutton.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<script language="javascript">


	
function submit_form () {
var APPROV_YN=document.form.APPROV_YN.value;

if(APPROV_YN == "") {
    inlineMsg('APPROV_YN','Select Approved or Not Approved',5);
    return false;
  }
  
 
 document.form.ins.value='I'; 
 document.form.submit()
}
</script>
<style type="text/css">
<!--
.style2 {color: #A0A0A0}
-->
</style>
</head>
<body>
<form   name="form" id ="form" method="post" >
<%

/*
SELECT 1 AS SRNO ,'Beneficiary' AS BENF_DESC,APP_NAME,E_MAIL,TO_CHAR(MOB_NO2) AS MOB_NO 
FROM APP_DETAIL AD WHERE APP_ID='DIGJ16176124-1542877'
UNION
SELECT 2. AS SRNO, 'Implementing Agency' AS BENF_DESC,OFF_NAME,
  MOM.OFF_EMAIL_ADDR AS EMAIL,
  TO_CHAR(MOM.PER1_NO) AS MOB_NO
FROM MAS_OFF_MAST MOM,APP_DETAIL AD
WHERE MOM.OFF_CD =AD.OFF_CD
AND APP_ID = 'DIGJ16176124-1542877' AND MOM.AGENCY_TYPE<>'KVIC'
UNION
SELECT 3 AS SRNO,'SO/DO of KVIC' AS BENF_DESC,OFF_NAME1,
  MOM.OFF_EMAIL_ADDR AS EMAIL,
  TO_CHAR(MOM.PER1_NO) AS MOB_NO
FROM MAS_OFF_MAST MOM,APP_DETAIL AD
WHERE AD.UNIT_DIST_CD=MOM.DISTRICT_CD AND MOM.AGENCY_TYPE='KVIC'
AND APP_ID = 'DIGJ16176124-1542877'
UNION
SELECT 4 AS SRNO,
'Financing Branch' AS BENF_DESC,
BR_IFSL_CODE ||', '||BBM.BR_NAME||', '||BBM.BRANCH_NAME AS BANK_DET,EMAIL,CONT_NO
FROM BANK_BR_MAST BBM, BANK_DATAENTRY BD WHERE BD.IFSC_CODE=BBM.BR_IFSL_CODE AND BD.APP_ID = 'DIGJ16176124-1542877'
UNION
SELECT 5 AS SRNO,'PMEGP' AS BENF_DESC,'Central office' AS OFF_NAME,
'regpkvic@gmail.com','9987402341' FROM DUAL
UNION
SELECT 6 AS SRNO,'Director PMEGP' AS BENF_DESC,'Smt.P M Joglekar' AS OFF_NAME,
'pmj04@rediffmail.com','9820213795' FROM DUAL
UNION
SELECT 7 AS SRNO,'Director IT' AS BENF_DESC,'Shri. M Rajan Babu' AS OFF_NAME,
'pmegpeportal@kvic.gov.in','9892222683' FROM DUAL

*/

String  APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");

String OFF_CD = (String) session.getAttribute("sOffCd");
String AGENCY_TYPE = "";
String OFF_NAME = "";
String APP_NAME = "";
String AADHAR_NO = "";
String BR_IFSL_CODE = "";
String APPLOAN_ACCNO = "";
String BR_NAME = "";
String BRANCH_NAME = "";
String MM_CLAIM_DT = "";
String MM_CLAIM_AMT = "";
String FB_ACNO = "";
String LOAN_DOCFNAME="";
String USER_ID = session.getAttribute("SUSER_ID")==null?"":(String) session.getAttribute("SUSER_ID");
String USER_TYPE = session.getAttribute("SUSER_TYPE")==null?"":(String) session.getAttribute("SUSER_TYPE");
String ACT_ID="";
String CO_REMARKS="";
String APPROV_YN="";
String PROC_DT="";
String ACT_DESC="";

DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     AD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     BBM.BR_IFSL_CODE,"      );
qrysb.append("     BD.APPLOAN_ACCNO,"      );
qrysb.append("     BBM.BR_NAME,"      );
qrysb.append("     BBM.BRANCH_NAME,"      );
qrysb.append("     TO_CHAR(BD.MM_CLAIM_DT, 'DD-MON-RRRR') AS MM_CLAIM_DT,"      );
qrysb.append("     BD.MM_CLAIM_AMT,"      );
qrysb.append("     BD.FB_ACNO,"      );
qrysb.append("     BD.LOAN_DOCFNAME,"      );
qrysb.append("     MRT.CO_REMARKS,"      );
qrysb.append("     MU.USER_DETAIL,"      );
qrysb.append("     BAS.ACT_DESC,"      );
qrysb.append("     BAS.ACT_ID, BD.APPRV_YN,"      );
qrysb.append("    TO_CHAR( MRT.PROC_DT,'DD-MON-RRRR') AS PROC_DT"      );
qrysb.append("   FROM BANK_DATAENTRY BD,"      );
qrysb.append("     APP_DETAIL AD,"      );
qrysb.append("     BANK_BR_MAST BBM,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     MM_REMARKS_TRANS MRT,"      );
qrysb.append("     MMCLAIM_USER MU,"      );
qrysb.append("     BANK_APP_STATUS BAS"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND BD.REMTRID        = MRT.REMTR_ID"      );
qrysb.append("   AND MRT.USER_ID       = MU.USER_ID"      );
qrysb.append("   AND MRT.PACT_ID       = BAS.ACT_ID"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("   AND BD.APP_ID         = ?  AND BD.APPRV_YN='S' "      );


//out.print (qrysb.toString());

List valuesq = new ArrayList();
valuesq.add(APP_ID);

   ResultSet rsMain  = db.executeSQL(qrysb.toString(),valuesq);
   valuesq.clear();

while (rsMain .next()){
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
BR_IFSL_CODE=rsMain.getString("BR_IFSL_CODE")==null?"":rsMain.getString("BR_IFSL_CODE");
APPLOAN_ACCNO=rsMain.getString("APPLOAN_ACCNO")==null?"":rsMain.getString("APPLOAN_ACCNO");
BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
LOAN_DOCFNAME=rsMain.getString("LOAN_DOCFNAME")==null?"":rsMain.getString("LOAN_DOCFNAME");
CO_REMARKS=rsMain.getString("CO_REMARKS")==null?"":rsMain.getString("CO_REMARKS");
APPROV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
PROC_DT=rsMain.getString("PROC_DT")==null?"":rsMain.getString("PROC_DT");
ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
}

rsMain .close();
%>
  <div>
  <table align="center">
    <tr>
      <th colspan="4"><div align="center">PMEGP MARGIN MONEY MM CLAIM APPROVAL FORM </div></th>
    </tr>
    <tr>
      <th width="237"><div align="right">
          <input name="ins" type="hidden" id="ins">
      Applicant Id : </div></th>
      <th width="122"><%=APP_ID %> </th>
      <th width="188"><div align="right">Name Of Applicant :</div></th>
      <th width="36"><%=  APP_NAME %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Agency Name(<%= AGENCY_TYPE %>): </div></th>
      <th colspan="3" nowrap ><%= OFF_NAME %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Bank IFS Code: </div></th>
      <th nowrap ><%= BR_IFSL_CODE %></th>
      <th nowrap ><div align="right">Transient A/c No:</div></th>
      <th nowrap ><%= FB_ACNO %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Bank Address:</div></th>
      <th colspan="3" nowrap ><%= BR_NAME %><br>
        <%= BRANCH_NAME %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Margin Money Claim Amount: </div></th>
      <th nowrap ><%= MM_CLAIM_AMT %></th>
      <th nowrap ><div align="right">Claim Date:</div></th>
      <th nowrap ><%= MM_CLAIM_DT %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Status:</div></th>
      <td colspan="3" nowrap ><%= ACT_DESC %></td>
    </tr>
    <tr valign="middle">
      <th><div align="right">Process Date: </div></th>
      <td colspan="3" nowrap ><%= PROC_DT %></td>
    </tr>
    <tr valign="middle">
      <th><div align="right">Remarks Detail : </div></th>
      <td colspan="3" nowrap ><%= CO_REMARKS %></td>
    </tr>
    <tr>
      <th>&nbsp;</th>
      <td colspan="3"><input name="APPROV_YN" type="radio" value="S" checked></td>
    </tr>
    <tr>
      <th>Approved (Yes/N0
        )
        <div id="textarea_feedback"></div></th>
      <td><input name="APPROV_YN" type="radio" value="A"> 
        <span class="mtextarea">Approved</span></td>
      <td colspan="2"><input name="APPROV_YN" type="radio" value="R">
        <span class="redLebel">Not Approved </span></td>
    </tr>
    <tr>
      <th colspan="4"> <div align="center">
          <input name="btnSubmit" type="button" class="button" id="btnSubmit"  onClick="submit_form();" value="Submit">
      </div></th>
    </tr>
  </table>
  <%

if ((String)request.getParameter("ins")!=null){
try {
String REMTR_ID="";
//ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
//CO_REMARKS=(String) request.getParameter("CO_REMARKS")==null?"":(String) request.getParameter("CO_REMARKS").trim();

APPROV_YN=(String) request.getParameter("APPROV_YN")==null?"S":(String) request.getParameter("APPROV_YN").trim();
List values=new ArrayList();
List pstm=new ArrayList();
/*
StringBuffer qryUpdate = new StringBuffer();

  ResultSet rsMax = db.execSQL(" SELECT MMPROCREMSEQ.NEXTVAL FROM DUAL ");
  while (rsMax.next()){
  REMTR_ID=rsMax.getString(1);
  }
  rsMax.close();
  
qryUpdate.append("  INSERT INTO  MM_REMARKS_TRANS (REMTR_ID,PROC_DT,USER_TYPE,PACT_ID,CO_REMARKS,APP_ID,IFSC_CODE,USER_ID) ");
qryUpdate.append(" values (?,SYSDATE,?,?,?,?,?,?) ");

values.clear();
pstm.clear();

values.add(REMTR_ID); pstm.add ("L");
values.add(USER_TYPE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(CO_REMARKS); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(BR_IFSL_CODE); pstm.add ("L");
values.add(USER_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
*/
String Updt= "UPDATE BANK_DATAENTRY SET APPRV_YN=? WHERE APP_ID=? AND IFSC_CODE=?  AND APP_ID IN ( SELECT APP_ID FROM APP_DETAIL WHERE ACT_YN='Y' AND APP_ID=?) ";
values.add(APPROV_YN); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(BR_IFSL_CODE); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(Updt);
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
db.close();
response.sendRedirect("savemsg.jsp");
}catch (Exception e) {out.print (e.toString());}
}

%>

</form>
</body>
</html>
