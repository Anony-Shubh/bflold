<%@ include file="includeHeadercomm.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>  
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>

</head>

<body>
<form name="form" id="form" class="form" method="post">
 
  <% 
  
  String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID"); 
  
  
String APP_NAME = "";  
String OFF_CD="";
String OFF_NAME = "";
String IFSC_CODE = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String APP_DIST_CD="";
String APP_PIN="";
String BANK_NAME="";
String DOC_NAME="";
String edp_type="";
String curr_status="";
String vWherecls=""; 
if (!APP_ID.equals("")){
       vWherecls=vWherecls+"  (app_id) LIKE  ('%"+APP_ID+"%')  ";

   }
   else {
	  vWherecls=vWherecls+"  (app_id) LIKE  ('-')  ";  
   }
  
    DBCon db= new DBCon();
    db.connect();

  StringBuffer qrysb = new StringBuffer();
 

qrysb.append(" select mqr.aadhar_no,mqr.app_id,mqr.app_name,(case when mqr.off_cd=9246 and trim(UPPER(sqr.DOC_NAME)) like'S%' then 'ONLINE EDP' ELSE 'OFFLINE EDP' END) AS edp_type,mqr.curr_status,mqr.ifsc_code,mqr.BANK_NAME,sqr.DOC_NAME " );
qrysb.append(" from (select bd.app_id,ad.aadhar_no,ad.app_name,FUNC_GETCURRENTSTATUS(ad.app_id) as curr_status,ad.IFSC_CODE,AD.BANK_NAME,bd.off_cd from app_detail ad,bank_dataentry bd" );
qrysb.append(" where ad.app_id=bd.app_id(+)  )mqr," );
qrysb.append(" ( SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT, BANK_DATAENTRY BD WHERE AUT.APP_ID=BD.APP_ID " );
qrysb.append(" AND AUT.UPM_CD=8 and doc_actyn='Y' group by AUT.APP_ID )sqr " );
qrysb.append("  WHERE mqr.APP_ID=sqr.APP_ID (+) and mqr.aadhar_no in (select aadhar_no from app_detail where "+vWherecls+" ) " );

//out.print (qrysb.toString());
 ResultSet rsMain = db.execSQL(qrysb.toString());
 
 


 
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="6"><div align="center">APPLICATION SEARCH FORM </div></th>
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
      <th>Sr No </th>
      <th><div align="center">Application_Id</div></th>
      <th><div align="center">Applicant_Name</div></th>     
      <th><div align="center">IFSC CODE</div></th>
	  <th><div align="center">Bank_Name</div></th>	
	   <th><div align="center">Current Status</div></th>
	  <th><div align="center">Training Type</div></th>
	   <th><div align="center">View EDP Certificate</div></th>
	
	 
    </tr>
	
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BANK_NAME =rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
DOC_NAME=rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");
edp_type=rsMain.getString("edp_type")==null?"":rsMain.getString("edp_type");
curr_status=rsMain.getString("curr_status")==null?"":rsMain.getString("curr_status");
edpcount=edpcount+1;
	
	%>
	
	<tr>
	  <td><%= edpcount %></td>
	  <td><div align="left"><%=APP_ID%></div></td>  
      <td><div align="left"><%=APP_NAME %></div></td> 
	  <td><div align="left"><%=IFSC_CODE %></div></td> 
	  <td><div align="left"><%=BANK_NAME %></div></td> 
       <td><div align="left"><%=curr_status %></div></td> 
       <td><div align="left"><%=edp_type %></div></td> 	
      
	 
	  <td>	
		    <div align="center">
			<% if  (!DOC_NAME.equals("")) {%>
			<input type="button" name="button" id="button" class="button" value="View EDP Certificate" onClick="viewdocument('<%= DOC_NAME %>','<%=APP_ID%>');">
	</center>
	
			<% } else {	%>
			    EDP Certificate Not Uploaded
	             <%
}%>				 
            </div></td>
			
    </tr>
	<% 
	

	
	}rsMain.close();
db.close();
	
	 %>	
</table>
</div>
<script language="javascript">

var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
function ShowNewPage(app_id,filename){
var urlpar=filename+'?APP_ID='+app_id;
 

 modalWin.ShowURL(urlpar,1000,1500,'View Application',null,null);
 }//end of bank



function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function viewdocument(vDOC_NAME,vAPP_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("docViewEdp.jsp?docname="+vDOC_NAME+"&APP_ID="+vAPP_ID,750,1200,'View Document',null,null);
 }//end of bank

function refreshpage() {
   form.submit(); 
}

function uploadCert(vDOC_NAME,pAppid) {
var url ="docViewS.jsp?docname="+vDOC_NAME+"&APP_ID="+pAppid;
 modalWin.ShowURL(url,800,1200,'Update EDP Certificate Details',null,null);
 
}

   </script>
</form>
</body>
</html>
