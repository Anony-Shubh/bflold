<%@ include file="includeHeaderPage.jsp" %>
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
      <td><div align="center"> BANK REJECTION APPLICATIONS DETAIL AND REFORWARD TO OTHER BANK </div></td>
      <td><div align="right">
      
      </div></td>
    </tr>
</table>
<table align="center" cellspacing="0" class="display" id="example">
        <thead>
            <tr>
              <th nowrap>Applicant ID </th>
                <th nowrap>APPLICANT NAME</th>
                <th nowrap>Aadhaar No </th>
                <th nowrap>IFSC</th>
                <th nowrap>Bank Name </th>
				<th nowrap>Remarks of bank </th>
				<th nowrap>Reforward to Bank </th>
			</tr>
        </thead>
        <tfoot>
            <tr>
              <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>Aadhaar No</th>
                <th>IFSC</th>
                <th>Bank Name </th>
				<th>Remarks of bank</th>
				<th>View </th>
			</tr>
        </tfoot>
		        <tbody>
		<%
		String APP_ID = "";
String APP_NAME = "";
String AADHAR_NO = "";
String IFSC_CODE = "";
String BR_NAME = "";
String BANK_REMARKS = "";
String BANK_REC_DT = "";
String REJ_ID = "";

		try {
		
			
DBCon db= new DBCon();
db.connect();
String OFF_CD= "";
StringBuffer qrysb = new StringBuffer();
qrysb.append("   SELECT AD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("    AD.AADHAR_NO,"      );
qrysb.append("     AD.IFSC_CODE,"      );
qrysb.append("     BBM.BR_NAME,"      );
qrysb.append("     BD.BANK_REMARKS,"      );
qrysb.append("     BD.BANK_REC_DT,"      );
qrysb.append("     BD.REJ_ID"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     BANK_BR_MAST BBM"      );
qrysb.append("   WHERE AD.APP_ID  = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.APP_ID    = BD.APP_ID"      );
qrysb.append("   AND BD.ACT_ID    = 3"      );


ResultSet rsMain = db.execSQL(qrysb.toString());

while(rsMain.next())
  { 
	APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
BANK_REMARKS=rsMain.getString("BANK_REMARKS")==null?"":rsMain.getString("BANK_REMARKS");
BANK_REC_DT=rsMain.getString("BANK_REC_DT")==null?"":rsMain.getString("BANK_REC_DT");
REJ_ID=rsMain.getString("REJ_ID")==null?"":rsMain.getString("REJ_ID");

  %>
            <tr>
              <td><%= APP_ID%></td>
                           <td> <%= APP_NAME%></td>
                            <td><%= AADHAR_NO %></td>
                            <td><%=IFSC_CODE %></td>
                            <td><%= BR_NAME %></td>
							<td><%= BANK_REMARKS %></td>
                            <td> <div align="center">
                              <input name="btnDocument" type="button" class="buttonMerun" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Change bank and  Reforward">
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