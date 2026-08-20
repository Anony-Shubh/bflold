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


<script language="javascript">

function form_submit(){
var COM_MODE = document.form.COM_MODE.value;
    var NB_NAME = document.form.NB_NAME.value;
    var NB_DESIG = document.form.NB_DESIG.value;
	var INT_REMARK  = document.form.INT_REMARK.value


if ( COM_MODE== "") {	 inlineMsg ( 'COM_MODE','Select Interaction Mode',2);	return (false);}
else if (NB_NAME== "") {	 inlineMsg ( 'NB_NAME','Enter Name of Nodal Officer',2); return (false);}
else if (NB_DESIG== "") {	 inlineMsg ( 'NB_DESIG','Enter Designation',2);	return (false);}
else if (INT_REMARK == "") {	 inlineMsg ( 'INT_REMARK','Remark Must be entered',2);	return (false);

}else {

document.form.ins.value='I';
document.form.submit();


}}

</script>
</head>
<body>
<% 
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");





Date todayDt = new Date();
 SimpleDateFormat form = new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss");


String vTodayDt =form.format(todayDt);
//String APP_ID = "";
String INT_TRANS_ID = "";
String COM_MODE = "";
String NB_NAME = "";
String NB_DESIG = "";
String INT_TIME = "";
String INT_REMARK = "";

String APP_NAME="";
String ONLINE_SUBDT="";
String E_MAIL="";
String MOB_NO1="";
String MOB_NO2="";

String APP_REC_DATE="";
String MT_DATE="";
String REMARKS="";
String MTG_ID="";
String TIME_STAMP="";
String ACT_ID="";
String TIME_DIF="";

String vOffcd=(String) session.getAttribute("off_cd");
//(String) session.getAttribute("off_cd");
StringBuffer av= new StringBuffer();
av.append(" SELECT ad.APP_ID, TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR HH:MM:SS') AS ONLINE_SUBDT,").
 append(" ad.APP_NAME,ad.MOB_NO1,  TO_CHAR(ad.APP_REC_DATE, 'DD-MON-RRRR') AS APP_REC_DATE, ").
 append(" floor((SYSDATE-ONLINE_SUBDT)*24)|| ' HOURS ' ||mod(floor((SYSDATE-ONLINE_SUBDT)*24*60),60)|| ' MINUTES ' || ").
   append(" mod(floor((SYSDATE-ONLINE_SUBDT)*24*60*60),60)|| ' SECS ' AS TIME_DIF, ").
 append(" ad.ACT_ID,ad.E_MAIL,ad.REMARKS   FROM app_detail_second ad ").
append(" WHERE ad.APP_ID = '"+APP_ID+"' AND AD.OFF_CD="+vOffcd+"");
DBCon db= new DBCon();
db.connect();
ResultSet rsApp = db.execSQL(av.toString());

while (rsApp.next()){
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
 APP_REC_DATE=rsApp.getString("APP_REC_DATE")==null?"":rsApp.getString("APP_REC_DATE");
 REMARKS=rsApp.getString("REMARKS")==null?"":rsApp.getString("REMARKS");
 MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");


 ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
TIME_DIF=rsApp.getString("TIME_DIF")==null?"":rsApp.getString("TIME_DIF");
}

rsApp.close();


String RINT_TRANS_ID = "";
String RCOM_MODE = "";
String RNB_NAME = "";
String RNB_DESIG = "";
String RINT_TIME = "";
String RINT_REMARK = "";

StringBuffer qrysb1= new StringBuffer();




qrysb1.append(" SELECT "      );
qrysb1.append("  IT.INT_TRANS_ID,"      );
qrysb1.append(" CASE WHEN IT.COM_MODE='O' THEN"      );
qrysb1.append(" 'Other Mode'"      );
qrysb1.append("  WHEN  IT.COM_MODE='E' THEN"      );
qrysb1.append("  'e-Mail'"      );
qrysb1.append("  ELSE"  );
qrysb1.append("  'Phone or Mobile'"  );
qrysb1.append("   END COM_MODE,"  );
qrysb1.append("   IT.NB_NAME,"  );
qrysb1.append("   IT.NB_DESIG,"  );
qrysb1.append("   TO_CHAR(IT.INT_TIME,'DD-MON-RRRR HH:MM:SS') AS INT_TIME,"  );
qrysb1.append("   IT.INT_REMARK"      );
qrysb1.append("   FROM INTERACTION_TRANS_SECOND IT  WHERE APP_ID = '"+APP_ID+"' ORDER BY INT_TIME DESC" );


%>
<form name="form" id="form"  class="form" method="post" action="InteractionDetailUpdateSec.jsp">

  <table align="center">

  <tr>
    <th colspan="4"><div align="center"> 
      <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
      INTERACTION WITH APPLICANT </div></th>
  </tr>
  <tr>
    <th><input name="ins" type="hidden" id="ins">
      Applicant Id</span> :      </th>
    <th><%=APP_ID %>   </th>
    <th><div align="right">Name Of Applicant :</div></th>
    <th><%=  APP_NAME %></th>
  </tr>
  
  <tr >
    <td colspan="4"><div align="center" class="redLebel">(Note:  Interaction by Nodal Officer with Applicant must be recorded within 5 working days of submission of the application) </div></td>
    </tr>
  <tr >
    <th>Submission Date &amp; Time: </th>
    <th><%= ONLINE_SUBDT %></th>
    <th colspan="2" class="GreenLebel">Time : <%= TIME_DIF %></th>
    </tr>
  <tr >
    <td>eMail and Mobile No:</td>
    <td colspan="3"><%= E_MAIL %>,1st Mobile No:<%= MOB_NO1 %> and alternative No: <%= MOB_NO2 %> </td>
    </tr>
  
  
  <tr bgcolor="#FF9E5E" >
    <td colspan="4">&nbsp;</td>
    </tr>
  <tr >
    <th><div align="right">Interaction Mode : * </div></th>
    <td colspan="3" >      <input name="COM_MODE" id="COM_MODE" type="radio" value="E"> 
      By Email
        <input name="COM_MODE" type="radio" id="COM_MODE" value="M">        
        By Phone or Mobile 
        <input name="COM_MODE" type="radio" id="COM_MODE" value="O">
        By Other Mode </td>
  </tr>
  
  <tr >
    <th >Nodal Officer Name </th>
    <td >
        <input name="NB_NAME" type="text" id="NB_NAME" value="<%=NB_NAME%>" maxlength="30">    </td>
    <th >Designation </th>
    <td ><input name="NB_DESIG" type="text" id="NB_DESIG" value="<%=NB_DESIG%>" size="20" maxlength="20"></td>
  </tr>
  
  <tr >
    <th >Interaction  Date and Time </th>
    <td colspan="3" ><input name="INT_TIME" type="text" id="INT_TIME" value="<%=vTodayDt%>" size="20" maxlength="20"></td>
  </tr>
  <tr >
    <th > Interaction Detail in brief*:</th>
    <td colspan="3" >
      <input name="INT_REMARK" type="text" id="INT_REMARK" value="<%=INT_REMARK%>" size="70" maxlength="100">    </td>
  </tr>
  
  <tr>
    <th colspan="4"> 
        <div align="center">
		 <input name="Button" type="button" class="button" onClick="form_submit()" value="Save Record">

         
          <input name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
        </div></th>
  </tr>
</table>




  <p>&nbsp;</p>
  <table align="center">
  <tr>
    <th colspan="6"><div align="center">INTERACTION WITH APPLICANT </div></th>
    </tr>
  <tr>
    <th>ID</th>
    <th>Interaction Mode</th>
    <th>Nodal Officer Name </th>
    <th>Designation </th>
    <th>Interaction  Date and Time </th>
    <th>Interaction Detail in brief*:</th>
    </tr>
	
	<%
	
	ResultSet rsMain = db.execSQL(qrysb1.toString());


while (rsMain.next()){
RINT_TRANS_ID=rsMain.getString("INT_TRANS_ID")==null?"":rsMain.getString("INT_TRANS_ID");
RCOM_MODE=rsMain.getString("COM_MODE")==null?"":rsMain.getString("COM_MODE");
RNB_NAME=rsMain.getString("NB_NAME")==null?"":rsMain.getString("NB_NAME");
RNB_DESIG=rsMain.getString("NB_DESIG")==null?"":rsMain.getString("NB_DESIG");
RINT_TIME=rsMain.getString("INT_TIME")==null?"":rsMain.getString("INT_TIME");
RINT_REMARK=rsMain.getString("INT_REMARK")==null?"":rsMain.getString("INT_REMARK");

	
	%>
	
  <tr>
    <td><%= RINT_TRANS_ID %></td>
    <td><%= RCOM_MODE %> </td>
    <td><%= RNB_NAME %></td>
    <td><%= RNB_DESIG %></td>
    <td><%= RINT_TIME %></td>
    <td><%= RINT_REMARK %></td>
    </tr>
	
	<%
	}
rsMain.close();
	%>
</table>


    <% if (ins.equals("I")){

APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
INT_TRANS_ID=(String) request.getParameter("INT_TRANS_ID")==null?"":(String) request.getParameter("INT_TRANS_ID").trim();
NB_NAME=(String) request.getParameter("NB_NAME")==null?"":(String) request.getParameter("NB_NAME").trim();
NB_DESIG=(String) request.getParameter("NB_DESIG")==null?"":(String) request.getParameter("NB_DESIG").trim();
INT_TIME=(String) request.getParameter("INT_TIME")==null?"":(String) request.getParameter("INT_TIME").trim();
INT_REMARK=(String) request.getParameter("INT_REMARK")==null?"":(String) request.getParameter("INT_REMARK").trim();
COM_MODE=(String) request.getParameter("COM_MODE")==null?"":(String) request.getParameter("COM_MODE").trim();

 StringBuffer qryUpdate = new StringBuffer();
 qryUpdate.append("INSERT INTO INTERACTION_TRANS_SECOND ");
 qryUpdate.append(" ( INT_TRANS_ID,");
  qryUpdate.append("APP_ID,");
qryUpdate.append("NB_NAME,");
qryUpdate.append("NB_DESIG,");
qryUpdate.append("INT_REMARK,");
qryUpdate.append("COM_MODE)");

qryUpdate.append(" VALUES(?,?,?,?,?,?) ");
List values=new ArrayList();
List pstm=new ArrayList();
values.clear();
pstm.clear();

ResultSet rsMax= db.execSQL("SELECT NVL(MAX(INT_TRANS_ID),0)+1 FROM INTERACTION_TRANS_SECOND ");
while (rsMax.next()) {
INT_TRANS_ID=rsMax.getString(1);
}
rsMax.close();
values.add(INT_TRANS_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(NB_NAME); pstm.add ("L");
values.add(NB_DESIG); pstm.add ("L");
values.add(INT_REMARK); pstm.add ("L");
values.add(COM_MODE); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
response.sendRedirect("savemsg.jsp");
}
//out.print(qryUpdate.toString());

 %>
    </p>
</form>
</body>
</html>
