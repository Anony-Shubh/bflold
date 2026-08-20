<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Bank applicant view</title>
<%@ include file="headerfile.jsp" %>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>

</head>

<body>
<form action="bankApplicationView.jsp" method="post" name="form1">

<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch=request.getParameter("txtSearch") == null?"":(String) request.getParameter("txtSearch");
String IFSC_CODE=(String)session.getAttribute("bank_id");
String APP_NAME="";
String CURRENT_STATUS="";
String BANK_F_DATE="";
String  BANK_REC_DT="";
String  UP_DATE ="";
String APP_ID ="";
String TR_ID ="";
String LOAN_DOCFNAME="";
String MM_CLAIM_AMT="";
String MM_CLAIM_DT="";
String ACT_ID="";
 
		
		StringBuffer av= new StringBuffer();
		
		av.append("  select B.TR_ID, a.app_id,B.act_id ,NVL(c.act_desc,'') AS CURRENT_STATUS, a.app_name,a.fh_name,B.ACT_ID,TO_CHAR(a.bank_f_date,'DD-MON-YYYY') AS bank_f_date,B.LOAN_DOCFNAME, B.MM_CLAIM_AMT,  ").
		append(" TO_CHAR(b.bank_rec_dt,'DD-MON-YYYY') AS BANK_REC_DT,to_char(b.time_stamp,'DD-MON-YYYY:HH:MM:SS') AS UP_DATE,TO_CHAR(B.MM_CLAIM_DT,'DD-MON-RRRR') AS MM_CLAIM_DT from app_detail a, "). 
		append("  bank_dataentry b,bank_app_status c where a.app_id=b.app_id (+) AND A.ACT_ID=5  AND  b.act_id=c.act_id (+) ").
		append("  AND A.IFSC_CODE=?  ").
  		append (" AND UPPER(A.app_id||' '||trim(A.app_name)) LIKE '%'||TRIM(UPPER(?))||'%' Order by b.time_stamp, B.bank_rec_dt desc ");
		
		List values=new ArrayList();
     values.add (IFSC_CODE); 
	 values.add (txtSearch);

		ResultSet rsinst = db.executeSQL(av.toString(),values);
		values.clear();

		
%>

<h2 align="center"><img src="../images/pmegpetrackN.png" width="699" height="83" /></h2>
<table border="2" align="center"  >
  <tr>
    <th colspan="10" align="left"><div align="center">Applicant data Search and Update form </div></th>
  </tr>
  <tr>
    <td colspan="10" align="left" class="redLebel">Note: After  Margin Money (Govt. Subsidy) Claimed Data Cannot be Updated.......... </td>
  </tr>
  <tr>
    <th colspan="10" align="left">
        <div align="left"><span >Search by Applicant ID / Name : (enter few letters) :</span>          
          <input name="txtSearch" type="text" class="style1" id="txtSearch" size="20" maxlength="15" />
          <input name="Submit" type="submit" class="button" onClick="strFind();" value="Find" />
          <input name="Submit" type="submit" class="button" onClick="strFind();" value="ALL" />       
    </div></th>
  </tr>
  
  <tr >
    <th rowspan="2" align="left">     <div align="center">Applicant id </div></th>
    <th rowspan="2" align="left">      <div align="center">Applicant Name<br>
    </div></th>
    <th rowspan="2" align="left"><div align="center">Date of Forwarding </div></th>
    <th rowspan="2" align="left" nowrap>Download Applicant </th>
    <th rowspan="2" align="left">Current Status </th>
    <th colspan="4" align="left" nowrap>Online Claim Submission </th>
    <th rowspan="2" align="left" nowrap>Applicant Data</th>
    </tr>
  <tr >
    <th align="left"> Date </th>
    <th align="left">Amount</th>
    <th align="left">Loan Statement </th>
    <th align="left"><div align="center">Download</div></th>
    </tr>
  <% 
  while (rsinst.next()) {
  srn=srn+1;
  APP_ID=rsinst.getString ("app_id")==null?"":rsinst.getString("app_id") ;
  APP_NAME= rsinst.getString("app_name")==null?"":rsinst.getString("app_name") ;
  BANK_F_DATE=rsinst.getString("BANK_F_DATE")==null?"":rsinst.getString("BANK_F_DATE");
  BANK_REC_DT=rsinst.getString("BANK_REC_DT")==null?"":rsinst.getString("BANK_REC_DT");
  CURRENT_STATUS=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
  TR_ID=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
  LOAN_DOCFNAME=rsinst.getString("LOAN_DOCFNAME")==null?"":rsinst.getString("LOAN_DOCFNAME");
 MM_CLAIM_AMT=rsinst.getString("MM_CLAIM_AMT")==null?"":rsinst.getString("MM_CLAIM_AMT");
  MM_CLAIM_DT=rsinst.getString("MM_CLAIM_DT")==null?"":rsinst.getString("MM_CLAIM_DT");
ACT_ID=rsinst.getString("ACT_ID")==null?"":rsinst.getString("ACT_ID");
   %>
  <tr>
    <td align="left" nowrap="nowrap"><span >(<%=srn%>)<%= APP_ID %></span></td>
    <td align="left" nowrap="nowrap"><%= APP_NAME %></td>
    <td align="left" nowrap="nowrap"><span ><%=BANK_F_DATE%></span></td>
	
    <td align="left" nowrap="nowrap"><div align="center"><span >
        <input name="btnSunction" type="button" class="buttonGreen" value="Documents" onClick="viewAppDocument('<%= APP_ID %>')">
    </span></div></td>
    <td align="left" nowrap="nowrap"><span >
	<% if (ACT_ID.equals("11")) { %>
	<input name="btnSunction" type="button" class="buttonOrange" value="Sanction Letter" onClick="openSancReport('<%= APP_ID %>')">
	<%}else{%>
	<%= CURRENT_STATUS %>
	<%}%>
	</span></td>
	
    <td align="left" nowrap="nowrap"><%= MM_CLAIM_DT %></td>
    <td align="left" nowrap="nowrap"><%= MM_CLAIM_AMT %></td>
    <td align="left" nowrap="nowrap">
	  <div align="center">
	      <% if (LOAN_DOCFNAME.equals("")) { %>
	  -
	  <%}else{%>
	  <input name="btnSunction" type="button" class="buttonGray" value="View" onClick="viewLs('<%= LOAN_DOCFNAME %>')">
	  <%}%>
	  
	  </div></td>
	
    <td align="left" nowrap="nowrap">
	<% if (MM_CLAIM_AMT.equals("")) { %>
	Not Claimed
	<%}else if ( !(MM_CLAIM_AMT.equals("")||MM_CLAIM_AMT.equals("0"))&& MM_CLAIM_DT.equals("") ) { %>
	
	<input name="btnSunction" type="button" class="buttonMerun" value=" Draft MM Claim" onClick="openmmReport('<%= APP_ID %>')">
	<%} else if (!MM_CLAIM_DT.equals("")) { %>
	<input name="btnSunction" type="button" class="buttonBlue" value="MM Claim letter (Final)" onClick="openmmReport('<%= APP_ID %>')">
	<%}%>
	</td>
    <td align="left" nowrap="nowrap"><div align="center">
	<% if (LOAN_DOCFNAME.equals("")) { %>
	
	<a href="appidSn.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Update</a>
	<%} else { %>
	Online Claim Submitted
	<%}%>
	
	</div></td>
    </tr>
  <%
}
rsinst.close();
db.close();
%>
</table>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function openSancReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=LetterHeadOfBank';
 modalWin.ShowURL(url,600,1100,'PMEGP Loan Sanction Letter',null,null);
 
}
function openmmReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoney';
 modalWin.ShowURL(url,600,1100,'Margin Money Claim Format',null,null);
 
}
function viewLs(APP_ID){
var urlpar='uploadclaim/'+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Loan Disbursement Statement',null,null);
 }//E



function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }//END OF FUNCTION

function HideModalWindow() {
    modalWin.HideModalPopUp();
}


</script>

</form>

</body>
</html>
<%
rsinst.close();
db.close();
%>
