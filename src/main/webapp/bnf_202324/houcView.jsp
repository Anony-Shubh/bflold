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
String ZONE_NM="";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

%>

 <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%= SOFF_CD %>" >
  <INPUT name="YEAR_ID" type="hidden" id="YEAR_ID" value="<%= sselect %>" >
<CENTER><BR>
<TABLE class="customers" id="customers">
  <TR>
    <TH colspan="17"  ><DIV align="center">Office Name: <%= SOFF_NAME1 %></DIV></TH>
    </TR>
  <TR>
    <TH colspan="17"  ><DIV align="center">Utilization Certificate Details For The Year: <%= sselect %></DIV></TH>
  </TR>
  <TR style="background-color:#33FF99;">
    <TD>Sr.No  </TD>
	 <TD>Zone</TD>
    <TD>Office </TD>
    <TD>Opening Balance</TD>
    <TD>
            Interest Earned During The Year
        </TD>
    <TD>Grant Received From H.O</TD>
    <TD> Grant Received From ZO/SO/DO </TD>
    <TD>Total Grant Received (3+4)</TD>
    <TD>Total Availble Funds </TD>
    <TD>Refunded to HO</TD>
    <TD>Transfered to ZO/SO/DO</TD>
    <TD>Total Refund/Transfer (6+7)</TD>
    <TD>Earned interest transferred to HO during the Year</TD>
    <TD>Expenditure incurred during the Year</TD>
    <TD>Closing Balance</TD>
    <TD>View</TD>
   
    </TR>
	

<%
DBCon db= new DBCon();
db.connect();

//String qrystr="";

if (!SOFF_CD.equals("")) {
//
 StringBuffer qrysb = new StringBuffer();



qrysb.append(" select bu.UC_ID, bu.YEAR_ID,bu.HO_FORW_DATE, "); 
qrysb.append(" mom.off_name1 ||'('||bu.OFF_CD||')' as OFF_CD,mom.ZONE_NM,");
qrysb.append(" bu.HO_RECEIVED+bu.SODO_RECEIVED as HOSODO_RECEIVED ,");
qrysb.append(" bu.REFUND_TO_HO+bu.TRANSFER_TO_SODO as TOT_REF_TRANSF ,bu.UC_UPLOAD_NAME,");
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
qrysb.append(" from bnf_uc bu,bnf_off_mast mom where mom.off_cd=bu.off_cd and bu.ho_forw_date IS NOT NULL ");
qrysb.append(" and bu.YEAR_ID=? ORDER BY mom.ZONE_NM ASC");



  //values.add(SOFF_CD);
  //values.add(UC_ID);
  values.add(sselect);
  

  //out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();
int srno=0;
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
UC_UPLOAD_NAME=rsMain.getString("UC_UPLOAD_NAME")==null?"":rsMain.getString("UC_UPLOAD_NAME");
ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
srno=srno+1;
//add_update="U";


//out.print (BUD_ID);
%>


 <TR>
	<TD  ><DIV align="center"><%=srno%></DIV></TD>
	<TD  ><DIV align="center"><%=ZONE_NM%></DIV></TD>
	<TD  ><DIV align="center"><%=OFF_CD%></DIV></TD>
	<TD  ><DIV align="center"><%=UC_OPG_BAL%></DIV></TD>	
	<TD  ><DIV align="center"><%=INT_EARNED%></DIV></TD>
	<TD  ><DIV align="center"><%=HO_RECEIVED%></DIV></TD>
	
	<TD  ><DIV align="center"><%=SODO_RECEIVED%></DIV></TD>
	<TD  ><DIV align="center"><%=HOSODO_RECEIVED%></DIV></TD>
	<TD  ><DIV align="center"><%=TOT_AVL_FUND%></DIV></TD>
	<TD  ><DIV align="center"><%=REFUND_TO_HO%></DIV></TD>
	<TD  ><DIV align="center"><%=TRANSFER_TO_SODO%></DIV></TD>
	
	<TD  ><DIV align="center"><%=TOTAL_REFUND%></DIV></TD>
	<TD  ><DIV align="center"><%=REFUND_INT%></DIV></TD>
	<TD  ><DIV align="center"><%=EXPENDITURE%></DIV></TD>
	<TD  ><DIV align="center"><%=CLOSING_BAL%></DIV></TD>
	
	
	<TD  ><%if(!UC_UPLOAD_NAME.equals("")){%>
	<A href="../../pmegpeportalappdoc/bnf/uc_upload/<%=UC_UPLOAD_NAME %>" target="_blank" class="myButton">UC </A>
	<%} else{%>
	Not Uploaded
	<%}%>
	
	</TD>
	</TR>
	
	
	
<%}
rsMain.close();

}
%>


   
</TABLE>


</CENTER>






</FORM>
 

</BODY>
</HTML>


