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
<style>

 .buttonMerun {
  border: 4px solid #A84300;
    border-radius: 10px;
    background-color: #990000;
    color: #ffffff;
    font-weight: bold;
    text-decoration: none;
    margin : 1px;
    padding: 5px 10px 5px 10px;
    display: inline-block;
 }
 .buttonMerun:hover {
  border: 2px solid #A84300;
    background-color: #990000;
	 color: #000000;
 }
</style>
</head>
<body>
<form name="form" id="form"  method="post">
<%
String txt="";
String txtSearch="";
	 // String str= "";
//String vOffcd =(String) session.getAttribute("sOffCd");
String U_COUNT=(String) session.getAttribute("sUC")==null?"0":(String)session.getAttribute("sUC");
	//	String vUSER_ID=(String) session.getAttribute("sUSERID")==null?"0":(String)session.getAttribute("sUSERID");
		//session.setAttribute("sUSERID",vUSERID);
		//out.print(vUSER_ID);
		try {
if (U_COUNT.equals("0")){
response.sendRedirect("Msg.jsp");
}
	}catch (Exception m) {}		
	
%>

<TABLE align="center" class="pmegpTable">
   
    <TR>
      <TD colspan="19"><DIV align="center">Physical Verification Status Update</DIV></TD>
    </TR>
    
  </TABLE>
  <br>
<br>

<table align="center" cellspacing="0" class="display" id="example" >
        <thead>
             <TR>
      <TH >Srno</TH>
       <TH >ID</TH>
      <TH >Name</TH>     
      
      
       <TH >Verification Status </TH>
      
       <TH >Current Status </TH>
	    <TH >District</TH>
       <TH >MM Adjustment </TH>
       <TH >Status </TH>
	   <TH >PV</TH>
       <TH >Geolocation</TH>
       <TH >Documents</TH>
       
       <TH >Adjustment Letter </TH>
	    
		<TH >Other Document </TH>
</TR>
        </THEAD>
		       <TFOOT>
             <TR>
      <TH >Srno</TH>
       <TH >ID</TH>
      <TH >Name</TH>     
      
      
       <TH >Verification Status </TH>
      
       <TH >Current Status </TH>
	    <TH >District</TH>
       <TH >MM Adjustment </TH>
       <TH >Status </TH>
	   <TH >PV</TH>
       <TH >Geolocation</TH>
       <TH >Documents</TH>
       
       <TH >Adjustment Letter </TH>
	   <TH >Other Document </TH>
	    
</TR>
        </TFOOT>
				        <tbody>
	 <% 
	  

String APP_ID =request.getParameter("APP_ID");
String ACT_ID="";
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
 String vOffcd= (String) session.getAttribute("sOffCd");
 
 String ADJ_YN="";
String MM_ADJUSTMENT_AMT_S=""; 
 out.print(vOffcd);
 String CUR_STA ="";
 String GEOYN="";
 String qryE="";

 
 String DISTRICT_NAME="";
 String MM_ADJUSTMENT_STATUS="";
 
	//out.print(vOffcd);
DBCon db= new DBCon();
db.connect();
List values=new ArrayList(); 
    StringBuffer qrysb= new StringBuffer();
	
if(!SLOGINTYPE.equals("Y")){
qrysb.append("   SELECT * FROM (SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,CASE WHEN GT.LATITUDE IS NULL AND GT.LONGITUDE IS NULL THEN 'N' ELSE 'Y' END AS GEOYN,MD.DISTRICT_NAME,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,GT.ACT_ID,CASE WHEN GT.ACT_ID=1 AND AD.APP_ID NOT IN (SELECT UDF1 FROM INDBANK_REQUEST) AND BANK_ADJ_DT IS NULL THEN 'A' ELSE 'R' END AS APPRV, "      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,"      );
qrysb.append("   GT.VERIFICATION_STATUS,GT.MM_ADJUSTMENT_AMT_S,GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,CASE WHEN GT.MM_ADJUSTMENT_STATUS IN ('PA','FD','FA') THEN 'Y' ELSE 'N' END  AS ADJ_YN, CASE WHEN GT.ACT_ID=1 THEN 'Approved' WHEN GT.ACT_ID=2 THEN 'Returned For Resubmission'  else '' end as CUR_STA "      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.MM_ADJUSTMENT_STATUS IS NOT NULL AND GT.QC_APPRV='Y' "      );	
qrysb.append(" AND AD.OFF_CD=? "      );
qrysb.append(" UNION ");
qrysb.append("   SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,CASE WHEN GT.LATITUDE IS NULL AND GT.LONGITUDE IS NULL THEN 'N' ELSE 'Y' END AS GEOYN,MD.DISTRICT_NAME,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,GT.ACT_ID,CASE WHEN GT.ACT_ID=1  AND AD.APP_ID NOT IN (SELECT UDF1 FROM INDBANK_REQUEST) AND BANK_ADJ_DT IS NULL THEN 'A' ELSE 'R' END AS APPRV, "      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,"      );
qrysb.append("   GT.VERIFICATION_STATUS,GT.MM_ADJUSTMENT_AMT_S,GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,CASE WHEN GT.MM_ADJUSTMENT_STATUS IN ('PA','FD','FA') THEN 'Y' ELSE 'N' END  AS ADJ_YN, CASE WHEN GT.ACT_ID=1 THEN 'Approved' WHEN GT.ACT_ID=2 THEN 'Returned For Resubmission'  else '' end as CUR_STA "      );
qrysb.append("   FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_DATAENTRY_SECOND BD,"      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.MM_ADJUSTMENT_STATUS IS NOT NULL  AND GT.QC_APPRV='Y' "      );
qrysb.append(" AND AD.OFF_CD=?) ORDER BY DATE_OF_VERIFICATION DESC"      );



//values.add(SMISOFFCD);
 values.add(vOffcd); 
 //values.add(txtSearch);
 values.add(vOffcd); 
}
else{

qrysb.append("   SELECT * FROM (SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,CASE WHEN GT.LATITUDE IS NULL AND GT.LONGITUDE IS NULL THEN 'N' ELSE 'Y' END AS GEOYN,MD.DISTRICT_NAME, "      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      ); 
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,GT.ACT_ID,CASE WHEN GT.ACT_ID=1  AND AD.APP_ID NOT IN (SELECT UDF1 FROM INDBANK_REQUEST) AND BANK_ADJ_DT IS NULL THEN 'A' ELSE 'R' END AS APPRV, "      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,"      );
qrysb.append("   GT.VERIFICATION_STATUS,GT.MM_ADJUSTMENT_AMT_S,GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,CASE WHEN GT.MM_ADJUSTMENT_STATUS IN ('PA','FD','FA') THEN 'Y' ELSE 'N' END  AS ADJ_YN, CASE WHEN GT.ACT_ID=1 THEN 'Approved' WHEN GT.ACT_ID=2 THEN 'Returned For Resubmission'  else '' end as CUR_STA "      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.MM_ADJUSTMENT_STATUS IS NOT NULL AND GT.QC_APPRV='Y' "      );	
qrysb.append(" AND AD.OFF_CD IN (SELECT OFF_CD  FROM MAS_OFF_MAST WHERE OFF_TYPE_CD IN (2,3) AND ACT_YN='Y' AND MIS_OFF_CD=(select mis_off_cd from mas_off_mast where off_cd=?)) "      );
qrysb.append(" UNION ");
qrysb.append("   SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("  AD.APP_ID, AD.APP_NAME,CASE WHEN GT.LATITUDE IS NULL AND GT.LONGITUDE IS NULL THEN 'N' ELSE 'Y' END AS GEOYN,MD.DISTRICT_NAME, "      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,GT.ACT_ID,CASE WHEN GT.ACT_ID=1   AND AD.APP_ID NOT IN (SELECT UDF1 FROM INDBANK_REQUEST) AND BANK_ADJ_DT IS NULL THEN 'A' ELSE 'R' END AS APPRV,"      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_CALLBACK_,"      );
qrysb.append("     GT.IS_MARGIN_MONEY_ELIGIBLE_FOR_A,"      );
qrysb.append("     GT.VERIFICATION_DATETIME,"      );
qrysb.append("   GT.VERIFICATION_STATUS,GT.MM_ADJUSTMENT_AMT_S,GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("   GT.VERIFIER_REMARKS , TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,CASE WHEN GT.MM_ADJUSTMENT_STATUS IN ('PA','FD','FA') THEN 'Y' ELSE 'N' END  AS ADJ_YN, CASE WHEN GT.ACT_ID=1 THEN 'Approved' WHEN GT.ACT_ID=2 THEN 'Returned For Resubmission'  else '' end as CUR_STA "      );
qrysb.append("   FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_DATAENTRY_SECOND BD,"      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.MM_ADJUSTMENT_STATUS IS NOT NULL  AND GT.QC_APPRV='Y' "      );
qrysb.append(" AND AD.OFF_CD IN (SELECT OFF_CD  FROM MAS_OFF_MAST WHERE OFF_TYPE_CD IN (2,3) AND ACT_YN='Y' AND MIS_OFF_CD=(select mis_off_cd from mas_off_mast where off_cd=?))) ORDER BY DATE_OF_VERIFICATION DESC"      );
values.add(vOffcd);
values.add(vOffcd);



}

/*
qrysb.append("   WHERE ad.ACT_ID     = asm.ACT_ID "      );
qrysb.append("   AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND UPPER(ad.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(ad.APP_NAME)) LIKE TRIM(UPPER(?))"      );
qrysb.append("   AND AD.OFF_CD=? ORDER BY ad.ONLINE_SUBDT DESC"      );
*/
	
//out.print(qrysb.toString());


   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  //  ResultSet rsupdt = db.executeSQL("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ",values);
	// rsupdt.close();
   //values.clear();
   String APPRV ="";
  
  String param="";
	while (rs.next()){
	
	APPRV=rs.getString("APPRV")==null?"":rs.getString("APPRV");
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
	DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
	MM_ADJUSTMENT_STATUS=rs.getString("MM_ADJUSTMENT_STATUS")==null?"":rs.getString("MM_ADJUSTMENT_STATUS");
	PMEGPGEOTAGID=rs.getString("PMEGPGEOTAGID")==null?"":rs.getString("PMEGPGEOTAGID");
	MM_ADJUSTMENT_AMT_S=rs.getString("MM_ADJUSTMENT_AMT_S")==null?"":rs.getString("MM_ADJUSTMENT_AMT_S");
	GEOYN=rs.getString("GEOYN")==null?"":rs.getString("GEOYN");
	param="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	//geoparam="APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID;
	ADJ_YN=rs.getString("ADJ_YN")==null?"":rs.getString("ADJ_YN");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	CUR_STA=rs.getString("CUR_STA")==null?"":rs.getString("CUR_STA");
//out.print(ADJ_YN);
	count=count+1;

   
    %>
     <INPUT name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>">
		   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=vOffcd %>">       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>
     
    
     
    
      <TD><DIV align="center"><%= VERIFICATION_STATUS %> </DIV></TD>
    
      <TD><%=CUR_STA%></TD>
	  <TD><%=DISTRICT_NAME%>
      <TD><%=MM_ADJUSTMENT_AMT_S%></TD>
	  <TD><% if ((ACT_ID.equals("2")) || ACT_ID.equals("")) {%>
  <DIV align="center"><A onClick="GTSTATUS('<%= APP_ID %>','<%= PMEGPGEOTAGID %>');"  class="greenButtonRound">Update </A></DIV>
  <%} else if (APPRV.equals("A")){ %>
  <DIV align="center"><A href="#" onClick="GTPULLBK('<%= APP_ID %>','<%= PMEGPGEOTAGID %>','<%=  APP_NAME %>');" class="buttonMerun">PULLBCK</A>  
    <%} else {%>

  MM Adjusted By Bank
  <%}%>

  </TD>
   <TD><DIV align="center"><A target="_blank" href="PMEGPGenAppForm.jsp?RNAME=GEOTAGREPORT&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Report</A></DIV></TD>
     
      <TD> 
	  
	  <DIV align="center">
	   <% if(GEOYN.equals("Y")){%>
	  <A href="javascript: mypopup('geoMap.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</A>
	   <%} else { out.print("-");}%>
	  </DIV>
	  
	  </TD>
      <TD>
	  
	  <DIV align="center"><A href="http://www.kviconline.net.in/pmegpgeoapi/api/GTDocumentsgov.jsp?<%= param %>" target="_blank" class="buttonGREEN">View</A></DIV><!--<DIV align="center"><A href="javascript: mypopup('GTDocuments.jsp','','1000','490');" class="greenButtonRound">View</A></DIV>--></TD>
     
       <TD><% if (ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RM"))){%>
	  <DIV align="center"><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=LET_OF_MM_CLAIM&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Download</A></DIV>
	  <%} else if (ACT_ID.equals("1") && (MM_ADJUSTMENT_STATUS.equals("RU")))  { out.print("Reverification");} else { %>-<%}%></TD>
  
  
	
  <TD>
   <DIV align="center"><A target="_blank" href="upload_desc.jsp?APP_ID=<%=APP_ID%>" class="greenButtonRound">Upload</A></DIV>
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
 modalWin.ShowURL("GTStatusUpdate2.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID,700,850,'Status',null,null);
 }//end of bank

function GTPULLBK(APP_ID,PMEGPGEOTAGID,APP_NAME){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APP_NAME="+APP_NAME,500,500,'Status',null,null);
modalWin.ShowURL("pullAppsi.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APP_NAME,500,500,'Status',null,null);
 }



function refreshpage() {
  location.reload();
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}

  </script>
    </p>

</form>
</body>
	</html>