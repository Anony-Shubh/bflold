<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>
<html>
<head>

<title>v</title>
<script type="text/javascript" src="../js/popcalendar.js"></script>
<script>
function submit_offupdate(){
document.form1.ins.value='I'; 
document.form1.submit();
window.opener.location.reload();

}
</script>
<style type="text/css">
<!--
.txtBox {
    border: 0px solid #003366;
    background-color: #FFF4EA;
    font-family: verdana, arial, helvetica, sans-serif;
    font-size: 12pt;    
    color: #990000;
    font-weight: bold;
}
.style60 {color: #990000; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 14px; }

.styleTMH {font-size: 24px;color: #0000CC;font-family: Verdana, Arial, Helvetica, sans-serif;}
.style90 {
	font-size: 18px;
	color: #990000;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style93 {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style94 {font-family: Geneva, Arial, Helvetica, sans-serif}
.style96 {color: #FFFFFF}
body {
	background-color: #E3ECD9;
}
.style97 {
	font-size: 18px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #FFFFFF;
}
.style98 {font-size: 18px; color: #FFFFFF; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; }
.style99 {font-family: Geneva, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 18px; }
.style3 {	color: #000099;
	font-weight: bold;
}
.style100 {color: #990000; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; }
-->
</style>
</head>
<body >
<form  action="mtg_update.jsp" method="post" name="form1"  >
<%
String DISTRICT_CD="";
String vState= (String) session.getAttribute("state_cd");
String OFF_CD= (String) session.getAttribute("off_cd");
String MTG_ID ="";
String MT_DATE="";
String MTG_PLACE="";
String ACT_YN="";


if (request.getParameter("MTG_ID") != ""){
		MTG_ID = request.getParameter("MTG_ID");
	}else{
		MTG_ID = "0";
	}
	
try {
DBCon db= new DBCon();
db.connect();

String strDist="SELECT A.district_cd,A.district_name FROM M_DISTRICT A WHERE A.DISTRICT_STATUS='A' AND A.STATE_CD='"+vState+"'";
ResultSet rsDist = db.execSQL(strDist);


	ResultSet rsMtg = db.execSQL("SELECT MTG_ID, to_char(MT_DATE,'DD-MON-YYYY') as MT_DATE,OFF_CD,MTG_PLACE,DISTRICT_CD,ACT_YN FROM APP_MEETING_MAST WHERE MTG_ID="+MTG_ID+" ");
//office_detail
while (rsMtg.next()) {//

	if (rsMtg.getString("OFF_CD") != null){
		OFF_CD = rsMtg.getString("OFF_CD");
	}else{
		OFF_CD = "";
	}
	if (rsMtg.getString("DISTRICT_CD") != null){
		DISTRICT_CD = rsMtg.getString("DISTRICT_CD");
	}else{
		DISTRICT_CD = "";
	}
				if (rsMtg.getString("ACT_YN") != null){
		ACT_YN = rsMtg.getString("ACT_YN");
	}else{
		ACT_YN = "";
	}
				
	if (rsMtg.getString("MTG_ID") != null){
		MTG_ID = rsMtg.getString("MTG_ID");
	}else{
		MTG_ID = "";
	}
	if (rsMtg.getString("MT_DATE") != null){
		MT_DATE = rsMtg.getString("MT_DATE");
	}else{
		MT_DATE = "";
	}	
	if (rsMtg.getString("DISTRICT_CD") != null){
		DISTRICT_CD = rsMtg.getString("DISTRICT_CD");
	}else{
		DISTRICT_CD = "";
	}	
	if (rsMtg.getString("MTG_PLACE") != null){
		MTG_PLACE = rsMtg.getString("MTG_PLACE");
	}else{
		MTG_PLACE = "";
	}	
	
	}//end of while Meeting
	rsMtg.close();
	//end of display
	
	if ((String)request.getParameter("ins")!=null){
	
	if (request.getParameter("MTG_ID") != null){
		MTG_ID = request.getParameter("MTG_ID");
	}else{
		MTG_ID = "";
	}
	
	if (request.getParameter("OFF_CD") != null){
		OFF_CD = request.getParameter("OFF_CD");
	}else{
		OFF_CD = "";
	}
	if (request.getParameter("DISTRICT_CD") != null){
		DISTRICT_CD = request.getParameter("DISTRICT_CD");
	}else{
		DISTRICT_CD = "";
	}
	
	if (request.getParameter("ACT_YN") != null){
		ACT_YN = request.getParameter("ACT_YN");
	}else{
		ACT_YN = "";
	}

	if (request.getParameter("MT_DATE") != null){
		MT_DATE = request.getParameter("MT_DATE");
	}else{
		MT_DATE = "";
	}	
	if (request.getParameter("DISTRICT_CD") != null){
		DISTRICT_CD = request.getParameter("DISTRICT_CD");
	}else{
		DISTRICT_CD = "";
	}	
	
	if (request.getParameter("MTG_PLACE") != null){
		MTG_PLACE = request.getParameter("MTG_PLACE");
	}else{
		MTG_PLACE = "";
	}	
		}// end of Request parameter
		
%>

  <table  border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#000066" >
    <tr valign="baseline" bgcolor="#BC3F52">
      <td colspan="2" align="right" nowrap><div align="center" class="style90 style96"> TASK FORCE COMMITTEE MEEING FORM UPDATE FORM </div></td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="style90"><div align="left"><span class="style60">
</span></div>        <div align="left" class="style60">
  <div align="right">
     <input name="ins" type="hidden" id="ins">
     ID:</div>
</div></td>
      <td align="right" nowrap class="style90"><div align="left"><span class="style60"><span class="style90">
          <input name="MTG_ID" type="text" id="MTG_ID" value="<%=MTG_ID%>" size="10" readonly="true">
          <input name="OFF_CD" type="hidden" id="OFF_CD" value="<%= OFF_CD %>">
</span></span></div>        
      <div align="left"><span class="style60"><span class="style90">
      </span></span></div>      <div align="left">
      </div></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>Meeting Date: </td>
      <td><input name="MT_DATE" type="text" id="MT_DATE" value="<%=MT_DATE %>" size="30" readonly="true">
        <span class="style68"><span class="style63">
        <input name="btnCalander" type="image" id="ImageButton1" tabindex="6" onClick="popUpCalendar(this, this.form.MT_DATE,'dd-mmm-yyyy');return false;" src="images/ew_calendar.gif"width="16" height="15">
      </span></span></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>Meeting Place  :</td>
      <td>
      <input name="MTG_PLACE" type="text" id="MTG_PLACE" value="<%=MTG_PLACE %>" size="80" maxlength="80"> </td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>District:</td>
      <td><select name="DISTRICT_CD" id="DISTRICT_CD" tabindex="10">
        <option value="">--Select---</option>
        <%
		String cmbSel="";
while (rsDist.next()) {
if (rsDist.getString("DISTRICT_CD").toString().equals(DISTRICT_CD) ){
cmbSel="Selected";
}else{
cmbSel="";
}
%>
        <option value="<%=((rsDist.getString("DISTRICT_CD")!=null)?rsDist.getString("DISTRICT_CD"):"")%>" <%= cmbSel %>><%=((rsDist.getString("DISTRICT_NAME")!=null)?rsDist.getString("DISTRICT_NAME"):"")%></option>
        <%
}
rsDist.close();

%>
      </select>      </td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>Display in List (Yes/No)* </td>
      <td>
        <select name="ACT_YN" class="style60" id="ACT_YN">
          <option selected>-Select-</option>
          <option value="Y" <% if (ACT_YN.equals("Y")){ out.println("Selected");}%>>Yes</option>
          <option value="N" <%if (ACT_YN.equals("N")){ out.println("Selected");}%>>No</option>
        </select>
    When Meeting is completed and no need to display<br>
    in the fresh application for then select Display in List &quot;No &quot; </td>
    </tr>
  </table>

  <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#000066">
    <tr>
      <td bgcolor="D5EAFF" class="style60"><input name="Button" type="button" onClick="submit_offupdate();" value="Save"></td>
      <td colspan="4" bgcolor="D5EAFF" class="style60"><div align="center">
          <input name="btnCancel" type="button" id="btnCancel" onClick="window.close();" value="Cancel">
      </div></td>
    </tr>
  </table>
  <%
 
 if ((String)request.getParameter("ins")!=null){

 List values=new ArrayList();
List pstm=new ArrayList();
StringBuffer sb= new StringBuffer();


 values.clear();
 pstm.clear();
 
 sb.append("UPDATE APP_MEETING_MAST SET").
append(" MT_DATE=?, DISTRICT_CD=?,MTG_PLACE=?,OFF_CD=?,ACT_YN=? WHERE MTG_ID="+MTG_ID+"");

db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
 
 values.add (MT_DATE);pstm.add ("D");
 values.add (DISTRICT_CD);pstm.add ("D");
 values.add (MTG_PLACE);pstm.add ("D");
 values.add (OFF_CD);pstm.add ("D");
 values.add (ACT_YN);pstm.add ("D");
 
db.executeUpdate() ;

db.close();
response.sendRedirect("saveMessgwin.jsp");
response.flushBuffer();
return;

} //end ins
%>
<%
}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();
}
  %>
  
</form>
</body>
</html>
