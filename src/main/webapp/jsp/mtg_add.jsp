<%@ page session="true" buffer="64kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>
 
<html>
<head>
<title>DLTFC_MEETING_UPDATE</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<!--<script type="text/javascript" src="../js/popcalendar.js"></script>-->
<script src="../js/inlineMsgMain.js"></script>
<script>
function submit_offupdate(){
  var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
   var MT_DATE= document.getElementById("MT_DATE").value;
  if (MT_DATE != "") {
	if  (!dtRegex.test(MT_DATE)){
	inlineMsg('MT_DATE',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	 }
  }
document.form1.ins.value='I'; 
document.form1.submit();
window.opener.location.reload();
//window.close();
}
</script>
</head>
<body >

<form  action="mtg_add.jsp" method="post" name="form1"  >

<% 
//APPLICANT_DATA

String DISTRICT_CD="";
String vState= (String) session.getAttribute("sStatecd");
String OFF_CD= (String) session.getAttribute("sOffCd");
String MTG_ID =request.getParameter("MTG_ID")==null?"0":(String) request.getParameter("MTG_ID");
String MT_DATE="";
String MTG_PLACE="";
String ACT_YN="";
String CONV_NAME="";
String CONV_DESIG="";
String CONV_EMAIL="";
String LDM_NAME="";
String LDM_DESIG="";
String LDM_EMAIL="";
String LDM_BNAME="";
	
try {
DBCon db= new DBCon();
db.connect();

String strDist="SELECT A.district_cd,A.district_name FROM M_DISTRICT A WHERE A.DISTRICT_STATUS='A' and A.STATE_CD='"+vState+"'";
ResultSet rsDist = db.execSQL(strDist);






 StringBuffer qrysb = new StringBuffer();

qrysb.append("SELECT MTG_ID, ");
qrysb.append("TO_CHAR(MT_DATE,'DD-MON-RRRR') AS MT_DATE,");
qrysb.append("OFF_CD,");
qrysb.append("MTG_PLACE,");
qrysb.append("DISTRICT_CD,");
qrysb.append("ACT_YN,");
qrysb.append("CONV_NAME,");
qrysb.append("CONV_DESIG,");
qrysb.append("CONV_EMAIL,");
qrysb.append("LDM_NAME,");
qrysb.append("LDM_DESIG,");
qrysb.append("LDM_EMAIL,");
qrysb.append("LDM_BNAME,");
qrysb.append("MT_DATE ");
qrysb.append(" FROM APP_MEETING_MAST WHERE MTG_ID="+MTG_ID+" ");

ResultSet rsMain = db.execSQL(qrysb.toString());

 while (rsMain.next()){
 
MT_DATE=rsMain.getString("MT_DATE")==null?"":rsMain.getString("MT_DATE");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
MTG_PLACE=rsMain.getString("MTG_PLACE")==null?"":rsMain.getString("MTG_PLACE");
DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
ACT_YN=rsMain.getString("ACT_YN")==null?"":rsMain.getString("ACT_YN");
CONV_NAME=rsMain.getString("CONV_NAME")==null?"":rsMain.getString("CONV_NAME");
CONV_DESIG=rsMain.getString("CONV_DESIG")==null?"":rsMain.getString("CONV_DESIG");
CONV_EMAIL=rsMain.getString("CONV_EMAIL")==null?"":rsMain.getString("CONV_EMAIL");
LDM_NAME=rsMain.getString("LDM_NAME")==null?"":rsMain.getString("LDM_NAME");
LDM_DESIG=rsMain.getString("LDM_DESIG")==null?"":rsMain.getString("LDM_DESIG");
LDM_EMAIL=rsMain.getString("LDM_EMAIL")==null?"":rsMain.getString("LDM_EMAIL");
LDM_BNAME=rsMain.getString("LDM_BNAME")==null?"":rsMain.getString("LDM_BNAME");

 
 }

rsMain.close();
		%>
  <table  border="1" align="center"  class="pmegpTable" >
    <tr   >
      <th colspan="2" align="right" nowrap><div align="center">TASK FORCE COMMITTEE MEEING FORM DATA ENTRY<span >
          <input name="MTG_ID" type="hidden" id="MTG_ID" value="<%=MTG_ID%>">
          <input name="ACT_YN" type="hidden"  id="ACT_YN" value="Y">
          <input name="ins" type="hidden" id="ins">
      </div></th>
    </tr>
    
    <tr  >
      <th align="right" nowrap>Meeting Date*: </th>
      <td><input name="MT_DATE" type="text" id="MT_DATE" placeholder="DD-MON-YYYY" value="<%=MT_DATE %>" size="15" maxlength="15">      </td>
    </tr>
    <tr  >
      <th align="right" nowrap>Meeting Place*  :</th>
      <td>
      <input name="MTG_PLACE" type="text" id="MTG_PLACE" value="<%=MTG_PLACE %>" size="80" maxlength="99">     </td>
    </tr>
    <tr  >
      <th align="right" nowrap>District*:</th>
      <td><select name="DISTRICT_CD" class="button" id="DISTRICT_CD" tabindex="10">
        <option value="">--Select---</option>
        <%
		String cmbSel="";
		String DISTRICT_CD_DW="";
		String DISTRICT_NAME="";
while (rsDist.next()) {
DISTRICT_CD_DW =rsDist.getString("DISTRICT_CD")==null?"":rsDist.getString("DISTRICT_CD");
DISTRICT_NAME=rsDist.getString("DISTRICT_NAME")==null?"":rsDist.getString("DISTRICT_NAME");
cmbSel=DISTRICT_CD.toString().equals(DISTRICT_CD_DW)?"Selected":"";
%>
        <option value="<%= DISTRICT_CD_DW %>" <%= cmbSel %>><%= DISTRICT_NAME %></option>
 <%
}
rsDist.next();
rsDist.close();
%>
      </select>      </td>
    </tr>
    <tr  >
      <th colspan="2" align="right" nowrap><div align="center">
      <div align="center">CHAIRMAN </div></th>
    </tr>
    <tr  >
      <th align="right" nowrap> Name: </th>
      <td><input name="CONV_NAME" type="text" id="CONV_NAME" value="<%=CONV_NAME %>" size="50" maxlength="50" ></td>
    </tr>
    <tr  >
      <th align="right" nowrap>Designation</th>
      <td><input name="CONV_DESIG" type="text" id="CONV_DESIG" value="<%=CONV_DESIG %>" size="30" maxlength="30" ></td>
    </tr>
    <tr  >
      <th align="right" nowrap>eMail:</th>
      <td><input name="CONV_EMAIL" type="text" id="CONV_EMAIL" value="<%=CONV_EMAIL %>" size="50" maxlength="50" ></td>
    </tr>
    <tr  >
      <th colspan="2" align="right" nowrap><div align="center">
      <div align="center">Lead Bank Manger (LDM) </div></th>
    </tr>
    <tr  >
      <th align="right" nowrap>Name:</th>
      <td><input name="LDM_NAME" type="text" id="LDM_NAME" value="<%=LDM_NAME %>" size="50" maxlength="50" ></td>
    </tr>
    <tr  >
      <th align="right" nowrap>Designation:</th>
      <td><input name="LDM_DESIG" type="text" id="LDM_DESIG" value="<%=LDM_DESIG %>" size="30" maxlength="30" ></td>
    </tr>
    <tr  >
      <th align="right" nowrap>Bank Name: </th>
      <td><input name="LDM_BNAME" type="text" id="LDM_BNAME" value="<%=LDM_BNAME %>" size="50" maxlength="50" ></td>
    </tr>
    <tr  >
      <th align="right" nowrap>eMail:</th>
      <td><input name="LDM_EMAIL" type="text" id="LDM_EMAIL" value="<%=CONV_EMAIL %>" size="60" maxlength="60" ></td>
    </tr>
    <tr  >
      <th colspan="2" align="right" nowrap><div align="center">
        <input name="Button" type="button" class="button" onClick="submit_offupdate();" value="Save">
        <input name="btnCancel" type="button" class="button" id="btnCancel" onClick="self.close()" value="Cancel">
      </div></th>
    </tr>
  </table>

  <%
 
 if ((String)request.getParameter("ins")!=null){
 
 
 MTG_ID=(String) request.getParameter("MTG_ID")==null?"":(String) request.getParameter("MTG_ID").trim();
MT_DATE=(String) request.getParameter("MT_DATE")==null?"":(String) request.getParameter("MT_DATE").trim();
MTG_PLACE=(String) request.getParameter("MTG_PLACE")==null?"":(String) request.getParameter("MTG_PLACE").trim();
DISTRICT_CD=(String) request.getParameter("DISTRICT_CD")==null?"":(String) request.getParameter("DISTRICT_CD").trim();
ACT_YN=(String) request.getParameter("ACT_YN")==null?"":(String) request.getParameter("ACT_YN").trim();
CONV_NAME=(String) request.getParameter("CONV_NAME")==null?"":(String) request.getParameter("CONV_NAME").trim();
CONV_DESIG=(String) request.getParameter("CONV_DESIG")==null?"":(String) request.getParameter("CONV_DESIG").trim();
CONV_EMAIL=(String) request.getParameter("CONV_EMAIL")==null?"":(String) request.getParameter("CONV_EMAIL").trim();
LDM_NAME=(String) request.getParameter("LDM_NAME")==null?"":(String) request.getParameter("LDM_NAME").trim();
LDM_DESIG=(String) request.getParameter("LDM_DESIG")==null?"":(String) request.getParameter("LDM_DESIG").trim();
LDM_EMAIL=(String) request.getParameter("LDM_EMAIL")==null?"":(String) request.getParameter("LDM_EMAIL").trim();
LDM_BNAME=(String) request.getParameter("LDM_BNAME")==null?"":(String) request.getParameter("LDM_BNAME").trim();

 
 List values=new ArrayList();
List pstm=new ArrayList();
StringBuffer sb= new StringBuffer();

 values.clear();
 pstm.clear();
 
 if (MTG_ID.equals("0")) {
sb.append("INSERT INTO APP_MEETING_MAST").
append(" ( MT_DATE,DISTRICT_CD,MTG_PLACE,OFF_CD,ACT_YN,  CONV_NAME,CONV_DESIG,CONV_EMAIL, LDM_NAME,LDM_DESIG,LDM_EMAIL,LDM_BNAME,MTG_ID) values(?,?,?,?,?,  ?,?,?, ?,?,?,?,?)");
}else {
sb.append("UPDATE APP_MEETING_MAST ").
append(" SET MT_DATE=?,DISTRICT_CD=?,MTG_PLACE=?,OFF_CD=?,ACT_YN=?,  CONV_NAME=?,CONV_DESIG=?,CONV_EMAIL=?, LDM_NAME=?,LDM_DESIG=?,LDM_EMAIL=?,LDM_BNAME=? WHERE MTG_ID=?");
}

db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
 
 values.add (MT_DATE);pstm.add ("D");
 values.add (DISTRICT_CD);pstm.add ("D");
 values.add (MTG_PLACE);pstm.add ("D");
 values.add (OFF_CD);pstm.add ("D");
 values.add (ACT_YN);pstm.add ("D");
  values.add (CONV_NAME);pstm.add ("D");
   values.add (CONV_DESIG);pstm.add ("D");
    values.add (CONV_EMAIL);pstm.add ("D");
	  values.add (LDM_NAME);pstm.add ("D");
   values.add (LDM_DESIG);pstm.add ("D");
    values.add (LDM_EMAIL);pstm.add ("D");
	  values.add (LDM_BNAME);pstm.add ("D");
	  	  values.add (MTG_ID);pstm.add ("D");
 
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
