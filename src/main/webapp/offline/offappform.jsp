<%@ include file="includeHeaderPage.jsp" %>
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
String SOFFID=(String) session.getAttribute("SOFFID");
String sOFF_TYPE_CD=(String) session.getAttribute("sOFF_TYPE_CD");
			String sdistrict_cd =(String) session.getAttribute("sdistrict_cd");
			String vOffcd= (String) session.getAttribute("off_cd");
String APP_ID = "";
String vOffcd= "";
String vOrgCD= "";
String vState= "";
String cmbSel="";
String OFF_CD = "";
String APP_PRIX = "";
String APP_NAME = "";
String FH_NAME = "";
String BENF_TYPE_CD= request.getParameter("BENF_CD")==null?"1":(String) request.getParameter("BENF_CD");

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
String LOCK_YN="";




ResultSet rsEdu = db.execSQL("SELECT edu_id, edu_desc FROM education_mast");




ResultSet rsBenfType = db.execSQL("SELECT A.AADHAR_NO,A.APP_NAME,A.GENDER,A.DOB,A.MOB_NO,A.OFF_CD,A.DIST_CD,MOM.ORG_CD  FROM AADHAR_VERI_OFFLINE A,MAS_OFF_MAST MOM  WHERE A.OFF_CD=MOM.OFF_CD AND OFF_ID= "+SOFFID+"");
while (rsBenfType.next()) {
AADHAR_NO=rsBenfType.getString("AADHAR_NO")==null?"1":rsBenfType.getString("AADHAR_NO");
APP_NAME=rsBenfType.getString("APP_NAME")==null?"-":rsBenfType.getString("APP_NAME");
GENDER=rsBenfType.getString("GENDER")==null?"-":rsBenfType.getString("GENDER");
DOB=rsBenfType.getString("DOB")==null?"-":rsBenfType.getString("DOB");
MOB_NO1=rsBenfType.getString("MOB_NO")==null?"-":rsBenfType.getString("MOB_NO");
OFF_CD=rsBenfType.getString("OFF_CD")==null?"-":rsBenfType.getString("OFF_CD");
UNIT_DIST_CD=rsBenfType.getString("DIST_CD")==null?"-":rsBenfType.getString("DIST_CD");
ORG_CD=rsBenfType.getString("ORG_CD")==null?"-":rsBenfType.getString("ORG_CD");
}
rsBenfType.close();


ResultSet rsDist = db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD=(select STATE_CD FROM M_DISTRICT WHERE DISTRICT_CD="+UNIT_DIST_CD+" ");
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
    <TD width="280"><INPUT name="AADHAR_NO" type="text" class="aadharimg" id="AADHAR_NO" value="<%= AADHAR_NO %>" size="17" readonly="true" maxlength="12" /></TD>
    <TD width="119"><STRONG>Name of Applicant:*</STRONG></TD>
    <TD colspan="2"><SELECT name="APP_PRIX" id="APP_PRIX">
      <OPTION value="">-Select-</OPTION>
      <OPTION value="Shri" <% if (APP_PRIX.equals("Shri")){out.print("selected");}%>>Shri</OPTION>
      <OPTION value="Smt." <% if (APP_PRIX.equals("Smt.")){out.print("selected");}%>>Smt.</OPTION>
      <OPTION value="Kum." <% if (APP_PRIX.equals("Kum.")){out.print("selected");}%>>Kum.</OPTION>
      <OPTION value="Ms." <% if (APP_PRIX.equals("Ms.")){out.print("selected");}%>>Ms.</OPTION>
    </SELECT>
      <INPUT name="APP_NAME" type="text" id="APP_NAME" value="<%=APP_NAME  %>" readonly="true" /></TD>
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
qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms where ms.state_cd=(select state_cd from m_district where district_cd="+UNIT_DIST_CD+"   order by ms.state_nm";
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
  <tr>
    <th>(22)</th>
    <th colspan="2" nowrap><strong>Want To avail CGTMSE  : * </strong></th>
    <td colspan="4"><select name="TECH_QUALI" class="button" id="TECH_QUALI" >
      <option value="" selected>-Select-</option>
      <option value="Y" <% if (TECH_QUALI.equals("Y")){out.print("selected");}%> >Yes</option>
      <option value="N" <% if (TECH_QUALI.equals("N")){out.print("selected");}%>>No</option>     
    </select>
	 </td>
  </tr>
   <tr>
    <th>(23)</th>
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
  
  <TR>
  
    <TD colspan="7"><DIV align="center">
	
            <INPUT name="Button" type="button" class="button"  onClick="sub_form();" value="Save Applicant Data" />
			
     </DIV></TD>
  </TR>
   
  <TR>
    <TD colspan="7">
      <%
   try{
   if ((String)request.getParameter("ins")!=null){
	
		APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
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
ACT_ID=(String) request.getParameter("ACT_ID")==null?"-1":(String) request.getParameter("ACT_ID").trim();
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
		      
qryUpdate.append(" INSERT INTO APP_DETAIL_ONLINE ");
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
qryUpdate.append("PAN_NO, ");
qryUpdate.append("BENF_SPECAT_CD, ");
qryUpdate.append("APP_PWD, ");
qryUpdate.append("ONLINE_SUBDT ) ");
qryUpdate.append("  VALUES ( ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?, SYSDATE)");

values.clear();
pstm.clear();

values.add(APP_ID); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(FH_NAME); pstm.add ("L");
BENF_TYPE_CD="1";
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

String SmsText="Dear  "+APP_NAME+ " ,Your PMEGP  Portal Application is registered. User  ID is "+tempUN+" and password is "+APP_PWD+". Please Login for Upload Documents and Final Submission. After Final Submission You can Print Application form. -KVIC ";
	 SMSServices sms1=new SMSServices();

	try {
     String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007053449928293814");	
}catch (Exception e) {}

session.setAttribute("sAPP_ID",APP_ID);
session.setAttribute("sAPP_NAME",APP_NAME);
session.setAttribute("sBENF_TYPE_CD",BENF_TYPE_CD);
session.setAttribute("sBENF_TYPE_DESC",BENF_TYPE_DESC); 
session.setAttribute("sACT_ID",ACT_ID); 
response.sendRedirect("Dataexists.jsp");
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
