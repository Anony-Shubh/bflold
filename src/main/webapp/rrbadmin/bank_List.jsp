<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>  
<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="../js/dis.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dis.css">
   </head>
   <body>
 
<form name="form" id="form" action="" class="form" method="post">  

<img src="../images/pmegponline.jpg" width="100%" height="150">

 <%@ include file="AppIncludePage.jsp" %>
	
    <center>
</p>
<div id = "view"  >
<%
DBCon db= new DBCon();
db.connect();
String BANK_NAME= request.getParameter("BANK_NAME")==null?"":request.getParameter("BANK_NAME");
String MAINIFSC= request.getParameter("MAINIFSC")==null?"":request.getParameter("MAINIFSC");

//String OFF_TYPE_CD= request.getParameter("OFF_TYPE_CD")==null?"0":request.getParameter("OFF_TYPE_CD");

StringBuffer qrysb = new StringBuffer();
qrysb.append("  SELECT RRB.BRCODE,RRB.BANK_NAME,RRB.IFSC_CODE,RRB.BRANCHNAME,MS.STATE_NM,RRB.CENTRE,RRB.ADDRESS,RRB.BANK_PINCD " );
qrysb.append("  FROM RBIBANKLIST_RRB RRB,M_STATE MS WHERE MS.STATE_CD=RRB.STATE_CD AND RRB.BANK_NAME='"+BANK_NAME+"' " );

ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<br>
<h1><center>Main Bank Name: <%= BANK_NAME %> (<%= MAINIFSC %>) </h1>
</center>

<br/>
<div align="right">
<input name="btnBank3" type="button" class="button" id="btnBank3" onClick="addNewBranch('<%=MAINIFSC %>','RRB.jsp','<%=BANK_NAME %>');"  value="ADD NEW BRANCH" />
</div>
<input name="ins" type="hidden" id="ins" value="">
<div align="right">
<!--<input name="btnBank2" type="button" class="button" id="btnBank2" onClick="ShowNewPage('0','RRB.jsp');"  value="ADD NEW " />

<input name="btnBank2" type="button" class="button" id="btnBank2" onClick="ShowNewPage('0','VApplication.jsp');"  value="ADD NEW" />-->

</div>
<br/>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
				<th>BR_CODE</th>
				<th>IFSC_CODE</th>
                <th>BRANCH NAME</th> 
				<th>ADDRESS</th> 
				<th>CITY</th> 
				<th>PINCODE</th>    
                <th>STATE</th>
				<th>Edit/Update</th>
                
            </tr>
        </thead>
        <tfoot>
            <tr>
                
                <th>BR_CODE</th>
				<th>IFSC_CODE</th>
                <th>BRANCH NAME</th> 
				<th>ADDRESS</th> 
				<th>CITY</th> 
				<th>PINCODE</th>    
                <th>STATE</th>
                <th>Edit/Update</th>
            </tr>
        </tfoot>
		        <tbody>
				
				
                
            
       <% 
	  String BR_CODE= ""; 	 
	  String BRANCHNAME= ""; 
	  String IFSC_CODE= "";
	  String STATE= "";
	  String CITY= ""; 	 
	  String PINCODE= ""; 
	  String ADDRESS= "";
	  
	  
	  while (rsMain.next()){
	 
	  BR_CODE=rsMain.getString("BRCODE")==null?"":rsMain.getString("BRCODE");	  
	  IFSC_CODE =rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
	  BRANCHNAME =rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
	  STATE=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
	  ADDRESS =rsMain.getString("ADDRESS")==null?"":rsMain.getString("ADDRESS");
	  CITY=rsMain.getString("CENTRE")==null?"":rsMain.getString("CENTRE");
	  PINCODE =rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
	  
	 
	   %>
      <tr>
			
                
                <td><%= BR_CODE%></td>	
				<td><%=IFSC_CODE  %></td>
                <td><%= BRANCHNAME  %></td>	
				 <td><%= ADDRESS%></td>	
				<td><%=CITY  %></td>
                <td><%= PINCODE %></td>	             
				<td><%=STATE%></td>	
               <td><div align="center">	
			<input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%=BR_CODE %>','bank_Update.jsp');"  value="UPDATE DETAILS" />
	           
        </div></td>
                
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
function ShowNewPage(vbank_code,filename){
var urlpar=filename+'?BR_CODE='+vbank_code;
 modalWin.ShowURL(urlpar,600,1000,'View Application',null,null);
 }//end of bank

function addNewBranch(vMAINIFSC,filename,banknm){
var urlpar=filename+'?MAINIFSC='+vMAINIFSC+'&BANK_NAME='+banknm;
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
