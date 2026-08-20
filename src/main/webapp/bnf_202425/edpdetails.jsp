<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<SCRIPT type="text/javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT type="text/javascript" src="js/Words.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/bnf.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/datetimepicker_css.js"></SCRIPT>

<SCRIPT>
function submitform() {
var PH_KVIC= document.form.PH_KVIC.value;
var FIN_KVIC= document.form.FIN_KVIC.value;
var PH_KVIB= document.form.PH_KVIB.value;
var FIN_KVIB= document.form.FIN_KVIB.value;
var PH_DIC= document.form.PH_DIC.value;
var FIN_DIC= document.form.FIN_DIC.value;
var SNO_BAL = document.form.SNO_BAL.value;
var SAMT_BAL = document.form.SAMT_BAL.value;
var PH_TOTAL = document.form.PH_TOTAL.value;
var FIN_TOTAL = document.form.FIN_TOTAL.value;
/*
if (PH_TOTAL>SNO_BAL) {
			 inlineMsg('PH_TOTAL',"Physical total cannot be greater than Balance total",2);
            return (false);
			}

if (FIN_TOTAL>SAMT_BAL) {
			 inlineMsg('FIN_TOTAL',"Financial total cannot be greater than Balance total",2);
            return (false);
			}
*/

if(PH_KVIC == "" && FIN_KVIC=="" && PH_KVIB=="" && FIN_KVIB=="" && PH_DIC=="" && FIN_DIC==""){
inlineMsg('PH_KVIC',"Enter atleast one field",2);	
return(false);
}
if (!PH_KVIC == "" || !PH_KVIC == 0) 
{		if (FIN_KVIC==""||FIN_KVIC==0){
inlineMsg('FIN_KVIC',"Finacial amount must be entered.",2);		
return (false);
}
}

if (!FIN_KVIC=="" || !FIN_KVIC==0 ) {
	if (PH_KVIC=="" || PH_KVIC==0){
inlineMsg('PH_KVIC',"Physical No must be entered.",2);			
return (false);
}
}


if (!PH_KVIB == "" || !PH_KVIB == 0) 
{		if (FIN_KVIB==""||FIN_KVIB==0){
inlineMsg('FIN_KVIB',"Finacial amount must be entered.",2);		
return (false);
}
}

if (!FIN_KVIB=="" || !FIN_KVIB==0 ) {
	if (PH_KVIB=="" || PH_KVIB==0){
inlineMsg('PH_KVIB',"Physical No must be entered.",2);			
return (false);
}
}


if (!PH_DIC == "" || !PH_DIC == 0) 
{		if (FIN_DIC==""||FIN_DIC==0){
inlineMsg('FIN_DIC',"Finacial amount must be entered.",2);		
return (false);
}
}

if (!FIN_DIC=="" || !FIN_DIC==0 ) {
	if (PH_DIC=="" || PH_DIC==0){
inlineMsg('PH_DIC',"Physical No must be entered.",2);			
return (false);
}
}

form.Button.disabled = true;
document.form.ins.value='I';
document.form.submit();
}

function calculate_phytotal() {
var PH_KVIC= document.form.PH_KVIC.value;
var PH_KVIB= document.form.PH_KVIB.value;
var PH_DIC= document.form.PH_DIC.value;

var phytotal =Number(PH_KVIC)+Number(PH_KVIB)+Number(PH_DIC);

document.form.PH_TOTAL.value=phytotal;
}

function calculate_amttotal() {
var FIN_KVIC= document.form.FIN_KVIC.value;
var FIN_KVIB= document.form.FIN_KVIB.value;
var FIN_DIC= document.form.FIN_DIC.value;

var amttotal =Number(FIN_KVIC)+Number(FIN_KVIB)+Number(FIN_DIC);

document.form.FIN_TOTAL.value=amttotal;
}

function onlyAlphabets(e, t) {
            try {
                if (window.event) {
                    var BNF_PLACE = window.event.keyCode;
                }
               else if (e) {
                    var BNF_PLACE = e.which;
                }
                else { return true; }
                if ((BNF_PLACE > 64 && BNF_PLACE < 91) || (BNF_PLACE > 96 && BNF_PLACE < 123))
                    return true;
                else
                    return false;
            }
            catch (err) {
                alert(err.Description);
            }
        }	

 function isNumberNoDec(evt)
      {
         var PH_KVIC = (evt.which) ? evt.which : event.keyCode
		 var PH_KVIB = (evt.which) ? evt.which : event.keyCode
		 var PH_DIC = (evt.which) ? evt.which : event.keyCode
		 if (PH_KVIC > 31 && (PH_KVIC < 48 || PH_KVIC > 57))
		 if (PH_KVIB > 31 && (PH_KVIB < 48 || PH_KVIB > 57))
		 if (PH_DIC > 31 && (PH_DIC < 48 || PH_DIC > 57))
		 return false;
         return true;
      }		
 function isNumber(evt) {
   var FIN_KVIC = (evt.which) ? evt.which : evt.keyCode
		var FIN_KVIB = (evt.which) ? evt.which : evt.keyCode
		var FIN_DIC = (evt.which) ? evt.which : evt.keyCode
		if (FIN_KVIC != 46 && FIN_KVIC > 31 && (FIN_KVIC < 48 || FIN_KVIC > 57))
		if (FIN_KVIB != 46 && FIN_KVIB > 31 && (FIN_KVIB < 48 || FIN_KVIB > 57))
		if (FIN_DIC != 46 && FIN_DIC > 31 && (FIN_DIC < 48 || FIN_DIC > 57))
        return false;
        return true;
    }    
	







</SCRIPT>

<STYLE type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</STYLE>

</HEAD>
<BODY onLoad="calculate_phytotal();calculate_amttotal();">
<FORM  name="form" id="form" method="post" >


<%@ include file = "sessionoutincforeditform.jsp" %>
<%

List values=new ArrayList();

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String POFF_NAME1=SOFF_NAME1;
//String BNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID");

String OFF_CD = SOFF_CD;
String OFF_NAME1 = POFF_NAME1;
//String BUD_ID = request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");;

String BNF_TRID=session.getAttribute("PBNF_TRID")==null?"0":(String)session.getAttribute("PBNF_TRID");	
String PBNF_DESC=session.getAttribute("PBNF_DESC")==null?"":(String)session.getAttribute("PBNF_DESC");
String BUD_ID=session.getAttribute("PBUD_ID")==null?"":(String)session.getAttribute("PBUD_ID");
String BNF_AFROMDT ="";
String BNF_ATODT ="";
String YEAR_ID ="";
//out.print(BNF_TRID);
//out.print(BUD_ID);
String TR_DATE = "";
String FIN_KVIC = "";
String PH_KVIC = "";
String FIN_KVIB = "";
String FIN_DIC = "";
String PH_KVIB = "";
String PH_DIC = "";
String CB_FNO = "";
String BNF_PLACE = "";
String REMARK_ADD = "";
String TIMESTAMP = "";

String BNF_HDID ="";
String BNF_SUB_HEAD_LONG_DESC="";
String add_update="I";
DBCon db= new DBCon();
db.connect();


  //out.print (BNF_TRID+" "+OFF_CD);


if (!BNF_TRID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.BNF_TRID,"      );
qrysb.append("     BFT.OFF_CD,BFT.YEAR_ID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     TO_CHAR(BFT.TR_DATE,'DD-MON-RRRR') AS TR_DATE,"      );
qrysb.append("     BFT.PH_KVIC,"      );
qrysb.append("     BFT.FIN_KVIC,"      );
qrysb.append("     BFT.PH_KVIB,"      );
qrysb.append("     BFT.FIN_KVIB,"      );
qrysb.append("     BFT.PH_DIC,"      );
qrysb.append("     BFT.FIN_DIC,"      );
qrysb.append("     BFT.REMARK_ADD"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE  BFT.BNF_TRID=? AND BFT.OFF_CD=?"      );



  values.add(BNF_TRID);
  values.add(OFF_CD);
 // out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

BNF_TRID=rsMain.getString("BNF_TRID")==null?"":rsMain.getString("BNF_TRID");
BUD_ID=rsMain.getString("BUD_ID")==null?"":rsMain.getString("BUD_ID");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");
PH_KVIC=rsMain.getString("PH_KVIC")==null?"":rsMain.getString("PH_KVIC");
FIN_KVIC=rsMain.getString("FIN_KVIC")==null?"":rsMain.getString("FIN_KVIC");
PH_KVIB=rsMain.getString("PH_KVIB")==null?"":rsMain.getString("PH_KVIB");
FIN_KVIB=rsMain.getString("FIN_KVIB")==null?"":rsMain.getString("FIN_KVIB");
PH_DIC=rsMain.getString("PH_DIC")==null?"":rsMain.getString("PH_DIC");
FIN_DIC=rsMain.getString("FIN_DIC")==null?"":rsMain.getString("FIN_DIC");
TR_DATE=rsMain.getString("TR_DATE")==null?"":rsMain.getString("TR_DATE");
REMARK_ADD=rsMain.getString("REMARK_ADD")==null?"":rsMain.getString("REMARK_ADD");


add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>

<STRONG><H2><CENTER><%=PBNF_DESC%></CENTER></H2></STRONG>
<TABLE>
<TR>
  <TD colspan="9"><DIV align="center"> Form For <%=PBNF_DESC%> (<%= sselect %>)</DIV></TD>
  </TR>
<TR>
  <TD width="24%">Date :</TD>
  <TD colspan="8"><INPUT name="TR_DATE" type="text" id="TR_DATE" onClick="javascript:NewCssCal('TR_DATE','ddMMMyyyy')" value="<%= TR_DATE %>" maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="Date" ></TD>
</TR>
<INPUT name="ins" type="hidden" id="ins">
<TR><INPUT name="BNF_TRID" type="hidden" id="BNF_TRID" value="<%= BNF_TRID %>" />
<INPUT name="BUD_ID" type="hidden" id="BUD_ID" value="<%= BUD_ID %>" />
<INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%= OFF_CD %>" />
<INPUT name="SNO_BAL" type="hidden" id="SNO_BAL" value=<%= SNO_BAL %> />
<INPUT name="SAMT_BAL" type="hidden" id="SAMT_BAL" value=<%= SAMT_BAL %> />
<INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value=<%= sselect %> />
  <TD> Remark : </TD>
  <TD colspan="8"><INPUT name="REMARK_ADD"  type="text" id="REMARK_ADD" value="<%=REMARK_ADD%>" size="50" maxlength="100"  autocomplete="off" PLACEHOLDER="Remark"></TD>
</TR>

<TR>
  <TD rowspan="3">Physical and Financial Target/Budget: </TD>
  <TD colspan="8">(Amount in Rs only) </TD>
  </TR>
<TR>
  <TH colspan="2">KVIC  </TH>
  <TH colspan="2">KVIB</TH>
  <TH colspan="2">DIC</TH>
  <TH colspan="2">TOTAL</TH>
  </TR>
<TR>
  <TH width="9%">No.</TH>
  <TH width="10%">Amount</TH>
  <TH width="9%">No.</TH>
  <TH width="10%">Amount</TH>
  <TH width="9%">No.</TH>
  <TH width="10%">Amount</TH>
  <TH width="9%">No.</TH>
  <TH width="10%">Amount</TH>
</TR>
<TR>
  <TD>  Financial Amount :  </TD>
  <TD><DIV align="center">
  <INPUT name="PH_KVIC"  autocomplete="off"  type="text" id="PH_KVIC" value="<%=PH_KVIC%>" onKeyPress="return isNumberNoDec(event)"   size="8" maxlength="8" onBlur="calculate_phytotal();" > 
</DIV></TD>
 <TD><INPUT name="FIN_KVIC"  type="text"  autocomplete="off"  id="FIN_KVIC" value="<%=FIN_KVIC%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="15" onBlur="calculate_amttotal();"  onkeyup="word.innerHTML=convertNumberToWords(this.value)" ></TD>
  
  <TD><INPUT name="PH_KVIB"  type="text"  id="PH_KVIB"   autocomplete="off" value="<%=PH_KVIB%>" onKeyPress="return isNumberNoDec(event)" size="8" maxlength="8" onBlur="calculate_phytotal();"></TD>
   <TD><INPUT name="FIN_KVIB"  type="text"   id="FIN_KVIB"   autocomplete="off" value="<%=FIN_KVIB%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="13" onBlur="calculate_amttotal();"  onkeyup="word.innerHTML=convertNumberToWords(this.value)" ></TD>
 
  <TD><INPUT name="PH_DIC"  type="text"  autocomplete="off"  id="PH_DIC" value="<%=PH_DIC%>" onKeyPress="return isNumberNoDec(event)" size="8" maxlength="8" onBlur="calculate_phytotal();"></TD>
  <TD><INPUT name="FIN_DIC"  type="text"   autocomplete="off" id="FIN_DIC" value="<%=FIN_DIC%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="13" onBlur="calculate_amttotal();"  onkeyup="word.innerHTML=convertNumberToWords(this.value)" ></TD>
  <TD><INPUT name="PH_TOTAL" type="text" readonly="" id="PH_TOTAL" size="10" maxlength="10" ></TD>
  <TD> <INPUT name="FIN_TOTAL" type="text" readonly="" id="FIN_TOTAL" size="10" ></TD>
</TR>
<TR> <TD><LABEL>

</LABEL></TD> 
  <TD colspan="8"><DIV id="word"></DIV> </TD>
  </TR></TABLE>
<BR/><DIV align="center">
  <INPUT name="Button" type="button" class="button" onClick="submitform();" value="SAVE"/>
</DIV>
<%
//out.print (ins);
if (ins.equals("I")) {

BNF_TRID=(String) request.getParameter("BNF_TRID")==null?"0":(String) request.getParameter("BNF_TRID").trim();
//OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
YEAR_ID=(String) request.getParameter("YEAR_ID")==null?"":(String) request.getParameter("YEAR_ID").trim();
BUD_ID=(String) request.getParameter("BUD_ID")==null?"":(String) request.getParameter("BUD_ID").trim();
TR_DATE=(String) request.getParameter("TR_DATE")==null?"":(String) request.getParameter("TR_DATE").trim();
PH_KVIC=(String) request.getParameter("PH_KVIC")==null?"":(String) request.getParameter("PH_KVIC").trim();
FIN_KVIC=(String) request.getParameter("FIN_KVIC")==null?"":(String) request.getParameter("FIN_KVIC").trim();
PH_KVIB=(String) request.getParameter("PH_KVIB")==null?"":(String) request.getParameter("PH_KVIB").trim();
FIN_KVIB=(String) request.getParameter("FIN_KVIB")==null?"":(String) request.getParameter("FIN_KVIB").trim();
PH_DIC=(String) request.getParameter("PH_DIC")==null?"":(String) request.getParameter("PH_DIC").trim();
FIN_DIC=(String) request.getParameter("FIN_DIC")==null?"":(String) request.getParameter("FIN_DIC").trim();
REMARK_ADD=(String) request.getParameter("REMARK_ADD")==null?"":(String) request.getParameter("REMARK_ADD").trim();
//out.print(BNF_TRID);
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
qryUpdate.append("PH_KVIC,");
qryUpdate.append("FIN_KVIC,");
qryUpdate.append("PH_KVIB,");
qryUpdate.append("FIN_KVIB,");
qryUpdate.append("PH_DIC,");

qryUpdate.append("FIN_DIC,");
qryUpdate.append("REMARK_ADD,");
qryUpdate.append("YEAR_ID,");
qryUpdate.append("TR_DATE,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
}

else {
try{
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("PH_KVIC=?,");
qryUpdate.append("FIN_KVIC=?,");
qryUpdate.append("PH_KVIB=?,");
qryUpdate.append("FIN_KVIB=?,");
qryUpdate.append("PH_DIC=?,");
qryUpdate.append("FIN_DIC=?,");
qryUpdate.append("REMARK_ADD=?,");
qryUpdate.append("YEAR_ID=?,");
qryUpdate.append("TR_DATE=?");
qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

//out.print ("In oupdate"+BNF_TRID);
}
 catch(Exception e){
out.print(e.toString());
	
}
}

//out.print (qryUpdate.toString());
values.add(PH_KVIC); pstm.add ("L");
values.add(FIN_KVIC); pstm.add ("L");
values.add(PH_KVIB); pstm.add ("L");
values.add(FIN_KVIB); pstm.add ("L");
values.add(PH_DIC); pstm.add ("L");
values.add(FIN_DIC); pstm.add ("L");
values.add(REMARK_ADD); pstm.add ("L");
values.add(YEAR_ID); pstm.add ("L");
values.add(TR_DATE); pstm.add ("L");
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