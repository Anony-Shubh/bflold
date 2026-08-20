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
<title>FB Profile View Page</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript"	src="../js/ModalPopupWindow.js"></script>
<script language="javascript">
  var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowResetPage(pIFSC){
var urlpar='sendemail.jsp?SBR_IFSC_CODE='+pIFSC;
 modalWin.ShowURL(urlpar,500,700,'Find Bank Details',null,null);
 }//END OF FUNCTION
 
 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
 
 </script>
</head>
<body >
<form  method="post"  name="form" action="bankProfileView.jsp">
    <div align="center">
      <p>
        <%
  String BR_IFSL_CODE =request.getParameter("SBR_IFSC_CODE")==null?"":(String) request.getParameter("SBR_IFSC_CODE") ;
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
qyrSel.append("RESETYN   FROM BANK_BR_MAST WHERE BR_IFSL_CODE=? ");
BR_IFSL_CODE=BR_IFSL_CODE.toUpperCase();
List values=new ArrayList();
values.add(BR_IFSL_CODE);		

//out.print(qyrSel.toString());	
			
ResultSet rsMain = db.executeSQL(qyrSel.toString(),values);
values.clear();

		
%>
        
        <span class="GreenLebel">FINANCING BRANCH VIEW FORM    </span></p>
      <p>&nbsp;</p>
    </div>
    <table border="1" align="center">
    <tr>
      <th colspan="2" scope="col">Search by IFS Code: </th>
      <td colspan="2" scope="col"><input name="SBR_IFSC_CODE" type="text" id="SBR_IFSC_CODE" size="15" maxlength="11" value="<%= BR_IFSL_CODE %>"></td>
      <td colspan="6" scope="col"><input name="btnSearch" type="submit" class="button" id="btnSearch" value="Search"></td>
      </tr>
    <tr>
      <th scope="col">Bank Name </th>
      <th scope="col">Branch Name </th>
      <th scope="col">State</th>
      <th scope="col">Transient Account No </th>
      <th scope="col">Contact Person name </th>
      <th scope="col">Mobile No </th>
      <th scope="col">Branch Email ID </th>
      <th colspan="2" scope="col"><div align="center">Profile</div></th>
      <th scope="col">&nbsp;</th>
      </tr>
  
  
  
  <%
  
  int countr=0;
  while (rsMain.next()) {
  countr = countr+1;
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
  
  %>
  

    <tr>
      <th scope="row"><%= BR_NAME %></th>
      <td><%= BRANCH_NAME %></td>
      <td><%= STATE %></td>
      <td><%= TRANS_ACNO %></td>
      <td><%= CONT_NAME %></td>
      <td><%= CONT_NO %></td>
      <td><%= EMAIL %></td>
      <td><a href="updtsession.jsp?SBR_IFSC_CODE=<%= BR_IFSL_CODE %>" class="button">Update</a></td>
      <td><a href="#" class="button">Upload/view  email </a></td>
      <td> <input name="sendEmail" type="button" class="button" onClick="ShowResetPage('<%= BR_IFSL_CODE %>');" value="SEND MAIL"> </td>
      </tr>
  </table>
  
  
 <%
 }
 rsMain.close();
 db.close();
 
 %>
 
 <center><h2 class="redLebel"> Enter 11 digit IFS Code and Click on  Search Button........</h2>
 </center>

</form>
 
</body>
</html>
