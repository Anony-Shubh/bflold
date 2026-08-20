<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<html>
<head>
 <script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>  
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script language="javascript">
function form_submit(){
document.form.submit();
}
 var xmlHttp   
      var xmlHttp 
      function showDistrict(str){ 
	  try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 
	  
      var url="district.jsp"; 
      url +="?count=" +str;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('DISTRICT');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }//main function end.

       

</script>
</head>

<body onLoad=""showDistrict(this.value);"">
<form name="form" id="form" class="form" method="post">
  <%@include file="AppIncludePage.jsp"%>
  <% 
  String STATE="";
  String DISTRICT="";
  String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID"); 
  String pSTATE =request.getParameter("STATE")==null?"":(String)request.getParameter("STATE"); 
  String vSTATE=(String) session.getAttribute("STATE")==null?"":(String)session.getAttribute("STATE");
  //out.print(STATE);
  String pDISTRICT =request.getParameter("DISTRICT")==null?"":(String)request.getParameter("DISTRICT");
  String vDISTRICT=(String) session.getAttribute("DISTRICT")==null?"":(String)session.getAttribute("DISTRICT");
  // out.print(DISTRICT);
   session.setAttribute("STATE", STATE);
   session.setAttribute("DISTRICT", DISTRICT);
   
   if ((pSTATE.equals("")) && (!vSTATE.equals(""))){
   STATE=vSTATE;
   }
   else if ((!pSTATE.equals("")) && (vSTATE.equals(""))){
    STATE=pSTATE;
   }
   else{
   STATE="";
   }
   
    if ((pDISTRICT.equals("")) && (!vDISTRICT.equals(""))){
   DISTRICT=vDISTRICT;
   }
   else if ((!pDISTRICT.equals("")) && (vDISTRICT.equals(""))){
    DISTRICT=pDISTRICT;
   }
   else{
   DISTRICT="";
   }
   
   
   
String APP_NAME = "";  
String OFF_CD="";
String OFF_NAME = "";
String IFSC_CODE = "";
String STATE_NM = "";
String DISTRICT_NAME = "";
String APP_DIST_CD="";
String APP_PIN="";
String BANK_NAME="";
String DOC_NAME="";
String MM_REL_DT="";
String vWherecls=""; 
String vcls="";
String vl=""; 
String pcls=""; 
if (!APP_ID.equals("")){
       vWherecls=vWherecls+" AND (a.app_id) LIKE  ('%"+APP_ID+"%')  ";

   }
   else {
	  vWherecls=vWherecls+" AND (a.app_id) LIKE  ('%%')  ";  
   }
 
   if (!STATE.equals("")){
    vWherecls=vWherecls+" AND (a.STATE_CD ) LIKE  ('%"+STATE+"%')  ";
}
else{
 vWherecls=vWherecls+" AND (a.STATE_CD ) LIKE  ('-')  ";
 
}


  
 if (!DISTRICT.equals("")){
  vWherecls=vWherecls+" AND (a.DISTRICT_CD ) LIKE  ('%"+DISTRICT+"%')  ";
    
 
}
else{
 vWherecls=vWherecls+" AND (a.DISTRICT_CD ) LIKE  ('-')  ";
  
  
}



   
  
  
    DBCon db= new DBCon();
    db.connect();

  StringBuffer qrysb = new StringBuffer();
 
/*
qrysb.append(" select mqr.app_id,mqr.app_name,mqr.ifsc_code,mqr.BANK_NAME,sqr.DOC_NAME " );
qrysb.append(" from (select bd.app_id,ad.app_name,ad.IFSC_CODE,AD.BANK_NAME from app_detail ad,bank_dataentry bd" );
qrysb.append(" where ad.app_id=bd.app_id  and bd.act_id=11 and BD.EDP_CERT_DT is NULL AND BD.MM_REL_DT IS NOT NULL AND BD.PACT_ID=34 AND BD.APPRV_YN='A' )mqr," );
qrysb.append(" ( SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT, BANK_DATAENTRY BD WHERE AUT.APP_ID=BD.APP_ID " );
qrysb.append(" AND AUT.UPM_CD=8 group by AUT.APP_ID )sqr " );
qrysb.append("  WHERE mqr.APP_ID=sqr.APP_ID (+) "+vWherecls+" " );
*/
qrysb.append("    select a.* ,b.doc_name from   "      );
qrysb.append("        ( SELECT bd.APP_ID,"      );
qrysb.append("     ad.APP_NAME,"      );
qrysb.append("     bd.IFSC_CODE,"      );
qrysb.append("     ad.BANK_NAME,"      );
qrysb.append("    to_char(bd.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,MS.STATE_CD,MD.DISTRICT_CD "      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     bank_dataentry bd,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     m_district md,"      );
qrysb.append("     m_state ms"      );
qrysb.append("   WHERE ad.APP_ID     = bd.APP_ID"      );
qrysb.append("   AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("   AND ad.UNIT_DIST_CD = md.DISTRICT_CD"      );
qrysb.append("   AND md.STATE_CD     = ms.STATE_CD"      );
qrysb.append("   AND bd.ACT_ID      = 11 and bd.EDP_CERT_DT IS NULL   "      );
qrysb.append("   )a,"      );
qrysb.append("     (  SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT WHERE "      );
qrysb.append("     AUT.UPM_CD=8 AND DOC_ACTYN='Y' group by AUT.APP_ID )b"      );
qrysb.append("     WHERE a.APP_ID=b.APP_ID "+vWherecls+"  "      );





//out.print (qrysb.toString());
 ResultSet rsMain = db.execSQL(qrysb.toString());
 
  ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");
 //ResultSet  rsDistrict=db.execSQL(" SELECT MD.DISTRICT_CD,MD.DISTRICT_NAME FROM M_DISTRICT MD WHERE  "+pcls+"   ORDER BY MD.DISTRICT_NAME ");

 
 %>
  <table align="center" class="bordered">
    <tr>
      <th colspan="11"><div align="center">APPLICATION SEARCH FORM </div></th>
    </tr>
 
    <tr>
      <td>SEARCH BY STATE:</td>
      <td><select name="STATE" id="STATE" onBlur="showDistrict(this.value);">
	          <option value=""> Search by State</option>
		<%
	   String sn="";
	   String st="";
	   while (rsState.next()) {
	   st=rsState.getString(1);	
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=st  %>" <% if (st.equals(STATE)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>	  </td>
      <td>SEARCH BY DISTRICT</td>
     <TD id ='DISTRICT' colspan="4"><SELECT name="DISTRICT" class="button" onBlur="showOffice(this.value);copy_dist()" >
          <OPTION value="-1" >--Select District-</OPTION>
      </SELECT></TD>
      <td>OR</td>
      <td>SEARCH BY APPLICATION_ID:</td>
      <td><input name="APP_ID" type="APP_ID" size="20" maxlength="20" value="<%= APP_ID %>" placeholder="Search by APPLICATION_ID"></td>
      <td><input name="btnFind" type="submit" class="button" id="btnFind" value="Search" ></td>
     <!-- <td><input name="Submit" type="submit" class="button" id="reset" value="View All"></td>-->
    </tr>
</table>
<div id = "view"  >
  <table id="example" align="center" class="bordered">
    <thead>
    <tr>
      <th>Sr No </th>
      <th><div align="center">Application_Id</div></th>
      <th><div align="center">Applicant_Name</div></th>     
      <th><div align="center">IFSC CODE</div></th>
	  <th><div align="center">Bank Name</div></th>	 
	   <th><div align="center">MM Release Date</div> </th>
	   <th><div align="center">View EDP Certificate</div></th>
	  <th><div align="center">Update EDP Certificate Details</div></th>
    </tr>
	</thead>
	<%
	int edpcount=0;
	while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BANK_NAME =rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
DOC_NAME=rsMain.getString("DOC_NAME")==null?"":rsMain.getString("DOC_NAME");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
edpcount=edpcount+1;
	
	%>
	
	<tr>
	  <td><%= edpcount %></td>
	  <td><div align="left"><%=APP_ID%></div></td>  
      <td><div align="left"><%=APP_NAME %></div></td> 
	  <td><div align="left"><%=IFSC_CODE %></div></td> 
	  <td><div align="left"><%=BANK_NAME %></div></td> 
       
      	
      
	 
	  <td><div align="left"><%=MM_REL_DT %></div></td>
	  <td>	
		    <div align="center">
			<% if  (!DOC_NAME.equals("")) {%>
			<input type="button" name="button" id="button" class="button" value="View EDP Certificate" onClick="viewdocument('<%= DOC_NAME %>','<%=APP_ID%>');">
	</center>
	
			<% } else {	%>
			    EDP Certificate Not Uploaded
	             <%
}%>				 
            </div></td>
			<td>
			<% if  (!DOC_NAME.equals("")) {%>
			<div align="center"><input name="btnUpload" type="button" class="buttonMerun" value="Update EDP Certificate Details" onClick="uploadCert('<%= DOC_NAME %>','<%= APP_ID %>')"></div>
			<% } else {	%>
			    EDP Certificate Not Uploaded
	             <%
}%>			</td>	
    </tr>
	<% 
	

	
	}rsMain.close();
db.close();
	
	 %>	
</table>
</div>
<script language="javascript">

var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
function ShowNewPage(app_id,filename){
var urlpar=filename+'?APP_ID='+app_id;
 

 modalWin.ShowURL(urlpar,1000,1500,'View Application',null,null);
 }//end of bank



function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}

function viewdocument(vDOC_NAME,vAPP_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("ViewS.jsp?docname="+vDOC_NAME+"&APP_ID="+vAPP_ID,500,800,'View Document',null,null);
 }//end of bank

function refreshpage() {
   form.submit(); 
}

function uploadCert(vDOC_NAME,pAppid) {
var url ="docViewS.jsp?docname="+vDOC_NAME+"&APP_ID="+pAppid;
 modalWin.ShowURL(url,800,1200,'Update EDP Certificate Details',null,null);
 
}

   </script>
</form>
</body>
</html>
