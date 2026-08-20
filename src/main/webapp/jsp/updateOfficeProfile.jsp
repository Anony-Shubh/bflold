<%@ page session="true" buffer="64kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>
 
<% 
//APPLICANT_DATA
String ORG_CD="";
String OFF_TYPE_CD="";
String DISTRICT_CD="";
String OFF_ADDR1="";
String OFF_ADDR2="";
String CITY="";
String PINCODE="";
String OFF_TEL_NO="";
String OFF_FAX_NO="";
String OFF_EMAIL_ADDR="";
String OFF_NAME="";
String OFF_LONG_DESC="";
String CONT_PER1="";
String CONT_PER2="";
String PER1_NO="";
String PER2_NO="";
String PER1_EMAIL="";
String PER2_EMAIL="";
String ACT_YN="";
String STATE_CD="";
String STATE_NM=""; 
String OFF_CD = "";

try {
DBCon db= new DBCon();
db.connect();
if (request.getParameter("OFF_CD") != null){
		OFF_CD = request.getParameter("OFF_CD");
	}else{
		OFF_CD = "";
	}
if (request.getParameter("STATE_CD") != null){
		STATE_CD = request.getParameter("STATE_CD");
	}else{
		STATE_CD = "";
	}
if (request.getParameter("STATE_NM") != null){
		STATE_NM = request.getParameter("STATE_NM");
	}else{
		STATE_NM = "";
	}
	
StringBuffer av= new StringBuffer();
av.append(" SELECT * FROM MAS_OFF_MAST WHERE OFF_CD="+OFF_CD+"" );
ResultSet rsOff = db.execSQL(av.toString());
boolean rsOff_isEmpty = !rsOff.next();
boolean rsOff_hasData = !rsOff_isEmpty;
Object rsOff_data;
int rsOff_numRows = 0;


ResultSet rsDist = db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD='"+STATE_CD+"' AND DISTRICT_STATUS='A' ORDER BY DISTRICT_NAME");
boolean rsDist_isEmpty = !rsDist.next();
boolean rsDist_hasData = !rsDist_isEmpty;
Object rsDist_data;
int rsDist_numRows = 0;

ResultSet rsOfftp = db.execSQL("SELECT OFF_TYPE_CD,OFF_TYPE_SHORT_DESC FROM MAS_OFF_TYPE_CDMAST");
boolean rsOfftp_isEmpty = !rsOfftp.next();
boolean rsOfftp_hasData = !rsOfftp_isEmpty;
Object rsOfftp_data;
int rsOfftp_numRows = 0;


//office_detail
	if (rsOff.getString("OFF_CD") != null){
		OFF_CD = rsOff.getString("OFF_CD");
	}else{
		OFF_CD = "";
	}
	
 if (rsOff.getString("OFF_TYPE_CD") != null){
		OFF_TYPE_CD = rsOff.getString("OFF_TYPE_CD");
	}else{
		OFF_TYPE_CD = "";
	}
	if (rsOff.getString("DISTRICT_CD") != null){
		DISTRICT_CD = rsOff.getString("DISTRICT_CD");
	}else{
		DISTRICT_CD = "";
	}
	if (rsOff.getString("OFF_ADDR1") != null){
		OFF_ADDR1 = rsOff.getString("OFF_ADDR1");
	}else{
		OFF_ADDR1 = "";
	}
	
	if (rsOff.getString("OFF_ADDR2") != null){
		OFF_ADDR2= rsOff.getString("OFF_ADDR2");
	}else{
		OFF_ADDR2= "";
	}
	if (rsOff.getString("CITY") != null){
		CITY = rsOff.getString("CITY");
	}else{
		CITY = "";
	}
	if (rsOff.getString("PINCODE") != null){
		PINCODE = rsOff.getString("PINCODE");
	}else{
		PINCODE = "";
	}
	if (rsOff.getString("OFF_TEL_NO") != null){
		OFF_TEL_NO = rsOff.getString("OFF_TEL_NO");
	}else{
		OFF_TEL_NO = "";
	}
	if (rsOff.getString("OFF_FAX_NO") != null){
		OFF_FAX_NO = rsOff.getString("OFF_FAX_NO");
	}else{
		OFF_FAX_NO = "";
	}
	if (rsOff.getString("OFF_EMAIL_ADDR") != null){
		OFF_EMAIL_ADDR = rsOff.getString("OFF_EMAIL_ADDR");
	}else{
		OFF_EMAIL_ADDR = "";
	}
	if (rsOff.getString("OFF_NAME") != null){
		OFF_NAME = rsOff.getString("OFF_NAME");
	}else{
		OFF_NAME = "";
	}
	if (rsOff.getString("OFF_LONG_DESC") != null){
		OFF_LONG_DESC = rsOff.getString("OFF_LONG_DESC");
	}else{
		OFF_LONG_DESC = "";
	}
	if (rsOff.getString("CONT_PER1") != null){
		CONT_PER1 = rsOff.getString("CONT_PER1");
	}else{
		CONT_PER1 = "";
	}
	if (rsOff.getString("CONT_PER2") != null){
		CONT_PER2 = rsOff.getString("CONT_PER2");
	}else{
		CONT_PER2 = "";
	}
	if (rsOff.getString("PER1_NO") != null){
		PER1_NO = rsOff.getString("PER1_NO");
	}else{
		PER1_NO = "";
	}
	if (rsOff.getString("PER2_NO") != null){
		PER2_NO = rsOff.getString("PER2_NO");
	}else{
		PER2_NO = "";
	}
	if (rsOff.getString("PER1_EMAIL") != null){
		PER1_EMAIL = rsOff.getString("PER1_EMAIL");
	}else{
		PER1_EMAIL = "";
	}
	if (rsOff.getString("PER2_EMAIL") != null){
		PER2_EMAIL = rsOff.getString("PER2_EMAIL");
	}else{
		PER2_EMAIL = "";
	}
	
	if (rsOff.getString("ACT_YN") != null){
		ACT_YN = rsOff.getString("ACT_YN");
	}else{
		ACT_YN = "";
	}
    
		//end of display
	
	if ((String)request.getParameter("ins")!=null){
	
		
		if (request.getParameter("OFF_TYPE_CD") != null){
		OFF_TYPE_CD = request.getParameter("OFF_TYPE_CD");
	}else{
		OFF_TYPE_CD = "";
	}
	if (request.getParameter("DISTRICT_CD") != null){
		DISTRICT_CD = request.getParameter("DISTRICT_CD");
	}else{
		DISTRICT_CD = "";
	}
	if (request.getParameter("OFF_ADDR1") != null){
		OFF_ADDR1 = request.getParameter("OFF_ADDR1");
	}else{
		OFF_ADDR1 = "";
	}
	
	if (request.getParameter("OFF_ADDR2") != null){
		OFF_ADDR2= request.getParameter("OFF_ADDR2");
	}else{
		OFF_ADDR2= "";
	}
	if (request.getParameter("CITY") != null){
		CITY = request.getParameter("CITY");
	}else{
		CITY = "";
	}
	if (request.getParameter("PINCODE") != null){
		PINCODE = request.getParameter("PINCODE");
	}else{
		PINCODE = "";
	}
	if (request.getParameter("OFF_TEL_NO") != null){
		OFF_TEL_NO = request.getParameter("OFF_TEL_NO");
	}else{
		OFF_TEL_NO = "";
	}
	if (request.getParameter("OFF_FAX_NO") != null){
		OFF_FAX_NO = request.getParameter("OFF_FAX_NO");
	}else{
		OFF_FAX_NO = "";
	}
	if (request.getParameter("OFF_EMAIL_ADDR") != null){
		OFF_EMAIL_ADDR = request.getParameter("OFF_EMAIL_ADDR");
	}else{
		OFF_EMAIL_ADDR = "";
	}
	if (request.getParameter("OFF_NAME") != null){
		OFF_NAME = request.getParameter("OFF_NAME");
	}else{
		OFF_NAME = "";
	}
	if (request.getParameter("OFF_LONG_DESC") != null){
		OFF_LONG_DESC = request.getParameter("OFF_LONG_DESC");
	}else{
		OFF_LONG_DESC = "";
	}
	if (request.getParameter("CONT_PER1") != null){
		CONT_PER1 = request.getParameter("CONT_PER1");
	}else{
		CONT_PER1 = "";
	}
	if (request.getParameter("CONT_PER2") != null){
		CONT_PER2 = request.getParameter("CONT_PER2");
	}else{
		CONT_PER2 = "";
	}
	if (request.getParameter("PER1_NO") != null){
		PER1_NO = request.getParameter("PER1_NO");
	}else{
		PER1_NO = "";
	}
	if (request.getParameter("PER2_NO") != null){
		PER2_NO = request.getParameter("PER2_NO");
	}else{
		PER2_NO = "";
	}
	if (request.getParameter("PER1_EMAIL") != null){
		PER1_EMAIL = request.getParameter("PER1_EMAIL");
	}else{
		PER1_EMAIL = "";
	}
	if (request.getParameter("PER2_EMAIL") != null){
		PER2_EMAIL = request.getParameter("PER2_EMAIL");
	}else{
		PER2_EMAIL = "";
	}
	if (request.getParameter("ACT_YN") != null){
		ACT_YN = request.getParameter("ACT_YN");
	}else{
		ACT_YN = "";
	}

		
		}// end of Request parameter
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>PMEGP OFFICE UPDATE FORM</title>
<script>
function submit_offupdate(){
document.form1.ins.value='I'; 
document.form1.submit();
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
.style96 {color: #FFFFFF}
body {
	background-color: #E3ECD9;
}
.style98 {font-size: 18px; color: #FFFFFF; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; }
.style100 {color: #990000; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; }
-->
</style>
</head>
<body >
<form  action="off_update.jsp" method="post" name="form1"  >
  <table width="700"  border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#000066" >
    <tr valign="baseline" bgcolor="#BC3F52">
      <td colspan="4" align="right" nowrap><div align="center" class="style90 style96"> OFFICE ADDRESS UPDATE FORM </div></td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="style90"><div align="left"><span class="style60">
</span></div>        <div align="left" class="style60">
  <div align="right">
     <input name="ins" type="hidden" id="ins">
     ID:</div>
</div></td>
      <td align="right" nowrap class="style90"><div align="left"><span class="style60"><span class="style90">
          <input name="OFF_CD" type="text" class="txtBox" id="OFF_CD" value="<%=OFF_CD%>" size="10" readonly="true">
      </span></span></div>        <div align="left"><span class="style60"><span class="style90">
      </span></span></div></td>
      <td align="right" nowrap class="style90"><input name="STATE_CD" type="hidden" id="STATE_CD" value="<%= STATE_CD %>">
      State:</td>
      <td align="right" nowrap class="style90"><div align="left">
        <input name="STATE_NM" type="text" class="txtBox" id="STATE_NM" value="<%= STATE_NM %>" readonly="true">
      </div></td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="style60">Organisation Type: </td>
      <td class="style60"><span class="style100">
        <select name="ORG_CD" disabled="disabled" class="txtBox" id="ORG_CD">
          <option value="KVIC">KVIC</option>
          <option value="KVIB">KVIB</option>
          <option value="DIC">DIC</option>
          <option value="RGUMY">RGUMY</option>
        </select>
      </span></td>
      <td class="style60"><div align="right">Office Type  :</div></td>
      <td class="style60"><div align="right">
        <span class="style90">
        <select name="OFF_TYPE_CD" disabled="disabled" class="txtBox" id="OFF_TYPE_CD"tabindex="31" value="<%=OFF_TYPE_CD%>">
          <option value="">--Select---</option>
          <%
			String cmbSel="";
while (rsOfftp_hasData) {

if (rsOfftp.getObject("OFF_TYPE_CD").toString().equals(OFF_TYPE_CD) ){
cmbSel="Selected";
}else{
cmbSel="";
}
%>
          <option value="<%=((rsOfftp.getObject("OFF_TYPE_CD")!=null)?rsOfftp.getObject("OFF_TYPE_CD"):"")%>" <%= cmbSel %>><%=((rsOfftp.getObject("OFF_TYPE_SHORT_DESC")!=null)?rsOfftp.getObject("OFF_TYPE_SHORT_DESC"):"")%></option>
          <%
  rsOfftp_hasData = rsOfftp.next();
}//END OF WHILE
rsOfftp.close();
%>
        </select>
      </span>        <span class="style100">        </span>        <div align="left">        </div></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>Name (Short)</td>
      <td colspan="3"><input name="OFF_NAME" type="text" class="txtBox" id="OFF_NAME" value="<%=OFF_NAME %>" size="30" readonly="true"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>Address:</td>
      <td colspan="3">
      <input name="OFF_LONG_DESC" type="text" id="OFF_LONG_DESC" value="<%=OFF_LONG_DESC %>" size="80" maxlength="80">      </span></span></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>&nbsp;</td>
      <td colspan="3"><input name="OFF_ADDR1" type="text" id="OFF_ADDR1" value="<%=OFF_ADDR1 %>" size="79" maxlength="79"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>&nbsp;</td>
      <td colspan="3"><input name="OFF_ADDR2" type="text" id="OFF_ADDR2" value="<%=OFF_ADDR2 %>" size="75" maxlength="75">        <div align="right"></div></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>City/Town:</td>
      <td colspan="3"><input name="CITY" type="text" id="CITY" value="<%=CITY %>"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>District:</td>
      <td><select name="DISTRICT_CD" id="DISTRICT_CD" tabindex="10">
        <option value="">--Select---</option>
        <%
while (rsDist_hasData) {
if (rsDist.getObject("DISTRICT_CD").toString().equals(DISTRICT_CD) ){
cmbSel="Selected";
}else{
cmbSel="";
}
%>
        <option value="<%=((rsDist.getObject("DISTRICT_CD")!=null)?rsDist.getObject("DISTRICT_CD"):"")%>" <%= cmbSel %>><%=((rsDist.getObject("DISTRICT_NAME")!=null)?rsDist.getObject("DISTRICT_NAME"):"")%></option>
        <%
  rsDist_hasData = rsDist.next();
}
rsDist.close();

%>
      </select></td>
      <td><div align="right">Pin:</div></td>
      <td><input name="PINCODE" type="text" id="PINCODE" value="<%=PINCODE %>"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>Telephone No. </td>
      <td><input name="OFF_TEL_NO" type="text" id="OFF_TEL_NO" value="<%=OFF_TEL_NO %>"></td>
      <td><div align="right">Fax No.</div></td>
      <td><input name="OFF_FAX_NO" type="text" id="OFF_FAX_NO" value="<%=OFF_FAX_NO %>"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>e-Mail:</td>
      <td><input name="OFF_EMAIL_ADDR" type="text" id="OFF_EMAIL_ADDR" value="<%=OFF_EMAIL_ADDR %>"></td>
      <td><div align="right">Active(Yes/no):</div></td>
      <td><select name="ACT_YN" disabled="disabled" class="txtBox" id="ACT_YN">
        <option value="Y">YES</option>
        <option value="N">NO</option>
      </select></td>
    </tr>
  </table>

  <table width="700" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">
    <tr bgcolor="#BC3F52" class="style60">
      <td colspan="4"><div align="center" class="style98">Contact Person Detail </div></td>
    </tr>
    <tr bgcolor="#E3ECD9" class="style60">
      <td width="58"><div align="center">Sr. No. </div></td>
      <td width="240"><div align="center">Name &amp; Designation </div></td>
      <td width="180"><div align="center">Telephone (STD)/<br>Mobile No </div></td>
      <td width="180" bgcolor="#E3ECD9"><div align="center">Email</div></td>
    </tr>
    <tr bgcolor="#E3ECD9">
      <td class="style60">(1)</td>
      <td><input name="CONT_PER1" type="text" id="CONT_PER1" size="40" maxlength="50" value="<%=CONT_PER1 %>"></td>
      <td><div align="center">
        <input name="PER1_NO" type="text" id="PER1_NO" size="30" value="<%=PER1_NO %>">
      </div></td>
      <td><input name="PER1_EMAIL" type="text" id="PER1_EMAIL" size="25" value="<%=PER1_EMAIL %>"></td>
    </tr>
    <tr bgcolor="#E3ECD9">
      <td class="style60">(2)</td>
      <td><input name="CONT_PER2" type="text" id="CONT_PER2" size="40" maxlength="50" value="<%=CONT_PER2 %>"></td>
      <td><div align="center">
        <input name="PER2_NO" type="text" id="PER2_NO" size="30" value="<%=PER2_NO %>">
      </div></td>
      <td><input name="PER2_EMAIL" type="text" id="PER2_EMAIL" value="<%=PER2_EMAIL %>" size="25"></td>
    </tr>
  </table>
  <table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#000066">
    <tr>
      <td bgcolor="D5EAFF" class="style60"><input name="Button" type="button" onClick="submit_offupdate();" value="Save"></td>
      <td colspan="4" bgcolor="D5EAFF" class="style60"><div align="center">
          <input name="btnCancel" type="button" id="btnCancel" onClick="parent.location='mainMenuPMEGP.jsp'" value="Cancel">
      </div></td>
    </tr>
  </table>
  <%
 
 if ((String)request.getParameter("ins")!=null){

 List values=new ArrayList();
List pstm=new ArrayList();
StringBuffer sb= new StringBuffer();

sb.append("UPDATE MAS_OFF_MAST SET ").
append(" DISTRICT_CD=?,OFF_ADDR1=?, OFF_ADDR2=?, CITY=?, PINCODE=?,").
append("OFF_TEL_NO=?, OFF_FAX_NO=?, OFF_EMAIL_ADDR=?, OFF_LONG_DESC=?, ").
append("CONT_PER1=?,CONT_PER2=?, PER1_NO=?,PER2_NO=?,PER1_EMAIL=?,PER2_EMAIL=?").
append(" where OFF_CD='"+OFF_CD+"'" );

 values.clear();
 pstm.clear();
 
 values.add (DISTRICT_CD);pstm.add ("D");
 values.add (OFF_ADDR1);pstm.add ("D");
 values.add (OFF_ADDR2);pstm.add ("D");
 values.add (CITY);pstm.add ("D");
 values.add (PINCODE);pstm.add ("D");
 values.add (OFF_TEL_NO);pstm.add ("D");

 values.add (OFF_FAX_NO);pstm.add ("D");
 values.add (OFF_EMAIL_ADDR);pstm.add ("D");
 values.add (OFF_LONG_DESC);pstm.add ("T");
 values.add (CONT_PER1);pstm.add ("D");
 values.add (CONT_PER2);pstm.add ("D");
 values.add (PER1_NO);pstm.add ("D");
 values.add (PER2_NO);pstm.add ("D");
 values.add (PER1_EMAIL);pstm.add ("D");
 values.add (PER2_EMAIL);pstm.add ("D");
  
db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;
db.close();
 response.sendRedirect("offview.jsp");

} //end ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();
}
  %>
  
</form>
<p class="style2">&nbsp;</p>
</body>
</html>
