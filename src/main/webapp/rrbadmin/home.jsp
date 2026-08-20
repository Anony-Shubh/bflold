   <%@ include file="AppIncludePage.jsp" %>
	<html>
<head>

<script type="text/javascript" src="../js/ModalPopupWindow.js"></script> </head>
   <body>
 
<form name="form" id="form" action="" class="form" method="post">  

<div id = "view"  >
<%
DBCon db= new DBCon();
db.connect();
//String STATE_CD= request.getParameter("STATE_CD")==null?"0":request.getParameter("STATE_CD");
//String OFF_TYPE_CD= request.getParameter("OFF_TYPE_CD")==null?"0":request.getParameter("OFF_TYPE_CD");

StringBuffer qrysb = new StringBuffer();
qrysb.append("  SELECT BANK_NAME,COUNT(IFSC_CODE) AS NO_OF_MAINBR,MAX(IFSC_CODE) AS IFSC_CODEMAX FROM RBIBANKLIST" );
qrysb.append("  GROUP BY BANK_NAME  HAVING COUNT(IFSC_CODE)=1 ORDER BY BANK_NAME" );

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
                <th>No of Branches </th>
                <th>IFSC_CODE</th> 				
				<th>UPDATE / ADD BRANCH </th>
                
            </tr>
        </thead>
        <tfoot>
            <tr>
              <th>SR NO </th>
                <th>BANK NAME</th>               
                <th>No of Branches </th>
                <th>IFSC_CODE</th> 				
				<th>UPDATE / ADD BRANCH </th>
            </tr>
        </tfoot>
		        <tbody>
				
				
                
            
       <% 
	  
	  String BANK_NAME= ""; 
	  String IFSC_CODE= "";
	  String NO_OF_MAINBR="";
	  int srno=0;
	  
	  while (rsMain.next()){
	 
	  BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
	  IFSC_CODE =rsMain.getString("IFSC_CODEMAX")==null?"":rsMain.getString("IFSC_CODEMAX");
	  NO_OF_MAINBR=rsMain.getString("NO_OF_MAINBR")==null?"":rsMain.getString("NO_OF_MAINBR");
	  srno=srno+1;
	 
	   %>
      <tr>
                <td><%=srno %></td>                
                <td><%=BANK_NAME %></td>	
                <td><%=NO_OF_MAINBR  %></td>
                <td><%=IFSC_CODE  %></td>				
                <td><a href="bank_List.jsp?BANK_NAME=<%=BANK_NAME %>&MAINIFSC=<%= IFSC_CODE %>" class="button">ADD/UPDATE</a></td>
               
			   
			   <!--<td><div align="center">	
			<input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%=BANK_NAME %>','<%=IFSC_CODE  %>','RRB.jsp');"  value="ADD/UPDATE " />
	           
        </div></td>-->
                
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
function ShowNewPage(vbank_nm,vifsc_code,filename){
var urlpar=filename+'?BANK_NAME='+vbank_nm+'&IFSC_CODE='+vifsc_code;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);

 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
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
