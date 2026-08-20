<%@ include file="includeHeaderPageDLTFC.jsp" %>
<LINK rel="stylesheet" type="text/css" href="../css/main1.css">
<SCRIPT src="../js/sweetalert.min.js"></SCRIPT>
<SCRIPT src="../js/datetimepicker_css.js"></SCRIPT>
<SCRIPT src="../js/scorecardnew.js"></SCRIPT>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript">
function Popup(url, title, w, h) {
// Fixes dual-screen position Most browsers Firefox
var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

var left = ((width / 2) - (w / 2)) + dualScreenLeft;
var top = ((height / 2) - (h / 2)) + dualScreenTop;
var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

// Puts focus on the newWindow
if (window.focus) {
newWindow.focus();
}
}
</script>
<STYLE type="text/css">
input[type=radio]{
border:0px;
width:5%;
height: 2em;
}
.style4 {color: #00CC00}
.style5 {color: #FF0000}

input.largerCheckbox { 
            width: 30px; 
            height: 30px; 
        }
.style6 {font-size: 24px}

</STYLE>
</HEAD>
<BODY>
<FORM  name="form" id="form" method="post"  >

<%
List values=new ArrayList();
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
//String APP_ID =(String) session.getAttribute("sAPP_ID");

String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
// String vOffcd= (String) session.getAttribute("off_cd");

String AGE = "";
String NO_DEPENDENCIES = "";
String OWN_HOUSE = "";
String RESIDING_SAME_ADD = "";
String QUALIFICATION = "";
String EXPERIENCE = "";
String ANY_O_SOI = "";
String ASSESED_IT = "";
String LI_POLICY = "";
String RELATION_W_LEND_BANK = "";
String CREDIT_HISTORY = "";
String LOCATION_ADV = "";
String SKILL_CERTIFICATION = "";
String MARKETING_TU = "";
String LINE_OF_ACT = "";
String REG_GOV_AUTH = "";
String REPAY_PER = "";
String EMP_GENERATION = "";
String AVG_DSCR = "";
String COLLATERAL_SEC_COV = "";
String COVERED_UNDER = "";
String APP_AGREE_YN = "";
String RL_LENDING_BANK_MARK = "";
String TOTAL_SCORE = "";
String RTOTAL_SCORE = "";
String HO_VERIFY_YN = "";
String add_update="I";
String DEPEN_DOC="";
String DEPEN_REMARK="";
String HOUSE_DOC="";
String HOUSE_REMARK="";
String ADDR_DOC="";
String ADDR_REMARK="";
String EXP_DOC="";
String EXP_REMARK="";
String OTHSOUR_DOC="";
String OTHSOUR_REMARK="";
String INCOME_DOC="";
String INCOME_REMARK="";
String INSU_DOC="";
String INSU_REMARK="";
String BANK_DOC="";
String BANK_REMARK="";
String SKILL_DOC="";
String SKILL_REMARK="";
String REGEGOV_DOC="";
String REGEGOV_REMARK="";
String AGENCY_DOC="";
String AGENCY_REMARK="";

String HO_VERIFY_DT = "";

String ADDL_REMARK="";
String ADDL_DOC="";

String COLSEC_DOC="";
String COLSEC_REMARK="";
String CR_DOC="";
String CR_REMARK="";
String LOC_DOC="";
String LOC_REMARK="";
String MARK_DOC="";
String MARK_REMARK="";
String REPY_DOC="";
String REPY_REMARK="";
String DSCR_DOC="";
String DSCR_REMARK="";



























DBCon db= new DBCon();
db.connect();

String AGEYR="";
String EDU_DESC="";
String IND_TYPE="";
String EMP_ENV="";
String APP_NAME="";
String UPDATE_YN="N";
String ONLINE_SUBDT="";
String BANK_STATUS="";
String DOC_REMARK="";
String ADD_DOC_NM="";
String ADD_REMARK="";
String ACT_ID="";
String NO_OF_APP="";
ResultSet rs1=db.execSQL("SELECT TRUNC(MONTHS_BETWEEN(AD.ONLINE_SUBDT, AD.DOB) / 12) AS AGEYR, EM.EDU_DESC, CASE  WHEN AD.IND_TYPE = 'S'  THEN 'Service'  WHEN AD.IND_TYPE = 'M'  THEN 'Manufacturing'  ELSE 'Trading/Others' END IND_TYPE, AD.EMP_ENV, AD.APP_NAME , CASE WHEN ACT_ID IN (5) THEN 'N' ELSE 'Y' END UPDATE_YN, ONLINE_SUBDT,ACT_ID, AD.APP_NAME FROM APP_DETAIL AD, EDUCATION_MAST EM WHERE AD.EDU_ID = EM.EDU_ID AND AD.APP_ID='"+APP_ID+"'");
	
	while (rs1.next()) {
AGEYR=rs1.getString(1);
EDU_DESC=rs1.getString(2);
IND_TYPE=rs1.getString(3);
EMP_ENV=rs1.getString(4);
APP_NAME=rs1.getString(5);
UPDATE_YN=rs1.getString(6);
//out.print(UPDATE_YN);
ONLINE_SUBDT=rs1.getString(7);
ACT_ID=rs1.getString(8);
APP_NAME=rs1.getString(9);
}
rs1.close();
ResultSet rs12=db.execSQL("SELECT ACT_ID FROM BANK_DATAENTRY BD WHERE  BD.APP_ID='"+APP_ID+"'");
	
	while (rs12.next()) {
		BANK_STATUS=rs12.getString("ACT_ID")==null?"":rs12.getString("ACT_ID");
	}
	rs12.close();
	
	ResultSet rs123=db.execSQL("SELECT COUNT(*) NO_OF_APP FROM PMEGP_SCORE_CARD BD WHERE  BD.APP_ID='"+APP_ID+"'");
	
	while (rs123.next()) {
		NO_OF_APP=rs123.getString("NO_OF_APP")==null?"":rs123.getString("NO_OF_APP");
	}
	rs123.close();
	
	
	
	
	
	//out.print(BANK_STATUS);
if (!APP_ID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("    SELECT PSC.APP_ID,  PSC.AGE, PSC.NO_DEPENDENCIES, PSC.OWN_HOUSE,  PSC.RESIDING_SAME_ADD, PSC.QUALIFICATION,  CASE WHEN PSC.TOTAL_SCORE > 60 THEN 'RPASS' ELSE 'RFAIL' END AS RTOTAL_SCORE,   "      );
qrysb.append("    PSC.EXPERIENCE, PSC.ANY_O_SOI,  PSC.ASSESED_IT,  PSC.LI_POLICY,  TO_CHAR(PSC.RELATION_W_LEND_BANK,'DD-MON-RRRR') AS RELATION_W_LEND_BANK,  PSC.CREDIT_HISTORY,    "      );
qrysb.append("    PSC.LOCATION_ADV,  PSC.SKILL_CERTIFICATION,  PSC.MARKETING_TU,  PSC.LINE_OF_ACT,  PSC.REG_GOV_AUTH, PSC.HO_VERIFY_YN,  PSC.HO_VERIFY_DT,  "      );
qrysb.append("    PSC.REPAY_PER,  PSC.EMP_GENERATION,  PSC.AVG_DSCR,  PSC.COLLATERAL_SEC_COV,  PSC.APP_AGREE_YN , PSC.COVERED_UNDER, PSC.RL_LENDING_BANK_MARK, PSC.TOTAL_SCORE, "      ); qrysb.append(" PSC.REGEGOV_REMARK,  PSC.REGEGOV_DOC,  PSC.SKILL_REMARK,  PSC.SKILL_DOC,  PSC.BANK_REMARK,  PSC.BANK_DOC, ");
qrysb.append(" PSC.INSU_REMARK,  PSC.INSU_DOC,  PSC.INCOME_REMARK,  PSC.OTHSOUR_REMARK,  PSC.INCOME_DOC,  PSC.OTHSOUR_DOC,PSC.ADDL_DOC,PSC.ADDL_REMARK, "      );
 qrysb.append(" PSC.EXP_REMARK,  PSC.ADDR_REMARK,  PSC.EXP_DOC,  PSC.ADDR_DOC,  PSC.HOUSE_REMARK,  PSC.DEPEN_REMARK,  PSC.HOUSE_DOC,  PSC.DEPEN_DOC, PSC.AGENCY_DOC,PSC.AGENCY_REMARK ,PSC.DSCR_DOC,  PSC.DSCR_REMARK,PSC.COLSEC_DOC,PSC.COLSEC_REMARK,  "      );

qrysb.append("  PSC.CR_DOC,  PSC.CR_REMARK,  PSC.LOC_DOC,  PSC.MARK_DOC,  PSC.MARK_REMARK,  PSC.LOC_REMARK,  PSC.REPY_REMARK,  PSC.REPY_DOC ");
qrysb.append("    FROM PMEGP_SCORE_CARD PSC    "      );
qrysb.append("   WHERE  PSC.APP_ID=?    "      );

values.add(APP_ID);
//out.print(qrysb.toString());
ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
AGE=rsMain.getString("AGE")==null?"":rsMain.getString("AGE");
NO_DEPENDENCIES=rsMain.getString("NO_DEPENDENCIES")==null?"":rsMain.getString("NO_DEPENDENCIES");
OWN_HOUSE=rsMain.getString("OWN_HOUSE")==null?"":rsMain.getString("OWN_HOUSE");
RESIDING_SAME_ADD=rsMain.getString("RESIDING_SAME_ADD")==null?"":rsMain.getString("RESIDING_SAME_ADD");
QUALIFICATION=rsMain.getString("QUALIFICATION")==null?"":rsMain.getString("QUALIFICATION");
EXPERIENCE=rsMain.getString("EXPERIENCE")==null?"":rsMain.getString("EXPERIENCE");
ANY_O_SOI=rsMain.getString("ANY_O_SOI")==null?"":rsMain.getString("ANY_O_SOI");
ASSESED_IT=rsMain.getString("ASSESED_IT")==null?"":rsMain.getString("ASSESED_IT");
LI_POLICY=rsMain.getString("LI_POLICY")==null?"":rsMain.getString("LI_POLICY");
RELATION_W_LEND_BANK=rsMain.getString("RELATION_W_LEND_BANK")==null?"":rsMain.getString("RELATION_W_LEND_BANK");
CREDIT_HISTORY=rsMain.getString("CREDIT_HISTORY")==null?"":rsMain.getString("CREDIT_HISTORY");
LOCATION_ADV=rsMain.getString("LOCATION_ADV")==null?"":rsMain.getString("LOCATION_ADV");
SKILL_CERTIFICATION=rsMain.getString("SKILL_CERTIFICATION")==null?"":rsMain.getString("SKILL_CERTIFICATION");
MARKETING_TU=rsMain.getString("MARKETING_TU")==null?"":rsMain.getString("MARKETING_TU");
LINE_OF_ACT=rsMain.getString("LINE_OF_ACT")==null?"":rsMain.getString("LINE_OF_ACT");
REG_GOV_AUTH=rsMain.getString("REG_GOV_AUTH")==null?"":rsMain.getString("REG_GOV_AUTH");
REPAY_PER=rsMain.getString("REPAY_PER")==null?"":rsMain.getString("REPAY_PER");
EMP_GENERATION=rsMain.getString("EMP_GENERATION")==null?"":rsMain.getString("EMP_GENERATION");
AVG_DSCR=rsMain.getString("AVG_DSCR")==null?"":rsMain.getString("AVG_DSCR");
COLLATERAL_SEC_COV=rsMain.getString("COLLATERAL_SEC_COV")==null?"":rsMain.getString("COLLATERAL_SEC_COV");
APP_AGREE_YN=rsMain.getString("APP_AGREE_YN")==null?"":rsMain.getString("APP_AGREE_YN");
COVERED_UNDER=rsMain.getString("COVERED_UNDER")==null?"":rsMain.getString("COVERED_UNDER");
RL_LENDING_BANK_MARK=rsMain.getString("RL_LENDING_BANK_MARK")==null?"":rsMain.getString("RL_LENDING_BANK_MARK");
TOTAL_SCORE=rsMain.getString("TOTAL_SCORE")==null?"":rsMain.getString("TOTAL_SCORE");
RTOTAL_SCORE=rsMain.getString("RTOTAL_SCORE")==null?"":rsMain.getString("RTOTAL_SCORE");
HO_VERIFY_YN=rsMain.getString("HO_VERIFY_YN")==null?"":rsMain.getString("HO_VERIFY_YN");
DEPEN_DOC=rsMain.getString("DEPEN_DOC")==null?"":rsMain.getString("DEPEN_DOC");
DEPEN_REMARK=rsMain.getString("DEPEN_REMARK")==null?"":rsMain.getString("DEPEN_REMARK");
HOUSE_DOC=rsMain.getString("HOUSE_DOC")==null?"":rsMain.getString("HOUSE_DOC");
HOUSE_REMARK=rsMain.getString("HOUSE_REMARK")==null?"":rsMain.getString("HOUSE_REMARK");
ADDR_DOC=rsMain.getString("ADDR_DOC")==null?"":rsMain.getString("ADDR_DOC");
ADDR_REMARK=rsMain.getString("ADDR_REMARK")==null?"":rsMain.getString("ADDR_REMARK");
EXP_DOC=rsMain.getString("EXP_DOC")==null?"":rsMain.getString("EXP_DOC");
EXP_REMARK=rsMain.getString("EXP_REMARK")==null?"":rsMain.getString("EXP_REMARK");
OTHSOUR_DOC=rsMain.getString("OTHSOUR_DOC")==null?"":rsMain.getString("OTHSOUR_DOC");
OTHSOUR_REMARK=rsMain.getString("OTHSOUR_REMARK")==null?"":rsMain.getString("OTHSOUR_REMARK");
INCOME_DOC=rsMain.getString("INCOME_DOC")==null?"":rsMain.getString("INCOME_DOC");
INCOME_REMARK=rsMain.getString("INCOME_REMARK")==null?"":rsMain.getString("INCOME_REMARK");
INSU_DOC=rsMain.getString("INSU_DOC")==null?"":rsMain.getString("INSU_DOC");
INSU_REMARK=rsMain.getString("INSU_REMARK")==null?"":rsMain.getString("INSU_REMARK");
BANK_DOC=rsMain.getString("BANK_DOC")==null?"":rsMain.getString("BANK_DOC");
BANK_REMARK=rsMain.getString("BANK_REMARK")==null?"":rsMain.getString("BANK_REMARK");
SKILL_DOC=rsMain.getString("SKILL_DOC")==null?"":rsMain.getString("SKILL_DOC");
SKILL_REMARK=rsMain.getString("SKILL_REMARK")==null?"":rsMain.getString("SKILL_REMARK");
REGEGOV_DOC=rsMain.getString("REGEGOV_DOC")==null?"":rsMain.getString("REGEGOV_DOC");
REGEGOV_REMARK=rsMain.getString("REGEGOV_REMARK")==null?"":rsMain.getString("REGEGOV_REMARK");
AGENCY_DOC=rsMain.getString("AGENCY_DOC")==null?"":rsMain.getString("AGENCY_DOC");
AGENCY_REMARK=rsMain.getString("AGENCY_REMARK")==null?"":rsMain.getString("AGENCY_REMARK");
ADDL_DOC=rsMain.getString("ADDL_DOC")==null?"":rsMain.getString("ADDL_DOC");
ADDL_REMARK=rsMain.getString("ADDL_REMARK")==null?"":rsMain.getString("ADDL_REMARK");
HO_VERIFY_DT=rsMain.getString("HO_VERIFY_DT")==null?"":rsMain.getString("HO_VERIFY_DT");

CR_DOC=rsMain.getString("CR_DOC")==null?"":rsMain.getString("CR_DOC");
CR_REMARK=rsMain.getString("CR_REMARK")==null?"":rsMain.getString("CR_REMARK");
LOC_DOC=rsMain.getString("LOC_DOC")==null?"":rsMain.getString("LOC_DOC");
LOC_REMARK=rsMain.getString("LOC_REMARK")==null?"":rsMain.getString("LOC_REMARK");
MARK_DOC=rsMain.getString("MARK_DOC")==null?"":rsMain.getString("MARK_DOC");
MARK_REMARK=rsMain.getString("AGENCY_DOC")==null?"":rsMain.getString("AGENCY_DOC");
REPY_DOC=rsMain.getString("REPY_DOC")==null?"":rsMain.getString("REPY_DOC");
REPY_REMARK=rsMain.getString("REPY_REMARK")==null?"":rsMain.getString("REPY_REMARK");
DSCR_DOC=rsMain.getString("DSCR_DOC")==null?"":rsMain.getString("DSCR_DOC");
DSCR_REMARK=rsMain.getString("DSCR_REMARK")==null?"":rsMain.getString("DSCR_REMARK");
COLSEC_DOC=rsMain.getString("COLSEC_DOC")==null?"":rsMain.getString("COLSEC_DOC");
COLSEC_REMARK=rsMain.getString("COLSEC_REMARK")==null?"":rsMain.getString("COLSEC_REMARK");


add_update="U";
}
rsMain.close();

}
out.print(add_update);
%>

<CENTER>
<h2>Application ID:  <SPAN class="style4"><%=APP_ID%></SPAN><BR>
Applicant Name: <SPAN class="style4"><%=APP_NAME%></SPAN> </h2>


  <%if (NO_OF_APP.equals("0")) {%>
  
<h2 class="style5"> This Applicant has not filled the scorecard</h2>
  <%}%>
  

<H1>PMEGP SCORE CARD</H1>

<%if(!TOTAL_SCORE.equals("")){%>

<%if(RTOTAL_SCORE.equals("RPASS")){%>
<H1> <SPAN class="style4"> TOTAL MARKS SCORED : <%= TOTAL_SCORE %></SPAN></H1>
<%} else{%>
<H1><SPAN class="style5">TOTAL MARKS SCORED  : <%= TOTAL_SCORE %></SPAN></H1>

<%}%>

<%}%>

<%if(HO_VERIFY_YN.equals("Y")){%>
<DIV align="center"><A target="_blank"  href="../jasperrop/scorecardreport.jsp?REP_NM=scorecard&APP_ID=<%= APP_ID %>"   class="myButton">PRINT SCORE CARD</A></DIV>
<BR>
<%}%>
<TABLE id="customers">

<INPUT name="HO_VERIFY_YN" type="hidden" id="HO_VERIFY_YN" value="Y">
<INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
<INPUT name="ins" type="hidden" id="ins">
<INPUT name="ONLINE_SUBDT" type="hidden" id="ONLINE_SUBDT" value="<%= ONLINE_SUBDT %>">

<TR>
  <TH colspan="10"><DIV align="center">1. Personal Details (In case of non-individual details of main promoter to be captured) </DIV></TH>
  </TR>
<TR>
  <TD><DIV align="center">Sr. No. </DIV></TD>
  <TD><DIV align="center">Parameters</DIV></TD>
  <TD>Marks Secured </TD>
  <TD><DIV align="center">Criteria</DIV></TD>
  <TD>Upload</TD>
  <TD>Delete</TD>
  <TD>Remarks</TD>
  <TD colspan="3"><DIV align="center">Marks</DIV></TD>
</TR>

<TR>
  <TD width="5%"><DIV align="center">1.</DIV></TD>
  <TD width="46%">Age</TD>
  <TD width="10%"><%= AGE %></TD>
  <TD width="29%" colspan="4"><P>Applicant's Age : <%= AGEYR %></P>
    <P>25 to 40 </P>
    <P>18 to 24</P>
    <P>41 to 49</P>
    <P>50 and above   </P></TD>
  <TD width="10%" colspan="3"><DIV align="center">
    <P>&nbsp;</P>
    <P>6</P>
    <P>5</P>
    <P>3</P>
    <P>2</P>
    </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">2.</DIV></TD>
  <TD>No. of dependencies</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
  <TD height="25" width="172"><%= NO_DEPENDENCIES %></TD>
  </TABLE></TD>
  <TD><P>
   
      <INPUT type="radio" name="NO_DEPENDENCIES" value="2"   <% if (NO_DEPENDENCIES.equals("2")) {out.print("checked");}%>>
      Upto 3<BR>
   
      <INPUT type="radio" name="NO_DEPENDENCIES" value="0"   <% if (NO_DEPENDENCIES.equals("0")) {out.print("checked");}%>>
      more than 3
   
  </P></TD>
  
  <TD><% if (((add_update.equals("U")) && (DEPEN_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=1&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!DEPEN_DOC.equals("")){ %>
    <input type="button" name="button2" id="button2" class="myButton" value="View" onClick="viewdocument('<%= DEPEN_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!DEPEN_DOC.equals("")) && (UPDATE_YN.equals("Y")))  || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=1&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><P align="center"><%=DEPEN_REMARK %></P></TD>
  <TD><P align="center">2</P>
    <P align="center">0  </P></TD>
</TR>
<TR>
  <TD><DIV align="center">3.</DIV></TD>
  <TD>Owning a house/parental house</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
  <TD height="25" width="172"><%= OWN_HOUSE %></TD>
  </TABLE></TD>
  <TD><P>
   
      <INPUT type="radio" name="OWN_HOUSE" value="5"   <% if (OWN_HOUSE.equals("5")) {out.print("checked");}%>  >
      Yes<BR>
   
      <INPUT type="radio" name="OWN_HOUSE" value="2"    <% if (OWN_HOUSE.equals("2")) {out.print("checked");}%>    >
     No
   
  </P> </TD>
  <TD><% if (((add_update.equals("U")) && (HOUSE_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=2&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!HOUSE_DOC.equals("")){ %>
    <input type="button" name="button3" id="button3" class="myButton" value="View" onClick="viewdocument('<%= HOUSE_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!HOUSE_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=2&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=HOUSE_REMARK %></TD>
  <TD colspan="3">    <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">4.</DIV></TD>
  <TD>Residing at the same address / location</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
  <TD height="25" width="172"><%= RESIDING_SAME_ADD %></TD>
  </TABLE></TD>
  <TD> <P>
     <INPUT type="radio" name="RESIDING_SAME_ADD" value="5"     <% if (RESIDING_SAME_ADD.equals("5")) {out.print("checked");}%>   >  5 years and above<BR>
     <INPUT type="radio" name="RESIDING_SAME_ADD" value="3"      <% if (RESIDING_SAME_ADD.equals("3")) {out.print("checked");}%> >  2-5 years<BR>
     <INPUT type="radio" name="RESIDING_SAME_ADD" value="2"     <% if (RESIDING_SAME_ADD.equals("2")) {out.print("checked");}%> >  Less than 2 years<BR>
  </P></TD>
  <TD><% if (((add_update.equals("U")) && (ADDR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=3&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!ADDR_DOC.equals("")) { %>
    <input type="button" name="button4" id="button4" class="myButton" value="View" onClick="viewdocument('<%= ADDR_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!ADDR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=3&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=ADDR_REMARK %></TD>
  <TD colspan="3">      <DIV align="center">
    <P>5</P>
    <P>3</P>
    <P>2</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">5.</DIV></TD>
  <TD>Academic qualification</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
  <TD height="20" width="172"><%= QUALIFICATION %></TD>
  </TABLE></TD>
  <TD colspan="4"><P>Applicant's Qualification : <%= EDU_DESC %></P>
    <P>Graduation</P>
    <P>Intermediate</P>
    <P>More Metric</P>
    <P>Below Metric  </P></TD>
  <TD colspan="3">  <DIV align="center">
    <P>&nbsp;</P>
    <P>4</P>
    <P>3</P>
    <P>2</P>
    <P>1</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">6.</DIV></TD>
  <TD>Experience in the line of trade</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
  <TD height="25" width="172"><%= EXPERIENCE %></TD>
  </TABLE></TD>
  <TD> <P>
     <INPUT type="radio" name="EXPERIENCE" value="8"  <% if (EXPERIENCE.equals("8")) {out.print("checked");}%> >  equal or more than 3 years<BR>
      <INPUT type="radio" name="EXPERIENCE" value="6"  <% if (EXPERIENCE.equals("6")) {out.print("checked");}%>>  1 to 3 years<BR>
     <INPUT type="radio" name="EXPERIENCE" value="3"  <% if (EXPERIENCE.equals("3")) {out.print("checked");}%>>  less than 1 year<BR>
     <INPUT type="radio" name="EXPERIENCE" value="0"  <% if (EXPERIENCE.equals("0")) {out.print("checked");}%>>  Nil<BR>
  </P> </TD>
  <TD><% if (((add_update.equals("U")) && (EXP_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=4&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!EXP_DOC.equals("")){ %>
    <input type="button" name="button5" id="button5" class="myButton" value="View" onClick="viewdocument('<%= EXP_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!EXP_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=4&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=EXP_REMARK %></TD>
  <TD colspan="3">   <DIV align="center">
    <P>8</P>
    <P>6</P>
    <P>3</P>
    <P>0</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">7.</DIV></TD>
  <TD>Any other source of income including family</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= ANY_O_SOI %></TD>
  </TABLE></TD>
  <TD> <P>
      <INPUT type="radio" name="ANY_O_SOI" value="5"   <% if (ANY_O_SOI.equals("5")) {out.print("checked");}%>> Yes<BR>
      <INPUT type="radio" name="ANY_O_SOI" value="2"   <% if (ANY_O_SOI.equals("2")) {out.print("checked");}%>> No
  </P> </TD>
  <TD><% if (((add_update.equals("U")) && (OTHSOUR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=5&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!OTHSOUR_DOC.equals("")){ %>
    <input type="button" name="button6" id="button6" class="myButton" value="View" onClick="viewdocument('<%= OTHSOUR_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!OTHSOUR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=5&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=OTHSOUR_REMARK %></TD>
  <TD colspan="3">       <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">8.</DIV></TD>
  <TD>Assessed for Income Tax</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= ASSESED_IT %></TD>
  </TABLE></TD>
  <TD><P>
     <INPUT type="radio" name="ASSESED_IT" value="2"     <% if (ASSESED_IT.equals("2")) {out.print("checked");}%>> Assessed<BR>
      <INPUT type="radio" name="ASSESED_IT" value="1"     <% if (ASSESED_IT.equals("1")) {out.print("checked");}%>> Not Assessed
  </P> </TD>
  <TD><% if (((add_update.equals("U")) && (INCOME_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=6&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!INCOME_DOC.equals("")){ %>
    <input type="button" name="button7" id="button7" class="myButton" value="View" onClick="viewdocument('<%= INCOME_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!INCOME_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=6&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=INCOME_REMARK %></TD>
  <TD colspan="3"> <DIV align="center">
    <P>2</P>
    <P>1</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">9.</DIV></TD>
  <TD>Having Life Insurance policy (PMSBY, PMJJBY, APY or any other insurance policy) </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= LI_POLICY %></TD>
  </TABLE></TD>
  <TD><P>
  
   <INPUT type="radio" name="LI_POLICY" value="3"  <% if (LI_POLICY.equals("3")) {out.print("checked");}%>> more than 2 Insurance<BR>
      <INPUT type="radio" name="LI_POLICY" value="2"  <% if (LI_POLICY.equals("2")) {out.print("checked");}%>> 2 Insurance<BR>
       <INPUT type="radio" name="LI_POLICY" value="1"  <% if (LI_POLICY.equals("1")) {out.print("checked");}%>> 1 Insurance<BR>
    <INPUT type="radio" name="LI_POLICY" value="0"  <% if (LI_POLICY.equals("0")) {out.print("checked");}%>> No Insurance
   
  </P></TD>
  <TD><% if (((add_update.equals("U")) && (INSU_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=7&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!INSU_DOC.equals("")){ %>
    <input type="button" name="button8" id="button8" class="myButton" value="View" onClick="viewdocument('<%= INSU_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!INSU_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=7&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=INSU_REMARK %></TD>
  <TD colspan="3"><DIV align="center">
    <P>3</P>
    <P>2</P>
    <P>1</P>
    <P>0</P>
    </DIV></TD>
  </TR>
 

<TR>
  <TH colspan="10"><DIV align="center">2. New Venture / Firm </DIV></TH>
  </TR>
<TR>
  <TD><DIV align="center">10.</DIV></TD>
  <TD>Relationship with lending bank ( Opening Date of Bank Account) (dd-mmm-yyyy) </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= RL_LENDING_BANK_MARK %></TD>
  </TABLE></TD>
  <TD><P>
  
  <INPUT type="radio" name="RL_LENDING_BANK_MARK" id="radio1" value="1"   <% if (RL_LENDING_BANK_MARK.equals("1")) {out.print("checked");}%> onClick="enableTxtBox1()">New
  
  
   <INPUT type="radio" name="RL_LENDING_BANK_MARK" id="radio2"  value="" <% if (!RELATION_W_LEND_BANK.equals("")) {out.print("checked");}%> onClick="abcenableTxtBox1()">Already Existing<BR>
  
 ( Account Opening Date at Lending Bank:
  <INPUT name="RELATION_W_LEND_BANK" type="text" id="RELATION_W_LEND_BANK" readonly="true" value="<%= RELATION_W_LEND_BANK %>"  onClick="javascript:NewCssCal('RELATION_W_LEND_BANK','ddMMMyyyy')" onChange="days();" placeholder="Bank Account Opening Date"> )   
  <BR>
  </P>
 <P> Above 3 years </P>
 <P> 1 to 3 years </P>
 <P> less than 1 year </P>
 <P> New </P> </TD>
  <TD><% if (((add_update.equals("U")) && (BANK_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=8&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!BANK_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= BANK_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!BANK_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=8&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=BANK_REMARK %></TD>
  <TD colspan="3">     <DIV align="center">
    <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P>5</P>
    <P>3</P>
    <P>2</P>
    <P>1</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">11.</DIV></TD>
  <TD>Credit History</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= CREDIT_HISTORY %></TD>
  </TABLE></TD>
  <TD><P>
     <INPUT type="radio" name="CREDIT_HISTORY" value="5"  <% if (CREDIT_HISTORY.equals("5")) {out.print("checked");}%>> Very Good<BR>
      <INPUT type="radio" name="CREDIT_HISTORY" value="4"  <% if (CREDIT_HISTORY.equals("4")) {out.print("checked");}%>> Satisfactory<BR>
    <INPUT type="radio" name="CREDIT_HISTORY" value="3"  <% if (CREDIT_HISTORY.equals("3")) {out.print("checked");}%>> No history
  </P></TD>
 <TD><% if (((add_update.equals("U")) && (CR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=13&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!CR_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= CR_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!CR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=13&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=CR_REMARK %></TD>
  <TD colspan="3"> <DIV align="center">
    <P>5</P>
    <P>4</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">12.</DIV></TD>
  <TD>Location Advantage (availability of infrastructure, raw materials, labour, proximity to markets etc.) </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= LOCATION_ADV %></TD>
  </TABLE></TD>
  <TD><P>
     <INPUT type="radio" name="LOCATION_ADV" value="5"  <% if (LOCATION_ADV.equals("5")) {out.print("checked");}%>> Yes<BR>
    <INPUT type="radio" name="LOCATION_ADV" value="3"  <% if (LOCATION_ADV.equals("3")) {out.print("checked");}%>> No
  </P></TD>
  <TD><% if (((add_update.equals("U")) && (LOC_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=14&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!LOC_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= LOC_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!LOC_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=14&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=LOC_REMARK %></TD>
  <TD colspan="3">         <DIV align="center">
    <P>5</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">13.</DIV></TD>
  <TD>Skill Certification Course / RSETI / ITS / Computer knowledge </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= SKILL_CERTIFICATION %></TD>
  </TABLE></TD>
  <TD><P>
     <INPUT type="radio" name="SKILL_CERTIFICATION" value="5"  <% if (SKILL_CERTIFICATION.equals("5")) {out.print("checked");}%>> Yes<BR>
     <INPUT type="radio" name="SKILL_CERTIFICATION" value="2"  <% if (SKILL_CERTIFICATION.equals("2")) {out.print("checked");}%>> No
  </P></TD>
  <TD><% if (((add_update.equals("U")) && (SKILL_DOC.equals(""))&& (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=9&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!SKILL_DOC.equals("")){ %>
    <input type="button" name="button10" id="button10" class="myButton" value="View" onClick="viewdocument('<%= SKILL_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!SKILL_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=9&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=SKILL_REMARK %></TD>
  <TD colspan="3"> <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>


<TR>
  <TD><DIV align="center">14.</DIV></TD>
  <TD>Marketing Tie ups for sale of products</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= MARKETING_TU %></TD>
  </TABLE></TD>
  <TD><P>
      <INPUT type="radio" name="MARKETING_TU" value="5"  <% if (MARKETING_TU.equals("5")) {out.print("checked");}%>> Yes<BR>
      <INPUT type="radio" name="MARKETING_TU" value="2"  <% if (MARKETING_TU.equals("2")) {out.print("checked");}%>> No
  </P></TD>
    <TD><% if (((add_update.equals("U")) && (MARK_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=15&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!MARK_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= MARK_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!MARK_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=15&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=MARK_REMARK %></TD>
  <TD colspan="3">         <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">15.</DIV></TD>
  <TD>Line of Activity</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= LINE_OF_ACT %></TD>
  </TABLE></TD>
  <TD colspan="4"><P>Applicant's Line of Activity : <%= IND_TYPE %></P>
    <P>Manufacturing / Service</P>
    <P>Trade and others  </P></TD>
  <TD colspan="3"> <BR>
    <P align="center">5</P>
    <P align="center">3      </P></TD>
  </TR>
<TR>
  <TD><DIV align="center">16.</DIV></TD>
  <TD>Registered with Govt. Authorities viz for GST/ licence from local bodies / shop act etc. </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= REG_GOV_AUTH %></TD>
  </TABLE></TD>
  <TD> <P>
      <INPUT type="radio" name="REG_GOV_AUTH" value="5"  <% if (REG_GOV_AUTH.equals("5")) {out.print("checked");}%>> Yes<BR>
      <INPUT type="radio" name="REG_GOV_AUTH" value="3"  <% if (REG_GOV_AUTH.equals("3")) {out.print("checked");}%>> No
    </P></TD>
  <TD><% if (((add_update.equals("U")) && (REGEGOV_DOC.equals(""))&& (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=10&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!REGEGOV_DOC.equals("")){ %>
    <input type="button" name="button" id="button" class="myButton" value="View" onClick="viewdocument('<%= REGEGOV_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!REGEGOV_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=10&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><P align="center"><%=REGEGOV_REMARK %></P></TD>
  <TD colspan="3">   <DIV align="center">
    <P>5</P>
    <P>3</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">17.</DIV></TD>
  <TD>Repayment Period</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= REPAY_PER %></TD>
  </TABLE></TD>
  <TD><P>
       <INPUT type="radio" name="REPAY_PER" value="5"  <% if (REPAY_PER.equals("5")) {out.print("checked");}%>> Upto 5 years<BR>
       <INPUT type="radio" name="REPAY_PER" value="3"  <% if (REPAY_PER.equals("3")) {out.print("checked");}%>> Above 5 years
  </P></TD>
  <TD><% if (((add_update.equals("U")) && (REPY_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=16&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!REPY_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= REPY_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!REPY_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=16&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=REPY_REMARK %></TD>
  <TD colspan="3"> <DIV align="center">
    <P>5</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">18.</DIV></TD>
  <TD>Employment Generation</TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= EMP_GENERATION %></TD>
  </TABLE></TD>
  <TD colspan="4"><P>Applicant's Employment Generation : <%= EMP_ENV %></P>
    <P>Above 5</P>
    <P>3 to 5</P>
    <P>Self Employed   </P></TD>
  <TD colspan="3"><DIV align="center">
    <P>&nbsp;</P>
    <P>5</P>
    <P>3</P>
    <P>2</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">19.</DIV></TD>
  <TD>Avg DSCR </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= AVG_DSCR %></TD>
  </TABLE></TD>
  <TD><P>
      <INPUT type="radio" name="AVG_DSCR" value="5"  <% if (AVG_DSCR.equals("5")) {out.print("checked");}%>> more than 2 <BR>
       <INPUT type="radio" name="AVG_DSCR" value="3"  <% if (AVG_DSCR.equals("3")) {out.print("checked");}%>> 1.5 to 2 <BR>
     <INPUT type="radio" name="AVG_DSCR" value="2"  <% if (AVG_DSCR.equals("2")) {out.print("checked");}%>> less than 1.5
  </P></TD>
    <TD><% if (((add_update.equals("U")) && (DSCR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=17&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!DSCR_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= DSCR_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!DSCR_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=17&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD><%=DSCR_REMARK %></TD>
  <TD colspan="3"><DIV align="center">
    <P>5</P>
    <P>3</P>
    <P>2</P>
  </DIV></TD>
  </TR>

<TR HIDDEN>
  <TD colspan="10"><DIV align="center">** To be followed up and completed </DIV></TD>
  </TR>
<TR>
  <TH colspan="10"><DIV align="center">3. Security </DIV></TH>
  </TR>

<TR>
  <TD colspan="8"><DIV align="center">Collateral Security Coverage : <INPUT type="radio" id="blue" name="COVERED_UNDER" value="" onClick="enableclr()" <% out.print("checked");%>>  </DIV>   </TD>
</TR>


<TR>
  <TD><DIV align="center">20.</DIV></TD>
  <TD><P>Collateral Security Coverage :</P>
    <P>&nbsp;</P></TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172"><%= COLLATERAL_SEC_COV %></TD>
  </TABLE></TD>
  <TD>
  <%if(!COLLATERAL_SEC_COV.equals("")){%>
  <P>
       <INPUT type="radio" id="COLLATERAL_SEC_COV" name="COLLATERAL_SEC_COV" value="10" <% if (COLLATERAL_SEC_COV.equals("10")) {out.print("checked");}%>> 100% & above  <BR>
       <INPUT type="radio" id="COLLATERAL_SEC_COV2" name="COLLATERAL_SEC_COV" value="8"  <% if (COLLATERAL_SEC_COV.equals("8")) {out.print("checked");}%>> 50% to < 100%  <BR>
      <INPUT type="radio" id="COLLATERAL_SEC_COV3" name="COLLATERAL_SEC_COV" value="6"  <% if (COLLATERAL_SEC_COV.equals("6")) {out.print("checked");}%>> Less than 50%  </P>
 
  <%}else{%>

 <P>
      <INPUT type="radio" id="COLLATERAL_SEC_COV" name="COLLATERAL_SEC_COV"  value="10" <% if (COLLATERAL_SEC_COV.equals("10")) {out.print("checked");}%>> 100% & above <BR>
      <INPUT type="radio" id="COLLATERAL_SEC_COV2" name="COLLATERAL_SEC_COV"   value="8"  <% if (COLLATERAL_SEC_COV.equals("8")) {out.print("checked");}%>> 50% to < 100%  <BR>
     <INPUT type="radio" id="COLLATERAL_SEC_COV3" name="COLLATERAL_SEC_COV"   value="6"  <% if (COLLATERAL_SEC_COV.equals("6")) {out.print("checked");}%>> Less than 50%  </P>

<%}%>  </TD>
  <TD><% if (((add_update.equals("U")) && (COLSEC_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=18&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!COLSEC_DOC.equals("")){ %>
    <input type="button" name="button9" id="button9" class="myButton" value="View" onClick="viewdocument('<%= COLSEC_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!COLSEC_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))) {%>
    <a href="appidAgn.jsp?UPM_CD=18&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
	 <TD><%=COLSEC_REMARK %></TD>
  <TD colspan="3"><DIV align="center">
    <P>10</P>
    <P>8</P>
    <P>6</P>
  </DIV></TD>
  </TR>
   <TR>
    <TD>21</TD>
    <TD>Any additional Documet </TD>
    <TD></TD>
	<td>
    <% if (((add_update.equals("U")) && (ADDL_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=12&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
    <%}else if (!ADDL_DOC.equals("")){ %>
    <input type="button" name="button11" id="button11" class="myButton" value="View" onClick="viewdocument('<%= ADDL_DOC %>','<%=APP_ID%>');">
    <%}%></TD>
  <TD><% if (((!ADDL_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
    <a href="appidAgn.jsp?UPM_CD=12&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
    <% } else{ out.print("-");} %></TD>
  <TD colspan="4"><P align="center"><%=ADDL_REMARK %></P></TD>
  </TR>
  
  
  <TR>
   <TR>
  <TD><DIV align="center">22.</DIV></TD>
  <TD>Agency Documents </TD>
  <TD><TABLE cellspacing="0" cellpadding="0">
    <TD height="25" width="172">&nbsp;</TD>
  </TABLE></TD>
  <TD><P>
<% if (((add_update.equals("U")) && (AGENCY_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
  <a href="appidSn.jsp?UPM_CD=11&APP_ID=<%=APP_ID%>" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
<%}else if (!AGENCY_DOC.equals("")){ %>
    <input type="button" name="button" id="button" class="myButton" value="View" onClick="viewdocumentA('<%= AGENCY_DOC %>','<%= APP_ID%>');">
   <%}%></P>  </TD>
  <TD><% if (((!AGENCY_DOC.equals("")) && (UPDATE_YN.equals("Y"))) || (BANK_STATUS.equals("3"))){%>
  <a href="Upload_score_app_delAgency.jsp?UPM_CD=11&APP_ID=<%=APP_ID%>&TYPE=D" class="myButton" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a>
  <% } else{ out.print("-");} %></TD>
  <TD colspan="3"><P align="center"><%=AGENCY_REMARK %></P>
    <P>&nbsp;</P></TD>
</TR>
  </TR>
 <TR>
  <TD colspan="9"><DIV align="center"> <INPUT type="hidden" name="APP_AGREE_YN" value="Y" id="APP_AGREE_YN">
    <!--  <INPUT type="checkbox" name="checkbox" value="check" class="largerCheckbox" id="checkbox" >
   <SPAN class="style6">   Verified and finalised Marks</SPAN>--></DIV></TD>
</TR>

<TR>
  <TD colspan="9">
  
 <DIV align="center"> <!--<INPUT name="Button" type="button" class="myButton" onClick="submitform();" value="SAVE"/>--></DIV>  </TD>
</TR>
</TABLE>
<CENTER>
<BR/>
  

<%

if (ins.equals("I")) {
AGE=(String) request.getParameter("AGE")==null?"":(String) request.getParameter("AGE").trim();
NO_DEPENDENCIES=(String) request.getParameter("NO_DEPENDENCIES")==null?"":(String) request.getParameter("NO_DEPENDENCIES").trim();
OWN_HOUSE=(String) request.getParameter("OWN_HOUSE")==null?"":(String) request.getParameter("OWN_HOUSE").trim();
RESIDING_SAME_ADD=(String) request.getParameter("RESIDING_SAME_ADD")==null?"":(String) request.getParameter("RESIDING_SAME_ADD").trim();
QUALIFICATION=(String) request.getParameter("QUALIFICATION")==null?"":(String) request.getParameter("QUALIFICATION").trim();
EXPERIENCE=(String) request.getParameter("EXPERIENCE")==null?"":(String) request.getParameter("EXPERIENCE").trim();
ANY_O_SOI=(String) request.getParameter("ANY_O_SOI")==null?"":(String) request.getParameter("ANY_O_SOI").trim();
ASSESED_IT=(String) request.getParameter("ASSESED_IT")==null?"":(String) request.getParameter("ASSESED_IT").trim();
LI_POLICY=(String) request.getParameter("LI_POLICY")==null?"":(String) request.getParameter("LI_POLICY").trim();
RELATION_W_LEND_BANK=(String) request.getParameter("RELATION_W_LEND_BANK")==null?"":(String) request.getParameter("RELATION_W_LEND_BANK").trim();
CREDIT_HISTORY=(String) request.getParameter("CREDIT_HISTORY")==null?"":(String) request.getParameter("CREDIT_HISTORY").trim();
LOCATION_ADV=(String) request.getParameter("LOCATION_ADV")==null?"":(String) request.getParameter("LOCATION_ADV").trim();
SKILL_CERTIFICATION=(String) request.getParameter("SKILL_CERTIFICATION")==null?"":(String) request.getParameter("SKILL_CERTIFICATION").trim();
MARKETING_TU=(String) request.getParameter("MARKETING_TU")==null?"":(String) request.getParameter("MARKETING_TU").trim();
LINE_OF_ACT=(String) request.getParameter("LINE_OF_ACT")==null?"":(String) request.getParameter("LINE_OF_ACT").trim();
REG_GOV_AUTH=(String) request.getParameter("REG_GOV_AUTH")==null?"":(String) request.getParameter("REG_GOV_AUTH").trim();
REPAY_PER=(String) request.getParameter("REPAY_PER")==null?"":(String) request.getParameter("REPAY_PER").trim();
EMP_GENERATION=(String) request.getParameter("EMP_GENERATION")==null?"":(String) request.getParameter("EMP_GENERATION").trim();
AVG_DSCR=(String) request.getParameter("AVG_DSCR")==null?"":(String) request.getParameter("AVG_DSCR").trim();
COLLATERAL_SEC_COV=(String) request.getParameter("COLLATERAL_SEC_COV")==null?"":(String) request.getParameter("COLLATERAL_SEC_COV").trim();
APP_AGREE_YN=(String) request.getParameter("APP_AGREE_YN")==null?"":(String) request.getParameter("APP_AGREE_YN").trim();
COVERED_UNDER=(String) request.getParameter("COVERED_UNDER")==null?"":(String) request.getParameter("COVERED_UNDER").trim();
RL_LENDING_BANK_MARK=(String) request.getParameter("RL_LENDING_BANK_MARK")==null?"":(String) request.getParameter("RL_LENDING_BANK_MARK").trim();

HO_VERIFY_YN=(String) request.getParameter("HO_VERIFY_YN")==null?"":(String) request.getParameter("HO_VERIFY_YN").trim();
HO_VERIFY_DT=(String) request.getParameter("HO_VERIFY_DT")==null?"":(String) request.getParameter("HO_VERIFY_DT").trim();


		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
	
if (add_update.equals("I")) {

qryUpdate.append("INSERT INTO PMEGP_SCORE_CARD ( ");
qryUpdate.append("AGE,");
qryUpdate.append("NO_DEPENDENCIES,");
qryUpdate.append("OWN_HOUSE,");
qryUpdate.append("RESIDING_SAME_ADD,");
qryUpdate.append("QUALIFICATION,");
qryUpdate.append("EXPERIENCE,");
qryUpdate.append("ANY_O_SOI,");
qryUpdate.append("ASSESED_IT,");
qryUpdate.append("LI_POLICY,");
qryUpdate.append("RELATION_W_LEND_BANK,");
qryUpdate.append("CREDIT_HISTORY,");
qryUpdate.append("LOCATION_ADV,");
qryUpdate.append("SKILL_CERTIFICATION,");
qryUpdate.append("MARKETING_TU,");
qryUpdate.append("LINE_OF_ACT,");
qryUpdate.append("REG_GOV_AUTH,");
qryUpdate.append("REPAY_PER,");
qryUpdate.append("EMP_GENERATION,");
qryUpdate.append("AVG_DSCR,");
qryUpdate.append("COLLATERAL_SEC_COV,COVERED_UNDER,RL_LENDING_BANK_MARK,");
qryUpdate.append("APP_AGREE_YN,");

qryUpdate.append("HO_VERIFY_YN,");
qryUpdate.append("HO_VERIFY_DT,");

qryUpdate.append("APP_ID");


qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,?,?,?,?,  ?,?,?,?,SYSDATE,? )");
}else {

qryUpdate.append("UPDATE PMEGP_SCORE_CARD SET ");

qryUpdate.append("AGE=?,");
qryUpdate.append("NO_DEPENDENCIES=?,");
qryUpdate.append("OWN_HOUSE=?,");
qryUpdate.append("RESIDING_SAME_ADD=?,");
qryUpdate.append("QUALIFICATION=?,");
qryUpdate.append("EXPERIENCE=?,");
qryUpdate.append("ANY_O_SOI=?,");
qryUpdate.append("ASSESED_IT=?,");
qryUpdate.append("LI_POLICY=?,");
qryUpdate.append("RELATION_W_LEND_BANK=?,");
qryUpdate.append("CREDIT_HISTORY=?,");
qryUpdate.append("LOCATION_ADV=?,");
qryUpdate.append("SKILL_CERTIFICATION=?,");
qryUpdate.append("MARKETING_TU=?,");
qryUpdate.append("LINE_OF_ACT=?,");
qryUpdate.append("REG_GOV_AUTH=?,");
qryUpdate.append("REPAY_PER=?,");
qryUpdate.append("EMP_GENERATION=?,");
qryUpdate.append("AVG_DSCR=?,");
qryUpdate.append("COLLATERAL_SEC_COV=?,");
qryUpdate.append("COVERED_UNDER=?,");
qryUpdate.append("RL_LENDING_BANK_MARK=?,");
qryUpdate.append("APP_AGREE_YN=?,");

qryUpdate.append("HO_VERIFY_YN=?,");
qryUpdate.append("HO_VERIFY_DT=SYSDATE");

qryUpdate.append(" WHERE APP_ID=? ");


}


values.add(AGE); pstm.add ("L");
values.add(NO_DEPENDENCIES); pstm.add ("L");
values.add(OWN_HOUSE); pstm.add ("L");
values.add(RESIDING_SAME_ADD); pstm.add ("L");
values.add(QUALIFICATION); pstm.add ("L");
values.add(EXPERIENCE); pstm.add ("L");
values.add(ANY_O_SOI); pstm.add ("L");
values.add(ASSESED_IT); pstm.add ("L");
values.add(LI_POLICY); pstm.add ("L");
values.add(RELATION_W_LEND_BANK); pstm.add ("L");
values.add(CREDIT_HISTORY); pstm.add ("L");
values.add(LOCATION_ADV); pstm.add ("L");
values.add(SKILL_CERTIFICATION); pstm.add ("L");
values.add(MARKETING_TU); pstm.add ("L");
values.add(LINE_OF_ACT); pstm.add ("L");
values.add(REG_GOV_AUTH); pstm.add ("L");
values.add(REPAY_PER); pstm.add ("L");
values.add(EMP_GENERATION); pstm.add ("L");
values.add(AVG_DSCR); pstm.add ("L");
values.add(COLLATERAL_SEC_COV); pstm.add ("L");
values.add(COVERED_UNDER); pstm.add ("L");
values.add(RL_LENDING_BANK_MARK); pstm.add ("L");
values.add(APP_AGREE_YN); pstm.add ("L");

values.add(HO_VERIFY_YN); pstm.add ("L");


values.add(APP_ID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
response.sendRedirect("pmegpscorecardAgency.jsp?APP_ID="+APP_ID);
}
db.close();
%>
 
  <SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");


 function viewdocument(vDOC_NAME,vApp_id){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("appidAgn.jsp?docname="+vDOC_NAME+"&APP_ID="+vApp_id,500,800,'View Document',null,null);
 }//end of bank
 function viewdocumentA(vDOC_NAME,vApp_id){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("docViewScoreAgency.jsp?docname="+vDOC_NAME+"&APP_ID="+vApp_id,500,800,'View Document',null,null);
 }//end of bank






  function HideModalWindow() {
  modalWin.HideModalPopUp();
}

function refreshpage() {
  location.reload();
}

</SCRIPT>


</FORM>
</BODY>
</HTML>