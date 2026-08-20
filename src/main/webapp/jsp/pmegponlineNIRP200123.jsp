<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="kvic.inputvalid.*" %>
<%@ page buffer="500kb" %>
<% 
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title>PMEGP Online Application Registration</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/pmegpOnlinemessagesNI.js"></script>
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>


<script language="javascript">
function openDPR() {
location.href="../dpr/DPRPACKAGE.xls";
}
</script>



<%String state="";
String qrystr="";
String Agency=""; 
 DBCon db= new DBCon();
db.connect();
jspinputvalid js = new jspinputvalid();

String APP_ID = "";
String vOffcd= "";
String vOrgCD= "";
String vState= "";
String cmbSel="";
String Org ="";
String IdPrix="";
String  vMaxID="";
String OFF_CD = "";
String APP_PRIX = "";
String APP_NAME = "";
String FH_NAME = "";
String BENF_TYPE_CD = request.getParameter("BENF_CD")==null?"0":js.getOnlyText((String)  request.getParameter("BENF_CD"),2);
String BENF_TYPE_DESC="";
String BENF_CATAGORY_CD = "";
String GENDER = "";
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
String ACT_ID = "0";
String BANK_F_DATE = "";
String REMARKS = "";
String IND_TYPE = "";
String ACTIVITY_CD = "";
String BRANCH_NAME = "";
String BANK_DISTRICT = "";
String AADHAR_NO = "";
String MOB_NO2 = "";
String IFSC_CODE2 = "";
String ONLINE_SUBDT = "";
String EDP_INST_ADDR = "";
String EDP_YN = "";
String PAN_NO="";
//EXTRA CALCULATED

String Activity_desc="";
String TOTAL_PRJ="";
String ORG_CD="";
String STATE="";

ResultSet rsBenfType = db.execSQL("SELECT BENF_TYPE_CD,BENF_TYPE_DESC  FROM BENF_TYPE_MAST WHERE BENF_TYPE_CD= "+BENF_TYPE_CD+"");
while (rsBenfType.next()) {
BENF_TYPE_CD=rsBenfType.getString("BENF_TYPE_CD")==null?"0":rsBenfType.getString("BENF_TYPE_CD");
BENF_TYPE_DESC=rsBenfType.getString("BENF_TYPE_DESC")==null?"-":rsBenfType.getString("BENF_TYPE_DESC");
}
rsBenfType.close();


	%>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>

<body onLoad="edpyn();">
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

<form name="form" id="form" method="POST"  action="pmegponline.jsp" >
<img src="../images/pmegponline.jpg" width="100%" height="150" >

<table>

<tr>
  <td>
    <table class="CSSTableGenerator">
      
    <tr bgcolor="#D1A476">
      <td colspan="6">
        <div align="center" class="style1">
          <h3>PMEGP ONLINE APPLICATION  FOR NON-INDIVIDUAL APPLICANT  </h3>
        </div></td>
      </tr>
      <tr>
        <th>(1) </th>
        <th colspan="2" nowrap><strong>Legal Type : </strong></th>
        <th colspan="3"><h2><%= BENF_TYPE_DESC %>
		<input name="BENF_TYPE_DESC" id="BENF_TYPE_DESC" type="hidden" value="<%= BENF_TYPE_DESC %>">
		<input name="BENF_CD" id="BENF_CD" type="hidden" value="<%= BENF_TYPE_CD %>">
		<h2>      </tr>
      <tr>
        <th>(2)</th>
        <th colspan="2" nowrap>Name of the  <%= BENF_TYPE_DESC %>*</th>
        <td colspan="3"><input name="APP_NAME" type="text"  id="APP_NAME"   value="" size="70" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th>(3)</th>
        <th colspan="2" nowrap>Registration No: </th>
        <td colspan="3">
		
		 <%
		 
		 
		  if (!(BENF_TYPE_CD.equals("4"))) {%>
		<input name="REGD_NO" type="text"  id="REGD_NO"   value="" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" />
		 <% } else {%>
		 <input name="REGD_NO" type="hidden"  id="REGD_NO"   value="" size="30" maxlength="20"/>
		   Not Applicable
		  <% }%>		</td>
      </tr>
      <tr>
        <th>(4)</th>
        <th colspan="2" nowrap><strong>Ragistration Date (dd-mm-yyyy)</strong></th>
        <td colspan="3">
		
		 <% if (!(BENF_TYPE_CD.equals("4"))) {%>
		
		<input name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" />
        <input name="AGE" type="text" id="AGE" size="5" maxlength="3" style="background-color: #FFCCCC" readonly="true"  />
		 <% } else {%>
		 <input name="DOB" type="hidden" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" />
        <input name="AGE" type="hidden" id="AGE" size="5" maxlength="3" style="background-color: #FFCCCC" readonly="true"  />
		 Not Applicable
		  <% }%>		</td>
      </tr>
      <tr>
        <th>(5)</th>
        <th colspan="2" nowrap>TAN No: 
         
          
          <input name="BENF_TYPE_CD" id="BENF_TYPE_CD" type="hidden" value="<%= BENF_TYPE_CD %>" />
          <strong>
          <input name="FH_NM_DESC"  id="FH_NM_DESC" type="hidden" value="-" />
          </strong></th>
        <td colspan="3">
		 <% if (!(BENF_TYPE_CD.equals("4"))) {%>
		<input name="TAN_NO" type="text"  id="TAN_NO" size="15" maxlength="10" onKeyPress="return RestrictSpecialChar(event);" />
		<% } else {%>
		<input name="TAN_NO" type="hidden"  id="TAN_NO" size="15" maxlength="10" />
		Not Applicable
		 <% }%>		</td>
      </tr>
      <tr>
        <th>(6)</th>
        <th colspan="2" nowrap>Authorised Person Name*: </th>
        <td colspan="3"><select name="APP_PRIX" id="APP_PRIX" >
            <option value="">-Select-</option>
            <option value="Shri">Shri</option>
            <option value="Smt.">Smt.</option>
            <option value="Kum.">Kum.</option>
            <option value="Ms.">Ms.</option>
          </select> 
		  
		  
		  <input name="FH_NAME" type="text"  id="FH_NAME"   value="" size="30" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th>(7 A)</th>
        <th colspan="2" nowrap>Designation*:</th>
        <td colspan="3"><input name="AUTH_DESIG" type="text"  id="AUTH_DESIG"   value="" size="30" maxlength="20" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      
      <tr>
        <th>(7 B)</th>
        <th colspan="2" nowrap><strong>AADHAAR No. of Authorised Person: </strong></th>
        <td colspan="3"><input name="AADHAR_NO" type="text" class="aadharimg"  id="AADHAR_NO" maxlength="12" onKeyPress="return numbersonly(event);" value="" /></td>
      </tr>
      <tr>
        <th>(7 D)</th>
        <th colspan="2" nowrap>PAN No of <strong>Authorised Person : </strong></th>
        <td colspan="3"><input name="PAN_NO" type="text" id="PAN_NO"   size="20" maxlength="10" value="" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th>(8)</th>
        <th colspan="2" nowrap><strong> Sponsoring Agency*:</strong></th>
        <td colspan="3"><select name="AGENCY" id="AGENCY"   onchange="showOffice(this.value);" >
          <option value ="-1" >--Select Agency --</option>
          <option value="KV">KVIC</option>
          <option value="KB">KVIB</option>
          <option value="DI">DIC</option>
		   <option value="CB">COIR BOARD</option>
        </select></td>
      </tr>
      <tr>
        <th>(9)</th>
        <th colspan="2" nowrap>State*:</th>
        <td colspan="3">
		
		
          <select name="STATE"  id="STATE" onBlur="showOffice(this.value);" onChange="showDistrict(this.value);">
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
        <th>(10)</th>
        <th colspan="2" nowrap>District*:</th>
		
		<td id ='DISTRICT' colspan="3"><select name="DISTRICT" onBlur="showOffice(this.value);copy_dist()" >
        <option value="-1" >--Select District-</option>
        </select></td>
      </tr>
      <tr>
        <th>(11)</th>
        <th colspan="2" nowrap>Sponsoring Office*: 
          <input name="OFF_CD" type="radio" disabled value="" /></th>
		
		 <td colspan="3" id="office">To get Office Select   Agency, State and District </td>
      </tr>
      
      
      <tr>
        <th>(12)</th>
        <th colspan="2" nowrap>Gender : </th>
        <td colspan="3"><select name="GENDER" id="GENDER">
          <option value="NA" >Not Applicable</option>
          <option value ="Women">Women</option>
        </select></td>
      </tr>
      <tr>
        <th rowspan="2">(13)</th>
        <th colspan="2" nowrap><strong>Social  Category : *
          
          <input name="EDU_ID" type="hidden" value="8">
        </strong></th>
        <td colspan="3"><select name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
          <option value="" selected>-Social Category-</option>
          <option value="GEN">Not Applicable</option>
          <option value="OBC">Other Backward Caste</option>
          <option value="SC">Scheduled Caste</option>
          <option value="ST">Scheduled Tribe</option>
          <option value="MN">Minority</option>
        </select></td>
      </tr>
      
      <tr>
        <th colspan="2" nowrap><strong>Special  Category (if any):</strong></th>
        <td colspan="3"><select name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
          <option value="NA">Not Applicable</option>
          <option value="EX">Ex-Serviceman</option>
          <option value="PH">Physically Challenged</option>
          <option value="HA">Hill Boarder Region</option>
          <option value="NE">North East Region</option>
        </select></td>
      </tr>
      <tr>
        <th>(14)</th>
        <th colspan="2" nowrap><strong>office Address: * </strong></th>
        <td colspan="3"><input name="APP_POST_ADDR" type="text" id="APP_POST_ADDR"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
        </tr>
      
      
      
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Taluk/Block*:</td>
        <td colspan="3"><input name="APP_TALUK_BLOCK" type="text" id="APP_TALUK_BLOCK" size="50" maxlength="60" onKeyPress="return RestrictSpecialChar(event);" /></td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2"><input name="APP_DIST_CD" type="hidden" id="APP_DIST_CD" value="" />
District*:</td>
        <td colspan="3"><input name="UNIT_DIST_NM" type="text" id="UNIT_DIST_NM" style="background-color: #FFCCCC"  readonly="true"  /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Pin*:</td>
        <td colspan="3"><input name="APP_PIN" type="text" id="APP_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th colspan="2" nowrap>Authorised Person Mobile No:*:</th>
        <td colspan="3">(1)<input name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" /> 
          Office Telephone No: 
            <input name="MOB_NO2" type="text" class="mob"  id="MOB_NO2" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" /> </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th colspan="2" nowrap>Office eMail:</th>
        <td colspan="3"> <input name="E_MAIL" type="text" id="E_MAIL" size="40"  maxlength="58" /></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <th colspan="2" nowrap>Bank Account of  <%= BENF_TYPE_DESC %></th>
        <td colspan="3"><input name="BANK_ACCNO" type="text" id="BANK_ACCNO" size="20"  maxlength="20" /></td>
      </tr>
      <tr>
        <th>(15)</th>
        <th colspan="2" nowrap>Unit Location </th>
        <td colspan="3"><select name="UNIT_LOC" id="UNIT_LOC" >
          <option value="">Select</option>
          <option value="Rural">Rural</option>
          <option value="Urban">Urban</option>
        </select></td>
      </tr>
      <tr>
        <th>(16)</th>
        <th colspan="2" nowrap><strong>Proposed Unit Address </strong><strong>: </strong></th>
        <td colspan="3"><input name="CopyAddress" type="button" class="button" onClick="copy_addres();" value="Copy Communication Address to Unit Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Address*</td>
        <td colspan="3"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  size="45" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Taluk/Block*</td>
        <td colspan="3"><input name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  size="40" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2"> District*
          <input name="UNIT_DIST_CD" type="hidden" id="UNIT_DIST_CD" value="" /></td>
        <td colspan="3"><input name="APP_DIST_NM" type="text" id="APP_DIST_NM"  style="background-color: #FFCCCC" readonly="true"  /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Pin*</td>
        <td colspan="3"><input name="UNIT_PIN" type="text" id="UNIT_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
      <tr>
        <th>(17)</th>
        <th colspan="2" nowrap><strong>Type of Activity  : * </strong></th>
        <td colspan="3"><select name="IND_TYPE" id="IND_TYPE" >
        <option value="">-Select-</option>
        <option value="M" >Manufacturing</option>
        <option value="S" >Service</option>
		<option value="T" >Trading</option>

        </select><input name="btnActList" type="button" class="button" id="btnActList"  onClick="activity();"  value="Select Industry / Activity" /></td>
      </tr>
      <tr>
        <th>(18)</th>
        <th colspan="2" nowrap>Industry / Activity Name : <strong>
          <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
        </strong></th>
        <td colspan="3"><input name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Product Description: </td>
        <td colspan="3"><input name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th>(19)</th>
        <th colspan="2" nowrap><strong>EDP Training Undergone:*
            <input name="EDP_TRG_FRDT" type="hidden" id="EDP_TRG_FRDT"  onkeypress="return onlyDate(event);" value=""/>
            <input name="EDP_TRG_TODT" type="hidden" id="EDP_TRG_TODT"  onkeypress="return onlyDate(event);" value="" />
            <input name="EDP_TRG_CDT" type="hidden" id="EDP_TRG_CDT"   onkeypress="return onlyDate(event);" value="" />
        </strong></th>
        <td colspan="3"><select name="EDP_YN" id="EDP_YN" onChange="edpyn();">
          <option value="">-Select-</option>
          <option value="N">No</option>
          <option value="Y">Yes</option>
        </select> <input name="GS_AMT" type="hidden" id="GS_AMT" onKeyPress="return numbersonly(event)" value="" />
        <input name="GS_AVAIL_YN" type="hidden" value="N" />
        <input name="GS_DETAIL" type="hidden" id="GS_DETAIL" onKeyPress="return RestrictSpecialChar(event);" value="" /></td>
      </tr>
      
      
         
      
     
      
      <tr>
        <th>(20)</th>
      <th colspan="2" nowrap>EDP Training Instn. Name </th>
      <td colspan="3"><input name="EDP_INST_ADDR" type="text" id="EDP_INST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="50" maxlength="50" /></td>
      </tr>
      <tr>
        <th nowrap>(21)</th>
        <th colspan="2" nowrap><strong>Project Cost  :
           
            <input name="WORKSHED_COST" type="hidden" id="WORKSHED_COST"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
            <input name="PRE_OPE_EXP" type="hidden"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
            <span class="style60">
            <input name="TOTAL_CE" type="hidden" id="TOTAL_CE" style="background-color: #FFCCCC" value="" />
            <input name="EMP_ENV" type="hidden" id="EMP_ENV"    title="Employment Envisaged (Full Time)"  value="0" />
            </span></strong></th>
        <th nowrap> Capital Expenditure</th>
        <th nowrap>Working Capital</th>
        <th nowrap><strong>Total</strong></th>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        <td><div align="center">
          <input name="MACHINARY_COST" type="text" id="MACHINARY_COST" onChange="proj_cal();" size="8" maxlength="7" onKeyPress="return numbersonly(event);"/>
        </div></td>
        <td><div align="center">
          <input name="WORKING_CAPITAL" type="text" id="WORKING_CAPITAL"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" size="8" maxlength="7" />
          &nbsp;</div></td>
        <td><div align="center">
          <input name="TOTAL_PRJ" type="text" id="TOTAL_PRJ" style="background-color: #FFCCCC" value="<%= TOTAL_PRJ %>" readonly="true"  size="8" />
        </div></td>
      </tr>
      <tr>
        <th>(22)</th>
        <th colspan="2" nowrap>1st Financing Bank*: </th>
        <td colspan="3"><span class="style64">
          <select name="BANK_NAME" id="BANK_NAME" >
            <option value="" >--Select Bank Name-</option>
            <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd");
	   
	   while(rs.next()){ 
	   
	   %>
            <option value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></option>
            <% } 
	  rs.close();
	   %>
          </select>
        </span></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">IFS/Bank Code*: </td>
        <td colspan="3"><input name="IFSC_CODE" type="text" id="IFSC_CODE"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <input name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Branch Name*: </td>
        <td colspan="3"><input name="BRANCH_NAME" type="text" id="BRANCH_NAME"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">Address*:</td>
        <td colspan="3"><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="70" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      <td colspan="2">District:</td>
      <td colspan="3"><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" /></td>
    </tr>
      
      <tr>
        <th>(23)</th>
      <th colspan="2" nowrap>2nd Financing Branch IFS Code <input type="hidden" name="BANK_TYPE" id="BANK_TYPE" value="1" /></th>
      <td colspan="3"><input name="IFSC_CODE2" type="text" id="IFSC_CODE2" maxlength="11" /></td>
      </tr>
      <tr>
    <th>(24)</th>
    <th colspan="2" nowrap><strong>Want To avail CGTMSE  : * </strong></th>
    <td colspan="4"><select name="TECH_QUALI" class="button" id="TECH_QUALI" >
      <option value="" selected>-Select-</option>
      <option value="Y" <% if (TECH_QUALI.equals("Y")){out.print("selected");}%> >Yes</option>
      <option value="N" <% if (TECH_QUALI.equals("N")){out.print("selected");}%>>No</option>     
    </select>
	 </td>
  </tr>
   <tr>
    <th>(25)</th>
    <th colspan="2" nowrap><strong>Where did you hear about PMEGP  : * </strong></th>
    <td colspan="4"><select name="BLDG_TYPE" class="button" id="BLDG_TYPE" >
      <option value="" selected>-Select-</option>
      <option value="1" <% if (BLDG_TYPE.equals("1")){out.print("selected");}%> >Word of mouth</option>
      <option value="2" <% if (BLDG_TYPE.equals("2")){out.print("selected");}%>>Awareness Camp</option>
      <option value="3" <% if (BLDG_TYPE.equals("3")){out.print("selected");}%>>Implementing Agencies(KVIC/KVIB/DIC)</option>
	  <option value="4" <% if (BLDG_TYPE.equals("4")){out.print("selected");}%> >Newspaper advertisements</option>
      <option value="5" <% if (BLDG_TYPE.equals("5")){out.print("selected");}%>>Radio advertisements</option>
      <option value="6" <% if (BLDG_TYPE.equals("6")){out.print("selected");}%>>Television advertisement</option>
	  <option value="7" <% if (BLDG_TYPE.equals("7")){out.print("selected");}%> >Internet advertisement</option>
      <option value="8" <% if (BLDG_TYPE.equals("8")){out.print("selected");}%>>Social Media (Twitter,facebook,etc)</option>
      <option value="9" <% if (BLDG_TYPE.equals("9")){out.print("selected");}%>>Search Engine</option>
	  <option value="10"<% if (BLDG_TYPE.equals("10")){out.print("selected");}%>>Other</option>
    </select>	  
     </td>
  </tr>
   
      
      <tr>
      
		
		 <td colspan="6"><input name="checkbox" type="checkbox" value="checkbox" checked>
          I hereby declare that information given above is true to the best of my knowledge. Any information to be found incorrect /false / wrong , I shall be liable for suitable Action. </td>
      </tr>
      <tr>
        <td colspan="6">
          <div align="center">
            <input type="hidden" name="ins" id="ins" value="" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input name="Button2" type="button" class="button"  onClick="sub_form();" value="Save Applicant Data" />
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="Button2" type="button" class="button" onClick="openDPR();"    value="Prepare DPR" />
&nbsp;&nbsp;&nbsp;&nbsp;<a href="../pmegphome/index.jsp" class="button">Home</a></div></td></tr>
      <tr>
        <td colspan="6"><div align="right">
          <%
   try{
   if ((String)request.getParameter("ins")!=null){
	
		APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
FH_NAME=(String) request.getParameter("FH_NAME")==null?"":(String) request.getParameter("FH_NAME").trim();
BENF_TYPE_CD=(String) request.getParameter("BENF_TYPE_CD")==null?"":(String) request.getParameter("BENF_TYPE_CD").trim();
BENF_CATAGORY_CD=(String) request.getParameter("BENF_CATAGORY_CD")==null?"":(String) request.getParameter("BENF_CATAGORY_CD").trim();
GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
APP_TALUK_BLOCK=(String) request.getParameter("APP_TALUK_BLOCK")==null?"":(String) request.getParameter("APP_TALUK_BLOCK").trim();
APP_DIST_CD=(String) request.getParameter("APP_DIST_CD")==null?"":(String) request.getParameter("APP_DIST_CD").trim();
APP_PIN=(String) request.getParameter("APP_PIN")==null?"":(String) request.getParameter("APP_PIN").trim();
E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();
EDU_ID=(String) request.getParameter("EDU_ID")==null?"8":(String) request.getParameter("EDU_ID").trim();
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
ACT_ID=(String) request.getParameter("ACT_ID")==null?"0":(String) request.getParameter("ACT_ID").trim();
BANK_F_DATE=(String) request.getParameter("BANK_F_DATE")==null?"":(String) request.getParameter("BANK_F_DATE").trim();
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME").trim();
BANK_DISTRICT=(String) request.getParameter("BANK_DISTRICT")==null?"":(String) request.getParameter("BANK_DISTRICT").trim();
AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO").trim();
MOB_NO2=(String) request.getParameter("MOB_NO2")==null?"":(String) request.getParameter("MOB_NO2").trim();
IFSC_CODE2=(String) request.getParameter("IFSC_CODE2")==null?"":(String) request.getParameter("IFSC_CODE2").trim();
ONLINE_SUBDT=(String) request.getParameter("ONLINE_SUBDT")==null?"":(String) request.getParameter("ONLINE_SUBDT").trim();
EDP_INST_ADDR=(String) request.getParameter("EDP_INST_ADDR")==null?"":(String) request.getParameter("EDP_INST_ADDR").trim();
EDP_YN=(String) request.getParameter("EDP_YN")==null?"":(String) request.getParameter("EDP_YN").trim();

		
		ResultSet rsProMaxID = db.execSQL("SELECT   FAPPIDGEN("+OFF_CD+") AS MAXID FROM APP_DETAIL ");
		
		while (rsProMaxID.next()){
		  APP_ID=rsProMaxID.getString(1);
		}
		rsProMaxID.close();
       
		List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		      
qryUpdate.append(" INSERT INTO APP_DETAIL ");
qryUpdate.append(" ( APP_ID,");
qryUpdate.append("OFF_CD,");
qryUpdate.append("APP_PRIX,");
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
qryUpdate.append("ONLINE_SUBDT ) ");

qryUpdate.append("  VALUES ( ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, SYSDATE)");






values.clear();
pstm.clear();

values.add(APP_ID); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");
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

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
%>

<jsp:forward page="pmegpOnlineSaveMsg.jsp"> 
<jsp:param name="APP_ID" value="<%= APP_ID %>" /> 
</jsp:forward> 



<%

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
  <td><table class="table">
    <tr bgcolor="#D1A476">
      <td colspan="2"><h3 align="center" class="style1"> Guidelines for Filling the Online PMEGP Application </h3></td>
    </tr>
    <tr>
      <td>(1)</td>
      <td ><p><strong>Legal Type :</strong>This Form is pertaining to Non Individual Applicant <strong> </strong>(Self Help Groups, Trust,Regd. Institutions, Co-operative Societies) </p></td>
    </tr>
    <tr>
      <td >(2)</td>
      <td ><strong>Name of </strong>Institution/SHG/etc. :</td>
    </tr>
    <tr>
      <td >(3) </td>
      <td  >Except SHG others are need to enter Registration No.</td>
    </tr>
    <tr>
      <td >(4)</td>
      <td  >Registration Date : Enter Registration Date. </td>
    </tr>
    <tr>
      <td >(5)</td>
      <td  >TAN No. : Enter TAN Number. </td>
    </tr>
    <tr>
      <td >(6)</td>
      <td  >Authorised Person Name : Enter Authorised Person Name. </td>
    </tr>
    <tr>
      <td >(7)</td>
      <td  >Designation : Enter Designation of the authorised person </td>
    </tr>
    <tr>
      <td >(8) </td>
      <td  ><p><strong>Sponsoring Agency</strong> :  Select Agency  (KVIC, KVIB, DIC)</p></td>
    </tr>
    <tr>
      <td>(9)</td>
      <td ><strong>State : </strong>Select State from the list.</td>
    </tr>
    <tr>
      <td>(10)</td>
      <td ><strong>District</strong> : Select District from the  list </td>
    </tr>
    <tr>
      <td>(11)</td>
      <td ><strong>Sponsoring Office</strong> : Select Office from the  list </td>
    </tr>
    <tr>
      <td>(12) </td>
      <td ><strong>Gender : </strong>Select  Gender (i.e. Women / NA) </td>
    </tr>
    <tr>
      <td>(13)</td>
      <td ><p><strong>Social Category : </strong>Select Social Category  from the list (i.e.    Other Backward Caste, Scheduled Caste, Scheduled Tribe, Minority). If none of them  select Not Applicable. </p>
          <p>Special Category : Select Special Category from the list (i.e. Ex-serviceman, Physically Challenged, Hill Border Area, North East Area). If non of then them select Not Applicable. </p></td>
    </tr>
    <tr>
      <td>(14)</td>
      <td ><strong>Office Address : </strong>Enter   complete postal address  including Taluka, Block,  District, Pin Code, Mobile No., Office No.,Email and Bank A/c No. </td>
    </tr>
    <tr>
      <td>(15)</td>
      <td ><strong>Unit Location</strong> : Select Unit Location (i.e. Rural OR Urban) </td>
    </tr>
    <tr>
      <td>(16)</td>
      <td ><strong>Proposed Unit Address</strong> : Fill  the complete Unit address of the unit including Taluka, District, Pin Code (If Unit Address is same as Communication Address then click on communication Address to Unit Address) </td>
    </tr>
    <tr>
      <td>(17)</td>
      <td ><strong>Type of Activity</strong> : Select from the activity list (i.e. Service or Manufacturing) </td>
    </tr>
    <tr>
      <td>(18)</td>
      <td ><strong>Name of the Activity</strong> : (i) <strong>Industry : </strong>Select Industry from the List of Industry (ii) <strong>Product Description : </strong>Type the specific product description. </td>
    </tr>
    <tr>
      <td>(19)</td>
      <td ><strong>Whether EDP Training Undergone</strong> :  Select Yes Or No from the List . </td>
    </tr>
    <tr>
      <td>(20)</td>
      <td ><strong>Training Institution Name : </strong>If EDP Training Undergone YES, enter Training Institute Name in detail.</td>
    </tr>
    <tr>
      <td>(21)</td>
      <td ><strong>Loan Required</strong> : (i) <strong>Capital Expenditure : </strong> Enter CE loan as proposed in the DPR in rupees. (ii) <strong>Working Capital</strong> : Enter WC loan as proposed in the DPR in rupees. (iii) <strong>Total Loan : </strong> The total loan will be calculated by the system automatically. </td>
    </tr>
    <tr>
      <td>(22)</td>
      <td ><strong>Bank Details : (i) </strong>Enter IFSC code (ii) if IFSC code is not known then click on GET IFSC CODE button and select correct IFSC Code of Financing Bank. (iii) Enter optional Bank IFSC code . </td>
    </tr>
    <tr>
      <td>(23)</td>
      <td >2nd Financial Bank : Enter IFS Code of the 2nd Financing Branch which is optional </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <th>After entering all necessary information in the appropriate field Click On &quot;Save Applicant Data&quot; button to Save the Details. </th>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>After &quot;Save Applicant Data&quot; , you need to Upload documents for final submission of application. </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>After Final Submission of Application , Applicant ID and password will be sent to your registered Mobile No. </td>
    </tr>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </table></td>
</tr>
</table>
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
 
function activity(){

var AGENCY= document.form.AGENCY.value;
var IND_TYPE= document.form.IND_TYPE.value;    

if (AGENCY == "-1") {	
 inlineMsg ( 'AGENCY','Please Select Agency',2);	
 return (false);
 }
 else if (IND_TYPE == "") {	
 inlineMsg ( 'IND_TYPE','Please Select Type of Activicty',2);	
 return (false);
 } 
 else {
 var urlpar='PMEGPlovpage.jsp?AGENCY='+AGENCY;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 }
 
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

function getBankLOV2(IFSC){
 form.IFSC_CODE2.value=IFSC;
}

</script>

</form>
 

</body>
</html>
