<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<HEAD>
<TITLE> Pending for EDP Training </TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/lov.css" />
</HEAD>
<BODY>
<FORM>

   <%@include file="AppIncludePage.jsp"%>
  
  <%
  String pState=request.getParameter("STATE")==null?"":request.getParameter("STATE");
   StringBuffer qrysb= new StringBuffer();
 String vcls="";
  if (!pState.equals("TOTAL")) {
vcls=vcls+"  AND MS.STATE_NM = '"+pState+"'  ";
}
/*
qrysb.append("   SELECT STATE_CD,"      );
qrysb.append("     NO_OF_APP,"      );
qrysb.append("     EDP_CERT_UPLOADED,"      );
qrysb.append("     NVL(NO_OF_APP, 0) - NVL(EDP_CERT_UPLOADED, 0) AS EDP_CERT_NOT_UPLOADED,"      );
qrysb.append("     EDP_BANK_VERIFIED,"      );
qrysb.append("     EDP_BANK_VERIFIED_NOT,"      );
qrysb.append("     DISTRICT_NAME"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT NVL(DISTRICT_NAME, 'TOTAL') AS DISTRICT_NAME,"      );
qrysb.append("       NVL(MAX(STATE_CD), 'TOTAL')  AS STATE_CD,"      );
qrysb.append("       SUM(NO_OF_APP)               AS NO_OF_APP,"      );
qrysb.append("       SUM(EDPUPLOADED)             AS EDP_CERT_UPLOADED,"      );
qrysb.append("       SUM(BANK_VERIFIED)           AS EDP_BANK_VERIFIED,"      );
qrysb.append("       SUM(BANK_NOT_VERIFIED)       AS EDP_BANK_VERIFIED_NOT"      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT MS.STATE_NM,"      );
qrysb.append("         MS.STATE_CD,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("         CASE"      );
qrysb.append("           WHEN BD.ACT_ID = 11"      );
qrysb.append("           THEN 1"      );
qrysb.append("         END, 0)) AS tot_no_app,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("         (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID"      );
qrysb.append("         ), 0)) AS EDPUPLOADED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("          (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NULL"      );
qrysb.append("         ), 0)) AS BANK_NOT_VERIFIED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("               (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NOT NULL), 0)) AS BANK_VERIFIED,bd.EDP_CERT_DT,"      );
qrysb.append("         MD.DISTRICT_NAME,"      );
qrysb.append("         COUNT(*) AS NO_OF_APP"      );
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("         BANK_DATAENTRY BD,"      );
qrysb.append("         MAS_OFF_MAST MOM,"      );
qrysb.append("         M_STATE MS,"      );
qrysb.append("         M_DISTRICT MD"      );
qrysb.append("       WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("       AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("       AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("       AND MD.STATE_CD     = MS.STATE_CD"      );
qrysb.append("       AND BD.ACT_ID      = 11  "+vcls+""      );
qrysb.append("       GROUP BY MS.STATE_NM,"      );
qrysb.append("         MS.STATE_CD,"      );
qrysb.append("         MD.DISTRICT_NAME,BD.EDP_CERT_DT"      );
qrysb.append("       )"      );
qrysb.append("     GROUP BY STATE_NM,ROLLUP(DISTRICT_NAME)"      );
qrysb.append("     )"      );
//qrysb.append("   ORDER BY NO_OF_APP DESC"      );



*/



qrysb.append("   SELECT STATE_CD,"      );
qrysb.append("     NO_OF_APP,"      );
qrysb.append("     EDP_CERT_UPLOADED,"      );
qrysb.append("     NVL(NO_OF_APP, 0) - NVL(EDP_CERT_UPLOADED, 0) AS EDP_CERT_NOT_UPLOADED,"      );
qrysb.append("     EDP_BANK_VERIFIED,"      );
qrysb.append("     EDP_BANK_VERIFIED_NOT,"      );
qrysb.append("     DISTRICT_NAME"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT NVL(DISTRICT_NAME, 'TOTAL') AS DISTRICT_NAME,"      );
qrysb.append("       NVL(MAX(STATE_CD), 'TOTAL')       AS STATE_CD,"      );
qrysb.append("       SUM(NO_OF_APP)                    AS NO_OF_APP,"      );
qrysb.append("       SUM(EDPUPLOADED)                  AS EDP_CERT_UPLOADED,"      );
qrysb.append("       SUM(BANK_VERIFIED)                AS EDP_BANK_VERIFIED,"      );
qrysb.append("       SUM(BANK_NOT_VERIFIED)            AS EDP_BANK_VERIFIED_NOT"      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT MS.STATE_NM,"      );
qrysb.append("         MS.STATE_CD,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("         CASE"      );
qrysb.append("           WHEN BD.ACT_ID = 11"      );
qrysb.append("           THEN 1"      );
qrysb.append("         END, 0)) AS tot_no_app,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("         (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID"      );
qrysb.append("         ), 0)) AS EDPUPLOADED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("          (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8  AND AUT.DOC_ACTYN='Y' "      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NULL"      );
qrysb.append("         ), 0)) AS BANK_NOT_VERIFIED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("               (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8  AND AUT.DOC_ACTYN='Y' "      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NOT NULL), 0)) AS BANK_VERIFIED,bd.EDP_CERT_DT,"      );
qrysb.append("         MD.DISTRICT_NAME,"      );
qrysb.append("       "      );
qrysb.append("         COUNT(*) AS NO_OF_APP"      );
qrysb.append("       FROM APP_DETAIL AD,"      );
qrysb.append("         BANK_DATAENTRY BD,"      );
qrysb.append("         MAS_OFF_MAST MOM,"      );
qrysb.append("         M_STATE MS,"      );
qrysb.append("         M_DISTRICT MD"      );
qrysb.append("       WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("       AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("       AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("       AND MD.STATE_CD     = MS.STATE_CD"      );
qrysb.append("       AND (BD.ACT_ID      = 11"      );
qrysb.append("      "+vcls+" )"      );
qrysb.append("       GROUP BY MS.STATE_NM,"      );
qrysb.append("         MS.STATE_CD,"      );
qrysb.append("         MD.DISTRICT_NAME,bd.EDP_CERT_DT"      );
qrysb.append("       )"      );
qrysb.append("     GROUP BY STATE_NM,"      );
qrysb.append("       ROLLUP(DISTRICT_NAME)"      );
qrysb.append("     )"      );











/*

 qrysb.append(" SELECT DISTRICT_NAME,STATE_CD,NO_OF_APP,EDP_CERT_UPLOADED,NVL(NO_OF_APP,0)-NVL(EDP_CERT_UPLOADED,0) AS EDP_CERT_NOT_UPLOADED, ");


  qrysb.append(" EDP_BANK_VERIFIED,EDP_BANK_VERIFIED_NOT FROM ( ");
  
  
  qrysb.append("  SELECT NVL(DISTRICT_NAME,'TOTAL') AS DISTRICT_NAME, NVL(MAX(STATE_CD),'TOTAL')  AS STATE_CD,SUM(NO_OF_APP) AS NO_OF_APP,"      );
qrysb.append(" sum(EDPUPLOADED)AS EDP_CERT_UPLOADED ,sum(BANK_VERIFIED)AS EDP_BANK_VERIFIED, SUM(BANK_NOT_VERIFIED)          AS EDP_BANK_VERIFIED_NOT FROM "      );
qrysb.append(" ( SELECT MS.STATE_NM,MS.STATE_CD, sum( nvl(case when bd.act_id=11 then 1 end ,0)) as tot_no_app ,"      );
qrysb.append(" SUM(NVL((SELECT COUNT(DISTINCT(APP_ID)) FROM APP_UPLOAD_TRANS AUT WHERE UPM_CD=8 AND AUT.APP_ID=BD.APP_ID),0)) AS EDPUPLOADED,"      );
/*qrysb.append("         SUM(NVL("      );
qrysb.append("          (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NULL"      );
qrysb.append("         ), 0)) AS BANK_NOT_VERIFIED,"      );
qrysb.append("         SUM(NVL("      );
qrysb.append("               (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
qrysb.append("         FROM APP_UPLOAD_TRANS AUT"      );
qrysb.append("         WHERE AUT.UPM_CD = 8"      );
qrysb.append("         AND AUT.APP_ID   = BD.APP_ID AND BD.EDP_CERT_DT IS NOT NULL), 0)) AS BANK_VERIFIED,bd.EDP_CERT_DT,"      );

qrysb.append(" SUM(NVL(    CASE      WHEN BD.EDP_CERT_DT IS  NULL      AND BD.ACT_ID        = 11      THEN 1    END, 0)) AS BANK_NOT_VERIFIED,"      );
qrysb.append(" sum( nvl(case when bd.edp_cert_dt IS NOT NULL and bd.act_id=11 then 1 end ,0)) as BANK_VERIFIED,"      );
qrysb.append(" MD.DISTRICT_NAME, COUNT(*) AS NO_OF_APP FROM APP_DETAIL AD, BANK_DATAENTRY BD,"      );
qrysb.append(" MAS_OFF_MAST MOM, M_STATE MS, M_DISTRICT MD WHERE AD.APP_ID = BD.APP_ID AND"      );
qrysb.append(" AD.OFF_CD = MOM.OFF_CD AND AD.UNIT_DIST_CD = MD.DISTRICT_CD AND "      );
qrysb.append(" MD.STATE_CD = MS.STATE_CD AND BD.ACT_ID = 11 "+vcls+"  GROUP BY MS.STATE_NM,MS.STATE_CD, MD.DISTRICT_NAME) GROUP BY STATE_NM,ROLLUP(DISTRICT_NAME)) "      );













  qrysb.append(" SELECT NVL(DISTRICT_NAME, 'TOTAL') AS DISTRICT_NAME,            " ); 
   qrysb.append(" MAX(STATE_CD)      AS STATE_CD,"      );
   qrysb.append(" SUM(NO_OF_APP)     AS NO_OF_APP,"      );
   qrysb.append(" SUM(EDPUPLOADED)   AS EDP_CERT_UPLOADED,"      );
   qrysb.append(" SUM(BANK_VERIFIED) AS EDP_BANK_VERIFIED"      );
 qrysb.append(" FROM"      );
   qrysb.append(" (SELECT MS.STATE_NM,"      );
     qrysb.append(" MS.STATE_CD,"      );
     qrysb.append(" SUM(NVL("      );
     qrysb.append(" CASE"      );
      qrysb.append("  WHEN BD.ACT_ID = 11"      );
      qrysb.append("  THEN 1"      );
    qrysb.append(" END, 0)) AS tot_no_app,"      );
    qrysb.append("  SUM(NVL("      );
    qrysb.append("  (SELECT COUNT(DISTINCT (AUT.APP_ID))"      );
    qrysb.append("  FROM APP_UPLOAD_TRANS AUT"      );
    qrysb.append(" WHERE AUT.UPM_CD = 8"      );
    qrysb.append("  AND AUT.APP_ID   = BD.APP_ID"      );
    qrysb.append("    ), 0)) AS EDPUPLOADED,"      );
     qrysb.append(" SUM(NVL("      );
     qrysb.append(" CASE"      );
      qrysb.append("  WHEN BD.EDP_CERT_DT IS NOT NULL"      );
      qrysb.append("  AND BD.ACT_ID        = 11"      );
       qrysb.append(" THEN 1"      );
     qrysb.append(" END, 0)) AS BANK_VERIFIED,"      );
     qrysb.append(" MD.DISTRICT_NAME,"      );
   qrysb.append("   COUNT(*) AS NO_OF_APP"      );
  qrysb.append("  FROM APP_DETAIL AD,"      );
    qrysb.append("  BANK_DATAENTRY BD,"      );
    qrysb.append("  MAS_OFF_MAST MOM,"      );
    qrysb.append("  M_STATE MS,"      );
    qrysb.append("  M_DISTRICT MD"      );
   qrysb.append(" WHERE AD.APP_ID     = BD.APP_ID"      );
  qrysb.append("  AND AD.OFF_CD       = MOM.OFF_CD"      );
   qrysb.append(" AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
   qrysb.append(" AND MD.STATE_CD     = MS.STATE_CD"      );
  qrysb.append("  AND BD.ACT_ID       = 11"      );
  qrysb.append("  "+vcls+"          "      );
   qrysb.append(" GROUP BY MS.STATE_NM,"      );
    qrysb.append("  MS.STATE_CD,"      );
    qrysb.append("  MD.DISTRICT_NAME"      );
   qrysb.append(" )"      );
 qrysb.append(" GROUP BY STATE_NM,ROLLUP(DISTRICT_NAME)"      );


*/
//out.print (qrysb.toString());
  DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
int recCount=0;
String STATE_NM="";
String DISTRICT_NAME="";
String NO_OF_APP="";
String EDP_CERT_UPLOADED="";
String EDP_BANK_VERIFIED="";
String EDP_BANK_VERIFIED_NOT="";
String EDP_CERT_NOT_UPLOADED="";
%>
<TABLE  border="1" cellpadding="3" cellspacing="3" class="bordered">
  <TR>
    <TH colspan="7" scope="row"><DIV align="center">Applications Sanctioned by Bank and Pending for EDP Training</DIV></TH>
    </TR>
  <TR>
    <TH colspan="2" scope="row">State Name: </TH>
    <TH colspan="5"><DIV align="left"><H2 align="center"><%= pState %></H2>
    </DIV></TH>
    </TR>
  <TR>
    <TH scope="row">Sr. No. </TH>
    <TH>District Name </TH>
    <TH><P>No of Application</P>
      <P>Sanctioned</P></TH>
    <TH><P align="center">No of EDP Certificate</P>
      <P align="center">Uploaded </P></TH>
	   <TH><P align="center">No of EDP Certificate</P>
      <P align="center">Not Uploaded </P></TH>
    <TH>No of EDP Certificate Uploaded and verified by Bank </TH>
	 <TH>No of EDP Certificate Uploaded yet Not verified by Bank </TH>
    </TR>
<%
   while (rsMain.next()) { 
   recCount=recCount+1;
 STATE_NM=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 //DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
 NO_OF_APP=rsMain.getString("NO_OF_APP")==null?"":rsMain.getString("NO_OF_APP");
  EDP_CERT_UPLOADED=rsMain.getString("EDP_CERT_UPLOADED")==null?"":rsMain.getString("EDP_CERT_UPLOADED");
 EDP_BANK_VERIFIED=rsMain.getString("EDP_BANK_VERIFIED")==null?"":rsMain.getString("EDP_BANK_VERIFIED");
  EDP_BANK_VERIFIED_NOT =rsMain.getString("EDP_BANK_VERIFIED_NOT")==null?"":rsMain.getString("EDP_BANK_VERIFIED_NOT");
 EDP_CERT_NOT_UPLOADED=rsMain.getString("EDP_CERT_NOT_UPLOADED")==null?"":rsMain.getString("EDP_CERT_NOT_UPLOADED");
  
  %>

  <TR>
    <TD><%= recCount %></TD>
    <TD><%= STATE_NM %></TD>
    <TD><%= NO_OF_APP %></TD>
    <TD><%= EDP_CERT_UPLOADED %></TD>
	<TD><%= EDP_CERT_NOT_UPLOADED %></TD>
    <TD><%= EDP_BANK_VERIFIED %></TD>
	 <TD><%= EDP_BANK_VERIFIED_NOT %></TD>
  </TR>
  <%
   }
  rsMain.close();
  db.close();
  
  
  %>
</TABLE>

</FORM>
</BODY>