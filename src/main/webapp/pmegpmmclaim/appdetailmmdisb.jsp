<%@ page contentType="text/html; charset=iso-8859-1" buffer="500kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<style type="text/css">
<!--
.style2 {color: #FFFFFF}
-->
</style>
</head>

<body>
<form name="form" id="form" class="form" method="post">

 <%@ include file="includeHeadercomm.jsp" %>
  <% 
  
  String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID"); 
  
 String ZONE_NM="";
String OFF_NAME1="";
//String  APP_ID = "";
String  APP_NAME = "";
String  MM_CLAIM_DT= "";
String  MM_CLAIM_AMT= "";
String  APP_STATUS1 = "";
String vWherecls=""; 
if (!APP_ID.equals("")){
       vWherecls=vWherecls+" AND (AD.APP_ID ) LIKE  ('%"+APP_ID+"%')  ";

   }
   else {
	  vWherecls=vWherecls+" AND (AD.APP_ID ) LIKE  ('-')  ";  
   }
      

  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
 qrysb.append("SELECT OFF_NAME1,ZONE_NM,APPRV_YN,APP_NAME,APP_ID,TO_CHAR(MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT,MM_CLAIM_AMT,     "      ); 
qrysb.append("CASE WHEN  APP_STATUS = 'RMR'  THEN ' Recommended For MM Release'"      ); 
qrysb.append("WHEN APP_STATUS = 'MR' THEN 'Margin Money Released' "      ); 
qrysb.append("WHEN APP_STATUS = 'RC' THEN 'Reffered And Clarified' "      ); 
//qrysb.append("WHEN APP_STATUS = 'RP' THEN 'Reffered And Pending' "      ); 
qrysb.append("WHEN APP_STATUS = 'RF' THEN 'Referred to KVIC Field Office' "      ); 
qrysb.append("ELSE 'Claims Under Process' END AS APP_STATUS  FROM ("      ); 

 
  qrysb.append("  SELECT BD.APP_ID,"      ); 
qrysb.append("   AD.APP_NAME,"      ); 
qrysb.append("   (CASE WHEN NVL(BD.PACT_ID,0)=34 AND BD.APPRV_YN='A'"      ); 
qrysb.append("   THEN 'MR'"      ); 
qrysb.append("   WHEN NVL(BD.PACT_ID,0)=32 AND BD.APPRV_YN='A'"      ); 
qrysb.append("   THEN 'RMR'"      ); 
qrysb.append("   WHEN  BD.PACT_ID IS NULL    "      ); 
qrysb.append("   THEN 'CUP' WHEN NVL(BD.PACT_ID,0)=30 AND BD.APPRV_YN='A' THEN 'RF' "      ); 
qrysb.append("   ELSE 'NA'"      ); 
qrysb.append("   END) AS APP_STATUS ,"      ); 
qrysb.append("   (SELECT MAX(TRUNC(UPLOAD_TIMESTAMP))  "      ); 
qrysb.append("   FROM APP_UPLOAD_TRANS AUT WHERE  AUT.APP_ID=BD.APP_ID AND AUT.UPM_CD IN (17,18,19,8)) AS VUPLOADTIMESTAMP ,"      ); 
qrysb.append("   CASE WHEN NVL(BD.PACT_ID,0)=30"      ); 
qrysb.append("   THEN TRUNC(MRT.PROC_DT) END AS PROC_DT,"      );  
qrysb.append("   BD.LOAN_DOCFNAME,"      ); 
qrysb.append("   BD.MM_CLAIM_AMT,"      ); 
 qrysb.append("  MOM.AGENCY_TYPE,"      ); 
qrysb.append("   MOM.OFF_NAME1,"      ); 
qrysb.append("   ZM.ZONE_NM,"      ); 
qrysb.append("   MS.STATE_NM,"      ); 
qrysb.append("   BD.PAY_STATUS,"      ); 
 qrysb.append("  BD.UTRN_NO, BD.PACT_ID,  BD.MM_CLAIM_DT,  BD.MM_REL_AMT,"      ); 
qrysb.append("   BD.MM_REL_DT,  BD.APPRV_YN  FROM APP_DETAIL AD,  BANK_DATAENTRY BD,"      ); 
qrysb.append("   MAS_OFF_MAST MOM,  M_DISTRICT MD,  MM_REMARKS_TRANS MRT,  M_STATE MS,"      ); 
qrysb.append("   ZONE_MAST ZM     WHERE AD.APP_ID       = BD.APP_ID   "      );  
qrysb.append(" AND MOM.OFF_CD        = AD.OFF_CD  "      ); 
qrysb.append(" AND MOM.DISTRICT_CD   = MD.DISTRICT_CD    "      );  
qrysb.append(" AND MD.STATE_CD       = MS.STATE_CD    "      ); 
qrysb.append(" AND MS.ZONE_CD        = ZM.ZONE_CD   "      ); 
qrysb.append(" AND BD.LOAN_DOCFNAME IS NOT NULL  "      ); 
qrysb.append(" AND BD.REMTRID = MRT.REMTR_ID(+)"      ); 
qrysb.append(" AND BD.MM_CLAIM_AMT   > 0   "      );
qrysb.append(" AND AD.ACT_ID         = 5  "      );  
qrysb.append(" AND BD.ACT_ID         = 11 "      );   ;
qrysb.append("   "+vWherecls+" ) " );




//out.print (qrysb.toString());
 ResultSet rsMain = db.execSQL(qrysb.toString());

 
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="7"><div align="center">APPLICATION DETAIL SEARCH FORM </div></th>
    </tr>
 
    <tr>
      <td>SEARCH BY APPLICATION_ID:</td>
      <td><input name="APP_ID" type="APP_ID" size="20" maxlength="20" value="<%= APP_ID %>" placeholder="Search by APPLICATION_ID"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     <!-- <td><input name="Submit" type="submit" class="button" id="reset" value="View All"></td>-->
    </tr>
</table>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
     <th>SRNO</th>
    <th>ZONE </th>
    <th>OFFICE NAME</th>
    <th>APPLICANT ID </th>
    <th>APPLICANT NAME</th>
    <th>MM CLAIM DT</th>
    <th>MM CLAIM AMOUNT </th>
    <th>CURRENT STATUS</th>
    <th>View </th>
	  </tr>
	
	</thead>
	 <% 

int srno =0;
 while (rsMain.next()) { 
 
ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
APP_STATUS1=rsMain.getString("APP_STATUS")==null?"":rsMain.getString("APP_STATUS");
srno =srno+1;

%>
	
	<tr>
	<td><%=srno %></td>
    <td><%=ZONE_NM %></td>
    <td><%=OFF_NAME1 %></td>
    <td><%=APP_ID %></td>
    <td><%=APP_NAME %></td>
    <td><%=MM_CLAIM_DT %></td>
    <td><%=MM_CLAIM_AMT %></td>
    <td><%=APP_STATUS1 %></td>
    <td><input name="btnDocument" type="button" class="button" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Forms / Document"></td>
	  </tr>

	<% 
	
	}
rsMain.close();
db.close();
	
	 %>	
</table>
</div>
<script language="javascript">
jQuery(function(){
i=document.form.STATE.selectedIndex; 
vstate=document.form.STATE.options[i].value;
$("#DISTRICT_NAME").autocomplete("itemlov.jsp?q="+vstate);
});

 var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
function ShowNewPage(app_id,filename){
var urlpar=filename+'?APP_ID='+app_id;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//end of bank


 function viewAlldocument(pAppid){
var urlpar='viewAppdocument.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,1000,'PMEGP View All Applicant Document',null,null);
 }

function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}


   </script>
</form>
</body>
</html>
