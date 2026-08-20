<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>UPDATE PERFORMANCE</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/main1.css">
<SCRIPT language="javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
<STYLE type="text/css">
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

.subtotal {
background-color: #FFF300;
text-align: right;
font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 19px;
	font-weight: bold;


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

.customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
	font-weight:900;
	border:1px solid #003366;
    border-color:#2C4F85;
}

.customers td, .customers th {
    /*border: 1px solid #ddd; */
    padding: 2px;
	padding-left:5px;
}



.customers th {
    padding-top: 4px;
    padding-bottom: 4px;
    text-align: center;
    background-color: #4CAF50;
    color: white;
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

.topnav a:hover {
  border-bottom: 3px solid red;
}


</STYLE>
</HEAD>

<BODY>


<FORM method="post" name="form">
<%@ include file = "sessionoutinc.jsp" %>
<P>
   
<%
List values=new ArrayList();
//if (vlogin.equals("Y")){
StringBuffer sb= new StringBuffer();
 
DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());

String ZONE_NM="";
String OFF_CD="";
String OFF_NAME1="";
String BGT_NO="";
String BGT_AMT="";
String PERF_NO="";
String PERF_AMT="";
String NO_BAL="";
String AMT_BAL="";
String ACHV_PER="";
String budgethead=request.getParameter("budgethead")==null?">=0":(String)request.getParameter("budgethead").trim();  
//out.print(budgethead);
%>
</P>


<P align="center" class="style1 style7">PROGRESS REPORT UNDER BACKWARD AND FORWARD LINKAGES UNDER PMEGP</P>
<P align="center">
    
    <SPAN class="inner style4"><STRONG>Budget Head</STRONG></SPAN><SPAN class="style4">:
    <SELECT name="budgethead" id="budgethead">
      <OPTION value=">=0" <% if (budgethead.equals(">=0")){out.print("Selected");} %>>ALL</OPTION>
      <OPTION value="=1" <% if (budgethead.equals("=1")){out.print("Selected");} %>>EDP</OPTION>
      <OPTION value="=2" <% if (budgethead.equals("=2")){out.print("Selected");} %>>Physical Verification</OPTION>
      <OPTION value="=3" <% if (budgethead.equals("=3")){out.print("Selected");} %>>Dist. Level Awareness Camps</OPTION>
      <OPTION value="=4" <% if (budgethead.equals("=4")){out.print("Selected");} %>>State Level Workshop</OPTION>
      <OPTION value="=5" <% if (budgethead.equals("=5")){out.print("Selected");} %>>Dist. Level Exhibitions</OPTION>
      <OPTION value="=6" <% if (budgethead.equals("=6")){out.print("Selected");} %>>State Level Exhibition</OPTION>
      <OPTION value="=7" <% if (budgethead.equals("=7")){out.print("Selected");} %>>Zonal Level Exhibition</OPTION>
      <OPTION value="=8" <% if (budgethead.equals("=8")){out.print("Selected");} %>>Zonal Level Review Meeting</OPTION>
      <OPTION value="=9" <% if (budgethead.equals("=9")){out.print("Selected");} %>>Quarterly Bankers Review Meeting</OPTION>
      <OPTION value="=10" <% if (budgethead.equals("=10")){out.print("Selected");} %>>State Level Monitoring Committee Meeting</OPTION>
      <OPTION value="=11" <% if (budgethead.equals("=11")){out.print("Selected");} %>>Staff  Training Workshops</OPTION>
      <OPTION value="=12" <% if (budgethead.equals("=12")){out.print("Selected");} %>>TA/DA of staff & officers</OPTION>
      <OPTION value="=13" <% if (budgethead.equals("=13")){out.print("Selected");} %>>PROMOTIONAL AND PUBLICITY</OPTION>
      <OPTION value="=14" <% if (budgethead.equals("=14")){out.print("Selected");} %>>Data Entry Operators</OPTION>
    </SELECT>
    <INPUT name="Submit" type="submit" class="myButton" onClick="copy();" value="Go">
  </SPAN></P>
  <TABLE border="1" align="center" id="customers">
  <THEAD>
  <TR>
    <TH width="8%"><DIV align="center">Srno</DIV></TH>
    <TH width="9%"><DIV align="center">Zone</DIV></TH>
    <TH width="15%"><DIV align="center">Office Name </DIV></TH>
	
	<TH width="12%"><DIV align="center">Financial Target Alloted (In Amt)</DIV></TH>
	<TH width="12%"><DIV align="center">Physical Target Achieved (In Number)</DIV></TH>
	<TH width="12%"><DIV align="center">Financial Target Achieved (In Amt)</DIV></TH>
	<TH width="12%"><DIV align="center">Physical Balance (In Number)</DIV></TH>
	<TH width="12%"><DIV align="center">Financial Balance (In Amt)</DIV></TH>
	<TH width="12%"><DIV align="center">Achievement Percentage</DIV></TH>
  </TR>
  </THEAD>
  <TBODY>
<%

sb.append("   SELECT MA.ZONE_NM ,"      );
sb.append("     MA.OFF_CD      ,"      );
sb.append("     MA.OFF_NAME1    ,"      );
sb.append("     MA.BGT_NO      ,"      );
sb.append("      NVL(MA.BGT_AMT*100000,0) AS BGT_AMT,"      );
sb.append("     TR.PERF_NO     ,"      );
sb.append("     NVL(TR.PERF_AMT,0) AS  PERF_AMT   ,"      );
sb.append("      NVL(MA.BGT_NO,0)- NVL(TR.PERF_NO,0) AS NO_BAL     ,"      );
sb.append("       NVL(MA.BGT_AMT*100000,0)- NVL(TR.PERF_AMT,0) AS AMT_BAL,"      );
//sb.append("       ROUND((TR.PERF_AMT/MA.BGT_AMT)*100,2) AS ACHV_PER"      );
sb.append("       ROUND((TR.PERF_AMT/DECODE(MA.BGT_AMT,0,1,MA.BGT_AMT))*100,2) AS ACHV_PER"      );
sb.append("    "      );
sb.append("   FROM"      ); 
sb.append("     (SELECT TGT.ZONE_NM,"      );
sb.append("       TGT.OFF_CD,"      );
sb.append("       TGT.OFF_NAME1,"      );
sb.append("       SUM(TGT.TPHY_NO)  AS BGT_NO,"      );
sb.append("       SUM(TGT.TFIN_AMT) AS BGT_AMT"      );
sb.append("     FROM"      );
sb.append("       (SELECT BOM.ZONE_NM,"      );
sb.append("         BBM.OFF_CD,"      );
sb.append("         BOM.OFF_NAME1,"      );
sb.append("         BBM.BNF_HDID,"      );
sb.append("         BHM.BNF_SUB_HEAD_SH_DESC,"      );
sb.append("         NVL(BBM.FIN_AMT_KVIC, 0) + NVL(BBM.FIN_AMT_DIC, 0) + NVL(BBM.FIN_AMT_KVIB, 0) AS TFIN_AMT,"      );
sb.append("         NVL(BBM.PHY_NO_KVIC, 0)  + NVL(BBM.PHY_NO_KVIB, 0) + NVL(BBM.PHY_NO_DIC, 0)   AS TPHY_NO,"      );
sb.append("         BBM.BNF_BUDID"      );
sb.append("       FROM BNF_BUDGET_MAST BBM,"      );
sb.append("         BNF_HEAD_MAST BHM,"      );
sb.append("         BNF_OFF_MAST BOM"      );
sb.append("       WHERE BBM.BNF_HDID = BHM.BNF_HDID"      );
sb.append("       AND BBM.OFF_CD     = BOM.OFF_CD"      );
sb.append("       AND BBM.YEAR_ID    = '"+sselect+"' AND BBM.BNF_HDID"+budgethead+""      );
sb.append("       ) TGT"      );
sb.append("     GROUP BY TGT.ZONE_NM,"      );
sb.append("       TGT.OFF_CD,"      );
sb.append("       TGT.OFF_NAME1"      );
sb.append("     ORDER BY ZONE_NM"      );
sb.append("     ) MA,"      );
sb.append("     (SELECT PTR.OFF_CD,"      );

if((budgethead.equals("=3"))||(budgethead.equals("=4"))||(budgethead.equals("=5"))||(budgethead.equals("=6"))||(budgethead.equals("=7"))||(budgethead.equals("=8"))||(budgethead.equals("=9"))||(budgethead.equals("=10"))){
sb.append("       COUNT(PTR.APHY_NO) AS PERF_NO,"      );
}else {
sb.append("       SUM(PTR.APHY_NO) AS PERF_NO,"      );
}

//sb.append("       SUM(PTR.APHY_NO) AS PERF_NO,"      );


sb.append("       SUM(PTR.AFIN_AMT) PERF_AMT"      );
sb.append("     FROM"      );
sb.append("       (SELECT BFT.OFF_CD,"      );
sb.append("         BFT.BUD_ID,"      );
sb.append("         BFT.TR_DATE,"      );
sb.append("         NVL(BFT.FIN_KVIC, 0) + NVL(BFT.FIN_DIC, 0) + NVL(BFT.FIN_KVIB, 0) AS AFIN_AMT,"      );
sb.append("         NVL(BFT.PH_KVIC, 0)  + NVL(BFT.PH_KVIB, 0) + NVL(BFT.PH_DIC, 0)   AS APHY_NO"      );
sb.append("       FROM BNF_FO_TRANS BFT WHERE BFT.BUD_ID "+budgethead+" AND BFT.YEAR_ID    = '"+sselect+"'"      );
sb.append("       ) PTR"      );
sb.append("     GROUP BY PTR.OFF_CD"      );
sb.append("     ) TR"      );
sb.append("   WHERE MA.OFF_CD = TR.OFF_CD(+)"      );
sb.append("   ORDER BY ZONE_NM"      );


ResultSet rs = db.executeSQL(sb.toString(),values);

int count=0;
String GROUP1_OLD="";
	String flag="N";


while (rs.next()) {
ZONE_NM=rs.getString("ZONE_NM")==null?"":rs.getString("ZONE_NM");

count=count+1;
if (!GROUP1_OLD.equals("")){
	flag=	 (!GROUP1_OLD.equals(ZONE_NM))?"Y":"N";
	}


OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
BGT_NO=rs.getString("BGT_NO")==null?"":rs.getString("BGT_NO");
BGT_AMT=rs.getString("BGT_AMT")==null?"":rs.getString("BGT_AMT");
PERF_NO=rs.getString("PERF_NO")==null?"0":rs.getString("PERF_NO");
PERF_AMT=rs.getString("PERF_AMT")==null?"0":rs.getString("PERF_AMT");
NO_BAL=rs.getString("NO_BAL")==null?"0":rs.getString("NO_BAL");
AMT_BAL=rs.getString("AMT_BAL")==null?"0":rs.getString("AMT_BAL");
ACHV_PER=rs.getString("ACHV_PER")==null?"0":rs.getString("ACHV_PER");

%>

<% if (flag.equals("Y")){ %>
  <TR>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD><DIV align="center">Zone Total : </DIV></TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD  class="subtotal">&nbsp;</TD>
    <TD>&nbsp;</TD>
  </TR>
  <% } GROUP1_OLD=ZONE_NM;%>





  <TR>
    <TD><DIV align="center"><%= count %></DIV></TD>
	<TD><DIV align="center"><%= ZONE_NM %></DIV></TD>
<!--	<TD><DIV align="center"><A href="drofficewisein.jsp?POFF_CD=<%//= OFF_CD %>&POFF_NAME1=<%//= OFF_NAME1 %>"><%//=OFF_NAME1 %></A> </DIV></TD>--> 
    <TD><DIV align="center"><%=OFF_NAME1 %></DIV></TD>
	<TD class="sum"><%= BGT_AMT %></TD>
	<TD class="sum"><%= PERF_NO %></TD>
	<TD class="sum"><%= PERF_AMT %></TD>
	<TD class="sum"><%= NO_BAL %></TD>
	<TD class="sum"><%= AMT_BAL %></TD>
	<TD class="sum"><%= ACHV_PER %> </TD>
	  </TR>
	

  
    <%

}
rs.close();
db.close();
%>

  <TR>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD><DIV align="center">Grand Total : </DIV></TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD  class="total">&nbsp;</TD>
    <TD>&nbsp;</TD>
  </TR>
</TBODY>
<TFOOT>
</TFOOT>
 <TR>
    <TH><DIV align="center">Srno</DIV></TH>
    <TH><DIV align="center">Zone</DIV></TH>
    <TH><DIV align="center">Office Name </DIV></TH>
	
	<TH><DIV align="center">Financial Target Alloted </DIV></TH>
	<TH><DIV align="center">Physical Target Achieved</DIV></TH>
	<TH><DIV align="center">Financial Target Achieved</DIV></TH>
	<TH><DIV align="center">Physical Balance</DIV></TH>
	<TH><DIV align="center">Financial Balance</DIV></TH>
	<TH><DIV align="center">Achievement Percentage</DIV></TH>
  </TR>
</TABLE>
 <SCRIPT language="javascript" src="js/drilldowntotal.js"></SCRIPT>
</FORM>

</BODY>
</HTML>