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
	 "order": [[ 4, "desc" ]]
    } );
} );


function submitfun(){

   var FROMDT = document.getElementById("FROMDT").value;
   var TODT = document.getElementById("TODT").value;

  if(FROMDT == "" || FROMDT == "0" ) {
    inlineMsg('FROMDT','SELECT DATE',2);
    return false;
  }
    if(TODT == "" || TODT == "0" ) {
    inlineMsg('TODT','SELECT DATE',2);
    return false;
  }

openModal();
document.form.ins.value='I';
document.form.submit();
document.getElementById("formsubmitbutton").style.display = "none"; // to undisplay
   document.getElementById("buttonreplacement").style.display = ""; // to display
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

<form id="form" name="form" method="post">

<img src="../pmegponline.jpg" width="100%" height="150" >
<%


 DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
	List pstm=new ArrayList();
String USER ="";


 String  FROMDT="";
  String  TODT="";
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


StringBuffer qrysb= new StringBuffer();

qrysb.append("	SELECT "      );
qrysb.append("	    edp.application_id, "      );
qrysb.append("	    edp.name EDP_NAME,"      );
qrysb.append("	    app.APP_NAME,"      );
qrysb.append("	    TO_CHAR(edp.registration_date,'DD-MON-YYYY') registration_date,"      );
qrysb.append("	    TO_CHAR(edp.training_completion_date,'DD-MON-YYYY') AS TRG_COMP_DT,"      );
qrysb.append("	    edp.certificate_no AS CERT_NO, edp.certificate_no||'.pdf' AS CERT_FILE,"      );
qrysb.append("	 edp.DOWNLOAD_CERTIFICATE AS CERT_PATH,"      );
qrysb.append("	    TO_CHAR(edp.last_updt_dt,'DD-MON-YYYY') last_updt_dt,nvl((select count(*) from APP_UPLOAD_TRANS up WHERE up.DOC_REMARKS='EDP ONLINE' and up.UPM_CD=8 and up.app_id=edp.application_id and up.doc_name=edp.certificate_no||'.pdf' AND UP.DOC_ACTYN='Y'),0) as UPLOAD_YN"      );
qrysb.append("	FROM"      );
qrysb.append("	    online_edp_data edp,"      );
qrysb.append("	    app_detail app"      );
qrysb.append("	WHERE"      );
qrysb.append("	    edp.application_id = app.app_id"      );
qrysb.append("	    AND   edp.certificate_no IS NOT NULL order by trunc(edp.training_completion_date) desc"      );
	

	%>

<table width="100%" border="1" align="center">
  <tr>
    <th><div align="center"></div></th>
    <th></th>
    <th><div align="center" ><a href="index.jsp" class="button">Logout</a></div></th>
  </tr>
</table>

<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  <span class="redLebel">Online EDP Data Transfer </span><br>
</div>
<table border="1" align="center">
  <tr>
    <th>From Date: <input name="FROMDT" type="text" id="FROMDT"  onClick="javascript:NewCssCal('FROMDT','YYYYMMDD')" value="2019-04-01" readonly="true" ></th>
    <th>To Date : <input name="TODT" type="text" id="TODT" value="2019-12-31"  onClick="javascript:NewCssCal('TODT','YYYYMMDD')" readonly="true" ></th>
  </tr>
  <tr>
    <th colspan="2"><div align="center">
	<div id="formsubmitbutton">
     <input name="button" type="button" class="buttonMerun" id="button" onClick="submitfun();" value="Refresh Online Edp Data">
	  </div>
<div id="buttonreplacement" style="margin-left:30px; display:none;">
<img src="../images/preload.gif" alt="loading..." >
</div>
		<div id="fade"></div>

        <div id="modal">
            <img id="loader" src="../images/loading.gif" />
			<br>
			<span style="color:#0000FF;font-size:16px;font-weight:bold">Please wait...</span>
        </div>   
	
    </div></th>
    </tr>
</table>

<DIV id="SUP_ST_NM"></DIV>

          <%
		  

   if ((String)request.getParameter("ins")!=null){
  
   FROMDT=(String) request.getParameter("FROMDT")==null?"":(String) request.getParameter("FROMDT").trim();
TODT=(String) request.getParameter("TODT")==null?"":(String) request.getParameter("TODT").trim();

out.print(FROMDT);
out.print(TODT);

   try{
   
    ResultSet rsMainDB=db.execSQL(" DELETE FROM ONLINE_EDP_DATA_TEMP ");
   
     JSONParser parser = new JSONParser();

      //  try {        
            URL oracle = new URL("https://udyami.org.in/api/registrationdetails/"+FROMDT+"/"+TODT+""); // URL to Parse
            URLConnection yc = oracle.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
           
            String inputLine;
            while ((inputLine = in.readLine()) != null) {              
                JSONArray a = (JSONArray) parser.parse(inputLine);
             // application_id	name	email	mobile	pan_number	aadhar_number	type	registration_date	training_completion_date	certificate_no	download_certificate
 
                // Loop through each item
                for (Object o : a) {
                    JSONObject tutorials = (JSONObject) o;

                    
                      String application_id = (String) tutorials.get("application_id");
                      String name = (String) tutorials.get("name");
                      String email = (String) tutorials.get("email");
                      String mobile = (String) tutorials.get("mobile");
                      String pan_number = (String) tutorials.get("pan_number");
                      String aadhar_number = (String) tutorials.get("aadhar_number");
                      String type = (String) tutorials.get("type");
                      String registration_date = (String) tutorials.get("registration_date");
                      String training_completion_date = (String) tutorials.get("training_completion_date");
                      String certificate_no = (String) tutorials.get("certificate_no");
                      String download_certificate = (String) tutorials.get("download_certificate");
                      

                     String repdownload_certificate=(download_certificate.replace("\'>", ">")).replace("='","=");
                    

                        try {                          
                      //  statement.execute("INSERT INTO ONLINE_EDP_DATA_TEMP (APPLICATION_ID,NAME,EMAIL,MOBILE,PAN_NUMBER,AADHAR_NUMBER,TYPE,REGISTRATION_DATE,TRAINING_COMPLETION_DATE,CERTIFICATE_NO,DOWNLOAD_CERTIFICATE,LAST_UPDT_DT,PMEGP_DB_UPDATE) values('"+application_id+"','"+name+"','"+email+"','"+mobile+"','"+pan_number+"','"+aadhar_number+"','"+type+"','"+registration_date+"','"+training_completion_date+"','"+certificate_no+"','"+repdownload_certificate+"',SYSDATE,'')");
                               
StringBuffer qryUpdate1 = new StringBuffer();		   
		   
qryUpdate1.append(" INSERT INTO ONLINE_EDP_DATA_TEMP (APPLICATION_ID,NAME,EMAIL,MOBILE,PAN_NUMBER,AADHAR_NUMBER,TYPE,REGISTRATION_DATE,TRAINING_COMPLETION_DATE,CERTIFICATE_NO,DOWNLOAD_CERTIFICATE,LAST_UPDT_DT,PMEGP_DB_UPDATE) values( ");

qryUpdate1.append(" ?,?,?,?,?, ?,?,?,?,? ,?,SYSDATE,SYSDATE) ");


  values.add(application_id);pstm.add("D");
  values.add(name);pstm.add("D");
  
  values.add(email);pstm.add("D");
  values.add(mobile);pstm.add("D");

  values.add(pan_number);pstm.add("D");
  values.add(aadhar_number);pstm.add("D");

  values.add(type);pstm.add("D");
  values.add(registration_date);pstm.add("D");
    values.add(training_completion_date);pstm.add("D");
 values.add(certificate_no);pstm.add("D");

  values.add(repdownload_certificate);pstm.add("D");


try{
db.setSqlValue(qryUpdate1.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

}catch(Exception e){
out.print(e.toString());}

values.clear();
pstm.clear();
                      }catch (Exception e) {
                      out.print(e);
                        }   
                                  
                                  
              
                }
            }
            in.close();
          
            

  //  JsonParser sm =new JsonParser();
      //    sm.Showedp("2019-04-01","2019-12-31");

		   
StringBuffer qryUpdate = new StringBuffer();		   
		   

qryUpdate.append(" merge into ONLINE_EDP_DATA OO  ");
qryUpdate.append("    using  ");
qryUpdate.append("      (select   ");
qryUpdate.append("      *  ");
qryUpdate.append("       from ONLINE_EDP_DATA_TEMP) OT  ");
qryUpdate.append("    on (OT.APPLICATION_ID = OO.APPLICATION_ID)  ");
qryUpdate.append("    when matched then  ");
qryUpdate.append("      update set   ");
qryUpdate.append("      ");
qryUpdate.append(" OO.NAME=DECODE(OT.NAME,'null','',OT.NAME),  ");
qryUpdate.append(" OO.EMAIL=DECODE(OT.EMAIL,'null','',OT.EMAIL),  ");
qryUpdate.append(" OO.MOBILE=DECODE(OT.MOBILE,'null','',OT.MOBILE),  ");
qryUpdate.append(" OO.PAN_NUMBER=DECODE(OT.PAN_NUMBER,'null','',OT.PAN_NUMBER),  ");
qryUpdate.append(" OO.AADHAR_NUMBER=DECODE(OT.AADHAR_NUMBER,'null','',OT.AADHAR_NUMBER),  ");
qryUpdate.append(" OO.TYPE=DECODE(OT.TYPE,'null','',OT.TYPE),  ");
qryUpdate.append("OO.REGISTRATION_DATE=DECODE(OT.REGISTRATION_DATE,'null','',to_date(substr(OT.REGISTRATION_DATE,1,10),'yyyy-mm-dd')),  ");
qryUpdate.append("OO.TRAINING_COMPLETION_DATE=DECODE(OT.TRAINING_COMPLETION_DATE,'null','',to_date(substr(OT.TRAINING_COMPLETION_DATE,1,10),'yyyy-mm-dd')),  ");
qryUpdate.append(" OO.CERTIFICATE_NO=DECODE(OT.CERTIFICATE_NO,'null','',OT.CERTIFICATE_NO),  ");
qryUpdate.append(" OO.DOWNLOAD_CERTIFICATE=DECODE(OT.DOWNLOAD_CERTIFICATE,'null','', substr(OT.DOWNLOAD_CERTIFICATE,INSTR(OT.DOWNLOAD_CERTIFICATE,'=')+1,INSTR(OT.DOWNLOAD_CERTIFICATE,'>',1)-INSTR(OT.DOWNLOAD_CERTIFICATE,'=')-1)),  ");
qryUpdate.append(" OO.LAST_UPDT_DT=DECODE(OT.LAST_UPDT_DT,'null','',OT.LAST_UPDT_DT),  ");
qryUpdate.append(" OO.PMEGP_DB_UPDATE=SYSDATE  ");
qryUpdate.append("   when not matched then  ");
qryUpdate.append("     insert (OO.APPLICATION_ID,  ");
qryUpdate.append(" OO.NAME,  ");
qryUpdate.append(" OO.EMAIL,  ");
qryUpdate.append(" OO.MOBILE,  ");
qryUpdate.append(" OO.PAN_NUMBER,  ");
qryUpdate.append(" OO.AADHAR_NUMBER,  ");
qryUpdate.append(" OO.TYPE,  ");
qryUpdate.append(" OO.REGISTRATION_DATE,  ");
qryUpdate.append(" OO.TRAINING_COMPLETION_DATE,  ");
qryUpdate.append(" OO.CERTIFICATE_NO,  ");
qryUpdate.append(" OO.DOWNLOAD_CERTIFICATE,  ");
qryUpdate.append(" OO.LAST_UPDT_DT,  ");
qryUpdate.append(" OO.PMEGP_DB_UPDATE)  ");
qryUpdate.append("     values (OT.APPLICATION_ID,  ");
qryUpdate.append(" DECODE(OT.NAME,'null','',OT.NAME),  ");
qryUpdate.append(" DECODE(OT.EMAIL,'null','',OT.EMAIL),  ");
qryUpdate.append(" DECODE(OT.MOBILE,'null','',OT.MOBILE),  ");
qryUpdate.append(" DECODE(OT.EMAIL,'null','',OT.PAN_NUMBER),  ");
qryUpdate.append(" DECODE(OT.AADHAR_NUMBER,'null','',OT.AADHAR_NUMBER),  ");
qryUpdate.append(" DECODE(OT.TYPE,'null','',OT.TYPE),  ");
qryUpdate.append("DECODE(OT.REGISTRATION_DATE,'null','',to_date(substr(OT.REGISTRATION_DATE,1,10),'yyyy-mm-dd')),  ");
qryUpdate.append("DECODE(OT.TRAINING_COMPLETION_DATE,'null','',to_date(substr(OT.TRAINING_COMPLETION_DATE,1,10),'yyyy-mm-dd')),  ");
qryUpdate.append(" DECODE(OT.CERTIFICATE_NO,'null','',OT.CERTIFICATE_NO),  ");
qryUpdate.append(" DECODE(OT.DOWNLOAD_CERTIFICATE,'null','', substr(OT.DOWNLOAD_CERTIFICATE,INSTR(OT.DOWNLOAD_CERTIFICATE,'=')+1,INSTR(OT.DOWNLOAD_CERTIFICATE,'>',1)-INSTR(OT.DOWNLOAD_CERTIFICATE,'=')-1)),    ");
qryUpdate.append(" OT.LAST_UPDT_DT,  ");
qryUpdate.append(" SYSDATE)  ");



try{
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
}catch(Exception e){
out.print(e.toString());}
		   
	}catch(Exception e){
out.print(e.toString());}
	   
	response.sendRedirect("view_edp_data.jsp");
	
}

   %><BR>
          <table  align="center"  class="display" id="example" width="100%">
            <thead>
              <tr>
                <th colspan="9">&nbsp;</th>
              </tr>
              <tr>
                <th>APP ID </th>
                <th>EDP APP NAME </th>
                <th>PORTAL APP NAME </th>
                <th bgcolor="#FFFFCC">REGISTRATION DT </th>
                <th bgcolor="#FFFFCC">TRAINING COMPLETION DT </th>
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
	%>
              <tr>
                <td><%= APPLICATION_ID %></td>
                <td><%= EDP_NAME %></td>
                <td><%= APP_NAME %></td>
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
	//db.close();
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
