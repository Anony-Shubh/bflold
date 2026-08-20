<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.io.*, pkgPmegpNew.DBCon"  %>

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
var urlpar='appAnnTurnover.jsp?appid='+pIFSC;
 modalWin.ShowURL(urlpar,700,1200,'Find Bank Details',null,null);
 }//END OF FUNCTION
 
 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refresh_data(){
form.submit();
}
 
 </script>
</head>
<body >
<form  method="post"  name="form" action="appSearchdata.jsp">
<img src="../images/pmegponline.jpg" width="100%" height="150">

 <%@ include file="AppIncludePage.jsp" %>
    <div align="center">
      <p>
        <%
  String EMAIL =request.getParameter("EMAIL")==null?"":(String) request.getParameter("EMAIL") ;
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

String PINCODE = "";
String FIN_NOD = "";
String BANK_ID = "";
String BANK_FLAG = "";
String APP_ID = "";
String APP_NAME = "";
String MM_REL_DT = "";
String MM_REL_AMT = "";
String HIRTWO = "";
String BRANCH_NAME = "";
String TRANS_ACNO = "";
String E_MAIL = "";
String RESETYN = "";
DBCon db= new DBCon();
db.connect();

StringBuffer qyrSel= new StringBuffer();
qyrSel.append(" SELECT AD.APP_ID,AD.APP_NAME,TO_CHAR(MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,MM_REL_AMT,AD.E_MAIL FROM APP_DETAIL AD,BANK_DATAENTRY BD WHERE AD.APP_ID=BD.APP_ID ");
qyrSel.append(" AND BD.MM_REL_DT IS NOT NULL AND BD.PACT_ID=34  AND TRIM(UPPER(AD.E_MAIL)) = TRIM(?) ");
EMAIL=EMAIL.toUpperCase();



List values=new ArrayList();
values.add(EMAIL);		

//out.print(qyrSel.toString());	
			
ResultSet rsMain = db.executeSQL(qyrSel.toString(),values);
values.clear();

%>
        
        <span class="GreenLebel">APPLICANT VIEW FORM    </span></p>
      <p>&nbsp;</p>
    </div>
    <table border="1" align="center">
    <tr>
      <th colspan="2" scope="col">Search by Email Id: </th>
      <td colspan="2" scope="col"><input name="EMAIL" type="text" id="EMAIL" size="50" maxlength="50" value="<%= EMAIL %>"></td>
      <td colspan="6" scope="col"><input name="btnSearch" type="submit" class="button" id="btnSearch" value="Search"></td>
      </tr>
    <tr>
      <th scope="col">APPLICATION ID </th>
      <th scope="col">APPLICATION NAME</th>
      <th scope="col">MM_REL_DT</th>
      <th scope="col">MM REL AMT</th> 
      <th scope="col">&nbsp;</th>
      </tr>
  
  
  
  <%
  
  int countr=0;
  while (rsMain.next()) {
  countr = countr+1;
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");

  %>
  

    <tr>
      <th scope="row"><%= APP_ID %></th>
      <td><%= APP_NAME %></td>
      <td><%= MM_REL_AMT %></td>
      <td><%= MM_REL_DT %></td>
        
      <td> <input name="sendEmail" type="button" class="button" onClick="ShowResetPage('<%= APP_ID %>');" value="Update"> </td>
      </tr>
  </table>
  
  
 <%
 
		
 }
 rsMain.close();
 db.close();
 
 %>
 
 <center><h2 class="redLebel"> Enter Registered Email Id and Click on  Search Button........</h2>
 </center>

</form>
 
</body>
</html>
