<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Bank applicant view</title>
<%@ include file="headerfile.jsp" %>
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/scroller/1.4.2/js/dataTables.scroller.min.js" type="text/javascript"></script>
<link href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="https://cdn.datatables.net/scroller/1.4.2/css/scroller.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<style type="text/css">

.text-wrap{
    white-space:normal;
}
.width-200{
    width:200px;
}
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
</style>
<script>
$(document).ready(function() {
    $('#example').DataTable( {
		
       "ajax": "jsonBankWiseReport.jsp", 
            
       
		
		
		"columns":
		[
		
		{ title: "Sr No", "data": "SRNO"  },
		{ title: "Application ID", "data": "APP ID"   },
            { title: "Applicant Name", "data": "APP NAME"   },
			{ title: "NEFT IFS Code", "data": "IFSCODE"    },	
			{ title: "MM Claim Amt", "data": "AMOUNT"    },	
            { title: "MM Claim Date", "data": "MMDT"    },			
			{ title: "Batch ID", "data": "BATCHID"    },
			{ title: "Batch Date", "data": "BATCHDATE"    },
			{ title: "UTRN No.", "data": "UTRNNO"    },
			{ title: "MM Disbursement Status", "data": "STATUS"    },
			
			{ title: "Branch Account No.", "data": "ACCNO"    },
			{ title: "MM Release Amt", "data": "MMRELAMT"    },
			{ title: "MM Release Date", "data": "MMRELDT"    },	
	        { title: "Update", "data": "UPDATE"    },
			{ title: "Generate", "data": "GENERATE"    },
			{ title: "Fail Disbursement Remarks/ Refer by CO,Mumbai to KVC Field office Remarks", "data": "FAILREMARKS"    }    
		 ],
		

/*
 columns: [
                { title: "ID", data: "ID" },
                { title: "First Name", data: "FirstName" },
                { title: "Change Summary", data: "LastName"},
                { title: "Details", data: "Details" },
                { title: "Country", data: "Country" }               
            ],
			*/
            columnDefs: [
                {
                    render: function (data, type, full, meta) {
                        return "<div class='text-wrap width-200'>" + data + "</div>";
                    },
                    targets: 14
					
                }
             ],
/*
        deferRender:    true,		
        scrollY:        400,
		 
        scrollCollapse: true,
		stateSave: true,
        scroller:       
		{
			loadingIndicator:true
		}
		*/
		
		 
        deferRender:    true,
        scrollX:        true,
        scrollY:        false,
        scrollCollapse: true,
        scroller:       false,
        searching:      true,
        paging:         true,
        info:           false
    } );
	

	
	
} );



</script>
</head>
<body>
<br> 
 <form name="form" id="form"  class="form" method="post">
	  

    <table id="example"    cellspacing="0" width="98%" >
     <!--  <thead>
   
    <tr>
      <th  nowrap   >Sr No </th>
      <th  nowrap   >Application ID</th>
	  <th  nowrap   >Applicant Name</th>
	  <th  nowrap   >NEFT IFS Code</th>
	  <th  nowrap   >MM Claim Amt</th> 
      <th  nowrap   >MM Claim Date</th>
      <th  nowrap   >Batch Id</th>     
      <th  nowrap   >Batch Date</th>
	  <th  nowrap   >UTRN No </th>
	  <th  nowrap   >MM Disbursement Status</th>
	  <th  nowrap    >Branch Account No </th>
	  <th  nowrap   >MM Release Amt</th>
	  <th  nowrap   >MM Release Date</th>	  
	  <th  nowrap   >Update</th>
	  <th  nowrap   >Fail Disbursement Remarks/ Refer by CO,Mumbai to KVC Field office Remarks</th>
      </tr>
	
	</thead>
	     <tfoot>
   
    <tr>
      <th  nowrap >Sr No </th>
      <th  nowrap   >Application ID</th>
	  <th  nowrap   >Applicant Name</th>
	  <th  nowrap   >NEFT IFS Code</th>
	  <th  nowrap   >MM Claim Amt</th> 
      <th  nowrap   >MM Claim Date</th>
      <th  nowrap   >Batch Id</th>     
      <th  nowrap   >Batch Date</th>
	  <th  nowrap   >UTRN No </th>
	  <th  nowrap   >MM Disbursement Status</th>
	  <th  nowrap   >Branch Account No </th>
	  <th  nowrap   >MM Release Amt</th>
	  <th  nowrap   >MM Release Date</th>	  
	  <th  nowrap   >Update</th>
	  <th  nowrap   >Fail Disbursement Remarks/ Refer by CO,Mumbai to KVC Field office Remarks</th>
      </tr>
	
	</tfoot>	
		-->
</table>
<p>&nbsp;</p>
   <p class="mtextarea"></p>
  <p class="mtextarea">For MM Claim related queries (PMEGP,MUMBAI) contact No: # 022-26713686 and send email to<span class="OrangeLebel"><em>
  <bold>pmegp.kvic@gov.in</bold> </em></span></p>
  <p class="mtextarea">For Govt. Subsidy Release</p>
  <p class="mtextarea">(1) claim before 30th June,2020 contact  ( Corp. Bank) queries contact :022-22835701 ( cb0511@unionbankofindia.com) </p>
  <p class="mtextarea">(2) claim after 30th June,2020 contact (Indian Bank) queries email : pmegp.narimanpoint@indianbank.co.in </p>
  <p>&nbsp;
   </p>
  <p align="center"> 
    <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowNewPage(vappid,filename){
var urlpar=filename+'?APP_ID='+vappid;
var callbackFunctionArray = new Array(refresh_data);

 modalWin.ShowURL(urlpar,750,1100,'View Application',null,null);
 }//end of bank
  function ShowNewPage1(vappid,filename){
var urlpar=filename+'?APP_ID='+vappid;
 var callbackFunctionArray = new Array(refresh_data);

 modalWin.ShowURL(urlpar,750,1100,'View Application',null,null);
 }//end of bank
function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refresh_data() {
   form.submit(); 
}


  </script>
    
</p>
 </form>
</body>
</html>