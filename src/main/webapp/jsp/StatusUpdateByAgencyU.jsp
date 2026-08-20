<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>



<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript" src="../js/popcalendar.js"></script>

<script language="javascript">

function form_submit(){

var APP_REC_DATE = document.form.APP_REC_DATE.value;
    var REMARKS = document.form.REMARKS.value;
 //   var MTG_ID = document.form.MTG_ID.value;
if (APP_REC_DATE== "") {	
 inlineMsg ('APP_REC_DATE','Select Application Receving Date',2);	
 return (false);
 }
 
if (REMARKS== "")  {	
inlineMsg ('REMARKS','Enter Remarks',2); 
return (false);
}

document.form.ins.value='I';
document.form.submit();


}
function showHint(str) {
    if (str.length == 0) { 
        document.getElementById("txtHint").innerHTML = "";
        return;
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("mtg").innerHTML = xmlhttp.responseText;
            }
        };
        xmlhttp.open("POST", "dltfc_meetingList.jsp?MTG_ID="+str, true);
        xmlhttp.send();
    }
}

function chMd()
 {
  // initialize form with empty field
  document.forms[0].APP_REC_DATE.disabled=true;
  document.forms[0].APP_REC_DATE.value="";
  document.forms[0].REMARKS.disabled=true;
  document.forms[0].REMARKS.value="";
  document.forms[0].MTG_ID.disabled=true;
  document.forms[0].MTG_ID.value="";
  document.forms[0].APP_REC_DATE.style.backgroundColor="#999999";
  document.forms[0].REMARKS.style.backgroundColor="#999999";
  document.forms[0].MTG_ID.style.backgroundColor="#999999";

  for(var i=0;i<document.forms[0].elements.length;i++)
  {
    if(document.forms[0].elements[i].name=="ACT_ID")
    {
     if(document.forms[0].elements[i].value=="1")
     {
       if(document.forms[0].elements[i].checked==true){

        document.forms[0].APP_REC_DATE.disabled=false;
        document.forms[0].REMARKS.disabled=false;
        document.forms[0].MTG_ID.disabled=true;
		document.forms[0].APP_REC_DATE.style.backgroundColor="#FFFFFF";
        document.forms[0].REMARKS.style.backgroundColor="#FFFFFF";
		document.forms[0].MTG_ID.style.backgroundColor="#999999";
            }
     }
     else if(document.forms[0].elements[i].value=="4")
     {
       if(document.forms[0].elements[i].checked==true){
        document.forms[0].APP_REC_DATE.disabled=false;
        document.forms[0].REMARKS.disabled=false;
         document.forms[0].MTG_ID.disabled=false;
        document.forms[0].APP_REC_DATE.style.backgroundColor="#FFFFFF";
        document.forms[0].REMARKS.style.backgroundColor="#FFFFFF";
		document.forms[0].MTG_ID.style.backgroundColor="#FFFFFF";
       }
     }
    
  else if(document.forms[0].elements[i].value=="3")
     {
       if(document.forms[0].elements[i].checked==true){
        document.forms[0].APP_REC_DATE.disabled=false;
        document.forms[0].REMARKS.disabled=false;
         document.forms[0].MTG_ID.disabled=true;
         document.forms[0].APP_REC_DATE.style.backgroundColor="#FFFFFF";
        document.forms[0].REMARKS.style.backgroundColor="#FFFFFF";
		document.forms[0].MTG_ID.style.backgroundColor="#999999";
       }
     }

    }
  }
 }





</script>
<style type="text/css">
<!--
.style2 {color: #0000FF}
-->
</style>
</head>
<body onLoad="chMd()">
<%
String vOffcd= (String) session.getAttribute("off_cd");
DBCon db= new DBCon();
db.connect();

StringBuffer av= new StringBuffer();

String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String APP_NAME="";
String APP_REC_DATE="";
String MT_DATE="";
String REMARKS="";
String MOB_NO1="";
String MTG_ID="";
String TIME_STAMP="";
String ACT_ID="";
String E_MAIL="";
String ONLINE_SUBDT="";
String MOB_NO2="";


av.append(" SELECT ad.APP_ID, TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR HH:MM:SS') AS ONLINE_SUBDT,").
 append(" ad.APP_NAME,ad.MOB_NO1, ad.MTG_ID, ad.TIME_STAMP,TO_CHAR(ad.APP_REC_DATE, 'DD-MON-RRRR') AS APP_REC_DATE, ").
 append(" ad.ACT_ID,ad.E_MAIL,ad.REMARKS   FROM app_detail ad ").
append(" WHERE ad.APP_ID = '"+APP_ID+"'");
ResultSet rsApp = db.execSQL(av.toString());

while (rsApp.next()){
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
 APP_REC_DATE=rsApp.getString("APP_REC_DATE")==null?"":rsApp.getString("APP_REC_DATE");
 REMARKS=rsApp.getString("REMARKS")==null?"":rsApp.getString("REMARKS");
 MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
MTG_ID=rsApp.getString("MTG_ID")==null?"":rsApp.getString("MTG_ID");
TIME_STAMP=rsApp.getString("TIME_STAMP")==null?"":rsApp.getString("TIME_STAMP");
 ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
}

rsApp.close();





%>
<form name="form" id="form"  class="form" method="post" action="StatusUpdateByAgency.jsp">

  <table align="center">
  <tr>
    <th colspan="4"><div align="center">APPLICANT CURRENT STATUS UPDATE FORM BY AGENCY </div></th>
  </tr>
  <tr>
    <th width="445"><input name="ins" type="hidden" id="ins">
      Applicant Id</span> : 
      <input name="ACT_ID" type="radio" value="0" checked></th>
    <th width="89"><%=APP_ID %>   </th>
    <th width="365"><div align="right">Name Of Applicant :</div></th>
    <th width="151"><%=  APP_NAME %></th>
  </tr>
  
  <tr >
    <td colspan="4">Online Submission Date and Time: <%= ONLINE_SUBDT %></td>
    </tr>
  <tr >
    <td>eMail:</td>
    <td colspan="3"><%= E_MAIL %></td>
    </tr>
  <tr >
    <td>Mobile No</td>
    <td colspan="3">1st Mobile No:<%= MOB_NO1 %> and alternative Mobile No: <%= MOB_NO2 %> </td>
    </tr>
  <tr >
    <th colspan="4"><div align="center" class="GreenLebel">(Note: Current Status of Application will be received by the Applicant by SMS/eMail once you save the record.) </div></th>
    </tr>
  <tr >
    <td colspan="4" class="GreenLebel"><div align="right" class="redLebel">
      <div align="center">First Select Current Status so as to enter data..... </div>
    </div></td>
    </tr>
  <tr >
    <th><div align="right">Select Current Status: * </div></th>
    <td colspan="3" ><input name="ACT_ID" type="radio" value="1" onClick="chMd()">
      Under Process
        <input name="ACT_ID" type="radio" value="4" onClick="chMd()">
        <span class="style2">      Recommended to Place before DLTFC 
	    </span>
        <input name="ACT_ID" id="ACT_ID"  type="radio" value="3" onClick="chMd()"><span class="redLebel"> Rejected by DLTFC </span></td>
  </tr>
  <tr >
    <td colspan="4" ><div align="center"></div></td>
    </tr>
  <tr >
    <th >Document  Received Date*:</th>
    <td colspan="3" ><input name="APP_REC_DATE" type="text" id="APP_REC_DATE" value="<%=APP_REC_DATE  %>" onClick="popUpCalendar(this, this.form.APP_REC_DATE,'dd-mmm-yyyy');return false;" > 
      (DD-MM-YYYY) </td>
  </tr>
  <tr >
    <th >Agency Remarks*:</th>
    <td colspan="3" >
      <input name="REMARKS" type="text" id="REMARKS"  value="<%= REMARKS %>" size="70" maxlength="100">    </td>
  </tr>
  <tr>
    <th  >Select DLTFC Meeting ID: </th>
    <td colspan="3"> <input name="MTG_ID" type="text" id="MTG_ID"  onClick="Status_change();" value="<%=MTG_ID%>" size="70" maxlength="100">    </td></td>
  </tr>
  
  <tr>
    <th colspan="4"> 
        <div align="center">
          <input name="Button" type="button" class="button" onClick="form_submit()" value="Save Record">
          <input name="Button" type="button" class="button" tabindex="42" onClick="" value="Cancel">          
        </div></th>
  </tr>
</table>
<%

if ((String)request.getParameter("ins")!=null){


APP_REC_DATE=(String) request.getParameter("APP_REC_DATE")==null?"":(String) request.getParameter("APP_REC_DATE").trim();
MT_DATE=(String) request.getParameter("MT_DATE")==null?"":(String) request.getParameter("MT_DATE").trim();
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
MTG_ID=(String) request.getParameter("MTG_ID")==null?"":(String) request.getParameter("MTG_ID").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();


	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();




qryUpdate.append("UPDATE APP_DETAIL SET APP_REC_DATE=?,");
qryUpdate.append("REMARKS=?,");
qryUpdate.append("MTG_ID=?,");
qryUpdate.append("TIME_STAMP=SYSDATE,");
qryUpdate.append("ACT_ID=? WHERE APP_ID=?");

values.clear();
pstm.clear();

values.add(APP_REC_DATE); pstm.add ("L");
values.add(REMARKS); pstm.add ("L");
values.add(MTG_ID); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();



}//ins



%>

</form>
</body>
</html>
