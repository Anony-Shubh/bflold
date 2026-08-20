<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>


<HTML>
<HEAD>
<TITLE>
</TITLE>
<SCRIPT language="javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT>

function submitform() {
//var APP_ID = document.form.APP_ID.value;

//if(PHY_YR==""){
// swal ( 'Note:','Please select Physical Year','error');	return (false);
//}	


document.form.ins.value='I';
document.form.submit();
}

</SCRIPT>

<STYLE type="text/css">

* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 60%;
}



#customers td, #customers th {
    border: 1px solid #000000;
    padding: 4px;
	font-size:13px;
	font-weight:bold;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: #2e7d22;
    color: white;
}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.myButton {
	background-color:#2e823c;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.style2 {
	color: #FF0000;
	font-size: 16px;
}
</STYLE>

</HEAD>
<BODY>
<%@ include file = "sessionoutinc.jsp" %>
<FORM  name="form" id="form" method="post" >
<%

List values=new ArrayList();

String OFF_CD="";
String UC_ID=request.getParameter("UC_ID")==null?"":(String)request.getParameter("UC_ID");
String UC_OPG_BAL="";             
String INT_EARNED="";          
String HO_RECEIVED="";            
String SODO_RECEIVED="";           
String TOT_AVL_FUND="";              
String REFUND_TO_HO="";             
String TRANSFER_TO_SODO="";     
String REFUND_IN="";              
String TOTAL_REFUND="";           
String EXPENDITURE="";           
String CLOSING_BAL="";        
String UC_UPLOAD_NAME="";         
String UC_UPLOAD_DT="";             
String YEAR_ID="";  
String REFUND_INT="";   
String HOSODO_RECEIVED="";   
String TOT_REF_TRANSF="";   
String HO_FORW_DATE="";
String add_update="U";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

DBCon db= new DBCon();
db.connect();

//String qrystr="";

if (!SOFF_CD.equals("")) {
//
 StringBuffer qrysb = new StringBuffer();



qrysb.append(" select bu.UC_ID, bu.YEAR_ID,bu.HO_FORW_DATE, "); 
qrysb.append(" bu.OFF_CD,");
qrysb.append(" bu.HO_RECEIVED+bu.SODO_RECEIVED as HOSODO_RECEIVED ,");
qrysb.append(" bu.REFUND_TO_HO+bu.TRANSFER_TO_SODO as TOT_REF_TRANSF ,");
qrysb.append(" bu.UC_OPG_BAL,");
qrysb.append(" bu.INT_EARNED,");
qrysb.append(" bu.HO_RECEIVED,");
qrysb.append(" bu.SODO_RECEIVED,");
qrysb.append(" bu.TOT_AVL_FUND,");
qrysb.append(" bu.REFUND_TO_HO,");
qrysb.append(" bu.TRANSFER_TO_SODO,");
qrysb.append(" bu.REFUND_INT,");
qrysb.append(" bu.TOTAL_REFUND,");
qrysb.append(" bu.EXPENDITURE,");
qrysb.append(" bu.CLOSING_BAL");
qrysb.append(" from bnf_uc bu where");
qrysb.append(" bu.OFF_CD=? and bu.UC_ID=? and bu.YEAR_ID=? ");



  values.add(SOFF_CD);
  values.add(UC_ID);
  values.add(sselect);
  

 // out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
UC_ID=rsMain.getString("UC_ID")==null?"":rsMain.getString("UC_ID");
UC_OPG_BAL=rsMain.getString("UC_OPG_BAL")==null?"":rsMain.getString("UC_OPG_BAL");
INT_EARNED=rsMain.getString("INT_EARNED")==null?"":rsMain.getString("INT_EARNED");
HO_RECEIVED=rsMain.getString("HO_RECEIVED")==null?"":rsMain.getString("HO_RECEIVED");
SODO_RECEIVED=rsMain.getString("SODO_RECEIVED")==null?"":rsMain.getString("SODO_RECEIVED");
TOT_AVL_FUND=rsMain.getString("TOT_AVL_FUND")==null?"":rsMain.getString("TOT_AVL_FUND");
REFUND_TO_HO=rsMain.getString("REFUND_TO_HO")==null?"":rsMain.getString("REFUND_TO_HO");
REFUND_INT=rsMain.getString("REFUND_INT")==null?"":rsMain.getString("REFUND_INT");
TOTAL_REFUND=rsMain.getString("TOTAL_REFUND")==null?"":rsMain.getString("TOTAL_REFUND");
EXPENDITURE=rsMain.getString("EXPENDITURE")==null?"":rsMain.getString("EXPENDITURE");
CLOSING_BAL=rsMain.getString("CLOSING_BAL")==null?"":rsMain.getString("CLOSING_BAL");
YEAR_ID=rsMain.getString("YEAR_ID")==null?"":rsMain.getString("YEAR_ID");
TRANSFER_TO_SODO=rsMain.getString("TRANSFER_TO_SODO")==null?"":rsMain.getString("TRANSFER_TO_SODO");
HOSODO_RECEIVED=rsMain.getString("HOSODO_RECEIVED")==null?"":rsMain.getString("HOSODO_RECEIVED");
TOT_REF_TRANSF=rsMain.getString("TOT_REF_TRANSF")==null?"":rsMain.getString("TOT_REF_TRANSF");
HO_FORW_DATE=rsMain.getString("HO_FORW_DATE")==null?"":rsMain.getString("HO_FORW_DATE");

add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>

 <INPUT name="ins" type="hidden" id="ins" >
 <INPUT name="UC_ID" type="hidden" id="UC_ID" value="<%= UC_ID %>" >
 <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%= SOFF_CD %>" >
  <INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value="<%= sselect %>" >
<CENTER><BR>
<TABLE class="customers" id="customers">
  <TR>
    <TH colspan="5"  ><DIV align="center">Office Name: <%= SOFF_NAME1 %></DIV></TH>
    </TR>
  <TR>
    <TH colspan="5"  ><DIV align="center">Utilization Certificate For The Year: <%= sselect %></DIV></TH>
    </TR>
  <TR>
    <TD  ><DIV align="center">(1)</DIV></TD>
    <TD colspan="2">Opening Balance</TD>
    <TD  colspan="2"><INPUT name="UC_OPG_BAL" type="text" id="UC_OPG_BAL" value="<%=UC_OPG_BAL%>"  readonly="true"  maxlength="15"  autocomplete="off"  placeholder="Opening Balance as on 01.04.2021"></TR>
  <TR style="background-color:#33FF99;">
    <TD  colspan="1"><DIV align="center">(2)</DIV></TD>
    <TD colspan="2">Interest Earned During The Year</TD>
    <TD ><INPUT name="INT_EARNED" type="text" id="INT_EARNED" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1').replace(/^0[^.]/, '0');" value="<%=INT_EARNED%>" maxlength="15"  autocomplete="off"  placeholder="Enter Interest Earned in Rs."></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(3)</DIV></TD>
    <TD colspan="2">Grant Received From H.O</TD>
    <TD ><INPUT name="HO_RECEIVED" type="text" id="HO_RECEIVED" value="<%=HO_RECEIVED%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Grant Received From H.O"></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(4)</DIV></TD>
    <TD colspan="2">Grant Received From ZO/SO/DO </TD>
    <TD><INPUT name="SODO_RECEIVED" type="text" id="SODO_RECEIVED" value="<%=SODO_RECEIVED%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Grant Received From ZO/SO/DO"></TD>
  </TR>
  <TR>
    <TD><DIV align="center"></DIV></TD>
    <TD colspan="2">Total Grant Received (3+4)</TD>
    <TD><INPUT name="HOSODO_RECEIVED" type="text" id="HOSODO_RECEIVED" value="<%=HOSODO_RECEIVED%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Total Grant Received (3+4)"></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(5)</DIV></TD>
    
    <TD colspan="2">Total Availble Funds </TD>
    <TD><INPUT name="TOT_AVL_FUND" type="text" id="TOT_AVL_FUND" value="<%=TOT_AVL_FUND%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Total Availble Funds"></TD>
    </TR>
  
  <TR>
    <TD><DIV align="center">(6)</DIV></TD>
    <TD colspan="2">Refunded to HO</TD>
	<TD><INPUT name="REFUND_TO_HO" type="text" id="REFUND_TO_HO" value="<%=REFUND_TO_HO%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Refunded to HO"></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(7)</DIV></TD>
    <TD colspan="2">Transfered to ZO/SO/DO</TD>
	<TD><INPUT name="TRANSFER_TO_SODO" type="text" id="TRANSFER_TO_SODO" value="<%=TRANSFER_TO_SODO%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Transfered to ZO/SO/DO"></TD>
  </TR>
  <TR>
    <TD><DIV align="center"></DIV></TD>
    <TD colspan="2">Total Refund/Transfer (6+7) </TD>
    <TD><INPUT name="TOTAL_REFUND" type="text" id="TOTAL_REFUND" value="<%=TOT_REF_TRANSF%>"  maxlength="15" readonly="true" AUTOCOMPLETE="off"  placeholder="Total Refund/Transfer (6+7)"></TD>
  </TR>
  <TR style="background-color:#33FF99;">
    <TD><DIV align="center">(8)</DIV></TD>
    <TD colspan="2">Earned interest transferred to HO during the Year</TD>
		<TD><INPUT name="REFUND_INT" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1').replace(/^0[^.]/, '0');" type="text" id="REFUND_INT" value="<%=REFUND_INT%>"  maxlength="15"  autocomplete="off"  placeholder="Enter Int. Refunded to HO in Rs."></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(9)</DIV></TD>
    <TD colspan="2">Expenditure incurred during the Year</TD>
	<TD><INPUT name="EXPENDITURE" type="text" id="EXPENDITURE" value="<%=EXPENDITURE%>"  maxlength="15" readonly="true" AUTOCOMPLETE="off"  placeholder="Expenditure incurred during the Year"></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(10)</DIV></TD>
    <TD colspan="2">Closing Balance</TD>
	<TD><INPUT name="CLOSING_BAL" type="text" id="CLOSING_BAL" value="<%=CLOSING_BAL%>" readonly="true" maxlength="15"  autocomplete="off"  placeholder="Closing Balance"></TD>
  </TR><INPUT name="HO_FORW_DATE" type="hidden" id="HO_FORW_DATE" value="<%=HO_FORW_DATE%>">
  
    <TR>
    <TD colspan="5"  ><DIV align="center">
	<%if(HO_FORW_DATE.equals("")){%>
	<A class="myButton" onClick="submitform();">Submit</A>
	<%}else{%>
	<SPAN class="style2">Updation not allowed after forwarding to HO!</SPAN>
	<%}%>
	
	</DIV></TD>
    </TR>

    <TR>
    <TD colspan="5"  ><DIV align="center">
	<A class="myButton" href="bnf_ucview.jsp">BACK</A>
	</DIV></TD>
    </TR>

  
</TABLE>



</CENTER>



<%
//out.print (ins);
 if ((String)request.getParameter("ins")!=null) {
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
UC_OPG_BAL=(String) request.getParameter("UC_OPG_BAL")==null?"":(String) request.getParameter("UC_OPG_BAL").trim();
INT_EARNED=(String) request.getParameter("INT_EARNED")==null?"":(String) request.getParameter("INT_EARNED").trim();
HO_RECEIVED=(String) request.getParameter("HO_RECEIVED")==null?"":(String) request.getParameter("HO_RECEIVED").trim();
SODO_RECEIVED=(String) request.getParameter("SODO_RECEIVED")==null?"":(String) request.getParameter("SODO_RECEIVED").trim();
TOT_AVL_FUND=(String) request.getParameter("TOT_AVL_FUND")==null?"":(String) request.getParameter("TOT_AVL_FUND").trim();
REFUND_TO_HO=(String) request.getParameter("REFUND_TO_HO")==null?"":(String) request.getParameter("REFUND_TO_HO").trim();
TRANSFER_TO_SODO=(String) request.getParameter("TRANSFER_TO_SODO")==null?"":(String) request.getParameter("TRANSFER_TO_SODO").trim();

EXPENDITURE=(String) request.getParameter("EXPENDITURE")==null?"":(String) request.getParameter("EXPENDITURE").trim();
CLOSING_BAL=(String) request.getParameter("CLOSING_BAL")==null?"":(String) request.getParameter("CLOSING_BAL").trim();
REFUND_INT=(String) request.getParameter("REFUND_INT")==null?"":(String) request.getParameter("REFUND_INT").trim();

		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();

try{
qryUpdate.append(" UPDATE bnf_uc SET ");

qryUpdate.append(" UC_OPG_BAL=?, ");
qryUpdate.append(" INT_EARNED=?, ");
qryUpdate.append(" HO_RECEIVED=?, ");
qryUpdate.append(" SODO_RECEIVED=?, ");
qryUpdate.append(" TOT_AVL_FUND=?, ");
qryUpdate.append(" REFUND_TO_HO=?, ");
qryUpdate.append(" TRANSFER_TO_SODO=?, ");
qryUpdate.append(" REFUND_INT=?, ");
qryUpdate.append(" TOTAL_REFUND=?, ");
qryUpdate.append(" EXPENDITURE=?, ");
qryUpdate.append(" CLOSING_BAL=? ");

qryUpdate.append(" WHERE YEAR_ID = ? and UC_ID=? and OFF_CD=? ");



//out.print (qryUpdate.toString());

values.add(UC_OPG_BAL); pstm.add ("L");
values.add(INT_EARNED); pstm.add ("L");
values.add(HO_RECEIVED); pstm.add ("L");
values.add(SODO_RECEIVED); pstm.add ("L");
values.add(TOT_AVL_FUND); pstm.add ("L");
values.add(REFUND_TO_HO); pstm.add ("L");
values.add(TRANSFER_TO_SODO); pstm.add ("L");
values.add(REFUND_INT); pstm.add ("L");
values.add(TOTAL_REFUND); pstm.add ("L");
values.add(EXPENDITURE); pstm.add ("L");
values.add(CLOSING_BAL); pstm.add ("L");

values.add(sselect); pstm.add ("L");
values.add(UC_ID); pstm.add ("L");
values.add(SOFF_CD); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();

response.sendRedirect("bnf_ucview.jsp");
}

 catch(Exception e){
out.print(e.toString());
		
}
}
%>


</FORM>
 

</BODY>
</HTML>


