<%@ include file="appIncludeHeaderPage.jsp" %>

<LINK rel="stylesheet" type="text/css" href="../css/main1.css">
<SCRIPT src="../js/sweetalert.min.js"></SCRIPT>
<SCRIPT src="../js/datetimepicker_css.js"></SCRIPT>
<SCRIPT src="../js/scorecard.js"></SCRIPT>


<STYLE type="text/css">
<!--
-->
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
<FORM  name="form" id="form" method="post" action="pmegpscorecard.jsp" >

<%

List values=new ArrayList();

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String APP_ID =(String) session.getAttribute("sAPP_ID");

// request.getParameter("APP_ID")==null?"KVMH16176512-1208711":(String)request.getParameter("APP_ID");;
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
String add_update="I";


DBCon db= new DBCon();
db.connect();

String AGEYR="";
String EDU_DESC="";
String IND_TYPE="";
String EMP_ENV="";
String APP_NAME="";
String UPDATE_YN="N";

ResultSet rs1=db.execSQL("SELECT TRUNC(MONTHS_BETWEEN(AD.ONLINE_SUBDT, AD.DOB) / 12) AS AGEYR, EM.EDU_DESC, CASE  WHEN AD.IND_TYPE = 'S'  THEN 'Service'  WHEN AD.IND_TYPE = 'M'  THEN 'Manufacturing'  ELSE 'Trading/Others' END IND_TYPE, AD.EMP_ENV, AD.APP_NAME , CASE WHEN ACT_ID IN (5,3,7) THEN 'N' ELSE 'Y' END UPDATE_YN FROM APP_DETAIL AD, EDUCATION_MAST EM WHERE AD.EDU_ID = EM.EDU_ID AND AD.APP_ID='"+APP_ID+"'");
	
	while (rs1.next()) {
AGEYR=rs1.getString(1);
EDU_DESC=rs1.getString(2);
IND_TYPE=rs1.getString(3);
EMP_ENV=rs1.getString(4);
APP_NAME=rs1.getString(5);
UPDATE_YN=rs1.getString(6);
}
rs1.close();


  //out.print (BNF_TRID+" "+OFF_CD);


if (!APP_ID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("    SELECT PSC.APP_ID,  PSC.AGE, PSC.NO_DEPENDENCIES, PSC.OWN_HOUSE,  PSC.RESIDING_SAME_ADD, PSC.QUALIFICATION,  CASE WHEN PSC.TOTAL_SCORE > 60 THEN 'RPASS' ELSE 'RFAIL' END AS RTOTAL_SCORE,   "      );
qrysb.append("    PSC.EXPERIENCE, PSC.ANY_O_SOI,  PSC.ASSESED_IT,  PSC.LI_POLICY,  TO_CHAR(PSC.RELATION_W_LEND_BANK,'DD-MON-RRRR') AS RELATION_W_LEND_BANK,  PSC.CREDIT_HISTORY,    "      );
qrysb.append("    PSC.LOCATION_ADV,  PSC.SKILL_CERTIFICATION,  PSC.MARKETING_TU,  PSC.LINE_OF_ACT,  PSC.REG_GOV_AUTH,    "      );
qrysb.append("    PSC.REPAY_PER,  PSC.EMP_GENERATION,  PSC.AVG_DSCR,  PSC.COLLATERAL_SEC_COV,  PSC.APP_AGREE_YN , PSC.COVERED_UNDER, PSC.RL_LENDING_BANK_MARK, PSC.TOTAL_SCORE   "      );
qrysb.append("    FROM PMEGP_SCORE_CARD PSC    "      );
qrysb.append("   WHERE  PSC.APP_ID=?    "      );

values.add(APP_ID);
 // out.print(qrysb.toString());

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

add_update="U";
}
rsMain.close();

}

%>


<BR>
<BR>
<CENTER>
<H1>PMEGP SCORE CARD</H1>

<%if(!TOTAL_SCORE.equals("")){%>

<%if(RTOTAL_SCORE.equals("RPASS")){%>
<H1> <SPAN class="style4">YOUR MARKS SCORED ARE : <%= TOTAL_SCORE %></SPAN></H1>
<%} else{%>
<H1><SPAN class="style5">YOUR MARKS SCORED ARE : <%= TOTAL_SCORE %></SPAN></H1>

<%}%>

<%}%>
<TABLE id="customers">

<INPUT name="ins" type="hidden" id="ins">

<TR>
  <TH colspan="7"><DIV align="center">1. Personal Details (In case of non-individual details of main promoter to be captured) </DIV></TH>
  </TR>
<TR>
  <TD><DIV align="center">Sr. No. </DIV></TD>
  <TD><DIV align="center">Parameters</DIV></TD>
  <TD>Marks Secured </TD>
  <TD><DIV align="center">Criteria</DIV></TD>
  <TD colspan="3"><DIV align="center">Marks</DIV></TD>
</TR>

<TR>
  <TD width="5%"><DIV align="center">1.</DIV></TD>
  <TD width="46%">Age</TD>
  <TD width="10%"><%= AGE %></TD>
  <TD width="29%"><P>Applicant's Age : <%= AGEYR %></P>
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
  <TD><table cellspacing="0" cellpadding="0">
  <td height="25" width="172"><%= NO_DEPENDENCIES %></td>
  </table></TD>
  <TD><P>
    <LABEL>
      <INPUT type="radio" name="NO_DEPENDENCIES" value="2"   <% if (NO_DEPENDENCIES.equals("2")) {out.print("checked");}%>>
      Upto 3</LABEL> <BR>
    <LABEL>
      <INPUT type="radio" name="NO_DEPENDENCIES" value="0"   <% if (NO_DEPENDENCIES.equals("0")) {out.print("checked");}%>>
      more than 3</LABEL>
   
  </P></TD>
  
  <TD><P align="center">2</P>
    <P align="center">0  </P></TD>
</TR>
<TR>
  <TD><DIV align="center">3.</DIV></TD>
  <TD>Owning a house/parental house</TD>
  <TD><table cellspacing="0" cellpadding="0">
  <td height="25" width="172"><%= OWN_HOUSE %></td>
  </table></TD>
  <TD><P>
    <LABEL>
      <INPUT type="radio" name="OWN_HOUSE" value="5"   <% if (OWN_HOUSE.equals("5")) {out.print("checked");}%>  >
      Yes</LABEL><BR>
    <LABEL>
      <INPUT type="radio" name="OWN_HOUSE" value="2"    <% if (OWN_HOUSE.equals("2")) {out.print("checked");}%>    >
     No</LABEL>
   
  </P> </TD>
  <TD colspan="3">    <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">4.</DIV></TD>
  <TD>Residing at the same address / location</TD>
  <TD><table cellspacing="0" cellpadding="0">
  <td height="25" width="172"><%= RESIDING_SAME_ADD %></td>
  </table></TD>
  <TD> <P>
    <LABEL>  <INPUT type="radio" name="RESIDING_SAME_ADD" value="5"     <% if (RESIDING_SAME_ADD.equals("5")) {out.print("checked");}%>   >  5 years and above</LABEL><BR>
   <LABEL>  <INPUT type="radio" name="RESIDING_SAME_ADD" value="3"      <% if (RESIDING_SAME_ADD.equals("3")) {out.print("checked");}%> >  2-5 years</LABEL><BR>
    <LABEL>  <INPUT type="radio" name="RESIDING_SAME_ADD" value="2"     <% if (RESIDING_SAME_ADD.equals("2")) {out.print("checked");}%> >  Less than 2 years</LABEL><BR>
  </P></TD>
  <TD colspan="3">      <DIV align="center">
    <P>5</P>
    <P>3</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">5.</DIV></TD>
  <TD>Academic qualification</TD>
  <TD><table cellspacing="0" cellpadding="0">
  <td height="20" width="172"><%= QUALIFICATION %></td>
  </table></TD>
  <TD><P>Applicant's Qualification : <%= EDU_DESC %></P>
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
  <TD><table cellspacing="0" cellpadding="0">
  <td height="25" width="172"><%= EXPERIENCE %></td>
  </table></TD>
  <TD> <P>
    <LABEL>  <INPUT type="radio" name="EXPERIENCE" value="8"  <% if (EXPERIENCE.equals("8")) {out.print("checked");}%> >  equal or more than 3 years</LABEL><BR>
    <LABEL>  <INPUT type="radio" name="EXPERIENCE" value="6"  <% if (EXPERIENCE.equals("6")) {out.print("checked");}%>>  1 to 3 years</LABEL><BR>
    <LABEL>  <INPUT type="radio" name="EXPERIENCE" value="3"  <% if (EXPERIENCE.equals("3")) {out.print("checked");}%>>  less than 1 year</LABEL><BR>
    <LABEL>  <INPUT type="radio" name="EXPERIENCE" value="0"  <% if (EXPERIENCE.equals("0")) {out.print("checked");}%>>  Nil</LABEL><BR>
  </P> </TD>
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
  <TD>&nbsp;</TD>
  <TD> <P>
    <LABEL>   <INPUT type="radio" name="ANY_O_SOI" value="5"   <% if (ANY_O_SOI.equals("5")) {out.print("checked");}%>> Yes</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="ANY_O_SOI" value="2"   <% if (ANY_O_SOI.equals("2")) {out.print("checked");}%>> No</LABEL>
  </P> </TD>
  <TD colspan="3">       <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">8.</DIV></TD>
  <TD>Assessed for Income Tax</TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="ASSESED_IT" value="2"     <% if (ASSESED_IT.equals("2")) {out.print("checked");}%>> Assessed</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="ASSESED_IT" value="1"     <% if (ASSESED_IT.equals("1")) {out.print("checked");}%>> Not Assessed</LABEL>
  </P> </TD>
  <TD colspan="3"> <DIV align="center">
    <P>2</P>
    <P>1</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">9.</DIV></TD>
  <TD>Having Life Insurance policy (PMSBY, PMJJBY, APY or any other insurance policy) </TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="LI_POLICY" value="0"  <% if (LI_POLICY.equals("0")) {out.print("checked");}%>> No Insurance</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="LI_POLICY" value="1"  <% if (LI_POLICY.equals("1")) {out.print("checked");}%>> 1 Insurance</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="LI_POLICY" value="2"  <% if (LI_POLICY.equals("2")) {out.print("checked");}%>> 2 Insurance</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="LI_POLICY" value="3"  <% if (LI_POLICY.equals("3")) {out.print("checked");}%>> more than 2 Insurance</LABEL>
  </P></TD>
  <TD colspan="3"><DIV align="center">
    <P>0</P>
    <P>1</P>
    <P>2</P>
    <P>3</P>
    </DIV></TD>
  </TR>
<TR>
  <TD>&nbsp;</TD>
  <TD><DIV align="center">MARKS SCORED </DIV></TD>
  <TD>&nbsp;</TD>
  <TD>&nbsp;</TD>
  <TD colspan="3">&nbsp;</TD>
  </TR>
<TR>
  <TH colspan="7"><DIV align="center">2. New Venture / Firm </DIV></TH>
  </TR>
<TR>
  <TD><DIV align="center">10.</DIV></TD>
  <TD>Relationship with lending bank ( Opening Date of Bank Account) (dd-mmm-yyyy) </TD>
  <TD>&nbsp;</TD>
  <TD><P>
  <LABEL>   
  <INPUT type="radio" name="RL_LENDING_BANK_MARK" id="radio1" value="1"  <% if (RL_LENDING_BANK_MARK.equals("1")) {out.print("checked");}%> onClick="enableTxtBox1()">New</LABEL>
  
   <LABEL>   
   <INPUT type="radio" name="RL_LENDING_BANK_MARK" id="radio2"   onClick="abcenableTxtBox1()">Already Existing</LABEL><BR>
  
    <LABEL>
<INPUT name="RELATION_W_LEND_BANK" type="text" id="RELATION_W_LEND_BANK" readonly="true" value="<%= RELATION_W_LEND_BANK %>"  onClick="javascript:NewCssCal('RELATION_W_LEND_BANK','ddMMMyyyy')" ></LABEL>
    <BR>
  </P>
 <P> Above 3 years </P>
 <P> 1 to 3 years </P>
 <P> less than 1 year </P>
 <P> New </P> </TD>
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
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="CREDIT_HISTORY" value="5"  <% if (CREDIT_HISTORY.equals("5")) {out.print("checked");}%>> Very Good</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="CREDIT_HISTORY" value="4"  <% if (CREDIT_HISTORY.equals("4")) {out.print("checked");}%>> Satisfactory</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="CREDIT_HISTORY" value="3"  <% if (CREDIT_HISTORY.equals("3")) {out.print("checked");}%>> No history</LABEL>
  </P></TD>
  <TD colspan="3"> <DIV align="center">
    <P>5</P>
    <P>4</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">12.</DIV></TD>
  <TD>Location Advantage (availability of infrastructure, raw materials, labour, proximity to markets etc.) </TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="LOCATION_ADV" value="5"  <% if (LOCATION_ADV.equals("5")) {out.print("checked");}%>> Yes</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="LOCATION_ADV" value="3"  <% if (LOCATION_ADV.equals("3")) {out.print("checked");}%>> No</LABEL>
  </P></TD>
  <TD colspan="3">         <DIV align="center">
    <P>5</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">13.</DIV></TD>
  <TD>Skill Certification Course / RSETI / ITS / Computer knowledge </TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="SKILL_CERTIFICATION" value="5"  <% if (SKILL_CERTIFICATION.equals("5")) {out.print("checked");}%>> Yes</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="SKILL_CERTIFICATION" value="2"  <% if (SKILL_CERTIFICATION.equals("2")) {out.print("checked");}%>> No</LABEL>
  </P></TD>
  <TD colspan="3"> <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">14.</DIV></TD>
  <TD>Marketing Tie ups for sale of products</TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="MARKETING_TU" value="5"  <% if (MARKETING_TU.equals("5")) {out.print("checked");}%>> Yes</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="MARKETING_TU" value="2"  <% if (MARKETING_TU.equals("2")) {out.print("checked");}%>> No</LABEL>
  </P></TD>
  <TD colspan="3">         <DIV align="center">
    <P>5</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">15.</DIV></TD>
  <TD>Line of Activity</TD>
  <TD>&nbsp;</TD>
  <TD><P>Applicant's Line of Activity : <%= IND_TYPE %></P>
    <P>Manufacturing / Service</P>
    <P>Trade and others  </P></TD>
  <TD colspan="3"> <P align="center">
    <LABEL></LABEL>
  </P>
    <P align="center">&nbsp;</P>
    <P align="center">5</P>
    <P align="center">3      <BR>
      </P></TD>
  </TR>
<TR>
  <TD><DIV align="center">16.</DIV></TD>
  <TD>Registered with Govt. Authorities viz for GST/ licence from local bodies / shop act etc. </TD>
  <TD>&nbsp;</TD>
  <TD> <P>
    <LABEL>   <INPUT type="radio" name="REG_GOV_AUTH" value="5"  <% if (REG_GOV_AUTH.equals("5")) {out.print("checked");}%>> Yes</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="REG_GOV_AUTH" value="3"  <% if (REG_GOV_AUTH.equals("3")) {out.print("checked");}%>> No</LABEL>
    </P></TD>
  <TD colspan="3">   <DIV align="center">
    <P>5</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">17.</DIV></TD>
  <TD>Repayment Period (not applicable for working capital loans) </TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="REPAY_PER" value="5"  <% if (REPAY_PER.equals("5")) {out.print("checked");}%>> Upto 5 years</LABEL><BR>
    <LABEL>   <INPUT type="radio" name="REPAY_PER" value="3"  <% if (REPAY_PER.equals("3")) {out.print("checked");}%>> Above 5 years</LABEL>
  </P></TD>
  <TD colspan="3"> <DIV align="center">
    <P>5</P>
    <P>3</P>
  </DIV></TD>
  </TR>
<TR>
  <TD><DIV align="center">18.</DIV></TD>
  <TD>Employment Generation</TD>
  <TD>&nbsp;</TD>
  <TD><P>Applicant's Employment Generation : <%= EMP_ENV %></P>
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
  <TD>Avg DSCR (not applicable for working capital loans) </TD>
  <TD>&nbsp;</TD>
  <TD><P>
    <LABEL>   <INPUT type="radio" name="AVG_DSCR" value="5"  <% if (AVG_DSCR.equals("5")) {out.print("checked");}%>> more than 2</LABEL> <BR>
    <LABEL>   <INPUT type="radio" name="AVG_DSCR" value="3"  <% if (AVG_DSCR.equals("3")) {out.print("checked");}%>> 1.5 to 2</LABEL> <BR>
    <LABEL>   <INPUT type="radio" name="AVG_DSCR" value="2"  <% if (AVG_DSCR.equals("2")) {out.print("checked");}%>> less than 1.5</LABEL>
  </P></TD>
  <TD colspan="3"><DIV align="center">
    <P>5</P>
    <P>3</P>
    <P>2</P>
  </DIV></TD>
  </TR>
<TR>
  <TD>&nbsp;</TD>
  <TD><DIV align="center">MARKS SCORED </DIV></TD>
  <TD>&nbsp;</TD>
  <TD>&nbsp;</TD>
  <TD colspan="3">&nbsp;</TD>
  </TR>
<TR HIDDEN>
  <TD colspan="7"><DIV align="center">** To be followed up and completed </DIV></TD>
  </TR>
<TR>
  <TH colspan="7"><DIV align="center">3. Security </DIV></TH>
  </TR>

<TR>
  <TD colspan="5"><DIV align="center"><strong>Coverd under CGTMSE/CGFMU/CGSSI : </strong>
  <INPUT type="radio"   name="COVERED_UNDER" id="COVERED_UNDER"   value="10"  <% if (COVERED_UNDER.equals("10")) {out.print("checked");}%>> Yes
  <INPUT type="radio"   name="COVERED_UNDER" id="COVERED_UNDER"   value="0"  <% if (COVERED_UNDER.equals("0")) {out.print("checked");}%>> No   </TD>
</TR>
<TR>
  <TD><DIV align="center">20.</DIV></TD>
  <TD><P>Collateral Security Coverage : Not covered under CGTMSE / CGFMU / CGSSI </P>
    <P>OR</P></TD>
  <TD>&nbsp;</TD>
  <TD>
  
    <LABEL>   <INPUT type="radio" id="COLLATERAL_SEC_COV" name="COLLATERAL_SEC_COV" value="10" <% if (COLLATERAL_SEC_COV.equals("10")) {out.print("checked");}%>> 100% & above </LABEL> <BR>
    <LABEL>   <INPUT type="radio" id="COLLATERAL_SEC_COV2" name="COLLATERAL_SEC_COV" value="8"  <% if (COLLATERAL_SEC_COV.equals("8")) {out.print("checked");}%>> 50% to < 100% </LABEL> <BR>
    <LABEL>   <INPUT type="radio" id="COLLATERAL_SEC_COV3" name="COLLATERAL_SEC_COV" value="6"  <% if (COLLATERAL_SEC_COV.equals("6")) {out.print("checked");}%>> Less than 50% </LABEL>
  </P>  </TD>
  <TD colspan="3"><DIV align="center">
    <P>10</P>
    <P>8</P>
    <P>6</P>
  </DIV></TD>
  </TR>

<TR>
  <TD><DIV align="center">21.</DIV></TD>
  <TD>Coverd under CGTMSE/CGFMU/CGSSI</TD>
  <TD>&nbsp;</TD>
  <TD>    </TD>
  <TD colspan="3"><DIV align="center">10</DIV></TD>
  </TR>
<TR>
  <TD>&nbsp;</TD>
  <TD><DIV align="center">MARKS SCORED </DIV></TD>
  <TD>&nbsp;</TD>
  <TD>&nbsp;</TD>
  <TD colspan="3">&nbsp;</TD>
  </TR>
<TR>
  <TD colspan="7"><DIV align="center"> <INPUT type="hidden" name="APP_AGREE_YN" value="Y" id="APP_AGREE_YN" >
   <INPUT type="checkbox" name="checkbox" value="check" class="largerCheckbox" id="checkbox" >
   <SPAN class="style6">    I hereby declare that the details furnished above are true and correct to the best of my knowledge and belief. In case any of the above information is found to be false or untrue or misleading or misrepresenting, I am aware that I may be held liable for it.</SPAN></DIV></TD>
</TR>
<TR>
  <TD colspan="7">
  <% if  (UPDATE_YN.equals("Y")) { %>
  <DIV align="center">
  <INPUT name="Button" type="button" class="myButton" onClick="submitform();" value="SAVE"/></DIV>
  <%} else {out.print ("Update not Allowed...") ; }%>  </TD>
</TR>
</TABLE>
<CENTER>
<BR/>
  

<%

if (ins.equals("I")) {
//APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
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
qryUpdate.append("APP_ID");


qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,?,?,?,?,  ?,?,?,? )");
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
qryUpdate.append("APP_AGREE_YN=?");
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
values.add(APP_ID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
response.sendRedirect("pmegpscorecard.jsp");
}
db.close();
%>

 

</FORM>
</BODY>
</HTML>