<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<SCRIPT language="javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript" src="../js/datetimepicker_css.js"></SCRIPT>
<SCRIPT language="javascript">


 function isNumber(evt) {
		var TR_AMT = (evt.which) ? evt.which : evt.keyCode
		if (TR_AMT != 46 && TR_AMT > 31 && (TR_AMT < 48 || TR_AMT > 57))
		
        return false;
        return true;
    }    
	
function submitform() {

var TR_DATE= document.form.TR_DATE.value;
var TR_AMT = document.form.TR_AMT.value;
var TR_OFFCDFR = document.form.TR_OFFCDFR.value;
var TR_OFFCDTO = document.form.TR_OFFCDTO.value;

 if(TR_DATE == "") {
    inlineMsg('TR_DATE','Enter Transaction Date!',2);
    return false;
	}

 if(TR_AMT == "" || TR_AMT == "0") {
    inlineMsg('TR_AMT','Amount should not be empty or 0',2);
    return false;
	}

 if(TR_OFFCDTO == "-1") {
    inlineMsg('TR_OFFCDTO','Please select Office',2);
    return false;
	}

 if(TR_OFFCDFR == TR_OFFCDTO) {
    inlineMsg('TR_OFFCDTO','Transfer or refund cannot be in same office! Please select other office.',2);
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
List pstm=new ArrayList();
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String TR=request.getParameter("TR")==null?"":(String) request.getParameter("TR");
String OFF_CD = SOFF_CD;
String BNF_ID=request.getParameter("PBNF_ID")==null?"":(String) request.getParameter("PBNF_ID");
String OFF_NM=request.getParameter("OFF_NM")==null?"":(String) request.getParameter("OFF_NM");
out.print(OFF_NM);
String TR_TYPE="RT";
String TYPE="";
String YEAR_ID="";
String TR_DATE="";

String TR_AMT="";

String TR_OFFCDFR = request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD");
String TR_DETAILS = "";
String REMARKS = "";
String TRANSFER_OFFCD = request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD");
String TR_OFFCDTO = "";
String off_cd1="";
String off_name1="";
String off_cd="";
String off_name="";
String add_update="I";

DBCon db= new DBCon();
db.connect();

String qrystr="";
/*
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
TR_TYPE=rsMain.getString("TR_TYPE")==null?"RT":rsMain.getString("TR_TYPE");
TR_AMT=rsMain.getString("TR_AMT")==null?"":rsMain.getString("TR_AMT");
TR_OFFCDFR=rsMain.getString("TR_OFFCDFR")==null?"":rsMain.getString("TR_OFFCDFR");
TR_OFFCDTO=rsMain.getString("TR_OFFCDTO")==null?"":rsMain.getString("TR_OFFCDTO");
TR_DETAILS=rsMain.getString("TR_DETAILS")==null?"":rsMain.getString("TR_DETAILS");
REMARKS=rsMain.getString("REMARKS")==null?"":rsMain.getString("REMARKS");
add_update="U";
}
rsMain.close();

}
*/
//out.print (BUD_ID);
%>
<TABLE>
<TR>
  <TD colspan="2"><DIV align="center">B.F.LINKAGES RELEASES, UTILISATION </DIV></TD>
  </TR>
<TR>
  <TD >Year</TD>
  <TD> <SELECT name="YEAR_ID" class="button" id="YEAR_ID">
         <OPTION value="<%= sselect %>" selected><%= sselect %></OPTION>
       </SELECT><INPUT name="TR" type="hidden" id="TR" value="<%= TR %>"  autocomplete="off"  >
    <INPUT name="BNF_ID" type="hidden" id="BNF_ID" value="<%= BNF_ID %>"  autocomplete="off"  ></TD>
</TR>
<TR><INPUT name="TRANSFER_OFFCD" type="hidden" id="TRANSFER_OFFCD" value="<%= TRANSFER_OFFCD %>" AUTOCOMPLETE="off" >
  <TD >Transaction Date </TD>
  <TD><INPUT name="TR_DATE" type="text" AUTOCOMPLETE="off" id="TR_DATE" value="<%= TR_DATE %>" onClick="javascript:NewCssCal('TR_DATE','ddMMMyyyy')"/></TD>
  </TR>

<INPUT name="ins" type="hidden" id="ins" value="" />

<TR>
  <TD>Transaction Amount </TD>
  <TD><INPUT name="TR_AMT" type="text" id="TR_AMT" value="<%= TR_AMT %>" onKeyPress="javascript:return isNumber(event)" AUTOCOMPLETE="off" >
</TD>
</TR>

<TR>
  <TD>Transfer from  Office </TD>
  <TD><%=OFF_NM%><INPUT name="TR_OFFCDFR" type="hidden" id="TR_OFFCDFR" value="<%= TR_OFFCDFR %>" AUTOCOMPLETE="off" > </TD>
</TR>
<TR>
  <TD>Transfer To  Office </TD>
  <TD><SELECT name="TR_OFFCDTO" class="button"  id="TR_OFFCDTO"  >
            <OPTION value="-1">--Select Office--</OPTION>
            <%
	    qrystr="SELECT BNF_OFF_MAST.OFF_CD, BNF_OFF_MAST.OFF_NAME1 FROM BNF_OFF_MAST";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   off_cd=rs.getString("OFF_CD");
	    off_name=rs.getString("OFF_NAME1");
	   %>
            <OPTION value="<%=off_cd%>"><%=off_name%></OPTION>
            <% } 
	  rs.close();
	   %>
            </SELECT>   </TD>
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
TR_TYPE=(String) request.getParameter("TR_TYPE")==null?"RT":(String) request.getParameter("TR_TYPE").trim();
TR_AMT=(String) request.getParameter("TR_AMT")==null?"":(String) request.getParameter("TR_AMT").trim();
TR_OFFCDFR=(String) request.getParameter("TR_OFFCDFR")==null?"":(String) request.getParameter("TR_OFFCDFR").trim();
TR_OFFCDTO=(String) request.getParameter("TR_OFFCDTO")==null?"":(String) request.getParameter("TR_OFFCDTO").trim();
TRANSFER_OFFCD=(String) request.getParameter("TRANSFER_OFFCD")==null?"":(String) request.getParameter("TRANSFER_OFFCD").trim();

if (TR_OFFCDTO.equals("9999"))
{
TYPE="RT";
}
else{
TYPE="TR";
}	

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
values.add(TYPE); pstm.add ("L");
values.add(TR_OFFCDFR); pstm.add ("L");
values.add(TR_OFFCDTO); pstm.add ("L");
values.add(TR_AMT); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

	

response.sendRedirect("savemsg.jsp");

}


		
		}

		
		
		


%>
<TABLE width="90%" align="center" border="0" class="shadow" bgcolor="#D4F5D0">
    <THEAD>
      
      <TR>
        <TD colspan="11" bgcolor="#147107">
             <DIV align="center"><SPAN class="style6">Transaction History </SPAN></DIV></TD>
      </TR>
      <TR>
        <TD>SrNo</TD>
         <TD>Trans ID </TD>
<TD>Transferred to Office </TD>
        <TD>Type</TD>
        <TD>Date</TD>
        <TD>Amount (Rs.)</TD>
        <TD>Delete</TD>
      </TR>
    </THEAD>
    <TBODY>
      <%

 String  PBNF_ID="";
 String  PTR_TYPE="";
 String  PTR_AMT="";
 String  PTR_DATE="";
 String POFF_NAME1="";

  
  
  StringBuffer qrysb = new StringBuffer();
 
 qrysb.append("  SELECT BFT.BNF_ID,"      );
  qrysb.append("  CASE"      );
  qrysb.append("    WHEN BFT.TR_TYPE = 'RT'"      );
   qrysb.append("   THEN 'RETURN TO CENTRAL OFFICE'"      );
   qrysb.append("   WHEN BFT.TR_TYPE = 'TR'"      );
   qrysb.append("   THEN 'TRANSFER'"      );
  qrysb.append("  END AS TR_TYPE,"      );
   qrysb.append(" BFT.TR_AMT,"      );
  qrysb.append("  TO_CHAR(BFT.TR_DATE, 'DD-MON-RRRR') AS TR_DATE, BOM.OFF_NAME1"      );
 qrysb.append(" FROM BNF_FUND BFT, BNF_OFF_MAST BOM  WHERE BFT.TR_OFFCDTO  = BOM.OFF_CD AND TR_TYPE IN ('RT','TR') AND TR_OFFCDFR='"+TR_OFFCDFR+"'  AND BFT.YEAR_ID='"+sselect+"'"); 
 //out.print(qrysb.toString());
  

	 
	 ResultSet rsMainNew =db.execSQL(qrysb.toString());
	 //BigDecimal  sumAmt=new BigDecimal("0.00");
	 int intsr=0;
	   
  while(rsMainNew.next())
  {
 PBNF_ID=rsMainNew.getString("BNF_ID")==null?"":rsMainNew.getString("BNF_ID");
 PTR_TYPE=rsMainNew.getString("TR_TYPE")==null?"":rsMainNew.getString("TR_TYPE");
  PTR_AMT=rsMainNew.getString("TR_AMT")==null?"":rsMainNew.getString("TR_AMT");
   PTR_DATE=rsMainNew.getString("TR_DATE")==null?"0":rsMainNew.getString("TR_DATE");
   POFF_NAME1=rsMainNew.getString("OFF_NAME1")==null?"0":rsMainNew.getString("OFF_NAME1");
    intsr=intsr+1;
   
	    %>
      <TR>
        <TD><%= intsr %></TD>
        <TD><%=PBNF_ID%></TD>
<TD><%= POFF_NAME1 %></TD>
        <TD><%=PTR_TYPE%></TD>
		<TD><%=PTR_DATE%></TD>
        <TD><div align="center"><%= PTR_AMT%></TD>
        
        <TD><DIV align="center">
          <A href="del_entry.jsp?BNF_ID=<%=PBNF_ID%>"><INPUT type="button" id="" name=""  class="buttonDarkGreen" value="Delete" ></A>
        </DIV></TD>
      </TR>
     
 <% }
rsMainNew.close();
db.close();
values.clear();
pstm.clear();

 %>
  
  </TBODY>
  </TABLE></td>
    <TD width="15%"></TD>
  </tr>
</table>


</FORM>
</BODY>
</HTML>