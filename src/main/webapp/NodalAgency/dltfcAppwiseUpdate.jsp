
<html>
<head>


<script language="javascript">
$(document).ready(function() {
    $('#btnFind').click(function() {
        $('#view').show();
    });
});

</script>
</head>

<body>
<form name="form" id="form" class="form" method="post">
<%@ include file="includeHeaderPageDLTFC.jsp" %>  <% 
  
  String U_COUNT=(String) session.getAttribute("sUC")==null?"0":(String)session.getAttribute("sUC");
	
		try {
if (U_COUNT.equals("0")){
//response.sendRedirect("Msg.jsp");
}
	}catch (Exception m) {}		
	

 
 	  String txtSearch="";
	  String str= "";
 String APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");;
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
if (request.getParameter("txtSearch") != null || txtSearch !=""){
			txtSearch ="%"+(String) request.getParameter("txtSearch")+"%";
			txt=(String)request.getParameter("txtSearch");
			}else{
			txtSearch ="%%";
			txt="";
			}
ResultSet  rs;
 
 int count=0;
 String vOffcd= (String) session.getAttribute("sOffCd");
 String vWherecls="";
 
 out.print(vOffcd);
 
 String DLTFC_PROC_DT="";
 String qryE="";
 String EDP_CERT_DTS=""; 
 
 
 
List values=new ArrayList();
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  
if(!SLOGINTYPE.equals("Y")){

	qrysb.append("   SELECT ad.APP_ID,'' AS INT_TIME,ad.ACT_YN,"      );
qrysb.append("     UPPER(ad.APP_NAME) AS APP_NAME,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     TO_CHAR(ad.APP_REC_DATE, 'DD-MON-RRRR') AS APP_REC_DATE,"      );
qrysb.append("     ad.ACT_ID,"      );
qrysb.append("     TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') AS ONLINE_SUBDT, TO_CHAR(ad.DLTFC_PROC_DT, 'DD-MON-RRRR') AS DLTFC_PROC_DT,"      );
qrysb.append("     asm.ACT_DESC"      );
qrysb.append("   FROM APP_DETAIL ad,"      );
qrysb.append("     app_status_mast asm,"      );
qrysb.append("     M_DISTRICT MD"      );
qrysb.append("   WHERE ad.ACT_ID     = asm.ACT_ID "      );
qrysb.append("   AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND AD.OFF_CD=? AND AD.ACT_ID in (2)ORDER BY ad.ONLINE_SUBDT DESC"      );
values.add(vOffcd);
} 
else {
	
	qrysb.append("   SELECT ad.APP_ID,'' AS INT_TIME,ad.ACT_YN,"      );
qrysb.append("     UPPER(ad.APP_NAME) AS APP_NAME,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     TO_CHAR(ad.APP_REC_DATE, 'DD-MON-RRRR') AS APP_REC_DATE,"      );
qrysb.append("     ad.ACT_ID,"      );
qrysb.append("     TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') AS ONLINE_SUBDT, TO_CHAR(ad.DLTFC_PROC_DT, 'DD-MON-RRRR') AS DLTFC_PROC_DT,"      );
qrysb.append("     asm.ACT_DESC"      );
qrysb.append("   FROM APP_DETAIL ad,"      );
qrysb.append("     app_status_mast asm,"      );
qrysb.append("     M_DISTRICT MD"      );
qrysb.append("   WHERE ad.ACT_ID     = asm.ACT_ID "      );
qrysb.append("   AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND AD.OFF_CD IN (SELECT OFF_CD  FROM MAS_OFF_MAST WHERE OFF_TYPE_CD IN (2,3) AND ACT_YN='Y' AND MIS_OFF_CD=(select mis_off_cd from mas_off_mast where off_cd=?)) AND AD.ACT_ID in (2)ORDER BY ad.ONLINE_SUBDT DESC"      );
	
	values.add(vOffcd);
}

  //out.print(qrysb.toString());
 
  
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
   


 
 %>
 
 <br/><br/>
 <table align="center" class="pmegpTable">
   
   
    <tr>
      <th colspan="9"><div align="right">Enter Applicant ID or  Applicant Name:</div></th>
      <th><input name="txtSearch" type="text"  id="txtSearch" size="25" maxlength="25" value="<%= txt %>"></th>
      <th><input name="btnSearch" type="submit" class="button" id="btnSearch"  onClick="strFind()" value="Search Applicant"></th>
    
    </tr>
</table>
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>         
      
	  <th><div align="center">ID</div></th>
	  <th><div align="center">NAME</div></th>	  
	  <th><div align="center">DATE OF SUBMISSION</div></th> 
	   <th><div align="center">FORM</div></th> 
	  <th><div align="center">DOCUMENTS</div></th>
	  <th><div align="center">SCORE CARD</div></th>
	   <th><div align="center">CURRENT STATUS</div></th>
	  	  	 <th><div align="center">APPLICANT STATUS</div></th>
	  
    </tr>
	
	</thead>
	<%

	String param="";
	while (rs.next()){
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
	param="APP_ID="+APP_ID;
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
	INT_TIME=rs.getString("INT_TIME")==null?"":rs.getString("INT_TIME");
	APP_REC_DATE=rs.getString("APP_REC_DATE")==null?"":rs.getString("APP_REC_DATE");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	ONLINE_SUBDT=rs.getString("ONLINE_SUBDT")==null?"":rs.getString("ONLINE_SUBDT");
	ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
    ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
	ACT_YN=rs.getString("ACT_YN")==null?"":rs.getString("ACT_YN");
	DLTFC_PROC_DT=rs.getString("DLTFC_PROC_DT")==null?"":rs.getString("DLTFC_PROC_DT");
	count=count+1;
	
	
	 qryE="SELECT EDP_CERT_DT FROM EDP_CONDUCT_TRANS BD WHERE APP_ID='"+APP_ID+"' ";
       ResultSet rsE = db.execSQL(qryE);
	   while(rsE.next()){ 
	   EDP_CERT_DTS=rsE.getString("EDP_CERT_DT")==null?"":rsE.getString("EDP_CERT_DT");
	   }
	

	 %>

	<tr>
	 <td > <%= count %></td>
      <td  > <%=APP_ID %></td>
     
      <td  ><%=APP_NAME%><br>
      <br></td>
      <td  >
      <%=ONLINE_SUBDT %></td>
      <td  > <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage1('<%= APP_ID %>','../jsp/PMEGPGenAppForm.jsp');"  value="View" />
	  
	  <!--<a href="../jsp/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="button">View</a>-->
	  
	  </td>
      <td  >
	  
	   <div align="center">
	    <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage1('<%= APP_ID %>','../jsp/app_upload_view.jsp');"  value="View" />
	  <!-- <a href="javascript: mypopup('../jsp/app_upload_view.jsp','<%= param %>','1000','490');" class="greenButtonRound">View  </a> -->

       </div>	</td>
     
      <td  ><a href="pmegpscorecardAgency.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Score Card </a></td>
   
    
      <td  ><%=ACT_DESC %></td>
      <td   >
	    <div align="center">
	      <% if (ACT_ID.equals("4")) { %>		  
	      Approved to be Forwarded to Bank		
		<% } else if (ACT_ID.equals("7"))  { %>
		 <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage1('<%= APP_ID %>','StatusDltfcRejDetail.jsp');"  value="Return To The Applicant Detail" />
		<!-- <a href="javascript: mypopup('StatusDltfcRejDetail.jsp','<%= param %>','1000','490');" class="greenButtonRound">Return Detail </a>-->
		 <!--<a href="StatusDltfcRejDetail.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Rejection Detail</a>	-->	
		 <% }else { %>
		  <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage1('<%= APP_ID %>','StatusUpdateByConvenor.jsp');"  value="Update" />
	        <!--  <a href="javascript: mypopup('StatusUpdateByConvenor.jsp','<%= param %>','1000','490');" class="greenButtonRound">Update </a>-->
          <%}%>
        </div></td>
    </tr>
	
	
		 
		<%
	}
	  rs.close();
   db.close();
	 
	
	%>	
	
	
	
</table>
</div>
<script language="javascript">
var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
function ShowNewPage(voffcd,filename){
var urlpar=filename+'?GR_ID='+voffcd;
 var callbackFunctionArray = new Array(null, null);

 modalWin.ShowURL(urlpar,600,1000,'View Application',callbackFunctionArray,null);
 }
 
 function ShowNewPage1(vactid,filename){
var urlpar=filename+'?APP_ID='+vactid;
 var callbackFunctionArray = new Array(null, null);

 modalWin.ShowURL(urlpar,600,1000,'View Contact Details',callbackFunctionArray,null);
 }///end of bank



function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}

function viewAppDocument(APP_ID){
var urlpar='../jsp/app_upload_view.jsp?&APP_ID='+APP_ID;
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }

function viewApp(APP_ID){

var urlpar='../jasperrop/PMEGPGenAppFormD.jsp?APP_ID='+APP_ID+'&RNAME=APPSTATUSVIEWD';
 modalWin.ShowURL(urlpar,600,1100,'Applicant Data View.',null,null);
 }

   </script>
</form>
</body>
</html>
