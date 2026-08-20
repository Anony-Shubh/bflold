<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %><HEAD>
<TITLE>FUND POSITION</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">

<SCRIPT type="text/javascript">

// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=500,width=1000,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}

function zeroFunction(){
    if (document.getElementById('OB_AMT').value == '0') 
	 if (document.getElementById('RET_REF_AMT').value == '0') 
	  if (document.getElementById('REL_AMT').value == '0') 
	
	{
        window.location.href = "release.jsp";
    } else {
        window.location.href = "#";
    }
};


</SCRIPT>
<SCRIPT language="javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
</HEAD>


<STYLE>
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}

.style7 {font-size: 9px}
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}

.bb{
background-color: #FFF300;
}
.subtotal {
background-color: #FFF300;
text-align: right;
font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 19px;
	font-weight: bold;


}
.tt{
background-color: #00F7FF;
}
.total {
background-color: #00F7FF;
text-align: right;

font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 20px;
	font-weight: bold;

}

.sum {
text-align: right;
font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
}

.style1 {
	font-family: "Times New Roman", Times, serif;
	font-size: 20px;
}
.style4 {font-size: 20px}

.style6 {
	font-size: 50px;
	font-family: Algerian;
	font-weight: bold;
}

body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.myButton {
	background-color:#44c767;
	-moz-border-radius:10px;
	-webkit-border-radius:10px;
	border-radius:10px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:17px;
	padding:5px 76px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.myButton:hover {
	background-color:#5cbf2a;
}
.myButton:active {
	position:relative;
	top:1px;
}
</STYLE>

<BODY>



<FORM method="post" name="form">

  <DIV align="center">
    <%@ include file = "sessionoutinc.jsp" %>
    
    <%

List values=new ArrayList();
//if (vlogin.equals("Y")){
StringBuffer sb= new StringBuffer();

DBCon db= new DBCon();
db.connect();

 String PBUD_ID=request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");
 String PBNF_NAME=request.getParameter("PBNF_NAME")==null?"":(String)request.getParameter("PBNF_NAME");

 String RECV_AMT="";
 String ZONE_NM="";
 String OFF_CD="";
 String OFF_NAME1="";
 String OB_AMT="";
 String RET_REF_AMT="";
 String REL_AMT="";
 String AVAIL_BAL="";
 String UTILISE="";
 String UNSPENT="";

%>
    
    <A href="jasperReports/bnfreport123.jsp?REPNM=report2&YEAR_ID=<%= sselect %>" target="_blank" class="myButton"> Print Report</A>
    
  </DIV>
    <TABLE border="1" align="center" id="customers">
   <THEAD>
  <TR>
    <TH colspan="12" bgcolor="#F0F0F0"><DIV align="center">Office wise Fund Position</DIV></TH>
    </TR>
  
  <TR>
    <TH width="4%" rowspan="3"><DIV align="center">Sr. No </DIV></TH>
    <TH width="6%" rowspan="3"><DIV align="center">Zone</DIV></TH>
    <TH width="17%" rowspan="3"><DIV align="center">Office Name</DIV></TH>
  </TR>
  <TR>
    
    <TH width="7%" rowspan="2"><DIV align="center">Opening Balance </DIV></TH>
	<TH colspan="2"><DIV align="center">Received from Ministry </DIV></TH>
	<TH width="7%" rowspan="2"><DIV align="center">Recieve From Other Office</DIV></TH>
	<TH colspan="2"><DIV align="center">Release from CO</DIV></TH>
	<TH width="7%" rowspan="2"><DIV align="center">Available Balance</DIV></TH>
	<TH width="7%" rowspan="2"><DIV align="center">Utilisation</DIV></TH>
	<TH width="7%" rowspan="2"><DIV align="center">Unspent</DIV></TH>
	</TR>
  <TR>
    <TH><DIV align="center">Amt</DIV></TH>
    <TH><DIV align="center">Add/Delete</DIV></TH>
    <TH><DIV align="center">Amt</DIV></TH>
    <TH><DIV align="center">Add/Delete</DIV></TH>
  </TR>
    </THEAD>
	   <TBODY>
 <%
StringBuffer qrysb= new StringBuffer();

qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("      SELECT K.*,"      );
qrysb.append("        L.*,"      );
qrysb.append("        NVL(K.avail_bal, 0) - NVL(L.UTILISE, 0) AS UNSPENT,"      );
qrysb.append("        K.YEAR_ID                               AS YEAR_ID1"      );
qrysb.append("      FROM"      );
qrysb.append("        (SELECT O.ZONE_NM,"      );
qrysb.append("          O.OFF_CD,"      );
qrysb.append("          O.OFF_NAME1,"      );
qrysb.append("          M.OB_AMT,"      );
qrysb.append("          (P.RET_REF_AMT/100000) AS RET_REF_AMT,"      );
qrysb.append("          M.REL_AMT,"      );
qrysb.append("          (T.RECV_AMT/100000) AS RECV_AMT,"      );
qrysb.append("     ((NVL(M.OB_AMT, 0)) + (NVL(M.REL_AMT, 0)) + (NVL((T.RECV_AMT/100000), 0))) - (NVL((P.RET_REF_AMT/100000), 0)) AS avail_bal,"      );
qrysb.append("          M.YEAR_ID"      );
qrysb.append("        FROM"      );
qrysb.append("          (SELECT BOM.ZONE_NM,"      );
qrysb.append("            BOM.OFF_CD,"      );
qrysb.append("            BOM.OFF_NAME1"      );
qrysb.append("          FROM BNF_BUDGET_MAST BBM,"      );
qrysb.append("            BNF_OFF_MAST BOM"      );
qrysb.append("          WHERE BOM.OFF_CD = BBM.OFF_CD"      );
qrysb.append("          GROUP BY BOM.ZONE_NM,"      );
qrysb.append("            BOM.OFF_CD,"      );
qrysb.append("            BOM.OFF_NAME1"      );
qrysb.append("          ) O,"      );
qrysb.append("          (SELECT BFT.TR_OFFCDTO                                          AS OFF_CD,"      );
qrysb.append("            SUM(NVL(DECODE(BFT.TR_TYPE, 'OB', NVL(BFT.TR_AMT, 0), 0), 0)) AS OB_AMT,"      );
qrysb.append("            SUM(NVL(DECODE(BFT.TR_TYPE, 'RC', NVL(BFT.TR_AMT, 0), 0), 0)) AS REL_AMT,"      );
qrysb.append("            BFT.YEAR_ID"      );
qrysb.append("          FROM BNF_FUND BFT"      );
qrysb.append("          GROUP BY BFT.TR_OFFCDTO,"      );
qrysb.append("            BFT.YEAR_ID"      );
qrysb.append("          ) M,"      );
qrysb.append("          (SELECT BFT.TR_OFFCDFR AS OFF_CD,"      );
qrysb.append("            SUM(NVL("      );
qrysb.append("            CASE"      );
qrysb.append("              WHEN BFT.TR_TYPE IN ('RT', 'TR')"      );
qrysb.append("              THEN BFT.TR_AMT"      );
qrysb.append("            END, 0)) AS RET_REF_AMT"      );
qrysb.append("          FROM BNF_FUND BFT WHERE BFT.YEAR_ID='"+sselect+"'"      );
qrysb.append("          GROUP BY BFT.TR_OFFCDFR"      );
qrysb.append("          ) P,"      );
qrysb.append("          (SELECT BFT.TR_OFFCDTO AS OFF_CD,"      );
qrysb.append("            SUM(NVL("      );
qrysb.append("            CASE"      );
qrysb.append("              WHEN BFT.TR_TYPE IN ('RT', 'TR')"      );
qrysb.append("              THEN BFT.TR_AMT"      );
qrysb.append("            END, 0)) AS RECV_AMT"      );
qrysb.append("          FROM BNF_FUND BFT WHERE BFT.YEAR_ID='"+sselect+"'"      );
qrysb.append("          GROUP BY BFT.TR_OFFCDTO"      );
qrysb.append("          ) T"      );
qrysb.append("        WHERE O.OFF_CD = M.OFF_CD(+)"      );
qrysb.append("        AND M.OFF_CD   = P.OFF_CD(+)"      );
qrysb.append("        AND O.OFF_CD   = T.OFF_CD(+)"      );
qrysb.append("        ORDER BY O.ZONE_NM,"      );
qrysb.append("          O.OFF_CD"      );
qrysb.append("        ) K,"      );
qrysb.append("        (SELECT BFT1.OFF_CD,"      );
qrysb.append("          ROUND(SUM(NVL(BFT1.FIN_KVIC, 0) + NVL(BFT1.FIN_KVIB, 0) + NVL(BFT1.FIN_DIC, 0)) / 100000, 2) AS UTILISE"      );
qrysb.append("        FROM BNF_FO_TRANS BFT1 WHERE BFT1.YEAR_ID='"+sselect+"'"      );
qrysb.append("        GROUP BY BFT1.OFF_CD "      );
qrysb.append("        ) L"      );
qrysb.append("      WHERE K.OFF_CD = L.OFF_CD(+) AND YEAR_ID='"+sselect+"'"      );
qrysb.append("      "      );


//out.print(qrysb.toString());


ResultSet rs = db.execSQL(qrysb.toString());

int c=0;
String GROUP1_OLD="";
	String flag="N";


while (rs.next()) {
ZONE_NM=rs.getString("ZONE_NM")==null?"":rs.getString("ZONE_NM");

c=c+1;
if (!GROUP1_OLD.equals("")){
	flag=	 (!GROUP1_OLD.equals(ZONE_NM))?"Y":"N";
	}
	
ZONE_NM=rs.getString("ZONE_NM")==null?"":rs.getString("ZONE_NM");
OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
OB_AMT=rs.getString("OB_AMT")==null?"0":rs.getString("OB_AMT");
RET_REF_AMT=rs.getString("RET_REF_AMT")==null?"0":rs.getString("RET_REF_AMT");
REL_AMT=rs.getString("REL_AMT")==null?"0":rs.getString("REL_AMT");
AVAIL_BAL=rs.getString("AVAIL_BAL")==null?"0":rs.getString("AVAIL_BAL");
RECV_AMT=rs.getString("RECV_AMT")==null?"0":rs.getString("RECV_AMT");
UTILISE=rs.getString("UTILISE")==null?"0":rs.getString("UTILISE");
UNSPENT=rs.getString("UNSPENT")==null?"0":rs.getString("UNSPENT");
%>

<% if (flag.equals("Y")){ %>
  <TR>
    <TD class="bb">&nbsp;</TD>
    <TD class="bb">&nbsp; </TD>
    <TD class="bb"><DIV align="center">Zone Total : </DIV></TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD width="6%"  class="subtotal">&nbsp;</TD>
    <TD width="6%"  class="bb">&nbsp;</TD>
    <TD  width="6%" class="subtotal">&nbsp;</TD>
    <TD width="6%"  class="subtotal">&nbsp;</TD>
    <TD width="6%" class="bb">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
  </TR>
    <% } GROUP1_OLD=ZONE_NM;%>
	
  <TR>
    <TD><DIV align="center"><%= c %></DIV></TD>
	<TD><DIV align="center"><%= ZONE_NM  %></DIV></TD>
	<TD><DIV align="center"><%= OFF_NAME1  %></DIV></TD>
	
	<TD class="sum">
	
	<% if ((OB_AMT.equals("0")) &&(sselect.equals("2022-23"))){%>	
	
	<A href="JavaScript:newPopup('releaseob.jsp?OFF_CD=<%=OFF_CD%>');"><%= OB_AMT %></A>
	<%} else{%>
	<%= OB_AMT %>	<%}%>	</TD>	
	

	<TD class="sum"><%= REL_AMT %></A>
	<%if(sselect.equals("2022-23")){%>
	<TD><DIV align="center"><A href="JavaScript:newPopup('releaserc.jsp?OFF_CD=<%=OFF_CD%>');">Add/Delete </A></DIV></TD>
	<%}else{%>
	<TD class="sum"><DIV align="center">-</DIV></TD>
	<%}%>
	
	<TD class="sum"><%=RECV_AMT%></TD>
	
	<TD class="sum"><%= RET_REF_AMT %></TD>
	<%if(sselect.equals("2022-23")){%>
	<TD><DIV align="center"><A href="JavaScript:newPopup('releaasert.jsp?OFF_CD=<%=OFF_CD%>&OFF_NM=<%=OFF_NAME1%>&TR=<%=AVAIL_BAL%>');"> Add/Delete</A></DIV></TD>
	<%}else{%>
	<TD class="sum"><DIV align="center">-</DIV></TD>
	<%}%>
	<TD class="sum"><%=AVAIL_BAL%></TD>
	<TD class="sum"><%= UTILISE %></TD>
	<TD class="sum"><%= UNSPENT %></TD>	
	</TR>

<%

}

rs.close();
db.close();
%>

<TR>
    <TD class="tt">&nbsp;</TD>
    <TD class="tt">&nbsp;</TD>
    <TD class="tt">Grand Total : </TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="tt">&nbsp;</TD>
    <TD class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="tt">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
  </TR>
</TBODY>
<TFOOT>
</TFOOT>
 <TR>
    <TH><DIV align="center">Srno</DIV></TH>
    <TH><DIV align="center">Zone</DIV></TH>
    <TH><DIV align="center">Office Name </DIV></TH>
	
	<TH><DIV align="center">Opening Balance </DIV></TH>
	<TH colspan="2"><DIV align="center">Received from Ministry </DIV></TH>
	<TH><DIV align="center">Recieve From Other Office</DIV></TH>
	<TH colspan="2"><DIV align="center">Release from CO</DIV></TH>
	<TH><DIV align="center">Available Balance</DIV></TH>
	<TH><DIV align="center">Utilisation</DIV></TH>
	<TH><DIV align="center">Unspent</DIV></TH>
	</TR>
</TABLE>
 <SCRIPT language="javascript" src="js/drilldowntotal.js"></SCRIPT>
</FORM>

</BODY>
</HTML>
