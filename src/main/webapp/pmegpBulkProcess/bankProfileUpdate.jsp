<%@ page session="true" buffer="50kb" import="java.sql.*,java.util.*,java.io.*, pkgPmegpNew.DBCon"  %>

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
<title>PMEGP Bank Data Entry Form</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript">
function form_submit() {
document.form.ins.value='I';
document.form.submit();

}
</script>
</head>
<body >
<form  method="post"  name="form">
  <%
String BR_IFSL_CODE =(String) session.getAttribute("SBR_IFSL_CODEs");
String ins =request.getParameter("ins")==null?"":(String) request.getParameter("ins") ;

String BR_NAME = "";
String BR_TYPE = "";
String BR_ADDR = "";
String DISTRICT = "";
String STATE = "";
String CONT_NAME = "";
String DESIG = "";
String CONT_NO = "";
String FAX_NO = "";
String REMARKS = "";
String PSSWD = "";
String ACT_YN = "";
String EMAIL_VALID_YN = "";
String EMAIL_VALID_DT = "";
String TIMESTAMP = "";
String EMAIL = "";
String PINCODE = "";
String FIN_NOD = "";
String BANK_ID = "";
String BANK_FLAG = "";
String BR_ID = "";
String N_IFSC_CODE = "";
String SPON_BANK_NAME = "";
String HIRONE = "";
String HIRTWO = "";
String BRANCH_NAME = "";
String TRANS_ACNO = "";
String EMAIL_FILE = "";
String RESETYN = "";
 
DBCon db= new DBCon();
db.connect();

StringBuffer qyrSel= new StringBuffer();

qyrSel.append(" SELECT ");
qyrSel.append("BR_IFSL_CODE,");
qyrSel.append("BR_NAME,");
qyrSel.append("BR_TYPE,");
qyrSel.append("BR_ADDR,");
qyrSel.append("DISTRICT,");
qyrSel.append("STATE,");
qyrSel.append("CONT_NAME,");
qyrSel.append("DESIG,");
qyrSel.append("CONT_NO,");
qyrSel.append("FAX_NO,");
qyrSel.append("REMARKS,");
qyrSel.append("PSSWD,");
qyrSel.append("ACT_YN,");
qyrSel.append("EMAIL_VALID_YN,");
qyrSel.append("EMAIL_VALID_DT,");
qyrSel.append("TIMESTAMP,");
qyrSel.append("EMAIL,");
qyrSel.append("PINCODE,");
qyrSel.append("FIN_NOD,");
qyrSel.append("BANK_ID,");
qyrSel.append("BANK_FLAG,");
qyrSel.append("BR_ID,");
qyrSel.append("N_IFSC_CODE,");
qyrSel.append("SPON_BANK_NAME,");
qyrSel.append("HIRONE,");
qyrSel.append("HIRTWO,");
qyrSel.append("BRANCH_NAME,");
qyrSel.append("TRANS_ACNO,");
qyrSel.append("EMAIL_FILE,");
qyrSel.append("RESETYN");
qyrSel.append("  FROM BANK_BR_MAST WHERE BR_IFSL_CODE=? ");

List values=new ArrayList();
List pstm=new ArrayList();

values.add(BR_IFSL_CODE);		
ResultSet rsMain = db.executeSQL(qyrSel.toString(),values);
values.clear();


while (rsMain.next()) {
BR_IFSL_CODE=rsMain.getString("BR_IFSL_CODE")==null?"":rsMain.getString("BR_IFSL_CODE");
BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
BR_TYPE=rsMain.getString("BR_TYPE")==null?"":rsMain.getString("BR_TYPE");
BR_ADDR=rsMain.getString("BR_ADDR")==null?"":rsMain.getString("BR_ADDR");
DISTRICT=rsMain.getString("DISTRICT")==null?"":rsMain.getString("DISTRICT");
STATE=rsMain.getString("STATE")==null?"":rsMain.getString("STATE");
CONT_NAME=rsMain.getString("CONT_NAME")==null?"":rsMain.getString("CONT_NAME");
DESIG=rsMain.getString("DESIG")==null?"":rsMain.getString("DESIG");
CONT_NO=rsMain.getString("CONT_NO")==null?"":rsMain.getString("CONT_NO");
FAX_NO=rsMain.getString("FAX_NO")==null?"":rsMain.getString("FAX_NO");
REMARKS=rsMain.getString("REMARKS")==null?"":rsMain.getString("REMARKS");
PSSWD=rsMain.getString("PSSWD")==null?"":rsMain.getString("PSSWD");
ACT_YN=rsMain.getString("ACT_YN")==null?"":rsMain.getString("ACT_YN");
EMAIL_VALID_YN=rsMain.getString("EMAIL_VALID_YN")==null?"":rsMain.getString("EMAIL_VALID_YN");
EMAIL_VALID_DT=rsMain.getString("EMAIL_VALID_DT")==null?"":rsMain.getString("EMAIL_VALID_DT");
TIMESTAMP=rsMain.getString("TIMESTAMP")==null?"":rsMain.getString("TIMESTAMP");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
PINCODE=rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
FIN_NOD=rsMain.getString("FIN_NOD")==null?"":rsMain.getString("FIN_NOD");
BANK_ID=rsMain.getString("BANK_ID")==null?"":rsMain.getString("BANK_ID");
BANK_FLAG=rsMain.getString("BANK_FLAG")==null?"":rsMain.getString("BANK_FLAG");
BR_ID=rsMain.getString("BR_ID")==null?"":rsMain.getString("BR_ID");
N_IFSC_CODE=rsMain.getString("N_IFSC_CODE")==null?"":rsMain.getString("N_IFSC_CODE");
SPON_BANK_NAME=rsMain.getString("SPON_BANK_NAME")==null?"":rsMain.getString("SPON_BANK_NAME");
HIRONE=rsMain.getString("HIRONE")==null?"":rsMain.getString("HIRONE");
HIRTWO=rsMain.getString("HIRTWO")==null?"":rsMain.getString("HIRTWO");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
TRANS_ACNO=rsMain.getString("TRANS_ACNO")==null?"":rsMain.getString("TRANS_ACNO");
EMAIL_FILE=rsMain.getString("EMAIL_FILE")==null?"":rsMain.getString("EMAIL_FILE");
RESETYN=rsMain.getString("RESETYN")==null?"":rsMain.getString("RESETYN");
}

rsMain.close();
		
%>
  <table align="center">
  <tr>
    <th colspan="4"><div align="center">Financing Branch Update Form </div></th>
    </tr>
  <tr>
    <td colspan="4"><div align="right"><a href="bankProfileView.jsp" class="greenButtonRound">Home</a></div></td>
    </tr>
  <tr>
    <th>Branch IFS Code     </th>
    <td colspan="3">  <input name="BR_IFSL_CODE" type="text" id="BR_IFSL_CODE" value="<%=BR_IFSL_CODE%>" size="11" maxlength="11" readonly="true">
      <input name="btnRBIBankList" type="button" class="button" id="btnRBIBankList" value="RBI BANKLIST" onClick="ShowBankLov();"></td>
  </tr>  
<tr>
  <th>Bank Name     </th>
  <td colspan="3">  <input name="BR_NAME" type="text" id="BR_NAME" value="<%=BR_NAME%>" size="70" maxlength="70" readonly="true">  </td></tr>  
<tr>
  <th>Branch Name </th>
  <td colspan="3"><input name="BRANCH_NAME"  type="text"  id="BRANCH_NAME" value="<%=BRANCH_NAME%>" size="50" maxlength="120"></td>
</tr>
<tr>
  <th>Bank Type     </th>
  <td colspan="3">  <input name="BR_TYPE"  type="text"  id="BR_TYPE" value="<%=BR_TYPE%>" size="20" maxlength="20">  </td></tr>  
<tr>
  <th>Address    </th>
  <td colspan="3">  <input name="BR_ADDR"  type="text"  id="BR_ADDR" value="<%=BR_ADDR%>" size="50" maxlength="300">  </td></tr>  
<tr>
  <th>State </th>
  <td><input name="STATE"  type="text"  id="STATE" value="<%=STATE%>" size="20" maxlength="20"></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <th>District    </th>
  <td>  <input name="DISTRICT"  type="text"  id="DISTRICT" value="<%=DISTRICT%>" size="40" maxlength="40">  </td>
  <th>Pin Code </th>
  <td><input name="PINCODE"  type="text"  id="PINCODE" value="<%=PINCODE%>" size="10" maxlength="6"></td>
</tr>  
  

<tr>
  <th>Email ID: </th>
  <td colspan="3"><input name="EMAIL"  type="text"  id="EMAIL" value="<%=EMAIL%>" size="40" maxlength="60"></td>
</tr>
<tr>
  <th>Contact Person Name     </th>
  <td>  <input name="CONT_NAME"  type="text"  id="CONT_NAME" value="<%=CONT_NAME%>" size="40" maxlength="40">  </td>
  <th>Designation </th>
  <td><input name="DESIG"  type="text"  id="DESIG" value="<%=DESIG%>" size="30" maxlength="30"></td>
</tr>  
  
<tr>
  <th>Contact Mobile No. </th>
  <td>  <input name="CONT_NO"  type="text"  id="CONT_NO" value="<%=CONT_NO%>" size="15" maxlength="10">  </td>
  <th>Telephone/Fax No: </th>
  <td><input name="FAX_NO"  type="text"  id="FAX_NO" value="<%=FAX_NO%>" size="30" maxlength="30"></td>
</tr>  
<tr>
  <th>Transient Account No: </th>
  <th colspan="3"><input name="TRANS_ACNO"  type="text"  id="TRANS_ACNO" value="<%=TRANS_ACNO%>" size="20" maxlength="20">
    <input name="ins" type="hidden" id="ins">
    (Carefully Enter the Account N0) </th>
</tr>

<tr>
  <th>Remarks    </th>
  <td colspan="3">  <input name="REMARKS"  type="text"  id="REMARKS" value="<%=REMARKS%>" size="50" maxlength="100">  </td></tr>  
  
  
<tr>
  <th>Bank ID     </th>
  <td>  <input name="BANK_ID" type="text" id="BANK_ID" value="<%=BANK_ID%>" size="10" maxlength="10" readonly="true">  </td>
  <th>Branch ID </th>
  <td><input name="BR_ID" type="text" id="BR_ID" value="<%=BR_ID%>" size="16" maxlength="16" readonly="true"></td>
</tr>  
  
<tr>
  <th>Nodal Bank ID </th>
  <td colspan="3">  <input name="N_IFSC_CODE" type="text" id="N_IFSC_CODE" value="<%=N_IFSC_CODE%>" size="15" maxlength="15" readonly="true">  </td></tr>  
<tr>
  <th>Sponsoring Bank </th>
  <td colspan="3">  <input name="SPON_BANK_NAME" type="text" id="SPON_BANK_NAME" value="<%=SPON_BANK_NAME%>" size="60" maxlength="60" readonly="true">  </td></tr>  
<tr>
  <th>Region Name </th>
  <td colspan="3">  <input name="HIRONE" type="text" id="HIRONE" value="<%=HIRONE%>" size="50" maxlength="50" readonly="true">  </td></tr>  
<tr>
  <th>Zone Name     </th>
  <td colspan="3">  <input name="HIRTWO" type="text" id="HIRTWO" value="<%=HIRTWO%>" size="50" maxlength="50" readonly="true">  </td></tr>
<tr>
  <th colspan="4"><div align="center">
    <input name="Button" type="button" class="button" value="Save Data" onClick="form_submit();">
  </div></th>
  </tr>  
  </table>
 <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowBankLov(){
 var ifsc =document.form.BR_IFSL_CODE.value;
var urlpar='APPRBIBANKLOV.jsp?BRIFSC='+ifsc;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,500,1200,'Find Bank Details',null,callbackFunctionArray);
 
 }//END OF FUNCTION
 

function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}


function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function getBankLOV(BR_NAME,BRANCH_NAME,BR_ADDR,STATE,DISTRICT,PINCODE){
 form.BR_NAME.value=BR_NAME;
 form.BRANCH_NAME.value=BRANCH_NAME;
 form.BR_ADDR.value=BR_ADDR;
form.DISTRICT.value=DISTRICT;
form.STATE.value=STATE;
form.PINCODE.value=PINCODE;
}

</script>


<%
if (ins.equals("I")) {


BR_NAME=(String) request.getParameter("BR_NAME")==null?"":(String) request.getParameter("BR_NAME").trim();
BR_TYPE=(String) request.getParameter("BR_TYPE")==null?"":(String) request.getParameter("BR_TYPE").trim();
BR_ADDR=(String) request.getParameter("BR_ADDR")==null?"":(String) request.getParameter("BR_ADDR").trim();
DISTRICT=(String) request.getParameter("DISTRICT")==null?"":(String) request.getParameter("DISTRICT").trim();
STATE=(String) request.getParameter("STATE")==null?"":(String) request.getParameter("STATE").trim();
CONT_NAME=(String) request.getParameter("CONT_NAME")==null?"":(String) request.getParameter("CONT_NAME").trim();
DESIG=(String) request.getParameter("DESIG")==null?"":(String) request.getParameter("DESIG").trim();
CONT_NO=(String) request.getParameter("CONT_NO")==null?"":(String) request.getParameter("CONT_NO").trim();
FAX_NO=(String) request.getParameter("FAX_NO")==null?"":(String) request.getParameter("FAX_NO").trim();
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
EMAIL=(String) request.getParameter("EMAIL")==null?"":(String) request.getParameter("EMAIL").trim();
PINCODE=(String) request.getParameter("PINCODE")==null?"":(String) request.getParameter("PINCODE").trim();
FIN_NOD=(String) request.getParameter("FIN_NOD")==null?"":(String) request.getParameter("FIN_NOD").trim();
BANK_ID=(String) request.getParameter("BANK_ID")==null?"":(String) request.getParameter("BANK_ID").trim();
BANK_FLAG=(String) request.getParameter("BANK_FLAG")==null?"":(String) request.getParameter("BANK_FLAG").trim();
BR_ID=(String) request.getParameter("BR_ID")==null?"":(String) request.getParameter("BR_ID").trim();
N_IFSC_CODE=(String) request.getParameter("N_IFSC_CODE")==null?"":(String) request.getParameter("N_IFSC_CODE").trim();
SPON_BANK_NAME=(String) request.getParameter("SPON_BANK_NAME")==null?"":(String) request.getParameter("SPON_BANK_NAME").trim();
HIRONE=(String) request.getParameter("HIRONE")==null?"":(String) request.getParameter("HIRONE").trim();
HIRTWO=(String) request.getParameter("HIRTWO")==null?"":(String) request.getParameter("HIRTWO").trim();
BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME").trim();
TRANS_ACNO=(String) request.getParameter("TRANS_ACNO")==null?"":(String) request.getParameter("TRANS_ACNO").trim();
EMAIL_FILE=(String) request.getParameter("EMAIL_FILE")==null?"":(String) request.getParameter("EMAIL_FILE").trim();


StringBuffer qrysb= new StringBuffer();

qrysb.append("UPDATE BANK_BR_MAST SET ");
qrysb.append("BR_NAME	=?,");
qrysb.append("BR_TYPE	=?,");
qrysb.append("BR_ADDR	=?,");
qrysb.append("DISTRICT	=?,");
qrysb.append("STATE	=?,");
qrysb.append("CONT_NAME	=?,");
qrysb.append("DESIG	=?, ");
qrysb.append("CONT_NO	=?,");
qrysb.append("FAX_NO	=?,");
qrysb.append("REMARKS	=?,");
qrysb.append("ACT_YN	=?,");
qrysb.append("EMAIL_VALID_YN	=?,");
qrysb.append("EMAIL	=?,");
qrysb.append("PINCODE	=? ,");
qrysb.append("FIN_NOD	=?,");
qrysb.append("BANK_ID	=?,");
qrysb.append("BANK_FLAG	=?,");
qrysb.append("BR_ID	=?,");
qrysb.append("N_IFSC_CODE	=?,");
qrysb.append("SPON_BANK_NAME	=? ,");
qrysb.append("HIRONE	=?,");
qrysb.append("HIRTWO	=?,");
qrysb.append("BRANCH_NAME	=?,");
qrysb.append("TRANS_ACNO	=? 	");
qrysb.append(" WHERE BR_IFSL_CODE	= ?");

values.clear();
pstm.clear();

values.add(BR_NAME); pstm.add ("L");
values.add(BR_TYPE); pstm.add ("L");
values.add(BR_ADDR); pstm.add ("L");
values.add(DISTRICT); pstm.add ("L");
values.add(STATE); pstm.add ("L");
values.add(CONT_NAME); pstm.add ("L");
values.add(DESIG); pstm.add ("L");
values.add(CONT_NO); pstm.add ("L");
values.add(FAX_NO); pstm.add ("L");
values.add(REMARKS); pstm.add ("L");
values.add(ACT_YN); pstm.add ("L");
values.add(EMAIL_VALID_YN); pstm.add ("L");
values.add(EMAIL); pstm.add ("L");
values.add(PINCODE); pstm.add ("L");
values.add(FIN_NOD); pstm.add ("L");
values.add(BANK_ID); pstm.add ("L");
values.add(BANK_FLAG); pstm.add ("L");
values.add(BR_ID); pstm.add ("L");
values.add(N_IFSC_CODE); pstm.add ("L");
values.add(SPON_BANK_NAME); pstm.add ("L");
values.add(HIRONE); pstm.add ("L");
values.add(HIRTWO); pstm.add ("L");
values.add(BRANCH_NAME); pstm.add ("L");
values.add(TRANS_ACNO); pstm.add ("L");
values.add(BR_IFSL_CODE); pstm.add ("L");

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

db.close();
response.sendRedirect("bankProfileView.jsp?SBR_IFSC_CODE="+BR_IFSL_CODE+"");

}// end of ins

%>
</form>
</body>
</html>
