
<%@ page session="true" import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<title>FB Profile View Page</title>
 <link rel="stylesheet" type="text/css" href="../css/dis.css">
 <link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
  <script>
  function form_submit(){  
	var APP_ID = document.form.APP_ID.value;
	if (APP_ID== "") {	 inlineMsg ( 'APP_ID','ENTER APPLICATION ID',2);	return (false);}    	
	document.form.submit();

}


</script>
</head>
<body >

<form  method="post"  name="form" action="ibviewPv.jsp" >
  <p>
    <%@ include file="IncludeHeader.jsp" %>
    <%
	String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String IFSC_CODE="";
String APP_NAME = "";
String BANK_NAME = "";
 String MM_ADJ_YN="";
 String MM_LOAN_DT="";

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
 String VERIFYAPP_CNT="";
 
 
DBCon db= new DBCon();
db.connect();
 String MM_ADJ_AMT="";
 String BANK_ADJ_AMT="";
    StringBuffer qrysb= new StringBuffer();
	
//  and trunc(SYSTIMESTAMP) BETWEEN trunc(rtimestamp_req) AND trunc(rtimestamp_req)+30
qrysb.append("  SELECT p.*,(select  count(*) from indbank_request where substr(txnid,3,length(txnid))=substr(p.app_id,instr(p.app_id,'-')+1,length(p.app_id)) AND UPPER(STATUS) NOT IN ('NOT FOUND' ,'FAILURE')   ) as verifyapp_cnt  FROM ( SELECT GT.PMEGPGEOTAGID,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN, "      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.REMTRID=GR.REMTRID(+) AND GT.ACT_ID=1 AND GT.AGENCY_UPLOAD IS NOT NULL AND  "      );
qrysb.append("     TRIM(AD.APP_ID) = TRIM(UPPER(?))  "      );
qrysb.append("  UNION ");
qrysb.append(" SELECT GT.PMEGPGEOTAGID,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN, "      );
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
qrysb.append("   AND BD.PACT_ID      = 34 AND GT.REMTRID=GR.REMTRID(+) AND GT.ACT_ID=1 AND GT.AGENCY_UPLOAD IS NOT NULL AND  "      );

qrysb.append("    TRIM(AD.APP_ID) = TRIM(UPPER(?))   )p  ORDER BY DATE_OF_VERIFICATION DESC"      );


//out.print(qrysb.toString());
List values=new ArrayList();

values.add(APP_ID);
// values.add(IFSC_CODE); 
 values.add(APP_ID);
// values.add(IFSC_CODE); 
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
   MM_ADJ_YN=rs.getString("MM_ADJ_YN")==null?"":rs.getString("MM_ADJ_YN");
  MM_LOAN_DT=rs.getString("MM_LOAN_DT")==null?"":rs.getString("MM_LOAN_DT");
    VERIFYAPP_CNT=rs.getString("VERIFYAPP_CNT")==null?"":rs.getString("VERIFYAPP_CNT");
	count=count+1;
//out.print(AGENCY_UPLOAD);
   
   }
   rs.close();



%>
    
  </p>
  <p>&nbsp;</p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th colspan="4"><div align="center">MM Adjustment Details   (  Login)
     
  </div></th>
  </tr>
 <tr>
  <th height="43" align="left" nowrap bgcolor="#CCCCCC" >   <input name="ins" type="hidden" id="ins" value="">
    APPLICANT ID     *</th>
   
	<td bgcolor="#CCCCCC"><input name="APP_ID"  id="APP_ID" placeholder="SEARCH" size="20" maxlength="20">	</td>
    <td bgcolor="#CCCCCC"><input name="Submit" type="submit" class="button"  value="SEARCH"></td>
 </tr>
	
	<tr>
	<th colspan="4">&nbsp;</th>                              
	</tr>
  </table>

<% if (!APP_ID.equals("")) {if (count > 0) {%>
<table align="center" cellspacing="0" class="display" id="example" width="100%">
        <thead>
             <TR>
      <TH>Srno</TH>
       <TH>ID</TH>
      <TH nowrap>Name</TH>
      
     
      <!-- <TH nowrap>Verification Date </TH>-->
       <TH >Verification Status </TH>
      
      
       <TH >MM Adjustment </TH>
	    <TH >Call Back Amount </TH>
       <!-- <TH nowrap>MM Adjustment Status </TH>-->
       <TH >Report </TH>
       
    
        <TH nowrap>Adjustment Letter </TH>
        </TR>
        </THEAD>
		 <TFOOT>
		<TR>
		<TH >Srno</TH>
       <TH >ID</TH>
       <TH >Name</TH>
     
     
     <!--  <TH >Verification Date </TH>-->
       <TH >Verification Status </TH>
       
      
       <TH >MM Adjustment </TH>
	    <TH >Call Back Amount </TH>
      <!-- <TH >MM Adjustment Status </TH>-->  
<TH >Report </TH>	  
     
       <TH >Adjustment Letter</TH>
       </TR>
        </tfoot>
		OK
		        <tbody>
	       <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>
     
     
     <!-- <TD><div align="center"></div></TD>-->
      <TD><DIV align="center"><%= VERIFICATION_STATUS %> </DIV></TD>
    
      
      <TD><div align="center"><%=MM_ADJUSTMENT_AMT_S%></div></TD>
	  <TD><div align="center"><%=CALLBACK_AMOUNT%>
      </div></TD>
	    <TD><DIV align="center"><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=GEOTAGREPORT&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Report</A></DIV></TD>
    <!--  <TD><% if (BANK_ADJ_AMT.equals("")){%>
	  <DIV align="center"><A onClick="GTSTATUS('<%= APP_ID %>','<%= PMEGPGEOTAGID %>');"  class="greenButtonRound">Update</A></DIV>
	  <%} else {%>
	  MM Adjusted
	  <%} %>	  </TD>-->
     
     
     
      
      <TD> <%  if((!AGENCY_UPLOAD.equals("")) &&  (MM_ADJ_YN.equals("Y"))){ 
	  
       if (AGENCY_UPLOAD.equals("GenAdjLetter")) {
	   %>
	     <DIV align="center"><A target="_blank" href="../geoportal/PMEGPGenAppForm.jsp?RNAME=LET_OF_MM_CLAIM&PMEGPGEOTAGID=<%= PMEGPGEOTAGID %>" class="greenButtonRound">Download</A></DIV>
	   <%}else{%>
      <DIV align="center"><a target="_blank" href="../geoportal/docView.jsp?docname=<%= AGENCY_UPLOAD %>" class="greenButtonRound">View  </a>	  
	  </DIV>
	  <%}
	 }%>	  </TD>
      </tr>
			
            
        </tbody>
</table>
  <%
  } else{%>
  
 <div align="center"><H2> Invalid ID Or MM Not Adjusted Yet </H2></div>
  <%
  }}
  db.close();
  %>
  </form>
    
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


</body>
	</html>