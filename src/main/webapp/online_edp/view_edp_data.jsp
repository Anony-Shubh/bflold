<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStreamReader"%>

<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="5000kb" %>
<%@ page import="globalp.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<html>
<head>
<title>PMEGP Online Application Registration</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>


<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('#example').DataTable( {
	 "order": [[ 5, "desc" ]]
    } );
} );

function searchf(){

//SELECT
form.submit();
}



	function openModal() {
        document.getElementById('modal').style.display = 'block';
        document.getElementById('fade').style.display = 'block';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.getElementById('fade').style.display = 'none';
}
</script>
<style type="text/css">
<!--
.style8 {color: #000000; font-size: 14; }
.style9 {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>
<style>
div#DISP {
    display: none;
    }
 
div#loading {

    position: absolute;
    z-index: 1000;
    width: 100%;
    height: 100%;
    background: url(../images/page_loading.gif) no-repeat;
    cursor: wait;
    }
</style>
<style>

#content {
    padding:25px;
}

#fade {
    display: none;
    position:absolute;
    top: 0%;
    left: 0%;
    width: 100%;
    height: 1000%;
    background-color: #ababab;
    z-index: 1001;
    -moz-opacity: 0.8;
    opacity: .70;
    filter: alpha(opacity=80);
}

#modal {
    display: none;
    position: absolute;
    top: 45%;
    left: 45%;
    width: 120px;
    height: 67px;
    padding:30px 15px 0px;
    border: 3px solid #ababab;
    box-shadow:1px 1px 10px #ababab;
    border-radius:20px;
    background-color: white;
    z-index: 1002;
    text-align:center;
    overflow: auto;
}

#results {
    font-size:1.25em;
    color:red
}

</style>
</head>

<body >

<form id="form" name="form"  method="post">

<img src="../pmegponline.jpg" width="100%" height="150" >
<%


 DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
	List pstm=new ArrayList();
String USER ="";

String SELECT= request.getParameter("SELECT")==null?"TR":(String) request.getParameter("SELECT");
 String  FROMDT= request.getParameter("FROMDT")==null?"01-JAN-2019":(String) request.getParameter("FROMDT");
  String  TODT= request.getParameter("TODT")==null?"31-MAR-2020":(String) request.getParameter("TODT");
  String  APPLICATION_ID="";
  String  	 EDP_NAME="";
  String  	 APP_NAME="";
  String  	 REGISTRATION_DATE="";
  String  	 TRG_COMP_DT="";
  String  	CERT_NO="";
  String  	  CERT_PATH="";
  String  	  LAST_UPDATED_DT="";
  String CERT_FILE="";
String UPLOAD_YN="";
String IFSC_CODE="";
String whrcls="";

if(SELECT.equals("NT")){
whrcls="WHERE UPLOAD_YN=0 AND  trunc(TRG_COMP_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'  ";
}else if(SELECT.equals("TR")){
whrcls="WHERE UPLOAD_YN>=1 AND  trunc(TRG_COMP_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'  ";
}else{
whrcls="WHERE  trunc(TRG_COMP_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";
}
//2019-04-01
StringBuffer qrysb= new StringBuffer();

qrysb.append("	SELECT IFSC_CODE,APPLICATION_ID,EDP_NAME,APP_NAME,TO_CHAR(REGISTRATION_DATE,'DD-MON-YYYY') REGISTRATION_DATE,TO_CHAR(TRG_COMP_DT,'DD-MON-YYYY') TRG_COMP_DT,CERT_NO,CERT_FILE,CERT_PATH,LAST_UPDT_DT,UPLOAD_YN FROM (SELECT "      );
qrysb.append("	(SELECT   BD.IFSC_CODE FROM BANK_DATAENTRY BD WHERE BD.APP_ID = EDP.APPLICATION_ID) IFSC_CODE, edp.application_id, "      );
qrysb.append("	    edp.name EDP_NAME,"      );
qrysb.append("	   (select APP.APP_NAME from   app_detail app WHERE  edp.application_id = app.app_id ) APP_NAME ,"      );
qrysb.append("	    (edp.registration_date) registration_date,"      );
qrysb.append("	     (edp.training_completion_date) AS TRG_COMP_DT,"      );
qrysb.append("	    edp.certificate_no AS CERT_NO, edp.certificate_no||'.pdf' AS CERT_FILE,"      );
qrysb.append("	 edp.DOWNLOAD_CERTIFICATE AS CERT_PATH,"      );
qrysb.append("	    TO_CHAR(edp.last_updt_dt,'DD-MON-YYYY') last_updt_dt,nvl((select count(*) from APP_UPLOAD_TRANS up WHERE up.DOC_REMARKS='EDP ONLINE' and up.UPM_CD=8 and up.app_id=edp.application_id and up.doc_name=edp.certificate_no||'.pdf' AND UP.DOC_ACTYN='Y'),0) as UPLOAD_YN"      );
qrysb.append("	FROM"      );
qrysb.append("	    online_edp_data edp"      );
qrysb.append("	  "      );
qrysb.append("	WHERE"      );
//qrysb.append("	  edp.application_id = app.app_id   and edp.APPLICATION_ID  in (select app_id from BANK_DATAENTRY ) "      );
qrysb.append("	 edp.APPLICATION_ID  in (select BD.app_id from BANK_DATAENTRY BD ,APP_DETAIL AP WHERE BD.APP_ID=AP.APP_ID)  AND   edp.TYPE='beneficiary'  AND   edp.TRAINING_COMPLETION_DATE IS NOT NULL and edp.registration_date is not null  AND EDP.CERTIFICATE_NO IS NOT NULL  order by (edp.training_completion_date) desc) "+whrcls+" "      );
	

	%>

<table width="100%" border="1" align="center">
  <tr>
    <th><div align="center" ><a href="HOME.jsp" class="button">HOME</a></div></th>
    <th><div align="center" ><a href="index.jsp" class="button">LOGOUT</a></div></th>
  </tr>
</table>

<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  <span class="redLebel">Online EDP Data Transfer </span><br>
</div>
<table border="1" align="center">
  <tr>
    <th><div align="center">Completion From Date:
        <input name="FROMDT" type="text" id="FROMDT"  onClick="javascript:NewCssCal('FROMDT','DDMMMYYYY')" value="<%= FROMDT %>" readonly="true" >
    </div></th>
    <th><div align="center">To Date :
      <input name="TODT" type="text" id="TODT" value="<%= TODT %>"  onClick="javascript:NewCssCal('TODT','DDMMMYYYY')" readonly="true" >
    </div></th>
  </tr>
  <tr>
    <th colspan="2">&nbsp;</th>
  </tr>
  <tr>
    <th colspan="2"><div align="center">
      <select name="SELECT" class="style8" id="SELECT">
        <OPTION value="TR"<%if(SELECT.equals("TR")){out.print("selected='selected'");}%>>TRANSFERED</OPTION>
        <OPTION value="NT"<%if(SELECT.equals("NT")){out.print("selected='selected'");}%>>YET TO BE TRANSFERED</OPTION>
        <OPTION value="ALL"<%if(SELECT.equals("ALL")){out.print("selected='selected'");}%>>ALL</OPTION>
        </select>
      <input type="button" onClick="searchf();" name="search" id="search" class="button" value="SEARCH">
    </div></th>
  </tr>
</table>

          <table  align="center"  class="display" id="example" width="100%">
            <thead>
              <tr>
                <th colspan="10">&nbsp;</th>
              </tr>
              <tr>
                <th>APP ID </th>
                <th>EDP APP NAME </th>
                <th>PORTAL APP NAME </th>
                <th bgcolor="#FFFFCC">IFSC CODE </th>
                <th bgcolor="#FFFFCC">REGISTRATION DT </th>
                <th bgcolor="#FFFFCC"> COMPLETION DT </th>
                <th bgcolor="#FFFFCC">CERT NO. </th>
                <th bgcolor="#CCCCCC">DOWNLOAD</th>
                <th bgcolor="#CCCCCC">LAST UPDT DT </th>
                <th bgcolor="#CCCCCC">&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              <%

	 ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();	
		
		while (rsMain.next()){ 
			 APPLICATION_ID=rsMain.getString("APPLICATION_ID")==null?"":rsMain.getString("APPLICATION_ID");

	 EDP_NAME=rsMain.getString("EDP_NAME")==null?"":rsMain.getString("EDP_NAME");
	 APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	 REGISTRATION_DATE=rsMain.getString("REGISTRATION_DATE")==null?"":rsMain.getString("REGISTRATION_DATE");
	 TRG_COMP_DT=rsMain.getString("TRG_COMP_DT")==null?"":rsMain.getString("TRG_COMP_DT");
	 CERT_NO=rsMain.getString("CERT_NO")==null?"":rsMain.getString("CERT_NO");
	  CERT_PATH=rsMain.getString("CERT_PATH")==null?"":rsMain.getString("CERT_PATH");
	  LAST_UPDATED_DT=rsMain.getString("LAST_UPDT_DT")==null?"":rsMain.getString("LAST_UPDT_DT");
	UPLOAD_YN=rsMain.getString("UPLOAD_YN")==null?"":rsMain.getString("UPLOAD_YN");
    CERT_FILE=rsMain.getString("CERT_FILE")==null?"":rsMain.getString("CERT_FILE");
    IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");

	%>
              <tr>
                <td><%= APPLICATION_ID %></td>
                <td><%= EDP_NAME %></td>
                <td><%= APP_NAME %></td>
                <td bgcolor="#FFFFCC"><%= IFSC_CODE %></td>
                <td bgcolor="#FFFFCC"><%= REGISTRATION_DATE %></td>
                <td bgcolor="#FFFFCC"><%= TRG_COMP_DT %></td>
                <td bgcolor="#FFFFCC"><%= CERT_NO %></td>
                <td bgcolor="#C0EAA8"><a href="<%= CERT_PATH %>"  download>Download</a></td>
                <td bgcolor="#C0EAA8"><%= LAST_UPDATED_DT %></td>
                <td bgcolor="#C0EAA8"><%if(UPLOAD_YN.equals("0")){%>
				<input type="button" name="button2" id="button2" class="button" value="Transfer Doc" onClick="uploadDoc('<%= APPLICATION_ID %>','<%= CERT_NO %>','<%= CERT_PATH %>','<%= APP_NAME %>');">
				<%}else{%>
				<input type="button" name="button3" id="button3" class="button" value="View" onClick="view('<%= APPLICATION_ID %>','<%= CERT_FILE %>');"><%}%></td>
              </tr>
              <%
	}   //uploadDoc
	rsMain.close();
	db.close();
		

	%>
            </tbody>
          </table>
</form>
 
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
   function uploadDoc(APPLICATION_ID,CERT_NO,CERT_PATH,APP_NAME){

  modalWin.ShowURL("uploadDoc.jsp?APP_ID="+APPLICATION_ID+"&CERT_NO="+CERT_NO+"&CERT_PATH="+CERT_PATH+"&APP_NAME="+APP_NAME,500,650,'transfer',null,null);

 }
    function view(APPLICATION_ID,CERT_FILE){

  modalWin.ShowURL("../jsp/doctransfertoNas.jsp?APP_ID="+APPLICATION_ID+"&docname="+CERT_FILE,800,1200,'view',null,null);

 }
 
function refreshpage() {
  location.reload();
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}



</script>
</body>
</html>
