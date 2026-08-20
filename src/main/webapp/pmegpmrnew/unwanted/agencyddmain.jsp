<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="css/asc_css.css">

</HEAD>
<BODY>



<FORM  name="form" id="form" method="post" >

 <%
List values=new ArrayList();

//if (vlogin.equals("Y")){
StringBuffer sb= new StringBuffer();

sb.append("   SELECT AGENCY_TYPE, PREVYRPENDING, CURYRPENDING, PREVYRPENDING+CURYRPENDING AS TOTALPENDING, SCORECARDFILLUP, AGENCY_VERIFY,  "      );
sb.append("   VAR_SCORE_60PER, SIXTYPER_FORD, PENDING_TO_FORWAD FROM ( "      );

sb.append("   SELECT MOM.AGENCY_TYPE,"      );
sb.append("   SUM(CASE WHEN ACT_ID IN (0,1,2) AND "      );
sb.append("   TRUNC(ONLINE_SUBDT) <'01-APR-2020' "      );
sb.append("   THEN 1 END) AS PREVYRPENDING,"      );
sb.append("   SUM(CASE WHEN  "      );
sb.append("   TRUNC(ONLINE_SUBDT) >='01-APR-2020' "      );
sb.append("   THEN 1 END) AS CURYRPENDING,"      );
sb.append("   COUNT(PSC.APP_ID) AS SCORECARDFILLUP,"      );
sb.append("   SUM(CASE WHEN PSC.HO_VERIFY_YN='Y' THEN 1 END) AS AGENCY_VERIFY,"      );
sb.append("   SUM(CASE WHEN PSC.TOTAL_SCORE>=60 AND PSC.HO_VERIFY_YN='Y'  THEN 1 END) VAR_SCORE_60PER,"      );
sb.append("   SUM(CASE WHEN PSC.TOTAL_SCORE>=60 AND PSC.HO_VERIFY_YN='Y' AND ACT_ID=5 THEN 1 END) SIXTYPER_FORD,"      );
sb.append("   SUM(CASE WHEN PSC.TOTAL_SCORE>=60 AND PSC.HO_VERIFY_YN='Y' AND ACT_ID<> 5 THEN 1 END) PENDING_TO_FORWAD"      );
sb.append("   FROM APP_DETAIL AD,PMEGP_SCORE_CARD PSC,"      );
sb.append("   m_district dm, mas_off_mast mom,m_state ms,ZONE_MAST ZM "      );
sb.append("   WHERE AD.APP_ID=PSC.APP_ID(+)"      );
sb.append("   AND ad.unit_dist_cd=dm.district_cd and dm.state_cd=ms.state_cd "      );
sb.append("    and ad.off_cd=mom.off_cd(+) AND MS.zone_cd=ZM.zone_cd "      );
sb.append("    GROUP BY ROLLUP(MOM.AGENCY_TYPE) )"      );


DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());
//ResultSet rs = db.executeSQL(sb.toString(),values);
ResultSet rs = db.execSQL(sb.toString());

String AGENCY_TYPE="";
String PREVYRPENDING="";
String CURYRPENDING="";
String SCORECARDFILLUP="";
String AGENCY_VERIFY="";
String VAR_SCORE_60PER="";
String SIXTYPER_FORD="";
String PENDING_TO_FORWAD="";
String TOTALPENDING="";

%>
<BR>
<BR>
<CENTER>

<H2>DASHBOARD</H2>
<TABLE width="90%" id="customers">
<TR>
  <TH colspan="9"><DIV align="center">Application</DIV></TH>
</TR>
<TR>
  <TD width="14%" rowspan="2"><DIV align="center">Agency</DIV></TD>
  <TD colspan="3"><DIV align="center">Pending with Agency </DIV></TD>
  <TD width="10%" rowspan="2"><DIV align="center">Score Card Filled by Applicant</DIV></TD>
  <TD colspan="3"><DIV align="center">Score Card Validated by Implementing Agency  </DIV></TD>
  <TD width="15%" rowspan="2"><DIV align="center">Pending to Forwarded to Bank by IA </DIV></TD>
</TR>
<TR>
  <TD width="9%"><DIV align="center">Previous Year </DIV></TD>
  <TD width="9%"><DIV align="center">Current Year </DIV></TD>
  <TD width="9%"><DIV align="center">Total Pending </DIV></TD>
  <TD width="10%"><DIV align="center">Total Score Card Verified </DIV></TD>
  <TD width="12%"><DIV align="center">60 percent above </DIV></TD>
  <TD width="12%"><DIV align="center">Forwarded to Bank </DIV></TD>
  </TR>
  
  <TR>
    <TD><DIV align="center">A</DIV></TD>
    <TD><DIV align="center">B</DIV></TD>
    <TD><DIV align="center">C</DIV></TD>
    <TD><DIV align="center">D=B+C</DIV></TD>
    <TD><DIV align="center">E</DIV></TD>
    <TD><DIV align="center">F</DIV></TD>
    <TD><DIV align="center">G</DIV></TD>
    <TD><DIV align="center">H</DIV></TD>
    <TD><DIV align="center">I=G-H</DIV></TD>
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
AGENCY_TYPE=rs.getString("AGENCY_TYPE")==null?"TOTAL":rs.getString("AGENCY_TYPE");
PREVYRPENDING=rs.getString("PREVYRPENDING")==null?"":rs.getString("PREVYRPENDING");
CURYRPENDING=rs.getString("CURYRPENDING")==null?"":rs.getString("CURYRPENDING");
SCORECARDFILLUP=rs.getString("SCORECARDFILLUP")==null?"":rs.getString("SCORECARDFILLUP");
AGENCY_VERIFY=rs.getString("AGENCY_VERIFY")==null?"":rs.getString("AGENCY_VERIFY");
VAR_SCORE_60PER=rs.getString("VAR_SCORE_60PER")==null?"":rs.getString("VAR_SCORE_60PER");
SIXTYPER_FORD=rs.getString("SIXTYPER_FORD")==null?"":rs.getString("SIXTYPER_FORD");
PENDING_TO_FORWAD=rs.getString("PENDING_TO_FORWAD")==null?"":rs.getString("PENDING_TO_FORWAD");
TOTALPENDING=rs.getString("TOTALPENDING")==null?"":rs.getString("TOTALPENDING");


%>


  <TR>
    <TD><DIV align="left"><A href="agencydd.jsp?AGENCY_TYPE=<%= AGENCY_TYPE %>&PARAID=1"><%= AGENCY_TYPE %></DIV></A></TD>
    <TD><DIV align="center"><%= PREVYRPENDING %></DIV></TD>
    <TD><DIV align="center"><%= CURYRPENDING %></DIV></TD>
    <TD><DIV align="center"><%= TOTALPENDING %></DIV></TD>
    <TD><DIV align="center"><%= SCORECARDFILLUP %></DIV></TD>
    <TD><DIV align="center"><%= AGENCY_VERIFY %></DIV></TD>
    <TD><DIV align="center"><%= VAR_SCORE_60PER %></DIV></TD>
    <TD><DIV align="center"><%= SIXTYPER_FORD %></DIV></TD>
    <TD><DIV align="center"><%= PENDING_TO_FORWAD %></DIV></TD>
  </TR>
  

<%
}
rs.close();
db.close();
%>
</TABLE>

</CENTER>
</FORM>
</BODY>
</HTML>