<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<HTML>

<HEAD>
   <META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <LINK rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <LINK rel="stylesheet" type="text/css" href="../../css/dataTables.bootstrap4.min.css">
   <SCRIPT language="javascript" src="../../js/jquery-3.5.1.js"></SCRIPT>
    <SCRIPT language="javascript" src="../../js/ModalPopupWindow.js"></SCRIPT>
   <SCRIPT language="javascript" src="../../js/jquery.dataTables.min.js"></SCRIPT>
    <SCRIPT language="javascript" src="../../js/dataTables.bootstrap4.min.js"></SCRIPT>
    <SCRIPT>
        $(document).ready(function() {
            $('#example').DataTable();
        });

    </SCRIPT>

    
       <TITLE>    </TITLE>
       <style type="text/css">
<!--
.style5 {font-family: "Times New Roman", Times, serif}
-->
       </style>
</HEAD>



<BODY>

<%@ include file = "sessionout.jsp" %>
<DIV id="menu">
<br>
<br>

<div align="center">
  <UL>
          <A href="logout.jsp" class="button"> Logout</A>
    </UL>

  </div>
</DIV>
<FORM method = "post"  id="form" name="form"  >
 <%
String PBATCH_ID=request.getParameter("PBATCH_ID")==null?"":(String) request.getParameter("PBATCH_ID");
PBATCH_ID=PBATCH_ID.trim();

String APP_ID="";
String APP_NAME="";
String MM_CLAIM_DT="";
String BANK_NAME="";
String BRANCHNAME="";
String EMAIL="";
String PAY_STATUS="";
String FAIL_REASON="";
String MOB_NO1="";
String ROWNUM="";




DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT ROWNUM, UPPER(B.APP_NAME) AS APP_NAME, "      );
poR.append(" B.APP_ID, "      );
poR.append(" B.MOB_NO1, "      );
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
poR.append(" AND A.PBATCH_ID   = ? "      );

values.add(PBATCH_ID);
ResultSet rsMain = db.executeSQL(poR.toString(),values);


%>
<CENTER>
<br>


<table border="1">
 <input name="PBATCH_ID"  type="text" id="PBATCH_ID" value="<%= PBATCH_ID %>" Maxlength="20" Autocomplete="off">
 <input name="submit"  type="submit" class="buttonlogin" value="Search">
  </table>
</FORM>
  <TABLE class="table table-striped table-bordered" id="example" style="width:100%">
  <thead>
    <tr>
      <th width="13%" align="center" valign="middle">SRNO</th>
      <th width="13%" align="center" valign="middle">Applicant Id</th>
      <th width="8%" align="center" valign="middle">Applicant Name</th>
      <th width="11%" align="center" valign="middle">Pay Status </th>
	  <th width="24%" align="center" valign="middle">Applicant Mobile Number </th>
	   <th width="13%" align="center" valign="middle">Bank Email Id</th>
      <th width="14%" align="center" valign="middle">SMS to Applicant</th>
      <th width="17%" align="center" valign="middle">E-mail to Bank </th>
    </tr>
  </thead>
  <tbody>
    <%
while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
PAY_STATUS=rsMain.getString("PAY_STATUS")==null?"":rsMain.getString("PAY_STATUS");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
FAIL_REASON=rsMain.getString("FAIL_REASON")==null?"":rsMain.getString("FAIL_REASON");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
ROWNUM=rsMain.getString("ROWNUM")==null?"":rsMain.getString("ROWNUM");
%>
    <tr>
      <td><%= ROWNUM %></td>
      <td><div align="center"><%=APP_ID%></div></td>
      <td><div align="center"><%=APP_NAME%></div></td>
	  <td><div align="center"><%=PAY_STATUS%></div></td>
	  <td><div align="center"><%=MOB_NO1%></div></td>
	   <td><div align="center"><%=EMAIL%></div></td>
      <td><div align="center"><A onClick="SendSMS('<%=APP_ID%>','<%=PBATCH_ID%>')" class="button">SMS</A></div></td>
      <td><div align="center">
        <% if(!EMAIL.equals("")){ %>  
        <A onClick="SendEmail('<%=PBATCH_ID%>','<%=APP_ID%>')" class="button"> Email</A> 
        </div>
        <%}else{
			 
			 %>
        
        
        <% } %>
      </div></td>
    </tr>
    <%

}
rsMain.close();
db.close();
%>
  </tbody>
</table>
<SCRIPT>
            var modalWin = new CreateModalPopUpObject();
            modalWin.SetLoadingImagePath("images/loading.gif");
            modalWin.SetCloseButtonImagePath("images/remove.gif");

            function SendSMS(APP_ID, PBATCH_ID) {
                var callbackFunctionArray = new Array(refreshpage);
                modalWin.ShowURL("sendsms.jsp?APP_ID=" + APP_ID + "&PBATCH_ID=" + PBATCH_ID, 600, 800, 'Send SMS', callbackFunctionArray, null);
            }


            function SendEmail(PBATCH_ID, APP_ID) {
                var callbackFunctionArray = new Array(refreshpage);
                modalWin.ShowURL("sendemail.jsp?PBATCH_ID=" + PBATCH_ID + "&APP_ID=" + APP_ID, 700, 800, 'Send email', callbackFunctionArray, null);
            }


            function HideModalWindow() {
                modalWin.HideModalPopUp();
            }

            function refreshpage() {
                location.reload();
            }

        </SCRIPT>
		
	
		
 

  </CENTER>
</BODY>

</HTML>
