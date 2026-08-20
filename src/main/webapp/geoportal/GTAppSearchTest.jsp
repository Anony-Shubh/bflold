<%@ include file="../jsp/includeHeaderPage.jsp" %>
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
<br>
<br>


<table align="center" cellspacing="0" class="display" id="example" width="100%">
        <thead>
             <TR>
      <TH>Srno</TH>
       <TH>ID</TH>
      <TH nowrap>Name</TH>
      
     
       <TH nowrap>Verification Date </TH>
       <TH >Verification Status </TH>
      
       <TH nowrap>Current Status/Remarks </TH>
       <TH >MM Adjustment </TH>
       <TH nowrap>Status</TH>
       <TH nowrap>Geolocation</TH>
       
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
     
     
       <TH >Verification Date </TH>
       <TH >Verification Status </TH>
       
       <TH >Current Status </TH>
       <TH >MM Adjustment </TH>
       <TH >Status</TH>
       <TH >Geolocation</TH>
       
       <TH >Documents</TH>
       <TH >Report</TH>
       <TH >Adjustment Letter </TH>
	    
	   </TR>
   
        </tfoot>
		        <tbody>
	 <% 
	  

String APP_ID ="KVAP16175722-1516494";
//request.getParameter("APP_ID");
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
 String vOffcd= "5722"; //(String) session.getAttribute("off_cd");
 String ADJ_YN="";
String MM_ADJUSTMENT_AMT_S=""; 
 //out.print(BANKFOR_YN);
 
 
 String qryE="";
String DOC_NAME="";
String ACT_ID="";
String MM_ADJUSTMENT_STATUS=""; 
 String CUR_STA="";
 
	//out.print(vOffcd);
DBCon db= new DBCon();
db.connect();
 
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("  SELECT * FROM ( SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,"      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,GT.DOC_NAME,GT.ACT_ID,GT.MM_ADJUSTMENT_STATUS,GR.CO_REMARKS,"      );
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
qrysb.append("   AND AD.APP_ID=?  )  ORDER BY DATE_OF_VERIFICATION DESC"      );



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

values.add(APP_ID);

   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  //  ResultSet rsupdt = db.executeSQL("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ",values);
	// rsupdt.close();
   //values.clear();
  String GEOYN="";
  String param="";
  String CO_REMARKS="";
	while (rs.next()){
	
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
CO_REMARKS=rs.getString("CO_REMARKS")==null?"":rs.getString("CO_REMARKS");
	count=count+1;

   
    %>
     <INPUT name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>">
		   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=vOffcd %>">       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>
     
     
      <TD><div align="center"><%= DATE_OF_VERIFICATION %> </div></TD>
      <TD><DIV align="center"><%= VERIFICATION_STATUS %> </DIV></TD>
    
      <TD><div align="center"><%=CUR_STA%>
          <% if (ACT_ID.equals("2")){%>
          /<%=CO_REMARKS%>
          <%}%>
      </div></TD>
      <TD><div align="center"><%=MM_ADJUSTMENT_AMT_S%></div></TD>
      <TD><% if ((MM_ADJUSTMENT_STATUS.equals("")) || (ACT_ID.equals("2"))){%>
	  <DIV align="center"><A onClick="GTSTATUS('<%= APP_ID %>','<%= PMEGPGEOTAGID %>');"  class="greenButtonRound">Update</A></DIV>
	  <%} else if (ACT_ID.equals("1")){%>
	  Approved
	  <%} else {%>
	  Submitted To Approver
	  <%}%>
	  </TD>
      <TD> <DIV align="center">
	  <% if(GEOYN.equals("Y")){%>
	  <A href="javascript: mypopup('geoMap.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</A>
	  <%} else { out.print("-");}%>
	  </DIV></TD>
     
      <TD><DIV align="center"><A href="javascript: mypopup('GTDocuments.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</A></DIV></TD>
      <TD><DIV align="center"><A target="_blank" href="PMEGPGenAppForm.jsp?RNAME=GEOTAGREPORT&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">View</A></DIV></TD>
      <TD><% if (ACT_ID.equals("1")){%>
	  <DIV align="center"><A target="_blank" href="PMEGPGenAppForm.jsp?RNAME=LET_OF_MM_CLAIM&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Download</A></DIV>
	  <%} else { out.print("-");}%></TD>
  
	<!--<TD> <% if (DOC_NAME.equals("")){%>
	<DIV align="center"><A onClick="GTUPLOAD('<%= APP_ID %>','<%= PMEGPGEOTAGID %>','<%=  APP_NAME %>');"  class="greenButtonRound">Upload</A></DIV>
	<%} else {%>
	<DIV align="center"><A onClick="GTview('<%= DOC_NAME %>');"  class="greenButtonRound">View</A></DIV>
	<%}%>
	</TD>-->


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
modalWin.ShowURL("GTStatusUpdate1.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,700,850,'Status',null,null);
//modalWin.ShowURL("systemValidRepo.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,500,800,'Status',null,null);
 }//end of bank
 function GTUPLOAD(APP_ID,PMEGPGEOTAGID,APPNAME){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
modalWin.ShowURL("UploadCoverPhoto.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
 }


function GTview(DOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("docView.jsp?DOC_NAME="+DOC_NAME,720,1350,'Status',null,null);
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

  </script>
    </p>

</form>
</body>
	</html>