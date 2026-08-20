<%@ include file="AppIncludePage.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>

</head>
<body>
<form name="form" id="form"  method="post">
<%

//String vOffcd =(String) session.getAttribute("sOffCd");
%>

<TABLE align="center" class="pmegpTable">
   
    <TR>
      <TD colspan="19"><DIV align="center">Admin Module</DIV></TD>
    </TR>
    
  </TABLE>
  <div align="center"><br>
    <br>
    <input type="button"    class="buttonBlue" value="Upload" onClick="viewdocument2('0');">
  </div>
  <table align="center" cellspacing="0" class="display" id="example">
        <thead>
             <TR>
      <TH nowrap>Srno</TH>
       <TH nowrap>State</TH>
	    <TH nowrap>Date</TH>
		 <TH nowrap>Remarks</TH>
      <TH nowrap>View</TH>     
       <TH nowrap>Delete</TH> 
      
	    
</TR>
        </THEAD>
				        <tbody>
	 <% 
	  

String DOC_NAME =request.getParameter("APP_ID");
String ACT_YN="";
String STATE_NM = "";
String STATE_CD = "";
String EN_ID="";

 
  
ResultSet  rs;
 
 int count=0;
 String vOffcd= (String) session.getAttribute("off_cd");

 String qryE="";

 
 
 
	//out.print(vOffcd);
DBCon db= new DBCon();
db.connect();
String DOC_REMARK="";
 
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("   SELECT GD.EN_ID,GD.DOC_NAME,GD.DOC_REMARK,GD.ACT_YN,TO_CHAR(UPLOAD_TIMESTAMP,'DD-MON-RRRR') AS UPLOAD_TIMESTAMP,MS.STATE_NM,MS.STATE_CD from GEOENUM_DETAIL GD,M_STATE MS WHERE MS.STATE_CD=GD.STATE_CD AND GD.ACT_YN='Y' "      );


String UPLOAD="";


List values=new ArrayList();


   rs = db.execSQL(qrysb.toString());
  
  
  String param="";
	while (rs.next()){
	
	EN_ID=rs.getString("EN_ID")==null?"":rs.getString("EN_ID");	
	DOC_NAME=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");	
	ACT_YN=rs.getString("ACT_YN")==null?"":rs.getString("ACT_YN");
	STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
	STATE_CD=rs.getString("STATE_CD")==null?"":rs.getString("STATE_CD");
	UPLOAD=rs.getString("UPLOAD_TIMESTAMP")==null?"":rs.getString("UPLOAD_TIMESTAMP");
	DOC_REMARK=rs.getString("DOC_REMARK")==null?"":rs.getString("DOC_REMARK");
	count=count+1;

   
    %>
         <tr>
              <TD> <DIV align="center"><%= count %></DIV></TD>
      <TD><DIV align="center">
	   <%=STATE_NM %> 
	   </DIV></TD>
	   <TD><DIV align="center">
	   <%=UPLOAD %> 
	   </DIV></TD>
	   <TD><DIV align="center">
	   <%=DOC_REMARK %> 
	   </DIV></TD>
      <TD> <DIV align="center">
 <input type="button" name="button" class="buttonGreen" value="View" onClick="GTview('<%= DOC_NAME %>');">
	  
	 </DIV>
	  
	   	  
	  </TD>
     
    
      <TD> <DIV align="center"> <input type="button" name="button" class="buttonMerun" value="Delete" onClick="Del('<%= EN_ID %>');">
	   </DIV>
	  </TD>
    
     
                  </tr>
			<%
			}
			
	  rs.close();
			db.close();
			
			%>
            
        </tbody>
</table>
  
    
    <script>
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#example tfoot th').each( function () {
        var title = $(this).text();
       // $(this).html( '<input type="text" placeholder="'+title+'" />' );
    } );
 
    // DataTable
    var table = $('#example').DataTable();
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            if ( that.search() !== this.value ) {
                that
                    .search( this.value )
                    .draw();
            }
        } );
    } );
} );



 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 function viewdocument2(ENID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("upload.jsp?EN_ID="+ENID,500,550,'Status',null,null);
 }//end of bank
 
  function Del(ENID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("delUpload.jsp?EN_ID="+ENID,400,500,'Status',null,null);
 }//

function refreshpage() {
  location.reload();
}

function GTview(DOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("docViewEn.jsp?DOC_NAME="+DOC_NAME,720,1350,'Status',null,null);
 }
fun

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}
  </script>
    </p>

</form>
</body>
	</html>