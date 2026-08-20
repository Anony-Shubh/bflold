<%@ include file="includeHeaderPage.jsp" %>


<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="../css/select.dataTables.min.css"/>
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<script language="javascript" src="../js/datatables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>


<script>


 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("img/loading.gif");
 modalWin.SetCloseButtonImagePath("img/remove.gif");
 //Uncomment below line to make look buttons as link
//modalWin.SetButtonStyle("background:blue;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(param){
 var callbackFunctionArray = new Array(EnrollLater);
 modalWin.ShowURL('dltfcPendingProcessByAgency.jsp?'+param,600,750,'PMEGP Application for DLTFC Meeting',null,callbackFunctionArray);
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
   $('#frm-example').on('submit', function(e){
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


<form id="frm-example" name="frm-example" method="post">
    <div align="center">
        <%
String SOFF_CD =(String) session.getAttribute("off_cd");
 DBCon db= new DBCon();
  db.connect(); 
	
String APP_ID = "";
String APP_NAME = "";
String GENDER = "";
String ACT_DESC = "";
String MOB_NO1 = "";
String AADHAR_NO = "";
String PAN_NO = "";
String MT_DATE = "";
String FORD_DT_DLTFC = "";
String MTG_ID="";
String ONLINE_SUBDT="";
String DLTFC_REMARK="";

	 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT "      );
qrysb.append("   TO_CHAR(AD.FORD_DT_DLTFC, 'dd-mon-yyyy')     AS FORD_DT_DLTFC,"      );
qrysb.append("   AD.APP_ID, MOM.AGENCY_TYPE, "      );
qrysb.append("    AD.MTG_ID,TO_CHAR(AD.ONLINE_SUBDT, 'dd-mon-yyyy') AS ONLINE_SUBDT, "      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("      AD.GENDER,"      );
qrysb.append("     AD.BENF_CATAGORY_CD,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.AADHAR_NO,  "      );
qrysb.append("     AD.PAN_NO,ASM.ACT_DESC,TO_CHAR(AMM.MT_DATE,'dd-mon-yyyy') AS MT_DATE, AD.DLTFC_REMARK "      );
qrysb.append("     FROM APP_DETAIL AD,"      );
qrysb.append("     MAS_OFF_MAST MOM,APP_STATUS_MAST ASM, APP_MEETING_MAST AMM "      );
qrysb.append("   WHERE"      );
qrysb.append("   AD.ACT_ID=ASM.ACT_ID"      );
qrysb.append("   AND AD.OFF_CD   = "+SOFF_CD+"  AND AD.ACT_ID IN (2,7) AND AD.ACT_YN='Y'"      );
qrysb.append("   AND AD.OFF_CD=MOM.OFF_CD AND AD.MTG_ID   = AMM.MTG_ID(+)"      );


	    ResultSet rs = db.execSQL(qrysb.toString());
		//out.print(qrysb.toString());
    %>	
	    
	
      </p>
      <input name="Submit" type="submit" class="button" value=" Click here to Place in DLTFC  Meeting" >
    </div>
  <table border="1" align="center" cellspacing="0" class="display select" id="example">

 <thead>
               <tr>
                 <th><input name="select_all" value="1" type="checkbox"></th>                 
                 <th>Applicant ID</th>
                 <th>Name</th>         
	             <th>Gender</th>	            
	             <th>Aadhaar</th>
	             <th>PAN</th>
				 <th>Online Submission Date</th>	            			 
	             <th> DLTFC Meeting Date</th> 
				 <th> Meeting ID</th>	
	             <th>Contact No</th>
				 <th>Current Status</th>
				  <th>DLTFC Remark</th>
    </thead>
  <tfoot>
            <tr>
              <th>&nbsp;</th>
              <th>Applicant ID</th>
              <th>Name</th>         
	          <th>Gender</th>	            
	          <th>Aadhaar</th>
	          <th>PAN</th>
			  <th>Online Submission Date</th>	
              <th>Previous DLTFC Meeting Date</th>  
			  <th> Meeting ID</th>
	          <th>Contact No</th>
		      <th>Current Status</th>
			  <th>DLTFC Remark</th>
			  
      </tr>
    </tfoot>
  <%

	 String c="";
	 int cnt=0;
	 while (rs.next()){
	
APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
GENDER=rs.getString("GENDER")==null?"":rs.getString("GENDER");
ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
MOB_NO1=rs.getString("MOB_NO1")==null?"":rs.getString("MOB_NO1");
AADHAR_NO=rs.getString("AADHAR_NO")==null?"":rs.getString("AADHAR_NO");
PAN_NO=rs.getString("PAN_NO")==null?"":rs.getString("PAN_NO");
ONLINE_SUBDT=rs.getString("ONLINE_SUBDT")==null?"":rs.getString("ONLINE_SUBDT");
MT_DATE=rs.getString("MT_DATE")==null?"":rs.getString("MT_DATE");
FORD_DT_DLTFC=rs.getString("FORD_DT_DLTFC")==null?"":rs.getString("FORD_DT_DLTFC");
MTG_ID=rs.getString("MTG_ID")==null?"":rs.getString("MTG_ID");	
DLTFC_REMARK=rs.getString("DLTFC_REMARK")==null?"":rs.getString("DLTFC_REMARK");	
	
	 %>
	 <tr>
	   <td >
	  
	   <%= APP_ID %>
	       </td>
	 
	   
	   <td ><div align="center"><%= APP_ID %></div></td>
           <td ><div align="center"><%= APP_NAME %></div></td>
           <td ><%= GENDER %></td>           
           <td ><%= AADHAR_NO %></td>
           <td ><%= PAN_NO %></td>
		   <td ><%= ONLINE_SUBDT%></td>
           <td ><%= MT_DATE %></td>
		   <td ><%=MTG_ID %></td>
           <td ><%= MOB_NO1 %></td>
		   <td ><%= ACT_DESC %></td>
		   <td ><%=DLTFC_REMARK%></td>
    </tr>
	<%}
   rs.close();
   db.close();
 
   %> 	
</table>

</form>

</html>