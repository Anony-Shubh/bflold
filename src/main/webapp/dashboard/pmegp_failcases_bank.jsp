<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="kvic.inputvalid.*"%>

<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css"/>
<style type="text/css">
<!--
.style1 {
	color: #804000;
	font-size: 16px;
}
.style2 {color: #0000A0}
-->
</style>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>

</head>

<body>
<form method="post" name="form" id="form"  >
<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<%

Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
DateFormat df1 = new SimpleDateFormat("dd-MMM-yyyy");
String todayDt=df1.format(now);
String curdt = df.format(now);

jspinputvalid js = new jspinputvalid();
//String YR=request.getParameter("YR")==null?"%%":(String) js.getOnlyTextspc(request.getParameter("YR"),7);

String vfromdt=request.getParameter("FROMDT")==null?"01-APR-2022":(String) js.getOnlyTextspc(request.getParameter("FROMDT"),12);
String vtodt=request.getParameter("TODT")==null?todayDt:(String) js.getOnlyTextspc(request.getParameter("TODT"),12);;



//String vfromdt=request.getParameter("FROMDT")==null?"01-APR-2022":(String)request.getParameter("FROMDT");
//String vtodt=request.getParameter("TODT")==null?todayDt:(String)request.getParameter("TODT");

 StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT NVL(OFF_NAME1,'TOTAL') AS OFF_NAME1,TOTAL_NO_APP_BANKREJ,NOT_VIAABLE_NO,"      );
qrysb.append("   ROUND((NOT_VIAABLE_NO/TOTAL_NO_APP_BANKREJ)*100,2) AS NOT_VIAABLE_NO_PER,"      );
qrysb.append("   TARGET_ACHIEV,"      );
qrysb.append("   ROUND((TARGET_ACHIEV/TOTAL_NO_APP_BANKREJ)*100,2) AS TARGET_ACHIEV_PER,"      );
qrysb.append("   OUT_SERV_AREA,"      );
qrysb.append("   ROUND((OUT_SERV_AREA/TOTAL_NO_APP_BANKREJ)*100,2) AS OUT_SERV_AREA_PER,"      );
qrysb.append("   APP_NOTINST,"      );
qrysb.append("   ROUND((APP_NOTINST/TOTAL_NO_APP_BANKREJ)*100,2) AS APP_NOTINST_PER,"      );
qrysb.append("   CIBIL,"      );
qrysb.append("   ROUND((CIBIL/TOTAL_NO_APP_BANKREJ)*100,2) AS CIBIL_PER,"      );
qrysb.append("   DEFAULTER,"      );
qrysb.append("   ROUND((DEFAULTER/TOTAL_NO_APP_BANKREJ)*100,2) AS DEFAULTER_PER,"      );
qrysb.append("   EXIST_UNIT,"      );
qrysb.append("   ROUND((EXIST_UNIT/TOTAL_NO_APP_BANKREJ)*100,2) AS EXIST_UNIT_PER,"      );
qrysb.append("   OWN_CON,"      );
qrysb.append("   ROUND((OWN_CON/TOTAL_NO_APP_BANKREJ)*100,2) AS OWN_CON_PER,"      );
qrysb.append("   INADQ_KNWLD,"      );
qrysb.append("   ROUND((INADQ_KNWLD/TOTAL_NO_APP_BANKREJ)*100,2) AS INADQ_KNWLD_PER,"      );
qrysb.append("   ACT_NEG,"      );
qrysb.append("   ROUND((ACT_NEG/TOTAL_NO_APP_BANKREJ)*100,2) AS ACT_NEG_PER,"      );
qrysb.append("   GOV_EMP,"      );
qrysb.append("   ROUND((GOV_EMP/TOTAL_NO_APP_BANKREJ)*100,2) AS GOV_EMP_PER,"      );
qrysb.append("   DOC_INCOMP,"      );
qrysb.append("   ROUND((DOC_INCOMP/TOTAL_NO_APP_BANKREJ)*100,2) AS DOC_INCOMP_PER,"      );
qrysb.append("   PMEGP_LOAN_AVAIL,"      );
qrysb.append("   ROUND((PMEGP_LOAN_AVAIL/TOTAL_NO_APP_BANKREJ)*100,2) AS PMEGP_LOAN_AVAIL_PER,"      );
qrysb.append("   IMP_APP,"      );
qrysb.append("   ROUND((IMP_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS IMP_APP_PER,"      );
qrysb.append("   REV_APP,"      );
qrysb.append("   ROUND((REV_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS REV_APP_PER,"      );
qrysb.append("   OTHER_BANK,"      );
qrysb.append("   ROUND((OTHER_BANK/TOTAL_NO_APP_BANKREJ)*100,2) AS OTHER_BANK_PER,"      );
qrysb.append("   OTHER_REASON,"      );
qrysb.append("   ROUND((OTHER_REASON/TOTAL_NO_APP_BANKREJ)*100,2) AS OTHER_REASON_PER,"      );
qrysb.append("    RET_APP,");
qrysb.append("   ROUND((RET_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS RET_APP_PER ");
qrysb.append("   FROM"      );
qrysb.append("   (SELECT MS.STATE_NM AS OFF_NAME1,COUNT(AD.APP_ID) AS TOTAL_NO_APP_BANKREJ,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=42 THEN 1 ELSE 0 END) AS NOT_VIAABLE_NO,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=41 THEN 1 ELSE 0 END) AS TARGET_ACHIEV,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=40 THEN 1 ELSE 0 END) AS OUT_SERV_AREA,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=33 THEN 1 ELSE 0 END) AS APP_NOTINST,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=35 THEN 1 ELSE 0 END) AS CIBIL,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=36 THEN 1 ELSE 0 END) AS DEFAULTER,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=37 THEN 1 ELSE 0 END) AS EXIST_UNIT,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=45 THEN 1 ELSE 0 END) AS OWN_CON,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=38 THEN 1 ELSE 0 END) AS INADQ_KNWLD,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=31 THEN 1 ELSE 0 END) AS ACT_NEG,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=32 THEN 1 ELSE 0 END) AS GOV_EMP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID in (44,50) THEN 1 ELSE 0 END) AS DOC_INCOMP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=43 THEN 1 ELSE 0 END) AS PMEGP_LOAN_AVAIL,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID in (15,46,47) THEN 1 ELSE 0 END) AS IMP_APP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID  IN ( 16 ,48) THEN 1 ELSE 0 END) AS REV_APP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=34 THEN 1 ELSE 0 END) AS OTHER_BANK,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID  in ( 39,51,55,54,52,53,56) OR BD.REJ_ID IS NULL THEN 1 ELSE 0 END) AS OTHER_REASON,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID IN ( 14 ,49) OR BD.REJ_ID IS NULL THEN 1 ELSE 0 END) AS RET_APP "      );
qrysb.append("   FROM BANK_DATAENTRY BD,"      );
qrysb.append("   APP_DETAIL AD,MAS_OFF_MAST MOM,  M_DISTRICT MD, M_STATE MS "      );
qrysb.append("   WHERE AD.APP_ID=BD.APP_ID AND MD.DISTRICT_CD=AD.UNIT_DIST_CD AND MS.STATE_CD=MD.STATE_CD "      );
qrysb.append("   AND AD.OFF_CD=MOM.OFF_CD AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+vfromdt+"' AND '"+vtodt+"'"      );
qrysb.append("   AND BD.ACT_ID=3 "      );
qrysb.append("   AND AD.ACT_YN='Y' AND AD.ACT_ID=5 "      );
qrysb.append("   GROUP BY ROLLUP(MS.STATE_NM))"      );


//out.print (qrysb.toString());

 String OFF_CD = "";
String  OFF_NAME1 = "";
String  TOTAL_NO_APP_BANKREJ = "";
String  NOT_VIAABLE_NO="";
String  NOT_VIAABLE_NO_PER= "";
String  TARGET_ACHIEV    ="";
String  TARGET_ACHIEV_PER   ="";
String  OUT_SERV_AREA  ="";
String  OUT_SERV_AREA_PER     ="";
String  APP_NOTINST    ="";
String  APP_NOTINST_PER    ="";
String  CIBIL    ="";
String  CIBIL_PER    ="";
String  DEFAULTER    ="";
String  DEFAULTER_PER   ="";
String  EXIST_UNIT ="";
String  EXIST_UNIT_PER   ="";
String  OWN_CON ="";
String  OWN_CON_PER ="";
String  INADQ_KNWLD   ="";
String  INADQ_KNWLD_PER="";
String  RET_APP="";
String  RET_APP_PER="";
String  ACT_NEG  ="";
String  ACT_NEG_PER ="";
String  GOV_EMP ="";
String  GOV_EMP_PER  ="";
String  DOC_INCOMP  ="";
String  DOC_INCOMP_PER   ="";
String  PMEGP_LOAN_AVAIL ="";
String  PMEGP_LOAN_AVAIL_PER ="";
String  IMP_APP ="";
String  IMP_APP_PER ="";
String  REV_APP="";
String  REV_APP_PER ="";
String  OTHER_BANK ="";
String  OTHER_BANK_PER  ="";
String  OTHER_REASON="";
String  OTHER_REASON_PER="";
DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
 
%>
<center>
  <h1> Rejection By Bank Status Report </h1>
</center>

<table width="50%" align="center">
  <tr>
    <td><div align="center"> From </div></td>
    <td><div align="center">
      <input name="FROMDT" type="text" id="FROMDT" value="<%=vfromdt%>"  onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')">
    </div></td>
    <td><div align="center">to</div></td>
    <td><div align="center">
      <input name="TODT" type="text" id="TODT"  value="<%=vtodt%>" onClick="javascript:NewCssCal('TODT','ddMMMyyyy')">
	   
    </div></td>
	<td><input name="Submit" type="submit" class="button"  value="Submit" ></td>
  </tr>
</table>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">Sr.No</div></th>   
    <th rowspan="2"><div align="center">Office Name </div></th>
	<th rowspan="2"><div align="center"></div>	  
	  <div align="center">No of Application Rejected </div>	  </th>	
	 <th colspan="2"><div align="center">Not Viable </div></th>
	 <th colspan="2"><div align="center">PMEGP Target Achieved for current year </div></th>
	 <th colspan="2"><div align="center">Out of service area </div></th>
	 <th colspan="2"><div align="center">Applicant not intrested </div></th>
	 <th colspan="2"><div align="center">CIBIL Report not satisfactory </div></th>
	 <th colspan="2"><div align="center">Defaulter</div></th>
	 <th colspan="2"><div align="center">Unable to deposit own contribution </div></th>
	 <th colspan="2"><div align="center">Existing unit </div></th>
	 <th colspan="2"><div align="center">Inadequate knowledge in proposed industry </div></th>
	 <th colspan="2"><div align="center">Activity in negative list as per PMEGP Scheme</div></th>
	 <th colspan="2"><div align="center">
	   <p>Already </p>
	   <p>Govt.</p>
	   <p>Employee</p>
	 </div></th>
	 <th colspan="2"><div align="center">Unable to submit Documents </div></th>
	 <th colspan="2"><div align="center">Spouse PMEGP/REGP Loan availed</div></th>
	 <th colspan="2"><div align="center">Applicant requested to return application </div></th>
	 <th colspan="2"><div align="center">Improper application </div></th>
	 <th colspan="2"><div align="center">
	   <p>Revised </p>
	   <p>Application</p>
	   <p>submitted</p>
	 </div></th>
	 <th colspan="2"><div align="center">Applicant willing to avail PMEGP loan from other bank </div></th>
	  <th colspan="2"><div align="center">Other Reasons </div></th>
  </tr>
  <tr>
    <th height="85"><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>	
	<th><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>	
  </tr>
   </thead>
  <% 


int srno =0;
 while (rsMain.next()) { 
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
TOTAL_NO_APP_BANKREJ=rsMain.getString("TOTAL_NO_APP_BANKREJ")==null?"":rsMain.getString("TOTAL_NO_APP_BANKREJ");
NOT_VIAABLE_NO=rsMain.getString("NOT_VIAABLE_NO")==null?"":rsMain.getString("NOT_VIAABLE_NO");
NOT_VIAABLE_NO_PER=rsMain.getString("NOT_VIAABLE_NO")==null?"":rsMain.getString("NOT_VIAABLE_NO_PER");
TARGET_ACHIEV=rsMain.getString("TARGET_ACHIEV")==null?"Grand Total":rsMain.getString("TARGET_ACHIEV");
TARGET_ACHIEV_PER=rsMain.getString("TARGET_ACHIEV_PER")==null?"":rsMain.getString("TARGET_ACHIEV_PER");
OUT_SERV_AREA=rsMain.getString("OUT_SERV_AREA")==null?"":rsMain.getString("OUT_SERV_AREA");
OUT_SERV_AREA_PER=rsMain.getString("OUT_SERV_AREA_PER")==null?"Grand Total":rsMain.getString("OUT_SERV_AREA_PER");
APP_NOTINST=rsMain.getString("APP_NOTINST")==null?"":rsMain.getString("APP_NOTINST");
APP_NOTINST_PER=rsMain.getString("APP_NOTINST_PER")==null?"":rsMain.getString("APP_NOTINST_PER");

CIBIL=rsMain.getString("CIBIL")==null?"":rsMain.getString("CIBIL");
CIBIL_PER=rsMain.getString("CIBIL_PER")==null?"":rsMain.getString("CIBIL_PER");
DEFAULTER=rsMain.getString("DEFAULTER")==null?"Grand Total":rsMain.getString("DEFAULTER");
DEFAULTER_PER=rsMain.getString("DEFAULTER_PER")==null?"":rsMain.getString("DEFAULTER_PER");
OWN_CON=rsMain.getString("OWN_CON")==null?"":rsMain.getString("OWN_CON");
OWN_CON_PER=rsMain.getString("OWN_CON_PER")==null?"Grand Total":rsMain.getString("OWN_CON_PER");
EXIST_UNIT=rsMain.getString("EXIST_UNIT")==null?"":rsMain.getString("EXIST_UNIT");
EXIST_UNIT_PER=rsMain.getString("EXIST_UNIT_PER")==null?"":rsMain.getString("EXIST_UNIT_PER");
INADQ_KNWLD=rsMain.getString("INADQ_KNWLD")==null?"Grand Total":rsMain.getString("INADQ_KNWLD");
INADQ_KNWLD_PER=rsMain.getString("INADQ_KNWLD_PER")==null?"":rsMain.getString("INADQ_KNWLD_PER");
ACT_NEG=rsMain.getString("ACT_NEG")==null?"":rsMain.getString("ACT_NEG");
ACT_NEG_PER=rsMain.getString("ACT_NEG_PER")==null?"Grand Total":rsMain.getString("ACT_NEG_PER");
GOV_EMP=rsMain.getString("GOV_EMP")==null?"":rsMain.getString("GOV_EMP");
GOV_EMP_PER=rsMain.getString("GOV_EMP_PER")==null?"":rsMain.getString("GOV_EMP_PER");
DOC_INCOMP=rsMain.getString("DOC_INCOMP")==null?"Grand Total":rsMain.getString("DOC_INCOMP");
DOC_INCOMP_PER=rsMain.getString("DOC_INCOMP_PER")==null?"":rsMain.getString("DOC_INCOMP_PER");
PMEGP_LOAN_AVAIL=rsMain.getString("PMEGP_LOAN_AVAIL")==null?"":rsMain.getString("PMEGP_LOAN_AVAIL");
PMEGP_LOAN_AVAIL_PER=rsMain.getString("PMEGP_LOAN_AVAIL_PER")==null?"":rsMain.getString("PMEGP_LOAN_AVAIL_PER");
RET_APP=rsMain.getString("RET_APP")==null?"":rsMain.getString("RET_APP");
RET_APP_PER=rsMain.getString("RET_APP_PER")==null?"":rsMain.getString("RET_APP_PER");
IMP_APP=rsMain.getString("IMP_APP")==null?"":rsMain.getString("IMP_APP");
IMP_APP_PER=rsMain.getString("IMP_APP_PER")==null?"":rsMain.getString("IMP_APP_PER");
REV_APP=rsMain.getString("REV_APP")==null?"":rsMain.getString("REV_APP");
REV_APP_PER=rsMain.getString("REV_APP_PER")==null?"":rsMain.getString("REV_APP_PER");
OTHER_BANK=rsMain.getString("OTHER_BANK")==null?"":rsMain.getString("OTHER_BANK");
OTHER_BANK_PER=rsMain.getString("OTHER_BANK_PER")==null?"":rsMain.getString("OTHER_BANK_PER");
OTHER_REASON=rsMain.getString("OTHER_REASON")==null?"":rsMain.getString("OTHER_REASON");
OTHER_REASON_PER=rsMain.getString("OTHER_REASON_PER")==null?"":rsMain.getString("OTHER_REASON_PER");
//OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");

srno =srno+1;



%>

<tbody>

  <tr>
    <td><%=srno %></td>
	<td nowrap><a href="detail_pmegpfail_case.jsp?OFF_NAME=<%=OFF_NAME1%>&FROMDT=<%=vfromdt%>&TODT=<%=vtodt%>"><%=OFF_NAME1 %></td>	
    <td><%=TOTAL_NO_APP_BANKREJ%></td>
	<td><%=NOT_VIAABLE_NO%></td>
	<td><%=NOT_VIAABLE_NO_PER%></td>
	<td><%=TARGET_ACHIEV%></td>
	<td><%=TARGET_ACHIEV_PER%></td>
	<td><%=OUT_SERV_AREA%></td>
	<td><%=OUT_SERV_AREA_PER%></td>
	<td><%=APP_NOTINST%></td>
	<td><%=APP_NOTINST_PER%></td>
	<td><%=CIBIL%></td>
	<td><%=CIBIL_PER%></td>
	<td><%=DEFAULTER%></td>
	<td><%=DEFAULTER_PER%></td>
	<td><%=OWN_CON%></td>
	<td><%=OWN_CON_PER%></td>
	<td><%=EXIST_UNIT%></td>
	<td><%=EXIST_UNIT_PER%></td>
	<td><%=INADQ_KNWLD%></td>
	<td><%=INADQ_KNWLD_PER%></td>
	<td><%=ACT_NEG%></td>
	<td><%=ACT_NEG_PER%></td>
	<td><%=GOV_EMP%></td>
	<td><%=GOV_EMP_PER%></td>
	<td><%=DOC_INCOMP%></td>
	<td><%=DOC_INCOMP_PER%></td>
	<td><%=PMEGP_LOAN_AVAIL%></td>
	<td><%=PMEGP_LOAN_AVAIL_PER%></td>
	<td><%=RET_APP%></td>
	<td><%=RET_APP%></td>
	<td><%=IMP_APP%></td>
	<td><%=IMP_APP_PER%></td>
	<td><%=REV_APP%></td>
	<td><%=REV_APP_PER%></td>
	<td><%=OTHER_BANK%></td>
	<td><%=OTHER_BANK_PER%></td>
	<td><%=OTHER_REASON%></td>
	<td><%=OTHER_REASON_PER%></td>
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
