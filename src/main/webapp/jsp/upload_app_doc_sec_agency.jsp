<%@ include file="includeHeaderPage.jsp" %>
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<body>
<form method="post" name="form" id="form" >
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		 String vOffcd= (String) session.getAttribute("off_cd");

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

		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		
        DBCon db= new DBCon();
        db.connect();

          String docStr="SELECT UPM_CD,DOC_DESC FROM APP_UPLOAD_MAST_SECOND WHERE USR_TYPE='I' AND ACT_YN='Y'";
		  
		    ResultSet rsDoc = db.execSQL(docStr);

           StringBuffer qry = new StringBuffer();
       
	   
	   qry.append("   SELECT AD.APP_NAME,"      );	
		qry.append("     AD.GENDER,"      );
		qry.append("     AD.E_MAIL,"      );		
		qry.append("     AD.UNIT_LOC,  "      );
		qry.append("     AD.AADHAR_NO,"      );
		qry.append("     AD.REGD_NO,"      );
		qry.append("     AD.TAN_NO,"      );
		qry.append("     AD.PAN_NO,"      );
		qry.append("     BCMSCAT.BENF_CATEGORY_DESC AS SPE_CAT,"      );
		qry.append("     AD.APP_ID"      );		
		qry.append("   FROM APP_DETAIL_SECOND AD,"      );		
		qry.append("     BENF_CATEGORY_MAST BCMSCAT"      );
		qry.append("   WHERE "      );		
		qry.append("    AD.BENF_SPECAT_CD      = BCMSCAT.BENF_CATEGORY_CD"      );
		qry.append("   AND APP_ID=? AND AD.OFF_CD=?"      );

			 List values=new ArrayList();
				 values.add (APP_ID); 
				  values.add (vOffcd); 

        ResultSet rsApp =db.executeSQL(qry.toString(),values);
 					 values.clear();	

        while (rsApp.next()){
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
//SOC_CAT=rsApp.getString("SOC_CAT")==null?"":rsApp.getString("SOC_CAT");
GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
//EDU_DESC=rsApp.getString("EDU_DESC")==null?"":rsApp.getString("EDU_DESC");
UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
//REGD_NO=rsApp.getString("REGD_NO")==null?"":rsApp.getString("REGD_NO");
//TAN_NO=rsApp.getString("TAN_NO")==null?"":rsApp.getString("TAN_NO");
PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
SPE_CAT=rsApp.getString("SPE_CAT")==null?"":rsApp.getString("SPE_CAT");
//BENF_TYPE_DESC=rsApp.getString("BENF_TYPE_DESC")==null?"":rsApp.getString("BENF_TYPE_DESC");
APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
//FH_NAME=rsApp.getString("FH_NAME")==null?"":rsApp.getString("FH_NAME");
//EDP_YN=	rsApp.getString("EDP_YN")==null?"":rsApp.getString("EDP_YN");	
        }
			rsApp.close();
			
				StringBuffer qryUp = new StringBuffer();	
			
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM APP_UPLOAD_TRANS_SECOND AUT,APP_UPLOAD_MAST_SECOND AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD AND AUM.USR_TYPE='I' AND AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM APP_UPLOAD_MAST_SECOND AUM WHERE  AUM.USR_TYPE='I' AND ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM APP_UPLOAD_TRANS_SECOND ");
qryUp.append(" WHERE APP_ID=?)) ");


//out.print(qryUp.toString());


/*
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
*/
      
	  values.add (APP_ID); 
	  values.add (APP_ID); 
	ResultSet rsUp = db.executeSQL(qryUp.toString(),values);
	values.clear();	
		
        %>
  </p>
	  <table align="center" class="pmegpTable">
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </th>
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
         <th nowrap><div align="right">Unit Location: </div></th>
          <th nowrap><%= UNIT_LOC %></th>
          <th nowrap><div align="right">Special Category : </div></th>
          <th nowrap><%= SPE_CAT %></th>
        </tr>     
        <tr>
          <th colspan="5" nowrap class="redLebel"><div align="center">Note: Project Report May be Submitted at  Financing Branch </div></th>
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
		  
		  
		  <% if (!UP_ID.equals("0")) {%>
		  
		  <input name="btnUploadDel" type="button" class="button"  onClick="ShowNewPageDel('<%= UP_ID %>','<%= APP_ID %>');" value="Delete">
		  
		  
		  </td>
		  <% } %>
		</td>
        </tr>
        <%
  }
  rsUp.close();
  db.close();
  %>
  </table>
	 <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(UPM_CD,APP_ID){
var urlpar='AppUplodadByAgencySec.jsp?UPM_CD='+UPM_CD+'&APP_ID='+APP_ID;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Upload Document',null,callbackFunctionArray);
 }//END OF FUNCTION
 
 function ShowNewPageDel(UP_ID,APP_ID){
var urlpar='upload_app_doc_delbyAgencySec.jsp?UP_ID='+UP_ID+'&APP_ID='+APP_ID;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Upload Document',null,callbackFunctionArray);
 }//E
 
 function ShowNewPageView(VDOC){
var urlpar='docView.jsp?docname='+VDOC;
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