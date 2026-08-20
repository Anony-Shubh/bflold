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
      <TD colspan="19"><DIV align="center">Geotagging Status Update</DIV></TD>
    </TR>
    <TR>
      <TD colspan="18"><DIV align="center">Enter Applicant ID or  Applicant Name :
          <INPUT name="txtSearch" type="text"  id="txtSearch" size="25" maxlength="25" value="<%= txt %>" />
       <INPUT name="btnSearch" type="submit" class="button" id="btnSearch"  onClick="strFind()" value="Search Applicant">
	    <INPUT name="btnSearch" type="button" class="button" id="btnSearch"  onClick="strExcel()" value="Download Data In Excel"></DIV>	   </TD>
    </TR>
	</TABLE>
<table align="center" cellspacing="0" class="display" id="example">
        <thead>
             <TR>
      <TH nowrap>Srno</TH>
       <TH nowrap>ID</TH>
       <TH nowrap>Name</TH>
       <TH nowrap>Bank Name</TH>
       <TH nowrap>IFSCCode</TH>
       <TH nowrap>MM Release Date</TH>
       <TH nowrap>MM Release Amount</TH>
       <TH nowrap>Verification Date </TH>
       <TH nowrap>Verification Status </TH>
       <TH nowrap>Verification Remarks </TH>
       <TH nowrap>Current Status </TH>
       <TH nowrap>MM Adjustment Amount </TH>
       <TH nowrap>Agency Remark </TH>
       <TH nowrap>Geolocation of The Unit</TH>
       <TH nowrap>Status</TH>
       <TH nowrap>Documents</TH>
       <TH nowrap>Report</TH>
       <TH nowrap>Adjustment Letter </TH>
    
</TR>
        </THEAD>
		 <TFOOT>
		<TR>
		<TH >Srno</TH>
       <TH >ID</TH>
       <TH >Name</TH>
       <TH >Bank Name</TH>
       <TH >IFSCCode</TH>
       <TH >MM Release Date</TH>
       <TH >MM Release Amount</TH>
       <TH >Verification Date </TH>
       <TH >Verification Status </TH>
       <TH >Verification Remarks </TH>
       <TH >Current Status </TH>
       <TH >MM Adjustment Amount </TH>
       <TH >Agency Remark </TH>
       <TH >Geolocation of The Unit</TH>
       <TH >Status</TH>
       <TH >Documents</TH>
       <TH >Report</TH>
       <TH >Adjustment Letter </TH>
	   </TR>
   
        </tfoot>
		        <tbody>
	 <% 
	  

String APP_ID =request.getParameter("APP_ID");
String APP_NAME = "";
String BANK_NAME = "";
String IFSC_CODE = "";
String MM_REL_DT = "";
String MM_REL_AMT = "";
String IS_MARGIN_MONEY_CALLBACK_ = "";
String IS_MARGIN_MONEY_ELIGIBLE_FOR_A = "";
String VERIFICATION_DATETIME = "";
String VERIFICATION_STATUS = "";
String VERIFIER_REMARKS = "";
String DATE_OF_VERIFICATION="";
String PMEGPGEOTAGID="";


 
  String BANKFOR_YN="";
if (request.getParameter("txtSearch") != null || txtSearch !=""){
			txtSearch ="%"+(String) request.getParameter("txtSearch")+"%";
			txt=(String)request.getParameter("txtSearch");
			}else{
			txtSearch ="%%";
			txt="";
			}
ResultSet  rs;
 
 int count=0;
 String vOffcd= (String) session.getAttribute("off_cd");
 
 
 //out.print(BANKFOR_YN);
 
 
 String qryE="";

 
 
 
	//out.print(vOffcd);
DBCon db= new DBCon();
db.connect();
 
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("   SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,"      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,"      );
qrysb.append("   GT.VERIFICATION_STATUS,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     GEOTAG_TRANS GT,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM"      );
qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );
qrysb.append("   AND AD.APP_ID       = GT.APP_ID"      );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD"      );
qrysb.append("   AND BD.PACT_ID      = 34"      );


	
qrysb.append("   AND UPPER(AD.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(AD.APP_NAME)) LIKE TRIM(UPPER(?)) ORDER BY GT.DATE_OF_VERIFICATION DESC"      );
/*
qrysb.append("   WHERE ad.ACT_ID     = asm.ACT_ID "      );
qrysb.append("   AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND UPPER(ad.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(ad.APP_NAME)) LIKE TRIM(UPPER(?))"      );
qrysb.append("   AND AD.OFF_CD=? ORDER BY ad.ONLINE_SUBDT DESC"      );
*/
	
//out.print(qrysb.toString());
List values=new ArrayList();

values.add(txtSearch);
  
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  //  ResultSet rsupdt = db.executeSQL("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ",values);
	// rsupdt.close();
   //values.clear();
  
  String param="";
	while (rs.next()){
	
	
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");	
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	BANK_NAME=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
	IFSC_CODE=rs.getString("IFSC_CODE")==null?"":rs.getString("IFSC_CODE");
	MM_REL_DT=rs.getString("MM_REL_DT")==null?"":rs.getString("MM_REL_DT");
	MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
	IS_MARGIN_MONEY_CALLBACK_=rs.getString("IS_MARGIN_MONEY_CALLBACK_")==null?"":rs.getString("IS_MARGIN_MONEY_CALLBACK_");
	IS_MARGIN_MONEY_ELIGIBLE_FOR_A=rs.getString("IS_MARGIN_MONEY_ELIGIBLE_FOR_A")==null?"":rs.getString("IS_MARGIN_MONEY_ELIGIBLE_FOR_A");
	VERIFICATION_DATETIME=rs.getString("VERIFICATION_DATETIME")==null?"":rs.getString("VERIFICATION_DATETIME");
	VERIFICATION_STATUS=rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
	VERIFIER_REMARKS=rs.getString("VERIFIER_REMARKS")==null?"":rs.getString("VERIFIER_REMARKS");
	DATE_OF_VERIFICATION=rs.getString("DATE_OF_VERIFICATION")==null?"":rs.getString("DATE_OF_VERIFICATION");
	PMEGPGEOTAGID=rs.getString("PMEGPGEOTAGID")==null?"":rs.getString("PMEGPGEOTAGID");
	param="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	//geoparam="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	count=count+1;

   
    %>
     <INPUT name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>">
		   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=vOffcd %>">       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>
      <TD><%= BANK_NAME %></TD>
      <TD><%= IFSC_CODE %></TD>
      <TD><%= MM_REL_DT %></TD>
      <TD><%= MM_REL_AMT %></TD>
      <TD><%= DATE_OF_VERIFICATION %> </TD>
      <TD><DIV align="center"><%= VERIFICATION_STATUS %> </DIV></TD>
      <TD><%= VERIFIER_REMARKS %></TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD> <DIV align="center"><A href="javascript: mypopup('geoMap.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</A></DIV></TD>
      <TD><DIV align="center"><A onClick="GTSTATUS('<%= APP_ID %>','<%= PMEGPGEOTAGID %>');"  class="greenButtonRound">Update</A></DIV></TD>
      <TD><DIV align="center"><A href="javascript: mypopup('GTDocuments.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</A></DIV></TD>
      <TD><DIV align="center"><A target="_blank" href="PMEGPGenAppForm.jsp?RNAME=GEOTAGREPORT&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">View</A></DIV></TD>
      <TD><DIV align="center"><A download href="pdf/AdjustmentLetter.docx" class="greenButtonRound">Download</A></DIV></TD>
  
	

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
 modalWin.ShowURL("GTStatusUpdate1.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,600,1500,'Status',null,null);
 }//end of bank

function refreshpage() {
  location.reload();
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

  </script>
    </p>

</form>
</body>
	</html>