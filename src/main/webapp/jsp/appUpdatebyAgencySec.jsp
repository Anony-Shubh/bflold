<%@ include file="includeHeaderPage.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SECOND lOAN</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script src="../js1/jquery-customselect.js"></script>
<script type="text/javascript" src="../js/Pmegpsecondloan.js"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<html>
<head>
<title>PMEGP Online Application Registration</title>

<script language="javascript">
  function sub_form(){
	  
			 if (validate(form)){
				  
				var answer = confirm ("Once Clicked On 'OK' Button, username and password will be sent to your registered mobile no."+ '\n' + "Using this Username and password, login to the system and make necessary corrections, if any and also upload necessary documents.  Once the application is completed in all respect,  click on final Submission button to forward your application to concerned agency.  After final submission you can print your application.")
					if (answer){
						
					 	
	 document.form.ins.value='I';
     document.form.submit();
					}
	}
	  }
</script>
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
<%


List values=new ArrayList();
	List pstm=new ArrayList(); 

String state="";
String qrystr="";
String Agency=""; 
 DBCon db= new DBCon();
db.connect();
String UNIT_ESTB_YR="";
 String UAD= "";
String ACT_YN="";
//out.print (APP_ID);
String vOffcd= "";
String vOrgCD= "";
String vState= "";
String cmbSel="";
String OFF_CD = "";
String APP_PRIX = "";
String APP_NAME = "";
String FH_NAME = "";
String APP_ID = request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
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

String ACT_ID = "";
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
String APP_PWD="";
String BENF_SPECAT_CD="";

//DISPLAY FIELD
String AGE="";
String UNIT_DIST_NM="";
String APP_DIST_NM="";
String STATE_CD="";


//EXTRA CALCULATED

String Activity_desc="";
String TOTAL_PRJ="";
String ORG_CD="";
String STATE="";


StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT AD.OFF_CD," );
qrysb.append("     AD.APP_ID,AD.ACT_ID," );
qrysb.append("     AD.APP_PRIX," );
qrysb.append("     AD.APP_NAME," );
qrysb.append("     AD.UAD," );
qrysb.append("     AD.GENDER," );
qrysb.append("     AD.MOB_NO1," );
qrysb.append("     AD.APP_POST_ADDR," );
qrysb.append("     AD.APP_TALUK_BLOCK," );
qrysb.append("     AD.APP_DIST_CD," );
qrysb.append("     AD.APP_PIN," );
qrysb.append("     AD.E_MAIL," );
qrysb.append("     AD.UNIT_LOC," );
qrysb.append("     AD.UNIT_POST_ADDR," );
qrysb.append("     AD.UNIT_TALUK_BLOCK," );
qrysb.append("     AD.UNIT_DIST_CD," );
qrysb.append("     AD.UNIT_PIN,TRUNC((SYSDATE-AD.DOB)/365) AS AGE,TO_CHAR(AD.DOB,'DD-MM-RRRR') AS DOB," );
qrysb.append("     AD.MACHINARY_COST,TO_CHAR(ad.UNIT_ESTB_YR,'DD-MON-RRRR') AS UNIT_ESTB_YR," );
qrysb.append("     AD.WORKING_CAPITAL,AD.BENF_CATAGORY_CD," );
qrysb.append("     NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0) AS TOTAL_PRJ," );
qrysb.append("     AD.BANK_NAME," );
qrysb.append("     AD.BANK_POST_ADDR," );
qrysb.append("     AD.BANK_TALUK_BLOCK," );
qrysb.append("     AD.BANK_PINCD," );
qrysb.append("     AD.PROD_DESC," );
qrysb.append("     AD.IFSC_CODE," );
qrysb.append("     AD.ACTIVITY_CD," );
qrysb.append("     AD.BRANCH_NAME," );
qrysb.append("     AD.BANK_DISTRICT," );
qrysb.append("     AD.AADHAR_NO," );
qrysb.append("     AD.MOB_NO2,AD.EMP_ENV ," );
qrysb.append("     AD.IFSC_CODE2," );
qrysb.append("     AD.PAN_NO," );
qrysb.append("     AD.BENF_SPECAT_CD," );
qrysb.append("     IGM.IND_GRP_LONG_DESC," );
qrysb.append("     AM.ACTIVITY_NAME," );
qrysb.append("     MOM.ORG_CD," );
qrysb.append("     AD.IND_TYPE," );
qrysb.append("     UNITMD.DISTRICT_NAME UNIT_DIST_NM," );
qrysb.append("     APPMD.DISTRICT_NAME AS APP_DIST_NM," );
qrysb.append("     UNITMS.STATE_CD AS UNIT_STATE" );
qrysb.append("   FROM APP_DETAIL_SECOND AD," );
qrysb.append("     MAS_OFF_MAST MOM," );
qrysb.append("     ACTIVITY_MAST AM," );
qrysb.append("     IND_GRP_MAST IGM," );
qrysb.append("     M_DISTRICT APPMD," );
qrysb.append("     M_DISTRICT UNITMD," );
qrysb.append("     M_DISTRICT OFFMD," );
qrysb.append("     M_STATE UNITMS" );
qrysb.append("   WHERE AD.OFF_CD     = MOM.OFF_CD" );
qrysb.append("   AND AD.ACTIVITY_CD  = AM.ACTIVITY_CD" );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD" );
qrysb.append("   AND AD.APP_DIST_CD  = APPMD.DISTRICT_CD" );
qrysb.append("   AND AD.UNIT_DIST_CD = UNITMD.DISTRICT_CD" );
qrysb.append("   AND MOM.DISTRICT_CD = OFFMD.DISTRICT_CD" );
qrysb.append("   AND UNITMD.STATE_CD = UNITMS.STATE_CD AND AD.APP_ID='"+APP_ID+"'" );

ResultSet rsMain=db.execSQL(qrysb.toString());

while (rsMain.next()){

OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
APP_PRIX=rsMain.getString("APP_PRIX")==null?"":rsMain.getString("APP_PRIX");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
ACT_ID=rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
BENF_CATAGORY_CD=rsMain.getString("BENF_CATAGORY_CD")==null?"":rsMain.getString("BENF_CATAGORY_CD");
UNIT_ESTB_YR=rsMain.getString("UNIT_ESTB_YR")==null?"":rsMain.getString("UNIT_ESTB_YR");
GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
APP_POST_ADDR=rsMain.getString("APP_POST_ADDR")==null?"":rsMain.getString("APP_POST_ADDR");
APP_TALUK_BLOCK=rsMain.getString("APP_TALUK_BLOCK")==null?"":rsMain.getString("APP_TALUK_BLOCK");
APP_DIST_CD=rsMain.getString("APP_DIST_CD")==null?"":rsMain.getString("APP_DIST_CD");
APP_PIN=rsMain.getString("APP_PIN")==null?"":rsMain.getString("APP_PIN");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
UNIT_LOC=rsMain.getString("UNIT_LOC")==null?"":rsMain.getString("UNIT_LOC");
UNIT_POST_ADDR=rsMain.getString("UNIT_POST_ADDR")==null?"":rsMain.getString("UNIT_POST_ADDR");
UNIT_TALUK_BLOCK=rsMain.getString("UNIT_TALUK_BLOCK")==null?"":rsMain.getString("UNIT_TALUK_BLOCK");
UNIT_DIST_CD=rsMain.getString("UNIT_DIST_CD")==null?"":rsMain.getString("UNIT_DIST_CD");
UNIT_PIN=rsMain.getString("UNIT_PIN")==null?"":rsMain.getString("UNIT_PIN");
MACHINARY_COST=rsMain.getString("MACHINARY_COST")==null?"":rsMain.getString("MACHINARY_COST");
WORKING_CAPITAL=rsMain.getString("WORKING_CAPITAL")==null?"":rsMain.getString("WORKING_CAPITAL");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
BANK_POST_ADDR=rsMain.getString("BANK_POST_ADDR")==null?"":rsMain.getString("BANK_POST_ADDR");
BANK_TALUK_BLOCK=rsMain.getString("BANK_TALUK_BLOCK")==null?"":rsMain.getString("BANK_TALUK_BLOCK");
BANK_PINCD=rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
PROD_DESC=rsMain.getString("PROD_DESC")==null?"":rsMain.getString("PROD_DESC");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
ACTIVITY_CD=rsMain.getString("ACTIVITY_CD")==null?"":rsMain.getString("ACTIVITY_CD");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
BANK_DISTRICT=rsMain.getString("BANK_DISTRICT")==null?"":rsMain.getString("BANK_DISTRICT");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
MOB_NO2=rsMain.getString("MOB_NO2")==null?"":rsMain.getString("MOB_NO2");
IFSC_CODE2=rsMain.getString("IFSC_CODE2")==null?"":rsMain.getString("IFSC_CODE2");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
BENF_SPECAT_CD=rsMain.getString("BENF_SPECAT_CD")==null?"":rsMain.getString("BENF_SPECAT_CD");
EMP_ENV=rsMain.getString("EMP_ENV")==null?"":rsMain.getString("EMP_ENV");
 UAD=rsMain.getString("UAD")==null?"":rsMain.getString("UAD");
 
 UNIT_DIST_NM=rsMain.getString("UNIT_DIST_NM")==null?"":rsMain.getString("UNIT_DIST_NM");
 APP_DIST_NM=rsMain.getString("APP_DIST_NM")==null?"":rsMain.getString("APP_DIST_NM");
 STATE_CD=rsMain.getString("UNIT_STATE")==null?"":rsMain.getString("UNIT_STATE");
 Activity_desc=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
 TOTAL_PRJ=rsMain.getString("TOTAL_PRJ")==null?"":rsMain.getString("TOTAL_PRJ");
 ORG_CD=rsMain.getString("ORG_CD")==null?"":rsMain.getString("ORG_CD");
DOB=rsMain.getString("DOB")==null?"":rsMain.getString("DOB");
AGE=rsMain.getString("AGE")==null?"":rsMain.getString("AGE");
}


//out.print ("DIST:"+APP_DIST_CD);
ResultSet rsDist = db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD='"+STATE_CD+"'");

//out.print ("DIST:"+BENF_CATAGORY_CD);
	%>

</head>

<body onLoad="showOffice(this.value);">

<form name="form"  id="form" method="post"  >


  <table align="center" class="CSSTableGenerator">
  <tr bgcolor="#D1A476">
    <td colspan="7">
      <h3>PMEGP ONLINE APPLICATION FOR SECOND LOAN SUBSIDY FOR UPGRADING OF EXISTING UNIT</h3>    </td>
  </tr>
  <tr>
    <th>(1)</th>
    <th colspan="2" nowrap><strong>Udyog Aadhar Registration No: </strong></th>
    <td colspan="4"><input name="UAD" type="text" class="aadharimg"  value="<%=UAD%>"  id="UAD" onKeyPress="return numbersonly(event);" size="17" maxlength="12" /></td>
  </tr><input name="APP_ID" type="hidden"  id="APP_ID" value="<%=APP_ID%>"/>
  <tr><input name="ACT_ID" type="hidden"  id="ACT_ID" value="<%=ACT_ID%>"/>
    <th>&nbsp;</th>
    <th colspan="2"><strong>AADHAAR Card No: </strong></th>
    <td colspan="4"><input name="AADHAR_NO" type="text" id="AADHAR_NO" value="<%= AADHAR_NO %>" size="17" maxlength="12" /></td>
  </tr>
  <tr>
    <th>(2)</th>
    <th colspan="2"><strong>Name of Applicant:*</strong></th>
    <td colspan="4"><select name="APP_PRIX" id="APP_PRIX">
      <option value="">-Select-</option>
      <option value="Shri" <% if (APP_PRIX.equals("Shri")){out.print("selected");}%>>Shri</option>
      <option value="Smt." <% if (APP_PRIX.equals("Smt.")){out.print("selected");}%>>Smt.</option>
      <option value="Kum." <% if (APP_PRIX.equals("Kum.")){out.print("selected");}%>>Kum.</option>
      <option value="M/s." <% if (APP_PRIX.equals("M/s.")){out.print("selected");}%>>M/s.</option>
    </select>
        <input name="APP_NAME" type="text"  id="APP_NAME" readonly="true" value="<%=APP_NAME  %>"/> 
        (Not Editable) </td>
  </tr>
  
  <tr>
    <th>(3)</th>
    <th colspan="2" nowrap><strong> Sponsoring Agency*:</strong></th>
    <td colspan="4"><select name="AGENCY" class="button" id="AGENCY"   onchange="showOffice(this.value);" >
      <option value ="-1" >--Select Agency --</option>
      <option value="KV" <% if (ORG_CD.equals("KV")){out.print("selected");}%> >KVIC</option>
      <option value="KB" <% if (ORG_CD.equals("KB")){out.print("selected");}%>>KVIB</option>
      <option value="DI" <% if (ORG_CD.equals("DI")){out.print("selected");}%>>DIC</option>
	   <option value="CB" <% if (ORG_CD.equals("CB")){out.print("selected");}%>>COIR</option>
    </select></td>
  </tr>
  <tr>
    <th>(4)</th>
    <th colspan="2" nowrap>State*:</th>
    <td colspan="4"><select name="STATE" class="button"  id="STATE"  onBlur="showOffice(this.value);" onChange="getDistrict(this.value);">
      <option value="-1">--Select State--</option>
      <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms    order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   %>
      <option value="<%=rs.getString("state_cd")%>" <% if (state.equals(STATE_CD)){out.print("selected");}%>><%=rs.getString("state_nm")%></option>
      <% } 
	  rs.close();
	   %>
    </select>    </td>
  </tr>
  <tr>
    <th>(5)</th>
    <th colspan="2" nowrap>District*:</th>
    <td id ='DISTRICT' colspan="4"><select name="DISTRICT" class="button" onChange="showOffice(this.value);" >
	<% 
	String vDistCd="";
	String vDistnm="";
	while (rsDist.next()) { 
	 vDistCd=rsDist.getString(1);
	 vDistnm=rsDist.getString(2);
	
	%>
      <option value="<%= vDistCd %>" <% if (vDistCd.equals(UNIT_DIST_CD)){out.print("selected");}%> ><%= vDistnm %></option>
	  
	  <% } 
	  rsDist.close();
	  
	  %>
    </select></td>
  </tr>
  <tr>
    <th>(6)</th>
    <th colspan="2" nowrap>Sponsoring Office*:
      <input name="OFF_CD" type="radio" value="<%= OFF_CD %>" checked="checked"/></th>
    <td   colspan="4" id="office">To get Office Select   Agency, State and District </td>
  </tr>
  <tr>
    <th>(7)</th>
    <th colspan="2" nowrap><strong>Legal Type*
      <input name="FH_NAME" id="FH_NAME" type="hidden" value="-" />
          <input name="FH_NM_DESC"  id="FH_NM_DESC" type="hidden" value="-" />
    </strong></th>
    <th colspan="4"> <input name="BENF_TYPE_CD" id="BENF_TYPE_CD" type="hidden" value="1" />
      INDIVIDUAL</th>
  </tr>
  <tr>
    <th>(8)</th>
    <th colspan="2" nowrap><strong>Gender:*</strong></th>
    <td colspan="4"><select name="GENDER" class="button" id="GENDER">
      <option value="" selected>Select</option>
      <option value ="Male" <% if (GENDER.equals("Male")){out.print("selected");}%>>Male</option>
      <option value ="Female" <% if (GENDER.equals("Female")){out.print("selected");}%>>Female</option>
      <option value="Transgender" <% if (GENDER.equals("Transgender")){out.print("selected");}%>>Transgender</option>
    </select></td>
  </tr>
    <tr>
    <th>(9)</th>
    <th colspan="2" nowrap><strong>Date of Birth (dd-mm-yyyy) :*</strong></th>
    <td colspan="4"><input name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" value="<%= DOB %>" />
      Age:
      <input name="AGE" type="text" id="AGE" size="5" maxlength="3" readonly="true" value="<%= AGE %>" /></td>
  </tr>
  <tr>
    <th rowspan="2">(10)</th>
    <th colspan="2" nowrap><strong>Social  Category : *</strong></th>
    <td colspan="4"><select name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
      <option value="-1" selected="selected">-Social Category-</option>
      <option value="GEN" <% if (BENF_CATAGORY_CD.equals("GEN")){out.print("selected");}%>>General</option>
      <option value="OBC" <% if (BENF_CATAGORY_CD.equals("OBC")){out.print("selected");}%>>Other Backward Caste</option>
      <option value="SC" <% if (BENF_CATAGORY_CD.equals("SC")){out.print("selected");}%>>Scheduled Caste</option>
      <option value="ST" <% if (BENF_CATAGORY_CD.equals("ST")){out.print("selected");}%>>Scheduled Tribe</option>
      <option value="MN" <% if (BENF_CATAGORY_CD.equals("MN")){out.print("selected");}%>>Minority</option>
    </select></td>
  </tr>
  <tr>
    <th colspan="2" nowrap><strong>Special Category (if any): </strong></th>
    <td colspan="4"><select name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
      <option value="" selected>-Special Category-</option>
      <option value="NA" selected>Not Applicable</option> 
      <option value="HS" <% if (BENF_SPECAT_CD.equals("HS")){out.print("selected");}%>>Hill Boarder Area</option>
      <option value="NE" <% if (BENF_SPECAT_CD.equals("NE")){out.print("selected");}%>>North East Area</option>
    </select></td>
  </tr>
  <tr>
    <th>(12)</th>
    <th colspan="2" nowrap><strong>Communication Address: * </strong></th>
    <td colspan="4"><input name="APP_POST_ADDR" type="text" id="APP_POST_ADDR"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" value="<%=APP_POST_ADDR  %>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Taluk/Block*:</td>
    <td colspan="4"><input name="APP_TALUK_BLOCK" type="text" id="APP_TALUK_BLOCK" size="50" maxlength="60" onKeyPress="return RestrictSpecialChar(event);"  value="<%=APP_TALUK_BLOCK  %>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2"><input name="APP_DIST_CD" type="hidden" id="APP_DIST_CD" value="<%=APP_DIST_CD  %>"/>
      District*:</td>
    <td colspan="4"><input name="APP_DIST_NM" type="text" id="APP_DIST_NM"  style="background-color: #FFCCCC" readonly="true" value="<%= APP_DIST_NM %>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Pin*:</td>
    <td colspan="4"><input name="APP_PIN" type="text" id="APP_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" value="<%=APP_PIN  %>"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <th colspan="2" nowrap>Mobile No:*:</th>
    <td colspan="4">(1)
        <input name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" value="<%=MOB_NO1%>" />
      (2)
      <input name="MOB_NO2" type="text" class="mob"  id="MOB_NO2" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" value="<%=MOB_NO2%>"/>    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <th colspan="2" nowrap>eMail:</th>
    <td colspan="4"><input name="E_MAIL" type="text" id="E_MAIL" size="20"  maxlength="58" value="<%=E_MAIL %>"/></td>
  </tr>
  <tr>
    <th>&nbsp;</th>
    <th colspan="2" nowrap>PAN NO: </th>
    <td colspan="4"><input name="PAN_NO" type="text" id="PAN_NO"   size="20" maxlength="10" value="<%=PAN_NO %>"/></td>
  </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap>Previous Unit Establishment </th>
        <td colspan="4"> <input type="text"  id="UNIT_ESTB_YR" name="UNIT_ESTB_YR" value="<%=UNIT_ESTB_YR%>" onClick="javascript:NewCssCal('UNIT_ESTB_YR','ddMMMyyyy')" size="11" maxlength="11" ></td>
      </tr>
  <tr>
    <th>(13)</th>
    <th colspan="2" nowrap>Unit Location </th>
    <td colspan="4"><select name="UNIT_LOC" class="button" id="UNIT_LOC" >
      <option value="" selected>Select</option>
      <option value="Rural" <% if (UNIT_LOC.equals("Rural")){out.print("selected");}%> >Rural</option>
      <option value="Urban" <% if (UNIT_LOC.equals("Urban")){out.print("selected");}%>>Urban</option>
    </select></td>
  </tr>
  <tr>
    <th>(14)</th>
    <th colspan="2" nowrap><strong>Proposed Unit Address </strong><strong>: </strong></th>
    <td colspan="4"><input name="CopyAddress" type="button" class="button" onClick="copy_addres();" value="Copy Communication Address to Unit Address" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Address*</td>
    <td colspan="4"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  size="45" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" value="<%=UNIT_POST_ADDR  %>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Taluk/Block*</td>
    <td colspan="4"><input name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  size="40" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" value="<%= UNIT_TALUK_BLOCK %>"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2"> District*
      <input name="UNIT_DIST_CD" type="hidden" id="UNIT_DIST_CD" value="<%= UNIT_DIST_CD %>" /></td>
    <td colspan="4"><input name="UNIT_DIST_NM" type="text" id="UNIT_DIST_NM" style="background-color: #FFCCCC"  readonly="true" value="<%= UNIT_DIST_NM %>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Pin*</td>
    <td colspan="4"><input name="UNIT_PIN" type="text" id="UNIT_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" value="<%= UNIT_PIN %>" /></td>
  </tr>
  <tr>
    <th>(15)</th>
    <th colspan="2" nowrap><strong>Type of Activity  : * </strong></th>
    <td colspan="4"><select name="IND_TYPE" class="button" id="IND_TYPE" >
      <option value="" selected>-Select-</option>
      <option value="M" <% if (IND_TYPE.equals("M")){out.print("selected");}%> >Manufacturing</option>
      <option value="S" <% if (IND_TYPE.equals("S")){out.print("selected");}%>>Service</option>
      <option value="T" <% if (IND_TYPE.equals("T")){out.print("selected");}%>>Trading</option>
    </select>
        <input name="btnActList" type="button" class="button" id="btnActList"  onclick=" window.open ('PMEGPlovpage.jsp', &quot;ActivityLOV&quot;,&quot;location=0,status=0,scrollbars=0,width=710,height=550&quot;);" value="Select Industry / Activity" /></td>
  </tr>
  <tr>
    <th>(16)</th>
    <th colspan="2" nowrap>Industry / Activity Name : <strong>
      <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
    </strong></th>
    <td colspan="4"><input name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Product Description: </td>
    <td colspan="4"><input name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" value="<%=PROD_DESC  %>"/></td>
  </tr> 
  <tr>
    <th nowrap>(19)</th>
    <th colspan="2" nowrap><strong>Project Cost  :
      <input name="BLDG_TYPE" id="BLDG_TYPE" type="hidden" value="" />
          <input name="WORKSHED_COST" type="hidden" id="WORKSHED_COST"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
          <input name="PRE_OPE_EXP" type="hidden"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
          
          <input name="TOTAL_CE" type="hidden" id="TOTAL_CE" style="background-color: #FFCCCC" value="" />        </th>
    <th nowrap> Capital Expenditure</th>
    <th nowrap>Working Capital<strong></strong></th>
    <th nowrap><strong>Total</strong></th>
    <th nowrap>Employment</th>
  </tr>
  <tr>
    <td>&nbsp;</td>  <input type="hidden" name="ins" id="ins" value="" /></th>
    <td colspan="2">&nbsp;</td>
    <td><div align="center">
      <input name="MACHINARY_COST" type="text" id="MACHINARY_COST" onChange="proj_cal();" size="8" maxlength="8"  value="<%=MACHINARY_COST  %>" />
    </div>      <div align="center">      &nbsp;</div>    <div align="center">
    </div></td>
    <td><input name="WORKING_CAPITAL" type="text" id="WORKING_CAPITAL"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" size="8" maxlength="8"  value="<%=WORKING_CAPITAL  %>" /></td>
    <td><input name="TOTAL_PRJ" type="text" id="TOTAL_PRJ" style="background-color: #FFCCCC" value="<%= TOTAL_PRJ %>" readonly="true"  size="8" /></td>
    <td><input name="EMP_ENV" type="text" id="EMP_ENV"    title="Proposed Employment" size="10" maxlength="3" value="<%=EMP_ENV%>" /></td>
  </tr>
  <tr>
    <th>(20)</th>
    <th colspan="2" nowrap>1st Financing Bank*: </th>
    <td colspan="4"><select name="BANK_NAME" class="button"  >
      <option value="-1" selected="selected" >--Select Bank Name-</option>
      <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A");
	   String bnm="";
	   while(rs.next()){ 
	   bnm=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
	   %>
      <option value="<%=bnm %>" <% if ( bnm.equals(BANK_NAME)) { out.print ("Selected");} %>><%=bnm %></option>
      <% } 
	  rs.close();
	   %>
    </select>
        </span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">IFS/Bank Code*: </td>
    <td colspan="4"><input name="IFSC_CODE" type="text" id="IFSC_CODE"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" value="<%=IFSC_CODE  %>" />
        <input name="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Branch Name*: </td>
    <td colspan="4"><input name="BRANCH_NAME" type="text" id="BRANCH_NAME"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" value="<%=BRANCH_NAME  %>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">Address*:</td>
    <td colspan="4"><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="70" value="<%=BANK_POST_ADDR  %>" /></td>
  </tr>
  <tr><input name="FLAG" type="hidden" id="FLAG" value="9">
    <td>&nbsp;</td>
    <td colspan="2">District:</td>
    <td colspan="4"><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" value="<%=BANK_DISTRICT  %>" /></td>
  </tr>
 
      <input type="hidden" name="BANK_TYPE" id="BANK_TYPE" value="1" />
        <input type="hidden" name="ins" id="ins" value="" /></th>
  <input name="IFSC_CODE2" type="hidden" id="IFSC_CODE2" maxlength="11" value="<%=IFSC_CODE2  %>" />
 
  <tr>
    <td colspan="7"><div align="center">&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="Button" type="button" class="button" onClick="sub_form();"  value="Save Applicant Data" />
      &nbsp;&nbsp;&nbsp;&nbsp;</div></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
  </tr>
</table>
<%
   if ((String)request.getParameter("ins")!=null){
   APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
 	

 OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
 APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
 APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
 FH_NAME=(String) request.getParameter("FH_NAME")==null?"":(String) request.getParameter("FH_NAME").trim();
 GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
 DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
 UAD=(String) request.getParameter("UAD")==null?"":(String) request.getParameter("UAD").trim();
 MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
 APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
 APP_TALUK_BLOCK=(String) request.getParameter("APP_TALUK_BLOCK")==null?"":(String) request.getParameter("APP_TALUK_BLOCK").trim();
 APP_DIST_CD=(String) request.getParameter("APP_DIST_CD")==null?"":(String) request.getParameter("APP_DIST_CD").trim();
 APP_PIN=(String) request.getParameter("APP_PIN")==null?"":(String) request.getParameter("APP_PIN").trim();
 E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();

 UNIT_LOC=(String) request.getParameter("UNIT_LOC")==null?"":(String) request.getParameter("UNIT_LOC").trim();
 UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"":(String) request.getParameter("UNIT_POST_ADDR").trim();
 UNIT_TALUK_BLOCK=(String) request.getParameter("UNIT_TALUK_BLOCK")==null?"":(String) request.getParameter("UNIT_TALUK_BLOCK").trim();
 UNIT_DIST_CD=(String) request.getParameter("UNIT_DIST_CD")==null?"":(String) request.getParameter("UNIT_DIST_CD").trim();
 UNIT_PIN=(String) request.getParameter("UNIT_PIN")==null?"":(String) request.getParameter("UNIT_PIN").trim();
 
 MACHINARY_COST=(String) request.getParameter("MACHINARY_COST")==null?"0":(String) request.getParameter("MACHINARY_COST").trim();

 WORKING_CAPITAL=(String) request.getParameter("WORKING_CAPITAL")==null?"0":(String) request.getParameter("WORKING_CAPITAL").trim();
 EMP_ENV=(String) request.getParameter("EMP_ENV")==null?"":(String) request.getParameter("EMP_ENV").trim();
 BANK_NAME=(String) request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME").trim();
 BANK_POST_ADDR=(String) request.getParameter("BANK_POST_ADDR")==null?"":(String) request.getParameter("BANK_POST_ADDR").trim();
 BANK_TALUK_BLOCK=(String) request.getParameter("BANK_TALUK_BLOCK")==null?"":(String) request.getParameter("BANK_TALUK_BLOCK").trim();
 BANK_PINCD=(String) request.getParameter("BANK_PINCD")==null?"":(String) request.getParameter("BANK_PINCD").trim();
 BANK_DIST_CD=(String) request.getParameter("BANK_DIST_CD")==null?"":(String) request.getParameter("BANK_DIST_CD").trim();

 PROD_DESC=(String) request.getParameter("PROD_DESC")==null?"":(String) request.getParameter("PROD_DESC").trim();
 IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();


 ACT_ID=(String) request.getParameter("ACT_ID")==null?"0":(String) request.getParameter("ACT_ID").trim();
 BANK_F_DATE=(String) request.getParameter("BANK_F_DATE")==null?"":(String) request.getParameter("BANK_F_DATE").trim();

 IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
 ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
 BRANCH_NAME=(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME").trim();
 BANK_DISTRICT=(String) request.getParameter("BANK_DISTRICT")==null?"":(String) request.getParameter("BANK_DISTRICT").trim();
 AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO").trim();
 MOB_NO2=(String) request.getParameter("MOB_NO2")==null?"":(String) request.getParameter("MOB_NO2").trim();
 IFSC_CODE2=(String) request.getParameter("IFSC_CODE2")==null?"":(String) request.getParameter("IFSC_CODE2").trim();
 ACT_YN=(String) request.getParameter("ACT_YN")==null?"Y":(String) request.getParameter("ACT_YN").trim();
 PAN_NO=(String) request.getParameter("PAN_NO")==null?"":(String) request.getParameter("PAN_NO").trim();
 BENF_SPECAT_CD=(String) request.getParameter("BENF_SPECAT_CD")==null?"NA":(String) request.getParameter("BENF_SPECAT_CD").trim();


 PRE_OPE_EXP=(String) request.getParameter("PRE_OPE_EXP")==null?"0":(String) request.getParameter("PRE_OPE_EXP").trim();
 WORKSHED_COST=(String) request.getParameter("WORKSHED_COST")==null?"0":(String) request.getParameter("WORKSHED_COST").trim();

String APP_REC_DATE="";




StringBuffer qryUpdate = new StringBuffer();
	try{	      
qryUpdate.append(" UPDATE APP_DETAIL_SECOND SET ");
qryUpdate.append("OFF_CD=?,");
qryUpdate.append("APP_PRIX=?,");
qryUpdate.append("GENDER=?,");
qryUpdate.append("DOB=?,");

qryUpdate.append("MOB_NO1=?,");
qryUpdate.append("APP_POST_ADDR=?,");
qryUpdate.append("APP_TALUK_BLOCK=?,");
qryUpdate.append("APP_DIST_CD=?,");
qryUpdate.append("APP_PIN=?,");
qryUpdate.append("E_MAIL=?,");

qryUpdate.append("UNIT_LOC=?,");
qryUpdate.append("UNIT_POST_ADDR=?,");
qryUpdate.append("UNIT_TALUK_BLOCK=?,");
qryUpdate.append("UNIT_DIST_CD=?,");
qryUpdate.append("UNIT_PIN=?,");
qryUpdate.append("MACHINARY_COST=?,");
qryUpdate.append("WORKING_CAPITAL=?,");
qryUpdate.append("EMP_ENV=?, ");
qryUpdate.append("BANK_NAME=?,");
qryUpdate.append("BANK_POST_ADDR=?,");
qryUpdate.append("BANK_TALUK_BLOCK=?,");
qryUpdate.append("BANK_PINCD=?,");
qryUpdate.append("BANK_DIST_CD=?,");

qryUpdate.append("PROD_DESC=?,");
qryUpdate.append("IFSC_CODE=?,");
qryUpdate.append("APP_REC_DATE=SYSDATE,");
qryUpdate.append("ACT_ID=?,");
qryUpdate.append("IND_TYPE=?,");
qryUpdate.append("ACTIVITY_CD=?,");
qryUpdate.append("BRANCH_NAME=?,");
qryUpdate.append("BANK_DISTRICT=?,");
qryUpdate.append("MOB_NO2=?,");
qryUpdate.append("IFSC_CODE2=?,");

qryUpdate.append("PAN_NO=?, ");
qryUpdate.append("BENF_SPECAT_CD=?, AADHAR_NO=? ");
qryUpdate.append("  WHERE APP_ID=?  ");





values.clear();
pstm.clear();


values.add(OFF_CD); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");

values.add(GENDER); pstm.add ("L");
values.add(getDate(DOB)); pstm.add ("L");
values.add(MOB_NO1); pstm.add ("L");
values.add(APP_POST_ADDR); pstm.add ("L");
values.add(APP_TALUK_BLOCK); pstm.add ("L");
values.add(APP_DIST_CD); pstm.add ("L");
values.add(APP_PIN); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");

values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");
values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(UNIT_PIN); pstm.add ("L");
values.add(MACHINARY_COST); pstm.add ("L");
values.add(WORKING_CAPITAL); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(BANK_POST_ADDR); pstm.add ("L");
values.add(BANK_TALUK_BLOCK); pstm.add ("L");
values.add(BANK_PINCD); pstm.add ("L");
values.add(BANK_DIST_CD); pstm.add ("L");

values.add(PROD_DESC); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");

values.add(ACT_ID); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(ACTIVITY_CD); pstm.add ("L");
values.add(BRANCH_NAME); pstm.add ("L");
values.add(BANK_DISTRICT); pstm.add ("L");
values.add(MOB_NO2); pstm.add ("L");
values.add(IFSC_CODE2); pstm.add ("L");

values.add(PAN_NO); pstm.add ("L");
values.add(BENF_SPECAT_CD); pstm.add ("L");
values.add(AADHAR_NO); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");




//response.sendRedirect("SecondApplicationDetails.jsp");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();


}//ins
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}





 
 }
 %>

</form>

<script>

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
 }//end of bank*/
 
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





</script>
</body>

</html>
