<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<SCRIPT language="javascript" src="inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript" src="popcalendar.js"></SCRIPT>
<SCRIPT language="javascript">

 function isNumber(evt) {
		var TR_AMT = (evt.which) ? evt.which : evt.keyCode
		if (TR_AMT != 46 && TR_AMT > 31 && (TR_AMT < 48 || TR_AMT > 57))
		
        return false;
        return true;
    }    
	

function submitform() {

var numberOnly= /^[0-9 \.-]+$/;

var TR_AMT = document.form.TR_AMT.value;

 if(TR_AMT == "" || TR_AMT == "0") {
    inlineMsg('TR_AMT','Amount should not be empty or 0',2);
    return false;
	}
		
document.form.ins.value='I';
document.form.submit();
}

</SCRIPT>

<STYLE type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
input[type=text], textarea {
  -webkit-transition: all 0.30s ease-in-out;
  -moz-transition: all 0.30s ease-in-out;
  -ms-transition: all 0.30s ease-in-out;
  -o-transition: all 0.30s ease-in-out;
  outline: none;
  padding: 3px 0px 3px 3px;
  margin: 5px 1px 3px 0px;
  border: 1px solid #DDDDDD;
  width:50%;
}
 
input[type=text]:focus, textarea:focus {
  box-shadow: 0 0 5px rgba(81, 203, 238, 1);
  padding: 3px 0px 3px 3px;
  margin: 5px 1px 3px 0px;
  border: 1px solid rgba(81, 203, 238, 1);
}

th
{
    color:#333333;
    background:#EFE0D1;
    border-style:solid;
    border-width:0px;
    border-color:#2C4F85;
    font-weight:bold;
	font-size:12px;
    padding:5px;
    text-align:left;
    vertical-align:top;
}


.style2 {color: #000000}
#msg {display:none; position:absolute; z-index:200; background:url(images/msg_arrow.gif) left center no-repeat; padding-left:7px}
#msgcontent {display:block; font:Arial, Helvetica, sans-serif; font-weight:bold;color: #990000;font-size: 16px;background:#f3e6e6; border:2px solid #924949; border-left:none; padding:5px; min-width:150px; max-width:250px}

</STYLE>

</HEAD>
<BODY>

<FORM  name="form" id="form" method="post" >
<%@ include file = "sessionoutincforeditform.jsp" %>
<%

List values=new ArrayList();

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String OFF_CD = SOFF_CD;
String BNF_ID=request.getParameter("PBNF_ID")==null?"":(String) request.getParameter("PBNF_ID");
String TR_TYPE="OB";

String YEAR_ID="";
String TR_DATE="01-APR-2023";

String TR_AMT="";

String TR_OFFCDFR ="";
String TR_DETAILS = "";
String REMARKS = "";
String TR_OFFCDTO = request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD");

String off_cd="";
String off_name="";
String add_update="I";

DBCon db= new DBCon();
db.connect();

String qrystr="";

if (!BNF_ID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BF.BNF_ID,"      );
qrysb.append("     BF.REMARKS,"      );
qrysb.append("    BF.TR_DETAILS,"      );
qrysb.append("     BF.TR_TYPE,"      );
qrysb.append("     BF.TR_AMT,"      );
qrysb.append("     BF.TR_OFFCDFR,"      );
qrysb.append("     BF.TR_OFFCDTO,"      );
qrysb.append("     BF.TR_DATE,"      );
qrysb.append("     BF.YEAR_ID"      );
qrysb.append("    FROM BNF_FUND BF"      );
qrysb.append("     WHERE BF.BNF_ID=?"      );


  values.add(BNF_ID);
 // values.add(TR_OFFCD);
  //out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

BNF_ID=rsMain.getString("BNF_ID")==null?"":rsMain.getString("BNF_ID");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");
TR_DATE=rsMain.getString("TR_DATE")==null?"":rsMain.getString("TR_DATE");
TR_TYPE=rsMain.getString("TR_TYPE")==null?"":rsMain.getString("TR_TYPE");
TR_AMT=rsMain.getString("TR_AMT")==null?"":rsMain.getString("TR_AMT");
TR_OFFCDFR=rsMain.getString("TR_OFFCDFR")==null?"":rsMain.getString("TR_OFFCDFR");
TR_OFFCDTO=rsMain.getString("TR_OFFCDTO")==null?"":rsMain.getString("TR_OFFCDTO");
TR_DETAILS=rsMain.getString("TR_DETAILS")==null?"":rsMain.getString("TR_DETAILS");
REMARKS=rsMain.getString("REMARKS")==null?"":rsMain.getString("REMARKS");


add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>
<TABLE>
  <TR>
    <TD colspan="2"><DIV align="center">B.F.LINKAGES RELEASES, UTILISATION</DIV></TD>
  </TR>
  <TR>
    <TD >Year</TD>
    <TD><SELECT name="YEAR_ID" class="button" id="YEAR_ID">
      <OPTION value="2023-24" selected>2023-24</OPTION>
    </SELECT>
        <INPUT name="BNF_ID" type="hidden" id="BNF_ID" value="<%= BNF_ID %>"  autocomplete="off"  ></TD>
  </TR>
  <TR>
    <TD >Transaction Date </TD>
    <TD><INPUT name="TR_DATE" type="text" AUTOCOMPLETE="off" id="TR_DATE" value="<%= TR_DATE %>" onClick="popUpCalendar(this, this.form.ESTAB_DATE,'dd-mmm-yyyy');return false;"/></TD>
  </TR>
  <INPUT name="ins" type="hidden" id="ins" value="" />
  <TR>
    <TD>Transaction Amount </TD>
    <TD><INPUT name="TR_AMT" type="text" id="TR_AMT" value="<%= TR_AMT %>" onKeyPress="javascript:return isNumber(event)" AUTOCOMPLETE="off" ></TD>
  </TR>
  
  <TR>
    <TD> Office </TD>
    <TD><SELECT name="TR_OFFCDTO" class="button"  id="TR_OFFCDTO" READONLY="true">
      <OPTION value="-1">--Select Office--</OPTION>
      <%
	    qrystr="SELECT BNF_OFF_MAST.OFF_CD, BNF_OFF_MAST.OFF_NAME1 FROM BNF_OFF_MAST";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   off_cd=rs.getString("OFF_CD");
	    off_name=rs.getString("OFF_NAME1");
	   %>
      <OPTION value="<%=off_cd%>"<% if ( TR_OFFCDTO.equals(off_cd)){out.print("selected");} %>><%=off_name%></OPTION>
      <% } 
	  rs.close();
	   %>
    </SELECT>
       </TD>
  </TR>
</TABLE>
<BR/>
<DIV align="center">
  <INPUT name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
</DIV>
<%
//out.print (ins);
if (ins.equals("I")) {

BNF_ID=(String) request.getParameter("BNF_ID")==null?"0":(String) request.getParameter("BNF_ID").trim();
YEAR_ID=(String) request.getParameter("YEAR_ID")==null?"":(String) request.getParameter("YEAR_ID").trim();
TR_DATE=(String) request.getParameter("TR_DATE")==null?"":(String) request.getParameter("TR_DATE").trim();
TR_TYPE=(String) request.getParameter("TR_TYPE")==null?"OB":(String) request.getParameter("TR_TYPE").trim();
TR_AMT=(String) request.getParameter("TR_AMT")==null?"":(String) request.getParameter("TR_AMT").trim();
TR_OFFCDFR=(String) request.getParameter("TR_OFFCDFR")==null?"":(String) request.getParameter("TR_OFFCDFR").trim();
TR_OFFCDTO=(String) request.getParameter("TR_OFFCDTO")==null?"":(String) request.getParameter("TR_OFFCDTO").trim();
TR_DETAILS=(String) request.getParameter("TR_DETAILS")==null?"":(String) request.getParameter("TR_DETAILS").trim();
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();

//out.print(BNF_TRID);
//out.print(OFF_CD);
//out.print(BUD_ID);

		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		if (add_update.equals("I")) {
		
String maxId="SELECT NVL(MAX(BNF_ID),0)+1 AS BNF_ID FROM BNF_FUND" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
BNF_ID=rsMax.getString("BNF_ID")==null?"":rsMax.getString("BNF_ID");
}


rsMax.close();

qryUpdate.append("INSERT INTO BNF_FUND ( ");
qryUpdate.append("BNF_ID,");
qryUpdate.append("YEAR_ID,");
qryUpdate.append("TR_DATE,");
qryUpdate.append("TR_TYPE,");
qryUpdate.append("TR_OFFCDFR,");
qryUpdate.append("TR_OFFCDTO,");
qryUpdate.append("TR_AMT,TIMESTAMP");

qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,SYSDATE)");

values.add(BNF_ID); pstm.add ("L");
values.add(YEAR_ID); pstm.add ("L");
values.add(TR_DATE); pstm.add ("L");
values.add(TR_TYPE); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");
values.add(TR_OFFCDTO); pstm.add ("L");
values.add(TR_AMT); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
	

response.sendRedirect("savemsg.jsp");
}
}
%>





</FORM>
</BODY>
</HTML>