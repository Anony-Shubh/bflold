<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

</head>

<body>
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">

<% 
String YR=request.getParameter("YR")==null?"%%":(String) request.getParameter("YR");
String vcls="";
if (YR.equals("2016-17")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2016' and '31-MAR-2017' ";
}

if (YR.equals("2017-18")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2017' and '31-MAR-2018' ";
}

if (YR.equals("2018-19")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2018' and '31-MAR-2019' ";
}
if (YR.equals("2019-20")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2019' and TRUNC(SYSDATE) ";
}

if (YR.equals("TOTAL")) {
vcls=" TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-APR-2016' and TRUNC(SYSDATE) ";
}

String Ban_nm="";
String banknm=request.getParameter("bankname")==null?"":(String)request.getParameter("bankname");
if (!banknm.equals("Total")){
	banknm=banknm;
	Ban_nm=banknm;
}
else{
banknm="%%";
Ban_nm="Total";

}

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);
String wcls="";
if (YR.equals("2016-17")) {
wcls=" 1-JULY-2016 TO 31-MARCH-2017 ";
}
if (YR.equals("2017-18")) {
wcls=" 1-APRIL-2017 TO 31-MARCH-2018 ";
}
if (YR.equals("2018-19")) {
wcls=" 1-APRIL-2018 TO 31-MARCH-2019 ";
}

if (YR.equals("2019-20")) {
wcls=" 1-APRIL-2019 TO "+curdt+" ";
}
if (YR.equals("TOTAL")) {
wcls=" 1-JULY-2016 TO "+curdt+" ";
}
 StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT Nvl(MOM.OFF_NAME1,'Total') AS BANK_NAME,"      );
qrysb.append("   COUNT(AD.APP_ID) AS FORD_PRJNO,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,11,1,0)) AS SANC_NOPRJ,"      );
qrysb.append("   SUM(DECODE(BD.ACT_ID,11,ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2),0)) AS SANC_MM,"      );
qrysb.append("   SUM(DECODE(BD.MM_CLAIM_DT,NULL,0,1)) AS FB_MM_CLAIM_PRJNO,"      );
qrysb.append("   SUM(DECODE(BD.MM_CLAIM_DT,NULL,0,round(MM_CLAIM_AMT/100000,2))) AS FB_MM_CLAIM_AMT,"      );
qrysb.append("   SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL  THEN 1 ELSE 0 END) AS CORPMM_REL_PRJNO,"      );
qrysb.append("   SUM(CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL THEN  ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2)ELSE 0 END) AS CORPMM_REL_AMT"      );
qrysb.append("   FROM "      );
qrysb.append("   APP_DETAIL AD,BANK_DATAENTRY BD, MAS_OFF_MAST MOM  "      );
qrysb.append("   WHERE AD.APP_ID=BD.APP_ID(+) AND AD.ACT_ID=5 AND AD.OFF_CD=MOM.OFF_CD AND  AD.BANK_NAME LIKE '"+banknm+"' and TRUNC(bd.LOAN_SANC_DT) BETWEEN '1-JUL-2016' and TRUNC(SYSDATE) "      );
qrysb.append("   GROUP BY ROLLUP(MOM.OFF_NAME1) ORDER BY CORPMM_REL_AMT DESC "      );




String BANK_NAME = "";
String NO_OF_BRANCH = "";
String FORD_PRJNO = "";
String FORD_MM = "";
String REJ_NOPRJ = "";
String REJ_MM = "";
String BANK_UP_NOPRJ = "";
String UP_MM = "";
String SANC_NOPRJ = "";
String SANC_MM = "";
String OWN_CONT_NOPRJ = "";
String OWN_CONT_MM = "";
String LOAN_NOPRJ = "";
String LOAN_MM = "";
String EDP_NOPRJ = "";
String EDP_MM = "";
String FB_MM_CLAIM_PRJNO = "";
String FB_MM_CLAIM_AMT = "";
String CORPMM_REL_PRJNO = "";
String CORPMM_REL_AMT = "";


DBCon db= new DBCon();
db.connect();
//out.print(qrysb.toString());
ResultSet rsMain = db.execSQL(qrysb.toString());

 %>
<center>
  <h1> Application Status at <%=Ban_nm%> State Wise From 01-JULY-2016 AS ON DATE
<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr bgcolor="#FBDDF9">
    <td rowspan="2">Sr.No.</td>
    <td rowspan="2"><div align="center">State/Office name </div></td>
    <td colspan="2"><div align="center">Sanctioned by Bank </div></td>
    <td colspan="2"><div align="center">MM Claimed </div></td>
    <td colspan="2"><div align="center">Pending For MM Claim </div></td>
    </tr>
  <tr>
    <td bgcolor="#FBDDF9"><div align="center">No.of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM Inv.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">No.of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM Inv.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">No.of Prj.</div></td>
    <td bgcolor="#FBDDF9"><div align="center">MM Inv.</div></td>
  </tr>
   </thead>
  
<tbody>
<% 

int srno =0;
 while (rsMain.next()) { 
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
//NO_OF_BRANCH=rsMain.getString("NO_OF_BRANCH")==null?"":rsMain.getString("NO_OF_BRANCH");
FORD_PRJNO=rsMain.getString("FORD_PRJNO")==null?"":rsMain.getString("FORD_PRJNO");

SANC_NOPRJ=rsMain.getString("SANC_NOPRJ")==null?"":rsMain.getString("SANC_NOPRJ");
SANC_MM=rsMain.getString("SANC_MM")==null?"":rsMain.getString("SANC_MM");

FB_MM_CLAIM_PRJNO=rsMain.getString("FB_MM_CLAIM_PRJNO")==null?"":rsMain.getString("FB_MM_CLAIM_PRJNO");
FB_MM_CLAIM_AMT=rsMain.getString("FB_MM_CLAIM_AMT")==null?"":rsMain.getString("FB_MM_CLAIM_AMT");
CORPMM_REL_PRJNO=rsMain.getString("CORPMM_REL_PRJNO")==null?"":rsMain.getString("CORPMM_REL_PRJNO");
CORPMM_REL_AMT=rsMain.getString("CORPMM_REL_AMT")==null?"":rsMain.getString("CORPMM_REL_AMT");

srno =srno+1;


%>
  <tr>
    <td><div align="center"><%= srno %></div></td>
     <td><div align="left"><%= BANK_NAME %></div></td>
    <td><div align="center"><%=SANC_NOPRJ  %></div></td>
    <td><div align="center"><%=SANC_MM  %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_PRJNO %></div></td>
    <td><div align="center"><%= FB_MM_CLAIM_AMT %></div></td>
	<td>
      <div align="center"><%= CORPMM_REL_PRJNO %>      </div></td>
	    <td><div align="center"><%= CORPMM_REL_AMT %></div></td>
  </tr>
  </tbody>
   <%  }
  rsMain.close();
  db.close();
    %>
</table>

</body>
</html>
