  <%@include file="includeHeaderPage.jsp"%>

<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>  
</head>

<body>
<form name="form" id="form" class="form" method="post">
  <div align="center">
    <p>
      <% 
  
  String STATE =(String) session.getAttribute("state_cd"); 
  String OFF_TY_CD=(String) session.getAttribute("sOFF_TYPE_CD"); 
  String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":(String)request.getParameter("DISTRICT_CD"); 
  String CITY=request.getParameter("CITY")==null?"":(String)request.getParameter("CITY"); 
  
String OFF_CD = "";  
String OFF_NAME = "";
String CITY1 = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String PINCODE1="";
String OFF_LONG_DESC="";
String OFF_TYPE_SHORT_DESC="";
String vWherecls=""; 

       vWherecls=vWherecls+" AND (MS.STATE_CD ) LIKE  ('"+STATE+"')  ";
   
    if (!CITY.equals("")){
       vWherecls=vWherecls+" AND UPPER(MOM.CITY) LIKE  UPPER('%"+CITY+"%')  ";
   }
   
  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  


qrysb.append(" SELECT MOM.OFF_CD,MOTC.OFF_TYPE_SHORT_DESC, MOM.OFF_LONG_DESC,MOM.OFF_NAME,MOM.CITY,MD.DISTRICT_NAME|| ' , '|| MS.STATE_NM AS DISTRICT_NAME,  " );
qrysb.append(" MD.DISTRICT_CD,MOM.PINCODE,MS.STATE_NM FROM MAS_OFF_MAST MOM,  " );
qrysb.append(" M_DISTRICT MD,M_STATE MS,MAS_OFF_TYPE_CDMAST MOTC WHERE MOM.OFF_TYPE_CD IN (26,17,18)  AND MOM.OFF_TYPE_CD=MOTC.OFF_TYPE_CD " );
qrysb.append(" AND MD.DISTRICT_CD=MOM.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND MOM.ACT_YN='Y'" );
qrysb.append("   "+vWherecls+"  " );
//out.print (qrysb.toString());

 ResultSet rsMain = db.execSQL(qrysb.toString());
// ResultSet rsDist=db.execSQL(" SELECT MD.DISTRICT_CD,MD.DISTRICT_NAME FROM M_DISTRICT MD WHERE MD.DISTRICT_STATUS='A'  ORDER BY DISTRICT_NAME");
 ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");
 %> 
    </p>
    <p><span style="font-weight: bold">Note:Accrediated/Approved EDP Training Centers By KVIC
    </span> </p>
  </div>
  <table align="center" class="bordered">
    <tr>
      <th colspan="5"><div align="center">EDP CENTER VIEW PAGE </div></th>
    </tr>
 
    <tr>
      <td> Search </td>
      <td><input name="CITY" type="CITY" size="20" maxlength="20" value="<%= CITY %>" placeholder="Search City"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
      <td><input name="Submit" type="submit" class="button" id="reset" value="View All"></td>
	 <td><!--<input name="btnBank1" id="btnBank1" type="button" class="button" onClick="ShowNewPage('0','edpaddUpdate.jsp');"  value="ADD NEW " />--></td>
    </tr>
</table>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>
      <th>EDP ID </th>
      <th>Type</th>
      <th>EDP Short Name </th>
      <th><div align="center">Training Center Name </div></th>
      <th><div align="center">CITY</div></th>     
      <th><div align="center">DISTRICT</div></th>
	  <th><div align="center">PINCODE </div></th>
	  <th><div align="center">VIEW DETAIL</div></th>
	
    </tr>
	
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
CITY1=rsMain.getString("CITY")==null?"":rsMain.getString("CITY");
STATE=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
PINCODE1=rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
OFF_LONG_DESC=rsMain.getString("OFF_LONG_DESC")==null?"":rsMain.getString("OFF_LONG_DESC");
OFF_TYPE_SHORT_DESC=rsMain.getString("OFF_TYPE_SHORT_DESC")==null?"":rsMain.getString("OFF_TYPE_SHORT_DESC");
edpcount=edpcount+1;
	
	%>
	<tr>
	  <td><%= edpcount %></td>
      <td><%=OFF_CD  %></td>
      <td><%= OFF_TYPE_SHORT_DESC %></td>
      <td><%=OFF_NAME  %></td>
      <td><div align="left"><%=OFF_LONG_DESC  %></div></td>      
      <td><div align="left"><%=CITY1  %></div></td> 
      <td><div align="left"><%= DISTRICT_NAME %></div></td>		
      <td><div align="left"><%= PINCODE1 %></div></td>	  
	  <td>	
		    <div align="center">
			    <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%= OFF_CD %>','offDetails.jsp');"  value="VIEW DETAILS" />
	               
            </div></td>
	<!-- <td>	
		    <div align="center">
			    <input name="btnBank2" type="button" class="button" id="btnBank2" onClick="ShowNewPage('<%= OFF_CD %>','edpaddUpdate.jsp');"  value="UPDATE" />
	               
            </div></td>-->
    </tr>
	<% 
	
	}
rsMain.close();
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
var urlpar=filename+'?OFF_CD='+voffcd;
var callbackFunctionArray = new Array(refreshpage);

 modalWin.ShowURL(urlpar,600,1000,'Add Update EDP Center by SO',callbackFunctionArray,null);
 }//end of bank



function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}


   </script>
</form>
</body>
</html>
