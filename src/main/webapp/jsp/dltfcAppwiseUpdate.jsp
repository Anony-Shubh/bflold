<%@ include file="includeHeaderPageDLTFC.jsp" %>
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<form  method="post" name="form">
  
      <% 
	  String txtSearch="";
	  String str= "";
      String txt="";
	  String VMTG_ID=request.getParameter("MTG_ID")==null?"0":(String) request.getParameter("MTG_ID");
	  
	  String wMTGcls=VMTG_ID.equals("0")?" ": " AND A.MTG_ID ="+VMTG_ID;
	  
	  
  
if (request.getParameter("txtSearch") != null || txtSearch !=""){
			txtSearch ="%"+(String) request.getParameter("txtSearch")+"%";
			txt=(String)request.getParameter("txtSearch");
			}else{
			txtSearch ="%%";
			}
			

 int count=0;
 String OFF_CD= (String) session.getAttribute("sOffCd");
 
  		
	DBCon db= new DBCon();
db.connect();
   
    StringBuffer qrysb= new StringBuffer();
	
 	qrysb.append("   SELECT A.MTG_ID,"      );
qrysb.append("   to_Char(A.MT_DATE,'dd-mon-yyyy') as MT_DATE,"      );
qrysb.append("  to_Char(AD.ONLINE_SUBDT,'dd-mon-yyyy') as ONLINE_SUBDT, "      );
qrysb.append("  to_Char(AD.FORD_DT_DLTFC,'dd-mon-yyyy') as FORD_DT_DLTFC, "      );
qrysb.append("   AD.APP_ID,AD.ACT_ID, "      );
qrysb.append("   AD.APP_NAME,"      );
qrysb.append("   B.DISTRICT_NAME AS UNIT_DIST,"      );
qrysb.append("   A.MTG_PLACE,"      );
qrysb.append("   B.DISTRICT_NAME AS MTG_DIST,"      );
qrysb.append("   ASM.ACT_DESC"      );
qrysb.append("   FROM APP_MEETING_MAST A,M_DISTRICT B,APP_DETAIL AD,"      );
qrysb.append("   APP_STATUS_MAST ASM, M_DISTRICT UMD"      );
qrysb.append("   WHERE A.DISTRICT_CD=B.DISTRICT_CD AND A.OFF_CD=?"      );
qrysb.append("   AND A.MTG_ID=AD.MTG_ID  AND  "      );
qrysb.append("   UPPER(ad.APP_ID||' '||TRIM(ad.APP_NAME) ) LIKE TRIM(UPPER(?)) "+wMTGcls+" "   );
qrysb.append("   AND AD.ACT_ID=ASM.ACT_ID"      );
qrysb.append("   AND AD.UNIT_DIST_CD=UMD.DISTRICT_CD"      );
qrysb.append("   ORDER BY A.MT_DATE DESC "      );

	
	List values = new ArrayList();
	values.add(OFF_CD);
	values.add(txtSearch);
   ResultSet rs = db.executeSQL(qrysb.toString(),values);
   values.clear();

    %>
  <table align="center" class="pmegpTable">
   
    <tr>
      <td colspan="10"><div align="center">Applicant ID/Name Wise Search Form </div></td>
    </tr>
    <tr>
      <td colspan="6"><div align="right">Enter Applicant ID or  Applicant Name:</div></td>
      <td colspan="3"><input name="txtSearch" type="text"  id="txtSearch" size="25" maxlength="15" value="<%= txt %>"></td>
      <td ><input name="OK" type="submit" class="button" id="OK"  onClick="strFind()" value="SEARCH"></td>
    </tr>
    <tr>
      <td>Srno
      <input type="hidden" name="MTG_ID" value="<%= VMTG_ID %>" /></td>
      <td>ID
      <td>Name </td>
      <td>Forwarding Date to DLTFC </td>
      <td>Meeting Date</td>
      <td>Meeting Place &amp; District </td>
      <td>Current Status </td>
      <td><div align="center">view</div></td>
      <td>Update</td>
      <td >Update Status </td>
    </tr>
    <%
	String APP_REC_DATE="";
	String  ONLINE_SUBDT="";
	String MTG_ID = "";
	String MT_DATE = "";
	String FORD_DT_DLTFC = "";
	String APP_NAME = "";
	String UNIT_DIST = "";
	String MTG_PLACE = "";
	String MTG_DIST = "";
	String ACT_DESC = "";
	String ACT_ID ="";
 String APP_ID="";
	while (rs.next()){
	
	 count=count+1;
	 
	 
	MTG_ID=rs.getString("MTG_ID")==null?"":rs.getString("MTG_ID");
MT_DATE=rs.getString("MT_DATE")==null?"":rs.getString("MT_DATE");
ONLINE_SUBDT=rs.getString("ONLINE_SUBDT")==null?"":rs.getString("ONLINE_SUBDT");
FORD_DT_DLTFC=rs.getString("FORD_DT_DLTFC")==null?"":rs.getString("FORD_DT_DLTFC");
APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
UNIT_DIST=rs.getString("UNIT_DIST")==null?"":rs.getString("UNIT_DIST");
MTG_PLACE=rs.getString("MTG_PLACE")==null?"":rs.getString("MTG_PLACE");
MTG_DIST=rs.getString("MTG_DIST")==null?"":rs.getString("MTG_DIST");
ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	 %>
    <tr  >
      <td >          <%= count %></td>
      <td  > <%=APP_ID%></td>
      <td  ><%=APP_NAME%><br>
          <%=UNIT_DIST %><br></td>
      <td  ><%= rs.getString("FORD_DT_DLTFC") %></td>
      <td  ><%=MT_DATE %></td>
      <td  ><%=MTG_PLACE %>, Dist: <%=MTG_DIST %></td>
      <td  ><%=ACT_DESC %></td>
      <td  > <input name="btnDltfc" type="button" class="button"  onClick=" viewUploadPage('<%= APP_ID %>');return(false);" value="Documents"></td>
	  
      <td  >
	 <%  if(!ACT_ID.equals("5")) {%>
	  <a href="appUpdatebyDltfc.jsp?APP_ID=<%= APP_ID %>">Applicant Data</a> 
	 <%  }else{
	 out.print (ACT_DESC);
	 }
	  %>	  </td>
      <td  >
	  <%  if(!ACT_ID.equals("5")) {%>
	  <input name="btnDltfc2" type="button" class="button"  onclick="ShowNewPage('<%= APP_ID %>');return(false);" value="Status Update" />
    <% 
	    }else{
	 out.print (ACT_DESC);
	 }
	    %>    </tr>
	 
	 <%
	 }
	  rs.close();
   db.close();
	 
	 %>
  </table> 
  
   <script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(APP_ID){
var urlpar='StatusUpdateByConvenor.jsp?&APP_ID='+APP_ID;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1100,'Dltfc form Update',null,callbackFunctionArray);
 }//END OF FUNCTION
 
 function viewUploadPage(APP_ID){
var urlpar='app_upload_view.jsp?&APP_ID='+APP_ID;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1100,'Dltfc form Update',null,callbackFunctionArray);
 }//END O
 

function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}
function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

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
