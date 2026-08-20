<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<SCRIPT language="javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript" src="js/Words.js"></SCRIPT>
<SCRIPT type="text/javascript" src="js/datetimepicker_css.js"></SCRIPT>
<SCRIPT language="javascript">
/*
function days_between(date1, date2) {
	
	

    // The number of milliseconds in one day
    var ONE_DAY = 1000 * 60 * 60 * 24

    // Convert both dates to milliseconds
    var date1_ms = date1.getTime()
    var date2_ms = date2.getTime()

    // Calculate the difference in milliseconds
    var difference_ms = Math.abs(date1_ms - date2_ms)

    // Convert back to days and return
    return Math.round(difference_ms/ONE_DAY)

}*/


function days(){
//var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;
var BNF_AFROMDT = document.form.BNF_AFROMDT.value;

var BNF_ATODT = document.form.BNF_ATODT.value;

var today = new Date();


	

if (BNF_AFROMDT == "") {
			 inlineMsg('BNF_AFROMDT',"Please select From Date.",2);
            return (false);
			}
			
	

var startDate = Date.parse(BNF_AFROMDT);
var endDate = Date.parse(BNF_ATODT );			
	
	if(startDate > endDate )
	{
	inlineMsg('BNF_AFROMDT',"Please select correct Date.",2);
            return (false);	
	}		
			
            var timeDiff = endDate - startDate;
            daysDiff = Math.floor((timeDiff / (1000 * 60 * 60 * 24))+1);
            document.form.BNF_ATOURDYS.value=daysDiff;
}



function isNumberNoDec(evt)
      {
         var BNF_ASTFFCNTCT = (evt.which) ? evt.which : event.keyCode
	
		 if (BNF_ASTFFCNTCT > 31 && (BNF_ASTFFCNTCT < 48 || BNF_ASTFFCNTCT > 57))
	
		 return false;
         return true;
      }		
	  
 function isNumber(evt) {
   var BNF_ATA = (evt.which) ? evt.which : evt.keyCode
	
		if (BNF_ATA != 46 && BNF_ATA > 31 && (BNF_ATA < 48 || BNF_ATA > 57))

        return false;
        return true;
    }   
	
function submitform() {
var	BNF_EVENT=form.BNF_EVENT.value;
var BNF_ASTFFNME=form.BNF_ASTFFNME.value;
//var BNF_ASTFFDSGNTN=form.BNF_ASTFFDSGNTN.value;
var BNF_ASTFFCNTCT= document.form.BNF_ASTFFCNTCT.value;
var BNF_APLACE= document.form.BNF_APLACE.value;
var BNF_APROGDTLS= document.form.BNF_APROGDTLS.value;
var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;
var BNF_AFROMDT = document.form.BNF_AFROMDT.value;
var BNF_ATODT = document.form.BNF_ATODT.value;
var BNF_TYPPUBLICITY = document.form.BNF_TYPPUBLICITY.value;
//var BNF_NOOFPARTCPNTS = document.form.BNF_NOOFPARTCPNTS.value;
//var BNF_ACLBNAME = document.form.BNF_ACLBNAME.value;
var BNF_ATA = document.form.BNF_ATA.value;
//var BNF_ADA = document.form.BNF_ADA.value;
var BNF_AGENCY = document.form.BNF_AGENCY.value;
var REMARK_ADD = document.form.REMARK_ADD.value;
/*
var SAMT_BAL = document.form.SAMT_BAL.value;

if (BNF_ATA>SAMT_BAL) {
			 inlineMsg('BNF_ATA',"Amount cannot be greater than balance",2);
            return (false);
			}
*/
if (BNF_EVENT == "") {
			 inlineMsg('BNF_EVENT',"Please enter name of the publicity .",2);
            return (false);
			}
if (BNF_TYPPUBLICITY == "") {
			 inlineMsg('BNF_TYPPUBLICITY',"Please enter type of publicity.",2);
            return (false);
			}

if (BNF_ASTFFNME == "") {
			 inlineMsg('BNF_ASTFFNME',"Please enter staff name.",2);
            return (false);
			}

			
if (BNF_ASTFFCNTCT == "") {
			 inlineMsg('BNF_ASTFFCNTCT',"Please enter staff contact no",2);
            return (false);
			}
						
			
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
			
			
		
			if (BNF_AFROMDT == "") {
			 inlineMsg('BNF_AFROMDT',"Please select from date",2);
            return (false);
			}		
			
			if (BNF_ATODT == "") {
			 inlineMsg('BNF_ATODT',"Please select to date",2);
            return (false);
			}
			
	if (BNF_AGENCY == "") {
			 inlineMsg('BNF_AGENCY',"Please enter agency",2);
            return (false);
			}			
			
					
			
	
			
		
			if (BNF_ATA == "") {
			 inlineMsg('BNF_ATA',"Please enter TA",2);
            return (false);
			}	

							
			
		
form.Button.disabled = true;				
document.form.ins.value='I';
document.form.submit();
}

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
//out.print(BNF_TRID);
String PBNF_DESC=session.getAttribute("PBNF_DESC")==null?"":(String)session.getAttribute("PBNF_DESC");
String BUD_ID=session.getAttribute("PBUD_ID")==null?"":(String)session.getAttribute("PBUD_ID");
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
String BNF_EVENT="";
String BNF_HDID ="";
String BNF_SUB_HEAD_LONG_DESC="";
String YEAR_ID="";
String add_update="I";

DBCon db= new DBCon();
db.connect();


  //out.print (BNF_TRID+" "+OFF_CD);


if (!BNF_TRID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.BNF_TRID,"      );
qrysb.append("     BFT.OFF_CD,BFT.BNF_EVENT,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     BFT.BNF_ASTFFNME,"      );
qrysb.append("     BFT.BNF_ASTFFDSGNTN,"      );
qrysb.append("     BFT.BNF_ASTFFCNTCT,"      );
qrysb.append("     BFT.BNF_APLACE,"      );
qrysb.append("     BFT.BNF_APROGDTLS,"      );
qrysb.append("     BFT.BNF_ATOURDYS,"      );
qrysb.append("     TO_CHAR(BFT.BNF_AFROMDT,'DD-MON-RRRR') AS BNF_AFROMDT,"      );
qrysb.append("     TO_CHAR(BFT.BNF_ATODT,'DD-MON-RRRR') AS BNF_ATODT, "      );
qrysb.append("     BFT.BNF_TYPPUBLICITY,"      );
qrysb.append("     BFT.BNF_NOOFPARTCPNTS,"      );
qrysb.append("     BFT.BNF_ACLBNAME,"      );
qrysb.append("      CASE WHEN BFT.BNF_AGENCY='KB'  THEN FIN_KVIB  WHEN BFT.BNF_AGENCY='KV'  "      );
qrysb.append("      THEN FIN_KVIC  WHEN BFT.BNF_AGENCY='DI'  THEN FIN_DIC END AS BNF_ATA , "      );
qrysb.append("     BFT.REMARK_ADD,"      );
qrysb.append("     BFT.BNF_AGENCY, BFT.YEAR_ID"      );
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
BNF_AFROMDT=rsMain.getString("BNF_AFROMDT")==null?"":rsMain.getString("BNF_AFROMDT");
BNF_ATODT=rsMain.getString("BNF_ATODT")==null?"":rsMain.getString("BNF_ATODT");
BNF_TYPPUBLICITY=rsMain.getString("BNF_TYPPUBLICITY")==null?"":rsMain.getString("BNF_TYPPUBLICITY");
BNF_NOOFPARTCPNTS=rsMain.getString("BNF_NOOFPARTCPNTS")==null?"":rsMain.getString("BNF_NOOFPARTCPNTS");
BNF_ACLBNAME=rsMain.getString("BNF_ACLBNAME")==null?"":rsMain.getString("BNF_ACLBNAME");
BNF_ATA=rsMain.getString("BNF_ATA")==null?"":rsMain.getString("BNF_ATA");
REMARK_ADD=rsMain.getString("REMARK_ADD")==null?"":rsMain.getString("REMARK_ADD");
BNF_AGENCY=rsMain.getString("BNF_AGENCY")==null?"":rsMain.getString("BNF_AGENCY");
BNF_EVENT=rsMain.getString("BNF_EVENT")==null?"":rsMain.getString("BNF_EVENT");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");

add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>
<STRONG><H2><CENTER><%=PBNF_DESC%> (Data Entry Form <%= sselect %> ) 
</CENTER></H2></STRONG>
<TABLE>


<TR>
  <TD >Name of the Event under </TD>
  <TD><INPUT name="BNF_EVENT" type="text" id="BNF_EVENT" value="<%= BNF_EVENT%>" maxlength="50" AUTOCOMPLETE="off" PLACEHOLDER="Event name"></TD>
</TR>
<TR>
  <TD >Type Of Publicity : </TD>
  <TD><INPUT name="BNF_TYPPUBLICITY" type="text" id="BNF_TYPPUBLICITY" value="<%= BNF_TYPPUBLICITY %>" maxlength="50" AUTOCOMPLETE="off" PLACEHOLDER="Publicity Type">   </TD>
</TR>
<TR>
  <TD> Organized From :</TD>
  <TD><INPUT name="BNF_AFROMDT" type="text" id="BNF_AFROMDT" onClick="javascript:NewCssCal('BNF_AFROMDT','ddMMMyyyy')" value="<%= BNF_AFROMDT %>" maxlength="11" readonly="true" PLACEHOLDER="Organized from" AUTOCOMPLETE="off" >
  </TD>
</TR>
<TR>
  <TD> Organized To :</TD>
  <TD><INPUT name="BNF_ATODT" type="text" id="BNF_ATODT" onChange="days();" onClick="javascript:NewCssCal('BNF_ATODT','ddMMMyyyy')" value="<%= BNF_ATODT %>" maxlength="11" readonly="true" AUTOCOMPLETE="off" PLACEHOLDER="Organized to" ></TD>
</TR>
<TR>
  <TD> No. of days  was organized: </TD>
  <TD><INPUT name="BNF_ATOURDYS" type="text" id="BNF_ATOURDYS" value="<%= BNF_ATOURDYS %>" maxlength="4" readonly="true" AUTOCOMPLETE="off"  PLACEHOLDER="Days Organized"></TD>
</TR>
<TR>
  <TD>Name of the Place: </TD>
  <TD><INPUT name="BNF_APLACE" type="text" id="BNF_APLACE" value="<%= BNF_APLACE %>" maxlength="20" AUTOCOMPLETE="off" PLACEHOLDER="Place Name"></TD>
</TR>
<TR>
  <TD >Name of the organizer : </TD>
  <TD><INPUT name="BNF_ASTFFNME" type="text" id="BNF_ASTFFNME" value="<%= BNF_ASTFFNME %>" maxlength="60" AUTOCOMPLETE="off" PLACEHOLDER="Organizer Name" />
  </TD>
</TR>
<INPUT name="BNF_TRID" type="hidden" id="BNF_TRID" value=<%= BNF_TRID %> />
<INPUT name="BUD_ID" type="hidden" id="BUD_ID" value=<%= BUD_ID %> />
<INPUT name="OFF_CD" type="hidden" id="OFF_CD" value=<%= OFF_CD %> />
<INPUT name="SAMT_BAL" type="hidden" id="SAMT_BAL" value=<%= SAMT_BAL %> />
<INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value=<%= sselect %> />

<TR>
  <TD> Contact no. : </TD> <INPUT name="ins" type="hidden" id="ins">
  <TD><INPUT name="BNF_ASTFFCNTCT" type="text" id="BNF_ASTFFCNTCT"  value="<%= BNF_ASTFFCNTCT %>" maxlength="12" AUTOCOMPLETE="off" onKeyPress="return isNumberNoDec(event)" PLACEHOLDER="Contact No" ></TD>
</TR>


<TR>
  <TD>Subject of advertising in brief and event if any: </TD>
  <TD><INPUT name="BNF_APROGDTLS" type="text" id="BNF_APROGDTLS"  value="<%= BNF_APROGDTLS %>" maxlength="100" AAUTOCOMPLETE="off" PLACEHOLDER="Advertising subject"></TD>
</TR>
<TR>
  <TD>Total Expenditure incurred for (Amount in Rs. only) : </TD>
  <TD><INPUT name="BNF_ATA" type="text" id="BNF_ATA" AUTOCOMPLETE="off" value="<%= BNF_ATA %>"  onKeyPress="javascript:return isNumber(event)" PLACEHOLDER="Expenditure incurred" onKeyUp="word.innerHTML=convertNumberToWords(this.value)" ></TD>
</TR>
<TR>
  <TD></TD>
  <TD><DIV id="word"></DIV> </TD>
</TR>

<TR>
  <TD>Organized By Agency (KVIC/KVIB/DIC): </TD>
  <TD>
  <SELECT name="BNF_AGENCY" class="button" id="BNF_AGENCY" >
          <!--<OPTION value ="-1" >--Select Agency --</OPTION>-->
          <OPTION value="KV" <% if (BNF_AGENCY.equals("KV")){out.print("selected");}%>>KVIC</OPTION>
          <OPTION value="KB" <% if (BNF_AGENCY.equals("KB")){out.print("selected");}%>>KVIB</OPTION>
          <OPTION value="DI" <% if (BNF_AGENCY.equals("DI")){out.print("selected");}%>>DIC</OPTION>
	    </SELECT>
    </TD>
</TR>
<TR>
  <TD>Remark (if any): </TD>
  <TD><INPUT name="REMARK_ADD" type="text" AUTOCOMPLETE="off" id="REMARK_ADD" value="<%= REMARK_ADD %>" PLACEHOLDER="Remark" ></TD>
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
BNF_ASTFFNME=(String) request.getParameter("BNF_ASTFFNME")==null?"":(String) request.getParameter("BNF_ASTFFNME").trim();
//BNF_ASTFFDSGNTN=(String) request.getParameter("BNF_ASTFFDSGNTN")==null?"":(String) request.getParameter("BNF_ASTFFDSGNTN").trim();
BNF_ASTFFCNTCT=(String) request.getParameter("BNF_ASTFFCNTCT")==null?"":(String) request.getParameter("BNF_ASTFFCNTCT").trim();
BNF_APLACE=(String) request.getParameter("BNF_APLACE")==null?"":(String) request.getParameter("BNF_APLACE").trim();
BNF_APROGDTLS=(String) request.getParameter("BNF_APROGDTLS")==null?"":(String) request.getParameter("BNF_APROGDTLS").trim();
BNF_ATOURDYS=(String) request.getParameter("BNF_ATOURDYS")==null?"":(String) request.getParameter("BNF_ATOURDYS").trim();
BNF_AFROMDT=(String) request.getParameter("BNF_AFROMDT")==null?"":(String) request.getParameter("BNF_AFROMDT").trim();
BNF_ATODT=(String) request.getParameter("BNF_ATODT")==null?"":(String) request.getParameter("BNF_ATODT").trim();
BNF_TYPPUBLICITY=(String) request.getParameter("BNF_TYPPUBLICITY")==null?"":(String) request.getParameter("BNF_TYPPUBLICITY").trim();
BNF_NOOFPARTCPNTS=(String) request.getParameter("BNF_NOOFPARTCPNTS")==null?"1":(String) request.getParameter("BNF_NOOFPARTCPNTS").trim();
//BNF_ACLBNAME=(String) request.getParameter("BNF_ACLBNAME")==null?"":(String) request.getParameter("BNF_ACLBNAME").trim();
BNF_ATA=(String) request.getParameter("BNF_ATA")==null?"":(String) request.getParameter("BNF_ATA").trim();
//BNF_ADA=(String) request.getParameter("BNF_ADA")==null?"":(String) request.getParameter("BNF_ADA").trim();
BNF_AGENCY=(String) request.getParameter("BNF_AGENCY")==null?"":(String) request.getParameter("BNF_AGENCY").trim();
REMARK_ADD=(String) request.getParameter("REMARK_ADD")==null?"":(String) request.getParameter("REMARK_ADD").trim();
BNF_EVENT=(String) request.getParameter("BNF_EVENT")==null?"":(String) request.getParameter("BNF_EVENT").trim();
YEAR_ID=(String) request.getParameter("YEAR_ID")==null?"":(String) request.getParameter("YEAR_ID").trim();


//out.print(BNF_TRID);
//out.print(OFF_CD);
//out.print(BUD_ID);

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
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_EVENT,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_AFROMDT,");
qryUpdate.append("BNF_ATODT,");
qryUpdate.append("BNF_TYPPUBLICITY,");

if (BNF_AGENCY.equals("KB")){
qryUpdate.append("PH_KVIB,");
qryUpdate.append("FIN_KVIB,");
}else if (BNF_AGENCY.equals("DI")){
qryUpdate.append("PH_DIC,");
qryUpdate.append("FIN_DIC,");
}else {
qryUpdate.append("PH_KVIC,");
qryUpdate.append("FIN_KVIC,");
}




qryUpdate.append("TR_DATE,");
//qryUpdate.append("BNF_ADA,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD, YEAR_ID, OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?, ?,SYSDATE,?,?,?,?,?,?)");


}else{
	
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_EVENT=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_AFROMDT=?,");
qryUpdate.append("BNF_ATODT=?,");
qryUpdate.append("BNF_TYPPUBLICITY=?,");
if (BNF_AGENCY.equals("KB")){
qryUpdate.append("PH_KVIB=?,");
qryUpdate.append("FIN_KVIB=?,");
qryUpdate.append("PH_DIC=0,");
qryUpdate.append("FIN_DIC=0,");
qryUpdate.append("PH_KVIC=0,");
qryUpdate.append("FIN_KVIC=0,");

}else if (BNF_AGENCY.equals("DI")){
qryUpdate.append("PH_KVIB=0,");
qryUpdate.append("FIN_KVIB=0,");
qryUpdate.append("PH_DIC=?,");
qryUpdate.append("FIN_DIC=?,");
qryUpdate.append("PH_KVIC=0,");
qryUpdate.append("FIN_KVIC=0,");
}else {
qryUpdate.append("PH_KVIB=0,");
qryUpdate.append("FIN_KVIB=0,");
qryUpdate.append("PH_DIC=0,");
qryUpdate.append("FIN_DIC=0,");
qryUpdate.append("PH_KVIC=?,");
qryUpdate.append("FIN_KVIC=?,");
}
qryUpdate.append("TR_DATE=SYSDATE,");
qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?,");
qryUpdate.append("YEAR_ID=?");
qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

}

values.add(BNF_ASTFFNME); pstm.add ("L");
values.add(BNF_EVENT); pstm.add ("L");
values.add(BNF_ASTFFCNTCT); pstm.add ("L");
values.add(BNF_APLACE); pstm.add ("L");
values.add(BNF_APROGDTLS); pstm.add ("L");
values.add(BNF_ATOURDYS); pstm.add ("L");
values.add(BNF_AFROMDT); pstm.add ("L");
values.add(BNF_ATODT); pstm.add ("L");
values.add(BNF_TYPPUBLICITY); pstm.add ("L");
values.add(BNF_NOOFPARTCPNTS); pstm.add ("L");
values.add(BNF_ATA); pstm.add ("L");
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