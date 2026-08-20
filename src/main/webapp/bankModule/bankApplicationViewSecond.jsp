<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<TITLE>Bank applicant view</TITLE>
<%@ include file="headerfile.jsp" %>
<SCRIPT language="javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<STYLE type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {color: #FF0000}
.style3 {
	color: #000000;
	font-weight: bold;
}
.style4 {font-size: large}
.style5 {
	color: #FF0000;
	font-size: large;
	font-weight: bold;
}
-->
</STYLE>
</HEAD>

<BODY>
<FORM action="bankApplicationViewSecond.jsp" method="post" name="form1" id="form1">

<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch=request.getParameter("txtSearch") == null?"":(String) request.getParameter("txtSearch");
String IFSC_CODE=(String)session.getAttribute("bank_id");
String APP_NAME="";
String CURRENT_STATUS="";
 String ONLINE_SUBDT="";
 String counsign="";
String BANK_F_DATE="";
String  BANK_REC_DT="";
String  UP_DATE ="";
String APP_ID ="";
String TR_ID ="";
String LOAN_DOCFNAME="";
String MM_CLAIM_AMT="";
String MM_CLAIM_DT="";
String ACT_ID="";
 String EDP_CERT="";
 String DOC_NAME="";
 String ACT_YN="";
  String BR_UPDATE_YN="";

 
		StringBuffer av= new StringBuffer();
		
		av.append(" SELECT * FROM  (select  D.BR_UPDATE_YN,  B.TR_ID, a.app_id,a.act_yn,B.act_id ,NVL(c.act_desc,'') AS CURRENT_STATUS, a.app_name,TO_CHAR(a.bank_f_date,'DD-MON-YYYY') AS bank_f_date, case when trunc(a.online_subdt)> '31-MAY-2022' AND B.act_id=11 THEN 'Y' ELSE 'N' END  AS online_subdt, ").
		append(" B.LOAN_DOCFNAME, B.MM_CLAIM_AMT,TO_CHAR(b.bank_rec_dt,'DD-MON-YYYY') AS BANK_REC_DT,to_char(b.time_stamp,'DD-MON-YYYY:HH:MM:SS') AS UP_DATE,TO_CHAR(B.MM_CLAIM_DT,'DD-MON-RRRR') "). 
		append("  AS MM_CLAIM_DT,(select count(*) from  app_upload_trans_second where app_id=a.app_id and upm_cd=16) as counsign from app_detail_second a,bank_dataentry_second b,bank_app_status c,BANK_BR_MAST D  where  A.IFSC_CODE=D.BR_IFSL_CODE AND  a.app_id=b.app_id (+) AND A.ACT_ID=5  AND  b.act_id=c.act_id (+)   ").
		append("  AND A.IFSC_CODE=?  ").
  		append (" AND UPPER(A.app_id||' '||trim(A.app_name)) LIKE '%'||TRIM(UPPER('"+txtSearch+"'))||'%' Order by b.time_stamp, B.bank_rec_dt desc) MQR,  ").
		append (" (  SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS_second AUT, BANK_DATAENTRY_second BD WHERE AUT.APP_ID=BD.APP_ID  ").
        append ("  AND BD.IFSC_CODE=? AND AUT.UPM_CD=8  ").
        append ("   GROUP BY AUT.APP_ID,BD.IFSC_CODE) SQR  ").
        append ("  WHERE MQR.APP_ID=SQR.APP_ID (+) ");

		List values=new ArrayList();
     values.add (IFSC_CODE);	 
	 values.add (IFSC_CODE);

		ResultSet rsinst = db.executeSQL(av.toString(),values);
		values.clear();

		
%>
<TABLE border="2" align="center"  >
  <TR>
    <TD colspan="12" align="left"><DIV align="center"><IMG src="../images/pmegpetrackN.png" width="auto" height="43" /></DIV></TD>
  </TR>
  <TR>
    <TD colspan="12" align="left"><DIV align="center">For Technical Assistance contact ( Information Technology, KVIC, Mumbai) #022-26712087, and send email to<SPAN class="OrangeLebel"><EM><bold> pmegpeportal.kvic@gov.in </bold> </EM></SPAN>from your branch email id,</DIV></TD>
  </TR>
  <TR>
    <TH colspan="12" align="left"><DIV align="center">For MM Claim status (PMEGP,MUMBI) contact No: # 022-26713686 and send email to<SPAN class="OrangeLebel"><EM><bold>pmegp.kvic@gov.in</bold> </EM></SPAN></DIV></TH>
  </TR>
   <TR>
    <TH colspan="12" align="left"> <DIV align="center">for Govt. Subsidy Release on or before 30-06-2020( Corp. Bank) queries contact :022-22833391/22833390 ( cb0511@unionbankofindia.com/epurse@unionbankofindia.com) </DIV></TH>
  </TR>
  <TR>
    <TH colspan="12" align="left"><DIV align="center">for Govt. Subsidy Release on or after 01-07-2020(Indian. Bank) queries contact :7021205724 (PMEGP.Narimanpoint@indianbank.co.in)<A href="Indian Bank Contact Details.pdf" target="_blank"  download>Download Circular</A> </DIV></TH>
  </TR>
  <TR>
    <TH colspan="12" align="left"><DIV align="center">Applicant data Search and Update form </DIV></TH>
  </TR>
  <TR>
    <TD colspan="12" align="left" class="redLebel">Note: After  Margin Money (Govt. Subsidy) Claimed Data Cannot be Updated.......... </TD>
  </TR>
  <TR>
    <TH colspan="12" align="left">
        <DIV align="left"><SPAN >Search by Applicant ID / Name : (enter few letters) :</SPAN>          
          <INPUT name="txtSearch" type="text" class="style1" id="txtSearch" size="20" maxlength="15" />
          <INPUT name="Submit" type="submit" class="button" onClick="strFind();" value="Find" />
          <INPUT name="Submit" type="submit" class="button" onClick="strFind();" value="ALL" />       
    </DIV></TH>
  </TR>
  
  <TR >
    <TH rowspan="2" align="left">     <DIV align="center">Applicant id </DIV></TH>
    <TH rowspan="2" align="left">      <DIV align="center">Applicant Name<BR>
    </DIV></TH>
    <TH rowspan="2" align="left"><DIV align="center">Date of Forwarding </DIV></TH>
    <TH rowspan="2" align="left" nowrap>Download Applicant </TH>
    <TH rowspan="2" align="left">Current Status </TH>
	 <TH rowspan="2" align="left">Upload </TH>    
    <TH colspan="4" align="left" nowrap>Online Claim Submission </TH>
    <TH rowspan="2" align="left" nowrap>Applicant Data</TH>
    </TR>
  <TR >
    <TH align="left"> Date </TH>
    <TH align="left">Amount</TH>
    <TH align="left">Loan Statement </TH>
    <TH align="left"><DIV align="center">Download</DIV></TH>
    </TR>
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
  DOC_NAME=rsinst.getString("DOC_NAME")==null?"":rsinst.getString("DOC_NAME");
  ACT_YN=rsinst.getString("ACT_YN")==null?"":rsinst.getString("ACT_YN");
    BR_UPDATE_YN=rsinst.getString("BR_UPDATE_YN")==null?"":rsinst.getString("BR_UPDATE_YN");
	counsign=rsinst.getString("counsign")==null?"0":rsinst.getString("counsign");
  ONLINE_SUBDT=rsinst.getString("ONLINE_SUBDT")==null?"0":rsinst.getString("ONLINE_SUBDT");

   if (ACT_YN.equals("Y")){

   %>
  <TR>
    <TD align="left" nowrap="nowrap"><SPAN >(<%=srn%>)<%= APP_ID %></SPAN></TD>
    <TD align="left" nowrap="nowrap"><%= APP_NAME %></TD>
    <TD align="left" nowrap="nowrap"><SPAN ><%=BANK_F_DATE%></SPAN></TD>
	
    <TD align="left" nowrap="nowrap"><DIV align="center"><SPAN >
        <INPUT name="btnSunction" type="button" class="buttonGreen" value="Documents" style="background-color:#FF9900;" onClick="viewAppDocument('<%= APP_ID %>')">
    </SPAN></DIV></TD>
    <TD align="left" nowrap="nowrap"><span>
	<div align="center">
	<% if (ACT_ID.equals("11")) { %>
	<A href="../jsp/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>&RNAME=LetterHeadOfBankSecond" class="buttonOrange" target="_blank">Sanction letter</A>	
	<%}else{%>
	<%= CURRENT_STATUS %>
	<%}%>	</TD>
	<TD align="left" nowrap="nowrap"> 
	<% if (ONLINE_SUBDT.equals("Y") && (counsign.equals("0"))){ %>
	<INPUT name="btnUpload" type="button" class="buttonMerun" style="color:#FF0000"  value="Sign Board" onClick="uploadSign('<%= APP_ID %>')">
	<%} else  if (ONLINE_SUBDT.equals("N") && (counsign.equals("0"))){%>
	-
	<%} else{%>
	Uploaded
	<%}%>
	</TD>
	
	
    <TD align="left" nowrap="nowrap"><%= MM_CLAIM_DT %></TD>
    <TD align="left" nowrap="nowrap"><%= MM_CLAIM_AMT %></TD>
    <TD align="left" nowrap="nowrap">
	  <DIV align="center">
	      <% if (LOAN_DOCFNAME.equals("")) { %>
	  -
	  <%}else{%>
	  <A href="docviewSec.jsp?docname=<%=LOAN_DOCFNAME%>" target="_blank" class="buttonGray">View</A>	 
	  <%}%>
	  
	  </DIV></TD>
	
    <TD align="left" nowrap="nowrap">
	<% if (MM_CLAIM_AMT.equals("")) { %>
	Not Claimed
	<%}else if ( !(MM_CLAIM_AMT.equals("")||MM_CLAIM_AMT.equals("0"))&& MM_CLAIM_DT.equals("") ) { %>
	
	<INPUT name="btnSunction" type="button" class="buttonMerun" value=" Draft MM Claim" onClick="openmmReport('<%= APP_ID %>')">
	<%} else if (!MM_CLAIM_DT.equals("")) { %>
	<INPUT name="btnSunction" type="button" class="buttonBlue" value="MM Claim letter (Final)" style="background-color:#FF9900;" onClick="openmmReport('<%= APP_ID %>')">
	<%}%>
	</TD>
    <TD align="left" nowrap="nowrap"><DIV align="center">
	<% if (LOAN_DOCFNAME.equals("")) { 
	 if(BR_UPDATE_YN.equals("Y")){ 
	%>
	
	<A href="appidSnSec.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Update</A>
	<% } } else { %>
	Online Claim Submitted
	<% } %>
	
	</DIV></TD>
    </TR>
 <%
  }
  else{%>
  <TR>
  <TD align="left" nowrap="nowrap"><SPAN >(<%=srn%>)<%= APP_ID %></SPAN></TD>
    <TD align="left" nowrap="nowrap"><%= APP_NAME %></TD>
    <TD align="left" nowrap="nowrap"><SPAN ><%=BANK_F_DATE%></SPAN></TD>
	
    <TD align="left" nowrap="nowrap"><DIV align="center"><SPAN >
        <INPUT name="btnSunction" type="button" class="buttonGreen" value="Documents" onClick="viewAppDocument('<%= APP_ID %>')">
    </SPAN></DIV></TD>
    <TD align="left" nowrap="nowrap"><SPAN class="style2"><STRONG><span>
      </STRONG>
      </SPAN>
      <DIV align="center" class="style3 style4">Returned</DIV></TD>
	
	<TD colspan="6" align="left" nowrap="nowrap">
	<DIV align="center">	</DIV>
	  <DIV align="center" class="style5"><SPAN style="font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(238, 238, 238); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Returned To Applicant For Fresh Application Submission</SPAN>      </DIV>	  <DIV align="center"></DIV></TD>
    </TR>
  <%}
}
rsinst.close();
db.close();
%>
</TABLE>
<SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function openSancReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=LetterHeadOfBankSecond';
 modalWin.ShowURL(url,600,1100,'PMEGP Loan Sanction Letter',null,null);
 
}
function openmmReport(pAppid) {
var url ='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoneySecond';
 modalWin.ShowURL(url,600,1100,'Margin Money Claim Format',null,null);
 
}
function viewLs(APP_ID){
var urlpar='uploadclaim/'+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Loan Disbursement Statement',null,null);
 }//E
 
function uploadCert(pAppid) {
var url ='edpAppUplodadByAgency.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload EDP Certificate',null,null);
 
}


function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_sec_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }//END OF FUNCTION

function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function uploadSign(pAppid) {
var url ='PmegpBoardUploadSec.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload PMEGP Sign Board',null,null);
 
}


</SCRIPT>

</FORM>

</BODY>
</HTML>
<%
rsinst.close();
db.close();
%>
