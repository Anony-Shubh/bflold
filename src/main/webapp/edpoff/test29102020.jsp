<%@include file="includeHeaderedp.jsp"%>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
</head>
<body>
<form name="form" id="form" method="post
<table align="center" class="pmegpTable">
    <tr>
      <td><div align="center"> PMEGP MARGIN MONEYCLAIM  STATUS </div></td>
      <td><div align="right">
      
      </div></td>
    </tr>
</table>
<table align="center" cellspacing="0" class="display" id="example">
        <thead>
            <tr>
               <th nowrap>Sr. No. </th>
    <th nowrap>Application ID</th>
    <th nowrap>Applicant Name</th>
    <th nowrap>Project Cost  </th>
	 <th nowrap>Submission Date  </th>
	<th nowrap>Current Status </th>
	<th nowrap>Industry Type </th>
	<th nowrap>Applicant Opted </th>
	
	<th nowrap>District </th>
	<th nowrap>State</th>
    <th nowrap>View Applicant Details</th> 
	 <th nowrap>Upload EDP Certificate</th> </tr>
    
        </thead>
        <tfoot>
            <tr>
              <th nowrap>Sr. No. </th>
    <th nowrap>Application ID</th>
    <th nowrap>Applicant Name</th>
    <th nowrap>Project Cost  </th>
	 <th nowrap>Submission Date  </th>
	<th nowrap>Current Status </th>
	<th nowrap>Industry Type </th>
	<th nowrap>Applicant Opted </th>
	
	<th nowrap>District </th>
	<th nowrap>State</th>
    <th nowrap>View Applicant Details</th> 
	 <th nowrap>Upload EDP Certificate</th> </tr>
        
			
        </tfoot>
		        <tbody>
		<%
		 String OFF_CD = vOFF_CD;
   String DOC_NAME="";
	String ONLINE_SUBDT="";
  String ACT_ID="";
  String UPLOAD_YN="";
   StringBuffer qrysb= new StringBuffer();
  
/*qrysb.append("  SELECT CASE WHEN EDP_TYPE = 1 THEN 'Paid online EDP' WHEN EDP_TYPE = 2 THEN 'free Online EDP' WHEN EDP_TYPE = 3  THEN 'Paid offline EDP' ELSE 'free offline EDP ' END AS OPT,ASM.ACT_DESC,AD.APP_ID,NVL(AD.MACHINARY_COST,0) + NVL(AD.WORKING_CAPITAL,0) AS PROJECT_COST,CASE WHEN AD.IND_TYPE = 'M' THEN 'MANUFACTURING'  WHEN AD.IND_TYPE = 'T' THEN 'TRADING'  WHEN AD.IND_TYPE = 'S' THEN 'SERVICING'  END AS IND_TYPE,  CASE WHEN AD.ACT_ID < =5 AND NVL(BD.ACT_ID,0) =0 THEN ASM.ACT_DESC   WHEN BD.ACT_ID>0 THEN   BAS.ACT_DESC END ACT_DESC ,AD.MOB_NO1,AD.APP_NAME,MD.DISTRICT_NAME,MS.STATE_NM FROM APP_DETAIL AD,M_DISTRICT MD, M_STATE MS,EDP_CONDUCT_TRANS ED,APP_STATUS_MAST ASM WHERE AD.APP_ID=ED.APP_ID AND AD.ACT_ID=ASM.ACT_ID AND AD.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND ED.EDP_TYPE IN (1,3,2,4) AND ED.EDP_CERT_DT IS NULL AND ED.EDPOFF_CD='"+OFF_CD+"'  "      );*/
qrysb.append("   SELECT TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR') AS ONLINE_SUBDT,ED.DOC_NAME,ED.ED_ID,ED.EDP_TYPE,"      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ED.EDP_TYPE = 1"      );
qrysb.append("       THEN 'Paid online EDP'"      );
qrysb.append("       WHEN ED.EDP_TYPE = 2"      );
qrysb.append("       THEN 'free Online EDP'"      );
qrysb.append("       WHEN ED.EDP_TYPE = 3"      );
qrysb.append("       THEN 'Paid offline EDP'"      );
qrysb.append("       ELSE 'free offline EDP '"      );
qrysb.append("     END AS OPT,"      );
qrysb.append("     CASE WHEN AD.ACT_ID < =5 AND NVL(BD.ACT_ID,0) =0 THEN ASM.ACT_DESC   WHEN BD.ACT_ID>0 THEN   BAS.ACT_DESC END ACT_DESC ,"      );
qrysb.append("     AD.APP_ID,"      );
qrysb.append("     NVL(AD.MACHINARY_COST, 0) + NVL(AD.WORKING_CAPITAL, 0) AS PROJECT_COST,"      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN AD.IND_TYPE = 'M'"      );
qrysb.append("       THEN 'MANUFACTURING'"      );
qrysb.append("       WHEN AD.IND_TYPE = 'T'"      );
qrysb.append("       THEN 'TRADING'"      );
qrysb.append("       WHEN AD.IND_TYPE = 'S'"      );
qrysb.append("       THEN 'SERVICING'"      );
qrysb.append("     END AS IND_TYPE,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append(" MS.STATE_NM,BD.ACT_ID,CASE WHEN ((BD.ACT_ID =11 AND EDP_TYPE=4) OR (EDP_TYPE=3)) AND DOC_NAME IS NULL THEN 'Y' ELSE 'N' END AS UPLOAD_YN "      );
qrysb.append("   FROM APP_DETAIL AD,BANK_DATAENTRY BD,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     EDP_CONDUCT_TRANS ED,"      );
qrysb.append("     APP_STATUS_MAST ASM,BANK_APP_STATUS BAS"      );
qrysb.append("   WHERE AD.APP_ID =BD.APP_ID(+)"      );
qrysb.append("   AND AD.APP_ID     = ED.APP_ID"      );
qrysb.append("   AND AD.ACT_ID       = ASM.ACT_ID"      );
qrysb.append("   AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD     = MS.STATE_CD"      );
qrysb.append("   AND BD.ACT_ID       =BAS.ACT_ID(+)"      );
qrysb.append("   AND (ED.EDP_TYPE   IN (1, 3, 2, 4)"      );
qrysb.append("   AND ED.EDP_CERT_DT IS NULL"      );
qrysb.append("   AND ED.EDPOFF_CD    = '"+OFF_CD+"')"      );




//out.print(qrysb.toString());



  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String APP_ID="";
String APP_NAME="";
String PROJECT_COST="";
String ACT_DESC="";
String IND_TYPE="";
String OPT="";
String ED_ID="";
String EDP_TYPE="";

 while (rsMain.next()) { 
   recCount=recCount+1;
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
 APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME"); 
 ONLINE_SUBDT=rsMain.getString("ONLINE_SUBDT")==null?"":rsMain.getString("ONLINE_SUBDT"); 
 PROJECT_COST =rsMain.getString("PROJECT_COST")==null?"":rsMain.getString("PROJECT_COST");
ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
OPT=rsMain.getString("OPT")==null?"":rsMain.getString("OPT");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
ED_ID=rsMain.getString("ED_ID")==null?"":rsMain.getString("ED_ID");
DOC_NAME=rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");
ACT_ID=rsMain.getString("ACT_ID")==null?"0":rsMain.getString("ACT_ID");
EDP_TYPE=rsMain.getString("EDP_TYPE")==null?"":rsMain.getString("EDP_TYPE");
  
  UPLOAD_YN=rsMain.getString("UPLOAD_YN")==null?"":rsMain.getString("UPLOAD_YN");
  %>


            <tr>
               <td><%= recCount %></td>
    <td><%= APP_ID %></td>
    <td> <%= APP_NAME %></td>
	<td><%= PROJECT_COST %></td>
	<td><%= ONLINE_SUBDT %></td>
	<td><%= ACT_DESC %></td>
	<td><%= IND_TYPE %></td>
	<td><%= OPT %></td>
	
	<td><%= DISTRICT_NAME %></td>
	<td><%= STATE_NM %></td>	
    <td><div align="center"> <input name="btnSunction" type="button" class="button" value="View" onClick="viewApp('<%= APP_ID %>')"></div></td>	
    <td><% if (UPLOAD_YN.equals("Y")) {%>
	
	<input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowUpload('<%= ED_ID%>','<%= APP_ID%>','docViewS.jsp');"  value="UPLOAD DETAILS" />
	
	<%}else if  (!DOC_NAME.equals("")){%>
	 <input type="button" name="button3" id="button3" class="myButton" value="View EDP Certificate" onClick="viewdocument('<%= DOC_NAME %>');">
	
	<%} else {%>
	-
	<%}%>
	</td>
                  </tr>
			<%
			}
			rsMain.close();
			db.close();
			
			%>
            
        </tbody>
</table>
  <div align="center">
    
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
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
function ShowNewPage(voffcd,filename){
var urlpar=filename+'?GR_ID='+voffcd;
 var callbackFunctionArray = new Array(null, null);

 modalWin.ShowURL(urlpar,600,1000,'View Application',callbackFunctionArray,null);
 }
 function viewdocument(vDOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("edpView.jsp?docname="+vDOC_NAME,500,800,'View Document',null,null);
 }
 function ShowNewPage1(voffcd,vactid,filename){
var urlpar=filename+'?DISTRICT_CD='+voffcd+'&APP_ID='+vactid;
 var callbackFunctionArray = new Array(null, null);

 modalWin.ShowURL(urlpar,600,1000,'View Contact Details',callbackFunctionArray,null);
 }///end of bank

function ShowUpload(vedid,vappid,filename){
var urlpar=filename+'?ED_ID='+vedid+'&APP_ID='+vappid;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//end of bank

function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}

function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }

function viewApp(APP_ID){
var urlpar='PMEGPGenAppFormD.jsp?APP_ID='+APP_ID+'&RNAME=APPSTATUSVIEWD';
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }

   </script>


    </p>
  </div>
</form>
</body>
	</html>