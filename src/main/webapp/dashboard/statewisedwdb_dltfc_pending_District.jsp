<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />

</head>

<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
<form>
<% 

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
DateFormat df1 = new SimpleDateFormat("dd-MMM-yyyy");
String todayDt=df1.format(now);
String curdt = df.format(now);
String vStatecd=request.getParameter("STATE_CD");
 StringBuffer qrysb= new StringBuffer();
 
String vwherecls="";
String vfromdt=request.getParameter("FROMDT")==null?"01-JUL-2016":(String)request.getParameter("FROMDT");
String vtodt=request.getParameter("TODT")==null?todayDt:(String)request.getParameter("TODT");
String vagency=request.getParameter("AGENCY")==null?"ALL":(String)request.getParameter("AGENCY");

if (!vagency.equals("ALL")) {
vwherecls=vwherecls + " AND MOM.AGENCY_TYPE= '"+vagency+"' ";
}
/*
qrysb.append("   SELECT "      );
qrysb.append("   Nvl(DISTRICT_NAME,'TOTAL') AS STATE_NM,"      );
qrysb.append("   MAX(STATE_CD) AS STATE_CD,"      );
qrysb.append("   SUM(NO_OF_APP) AS NO_OF_APP,"      );
qrysb.append("   SUM(UPTO15DAY) AS UPTO15DAY,"      );
qrysb.append("   SUM(PEND_30DAY) AS PEND_30DAY,"      );
qrysb.append("   SUM(PEND_30TO45DAY) AS PEND_30TO45DAY,"      );
qrysb.append("   SUM(PEND_ABOVE45DAYS) AS PEND_ABOVE45DAYS"      );
qrysb.append("   "      );
qrysb.append("   FROM ("      );
qrysb.append("   SELECT MS.STATE_NM,MAX(MS.STATE_CD) AS STATE_CD,MD.DISTRICT_NAME,"      );
qrysb.append("     COUNT(AD.APP_ID) NO_OF_APP,"      );
qrysb.append("    SUM(CASE WHEN AD.ACT_ID=3 THEN 1 ELSE 0 END) AS UPTO15DAY,"      );
qrysb.append("     SUM(CASE WHEN  (AD.FORD_DT_DLTFC IS NOT NULL OR AD.MTG_ID IS NOT NULL)  THEN 1 ELSE 0 END) PEND_30DAY,"      );
qrysb.append("      SUM(CASE WHEN  ACT_ID IN (4,5)  THEN 1 ELSE 0 END) PEND_30TO45DAY,"      );
qrysb.append("      COUNT(DISTINCT(AMM.MT_DATE)) AS PEND_ABOVE45DAYS"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     APP_MEETING_MAST AMM,"      );
qrysb.append("     MAS_OFF_MAST MOM"      );
qrysb.append("   WHERE AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD       = MS.STATE_CD"      );
qrysb.append("   AND AD.MTG_ID         = AMM.MTG_ID(+) AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+vfromdt+"' AND '"+vtodt+"' "      );
qrysb.append("   AND AD.OFF_CD=MOM.OFF_CD AND MS.STATE_CD='"+vStatecd+"'  "+vwherecls+" "      );
qrysb.append("   GROUP BY MD.DISTRICT_NAME,MS.STATE_NM ORDER BY MS.STATE_NM,MD.DISTRICT_NAME)"      );
qrysb.append("   GROUP BY ROLLUP(DISTRICT_NAME)"      );
*/

qrysb.append("   SELECT NVL(DISTRICT_NAME, 'TOTAL') AS STATE_NM,"      );
qrysb.append("     MAX(STATE_CD)               AS STATE_CD,"      );
qrysb.append("    COUNT(APP_ID)  AS NO_OF_APP,"      );
qrysb.append("    SUM(CASE WHEN NO_OF_DAYS_PENDING BETWEEN 0 AND 15 THEN 1 ELSE 0 END) AS UPTO15DAY,"      );
qrysb.append("     SUM(CASE WHEN NO_OF_DAYS_PENDING BETWEEN 16 AND 30 THEN 1 ELSE 0 END) AS PEND_30DAY,"      );
qrysb.append("     SUM(CASE WHEN NO_OF_DAYS_PENDING BETWEEN 31 AND 45 THEN 1 ELSE 0 END) AS PEND_30TO45DAY,"      );
qrysb.append("    SUM(CASE WHEN NO_OF_DAYS_PENDING >45 THEN 1 ELSE 0 END) AS PEND_ABOVE45DAYS"      );
qrysb.append("   FROM"      );
qrysb.append("     ("      );
qrysb.append("     SELECT "      );
qrysb.append("     AD.APP_ID,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     UPPER(AD.APP_NAME) AS APP_NAME,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("      MS.STATE_CD,"      );
qrysb.append("       MD.DISTRICT_NAME,"      );
qrysb.append("     TRUNC(SYSDATE)- TRUNC(AD.FORD_DT_DLTFC) AS NO_OF_DAYS_PENDING ,"      );
qrysb.append("      AD.ACT_ID"      );
qrysb.append("     FROM APP_DETAIL AD,"      );
qrysb.append("       M_DISTRICT MD,"      );
qrysb.append("       M_STATE MS,"      );
qrysb.append("       MAS_OFF_MAST MOM"      );
qrysb.append("     WHERE AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("     AND MD.STATE_CD       = MS.STATE_CD"      );
qrysb.append("     AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("     AND TRUNC(AD.FORD_DT_DLTFC) BETWEEN '"+vfromdt+"' AND '"+vtodt+"'"      );
qrysb.append("     AND AD.ACT_ID =2 AND AD.FORD_DT_DLTFC IS NOT NULL  "+vwherecls+" AND MS.STATE_CD='"+vStatecd+"'"      );
qrysb.append("     GROUP BY"      );
qrysb.append("      AD.APP_ID,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     UPPER(AD.APP_NAME),"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("      MS.STATE_CD,"      );
qrysb.append("       MD.DISTRICT_NAME,"      );
qrysb.append("     TRUNC(SYSDATE)- TRUNC(AD.FORD_DT_DLTFC),"      );
qrysb.append("       AD.ACT_ID"      );
qrysb.append("     )"      );
qrysb.append("   GROUP BY ROLLUP(DISTRICT_NAME)"      );


String STATE_NM = "";
String DISTRICT_NAME = "";
String NO_OF_APP = "";
String UPTO15DAY = "";
String PEND_30DAY = "";
String PEND_30TO45DAY = "";
String PEND_ABOVE45DAYS = "";

String STATE_CD="";
//out.print (qrysb.toString());

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
<center>
  <h1>  Pending with DLTFC Report Generate Date <%= curdt %>
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a>
</h1>
  </center>

 <table align="center" class="bordered">
 <thead>
  <tr>
      <th rowspan="3"><div align="center">SRNO</div></th>
      <th rowspan="3"><div align="center">Name </div></th>
      <th>Agency:<%= vagency %></th>
      <th>&nbsp;</th>
      <th>From Date: <%= vfromdt %></th>
      <th>To Date:<%= vtodt %></th>
      <th rowspan="3"><div align="center">Above 45 days </div></th>
  </tr>
  <tr>
    <th colspan="4"><div align="center">No fo Applications Pending With DLTFC </div></th>
    </tr>
  <tr>
    <th><div align="center">Total</div></th>
    <th><div align="center">Upto 15 Days </div></th>
    <th><div align="center">16 to 30 days </div></th>
    <th><div align="center">31to 45 days </div></th>
    </tr>
   </thead>
   <tfoot>
   </tfoot>
<tbody>
<% 

int srno =0;
 while (rsMain.next()) { 
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
//DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
NO_OF_APP=rsMain.getString("NO_OF_APP")==null?"":rsMain.getString("NO_OF_APP");
UPTO15DAY=rsMain.getString("UPTO15DAY")==null?"":rsMain.getString("UPTO15DAY");
PEND_30DAY=rsMain.getString("PEND_30DAY")==null?"":rsMain.getString("PEND_30DAY");
PEND_30TO45DAY=rsMain.getString("PEND_30TO45DAY")==null?"":rsMain.getString("PEND_30TO45DAY");
PEND_ABOVE45DAYS=rsMain.getString("PEND_ABOVE45DAYS")==null?"":rsMain.getString("PEND_ABOVE45DAYS");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");


srno =srno+1;


%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"></div>
       <div align="left"><%= STATE_NM %></div></td>
    <td><div align="center"><%= NO_OF_APP %></div></td>
    <td><div align="center"><%=UPTO15DAY %></div></td>
    <td><div align="center"><%=PEND_30DAY %></div></td>
    <td><div align="center"><%=PEND_30TO45DAY %></div></td>
	<td><div align="center"><%= PEND_ABOVE45DAYS %></div></td>
    </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
</table>
</form>
</body>
</html>
