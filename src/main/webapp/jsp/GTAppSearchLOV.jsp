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
    
  </TABLE>
<br>
<center><h2><strong>(*) Date is Calculated from the date of First Loan Disbursement. <br>
Note: After Approval , Download the MM Adjustment Letter and Upload Signed and Stamped Copy Under Adj. Letter Upload Column. <br>
This will enable the financing bank to adjust the Govt. Subsidy.
</strong></h2></center>
<br>

<table align="center" cellspacing="0" class="display" id="example" width="100%">
        <thead>
             <TR>
      <TH>Srno</TH>
       <TH>ID</TH>
      <TH nowrap>Name</TH>
      
     
       <TH nowrap>Verified by </TH>
       <TH nowrap>Verification Date </TH>
       <TH >Verification Status </TH>
      
       <TH nowrap>Current Status </TH>
	    
       <TH >MM Release Amount </TH>
	    <TH >MM Adjustment </TH>
		 <TH >MM Callback </TH>
	     <TH >3 Yrs Completed*</TH>
		  <TH nowrap>Edit</TH>
       <TH nowrap>Status</TH>
	   
	  
       <TH nowrap>PullBack</TH>
	    <TH nowrap>PV</TH>
       <TH nowrap>Geolocation</TH>
       
       <TH nowrap>Documents</TH>
      
       <TH nowrap>Adjustment Letter </TH>
	   <TH nowrap>Adj. Letter Upload </TH>
	    <TH nowrap>Other Document</TH>
</TR>
        </THEAD>
		 <TFOOT>
		<TR>
		<TH >Srno</TH>
       <TH >ID</TH>
       <TH >Name</TH>
     
     
       <TH >Verified by</TH>
       <TH >Verification Date </TH>
       <TH >Verification Status </TH>
       
       <TH >Current Status </TH>
       <TH >MM Adjustment </TH>
	    <TH >MM Adjustment </TH>
		
		 <TH >MM Adjustment </TH>
	   <TH> 3 Yrs Completed</TH>
	    <TH nowrap>Edit</TH>
       <TH >Status</TH>
	    <TH nowrap>PullBack</TH>
	    <TH nowrap>PV</TH>
       
        <TH >Geolocation</TH>
       
       <TH >Documents</TH>
       
       <TH >Adjustment Letter </TH>
	     <TH >Upload</TH>
		  <TH nowrap>Other Document</TH>
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
 String ADJ_YN="";
String MM_ADJUSTMENT_AMT_S=""; 
 //out.print(BANKFOR_YN);
 
 
 String qryE="";
String DOC_NAME="";
String ACT_ID="";
String MM_ADJUSTMENT_STATUS=""; 
 String CUR_STA="";
 String MM_ADJ_YN="";
 String MM_LOAN_DT="";
 String VERIFICATION_BY="";
 
	//out.print(vOffcd);
DBCon db= new DBCon();
db.connect();
 
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("  SELECT * FROM ( SELECT GT.PMEGPGEOTAGID,upper(gt.verification_by) as verification_by,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N0' ELSE 'YES' END AS MM_ADJ_YN, "      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,"      );
qrysb.append("     BD.MM_REL_AMT,GT.AGN_CALLBACK,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,GT.AGENCY_UPLOAD AS DOC_NAME,GT.ACT_ID,GT.MM_ADJUSTMENT_STATUS,GR.CO_REMARKS,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,CASE WHEN GT.LATITUDE IS NULL AND GT.LONGITUDE IS NULL THEN 'N' ELSE 'Y' END AS GEOYN, "      );
qrysb.append("   GT.VERIFICATION_STATUS,GT.MM_ADJUSTMENT_AMT_S,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,CASE WHEN GT.MM_ADJUSTMENT_STATUS IN ('PA','FD','FA') THEN 'Y' ELSE 'N' END  AS ADJ_YN,CASE WHEN GT.ACT_ID=1 THEN 'Approved' WHEN GT.ACT_ID=2 THEN 'Returned For Resubmission'  else '' end as CUR_STA,GT.QC_APPRV  "      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     GEOTAG_TRANS GT,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM,GEOTAG_REMARKS GR"      );
qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );
qrysb.append("   AND AD.APP_ID       = GT.APP_ID"      );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD"      );
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.REMTRID=GR.REMTRID(+) "      );
qrysb.append("   AND UPPER(AD.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(AD.APP_NAME)) LIKE TRIM(UPPER(?)) AND AD.OFF_CD=? "      );
qrysb.append("  UNION ");
qrysb.append(" SELECT GT.PMEGPGEOTAGID,upper(gt.verification_by) as verification_by,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN, "      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,"      );
qrysb.append("     BD.MM_REL_AMT,GT.AGN_CALLBACK,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,GT.AGENCY_UPLOAD AS DOC_NAME,GT.ACT_ID,GT.MM_ADJUSTMENT_STATUS,GR.CO_REMARKS,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,CASE WHEN GT.LATITUDE IS NULL AND GT.LONGITUDE IS NULL THEN 'N' ELSE 'Y' END AS GEOYN, "      );
qrysb.append("   GT.VERIFICATION_STATUS,GT.MM_ADJUSTMENT_AMT_S,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,CASE WHEN GT.MM_ADJUSTMENT_STATUS IN ('PA','FD','FA') THEN 'Y' ELSE 'N' END  AS ADJ_YN,CASE WHEN GT.ACT_ID=1 THEN 'Approved' WHEN GT.ACT_ID=2 THEN 'Returned For Resubmission'  else '' end as CUR_STA,GT.QC_APPRV "      );
qrysb.append("   FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     GEOTAG_TRANS GT,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM,GEOTAG_REMARKS GR"      );
qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );
qrysb.append("   AND AD.APP_ID       = GT.APP_ID"      );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD"      );
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.REMTRID=GR.REMTRID(+) "      );
qrysb.append("   AND UPPER(AD.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(AD.APP_NAME)) LIKE TRIM(UPPER(?)) AND AD.OFF_CD=?  ) WHERE QC_APPRV='Y' ORDER BY DATE_OF_VERIFICATION DESC"      );

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
 values.add(vOffcd); 
 values.add(txtSearch);
 values.add(vOffcd); 
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  //  ResultSet rsupdt = db.executeSQL("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ",values);
	// rsupdt.close();
   //values.clear();
  String GEOYN="";
  String param="";
  String AGN_CALLBACK="";
  String CO_REMARKS="";
	while (rs.next()){
	VERIFICATION_BY=rs.getString("VERIFICATION_BY")==null?"":rs.getString("VERIFICATION_BY");
	GEOYN=rs.getString("GEOYN")==null?"":rs.getString("GEOYN");
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
	MM_ADJUSTMENT_AMT_S=rs.getString("MM_ADJUSTMENT_AMT_S")==null?"":rs.getString("MM_ADJUSTMENT_AMT_S");
	param="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	//geoparam="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	ADJ_YN=rs.getString("ADJ_YN")==null?"":rs.getString("ADJ_YN");
	DOC_NAME=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	MM_ADJUSTMENT_STATUS=rs.getString("MM_ADJUSTMENT_STATUS")==null?"":rs.getString("MM_ADJUSTMENT_STATUS");
	CUR_STA=rs.getString("CUR_STA")==null?"":rs.getString("CUR_STA");
//out.print(ADJ_YN);
AGN_CALLBACK=rs.getString("AGN_CALLBACK")==null?"":rs.getString("AGN_CALLBACK");
CO_REMARKS=rs.getString("CO_REMARKS")==null?"":rs.getString("CO_REMARKS");
  MM_ADJ_YN=rs.getString("MM_ADJ_YN")==null?"":rs.getString("MM_ADJ_YN");
  MM_LOAN_DT=rs.getString("MM_LOAN_DT")==null?"":rs.getString("MM_LOAN_DT");
	count=count+1;
 //session.setAttribute("APP_ID",APP_ID);
  
    %>
     <INPUT name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>">
		   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=vOffcd %>">       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>
     
     
      <TD><%= VERIFICATION_BY %></TD>
      <TD><div align="center"><%= VERIFICATION_DATETIME %> </div></TD>
      <TD><DIV align="center"><%= VERIFICATION_STATUS %> </DIV></TD>
    
      <TD><div align="center"><%=CUR_STA%>
          
      </div></TD>
      <TD><div align="center"><%=MM_REL_AMT%></div></TD>
	   <TD><div align="center"><%=MM_ADJUSTMENT_AMT_S%></div></TD>
	    <TD><div align="center"><%=AGN_CALLBACK%></div></TD>
	  <TD><div align="center"><%=MM_ADJ_YN%></div></TD>
	   <TD>
  <% if ((ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RU"))) || (MM_ADJUSTMENT_STATUS.equals("")) || (ACT_ID.equals("2") && (!MM_ADJUSTMENT_STATUS.equals("")))){%>
 <%// if ((ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RU"))) || (MM_ADJUSTMENT_STATUS.equals(""))){%>
   <DIV align="center"><A target="_blank" href="appGeoUpdate.jsp?APP_ID=<%=APP_ID%>&PMEGPGEOTAGID=<%=PMEGPGEOTAGID%>" class="greenButtonRound">Edit</A></DIV>
 <%} else{%>
 -
 <%}%>  </TD>
	  
      <TD><% if ((MM_ADJUSTMENT_STATUS.equals("")) || (ACT_ID.equals("2"))){%>
	  <DIV align="center"><A onClick="GTSTATUS('<%= APP_ID %>','<%= PMEGPGEOTAGID %>');"  class="greenButtonRound">Update</A></DIV>
	  <%} else if (ACT_ID.equals("1")){%>
	  Approved
	  <%} else {%>
	  Submitted To Approver
	  <%}%>	  </TD>
	   <TD>
	   <% if ((ACT_ID.equals("")) && (!MM_ADJUSTMENT_STATUS.equals(""))){ %>
	   
	   <DIV align="center"><A href="#" onClick="GTPULLBK('<%= APP_ID %>','<%= PMEGPGEOTAGID %>','<%=  APP_NAME %>');" class="buttonMerun">PULLBCK</A>
	<%}%>	   </TD>
	   <TD><DIV align="center"><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=GEOTAGREPORT&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Report</A></DIV></TD>
      
       <TD> <DIV align="center">
	  <% if(GEOYN.equals("Y")){%>
	  <A href="javascript: mypopup('../geoportal/geoMap.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</A>
	  <%} else { out.print("-");}%>
	  </DIV></TD>
     
      <TD><DIV align="center"><A href="http://www.kviconline.net.in/pmegpgeoapi/api/GTDocumentsgov.jsp?<%= param %>" target="_blank" class="buttonGREEN">View</A></DIV></TD>
     
      <TD><% if (ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RM"))){%>
	  <DIV align="center"><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=LET_OF_MM_CLAIM&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Download</A></DIV>
	  <%} else if (ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RU")))  { out.print("Reverification");} else { %>-<%}%></TD>
  
	<TD> <% if ((DOC_NAME.equals("")) && (ACT_ID.equals("1")) && (MM_ADJUSTMENT_STATUS.equals("RM"))){%>
	<DIV align="center"><A onClick="GTUPLOAD1('<%= APP_ID %>','<%= PMEGPGEOTAGID %>','<%=  APP_NAME %>');"  class="greenButtonRound">Upload</A></DIV>
	<%} if  (!DOC_NAME.equals("")) {
	if (!DOC_NAME.equals("GenAdjLetter")) {
	%>
	
	
	<A onClick="GTview('<%= DOC_NAME %>');"  class="greenButtonRound">View</A></DIV>
	<%}else{ 
	
	if (ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RM"))){
	%>
	
	
	  <DIV align="center"><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=LET_OF_MM_CLAIM&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Download</A></DIV>
	  
	
	
	<%
	}
	}
	}
	
	
	%>	</TD>
	  <TD>
   <DIV align="center"><A target="_blank" href="upload_desc.jsp?APP_ID=<%=APP_ID%>" class="greenButtonRound">Upload</A></DIV>  </TD>
 


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
 function GTUPLOAD(APP_ID,PMEGPGEOTAGID,APPNAME){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
modalWin.ShowURL("../geoportal/UploadCoverPhoto.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
 }
 
  function GTUPLOAD1(APP_ID,PMEGPGEOTAGID,APPNAME){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("../geoportal/UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
//modalWin.ShowURL("../geoportal/UploadCoverPhoto.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
modalWin.ShowURL("ValidUploadgt.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
 }
function GTPULLBK(APP_ID,PMEGPGEOTAGID,APP_NAME){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APP_NAME="+APP_NAME,500,500,'Status',null,null);
modalWin.ShowURL("pullAppsi.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APP_NAME,500,500,'Status',null,null);
 }


function GTview(DOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("../geoportal/docView.jsp?docname="+DOC_NAME,720,1350,'Status',null,null);
 }
 
 function GBack(MM_ADJUSTMENT_STATUS,NODAL_OFFICER_REMARK){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("../geoportal/GTStatusUpdate1.jsp?MM_ADJUSTMENT_STATUS="+MM_ADJUSTMENT_STATUS+"NODAL_OFFICER_REMARK="+NODAL_OFFICER_REMARK,720,1350,'Status',null,null);
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