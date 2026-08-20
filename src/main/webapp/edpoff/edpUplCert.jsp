<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<title> Pending for EDP Training </title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script> 

</head>
<body>
<form name="form" id="form" method="post">

  <%@include file="includeHeaderedp.jsp"%>
  
  <%
   String OFF_CD = vOFF_CD;
  String ONLINE_SUBDT="";

  
   StringBuffer qrysb= new StringBuffer();
  
  
/*qrysb.append("  SELECT CASE WHEN EDP_TYPE = 1 THEN 'Paid online EDP' WHEN EDP_TYPE = 2 THEN 'free Online EDP' WHEN EDP_TYPE = 3  THEN 'Paid offline EDP' ELSE 'free offline EDP ' END AS OPT,ASM.ACT_DESC,AD.APP_ID,NVL(AD.MACHINARY_COST,0) + NVL(AD.WORKING_CAPITAL,0) AS PROJECT_COST,CASE WHEN AD.IND_TYPE = 'M' THEN 'MANUFACTURING'  WHEN AD.IND_TYPE = 'T' THEN 'TRADING'  WHEN AD.IND_TYPE = 'S' THEN 'SERVICING'  END AS IND_TYPE,AD.MOB_NO1,AD.APP_NAME,MD.DISTRICT_NAME,MS.STATE_NM,ED.DOC_NAME,ED.UP_ID FROM APP_DETAIL_ONLINE AD,M_DISTRICT MD, M_STATE MS,EDP_CONDUCT_TRANS ED,APP_STATUS_MAST ASM WHERE AD.APP_ID=ED.APP_ID AND AD.ACT_ID=ASM.ACT_ID AND AD.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND ED.EDP_TYPE IN (1,3,2,4) AND ED.EDP_CERT_DT IS NULL AND ED.EDPOFF_CD='"+OFF_CD+"'  "      );
//out.print(qrysb.toString());*/

qrysb.append("   SELECT ED.DOC_NAME,ED.ED_ID ,TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR') AS ONLINE_SUBDT,"      );
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
qrysb.append("     MS.STATE_NM"      );
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

  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String APP_ID="";
String APP_NAME="";
String PROJECT_COST="";
String MOB_NO1="";
String DOC_NAME="";
String ED_ID="";
String ACT_DESC="";
String IND_TYPE="";
String OPT="";
%>




<table  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <tr>
    <th colspan="11" scope="row"><div align="center">Upload EDP Certificates</div></th>
    </tr>
	
  <tr>
    <th width="7%" scope="row">Sr. No. </th>
    <th width="7%">Application ID</th>
    <th width="15%"><p align="center">Applicant Name</p> </th>
    <th width="20%"><p align="center">Project Cost</p>  </th>
	 <th width="20%"><p align="center">Submission Date</p>  </th>
		<th width="5%">Current Status </th>
	<th width="5%">Industry Type </th>
	<th width="10%">Applicant Opted </th>
	<th width="20%"><p align="center">District</p> </th>
	<th width="20%"><p align="center">State</p> </th>   
    <th width="22%"><div align="center">Upload Certficate</div></th> 	
  </tr>
<%
   while (rsMain.next()) { 
   recCount=recCount+1;
 STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
 DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
 APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME"); 
 MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1"); 
 PROJECT_COST =rsMain.getString("PROJECT_COST")==null?"":rsMain.getString("PROJECT_COST");
 DOC_NAME=rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");
 ED_ID=rsMain.getString("ED_ID")==null?"":rsMain.getString("ED_ID");
 ONLINE_SUBDT=rsMain.getString("ONLINE_SUBDT")==null?"":rsMain.getString("ONLINE_SUBDT");
 ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
OPT=rsMain.getString("OPT")==null?"":rsMain.getString("OPT");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
  session.setAttribute("sAPP_ID", APP_ID);
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
   	
	<td> <% if (DOC_NAME.equals("")){%>
	<input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%= ED_ID%>','edpUploadByOff.jsp');"  value="UPLOAD DETAILS" />
	<% }else{%>
	 <input type="button" name="button3" id="button3" class="myButton" value="View EDP Certificate" onClick="viewdocument('<%= DOC_NAME %>');">
	
	<%}%>
	</td>
  </tr>
  <%
   }
  rsMain.close();
  db.close();
  
  
  %>
</table>
<script language="javascript">


 var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
function ShowNewPage(vedid,filename){
var urlpar=filename+'?ED_ID='+vedid;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//end of bank
function viewdocument(vDOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("edpView.jsp?docname="+vDOC_NAME,500,800,'View Document',null,null);
 }//end of bank



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