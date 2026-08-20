<%@ include file="includeHeaderPage.jsp" %>
<LINK href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<LINK href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<SCRIPT src="../js/jquery-1.12.0.min.js"></SCRIPT>
<SCRIPT src="../js/jquery.dataTables.min.js"></SCRIPT>
<SCRIPT src="../js/ModalPopupWindow.js" type="text/javascript"></SCRIPT>
</HEAD>
<BODY>
<FORM name="form" id="form"  method="post">
<TABLE align="center" class="pmegpTable">
    <TR>
      <TD><DIV align="center"> PMEGP MARGIN MONEYCLAIM  STATUS </DIV></TD>
      <TD><DIV align="right">
      
      </DIV></TD>
    </TR>
</TABLE>
<TABLE align="center" cellspacing="0" class="display" id="example">
        <THEAD>
            <TR>
              <TH nowrap>Office Name </TH>
              <TH nowrap>Applicant ID </TH>
                <TH nowrap>APPLICANT NAME</TH>
                <TH nowrap>Aadhaar No </TH>
                <TH nowrap>IFSC</TH>
                <TH nowrap>MM Claim Date </TH>
				<TH nowrap>MM Claim Amount </TH>
				<TH nowrap>Process Date </TH>
				<TH nowrap>Upload</TH>
				<TH nowrap>Update</TH>
				<TH nowrap>View </TH>
				<TH nowrap>Current Status</TH>
				<TH nowrap>Approv. Status </TH>
			</TR>
        </THEAD>
        <TFOOT>
            <TR>
              <TH>Office Name</TH>
              <TH>Applicant ID </TH>
                <TH>APPLICANT NAME</TH>
                <TH>Aadhaar No</TH>
                <TH>IFSC</TH>
                <TH>MM Claim Date </TH>
				<TH>MM Claim</TH>
				<TH>Process Date </TH>
				<TH>&nbsp;</TH>
				<TH>&nbsp;</TH>
				<TH>View </TH>

				<TH>Current Status</TH>
				<TH>Approv. Status</TH>
			</TR>
        </TFOOT>
		        <TBODY>
		<%
		String vwhereqry="";
		try {
		String sOFF_TYPE_CD=(String) session.getAttribute("sOFF_TYPE_CD");
			String sdistrict_cd =(String) session.getAttribute("sdistrict_cd");
			String sagency_type=(String) session.getAttribute("sagency_type");
			
			
			if (sOFF_TYPE_CD.equals("2")){
			 vwhereqry =" AND MOM.DISTRICT_CD= "+sdistrict_cd+" ";
			}else{
			vwhereqry =" AND MOM.USER_ID= "+vUserID+" ";
			}
DBCon db= new DBCon();
db.connect();
String OFF_CD= "";
StringBuffer qrysb = new StringBuffer();
qrysb.append("      "      );
qrysb.append("   SELECT BD.TR_ID,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     AD.APP_ID,BD.EDP_CERT_DT,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     BBM.BR_IFSL_CODE,"      );
qrysb.append("     BD.APPLOAN_ACCNO,"      );
qrysb.append("     BBM.BR_NAME,"      );
qrysb.append("     BBM.BRANCH_NAME,"      );
qrysb.append("     TO_CHAR(BD.MM_CLAIM_DT, 'DD-MON-RRRR') AS MM_CLAIM_DT,"      );
qrysb.append("     BD.MM_CLAIM_AMT,BD.PACT_ID,"      );
qrysb.append("     BD.FB_ACNO,"      );
qrysb.append("     BD.LOAN_DOCFNAME,"      );
qrysb.append("     TO_CHAR(MRT.PROC_DT,'DD-MON-RRRR HH:MM:SS') AS PROC_DT,"      );
qrysb.append("     BAS.ACT_DESC,"      );
qrysb.append("     BD.APPRV_YN,"      );
qrysb.append("     MU.USER_DETAIL"      );
qrysb.append("   FROM BANK_DATAENTRY BD,"      );
qrysb.append("     APP_DETAIL AD,"      );
qrysb.append("     BANK_BR_MAST BBM,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     MM_REMARKS_TRANS MRT,"      );
qrysb.append("     BANK_APP_STATUS BAS,"      );
qrysb.append("     MMCLAIM_USER MU"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND BD.REMTRID        = MRT.REMTR_ID"      );
qrysb.append("   AND BD.PACT_ID       = BAS.ACT_ID(+)"      );
qrysb.append("   AND MRT.USER_ID       = MU.USER_ID(+)"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL "+vwhereqry+"  "      );

//out.print(qrysb.toString());

ResultSet rsMain = db.execSQL(qrysb.toString());
String DOC_NAME="";
String EDP_CERT_DT = "";
String AGENCY_TYPE = "";
String OFF_NAME = "";
String APP_ID = "";
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

String APPRV_YN="";
String PROC_DT="";
String USER_DETAIL="";
String ACT_DESC="";
String PACT_ID="";

while(rsMain.next())
  { 
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
PACT_ID=rsMain.getString("PACT_ID")==null?"":rsMain.getString("PACT_ID");
 APPRV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
 PROC_DT=rsMain.getString("PROC_DT")==null?"":rsMain.getString("PROC_DT");
 USER_DETAIL=rsMain.getString("USER_DETAIL")==null?"":rsMain.getString("USER_DETAIL");
 ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
 
  %>
            <TR>
              <TD><%= OFF_NAME %></TD>
              <TD><%= APP_ID%></TD>
                           <TD> <%= APP_NAME%></TD>
                            <TD><%= AADHAR_NO %></TD>
                            <TD><%=BR_IFSL_CODE %></TD>
                            <TD><%= MM_CLAIM_DT %></TD>
							<TD><%= MM_CLAIM_AMT %></TD>
                            <TD><DIV align="center"><%= PROC_DT %></DIV></TD>
                            <TD>
							 <%  if (APPRV_YN.equals("A") && PACT_ID.equals("30")) { %>
							
							<INPUT name="btnDocument" type="button" class="buttonGreen" id="btnDocument" onClick="uploadmmRefdoc('<%=APP_ID%>');" value="Upload">
							<%}%>							</TD>
									 <td>
 <%  if (APPRV_YN.equals("A") && PACT_ID.equals("30")) { %>							 
							<input name="btnDocument" type="button" class="buttonMerun" id="btnDocument" onClick="ReferAppDetail('<%=APP_ID%>');" value="Update">	
<%}%>							</td>
                            <TD> <DIV align="center">
                              <INPUT name="btnDocument" type="button" class="buttonGreen" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Document">
              </DIV></TD>
			  
                           
                            <TD><%= ACT_DESC  %></TD>
                            <TD>
							<%if (APPRV_YN.equals("S")) {%>
							  <div align="center"><IMG src="../images/submit.png" width="10%" title="Submitted for Approval">
							<%  }else if (APPRV_YN.equals("A")) { %>
							   <div align="center"><IMG src="../images/approve.jpg" width="10%" title="Approved...." >
							  <%  }else if (APPRV_YN.equals("R")) { %>
								<DIV align="center"><IMG src="../images/returned.jpg" width="10%" title="Referred/ Returned for correction" >
								<%}%>
							  </DIV></TD>
                  </TR>
			<%
			}
			rsMain.close();
			db.close();
			}catch (Exception e) {out.print(e.toString());}
			%>
        </TBODY>
</TABLE>
  <DIV align="center">
  <!--
    <INPUT name="btnReport" type="button" class="blinker" id="btnReport" onClick="printMMStatus('<%= vwhereqry %>')" value="Generate Consolidated Report">
	-->
    <SCRIPT>
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#example tfoot th').each( function () {
        var title = $(this).text();
       // $(this).html( '<input type="text" placeholder="'+title+'" />' );
    } );
 
    // DataTable
    var table = $('#example').DataTable();
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            if ( that.search() !== this.value ) {
                that
                    .search( this.value )
                    .draw();
            }
        } );
    } );
} );



 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
function ShowLoanDoc(docname){
var urlpar='../bankModule/uploadclaim/'+docname;
 modalWin.ShowURL(urlpar,700,800,'Loan Document Disbursement Statement',null,null);
 }
 
 function ShowMMClaimReport(pAppid){
var urlpar='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoney1';
 modalWin.ShowURL(urlpar,700,800,'PMEGP Application',null,null);
 }
 
 function printMMStatus(pAppid){
var urlpar='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=BANKSTATUSCOREPORT';
 modalWin.ShowURL(urlpar,700,800,'PMEGP Application',null,null);
 }
 
 function viewAlldocument(pAppid){
var urlpar='../jsp/viewAppdocumentmmdisbursement.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,800,'PMEGP View All Applicant Document',null,null);
 }
 
 function uploadmmRefdoc(pAppid){
var urlpar='../jsp/upload_app_doc_mm.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,800,'PMEGP View All Applicant Document',null,null);
 }
   function ReferAppDetail(pAppid){
var urlpar='../jsp/ReferDetail.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,1000,'PMEGP View All Applicant Document',null,null);
 }
 function userrAppDetail(pAppid){
 var urlpar='../jsp/Uselink.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,1000,'PMEGP View All Applicant Document',null,null);

 }
 
 
 function uploadCert(vDOC_NAME,pAppid) {
var url ="../edpUpdate/docViewS.jsp?docname="+vDOC_NAME+"&APP_ID="+pAppid;
 modalWin.ShowURL(url,800,1200,'Update EDP Certificate Details',null,null);
 
}
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

function refreshpage(){
form.submit();
}

  </SCRIPT>
    </p>
  </DIV>
</FORM>
</BODY>
	</HTML>