<%@ include file="includeHeaderPageDLTFC.jsp" %>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT type="text/javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/pmegpOnlinemessages.js"></SCRIPT>

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

<%String state="";
String qrystr="";
String Agency=""; 
 DBCon db= new DBCon();
db.connect();


String APP_ID = request.getParameter("APP_ID")==null?"": (String)  request.getParameter("APP_ID");
String vOffcd= "";
String vOrgCD= "";
String vState= "";
String cmbSel="";
String OFF_CD = "";
String APP_PRIX = "";
String APP_NAME = "";
String FH_NAME = "";
String BENF_TYPE_CD= request.getParameter("BENF_CD")==null?"":(String) request.getParameter("BENF_CD");

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

String DT_LOCK1="0";

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





ResultSet rsEdu = db.execSQL("SELECT edu_id, edu_desc FROM education_mast");

StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT AD.OFF_CD," );
qrysb.append("     AD.APP_ID," );
qrysb.append("     AD.APP_PRIX," );
qrysb.append("     AD.APP_NAME," );
qrysb.append("     AD.FH_NAME," );
qrysb.append("     AD.BENF_TYPE_CD,BTM.BENF_TYPE_DESC," );
qrysb.append("     AD.BENF_CATAGORY_CD," );
qrysb.append("     AD.GENDER," );
qrysb.append("     TO_CHAR(AD.DOB,'DD-MM-RRRR') AS DOB," );
qrysb.append("      TRUNC((SYSDATE-AD.DOB)/365) AS AGE," );
qrysb.append("     AD.MOB_NO1," );
qrysb.append("     AD.APP_POST_ADDR," );
qrysb.append("     AD.APP_TALUK_BLOCK," );
qrysb.append("     AD.APP_DIST_CD," );
qrysb.append("     AD.APP_PIN," );
qrysb.append("     AD.E_MAIL," );
qrysb.append("     AD.EDU_ID," );
qrysb.append("     AD.TECH_QUALI," );
qrysb.append("     AD.UNIT_LOC," );
qrysb.append("     AD.UNIT_POST_ADDR," );
qrysb.append("     AD.UNIT_TALUK_BLOCK," );
qrysb.append("     AD.UNIT_DIST_CD," );
qrysb.append("     AD.UNIT_PIN," );
qrysb.append("     AD.MACHINARY_COST," );
qrysb.append("     AD.WORKING_CAPITAL," );
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
qrysb.append("     AD.MOB_NO2," );
qrysb.append("     AD.IFSC_CODE2," );
qrysb.append("     AD.EDP_INST_ADDR," );
qrysb.append("     AD.EDP_YN," );
qrysb.append("     AD.REGD_NO," );
qrysb.append("     AD.TAN_NO," );
qrysb.append("     AD.AUTH_DESIG," );
qrysb.append("     AD.PAN_NO," );
qrysb.append("     AD.BENF_SPECAT_CD,AD.EMP_ENV," );
qrysb.append("     IGM.IND_GRP_LONG_DESC," );
qrysb.append("     AM.ACTIVITY_NAME," );
qrysb.append("     MOM.ORG_CD," );
qrysb.append("     AD.IND_TYPE," );
qrysb.append("     UNITMD.DISTRICT_NAME UNIT_DIST_NM," );
qrysb.append("     APPMD.DISTRICT_NAME AS APP_DIST_NM," );
qrysb.append("     UNITMS.STATE_CD AS UNIT_STATE" );
qrysb.append("   FROM APP_DETAIL AD," );
qrysb.append("     MAS_OFF_MAST MOM," );
qrysb.append("     ACTIVITY_MAST AM," );
qrysb.append("     IND_GRP_MAST IGM," );
qrysb.append("     M_DISTRICT APPMD," );
qrysb.append("     M_DISTRICT UNITMD," );
qrysb.append("     M_DISTRICT OFFMD," );
qrysb.append("     M_STATE UNITMS,BENF_TYPE_MAST BTM" );
qrysb.append("   WHERE AD.OFF_CD     = MOM.OFF_CD" );
qrysb.append("   AND AD.ACTIVITY_CD  = AM.ACTIVITY_CD" );
qrysb.append("   AND AM.IND_GRP_CD   = IGM.IND_GRP_CD" );
qrysb.append("   AND AD.APP_DIST_CD  = APPMD.DISTRICT_CD" );
qrysb.append("   AND AD.UNIT_DIST_CD = UNITMD.DISTRICT_CD" );
qrysb.append("   AND MOM.DISTRICT_CD = OFFMD.DISTRICT_CD AND BTM.BENF_TYPE_CD=AD.BENF_TYPE_CD" );
qrysb.append("   AND UNITMD.STATE_CD = UNITMS.STATE_CD AND AD.APP_ID='"+APP_ID+"'" );

ResultSet rsMain=db.execSQL(qrysb.toString());

while (rsMain.next()){

OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
APP_PRIX=rsMain.getString("APP_PRIX")==null?"":rsMain.getString("APP_PRIX");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
FH_NAME=rsMain.getString("FH_NAME")==null?"":rsMain.getString("FH_NAME");
BENF_TYPE_CD=rsMain.getString("BENF_TYPE_CD")==null?"":rsMain.getString("BENF_TYPE_CD");
BENF_CATAGORY_CD=rsMain.getString("BENF_CATAGORY_CD")==null?"":rsMain.getString("BENF_CATAGORY_CD");
GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
DOB=rsMain.getString("DOB")==null?"":rsMain.getString("DOB");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
APP_POST_ADDR=rsMain.getString("APP_POST_ADDR")==null?"":rsMain.getString("APP_POST_ADDR");
APP_TALUK_BLOCK=rsMain.getString("APP_TALUK_BLOCK")==null?"":rsMain.getString("APP_TALUK_BLOCK");
APP_DIST_CD=rsMain.getString("APP_DIST_CD")==null?"":rsMain.getString("APP_DIST_CD");
APP_PIN=rsMain.getString("APP_PIN")==null?"":rsMain.getString("APP_PIN");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
EDU_ID=rsMain.getString("EDU_ID")==null?"":rsMain.getString("EDU_ID");
TECH_QUALI=rsMain.getString("TECH_QUALI")==null?"":rsMain.getString("TECH_QUALI");
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
EDP_INST_ADDR=rsMain.getString("EDP_INST_ADDR")==null?"":rsMain.getString("EDP_INST_ADDR");
EDP_YN=rsMain.getString("EDP_YN")==null?"":rsMain.getString("EDP_YN");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
BENF_SPECAT_CD=rsMain.getString("BENF_SPECAT_CD")==null?"":rsMain.getString("BENF_SPECAT_CD");
EMP_ENV=rsMain.getString("EMP_ENV")==null?"":rsMain.getString("EMP_ENV");

 AGE=rsMain.getString("AGE")==null?"":rsMain.getString("AGE");
 UNIT_DIST_NM=rsMain.getString("UNIT_DIST_NM")==null?"":rsMain.getString("UNIT_DIST_NM");
 APP_DIST_NM=rsMain.getString("APP_DIST_NM")==null?"":rsMain.getString("APP_DIST_NM");
 STATE_CD=rsMain.getString("UNIT_STATE")==null?"":rsMain.getString("UNIT_STATE");
 Activity_desc=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
 TOTAL_PRJ=rsMain.getString("TOTAL_PRJ")==null?"":rsMain.getString("TOTAL_PRJ");
 ORG_CD=rsMain.getString("ORG_CD")==null?"":rsMain.getString("ORG_CD");
BENF_TYPE_DESC=rsMain.getString("BENF_TYPE_DESC")==null?"":rsMain.getString("BENF_TYPE_DESC");
}


/*ResultSet rsBenfType = db.execSQL("SELECT BENF_TYPE_CD,BENF_TYPE_DESC  FROM BENF_TYPE_MAST WHERE BENF_TYPE_CD= "+BENF_TYPE_CD+"");
while (rsBenfType.next()) {
BENF_TYPE_CD=rsBenfType.getString("BENF_TYPE_CD")==null?"1":rsBenfType.getString("BENF_TYPE_CD");
BENF_TYPE_DESC=rsBenfType.getString("BENF_TYPE_DESC")==null?"-":rsBenfType.getString("BENF_TYPE_DESC");
}
rsBenfType.close();*/


ResultSet rsDist = db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD='"+STATE_CD+"'");
	%>

</HEAD>

<BODY onLoad="showOffice(this.value);">

<FORM name="form"  id="form" method="post"  >

  <TABLE align="center" class="CSSTableGenerator">
  <TR bgcolor="#D1A476">
    <TD colspan="7">
      <H3 align="center">PMEGP APPLICANT DATA UPDATE </H3>
    </TD>
  </TR>
  <TR>
    <TH width="26">(1)</TH>
    <TH colspan="2" nowrap><STRONG>AADHAAR Card No: </STRONG></TH>
    <TD width="280"><INPUT name="AADHAR_NO" type="text" class="aadharimg" id="AADHAR_NO" value="<%= AADHAR_NO %>" size="17" maxlength="12" /></TD>
    <TD width="119"><STRONG>Name of Applicant:*</STRONG></TD>
    <TD colspan="2"><SELECT name="APP_PRIX" id="APP_PRIX">
      <OPTION value="">-Select-</OPTION>
      <OPTION value="Shri" <% if (APP_PRIX.equals("Shri")){out.print("selected");}%>>Shri</OPTION>
      <OPTION value="Smt." <% if (APP_PRIX.equals("Smt.")){out.print("selected");}%>>Smt.</OPTION>
      <OPTION value="Kum." <% if (APP_PRIX.equals("Kum.")){out.print("selected");}%>>Kum.</OPTION>
      <OPTION value="Ms." <% if (APP_PRIX.equals("Ms.")){out.print("selected");}%>>Ms.</OPTION>
    </SELECT>
      <INPUT name="APP_NAME" type="text" id="APP_NAME" value="<%=APP_NAME  %>" readonly="true"/></TD>
  </TR>

  <TR>
    <TH>(3)</TH>
    <TH colspan="2" nowrap><STRONG> Sponsoring Agency*:</STRONG></TH>
    <TD><SELECT name="AGENCY" disabled="disabled" class="button" id="AGENCY"   onchange="showOffice(this.value);" >
      <OPTION value ="-1" >--Select Agency --</OPTION>
      <OPTION value="KV" <% if (ORG_CD.equals("KV")){out.print("selected");}%> >KVIC</OPTION>
      <OPTION value="KB" <% if (ORG_CD.equals("KB")){out.print("selected");}%>>KVIB</OPTION>
      <OPTION value="DI" <% if (ORG_CD.equals("DI")){out.print("selected");}%>>DIC</OPTION>
	  <OPTION value="CB" <% if (ORG_CD.equals("CB")){out.print("selected");}%>>COIR</OPTION>
    </SELECT></TD>
    <TD>State*:</TD>
    <TD colspan="2"><SELECT name="STATE" disabled="disabled" class="button"  id="STATE" onBlur="showOffice(this.value);" onChange="showDistrict(this.value);">
      <OPTION value="-1">--Select State--</OPTION>
      <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   %>
      <OPTION value="<%=rs.getString("state_cd")%>" <% if (state.equals(STATE_CD)){out.print("selected");}%>><%=rs.getString("state_nm")%></OPTION>
      <% } 
	  rs.close();
	   %>
    </SELECT></TD>
  </TR>
  <TR>
    <TH>(5)</TH>
    <TH colspan="2" nowrap>District*:</TH>
    <TD id ='DISTRICT' colspan="4"><SELECT name="DISTRICT" disabled="disabled" class="button" onChange="showOffice(this.value);" >
	<% 
	String vDistCd="";
	String vDistnm="";
	while (rsDist.next()) { 
	 vDistCd=rsDist.getString(1);
	 vDistnm=rsDist.getString(2);
	
	%>
      <OPTION value="<%= vDistCd %>" <% if (vDistCd.equals(UNIT_DIST_CD)){out.print("selected");}%> ><%= vDistnm %></OPTION>
	  
	  <% } 
	  rsDist.close();
	  
	  %>
    </SELECT></TD>
  </TR>
  <TR>
    <TH>(6)</TH>
    <TH colspan="2" nowrap>Sponsoring Office*:
      <INPUT name="OFF_CD" id="OFF_CD" type="radio" value="<%= OFF_CD %>" checked="checked"/></TH>
    <TD   colspan="4" id="office">To get Office Select   Agency, State and District </TD>
  </TR>
  <TR>
    <TH>(7)</TH>
    <TH colspan="2" nowrap><STRONG>Legal Type*
      <INPUT name="FH_NAME" id="FH_NAME" type="hidden" value="-" />
          <INPUT name="FH_NM_DESC"  id="FH_NM_DESC" type="hidden" value="-" />
    </STRONG></TH>
    <TH colspan="4"> <INPUT name="BENF_TYPE_CD" id="BENF_TYPE_CD" type="hidden" value="<%=BENF_TYPE_CD%>" />
      <%=BENF_TYPE_DESC%></TH>
  </TR>
  <TR>
    <TH>(8)</TH>
    <TH colspan="2" nowrap><STRONG>Gender:*</STRONG></TH>
    <TD colspan="4"><SELECT name="GENDER" class="button" id="GENDER">
      <OPTION value="" selected>Select</OPTION>
      <OPTION value ="Male" <% if (GENDER.equals("Male")){out.print("selected");}%>>Male</OPTION>
      <OPTION value ="Female" <% if (GENDER.equals("Female")){out.print("selected");}%>>Female</OPTION>
      <OPTION value="Transgender" <% if (GENDER.equals("Transgender")){out.print("selected");}%>>Transgender</OPTION>
    </SELECT></TD>
  </TR>
  <TR>
    <TH>(9)</TH>
    <TH colspan="2" nowrap><STRONG>Date of Birth (dd-mm-yyyy) :*</STRONG></TH>
    <TD colspan="4"><INPUT name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" value="<%= DOB %>" />
      Age:
      <INPUT name="AGE" type="text" id="AGE" size="5" maxlength="3" style="background-color: #FFCCCC" readonly="true" value="<%= AGE %>" /></TD>
  </TR>
  <TR>
    <TH>(10)</TH>
    <TH colspan="2" nowrap><STRONG>Social  Category : *</STRONG></TH>
    <TD><SELECT name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
      <OPTION value="" selected>-Social Category-</OPTION>
      <OPTION value="GEN" <% if (BENF_CATAGORY_CD.equals("GEN")){out.print("selected");}%>>General</OPTION>
      <OPTION value="OBC" <% if (BENF_CATAGORY_CD.equals("OBC")){out.print("selected");}%>>Other Backward Caste</OPTION>
      <OPTION value="SC" <% if (BENF_CATAGORY_CD.equals("SC")){out.print("selected");}%>>Scheduled Caste</OPTION>
      <OPTION value="ST" <% if (BENF_CATAGORY_CD.equals("ST")){out.print("selected");}%>>Scheduled Tribe</OPTION>
      <OPTION value="MN" <% if (BENF_CATAGORY_CD.equals("MN")){out.print("selected");}%>>Minority</OPTION>
    </SELECT></TD>
    <TD>Special Category </TD>
    <TD colspan="2"><SELECT name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
      <OPTION value="" selected>-Special Category-</OPTION>
      <OPTION value="NA" selected>Not Applicable</OPTION>
      <OPTION value="EX" <% if (BENF_SPECAT_CD.equals("EX")){out.print("selected");}%>>Ex-Serviceman</OPTION>
      <OPTION value="PH" <% if (BENF_SPECAT_CD.equals("PH")){out.print("selected");}%>>Physically Challenged</OPTION>
      <OPTION value="HA" <% if (BENF_SPECAT_CD.equals("HA")){out.print("selected");}%>>Hill Boarder Area</OPTION>
      <OPTION value="NE" <% if (BENF_SPECAT_CD.equals("NE")){out.print("selected");}%>>North East Area</OPTION>
    </SELECT></TD>
  </TR>
  <TR>
    <TH>(11)</TH>
    <TH colspan="2" nowrap><STRONG>Qualification:*
      <INPUT name="TECH_QUALI" type="hidden" id="TECH_QUALI"  value="" />
    </STRONG></TH>
    <TD colspan="4"><SELECT name="EDU_ID" class="button" id="EDU_ID" >
      <OPTION value="">--Select---</OPTION>
      <%
while (rsEdu.next()) {
cmbSel=(rsEdu.getObject("edu_id").toString().equals(EDU_ID) )?"Selected":"";
%>
      <OPTION value="<%=((rsEdu.getObject("edu_id")!=null)?rsEdu.getObject("edu_id"):"")%>" <%= cmbSel %>><%=((rsEdu.getObject("edu_desc")!=null)?rsEdu.getObject("edu_desc"):"")%></OPTION>
      <%
}
rsEdu.close();
%>
    </SELECT></TD>
  </TR>
  <TR>
    <TH>(12)</TH>
    <TH colspan="2" nowrap><STRONG>Communication Address: * </STRONG></TH>
    <TD colspan="4"><INPUT name="APP_POST_ADDR" type="text" id="APP_POST_ADDR"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" value="<%=APP_POST_ADDR  %>" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Taluk/Block*:</TD>
    <TD colspan="4"><INPUT name="APP_TALUK_BLOCK" type="text" id="APP_TALUK_BLOCK" size="50" maxlength="60" onKeyPress="return RestrictSpecialChar(event);"  value="<%=APP_TALUK_BLOCK  %>" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2"><INPUT name="APP_DIST_CD" type="hidden" id="APP_DIST_CD" value="<%=APP_DIST_CD  %>"/>
      District*:</TD>
    <TD colspan="2"><INPUT name="APP_DIST_NM" type="text" id="APP_DIST_NM"  style="background-color: #FFCCCC" readonly="true" value="<%= APP_DIST_NM %>" />	  <INPUT name="btnComaddr" id="btnComAddr" type="button" class="button" onClick="changeComDistrict();"  value="Change Communication District" /></TD>
    <TD>Pin*:</TD>
    <TD><INPUT name="APP_PIN" type="text" id="APP_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" value="<%=APP_PIN  %>"/></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TH colspan="2" nowrap>Mobile No:*:</TH>
    <TD colspan="4">(1)
        <INPUT name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" value="<%=MOB_NO1%>" />
      (2)
      <INPUT name="MOB_NO2" type="text" class="mob"  id="MOB_NO2" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" value="<%=MOB_NO2%>"/>    </TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TH colspan="2" nowrap>eMail:</TH>
    <TD><INPUT name="E_MAIL" type="text" id="E_MAIL" size="40"  maxlength="58" value="<%=E_MAIL %>"/></TD>
    <TD>PAN NO: </TD>
    <TD colspan="2"><INPUT name="PAN_NO" type="text" id="PAN_NO"   size="20" maxlength="10" value="<%=PAN_NO %>"/></TD>
  </TR>
  <TR>
    <TH>(13)</TH>
    <TH colspan="2" nowrap>Unit Location </TH>
    <TD colspan="4"><SELECT name="UNIT_LOC" class="button" id="UNIT_LOC" >
      <OPTION value="" selected>Select</OPTION>
      <OPTION value="Rural" <% if (UNIT_LOC.equals("Rural")){out.print("selected");}%> >Rural</OPTION>
      <OPTION value="Urban" <% if (UNIT_LOC.equals("Urban")){out.print("selected");}%>>Urban</OPTION>
    </SELECT></TD>
  </TR>
  <TR>
    <TH>(14)</TH>
    <TH colspan="2" nowrap><STRONG>Proposed Unit Address </STRONG><STRONG>: </STRONG></TH>
    <TD colspan="4"><INPUT name="CopyAddress" type="button" class="button" onClick="copy_addres();" value="Copy Communication Address to Unit Address" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Address*</TD>
    <TD colspan="4"><INPUT name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  size="45" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" value="<%=UNIT_POST_ADDR  %>" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Taluk/Block*</TD>
    <TD colspan="4"><INPUT name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  size="40" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" value="<%= UNIT_TALUK_BLOCK %>"/></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2"> District*
      <INPUT name="UNIT_DIST_CD" type="hidden" id="UNIT_DIST_CD" value="<%= UNIT_DIST_CD %>" /></TD>
    <TD colspan="4"><INPUT name="UNIT_DIST_NM" type="text" id="UNIT_DIST_NM" style="background-color: #FFCCCC"  readonly="true" value="<%= UNIT_DIST_NM %>" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Pin*</TD>
    <TD colspan="4"><INPUT name="UNIT_PIN" type="text" id="UNIT_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" value="<%= UNIT_PIN %>" /></TD>
  </TR>
  <TR>
    <TH>(15)</TH>
    <TH colspan="2" nowrap><STRONG>Type of Activity  : * </STRONG></TH>
    <TD colspan="4"><SELECT name="IND_TYPE" class="button" id="IND_TYPE" >
      <OPTION value="" selected>-Select-</OPTION>
      <OPTION value="M" <% if (IND_TYPE.equals("M")){out.print("selected");}%> >Manufacturing</OPTION>
      <OPTION value="S" <% if (IND_TYPE.equals("S")){out.print("selected");}%>>Service</OPTION>
      <OPTION value="T" <% if (IND_TYPE.equals("T")){out.print("selected");}%>>Trading</OPTION>
    </SELECT>
        <INPUT name="btnActList" type="button" class="button" id="btnActList"  onClick="activity();" value="Select Industry / Activity" /></TD>
  </TR>
  <TR>
    <TH>(16)</TH>
    <TH colspan="2" nowrap>Industry / Activity Name : <STRONG>
      <INPUT name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
    </STRONG></TH>
    <TD colspan="4"><INPUT name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Product Description: </TD>
    <TD colspan="4"><INPUT name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" value="<%=PROD_DESC  %>"/></TD>
  </TR>
  <TR>
    <TH>(17)</TH>
    <TH colspan="2" nowrap><STRONG>EDP Training Undergone:*
      <INPUT name="EDP_INST_ADDR2" type="hidden" id="EDP_INST_ADDR2" onKeyPress="return RestrictSpecialChar(event);" value="" />
          <INPUT name="EDP_TRG_FRDT" type="hidden" id="EDP_TRG_FRDT"  onkeypress="return onlyDate(event);" value=""/>
          <INPUT name="EDP_TRG_TODT" type="hidden" id="EDP_TRG_TODT"  onkeypress="return onlyDate(event);" value="" />
          <INPUT name="EDP_TRG_CDT" type="hidden" id="EDP_TRG_CDT"   onkeypress="return onlyDate(event);" value="" />
    </STRONG></TH>
    <TD colspan="4"><SELECT name="EDP_YN" id="EDP_YN">
      <OPTION value="">-Select-</OPTION>
      <OPTION value="N" <% if (EDP_YN.equals("N")){out.print("selected");}%>>No</OPTION>
      <OPTION value="Y"  <% if (EDP_YN.equals("Y")){out.print("selected");}%>>Yes</OPTION>
    </SELECT>
        <INPUT name="GS_AMT" type="hidden" id="GS_AMT" onKeyPress="return numbersonly(event)" value="" />
        <INPUT name="GS_AVAIL_YN" id="GS_AVAIL_YN" type="hidden" value="N" />
        <INPUT name="GS_DETAIL" type="hidden" id="GS_DETAIL" onKeyPress="return RestrictSpecialChar(event);" value="" /></TD>
  </TR>
  <TR>
    <TH>(18)</TH>
    <TH colspan="2" nowrap>EDP Training Instn. Name </TH>
    <TD colspan="4"><INPUT name="EDP_INST_ADDR" type="text" id="EDP_INST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="50" maxlength="50" value="<%=EDP_INST_ADDR  %>" /></TD>
  </TR>
  <TR>
    <TH nowrap>(19)</TH>
    <TH colspan="2" nowrap>Project Cost  :
      <INPUT name="BLDG_TYPE" id="BLDG_TYPE" type="hidden" value="" />
          <INPUT name="WORKSHED_COST" type="hidden" id="WORKSHED_COST"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
          <INPUT name="PRE_OPE_EXP" type="hidden"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
          
          <INPUT name="TOTAL_CE" type="hidden" id="TOTAL_CE" style="background-color: #FFCCCC" value="" />
          
        </TH>
    <TH nowrap> <DIV align="center">Capital Expenditure</DIV></TH>
    <TH nowrap><DIV align="center">Working Capital</DIV></TH>
    <TH width="114" nowrap><DIV align="center"><STRONG>Total</STRONG></DIV></TH>
    <TH width="142" nowrap><DIV align="center">Employment</DIV></TH>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">&nbsp;</TD>
    <TD>      <DIV align="center">
      <INPUT name="MACHINARY_COST" type="text" id="MACHINARY_COST" onChange="proj_cal();" size="8" maxlength="7"  value="<%=MACHINARY_COST  %>" />    
    </DIV></TD>
    <TD>      <DIV align="center">
          <INPUT name="WORKING_CAPITAL" type="text" id="WORKING_CAPITAL"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" size="8" maxlength="7"  value="<%=WORKING_CAPITAL  %>" />      
      &nbsp;</DIV></TD>
    <TD>      <DIV align="center">
      <INPUT name="TOTAL_PRJ" type="text" id="TOTAL_PRJ" style="background-color: #FFCCCC" value="<%= TOTAL_PRJ %>" readonly="true"  size="8" />    
    </DIV></TD>
    <TD>      <DIV align="center">
      <INPUT name="EMP_ENV" type="text" id="EMP_ENV"    title="Proposed Employment" size="10" maxlength="3" value="<%=EMP_ENV%>" />    
    </DIV></TD>
  </TR>
  <TR>
    <TH>(20)</TH>
    <TH colspan="2" nowrap>1st Financing Bank*: </TH>
    <TD colspan="4"><SELECT name="BANK_NAME" id="BANK_NAME" class="button"  >
      <OPTION value="-1" selected="selected" >--Select Bank Name-</OPTION>
      <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A");
	   String bnm="";
	   while(rs.next()){ 
	   bnm=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
	   %>
      <OPTION value="<%=bnm %>" <% if ( bnm.equals(BANK_NAME)) { out.print ("Selected");} %>><%=bnm %></OPTION>
      <% } 
	  rs.close();
	   %>
    </SELECT>
        </span></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">IFS/Bank Code*: </TD>
    <TD colspan="4"><INPUT name="IFSC_CODE" type="text" id="IFSC_CODE"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" value="<%=IFSC_CODE  %>" />
        <INPUT name="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Branch Name*: </TD>
    <TD colspan="4"><INPUT name="BRANCH_NAME" type="text" id="BRANCH_NAME"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" value="<%=BRANCH_NAME  %>" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">Address*:</TD>
    <TD colspan="4"><INPUT name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="70" value="<%=BANK_POST_ADDR  %>" /></TD>
  </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD colspan="2">District:</TD>
    <TD colspan="4"><INPUT name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" value="<%=BANK_DISTRICT  %>" /></TD>
  </TR>
  <TR>
    <TH>(21)</TH>
    <TH colspan="2" nowrap>Alternative Financing Branch : </TH>
    <TD colspan="4">
	
	<SELECT name="BANK_NAME2" class="button" id="BANK_NAME2"  >
          <OPTION value="-1" selected="selected" >--Select Bank Name-</OPTION>
          <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd");
	   
	   while(rs.next()){ 
	   
	   %>
          <OPTION value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></OPTION>
          <% } 
	  rs.close();
	   %>
        </SELECT>
	
	
	</TD>
  </TR>
  <TR>
    <TH>&nbsp;</TH>
    <TH colspan="2" nowrap>Code
      <INPUT type="hidden" name="BANK_TYPE" id="BANK_TYPE" value="1" />
        <INPUT type="hidden" name="ins" id="ins" value="" /></TH>
    <TD colspan="4"><INPUT name="IFSC_CODE2" type="text" id="IFSC_CODE2" value="<%=IFSC_CODE2  %>" maxlength="11" readonly="true" />
      <INPUT name="btnBank2" type="button" class="button" id="btnBank2" onClick="ShowNewPage2();"  value="Select  Bank IFS Code" /></TD>
  </TR>
  <%
 ResultSet rslock = db.execSQL("SELECT COUNT(APP_ID) as DT_LOCK FROM BANK_DATAENTRY WHERE APP_ID='"+APP_ID+"' AND NVL(MM_CLAIM_AMT,0) >0    ");
	    
      
	   
	   while(rslock.next()){ 
	   DT_LOCK1=rslock.getString("DT_LOCK")==null?"0":rslock.getString("DT_LOCK");
	  }
	  rslock.close();
	  
	  %>
	  
  <TR>
  
    <TD colspan="7"><DIV align="center">
	<% if (DT_LOCK1.equals("0")) {%>
            <INPUT name="Button" type="button" class="button"  onClick="sub_form();" value="Save Applicant Data" />
			<%}else{%>
			<SPAN class="blinker">Data Locked...... Cannot Modify......</SPAN>		  
			<%}%>
     </DIV></TD>
  </TR>
   
  <TR>
    <TD colspan="7">
      <%
   try{
   if ((String)request.getParameter("ins")!=null){
	
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
FH_NAME=(String) request.getParameter("FH_NAME")==null?"":(String) request.getParameter("FH_NAME").trim();
BENF_TYPE_CD=(String) request.getParameter("BENF_TYPE_CD")==null?"1":(String) request.getParameter("BENF_TYPE_CD").trim();
BENF_CATAGORY_CD=(String) request.getParameter("BENF_CATAGORY_CD")==null?"":(String) request.getParameter("BENF_CATAGORY_CD").trim();
GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
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

 PAN_NO=(String) request.getParameter("PAN_NO")==null?"":(String) request.getParameter("PAN_NO").trim();
 BENF_SPECAT_CD=(String) request.getParameter("BENF_SPECAT_CD")==null?"":(String) request.getParameter("BENF_SPECAT_CD").trim();
		       
		List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		      
qryUpdate.append(" UPDATE APP_DETAIL SET ");
//qryUpdate.append("OFF_CD=?,");
qryUpdate.append("APP_PRIX=?,");
qryUpdate.append("FH_NAME=?,");
qryUpdate.append("BENF_TYPE_CD=?,");
qryUpdate.append("BENF_CATAGORY_CD=?,");
qryUpdate.append("GENDER=?,");
qryUpdate.append("DOB=?,");
qryUpdate.append("MOB_NO1=?,");
qryUpdate.append("APP_POST_ADDR=?,");
qryUpdate.append("APP_TALUK_BLOCK=?,");
qryUpdate.append("APP_DIST_CD=?,");
qryUpdate.append("APP_PIN=?,");
qryUpdate.append("E_MAIL=?,");
qryUpdate.append("EDU_ID=?,");
qryUpdate.append("UNIT_LOC=?,");
qryUpdate.append("UNIT_POST_ADDR=?,");
qryUpdate.append("UNIT_TALUK_BLOCK=?,");
//qryUpdate.append("UNIT_DIST_CD=?,");
qryUpdate.append("UNIT_PIN=?,");
qryUpdate.append("MACHINARY_COST=?,");
qryUpdate.append("WORKING_CAPITAL=?,");
qryUpdate.append("EMP_ENV=?,");
qryUpdate.append("BANK_NAME=?,");
qryUpdate.append("BANK_POST_ADDR=?,");
qryUpdate.append("BANK_TALUK_BLOCK=?,");
qryUpdate.append("BANK_PINCD=?,");
qryUpdate.append("BANK_DIST_CD=?,");
//qryUpdate.append("MTG_ID=?,");
qryUpdate.append("PROD_DESC=?,");
qryUpdate.append("IFSC_CODE=?,");
qryUpdate.append("APP_REC_DATE=?,");
//qryUpdate.append("ACT_ID=?,");
qryUpdate.append("IND_TYPE=?,");
qryUpdate.append("ACTIVITY_CD=?,");
qryUpdate.append("BRANCH_NAME=?,");
qryUpdate.append("BANK_DISTRICT=?,");
qryUpdate.append("MOB_NO2=?,");
qryUpdate.append("IFSC_CODE2=?,");
qryUpdate.append("EDP_INST_ADDR=?,");
qryUpdate.append("EDP_YN=?, ");
qryUpdate.append("PAN_NO=?, ");
qryUpdate.append("BENF_SPECAT_CD=? ");
qryUpdate.append("WHERE APP_ID=?  ");

values.clear();
pstm.clear();


//values.add(OFF_CD); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");
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
values.add(UNIT_LOC); pstm.add ("L");
values.add(UNIT_POST_ADDR); pstm.add ("L");
values.add(UNIT_TALUK_BLOCK); pstm.add ("L");
//values.add(UNIT_DIST_CD); pstm.add ("L");
values.add(UNIT_PIN); pstm.add ("L");
values.add(MACHINARY_COST); pstm.add ("L");
values.add(WORKING_CAPITAL); pstm.add ("L");
values.add(EMP_ENV); pstm.add ("L");
values.add(BANK_NAME); pstm.add ("L");
values.add(BANK_POST_ADDR); pstm.add ("L");
values.add(BANK_TALUK_BLOCK); pstm.add ("L");
values.add(BANK_PINCD); pstm.add ("L");
values.add(BANK_DIST_CD); pstm.add ("L");
//values.add(MTG_ID); pstm.add ("L");
values.add(PROD_DESC); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(APP_REC_DATE); pstm.add ("L");
//values.add(ACT_ID); pstm.add ("L");
values.add(IND_TYPE); pstm.add ("L");
values.add(ACTIVITY_CD); pstm.add ("L");
values.add(BRANCH_NAME); pstm.add ("L");
values.add(BANK_DISTRICT); pstm.add ("L");
values.add(MOB_NO2); pstm.add ("L");
values.add(IFSC_CODE2); pstm.add ("L");
values.add(EDP_INST_ADDR); pstm.add ("L");
values.add(EDP_YN); pstm.add ("L");
values.add(PAN_NO); pstm.add ("L");
values.add(BENF_SPECAT_CD); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();


try {
values.add(APP_ID); pstm.add ("L");
db.setSqlValue("UPDATE PMEGP_SCORE_CARD SET TOTAL_SCORE=0 WHERE APP_ID =? ");
db.setValues(values,pstm);
db.executeUpdate() ;
}catch (Exception e) {}




db.close();
response.sendRedirect("AppSearchLOV.jsp");
}//ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}

   %>
   </TD>
  </TR>
</TABLE>
<SCRIPT language="javascript">
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

function getBankLOV(IFSC,BRNAME,ADDR,DIST){
 form.IFSC_CODE.value=IFSC;
 form.BRANCH_NAME.value=BRNAME;
 form.BANK_POST_ADDR.value=ADDR;
form.BANK_DISTRICT.value=DIST;

}

function getBankLOV2(IFSC){
 form.IFSC_CODE2.value=IFSC;
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
 form.APP_DIST_NM.value=DISTRICT_NAME;
form.APP_DIST_CD.value=DISTRICT_CD;
}
</SCRIPT>

</FORM>
</BODY>

</HTML>
