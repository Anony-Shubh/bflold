<%@ page contentType="text/html; charset=iso-8859-1"  language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script> 

<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('#btnFind').click(function() {
        $('#view').show();
    });
});

</script>
</head>

<body>
<form name="form" id="form" class="form" method="post">
    <%@ include file="includeHeaderPage.jsp" %>
  <% 
  
  
  String ADDRESS=request.getParameter("ADDRESS")==null?"":(String)request.getParameter("ADDRESS"); 
 String assi=vAssign;

String APP_ID = "";
String EMAIL_FROM = ""; 
String GR_ID = "";
String GR_SUB = "";
String GR_MATTER = "";
String EMAIL_TO="";
String APP_STATUS="";
String ASSIGN_TO="";
String GR_TIMESTAMP="";
String ACT_ID="";
String vWherecls=""; 
String DISTRICT_CD="";
 String APP_ACT_ID=""; 
 String APP_NAME ="";
String STATUS_DESC="";
 String OFF_CD="";
 String USER_ID="";
 if (!ADDRESS.equals("")){
       vWherecls=vWherecls+" AND ((UPPER(trim(P.EMAIL_FROM))||' '||UPPER(trim(P.APP_ID))||' '||UPPER(trim(P.GR_ID))||' '||UPPER(trim(P.SUB_ID)) LIKE (UPPER('%"+ADDRESS+"%')) ) )";

 }

  
    DBCon db= new DBCon();
  db.connect();
  
  
  
  
  

  StringBuffer qrysb = new StringBuffer();
  


qrysb.append(" SELECT P.GR_ID,ad.off_cd,du.user_id, TO_CHAR(P.GR_TIMESTAMP,'DD-MON-RRRR') AS GR_TIMESTAMP, g.SUB_desc as gr_sub, ad.act_id as app_act_id, P.EMAIL_FROM, P.EMAIL_TO, P.APP_ID, md.district_cd , (SELECT ACT_DESC FROM APP_STATUS_MAST ASM,APP_DETAIL PD WHERE PD.ACT_ID=ASM.ACT_ID AND PD.APP_ID=AD.APP_ID) AS STATUS_DESC,DECODE(P.ACT_ID,0,'Online Submitted',1,'Under Process',2,'Replied',3,'Closed') as app_status ,P.ACT_ID,P.ASSIGN_TO,ad.APP_NAME FROM pmegp_grivences P,GRIV_sub_mast g,app_detail_online ad,m_district md,mas_off_mast mom,dataentry_user du WHERE p.sub_id=g.sub_id  and p.app_id=ad.app_id and ad.unit_dist_cd=md.district_cd and ad.off_cd=mom.off_cd and mom.user_id=du.user_id AND P.ASSIGN_TO='AG'  and du.user_id="+vUserID+" " );
qrysb.append("   "+vWherecls+"  ORDER BY P.GR_TIMESTAMP DESC " );
//out.print (qrysb.toString());

 ResultSet rsMain = db.execSQL(qrysb.toString());

 
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="8"><div align="center">SEARCH FORM</div></th>
    </tr>
 
    <tr>
      <td width="30%"><div align="center">
        <input name="ADDRESS" type="text" id="ADDRESS" placeholder="Search" value="<%=ADDRESS %>"  size="30" maxlength="30">
           </div></td>
		 
       <td width="26%"><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     
    </tr>
</table>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>         
      
	  <th><div align="center">ID</div></th>
	  <th><div align="center">SUBJECT</div></th>	  
	  <th><div align="center">APPLICATION ID</div></th> 
	   <th><div align="center">APPLICATION NAME</div></th> 
	  <th><div align="center">GRIEVANCE CURRENT STATUS</div></th>
	  <th><div align="center">SUBMISSION DATE</div></th>
	   <th><div align="center">APPLICANT CURRENT STATUS</div></th>
	  	  	 <th><div align="center">CONTACT DETAILS OF IA/FB</div></th>
	   <th><div align="center">APPLICANT DETAIL</div></th>
	    <th><div align="center">VIEW DOCCUMENT</div></th>		 
 <th><div align="center">UPDATE</div></th>

    </tr>
	
	</thead>
	<%
	int count=0;
	while (rsMain.next()){
GR_ID=rsMain.getString("GR_ID")==null?"":rsMain.getString("GR_ID");
GR_SUB=rsMain.getString("GR_SUB")==null?"":rsMain.getString("GR_SUB");
EMAIL_FROM=rsMain.getString("EMAIL_FROM")==null?"":rsMain.getString("EMAIL_FROM");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_STATUS=rsMain.getString("APP_STATUS")==null?"":rsMain.getString("APP_STATUS");
ACT_ID=rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
EMAIL_TO=rsMain.getString("EMAIL_TO")==null?"":rsMain.getString("EMAIL_TO");
ASSIGN_TO=rsMain.getString("ASSIGN_TO")==null?"":rsMain.getString("ASSIGN_TO");
GR_TIMESTAMP=rsMain.getString("GR_TIMESTAMP")==null?"":rsMain.getString("GR_TIMESTAMP");
DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
APP_ACT_ID=rsMain.getString("APP_ACT_ID")==null?"":rsMain.getString("APP_ACT_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
STATUS_DESC=rsMain.getString("STATUS_DESC")==null?"Incomplete Application":rsMain.getString("STATUS_DESC");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
USER_ID=rsMain.getString("USER_ID")==null?"":rsMain.getString("USER_ID");
count=count+1;	
	%>
	<tr>
	  <td><div align="center"><%= count %></div></td>      
      <td><div align="left"><%= GR_ID %></div></td>		
	  <td><div align="left"><%= GR_SUB %></div></td>     
	  <td><div align="left"><%= APP_ID %></div></td>
	   <td><div align="left"><%= APP_NAME %></div></td>
	  <td><div align="left"><%= APP_STATUS %></div></td> 
	  <td><div align="left"><%= GR_TIMESTAMP %></div></td> 
	   <td><div align="left"><%= STATUS_DESC %></div></td> 
	      <td>	
		    <div align="center">
			    <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage1('<%= DISTRICT_CD %>','<%= APP_ID %>','offDetails.jsp');"  value="View" />
	               
            </div></td>
		 <td><div align="center"> <input name="btnSunction" type="button" class="button" value="View" onClick="viewApp('<%= APP_ID %>')"></div></td>
		  <td align="left" nowrap="nowrap"><div align="center"><span >
        <input name="btnSunction" type="button" class="button" value="Documents" onClick="viewAppDocument('<%= APP_ID %>')">
    </span></div></td>  
	  <td>	
		    <div align="center">
					<% if  ((vAssign.equals(ASSIGN_TO)) && (vUserID.equals(USER_ID))  && (!ACT_ID.equals("3")) ){%>
			    <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%= GR_ID %>','AgencyGrivUpdate.jsp');"  value="UPDATE" />
	                 <%} else {%>
					 CLOSED  <%}%>
            </div></td>
			
    </tr>
	<% 
	
	}
rsMain.close();
db.close();
	
	 %>	
</table>
</div>
<script language="javascript">
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
 
 
 function ShowNewPage2(voffcd,filename){
var urlpar='../GrivancesMS/'+filename+'?GR_ID='+voffcd;
 var callbackFunctionArray = new Array(null, null);

 modalWin.ShowURL(urlpar,600,1000,'View Application',callbackFunctionArray,null);
 }//
 
 function ShowNewPage1(voffcd,vactid,filename){
var urlpar='../GrivancesMS/'+filename+'?DISTRICT_CD='+voffcd+'&APP_ID='+vactid;
 var callbackFunctionArray = new Array(null, null);

 modalWin.ShowURL(urlpar,600,1000,'View Contact Details',callbackFunctionArray,null);
 }///end of bank



function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}

function viewAppDocument(APP_ID){
var urlpar='app_upload_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }

function viewApp(APP_ID){

var urlpar='../jasperrop/PMEGPGenAppFormD.jsp?APP_ID='+APP_ID+'&RNAME=APPSTATUSVIEWD';
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }

   </script>
</form>
</body>
</html>
