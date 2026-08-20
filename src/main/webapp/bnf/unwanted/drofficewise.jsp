<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>UPDATE PERFORMANCE</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<img src="../images/01.jpg" width="100%" height="23%" />
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>

<style type="text/css">
<!--
.style7 {font-size: 9px}
-->
</style>


<style>
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


</style>

</head>
<body>

<div class="topnav">
<a class="active" href="index.jsp">CLICK HERE TO LOGIN</a>
<a class="active" href="dr.jsp">CLICK HERE TO GO BACK</a>

</div>



<form method="post" name="form">
<!--<a href="../jasperrop/bnfreport.jsp?REPNM=MPR_BFL&OFF_CD=&QRYCODE=0" class="buttonGreen" target="_blank" >View</a></div> -->
<%!
 
 public String geturl(String voffcd,String repnm,String qrycode) {
 
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
 
return ("../jasperrop/bnfreport.jsp?REPNM="+repnm+"&OFF_CD="+voffcd+"&QRYCODE="+qrycode);
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
<p align="center" class="style1 style7">OFFICEWISE PROGRESS REPORT UNDER BACKWARD AND FORWARD LINKAGES UNDER PMEGP FOR <%= POFF_NAME1 %></p>

  <table border="1" align="center">
  <thead>
  <tr>
    <th width="6%">Srno</th>
    <th hidden>Head Id </th>
    <th width="30%">Head</th>
    <th width="3%" hidden>Zone</th>
    <th width="4%" hidden>Office Name </th>
	
	<th width="8%">Physical Target Alloted (In Number)</th>
	<th width="8%">Financial Target Alloted (In Amt)</th>
	<th width="8%">Physical Target Achieved (In Number)</th>
	<th width="7%">Financial Target Achieved (In Amt)</th>
	<th width="5%">Physical Balance (In Number)</th>
	<th width="6%">Financial Balance (In Amt)</th>
	<th width="9%">View Details </th>
  </tr>
  </thead>
  <tbody>
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
BGT_NO=rs.getString("BGT_NO")==null?"":rs.getString("BGT_NO");
BGT_AMT=rs.getString("BGT_AMT")==null?"":rs.getString("BGT_AMT");
PERF_NO=rs.getString("PERF_NO")==null?"0":rs.getString("PERF_NO");
PERF_AMT=rs.getString("PERF_AMT")==null?"":rs.getString("PERF_AMT");
NO_BAL=rs.getString("NO_BAL")==null?"":rs.getString("NO_BAL");
AMT_BAL=rs.getString("AMT_BAL")==null?"":rs.getString("AMT_BAL");


%>

<% if (flag.equals("Y")){ %>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Zone Total : </td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
  
  </tr>
  <% } GROUP1_OLD=ZONE_NM;%>





  <tr>
    <td><%= count %></td>
	<td hidden><%= BNF_HDID %></td>
	<td><%= BNF_SUB_HEAD_SH_DESC %></td>
	<td hidden><%= ZONE_NM %></td>
	<td hidden><%=OFF_NAME1 %></a> </td>
    
	<td class="sum"><%= BGT_NO %></td>
	<td class="sum"><%= BGT_AMT %></td>
	<td class="sum"><%= PERF_NO %></td>
	<td class="sum"><%= PERF_AMT %></td>
	<td class="sum"><%= NO_BAL %></td>
	<td class="sum"><%= AMT_BAL %></td>
	<td> <a href=<%=geturl(OFF_CD,"",BNF_HDID) %> class="buttonGreen" target="_blank">View</a></td>
	  </tr>
	

  
    <%

}
rs.close();
db.close();
%>
  <tr>
    <td>&nbsp;</td>
    
    <td>Grand Total :</td>
    
    <td  class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
	
    
  </tr>
</tbody>
<tfoot>
</tfoot>
 <tr>
    <th>Srno</th>
    <th hidden>Head Id</th>
    <th>Head</th>
    <th hidden>Zone</th>
    <th hidden>Office Name </th>
	
	<th>Physical Target Alloted </th>
	<th>Financial Target Alloted </th>
	<th>Physical Target Achieved</th>
	<th>Financial Target Achieved</th>
	<th>Physical Balance</th>
	<th>Financial Balance</th>
	<th>View Details </th>
  </tr>
</table>
 <script language="javascript" src="../js/drilldowntotal.js"></script>
</form>

</body>
</html>