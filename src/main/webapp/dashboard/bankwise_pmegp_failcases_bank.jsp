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
String vWherecls ="";

jspinputvalid js = new jspinputvalid();
String vfromdt=request.getParameter("FROMDT")==null?"01-APR-2022":(String) js.getOnlyTextspc(request.getParameter("FROMDT"),12);
String vtodt=request.getParameter("TODT")==null?todayDt:(String) js.getOnlyTextspc(request.getParameter("TODT"),12);;
String STATE=request.getParameter("STATE")==null?"ALL":(String) js.getOnlyTextspc(request.getParameter("STATE"),2);


//String vfromdt=request.getParameter("FROMDT")==null?"01-APR-2022":(String)request.getParameter("FROMDT");
//String vtodt=request.getParameter("TODT")==null?todayDt:(String)request.getParameter("TODT");
//String STATE=request.getParameter("STATE")==null?"ALL":(String)request.getParameter("STATE");
 if ((!STATE.equals("")) && (!STATE.equals("ALL"))){
    vWherecls=vWherecls+" AND (MS.STATE_CD ) LIKE  ('%"+STATE+"%')  ";
}
else if (STATE.equals("ALL")){
	  vWherecls=vWherecls+" AND (MS.STATE_CD ) LIKE  ('%%')  ";
}
else{
 vWherecls=vWherecls+" AND (MS.STATE_CD ) LIKE  ('-')  ";
 
}

DBCon db= new DBCon();
db.connect();
 ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");

 StringBuffer qrysb= new StringBuffer();
 
qrysb.append("   SELECT NVL(BANK_NAME, 'TOTAL') AS OFF_NAME1,NO_APP_FORWD ,"      );
qrysb.append("     TOTAL_NO_APP_BANKREJ,  DIV_ERR ( TOTAL_NO_APP_BANKREJ,NO_APP_FORWD) AS TOTAL_REJ_PER,"      );
qrysb.append("     NOT_VIAABLE_NO,"      );
qrysb.append("     DIV_ERR (NOT_VIAABLE_NO , TOTAL_NO_APP_BANKREJ)AS NOT_VIAABLE_NO_PER,"      );
qrysb.append("     TARGET_ACHIEV,"      );
qrysb.append("     DIV_ERR (TARGET_ACHIEV , TOTAL_NO_APP_BANKREJ) AS TARGET_ACHIEV_PER,"      );
qrysb.append("     OUT_SERV_AREA,"      );
qrysb.append("     DIV_ERR (OUT_SERV_AREA , TOTAL_NO_APP_BANKREJ) AS OUT_SERV_AREA_PER,"      );
qrysb.append("     APP_NOTINST,"      );
qrysb.append("     DIV_ERR (APP_NOTINST , TOTAL_NO_APP_BANKREJ)  AS APP_NOTINST_PER,"      );
qrysb.append("     CIBIL,"      );
qrysb.append("     DIV_ERR (CIBIL , TOTAL_NO_APP_BANKREJ) AS CIBIL_PER,"      );
qrysb.append("     DEFAULTER,"      );
qrysb.append("     DIV_ERR (DEFAULTER , TOTAL_NO_APP_BANKREJ)  AS DEFAULTER_PER,"      );
qrysb.append("     EXIST_UNIT,"      );
qrysb.append("     DIV_ERR (EXIST_UNIT , TOTAL_NO_APP_BANKREJ) AS EXIST_UNIT_PER,"      );
qrysb.append("     OWN_CON,"      );
qrysb.append("     DIV_ERR (OWN_CON , TOTAL_NO_APP_BANKREJ)  AS OWN_CON_PER,"      );
qrysb.append("     INADQ_KNWLD,"      );
qrysb.append("     DIV_ERR (INADQ_KNWLD , TOTAL_NO_APP_BANKREJ)  AS INADQ_KNWLD_PER,"      );
qrysb.append("     ACT_NEG,"      );
qrysb.append("     DIV_ERR (ACT_NEG ,TOTAL_NO_APP_BANKREJ) AS ACT_NEG_PER,"      );
qrysb.append("     GOV_EMP,"      );
qrysb.append("     DIV_ERR (GOV_EMP , TOTAL_NO_APP_BANKREJ)  AS GOV_EMP_PER,"      );
qrysb.append("     DOC_INCOMP,"      );
qrysb.append("     DIV_ERR (DOC_INCOMP , TOTAL_NO_APP_BANKREJ)  AS DOC_INCOMP_PER,"      );
qrysb.append("     PMEGP_LOAN_AVAIL,"      );
qrysb.append("     DIV_ERR (PMEGP_LOAN_AVAIL , TOTAL_NO_APP_BANKREJ)  AS PMEGP_LOAN_AVAIL_PER,"      );
qrysb.append("     IMP_APP,"      );
qrysb.append("     DIV_ERR (IMP_APP , TOTAL_NO_APP_BANKREJ)  AS IMP_APP_PER,"      );
qrysb.append("     REV_APP,"      );
qrysb.append("     DIV_ERR (REV_APP , TOTAL_NO_APP_BANKREJ)  AS REV_APP_PER,"      );
qrysb.append("     OTHER_BANK,"      );
qrysb.append("     DIV_ERR (OTHER_BANK , TOTAL_NO_APP_BANKREJ)  AS OTHER_BANK_PER,"      );
qrysb.append("     OTHER_REASON,"      );
qrysb.append("     DIV_ERR (OTHER_REASON ,TOTAL_NO_APP_BANKREJ)  AS OTHER_REASON_PER,"      );
qrysb.append("     RET_APP,"      );
qrysb.append("     DIV_ERR (RET_APP , TOTAL_NO_APP_BANKREJ) AS RET_APP_PER"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT RBL.BANK_NAME,"      );
qrysb.append("   "      );
qrysb.append("       COUNT(AD.APP_ID) AS NO_APP_FORWD,"      );
qrysb.append("       SUM(DECODE(BD.ACT_ID,3,1,0)) AS TOTAL_NO_APP_BANKREJ,"      );

qrysb.append("    SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 42 AND BD.ACT_ID=3 "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS NOT_VIAABLE_NO,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 41 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS TARGET_ACHIEV,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 40 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS OUT_SERV_AREA,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 33 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS APP_NOTINST,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 35 AND BD.ACT_ID=3 "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS CIBIL,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 36 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS DEFAULTER,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 37 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS EXIST_UNIT,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 45 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS OWN_CON,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 38 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS INADQ_KNWLD,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 31 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS ACT_NEG,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 32 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS GOV_EMP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID in ( 44,50) AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS DOC_INCOMP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID = 43 AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS PMEGP_LOAN_AVAIL,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID  in ( 15,46,47) AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS IMP_APP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID  IN ( 16 ,48) AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS REV_APP,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID in ( 34 ) AND BD.ACT_ID=3  "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS OTHER_BANK,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.REJ_ID  in ( 39,51,55,54,52,53,56) AND BD.ACT_ID=3  "      );
qrysb.append("         OR ( BD.REJ_ID   IS NULL"      );
qrysb.append("         AND BD.ACT_ID   = 3 ) "      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS OTHER_REASON,"      );

qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN  BD.REJ_ID IN ( 14 ,49) AND BD.ACT_ID   = 3 "      );

qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS RET_APP"      );
qrysb.append("     FROM BANK_DATAENTRY BD,"      );
qrysb.append("       APP_DETAIL AD,M_DISTRICT MD,M_STATE MS,"      );
qrysb.append("       MAS_OFF_MAST MOM , RBIBANKLIST RBL "      );
qrysb.append("     WHERE AD.APP_ID = BD.APP_ID(+) AND AD.IFSC_CODE=RBL.IFSC_CODE AND AD.UNIT_DIST_CD=MD.DISTRICT_CD  "      );
qrysb.append("     AND AD.OFF_CD   = MOM.OFF_CD AND  AD.ACT_YN='Y' AND MD.STATE_CD=MS.STATE_CD "+vWherecls+" "      );
qrysb.append("     AND AD.ACT_ID=5 AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+vfromdt+"' AND '"+vtodt+"'"      );
qrysb.append("     GROUP BY ROLLUP(RBL.BANK_NAME)"      );
qrysb.append("     ) "      );
qrysb.append("   ORDER BY TOTAL_NO_APP_BANKREJ DESC"      );


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
String  NO_APP_FORWD="";
String TOTAL_REJ_PER="";


ResultSet rsMain = db.execSQL(qrysb.toString());
 
%>
<center>
  <h1> Returned By Bank Status Report </h1>
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
	 <td>SEARCH BY STATE:</td>
      <td> <select name="STATE" id="STATE" >
	         
			   <option value="ALL"> All</option>
		<%
	   String sn="";
	   String st="";
	   while (rsState.next()) {
	   st=rsState.getString(1);	
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=st  %>" <% if (st.equals(STATE)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>	  </td>
	<td><input name="Submit" type="submit" class="button" value="Submit"></td>
  </tr>
</table>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">Sr.No</div></th>   
    <th rowspan="2"><div align="center"> Name </div></th>
	<th rowspan="2"><div align="center">No of Application Forwarded </div></th>	
	 <th colspan="2"><div align="center">Total Application Rejected /Returned by Bank </div></th>
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
	 <th colspan="2"><div align="center">Unable to fullfil Bank Formalities </div></th>
	 <th colspan="2"><div align="center">Spouse PMEGP/REGP Loan availed</div></th>
	 <th colspan="2"><div align="center">Applicant requested to return application </div></th>
	 <th colspan="2"><div align="center">Improper application </div></th>
	 <th colspan="2"><div align="center">
	   <p>Beneficiary Not Reachable/ Revised Application </p>
	   </div></th>
	 <th colspan="2"><div align="center">Applicant willing to avail PMEGP loan from other bank </div></th>
	  <th colspan="2"><div align="center">Other Reasons </div></th>
  </tr>
  <tr>
    <th height="85"><div align="center">Prj. No</div></th>
    <th><div align="center">In % </div></th>
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
 NO_APP_FORWD =rsMain.getString("NO_APP_FORWD")==null?"":rsMain.getString("NO_APP_FORWD");
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

TOTAL_REJ_PER=rsMain.getString("TOTAL_REJ_PER")==null?"":rsMain.getString("TOTAL_REJ_PER");

srno =srno+1;



%>

<tbody>

  <tr>
    <td><%=srno %></td>
	<td nowrap><a href="bankwise_detail_pmegpfail_case.jsp?BANK_NAME=<%=OFF_NAME1%>&FROMDT=<%=vfromdt%>&TODT=<%=vtodt%>&STATE=<%=STATE%>"><%=OFF_NAME1 %></td>	
    <td><%=NO_APP_FORWD%></td>
	<td><%=TOTAL_NO_APP_BANKREJ%></td>
	<td><%=TOTAL_REJ_PER%></td>
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
	<td><%=RET_APP_PER%></td>
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
