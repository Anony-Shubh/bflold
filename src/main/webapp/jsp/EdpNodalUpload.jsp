<%@ include file="../jsp/includeHeaderPage.jsp" %>
 
 <head>
 <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
 <script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script language="javascript">
function form_submit(){
document.form.submit();
}
</script>
   	<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 function ShowUpload(vedid,vappid,filename){
var urlpar=filename+'?ED_ID='+vedid+'&APP_ID='+vappid;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }
  function viewdocument(vDOC_NAME,vAPPID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("doctransfertoNas.jsp?docname="+vDOC_NAME+"&APP_ID="+vAPPID,500,800,'View Document',null,null);
 }
 
 function AddupdateEdp(vAPP_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("AddedpDetails.jsp?APP_ID="+vAPP_ID,700,1000,'View Document',null,null);
 }//end of bank

function uploadCert(vDOC_NAME,pAppid) {
var url ="../edpUpdate/docViewS.jsp?docname="+vDOC_NAME+"&APP_ID="+pAppid;
 modalWin.ShowURL(url,800,1200,'Update EDP Certificate Details',null,null);
 
}

function updateEdp(vAPP_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("AgnEnbEdp.jsp?APP_ID="+vAPP_ID,700,1000,'View Document',null,null);
 }
function refresh_data(){
window.parent.location.reload();
}
function uploadCerti(pAppid) {
var url ='../bankModule/edpAppUplodadByAgency.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,500,700,'Upload EDP Certificate',null,null);
 
}



 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refreshpage() {
   form.submit(); 
}

$(document).ready(function() {
    $('#example').DataTable();
} );


function view()
  {
  var PEND_TYPE=document.getElementById("PEND_TYPE").value;

window.location.href = 'edpDetailGeneRepo.jsp?REPNM=edpDetaildownload&PEND_TYPE='+PEND_TYPE;
}

 

</script>
</head>
<body  >
<%
 String PEND_TYPE =request.getParameter("PEND_TYPE")==null?"2":(String)request.getParameter("PEND_TYPE"); 
%>
<form  method="post" name="form" >
<br/>
  <table align="center" class="bordered">
    <tr>
      <th colspan="11"><div align="center">EDP DATA UPLOAD/UPDATE FORM  </div></th>
    </tr>
 
   
<tr>
       <td colspan="8"><div align="center">SEARCH :

          <select name="PEND_TYPE" id="PEND_TYPE" onChange="form_submit();">
		  
          <option value="1" <% if (PEND_TYPE.equals("1")){ out.print("selected");}%>> ALL</option>
		   <option value="2" <% if (PEND_TYPE.equals("2")){ out.print("selected");}%>> SANCTION CASES PENDING</option>
		    <option value="3" <% if (PEND_TYPE.equals("3")){ out.print("selected");}%>> PRE EDP CASES PENDING</option>
                 
        </select>
      </div></td>
	  <td colspan="3"><div align="center"><input type="button" class="button"  onClick="view();" value="Download" ></div></td>
</tr>
</table>

      <p>*online EDP is disabled untill further Notice. </p>
      <div align="center">
        <%

String SOFF_CD =(String) session.getAttribute("off_cd"); 
//out.print(SOFF_CD);

String vWherecls="";
 List values=new ArrayList();
     List pstm=new ArrayList();
	pstm.clear();
    values.clear();
	

if (PEND_TYPE.equals("1")){
       vWherecls=vWherecls+"  WHERE MQR.APP_ID=SQR.APP_ID (+)  ";

   }
   else if (PEND_TYPE.equals("2")) {
	  vWherecls=vWherecls+" WHERE MQR.APP_ID = SQR.APP_ID(+) AND MQR.ACT_ID=11 AND (MQR.EDP_CERT_DT IS NULL OR SQR.DOC_NAME IS NULL)  ";  
   }
    else {
	  vWherecls=vWherecls+" WHERE MQR.APP_ID = SQR.APP_ID(+) AND MQR.EDP_TYPE IN (1,3) AND MQR.EDP_CERT_DT IS NULL   ";  
   }
   
//"DIAS16175805-1266832"
String  APP_ID = "";
String  APP_NAME ="";
String  PAN_NO="";
String   AADHAR_NO = "";
String   MM_REL_DT= "";
String    MM_REL_AMT = "";
String  CURRENT_STATUS= "";
String SRNO="";
String ACT_ID="";
String ACT_ID_AD="";
String UPLOAD_YN="";
String ED_ID="";
String DOC_NAME="";
String OPT="";
String EDP_DOC="";
String EDP_CERT_DT="";
String MM_REL_YN="";
%>
      </div>
      <table align="center"  class="display" id="example" >
 <thead>
  <tr>
    <th><div align="center">Sr no. </div></th>
    <th><div align="center">Applicant ID </div></th>
    <th><div align="center">Applicant Name</div></th>
    <th><div align="center">Aadhar Card No. </div></th>
    <th><div align="center">PAN No. </div></th>
    <th><div align="center">Project Cost </div></th>
    <th><div align="center">Loan Sanction date</div></th>
	<th><div align="center">EDP Certficate Issue Date</div></th>
    <th> <div align="center">Current Status</div></th>
	<th> <div align="center">MM RELEASE </div></th>
	<th><div align="center">EDP Type Opted</div> </th>
	<th><div align="center">Add/Edit Edp Details</div> </th>
    <th><div align="center">Update EDP Detail </div></th>
    </tr>
  </thead>

  <tbody>
  <%
  StringBuffer qrysb= new StringBuffer();
qrysb.append("      SELECT MQR.*,SQR.DOC_NAME FROM (SELECT ROWNUM AS SRNO,AD.APP_NAME, CASE WHEN (AD.ACT_ID <= 5 OR AD.ACT_ID=7)  AND NVL(bd.ACT_ID, 0) = 0 THEN asm.ACT_DESC ELSE bas.ACT_DESC END AS CURRENT_STATUS, "      );
qrysb.append("        AD.APP_ID,ED.DOC_NAME AS EDP_DOC,ED.ED_ID,DECODE(BD.MM_REL_DT,NULL,'No','Yes') AS MM_REL_YN,DECODE(BD.ACT_ID,11,(NVL(bd.MACHINARY_COST, 0) + NVL(bd.WORKING_CAPITAL, 0)) ,(NVL(ad.MACHINARY_COST, 0) + NVL(ad.WORKING_CAPITAL, 0)))  AS  mm_rel_amt,"      );
qrysb.append("            DECODE(ad.aadhar_no,NULL,NULL, '*****'     || substr(ad.aadhar_no,7,length(ad.aadhar_no)-6)) AADHAR_NO,ad.act_id as act_id_ad,bd.act_id,"      );
qrysb.append("              AD.PAN_NO,"      );
qrysb.append("              TO_CHAR(BD.LOAN_SANC_DT,'DD-MON-YYYY') mm_rel_dt,"      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ED.EDP_TYPE = 1"      );
qrysb.append("       THEN 'Paid online EDP'"      );
qrysb.append("       WHEN ED.EDP_TYPE = 2"      );
qrysb.append("       THEN 'free Online EDP'"      );
qrysb.append("       WHEN ED.EDP_TYPE = 3"      );
qrysb.append("       THEN 'Paid offline EDP' WHEN ED.EDP_TYPE = 4 THEN 'free offline EDP' "      );
qrysb.append("       ELSE 'EDP Not Opted' "      );
qrysb.append("     END AS OPT,TO_CHAR(BD.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT ,ED.EDP_TYPE,"      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ((BD.ACT_ID = 11 "      );
qrysb.append("       AND ED.EDP_TYPE  IN (4,2))"      );
qrysb.append("       OR (ED.EDP_TYPE  IN (1,3)))"      );
qrysb.append("       AND ED.DOC_NAME IS NULL"      );
qrysb.append("       THEN 'Y'"      );
qrysb.append("       ELSE 'N'"      );
qrysb.append("     END AS UPLOAD_YN "      );
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("        BANK_DATAENTRY BD,edp_conduct_trans ed,bank_app_status bas,app_status_mast asm "      );
qrysb.append("      WHERE AD.APP_ID         = BD.APP_ID(+) and AD.APP_ID=ed.app_id(+) AND AD.ACT_ID = asm.ACT_ID AND bd.ACT_ID = bas.ACT_ID(+)  "      );
qrysb.append("       AND  AD.OFF_CD="+SOFF_CD+")MQR,  "      );
qrysb.append(" (SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT WHERE  ");
qrysb.append("  AUT.UPM_CD=8  AND AUT.DOC_ACTYN='Y' ");
qrysb.append("   GROUP BY AUT.APP_ID) SQR  ");
qrysb.append("  "+vWherecls+"   ");

//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();



ResultSet rsMain = db.execSQL(qrysb.toString());
 while (rsMain.next()) {
 SRNO =rsMain.getString("SRNO")==null?"":rsMain.getString("SRNO");
APP_ID =rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME =rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
 AADHAR_NO = rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
 MM_REL_DT= rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
  MM_REL_AMT = rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
ACT_ID_AD= rsMain.getString("ACT_ID_AD")==null?"":rsMain.getString("ACT_ID_AD");
ACT_ID= rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
CURRENT_STATUS= rsMain.getString("CURRENT_STATUS")==null?"":rsMain.getString("CURRENT_STATUS");
ED_ID= rsMain.getString("ED_ID")==null?"":rsMain.getString("ED_ID");
DOC_NAME= rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");
UPLOAD_YN= rsMain.getString("UPLOAD_YN")==null?"":rsMain.getString("UPLOAD_YN");
OPT= rsMain.getString("OPT")==null?"":rsMain.getString("OPT");
EDP_DOC=rsMain.getString("EDP_DOC")==null?"":rsMain.getString("EDP_DOC");
EDP_CERT_DT=rsMain.getString("EDP_CERT_DT")==null?"":rsMain.getString("EDP_CERT_DT");
MM_REL_YN=rsMain.getString("MM_REL_YN")==null?"":rsMain.getString("MM_REL_YN");
%>
  <tr valign="middle">
    <td><div align="center"><%= SRNO %></div></td>
    <td><div align="center"><%= APP_ID %></div></td>
    <td><div align="left"><%= APP_NAME %></div></td>
    <td><div align="center"><%= AADHAR_NO %></div></td>
    <td><div align="center"><%= PAN_NO %></div></td>
    <td><div align="center"><%= MM_REL_AMT %></div></td>
    <td><div align="center"><%= MM_REL_DT %></div></td>
	<td><div align="center"><%=EDP_CERT_DT %></div></td>
    <td><div align="center"><%= CURRENT_STATUS %></div></td>
	  <td><div align="center"><%= MM_REL_YN %></div></td>
	  <td><div align="center"><%=OPT%></div></td>
	  <td>
		<% if ((UPLOAD_YN.equals("N")) && (EDP_CERT_DT.equals("")) && (DOC_NAME.equals("")) && (ED_ID.equals("")) )  {%>
		<input name="btnDocument" type="button" class="buttonBlue1"  id="btnDocument" value="Add Edp Details" onClick="AddupdateEdp('<%= APP_ID %>')">
		<%} else if ((EDP_CERT_DT.equals("")) && (!ED_ID.equals("")))  {%>
		<input name="btnDocument" type="button" class="buttongreen1"  id="btnDocument" value="Update Edp Details" onClick="updateEdp('<%= APP_ID %>')">
		<%}%>
		
		</td>

    <td>

	<%  if ((UPLOAD_YN.equals("Y")) && (EDP_CERT_DT.equals("")) && (DOC_NAME.equals("")) )  {%>	
	<input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowUpload('<%= ED_ID%>','<%= APP_ID%>','edpUploadByOff.jsp');"  value="UPLOAD EDP DETAILS" />	
	<%}else if ( (!DOC_NAME.equals("")) && (EDP_CERT_DT.equals("")) && (ACT_ID.equals("11"))){%>
	<input name="btnUpload" type="button" class="buttonOrange1" value="Update EDP Certificate Details" onClick="uploadCert('<%= DOC_NAME %>','<%= APP_ID %>')"></div>
	<%}else if ( (DOC_NAME.equals("")) && (!EDP_CERT_DT.equals("")) && (ACT_ID.equals("11"))){%>
	<input name="btnUpload" type="button" class="buttonMerun1" value="Upload EDP Certificate" onClick="uploadCerti('<%= APP_ID %>')"></div>
	<%}else if  (!DOC_NAME.equals("")){%>
	 <input type="button" name="button3" id="button3" class="myButton1" value="View EDP Certificate" onClick="viewdocument('<%= DOC_NAME %>','<%= APP_ID%>');">
<%} else if ((UPLOAD_YN.equals("N")) && (EDP_CERT_DT.equals("")) && (DOC_NAME.equals("")) && (ED_ID.equals("")) )  {%>
	<!--Opt for EDP-->-
	<%} else{%>
	-
	<%}%>
	</td>
    </tr>
  <%}
	rsMain.close();
	db.close();
	%></tbody>
</table>


</form>
</body>
</html>
