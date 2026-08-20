<%@ page session="true" import="api.*,java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat"  %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page  import="java.io.FileOutputStream"%>
<%@ page  import="java.io.IOException"%>
<%@ page   import="java.net.URL"%>
<%@ page import="globalp.*"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page  import="java.nio.channels.Channels"%>
<%@ page  import="java.nio.channels.ReadableByteChannel"%>


<%@ page buffer="5000kb" %>
<%@ page import="globalp.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Delete product sales </title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/inlineMsgMain.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script>
function submit_update(){
openModal();
document.form.ins.value='I';
document.form.submit();


}

function closeAndRefresh(){
   window.parent.refreshpage();  
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

.style1 {color: #990000}
</style>

</head>

<body>

<form name="form" id="form"  class="form" method="post">

<%
String MSG="";
//String CUSTCODE= (String) session.getAttribute("SCUSTCODE");

String APP_ID = request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String CERT_NO = request.getParameter("CERT_NO")==null?"":(String) request.getParameter("CERT_NO");
String CERT_PATH= request.getParameter("CERT_PATH")==null?"":(String) request.getParameter("CERT_PATH");
String APP_NAME= request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME");
String ins="";
DBCon db= new DBCon();
db.connect();
	 List values=new ArrayList();	
    List pstm=new ArrayList();
%>
<table width="100%" align="center" class="shadow">
  <tr>
    <th colspan="2">APPLICATION ID :
      <input name="APP_ID" type="text" id="APP_ID" value="<%=APP_ID%>" readonly="readonly" >
	 
	  <strong><span class="style1"><%= APP_NAME %></span></strong></th>
    </tr>
  
  <tr>
    <td colspan="2"> <div align="center">
      
	  	<div id="formsubmitbutton">
    <input name="Button" type="button" class="buttonGreen" value="Transfer" onclick="submit_update();" />
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

    </div></td>
    </tr>
</table>
  <input name="ins" type="hidden" id="ins">
  
   <%
   String urlStr="";
   String file="";
   if ((String)request.getParameter("ins")!=null){

APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
CERT_NO=request.getParameter("CERT_NO")==null?"":request.getParameter("CERT_NO");


  ResultSet rsMainDB=db.execSQL(" select DOWNLOAD_CERTIFICATE FROM ONLINE_EDP_DATA WHERE APPLICATION_ID='"+APP_ID+"' ");
  
  	while (rsMainDB.next()){ 
			 CERT_PATH=rsMainDB.getString("DOWNLOAD_CERTIFICATE")==null?"":rsMainDB.getString("DOWNLOAD_CERTIFICATE");
}rsMainDB.close();

	out.print(CERT_PATH);

	try{
	
	
kvicGlobalPath sm = new kvicGlobalPath();
String globalpath=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/tempedponline/");
	
	CERT_NO=CERT_NO+".pdf";
	
	file=globalpath+CERT_NO;
	

	
	 URL url = new URL(CERT_PATH);
         BufferedInputStream bis = new BufferedInputStream(url.openStream());
         FileOutputStream fis = new FileOutputStream(file);
         byte[] buffer = new byte[1024];
         int count=0;
         while((count = bis.read(buffer,0,1024)) != -1)
         {
             fis.write(buffer, 0, count);
         }
        fis.close();
        bis.close();
		
		
			File ftemp = new File(file);
String tempyn=(ftemp.exists()? "Y" : "N");
	out.print(tempyn+"tempyn");
	//FTPUploader ft = new FTPUploader();
      //      ft.downloadUsingStream(CERT_PATH, globalpath+CERT_NO);

if(tempyn.equals("Y")){
StringBuffer qryUpdate1 = new StringBuffer();		   
		   
qryUpdate1.append(" INSERT INTO APP_UPLOAD_TRANS( ");

qryUpdate1.append(" UP_ID, ");
qryUpdate1.append(" APP_ID, ");
qryUpdate1.append(" UPM_CD, ");
qryUpdate1.append(" DOC_NAME, ");
qryUpdate1.append(" DOC_REMARKS, ");
qryUpdate1.append(" DOC_ACTYN, ");
qryUpdate1.append(" UPLOAD_TIMESTAMP, ");
qryUpdate1.append(" FLAG_EXP_SUC ");
qryUpdate1.append("  ) VALUES(APPUPLOAD_SEQ.NEXTVAL,?,8,?,'EDP ONLINE','Y',SYSDATE,'N') ");

  values.add(APP_ID);pstm.add("D");
  values.add(CERT_NO);pstm.add("D");

db.setSqlValue(qryUpdate1.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
	db.close();

response.sendRedirect("../savepage.jsp");
}else{
   out.print("<div class='error'>error in transfer..</div>");
}
  }catch(Exception e){
  out.print(e.toString());
		   out.print("<div class='error'>error in transfer..</div>");
		   }


////////////////////


  db.close();

	
   }
  
  %>  
</form>
</body>
</html>
