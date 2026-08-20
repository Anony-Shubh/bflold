<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script> 

<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
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
 
  <% 
  
  String STATE =request.getParameter("STATE")==null?"":(String)request.getParameter("STATE"); 
  String ADDRESS=request.getParameter("ADDRESS")==null?"":(String)request.getParameter("ADDRESS"); 
  String AGENCY_TYPE=request.getParameter("AGENCY_TYPE")==null?"":(String)request.getParameter("AGENCY_TYPE"); 

  
String OFF_CD = "";  
String OFF_NAME = "";
String CITY1 = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String PINCODE1="";
String OFF_LONG_DESC="";
String CONT_PER1=""; 
String OFF_TEL_NO="";
String OFF_EMAIL_ADDR="";



String vWherecls=""; 

 if (!AGENCY_TYPE.equals("")){
       vWherecls=vWherecls+" AND (MOM.AGENCY_TYPE) LIKE  ('%"+AGENCY_TYPE+"%')  ";

   }


if (!STATE.equals("")){
       vWherecls=vWherecls+" AND (MS.STATE_NM ) LIKE  ('%"+STATE+"%')  ";

}
  
 if (!ADDRESS.equals("")){
       vWherecls=vWherecls+" AND UPPER(trim(MOM.OFF_NAME)||' '||trim(MOM.OFF_LONG_DESC)||' '||trim(MOM.CITY)||' '||trim(MD.DISTRICT_NAME)||' '||MOM.PINCODE) LIKE (UPPER('%"+ADDRESS+"%'))  ";

 }
   

  
    DBCon db= new DBCon();
  db.connect();

  StringBuffer qrysb = new StringBuffer();
  


qrysb.append(" SELECT MOM.OFF_CD,MOM.AGENCY_TYPE, MOM.OFF_LONG_DESC,MOM.OFF_NAME,MOM.CITY,MD.DISTRICT_NAME,  " );
qrysb.append(" MD.DISTRICT_CD,MOM.PINCODE,MS.STATE_NM,MOM.CONT_PER1,MOM.OFF_TEL_NO,MOM.OFF_EMAIL_ADDR FROM MAS_OFF_MAST MOM,  " );
qrysb.append(" M_DISTRICT MD,M_STATE MS WHERE MOM.OFF_TYPE_CD IN (2,3,5,22)  " );
qrysb.append(" AND MD.DISTRICT_CD=MOM.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD " );
qrysb.append("   "+vWherecls+"  " );
//out.print (qrysb.toString());

 ResultSet rsMain = db.execSQL(qrysb.toString());

 ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="7"><div align="center">SEARCH FORM</div></th>
    </tr>
 
    <tr>
	<td width="23%"><select name="AGENCY_TYPE" id="AGENCY_TYPE">
	          <option value="">Search by Agency</option>
			  <option value="KVIC"<% if(AGENCY_TYPE.equals("KVIC")){out.print("selected");} %>>KVIC</option>
			  <option value="KVIB"<% if(AGENCY_TYPE.equals("KVIB")){out.print("selected");} %>>KVIB</option>
			  <option value="DIC"<% if(AGENCY_TYPE.equals("DIC")){out.print("selected");} %>>DIC</option>
			 </select>Or</td>
	
      <td width="21%"><select name="STATE" id="STATE">
	          <option value=""> Search by State</option>
		<%
	   String sn="";
	   while (rsState.next()) {
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=sn  %>" <% if (sn.equals(STATE)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>Or</td>
		
      <td width="30%"><div align="center">
        <input name="ADDRESS" type="text" id="ADDRESS" placeholder="Search By ADDRESS" value="<%=ADDRESS %>"  size="30" maxlength="30">
           </div></td>
		 
       <td width="26%"><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     
    </tr>
</table>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>         
      <th><div align="center">DISTRICT</div></th>
	  <th><div align="center">OFFICE NAME</div></th>
	  <th><div align="center">CONTACT PERSON</div></th>
	  <th><div align="center">CONTACT NO</div></th>
	  <th><div align="center">EMAIL ID</div></th> 
	  <th><div align="center">VIEW DETAILS</div></th> 
    </tr>
	
	</thead>
	<%
	int count=0;
	while (rsMain.next()){
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
CITY1=rsMain.getString("CITY")==null?"":rsMain.getString("CITY");
STATE=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
PINCODE1=rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
OFF_LONG_DESC=rsMain.getString("OFF_LONG_DESC")==null?"":rsMain.getString("OFF_LONG_DESC");
CONT_PER1=rsMain.getString("CONT_PER1")==null?"":rsMain.getString("CONT_PER1");
OFF_TEL_NO=rsMain.getString("OFF_TEL_NO")==null?"":rsMain.getString("OFF_TEL_NO");
OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
count=count+1;	
	%>
	<tr>
	  <td><div align="center"><%= count %></div></td>      
      <td><div align="left"><%= DISTRICT_NAME %></div></td>		
	  <td><div align="left"><%= OFF_NAME %></div></td>		
      <td><div align="left"><%= CONT_PER1 %></div></td>	  
	  <td><div align="left"><%= OFF_TEL_NO %></div></td>
	  <td><div align="left"><%= OFF_EMAIL_ADDR %></div></td>  
	  <td>	
		    <div align="center">
			    <input name="btnBank3" type="button" class="button" id="btnBank3" onClick="ShowNewPage('<%= OFF_CD %>','offDetails.jsp');"  value="VIEW DETAILS" />
	               
            </div></td>
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
