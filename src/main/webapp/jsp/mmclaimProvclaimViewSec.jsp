<%@ include file="includeHeaderPage.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
</head>
<body>
<form name="form" id="form"  method="post">
<table align="center" class="pmegpTable">
    <tr>
      <td><div align="center"> PMEGP MARGIN MONEYCLAIM  STATUS </div></td>
      <td><div align="right">
      
      </div></td>
    </tr>
</table>
<table align="center" cellspacing="0" class="display" id="example">
        <thead>
            <tr>
              <th nowrap>Office Name </th>
              <th nowrap>Applicant ID </th>
                <th nowrap>APPLICANT NAME</th>
                <th nowrap>Aadhaar No </th>
                <th nowrap>IFSC</th>
                <th nowrap>MM Claim Date </th>
				<th nowrap>MM Claim Amount </th>
				<th nowrap>Process Date </th>
				<th nowrap>Upload</th>
				<th nowrap>View </th>
				<th nowrap>Current Status</th>
				<th nowrap>Approv. Status </th>
			</tr>
        </thead>
        <tfoot>
            <tr>
              <th>Office Name</th>
              <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>Aadhaar No</th>
                <th>IFSC</th>
                <th>MM Claim Date </th>
				<th>MM Claim</th>
				<th>Process Date </th>
				<th>&nbsp;</th>
				<th>View </th>
				<th>Current Status</th>
				<th>Approv. Status</th>
			</tr>
        </tfoot>
		        <tbody>
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
qrysb.append("   SELECT BD.TR_ID,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     AD.APP_ID,"      );
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
qrysb.append("   FROM BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("     APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_BR_MAST BBM,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     MM_REMARKS_TRANS_SECOND MRT,"      );
qrysb.append("     BANK_APP_STATUS BAS,"      );
qrysb.append("     MMCLAIM_USER MU"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND BD.REMTRID        = MRT.REMTR_ID"      );
qrysb.append("   AND BD.PACT_ID       = BAS.ACT_ID(+)"      );
qrysb.append("   AND MRT.USER_ID       = MU.USER_ID(+)"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL "+vwhereqry+""      );

//out.print(qrysb.toString());

ResultSet rsMain = db.execSQL(qrysb.toString());

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
            <tr>
              <td><%= OFF_NAME %></td>
              <td><%= APP_ID%></td>
                           <td> <%= APP_NAME%></td>
                            <td><%= AADHAR_NO %></td>
                            <td><%=BR_IFSL_CODE %></td>
                            <td><%= MM_CLAIM_DT %></td>
							<td><%= MM_CLAIM_AMT %></td>
                            <td><div align="center"><%= PROC_DT %></div></td>
                            <td>
							 <%  if (APPRV_YN.equals("A") && PACT_ID.equals("30")) { %>
							
							<input name="btnDocument" type="button" class="buttonGreen" id="btnDocument" onClick="uploadmmRefdoc('<%=APP_ID%>');" value="Upload">
							<%}%>
							</td>
                            <td> <div align="center">
                              <input name="btnDocument" type="button" class="buttonMerun" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Document">
              </div></td>
                            <td><%= ACT_DESC  %></td>
                            <td>
							<%if (APPRV_YN.equals("S")) {%>
							  <div align="center"><img src="../images/submit.png" width="10%" title="Submitted for Approval">
							<%  }else if (APPRV_YN.equals("A")) { %>
							   <div align="center"><img src="../images/approve.jpg" width="10%" title="Approved...." >
							  <%  }else if (APPRV_YN.equals("R")) { %>
								<div align="center"><img src="../images/returned.jpg" width="10%" title="Referred/ Returned for correction" >
								<%}%>
							  
							  </div></td>
                  </tr>
			<%
			}
			rsMain.close();
			db.close();
			}catch (Exception e) {out.print(e.toString());}
			%>
            
        </tbody>
</table>
  <div align="center">
    <input name="btnReport" type="button" class="blinker" id="btnReport" onClick="printMMStatus('<%= vwhereqry %>')" value="Generate Consolidated Report">
    <script>
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
var urlpar='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoneySecond';
 modalWin.ShowURL(urlpar,700,800,'PMEGP Application',null,null);
 }
 
 function printMMStatus(pAppid){
var urlpar='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=BANKSTATUSCOREPORTSEC';
 modalWin.ShowURL(urlpar,700,800,'PMEGP Application',null,null);
 }
 
 function viewAlldocument(pAppid){
var urlpar='../jsp/viewAppdocumentmmdisbursementSec.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,800,'PMEGP View All Applicant Document',null,null);
 }
 
 function uploadmmRefdoc(pAppid){
var urlpar='../jsp/upload_app_doc_mmSec.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,800,'PMEGP View All Applicant Document',null,null);
 }
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

  </script>
    </p>
  </div>
</form>
</body>
	</html>