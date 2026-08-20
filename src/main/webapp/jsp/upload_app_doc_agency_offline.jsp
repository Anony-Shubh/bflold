<%@ include file="includeHeaderPage.jsp" %>
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<body>
<form method="post" name="form" id="form" >
	    <%
		
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		 session.setAttribute("sAPP_ID",APP_ID);
		 String vOffcd= (String) session.getAttribute("off_cd");
if (vOffcd !=null) {
       String APP_NAME = "";
String SOC_CAT = "";
String GENDER = "";
String E_MAIL = "";
String EDU_DESC = "";
String UNIT_LOC = "";
String AADHAR_NO = "";
String REGD_NO = "";
String TAN_NO = "";
String PAN_NO = "";
String SPE_CAT = "";
String BENF_TYPE_DESC = "";
String FH_NAME = "";
 String EDP_YN = "";
String ACT_ID="";
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		
        DBCon db= new DBCon();
        db.connect();
           StringBuffer qry = new StringBuffer();
       
	   
	   qry.append("   SELECT AD.APP_NAME,"      );
		qry.append("    BCMCAT.BENF_CATEGORY_DESC AS SOC_CAT ,AD.ACT_ID,"      );
		qry.append("     AD.GENDER,"      );
		qry.append("     AD.E_MAIL,"      );
		qry.append("     EM.EDU_DESC,"      );
		qry.append("     AD.UNIT_LOC, DECODE(AD.EDP_YN,'N','No','Yes') AS EDP_YN, "      );
		qry.append("     AD.AADHAR_NO,"      );
		qry.append("     AD.REGD_NO,"      );
		qry.append("     AD.TAN_NO,"      );
		qry.append("     AD.PAN_NO,"      );
		qry.append("     BCMSCAT.BENF_CATEGORY_DESC AS SPE_CAT,"      );
		qry.append("     BTM.BENF_TYPE_DESC,"      );
		qry.append("     AD.APP_ID,"      );
		qry.append("     AD.FH_NAME"      );
		qry.append("   FROM APP_DETAIL_ONLINE AD,"      );
		qry.append("     EDUCATION_MAST EM,"      );
		qry.append("     BENF_CATEGORY_MAST BCMCAT,"      );
		qry.append("     BENF_TYPE_MAST BTM,"      );
		qry.append("     BENF_CATEGORY_MAST BCMSCAT"      );
		qry.append("   WHERE AD.EDU_ID              = EM.EDU_ID"      );
		qry.append("   AND AD.BENF_TYPE_CD          = BTM.BENF_TYPE_CD"      );
		qry.append("   AND AD.BENF_CATAGORY_CD      = BCMCAT.BENF_CATEGORY_CD"      );
		qry.append("   AND BCMSCAT.BENF_CATEGORY_CD = AD.BENF_SPECAT_CD AND APP_ID=? AND AD.OFF_CD=?"      );

			 List values=new ArrayList();
				 values.add (APP_ID); 
				  values.add (vOffcd); 

        ResultSet rsApp =db.executeSQL(qry.toString(),values);
 					 values.clear();	

        while (rsApp.next()){
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
SOC_CAT=rsApp.getString("SOC_CAT")==null?"":rsApp.getString("SOC_CAT");
GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
EDU_DESC=rsApp.getString("EDU_DESC")==null?"":rsApp.getString("EDU_DESC");
UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
REGD_NO=rsApp.getString("REGD_NO")==null?"":rsApp.getString("REGD_NO");
TAN_NO=rsApp.getString("TAN_NO")==null?"":rsApp.getString("TAN_NO");
PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
SPE_CAT=rsApp.getString("SPE_CAT")==null?"":rsApp.getString("SPE_CAT");
BENF_TYPE_DESC=rsApp.getString("BENF_TYPE_DESC")==null?"":rsApp.getString("BENF_TYPE_DESC");
APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
FH_NAME=rsApp.getString("FH_NAME")==null?"":rsApp.getString("FH_NAME");
EDP_YN=	rsApp.getString("EDP_YN")==null?"":rsApp.getString("EDP_YN");	
ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
        }
			rsApp.close();
			
				StringBuffer qryUp = new StringBuffer();	
		if (ACT_ID.equals("5")) {	
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM APP_UPLOAD_TRANS AUT,APP_UPLOAD_MAST AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD AND AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM WHERE ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM APP_UPLOAD_TRANS ");
qryUp.append(" WHERE APP_ID=?)) ");
qryUp.append(" WHERE UPM_CD IN (8,19) OR UPM_CD IN ");
qryUp.append(" (SELECT * FROM TABLE(FUPLOAD_DOC(?))) ");
}else{
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM APP_UPLOAD_TRANS AUT,APP_UPLOAD_MAST AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD AND AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM WHERE ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM APP_UPLOAD_TRANS ");
qryUp.append(" WHERE APP_ID=?)) ");
qryUp.append(" WHERE UPM_CD IN ");
qryUp.append(" (SELECT * FROM TABLE(FUPLOAD_DOC(?))) ");

}

      values.add (APP_ID); 
	  values.add (APP_ID); 
	  values.add (APP_ID); 
	ResultSet rsUp = db.executeSQL(qryUp.toString(),values);
	values.clear();	
		
        %>
  </p>
	  <table align="center" class="pmegpTable">
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </th>
		   <center><a href="AppSearchLOVOFF.jsp" class="greenButtonRound">Back</a></center>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">ID:</div></th>
          <th nowrap><%= APP_ID %></th>
          <th nowrap><div align="right">Aadhaar No: </div></th>
          <th nowrap><%= AADHAR_NO %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">Name:</div></th>
          <th nowrap><%= APP_NAME %>&nbsp;</th>
          <th nowrap><div align="right">PAN No. </div></th>
          <th nowrap><%= PAN_NO %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">Category: </div></th>
          <th nowrap><%= SOC_CAT %></th>
          <th nowrap><div align="right">Special Category : </div></th>
          <th nowrap><%= SPE_CAT %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">Education:</div></th>
          <th nowrap><%= EDU_DESC %></th>
          <th nowrap><div align="right">Unit Location: </div></th>
          <th nowrap><%= UNIT_LOC %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">EDP Training: </div></th>
          <th colspan="3" nowrap><%= EDP_YN %></th>
        </tr>
        
        <tr>
          <th nowrap>SrNo</th>
          <th nowrap>Document Desc </th>
          <th nowrap>Remarks</th>
          <th nowrap>View</th>
          <th nowrap>delete</th>
        </tr>
        <% 
  
  String vDOC_NAME="";
  String vDOC_DESC="";
  String vDOC_REMARKS="";
  int srno=0;
  while (rsUp.next()) {
  srno=srno+1;
    vDOC_NAME=rsUp.getString("DOC_NAME")==null?"":rsUp.getString("DOC_NAME");
   vDOC_DESC=rsUp.getString("DOC_DESC")==null?"":rsUp.getString("DOC_DESC");
   vDOC_REMARKS=rsUp.getString("DOC_REMARKS")==null?"":rsUp.getString("DOC_REMARKS");
   UP_ID = rsUp.getString("UP_ID")==null?"0":rsUp.getString("UP_ID");
		 UPM_CD = rsUp.getString("UPM_CD")==null?"":rsUp.getString("UPM_CD");
  
  %>
        <tr>
          <th><%= srno %></th>
          <th><%= vDOC_DESC %></th>
          <td><%= vDOC_REMARKS %></td>
          <td>
		  <% if (!UP_ID.equals("0")) {%>
		  		  <input name="btnview" type="button" class="button"  onClick="ShowNewPageView('<%= vDOC_NAME %>');" value="View">

		  <% }else{%>
		  <input name="btnUpload" type="button" class="button"  onClick="ShowNewPage('<%= UPM_CD %>','<%= APP_ID %>');" value="UPLOAD">
		  <% } %>		   </td>
          <td>
		  
		  
		 <% if (!UP_ID.equals("0"))  {%>
		  
		  <input name="btnUploadDel" type="button" class="button"  onClick="ShowNewPageDel('<%= UP_ID %>','<%= APP_ID %>');" value="Delete">
		
		  <%}%> 	  	  
		</td>
        </tr>
        <%
  }
  rsUp.close();
  db.close();
  
  }// end of if
  %>
  </table>
	 <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(UPM_CD,APP_ID){
var urlpar='AppUplodadByAgencyOffline.jsp?UPM_CD='+UPM_CD+'&APP_ID='+APP_ID;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Upload Document',null,callbackFunctionArray);
 }//END OF FUNCTION
 
 function ShowNewPageDel(UP_ID,APP_ID){
var urlpar='upload_app_doc_delbyAgencyoffline.jsp?UP_ID='+UP_ID+'&APP_ID='+APP_ID;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Upload Document',null,callbackFunctionArray);
 }//E
 
 function ShowNewPageView(VDOC){
var urlpar='doctransfertoNas.jsp?docname='+VDOC;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Upload Document',null,callbackFunctionArray);
 }//END OF FUNCTION
 
function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}
function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refresh_data(){
form.submit();
}

</script>
</form>
</body>
</html>