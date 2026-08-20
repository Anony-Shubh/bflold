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
String TODAYDT="";
String FORD_DT_DLTFC="";
String MSG="";

av.append(" SELECT ad.APP_ID,FUN_LOCKUPDATE_REJ(ad.APP_ID) AS MSG, TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR HH:MM:SS') AS ONLINE_SUBDT, ").
 append(" ad.APP_NAME,ad.MOB_NO1, ad.MTG_ID,TO_CHAR(AD.ONLINE_SUBDT, 'DD-MON-RRRR') AS APP_REC_DATE, TO_CHAR(SYSDATE,'DD-MON-RRRR') AS TODAYDT, TO_CHAR(FORD_DT_DLTFC,'DD-MON-RRRR') AS FORD_DT_DLTFC ,").
 append(" ad.ACT_ID,ad.E_MAIL,ad.REMARKS   FROM app_detail ad ").
append(" WHERE ad.APP_ID = '"+APP_ID+"'");
ResultSet rsApp = db.execSQL(av.toString());

while (rsApp.next()){
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
 APP_REC_DATE=rsApp.getString("APP_REC_DATE")==null?"":rsApp.getString("APP_REC_DATE");
 REMARKS=rsApp.getString("REMARKS")==null?"":rsApp.getString("REMARKS");
 MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
MTG_ID=rsApp.getString("MTG_ID")==null?"":rsApp.getString("MTG_ID");
ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
FORD_DT_DLTFC=rsApp.getString("FORD_DT_DLTFC")==null?"":rsApp.getString("FORD_DT_DLTFC");
TODAYDT=rsApp.getString("TODAYDT")==null?"":rsApp.getString("TODAYDT");
MSG=rsApp.getString("MSG")==null?"":rsApp.getString("MSG");
}

rsApp.close();
%>

<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">

function submit_form() {
var ACT_ID = document.form.ACT_ID.value; 
var REMARKS = document.form.REMARKS.value; 

 
 if(ACT_ID == "") {
    inlineMsg('ACT_ID','Select Applicant Status.........',2);
    return false;
  }else 


if(REMARKS == "" && (ACT_ID =="3"|| ACT_ID=="1")) {
    inlineMsg('REMARKS','Enter Remarks',2);
    return false;
  }else{
    document.form.ins.value='I'; 
              document.form.submit()
			  } 
}

</script>
</head>
<body>
<form  method="post" name="form" id="form">
<% if(MSG.equals("U")){%>
  <table align="center">
    <tr>
      <th colspan="4"><div align="center">APPLICANT CURRENT STATUS UPDATE FORM BY AGENCY </div></th>
    </tr>
    <tr>
      <th><input name="ins" type="hidden" id="ins">
      Applicant Id :
        <input name="ACT_ID" type="radio" disabled value="0" <% if (ACT_ID.equals("0")){out.print("Checked");}%>></th>
      <th><%=APP_ID %> </th>
      <th><div align="right">Name Of Applicant :</div></th>
      <th><%=  APP_NAME %></th>
    </tr>
    <tr >
      <th nowrap>Online Submission Date and Time: <%= ONLINE_SUBDT %></th>
      <th colspan="3" nowrap><div align="right">DLTFC Fordwarding Date:<%= FORD_DT_DLTFC  %></div></th>
    </tr>
    <tr >
      <th nowrap>eMail:</th>
      <th colspan="3" nowrap><%= E_MAIL %></th>
    </tr>
    <tr >
      <th nowrap>Mobile No</th>
      <th colspan="3" nowrap>1st Mobile No:<%= MOB_NO1 %> and alternative Mobile No: <%= MOB_NO2 %> </th>
    </tr>
    <tr >
      <th colspan="4"><div align="center" class="redLebel">(Note: Current Status of Application will be received by the Applicant by SMS/eMail once you save the record.) </div></th>
    </tr>
    <tr >
      <td colspan="4"></td>
    </tr>
    <tr >
      <th><div align="right">Select Current Status: * </div></th>
      <th colspan="3" >	
	  <input name="ACT_ID" id="ACT_ID" type="radio" value="1" <% if (ACT_ID.equals("1")){out.print("Checked");}%>>
      Under Process
        <input name="ACT_ID"  id="ACT_ID" type="radio" value="3" <% if (ACT_ID.equals("3")){out.print("Checked");}%>>
        <span class="redLebel">Rejected by Agency <span class="GreenLebel">
        <input name="ACT_ID"  id="ACT_ID" type="radio" value="2" <% if (ACT_ID.equals("2")){out.print("Checked");}%>>
      Forwarded to DLTFC</span> </span></th>
    </tr>
    <tr >
      <td colspan="4" class="GreenLebel" ><div align="center" class="redLebel">Note: Applicantion can be forwarded to DLTFC after scrutiny and need not wait for Meeting Date. </div></td>
    </tr>
    <tr >
      <th ><div align="right">Agency Remarks*:
              
      </div></th>
      <td colspan="3" ><input name="REMARKS" type="text" id="REMARKS" onClick="Status_change();" value="<%= REMARKS %>" size="50" maxlength="100">
      </td>
    </tr>
    <tr>
      <th colspan="4"> <div align="center">
          <input name="Button2" type="button" class="button"  value="Cancel" onClick="javascript:window.close();">
          <input name="Button" type="button" class="button"  onClick="submit_form();" value="Save  Record">
      </div></th>
    </tr>
  </table>
  <%} else {%>
	<table align="center">
    <tr>
      <th colspan="4"><div align="center">APPLICANT CURRENT STATUS UPDATE FORM BY AGENCY </div></th>
    </tr>
    <tr>
      <th><input name="ins" type="hidden" id="ins">
      Applicant Id :
        <input name="ACT_ID" type="radio" disabled value="0" <% if (ACT_ID.equals("0")){out.print("Checked");}%>></th>
      <th><%=APP_ID %> </th>
      <th><div align="right">Name Of Applicant :</div></th>
      <th><%=  APP_NAME %></th>
    </tr>
    <tr >
      <th nowrap>Online Submission Date and Time: <%= ONLINE_SUBDT %></th>
      <th colspan="3" nowrap><div align="right">DLTFC Fordwarding Date:<%= FORD_DT_DLTFC  %></div></th>
    </tr>
    <tr >
      <th nowrap>eMail:</th>
      <th colspan="3" nowrap><%= E_MAIL %></th>
    </tr>
    <tr >
      <th nowrap>Mobile No</th>
      <th colspan="3" nowrap>1st Mobile No:<%= MOB_NO1 %> and alternative Mobile No: <%= MOB_NO2 %> </th>
    </tr>
	  <tr >
      <th colspan="4"><div align="center" class="redLebel"><%=MSG%> </div></th>
	  </tr>
	  <tr>
	  <th colspan="4"> <div align="center"><input name="Button2" type="button" class="button"  value="Cancel" onClick="javascript:window.close();"> </div></th>
    </tr>
    <tr >
  </table>
  <%}%>
  <%

if ((String)request.getParameter("ins")!=null){
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
String vtoDate=ACT_ID.equals("2")?TODAYDT:"";

	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
//out.print (vtoDate);
qryUpdate.append(" UPDATE APP_DETAIL SET REMARKS=?,APP_REC_DATE=?,");
qryUpdate.append("  ACT_ID=?,FORD_DT_DLTFC=? WHERE APP_ID=? AND ACT_ID IN (0,1,3,2) AND MTG_ID IS NULL AND DLTFC_PROC_DT IS NULL");

values.clear();
pstm.clear();

values.add(REMARKS); pstm.add ("L");
values.add(APP_REC_DATE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(vtoDate); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("savemsg.jsp");

}//ins
%>
</form>
</body>
</html>
