<%@ include file="includeHeaderPageDLTFC.jsp" %>
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

String U_COUNT=(String) session.getAttribute("sUC")==null?"0":(String)session.getAttribute("sUC");
	
		try {
if (U_COUNT.equals("0")){
response.sendRedirect("Msg.jsp");
}
	}catch (Exception m) {}		
	

%>

<TABLE align="center" class="pmegpTable">
   
    <TR>
      <TD colspan="19"><DIV align="center">PMEGP AWARD</DIV><DIV align="right"><a style="color:#FFFFFF;" download href="../documents/Awards_Guidelines_Circular.pdf">Download Guideline Circular</a></DIV></TD>
    </TR>
    
  </TABLE>

<br>

<table align="center" cellspacing="0" class="display" id="example" width="100%">
        <thead>
 <TR>
      <TH>Srno</TH>
       <TH>ID</TH>
      <TH>Unit Name</TH>  
	  <TH>Unit District</TH> 
	  <TH>Implementing Agency</TH>     
       <TH>Current Status </TH>
       <TH>Report</TH>
       <TH>Documents</TH>
	   
	   <TH>Form</TH>
       <TH>Status</TH>
       </TR>
        </thead>
		
<tbody>
	 <% 
	  

String APP_ID =request.getParameter("APP_ID");
String UNIT_NAME="";
String APP_APPROV_YN = "";
//out.print(SOFF_CD);
String DISTRICT_NAME="";
String AGENCY_TYPE="";

ResultSet  rs;
 
int count=0;
String vOffcd= (String) session.getAttribute("sOffCd");
out.print(vOffcd);

DBCon db= new DBCon();
db.connect();
 
StringBuffer qrysb= new StringBuffer();
List values=new ArrayList();

 	
if(!SLOGINTYPE.equals("Y")){
qrysb.append(" SELECT pa.APP_ID,pa.UNIT_NAME,md.DISTRICT_NAME,mom.AGENCY_TYPE,"      );
qrysb.append(" DECODE(pa.APP_APPROV_YN, 'Y', 'Forward to Central Office', 'N', 'Returned to DCO', 'New') AS APP_APPROV_YN "      );
qrysb.append(" FROM pmegp_award pa, app_detail ad,  M_DISTRICT md,  M_STATE ms,  mas_off_mast mom "      );
qrysb.append(" WHERE pa.APP_ID      = ad.APP_ID AND ad.UNIT_DIST_CD  = md.DISTRICT_CD AND md.STATE_CD      = ms.STATE_CD   "      );
qrysb.append(" AND ad.OFF_CD        = mom.OFF_CD AND pa.FINAL_SUB_DT IS NOT NULL AND pa.DCO_APPROV_YN = 'Y' and ad.off_cd=?   "      );
 values.add(vOffcd);
}
else{
qrysb.append(" SELECT pa.APP_ID,pa.UNIT_NAME,md.DISTRICT_NAME,mom.AGENCY_TYPE, "      );
qrysb.append(" DECODE(pa.APP_APPROV_YN, 'Y', 'Forward to Central Office', 'N', 'Returned to DCO', 'New') AS APP_APPROV_YN "      );
qrysb.append(" FROM pmegp_award pa, app_detail ad,  M_DISTRICT md,  M_STATE ms,  mas_off_mast mom "      );
qrysb.append(" WHERE pa.APP_ID      = ad.APP_ID AND ad.UNIT_DIST_CD  = md.DISTRICT_CD AND md.STATE_CD      = ms.STATE_CD   "      );
qrysb.append(" AND ad.OFF_CD        = mom.OFF_CD AND pa.FINAL_SUB_DT IS NOT NULL AND pa.DCO_APPROV_YN = 'Y' and ad.off_cd in  "      );
qrysb.append(" (SELECT OFF_CD  FROM MAS_OFF_MAST WHERE OFF_TYPE_CD IN (2,3) AND ACT_YN='Y' AND MIS_OFF_CD=(select mis_off_cd from mas_off_mast where off_cd=?))  "      );
 values.add(vOffcd);
}


//qrysb.append("  and ad.off_cd=? "      );

	
//out.print(qrysb.toString());

  // rs = db.execSQL(qrysb.toString());
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  //  ResultSet rsupdt = db.executeSQL("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ",values);
	// rsupdt.close();
   //values.clear();

	while (rs.next()){
	
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");	
	UNIT_NAME=rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
	APP_APPROV_YN=rs.getString("APP_APPROV_YN")==null?"":rs.getString("APP_APPROV_YN");
	AGENCY_TYPE=rs.getString("AGENCY_TYPE")==null?"":rs.getString("AGENCY_TYPE");
	DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
	count=count+1;
 //session.setAttribute("APP_ID",APP_ID);
  
    %>
     <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID %>">
		   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=vOffcd %>">       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= UNIT_NAME %> </TD>
	   <TD><%= DISTRICT_NAME %> </TD>
	    <TD><%= AGENCY_TYPE %> </TD>
     
      <TD><%= APP_APPROV_YN %></TD>
      <TD><DIV align="center">
	
	  
	  <A onClick="ShowReport('<%=APP_ID%>','1')"  class="greenButtonRound">View</A>
	  
	  </DIV></TD>
      <TD>
	  <DIV align="center"><A href="awardviewdocument.jsp?app_id=<%= APP_ID %>&app_name=<%= UNIT_NAME %>"  class="greenButtonRound">View</A></DIV>	 </TD>
	   <TD><DIV align="center"><A href="award_nomination.jsp?app_id=<%= APP_ID %>&app_name=<%= UNIT_NAME %>"  class="greenButtonRound">View</A></DIV></TD>
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


</form>
</body>
	</html>