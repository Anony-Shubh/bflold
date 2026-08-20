<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %><HEAD>
<TITLE>Office Wise Target</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">

<SCRIPT type="text/javascript">

// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=500,width=1000,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}

</SCRIPT>
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



</STYLE>

<BODY>



<FORM method="post" name="form">

<%@ include file = "sessionoutinc.jsp" %>

<%
String PBUD_ID=request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");
String PBNF_NAME=request.getParameter("PBNF_NAME")==null?"":(String)request.getParameter("PBNF_NAME");



StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT"      );
qrysb.append("   OM.ZONE_NM,"      );
qrysb.append("   OM.OFF_CD,"      );
qrysb.append("    DT.BNF_BUDID,"      );
qrysb.append("    DT.BNF_HDID,"      );
qrysb.append("    DT.BNF_SUB_HEAD_SH_DESC,"      );

qrysb.append("     OM.STATE_NM,"      );
qrysb.append("     OM.ZONE_NM,"      );
qrysb.append("     OM.OFF_NAME1,"      );
qrysb.append("     DT.FIN_AMT,"      );
qrysb.append("     DT.PHY_NO"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT BNF_OFF_MAST.OFF_CD,"      );
qrysb.append("       BNF_OFF_MAST.ZONE_NM,"      );
qrysb.append("       BNF_OFF_MAST.STATE_NM,"      );
qrysb.append("       BNF_OFF_MAST.OFF_NAME1"      );
qrysb.append("     FROM BNF_OFF_MAST"      );
qrysb.append("     WHERE BNF_OFF_MAST.AGENCY_TYPE = 'KVIC'"      );
qrysb.append("     ORDER BY BNF_OFF_MAST.ZONE_NM"      );
qrysb.append("     ) OM,"      );
qrysb.append("     (SELECT BBM.OFF_CD,"      );
qrysb.append("       nvl(BBM.FIN_AMT_KVIC,0) + nvl(BBM.FIN_AMT_DIC,0) + nvl(BBM.FIN_AMT_KVIB,0) AS FIN_AMT,"      );
qrysb.append("       nvl(BBM.PHY_NO_KVIC,0)  + nvl(BBM.PHY_NO_KVIB,0) + nvl(BBM.PHY_NO_DIC,0)   AS PHY_NO,"      );
qrysb.append("       BBM.BNF_HDID ,BBM.YEAR_ID,"      );
qrysb.append("       BBM.BNF_BUDID,"      );
qrysb.append("       BHM.BNF_SUB_HEAD_SH_DESC"      );
qrysb.append("     FROM BNF_BUDGET_MAST BBM,"      );
qrysb.append("       BNF_HEAD_MAST BHM"      );
qrysb.append("     WHERE BBM.BNF_HDID = BHM.BNF_HDID(+) AND BBM.BNF_HDID="+PBUD_ID+"  AND  BBM.YEAR_ID='"+sselect+"'"      );
qrysb.append("     ) DT"      );
qrysb.append("   WHERE OM.OFF_CD = DT.OFF_CD(+) "      );
if(!sselect.equals("2018-19")){
qrysb.append("   AND OM.OFF_CD NOT IN (1570) "      );
}

//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();

ResultSet rs = db.execSQL(qrysb.toString());
 String ZONE_NM="";
 String OFF_CD="";
 String BNF_BUDID="";
 String BNF_HDID="";
 String BNF_SUB_HEAD_SH_DESC="";
 String STATE_NM="";
 String OFF_NAME1="";
 String FIN_AMT="";
 String PHY_NO="";
%>
<BR>

<TABLE border="1" align="center" id="customers">
  
  <TR>
    <TH colspan="8" bgcolor="#F0F0F0"><DIV align="center">Office wise Data Update form for <%= PBNF_NAME %> </DIV></TH>
    </TR>
  
  <TR>
    <TH width="8%" rowspan="2"><DIV align="center">Sr. No </DIV></TH>
    <TH width="15%" rowspan="2"><DIV align="center">Zone</DIV></TH>
    <TH width="40%" rowspan="2"><DIV align="center">Office Name </DIV></TH>
    <TH colspan="2"><DIV align="center">Target/Budget </DIV></TH>
		<%if(sselect.equals("2021-22")){%>
    <TH width="8%" rowspan="2"><DIV align="center">UPDATE</DIV></TH>
	<%}%>
  </TR>
  <TR>
    
    <TH width="11%"><DIV align="center">NO.</DIV></TH>
	<TH width="11%"><DIV align="center">AMT</DIV></TH>
	</TR>
  
<%
int c=0;
while (rs.next()) {
c=c+1;
ZONE_NM=rs.getString("ZONE_NM")==null?"":rs.getString("ZONE_NM");
  OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
  BNF_BUDID=rs.getString("BNF_BUDID")==null?"":rs.getString("BNF_BUDID");
  BNF_HDID=rs.getString("BNF_HDID")==null?"":rs.getString("BNF_HDID");
 BNF_SUB_HEAD_SH_DESC=rs.getString("BNF_SUB_HEAD_SH_DESC")==null?"":rs.getString("BNF_SUB_HEAD_SH_DESC");
 STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
  OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
 FIN_AMT=rs.getString("FIN_AMT")==null?"":rs.getString("FIN_AMT");
  PHY_NO=rs.getString("PHY_NO")==null?"":rs.getString("PHY_NO");
%>

  <TR>
    <TD><DIV align="center"><%= c %></DIV></TD>
	<TD><DIV align="center"><%= ZONE_NM  %></DIV></TD>
	<TD><DIV align="center"><%= OFF_NAME1  %></DIV></TD>
	<TD><%= PHY_NO %></TD>
	<TD><%= FIN_AMT %></TD>				<%if(sselect.equals("2024-25")){%>


	<TD>
  <A href="JavaScript:newPopup('tgt_addupdate.jsp?PBUDID=<%= PBUD_ID %>&POFFCD=<%= OFF_CD %>&PBNF_BUDID=<%= BNF_BUDID %>');">
    <DIV style="height:100%;width:100%">
      <DIV align="center" class="myButton">UPDATE    </DIV>
    </DIV>
  </A></TD><%}%>
	</TR>
  



<%

}
rs.close();
db.close();
%>
</TABLE>
</FORM>

</BODY>
</HTML>
