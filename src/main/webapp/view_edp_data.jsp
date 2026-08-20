<%@ page import="java.sql.*,api.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="1000kb" %>
<%@ page import="globalp.*,FTPUploader.*"%>

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


document.form.ins.value='I';
document.form.submit();
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
</head>

<body >

<form name="form" id="form"  class="form" >

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


StringBuffer qrysb= new StringBuffer();

qrysb.append("	SELECT "      );
qrysb.append("	    edp.application_id, "      );
qrysb.append("	    edp.name EDP_NAME,"      );
qrysb.append("	    app.APP_NAME,"      );
qrysb.append("	    TO_CHAR(edp.registration_date,'DD-MON-YYYY') registration_date,"      );
qrysb.append("	    TO_CHAR(edp.training_completion_date,'DD-MON-YYYY') AS TRG_COMP_DT,"      );
qrysb.append("	    edp.certificate_no AS CERT_NO,"      );
qrysb.append("	 edp.DOWNLOAD_CERTIFICATE AS CERT_PATH,"      );
qrysb.append("	    TO_CHAR(edp.last_updt_dt,'DD-MON-YYYY') last_updt_dt"      );
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
    <th colspan="2"><div align="center"><input name="button" type="button" class="buttonMerun" id="button" onClick="submitfun();" value="Refresh Online Edp Data">
    </div></th>
    </tr>
</table>

<DIV id="SUP_ST_NM"></DIV>

          <%
		  

   if ((String)request.getParameter("ins")!=null){
  
   FROMDT=(String) request.getParameter("FROMDT")==null?"":(String) request.getParameter("FROMDT").trim();
TODT=(String) request.getParameter("TODT")==null?"":(String) request.getParameter("TODT").trim();

   try{
   
    JsonParser sm =new JsonParser();
         //  sm.edpdata(FROMDT,TODT);
		   
		   
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
		   out.print(e.toString());
		   }

	
	
kvicGlobalPath sm = new kvicGlobalPath();
String globalpath=sm.getStorage("PMEGPEPORTAL/tempedponline/");
	
	FTPUploader ft = new FTPUploader();

ft.downloadUsingStream(url, globalpath+"SMD5504683.pdf");


	
	
}

   %><BR>
          <table  align="center"  class="display" id="example" width="100%">
            <thead>
              <tr>
                <th colspan="8">&nbsp;</th>
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
				
              </tr>
              <%
	}
	rsMain.close();
	db.close();
	
	%>
            </tbody>
          </table>
</form>
 

</body>
</html>
