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

   var MONTH = document.getElementById("MONTH").value;
 
    if(MONTH == "" || MONTH == "0" ) {
    inlineMsg('MONTH','SELECT MONTH',2);
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
String MONTH="";
String INV_DATE="";
String UPDATE_DT="";
String TOT_CNT="";
String CNT_BEN="";
String CNT_NBEN="";


	%>

<table width="80%" border="1" align="center">
  <tr>
    <th><div align="center"><a href="view_edp_data.jsp" class="button">EDP ONLINE</a></div></th>
    <th><div align="center"><a href="HOME.jsp" class="button">DATEWISE EDP API </a></div></th>
    <th><div align="center" ><a href="index.jsp" class="button">LOGOUT</a></div></th>
  </tr>
</table>

<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  ONLINE EDP INVOICE
</div>


          <%
		    MONTH=(String) request.getParameter("MONTH")==null?"":(String) request.getParameter("MONTH").trim();

		  
String ins=(String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();

   if ( ins.equals("I") ){
   
 //  out.print (MONTH);
   
ResultSet bar=db.execSQL("select TO_CHAR(trunc(to_date('"+MONTH+"'||to_char(sysdate-20,'yyyy')),'month'),'yyyy-mm-dd') FROMDT,TO_CHAR(LAST_DAY('"+MONTH+"'||to_char(sysdate-20,'yyyy')),'YYYY-MM-DD') TODT from dual");
while (bar.next()) {
FROMDT=bar.getString("FROMDT")==null?"":bar.getString("FROMDT");
TODT=bar.getString("TODT")==null?"":bar.getString("TODT");

}	
bar.close();

out.print (FROMDT);

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
					  
					//  out.print (application_id);
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
                      
					//  out.print (name);

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

		  Connection conn = null;
	try{
  Class.forName("oracle.jdbc.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "PMEGPNEW", "PMEGP_1239");

CallableStatement cs = conn.prepareCall("{call  ONLINE_EDP_INVOICE (?,?)}");

cs.setString(1,FROMDT); 
cs.setString(2,TODT); 
cs.execute();
}catch(Exception e){out.print(e.toString());}

		   
	}catch(Exception e){
out.print(e.toString());}
	// db.close();  
	//response.sendRedirect("HOME.jsp");
	
}

  // conn.close();



   %>
<table border="1" align="center">
  
  <tr>
    <th colspan="2"><div align="center">------</div></th>
  </tr>
  <tr>
    <th>
	<select  id="MONTH" name="MONTH">
	<OPTION value="">--SELECT MONTH--</OPTION>
	<OPTION VALUE="01-JAN-">JAN</OPTION>
	<OPTION VALUE="01-FEB-">FEB</OPTION>
	<OPTION VALUE="01-MAR-">MAR</OPTION>
	<OPTION VALUE="01-APR-">APR</OPTION>
	<OPTION VALUE="01-MAY-">MAY</OPTION>

	<OPTION VALUE="01-JUN-">JUN</OPTION>
	<OPTION VALUE="01-JUL-">JUL</OPTION>
	<OPTION VALUE="01-AUG-">AUG</OPTION>
	<OPTION VALUE="01-SEP-">SEP</OPTION>
	<OPTION VALUE="01-OCT-">OCT</OPTION>
	<OPTION VALUE="01-NOV-">NOV</OPTION>
	<OPTION VALUE="01-DEC-">DEC</OPTION>
	</select>
	
	</th>
  </tr>
  <tr>
    <th colspan="2"> <div id="formsubmitbutton">
      <div align="center">
        <input name="button" type="button" class="style10" id="button" onClick="submitfun();" value="Refresh Online Edp Data">
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
<%

StringBuffer qrysb= new StringBuffer();


qrysb.append("	SELECT TO_CHAR(INV_DATE,'DD-MON-YYYY') INV_DATE,TO_CHAR(update_dt,'DD-MON-YYYY') update_dt,COUNT(*) TOT_CNT,sum(DECODE(TYPE,'beneficiary',1,0)) cnt_ben, "      );
qrysb.append("	sum(DECODE(TYPE,'beneficiary',0,1)) cnt_nben "      );
qrysb.append("	FROM BNF_SAMADHANEDP_APPDETAIL1 "      );
qrysb.append("	GROUP BY INV_DATE,update_dt  "      );
qrysb.append("	ORDER BY TO_DATE(INV_DATE) DESC "      );

	 ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();	
		
		

%><HR>
<table width="70%"  align="center" >
  <tr>
    <th >INVOICE DATE</th>
    <th >PROCESS DATE</th>
    <th >TOTAL APPLICATION</th>
    <th >BENEFICIARY</th>
    <th >NON-BENEFICIARY</th>
  </tr>
  <%
  while (rsMain.next()){ 
		
			 INV_DATE=rsMain.getString("INV_DATE")==null?"":rsMain.getString("INV_DATE");
			 UPDATE_DT=rsMain.getString("UPDATE_DT")==null?"":rsMain.getString("UPDATE_DT");
			 TOT_CNT=rsMain.getString("TOT_CNT")==null?"":rsMain.getString("TOT_CNT");
			 CNT_BEN=rsMain.getString("CNT_BEN")==null?"":rsMain.getString("CNT_BEN");
			 CNT_NBEN=rsMain.getString("CNT_NBEN")==null?"":rsMain.getString("CNT_NBEN");
	%>
   <tr>
    <td ><%= INV_DATE %></td>
    <td ><%= UPDATE_DT %></td>
    <td ><%= TOT_CNT %></td>
    <td ><%= CNT_BEN %></td>
    <td ><%= CNT_NBEN %></td>
  </tr>
  <%}rsMain.close();%>
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
