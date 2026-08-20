<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>


<HTML>
<HEAD>
<TITLE>
</TITLE>
        <SCRIPT src='js/jquery-3.2.1.min.js' type='text/javascript'></SCRIPT>
        <SCRIPT src='select2/dist/js/select2.min.js' type='text/javascript'></SCRIPT>
<SCRIPT type="text/javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<SCRIPT language="javascript" src="js/datetimepicker_css.js"></SCRIPT>
<SCRIPT language="javascript" src="js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript" src="js/sweetalert.min.js"></SCRIPT>
        <LINK href='select2/dist/css/select2.min.css' rel='stylesheet' type='text/css'>

<SCRIPT language="javascript">

 function isNumber(evt) {
		var TR_AMT = (evt.which) ? evt.which : evt.keyCode
		if (TR_AMT != 46 && TR_AMT > 31 && (TR_AMT < 48 || TR_AMT > 57))
		
        return false;
        return true;
    }    
	
function submitform() {

var APP_ID = document.form.APP_ID.value;
var APP_NAME = document.form.APP_NAME.value;
var BENF_CATEGORY_CD = document.form.BENF_CATEGORY_CD.value;
var GENDER = document.form.GENDER.value;
var TEL_NO = document.form.TEL_NO.value;
var UNIT_LOC = document.form.UNIT_LOC.value;
var UNIT_POST_ADDR = document.form.UNIT_POST_ADDR.value;
var UNIT_TALUK_BLOCK = document.form.UNIT_TALUK_BLOCK.value;
var UNIT_PIN = document.form.UNIT_PIN.value;
var PRJ_COST = document.form.PRJ_COST.value;
var EMP_ENV = document.form.EMP_ENV.value;
var BANK_NAME = document.form.BANK_NAME.value;
var IFSC_CODE = document.form.IFSC_CODE.value;
var IND_TYPE = document.form.IND_TYPE.value;
var IND_ACTIVITY = document.form.IND_ACTIVITY.value;
var MM_AMT = document.form.MM_AMT.value;
var MM_REL_DT = document.form.MM_REL_DT.value;
var PHY_DT = document.form.PHY_DT.value;
var PHY_STATUS = document.form.PHY_STATUS.value;
var UNIT_NAME = document.form.UNIT_NAME.value;
var PRODUCT_DESC = document.form.PRODUCT_DESC.value;
var PHY_VER_AGEN_NM = document.form.PHY_VER_AGEN_NM.value;
var EST_DATE = document.form.EST_DATE.value;
var EDP_RGY_YN = document.form.EDP_RGY_YN.value;
var MM_CALL_BACK = document.form.MM_CALL_BACK.value;
var CALL_BACK_AMT = document.form.CALL_BACK_AMT.value;
var PHY_YR = document.form.PHY_YR.value;

if(APP_ID==""){
 swal ( 'Note:','Please enter Applicant Id','error');	return (false);
}	
if(APP_NAME==""){
 swal ( 'Note:','Please enter Beneficiary Name','error');	return (false);
}	
if(BENF_CATEGORY_CD==""){
 swal ( 'Note:','Please select Category','error');	return (false);
}
if(GENDER==""){
 swal ( 'Note:','Please enter Gender','error');	return (false);
}	
if(TEL_NO==""){
 swal ( 'Note:','Please enter Contact No','error');	return (false);
}
if(UNIT_NAME==""){
 swal ( 'Note:','Please enter Unit Name','error');	return (false);
}
if(EST_DATE==""){
 swal ( 'Note:','Please enter Establishment Date','error');	return (false);
}
if(UNIT_LOC==""){
 swal ( 'Note:','Please select Unit Location','error');	return (false);
}
if(UNIT_POST_ADDR==""){
 swal ( 'Note:','Please enter Unit Address','error');	return (false);
}
if(UNIT_TALUK_BLOCK==""){
 swal ( 'Note:','Please enter Taluka Block','error');	return (false);
}
if(UNIT_DIST_CD==""){
 swal ( 'Note:','Please select District','error');	return (false);
}
if(UNIT_PIN==""){
 swal ( 'Note:','Please enter Unit Pincode','error');	return (false);
}
if(IND_TYPE==""){
 swal ( 'Note:','Please select Industry Type','error');	return (false);
}
if(IND_ACTIVITY==""){
 swal ( 'Note:','Please enter Industry Activity','error');	return (false);
}
if(PRODUCT_DESC==""){
 swal ( 'Note:','Please enter Product Description','error');	return (false);
}
if(PRJ_COST==""){
 swal ( 'Note:','Please enter Project Cost','error');	return (false);
}
if(BANK_NAME==""){
 swal ( 'Note:','Please select Bank Name','error');	return (false);
}
if(MM_AMT==""){
 swal ( 'Note:','Please enter MM Amount','error');	return (false);
}
if(MM_REL_DT==""){
 swal ( 'Note:','Please enter MM Release Date','error');	return (false);
}
if(EMP_ENV==""){
 swal ( 'Note:','Please enter Employment','error');	return (false);
}
if(EDP_RGY_YN==""){
 swal ( 'Note:','Please select whether EDP Completed or not','error');	return (false);
}
if(PHY_DT==""){
 swal ( 'Note:','Please enter Physical Verification Date','error');	return (false);
}
if(PHY_VER_AGEN_NM==""){
 swal ( 'Note:','Please enter Physical Verification Agency Name','error');	return (false);
}
if(MM_CALL_BACK==""){
 swal ( 'Note:','Please select whether MM Call back','error');	return (false);
}		
if (MM_CALL_BACK == "Y") {	

if(CALL_BACK_AMT==""){
 swal ( 'Note:','Please enter MM Call Amount','error');	return (false);
}

}
if(PHY_YR==""){
 swal ( 'Note:','Please select Physical Year','error');	return (false);
}	


document.form.ins.value='I';
document.form.submit();
}

 function isNumberKey(txt, evt) {

    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode == 46) {
        //Check if the text already contains the . character
        if (txt.value.indexOf('.') === -1) {
            return true;
        } else {
            return false;
        }
    } else {
        if (charCode > 31
             && (charCode < 48 || charCode > 57))
            return false;
    }
    return true;
}

</SCRIPT>

<STYLE type="text/css">
.myButton {
	background-color:#50c73e;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}

* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 90%;
}



#customers td, #customers th {
    border: 1px solid #000000;
    padding: 4px;
	font-size:13px;
	font-weight:bold;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: #2e7d22;
    color: white;
}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.style1 {color: #FF0000}
</STYLE>

</HEAD>
<BODY>

<FORM  name="form" id="form" method="post" >
<%@ include file = "sessionoutinc.jsp" %>
<%

List values=new ArrayList();
//List pstm=new ArrayList();
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String PHYV_TRID=request.getParameter("PHYV_TRID")==null?"":(String) request.getParameter("PHYV_TRID");
String APP_ID=request.getParameter("PAPP_ID")==null?"":(String) request.getParameter("PAPP_ID");
String OFF_CD = "";
String APP_NAME=request.getParameter("PAPP_NAME")==null?"":(String) request.getParameter("PAPP_NAME");
String BENF_CATEGORY_CD=request.getParameter("PBENF_CATAGORY_CD")==null?"":(String) request.getParameter("PBENF_CATAGORY_CD");
String GENDER=request.getParameter("PGENDER")==null?"":(String) request.getParameter("PGENDER");
String TEL_NO=request.getParameter("PTEL_NO")==null?"":(String) request.getParameter("PTEL_NO");
String EMAIL=request.getParameter("PE_MAIL")==null?"":(String) request.getParameter("PE_MAIL");
String UNIT_LOC=request.getParameter("PUNIT_LOC")==null?"":(String) request.getParameter("PUNIT_LOC");
String UNIT_POST_ADDR=request.getParameter("PUNIT_POST_ADDR")==null?"":(String) request.getParameter("PUNIT_POST_ADDR");
String UNIT_TALUK_BLOCK=request.getParameter("PUNIT_TALUK_BLOCK")==null?"":(String) request.getParameter("PUNIT_TALUK_BLOCK");
String UNIT_DIST_CD=request.getParameter("PUNIT_DIST_CD")==null?"":(String) request.getParameter("PUNIT_DIST_CD");
String PUNIT_DIST_CD=request.getParameter("PUNIT_DIST_CD")==null?"":(String) request.getParameter("PUNIT_DIST_CD");
String UNIT_PIN=request.getParameter("PUNIT_PIN")==null?"":(String) request.getParameter("PUNIT_PIN");
String PRJ_COST=request.getParameter("PTOT")==null?"":(String) request.getParameter("PTOT");
String EMP_ENV = "";
String BANK_NAME=request.getParameter("PBANK_NAME")==null?"":(String) request.getParameter("PBANK_NAME");
String PBANK_NAME=request.getParameter("PBANK_NAME")==null?"":(String) request.getParameter("PBANK_NAME");
String IFSC_CODE=request.getParameter("BR_CODE")==null?"":(String) request.getParameter("BR_CODE");
String TIMESTAMP = "";
String IND_TYPE=request.getParameter("PIND_TYPE")==null?"":(String) request.getParameter("PIND_TYPE");
String IND_ACTIVITY=request.getParameter("PIND_ACTIVITY")==null?"":(String) request.getParameter("PIND_ACTIVITY");
String PIND_ACTIVITY=request.getParameter("PIND_ACTIVITY")==null?"":(String) request.getParameter("PIND_ACTIVITY");
String MM_AMT = "";
String MM_REL_DT = "";
String PHY_DT = "";
String AADHAR_UDYOG_NO = "";
String PHY_STATUS = "";
String UNIT_NAME = "";
String PRODUCT_DESC = "";
String PHY_VER_AGEN_NM = "";
String EST_DATE = "";
String EDP_RGY_YN = "";
String MM_CALL_BACK = "";
String CALL_BACK_AMT = "";
String REMARKS = "";
String PHY_YR="";
String Activity_desc = "";
String Bank_desc = "";
String add_update="I";
//out.print(UNIT_DIST_CD);
DBCon db= new DBCon();
db.connect();

//String qrystr="";

if (!PHYV_TRID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BAD.PHYV_TRID,"      );
qrysb.append("     BAD.APP_ID,"      );
qrysb.append("     BAD.OFF_CD,"      );
qrysb.append("     BAD.APP_NAME,"      );
qrysb.append("     BAD.BENF_CATEGORY_CD,"      );
qrysb.append("     BAD.GENDER,"      );
qrysb.append("     BAD.TEL_NO,"      );
qrysb.append("     BAD.EMAIL,"      );
qrysb.append("     BAD.UNIT_LOC,"      );
qrysb.append("     BAD.UNIT_POST_ADDR,"      );
qrysb.append("     BAD.UNIT_TALUK_BLOCK,"      );
qrysb.append("     BAD.UNIT_DIST_CD,"      );
qrysb.append("     BAD.UNIT_PIN,"      );
qrysb.append("     BAD.PRJ_COST,"      );
qrysb.append("     BAD.EMP_ENV,"      );
qrysb.append("     BAD.BANK_NAME,"      );
qrysb.append("     BAD.IFSC_CODE,"      );
qrysb.append("     BAD.IND_TYPE,"      );
qrysb.append("     BAD.MM_AMT,"      );
qrysb.append("     BAD.IND_ACTIVITY,"      );
qrysb.append("     TO_CHAR(BAD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,"      );
qrysb.append("     TO_CHAR(BAD.PHY_DT,'DD-MON-RRRR') AS PHY_DT,"      );
qrysb.append("     BAD.AADHAR_UDYOG_NO,"      );
qrysb.append("     BAD.PHY_STATUS,"      );
qrysb.append("     BAD.UNIT_NAME,"      );
qrysb.append("     BAD.PRODUCT_DESC,"      );
qrysb.append("     BAD.PHY_VER_AGEN_NM,"      );
qrysb.append("     TO_CHAR(BAD.EST_DATE,'DD-MON-RRRR') AS EST_DATE,"      );
qrysb.append("     BAD.MM_CALL_BACK,"      );
qrysb.append("     BAD.EDP_RGY_YN,"      );
qrysb.append("     BAD.CALL_BACK_AMT,BAD.PHY_YR,"      );
qrysb.append("     BAD.REMARKS"      );
qrysb.append("   FROM BNF_APP_DETAIL BAD WHERE BAD.PHYV_TRID=?"      );



  values.add(PHYV_TRID);
  //out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){
PHYV_TRID=rsMain.getString("PHYV_TRID")==null?"":rsMain.getString("PHYV_TRID");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
BENF_CATEGORY_CD=rsMain.getString("BENF_CATEGORY_CD")==null?"":rsMain.getString("BENF_CATEGORY_CD");
GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
TEL_NO=rsMain.getString("TEL_NO")==null?"":rsMain.getString("TEL_NO");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
UNIT_LOC=rsMain.getString("UNIT_LOC")==null?"":rsMain.getString("UNIT_LOC");
UNIT_POST_ADDR=rsMain.getString("UNIT_POST_ADDR")==null?"":rsMain.getString("UNIT_POST_ADDR");
UNIT_TALUK_BLOCK=rsMain.getString("UNIT_TALUK_BLOCK")==null?"":rsMain.getString("UNIT_TALUK_BLOCK");
UNIT_DIST_CD=rsMain.getString("UNIT_DIST_CD")==null?"":rsMain.getString("UNIT_DIST_CD");
UNIT_PIN=rsMain.getString("UNIT_PIN")==null?"":rsMain.getString("UNIT_PIN");
PRJ_COST=rsMain.getString("PRJ_COST")==null?"":rsMain.getString("PRJ_COST");
EMP_ENV=rsMain.getString("EMP_ENV")==null?"":rsMain.getString("EMP_ENV");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
IND_ACTIVITY=rsMain.getString("IND_ACTIVITY")==null?"":rsMain.getString("IND_ACTIVITY");
MM_AMT=rsMain.getString("MM_AMT")==null?"":rsMain.getString("MM_AMT");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
PHY_DT=rsMain.getString("PHY_DT")==null?"":rsMain.getString("PHY_DT");
AADHAR_UDYOG_NO=rsMain.getString("AADHAR_UDYOG_NO")==null?"":rsMain.getString("AADHAR_UDYOG_NO");
PHY_STATUS=rsMain.getString("PHY_STATUS")==null?"":rsMain.getString("PHY_STATUS");
UNIT_NAME=rsMain.getString("UNIT_NAME")==null?"":rsMain.getString("UNIT_NAME");
PRODUCT_DESC=rsMain.getString("PRODUCT_DESC")==null?"":rsMain.getString("PRODUCT_DESC");
PHY_VER_AGEN_NM=rsMain.getString("PHY_VER_AGEN_NM")==null?"":rsMain.getString("PHY_VER_AGEN_NM");
EST_DATE=rsMain.getString("EST_DATE")==null?"":rsMain.getString("EST_DATE");
EDP_RGY_YN=rsMain.getString("EDP_RGY_YN")==null?"":rsMain.getString("EDP_RGY_YN");
MM_CALL_BACK=rsMain.getString("MM_CALL_BACK")==null?"":rsMain.getString("MM_CALL_BACK");
CALL_BACK_AMT=rsMain.getString("CALL_BACK_AMT")==null?"":rsMain.getString("CALL_BACK_AMT");
REMARKS=rsMain.getString("REMARKS")==null?"":rsMain.getString("REMARKS");
PHY_YR=rsMain.getString("PHY_YR")==null?"":rsMain.getString("PHY_YR");

add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>
<BR>

<CENTER>
<TABLE class="customers" id="customers">
<TR>
  <TH colspan="4"><DIV align="center">PMEGP Physical Verification Beneficiary Details</DIV></TH>
  </TR>
   <TR>
   <TH colspan="4" ><DIV align="center">(*) marked fields are mandatory</DIV></TH>
 </TR>
 <%if(!PHYV_TRID.equals("")){%> 
 <TR>
  <TH colspan="4" ><DIV align="center">Physical Trid:  <%= PHYV_TRID %></DIV></TH>
  </TR>
  <%}%>
<TR>
  <TD width="23%" >E-Tracking ID * </TD> 
  <TD width="28%"><INPUT name="APP_ID" type="text" id="APP_ID" readonly="TRUE" style="font-weight:900" value="<%= APP_ID %>" maxlength="20"    AUTOCOMPLETE="off" ></TD>
  <TD width="18%">Beneficiary Name *</TD>
  <TD width="31%"><INPUT name="APP_NAME" type="text" id="APP_NAME" readonly="TRUE" style="font-weight:900" value="<%= APP_NAME %>" maxlength="100"   AUTOCOMPLETE="off"></TD>
</TR>
<TR>
  <TD >Category *</TD>
  <TD>
  <SELECT name="BENF_CATEGORY_CD" id="BENF_CATEGORY_CD" style="font-weight:900">
  <OPTION value="">----SELECT----</OPTION>
  <OPTION value="EX"<% if (BENF_CATEGORY_CD.equals("EX")){out.print("selected");}%>>Ex-Servicemen</OPTION>
  <OPTION value="GEN"<% if (BENF_CATEGORY_CD.equals("GEN")){out.print("selected");}%>>GENERAL</OPTION>
  <OPTION value="OBC"<% if (BENF_CATEGORY_CD.equals("OBC")){out.print("selected");}%>>OBC</OPTION>
  <OPTION value="SC"<% if (BENF_CATEGORY_CD.equals("SC")){out.print("selected");}%>>SC</OPTION>
  <OPTION value="ST"<% if (BENF_CATEGORY_CD.equals("ST")){out.print("selected");}%>>ST</OPTION>
  <OPTION value="MN"<% if (BENF_CATEGORY_CD.equals("MN")){out.print("selected");}%>>Minority</OPTION>
  <OPTION value="PH"<% if (BENF_CATEGORY_CD.equals("PH")){out.print("selected");}%>>Physically Handicapped</OPTION>
  <OPTION value="HA"<% if (BENF_CATEGORY_CD.equals("HA")){out.print("selected");}%>>Hill Border or NE Area</OPTION>
  </SELECT>  </TD>
  <TD>Gender *</TD>
  <TD>
    <SELECT name="GENDER" id="GENDER" style="font-weight:900">
  <OPTION value="">----SELECT----</OPTION>
  <OPTION value="Male"<% if (GENDER.equals("Male")){out.print("selected");}%>>MALE</OPTION>
  <OPTION value="Female"<% if (GENDER.equals("Female")){out.print("selected");}%>>FEMALE</OPTION>
  <OPTION value="N"<% if (GENDER.equals("N")){out.print("selected");}%>>NOT AVAILABLE</OPTION>
    </SELECT>  </TD>
  </TR>

<INPUT name="ins" type="hidden" id="ins" value="" />

<TR>
  <TD>Contact No *</TD>
  <TD><INPUT name="TEL_NO" type="text" id="TEL_NO" value="<%= TEL_NO %>" style="font-weight:900" maxlength="15" onKeyPress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" AUTOCOMPLETE="off" ></TD>
  <TD>Email</TD>
  <TD><INPUT name="EMAIL" type="text" id="EMAIL" value="<%= EMAIL %>" style="font-weight:900"  maxlength="60"  AUTOCOMPLETE="off" ></TD>
</TR>

<TR>
  <TD>Unit Name *</TD>
  <TD colspan="3"><INPUT name="UNIT_NAME" type="text" id="UNIT_NAME" style="font-weight:900" value="<%= UNIT_NAME %>"  maxlength="100"   AUTOCOMPLETE="off" ></TD>
  </TR>
<TR>
  <TD>Establishment Date *</TD>
  <TD><INPUT name="EST_DATE" type="text" id="EST_DATE" value="<%= EST_DATE %>" style="font-weight:900;background-color:#FFFFFF"   onClick="javascript:NewCssCal('EST_DATE','ddMMMyyyy')" readonly="true"  AUTOCOMPLETE="off" ></TD>
  <TD> Udyog Aadhar No</TD>
  <TD><INPUT name="AADHAR_UDYOG_NO" type="text" id="AADHAR_UDYOG_NO" value="<%= AADHAR_UDYOG_NO %>" style="font-weight:900"  maxlength="20"   AUTOCOMPLETE="off" ></TD>
</TR>
<TR>
  <TD>Unit Location *</TD>
  <TD>
  <SELECT name="UNIT_LOC" id="UNIT_LOC" style="font-weight:900">
  <OPTION value="">----SELECT----</OPTION>
  <OPTION value="Rural"<% if (UNIT_LOC.equals("Rural")){out.print("selected");}%>>RURAL</OPTION>
  <OPTION value="Urban"<% if (UNIT_LOC.equals("Urban")){out.print("selected");}%>>URBAN</OPTION>
  </SELECT>  </TD>
  <TD>Unit  Address *</TD>
  <TD><INPUT name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR" value="<%= UNIT_POST_ADDR %>" style="font-weight:900"  maxlength="100"   AUTOCOMPLETE="off" ></TD>
</TR>
<TR>
  <TD>Unit Taluka Block *</TD><INPUT name="PUNIT_DIST_CD" type="hidden" id="PUNIT_DIST_CD" value="<%= PUNIT_DIST_CD %>">
  <TD><INPUT name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK" value="<%= UNIT_TALUK_BLOCK %>" style="font-weight:900"  maxlength="60"   AUTOCOMPLETE="off" ></TD>
  <TD>Unit District *</TD>
  <TD>  
  <SELECT name="UNIT_DIST_CD"  id="UNIT_DIST_CD" style="font-weight:900">
	<OPTION value="">----Select----</OPTION>
      <%
		String DISTRICTCD="";
		String DISTRICTNM="";
		ResultSet statersn1 =db.execSQL("SELECT DISTRICT_CD, DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD='"+SSTATE_CD+"' ORDER BY DISTRICT_NAME");
	while (statersn1.next()) {
DISTRICTCD=statersn1.getString(1);
DISTRICTNM=statersn1.getString(2);
	%>
    <OPTION value="<%= UNIT_DIST_CD %>"<% if (DISTRICTCD.equals(PUNIT_DIST_CD)){out.print("selected");}%>><%= DISTRICTNM %></OPTION>
      <%  }  statersn1.close();//while close  
	   %>
    </SELECT>  </TD>
</TR>
<TR>
  <TD>Unit Pincode *</TD>
  <TD><INPUT name="UNIT_PIN" type="text" id="UNIT_PIN" value="<%= UNIT_PIN %>" style="font-weight:900"  onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" maxlength="6"  AUTOCOMPLETE="off" ></TD>
  <TD>Industry Type *</TD>
  <TD><SELECT name="IND_TYPE" id="IND_TYPE" style="font-weight:900">
    <OPTION value="">----SELECT----</OPTION>
    <OPTION value="M"<% if (IND_TYPE.equals("M")){out.print("selected");}%>>MANUFACTURER</OPTION>
    <OPTION value="S"<% if (IND_TYPE.equals("S")){out.print("selected");}%>>SERVICE</OPTION>
  </SELECT></TD>
</TR>
<TR>
  <TD>Project Cost *</TD>
  <TD><INPUT name="PRJ_COST" type="text" id="PRJ_COST" value="<%= PRJ_COST %>" style="font-weight:900" onKeyPress="return isNumberKey(this, event);"  AUTOCOMPLETE="off" ></TD>
  <TD colspan="2">&nbsp;</TD>
  </TR>
<TR>
  <TD>Industry Activity * </TD>
  <TD colspan="3"><SELECT name="IND_ACTIVITY"  id='IND_ACTIVITY'>
    <OPTION value="-1" >-Select Activity Name-</OPTION>
    <%
		String ACTCD="";
		String ACTNM="";
		ResultSet statersn1nn =db.execSQL("SELECT ACTIVITY_CD, ACTIVITY_NAME FROM ACTIVITY_MAST WHERE STATUS='Y'");
	while (statersn1nn.next()) {
ACTCD=statersn1nn.getString(1);
ACTNM=statersn1nn.getString(2);
	%>
    <OPTION value="<%= IND_ACTIVITY %>"<% if (ACTCD.equals(PIND_ACTIVITY)){out.print("selected");}%>><%= ACTNM %></OPTION>
    <%  }  statersn1nn.close();//while close  
	   %>
  </SELECT></TD>
</TR>
<TR>
  <TD>Product Desciption *</TD>
  <TD colspan="3"><INPUT name="PRODUCT_DESC" type="text" id="PRODUCT_DESC" style="font-weight:900" value="<%= PRODUCT_DESC %>"   maxlength="200"  AUTOCOMPLETE="off"></TD>
  </TR>
    <TD>Bank *
          <INPUT name="b1" type="hidden" id="b1" size="1" maxlength="1" ></TD>
      <TD colspan="4"><SELECT name="BANK_NAME"  id='BANK_NAME'>
          <OPTION value="-1" >-Select Bank Name-</OPTION>
	   
	         <%
		String BANKNAME="";
		ResultSet statersn1n =db.execSQL("SELECT DISTINCT BANK_NAME FROM PMEGPONLINE.APP_DETAIL WHERE BANK_NAME NOT IN ('`','-1')");
	while (statersn1n.next()) {
BANKNAME=statersn1n.getString(1);
	%>
    <OPTION value="<%= BANK_NAME %>"<% if (BANKNAME.equals(PBANK_NAME)){out.print("selected");}%>><%= BANKNAME %></OPTION>
      <%  }  statersn1n.close();//while close  
	   %>
	   
	   
        </SELECT>      </TD>
  <TR>
  <TD>IFSC Code *</TD>
  <TD><INPUT name="IFSC_CODE" type="text" id="IFSC_CODE" value="<%= IFSC_CODE %>" style="font-weight:900" maxlength="15"  AUTOCOMPLETE="off" ></TD>
  <TD colspan="2">&nbsp;</TD>
  </TR>
<TR>
  <TD>MM Release Amount (in Rupees )*</TD>
  <TD><INPUT name="MM_AMT" type="text" id="MM_AMT" value="<%= MM_AMT %>"  maxlength="6" style="font-weight:900" onKeyPress="return isNumberKey(this, event);" AUTOCOMPLETE="off" ></TD>
  <TD>MM Release Date *</TD>
  <TD><INPUT name="MM_REL_DT" type="text" id="MM_REL_DT" value="<%= MM_REL_DT %>" style="font-weight:900;background-color:#FFFFFF" readonly="true" AUTOCOMPLETE="off" onClick="javascript:NewCssCal('MM_REL_DT','ddMMMyyyy')"></TD>
</TR>
<TR>
  <TD>Employement *</TD>
  <TD><INPUT name="EMP_ENV" type="text" id="EMP_ENV" value="<%= EMP_ENV %>" style="font-weight:900" maxlength="7" onKeyPress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;"   AUTOCOMPLETE="off" ></TD>
  <TD>EDP Completed  *</TD>
  <TD><SELECT name="EDP_RGY_YN" id="EDP_RGY_YN" style="font-weight:900">
    <OPTION value="Y"<% if (EDP_RGY_YN.equals("Y")){out.print("selected");}%>>YES</OPTION>
    <OPTION value="N"<% if (EDP_RGY_YN.equals("S")){out.print("selected");}%>>NO</OPTION>
  </SELECT></TD>
</TR>
<TR>
  <TD>Verification Date *</TD>
  <TD><INPUT name="PHY_DT" type="text" id="PHY_DT" value="<%= PHY_DT %>" style="font-weight:900;background-color:#FFFFFF" readonly="true"   AUTOCOMPLETE="off" onClick="javascript:NewCssCal('PHY_DT','ddMMMyyyy')" ></TD>
  <TD>Verification Status *</TD>
  <TD><SELECT name="PHY_STATUS" id="PHY_STATUS" style="font-weight:900">
    <OPTION value="W"<% if (PHY_STATUS.equals("W")){out.print("selected");}%>>WORKING</OPTION>
    <OPTION value="NW"<% if (PHY_STATUS.equals("NW")){out.print("selected");}%>>NOT WORKING</OPTION>
    <OPTION value="NT"<% if (PHY_STATUS.equals("NT")){out.print("selected");}%>>NOT TRACEABLE</OPTION>
  </SELECT></TD>
</TR>
<TR>
  <TD>Physical Verification Year </TD>
  <TD colspan="3"><SELECT name="PHY_YR" id="PHY_YR" style="font-weight:900">
  <OPTION value="">----SELECT----</OPTION>
  <OPTION value="2008-09"<% if (PHY_YR.equals("2008-09")){out.print("selected");}%>>2008-09</OPTION>
  <OPTION value="2009-10"<% if (PHY_YR.equals("2009-10")){out.print("selected");}%>>2009-10</OPTION>
  <OPTION value="2010-11"<% if (PHY_YR.equals("2010-11")){out.print("selected");}%>>2010-11</OPTION>
  <OPTION value="2011-12"<% if (PHY_YR.equals("2011-12")){out.print("selected");}%>>2011-12</OPTION>
  <OPTION value="2012-13"<% if (PHY_YR.equals("2012-13")){out.print("selected");}%>>2012-13</OPTION>
  <OPTION value="2013-14"<% if (PHY_YR.equals("2013-14")){out.print("selected");}%>>2013-14</OPTION>
  <OPTION value="2014-15"<% if (PHY_YR.equals("2014-15")){out.print("selected");}%>>2014-15</OPTION>
  </SELECT></TD>
</TR>
<TR>
  <TD>Physical Verification Agency Name *</TD>
  <TD colspan="3"><INPUT name="PHY_VER_AGEN_NM" style="font-weight:900" type="text" id="PHY_VER_AGEN_NM" value="<%= PHY_VER_AGEN_NM %>"  maxlength="100"  AUTOCOMPLETE="off" ></TD>
  </TR>
<TR>
  <TD>MM Call Back *</TD>
  <TD>
 <SELECT name="MM_CALL_BACK" id="MM_CALL_BACK" style="font-weight:900" onChange="if (this.value=='Y'){this.form['CALL_BACK_AMT'].style.visibility='visible'}else {this.form['CALL_BACK_AMT'].style.visibility='hidden'};">
    <OPTION value="">----SELECT----</OPTION>
    <OPTION value="Y"<% if (MM_CALL_BACK.equals("Y")){out.print("selected");}%>>YES</OPTION>
    <OPTION value="N"<% if (MM_CALL_BACK.equals("N")){out.print("selected");}%>>NO</OPTION>
  </SELECT></TD>
  <TD colspan="2"><INPUT name="CALL_BACK_AMT" type="text" style="font-weight:900;visibility:hidden;" id="CALL_BACK_AMT" maxlength="6" value="<%= CALL_BACK_AMT %>"  AUTOCOMPLETE="off" onKeyPress="return isNumberKey(this, event);" PLACEHOLDER="ENTER MM CALL BACK AMOUNT"></TD>
  </TR>
<TR>
  <TD>Remarks if any</TD>
  <TD colspan="3"><INPUT name="REMARKS" type="text" id="REMARKS" style="font-weight:900" value="<%= REMARKS %>" maxlength="200" AUTOCOMPLETE="off" ></TD>
  </TR>
</TABLE>
</CENTER>
<BR/>
<DIV align="center">
  <INPUT name="Button" type="button" class="myButton" onClick="submitform();" value="SAVE">
</DIV>


<%
//out.print (ins);
if (ins.equals("I")) {

PHYV_TRID=(String) request.getParameter("PHYV_TRID")==null?"":(String) request.getParameter("PHYV_TRID").trim();
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
BENF_CATEGORY_CD=(String) request.getParameter("BENF_CATEGORY_CD")==null?"":(String) request.getParameter("BENF_CATEGORY_CD").trim();
GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
TEL_NO=(String) request.getParameter("TEL_NO")==null?"":(String) request.getParameter("TEL_NO").trim();
EMAIL=(String) request.getParameter("EMAIL")==null?"":(String) request.getParameter("EMAIL").trim();
UNIT_LOC=(String) request.getParameter("UNIT_LOC")==null?"":(String) request.getParameter("UNIT_LOC").trim();
UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"":(String) request.getParameter("UNIT_POST_ADDR").trim();
UNIT_TALUK_BLOCK=(String) request.getParameter("UNIT_TALUK_BLOCK")==null?"":(String) request.getParameter("UNIT_TALUK_BLOCK").trim();
UNIT_DIST_CD=(String) request.getParameter("UNIT_DIST_CD")==null?"":(String) request.getParameter("UNIT_DIST_CD").trim();
UNIT_PIN=(String) request.getParameter("UNIT_PIN")==null?"":(String) request.getParameter("UNIT_PIN").trim();
PRJ_COST=(String) request.getParameter("PRJ_COST")==null?"":(String) request.getParameter("PRJ_COST").trim();
EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"":(String) request.getParameter("EMP_ENV").trim();
BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME").trim();
IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();
TIMESTAMP=(String) request.getParameter("TIMESTAMP")==null?"":(String) request.getParameter("TIMESTAMP").trim();
IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
IND_ACTIVITY=(String) request.getParameter("IND_ACTIVITY")==null?"":(String) request.getParameter("IND_ACTIVITY").trim();
MM_AMT=(String) request.getParameter("MM_AMT")==null?"":(String) request.getParameter("MM_AMT").trim();
MM_REL_DT=(String) request.getParameter("MM_REL_DT")==null?"":(String) request.getParameter("MM_REL_DT").trim();
PHY_DT=(String) request.getParameter("PHY_DT")==null?"":(String) request.getParameter("PHY_DT").trim();
AADHAR_UDYOG_NO=(String) request.getParameter("AADHAR_UDYOG_NO")==null?"":(String) request.getParameter("AADHAR_UDYOG_NO").trim();
PHY_STATUS=(String) request.getParameter("PHY_STATUS")==null?"":(String) request.getParameter("PHY_STATUS").trim();
UNIT_NAME=(String) request.getParameter("UNIT_NAME")==null?"":(String) request.getParameter("UNIT_NAME").trim();
PRODUCT_DESC=(String) request.getParameter("PRODUCT_DESC")==null?"":(String) request.getParameter("PRODUCT_DESC").trim();
PHY_VER_AGEN_NM=(String) request.getParameter("PHY_VER_AGEN_NM")==null?"":(String) request.getParameter("PHY_VER_AGEN_NM").trim();
EST_DATE=(String) request.getParameter("EST_DATE")==null?"":(String) request.getParameter("EST_DATE").trim();
EDP_RGY_YN=(String) request.getParameter("EDP_RGY_YN")==null?"":(String) request.getParameter("EDP_RGY_YN").trim();
MM_CALL_BACK=(String) request.getParameter("MM_CALL_BACK")==null?"":(String) request.getParameter("MM_CALL_BACK").trim();
CALL_BACK_AMT=(String) request.getParameter("CALL_BACK_AMT")==null?"":(String) request.getParameter("CALL_BACK_AMT").trim();
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
PHY_YR=(String) request.getParameter("PHY_YR")==null?"":(String) request.getParameter("PHY_YR").trim();

		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		if (add_update.equals("I")) {
		
String maxId="SELECT NVL(MAX(PHYV_TRID),0)+1 AS PHYV_TRID FROM BNF_APP_DETAIL" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
PHYV_TRID=rsMax.getString("PHYV_TRID")==null?"":rsMax.getString("PHYV_TRID");
}
rsMax.close();

qryUpdate.append("INSERT INTO BNF_APP_DETAIL ( ");

qryUpdate.append("APP_ID,");
qryUpdate.append("OFF_CD,");
qryUpdate.append("APP_NAME,");
qryUpdate.append("BENF_CATEGORY_CD,");
qryUpdate.append("GENDER,");
qryUpdate.append("TEL_NO,");
qryUpdate.append("EMAIL,");
qryUpdate.append("UNIT_LOC,");
qryUpdate.append("UNIT_POST_ADDR,");
qryUpdate.append("UNIT_TALUK_BLOCK,");
qryUpdate.append("UNIT_DIST_CD,");
qryUpdate.append("UNIT_PIN,");
qryUpdate.append("PRJ_COST,");
qryUpdate.append("EMP_ENV,");
qryUpdate.append("BANK_NAME,");
qryUpdate.append("IFSC_CODE,");
qryUpdate.append("TIMESTAMP,");
qryUpdate.append("IND_TYPE,");
qryUpdate.append("IND_ACTIVITY,");
qryUpdate.append("MM_AMT,");
qryUpdate.append("MM_REL_DT,");
qryUpdate.append("PHY_DT,");
qryUpdate.append("AADHAR_UDYOG_NO,");
qryUpdate.append("PHY_STATUS,");
qryUpdate.append("UNIT_NAME,");
qryUpdate.append("PRODUCT_DESC,");
qryUpdate.append("PHY_VER_AGEN_NM,");
qryUpdate.append("EST_DATE,");
qryUpdate.append("EDP_RGY_YN,");
qryUpdate.append("MM_CALL_BACK,");
qryUpdate.append("CALL_BACK_AMT,");
qryUpdate.append("REMARKS,");
qryUpdate.append("PHY_YR,");
qryUpdate.append("PHYV_TRID");

qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,?,?,?,?,   ?,?,?,? )");
}

else {
try{
qryUpdate.append("UPDATE BNF_APP_DETAIL SET ");
qryUpdate.append("APP_ID=?,");
qryUpdate.append("OFF_CD=?,");
qryUpdate.append("APP_NAME=?,");
qryUpdate.append("BENF_CATEGORY_CD=?,");
qryUpdate.append("GENDER=?,");
qryUpdate.append("TEL_NO=?,");
qryUpdate.append("EMAIL=?,");
qryUpdate.append("UNIT_LOC=?,");
qryUpdate.append("UNIT_POST_ADDR=?,");
qryUpdate.append("UNIT_TALUK_BLOCK=?,");
qryUpdate.append("UNIT_DIST_CD=?,");
qryUpdate.append("UNIT_PIN=?,");
qryUpdate.append("PRJ_COST=?,");
qryUpdate.append("EMP_ENV=?,");
qryUpdate.append("BANK_NAME=?,");
qryUpdate.append("IFSC_CODE=?,");
qryUpdate.append("TIMESTAMP=?,");
qryUpdate.append("IND_TYPE=?,");
qryUpdate.append("IND_ACTIVITY=?,");
qryUpdate.append("MM_AMT=?,");
qryUpdate.append("MM_REL_DT=?,");
qryUpdate.append("PHY_DT=?,");
qryUpdate.append("AADHAR_UDYOG_NO=?,");
qryUpdate.append("PHY_STATUS=?,");
qryUpdate.append("UNIT_NAME=?,");
qryUpdate.append("PRODUCT_DESC=?,");
qryUpdate.append("PHY_VER_AGEN_NM=?,");
qryUpdate.append("EST_DATE=?,");
qryUpdate.append("EDP_RGY_YN=?,");
qryUpdate.append("MM_CALL_BACK=?,");
qryUpdate.append("CALL_BACK_AMT=?,");
qryUpdate.append("REMARKS=?,");
qryUpdate.append("PHY_YR=?");
qryUpdate.append(" WHERE PHYV_TRID=?");

//out.print ("In oupdate"+PEN_FILE_NO);
}
 catch(Exception e){
out.print(e.toString());
	
}
}

//out.print (qryUpdate.toString());

values.add(APP_ID); pstm.add ("L");
values.add(SOFF_CD); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(BENF_CATEGORY_CD); pstm.add ("L");
values.add(GENDER); pstm.add ("L");
values.add(TEL_NO); pstm.add ("L");
values.add(EMAIL); pstm.add ("L");
values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");
values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(UNIT_PIN); pstm.add ("L");
values.add(PRJ_COST); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(TIMESTAMP); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(IND_ACTIVITY); pstm.add ("L");
values.add(MM_AMT); pstm.add ("L");
values.add(MM_REL_DT); pstm.add ("L");
values.add(PHY_DT); pstm.add ("L");
values.add(AADHAR_UDYOG_NO); pstm.add ("L");
values.add(PHY_STATUS); pstm.add ("L");
values.add(UNIT_NAME); pstm.add ("L");
values.add(PRODUCT_DESC); pstm.add ("L");
values.add(PHY_VER_AGEN_NM); pstm.add ("L");
values.add(EST_DATE); pstm.add ("L");
values.add(EDP_RGY_YN); pstm.add ("L");
values.add(MM_CALL_BACK); pstm.add ("L");
values.add(CALL_BACK_AMT); pstm.add ("L");
values.add(REMARKS); pstm.add ("L");
values.add(PHY_YR); pstm.add ("L");
values.add(PHYV_TRID); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();

response.sendRedirect("savemsgapp.jsp");
}
%>


<SCRIPT>



        $(document).ready(function(){
            
            // Initialize select2
            $("#BANK_NAME").select2();
			 $("#UNIT_DIST_CD").select2();
			 $("#IND_ACTIVITY").select2();

            // Read selected option
            $('#but_read').click(function(){
                var username = $('#selUser option:selected').text();
                var userid = $('#selUser').val();
           
                $('#result').html("id : " + userid + ", name : " + username);
            });
        });



</SCRIPT>


<SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}


function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function activity(){
var urlpar='PMEGPlovpage.jsp';
var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
}
function activity2(){
var urlpar='BANKlovpage.jsp';
var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
}


</SCRIPT>
</FORM>
 

</BODY>
</HTML>



</FORM>





</BODY>
</HTML>
