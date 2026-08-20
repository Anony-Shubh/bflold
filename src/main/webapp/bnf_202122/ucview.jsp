<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<HTML><HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   

<script language="javascript" src="js/jquery-1.12.4.js"></script>
<script language="javascript" src="js/ModalPopupWindow.js"></script>
	
	</HEAD>
	<link rel="stylesheet" type="text/css" href="itview.css">
	<script>
var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 
	
 
 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function EnrollLater(){
modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}

function refreshpage(){
window.parent.location.reload();
}
</script>
<script>
function ShowReport(off_cd){
 modalWin.ShowURL('genrep.jsp?REP_NM=IT_INFR_FO1&off_cd='+off_cd,900,1200,'it Ifrastructure',null,null);
 } 
 
</script>


<body>
<div class="pmegp_logo">
		<div class="container-fluid">
			<img src="images/pmegp banner.jpg"style="margin: 10px auto; width: 100%;">		
		</div>
	</div>
<th></div>
<table align="center"  style="width:100%" id="container" >
<th><center>
  <h1>Uc for the year 2021-22</h1>
  </center></th></table>
    
<TABLE id="example"  style="width:100%" border="1">
            <THEAD>
                <tr>
				
                  <th><DIV align="center"><h3>OFFICE CODE:</h3></DIV></th>
				  
                  <th><DIV align="center"><h3>OFFICE NAME</h3></DIV>    </th>
				   
				  
				   
				  
				   <th><DIV align="center"> <h3>Add/Update</h3>
				   </DIV> </th>
				    <th><DIV align="center">
				      <h3>Uc Report</h3>
				    </DIV></th>
					 <th><DIV align="center"><h3>Upload Signed Uc</h3></DIV></th>
					  <th><DIV align="center"><h3>Forward Uc to HO</h3></DIV></th>
					  
				               
				  
				
                    
    </tr>
            </THEAD>

            <TBODY>
   <%
 //String app_id=(String) session.getAttribute("Sapp_id");
String off_cd="";
String off_name = "";
String ITINF_ID="";
String IT_REQ_YEAR="";



     DBCon db= new DBCon();
      db.connect(); 


 StringBuffer qrysb = new StringBuffer();

 

qrysb.append(" select ir.IT_REQ_YEAR,ir.ITINF_ID,iu.off_cd,iu.off_name from itinf_usermast iu, it_inf_req ir where iu.off_cd=ir.off_cd(+) ");
qrysb.append(" and iu.off_cd=165 ");
	
  
	  
	   ResultSet rsMain=db.execSQL(qrysb.toString());
	   
//String BEN_CD = "";
//String ben_nm = "";
//String ben_city = "";
  while(rsMain.next())
  {
off_cd=rsMain.getString("off_cd")==null?"":rsMain.getString("off_cd");
off_name=rsMain.getString("off_name")==null?"":rsMain.getString("off_name");
ITINF_ID=rsMain.getString("ITINF_ID")==null?"":rsMain.getString("ITINF_ID");









%>
             <tr> 
			 <%--<td><DIV align="center" ><%//=ITINF_ID %></DIV></td>--%>
                   <td><DIV align="center" ><%=off_cd %></DIV></td>

				 <td><DIV align="center"><%=off_name %></DIV></td>
				  
				     
				 
				 <td><DIV align="center" ><a href="bnf_uc.jsp" class="button"  value="Add/Update">Add Update</a>
				</DIV></td>
                 
	<td><div align="center"><INPUT type="button" class="button" value="View Report"  onClick=""></div></td>
	<td><div align="center"><INPUT type="button" class="button" value="Upload Signed Uc"  onClick=""></div></td>
	<td><div align="center"><INPUT type="button" class="button" value="Forward To HO"  onClick=""></div></td>
					
			
               
				   
 
         
		      </tr>  
			  
            </TBODY>
      </TABLE>

</body>
		
		</HTML>

 <%
  }
  rsMain.close();
  db.close();
  %>

