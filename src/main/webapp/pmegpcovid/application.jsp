<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<META name="viewport" content="width=device-width, initial-scale=1">
<HEAD>
<TITLE></TITLE>
<LINK rel="stylesheet" type="text/css" href="css/main1.css">

<SCRIPT src="js/sweetalert.min.js"></SCRIPT>


<SCRIPT>

function submitform1() {


var APP_NAME = document.form.APP_NAME.value;
var UNIT_NAME = document.form.UNIT_NAME.value;
var MOB_NO = document.form.MOB_NO.value;
var E_MAIL = document.form.E_MAIL.value;
var APP_POST_ADDR = document.form.APP_POST_ADDR.value;
var STATE_CD = document.form.STATE_CD.value;
var PINCODE = document.form.PINCODE.value;


if(APP_NAME==""){
 swal ( 'Note:','Please Enter PMEGP Beneficiary Name.','error');	
 return (false);
}

if(UNIT_NAME==""){
 swal ( 'Note:','Please Enter Unit Name.','error');	
 return (false);
}

if(MOB_NO==""){
 swal ( 'Note:','Please Enter Mobile No.','error');	
 return (false);
}

if(E_MAIL==""){
 swal ( 'Note:','Please Enter Email Id','error');	
 return (false);
}

if(APP_POST_ADDR==""){
 swal ( 'Note:','Please Enter Applicant Post Address','error');	
 return (false);
}

if(STATE_CD==""){
 swal ( 'Note:','Please Select State Name','error');	
 return (false);
}

if(PINCODE==""){
 swal ( 'Note:','Please Enter Pincode','error');	
 return (false);
}

								
document.form.ins.value='I';
document.form.submit();
}


		
</SCRIPT>


</HEAD>

<BODY>


<FORM  name="form" id="form" method="post" >
<IMG src="images/04_01.png" width="100%" alt="img">
<BR>
<BR>

<%

List values=new ArrayList();

String COVDONID="";
String APP_ID="";
String APP_PRIX="";
String APP_NAME="";
String UNIT_NAME="";
String MOB_NO="";
String E_MAIL="";
String APP_POST_ADDR="";
String PINCODE="";
String STATE_CD="";
String BEN_TP="";
String OT_PMEGP="";

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

DBCon db= new DBCon();
db.connect();

%>
  <INPUT name="ins" type="hidden" id="ins" >

<%

if (ins.equals("I")) {

COVDONID=(String) request.getParameter("COVDONID")==null?"":(String) request.getParameter("COVDONID").trim();
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
UNIT_NAME=(String) request.getParameter("UNIT_NAME")==null?"":(String) request.getParameter("UNIT_NAME").trim();
MOB_NO=(String) request.getParameter("MOB_NO")==null?"":(String) request.getParameter("MOB_NO").trim();
E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();
APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
PINCODE=(String) request.getParameter("PINCODE")==null?"":(String) request.getParameter("PINCODE").trim();
STATE_CD=(String) request.getParameter("STATE_CD")==null?"":(String) request.getParameter("STATE_CD").trim();
BEN_TP=(String) request.getParameter("BEN_TP")==null?"":(String) request.getParameter("BEN_TP").trim();
OT_PMEGP=(String) request.getParameter("OT_PMEGP")==null?"":(String) request.getParameter("OT_PMEGP").trim();

List pstm=new ArrayList();
StringBuffer qryUpdate = new StringBuffer();
values.clear();
pstm.clear();
	
		
String maxId="SELECT NVL(MAX(COVDONID),0)+1 AS COVDONID FROM ACOVID_DONATION_TRANS" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
COVDONID=rsMax.getString("COVDONID")==null?"":rsMax.getString("COVDONID");
}

rsMax.close();

qryUpdate.append("INSERT INTO ACOVID_DONATION_TRANS ( ");

qryUpdate.append("COVDONID,");
qryUpdate.append("APP_ID,");
qryUpdate.append("APP_PRIX,");
qryUpdate.append("APP_NAME,");
qryUpdate.append("UNIT_NAME,");
qryUpdate.append("MOB_NO,");
qryUpdate.append("E_MAIL,");
qryUpdate.append("APP_POST_ADDR,");
qryUpdate.append("PINCODE,");
qryUpdate.append("STATE_CD,");
qryUpdate.append("BEN_TP,");
qryUpdate.append("OT_PMEGP");

qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");

values.add(COVDONID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(UNIT_NAME); pstm.add ("L");
values.add(MOB_NO); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");
values.add(APP_POST_ADDR); pstm.add ("L");
values.add(PINCODE); pstm.add ("L");
values.add(STATE_CD); pstm.add ("L");
values.add(BEN_TP); pstm.add ("L");
values.add(OT_PMEGP); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
response.sendRedirect("index.jsp");

}

%>




<CENTER>

<TABLE border="1" id="customers" >
  <TR>
    <TH colspan="2">Download Appeal </TH>
  </TR>
  <TR>
    <TH colspan="2"><DIV align="center">PMEGP BENEFICIARY COVID19 DONATION FORM </DIV></TH>
    </TR>
  <TR>
    <TD colspan="2"><DIV align="center">All (*) marked fields are mandatory </DIV></TD>
    </TR>
  
  <TR>
    <TD>Select Title 
	<INPUT name="BEN_TP" type="hidden" id="BEN_TP" value="PMEGP"  autocomplete="off"  maxlength="4">	</TD>
    <TD width="77%">
	
	<SELECT name="APP_PRIX" id="APP_PRIX">
      <OPTION value="">Select Title</OPTION>
      <OPTION value="Mr">Mr</OPTION>
      <OPTION value="Mrs">Mrs</OPTION>
      <OPTION value="Ms">Ms</OPTION>
      <OPTION value="M/S">M/S</OPTION>
    </SELECT></TD>
    </TR>
  <TR>
    <TD width="23%">PMEGP Beneficiary Name * </TD>
    <TD><INPUT name="APP_NAME" type="text" id="APP_NAME" value="<%= APP_NAME%>"  autocomplete="off" PLACEHOLDER="PMEGP Beneficiary Name" maxlength="50"></TD>
    </TR>
  
  <TR>
    <TD>Applicant ID</TD>
    <TD><INPUT name="APP_ID" type="text" id="APP_ID" value="<%= APP_ID%>"  autocomplete="off" PLACEHOLDER="Applicant ID" maxlength="20"></TD>
    </TR>
  
  <TR>
    <TD>Unit Name * </TD>
    <TD><INPUT name="UNIT_NAME" type="text" id="UNIT_NAME" value="<%= UNIT_NAME%>"  autocomplete="off" PLACEHOLDER="Unit Name" maxlength="100"></TD>
    </TR>
  <TR>
    <TD>Mobile No * </TD>
    <TD><INPUT name="MOB_NO" type="text" id="MOB_NO" value="<%= MOB_NO%>"  autocomplete="off" PLACEHOLDER="Mobile No" maxlength="10"></TD>
    </TR>
  <TR>
    <TD>Email Id * </TD>
    <TD><INPUT name="E_MAIL" type="text" id="E_MAIL" value="<%= E_MAIL%>"  autocomplete="off" PLACEHOLDER="Email Id" maxlength="60"></TD>
  </TR>
  <TR>
    <TD>Address * </TD>
    <TD><INPUT name="APP_POST_ADDR" type="text" id="APP_POST_ADDR" value="<%= APP_POST_ADDR%>"  autocomplete="off" PLACEHOLDER="Address" maxlength="300"></TD>
  </TR>
  <TR>
    <TD>State Name * </TD>
    <TD><SELECT name="STATE_CD" id="STATE_CD" >
      <OPTION value="">----Select----</OPTION>
      <%
	String STATE_CD_D1="";
	String STATE_NM_D1="";
	ResultSet staters1 =db.execSQL("SELECT STAT.STATE_CD,STAT.STATE_NM FROM MAS.M_STATE STAT");
	while (staters1.next()) {
STATE_CD_D1=staters1.getString(1);
STATE_NM_D1=staters1.getString(2);
	%>
      <OPTION value="<%= STATE_CD_D1 %>" ><%= STATE_NM_D1 %></OPTION>
      <%  }  staters1.close();//while close  
	   %>
    </SELECT></TD>
    </TR>
  <TR>
    <TD>Pincode * </TD>
    <TD><INPUT name="PINCODE" type="text" id="PINCODE" value="<%= PINCODE%>"  autocomplete="off" PLACEHOLDER="Pincode" maxlength="6"></TD>
    </TR>
  <TR>
    <TD>Amount: </TD>
    <TD>Rs.500 (Five Hunder only) </TD>
  </TR>
  <TR>
    <TD>Capcha</TD>
    <TD>Capcha text </TD>
  </TR>
  <TR>
    <TD colspan="2"><DIV align="center">
      <INPUT type="checkbox" name="checkbox" value="checkbox">
      I agree to donate Rs.500 ( Rupees Five Hundered Only) For COVID Victims </DIV></TD>
  </TR>
  <TR>
    <TD colspan="2"> <DIV align="center"><INPUT type="reset" class="myButtonred">    <A onClick="submitform1();" class="myButton">Proceed For Payment</A></DIV></TD>
    </TR>
  </TABLE>


</CENTER>

<%
	   db.close();
%>
</FORM>
</BODY>
</HTML>
