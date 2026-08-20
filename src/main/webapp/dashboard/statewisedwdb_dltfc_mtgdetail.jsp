<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
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
String vfromdt=request.getParameter("FROMDT")==null?"01-JUL-2016":(String)request.getParameter("FROMDT");
String vtodt=request.getParameter("TODT")==null?todayDt:(String)request.getParameter("TODT");
String vagency=request.getParameter("AGENCY")==null?"ALL":(String)request.getParameter("AGENCY");

if (!vagency.equals("ALL")) {
vwherecls=vwherecls + " AND MOM.AGENCY_TYPE= '"+vagency+"' ";
}

 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT "      );
qrysb.append("   Nvl(STATE_NM,'TOTAL') AS STATE_NM,"      );
qrysb.append("   MAX(STATE_CD) AS STATE_CD,"      );
qrysb.append("   SUM(NO_OF_APPREC) AS NO_OF_APPREC,"      );
qrysb.append("   SUM(NO_OF_APP_REJECTED) AS NO_OF_APP_REJECTED,"      );
qrysb.append("   SUM(DLTFC_FORWARD) AS DLTFC_FORWARD,"      );
qrysb.append("   SUM(APPROVED_BYDLTFC) AS APPROVED_BYDLTFC,"      );
qrysb.append("   SUM(NO_OFMTG_CONDUCTED) AS NO_OFMTG_CONDUCTED"      );
qrysb.append("   "      );
qrysb.append("   FROM ("      );
qrysb.append("   SELECT MS.STATE_NM,MAX(MS.STATE_CD) AS STATE_CD,MD.DISTRICT_NAME,"      );
qrysb.append("     COUNT(AD.APP_ID) NO_OF_APPREC,"      );
qrysb.append("    SUM(CASE WHEN AD.ACT_ID=3 THEN 1 ELSE 0 END) AS NO_OF_APP_REJECTED,"      );
qrysb.append("     SUM(CASE WHEN  (AD.FORD_DT_DLTFC IS NOT NULL OR AD.MTG_ID IS NOT NULL)  THEN 1 ELSE 0 END) DLTFC_FORWARD,"      );
qrysb.append("      SUM(CASE WHEN  ACT_ID IN (4,5)  THEN 1 ELSE 0 END) APPROVED_BYDLTFC,"      );
qrysb.append("      COUNT(DISTINCT(AMM.MT_DATE)) AS NO_OFMTG_CONDUCTED"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     APP_MEETING_MAST AMM,"      );
qrysb.append("     MAS_OFF_MAST MOM"      );
qrysb.append("   WHERE AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD       = MS.STATE_CD"      );
qrysb.append("   AND AD.MTG_ID         = AMM.MTG_ID(+) AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+vfromdt+"' AND '"+vtodt+"' "      );
qrysb.append("   AND AD.OFF_CD=MOM.OFF_CD  "+vwherecls+" "      );
qrysb.append("   GROUP BY MD.DISTRICT_NAME,MS.STATE_NM ORDER BY MS.STATE_NM,MD.DISTRICT_NAME)"      );
qrysb.append("   GROUP BY ROLLUP(STATE_NM)"      );

//out.print (qrysb.toString());

String STATE_NM = "";
String DISTRICT_NAME = "";
String NO_OF_APPREC = "";
String NO_OF_APP_REJECTED = "";
String DLTFC_FORWARD = "";
String APPROVED_BYDLTFC = "";
String NO_OFMTG_CONDUCTED = "";

String STATE_CD="";
//out.print (qrysb.toString());

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
<center>
  <h1> Report Generate Date <%= curdt %>
<a href="../pmegphome/index.jsp" class="button" >
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
        </select>
      </div></td>
      <th><div align="right">From Date : </div></th>
      <td><div align="left">
        <input name="FROMDT" ID="FROMDT" type="text" size="12" maxlength="12" value="<%= vfromdt %>"  onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')">
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
    <th colspan="4"><div align="center">No fo Applications </div></th>
    <th rowspan="2"><div align="center">No of DLTFC Meeting</div></th>
    </tr>
  <tr>
    <th><div align="center">Received </div></th>
    <th><div align="center">Rejected by Agency </div></th>
    <th><div align="center">Forwarded to DLTFC </div></th>
    <th><div align="center">Approved by DLTFC </div></th>
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
NO_OF_APPREC=rsMain.getString("NO_OF_APPREC")==null?"":rsMain.getString("NO_OF_APPREC");
NO_OF_APP_REJECTED=rsMain.getString("NO_OF_APP_REJECTED")==null?"":rsMain.getString("NO_OF_APP_REJECTED");
DLTFC_FORWARD=rsMain.getString("DLTFC_FORWARD")==null?"":rsMain.getString("DLTFC_FORWARD");
APPROVED_BYDLTFC=rsMain.getString("APPROVED_BYDLTFC")==null?"":rsMain.getString("APPROVED_BYDLTFC");
NO_OFMTG_CONDUCTED=rsMain.getString("NO_OFMTG_CONDUCTED")==null?"":rsMain.getString("NO_OFMTG_CONDUCTED");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");


srno =srno+1;


%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"></div>
       <div align="left"><a href="statewisedwdb_dltfc_mtgdetail_District.jsp?STATE_CD=<%= STATE_CD %>&FROMDT=<%=vfromdt  %>&TODT=<%=vtodt  %>&AGENCY=<%=vagency  %>" target="_parent"><%= STATE_NM %></a></div></td>
    <td><div align="center"><%= NO_OF_APPREC %></div></td>
    <td><div align="center"><%=NO_OF_APP_REJECTED %></div></td>
    <td><div align="center"><%=DLTFC_FORWARD %></div></td>
    <td><div align="center"><%=APPROVED_BYDLTFC %></div></td>
	<td><div align="center"><%= NO_OFMTG_CONDUCTED %></div></td>
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
