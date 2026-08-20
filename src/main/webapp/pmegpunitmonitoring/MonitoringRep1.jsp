 <%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
 <%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
 <head>
 <script>
function toggle() {
 if(document.getElementById("PV_STATUS").value == "WO" ) {
   document.getElementById("hidethis1").style.display = 'table-row'; 
   document.getElementById("hidethis2").style.display = 'table-row';
   document.getElementById("hidethis3").style.display = 'table-row';
   document.getElementById("hidethis4").style.display = 'table-row'; 
   document.getElementById("hidethis5").style.display = 'table-row';
   document.getElementById("hidethis6").style.display = 'table-row';
   
 }else{
   document.getElementById("hidethis1").style.display = 'none';
   document.getElementById("hidethis2").style.display = 'none';
   document.getElementById("hidethis3").style.display = 'none';
   document.getElementById("hidethis4").style.display = 'none';
   document.getElementById("hidethis5").style.display = 'none';
   document.getElementById("hidethis6").style.display = 'none';
 }
 }

</script>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}
 %>
 
 
<script language="javascript">
 var xmlHttp   
      var xmlHttp 
      function button1(){ 
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
     str = document.getElementById("APP_ID").value;
      var url="Entrepreneur_Prof.jsp"; 
    url +="?APP_ID=" +str;
      xmlHttp.onreadystatechange = ProductTwoChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
      function ProductTwoChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('BANKDATAENTRYFORMVER');
	  x.innerHTML=xmlHttp.responseText;
	// alert (xmlHttp.responseText);
      } //statechane1 function end   
      }//main function end.

	   var xmlHttp   
      var xmlHttp 
      function buttonclick2(){ 
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
	 
	  str = document.getElementById("APP_ID").value;
	  
     

	  
      var url="Mont_ProjectProfile.jsp"; 
        url +="?APP_ID=" +str;
    
	  
      xmlHttp.onreadystatechange = ProductTwoChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function ProductTwoChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('PROJECT_PROFILE');
	  x.innerHTML=xmlHttp.responseText;
	// alert (xmlHttp.responseText);
      } //statechane1 function end   
      }//main function end.
	  
	  
	  
	  
	  </script>
	  
	  <script>
 var xmlHttp   
      var xmlHttp 
      function buttonclick3(){ 
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
	 
	  
	  str = document.getElementById("APP_ID").value;
	  
    
      var url="monitoring.jsp"; 
      url +="?APP_ID=" +str;
	  
      xmlHttp.onreadystatechange = ProductTwoChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function ProductTwoChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('MONITORING_REPORT');
	  x.innerHTML=xmlHttp.responseText;
	// alert (xmlHttp.responseText);
      } //statechane1 function end   
      }//main function end.



function show(){
button1();
}
function show2(){
buttonclick2();
}
function show3(){
buttonclick3();
}
</script>
<script>
function submitUpdate(){
  var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/; 
  var numberOnly=/^[0-9 \.-]+$/;




	document.form.ins.value='I'; 
	document.form.submit();
//	document.form.refresh();
   

}




</script>
<style type="text/css">
<!--
.style1 {font-size: 16px}
-->
</style>
</head>
<body onLoad="show();">



<form  method="post" name="form" >
  <%@ include file="MonitoringRep.jsp" %>
 
  <%
String  APP_ID =  session.getAttribute("SAPP_ID")==null?"":(String) session.getAttribute("SAPP_ID");
%>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
    <jsp:setProperty name="upBean" property="folderstore" value="E:\tomcat5\webapps\pmegpeportal\pmegpunitmonitoring\physicalmupload" />
    <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
    <jsp:setProperty name="upBean" property="overwrite" value="false" />
    <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*jpeg,*.png" />
    </jsp:useBean>
<%
 List values=new ArrayList();
     List pstm=new ArrayList();
	pstm.clear();
    values.clear();
	
 DBCon db= new DBCon();
db.connect();
String PHTR_ID = "";
String PV_DT = "";
String PV_VAR_OFF = "";
String PV_VAR_DES = "";
String PV_AGENCY = "";
String PHY_PROD = "";
String PHY_SALES = "";
String PHY_EMP_PT = "";
String PHY_EMP_FT = "";
String START_DT = "";
String PRODUCT_DETAIL = "";
String PHY_INV = "";
String PHY_ANL_TO = "";
String PV_STATUS = "";
String PV_VER_OFF = "";
String PV_OBSERV = "";
String REP_UPLOAD_FNM = "";
String ACT_YN_PH = "";
String PVTIME_STAMP = "";
%>

<table align="center" class="pmegpTable">
  <tr>
    <th colspan="7" nowrap><div align="center" class="style1">Concurrent Monitoring of PMEGP Entrepreneur </div></th>
  </tr>  
  <tr>
    <td nowrap> <div align="center">
	<input type="button" id="button1" name="button1" value="ENTREPRENEUR PROFILE" onClick="show();" class="buttonMerun" > 
	
	</div></td>    
    <td nowrap><div align="center">
	<input type="button" id="button2" name="button2" value="PROJECT PROFILE" onClick="show2();" class="buttonMerun" >

	</div></td>
	 <td nowrap><div align="center">
	 <input type="button" id="button3" name="button3" value="MONITORING REPORT " onClick="show3();" class="buttonGreen" >
	    <input name="ins" type="hidden" id="ins"><input type="hidden" id="APP_ID" name="APP_ID" value="<%= APP_ID %>">
	</div></td>	
    </tr>
</table>
<%
	if ((String)request.getParameter("ins")!=null){

PHTR_ID=(String) request.getParameter("PHTR_ID")==null?"":(String) request.getParameter("PHTR_ID").trim();
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
PV_DT=(String) request.getParameter("PV_DT")==null?"":(String) request.getParameter("PV_DT").trim();
PV_VAR_OFF=(String) request.getParameter("PV_VAR_OFF")==null?"":(String) request.getParameter("PV_VAR_OFF").trim();
PV_VAR_DES=(String) request.getParameter("PV_VAR_DES")==null?"":(String) request.getParameter("PV_VAR_DES").trim();
PV_AGENCY=(String) request.getParameter("PV_AGENCY")==null?"":(String) request.getParameter("PV_AGENCY").trim();
PHY_PROD=(String) request.getParameter("PHY_PROD")==null?"":(String) request.getParameter("PHY_PROD").trim();
PHY_SALES=(String) request.getParameter("PHY_SALES")==null?"":(String) request.getParameter("PHY_SALES").trim();
PHY_EMP_PT=(String) request.getParameter("PHY_EMP_PT")==null?"":(String) request.getParameter("PHY_EMP_PT").trim();
PHY_EMP_FT=(String) request.getParameter("PHY_EMP_FT")==null?"":(String) request.getParameter("PHY_EMP_FT").trim();
START_DT=(String) request.getParameter("START_DT")==null?"":(String) request.getParameter("START_DT").trim();
PRODUCT_DETAIL=(String) request.getParameter("PRODUCT_DETAIL")==null?"":(String) request.getParameter("PRODUCT_DETAIL").trim();
PHY_INV=(String) request.getParameter("PHY_INV")==null?"":(String) request.getParameter("PHY_INV").trim();
PHY_ANL_TO=(String) request.getParameter("PHY_ANL_TO")==null?"":(String) request.getParameter("PHY_ANL_TO").trim();
PV_STATUS=(String) request.getParameter("PV_STATUS")==null?"":(String) request.getParameter("PV_STATUS").trim();
PV_VER_OFF=(String) request.getParameter("PV_VER_OFF")==null?"":(String) request.getParameter("PV_VER_OFF").trim();
PV_OBSERV=(String) request.getParameter("PV_OBSERV")==null?"":(String) request.getParameter("PV_OBSERV").trim();
REP_UPLOAD_FNM=(String) request.getParameter("REP_UPLOAD_FNM")==null?"":(String) request.getParameter("REP_UPLOAD_FNM").trim();
ACT_YN_PH=(String) request.getParameter("ACT_YN_PH")==null?"":(String) request.getParameter("ACT_YN_PH").trim();
	StringBuffer qryUpdate = new StringBuffer();

	pstm.clear();
    values.clear();
	
		
//if ( !update.equals("UPDT") ) {


	ResultSet rs1=db.execSQL("select NVL(MAX(PHTR_ID),0)+1 from MONITORING_PV_DETAIL");
	while (rs1.next()) {
PHTR_ID=rs1.getString(1);
}
rs1.close();
 qryUpdate.append("INSERT INTO MONITORING_PV_DETAIL ( ");
qryUpdate.append("PVTIME_STAMP,");
qryUpdate.append("APP_ID,");
qryUpdate.append("PV_DT,");
qryUpdate.append("PV_VAR_OFF,");
qryUpdate.append("PV_VAR_DES,");
qryUpdate.append("PV_AGENCY,");

qryUpdate.append("PHY_PROD,");
qryUpdate.append("PHY_SALES,");
qryUpdate.append("PHY_EMP_PT,");
qryUpdate.append("PHY_EMP_FT,");
qryUpdate.append("START_DT,");
qryUpdate.append("PRODUCT_DETAIL,");
qryUpdate.append("PHY_INV,");
qryUpdate.append("PHY_ANL_TO,");
qryUpdate.append("PV_STATUS,");
qryUpdate.append("PV_VER_OFF,");
qryUpdate.append("PV_OBSERV,");
qryUpdate.append("REP_UPLOAD_FNM,");
qryUpdate.append("ACT_YN_PH,");
 qryUpdate.append("PHTR_ID)");
qryUpdate.append(" VALUES (SYSDATE,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?) ");
  
//} 

values.add(APP_ID); pstm.add ("L");
values.add(PV_DT); pstm.add ("L");
values.add(PV_VAR_OFF); pstm.add ("L");
values.add(PV_VAR_DES); pstm.add ("L");
values.add(PV_AGENCY); pstm.add ("L");
values.add(PHY_PROD); pstm.add ("L");
values.add(PHY_SALES); pstm.add ("L");
values.add(PHY_EMP_PT); pstm.add ("L");
values.add(PHY_EMP_FT); pstm.add ("L");
values.add(START_DT); pstm.add ("L");
values.add(PRODUCT_DETAIL); pstm.add ("L");
values.add(PHY_INV); pstm.add ("L");
values.add(PHY_ANL_TO); pstm.add ("L");
values.add(PV_STATUS); pstm.add ("L");
values.add(PV_VER_OFF); pstm.add ("L");
values.add(PV_OBSERV); pstm.add ("L");
values.add(REP_UPLOAD_FNM); pstm.add ("L");
values.add(ACT_YN_PH); pstm.add ("L");
values.add(PHTR_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());

db.setValues(values,pstm);
db.executeUpdate() ;
			
			}


%>
<div id="BANKDATAENTRYFORMVER"></div>
<div id="PROJECT_PROFILE"></div>

<div id="MONITORING_REPORT"></div>

  
</form>
</body>
</html>
