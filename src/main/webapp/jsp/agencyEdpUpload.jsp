
<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>  
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/autolist.css" />
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
 
  <% 
  
  String txtSearch =request.getParameter("txtSearch")==null?"":(String)request.getParameter("txtSearch"); 
  DBCon db= new DBCon();
  db.connect();
  
String APP_ID = "";  
String APP_NAME = "";  
String AADHAR_NO = "";
String ACT_DESC = "";
String DOC_NAME= "";
String GENDER= "";
String TOTAL_PRJ_COST="";
String ACT_ID="";


String vWherecls=""; 


if (!txtSearch.equals("")){
    vWherecls=vWherecls+"  UPPER(MQ.APP_ID||' '||trim(MQ.APP_NAME)) LIKE (UPPER('%"+txtSearch+"%'))  ";
   }
   
   else {
	  vWherecls=vWherecls+"  MQ.APP_ID='-' ";  
   }
      

  
   
  StringBuffer qrysb = new StringBuffer();
  
 qrysb.append(" SELECT * FROM  " );
qrysb.append(" (SELECT AP.APP_ID, " );
qrysb.append("   AP.APP_NAME, " );
qrysb.append("  AP.AADHAR_NO, " );
qrysb.append("   DECODE(BD.ACT_ID,11,'Sanctioned by Bank',ASM.ACT_DESC) as ACT_DESC, " );
 qrysb.append("  AP.ACT_ID, " );
 qrysb.append("  AP.GENDER,  " );
 qrysb.append("  CASE WHEN NVL(DLTFC_CE,0)+NVL(DLTFC_WC,0)>0 AND BD.ACT_ID<>11 THEN " ); 
 qrysb.append("   NVL(DLTFC_CE,0)+NVL(DLTFC_WC,0) " );
 qrysb.append("   WHEN BD.ACT_ID=11 THEN " );
 qrysb.append("    NVL(BD.MACHINARY_COST, 0)+ NVL(BD.WORKING_CAPITAL, 0) " );
  qrysb.append(" ELSE " );
qrysb.append("  NVL(AP.MACHINARY_COST, 0)+ NVL(AP.WORKING_CAPITAL, 0)  " );
 qrysb.append(" END  TOTAL_PRJ_COST " );
qrysb.append(" FROM APP_DETAIL AP, " );
  qrysb.append(" APP_STATUS_MAST ASM, " );
 qrysb.append("  MAS_OFF_MAST MOM, " );
qrysb.append("   BANK_DATAENTRY BD " );
qrysb.append(" WHERE ASM.ACT_ID    = AP.ACT_ID " );
qrysb.append(" AND AP.OFF_CD       = MOM.OFF_CD " );
qrysb.append(" AND AP.APP_ID=BD.APP_ID(+) " );
qrysb.append(" AND MOM.AGENCY_TYPE = 'KVIC' AND AP.ACT_ID=5) MQ, " );
qrysb.append(" (SELECT APP_ID,MAX(DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT WHERE UPM_CD=8 GROUP BY APP_ID) SQ " );
qrysb.append(" WHERE MQ.APP_ID=SQ.APP_ID(+) AND  "+vWherecls+"  " );

out.print (qrysb.toString());

/*qrysb.append("  SELECT AP.APP_ID,AP.APP_NAME,AP.AADHAR_NO,ASM.ACT_DESC,AP.ACT_ID,AP.GENDER,  " );
qrysb.append("  sum((NVL(AP.MACHINARY_COST, 0))+(NVL(AP.WORKING_CAPITAL,0)))  " );
qrysb.append("  AS TOTAL_PRJ_COST FROM APP_DETAIL AP,APP_STATUS_MAST ASM, MAS_OFF_MAST MOM ,APP_UPLOAD_TRANS AUT ");
qrysb.append("  WHERE ASM.ACT_ID=AP.ACT_ID AND AP.ACT_ID IN(2,5,3,22)  ");
qrysb.append("  AND AP.OFF_CD=MOM.OFF_CD AND MOM.AGENCY_TYPE='KVIC' AND AUT.APP_ID=AP.APP_ID AND AUT.UPM_CD != 8 " ); 
qrysb.append("   "+vWherecls+"  " );
qrysb.append("  Group By AP.APP_ID, AP.APP_NAME, AP.AADHAR_NO, ASM.ACT_DESC, AP.ACT_ID, AP.GENDER   ");
out.print (qrysb.toString());*/


 ResultSet rsMain = db.execSQL(qrysb.toString());


 

 
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="6"><div align="center">APPLICATION SEARCH FORM </div></th>
    </tr>
 
    <tr>
      <td>SEARCH BY APPLICATION_ID/NAME:</td>
      <td><input name="txtSearch" id="txtSearch" type="textbox" size="20" maxlength="20"  placeholder="Search by APPLICATION_ID"></td>
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
      <th><div align="center">Aadhar_No</div></th>
	  <th><div align="center">Gender </div></th>
	  <th><div align="center">Total Project Cost</div></th>	  
	  <th><div align="center">Current Status</div></th>	  
	  <th><div align="center">Upload EDP Certificate</div></th>
	  </tr>
	
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
ACT_DESC =rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
ACT_ID=rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
TOTAL_PRJ_COST=rsMain.getString("TOTAL_PRJ_COST")==null?"":rsMain.getString("TOTAL_PRJ_COST");
DOC_NAME=rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");

edpcount=edpcount+1;
	
	%>
	
	<tr>
	  <td><%= edpcount %></td>
	  <td><div align="left"><%=APP_ID%></div></td>  
      <td><div align="left"><%=APP_NAME %></div></td> 
	  <td><div align="left"><%=AADHAR_NO %></div></td> 
	  <td><div align="left"><%=GENDER %></div></td> 
	  <td><div align="left"><%=TOTAL_PRJ_COST%></div></td>	
	  <td><div align="left"><%=ACT_DESC %></div></td> 
	  <td><%	
	  if (DOC_NAME.equals("")) {	
%>	  
		    <div align="center">
			    <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%= APP_ID %>','edpCertUploadByAgency.jsp');"  value="UPLOAD EDP CERTIFICATE" />
	               
            </div>
			
			<%
	  }
			else {
				%>
				EDP Certificate Uploaded
			<%}%>
			</td>
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
function ShowNewPage(app_id,filename){
var urlpar=filename+'?APP_ID='+app_id;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,800,'View Application',null,null);
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
</html>
