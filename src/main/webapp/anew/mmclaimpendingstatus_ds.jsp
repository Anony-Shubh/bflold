<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE></TITLE>
    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <LINK href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</HEAD>


<BODY>

<FORM method="post" name="form">


  <%
List values=new ArrayList();
String STATE_CD=request.getParameter("STATE_CD")==null?"MH":(String)request.getParameter("STATE_CD");
String id=request.getParameter("id")==null?"":(String)request.getParameter("id");

//String id=request.getParameter("count"); 
//String buffer="<TD id='STATE_NM' ></TD>";

out.print(STATE_CD); 
out.print(id); 

//if (vlogin.equals("Y")){
 StringBuffer qrysb= new StringBuffer();
qrysb.append("   select STATE_NM,TOT_SANC,OWN_CONT_NOT,ROUND(NVL(OWN_CONT_NOT,0)/NVL(TOT_SANC,0)*100,2) AS OWN_PER,OWN_CONT_NOT_MM,"      );
qrysb.append("   LOAN_RELNOT,LOAN_RELNOT_MM,ROUND(NVL(LOAN_RELNOT,0)/NVL(TOT_SANC,0)*100,2) AS LOAN_RELNOT_PER,EDP_NOTCOMP"      );
qrysb.append("   "      );
qrysb.append("   from (SELECT  STATE_NM,"      );
qrysb.append("     COUNT(                                *)                         AS TOT_SANC,"      );
qrysb.append("     SUM(ROUND(MM_AMT_BANKSANC(MQR.APP_ID) / 100000, 2))              AS SANC_MM,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN TRUNC(MQR.OWN_CONT_DT) IS NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END, 0)) AS OWN_CONT_NOT,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN TRUNC(MQR.OWN_CONT_DT) IS NULL"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(MQR.APP_ID) / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END, 0)) AS OWN_CONT_NOT_MM,"      );
qrysb.append("   "      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN TRUNC(MQR.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(MQR.IST_LOAN_DT)  IS NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END, 0)) AS LOAN_RELNOT,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN TRUNC(MQR.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(MQR.IST_LOAN_DT)  IS NULL"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(MQR.APP_ID) / 100000, 2)"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END, 0)) AS LOAN_RELNOT_MM,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN TRUNC(MQR.EDP_CERT_DT) IS NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END, 0)) AS EDP_NOTCOMP"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT ad.APP_ID,"      );
qrysb.append("       ad.APP_NAME,"      );
qrysb.append("       MOM.OFF_NAME1,ms.state_nm,"      );
qrysb.append("       ZM.ZONE_NM,"      );
qrysb.append("       ad.BANK_NAME,"      );
qrysb.append("       ad.IFSC_CODE,"      );
qrysb.append("       bd.LOAN_SANC_DT,"      );
qrysb.append("       getfinyr(bd.LOAN_SANC_DT) AS LOAN_SANCT_YR,"      );
qrysb.append("       bd.WORKING_CAPITAL,"      );
qrysb.append("       bd.MACHINARY_COST,"      );
qrysb.append("       bd.OWN_CONTRIBUTION,"      );
qrysb.append("       NVL(bd.CE_SANC_FB, 0) CE_SANC_FB,"      );
qrysb.append("       NVL(bd.WC_SANC_FB, 0) WC_SANC_FB,"      );
qrysb.append("       bd.OWN_CONT_DT,"      );
qrysb.append("       bd.IST_LOAN_AMT,"      );
qrysb.append("       bd.IST_LOAN_DT,"      );
qrysb.append("       bd.EDP_TRG_NAME,"      );
qrysb.append("       bd.EDP_FR_DT,"      );
qrysb.append("       bd.EDP_TO_DT,"      );
qrysb.append("       bd.EDP_CERT_DT,DM.DISTRICT_NAME"      );
qrysb.append("     FROM app_detail ad,"      );
qrysb.append("       bank_dataentry bd,"      );
qrysb.append("       MAS_OFF_MAST MOM,"      );
qrysb.append("       M_DISTRICT DM,"      );
qrysb.append("       M_STATE MS,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ad.APP_ID       = bd.APP_ID(+)"      );
qrysb.append("     AND ad.UNIT_DIST_CD   = DM.DISTRICT_CD"      );
qrysb.append("     AND DM.STATE_CD       = MS.STATE_CD"      );
qrysb.append("     AND ad.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("     AND MS.ZONE_CD        = ZM.ZONE_CD"      );
qrysb.append("     AND (bd.LOAN_SANC_DT IS NOT NULL"      );
qrysb.append("     AND bd.ACT_ID         = 11"      );
qrysb.append("     AND TRUNC(bd.LOAN_SANC_DT) BETWEEN  '01-APR-2020' AND SysDate"      );
qrysb.append("     AND bd.MM_CLAIM_DT   IS NULL"      );
qrysb.append("     AND bd.LOAN_DOCFNAME IS NULL   AND MS.STATE_CD=?     )"      );
qrysb.append("     ) MQR"      );
qrysb.append("      GROUP BY STATE_NM"      );
qrysb.append("   order by STATE_NM)"      );

DBCon db= new DBCon();
db.connect();

values.add(STATE_CD);
//out.print(sb.toString());
ResultSet rs = db.executeSQL(qrysb.toString(),values);
//ResultSet rs = db.execSQL(qrysb.toString());

String STATE_NM="";
String TOT_SANC="";
String OWN_CONT_NOT="";
String OWN_PER="";
String OWN_CONT_NOT_MM="";
String LOAN_RELNOT="";
String LOAN_RELNOT_MM="";
String LOAN_RELNOT_PER="";
String EDP_NOTCOMP="";

%>

<input type="text" name="id" id="id" value="">
<input name="STATE_CD" type="text" id="STATE_CD" value="<%= STATE_CD %>">
<TABLE class="table table-striped" id="dataTable" width="50%" cellspacing="0">
  
  <TR>
    <TH width="5%"><DIV align="center">STATE_NM</DIV></TH>
    <TH width="6%"><DIV align="center">TOT_SANC</DIV></TH>
	<TH width="5%"><DIV align="center">OWN_CONT_NOT</DIV></TH>
    <TH width="6%"><DIV align="center">OWN_PER</DIV></TH>
	<TH width="5%"><DIV align="center">OWN_CONT_NOT_MM</DIV></TH>
    <TH width="6%"><DIV align="center">LOAN_RELNOT</DIV></TH>
	<TH width="5%"><DIV align="center">LOAN_RELNOT_MM</DIV></TH>
    <TH width="6%"><DIV align="center">LOAN_RELNOT_PER</DIV></TH>
    <TH width="6%"><DIV align="center">EDP_NOTCOMP</DIV></TH>
  
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;

STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
TOT_SANC=rs.getString("TOT_SANC")==null?"":rs.getString("TOT_SANC");
OWN_CONT_NOT=rs.getString("OWN_CONT_NOT")==null?"":rs.getString("OWN_CONT_NOT");
OWN_PER=rs.getString("OWN_PER")==null?"":rs.getString("OWN_PER");
OWN_CONT_NOT_MM=rs.getString("OWN_CONT_NOT_MM")==null?"":rs.getString("OWN_CONT_NOT_MM");
LOAN_RELNOT=rs.getString("LOAN_RELNOT")==null?"":rs.getString("LOAN_RELNOT");
LOAN_RELNOT_MM=rs.getString("LOAN_RELNOT_MM")==null?"":rs.getString("LOAN_RELNOT_MM");
LOAN_RELNOT_PER=rs.getString("LOAN_RELNOT_PER")==null?"":rs.getString("LOAN_RELNOT_PER");
EDP_NOTCOMP=rs.getString("EDP_NOTCOMP")==null?"":rs.getString("EDP_NOTCOMP");

%>
  <TR>
    <TD height="40"><DIV align="center"><%= STATE_NM %></DIV></TD>
	<TD ><DIV align="center"><%= TOT_SANC %></DIV></TD>
	<TD ><DIV align="center"><%= OWN_CONT_NOT %></DIV></TD>
	<TD ><DIV align="center"><%= OWN_PER %></DIV></TD>
	<TD ><DIV align="center"><%= OWN_CONT_NOT_MM %></DIV></TD>
	<TD ><DIV align="center"><%= LOAN_RELNOT %></DIV></TD>
	<TD ><DIV align="center"><%= LOAN_RELNOT_MM %></DIV></TD>
	<TD ><DIV align="center"><%= LOAN_RELNOT_PER %></DIV></TD>
	<TD ><DIV align="center"><%= EDP_NOTCOMP %></DIV></TD>
	
  
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