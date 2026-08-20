<%@ include file="includeHeaderPage.jsp" %>
<!DOCTYPE html>
<html>
<head>   
    <title>Dashboard Boxes - Bootsnipp.com</title> 
	<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
 <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.6.4/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.print.min.js  "></script>  
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<style>
	@-webkit-keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
@-moz-keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
@-o-keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
@keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
.invalid {
  -webkit-animation: invalid 3s infinite; /* Safari 4+ */
  -moz-animation:    invalid 3s infinite; /* Fx 5+ */
  -o-animation:      invalid 3s infinite; /* Opera 12+ */
  animation:         invalid 3s infinite; /* IE 10+ */
}

td {
    padding: 1em;
}
}
</style>
	<script>
$(document).ready(function() {
	//function rotate(i) {
    //   var x = document.getElementById(i);
     var blink = document.getElementById('blink_me');
	 //alert(blink);
      setInterval(function() {
        blink.style.opacity = (blink.style.opacity == 0 ? 5 : 0);
      }, 1000);
  //  }
});
</script>

	<script>
	$(document).ready(function() {
    $('#example').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'print'
			
        ]
    } );
} );

	
$('#example').DataTable( {
    buttons: [
        {
            extend: 'print',
            text: 'Print current page',
            autoPrint: false
        }
    ]
} );

$('#example').DataTable( {
    buttons: [
        {
            extend: 'print',
            text: 'Print current page',
            exportOptions: {
                modifier: {
                    page: 'current'
                }
            }
        }
    ]
} );
 </script>   
</head>
<body>
<form name="form" id="form"  class="form" >
<%

String user_id= vUserID;
String T =request.getParameter("T")==null?"":(String)request.getParameter("T");
DBCon db= new DBCon();
db.connect();
String vcls="";
if (T.equals("ALL")) {
vcls= vcls+" AND TRUNC(ad.ONLINE_SUBDT) BETWEEN '01-APR-2016' AND SYSDATE  ";
}
if (T.equals("UP")) {
vcls= vcls+"  AND  ad.ACT_ID in (0,1,2,4) AND SYSDATE-TRUNC(AD.ONLINE_SUBDT) < =26"; 
}
if (T.equals("RJ")) {
vcls= vcls+"  AND (ad.ACT_ID IN(3,7) OR ad.ACT_YN='N') ";
}
if (T.equals("BS")) {
vcls= vcls+"  AND ad.ACT_ID = 5 AND ad.ACT_YN='Y' ";
}
if (T.equals("PD")) {
vcls= vcls+"  AND SYSDATE-TRUNC(AD.ONLINE_SUBDT) > 26 AND ad.ACT_ID in (0,1,2,4) AND ad.ACT_YN='Y' ";
}






StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT ad.APP_ID,trunc(SYSDATE)-TRUNC(AD.ONLINE_SUBDT) as no_of_days,TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR') AS ONLINE_SUBDT,FUNC_GETCURRENTSTATUS(AD.APP_ID) as CURRENT_STATUS,"      );
qrysb.append("     ad.APP_NAME, CASE WHEN AD.ACT_ID=4 AND MTG_ID is not null AND AD.ACT_YN='Y' THEN 'Y' ELSE 'N' END AS RET_YN,"      );
qrysb.append("     ad.GENDER,"      );
qrysb.append("     ad.MOB_NO1,"      );
qrysb.append("     nvl(ad.MACHINARY_COST,0)+nvl(ad.WORKING_CAPITAL,0) as PRJ_COST,"      );
qrysb.append("     ad.IFSC_CODE,"      );
qrysb.append("     md.DISTRICT_NAME, BTM.BENF_TYPE_DESC,"      );
qrysb.append("     bcm.BENF_CATEGORY_DESC,igm.IND_GRP_LONG_DESC,"      );
qrysb.append("     am.ACTIVITY_NAME"      );
qrysb.append("     || ' / '"      );
qrysb.append("     || ad.PROD_DESC AS ACTIVITY_NAME"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     m_district md, benf_type_mast BTM,"      );
qrysb.append("     benf_category_mast bcm,activity_mast am,"      );
qrysb.append("     ind_grp_mast igm"      );
qrysb.append("   WHERE ad.OFF_CD     = mom.OFF_CD"      );
qrysb.append("   AND ad.UNIT_DIST_CD = md.DISTRICT_CD"      );
qrysb.append("   AND ad.BENF_TYPE_CD     = BTM.BENF_TYPE_CD"      );
qrysb.append("   AND ad.BENF_CATAGORY_CD = bcm.BENF_CATEGORY_CD"      );
qrysb.append("   AND ad.ACTIVITY_CD      = am.ACTIVITY_CD"      );
qrysb.append("   AND am.IND_GRP_CD       = igm.IND_GRP_CD  "+vcls+"  "      );
qrysb.append("   AND mom.USER_ID    = "+user_id+" "      );
if (T.equals("PD")) {
qrysb.append(" UNION "      );
qrysb.append("   SELECT ad.APP_ID,trunc(SYSDATE)-TRUNC(AD.ONLINE_SUBDT) as no_of_days,TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR') AS ONLINE_SUBDT,FUNC_GETCURRENTSTATUS(AD.APP_ID) as CURRENT_STATUS,"      );
qrysb.append("     ad.APP_NAME, CASE WHEN AD.ACT_ID=4 AND MTG_ID is not null AND AD.ACT_YN='Y' THEN 'Y' ELSE 'N' END AS RET_YN,"      );
qrysb.append("     ad.GENDER,"      );
qrysb.append("     ad.MOB_NO1,"      );
qrysb.append("     nvl(ad.MACHINARY_COST,0)+nvl(ad.WORKING_CAPITAL,0) as PRJ_COST,"      );
qrysb.append("     ad.IFSC_CODE,"      );
qrysb.append("     md.DISTRICT_NAME, BTM.BENF_TYPE_DESC,"      );
qrysb.append("     bcm.BENF_CATEGORY_DESC,igm.IND_GRP_LONG_DESC,"      );
qrysb.append("     am.ACTIVITY_NAME"      );
qrysb.append("     || ' / '"      );
qrysb.append("     || ad.PROD_DESC AS ACTIVITY_NAME"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     m_district md, benf_type_mast BTM,"      );
qrysb.append("     benf_category_mast bcm,activity_mast am,"      );
qrysb.append("     ind_grp_mast igm"      );
qrysb.append("   WHERE ad.OFF_CD     = mom.OFF_CD"      );
qrysb.append("   AND ad.UNIT_DIST_CD = md.DISTRICT_CD"      );
qrysb.append("   AND ad.BENF_TYPE_CD     = BTM.BENF_TYPE_CD"      );
qrysb.append("   AND ad.BENF_CATAGORY_CD = bcm.BENF_CATEGORY_CD"      );
qrysb.append("   AND ad.ACTIVITY_CD      = am.ACTIVITY_CD"      );
qrysb.append("   AND am.IND_GRP_CD       = igm.IND_GRP_CD  AND AD.MTG_ID IS NOT NULL AND ad.ACT_ID = 4  AND ad.ACT_YN  = 'Y'  "      );
qrysb.append("   AND mom.USER_ID    = "+user_id+" "      );
}
ResultSet rsApp = db.execSQL(qrysb.toString());
String APP_ID="";
String APP_NAME="";
String GENDER="";
String MOB_NO1="";
String PRJ_COST="";
String RET_YN="";
String IFSC_CODE="";
String DISTRICT_NAME="";
String BENF_TYPE_DESC="";
String BENF_CATEGORY_DESC="";
String IND_GRP_LONG_DESC="";
String ACTIVITY_NAME="";
String NO_OF_DAYS="";
String ONLINE_SUBDT="";
String CURRENT_STATUS="";

//out.print(qrysb);

	int edpcount=0;




%>
<div align="center"><a href="PMEGPAgencyHomePage.jsp" class="greenButtonRound">Back</a></div>
<table id="example" class="display" style="width:100%">
        <thead>
            <tr>
                <th>Sr.No</th>
				
                <th>ID</th>
                <th>Name</th>               
                <th>Project cost</th>				
				<th>Cateogry</th>
                <th>Activity</th>
				<th>Current Status</th>
				<% if (T.equals("PD")){%>
				<th>Days Since Pending</th>
				<th>Online Submission Date</th>
				<%}%>
                <th>Industry Type</th>
                <th>Ifsc Code</th>
				<% if (T.equals("PD")){%>
                <th>Return</th>
                <%}%>
            </tr>
        </thead>
        <tbody>
		<%
		while (rsApp.next()){
APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
PRJ_COST=rsApp.getString("PRJ_COST")==null?"":rsApp.getString("PRJ_COST");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
DISTRICT_NAME=rsApp.getString("DISTRICT_NAME")==null?"":rsApp.getString("DISTRICT_NAME");
BENF_TYPE_DESC=rsApp.getString("BENF_TYPE_DESC")==null?"":rsApp.getString("BENF_TYPE_DESC");
BENF_CATEGORY_DESC=rsApp.getString("BENF_CATEGORY_DESC")==null?"":rsApp.getString("BENF_CATEGORY_DESC");
IND_GRP_LONG_DESC=rsApp.getString("IND_GRP_LONG_DESC")==null?"":rsApp.getString("IND_GRP_LONG_DESC");
ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
NO_OF_DAYS=rsApp.getString("NO_OF_DAYS")==null?"":rsApp.getString("NO_OF_DAYS");
CURRENT_STATUS=rsApp.getString("CURRENT_STATUS")==null?"":rsApp.getString("CURRENT_STATUS");
RET_YN=rsApp.getString("RET_YN")==null?"":rsApp.getString("RET_YN");
int NO_D = Integer.parseInt(NO_OF_DAYS);
edpcount=edpcount+1;
%>
            <tr>
			 <td>
			 
			 
			 <%=edpcount%>
			
			 
			 </td>
			
                <td><%=APP_ID%></td>
                <td><%=APP_NAME%></td>
                
                <td><%=PRJ_COST%></td>                
				<td><%=BENF_CATEGORY_DESC%></td>
                <td><%=ACTIVITY_NAME%></td>
				 <td><%=CURRENT_STATUS%></td>
				<% if (T.equals("PD") && NO_D >26 ){%>
				<td class="invalid"><%= NO_OF_DAYS%></td>				
				<td><%=ONLINE_SUBDT%></td>
				<%} else {%>
				<td ></td>				
				<td></td>
				<%}%>
				
                <td><%=IND_GRP_LONG_DESC%></td>
				<td><%=IFSC_CODE%></td>
				
                <td><% if ((T.equals("PD")) && (RET_YN.equals("Y"))){%>
				<input name="btnReturned" type="button" class="buttonMarun"  id="btnReturned" onClick="rejectBankPage('<%= APP_ID %>')" value="Returned">
				<%} else {%>
				-
				<%}%>
				</td>
             
            </tr>
			
		<% } rsApp.close();db.close();%>
</tbody>
 <tfoot>
            <tr>
             <th>Sr.No</th>
			 
                <th>ID</th>
                <th>Name</th>               
                <th>Project cost</th>				
				<th>Cateogry</th>
                <th>Activity</th>
				<th>Current Status</th>
				<% if (T.equals("PD")){%>
				<th>Days Since Pending</th>
				<th>Online Submission Date</th>
				<%}%>
                <th>Industry Type</th>
                <th>Ifsc Code</th>
				<% if (T.equals("PD")){%>
                <th>Return</th>
				<%}%>
            </tr>
        </tfoot>
</table>
</form>
 <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");


 function rejectBankPage(APP_ID){
 var callbackFunctionArray = new Array(refreshpage);
var urlpar='AgencyReject.jsp?APP_ID='+APP_ID;
//var urlpar='applicantFormValidation.jsp?APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1000,'Reject App Process....',callbackFunctionArray,null);
 }//

function refreshpage() {
   form.submit(); 
}
function HideModalWindow1() {

    modalWin.HideModalPopUp();
}

function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

</script>
  </body>
</html>
