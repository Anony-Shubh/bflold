
<script type="text/javascript">
function Popup(url, title, w, h) {
// Fixes dual-screen position Most browsers Firefox
var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

var left = ((width / 2) - (w / 2)) + dualScreenLeft;
var top = ((height / 2) - (h / 2)) + dualScreenTop;
var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

// Puts focus on the newWindow
if (window.focus) {
newWindow.focus();
}
}
</script>

<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<body>

<form method="post" action="upload_app_doc.jsp" name="form" id="form" >

	    <%
		String vDOC_NAME="";
		String APP_ID="";
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		 session.setAttribute("sAPP_ID",APP_ID);
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

		


        //  String docStr="SELECT UPM_CD,DOC_DESC FROM APP_UPLOAD_MAST WHERE USR_TYPE='I' AND ACT_YN='Y'";
		  
		  //  ResultSet rsDoc = db.execSQL(docStr);

     
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </th>
        </tr>
        <tr>
          <th colspan="2" nowrap>ID:</th>
          <th nowrap>-</th>
          <th nowrap>Aadhaar No: </th>
          <th nowrap>&nbsp;</th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Name:</th>
          <th nowrap>&nbsp;</th>
          <th nowrap>PAN No. </th>
          <th nowrap>&nbsp;</th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Category: </th>
          <th nowrap>&nbsp;</th>
          <th nowrap>Special Category : </th>
          <th nowrap>&nbsp;</th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Education:</th>
          <th nowrap>&nbsp;</th>
          <th nowrap>Unit Location: </th>
          <th nowrap>&nbsp;</th>
        </tr>
        <tr>
          <th colspan="2" nowrap>EDP Training: </th>
          <th colspan="3" nowrap>&nbsp;</th>
        </tr>
        <tr>
          <td colspan="5" nowrap class="redLebel"><div align="center">Upload all valid  Documents </div></td>
        </tr>
        <tr>
          <th nowrap>SrNo</th>
          <th nowrap>Document Desc </th>
          <th nowrap>Remarks</th>
          <th nowrap>View</th>
          <th nowrap>delete</th>
        </tr>
      
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td><input type="button" name="button" id="button" value="View" onClick="viewdocument('<%= vDOC_NAME %>');">
		<!--  <a href="doctransfertoNas.jsp?docname=<%//= vDOC_NAME %>" class="greenButtonRound"  onClick="javascript:Popup(this.href, 'View Document', 800, 350);return (false);">view </a>  --><a href="upload_app_doc_puf.jsp?UPM_CD=<%= UPM_CD %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a></td>
          <td><a href="upload_app_doc_del.jsp?UP_ID=<%= UP_ID %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
		 
		  Data Lock		</td>
        </tr>
 
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

  function HideModalWindow() {
  modalWin.HideModalPopUp();
}

function refreshpage() {
  location.reload();
}

</SCRIPT>

</body>
</html>