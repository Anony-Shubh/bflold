<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="kvic.inputvalid.*"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script language="javascript" src="../js/inlineMsgMain.js"></script>
<script type="text/javascript">
function submit_form(){
var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
var FROMDT= document.form.FROMDT.value;
var TODT= document.form.TODT.value;

 if (FROMDT != "") {
	if  (!dtRegex.test(FROMDT)){
	inlineMsg('FROMDT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
	 }

 if (TODT != "") {
	if  (!dtRegex.test(TODT)){
	inlineMsg('TODT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	
  }
	 }
	 
	 document.form.submit();
}

</script>
</head>

<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
<form method="post" name="form" id="form">

<% 

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
DateFormat df1 = new SimpleDateFormat("dd-MMM-yyyy");
String todayDt=df1.format(now);
String curdt = df.format(now);

String vwherecls="";

jspinputvalid js = new jspinputvalid();
//String YR=request.getParameter("YR")==null?"%%":(String) js.getOnlyTextspc(request.getParameter("YR"),7);

String vfromdt=request.getParameter("FROMDT")==null?"01-JUL-2016":(String) js.getOnlyTextspc(request.getParameter("FROMDT"),12);
String vtodt=request.getParameter("TODT")==null?todayDt:(String) js.getOnlyTextspc(request.getParameter("TODT"),12);;
String vagency=request.getParameter("AGENCY")==null?"ALL":(String) js.getOnlyTextspc(request.getParameter("AGENCY"),4);;



//String vfromdt=request.getParameter("FROMDT")==null?"01-JUL-2016":(String)request.getParameter("FROMDT");
//String vtodt=request.getParameter("TODT")==null?todayDt:(String)request.getParameter("TODT");
//String vagency=request.getParameter("AGENCY")==null?"ALL":(String)request.getParameter("AGENCY");

if (!vagency.equals("ALL")) {
vwherecls=vwherecls + " AND MOM.AGENCY_TYPE= '"+vagency+"' ";
}

 StringBuffer qrysb= new StringBuffer();
/*
qrysb.append("   SELECT NVL(STATE_NM, 'TOTAL') AS STATE_NM,"      );
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
qrysb.append("     TRUNC(SYSDATE)- TRUNC(AD.ONLINE_SUBDT) AS NO_OF_DAYS_PENDING ,"      );
qrysb.append("      AD.ACT_ID"      );
qrysb.append("     FROM APP_DETAIL AD,"      );
qrysb.append("       M_DISTRICT MD,"      );
qrysb.append("       M_STATE MS,"      );
qrysb.append("       MAS_OFF_MAST MOM"      );
qrysb.append("     WHERE AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("     AND MD.STATE_CD       = MS.STATE_CD"      );
qrysb.append("     AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("     AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+vfromdt+"' AND '"+vtodt+"' "      );
qrysb.append("     AND AD.ACT_ID IN (0,1) "+vwherecls+" "      );
qrysb.append("     GROUP BY"      );
qrysb.append("      AD.APP_ID,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     UPPER(AD.APP_NAME),"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("      MS.STATE_CD,"      );
qrysb.append("       MD.DISTRICT_NAME,"      );
qrysb.append("     TRUNC(SYSDATE)- TRUNC(AD.ONLINE_SUBDT),"      );
qrysb.append("       AD.ACT_ID"      );
qrysb.append("     )"      );
qrysb.append("   GROUP BY ROLLUP(STATE_NM)"      );
*/

qrysb.append("   SELECT NVL(STATE_NM, 'TOTAL') AS STATE_NM,"      );
qrysb.append("     MAX(STATE_CD)               AS STATE_CD,"      );
qrysb.append("     COUNT(APP_ID)               AS NO_OF_APP,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NO_OF_DAYS_PENDING BETWEEN 0 AND 15 AND ACT_ID IN (0,1,2,4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS UPTO15DAY,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NO_OF_DAYS_PENDING BETWEEN 16 AND 30 AND ACT_ID IN (0,1,2,4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PEND_30DAY,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NO_OF_DAYS_PENDING BETWEEN 31 AND 45 AND ACT_ID IN (0,1,2,4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PEND_30TO45DAY,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN NO_OF_DAYS_PENDING > 45 AND ACT_ID IN (0,1,2,4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS PEND_ABOVE45DAYS,"      );
qrysb.append("     SUM(LESSTHAN_3DAYS) AS LESSTHAN_3DAYS,"      );
qrysb.append("      SUM(MORETHAN_3DAYS) AS MORETHAN_3DAYS"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT AD.APP_ID,"      );
qrysb.append("       MOM.AGENCY_TYPE,"      );
qrysb.append("       UPPER(AD.APP_NAME) AS APP_NAME,"      );
qrysb.append("       MS.STATE_NM,"      );
qrysb.append("       MS.STATE_CD,"      );
qrysb.append("       MD.DISTRICT_NAME,"      );
qrysb.append("       TRUNC(SysDate) - TRUNC(AD.ONLINE_SUBDT) AS NO_OF_DAYS_PENDING,"      );
qrysb.append("       AD.ACT_ID,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN (TRUNC(SysDate) - TRUNC(AMM.MT_DATE) <= 5"      );
qrysb.append("         AND AD.ACT_ID                              = 4"      );
qrysb.append("         AND NVL(AD.MTG_ID,0)                              > 0)"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS LESSTHAN_3DAYS,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN (TRUNC(SysDate) - TRUNC(AMM.MT_DATE) > 5"      );
qrysb.append("         AND AD.ACT_ID                             = 4"      );
qrysb.append("         AND NVL(AD.MTG_ID ,0)                            > 0)"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS MORETHAN_3DAYS"      );
qrysb.append("     FROM APP_DETAIL AD,"      );
qrysb.append("       M_DISTRICT MD,"      );
qrysb.append("       M_STATE MS,"      );
qrysb.append("       MAS_OFF_MAST MOM,"      );
qrysb.append("       APP_MEETING_MAST AMM"      );
qrysb.append("     WHERE AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("     AND AD.MTG_ID         = AMM.MTG_ID(+)"      );
qrysb.append("     AND MD.STATE_CD       = MS.STATE_CD"      );
qrysb.append("     AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("     AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+vfromdt+"' AND '"+vtodt+"' "      );
qrysb.append("     AND AD.ACT_ID IN (0,1,2,4)  AND AD.ACT_YN='Y' "+vwherecls+"  "      );
qrysb.append("     GROUP BY AD.APP_ID,"      );
qrysb.append("       MOM.AGENCY_TYPE,"      );
qrysb.append("       UPPER(AD.APP_NAME),"      );
qrysb.append("       MS.STATE_NM,"      );
qrysb.append("       MS.STATE_CD,"      );
qrysb.append("       MD.DISTRICT_NAME,"      );
qrysb.append("       TRUNC(SysDate) - TRUNC(AD.ONLINE_SUBDT),"      );
qrysb.append("       AD.ACT_ID"      );
qrysb.append("     )"      );
qrysb.append("   GROUP BY ROLLUP(STATE_NM)"      );

//out.print(qrysb.toString());
String STATE_NM = "";
String DISTRICT_NAME = "";
String NO_OF_APP = "";
String UPTO15DAY = "";
String PEND_30DAY = "";
String PEND_30TO45DAY = "";
String PEND_ABOVE45DAYS = "";
String LESSTHAN_3DAYS="";
String MORETHAN_3DAYS="";



String STATE_CD="";
//out.print (qrysb.toString());

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
<center>
  <h1> Agency Pending Report Generate Date <%= curdt %>
<a href="index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a>
</h1>
 <table width="100%"  border="1" class="bordered">
    <tr>
      <th>Agency</th>
      <td><div align="left">
        <select name="AGENCY" id="AGENCY">
          <option value="ALL">ALL</option>
          <option value="KVIC" <% if (vagency.equals("KVIC")){ out.print("selected");}%>>KVIC</option>
          <option value="KVIB" <% if (vagency.equals("KVIB")){ out.print("selected");}%> >KVIB</option>
          <option value="DIC" <% if (vagency.equals("DIC")){ out.print("selected");}%>>DIC</option>
		   <option value="COIR" <% if (vagency.equals("COIR")){ out.print("selected");}%>>COIR</option>
        </select>
      </div></td>
      <th><div align="right">From Date : </div></th>
      <td><div align="left">
        <input name="FROMDT" ID="FROMDT" type="text" size="12" maxlength="12" value="<%= vfromdt %>" onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')">
      </div></td>
      <th>To Date </th>
      <td><div align="left">
        <input name="TODT" id="TODT" type="text" size="12" maxlength="12" value="<%= vtodt %>" onClick="javascript:NewCssCal('TODT','ddMMMyyyy')" >
      </div></td>
      <td><input name="button" type="button" class="button" value="Submit" onClick="submit_form();"></td>
    </tr>
  </table>
 
  </center>

 <table align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">SRNO</div></th>
    <th rowspan="2"><div align="center">State Name </div></th>
    <th colspan="4"><div align="center">No fo Applications Pending With Implementing Agency for Scrutiny</div></th>
    <th rowspan="2">Above 45 days </th>
    <!--<th colspan="2"><div align="center">Recommended by DLTFC but pending for Forwarding to Bank</div></th>-->
    </tr>
  <tr>
    <th><div align="center">Total</div></th>
    <th><div align="center">Upto 15 Days </div></th>
    <th><div align="center">16 to 30 days </div></th>
    <th><div align="center">31to 45 days </div></th>
    <!--<th><div align="center">Within 5 days</div></th>
    <th><div align="center">More than 5 days </div></th>-->
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
 LESSTHAN_3DAYS=rsMain.getString("LESSTHAN_3DAYS")==null?"":rsMain.getString("LESSTHAN_3DAYS");
 MORETHAN_3DAYS=rsMain.getString("MORETHAN_3DAYS")==null?"":rsMain.getString("MORETHAN_3DAYS");


srno =srno+1;


%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"></div>
       <div align="left"><a href="statewisedwdb_agency_pending_District.jsp?STATE_CD=<%= STATE_CD %>&FROMDT=<%=vfromdt  %>&TODT=<%=vtodt  %>&AGENCY=<%=vagency  %>" target="_parent"><%= STATE_NM %></a></div></td>
    <td><div align="center"><%= NO_OF_APP %></div></td>
    <td><div align="center"><%=UPTO15DAY %></div></td>
    <td><div align="center"><%=PEND_30DAY %></div></td>
    <td><div align="center"><%=PEND_30TO45DAY %></div></td>
	<td><%= PEND_ABOVE45DAYS %></td>
	<!--<td><%= LESSTHAN_3DAYS %></td>
	<td><div align="center"><%= MORETHAN_3DAYS %></div></td>-->
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
