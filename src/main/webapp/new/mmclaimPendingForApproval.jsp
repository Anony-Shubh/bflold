<%@ include file="includeHeadercomm.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("img/loading.gif");
 modalWin.SetCloseButtonImagePath("img/remove.gif");
 //Uncomment below line to make look buttons as link
//modalWin.SetButtonStyle("background:blue;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(param){
 var callbackFunctionArray = new Array(EnrollLater);
 modalWin.ShowURL('mmclaimApproved.jsp?'+param,600,900,'View Application',null,callbackFunctionArray);
 }
 

function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function EnrollLater(){
modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}


function updateDataTableSelectAllCtrl(table){
   var $table             = table.table().node();
   var $chkbox_all        = $('tbody input[type="checkbox"]', $table);
   var $chkbox_checked    = $('tbody input[type="checkbox"]:checked', $table);
   var chkbox_select_all  = $('thead input[name="select_all"]', $table).get(0);

   // If none of the checkboxes are checked
   if($chkbox_checked.length === 0){
      chkbox_select_all.checked = false;
      if('indeterminate' in chkbox_select_all){
         chkbox_select_all.indeterminate = false;
      }

   // If all of the checkboxes are checked
   } else if ($chkbox_checked.length === $chkbox_all.length){
      chkbox_select_all.checked = true;
      if('indeterminate' in chkbox_select_all){
         chkbox_select_all.indeterminate = false;
      }

   // If some of the checkboxes are checked
   } else {
      chkbox_select_all.checked = true;
      if('indeterminate' in chkbox_select_all){
         chkbox_select_all.indeterminate = true;
      }
   }
}

$(document).ready(function (){
   // Array holding selected row IDs
   var rows_selected = [];
   var table = $('#example').DataTable({
      'columnDefs': [{
         'targets': 0,
         'searchable':false,
         'orderable':false,
         'className': 'dt-body-center',
         'render': function (data, type, full, meta){
             return '<input type="checkbox">';
         }
      }],
      'order': [1, 'asc'],
      'rowCallback': function(row, data, dataIndex){
         // Get row ID
         var rowId = data[0];

         // If row ID is in the list of selected row IDs
         if($.inArray(rowId, rows_selected) !== -1){
            $(row).find('input[type="checkbox"]').prop('checked', true);
            $(row).addClass('selected');
         }
      }
   });

   // Handle click on checkbox
   $('#example tbody').on('click', 'input[type="checkbox"]', function(e){
      var $row = $(this).closest('tr');

      // Get row data
      var data = table.row($row).data();

      // Get row ID
      var rowId = data[0];

      // Determine whether row ID is in the list of selected row IDs 
      var index = $.inArray(rowId, rows_selected);

      // If checkbox is checked and row ID is not in list of selected row IDs
      if(this.checked && index === -1){
         rows_selected.push(rowId);

      // Otherwise, if checkbox is not checked and row ID is in list of selected row IDs
      } else if (!this.checked && index !== -1){
         rows_selected.splice(index, 1);
      }

      if(this.checked){
         $row.addClass('selected');
      } else {
         $row.removeClass('selected');
      }

      // Update state of "Select all" control
      updateDataTableSelectAllCtrl(table);

      // Prevent click event from propagating to parent
      e.stopPropagation();
   });

   // Handle click on table cells with checkboxes
   $('#example').on('click', 'tbody td, thead th:first-child', function(e){
      $(this).parent().find('input[type="checkbox"]').trigger('click');
   });

   // Handle click on "Select all" control
   $('thead input[name="select_all"]', table.table().container()).on('click', function(e){
      if(this.checked){
         $('tbody input[type="checkbox"]:not(:checked)', table.table().container()).trigger('click');
      } else {
         $('tbody input[type="checkbox"]:checked', table.table().container()).trigger('click');
      }

      // Prevent click event from propagating to parent
      e.stopPropagation();
   });

   // Handle table draw event
   table.on('draw', function(){
      // Update state of "Select all" control
      updateDataTableSelectAllCtrl(table);
   });
   
    // Remove added elements
     
    
   // Handle form submission event 
   $('#form').on('submit', function(e){
    $('input[name="billid\[\]"]', form).remove();
      var form = this;

      // Iterate over all selected checkboxes
      $.each(rows_selected, function(index, rowId){
         // Create a hidden element 
         $(form).append(
             $('<input>')
                .attr('type', 'hidden')
                .attr('name', 'billid')
                .val(rowId)
         );
      });

      // FOR DEMONSTRATION ONLY    
	  
      // Output form data to a console     
     $('#example-console').text($(form).serialize());
     //console.log("Form submission", $(form).serialize());
	 //alert ( $(form).serialize());
	  ShowNewPage($(form).serialize());
	 
      	   $('input[name="billid\"]', form).remove();
      
      // Prevent actual form submission
      e.preventDefault();
	 
   });
   
});
</script>
</head>
<body>
<form name="form" id="form" class="form" method="post">
<div>
  <div align="center">
    <input name="Submit" type="submit" class="button" value="Click Here For Group Approval" >
    </div>
</div>
  <table border="1" align="center" cellspacing="0" class="display select" id="example">
        <thead>
            <tr>
			 <th><input name="select_all" value="1" type="checkbox"></th> 
              <th width="10%" nowrap>Agency</th>
              <th width="10%" nowrap>Applicant ID </th>
                <th width="16%" nowrap>APPLICANT NAME</th>
                <th width="4%" nowrap>IFSC</th>
                <th width="13%" nowrap>MM Claim Date </th>
				<th width="16%" nowrap>MM Claim </th>
				<th width="11%" nowrap>Process Date </th>
				<th width="11%" nowrap>View</th>
				<th width="0%" nowrap>Update</th>
				<th width="0%" nowrap>Current Status</th>
				<th width="14%" nowrap>Appv../Sub. by </th>
            </tr>
        </thead>
        <tfoot>
            <tr>
			<th>&nbsp;</th>
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
				<th>Appv../Sub. by </th>
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
qrysb.append("   AND MRT.PACT_ID       = BAS.ACT_ID"      );
qrysb.append("   AND MRT.USER_ID       = MU.USER_ID"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0"      );
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("   AND BD.APPRV_YN      IS NOT NULL AND BD.APPRV_YN='S' "      );


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
			<td >	  
	   <%= APP_ID %>
	       </td>
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
                            <td><input name="btnDocument" type="button" class="buttonGray" id="btnDocument" onClick="processApproval('<%=APP_ID%>');" value="Status"></td>
                            <td><%= ACT_DESC  %></td>
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
 
 function processApproval(pAppid){
var urlpar='StatusUpdateApproval.jsp?APP_ID='+pAppid;
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