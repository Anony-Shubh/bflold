<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>
</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<script>

// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=800,width=1000,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}

</script>
</head>
<body>
<form  name="form" id="form" method="post" >

<%@ include file = "sessionoutinc.jsp" %>



<%

//PBNF_HDID=4
String POFF_CD=SOFF_CD;
String PBNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID");
String PBUD_ID=request.getParameter("PBUD_ID")==null?"0":(String)request.getParameter("PBUD_ID");
String PTR_DATE=request.getParameter("PTR_DATE")==null?"":(String)request.getParameter("PTR_DATE");
String PCB_FNO=request.getParameter("PCB_FNO")==null?"":(String)request.getParameter("PCB_FNO");
String BNF_HDID=request.getParameter("PBNF_HDID")==null?"0":(String)request.getParameter("PBNF_HDID");
String BNF_SUB_HEAD_LONG_DESC="";
String OFF_CD = POFF_CD;
String BNF_TRID = PBNF_TRID;
String BUD_ID = PBUD_ID;
String TR_DATE = PTR_DATE;

String CB_FNO = PCB_FNO;
String BNF_PLACE="";
String ADD_RMRK="";
String TIMESTAMP="";
String FIN_TOTAL="";
String PH_TOTAL="";
String add_update="I";

DBCon db= new DBCon();
db.connect();
List values=new ArrayList();


String qryname="SELECT BHM.BNF_HDID,BHM.BNF_SUB_HEAD_LONG_DESC FROM BNF_HEAD_MAST BHM WHERE BHM.BNF_HDID = ?";

values.add(BNF_HDID);

ResultSet rsname = db.executeSQL(qryname,values);
values.clear();


while (rsname.next()){
BNF_HDID=rsname.getString("BNF_HDID")==null?"":rsname.getString("BNF_HDID");
BNF_SUB_HEAD_LONG_DESC=rsname.getString("BNF_SUB_HEAD_LONG_DESC")==null?"":rsname.getString("BNF_SUB_HEAD_LONG_DESC");
}

rsname.close();

%>

<table>
<tr>
  <td colspan="7"><h1><div align="center"><%= BNF_SUB_HEAD_LONG_DESC %></div></h1></td>
  </tr>


<tr>
  <th width="10%">Sr no</th>
  <th width="16%">Trans ID </th>
  <th width="17%" >TR DATE:</th>
  <th width="20%">Phy. No </th>
  <th width="20%">Financial Amt </th>
  <th width="17%">Add New </th>
</tr>



<%


StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.OFF_CD,"      );
qrysb.append("     BFT.BNF_TRID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     TO_CHAR(BFT.TR_DATE,'DD-MON-RRRR') AS TR_DATE ,"      );
qrysb.append("      BFT.FIN_KVIC+BFT.FIN_KVIB+ BFT.FIN_DIC AS FIN_TOTAL,"      );
qrysb.append("     BFT.PH_KVIB+ BFT.PH_KVIC+BFT.PH_DIC AS PH_TOTAL,"      );
qrysb.append("     BFT.CB_FNO,"      );
qrysb.append("     BFT.BNF_PLACE,"      );
qrysb.append("     BFT.ADD_RMRK,"      );
qrysb.append("     BFT.TIMESTAMP"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE BFT.OFF_CD = ? AND BFT.BUD_ID=?"      );

  values.add(OFF_CD);
values.add(BNF_HDID);
  

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

int count=0;
while (rsMain.next()){
count=count+1;
BNF_TRID=rsMain.getString("BNF_TRID")==null?"0":rsMain.getString("BNF_TRID");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
BUD_ID=rsMain.getString("BUD_ID")==null?"":rsMain.getString("BUD_ID");
TR_DATE=rsMain.getString("TR_DATE")==null?"":rsMain.getString("TR_DATE");
FIN_TOTAL=rsMain.getString("FIN_TOTAL")==null?"":rsMain.getString("FIN_TOTAL");
PH_TOTAL=rsMain.getString("PH_TOTAL")==null?"":rsMain.getString("PH_TOTAL");
CB_FNO=rsMain.getString("CB_FNO")==null?"":rsMain.getString("CB_FNO");
BNF_PLACE=rsMain.getString("BNF_PLACE")==null?"":rsMain.getString("BNF_PLACE");
ADD_RMRK=rsMain.getString("ADD_RMRK")==null?"":rsMain.getString("ADD_RMRK");
TIMESTAMP=rsMain.getString("TIMESTAMP")==null?"":rsMain.getString("TIMESTAMP");

%>

<tr>
  <td><div align="center"><%= count %></div></td>
  <td><div align="center"><%= BNF_TRID %></div></td>
  <td><div align="center"><%=TR_DATE%></div></td>
  <td><div align="center"><%= PH_TOTAL %></div></td>
  <td><div align="center"><%= FIN_TOTAL %></div></td>
  <td><a href="JavaScript:newPopup('def_addedit.jsp?PBUDID=<%= BUD_ID %>');">
    <div style="height:100%;width:100%">
      <div align="center">UPDATE    </div>
    </div></td>
</tr>  


<%
}
rsMain.close();

db.close();

%>
</table>

</form>
</body>
</html>