<%@ page session="true"%>  
	<html>
<head>

<script type="text/javascript" src="../js/ModalPopupWindow.js"></script> </head>
   <body>
 
<form name="form" id="form" action="" class="form" method="post">  

<img src="../images/pmegponline.jpg" width="100%" height="150">

 <%@ include file="AppIncludePage.jsp" %>

<p></p>
<p></p>
<p></p>
<p></p>


	</br></br>

	
	</br></br></br></br>
 
			 
  <table class="pmegpTable"><br>
<tr>

<th>
 <center> <h2>For Technical issues contact email: pmegpeportal.kvic@gov.in and PMEGP Scheme related queries contact email: pmegpeportal.kvic@gov.in</h2>
 </center>
  </th>
  </tr>
  </table>
</div>  
 <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
function ShowNewPage(vbank_id,vifsc_code,filename){
var urlpar=filename+'?BANK_ID='+vbank_id+'&IFSC_CODE='+vifsc_code;;
  var callbackFunctionArray = new Array(refresh_data);
 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//end of bank

function addNewBranch(vbank_id,filename){
var urlpar=filename+'?BANK_ID='+vbank_id;
 var callbackFunctionArray = new Array(refresh_data);
 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//en

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
