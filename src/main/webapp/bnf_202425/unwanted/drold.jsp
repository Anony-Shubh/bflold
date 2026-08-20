<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>UPDATE PERFORMANCE</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<img src="../images/01.jpg" width="100%" height="23%" />
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<style type="text/css">
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


</style>
</head>




<body>

<div class="topnav">
<a class="active" href="index.jsp">CLICK HERE TO LOGIN</a></div>

<div style="padding-left:16px">
</div>

<form method="post" name="form">
<p>
 
 
   
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
</p>


<p align="center" class="style1 style7">PROGRESS REPORT UNDER BACKWARD AND FORWARD LINKAGES UNDER PMEGP FOR THE YEAR 2018-19</p>
<p align="center">
    
    <span class="inner style4"><strong>Budget Head</strong></span><span class="style4">:
    <select name="budgethead" id="budgethead">
      <option value=">=0" <% if (budgethead.equals(">=0")){out.print("Selected");} %>>ALL</option>
      <option value="=1" <% if (budgethead.equals("=1")){out.print("Selected");} %>>EDP</option>
      <option value="=2" <% if (budgethead.equals("=2")){out.print("Selected");} %>>Physical Verification</option>
      <option value="=3" <% if (budgethead.equals("=3")){out.print("Selected");} %>>Dist. Level Awareness Camps</option>
      <option value="=4" <% if (budgethead.equals("=4")){out.print("Selected");} %>>State Level Workshop</option>
      <option value="=5" <% if (budgethead.equals("=5")){out.print("Selected");} %>>Dist. Level Exhibitions</option>
      <option value="=6" <% if (budgethead.equals("=6")){out.print("Selected");} %>>State Level Exhibition</option>
      <option value="=7" <% if (budgethead.equals("=7")){out.print("Selected");} %>>Zonal Level Exhibition</option>
      <option value="=8" <% if (budgethead.equals("=8")){out.print("Selected");} %>>Zonal Level Review Meeting</option>
      <option value="=9" <% if (budgethead.equals("=9")){out.print("Selected");} %>>Quarterly Bankers Review Meeting</option>
      <option value="=10" <% if (budgethead.equals("=10")){out.print("Selected");} %>>State Level Monitoring Committee Meeting</option>
      <option value="=11" <% if (budgethead.equals("=11")){out.print("Selected");} %>>Staff  Training Workshops</option>
      <option value="=12" <% if (budgethead.equals("=12")){out.print("Selected");} %>>TA/DA of staff & officers</option>
      <option value="=13" <% if (budgethead.equals("=13")){out.print("Selected");} %>>PROMOTIONAL AND PUBLICITY</option>
      <option value="=14" <% if (budgethead.equals("=14")){out.print("Selected");} %>>Data Entry Operators</option>
    </select>
    <input type="submit" name="Submit" onClick="copy();" value="Go">
  </span></p>
  <table border="1" align="center">
  <thead>
  <tr>
    <th width="8%">Srno</th>
    <th width="9%">Zone</th>
    <th width="15%">Office Name </th>
	
	<th width="12%">Physical Target Alloted (In Number)</th>
	<th width="12%">Financial Target Alloted (In Amt)</th>
	<th width="12%">Physical Target Achieved (In Number)</th>
	<th width="12%">Financial Target Achieved (In Amt)</th>
	<th width="12%">Physical Balance (In Number)</th>
	<th width="12%">Financial Balance (In Amt)</th>
	<th width="12%">Achievement Percentage</th>
  </tr>
  </thead>
  <tbody>
 
  
  
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
sb.append("       AND BBM.YEAR_ID    = '2018-19' AND BBM.BNF_HDID"+budgethead+""      );
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
sb.append("       FROM BNF_FO_TRANS BFT WHERE BFT.BUD_ID "+budgethead+""      );
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
NO_BAL=rs.getString("NO_BAL")==null?"":rs.getString("NO_BAL");
AMT_BAL=rs.getString("AMT_BAL")==null?"":rs.getString("AMT_BAL");
ACHV_PER=rs.getString("ACHV_PER")==null?"":rs.getString("ACHV_PER");

%>

<% if (flag.equals("Y")){ %>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Zone Total : </td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td  class="subtotal">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <% } GROUP1_OLD=ZONE_NM;%>





  <tr>
    <td><%= count %></td>
	<td><%= ZONE_NM %></td>
	<td><a href="drofficewise.jsp?POFF_CD=<%= OFF_CD %>&POFF_NAME1=<%= OFF_NAME1 %>"><%=OFF_NAME1 %></a> </td>
    
	<td class="sum"><%= BGT_NO %></td>
	<td class="sum"><%= BGT_AMT %></td>
	<td class="sum"><%= PERF_NO %></td>
	<td class="sum"><%= PERF_AMT %></td>
	<td class="sum"><%= NO_BAL %></td>
	<td class="sum"><%= AMT_BAL %></td>
	<td class="sum"><%= ACHV_PER %> </td>
	  </tr>
	

  
    <%

}
rs.close();
db.close();
%>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Grand Total : </td>
    <td  class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td  class="total">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</tbody>
<tfoot>
</tfoot>
 <tr>
    <th>Srno</th>
    <th>Zone</th>
    <th>Office Name </th>
	
	<th>Physical Target Alloted </th>
	<th>Financial Target Alloted </th>
	<th>Physical Target Achieved</th>
	<th>Financial Target Achieved</th>
	<th>Physical Balance</th>
	<th>Financial Balance</th>
	<th>Achievement Percentage</th>
  </tr>
</table>
 <script language="javascript" src="../js/drilldowntotal.js"></script>
</form>

</body>
</html>