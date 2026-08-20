<%@ page session="true" buffer="30kb" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<SCRIPT language="javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript" src="js/Words.js"></SCRIPT>
<SCRIPT language="javascript">


function tot(){
	var ce=document.form.BNF_ATA.value;
	var we=document.form.BNF_ADA.value;
	var tcewe=Number(ce)+Number(we);
	document.form.FIN_AMT.value=tcewe;
	//alert(tcewe);
	}
	
 function isNumber(evt) {
   var BNF_ATA = (evt.which) ? evt.which : evt.keyCode
   var BNF_ADA = (evt.which) ? evt.which : evt.keyCode
	
		if (BNF_ATA != 46 && BNF_ATA > 31 && (BNF_ATA < 48 || BNF_ATA > 57))
		if (BNF_ADA != 46 && BNF_ADA > 31 && (BNF_ADA < 48 || BNF_ADA > 57))

        return false;
        return true;
    }   
	
function isNumberNoDec(evt)
      {
         var BNF_ASTFFCNTCT = (evt.which) ? evt.which : event.keyCode
		 var BNF_ATOURDYS = (evt.which) ? evt.which : event.keyCode
		 var BNF_ORG_CONTNO = (evt.which) ? evt.which : event.keyCode
		  var BNF_ORG_DAY = (evt.which) ? evt.which : event.keyCode
		 if (BNF_ASTFFCNTCT > 31 && (BNF_ASTFFCNTCT < 48 || BNF_ASTFFCNTCT > 57))
		 if (BNF_ATOURDYS > 31 && (BNF_ATOURDYS < 48 || BNF_ATOURDYS > 57))
		 if (BNF_ORG_CONTNO > 31 && (BNF_ORG_CONTNO < 48 || BNF_ORG_CONTNO > 57))
		  if (BNF_ORG_DAY > 31 && (BNF_ORG_DAY < 48 || BNF_ORG_DAY > 57))
		 return false;
         return true;
      }		

function submitform() {
 var numberOnly= /^[0-9 \.-]+$/;
var BNF_ASTFFNME=form.BNF_ASTFFNME.value;
var BNF_ASTFFDSGNTN=form.BNF_ASTFFDSGNTN.value;
var BNF_ASTFFCNTCT= document.form.BNF_ASTFFCNTCT.value;

var BNF_APROGDTLS= document.form.BNF_APROGDTLS.value;
var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;

var BNF_ORG_CONTNO= document.form.BNF_ORG_CONTNO.value;
var BNF_ORG_DAY= document.form.BNF_ORG_DAY.value;
var BNF_APLACE= document.form.BNF_APLACE.value;

var BNF_ACLBNAME = document.form.BNF_ACLBNAME.value;
var BNF_ATA = document.form.BNF_ATA.value;
var BNF_ADA = document.form.BNF_ADA.value;
var BNF_AGENCY = document.form.BNF_AGENCY.value;
var REMARK_ADD = document.form.REMARK_ADD.value;
var BNF_EVENT= document.form.BNF_EVENT.value;
var SAMT_BAL = document.form.SAMT_BAL.value;

var FIN_AMT = document.form.FIN_AMT.value;
/*
if (FIN_AMT>SAMT_BAL) {
			 inlineMsg('FIN_AMT',"Amount cannot be greater than balance",2);
            return (false);
			}
	*/		
			
if (BNF_EVENT == "") {
			 inlineMsg('BNF_EVENT',"Please enter event name.",2);
            return (false);
			}




if (BNF_ASTFFNME == "") {
			 inlineMsg('BNF_ASTFFNME',"Please enter staff name.",2);
            return (false);
			}



if (BNF_ASTFFDSGNTN == "") {
			 inlineMsg('BNF_ASTFFDSGNTN',"Please enter staff designation",2);
            return (false);
			}
			
if (BNF_ASTFFCNTCT == "") {
			 inlineMsg('BNF_ASTFFCNTCT',"Please enter staff contact no",2);
            return (false);
			}
			
if (!numberOnly.test(Number(BNF_ASTFFCNTCT))) {	 inlineMsg ( 'BNF_ASTFFCNTCT','Enter valid Contact No',2);	return (false);}			
			
						
	if (BNF_APLACE == "") {
			 inlineMsg('BNF_APLACE',"Please enter Place of Visit",2);
            return (false);
			}		
	
			
	if (BNF_APROGDTLS == "") {
			 inlineMsg('BNF_APROGDTLS',"Please enter Prgogramme Details",2);
            return (false);
			}			
			
			if (BNF_ATOURDYS == "") {
			 inlineMsg('BNF_ATOURDYS',"Please enter days",2);
            return (false);
			}	
		
			if (!numberOnly.test(Number(BNF_ATOURDYS))) {	 inlineMsg ( 'BNF_ATOURDYS','Enter valid No of Tour Days',2);	return (false);}	
			
	if (BNF_AGENCY == "") {
			 inlineMsg('BNF_AGENCY',"Please enter agency",2);
            return (false);
			}			
			

		if (BNF_ORG_DAY == "") {
			 inlineMsg('BNF_ORG_DAY',"Please enter No.Of days organized work done by Staff/Officer",2);
            return (false);
			}	


if (!numberOnly.test(Number(BNF_ORG_DAY))) {	 inlineMsg ( 'BNF_ORG_DAY','Enter valid  No.Of days organized work done by Staff/Officer',2);	return (false);}			
			
	if (BNF_ACLBNAME == "") {
			 inlineMsg('BNF_ACLBNAME',"Please enter name of the Organizer incharge name",2);
            return (false);
			}			
			
			if (BNF_ORG_CONTNO == "") {
			 inlineMsg('BNF_ORG_CONTNO',"Please enter Contact no of organizer",2);
            return (false);
			}	
			
			
		if (!numberOnly.test(Number(BNF_ORG_CONTNO))) {	 inlineMsg ( 'BNF_ORG_CONTNO','Enter valid  Contact No',2);	return (false);}			

			if (BNF_ATA == "") {
			 inlineMsg('BNF_ATA',"Please enter TA",2);
            return (false);
			}	

		if (!numberOnly.test(Number(BNF_ATA))) {	 inlineMsg ( 'BNF_ATA','Enter valid Amt',2);	return (false);}				
		
		if (BNF_ADA == "") {
			 inlineMsg('BNF_ADA',"Please enter DA",2);
            return (false);
			}	

		if (!numberOnly.test(Number(BNF_ADA))) {	 inlineMsg ( 'BNF_ADA','Enter valid Amt',2);	return (false);}				
			
		
form.Button.disabled = true;			
document.form.ins.value='I';
document.form.submit();
}
//KVKN17186442-3538845
</SCRIPT>

<STYLE type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</STYLE>

</HEAD>
<BODY>
<FORM  name="form" id="form" method="post" >


<%@ include file = "sessionoutincforeditform.jsp" %>
<%

List values=new ArrayList();

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String POFF_NAME1=SOFF_NAME1;
//String BNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID");
//String PBNF_DESC=request.getParameter("PBNF_DESC")==null?"":(String)request.getParameter("PBNF_DESC");
String OFF_CD = SOFF_CD;
String OFF_NAME1 = POFF_NAME1;
//String BUD_ID = request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");
//out.print(BUD_ID);
String BNF_TRID=session.getAttribute("PBNF_TRID")==null?"0":(String)session.getAttribute("PBNF_TRID");	
out.print(BNF_TRID);
String PBNF_DESC=session.getAttribute("PBNF_DESC")==null?"":(String)session.getAttribute("PBNF_DESC");
String BUD_ID=session.getAttribute("PBUD_ID")==null?"":(String)session.getAttribute("PBUD_ID");
//String FIN_AMT = "";
String BNF_EVENT="";
String PARTICIPANTS="";
//out.print(SAMT_BAL);
//out.print(FIN_AMT);




String BNF_ASTFFNME = "";
String BNF_ASTFFDSGNTN = "";
String BNF_ASTFFCNTCT = "";
String BNF_APLACE = "";
String BNF_APROGDTLS = "";
String BNF_ATOURDYS = "";
String BNF_AFROMDT = "";
String BNF_ATODT = "";
String BNF_TYPPUBLICITY = "";
String BNF_NOOFPARTCPNTS = "";
String BNF_ACLBNAME = "";
String BNF_ATA = "";
String BNF_ADA = "";
String BNF_AGENCY = "";
String REMARK_ADD = "";
String BNF_ATARGET = "";
String FIN_AMT="";
String BNF_HDID ="";
String YEAR_ID ="";
String BNF_SUB_HEAD_LONG_DESC="";

String BNF_ORG_CONTNO ="";
String BNF_ORG_DAY="";

String add_update="I";

DBCon db= new DBCon();
db.connect();


  //out.print (BNF_TRID+" "+OFF_CD);


if (!BNF_TRID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.BNF_TRID,BFT.BNF_ORG_CONTNO,BFT.BNF_ORG_DAY,"      );
qrysb.append("     BFT.OFF_CD, BFT.YEAR_ID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     BFT.BNF_ASTFFNME,"      );
qrysb.append("     BFT.BNF_ASTFFDSGNTN,"      );
qrysb.append("     BFT.BNF_ASTFFCNTCT,"      );
qrysb.append("     BFT.BNF_APLACE,"      );
qrysb.append("     BFT.BNF_APROGDTLS,"      );
qrysb.append("     BFT.BNF_ATOURDYS,"      );
qrysb.append("     BFT.BNF_TYPPUBLICITY,"      );
qrysb.append("     BFT.BNF_NOOFPARTCPNTS,BFT.BNF_EVENT,"      );
qrysb.append("     BFT.BNF_ACLBNAME,"      );
qrysb.append("      BFT.BNF_ADA, "      );
qrysb.append("     BFT.BNF_ATA , "      );
qrysb.append("     BFT.REMARK_ADD,"      );
qrysb.append("     BFT.BNF_AGENCY,NVL(CASE WHEN BFT.BNF_AGENCY='KV' THEN FIN_KVIC WHEN BFT.BNF_AGENCY='KB' THEN FIN_KVIB WHEN BFT.BNF_AGENCY='DI' THEN FIN_DIC END,0 ) AS FIN_AMT "      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE BFT.BNF_TRID = ?"      );
qrysb.append("   AND BFT.OFF_CD     = ?"      );

  values.add(BNF_TRID);
  values.add(OFF_CD);
 //out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

BNF_TRID=rsMain.getString("BNF_TRID")==null?"":rsMain.getString("BNF_TRID");
BUD_ID=rsMain.getString("BUD_ID")==null?"":rsMain.getString("BUD_ID");
//OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
BNF_ASTFFNME=rsMain.getString("BNF_ASTFFNME")==null?"":rsMain.getString("BNF_ASTFFNME");
BNF_ASTFFDSGNTN=rsMain.getString("BNF_ASTFFDSGNTN")==null?"":rsMain.getString("BNF_ASTFFDSGNTN");
BNF_ASTFFCNTCT=rsMain.getString("BNF_ASTFFCNTCT")==null?"":rsMain.getString("BNF_ASTFFCNTCT");
BNF_APLACE=rsMain.getString("BNF_APLACE")==null?"":rsMain.getString("BNF_APLACE");
BNF_APROGDTLS=rsMain.getString("BNF_APROGDTLS")==null?"":rsMain.getString("BNF_APROGDTLS");
BNF_ATOURDYS=rsMain.getString("BNF_ATOURDYS")==null?"":rsMain.getString("BNF_ATOURDYS");
BNF_TYPPUBLICITY=rsMain.getString("BNF_TYPPUBLICITY")==null?"":rsMain.getString("BNF_TYPPUBLICITY");
BNF_NOOFPARTCPNTS=rsMain.getString("BNF_NOOFPARTCPNTS")==null?"":rsMain.getString("BNF_NOOFPARTCPNTS");
BNF_ACLBNAME=rsMain.getString("BNF_ACLBNAME")==null?"":rsMain.getString("BNF_ACLBNAME");
BNF_ATA=rsMain.getString("BNF_ATA")==null?"":rsMain.getString("BNF_ATA");
BNF_ADA=rsMain.getString("BNF_ADA")==null?"":rsMain.getString("BNF_ADA");
REMARK_ADD=rsMain.getString("REMARK_ADD")==null?"":rsMain.getString("REMARK_ADD");
BNF_AGENCY=rsMain.getString("BNF_AGENCY")==null?"":rsMain.getString("BNF_AGENCY");
BNF_EVENT=rsMain.getString("BNF_EVENT")==null?"":rsMain.getString("BNF_EVENT");
FIN_AMT=rsMain.getString("FIN_AMT")==null?"":rsMain.getString("FIN_AMT");
BNF_ORG_DAY=rsMain.getString("BNF_ORG_DAY")==null?"":rsMain.getString("BNF_ORG_DAY");
BNF_ORG_CONTNO=rsMain.getString("BNF_ORG_CONTNO")==null?"":rsMain.getString("BNF_ORG_CONTNO");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");

add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>
<STRONG><H2><CENTER><%=PBNF_DESC%></CENTER></H2></STRONG>
<TABLE>
<TR>
  <TD colspan="2"><DIV align="center">Data Entry Form <%= sselect %> </DIV></TD>
  </TR>
<TR>
  <TD >Name of the Event under :  </TD>
  <TD><INPUT name="BNF_EVENT" type="text" id="BNF_EVENT" value="<%= BNF_EVENT%>" maxlength="50" AUTOCOMPLETE="off" PLACEHOLDER="Event name"></TD>
</TR>
<TR>
  <TD >Name of the staff : </TD>
  <TD><INPUT name="BNF_ASTFFNME" type="text" id="BNF_ASTFFNME" value="<%= BNF_ASTFFNME %>" maxlength="55" AUTOCOMPLETE="off" PLACEHOLDER="Staff name" />    </TD>
</TR><INPUT name="BNF_TRID" type="hidden" id="BNF_TRID" value=<%= BNF_TRID %>  />
<INPUT name="BUD_ID" type="hidden" id="BUD_ID" value=<%= BUD_ID %> />
<INPUT name="OFF_CD" type="hidden" id="OFF_CD" value=<%= OFF_CD %> />
<INPUT name="SAMT_BAL" type="hidden" id="SAMT_BAL" value=<%= SAMT_BAL %> />
<INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value=<%= sselect %> />
<TR>
  <TD>Designation of the Staff for TA/DA: </TD>
  <TD><INPUT name="BNF_ASTFFDSGNTN" type="text" id="BNF_ASTFFDSGNTN" value="<%= BNF_ASTFFDSGNTN %>" maxlength="50" AUTOCOMPLETE="off" PLACEHOLDER="Staff designation" /></TD>
</TR>
<TR>
  <TD> Contact no. : </TD> <INPUT name="ins" type="hidden" id="ins">
  <TD><INPUT name="BNF_ASTFFCNTCT" type="text" id="BNF_ASTFFCNTCT" value="<%= BNF_ASTFFCNTCT %>" maxlength="12" AUTOCOMPLETE="off" onKeyPress="return isNumberNoDec(event)" PLACEHOLDER="Contact no"></TD>
</TR>
<TR>
  <TD>Place of visit : </TD>
  <TD><INPUT name="BNF_APLACE" type="text" id="BNF_APLACE" value="<%= BNF_APLACE %>" maxlength="20" PLACEHOLDER="Visit place"></TD>
</TR>

<TR>
  <TD>Programme detail : </TD>
  <TD><INPUT name="BNF_APROGDTLS" type="text" id="BNF_APROGDTLS" value="<%= BNF_APROGDTLS %>" maxlength="100" AUTOCOMPLETE="off" PLACEHOLDER="Programme detail" ></TD>
</TR>
<TR>
  <TD>Tour sanctioned for No. of days : </TD>
  <TD><INPUT name="BNF_ATOURDYS" type="text" id="BNF_ATOURDYS" value="<%= BNF_ATOURDYS %>" maxlength="4" AUTOCOMPLETE="off" onKeyPress="return isNumberNoDec(event)" PLACEHOLDER="Tour sanctioned for No. of days"></TD>
  </TR>
<TR>
  <TD>Organized By Agency KVIC/KVIB/DIC: </TD>
  <TD><SELECT name="BNF_AGENCY" class="button" id="BNF_AGENCY" >
      <OPTION value ="-1" >--Select Agency --</OPTION>
      <OPTION value="KV" <% if (BNF_AGENCY.equals("KV")){out.print("selected");}%>>KVIC</OPTION>
      <OPTION value="KB" <% if (BNF_AGENCY.equals("KB")){out.print("selected");}%>>KVIB</OPTION>
      <OPTION value="DI" <% if (BNF_AGENCY.equals("DI")){out.print("selected");}%>>DIC</OPTION>
    </SELECT>
  </TD>
</TR>
<TR>
  <TD>No.Of days organized work done by Staff/Officer </TD>
  <TD><INPUT name="BNF_ORG_DAY" type="text" id="BNF_ORG_DAY"  value="<%= BNF_ORG_DAY%>" maxlength="4" AUTOCOMPLETE="off" onKeyPress="return isNumberNoDec(event)" PLACEHOLDER="No.of days work done" ></TD>
  </TR>
<TR>
  <TD>Organizer Co. Incharge Name: </TD>
  <TD><INPUT name="BNF_ACLBNAME" type="text" id="BNF_ACLBNAME" value="<%= BNF_ACLBNAME %>" maxlength="50" AUTOCOMPLETE="off" PLACEHOLDER="Incharge Name">    </TD>
  </TR>
<TR>
  <TD>Organizer Contact No</TD>
  <TD><INPUT name="BNF_ORG_CONTNO" type="text" id="BNF_ORG_CONTNO" value="<%= BNF_ORG_CONTNO%>" maxlength="12" AUTOCOMPLETE="off" onKeyPress="return isNumberNoDec(event)"PLACEHOLDER="Contact No"></TD>
</TR>
<TR>
  <TD>Expenditure incurred on TA (Amount in Rs only): </TD>
  <TD><INPUT name="BNF_ATA" AUTOCOMPLETE="off" type="text" id="BNF_ATA" value="<%= BNF_ATA %>" onChange="tot();" onKeyPress="javascript:return isNumber(event)" PLACEHOLDER="Expenditure (TA)"></TD>
</TR>
<TR>
  <TD>Expenditure incurred on DA (Amount in Rs only): </TD>
  <TD><INPUT name="BNF_ADA" type="text" id="BNF_ADA" value="<%= BNF_ADA %>" AUTOCOMPLETE="off" onChange="tot();" onKeyPress="javascript:return isNumber(event)" PLACEHOLDER="Expenditure (DA)" >
  </TD>
</TR>
<TR>
  <TD>Total Expenditure incurred on TA/DA:</TD>
  <TD><INPUT name="FIN_AMT" type="text" id="FIN_AMT" value="<%=FIN_AMT%>"  readonly="true" PLACEHOLDER="Total(TA/DA)" onKeyUp="word.innerHTML=convertNumberToWords(this.value)"></TD>
</TR>
<TR>
  <TD></TD>
  <TD><DIV id="word"></DIV></TD>
</TR>

<TR>
  <TD>Remark : </TD>
  <TD><INPUT name="REMARK_ADD" type="text" id="REMARK_ADD" value="<%= REMARK_ADD %>" maxlength="95" AUTOCOMPLETE="off" PLACEHOLDER="Remark"></TD>
</TR>

 
</TABLE>
<BR/>
<DIV align="center">
  <INPUT name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
</DIV>
<%
//out.print (ins);
if (ins.equals("I")) {

BNF_TRID=(String) request.getParameter("BNF_TRID")==null?"0":(String) request.getParameter("BNF_TRID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
BUD_ID=(String) request.getParameter("BUD_ID")==null?"":(String) request.getParameter("BUD_ID").trim();
YEAR_ID=(String) request.getParameter("YEAR_ID")==null?"":(String) request.getParameter("YEAR_ID").trim();
BNF_ASTFFNME=(String) request.getParameter("BNF_ASTFFNME")==null?"":(String) request.getParameter("BNF_ASTFFNME").trim();
BNF_ASTFFDSGNTN=(String) request.getParameter("BNF_ASTFFDSGNTN")==null?"":(String) request.getParameter("BNF_ASTFFDSGNTN").trim();
BNF_ASTFFCNTCT=(String) request.getParameter("BNF_ASTFFCNTCT")==null?"":(String) request.getParameter("BNF_ASTFFCNTCT").trim();
BNF_APLACE=(String) request.getParameter("BNF_APLACE")==null?"":(String) request.getParameter("BNF_APLACE").trim();
BNF_APROGDTLS=(String) request.getParameter("BNF_APROGDTLS")==null?"":(String) request.getParameter("BNF_APROGDTLS").trim();
BNF_ATOURDYS=(String) request.getParameter("BNF_ATOURDYS")==null?"":(String) request.getParameter("BNF_ATOURDYS").trim();
BNF_NOOFPARTCPNTS=(String) request.getParameter("BNF_NOOFPARTCPNTS")==null?"":(String) request.getParameter("BNF_NOOFPARTCPNTS").trim();
BNF_ACLBNAME=(String) request.getParameter("BNF_ACLBNAME")==null?"":(String) request.getParameter("BNF_ACLBNAME").trim();
BNF_ATA=(String) request.getParameter("BNF_ATA")==null?"":(String) request.getParameter("BNF_ATA").trim();
BNF_ADA=(String) request.getParameter("BNF_ADA")==null?"":(String) request.getParameter("BNF_ADA").trim();
BNF_AGENCY=(String) request.getParameter("BNF_AGENCY")==null?"":(String) request.getParameter("BNF_AGENCY").trim();
REMARK_ADD=(String) request.getParameter("REMARK_ADD")==null?"":(String) request.getParameter("REMARK_ADD").trim();
BNF_EVENT=(String) request.getParameter("BNF_EVENT")==null?"":(String) request.getParameter("BNF_EVENT").trim();
PARTICIPANTS=(String) request.getParameter("PARTICIPANTS")==null?"1":(String) request.getParameter("PARTICIPANTS").trim();
BNF_ORG_DAY=(String) request.getParameter("BNF_ORG_DAY")==null?"":(String) request.getParameter("BNF_ORG_DAY").trim();
BNF_ORG_CONTNO=(String) request.getParameter("BNF_ORG_CONTNO")==null?"":(String) request.getParameter("BNF_ORG_CONTNO").trim();



int BNF_ATA_I=Integer.parseInt(BNF_ATA);  
int BNF_ADA_I=Integer.parseInt(BNF_ADA);  
int FIN_TOTAL=BNF_ATA_I+BNF_ADA_I;
 FIN_AMT=String.valueOf(FIN_TOTAL);
//out.print(BNF_TRID);
//out.print(OFF_CD);
out.print(FIN_AMT);

		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		if (add_update.equals("I")) {
		
String maxId="SELECT NVL(MAX(BNF_TRID),0)+1 AS BNF_TRID FROM BNF_FO_TRANS" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
BNF_TRID=rsMax.getString("BNF_TRID")==null?"":rsMax.getString("BNF_TRID");
}


rsMax.close();

try{
if (BNF_AGENCY.equals("KV")){
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_EVENT,");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("PH_KVIC,");//7
qryUpdate.append("BNF_ORG_DAY,");//7
qryUpdate.append("BNF_ORG_CONTNO,");//7

qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("BNF_ATA,");
qryUpdate.append("TR_DATE,");//12

qryUpdate.append("BNF_ADA,");
qryUpdate.append("FIN_KVIC,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD, YEAR_ID, OFF_CD,BUD_ID,BNF_TRID");//19
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?, ?,?,?,?,SYSDATE,?,?,?,?,?,?,?,?)");
}
if (BNF_AGENCY.equals("KB")){
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_EVENT,");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("PH_KVIB,");//7
qryUpdate.append("BNF_ORG_DAY,");//7
qryUpdate.append("BNF_ORG_CONTNO,");//7

qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("BNF_ATA,");
qryUpdate.append("TR_DATE,");//12

qryUpdate.append("BNF_ADA,");
qryUpdate.append("FIN_KVIB,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD, YEAR_ID,OFF_CD,BUD_ID,BNF_TRID");//19
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?, ?,?,?,?,SYSDATE, ?,?,?,?,?,?,?,?)");
}

if (BNF_AGENCY.equals("DI")){
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_EVENT,");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("PH_DIC,");
qryUpdate.append("BNF_ORG_DAY,");//7
qryUpdate.append("BNF_ORG_CONTNO,");//7

qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("BNF_ATA,");
qryUpdate.append("TR_DATE,");

qryUpdate.append("BNF_ADA,");
qryUpdate.append("FIN_DIC,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD,YEAR_ID,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,? ,?,?,?,?,SYSDATE,?,?,?,?,?,?,?,?)");
}
		}catch(Exception e){
out.print(e.toString());
}	
		
		
		}
		else{
	try{
if(BNF_AGENCY.equals("KV")){
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_EVENT=?,");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("PH_KVIC=?,");
qryUpdate.append("PH_KVIB=0,");
qryUpdate.append("PH_DIC=0,");

qryUpdate.append("BNF_ORG_DAY=?,");//7
qryUpdate.append("BNF_ORG_CONTNO=?,");//7


qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("BNF_ATA=?,");
qryUpdate.append("TR_DATE=SYSDATE,");

qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("FIN_KVIC=?,");
qryUpdate.append("FIN_KVIB=0,");
qryUpdate.append("FIN_DIC=0,");

qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?,");
qryUpdate.append("YEAR_ID=?");
qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

}
		
if(BNF_AGENCY.equals("KB")){

qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_EVENT=?,");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("PH_KVIB=?,");
qryUpdate.append("PH_KVIC=0,");
qryUpdate.append("PH_DIC=0,");

qryUpdate.append("BNF_ORG_DAY=?,");//7
qryUpdate.append("BNF_ORG_CONTNO=?,");//7

qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("BNF_ATA=?,");
qryUpdate.append("TR_DATE=SYSDATE,");

qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("FIN_KVIB=?,");
qryUpdate.append("FIN_KVIC=0,");
qryUpdate.append("FIN_DIC=0,");

qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?,");
qryUpdate.append("YEAR_ID=?");
qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

}
if(BNF_AGENCY.equals("DI")){
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_EVENT=?,");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("PH_DIC=?,");
qryUpdate.append("PH_KVIC=0,");
qryUpdate.append("PH_KVIB=0,");

qryUpdate.append("BNF_ORG_DAY=?,");//7
qryUpdate.append("BNF_ORG_CONTNO=?,");//7


qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("BNF_ATA=?,");
qryUpdate.append("TR_DATE=SYSDATE,");

qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("FIN_DIC=?,");
qryUpdate.append("FIN_KVIC=0,");
qryUpdate.append("FIN_KVIB=0,");

qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?,");
qryUpdate.append("YEAR_ID=?");
qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

}
}	
	catch(Exception e){
out.print(e.toString());
}}		
		
		
		
		
		
		

//out.print (qryUpdate.toString());

values.add(BNF_EVENT); pstm.add ("L");
values.add(BNF_ASTFFNME); pstm.add ("L");
values.add(BNF_ASTFFDSGNTN); pstm.add ("L");
values.add(BNF_ASTFFCNTCT); pstm.add ("L");
values.add(BNF_APLACE); pstm.add ("L");
values.add(BNF_APROGDTLS); pstm.add ("L");
values.add(PARTICIPANTS); pstm.add ("L");

values.add(BNF_ORG_DAY); pstm.add ("L");
values.add(BNF_ORG_CONTNO); pstm.add ("L");

values.add(BNF_ATOURDYS); pstm.add ("L");
values.add(BNF_NOOFPARTCPNTS); pstm.add ("L");
values.add(BNF_ACLBNAME); pstm.add ("L");

values.add(BNF_ATA); pstm.add ("L");
values.add(BNF_ADA); pstm.add ("L");
values.add(FIN_AMT); pstm.add ("L");

values.add(BNF_AGENCY); pstm.add ("L");
values.add(REMARK_ADD); pstm.add ("L");
values.add(YEAR_ID); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");

values.add(BUD_ID); pstm.add ("L");
values.add(BNF_TRID); pstm.add ("L");
		

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();

response.sendRedirect("savemsg.jsp");
}

%>


</FORM>
</BODY>
</HTML>