<%@ include file="includeHeadercomm.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
</head>
<body>
<form name="form" id="form" class="form" method="post">
<table align="center" class="pmegpTable">
    <tr>
      <td colspan="18"><div align="center"> PMEGP MARGIN MONEY (GOVT. SUBSIDY) CLAIM PROCESS STATUS </div></td>
    </tr>
</table>
<p>&nbsp;</p>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
              <th width="10%" nowrap>Agency</th>
              <th width="10%" nowrap>Applicant ID </th>
                <th width="16%" nowrap>APPLICANT NAME</th>
                <th width="4%" nowrap>IFSC</th>
                <th width="13%" nowrap>MM Claim Date </th>
				<th width="16%" nowrap>MM Claim </th>
				<th width="11%" nowrap>Process Date </th>
				<th width="11%" nowrap>View </th>
				<th width="0%" nowrap>Process Detail </th>
				<th width="0%" nowrap>Current Status</th>
				<th width="7%" nowrap>Approv. Status </th>
				<th width="7%" nowrap>EMAIL/SMS</th>
				<th width="14%" nowrap>Appv../Sub. by </th>
            </tr>
        </thead>
        <tfoot>
            <tr>
              <th>&nbsp;</th>
              <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>IFSC</th>
                <th>MM Claim Date </th>
				<th>MM Claim</th>
				<th>Process Date </th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>Transient A/c No. </th>
            </tr>
        </tfoot>
		        <tbody>
		<%
		try {
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
qrysb.append("     BD.MM_CLAIM_AMT,"      );
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
qrysb.append("     MM_REMARKS_TRANS_SECOND	 MRT,"      );
qrysb.append("     BANK_APP_STATUS BAS,"      );
qrysb.append("     MMCLAIM_USER MU"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND BD.REMTRID        = MRT.REMTR_ID"      );
qrysb.append("   AND MRT.PACT_ID       = BAS.ACT_ID"      );
qrysb.append("   AND MRT.USER_ID       = MU.USER_ID"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("   AND BD.APPRV_YN IN ('A','R') "      );


out.print(qrysb.toString());

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

 APPRV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
 PROC_DT=rsMain.getString("PROC_DT")==null?"":rsMain.getString("PROC_DT");
 USER_DETAIL=rsMain.getString("USER_DETAIL")==null?"":rsMain.getString("USER_DETAIL");
 ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
  %>
            <tr>
              <td><%= AGENCY_TYPE %></td>
              <td><%= APP_ID%></td>
                           <td> <%= APP_NAME%></td>
                            <td><%=BR_IFSL_CODE %></td>
                            <td><%= MM_CLAIM_DT %></td>
							<td><%= MM_CLAIM_AMT %></td>
                            <td><div align="center"><%= PROC_DT %></div></td>
                            <td> <div align="center">
                              <input name="btnDocument" type="button" class="buttonMerun" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Document">
              </div></td>
                            <td><input name="btnDocument" type="button" class="buttonGray" id="btnDocument" onClick="processDetail('<%=APP_ID%>');" value="Detail"></td>
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
                            <td>Send</td>
                            <td><%= USER_DETAIL %></td>
                  </tr>
			<%
			}
			rsMain.close();
			db.close();
			}catch (Exception e) {out.print(e.toString());}
			%>
            
        </tbody>
</table>
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
var urlpar='../jsp/PMEGPGenAppForm.jsp?APP_ID='+pAppid+'&RNAME=marginmoney1';
 modalWin.ShowURL(urlpar,700,800,'PMEGP Application',null,null);
 }
 
 function ShowMMClaim(pAppid){
var urlpar='StatusUpdateIstLCO.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,900,'PMEGP STATUS UPDATE',null,null);
 }
 
 function viewAlldocument(pAppid){
var urlpar='viewAppdocument.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,800,1200,'PMEGP View All Applicant Document',null,null);
 }
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

 </script>
</form>
</body>
	</html>