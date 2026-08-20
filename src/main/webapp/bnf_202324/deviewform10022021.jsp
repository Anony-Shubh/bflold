<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">
<SCRIPT>

// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=650,width=1000,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}

</SCRIPT>
<STYLE>
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
</STYLE>

</HEAD>
<BODY>
<FORM  name="form" id="form" method="post" >

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
String CONTYN="";
String CB_FNO = PCB_FNO;
String BNF_PLACE="";
String ADD_RMRK="";
String TIMESTAMP="";
String FIN_TOTAL="";
String PH_TOTAL="";
String add_update="I";
String DOCFNAME="";
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

<H1><DIV align="center"><%= BNF_SUB_HEAD_LONG_DESC %></DIV></H1>

  
  <DIV align="center">
    <%if(!sselect.equals("")){%>
      
    <A class="myButton" href="JavaScript:newPopup('bypass.jsp?PBUDID=<%= BNF_HDID %>&PBNF_TRID=<%= BNF_TRID %>&PBNF_DESC=<%= BNF_SUB_HEAD_LONG_DESC %>');">ADD NEW</A>
      
    <%}%>

	<%if((BNF_HDID.equals("12"))&&(!sselect.equals(""))){%>
	
	<A class="myButton" href="JavaScript:newPopup('tadapmegpconti.jsp');">ADD TA/DA AS CONTIGENCY</A>
	
	<%}%>
    </DIV><BR>

    <TABLE id="customers" class="customers" align="center">

<TR hidden>
  <TH colspan="3"><DIV align="center">TOTAL PHYSICAL BALANCE= <%= SNO_BAL %></DIV></TH>
  <TH colspan="4"><DIV align="center">TOTAL FINANCIAL BALANCE= <%= SAMT_BAL %></DIV></TH>
  <%if(!sselect.equals("2018-19")){%>
  <%}%>
</TR>
<TR>
  <TH width="8%"><DIV align="center">Sr no</DIV></TH>
  <TH width="13%"><DIV align="center">Trans ID </DIV></TH>
  <TH width="14%" ><DIV align="center">TR DATE:</DIV></TH>
  <TH width="17%"><DIV align="center">Phy. No </DIV></TH>
  <TH width="20%"><DIV align="center">Financial Amt </DIV></TH>
  <%if(sselect.equals("2020-21")){%>
  <TH width="11%"><DIV align="center">Update</DIV></TH> 
  <TH width="17%"><DIV align="center">Upload</DIV></TH>
  <%}%>
</TR>



<%


StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.OFF_CD,"      );
qrysb.append("     BFT.BNF_TRID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     TO_CHAR(BFT.TR_DATE,'DD-MON-RRRR') AS TR_DATE ,"      );
qrysb.append("      NVL(BFT.FIN_KVIC,0)+NVL(BFT.FIN_KVIB,0)+ NVL(BFT.FIN_DIC,0) AS FIN_TOTAL,"      );
qrysb.append("     NVL(BFT.PH_KVIB,0)+ NVL(BFT.PH_KVIC,0)+NVL(BFT.PH_DIC,0) AS PH_TOTAL,BFT.DOCFNAME,"      );
qrysb.append("     BFT.CB_FNO,"      );
qrysb.append("     BFT.BNF_PLACE,"      );
qrysb.append("     BFT.ADD_RMRK,"      );
qrysb.append("     CASE WHEN BFT.BNF_EVENT='TA/DA AS CONTIGENCY' THEN 'Y' END AS CONTYN,    "      );
qrysb.append("     BFT.TIMESTAMP"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE BFT.OFF_CD = ? AND BFT.BUD_ID=? AND BFT.YEAR_ID='"+sselect+"'"      );

  values.add(OFF_CD);
values.add(BNF_HDID);
 //out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

int count=0;
while (rsMain.next()){
count=count+1;
BNF_TRID=rsMain.getString("BNF_TRID")==null?"0":rsMain.getString("BNF_TRID");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
BUD_ID=rsMain.getString("BUD_ID")==null?"":rsMain.getString("BUD_ID");
TR_DATE=rsMain.getString("TR_DATE")==null?"":rsMain.getString("TR_DATE");
FIN_TOTAL=rsMain.getString("FIN_TOTAL")==null?"-":rsMain.getString("FIN_TOTAL");
PH_TOTAL=rsMain.getString("PH_TOTAL")==null?"":rsMain.getString("PH_TOTAL");
CB_FNO=rsMain.getString("CB_FNO")==null?"":rsMain.getString("CB_FNO");
BNF_PLACE=rsMain.getString("BNF_PLACE")==null?"":rsMain.getString("BNF_PLACE");
ADD_RMRK=rsMain.getString("ADD_RMRK")==null?"":rsMain.getString("ADD_RMRK");
TIMESTAMP=rsMain.getString("TIMESTAMP")==null?"":rsMain.getString("TIMESTAMP");
DOCFNAME=rsMain.getString("DOCFNAME")==null?"":rsMain.getString("DOCFNAME");
CONTYN=rsMain.getString("CONTYN")==null?"":rsMain.getString("CONTYN");
%>

<TR>
  <TD><DIV align="center"><%= count %></DIV></TD>
  <TD><DIV align="center"><%= BNF_TRID %></DIV></TD>
  <TD><DIV align="center"><%=TR_DATE%></DIV></TD>
  <TD><DIV align="center"><%= PH_TOTAL %></DIV></TD>
    <TD><DIV align="center"><%= FIN_TOTAL %></DIV></TD>
	
  <%  if (     (!sselect.equals(""))          ){%>
   
   <%if(CONTYN.equals("Y")){%>
  <TD>
   <A href="JavaScript:newPopup('tadapmegpconti.jsp?PBUDID=<%= BNF_HDID %>&BNF_TRID=<%= BNF_TRID %>');" class="myButton">UPDATE</A>
  </TD>
  <%}else {%>
   <TD>
  <a href="JavaScript:newPopup('bypass.jsp?PBUDID=<%= BNF_HDID %>&PBNF_TRID=<%= BNF_TRID %>&PBNF_DESC=<%= BNF_SUB_HEAD_LONG_DESC %>');" class="myButton">
    <DIV align="center"></DIV>
    <DIV style="height:100%;width:100%"> 
      <DIV align="center">UPDATE</DIV>
    </DIV>
	<%}%>
	
	
	</TD>	 <TD>
	 <%  if ((BUD_ID.equals("1"))||(BUD_ID.equals("2"))||(BUD_ID.equals("14"))){ %>
	 
	  <% if(DOCFNAME.equals("")){%>
  <a href="JavaScript:newPopup('edpphyupload.jsp?PBUDID=<%= BNF_HDID %>&PBNF_TRID=<%= BNF_TRID %>&PBNF_DESC=<%= BNF_SUB_HEAD_LONG_DESC %>');">
    <DIV style="height:100%;width:100%">
     	  
	  <DIV align="center" class="myButton">Upload</DIV>
	  </a>
	  <%} else{%>
		  
		 <A href="upload/<%=DOCFNAME%>" class="myButton" >Download</A>
	<% }}%>
	
	 </DIV></TD>
	 
	 <%}%>
	 
	 
	 
</TR>  


<%

}
rsMain.close();
db.close();

%>
</TABLE>
</FORM>
</BODY>
</HTML>