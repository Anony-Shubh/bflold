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

.style10 {font-weight: bold}
.style12 {font-weight: bold; font-size: 24px; }
.style13 {font-size: 24px}
.style8 {color: #000000; font-size: 14; }
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
String  TOT_UPLD="";
String 			 TODAY_TRG="";
String 			 TOT_TRG="";
String 			 TOT_REG="";
String 			 TODAY_REG="";
String BALANCE="";


StringBuffer qrysb= new StringBuffer();


qrysb.append("	SELECT SUM(TOT_TRG)-SUM(TOT_UPLD) as BALANCE   ,SUM(TOT_UPLD) TOT_UPLD,SUM(TODAY_TRG) TODAY_TRG,SUM(TOT_TRG) TOT_TRG,SUM(TOT_REG) TOT_REG, SUM(TODAY_REG) TODAY_REG FROM ( "      );
qrysb.append("	(select 0 TOT_UPLD,0  TODAY_TRG ,0 TOT_TRG,count(*) TOT_REG,0 TODAY_REG from ONLINE_EDP_DATA where REGISTRATION_DATE is not null  and APPLICATION_ID  in (select BD.app_id from BANK_DATAENTRY BD ,APP_DETAIL AP WHERE BD.APP_ID=AP.APP_ID)   AND TYPE='beneficiary') "      );
qrysb.append("	UNION ALL "      );
qrysb.append("	(select 0 TOT_UPLD,0  TODAY_TRG , 0 TOT_TRG,0 TOT_REG,count(*) TODAY_REG from ONLINE_EDP_DATA where REGISTRATION_DATE is not null  and APPLICATION_ID  in (select BD.app_id from BANK_DATAENTRY BD ,APP_DETAIL AP WHERE BD.APP_ID=AP.APP_ID)   AND TRUNC(REGISTRATION_DATE) = TRUNC(SYSDATE) AND TYPE='beneficiary') "      );
qrysb.append("	UNION ALL "      );
qrysb.append("	(select 0 TOT_UPLD,0  TODAY_TRG , count(*) TOT_TRG,0 TOT_REG,0 TODAY_REG from ONLINE_EDP_DATA where   REGISTRATION_DATE is not null  and APPLICATION_ID  in (select BD.app_id from BANK_DATAENTRY BD ,APP_DETAIL AP WHERE BD.APP_ID=AP.APP_ID)  AND CERTIFICATE_NO IS NOT NULL   AND TRAINING_COMPLETION_DATE is not null AND TYPE='beneficiary') "      );
qrysb.append("	UNION ALL "      );
qrysb.append("	(select 0 TOT_UPLD,count(*) TODAY_TRG ,0 TOT_TRG,0 TOT_REG,0 TODAY_REG from ONLINE_EDP_DATA where  REGISTRATION_DATE is not null  and APPLICATION_ID  in (select BD.app_id from BANK_DATAENTRY BD ,APP_DETAIL AP WHERE BD.APP_ID=AP.APP_ID) AND CERTIFICATE_NO IS NOT NULL AND TRAINING_COMPLETION_DATE is not null AND TRUNC(TRAINING_COMPLETION_DATE) = TRUNC(SYSDATE) AND TYPE='beneficiary') "      );
qrysb.append("	UNION ALL "      );
qrysb.append("	(select count(*) TOT_UPLD,0  TODAY_TRG ,0 TOT_TRG,0 TOT_REG,0 TODAY_REG from ONLINE_EDP_DATA where  REGISTRATION_DATE is not null  and APPLICATION_ID  in (select BD.app_id from BANK_DATAENTRY BD ,APP_DETAIL AP WHERE BD.APP_ID=AP.APP_ID)  AND CERTIFICATE_NO IS NOT NULL   AND TYPE='beneficiary' AND APPLICATION_ID in (select app_id from app_upload_trans where app_upload_trans.UPM_CD=8 and app_upload_trans.DOC_REMARKS='EDP ONLINE' AND app_upload_trans.DOC_ACTYN='Y')) "      );
qrysb.append("	)	 "      );

	//out.print(qrysb.toString());
	 ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();	
		
		while (rsMain.next()){ 
		
			 TOT_UPLD=rsMain.getString("TOT_UPLD")==null?"":rsMain.getString("TOT_UPLD");
			 TODAY_TRG=rsMain.getString("TODAY_TRG")==null?"":rsMain.getString("TODAY_TRG");
			 TOT_TRG=rsMain.getString("TOT_TRG")==null?"":rsMain.getString("TOT_TRG");
			 TOT_REG=rsMain.getString("TOT_REG")==null?"":rsMain.getString("TOT_REG");
			 TODAY_REG=rsMain.getString("TODAY_REG")==null?"":rsMain.getString("TODAY_REG");
			 BALANCE=rsMain.getString("BALANCE")==null?"":rsMain.getString("BALANCE");
}rsMain.close();

	%>

<table width="100%" border="1" align="center">
  <tr>
    <th><div align="center"><a href="view_edp_data.jsp" class="button">EDP ONLINE</a></div></th>
    <th><div align="center"><a href="HOME_MONTHLY.jsp" class="button">ONLINE EDP INVOICE </a></div></th>

    <th><div align="center" ><a href="index.jsp" class="button">LOGOUT</a></div></th>
  </tr>
</table>

<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  <span class="redLebel">Online EDP Data Transfer </span><br>
</div>


          <%
		    FROMDT=(String) request.getParameter("FROMDT")==null?"":(String) request.getParameter("FROMDT").trim();
TODT=(String) request.getParameter("TODT")==null?"":(String) request.getParameter("TODT").trim();

		  
String ins=(String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();

   if ( ins.equals("I") ){
   
     //out.print((String)request.getParameter("ins")+"ins");
  // FROMDT=(String) request.getParameter("FROMDT")==null?"":(String) request.getParameter("FROMDT").trim();
//TODT=(String) request.getParameter("TODT")==null?"":(String) request.getParameter("TODT").trim();



   try{
   
  ResultSet rsMainDB=db.execSQL(" DELETE FROM ONLINE_EDP_DATA_TEMP ");
   
     JSONParser parser = new JSONParser();
	// https://kviconline.gov.in/WSdemo/webService/getedpbyappid?APP_ID=KBDL20216058-9416511

       //https://udyami.org.in/api/v4/certificate-for-kvic?id=237179&type=beneficiary
	 // URL oracle = new URL( "https://udyami.org.in/api/v4/registrationdetails/2021-01-01/2021-01-31");
       
          URL oracle = new URL("https://udyami.org.in/api/v4/registrationdetails/"+FROMDT+"/"+TODT+""); // URL to Parse
            URLConnection yc = oracle.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
           
		  // out.print (oracle);
            String inputLine;
            while ((inputLine = in.readLine()) != null) {              
                JSONArray a = (JSONArray) parser.parse(inputLine);
             // application_id	name	email	mobile	pan_number	aadhar_number	type	registration_date	training_completion_date	certificate_no	download_certificate
 
                // Loop through each item
                for (Object o : a) {
                    JSONObject tutorials = (JSONObject) o;

                    
                      String application_id = (String) tutorials.get("application_id");
					  
					  out.print (application_id);
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
                      out.print(e.toString());
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
qryUpdate.append("       from ONLINE_EDP_DATA_TEMP  WHERE APPLICATION_ID NOT IN ");
qryUpdate.append(" (select APPLICATION_ID  from ONLINE_EDP_DATA_TEMP GROUP BY APPLICATION_ID HAVING COUNT(*)>1) ) OT  ");
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
qryUpdate.append(" OO.PMEGP_DB_UPDATE=SYSDATE  WHERE  OO.TRAINING_COMPLETION_DATE is  null   ");
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

out.print (qryUpdate.toString());

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
	 db.close();  
	response.sendRedirect("HOME.jsp");
	
}

   %>
<table border="1" align="center">
  
  <tr>
    <th colspan="2"><div align="center"></div></th>
  </tr>
  <tr>
    <th><div align="center">From Date:
      <input name="FROMDT" type="text" id="FROMDT"  onClick="javascript:NewCssCal('FROMDT','YYYYMMDD')" value="<%= FROMDT %>"  >
    </div></th>
    <th><div align="center">To Date :
      <input name="TODT" type="text" id="TODT" value="<%= TODT %>"  onClick="javascript:NewCssCal('TODT','YYYYMMDD')"  >
    </div></th>
  </tr>
  <tr>
    <th colspan="2"> <div id="formsubmitbutton">
      <div align="center">
        <input name="button" type="button" class="buttonMerun" id="button" onClick="submitfun();" value="Refresh Online Edp Data">
      </div>
    </div>
        <div id="buttonreplacement" style="margin-left:30px; display:none;">
          <div align="center"><img src="../images/preload.gif" alt="loading..." ></div>
        </div>
      <div id="fade"></div>
      <div id="modal">
          <div align="center"><img id="loader" src="../images/loading.gif" /> <br>
              <span style="color:#0000FF;font-size:16px;font-weight:bold">Please wait...</span> </div>
      </div></th>
  </tr>
</table>
<table width="80%"  align="center"  style="padding:10px 10px 10px 10px;">
  <tr>
    <th width="33%">&nbsp;</th>
    <th width="15%">&nbsp;</th>
    <th width="2%">&nbsp;</th>
    <th width="32%">&nbsp;</th>
    <th width="18%">&nbsp;</th>
  </tr>
  <tr>
    <td bgcolor="#99FFFF" class="style10"><div align="center" class="style12">Total Registered : </div></td>
    <td bgcolor="#99FFFF" class="style10"><div align="left" class="style13"><%= TOT_REG %></div></td>
    <th>&nbsp;</th>
    <td bgcolor="#99FFFF" class="style10"><div align="center" class="style13"><strong>Total Completed </strong>:</div></td>
    <td bgcolor="#99FFFF" class="style12"><%= TOT_TRG %></td>
  </tr>
  <tr>
    <td bgcolor="#99FFFF" class="style10"><div align="center" class="style13"><strong>Today : </strong></div></td>
    <td bgcolor="#99FFFF" class="style10"><div align="left" class="style13"><%= TODAY_REG %></div></td>
    <th>&nbsp;</th>
    <td bgcolor="#99FFFF" class="style10"><div align="center" class="style13"><strong>Today : </strong></div></td>
    <td bgcolor="#99FFFF" class="style12"><%= TODAY_TRG %></td>
  </tr>
  <tr>
    <th><div align="center"></div></th>
    <th><div align="left"></div></th>
    <th>&nbsp;</th>
    <th><div align="center"></div></th>
    <th>&nbsp;</th>
  </tr>
  <tr>
    <td bgcolor="#99FFFF" class="style10"><div align="center" class="style13"><strong>Completed Edp Transfer </strong>:</div></td>
    <td bgcolor="#99FFFF" class="style10"><div align="left" class="style13"><%= TOT_UPLD %></div></td>
    <th>&nbsp;</th>
    <td bgcolor="#99FFFF" class="style10"><div align="center" class="style13"><strong>Balance To be Transfer </strong>:</div></td>
    <td bgcolor="#99FFFF" class="style12"><%= BALANCE %></td>
  </tr>
  <tr>
    <th><div align="center"></div></th>
    <th><div align="left"></div></th>
    <th>&nbsp;</th>
    <th><div align="center"></div></th>
    <th>&nbsp;</th>
  </tr>
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
