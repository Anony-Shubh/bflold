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

var BNF_ATA = document.form.BNF_ATA.value;
var SAMT_BAL = document.form.SAMT_BAL.value;


			
if (BNF_ATA == "") {
			 inlineMsg('BNF_ATA',"Please enter AMOUNT.",2);
            return (false);
			}
	
			
		
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
String BNF_TRID=request.getParameter("BNF_TRID")==null?"0":(String)request.getParameter("BNF_TRID");	
String PBNF_DESC=session.getAttribute("PBNF_DESC")==null?"":(String)session.getAttribute("PBNF_DESC");
String BUD_ID=session.getAttribute("PBUD_ID")==null?"":(String)session.getAttribute("PBUD_ID");
//String FIN_AMT = "";
String BNF_EVENT="";

String BNF_ATA = "";
String BNF_AGENCY = "";
String REMARK_ADD = "";
String BNF_HDID ="";
String YEAR_ID ="";
String FIN_KVIC ="";

String add_update="I";
DBCon db= new DBCon();
db.connect();


  //out.print (BNF_TRID+" "+OFF_CD);


if (!BNF_TRID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.BNF_TRID,"      );
qrysb.append("     BFT.OFF_CD, BFT.YEAR_ID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     BFT.BNF_EVENT,"      );
qrysb.append("     BFT.BNF_ATA ,BFT.FIN_KVIC, "      );
qrysb.append("     BFT.REMARK_ADD,"      );
qrysb.append("     BFT.BNF_AGENCY "      );
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
BNF_ATA=rsMain.getString("BNF_ATA")==null?"":rsMain.getString("BNF_ATA");
REMARK_ADD=rsMain.getString("REMARK_ADD")==null?"":rsMain.getString("REMARK_ADD");
BNF_AGENCY=rsMain.getString("BNF_AGENCY")==null?"":rsMain.getString("BNF_AGENCY");
BNF_EVENT=rsMain.getString("BNF_EVENT")==null?"":rsMain.getString("BNF_EVENT");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");
FIN_KVIC=rsMain.getString("FIN_KVIC")==null?"":rsMain.getString("FIN_KVIC");

add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>
<STRONG><H2><CENTER>TA/DA AS CONTIGENCY  <%= sselect %></CENTER></H2></STRONG>
<TABLE>
<TR>
  <TD colspan="2"><DIV align="center">DATA ENTRY FORM <%= sselect %> </DIV></TD>
  </TR>
<TR>
  <TD >Name of the Event under :  </TD>
  <TD><INPUT name="BNF_EVENT" type="text" id="BNF_EVENT" value="TA/DA AS CONTIGENCY" readonly="true" AUTOCOMPLETE="off" ></TD>
</TR><INPUT name="BNF_TRID" type="hidden" id="BNF_TRID" value=<%= BNF_TRID %>  />
<INPUT name="BUD_ID" type="hidden" id="BUD_ID" value=<%= BUD_ID %> />
<INPUT name="OFF_CD" type="hidden" id="OFF_CD" value=<%= OFF_CD %> />
<INPUT name="SAMT_BAL" type="hidden" id="SAMT_BAL" value=<%= SAMT_BAL %> />
<INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value=<%= sselect %> />

<INPUT name="ins" type="hidden" id="ins">
<INPUT name="BNF_AGENCY" type="hidden" id="BNF_AGENCY" value="KV"> 
<TR>
  <TD>Organized By Agency: </TD>
  <TD><INPUT name="BNF_AGENCY2" type="text" id="BNF_AGENCY2" value="KVIC"  readonly="true"> </TD>
</TR>
<TR>
  <TD>Expenditure incurred on TA (Amount in Rs only): </TD>
  <TD><INPUT name="BNF_ATA" AUTOCOMPLETE="off" type="text" id="BNF_ATA" value="<%= BNF_ATA %>" onChange="tot();" onKeyPress="javascript:return isNumber(event)" PLACEHOLDER="Expenditure (TA)"></TD>
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

BNF_EVENT=(String) request.getParameter("BNF_EVENT")==null?"":(String) request.getParameter("BNF_EVENT").trim();
YEAR_ID=(String) request.getParameter("YEAR_ID")==null?"":(String) request.getParameter("YEAR_ID").trim();
BNF_ATA=(String) request.getParameter("BNF_ATA")==null?"":(String) request.getParameter("BNF_ATA").trim();
BNF_AGENCY=(String) request.getParameter("BNF_AGENCY")==null?"":(String) request.getParameter("BNF_AGENCY").trim();
REMARK_ADD=(String) request.getParameter("REMARK_ADD")==null?"":(String) request.getParameter("REMARK_ADD").trim();
BNF_TRID=(String) request.getParameter("BNF_TRID")==null?"0":(String) request.getParameter("BNF_TRID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
BUD_ID=(String) request.getParameter("BUD_ID")==null?"":(String) request.getParameter("BUD_ID").trim();
FIN_KVIC=(String) request.getParameter("FIN_KVIC")==null?"":(String) request.getParameter("FIN_KVIC").trim();


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

qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_EVENT,");
qryUpdate.append("YEAR_ID,");
qryUpdate.append("BNF_ATA,");
qryUpdate.append("FIN_KVIC,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD,");
qryUpdate.append("TR_DATE,");
qryUpdate.append("OFF_CD,");
qryUpdate.append("BUD_ID,");//7
qryUpdate.append("BNF_TRID");//7

qryUpdate.append(" ) VALUES (?,?,?,?,?,?,SYSDATE,?,?,?)");


		}catch(Exception e){
out.print(e.toString());
}	
		
		
		}
		else{
	try{

qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_EVENT=?,");
qryUpdate.append("YEAR_ID=?,");
qryUpdate.append("BNF_ATA=?,");
qryUpdate.append("FIN_KVIC=?,");
qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?,");
qryUpdate.append("TR_DATE=SYSDATE");

qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

}	
	catch(Exception e){
out.print(e.toString());
}}		
		

values.add(BNF_EVENT); pstm.add ("L");
values.add(YEAR_ID); pstm.add ("L");
values.add(BNF_ATA); pstm.add ("L");
values.add(BNF_ATA); pstm.add ("L");
values.add(BNF_AGENCY); pstm.add ("L");
values.add(REMARK_ADD); pstm.add ("L");
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