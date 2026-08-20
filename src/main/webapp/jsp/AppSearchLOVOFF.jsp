<%@ include file="includeHeaderPage.jsp" %>
<style type="text/css">
<!--
.style2 {color: #FF0000; font-weight: bold; }
.style3 {color: #0000FF}
-->
</style>

<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<form  method="post" name="form">
  
      <% 
	  String txtSearch="";
	  String str= "";
 String APP_ID =request.getParameter("APP_ID");
String APP_NAME = "";
String DISTRICT_NAME = "";
String INT_TIME = "";
String APP_REC_DATE = "";
String ACT_ID = "";
String ONLINE_SUBDT = "";
String ACT_DESC = "";
String ACT_YN = "";
 String txt="";
  String BANKFOR_YN="";

 

 String vOffcd= (String) session.getAttribute("off_cd");
 
 if (vOffcd != null ) {
 
 if (request.getParameter("txtSearch") != null || txtSearch !=""){
			txtSearch ="%"+(String) request.getParameter("txtSearch")+"%";
			txt=(String)request.getParameter("txtSearch");
			}else{
			txtSearch ="%%";
			txt="";
			}

  int count=0;
 String qryE="";
 String EDP_CERT_DTS=""; 
 
 String BENF_TYPE_CD ="";

    StringBuffer qrysb= new StringBuffer();
	
	qrysb.append("   SELECT ad.APP_ID,ad.ACT_YN,ad.BENF_TYPE_CD,"      );
qrysb.append("     UPPER(ad.APP_NAME) AS APP_NAME,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     TO_CHAR(ad.APP_REC_DATE, 'DD-MON-RRRR') AS APP_REC_DATE,"      );
qrysb.append("     ad.ACT_ID,"      );
qrysb.append("     TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') AS ONLINE_SUBDT,"      );
qrysb.append("     asm.ACT_DESC, "      );
qrysb.append("   (SELECT EDP_CERT_DT FROM EDP_CONDUCT_TRANS BD WHERE APP_ID=ad.app_id) as EDP_CERT_DTS "      );
qrysb.append("   FROM APP_DETAIL_ONLINE ad,"      );
qrysb.append("     app_status_mast asm,"      );
qrysb.append("     M_DISTRICT MD"      );
qrysb.append("   WHERE ad.ACT_ID     = asm.ACT_ID "      );
qrysb.append("   AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND UPPER(ad.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(ad.APP_NAME)) LIKE TRIM(UPPER(?))"      );
qrysb.append("   AND AD.OFF_CD=? and ad.RET_YN='Y'  ORDER BY ad.ONLINE_SUBDT DESC"      );

List values=new ArrayList();
  
  values.add(txtSearch);
  values.add(vOffcd);
  
   DBCon db= new DBCon();
db.connect();
 
 ResultSet  rs = db.executeSQL(qrysb.toString(),values);

   values.clear();
   values.add(vOffcd);

    %>
  <table align="center" class="pmegpTable">
   
    <tr>
      <td colspan="14"><div align="center">Offline Applicantion Status Update</div></td>
    </tr>
    <tr>
	
	
      <td colspan="5"><div align="right">Enter Applicant ID or  Applicant Name:</div></td>
      <td><input name="txtSearch" type="text"  id="txtSearch" size="25" maxlength="25" value="<%= txt %>"></td>
      <td ><input name="btnSearch" type="submit" class="button" id="btnSearch"  onclick="strFind()" value="Search Applicant" /></td>
	  <td colspan="3"><div align="right"><a href="OffAddharValidate.jsp" class="button">Add New Offline Application</a></div></td>
    </tr>
    <tr>
      <td rowspan="2">Srno</td>
      <td rowspan="2">ID
        <input name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>"></td>
     <!-- <td rowspan="2">Change Unit District and Agecny </td>-->
      <td rowspan="2">Name </td>
      <td rowspan="2">Date of Submission </td>
      <td colspan="3"><div align="center">Offline Application </div></td>
     <td rowspan="2" ><div align="center">Applicant Status </div></td>
     
      <td rowspan="2">Current Status</td>
      
    </tr>
    <tr>
      <td><div align="center">Applicant Form </div></td>
      <td><div align="center">Documents</div></td>
      <td><div align="center">Score Card </div></td>
     
     
    </tr>
    <%
	
	String param="";
	while (rs.next()){
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
	param="APP_ID="+APP_ID;
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
	APP_REC_DATE=rs.getString("APP_REC_DATE")==null?"":rs.getString("APP_REC_DATE");
	//INT_TIME=rs.getString("INT_TIME")==null?"":rs.getString("INT_TIME");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	ONLINE_SUBDT=rs.getString("ONLINE_SUBDT")==null?"":rs.getString("ONLINE_SUBDT");
	ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
    ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
	ACT_YN=rs.getString("ACT_YN")==null?"":rs.getString("ACT_YN");
	BENF_TYPE_CD=rs.getString("BENF_TYPE_CD")==null?"":rs.getString("BENF_TYPE_CD");
	EDP_CERT_DTS=rs.getString("EDP_CERT_DTS")==null?"":rs.getString("EDP_CERT_DTS");
	count=count+1;
	
	

	 %>
    <tr  >
      <td > <%= count %></td>
      <td  > <%=APP_ID %></td>
     
      <td  ><%=APP_NAME%><br>
      <br>
      District:<%=DISTRICT_NAME%></td>
      <td  >
      <%=ONLINE_SUBDT %></td>
	   <td  ><div align="center">
	  <% if (ACT_ID.equals("-1")) { %>
	 <a href="appngenupdateoffline.jsp?APP_ID=<%= APP_ID %>&TYPE=1" class="button">Edit</a>
	  <%} else {%>
	Application Final Submitted
	  <%}%>	</div> </td>  
	       <td  ><div align="center">
		    <% if (ACT_ID.equals("-1")) { %>
		   <a href="upload_app_doc_agency_offline.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Upload</a>
			<%} else{%>
		   <a href="javascript: mypopup('app_upload_view_offline.jsp','<%= param %>','1000','490');" class="greenButtonRound">View  </a>
			<%}%>	</div>	   </td>
		   <td  >  
		   <div align="center">
		   <% if (ACT_ID.equals("-1")) { %>
		   <a href="appngenupdateoffline.jsp?APP_ID=<%= APP_ID %>&TYPE=2" class="greenButtonRound">Score Card </a>
		    <%} else {%>
	Application Final Submitted
	  <%}%>	
		   </div>
		   
		   </td>
		   
         
    
   
	
         <td  >
	    <div align="center">
	      <% if (ACT_ID.equals("-1")) { %>
		  
	    <a href="javascript: mypopup('appngenupdateoffline.jsp','<%= param %>','1000','600');" class="greenButtonRound">Final Submit</a>
		<% } else  {%>
		
		<a href="PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="button">View</a>
		<%}%>
        </div></td>

      
   
     
      <td  ><%=ACT_DESC%></td>
   
    </tr>
	
	 
	  
   
		 
		 
	<%	 
	

	
   }// end loop
  

rs.close();
db.close(); 
}
	 %>
  </table> 
</form>
</body>
<script language="javascript">

var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 



function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}

function updateEdp(vAPP_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("AgnEnbEdp.jsp?APP_ID="+vAPP_ID,700,1000,'View Document',null,null);
 }//end of bank

function refreshpage() {
   window.parent.location.reload();
}


function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function refresh_data(){
form.submit();
}

   </script>
</html>
