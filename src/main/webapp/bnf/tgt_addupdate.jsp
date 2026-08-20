<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">

<SCRIPT language="javascript">

function submitform() {
var PHY_NO_KVIC= document.form.PHY_NO_KVIC.value;
var FIN_AMT_KVIC= document.form.FIN_AMT_KVIC.value;
var PHY_NO_KVIB= document.form.PHY_NO_KVIB.value;
var FIN_AMT_KVIB= document.form.FIN_AMT_KVIB.value;
var PHY_NO_DIC= document.form.PHY_NO_DIC.value;
var FIN_AMT_DIC= document.form.FIN_AMT_DIC.value;

if(PHY_NO_KVIC=="" && FIN_AMT_KVIC=="" && PHY_NO_KVIB=="" && FIN_AMT_KVIB=="" && PHY_NO_DIC=="" && FIN_AMT_DIC==""){
alert ("Enter atleast one field")
return(false);
}

if (FIN_AMT_KVIC==""&&!PHY_NO_KVIC==""){
alert ("Finacial amount must be entered for physical achievement");
return (false);
}

if (FIN_AMT_KVIB==""&&!PHY_NO_KVIB==""){
alert ("Finacial amount must be entered for physical achievement");
return (false);
}

if (FIN_AMT_DIC==""&&!PHY_NO_DIC==""){
alert ("Finacial amount must be entered for physical achievement");
return (false);
}


document.form.ins.value='I';
document.form.submit();
}

function calculate_phytotal() {
var PHY_NO_KVIC= document.form.PHY_NO_KVIC.value;
var PHY_NO_KVIB= document.form.PHY_NO_KVIB.value;
var PHY_NO_DIC= document.form.PHY_NO_DIC.value;

var phytotal =Number(PHY_NO_KVIC)+Number(PHY_NO_KVIB)+Number(PHY_NO_DIC);

document.form.PHY_NO_TOTAL.value=phytotal;
}

function calculate_amttotal() {
var FIN_AMT_KVIC= document.form.FIN_AMT_KVIC.value;
var FIN_AMT_KVIB= document.form.FIN_AMT_KVIB.value;
var FIN_AMT_DIC= document.form.FIN_AMT_DIC.value;

var amttotal =Number(FIN_AMT_KVIC)+Number(FIN_AMT_KVIB)+Number(FIN_AMT_DIC);

document.form.FIN_AMT_TOTAL.value=amttotal;
}

 function isNumberNoDec(evt)
      {
         var PHY_NO_KVIC = (evt.which) ? evt.which : event.keyCode
		 var PHY_NO_KVIB = (evt.which) ? evt.which : event.keyCode
		 var PHY_NO_DIC = (evt.which) ? evt.which : event.keyCode
		 if (PHY_NO_KVIC > 31 && (PHY_NO_KVIC < 48 || PHY_NO_KVIC > 57))
		 if (PHY_NO_KVIB > 31 && (PHY_NO_KVIB < 48 || PHY_NO_KVIB > 57))
		 if (PHY_NO_DIC > 31 && (PHY_NO_DIC < 48 || PHY_NO_DIC > 57))
		 return false;
         return true;
      }		
 function isNumber(evt) {
   var FIN_AMT_KVIC = (evt.which) ? evt.which : evt.keyCode
		var FIN_AMT_KVIB = (evt.which) ? evt.which : evt.keyCode
		var FIN_AMT_DIC = (evt.which) ? evt.which : evt.keyCode
		if (FIN_AMT_KVIC != 46 && FIN_AMT_KVIC > 31 && (FIN_AMT_KVIC < 48 || FIN_AMT_KVIC > 57))
		if (FIN_AMT_KVIB != 46 && FIN_AMT_KVIB > 31 && (FIN_AMT_KVIB < 48 || FIN_AMT_KVIB > 57))
		if (FIN_AMT_DIC != 46 && FIN_AMT_DIC > 31 && (FIN_AMT_DIC < 48 || FIN_AMT_DIC > 57))
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
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String PBUD_ID=request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");
String POFF_CD=request.getParameter("POFFCD")==null?"":(String)request.getParameter("POFFCD");
String POFF_NAME1=request.getParameter("POFFNAME1")==null?"":(String)request.getParameter("POFFNAME1");
String BNF_BUDID =request.getParameter("PBNF_BUDID")==null?"0":(String)request.getParameter("PBNF_BUDID"); 

String OFF_CD = POFF_CD;
String OFF_NAME1 = POFF_NAME1;
//String YEAR_ID = "";
String YEAR_ID=session.getAttribute("sselect")==null?"":(String)session.getAttribute("sselect");		

String FIN_AMT_KVIC = "";
String PHY_NO_KVIC = "";
String ACT_YN = "";
String FIN_AMT_KVIB = "";
String FIN_AMT_DIC = "";
String PHY_NO_KVIB = "";
String PHY_NO_DIC = "";
String BNF_HDID = PBUD_ID;
String BNF_SUB_HEAD_LONG_DESC="";
String add_update="I";


DBCon db= new DBCon();
db.connect();



String qrybud="SELECT BHM.BNF_HDID,BHM.BNF_SUB_HEAD_LONG_DESC FROM BNF_HEAD_MAST BHM WHERE BHM.BNF_HDID = "+PBUD_ID+"";

ResultSet rsbud=db.execSQL(qrybud);

while (rsbud.next()){
BNF_SUB_HEAD_LONG_DESC=rsbud.getString("BNF_SUB_HEAD_LONG_DESC")==null?"":rsbud.getString("BNF_SUB_HEAD_LONG_DESC");
}

rsbud.close();


String qryname="SELECT OFF_NAME1 FROM BNF_OFF_MAST WHERE OFF_CD = "+POFF_CD+"";

ResultSet rsname=db.execSQL(qryname);

while (rsname.next()){
OFF_NAME1=rsname.getString("OFF_NAME1")==null?"":rsname.getString("OFF_NAME1");
}

rsname.close();


if (!BNF_BUDID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BBM.BNF_BUDID,"      );
qrysb.append("     BBM.OFF_CD,"      );
qrysb.append("     BBM.YEAR_ID,"      );
qrysb.append("     BBM.FIN_AMT_KVIC,"      );
qrysb.append("     BBM.PHY_NO_KVIC,"      );
qrysb.append("     BBM.ACT_YN,"      );
qrysb.append("     BBM.FIN_AMT_KVIB,"      );
qrysb.append("     BBM.FIN_AMT_DIC,"      );
qrysb.append("     BBM.PHY_NO_KVIB,"      );
qrysb.append("     BBM.PHY_NO_DIC,"      );
qrysb.append("     BBM.BNF_HDID"      );
qrysb.append("   FROM BNF_BUDGET_MAST BBM"      );
qrysb.append("   WHERE BBM.BNF_BUDID = "+BNF_BUDID+"");

//out.print (qrysb.toString());


ResultSet rsMain=db.execSQL(qrysb.toString());


while (rsMain.next()){

BNF_BUDID=rsMain.getString("BNF_BUDID")==null?"0":rsMain.getString("BNF_BUDID");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");
FIN_AMT_KVIC=rsMain.getString("FIN_AMT_KVIC")==null?"":rsMain.getString("FIN_AMT_KVIC");
PHY_NO_KVIC=rsMain.getString("PHY_NO_KVIC")==null?"":rsMain.getString("PHY_NO_KVIC");
ACT_YN=rsMain.getString("ACT_YN")==null?"":rsMain.getString("ACT_YN");
FIN_AMT_KVIB=rsMain.getString("FIN_AMT_KVIB")==null?"":rsMain.getString("FIN_AMT_KVIB");
FIN_AMT_DIC=rsMain.getString("FIN_AMT_DIC")==null?"":rsMain.getString("FIN_AMT_DIC");
PHY_NO_KVIB=rsMain.getString("PHY_NO_KVIB")==null?"":rsMain.getString("PHY_NO_KVIB");
PHY_NO_DIC=rsMain.getString("PHY_NO_DIC")==null?"":rsMain.getString("PHY_NO_DIC");
BNF_HDID=rsMain.getString("BNF_HDID")==null?"":rsMain.getString("BNF_HDID");
add_update="U";
}
rsMain.close();

}
%>
<TABLE>
<TR>
  <TD colspan="9"><DIV align="center">B&amp;F Target/Budget Add Update Form <%= sselect %> </DIV></TD>
  </TR>
<TR>
  <TD width="24%"> Budget / Target Head : </TD>
  <TD colspan="8"><INPUT name="BNF_HDID" type="hidden" id="BNF_HDID" value="<%=BNF_HDID%>">
    <%= BNF_SUB_HEAD_LONG_DESC %> <SPAN class="style1"></SPAN></TD></TR>
<TR><TD>  Budget ID  
  <INPUT name="ins" type="hidden" id="ins"></TD><TD colspan="8">  <INPUT name="BNF_BUDID" type="hidden" id="BNF_BUDID" value="<%=BNF_BUDID%>">
    <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD%>">
</TD></TR>  
  
<TR>
  <TD>Office Name 
    <INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value="<%=sselect%>">
    <INPUT name="ACT_YN" type="hidden" id="ACT_YN" value="<%=ACT_YN%>">
    :</TD>
  <TD colspan="8"><%= OFF_NAME1 %> </TD>
</TR>
  
<TR>
  <TD rowspan="3">Physical and Financial Target/Budget: </TD>
  <TD colspan="8">(Amount in Lakhs) </TD>
  </TR>
<TR>
  <TH colspan="2">KVIC  </TH>
  <TH colspan="2">KVIB</TH>
  <TH colspan="2">DIC</TH>
  <TH colspan="2">TOTAL</TH>
  </TR>
<TR>
  <TH width="9%">In No. </TH>
  <TH width="10%">Amount</TH>
  <TH width="9%">In No. </TH>
  <TH width="10%">Amount</TH>
  <TH width="9%">In No. </TH>
  <TH width="10%">Amount</TH>
  <TH width="9%">In No. </TH>
  <TH width="10%">Amount</TH>
</TR>
<TR>
  <TD>  KVIC Financial Amount :  </TD>
  <TD><DIV align="center">
  <INPUT name="PHY_NO_KVIC"  type="text" id="PHY_NO_KVIC" value="<%=PHY_NO_KVIC%>" onKeyPress="return isNumberNoDec(event)"   size="8" maxlength="8" onBlur="calculate_phytotal();" > 
</DIV></TD>
 <TD><INPUT name="FIN_AMT_KVIC"  type="text"   id="FIN_AMT_KVIC" value="<%=FIN_AMT_KVIC%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="15" onBlur="calculate_amttotal();" ></TD>
  
  <TD><INPUT name="PHY_NO_KVIB"  type="text"  id="PHY_NO_KVIB" value="<%=PHY_NO_KVIB%>" onKeyPress="return isNumberNoDec(event)" size="8" maxlength="8" onBlur="calculate_phytotal();"></TD>
   <TD><INPUT name="FIN_AMT_KVIB"  type="text"   id="FIN_AMT_KVIB" value="<%=FIN_AMT_KVIB%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="13" onBlur="calculate_amttotal();"></TD>
 
  <TD><INPUT name="PHY_NO_DIC"  type="text"  id="PHY_NO_DIC" value="<%=PHY_NO_DIC%>" onKeyPress="return isNumberNoDec(event)" size="8" maxlength="8" onBlur="calculate_phytotal();"></TD>
  <TD><INPUT name="FIN_AMT_DIC"  type="text" id="FIN_AMT_DIC" value="<%=FIN_AMT_DIC%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="13" onBlur="calculate_amttotal();"></TD>
  <TD><INPUT name="PHY_NO_TOTAL" type="text" readonly="" id="PHY_NO_TOTAL" size="10" maxlength="10" ></TD>
  <TD> <INPUT name="FIN_AMT_TOTAL" type="text" readonly="" id="FIN_AMT_TOTAL" size="10" ></TD>
</TR>
<TR> <TD colspan="9"><LABEL>

</LABEL></TD> </TR>  
</TABLE>

<BR/><DIV align="center">
  <INPUT name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
</DIV>
<%
//out.print (ins);
if (ins.equals("I")) {


BNF_BUDID=(String) request.getParameter("BNF_BUDID")==null?"0":(String) request.getParameter("BNF_BUDID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
YEAR_ID=(String) request.getParameter("YEAR_ID")==null?"":(String) request.getParameter("YEAR_ID").trim();

//YEAR_ID="2018-19";
//(String) request.getParameter("YEAR_ID")==null?"2018-19":(String) request.getParameter("YEAR_ID").trim();
FIN_AMT_KVIC=(String) request.getParameter("FIN_AMT_KVIC")==null?"":(String) request.getParameter("FIN_AMT_KVIC").trim();
PHY_NO_KVIC=(String) request.getParameter("PHY_NO_KVIC")==null?"":(String) request.getParameter("PHY_NO_KVIC").trim();
ACT_YN="Y";
//(String) request.getParameter("ACT_YN")==null?"Y":(String) request.getParameter("ACT_YN").trim();
FIN_AMT_KVIB=(String) request.getParameter("FIN_AMT_KVIB")==null?"":(String) request.getParameter("FIN_AMT_KVIB").trim();
FIN_AMT_DIC=(String) request.getParameter("FIN_AMT_DIC")==null?"":(String) request.getParameter("FIN_AMT_DIC").trim();
PHY_NO_KVIB=(String) request.getParameter("PHY_NO_KVIB")==null?"":(String) request.getParameter("PHY_NO_KVIB").trim();
PHY_NO_DIC=(String) request.getParameter("PHY_NO_DIC")==null?"":(String) request.getParameter("PHY_NO_DIC").trim();
BNF_HDID=(String) request.getParameter("BNF_HDID")==null?"":(String) request.getParameter("BNF_HDID").trim();


 List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		
		if (add_update.equals("I")) {
		
		String maxId="SELECT NVL(MAX(BNF_BUDID),0)+1 AS BNF_BUDID FROM BNF_BUDGET_MAST";
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
BNF_BUDID=rsMax.getString("BNF_BUDID")==null?"":rsMax.getString("BNF_BUDID");
}


rsMax.close();

qryUpdate.append("INSERT INTO BNF_BUDGET_MAST (");
qryUpdate.append("OFF_CD,");
qryUpdate.append("YEAR_ID,");
qryUpdate.append("FIN_AMT_KVIC,");
qryUpdate.append("PHY_NO_KVIC,");
qryUpdate.append("ACT_YN,");
qryUpdate.append("FIN_AMT_KVIB,");
qryUpdate.append("FIN_AMT_DIC,");
qryUpdate.append("PHY_NO_KVIB,");
qryUpdate.append("PHY_NO_DIC,");
qryUpdate.append("BNF_HDID,");
qryUpdate.append("BNF_BUDID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
}else {

qryUpdate.append("UPDATE BNF_BUDGET_MAST SET ");
qryUpdate.append("OFF_CD=?,");
qryUpdate.append("YEAR_ID=?,");
qryUpdate.append("FIN_AMT_KVIC=?,");
qryUpdate.append("PHY_NO_KVIC=?,");
qryUpdate.append("ACT_YN=?,");
qryUpdate.append("FIN_AMT_KVIB=?,");
qryUpdate.append("FIN_AMT_DIC=?,");
qryUpdate.append("PHY_NO_KVIB=?,");
qryUpdate.append("PHY_NO_DIC=?,");
qryUpdate.append("BNF_HDID=? ");
qryUpdate.append(" WHERE  BNF_BUDID=?");

}

//out.print (qryUpdate.toString());
values.add(OFF_CD); pstm.add ("L");
values.add(YEAR_ID); pstm.add ("L");
values.add(FIN_AMT_KVIC); pstm.add ("L");
values.add(PHY_NO_KVIC); pstm.add ("L");
values.add(ACT_YN); pstm.add ("L");
values.add(FIN_AMT_KVIB); pstm.add ("L");
values.add(FIN_AMT_DIC); pstm.add ("L");
values.add(PHY_NO_KVIB); pstm.add ("L");
values.add(PHY_NO_DIC); pstm.add ("L");
values.add(BNF_HDID); pstm.add ("L");
values.add(BNF_BUDID); pstm.add ("L");

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