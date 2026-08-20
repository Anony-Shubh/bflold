<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>


<html>
<head>
<title>PMEGP Online Application Registration</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery-customselect.js"></script>
<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>


<script language="javascript">
function openDPR() {
location.href="../dpr/DPRPACKAGE.xls";
}
</script>
<%

String AADHAR_NO = (String) session.getAttribute("sAADHAR_NO");
String APP_NAME= (String) session.getAttribute("sAPP_NAME");
String GENDER= (String) session.getAttribute("sGENDER");

String state="";
String qrystr="";
String Agency=""; 
 DBCon db= new DBCon();
db.connect();


String APP_ID = "";
String vOffcd= "";
String vOrgCD= "";
String vState= "";
String cmbSel="";
String Org ="";
String IdPrix="";
String  vMaxID="";
String OFF_CD = "";
String FH_NAME = "";
String BENF_TYPE_CD = request.getParameter("BENF_CD")==null?"1":(String) request.getParameter("BENF_CD");
String BENF_TYPE_DESC="";
String BENF_CATAGORY_CD = "";
String DOB = "";
String MOB_NO1 = "";
String APP_POST_ADDR = "";
String APP_TALUK_BLOCK = "";
String APP_DIST_CD = "";
String APP_PIN = "";
String E_MAIL = "";
String EDU_ID = "";
String TECH_QUALI = "";
String UNIT_LOC = "";
String UNIT_POST_ADDR = "";
String UNIT_TALUK_BLOCK = "";
String UNIT_DIST_CD = "";
String UNIT_PIN = "";
String BLDG_TYPE = "";
String WORKSHED_COST = "";
String MACHINARY_COST = "";
String PRE_OPE_EXP = "";
String WORKING_CAPITAL = "";
String EMP_ENV = "";
String BANK_NAME = "";
String BANK_POST_ADDR = "";
String BANK_TALUK_BLOCK = "";
String BANK_PINCD = "";
String BANK_DIST_CD = "";
String MTG_ID = "";
String PROD_DESC = "";
String IFSC_CODE = "";
String TIME_STAMP = "";
String APP_REC_DATE = "";
String ACT_ID = "-1";
String BANK_F_DATE = "";
String REMARKS = "";
String IND_TYPE = "";
String ACTIVITY_CD = "";
String BRANCH_NAME = "";
String BANK_DISTRICT = "";

String MOB_NO2 = "";
String IFSC_CODE2 = "";
String ONLINE_SUBDT = "";
String EDP_INST_ADDR = "";
String EDP_YN = "";



String PAN_NO="";
String APP_PWD="";
String BENF_SPECAT_CD="";

//EXTRA CALCULATED

String Activity_desc="";
String TOTAL_PRJ="";
String ORG_CD="";
String STATE="";

 List values=new ArrayList();
 values.add (BENF_TYPE_CD); 

ResultSet rsBenfType =db.executeSQL("SELECT BENF_TYPE_CD,BENF_TYPE_DESC  FROM BENF_TYPE_MAST WHERE BENF_TYPE_CD= ?",values);

while (rsBenfType.next()) {
BENF_TYPE_CD=rsBenfType.getString("BENF_TYPE_CD")==null?"1":rsBenfType.getString("BENF_TYPE_CD");
BENF_TYPE_DESC=rsBenfType.getString("BENF_TYPE_DESC")==null?"-":rsBenfType.getString("BENF_TYPE_DESC");
}
rsBenfType.close();
values.clear();


ResultSet rsEdu = db.execSQL("SELECT edu_id, edu_desc FROM education_mast");

	%>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>

<body  onload="edp_yn();">
<%!
 public String getDate(String str){
 str=str.trim();
SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yyyy");
try{
     Date date = sdfSource.parse(str);
	 
     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
	  str=sdfDestination.format(date);
	  }catch(Exception e){}
	 return(str); 
	 
}
 %>

<img src="../images/pmegponline.jpg" width="100%" height="150" >

<form name="form" id="form"  class="form" method="post">

<table>

<tr>
  <td>
    <table class="CSSTableGenerator">
      
    <tr bgcolor="#D1A476">
      <td colspan="6">
        <div align="center" class="style1">
          <h3>PMEGP ONLINE APPLICATION  FOR INDIVIDUAL APPLICANT  </h3>
        </div></td>
      </tr>
      
      <tr>
        <th width="44">(1)</th>
        <th width="298" nowrap><strong>Aadhaar Card No: </strong></th>
        <td colspan="4">  <input name="AADHAR_NO" type="text" class="aadharimg"  id="AADHAR_NO" onKeyPress="return numbersonly(event);" size="17" maxlength="12" /></td>
        </tr>
      <tr>
        <th>(2)</th>
        <th><strong>Name of Applicant:*</strong></th>
        <td colspan="4">
		<input name="APP_NAME" type="text"  id="APP_NAME"   value="" size="30" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" />
		  (Name as Per Aadhaar Card)		</td></tr>
      
      
      <tr>
        <th>(3)</th>
        <th nowrap><strong> Sponsoring Agency*:</strong></th>
        <td colspan="4"><select name="AGENCY" class="button" id="AGENCY"   onchange="showOffice(this.value);" >
          <option value ="-1" >--Select Agency --</option>
          <option value="KV">KVIC</option>
          <option value="KB">KVIB</option>
          <option value="DI">DIC</option>
        </select></td>
      </tr>
      <tr>
        <th>(4)</th>
        <th nowrap>State*:</th>
        <td colspan="4">
		
		
          <select name="STATE" class="button"  id="STATE" onBlur="showOffice(this.value);" onChange="showDistrict(this.value);">
            <option value="-1">--Select State--</option>
            <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   %>
            <option value="<%=rs.getString("state_cd")%>"><%=rs.getString("state_nm")%></option>
            <% } 
	  rs.close();
	   %>
            </select>          		</td>
      </tr>
      <tr>
        <th>(5)</th>
        <th nowrap>District*:</th>
		
		<td id ='DISTRICT' colspan="4"><select name="DISTRICT" class="button" onBlur="showOffice(this.value);copy_dist()" >
        <option value="-1" >--Select District-</option>
        </select></td>
      </tr>
      <tr>
        <th>(6)</th>
        <th nowrap>Sponsoring Office*: 
          <input name="OFF_CD" type="radio" disabled value="" /></th>
		
		 <td   colspan="4" id="office">To get Office Select   Agency, State and District </td>
      </tr>
      <tr>
        <th>(7)</th>
        <th nowrap><strong>Legal Type*
          <input name="FH_NAME" id="FH_NAME" type="hidden" value="-" />
          <input name="FH_NM_DESC"  id="FH_NM_DESC" type="hidden" value="-" />
        </strong></th>
        <th colspan="4">
		<input name="BENF_TYPE_CD" id="BENF_TYPE_CD" type="hidden" value="1" />
		INDIVIDUAL</th>
      </tr>
      <tr>
        <th>(8)</th>
        <th nowrap><strong>Gender:*</strong></th>
        <td colspan="4"><select name="GENDER" class="button" id="GENDER">
          <option value="" selected>Select</option>
          <option value ="Male">Male</option>
          <option value ="Female">Female</option>
          <option value="Transgender">Transgender</option>
        </select></td>
      </tr>
      <tr>
        <th>(9)</th>
        <th nowrap><strong>Date of Birth (dd-mm-yyyy) :*</strong></th>
        <td colspan="4"><input name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" />
          Age: <input name="AGE" type="text" id="AGE" size="5" maxlength="3" style="background-color: #FFCCCC" readonly="true"  /></td>
      </tr>
      <tr>
        <th rowspan="2">(10)</th>
        <th nowrap><strong>Social  Category : *</strong></th>
        <td colspan="4"><select name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
          <option value="" selected>-Social Category-</option>
          <option value="GEN">General</option>
          <option value="OBC">Other Backward Caste</option>
          <option value="SC">Scheduled Caste</option>
          <option value="ST">Scheduled Tribe</option>
		   <option value="MN">Minority</option>
     
        </select></td>
      </tr>
      <tr>
        <th nowrap><strong>Special  Category (if any): </strong></th>
        <td colspan="4"><select name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
          <option value="" selected>-Special Category-</option>
		    <option value="NA" selected>Not Applicable</option>
          <option value="EX">Ex-Serviceman</option>
          <option value="PH">Physically Challenged</option>
          <option value="HA">Hill Boarder Region</option>
		   <option value="NE">North East Region</option>
        </select></td>
      </tr>
      <tr>
        <th>(11)</th>
        <th nowrap><strong>Qualification:*
            <input name="TECH_QUALI" type="hidden" id="TECH_QUALI" onKeyPress="return RestrictSpecialChar(event);" value="" />
        </strong></th>
        <td colspan="4"><select name="EDU_ID" class="button" id="EDU_ID" >
          <option value="">--Select---</option>
          <%
while (rsEdu.next()) {
cmbSel=(rsEdu.getObject("edu_id").toString().equals(EDU_ID) )?"Selected":"";

%>
          <option value="<%=((rsEdu.getObject("edu_id")!=null)?rsEdu.getObject("edu_id"):"")%>" <%= cmbSel %>><%=((rsEdu.getObject("edu_desc")!=null)?rsEdu.getObject("edu_desc"):"")%></option>
          <%
}
rsEdu.close();
%>
        </select></td>
      </tr>
      <tr>
        <th>(12)</th>
        <th nowrap><strong>Communication Address: * </strong></th>
        <td colspan="4"><input name="APP_POST_ADDR" type="text" id="APP_POST_ADDR"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
        </tr>
      
      
      
      <tr>
        <td>&nbsp;</td>
        <td>Taluk/Block*:</td>
        <td colspan="4"><input name="APP_TALUK_BLOCK" type="text" id="APP_TALUK_BLOCK" size="50" maxlength="60" onKeyPress="return RestrictSpecialChar(event);" /></td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input name="APP_DIST_CD" type="hidden" id="APP_DIST_CD" value="" />
District*:</td>
        <td colspan="4"><input name="UNIT_DIST_NM" type="text" id="UNIT_DIST_NM" style="background-color: #FFCCCC"  readonly="true"  />
          </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Pin*:</td>
        <td colspan="4"><input name="APP_PIN" type="text" id="APP_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th nowrap>Mobile No:*:</th>
        <td colspan="4">(1)<input name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" />
        (2)      
        <input name="MOB_NO2" type="text" class="mob"  id="MOB_NO2" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" /> </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th nowrap>eMail:</th>
        <td colspan="4"> <input name="E_MAIL" type="text" id="E_MAIL" size="20"  maxlength="58" /></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap>PAN NO: </th>
        <td colspan="4"><input name="PAN_NO" type="text" id="PAN_NO"   size="20" maxlength="10" /></td>
      </tr>
      <tr>
        <th>(13)</th>
        <th nowrap>Unit Location </th>
        <td colspan="4"><select name="UNIT_LOC" class="button" id="UNIT_LOC" >
          <option value="">Select</option>
          <option value="Rural">Rural</option>
          <option value="Urban">Urban</option>
        </select></td>
      </tr>
      <tr>
        <th>(14)</th>
        <th nowrap><strong>Proposed Unit Address </strong><strong>: </strong></th>
        <td colspan="4"><input name="CopyAddress" type="button" class="button" onClick="copy_addres();" value="Copy Communication Address to Unit Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Address*</td>
        <td colspan="4"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  size="45" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Taluk/Block*</td>
        <td colspan="4"><input name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  size="40" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td> District*
          <input name="UNIT_DIST_CD" type="hidden" id="UNIT_DIST_CD" value="" /></td>
        <td colspan="4"><input name="APP_DIST_NM" type="text" id="APP_DIST_NM"  style="background-color: #FFCCCC" readonly="true"  /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Pin*</td>
        <td colspan="4"><input name="UNIT_PIN" type="text" id="UNIT_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
      <tr>
        <th>(15)</th>
        <th nowrap><strong>Type of Activity  : * </strong></th>
        <td colspan="4"><select name="IND_TYPE" class="button" id="IND_TYPE" >
        <option value="" selected>-Select-</option>
        <option value="M" >Manufacturing</option>
        <option value="S" >Service</option>
		<option value="T" >Trading</option>

        </select><input name="btnActList" type="button" class="button" id="btnActList"  onclick=" window.open ('PMEGPlovpage.jsp', &quot;ActivityLOV&quot;,&quot;location=0,status=0,scrollbars=0,width=710,height=550&quot;);" value="Select Industry / Activity" /></td>
      </tr>
      <tr>
        <th>(16)</th>
        <th nowrap>Industry / Activity Name : <strong>
          <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
        </strong></th>
        <td colspan="4"><input name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Product Description: </td>
        <td colspan="4"><input name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th>(17)</th>
        <th nowrap><strong>EDP Training Undergone:*
          
            <input name="EDP_TRG_FRDT" type="hidden" id="EDP_TRG_FRDT"  onkeypress="return onlyDate(event);" value=""/>
            <input name="EDP_TRG_TODT" type="hidden" id="EDP_TRG_TODT"  onkeypress="return onlyDate(event);" value="" />
            <input name="EDP_TRG_CDT" type="hidden" id="EDP_TRG_CDT"   onkeypress="return onlyDate(event);" value="" />
        </strong></th>
        <td colspan="4"><select name="EDP_YN" id="EDP_YN" onChange="edp_yn();">
          <option value="">-Select-</option>
          <option value="N">No</option>
          <option value="Y">Yes</option>
        </select> <input name="GS_AMT" type="hidden" id="GS_AMT" onKeyPress="return numbersonly(event)" value="" />
        <input name="GS_AVAIL_YN" type="hidden" value="N" />
        <input name="GS_DETAIL" type="hidden" id="GS_DETAIL" onKeyPress="return RestrictSpecialChar(event);" value="" /></td>
      </tr>
      
      <tr>
        <th>(18)</th>
      <th nowrap>EDP Training Instn. Name </th>
      <td colspan="4"><input name="EDP_INST_ADDR" type="text" id="EDP_INST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="50" maxlength="50" /></td>
      </tr>
      <tr>
        <th nowrap>(19)</th>
        <th nowrap><strong>Project Cost  :
            <input name="BLDG_TYPE" id="BLDG_TYPE" type="hidden" value="" />
            <input name="WORKSHED_COST" type="hidden" id="WORKSHED_COST"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
            <input name="PRE_OPE_EXP" type="hidden"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
            <span class="style60">
            <input name="TOTAL_CE" type="hidden" id="TOTAL_CE" style="background-color: #FFCCCC" value="" />
            
            </span></strong></th>
        <th width="197" nowrap> <div align="center">Capital Expenditure</div></th>
        <th width="229" nowrap><div align="center">Working Capital</div></th>
        <th width="164" nowrap><div align="center">Total</div></th>
        <th width="" nowrap><div align="center">Employement</div></th>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>          <div align="center">
          <input name="MACHINARY_COST" type="text" id="MACHINARY_COST" onChange="proj_cal();" size="8" maxlength="7" />        
        </div></td>
        <td><div align="center">
          <input name="WORKING_CAPITAL" type="text" id="WORKING_CAPITAL"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" size="8" maxlength="7" />
        </div></td>
        <td><div align="center">          
          <input name="TOTAL_PRJ" type="text" id="TOTAL_PRJ" style="background-color: #FFCCCC" value="" readonly="true"  size="8" />
          &nbsp;</div></td>
        <td><div align="center">
          <input name="EMP_ENV" type="text" id="EMP_ENV"  size="8" maxlength="3" value="" />
        </div></td>
        </tr>
      <tr>
        <th>(20)</th>
        <th nowrap>1st Financing Bank*: 
          <input name="b1" type="hidden" id="b1" size="1" maxlength="1" ></th>
        <td colspan="4">
		<select name="BANK_NAME"  id="BANK_NAME" class="custom-select">
            <option value="-1" >-Select Bank Name-</option>
            <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd(+) AND A.ACT_YN='Y' ORDER BY BANK_NAME");
	   while(rs.next()){ 
	   %>
            <option value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></option>
            <% } 
	  rs.close();
	   %>
          </select>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>IFS/Bank Code*: </td>
        <td colspan="4"><input name="IFSC_CODE" type="text" id="IFSC_CODE"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <input name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Branch Name*: </td>
        <td colspan="4"><input name="BRANCH_NAME" type="text" id="BRANCH_NAME"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Address*:</td>
        <td colspan="4"><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="70" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      <td>District:</td>
      <td colspan="4"><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" /></td>
    </tr>
      
      <tr>
        <th>(21)</th>
        <th nowrap>Alternate Financing Bank Name </th>
        <td colspan="4">		
		<select name="BANK_NAME2"  id="BANK_NAME2"  >
          <option value="-1" selected="selected" >-Select Bank Name-</option>
          <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd");
	   
	   while(rs.next()){ 
	   
	   %>
          <option value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></option>
          <% } 
	  rs.close();
	   %>
        </select></td>
      </tr>
      <tr>
        <th>(21)</th>
      <th nowrap>2nd Financing Branch IFS Code <input type="hidden" name="BANK_TYPE" id="BANK_TYPE" value="1" />
        <input type="hidden" name="ins" id="ins" value="" /></th>
      <td colspan="4"><input name="IFSC_CODE2" type="text" id="IFSC_CODE2" size="11" maxlength="11" readonly="true" />
        <input name="btnBank2" type="button" class="button" id="btnBank2" onClick="ShowNewPage2();"  value="Select  Bank IFS Code" /></td>
      </tr>
      
      
      <tr>
        <td colspan="6"><input name="checkbox" type="checkbox" value="checkbox" checked>
          I hereby declare that information given above is true to the best of my knowledge. Any information to be found incorrect /false / wrong , I shall be liable for suitable Action. </td>
      </tr>
      <tr>
        <td colspan="6">
          <div align="center">&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="Button" type="button" class="button"  onClick="sub_form();" value="Save Applicant Data" />
&nbsp;&nbsp;&nbsp;&nbsp;            </div></td></tr>
      <tr>
        <td colspan="6"><div align="right">
          <%
   try{
   if ((String)request.getParameter("ins")!=null){
	
		APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();

//APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
FH_NAME=(String) request.getParameter("FH_NAME")==null?"":(String) request.getParameter("FH_NAME").trim();
BENF_TYPE_CD=(String) request.getParameter("BENF_TYPE_CD")==null?"1":(String) request.getParameter("BENF_TYPE_CD").trim();
BENF_CATAGORY_CD=(String) request.getParameter("BENF_CATAGORY_CD")==null?"":(String) request.getParameter("BENF_CATAGORY_CD").trim();
//GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
APP_TALUK_BLOCK=(String) request.getParameter("APP_TALUK_BLOCK")==null?"":(String) request.getParameter("APP_TALUK_BLOCK").trim();
APP_DIST_CD=(String) request.getParameter("APP_DIST_CD")==null?"":(String) request.getParameter("APP_DIST_CD").trim();
APP_PIN=(String) request.getParameter("APP_PIN")==null?"":(String) request.getParameter("APP_PIN").trim();
E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();
EDU_ID=(String) request.getParameter("EDU_ID")==null?"":(String) request.getParameter("EDU_ID").trim();
TECH_QUALI=(String) request.getParameter("TECH_QUALI")==null?"":(String) request.getParameter("TECH_QUALI").trim();
UNIT_LOC=(String) request.getParameter("UNIT_LOC")==null?"":(String) request.getParameter("UNIT_LOC").trim();
UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"":(String) request.getParameter("UNIT_POST_ADDR").trim();
UNIT_TALUK_BLOCK=(String) request.getParameter("UNIT_TALUK_BLOCK")==null?"":(String) request.getParameter("UNIT_TALUK_BLOCK").trim();
UNIT_DIST_CD=(String) request.getParameter("UNIT_DIST_CD")==null?"":(String) request.getParameter("UNIT_DIST_CD").trim();
UNIT_PIN=(String) request.getParameter("UNIT_PIN")==null?"":(String) request.getParameter("UNIT_PIN").trim();
BLDG_TYPE=(String) request.getParameter("BLDG_TYPE")==null?"":(String) request.getParameter("BLDG_TYPE").trim();
WORKSHED_COST=(String) request.getParameter("WORKSHED_COST")==null?"":(String) request.getParameter("WORKSHED_COST").trim();
MACHINARY_COST=(String) request.getParameter("MACHINARY_COST")==null?"":(String) request.getParameter("MACHINARY_COST").trim();
PRE_OPE_EXP=(String) request.getParameter("PRE_OPE_EXP")==null?"":(String) request.getParameter("PRE_OPE_EXP").trim();
WORKING_CAPITAL=(String) request.getParameter("WORKING_CAPITAL")==null?"":(String) request.getParameter("WORKING_CAPITAL").trim();
EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"":(String) request.getParameter("EMP_ENV").trim();
BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME").trim();
BANK_POST_ADDR=(String) request.getParameter("BANK_POST_ADDR")==null?"":(String) request.getParameter("BANK_POST_ADDR").trim();
BANK_TALUK_BLOCK=(String) request.getParameter("BANK_TALUK_BLOCK")==null?"":(String) request.getParameter("BANK_TALUK_BLOCK").trim();
BANK_PINCD=(String) request.getParameter("BANK_PINCD")==null?"":(String) request.getParameter("BANK_PINCD").trim();
BANK_DIST_CD=(String) request.getParameter("BANK_DIST_CD")==null?"":(String) request.getParameter("BANK_DIST_CD").trim();
MTG_ID=(String) request.getParameter("MTG_ID")==null?"":(String) request.getParameter("MTG_ID").trim();
PROD_DESC=(String) request.getParameter("PROD_DESC")==null?"":(String) request.getParameter("PROD_DESC").trim();
IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();
TIME_STAMP=(String) request.getParameter("TIME_STAMP")==null?"":(String) request.getParameter("TIME_STAMP").trim();
APP_REC_DATE=(String) request.getParameter("APP_REC_DATE")==null?"":(String) request.getParameter("APP_REC_DATE").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"-1":(String) request.getParameter("ACT_ID").trim();
BANK_F_DATE=(String) request.getParameter("BANK_F_DATE")==null?"":(String) request.getParameter("BANK_F_DATE").trim();
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME").trim();
BANK_DISTRICT=(String) request.getParameter("BANK_DISTRICT")==null?"":(String) request.getParameter("BANK_DISTRICT").trim();
//AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO").trim();
MOB_NO2=(String) request.getParameter("MOB_NO2")==null?"":(String) request.getParameter("MOB_NO2").trim();
IFSC_CODE2=(String) request.getParameter("IFSC_CODE2")==null?"":(String) request.getParameter("IFSC_CODE2").trim();
ONLINE_SUBDT=(String) request.getParameter("ONLINE_SUBDT")==null?"":(String) request.getParameter("ONLINE_SUBDT").trim();
EDP_INST_ADDR=(String) request.getParameter("EDP_INST_ADDR")==null?"":(String) request.getParameter("EDP_INST_ADDR").trim();
EDP_YN=(String) request.getParameter("EDP_YN")==null?"":(String) request.getParameter("EDP_YN").trim();
//EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"":(String) request.getParameter("EMP_ENV").trim();
 PAN_NO=(String) request.getParameter("PAN_NO")==null?"":(String) request.getParameter("PAN_NO").trim();
 BENF_SPECAT_CD=(String) request.getParameter("BENF_SPECAT_CD")==null?"":(String) request.getParameter("BENF_SPECAT_CD").trim();
		
		ResultSet rsProMaxID = db.execSQL("SELECT FAPPIDGEN("+OFF_CD+") AS MAXID FROM DUAL ");
		
		while (rsProMaxID.next()){
		  APP_ID=rsProMaxID.getString(1);
		}
		rsProMaxID.close();
		
		
		ResultSet rsRd = db.execSQL("select round(dbms_random.value(100000,999999),0) APP_PWD from dual ");
		
		while (rsRd.next()){
		  APP_PWD=rsRd.getString(1);
		}
		rsRd.close();
		
		
		
       
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		      
qryUpdate.append(" INSERT INTO APP_DETAIL_SA ");
qryUpdate.append(" ( APP_ID,");
qryUpdate.append("OFF_CD,");
qryUpdate.append("APP_NAME,");
qryUpdate.append("FH_NAME,");
qryUpdate.append("BENF_TYPE_CD,");
qryUpdate.append("BENF_CATAGORY_CD,");
qryUpdate.append("GENDER,");
qryUpdate.append("DOB,");
qryUpdate.append("MOB_NO1,");
qryUpdate.append("APP_POST_ADDR,");
qryUpdate.append("APP_TALUK_BLOCK,");
qryUpdate.append("APP_DIST_CD,");
qryUpdate.append("APP_PIN,");
qryUpdate.append("E_MAIL,");
qryUpdate.append("EDU_ID,");
qryUpdate.append("TECH_QUALI,");
qryUpdate.append("UNIT_LOC,");
qryUpdate.append("UNIT_POST_ADDR,");
qryUpdate.append("UNIT_TALUK_BLOCK,");
qryUpdate.append("UNIT_DIST_CD,");
qryUpdate.append("UNIT_PIN,");
qryUpdate.append("BLDG_TYPE,");
qryUpdate.append("WORKSHED_COST,");
qryUpdate.append("MACHINARY_COST,");
qryUpdate.append("PRE_OPE_EXP,");
qryUpdate.append("WORKING_CAPITAL,");
qryUpdate.append("EMP_ENV,");
qryUpdate.append("BANK_NAME,");
qryUpdate.append("BANK_POST_ADDR,");
qryUpdate.append("BANK_TALUK_BLOCK,");
qryUpdate.append("BANK_PINCD,");
qryUpdate.append("BANK_DIST_CD,");
qryUpdate.append("MTG_ID,");
qryUpdate.append("PROD_DESC,");
qryUpdate.append("IFSC_CODE,");
qryUpdate.append("TIME_STAMP,");
qryUpdate.append("APP_REC_DATE,");
qryUpdate.append("ACT_ID,");
qryUpdate.append("BANK_F_DATE,");
qryUpdate.append("REMARKS,");
qryUpdate.append("IND_TYPE,");
qryUpdate.append("ACTIVITY_CD,");
qryUpdate.append("BRANCH_NAME,");
qryUpdate.append("BANK_DISTRICT,");
qryUpdate.append("AADHAR_NO,");
qryUpdate.append("MOB_NO2,");
qryUpdate.append("IFSC_CODE2,");
qryUpdate.append("EDP_INST_ADDR,");
qryUpdate.append("EDP_YN, ");
qryUpdate.append("PAN_NO, ");
qryUpdate.append("BENF_SPECAT_CD, ");
qryUpdate.append("APP_PWD, ");
qryUpdate.append("ONLINE_SUBDT ) ");
qryUpdate.append("  VALUES ( ?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?, ?,?,?, SYSDATE)");

values.clear();
pstm.clear();

values.add(APP_ID); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");

values.add(APP_NAME); pstm.add ("L");
values.add(FH_NAME); pstm.add ("L");
values.add(BENF_TYPE_CD); pstm.add ("L");
values.add(BENF_CATAGORY_CD); pstm.add ("L");
values.add(GENDER); pstm.add ("L");
values.add(getDate(DOB)); pstm.add ("L");
values.add(MOB_NO1); pstm.add ("L");
values.add(APP_POST_ADDR); pstm.add ("L");
values.add(APP_TALUK_BLOCK); pstm.add ("L");
values.add(APP_DIST_CD); pstm.add ("L");
values.add(APP_PIN); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");
values.add(EDU_ID); pstm.add ("L");
values.add(TECH_QUALI); pstm.add ("L");
values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");
values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(UNIT_PIN); pstm.add ("L");
values.add(BLDG_TYPE); pstm.add ("L");
values.add(WORKSHED_COST); pstm.add ("L");
values.add(MACHINARY_COST); pstm.add ("L");
values.add(PRE_OPE_EXP); pstm.add ("L");
values.add(WORKING_CAPITAL); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(BANK_POST_ADDR); pstm.add ("L");
values.add(BANK_TALUK_BLOCK); pstm.add ("L");
values.add(BANK_PINCD); pstm.add ("L");
values.add(BANK_DIST_CD); pstm.add ("L");
values.add(MTG_ID); pstm.add ("L");
values.add(PROD_DESC); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(TIME_STAMP); pstm.add ("L");
values.add(APP_REC_DATE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(BANK_F_DATE); pstm.add ("L");
values.add(REMARKS); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(ACTIVITY_CD); pstm.add ("L");
values.add(BRANCH_NAME); pstm.add ("L");
values.add(BANK_DISTRICT); pstm.add ("L");
values.add(AADHAR_NO); pstm.add ("L");
values.add(MOB_NO2); pstm.add ("L");
values.add(IFSC_CODE2); pstm.add ("L");
values.add(EDP_INST_ADDR); pstm.add ("L");
values.add(EDP_YN); pstm.add ("L");
values.add(PAN_NO); pstm.add ("L");
values.add(BENF_SPECAT_CD); pstm.add ("L");
values.add(APP_PWD); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();

try {

int cal=APP_ID.indexOf("-");
int len=APP_ID.length();
String tempUN=APP_ID.substring(cal+1,len);
//String SmsText="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking Application is registered. User  ID is "+tempUN+" and password is: "+APP_PWD+".Please Login for Upload Documents and Final Submission. After Final Submission You can Print Application form. ";
//SendSMS.sendBulkSMS("KVICDIT", "Kvic@1974", "KVICIT", MOB_NO1, SmsText);
session.setAttribute("sAPP_ID",APP_ID);
session.setAttribute("sAPP_NAME",APP_NAME);
session.setAttribute("sBENF_TYPE_DESC",BENF_TYPE_DESC); 
session.setAttribute("sACT_ID",ACT_ID); 
session.setAttribute("sAPP_PWD",APP_PWD); 
response.sendRedirect("savemsg.jsp");
}catch(Exception e){

}

}//ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}

   %>
          </div></td>
    </tr>
</table></td>
  <td></td>
</tr>
</table>
<script>
$(function() {
$("#BANK_NAME").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     20,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});

$(function() {
$("#BANK_NAME2").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     20,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});
</script>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function ShowNewPage(){

i=document.form.BANK_NAME.selectedIndex;
vbankCode=document.form.BANK_NAME.options[i].value;  
BANK_NM=document.form.BANK_NAME.options[i].text; 
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
    

if (vbankCode == "-1") {	
 inlineMsg ( 'BANK_NAME','Please Select Bank name',2);	
 return (false);
 }else
 if (vstate=='-1') {	        
inlineMsg('STATE','<Strong> Select State Name for Unit  From the List </Strong>',2);
return (false);
		} else {
var urlpar='APPRBIBANKLOV.jsp?BANK_NAME='+BANK_NM+'&state='+vstate;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 }//END OF FUNCTION
 
 
 
 function ShowNewPage2(){

i=document.form.BANK_NAME2.selectedIndex;
vbankCode=document.form.BANK_NAME2.options[i].value;  
BANK_NM=document.form.BANK_NAME2.options[i].text; 
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
    

if (vbankCode == "-1") {	
 inlineMsg ( 'BANK_NAME2','Please Select Alternative Financing Bank name',2);	
 return (false);
 }else
 if (vstate=='-1') {	        
inlineMsg('STATE','<Strong> Select State Name for Unit  From the List </Strong>',2);
return (false);
		} else {
var urlpar='APPRBIBANKLOV2.jsp?BANK_NAME='+BANK_NM+'&state='+vstate;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 }//END OF FUNCTION
 
 
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


function getBankLOV(IFSC,BRNAME,ADDR,DIST){
 form.IFSC_CODE.value=IFSC;
 form.BRANCH_NAME.value=BRNAME;
 form.BANK_POST_ADDR.value=ADDR;
form.BANK_DISTRICT.value=DIST;

}

function changeComDistrict(){
i=document.form.STATE.selectedIndex;
vstate=document.form.STATE.options[i].value;  
var urlpar='districtCommunicationLOV.jsp?STATE='+vstate;
if (vstate=='-1') {	        
inlineMsg('STATE','<Strong> Select State Name</Strong>',2);
return (false);
		}
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,600,'Find Bank Details',null,callbackFunctionArray);
 }//end 
function getDistrictName(DISTRICT_NAME,DISTRICT_CD){
 form.UNIT_DIST_NM.value=DISTRICT_NAME;
form.APP_DIST_CD.value=DISTRICT_CD;
}
function getBankLOV2(IFSC){
 form.IFSC_CODE2.value=IFSC;
}

</script>
</form>
 

</body>
</html>
