<%@ page import="javax.sql.*,javax.naming.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="kvic.inputvalid.*"%>

<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />

</head>

<body>

<img src="images/pmegponlineN.jpg"  height="20%" width="100%">

<% 
jspinputvalid js = new jspinputvalid();
String YR=request.getParameter("YR")==null?"%%":(String) js.getOnlyTextspc(request.getParameter("YR"),7);
String vcls="";
if (YR.equals("2016-17")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2016' and '31-MAR-2017' ";
}

if (YR.equals("2017-18")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2017' and '31-MAR-2018' ";
}
if (YR.equals("2018-19")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2018' and '31-MAR-2019' ";
}
if (YR.equals("2019-20")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2019' and '31-MAR-2020' ";
}
if (YR.equals("2020-21")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2020' and TRUNC(SYSDATE) ";
}

if (YR.equals("2020-21")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2020' and '31-MAR-2021' ";
}

if (YR.equals("2021-22")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2021' and '31-MAR-2022' ";
}

if (YR.equals("2022-23")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2022' and '31-MAR-2023' ";
}
if (YR.equals("2023-24")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2023' and '31-MAR-2024' ";
}

if (YR.equals("2024-25")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2024' and  '31-MAR-2025' ";
}

if (YR.equals("2025-26")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2025' and  TRUNC(SYSDATE) ";
}


if (YR.equals("TOTAL")) {
vcls=" TRUNC(ad.BANK_F_DATE) BETWEEN '1-APR-2016' and TRUNC(SYSDATE) ";
}
Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);
String wcls="";
if (YR.equals("2016-17")) {
wcls=" 1-JULY-2016 TO 31-MARCH-2017 ";
}

if (YR.equals("2017-18")) {
wcls=" 1-APRIL-2017 TO 31-MARCH-2017 ";
}

if (YR.equals("2018-19")) {
wcls=" 1-APRIL-2018 TO 31-MARCH-2019 ";
}

if (YR.equals("2019-20")) {
wcls=" 1-APRIL-2019 TO 31-MARCH-2020 ";
}
if (YR.equals("2020-21")) {
wcls=" 1-APRIL-2020 TO 31-MAR-2021 ";
}

if (YR.equals("2021-22")) {
wcls=" 1-APRIL-2021 TO 31-MAR-2022 ";
}

if (YR.equals("2022-23")) {
wcls=" 1-APRIL-2022 TO 31-MAR-2023 ";
}

if (YR.equals("2023-24")) {
wcls=" 1-APRIL-2023 TO 31-MAR-2024 ";
}

if (YR.equals("2024-25")) {
wcls=" 1-APRIL-2024 TO 31-MAR-2025 ";
}

if (YR.equals("2025-26")) {
wcls=" 1-APRIL-2025 TO "+curdt+" ";
}

if (YR.equals("TOTAL")) {
wcls=" 1-JULY-2016 TO "+curdt+" ";
}
String STATE_NM = "";
String SC_APPNO = "";
String ST_APPNO = "";
String OBC_APPNO = "";
String GEN_APPNO = "";
String MIN_APPNO = "";
String CAT_TOT = "";
String STATE_CD= js.getOnlyTextspc(request.getParameter("STATE_CD"),2);
 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT NVL(DISTRICT_NAME,'Total:') as STATE_NM,MAX(STATE_NM) AS STATE_CD,"      );
qrysb.append("   SUM(SC_APPNO) AS SC_APPNO,"      );
qrysb.append("   SUM(ST_APPNO) AS ST_APPNO,"      );
qrysb.append("   SUM(OBC_APPNO) AS OBC_APPNO,"      );
qrysb.append("   SUM(GEN_APPNO) AS GEN_APPNO,"      );
qrysb.append("   SUM(MN_APPNO) AS MIN_APPNO,"      );
qrysb.append("   SUM(nvl(SC_APPNO,0)+"      );
qrysb.append("   nvl(ST_APPNO,0)+"      );
qrysb.append("   nvl(OBC_APPNO,0)+"      );
qrysb.append("   nvl(GEN_APPNO,0)+"      );
qrysb.append("   nvl(MN_APPNO,0)) AS CAT_TOT"      );
qrysb.append("   FROM("      );
qrysb.append("   WITH TBL AS "      );
qrysb.append("   (SELECT MS.STATE_NM,MS.STATE_CD,"      );
qrysb.append("     MD.DISTRICT_NAME,MD.DISTRICT_CD,AD.OFF_CD,"      );
qrysb.append("     BCM.BENF_CATEGORY_DESC,"      );
qrysb.append("     ad.BENF_CATAGORY_CD"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     bank_detail bd,"      );
qrysb.append("     app_meeting_mast amm,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS"      );
qrysb.append("   WHERE ad.MTG_ID         = amm.MTG_ID(+) AND AD.ACT_ID=5  "      );
qrysb.append("   AND ad.OFF_CD           = MOM.OFF_CD"      );
qrysb.append("   AND MOM.DISTRICT_CD     = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD         = MS.STATE_CD"      );
qrysb.append("   AND ad.APP_ID           = bd.APP_ID(+)"      );
qrysb.append("   AND ad.BENF_CATAGORY_CD = BCM.BENF_CATEGORY_CD and "      );
qrysb.append("   "+vcls+" ) ");
qrysb.append("   SELECT * FROM TBL"      );
qrysb.append("   PIVOT"      );
qrysb.append("   ("      );
qrysb.append("   COUNT (*) AS APPNO"      );
qrysb.append("   FOR"      );
qrysb.append("   (BENF_CATAGORY_CD)"      );
qrysb.append("   IN"      );
qrysb.append("   ('SC' AS SC,'ST' AS ST,'OBC' AS OBC,'GEN' AS GEN,'MN' AS MN))) WHERE STATE_CD='"+STATE_CD+"'"      );
qrysb.append("   GROUP BY ROLLUP(DISTRICT_NAME)"      );



//out.print (qrysb.toString());

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
 <center>
   <h1> No. of Applications Forwarded to Bank for the period from <%=wcls%>
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a>
</h1></center>
 <table align="center" class="bordered">
 <thead>
  <tr bgcolor="#FBDDF9">
    <td><div align="center">SR.NO.</div></td>
    <td><div align="center">DISTRICT</div></td>
    <td><div align="center">GENERAL</div></td>
    <td><div align="center">SC</div></td>
    <td><div align="center">ST</div></td>
    <td><div align="center">OBC</div></td>
      <td><div align="center">MINORITY</div></td>
      <td><div align="center">TOTAL</div></td>
  </tr>
   </thead>
   <tfoot>
   </tfoot>
<tbody>
<% 

int srno =0;
 while (rsMain.next()) { 
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
SC_APPNO=rsMain.getString("SC_APPNO")==null?"":rsMain.getString("SC_APPNO");
ST_APPNO=rsMain.getString("ST_APPNO")==null?"":rsMain.getString("ST_APPNO");
OBC_APPNO=rsMain.getString("OBC_APPNO")==null?"":rsMain.getString("OBC_APPNO");
GEN_APPNO=rsMain.getString("GEN_APPNO")==null?"":rsMain.getString("GEN_APPNO");
MIN_APPNO=rsMain.getString("MIN_APPNO")==null?"":rsMain.getString("MIN_APPNO");
CAT_TOT=rsMain.getString("CAT_TOT")==null?"":rsMain.getString("CAT_TOT");

srno =srno+1;


%>
<% if (srno<2) { %>
  <tr bgcolor="#FBDDF9">
    <td colspan="8"><h3 align="center"><%= STATE_CD %></h3></td>
    </tr>
	<%} %>
  <tr>
    <td><div align="center"><%= srno %></div></td>
    <td><div align="left"><%= STATE_NM %></div></td>
    <td><div align="center"><%= GEN_APPNO %></div></td>
    <td><div align="center"><%= SC_APPNO %></div></td>
    <td><div align="center"><%=ST_APPNO %></div></td>
    <td><div align="center"><%=OBC_APPNO %></div></td>
	<td><div align="center"><%= MIN_APPNO %></div></td>
	    <td><div align="center"><%= CAT_TOT %></div></td>
  </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
</table>

</body>
</html>
