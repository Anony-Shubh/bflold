<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%//@ include file="headerfile.jsp" %>
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

<!--<TABLE align="center" class="pmegpTable">
   
    <TR>
      <TD colspan="19"><DIV align="center">Geotagging Status Update</DIV></TD>
    </TR>
    <TR>
      <TD colspan="18"><DIV align="center">Enter Applicant ID or  Applicant Name :
          <INPUT name="txtSearch" type="text"  id="txtSearch" size="25" maxlength="25" value="<%= txt %>" />
       <INPUT name="btnSearch" type="submit" class="button" id="btnSearch"  onClick="strFind()" value="Search Applicant">
	    </DIV>	   </TD>
    </TR>
  </TABLE>-->
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
      
      
       <TH >MM Adjustment </TH>
	    <TH >Call Back Amount </TH>
        <TH nowrap>MM Adjustment Status </TH>
       
       
    
        <TH nowrap>Adjustment Letter </TH>
        <TH nowrap> Challan </TH>
</TR>
        </THEAD>
		 <TFOOT>
		<TR>
		<TH >Srno</TH>
       <TH >ID</TH>
       <TH >Name</TH>
     
     
       <TH >Verification Date </TH>
       <TH >Verification Status </TH>
       
      
       <TH >MM Adjustment </TH>
	    <TH >Call Back Amount </TH>
       <TH >MM Adjustment Status </TH>    
     
       <TH >Adjustment Letter</TH>
       <TH >Challan</TH>
	   </TR>
        </tfoot>
		        <tbody>
	 <% 
	  

String APP_ID =request.getParameter("APP_ID");
String IFSC_CODE="IDIB000N149";//(String)session.getAttribute("bank_id");

String APP_NAME = "";
String BANK_NAME = "";

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
 //String vOffcd= (String) session.getAttribute("off_cd");
 String ADJ_YN="";
String MM_ADJUSTMENT_AMT_S=""; 
 //out.print(BANKFOR_YN);
 
 
 String qryE="";
String DOC_NAME="";
String ACT_ID="";
String MM_ADJUSTMENT_STATUS=""; 
 String CUR_STA="";
 String AGENCY_UPLOAD="";
 String CALLBACK_AMOUNT="";
	//out.print(vOffcd);
DBCon db= new DBCon();
db.connect();
 String MM_ADJ_AMT="";
 String BANK_ADJ_AMT="";
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("  SELECT * FROM ( SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,"      );
qrysb.append("     RBL.BANK_NAME,BD.MM_ADJ_AMT,GT.BANK_ADJ_AMT,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,GT.AGENCY_UPLOAD,GT.AGN_CALLBACK AS CALLBACK_AMOUNT,"      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.REMTRID=GR.REMTRID(+) AND GT.ACT_ID=1 AND GT.AGENCY_UPLOAD IS NOT NULL "      );
qrysb.append("   AND UPPER(AD.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(AD.APP_NAME)) LIKE TRIM(UPPER(?)) AND RBL.IFSC_CODE=? "      );
qrysb.append("  UNION ");
qrysb.append(" SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,"      );
qrysb.append("     RBL.BANK_NAME,BD.MM_ADJ_AMT,GT.BANK_ADJ_AMT,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,GT.AGENCY_UPLOAD,GT.AGN_CALLBACK AS CALLBACK_AMOUNT,"      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,GT.DOC_NAME,GT.ACT_ID,GT.MM_ADJUSTMENT_STATUS,GR.CO_REMARKS,"      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.REMTRID=GR.REMTRID(+) AND GT.ACT_ID=1 AND GT.AGENCY_UPLOAD IS NOT NULL "      );
qrysb.append("   AND UPPER(AD.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(AD.APP_NAME)) LIKE TRIM(UPPER(?)) AND  RBL.IFSC_CODE=?  )  ORDER BY DATE_OF_VERIFICATION DESC"      );



List values=new ArrayList();

values.add(txtSearch);
 values.add(IFSC_CODE); 
 values.add(txtSearch);
 values.add(IFSC_CODE); 
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
 
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
	BANK_ADJ_AMT=rs.getString("BANK_ADJ_AMT")==null?"":rs.getString("BANK_ADJ_AMT");
	//geoparam="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	ADJ_YN=rs.getString("ADJ_YN")==null?"":rs.getString("ADJ_YN");
	MM_ADJ_AMT=rs.getString("MM_ADJ_AMT")==null?"":rs.getString("MM_ADJ_AMT");
	DOC_NAME=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	MM_ADJUSTMENT_STATUS=rs.getString("MM_ADJUSTMENT_STATUS")==null?"":rs.getString("MM_ADJUSTMENT_STATUS");
	CUR_STA=rs.getString("CUR_STA")==null?"":rs.getString("CUR_STA");
//out.print(ADJ_YN);
CO_REMARKS=rs.getString("CO_REMARKS")==null?"":rs.getString("CO_REMARKS");
 AGENCY_UPLOAD=rs.getString("AGENCY_UPLOAD")==null?"":rs.getString("AGENCY_UPLOAD");
  CALLBACK_AMOUNT=rs.getString("CALLBACK_AMOUNT")==null?"":rs.getString("CALLBACK_AMOUNT");
	count=count+1;
//out.print(AGENCY_UPLOAD);
   
    %>
     <INPUT name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>">
		        <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>
     
     
      <TD><div align="center"><%= DATE_OF_VERIFICATION %> </div></TD>
      <TD><DIV align="center"><%= VERIFICATION_STATUS %> </DIV></TD>
    
      
      <TD><div align="center"><%=MM_ADJUSTMENT_AMT_S%></div></TD>
	  <TD><div align="center"><%=CALLBACK_AMOUNT%>
      </div></TD>
      <TD><% if (BANK_ADJ_AMT.equals("")){%>
	  <DIV align="center"><A onClick="GTSTATUS('<%= APP_ID %>','<%= PMEGPGEOTAGID %>');"  class="greenButtonRound">Update</A></DIV>
	  <%} else {%>
	  MM Adjusted
	  <%} %>
	  </TD>
     
     
     
      
      <TD> <%  if(!AGENCY_UPLOAD.equals("")){%>
      <DIV align="center"><a target="_blank" href="../geoportal/docView.jsp?docname=<%= AGENCY_UPLOAD %>" class="greenButtonRound">View  </a>	  
	  </DIV>
	  <%}%>
	  </TD>
      <TD>
	   <%  if(!CALLBACK_AMOUNT.equals("0")){%>
	  <DIV align="center"><A target="_blank" href="index.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Generate</A></DIV>	
	  <%} else{%>
	  -<%}%>
	   </TD>
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
modalWin.ShowURL("BankPhyAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,700,850,'Status',null,null);
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