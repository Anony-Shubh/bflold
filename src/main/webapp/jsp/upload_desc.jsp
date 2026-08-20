<%@ include file="includeHeaderPage.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<body>

<form method="post" action="upload_desc.jsp" name="form" id="form" >

	    <%
		
		String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		 session.setAttribute("sAPP_ID",APP_ID);
		 
		 if (APP_ID !=null) {
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
		String VIEWID="";
		String PMEGPGEOTAGID="";
		
        DBCon db= new DBCon();
        db.connect();

       
		  //  ResultSet rsDoc = db.execSQL(docStr);

           StringBuffer qry = new StringBuffer();
       
	   
	   qry.append("   SELECT AD.APP_NAME,substr(AD.APP_ID,instr(AD.APP_ID,'-')+1,length(AD.APP_ID))  AS VIEWID,GT.PMEGPGEOTAGID,"      );
		qry.append("    BCMCAT.BENF_CATEGORY_DESC AS SOC_CAT ,"      );
		qry.append("     AD.GENDER,AD.ACT_ID,"      );
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
		qry.append("   FROM APP_DETAIL_ONLINE AD, APP_DETAIL AFD, GEOTAG_TRANS GT,"      );
		qry.append("     EDUCATION_MAST EM,"      );
		qry.append("     BENF_CATEGORY_MAST BCMCAT,"      );
		qry.append("     BENF_TYPE_MAST BTM,  "      );
		qry.append("     BENF_CATEGORY_MAST BCMSCAT  "      );
		qry.append("   WHERE AD.EDU_ID              = EM.EDU_ID AND AD.APP_ID=AFD.APP_ID (+) AND AFD.APP_ID=GT.APP_ID   "      );
		qry.append("   AND AD.BENF_TYPE_CD          = BTM.BENF_TYPE_CD"      ); 
		qry.append("   AND AD.BENF_CATAGORY_CD      = BCMCAT.BENF_CATEGORY_CD"      );
		qry.append("   AND BCMSCAT.BENF_CATEGORY_CD = AD.BENF_SPECAT_CD AND AD.APP_ID=?"      );

			 List values=new ArrayList();
				 values.add (APP_ID); 

        ResultSet rsApp =db.executeSQL(qry.toString(),values);
 					 values.clear();	

        while (rsApp.next()){
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
	PMEGPGEOTAGID=rsApp.getString("PMEGPGEOTAGID")==null?"":rsApp.getString("PMEGPGEOTAGID");
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
VIEWID=rsApp.getString("VIEWID")==null?"":rsApp.getString("VIEWID");
        }
			rsApp.close();
			
				StringBuffer qryUp = new StringBuffer();	
			
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM GEOTAG_UPLOAD_TRANS AUT,GEOTAG_UPLOAD_MAST AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD  AND AUT.DOC_ACTYN='Y'  AND  AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM GEOTAG_UPLOAD_MAST AUM WHERE ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM GEOTAG_UPLOAD_TRANS ");
qryUp.append(" WHERE APP_ID=? AND  DOC_ACTYN='Y')) ");
      values.add (APP_ID); 
	  values.add (APP_ID); 
	ResultSet rsUp = db.executeSQL(qryUp.toString(),values);
	values.clear();	
		
        %>
  </p>
	  <table align="center" >
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </th>
        </tr>
        <tr>
          <th colspan="2" nowrap>ID:</th>
          <th nowrap><%=APP_ID%></th>
          <th nowrap>Aadhaar No: </th>
          <th nowrap><%= AADHAR_NO %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Name:</th>
          <th nowrap><%= APP_NAME %>&nbsp;</th>
          <th nowrap>PAN No. </th>
          <th nowrap><%= PAN_NO %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Category: </th>
          <th nowrap><%= SOC_CAT %></th>
          <th nowrap>Special Category : </th>
          <th nowrap><%= SPE_CAT %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Education:</th>
          <th nowrap><%= EDU_DESC %></th>
          <th nowrap>Unit Location: </th>
          <th nowrap><%= UNIT_LOC %></th>
        </tr>
       
        <tr>
          <td colspan="5" nowrap class="redLebel"><div align="center">Upload Additional Document</div></td>
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
           <td><%= srno %></td>
          <td><%= vDOC_DESC %></td>
          <td><%= vDOC_REMARKS %></td>
          <td>
		  <% if (UP_ID.equals("0")) {%>
		   <DIV align="center"><A onClick="GTUPLOAD2('<%= APP_ID %>','<%= PMEGPGEOTAGID %>','<%=  APP_NAME %>','<%=  UPM_CD %>');"  class="greenButtonRound">Upload</A></DIV>
		  
		
			  
		  
		  <% }else{%>
		 <DIV align="center"><A onClick="GTview2('<%= VIEWID %>','<%= vDOC_NAME %>');"  class="greenButtonRound">View</A></DIV>
		  <% } %>
		   </td>
          <td>
		  
		  
		 <% if (!UP_ID.equals("0")) {%>
		 
		  <DIV align="center"><A onClick="GTDEL('<%= APP_ID %>','<%= UP_ID %>','<%=  APP_ID %>');"  class="greenButtonRound">Delete</A></DIV>
		  
		 <%}%>
		</td>
        </tr>
       <% }
  rsUp.close();
  db.close();
  }// end of if
  %>
  
      </table>
	 
</form>
   <SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");


 function viewdocument(vDOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("doctransfertoNas.jsp?docname="+vDOC_NAME,500,800,'View Document',null,null);
 }//end of bank

   function GTUPLOAD2(APP_ID,PMEGPGEOTAGID,APPNAME,UPMCD){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
modalWin.ShowURL("../geoportal/upload_app_oth.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME+"&UPM_CD="+UPMCD,500,600,'Status',null,null);
 }


 function GTDEL(APP_ID,UP_ID,){
var callbackFunctionArray = new Array(refreshpage);
// modalWin.ShowURL("UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME,500,500,'Status',null,null);
modalWin.ShowURL("../geoportal/upload_del.jsp?APP_ID="+APP_ID+"&UP_ID="+UP_ID,500,600,'Status',null,null);
 }


 function GTview2(APP_ID,DOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("../geoportal/otherView.jsp?docname="+DOC_NAME+"&APP_ID="+APP_ID,720,1350,'Status',null,null);
 }
  function HideModalWindow() {
  modalWin.HideModalPopUp();
}

function refreshpage() {
  location.reload();
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}


function refresh_da(){
window.parent.location.reload();
}
</SCRIPT>

</body>
</html>