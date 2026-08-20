<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>UPDATE PERFORMANCE</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">

<SCRIPT language="javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>

<STYLE type="text/css">
<!--
.style7 {font-size: 9px}
-->
</STYLE>


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
  float:right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}


</STYLE>

</HEAD>
<BODY>





<FORM method="post" name="form">
<%@ include file = "sessionoutinc.jsp" %>
<DIV class="topnav">

<A class="active" href="drin.jsp">CLICK HERE TO GO BACK</A>

</DIV>
<!--<a href="../jasperrop/bnfreport.jsp?REPNM=MPR_BFL&OFF_CD=&QRYCODE=0" class="buttonGreen" target="_blank" >View</a></div> -->
<%!
 
 public String geturl(String voffcd,String repnm,String qrycode, String YEAR_ID) {
 
 if (qrycode.equals("1")){ repnm="EDPREPO";}
 if (qrycode.equals("2")){ repnm="EDPREPO";}
 if (qrycode.equals("3")){ repnm="reportbnf";}
 if (qrycode.equals("4")){ repnm="reportbnf";}
 if (qrycode.equals("5")){ repnm="reportbnf";}
 if (qrycode.equals("6")){ repnm="reportbnf";}
 if (qrycode.equals("7")){ repnm="reportbnf";}
 if (qrycode.equals("8")){ repnm="reportbnf";}
 if (qrycode.equals("9")){ repnm="reportbnf";}
 if (qrycode.equals("10")){ repnm="reportbnf";}
 if (qrycode.equals("11")){ repnm="reportbnf";}
 if (qrycode.equals("12")){ repnm="TA_DA";}
 if (qrycode.equals("13")){ repnm="PUBLICITY";}
 if (qrycode.equals("14")){ repnm="EDPREPO";}
 
return ("jasperReports/bnfreportach.jsp?REPNM="+repnm+"&OFF_CD="+voffcd+"&QRYCODE="+qrycode+"&YEAR_ID="+YEAR_ID);
 }
 
%> 
   
<%

//out.print ( geturl("","",""));
List values=new ArrayList();
//if (vlogin.equals("Y")){
StringBuffer sb= new StringBuffer();
 
DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());

String POFF_CD=request.getParameter("POFF_CD")==null?"0":(String)request.getParameter("POFF_CD");
String POFF_NAME1=request.getParameter("POFF_NAME1")==null?"":(String)request.getParameter("POFF_NAME1");


String BNF_HDID="";
String BNF_SUB_HEAD_SH_DESC="";
String ZONE_NM="";
String OFF_CD="";
String OFF_NAME1="";
String BGT_NO="";
String BGT_AMT="";
String PERF_NO="";
String PERF_AMT="";
String NO_BAL="";
String AMT_BAL="";

//String budgethead=request.getParameter("budgethead")==null?">=0":(String)request.getParameter("budgethead").trim();  
//out.print(budgethead);
%>
</p>
<P align="center" class="style1 style7">OFFICEWISE PROGRESS REPORT UNDER BACKWARD AND FORWARD LINKAGES UNDER PMEGP FOR <%= POFF_NAME1 %></P>

  <TABLE border="1" align="center" id="customers">
  <THEAD>
  <TR>
    <TH width="6%"><DIV align="center">Srno</DIV></TH>
    <TH hidden><DIV align="center">Head Id </DIV></TH>
    <TH width="30%"><DIV align="center">Head</DIV></TH>
    <TH width="3%" hidden><DIV align="center">Zone</DIV></TH>
    <TH width="4%" hidden><DIV align="center">Office Name </DIV></TH>
	
	<TH width="8%"><DIV align="center">Physical Target Alloted (In Number)</DIV></TH>
	<TH width="8%"><DIV align="center">Financial Target Alloted (In Amt)</DIV></TH>
	<TH width="8%"><DIV align="center">Physical Target Achieved (In Number)</DIV></TH>
	<TH width="7%"><DIV align="center">Financial Target Achieved (In Amt)</DIV></TH>
	<TH width="5%"><DIV align="center">Physical Balance (In Number)</DIV></TH>
	<TH width="6%"><DIV align="center">Financial Balance (In Amt)</DIV></TH>
	<TH width="9%"><DIV align="center">View Details </DIV></TH>
  </TR>
  </THEAD>
  <TBODY>
  <%
  
  
sb.append("   SELECT MA.BNF_HDID,"      );
sb.append("     MA.BNF_SUB_HEAD_SH_DESC,"      );
sb.append("     MA.OFF_CD,"      );
sb.append("     MA.OFF_NAME1,"      );
sb.append("     MA.ZONE_NM,"      );
sb.append("     MA.BGT_NO,"      );
sb.append("     NVL(MA.BGT_AMT*100000,0) AS BGT_AMT,"      );
sb.append("     TR.PERF_NO,"      );
sb.append("     NVL(TR.PERF_AMT,0) AS PERF_AMT,"      );
sb.append("     NVL(MA.BGT_NO, 0) - NVL(TR.PERF_NO, 0)               AS NO_BAL,"      );
sb.append("     NVL(MA.BGT_AMT*100000, 0) - NVL(TR.PERF_AMT, 0) AS AMT_BAL,"      );
sb.append("     TR.BUD_ID"      );
sb.append("   FROM"      );
sb.append("     (SELECT TGT.BNF_SUB_HEAD_SH_DESC,"      );
sb.append("       TGT.ZONE_NM,"      );
sb.append("       TGT.BNF_HDID,"      );
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
sb.append("       AND BBM.YEAR_ID    = '2018-19'"      );
sb.append("       ) TGT"      );
sb.append("     GROUP BY TGT.BNF_SUB_HEAD_SH_DESC,"      );
sb.append("       TGT.ZONE_NM,"      );
sb.append("       TGT.BNF_HDID,"      );
sb.append("       TGT.OFF_CD,"      );
sb.append("       TGT.OFF_NAME1"      );
sb.append("     ORDER BY ZONE_NM"      );
sb.append("     ) MA,"      );
sb.append("     (SELECT PTR.OFF_CD,"      );
sb.append("       SUM(PTR.APHY_NO) AS PERF_NO,"      );
sb.append("       SUM(PTR.AFIN_AMT) PERF_AMT,"      );
sb.append("       PTR.BUD_ID"      );
sb.append("     FROM"      );
sb.append("       (SELECT BFT.OFF_CD,"      );
sb.append("         BFT.BUD_ID,"      );
sb.append("         BFT.TR_DATE,"      );
sb.append("         NVL(BFT.FIN_KVIC, 0) + NVL(BFT.FIN_DIC, 0) + NVL(BFT.FIN_KVIB, 0) AS AFIN_AMT,"      );
sb.append("         NVL(BFT.PH_KVIC, 0)  + NVL(BFT.PH_KVIB, 0) + NVL(BFT.PH_DIC, 0)   AS APHY_NO"      );
sb.append("       FROM BNF_FO_TRANS BFT"      );
sb.append("       INNER JOIN BNF_OFF_MAST BOM"      );
sb.append("       ON BFT.OFF_CD = BOM.OFF_CD"      );
sb.append("       INNER JOIN BNF_HEAD_MAST BHM"      );
sb.append("       ON BFT.BUD_ID = BHM.BNF_HDID"      );
sb.append("       ) PTR"      );
sb.append("     GROUP BY PTR.OFF_CD,"      );
sb.append("       PTR.BUD_ID"      );
sb.append("     ) TR"      );
sb.append("   WHERE MA.OFF_CD = TR.OFF_CD(+)"      );
sb.append("   AND MA.BNF_HDID = TR.BUD_ID(+)"      );
sb.append("   AND MA.OFF_CD   = ?"      );


values.add(POFF_CD);



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
	
BNF_HDID=rs.getString("BNF_HDID")==null?"":rs.getString("BNF_HDID");
BNF_SUB_HEAD_SH_DESC=rs.getString("BNF_SUB_HEAD_SH_DESC")==null?"":rs.getString("BNF_SUB_HEAD_SH_DESC");
OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
BGT_NO=rs.getString("BGT_NO")==null?"0":rs.getString("BGT_NO");
BGT_AMT=rs.getString("BGT_AMT")==null?"0":rs.getString("BGT_AMT");
PERF_NO=rs.getString("PERF_NO")==null?"0":rs.getString("PERF_NO");
PERF_AMT=rs.getString("PERF_AMT")==null?"0":rs.getString("PERF_AMT");
NO_BAL=rs.getString("NO_BAL")==null?"0":rs.getString("NO_BAL");
AMT_BAL=rs.getString("AMT_BAL")==null?"0":rs.getString("AMT_BAL");


%>

<% if (flag.equals("Y")){ %>
  <TR>
    <TD><DIV align="center"></DIV></TD>
    <TD><DIV align="center"></DIV></TD>
    <TD><DIV align="center"></DIV></TD>
    <TD><DIV align="center"></DIV></TD>
    <TD><DIV align="center">Zone Total : </DIV></TD>
    <TD  class="subtotal"><DIV align="center"></DIV></TD>
    <TD  class="subtotal"><DIV align="center"></DIV></TD>
    <TD  class="subtotal"><DIV align="center"></DIV></TD>
    <TD  class="subtotal"><DIV align="center"></DIV></TD>
    <TD  class="subtotal"><DIV align="center"></DIV></TD>
    <TD  class="subtotal"><DIV align="center"></DIV></TD>
  </TR>
  <% } GROUP1_OLD=ZONE_NM;%>





  <TR>
    <TD><DIV align="center"><%= count %></DIV></TD>
	<TD hidden><DIV align="center"><%= BNF_HDID %></DIV></TD>
	<TD><DIV align="center"><%= BNF_SUB_HEAD_SH_DESC %></DIV></TD>
	<TD hidden><DIV align="center"><%= ZONE_NM %></DIV></TD>
	<TD hidden><DIV align="center"><%=OFF_NAME1 %></a> </DIV></TD>
    
	<TD class="sum"><DIV align="center"><%= BGT_NO %></DIV></TD>
	<TD class="sum"><DIV align="center"><%= BGT_AMT %></DIV></TD>
	<TD class="sum"><DIV align="center"><%= PERF_NO %></DIV></TD>
	<TD class="sum"><DIV align="center"><%= PERF_AMT %></DIV></TD>
	<TD class="sum"><DIV align="center"><%= NO_BAL %></DIV></TD>
	<TD class="sum"><DIV align="center"><%= AMT_BAL %></DIV></TD>
	<TD> <DIV align="center"><A href=<%=geturl(OFF_CD,"",BNF_HDID,sselect) %> class="myButton" target="_blank">View</A></DIV></TD>
	  </TR>
	

  
    <%

}
rs.close();
db.close();
%>
  <TR>
    <TD><DIV align="center"></DIV></TD>
    
    <TD><DIV align="center">Grand Total :</DIV></TD>
    
    <TD  class="total"><DIV align="center"></DIV></TD>
    <TD  class="total"><DIV align="center"></DIV></TD>
    <TD  class="total"><DIV align="center"></DIV></TD>
    <TD class="total"><DIV align="center"></DIV></TD>
    <TD  class="total"><DIV align="center"></DIV></TD>
    <TD  class="total"><DIV align="center"></DIV></TD>
  </TR>
</TBODY>
<TFOOT>
</TFOOT>
 <TR>
    <TH><DIV align="center">Srno</DIV></TH>
    <TH hidden><DIV align="center">Head Id</DIV></TH>
    <TH><DIV align="center">Head</DIV></TH>
    <TH hidden><DIV align="center">Zone</DIV></TH>
    <TH hidden><DIV align="center">Office Name </DIV></TH>
	
	<TH><DIV align="center">Physical Target Alloted </DIV></TH>
	<TH><DIV align="center">Financial Target Alloted </DIV></TH>
	<TH><DIV align="center">Physical Target Achieved</DIV></TH>
	<TH><DIV align="center">Financial Target Achieved</DIV></TH>
	<TH><DIV align="center">Physical Balance</DIV></TH>
	<TH><DIV align="center">Financial Balance</DIV></TH>
	<TH><DIV align="center">View Details </DIV></TH>
  </TR>
</TABLE>
 <SCRIPT language="javascript" src="../js/drilldowntotal.js"></SCRIPT>
</FORM>

</BODY>
</HTML>