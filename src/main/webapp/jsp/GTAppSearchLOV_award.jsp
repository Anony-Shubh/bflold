<%@ include file="includeHeaderPage.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<SCRIPT>
 function strExcel()
  {
  window.location.href = '../jasperrop/generateExcel.jsp?REPNAME=GeoAppreport';

}
</SCRIPT>
</head>
<body>
<form name="form" id="form"  method="post">
<%
String txt="";
String txtSearch="";
	  String str= "";

%>

<TABLE align="center" class="pmegpTable">
   
    <TR>
      <TD colspan="19"><DIV align="center">PMEGP AWARD </DIV><DIV align="right"><a download href="../documents/Awards_Guidelines_Circular.pdf">Download Guideline Circular</a></DIV></TD>
    </TR>
    
  </TABLE>

<br>

<table align="center" cellspacing="0" class="display" id="example" width="100%">
        <thead>
             <TR>
      <TH width="5%">Srno</TH>
       <TH width="15%">ID</TH>
      <TH width="27%" nowrap>Applicant Name</TH>
      
       <TH width="22%" nowrap>Current Status </TH>
       <TH width="8%" nowrap>Approver Status </TH>
       <TH width="8%" nowrap>Report</TH>
       <TH width="8%" nowrap>Documents</TH>
	   
	   <TH width="7%" nowrap>Form</TH>
       <TH width="8%" nowrap>Status</TH>
       </TR>
        </THEAD>
		 <TFOOT>
		<TR>
		<TH >Srno</TH>
       <TH >ID</TH>
       <TH >Applicant Name</TH>
     
       <TH nowrap>Current Status </TH>
       <TH nowrap>Approver Status </TH>
       <TH nowrap>Report</TH>
       <TH >Documents</TH>
	    <TH nowrap>Form</TH>
       <TH >Status</TH>
       </TR>
        </tfoot>
		        <tbody>
	 <% 
	  

String APP_ID =request.getParameter("APP_ID");
String UNIT_NAME="";
String DCO_APPROV_YN = "";
String APP_APPROV_YN = "";

ResultSet  rs;
 
int count=0;
String vOffcd= (String) session.getAttribute("off_cd");


DBCon db= new DBCon();
db.connect();
 
 List values=new ArrayList();
StringBuffer qrysb= new StringBuffer();
	



qrysb.append(" SELECT DECODE(pa.APP_APPROV_YN, 'Y', 'Forwarded to Central Office', 'N', 'Returned to DCO', 'Pending') APP_APPROV_YN, pa.APP_ID, ad.APP_NAME AS UNIT_NAME,   "      );
qrysb.append("  DECODE(pa.DCO_APPROV_YN, 'Y', 'Recommended to Approver', 'N', 'Returned to Benificiary', 'New') AS DCO_APPROV_YN  "      );
qrysb.append("  FROM pmegp_award pa, app_detail ad, m_district md, m_state ms,mas_off_mast mom  "      );
qrysb.append("  WHERE pa.APP_ID      = ad.APP_ID AND ad.UNIT_DIST_CD  = md.DISTRICT_CD  "      );
qrysb.append("  AND md.STATE_CD      = ms.STATE_CD AND ad.off_cd=mom.off_cd AND pa.FINAL_SUB_DT IS NOT NULL and mom.off_cd=?  "      );



 values.add(vOffcd); 
  



//qrysb.append("  and ad.off_cd=? "      );

	
//out.print(qrysb.toString());


 //values.add(vOffcd); 
  // rs = db.execSQL(qrysb.toString());
  rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  //  ResultSet rsupdt = db.executeSQL("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ",values);
	// rsupdt.close();
   //values.clear();

	while (rs.next()){
	
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");	
	UNIT_NAME=rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
	DCO_APPROV_YN=rs.getString("DCO_APPROV_YN")==null?"":rs.getString("DCO_APPROV_YN");
	APP_APPROV_YN=rs.getString("APP_APPROV_YN")==null?"":rs.getString("APP_APPROV_YN");
	
	count=count+1;
 //session.setAttribute("APP_ID",APP_ID);
  
    %>
     <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID %>">
		   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=vOffcd %>">       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= UNIT_NAME %> </TD>
     
      <TD><%= DCO_APPROV_YN %></TD>
      <TD>
	  <%if(!APP_APPROV_YN.equals("Returned to DCO")){%>	  
	  <%= APP_APPROV_YN %>
	  <%}else{%>
	  <div style="color:#FF0000;"><%= APP_APPROV_YN %></div>
	  <%}%>
	  </TD>
      <TD><DIV align="center">
	
	  
	  <A onClick="ShowReport('<%=APP_ID%>','1')"  class="greenButtonRound">View</A>
	  
	  </DIV></TD>
      <TD>
	  <DIV align="center"><A href="awardviewdocument.jsp?app_id=<%= APP_ID %>&app_name=<%= UNIT_NAME %>"  class="greenButtonRound">View</A></DIV>	 </TD>
	   <TD><DIV align="center"><A href="award_nomination.jsp?app_id=<%= APP_ID %>&app_name=<%= UNIT_NAME %>"  class="greenButtonRound">Update</A></DIV></TD>
	   <TD><DIV align="center"><A onClick="changestatus('<%=APP_ID%>','<%= UNIT_NAME %>')"  class="greenButtonRound">Update</A></DIV></TD>
     
      </tr>
			<%
			}
			
	  rs.close();
			db.close();
			
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
 function GTSTATUS(APP_ID,PMEGPGEOTAGID){
var callbackFunctionArray = new Array(refreshpage);
modalWin.ShowURL("appgeoStatUpdate.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,700,850,'Status',null,null);
//modalWin.ShowURL("systemValidRepo.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,500,800,'Status',null,null);
 }//end of bank

 	function changestatus(APP_ID,UNIT_NAME){
 modalWin.ShowURL('award_status.jsp?app_id='+APP_ID+'&UNIT_NAME='+UNIT_NAME,400,800,'PMEGP Nomination Award Status Change',null,null);
 }
 
  	function ShowReport(APP_ID,typenew){
 modalWin.ShowURL('../pmegpaward/genrep.jsp?REP_NM=pmegpaward_report&app_id='+APP_ID+'&typenew='+typenew,800,1200,'PMEGP Nomination Award Report',null,null);
 }
 

function refreshpage() {
  location.reload();
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}


function refresh_da(){
window.parent.location.reload();
}

  </script>
    </p>

</form>
</body>
	</html>