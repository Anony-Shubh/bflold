  
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

	
    <center>
</p>
<div id = "view"  >
<%
DBCon db= new DBCon();
db.connect();


StringBuffer qrysb = new StringBuffer();
qrysb.append("  SELECT BANK_ID,USER_DESC,IFSL_CODE FROM BU_USERMAST" );
ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<p></p>
<p></p>
<p></p>
<p></p>


<br/>
<input name="ins" type="hidden" id="ins" value="">
<br/>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
              <th>SR NO </th>  
                <th>BANK NAME</th>			  
                 <th>IFSC_CODE</th> 
					
				      <th><input name="btnBank3" type="button" class="button" id="btnBank3" onClick="addNewBranch('0','addUpdateBankDetail.jsp' );"  value="ADD NEW BRANCH" /></th>
                
            </tr>
        </thead>
        <tfoot>
            <tr>
              <th>SR NO </th>  
                <th>BANK NAME</th>			  
                 <th>IFSC_CODE</th> 
				      <th>UPDATE </th>
            </tr>
        </tfoot>
		        <tbody>
				
				
                
            
       <% 
	  
	  String BANK_NAME= ""; 
	  String IFSC_CODE= "";	
	  String BANK_ID="";
	  int srno=0;
	  
	  while (rsMain.next()){
	 
	  BANK_NAME=rsMain.getString("USER_DESC")==null?"":rsMain.getString("USER_DESC");
	  IFSC_CODE =rsMain.getString("IFSL_CODE")==null?"":rsMain.getString("IFSL_CODE");
	  BANK_ID=rsMain.getString("BANK_ID")==null?"":rsMain.getString("BANK_ID");
	  srno=srno+1;
	 
	   %>
      <tr>
                <td><div align="center"><%=srno %></div></td>                
                <td><div align="center"><%=BANK_NAME %></div></td>	               
                <td><div align="center"><%=IFSC_CODE  %></div></td>				
                <td><div align="center"><input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%=BANK_ID %>','<%=IFSC_CODE %>','addUpdateBankDetail.jsp');" value="UPDATE" /></td>    
			   
			   
                
            </tr>
			<%
			}
			rsMain.close();
			db.close();
			%>
            
        </tbody>
    </table>
</div>

  <p>&nbsp;</p>
  <p>&nbsp;</p>
 
			 
  <table class="pmegpTable"><br>
<tr>

<th>
 <center> <h2>For Technical issues contact email: pmegpeportal@kvic.gov.in and PMEGP Scheme related queries contact email: pmegp@kvic.gov.in</h2>
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
