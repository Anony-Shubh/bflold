<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>
<%@ include file="responseheaderinclude.jsp" %>

<HTML>
<HEAD>
<TITLE>PMEGP Online Application Registration</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT type="text/javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
<SCRIPT src="../js/jquery-customselect.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/pmegpOnlinemessages.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/ModalPopupWindow.js"></SCRIPT>


<SCRIPT language="javascript">
function openDPR() {
location.href="../dpr/DPRPACKAGE.xls";
}
</SCRIPT>
<%String state="";
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
String APP_PRIX = "";
String APP_NAME = "";
String FH_NAME = "";
String BENF_TYPE_CD = request.getParameter("BENF_CD")==null?"1":(String) request.getParameter("BENF_CD");
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
String ACT_ID = "-1";
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
<STYLE type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</STYLE>
</HEAD>

<BODY  onload="edp_yn();">
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

<IMG src="../images/pmegponline.jpg" width="100%" height="150" >

<FORM name="form" id="form"  class="form" method="post">

<TABLE>

<TR>
  <TD>    <TABLE class="CSSTableGenerator">
    <TR bgcolor="#D1A476">
      <TD colspan="6"><DIV align="center" class="style1">
          <H3>PMEGP ONLINE APPLICATION FOR INDIVIDUAL APPLICANT/&#2357;&#2381;&#2351;&#2325;&#2381;&#2340;&#2367;&#2327;&#2340; &#2310;&#2357;&#2375;&#2342;&#2344; &#2325;&#2375; &#2354;&#2367;&#2319; &#2346;&#2368;&#2319;&#2350;&#2312;&#2332;&#2368;&#2346;&#2368; &#2321;&#2344;&#2354;&#2366;&#2311;&#2344; &#2310;&#2357;&#2375;&#2342;&#2344;</H3>
      </DIV></TD>
    </TR>
    <TR>
      <TH>(1)</TH>
      <TH nowrap><STRONG>Aadhaar Card No /&#2310;&#2343;&#2366;&#2352;  &#2344;&#2306;&#2348;&#2352;: </STRONG></TH>
      <TD colspan="4"><INPUT name="AADHAR_NO" type="text" class="aadharimg"  id="AADHAR_NO" onKeyPress="return numbersonly(event);" size="17" maxlength="12" /></TD>
    </TR>
    <TR>
      <TH>(2)</TH>
      <TH><STRONG>Name of Applicant/&#2310;&#2357;&#2375;&#2342;&#2325;  &#2325;&#2366; &#2344;&#2366;&#2350;:*</STRONG></TH>
      <TD colspan="4"><SELECT name="APP_PRIX" id="APP_PRIX">
          <OPTION value="">-Select-</OPTION>
          <OPTION value="Shri">Shri</OPTION>
          <OPTION value="Smt.">Smt.</OPTION>
          <OPTION value="Kum.">Kum.</OPTION>
          <OPTION value="Ms.">Ms.</OPTION>
        </SELECT>
          <INPUT name="APP_NAME" type="text"  id="APP_NAME"   value="" size="30" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" />
      (Name as Per Aadhaar Card/&#2310;&#2343;&#2366;&#2352; &#2325;&#2366;&#2352;&#2381;&#2337; &#2325;&#2375; &#2309;&#2344;&#2369;&#2360;&#2366;&#2352; &#2344;&#2366;&#2350;) </TD>
    </TR>
    <TR>
      <TH>&nbsp;</TH>
      <TH nowrap>&nbsp;</TH>
      <TH colspan="4"><DIV align="center">
          <INPUT name="Button" type="button" class="button" value="Validate  Aadhar">
      </DIV></TH>
    </TR>
    <TR>
      <TH>(3)</TH>
      <TH nowrap><STRONG> Sponsoring Agency/&#2346;&#2381;&#2352;&#2366;&#2351;&#2379;&#2332;&#2325;  &#2319;&#2332;&#2375;&#2306;&#2360;&#2368;*:</STRONG></TH>
      <TD colspan="4"><SELECT name="AGENCY" class="button" id="AGENCY"   onChange="showOffice(this.value);" >
          <OPTION value ="-1" >--Select Agency --</OPTION>
          <OPTION value="KV">KVIC</OPTION>
          <OPTION value="KB">KVIB</OPTION>
          <OPTION value="DI">DIC</OPTION>
		   <OPTION value="CB">COIR BOARD</OPTION>
      </SELECT></TD>
    </TR>
    <TR>
      <TH>(4)</TH>
      <TH nowrap>State/&#2352;&#2366;&#2332;&#2381;&#2351;*:</TH>
      <TD colspan="4"><SELECT name="STATE" class="button"  id="STATE" onBlur="showOffice(this.value);" onChange="showDistrict(this.value);">
          <OPTION value="-1">--Select State--</OPTION>
          <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   %>
          <OPTION value="<%=rs.getString("state_cd")%>"><%=rs.getString("state_nm")%></OPTION>
          <% } 
	  rs.close();
	   %>
        </SELECT>
      </TD>
    </TR>
    <TR>
      <TH>(5)</TH>
      <TH nowrap>District/&#2332;&#2367;&#2354;&#2366;*:</TH>
      <TD id ='DISTRICT' colspan="4"><SELECT name="DISTRICT" class="button" onBlur="showOffice(this.value);copy_dist()" >
          <OPTION value="-1" >--Select District-</OPTION>
      </SELECT></TD>
    </TR>
    <TR>
      <TH>(6)</TH>
      <TH nowrap>Sponsoring Office/&#2346;&#2381;&#2352;&#2366;&#2351;&#2379;&#2332;&#2325;  &#2325;&#2366;&#2352;&#2381;&#2351;&#2366;&#2354;&#2351;*:
          <INPUT name="OFF_CD" type="radio" disabled value="" /></TH>
      <TD   colspan="4" id="office">To get Office Select Agency, State and District/&#2325;&#2366;&#2352;&#2381;&#2351;&#2366;&#2354;&#2351; &#2346;&#2381;&#2352;&#2366;&#2346;&#2381;&#2340; &#2325;&#2352;&#2344;&#2375; &#2325;&#2375; &#2354;&#2367;&#2319; &#2319;&#2332;&#2375;&#2306;&#2360;&#2368;, &#2352;&#2366;&#2332;&#2381;&#2351; &#2324;&#2352; &#2332;&#2367;&#2354;&#2366;  &#2325;&#2366; &#2330;&#2351;&#2344;  &#2325;&#2352;&#2375;&#2306; </TD>
    </TR>
    <TR>
      <TH>(7)</TH>
      <TH nowrap><STRONG>Legal Type/&#2325;&#2366;&#2344;&#2370;&#2344;&#2368;  &#2346;&#2381;&#2352;&#2325;&#2366;&#2352;*
            <INPUT name="FH_NAME" id="FH_NAME" type="hidden" value="-" />
            <INPUT name="FH_NM_DESC"  id="FH_NM_DESC" type="hidden" value="-" />
      </STRONG></TH>
      <TH colspan="4"> <INPUT name="BENF_TYPE_CD" id="BENF_TYPE_CD" type="hidden" value="1" />
      INDIVIDUAL</TH>
    </TR>
    <TR>
      <TH>(8)</TH>
      <TH nowrap><STRONG>Gender/&#2354;&#2367;&#2306;&#2327;:*</STRONG></TH>
      <TD colspan="4"><SELECT name="GENDER" class="button" id="GENDER">
          <OPTION value="" selected>Select</OPTION>
          <OPTION value ="Male">Male</OPTION>
          <OPTION value ="Female">Female</OPTION>
          <OPTION value="Transgender">Transgender</OPTION>
      </SELECT></TD>
    </TR>
    <TR>
      <TH>(9)</TH>
      <TH nowrap><STRONG>Date of Birth/&#2332;&#2344;&#2381;&#2350;  &#2340;&#2367;&#2341;&#2367; (dd-mm-yyyy) :*</STRONG></TH>
      <TD colspan="4"><INPUT name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" />
   Age/&#2310;&#2351;&#2369;:
        <INPUT name="AGE" type="text" id="AGE" size="5" maxlength="3" style="background-color: #FFCCCC" readonly="true"  /></TD>
    </TR>
    <TR>
      <TH rowspan="2">(10)</TH>
      <TH nowrap><STRONG>Social Category/&#2360;&#2366;&#2350;&#2366;&#2332;&#2367;&#2325;  &#2358;&#2381;&#2352;&#2375;&#2339;&#2368; : *</STRONG></TH>
      <TD colspan="4"><SELECT name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
          <OPTION value="" selected>-Social Category-</OPTION>
          <OPTION value="GEN">General</OPTION>
          <OPTION value="OBC">Other Backward Caste</OPTION>
          <OPTION value="SC">Scheduled Caste</OPTION>
          <OPTION value="ST">Scheduled Tribe</OPTION>
          <OPTION value="MN">Minority</OPTION>
      </SELECT></TD>
    </TR>
    <TR>
      <TH nowrap><STRONG>Special Category (if any)/&#2357;&#2367;&#2358;&#2375;&#2359; &#2358;&#2381;&#2352;&#2375;&#2339;&#2368; (&#2351;&#2342;&#2367; &#2325;&#2379;&#2312; &#2361;&#2379;): </STRONG></TH>
      <TD colspan="4"><SELECT name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
          <OPTION value="" selected>-Special Category-</OPTION>
          <OPTION value="NA" selected>Not Applicable</OPTION>
          <OPTION value="EX">Ex-Serviceman</OPTION>
          <OPTION value="PH">Physically Challenged</OPTION>
          <OPTION value="HA">Hill Boarder Region</OPTION>
          <OPTION value="NE">North East Region</OPTION>
      </SELECT></TD>
    </TR>
    <TR>
      <TH>(11)</TH>
      <TH nowrap><STRONG>Qualification/&#2358;&#2376;&#2325;&#2381;&#2359;&#2339;&#2367;&#2325;  &#2351;&#2379;&#2327;&#2381;&#2351;&#2340;&#2366;:*
           
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
      <TH nowrap><STRONG>Communication Address/&#2346;&#2340;&#2381;&#2352;&#2366;&#2330;&#2366;&#2352;  &#2361;&#2375;&#2340;&#2369; &#2346;&#2340;&#2366;: * </STRONG></TH>
      <TD colspan="4"><INPUT name="APP_POST_ADDR" type="text" id="APP_POST_ADDR"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Taluk/Block/&#2340;&#2366;&#2354;&#2369;&#2325; / &#2348;&#2381;&#2354;&#2377;&#2325;*:</TD>
      <TD colspan="4"><INPUT name="APP_TALUK_BLOCK" type="text" id="APP_TALUK_BLOCK" size="50" maxlength="60" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD><INPUT name="APP_DIST_CD" type="hidden" id="APP_DIST_CD" value="" />
      District/&#2332;&#2367;&#2354;&#2366;*:</TD>
      <TD colspan="4"><INPUT name="UNIT_DIST_NM" type="text" id="UNIT_DIST_NM" style="background-color: #FFCCCC"  readonly="true"  />
          <INPUT name="btnComaddr" id="btnComAddr" type="button" class="button" onClick="changeComDistrict();"  value="Change Communication District" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Pin/&#2346;&#2367;&#2344; &#2325;&#2379;&#2337;*:</TD>
      <TD colspan="4"><INPUT name="APP_PIN" type="text" id="APP_PIN"  onKeyPress="return numbersonly(event);" size="10" maxlength="6" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TH nowrap>Mobile No/&#2350;&#2379;&#2348;&#2366;&#2311;&#2354; &#2344;&#2306;&#2348;&#2352;:*:</TH>
      <TD colspan="4">(1)
          <INPUT name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" />
      (2)
      <INPUT name="MOB_NO2" type="text" class="mob"  id="MOB_NO2" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" />
      </TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TH nowrap>eMail/&#2312;-&#2350;&#2375;&#2354;:</TH>
      <TD colspan="4"><INPUT name="E_MAIL" type="text" id="E_MAIL" size="20"  maxlength="58" /></TD>
    </TR>
    <TR>
      <TH>&nbsp;</TH>
      <TH nowrap>PAN NO/&#2346;&#2376;&#2344; &#2344;&#2306;&#2348;&#2352;: </TH>
      <TD colspan="4"><INPUT name="PAN_NO" type="text" id="PAN_NO"   size="20" maxlength="10" /></TD>
    </TR>
    <TR>
      <TH>(13)</TH>
      <TH nowrap>Unit Location/&#2311;&#2325;&#2366;&#2312;  &#2325;&#2366; &#2360;&#2381;&#2341;&#2366;&#2344;</TH>
      <TD colspan="4"><SELECT name="UNIT_LOC" class="button" id="UNIT_LOC" >
          <OPTION value="">Select</OPTION>
          <OPTION value="Rural">Rural</OPTION>
          <OPTION value="Urban">Urban</OPTION>
      </SELECT></TD>
    </TR>
    <TR>
      <TH>(14)</TH>
      <TH nowrap><STRONG>Proposed Unit Address/&#2346;&#2381;&#2352;&#2360;&#2381;&#2340;&#2366;&#2357;&#2367;&#2340;  &#2311;&#2325;&#2366;&#2312; &#2346;&#2340;&#2366; </STRONG><STRONG>: </STRONG></TH>
      <TD colspan="4"><INPUT name="CopyAddress" type="button" class="button" onClick="copy_addres();" value="Copy Communication Address to Unit Address" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Address/&#2346;&#2340;&#2366;*</TD>
      <TD colspan="4"><INPUT name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  size="45" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Taluk/Block/&#2340;&#2366;&#2354;&#2369;&#2325; / &#2348;&#2381;&#2354;&#2377;&#2325;*</TD>
      <TD colspan="4"><INPUT name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  size="40" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD> District/&#2332;&#2367;&#2354;&#2366;*
          <INPUT name="UNIT_DIST_CD" type="hidden" id="UNIT_DIST_CD" value="" /></TD>
      <TD colspan="4"><INPUT name="APP_DIST_NM" type="text" id="APP_DIST_NM"  style="background-color: #FFCCCC" readonly="true"  /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Pin/&#2346;&#2367;&#2344; *</TD>
      <TD colspan="4"><INPUT name="UNIT_PIN" type="text" id="UNIT_PIN"  onKeyPress="return numbersonly(event);" size="10" maxlength="6" /></TD>
    </TR>
    <TR>
      <TH>(15)</TH>
      <TH nowrap><STRONG>Type of Activity/&#2327;&#2340;&#2367;&#2357;&#2367;&#2343;&#2367;  &#2325;&#2366; &#2346;&#2381;&#2352;&#2325;&#2366;&#2352; : * </STRONG></TH>
      <TD colspan="4"><SELECT name="IND_TYPE" class="button" id="IND_TYPE" >
          <OPTION value="" selected>-Select-</OPTION>
          <OPTION value="M" >Manufacturing</OPTION>
          <OPTION value="S" >Service</OPTION>
          <OPTION value="T" >Trading</OPTION>
        </SELECT>
          <INPUT name="btnActList" type="button" class="button" id="btnActList"  onClick="activity();"  value="Select Industry / Activity" /></TD>
    </TR>
    <TR>
      <TH>(16)</TH>
      <TH nowrap>Industry / Activity Name/&#2327;&#2340;&#2367;&#2357;&#2367;&#2343;&#2367;  &#2325;&#2366; &#2344;&#2366;&#2350; : <STRONG>
        <INPUT name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
      </STRONG></TH>
      <TD colspan="4"><INPUT name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Product Description/&#2313;&#2340;&#2381;&#2346;&#2366;&#2342;  &#2357;&#2367;&#2357;&#2352;&#2339;: </TD>
      <TD colspan="4"><INPUT name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TH>(17)</TH>
      <TH nowrap><STRONG>EDP Training Undergone/&#2325;&#2381;&#2351;&#2366;  &#2312;&#2337;&#2368;&#2346;&#2368; &#2346;&#2381;&#2352;&#2358;&#2367;&#2325;&#2381;&#2359;&#2339; &#2354;&#2367;&#2351;&#2366; &#2361;&#2376;:*
            <INPUT name="EDP_TRG_FRDT" type="hidden" id="EDP_TRG_FRDT"  onKeyPress="return onlyDate(event);" value=""/>
            <INPUT name="EDP_TRG_TODT" type="hidden" id="EDP_TRG_TODT"  onKeyPress="return onlyDate(event);" value="" />
            <INPUT name="EDP_TRG_CDT" type="hidden" id="EDP_TRG_CDT"   onKeyPress="return onlyDate(event);" value="" />
      </STRONG></TH>
      <TD colspan="4"><SELECT name="EDP_YN" id="EDP_YN" onChange="edp_yn();">
          <OPTION value="">-Select-</OPTION>
          <OPTION value="N">No</OPTION>
          <OPTION value="Y">Yes</OPTION>
        </SELECT>
          <INPUT name="GS_AMT" type="hidden" id="GS_AMT" onKeyPress="return numbersonly(event)" value="" />
          <INPUT name="GS_AVAIL_YN" type="hidden" value="N" />
          <INPUT name="GS_DETAIL" type="hidden" id="GS_DETAIL" onKeyPress="return RestrictSpecialChar(event);" value="" /></TD>
    </TR>
    <TR>
      <TH>(18)</TH>
      <TH nowrap>EDP Training Instn. Name/&#2346;&#2381;&#2352;&#2358;&#2367;&#2325;&#2381;&#2359;&#2339;  &#2360;&#2306;&#2360;&#2381;&#2341;&#2366; &#2325;&#2366; &#2344;&#2366;&#2350;</TH>
      <TD colspan="4"><INPUT name="EDP_INST_ADDR" type="text" id="EDP_INST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="50" maxlength="50" /></TD>
    </TR>
    <TR>
      <TH nowrap>(19)</TH>
      <TH nowrap><STRONG>Project Cost/&#2346;&#2352;&#2367;&#2351;&#2379;&#2332;&#2344;&#2366; &#2325;&#2368; &#2354;&#2366;&#2327;&#2340;&#2339; :
          
            <INPUT name="WORKSHED_COST" type="hidden" id="WORKSHED_COST"  onChange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
            <INPUT name="PRE_OPE_EXP" type="hidden"  onChange="proj_cal();" onKeyPress="return numbersonly(event);" value="" />
            <SPAN class="style60">
            <INPUT name="TOTAL_CE" type="hidden" id="TOTAL_CE" style="background-color: #FFCCCC" value="" />
          </SPAN></STRONG></TH>
      <TH nowrap> Capital Expenditure/ &#2346;&#2370;&#2306;&#2332;&#2368;&#2327;&#2340; &#2357;&#2381;&#2351;&#2351;</TH>
      <TH nowrap>Working Capital/&#2325;&#2366;&#2352;&#2381;&#2351;&#2358;&#2368;&#2354; &#2346;&#2370;&#2306;&#2332;&#2368;</TH>
      <TH nowrap>Total/&#2325;&#2369;&#2354;</TH>
      <TH nowrap>Employment/&#2352;&#2379;&#2332;&#2364;&#2327;&#2366;&#2352;</TH>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD><DIV align="center">
          <INPUT name="MACHINARY_COST" type="text" id="MACHINARY_COST" onChange="proj_cal();" size="8" maxlength="7" />
      </DIV></TD>
      <TD><DIV align="center">
          <INPUT name="WORKING_CAPITAL" type="text" id="WORKING_CAPITAL"  onChange="proj_cal();" onKeyPress="return numbersonly(event);" size="8" maxlength="7" />
&nbsp;</DIV></TD>
      <TD><INPUT name="TOTAL_PRJ" type="text" id="TOTAL_PRJ" style="background-color: #FFCCCC" value="<%= TOTAL_PRJ %>" readonly="true"  size="8" /></TD>
      <TD><INPUT name="EMP_ENV" type="text" id="EMP_ENV"    title="Proposed Employment" size="10" maxlength="3" />
&nbsp;</TD>
    </TR>
    <TR>
      <TH>(20)</TH>
      <TH nowrap>1st Financing Bank/ &#2348;&#2376;&#2306;&#2325;  &#2357;&#2367;&#2357;&#2352;&#2339;*:
          <INPUT name="b1" type="hidden" id="b1" size="1" maxlength="1" ></TH>
      <TD colspan="4"><SELECT name="BANK_NAME"  id="BANK_NAME" class="custom-select">
          <OPTION value="-1" >-Select Bank Name-</OPTION>
          <%
 rs = db.execSQL("SELECT DISTINCT (TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A WHERE A.ACT_YN = 'Y' ORDER BY (TRIM(UPPER(A.BANK_NAME)))");
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
      <TD>&nbsp;</TD>
      <TD>IFS/Bank Code</TD>
      <TD colspan="4"><INPUT name="IFSC_CODE" type="text" id="IFSC_CODE"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <INPUT name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Branch Name/&#2358;&#2366;&#2326;&#2366; &#2325;&#2366; &#2344;&#2366;&#2350;*:</TD>
      <TD colspan="4"><INPUT name="BRANCH_NAME" type="text" id="BRANCH_NAME"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>Address/&#2346;&#2340;&#2366;*:</TD>
      <TD colspan="4"><INPUT name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="70" /></TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>District:/&#2332;&#2367;&#2354;&#2366;</TD>
      <TD colspan="4"><INPUT name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" /></TD>
    </TR>
    <TR>
      <TH>(21)</TH>
      <TH nowrap>Alternate Financing Bank Name /&#2342;&#2370;&#2360;&#2352;&#2366;  &#2398;&#2366;&#2311;&#2344;&#2375;&#2306;&#2358;&#2367;&#2351;&#2354; &#2348;&#2376;&#2306;&#2325; </TH>
      <TD colspan="4"><SELECT name="BANK_NAME2"  id="BANK_NAME2"  >
          <OPTION value="-1" selected="selected" >-Select Bank Name-</OPTION>
          <%
 rs = db.execSQL("SELECT DISTINCT (TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A WHERE A.ACT_YN = 'Y' ORDER BY (TRIM(UPPER(A.BANK_NAME)))");
	   
	   while(rs.next()){ 
	   
	   %>
          <OPTION value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></OPTION>
          <% } 
	  rs.close();
	   %>
      </SELECT></TD>
    </TR>
    <TR>
      <TH>(21)</TH>
      <TH nowrap>2nd Financing Branch IFS Code/&#2342;&#2370;&#2360;&#2352;&#2368;  &#2347;&#2366;&#2311;&#2344;&#2375;&#2306;&#2360;&#2367;&#2306;&#2327; &#2348;&#2381;&#2352;&#2366;&#2306;&#2330; &#2325;&#2366; IFSC &#2325;&#2379;&#2337;
          <INPUT type="hidden" name="BANK_TYPE" id="BANK_TYPE" value="1" />
          <INPUT type="hidden" name="ins" id="ins" value="" /></TH>
      <TD colspan="4"><INPUT name="IFSC_CODE2" type="text" id="IFSC_CODE2" size="11" maxlength="11" readonly="true" />
          <INPUT name="btnBank2" type="button" class="button" id="btnBank2" onClick="ShowNewPage2();"  value="Select  Bank IFS Code" /></TD>
    </TR>
	<TR>
    <TH>(22)</TH>
    <TH  nowrap><STRONG>Want To avail CGTMSE/&#2360;&#2368;&#2332;&#2368;&#2335;&#2368;&#2319;&#2350;&#2319;&#2360;&#2312; &#2325;&#2366; &#2354;&#2366;&#2349; &#2313;&#2336;&#2366;&#2344;&#2366; &#2330;&#2366;&#2361;&#2340;&#2375; &#2361;&#2376;&#2306; </STRONG>
      <STRONG>: * </STRONG></TH>
    <TD ><SELECT name="TECH_QUALI" class="button" id="TECH_QUALI" >
      <OPTION value="" selected>-Select-</OPTION>
      <OPTION value="Y" <% if (TECH_QUALI.equals("Y")){out.print("selected");}%> >Yes</OPTION>
      <OPTION value="N" <% if (TECH_QUALI.equals("N")){out.print("selected");}%>>No</OPTION>     
    </SELECT>
	 </TD>
  </TR>
   <TR>
    <TH>(23)</TH>
    <TH  nowrap><STRONG>Where did you hear about PMEGP/&#2310;&#2346;&#2344;&#2375; &#2346;&#2368;&#2319;&#2350;&#2312;&#2332;&#2368;&#2346;&#2368; &#2325;&#2375; &#2348;&#2366;&#2352;&#2375; &#2350;&#2375;&#2306; &#2325;&#2361;&#2366;&#2306; &#2360;&#2369;&#2344;&#2366;  : * </STRONG></TH>
    <TD ><SELECT name="BLDG_TYPE" class="button" id="BLDG_TYPE" >
      <OPTION value="" selected>-Select-</OPTION>
      <OPTION value="1" <% if (BLDG_TYPE.equals("1")){out.print("selected");}%> >Word of mouth</OPTION>
      <OPTION value="2" <% if (BLDG_TYPE.equals("2")){out.print("selected");}%>>Awareness Camp</OPTION>
      <OPTION value="3" <% if (BLDG_TYPE.equals("3")){out.print("selected");}%>>Implementing Agencies(KVIC/KVIB/DIC)</OPTION>
	  <OPTION value="4" <% if (BLDG_TYPE.equals("4")){out.print("selected");}%> >Newspaper advertisements</OPTION>
      <OPTION value="5" <% if (BLDG_TYPE.equals("5")){out.print("selected");}%>>Radio advertisements</OPTION>
      <OPTION value="6" <% if (BLDG_TYPE.equals("6")){out.print("selected");}%>>Television advertisement</OPTION>
	  <OPTION value="7" <% if (BLDG_TYPE.equals("7")){out.print("selected");}%> >Internet advertisement</OPTION>
      <OPTION value="8" <% if (BLDG_TYPE.equals("8")){out.print("selected");}%>>Social Media (Twitter,facebook,etc)</OPTION>
      <OPTION value="9" <% if (BLDG_TYPE.equals("9")){out.print("selected");}%>>Search Engine</OPTION>
	  <OPTION value="10"<% if (BLDG_TYPE.equals("10")){out.print("selected");}%>>Other</OPTION>
    </SELECT>	  
     </TD>
  </TR>

    <TR>
      <TD colspan="6"><INPUT name="checkbox" type="checkbox" value="checkbox" checked>
      I hereby declare that information given above is true to the best of my knowledge. Any information to be found incorrect /false / wrong , I shall be liable for suitable Action/    
        <ul>        &#2350;&#2376;&#2306; &#2319;&#2340;&#2342; &#2328;&#2379;&#2359;&#2339;&#2366; &#2325;&#2352;&#2340;&#2366; &#2361;&#2370;&#2306; &#2325;&#2367; &#2314;&#2346;&#2352; &#2342;&#2368; &#2327;&#2312; &#2332;&#2366;&#2344;&#2325;&#2366;&#2352;&#2368; &#2350;&#2375;&#2352;&#2375; &#2360;&#2352;&#2381;&#2357;&#2379;&#2340;&#2381;&#2340;&#2350; &#2332;&#2381;&#2334;&#2366;&#2344; &#2325;&#2375; &#2354;&#2367;&#2319;  &#2360;&#2361;&#2368; &#2361;&#2376; | &#2325;&#2367;&#2360;&#2368;  &#2349;&#2368; &#2332;&#2366;&#2344;&#2325;&#2366;&#2352;&#2368; &#2325;&#2375; &#2327;&#2354;&#2340;/&#2340;&#2381;&#2352;&#2369;&#2335;&#2367;&#2346;&#2370;&#2352;&#2381;&#2339;/&#2309;&#2360;&#2340;&#2381;&#2351; &#2346;&#2366;&#2319; &#2332;&#2366;&#2344;&#2375; &#2325;&#2367; &#2360;&#2381;&#2341;&#2367;&#2340;&#2367; &#2350;&#2375;&#2306;, &#2350;&#2376;&#2306; &#2313;&#2330;&#2367;&#2340; &#2325;&#2366;&#2352;&#2381;&#2352;&#2357;&#2366;&#2312; &#2325;&#2375; &#2354;&#2367;&#2319; &#2360;&#2381;&#2357;&#2351;&#2306; &#2313;&#2340;&#2381;&#2340;&#2352;&#2342;&#2366;&#2351;&#2368; &#2352;&#2361;&#2370;&#2305;&#2327;&#2366; | . </TD>
    </TR>
    <TR>
      <TD colspan="6"><DIV align="center">&nbsp;&nbsp;&nbsp;&nbsp;
              <INPUT name="Button" type="button"  class="button"  onClick="sub_form();" value="Save Applicant Data" />
&nbsp;&nbsp;&nbsp;&nbsp;
        <INPUT name="Button" type="button" class="button" onClick="openDPR();"    value="Prepare DPR" />
        <A href="../pmegphome/index.jsp" class="button">Home</A>
		
		<A href="../pmegpemi/" target="_blank" class="button">EMI Calculator</A></DIV></TD>
		
    </TR>
    <TR>
      <TD colspan="6"><DIV align="right">
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
      </DIV></TD>
    </TR>
  </TABLE></TD>
  <TD><TABLE class="table">
    <TR bgcolor="#D1A476">
      <TD colspan="2"><H3 align="center" class="style1"> Guidelines for Filling the Online PMEGP Application /
        &#2321;&#2344;&#2354;&#2366;&#2311;&#2344; &#2346;&#2368;&#2319;&#2350;&#2312;&#2332;&#2368;&#2346;&#2368;  &#2310;&#2357;&#2375;&#2342;&#2344; &#2349;&#2352;&#2344;&#2375; &#2361;&#2375;&#2340;&#2369; &#2342;&#2367;&#2358;&#2366;&#2344;&#2367;&#2352;&#2381;&#2342;&#2375;&#2358;
        </H3></TD>
    </TR>
    <TR>
      <TD>(1)</TD>
      <TD ><STRONG>Aadhaar Number/&#2310;&#2343;&#2366;&#2352;  &#2344;&#2306;&#2348;&#2352;</STRONG> : 12 digit Aadhar number of the applicant should be filled in./&#2310;&#2343;&#2366;&#2352;  &#2344;&#2306;&#2348;&#2352;: &#2310;&#2357;&#2375;&#2342;&#2344; &#2325;&#2379; 12 &#2309;&#2306;&#2325;&#2379;&#2306; &#2325;&#2366; &#2310;&#2343;&#2366;&#2352; &#2344;&#2306;&#2348;&#2352; &#2349;&#2352;&#2344;&#2366; &#2330;&#2366;&#2361;&#2367;&#2319; </TD>
    </TR>
    <TR>
      <TD >(2)</TD>
      <TD ><STRONG>Name of Applicant/&#2310;&#2357;&#2375;&#2342;&#2325;  &#2325;&#2366; &#2344;&#2366;&#2350; : (i) </STRONG>Select prefix of name from the list/&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2344;&#2366;&#2350; &#2325;&#2366; &#2360;&#2350;&#2381;&#2348;&#2379;&#2343;&#2344; &#2330;&#2369;&#2344;&#2375;, (ii) The applicant should fill his/her name exactly as it appears in the Aadhaar Card. In case of any mismatch in the name entered, the applicant will not be able to fill the form further/&#2310;&#2357;&#2375;&#2342;&#2325;  &#2325;&#2379; &#2309;&#2346;&#2344;&#2366; &#2344;&#2366;&#2350; &#2336;&#2368;&#2325; &#2313;&#2360;&#2368; &#2340;&#2352;&#2361; &#2349;&#2352;&#2344;&#2366; &#2330;&#2366;&#2361;&#2367;&#2319; &#2332;&#2376;&#2360;&#2375; &#2310;&#2343;&#2366;&#2352; &#2325;&#2366;&#2352;&#2381;&#2337; &#2350;&#2375; &#2342;&#2352;&#2381;&#2332; &#2325;&#2367;&#2351;&#2366; &#2327;&#2351;&#2366; &#2361;&#2376; | &#2342;&#2352;&#2381;&#2332; &#2325;&#2367;&#2319; &#2327;&#2319; &#2344;&#2366;&#2350; &#2350;&#2375;&#2305; &#2325;&#2367;&#2360;&#2368; &#2349;&#2368; &#2346;&#2381;&#2352;&#2325;&#2366;&#2352;  &#2360;&#2375; &#2348;&#2375;&#2350;&#2375;&#2354; &#2361;&#2379;&#2344;&#2375; &#2325;&#2375; &#2350;&#2366;&#2350;&#2354;&#2375; &#2350;&#2375;&#2306;,&#2310;&#2357;&#2375;&#2342;&#2325; &#2310;&#2327;&#2375; &#2347;&#2377;&#2352;&#2381;&#2350; &#2344;&#2361;&#2368;&#2306; &#2349;&#2352; &#2346;&#2366;&#2319;&#2327;&#2366; |. </TD>
    </TR>
    <TR>
      <TD >(3) </TD>
      <TD  ><P><STRONG>Sponsoring Agency</STRONG>/&#2346;&#2381;&#2352;&#2366;&#2351;&#2379;&#2332;&#2325;  &#2319;&#2332;&#2375;&#2306;&#2360;&#2368; :  Select Agency  (KVIC, KVIB, DIC) in which you want to submit the application form/&#2313;&#2360; &#2319;&#2332;&#2375;&#2306;&#2360;&#2368; (KVIC, KVIB, DIC) &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306;, &#2332;&#2367;&#2360;&#2350;&#2375;&#2306; &#2310;&#2346; &#2310;&#2357;&#2375;&#2342;&#2344; &#2346;&#2340;&#2381;&#2352; &#2332;&#2350;&#2366; &#2325;&#2352;&#2344;&#2366; &#2330;&#2366;&#2361;&#2340;&#2375; &#2361;&#2376;&#2306; |. </P></TD>
    </TR>
    <TR>
      <TD>(4)</TD>
      <TD ><STRONG>State/&#2352;&#2366;&#2332;&#2381;&#2351; : </STRONG>Select State from the list/ &#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2352;&#2366;&#2332;&#2381;&#2351; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; .</TD>
    </TR>
    <TR>
      <TD>(5)</TD>
      <TD ><STRONG>District/&#2332;&#2367;&#2354;&#2366;</STRONG> : Select District from the  list/&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2332;&#2367;&#2354;&#2375; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; </TD>
    </TR>
    <TR>
      <TD>(6)</TD>
      <TD ><STRONG>Sponsoring Office/&#2346;&#2381;&#2352;&#2366;&#2351;&#2379;&#2332;&#2325;  &#2325;&#2366;&#2352;&#2381;&#2351;&#2366;&#2354;&#2351;</STRONG> : Select Office from the  list /&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2325;&#2366;&#2352;&#2381;&#2351;&#2366;&#2354;&#2351; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; </TD>
    </TR>
    <TR>
      <TD>(7)</TD>
      <TD ><STRONG>Legal Type/&#2325;&#2366;&#2344;&#2370;&#2344;&#2368;  &#2346;&#2381;&#2352;&#2325;&#2366;&#2352; :</STRONG>This Form is pertaining to Individual Applicant/        &#2351;&#2361; &#2346;&#2381;&#2352;&#2346;&#2340;&#2381;&#2352; &#2357;&#2381;&#2351;&#2325;&#2381;&#2340;&#2367;&#2327;&#2340; &#2310;&#2357;&#2375;&#2342;&#2325; &#2360;&#2375; &#2360;&#2306;&#2348;&#2306;&#2343;&#2367;&#2340; &#2361;&#2376;&#2306; |. </TD>
    </TR>
    <TR>
      <TD>(8) </TD>
      <TD ><STRONG>Gender/&#2354;&#2367;&#2306;&#2327; : </STRONG>Select  Gender (i.e. Male, Female, Transgender) /&#2354;&#2367;&#2306;&#2327;  &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; (&#2309;&#2352;&#2381;&#2341;&#2366;&#2340; &#2346;&#2369;&#2352;&#2369;&#2359;, &#2350;&#2361;&#2367;&#2354;&#2366;, &#2335;&#2381;&#2352;&#2366;&#2306;&#2360;&#2332;&#2375;&#2306;&#2337;&#2352;) </TD>
    </TR>
    <TR>
      <TD>(9)</TD>
      <TD ><STRONG>Date of Birth/&#2332;&#2344;&#2381;&#2350;  &#2340;&#2367;&#2341;&#2367; </STRONG>: (i) Date of Birth must be fill in the format of (DD-MM-YYYY) e.g. 15-12-1991/&#2340;&#2368;&#2341;&#2368; (DD-MM-YYYY) &#2325;&#2375; &#2346;&#2381;&#2352;&#2366;&#2352;&#2370;&#2346; &#2350;&#2375;&#2306; &#2349;&#2352;&#2344;&#2366; &#2330;&#2366;&#2361;&#2367;&#2319;  &#2332;&#2376;&#2360;&#2375; 15-12-1991 |. (ii) <STRONG>Age</STRONG> : Age should not less than 18 years. As soon as Date of Birth is entered the age will calculate dynamically/&#2310;&#2351;&#2369;:  &#2310;&#2351;&#2369; 18 &#2357;&#2352;&#2381;&#2359; &#2360;&#2375; &#2325;&#2350; &#2344;&#2361;&#2368;&#2306; &#2361;&#2379;&#2344;&#2368; &#2330;&#2366;&#2361;&#2367;&#2319;| &#2332;&#2376;&#2360;&#2375; &#2361;&#2368; &#2332;&#2344;&#2381;&#2350; &#2325;&#2368; &#2340;&#2366;&#2352;&#2368;&#2326; &#2342;&#2352;&#2381;&#2332; &#2325;&#2368; &#2332;&#2366;&#2340;&#2368; &#2361;&#2376; &#2313;&#2350;&#2381;&#2352; &#2360;&#2381;&#2357;&#2350;&#2375;&#2357; &#2327;&#2339;&#2344;&#2366; &#2361;&#2379;  &#2332;&#2366;&#2319;&#2327;&#2368; |. </TD>
    </TR>
    <TR>
      <TD>(10)</TD>
      <TD ><P><STRONG>Social Category/&#2360;&#2366;&#2350;&#2366;&#2332;&#2367;&#2325;  &#2358;&#2381;&#2352;&#2375;&#2339;&#2368; : </STRONG>Select Social Category of the applicant from the list (i.e.  General,  Other Backward Caste, Scheduled Caste, Scheduled Tribe, Minority)/&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2310;&#2357;&#2375;&#2342;&#2325; &#2325;&#2368; &#2360;&#2366;&#2350;&#2366;&#2332;&#2367;&#2325; &#2358;&#2381;&#2352;&#2375;&#2339;&#2368; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; (&#2309;&#2352;&#2381;&#2341;&#2366;&#2340; &#2360;&#2366;&#2350;&#2366;&#2344;&#2381;&#2351;, &#2309;&#2344;&#2381;&#2351; &#2346;&#2367;&#2331;&#2396;&#2368; &#2332;&#2366;&#2340;&#2367;, &#2309;&#2344;&#2369;&#2360;&#2370;&#2330;&#2367;&#2340; &#2332;&#2344;&#2332;&#2366;&#2340;&#2367;, &#2309;&#2354;&#2381;&#2346;&#2360;&#2306;&#2326;&#2381;&#2351;&#2325;) </P>
        <P>Special Category/&#2357;&#2367;&#2358;&#2375;&#2359;  &#2358;&#2381;&#2352;&#2375;&#2339;&#2368; : Select Special Category from the list (i.e. Ex-serviceman, Physically Challenged, Hill Border Area, North East Area) /&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2357;&#2367;&#2358;&#2375;&#2359; &#2358;&#2381;&#2352;&#2375;&#2339;&#2368; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; (&#2309;&#2352;&#2381;&#2341;&#2366;&#2340; &#2349;&#2370;&#2340;&#2346;&#2370;&#2352;&#2381;&#2357; &#2360;&#2376;&#2344;&#2367;&#2325;, &#2358;&#2366;&#2352;&#2368;&#2352;&#2367;&#2325; &#2352;&#2370;&#2346; &#2360;&#2375; &#2357;&#2367;&#2325;&#2354;&#2366;&#2306;&#2327;, &#2346;&#2361;&#2366;&#2396;&#2368; &#2360;&#2368;&#2350;&#2366; &#2325;&#2381;&#2359;&#2375;&#2340;&#2381;&#2352;, &#2313;&#2340;&#2381;&#2340;&#2352; &#2346;&#2370;&#2352;&#2381;&#2357; &#2325;&#2381;&#2359;&#2375;&#2340;&#2381;&#2352;) </P></TD>
    </TR>
    <TR>
      <TD>11)</TD>
      <TD ><STRONG>Qualification/&#2358;&#2376;&#2325;&#2381;&#2359;&#2339;&#2367;&#2325;  &#2351;&#2379;&#2327;&#2340;&#2366; : S</STRONG>elect  qualification from the list (i.e. 8th Pass, Under 8th, 10th Pass, 12th Pass, Graduate, Post Graduate, PHD, Diploma) /&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2358;&#2376;&#2325;&#2381;&#2359;&#2339;&#2367;&#2325; &#2351;&#2379;&#2327;&#2381;&#2351;&#2340;&#2366; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2344; (&#2309;&#2352;&#2381;&#2341;&#2366;&#2340; 8 &#2357;&#2368;&#2306; &#2346;&#2366;&#2360;, 8 &#2357;&#2368;&#2306; &#2360;&#2375; &#2325;&#2350;, 10 &#2357;&#2368;&#2306;  &#2346;&#2366;&#2360;, 12 &#2357;&#2368;&#2306; &#2346;&#2366;&#2360;, &#2360;&#2381;&#2344;&#2366;&#2340;&#2325;, &#2360;&#2381;&#2344;&#2366;&#2340;&#2325;&#2379;&#2340;&#2381;&#2340;&#2352;, &#2346;&#2368;&#2319;&#2330;&#2337;&#2368;,  &#2337;&#2367;&#2346;&#2381;&#2354;&#2379;&#2350;&#2366;) </TD>
    </TR>
    <TR>
      <TD>(12)</TD>
      <TD ><STRONG> Address for Communication/&#2346;&#2340;&#2381;&#2352;&#2366;&#2330;&#2366;&#2352;  &#2361;&#2375;&#2340;&#2369; &#2346;&#2340;&#2366;: </STRONG>The Applicant should fill the  complete postal address of the applicant including State, District, Pin Code, Mobile No., Email and PAN No/&#2310;&#2357;&#2375;&#2342;&#2325;  &#2325;&#2379; &#2352;&#2366;&#2332;&#2381;&#2351;, &#2332;&#2367;&#2354;&#2366;, &#2346;&#2367;&#2344; &#2325;&#2379;&#2337;, &#2350;&#2379;&#2348;&#2366;&#2311;&#2354; &#2344;&#2306;&#2348;&#2352;, &#2312;&#2350;&#2375;&#2354; &#2324;&#2352; &#2346;&#2376;&#2344; &#2344;&#2306;&#2348;&#2352; &#2360;&#2361;&#2367;&#2340; &#2310;&#2357;&#2375;&#2342;&#2325; &#2325;&#2366; &#2346;&#2370;&#2352;&#2366;  &#2337;&#2366;&#2325; &#2346;&#2340;&#2366; &#2349;&#2352;&#2344;&#2366; &#2330;&#2366;&#2361;&#2367;&#2319;|. </TD>
    </TR>
    <TR>
      <TD>(13)</TD>
      <TD ><P><STRONG>Unit Location</STRONG>/&#2311;&#2325;&#2366;&#2312;  &#2325;&#2366; &#2360;&#2381;&#2341;&#2366;&#2344; : Select Unit Location (i.e. Rural OR Urban) /&#2330;&#2369;&#2344;&#2375;&#2306;  (&#2309;&#2352;&#2381;&#2341;&#2366;&#2340; &#2327;&#2381;&#2352;&#2366;&#2350;&#2368;&#2339; &#2351;&#2366; &#2358;&#2361;&#2352;&#2368;) </P>
        <P>&nbsp;</P></TD>
    </TR>
    <TR>
      <TD>(14)</TD>
      <TD ><STRONG>Proposed Unit Address/&#2346;&#2381;&#2352;&#2360;&#2381;&#2340;&#2366;&#2357;&#2367;&#2340;  &#2311;&#2325;&#2366;&#2312; &#2346;&#2340;&#2366;</STRONG> : The Applicant should fill  the complete Unit address of the unit including Taluka, District, Pin Code (If Unit Address is same as Communication Address then click on communication Address to Unit Address) /        &#2310;&#2357;&#2375;&#2342;&#2325; &#2325;&#2379; &#2311;&#2325;&#2366;&#2312;-&#2346;&#2340;&#2366; &#2349;&#2352;&#2339; &#2330;&#2366;&#2361;&#2367;&#2319;, &#2332;&#2367;&#2360;&#2350;&#2375;&#2306; &#2340;&#2366;&#2354;&#2369;&#2325;&#2366;, &#2332;&#2367;&#2354;&#2366;,<BR>
        &#2346;&#2367;&#2344; &#2325;&#2379;&#2337; (&#2351;&#2342;&#2367; &#2311;&#2325;&#2366;&#2312; &#2325;&#2366; &#2346;&#2340;&#2366;, &#2346;&#2340;&#2381;&#2352;&#2366;&#2330;&#2366;&#2352; &#2325;&#2375; &#2346;&#2340;&#2375; &#2325;&#2375; &#2360;&#2350;&#2366;&#2344; &#2361;&#2376; &#2340;&#2379; &#2311;&#2325;&#2366;&#2312; &#2325;&#2375; &#2346;&#2340;&#2375; &#2325;&#2375; &#2360;&#2381;&#2341;&#2366;&#2344; &#2346;&#2352;  &ldquo;&#2311;&#2325;&#2366;&#2312; &#2325;&#2366; &#2346;&#2340;&#2366;&rdquo; &#2346;&#2352; &#2325;&#2381;&#2354;&#2367;&#2325; &#2325;&#2352;&#2375;&#2306;)</TD>
    </TR>
    <TR>
      <TD>(15)</TD>
      <TD ><STRONG>Type of Activity/&#2327;&#2340;&#2367;&#2357;&#2367;&#2343;&#2367;  &#2325;&#2366; &#2346;&#2381;&#2352;&#2325;&#2366;&#2352;</STRONG> : Select from the activity list (i.e. Service or Manufacturing)/&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; (&#2309;&#2352;&#2381;&#2341;&#2366;&#2340; &#2360;&#2375;&#2357;&#2366; &#2351;&#2366; &#2357;&#2367;&#2344;&#2367;&#2352;&#2381;&#2350;&#2366;&#2339;)</TD>
    </TR>
    <TR>
      <TD>(16)</TD>
      <TD ><STRONG>Name of the Activity/&#2327;&#2340;&#2367;&#2357;&#2367;&#2343;&#2367;  &#2325;&#2366; &#2344;&#2366;&#2350;</STRONG> : (i) <STRONG>Industr/&#2313;&#2342;&#2381;&#2351;&#2379;&#2327;y : </STRONG>Select Industry from the List of Industry/&#2313;&#2342;&#2381;&#2351;&#2379;&#2327;  &#2325;&#2368; &#2360;&#2370;&#2330;&#2368; &#2360;&#2375; &#2313;&#2342;&#2381;&#2351;&#2379;&#2327; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306;  (ii) <STRONG>Product Description/&#2313;&#2340;&#2381;&#2346;&#2366;&#2342;  &#2357;&#2367;&#2357;&#2352;&#2339; : </STRONG>Type the specific product description/&#2357;&#2367;&#2358;&#2367;&#2359;&#2381;&#2335;:  &#2313;&#2340;&#2381;&#2346;&#2366;&#2342; &#2357;&#2367;&#2357;&#2352;&#2339; &#2325;&#2366; &#2344;&#2366;&#2350; &#2348;&#2340;&#2366;&#2319; . </TD>
    </TR>
    <TR>
      <TD>(17)</TD>
      <TD ><STRONG>Whether EDP Training Undergone/&#2325;&#2381;&#2351;&#2366;  &#2312;&#2337;&#2368;&#2346;&#2368; &#2346;&#2381;&#2352;&#2358;&#2367;&#2325;&#2381;&#2359;&#2339; &#2354;&#2367;&#2351;&#2366; &#2361;&#2376;</STRONG> :  Select Yes Or No from the List/&#2360;&#2370;&#2330;&#2368;  &#2360;&#2375; &ldquo;&#2361;&#2366;&#2306;&rdquo; &#2351;&#2366; &ldquo;&#2344;&#2361;&#2368;&#2306;&rdquo; &#2325;&#2366; &#2330;&#2351;&#2344; &#2325;&#2352;&#2375;&#2306; |. </TD>
    </TR>
    <TR>
      <TD>(18)</TD>
      <TD ><STRONG>Training Institute's Name/&#2346;&#2381;&#2352;&#2358;&#2367;&#2325;&#2381;&#2359;&#2339;  &#2360;&#2306;&#2360;&#2381;&#2341;&#2366; &#2325;&#2366; &#2344;&#2366;&#2350; : </STRONG>If EDP Training Undergone YES, enter Training Institute Name in detail/        &#2351;&#2342;&#2367; &#2312;&#2337;&#2368;&#2346;&#2368; &#2346;&#2381;&#2352;&#2358;&#2367;&#2325;&#2381;&#2359;&#2339; &#2354;&#2367;&#2351;&#2366; &#2361;&#2376;,&#2340;&#2379; &#2346;&#2381;&#2352;&#2358;&#2367;&#2325;&#2381;&#2359;&#2339; &#2360;&#2306;&#2360;&#2381;&#2341;&#2366;&#2344; &#2325;&#2366; &#2346;&#2370;&#2352;&#2366; &#2344;&#2366;&#2350; &#2357; &#2357;&#2367;&#2357;&#2352;&#2339; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2375;&#2306; |.</TD>
    </TR>
    <TR>
      <TD>(19)</TD>
      <TD ><STRONG>Loan Required/&#2310;&#2357;&#2358;&#2381;&#2351;&#2325;  &#2315;&#2339;</STRONG> : (i) <STRONG>Capital Expenditure : </STRONG> Enter CE loan as proposed in the DPR in rupees/&#2346;&#2370;&#2306;&#2332;&#2368;&#2327;&#2340;  &#2357;&#2381;&#2351;&#2357;: &#2357;&#2381;&#2351;&#2357; &#2315;&#2339; &#2325;&#2379; &#2352;&#2369;&#2346;&#2351;&#2375; &#2350;&#2375;&#2306; &#2337;&#2368;&#2346;&#2368;&#2310;&#2352; &#2350;&#2375;&#2306; &#2346;&#2381;&#2352;&#2360;&#2381;&#2340;&#2366;&#2357;&#2367;&#2340; &#2309;&#2344;&#2369;&#2360;&#2366;&#2352; &#2346;&#2370;&#2306;&#2332;&#2368;&#2327;&#2340; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2375;&#2306; |. (ii) <STRONG>Working Capital</STRONG> : Enter WC loan as proposed in the DPR in rupees/&#2325;&#2366;&#2352;&#2381;&#2351;&#2358;&#2368;&#2354;  &#2346;&#2370;&#2306;&#2332;&#2368; &#2315;&#2339; &#2337;&#2368;&#2346;&#2368;&#2310;&#2352; &#2350;&#2375;&#2306; &#2346;&#2381;&#2352;&#2360;&#2381;&#2340;&#2366;&#2357;&#2367;&#2340; &#2309;&#2344;&#2369;&#2360;&#2366;&#2352; &#2325;&#2366;&#2352;&#2381;&#2351;&#2358;&#2368;&#2354; &#2346;&#2370;&#2306;&#2332;&#2368; &#2315;&#2339; &#2325;&#2379; &#2352;&#2369;&#2346;&#2351;&#2375; &#2350;&#2375;&#2306; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2375;&#2306;. (iii) <STRONG>Total Loan : </STRONG> The total loan will be calculated by the system automatically/) &#2325;&#2369;&#2354;  &#2315;&#2339;: &#2325;&#2368; &#2327;&#2339;&#2344;&#2366; &#2346;&#2381;&#2352;&#2339;&#2366;&#2354;&#2368; &#2342;&#2381;&#2357;&#2366;&#2352;&#2366; &#2360;&#2381;&#2357;&#2330;&#2366;&#2354;&#2367;&#2340; &#2352;&#2370;&#2346; &#2360;&#2375; &#2325;&#2368; &#2332;&#2366;&#2319;&#2327;&#2368; |. </TD>
    </TR>
    <TR>
      <TD>(20)</TD>
      <TD ><STRONG>Bank Details/&#2348;&#2376;&#2306;&#2325;  &#2357;&#2367;&#2357;&#2352;&#2339;: (i) </STRONG>Enter IFSC code/&#2310;&#2312;&#2319;&#2347;&#2360;&#2360;&#2368;  (IFSC) &#2325;&#2379;&#2337; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2375;&#2306;  (ii) if IFSC code is not known then click on GET IFSC CODE button and select correct IFSC Code of Financing Bank/        &#2351;&#2342;&#2367; IFSC &#2325;&#2379;&#2337; &#2332;&#2381;&#2334;&#2366;&#2340; &#2344;&#2361;&#2368;&#2306; &#2361;&#2376; &#2340;&#2379; GET IFSC CODE &#2348;&#2335;&#2344; &#2346;&#2352; &#2325;&#2381;&#2354;&#2367;&#2325; &#2325;&#2352;&#2375;&#2306;, &#2324;&#2352; &#2347;&#2366;&#2311;&#2344;&#2375;&#2306;&#2360;&#2367;&#2306;&#2327; &#2348;&#2376;&#2306;&#2325; &#2325;&#2366; &#2360;&#2361;&#2368; IFSC &#2325;&#2379;&#2337; &#2330;&#2369;&#2344;&#2375;&#2306; | . (iii) Enter optional Bank IFSC code/&#2357;&#2376;&#2325;&#2354;&#2381;&#2346;&#2367;&#2325;  &#2348;&#2376;&#2306;&#2325; &#2325;&#2366; IFSC &#2325;&#2379;&#2337; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2375;&#2306; |. </TD>
    </TR>
    <TR>
      <TD>(21)</TD>
      <TD >2nd Financial Bank : Enter IFS Code of the 2nd Financing Branch which is optional /&#2342;&#2370;&#2360;&#2352;&#2368;  &#2347;&#2366;&#2311;&#2344;&#2375;&#2306;&#2360;&#2367;&#2306;&#2327; &#2348;&#2381;&#2352;&#2366;&#2306;&#2330; &#2325;&#2366; IFSC &#2325;&#2379;&#2337; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2375;&#2306;, &#2332;&#2379; &#2357;&#2376;&#2325;&#2354;&#2381;&#2346;&#2367;&#2325; &#2361;&#2376; | </TD>
    </TR>
    <TR>
      <TH>&nbsp;</TH>
      <TH>After entering all necessary information in the appropriate field Click On &quot;Save Applicant Data&quot; button to Save the Details/&#2313;&#2346;&#2351;&#2369;&#2325;&#2340; &#2360;&#2349;&#2368; &#2326;&#2366;&#2344;&#2379;&#2306; &#2350;&#2375;&#2306;  &#2360;&#2349;&#2368; &#2310;&#2357;&#2358;&#2381;&#2351;&#2325; &#2332;&#2366;&#2344;&#2325;&#2366;&#2352;&#2368; &#2342;&#2352;&#2381;&#2332; &#2325;&#2352;&#2344;&#2375; &#2325;&#2375; &#2348;&#2366;&#2342; &#2357;&#2367;&#2357;&#2352;&#2339; &#2325;&#2379; &#2360;&#2306;&#2330;&#2367;&#2340; (SAVE) &#2325;&#2352;&#2344;&#2375; &#2325;&#2375; &#2354;&#2367;&#2319; &ldquo;&#2310;&#2357;&#2375;&#2342;&#2325;  &#2337;&#2375;&#2335;&#2366; &#2360;&#2361;&#2375;&#2332;&#2375;&#2306;&rdquo; (Save Applicant Data) &#2348;&#2335;&#2344; &#2346;&#2352; &#2325;&#2381;&#2354;&#2367;&#2325; &#2325;&#2352;&#2375;&#2306; |. </TH>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>After &quot;Save Applicant Data&quot; , you need to Upload documents for final submission of application/&#2310;&#2357;&#2375;&#2342;&#2325;  &#2337;&#2375;&#2335;&#2366; &#2360;&#2361;&#2375;&#2332;&#2375;&#2306;&rdquo; (Save Applicant Data) &#2325;&#2375; &#2348;&#2366;&#2342;, &#2310;&#2357;&#2375;&#2342;&#2325; &#2325;&#2379; &#2309;&#2306;&#2340;&#2367;&#2350;  &#2340;&#2380;&#2352; &#2346;&#2352; &#2332;&#2350;&#2366; &#2325;&#2352;&#2344;&#2375; &#2325;&#2375; &#2354;&#2367;&#2319; &#2310;&#2346;&#2325;&#2379; &#2342;&#2360;&#2381;&#2340;&#2366;&#2357;&#2375;&#2332; &#2309;&#2346;&#2354;&#2379;&#2337; &#2325;&#2352;&#2344;&#2375; &#2361;&#2379;&#2306;&#2327;&#2375;&#2306; |. </TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>After Final Submission of Application , Applicant ID and password will be sent to your registered Mobile No/        &#2310;&#2357;&#2375;&#2342;&#2344; &#2325;&#2375; &#2309;&#2306;&#2340;&#2367;&#2350; &#2340;&#2380;&#2352;  &#2346;&#2352; &#2332;&#2350;&#2366; &#2361;&#2379;&#2344;&#2375; &#2325;&#2375; &#2348;&#2366;&#2342;, &#2310;&#2357;&#2375;&#2342;&#2325; &#2310;&#2312;&#2337;&#2368; &#2324;&#2352; &#2346;&#2366;&#2360;&#2357;&#2352;&#2381;&#2337; &#2310;&#2346;&#2325;&#2375; &#2346;&#2306;&#2332;&#2368;&#2325;&#2371;&#2340; &#2350;&#2379;&#2348;&#2366;&#2311;&#2354; &#2344;&#2306;&#2348;&#2352; &#2346;&#2352; &#2349;&#2375;&#2332; &#2342;&#2367;&#2351;&#2366; &#2332;&#2366;&#2319;&#2327;&#2366; |. </TD>
    </TR>
  </TABLE></TD>
</TR>
</TABLE>
<SCRIPT>
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
</SCRIPT>
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

</SCRIPT>
</FORM>
 

</BODY>
</HTML>
