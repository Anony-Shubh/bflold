<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%@ include file="includesessionpage.jsp" %>
<!DOCTYPE html>
<HTML lang="en">

<HEAD>

    <META CHARSET="utf-8">
    <META http-equiv="X-UA-Compatible" content="IE=edge">
    <META name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <META name="description" content="">
    <META name="author" content="">

    <TITLE>PMEGP DASHBOARD</TITLE>

    <!-- Custom fonts for this template -->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <LINK href="css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <LINK href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<SCRIPT type="text/javascript" src="js/datetimepicker_css.js"></SCRIPT>

<SCRIPT language="javascript">

function changetype(){
/*
var GENDERT=document.getElementById("GENDERT").value;

				
				if(GENDERT==""){
				inlineMsg('GENDERT','Select Gender',2);
				return false;
				}
*/
document.form.submit();

}


  function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

return (showdt);
}
 
 function todaydt() {
 test = new Date()
document.getElementById("TODT").value=now();
 }

</SCRIPT>

<STYLE>
.buttonplus {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 20px;
  cursor: pointer;
  border-radius: 50%;
}

</STYLE>

</HEAD>

<BODY onLoad="todaydt();" id="page-top">
<FORM name="form" id="form" >
<%List values=new ArrayList();

String TYPE=request.getParameter("TYPE")==null?"A":(String)request.getParameter("TYPE");

String STATE_CD=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
String STATE_NM=request.getParameter("STATE_NM")==null?"":(String)request.getParameter("STATE_NM");

String GENDERT=request.getParameter("GENDERT")==null?"":request.getParameter("GENDERT");
String ACTCD=request.getParameter("ACTCD")==null?"":request.getParameter("ACTCD");
String AGENTYPE=request.getParameter("AGENTYPE")==null?"":request.getParameter("AGENTYPE");
String STATE_CD_D1=request.getParameter("STATE_CD_D1")==null?"":request.getParameter("STATE_CD_D1");
String ACTSAVE=request.getParameter("ACTSAVE")==null?"":request.getParameter("ACTSAVE");

String FROMDT=request.getParameter("FROMDT")==null?"01-APR-2020":request.getParameter("FROMDT");
String TODT=request.getParameter("TODT")==null?"01-APR-2021":request.getParameter("TODT");

String FROMDT1="";
String TODT1="";


String whrcls="";
String whrcls2="";	
String whrcls3="";

if(GENDERT.equals("Male")){
whrcls="  ad.gender='Male' AND  ";
}else if(GENDERT.equals("Female")){
whrcls="  ad.gender='Female' AND  ";
}else if(GENDERT.equals("Transgender")){
whrcls="  ad.gender='Transgender' AND  ";
}else if(GENDERT.equals("")){
whrcls="  ";
}


if(AGENTYPE.equals("KVIC")){
whrcls2="  MOM.AGENCY_TYPE='KVIC' AND  ";
}else if(AGENTYPE.equals("KVIB")){
whrcls2="  MOM.AGENCY_TYPE='KVIB' AND  ";
}else if(AGENTYPE.equals("DIC")){
whrcls2="  MOM.AGENCY_TYPE='DIC' AND  ";
}else if(AGENTYPE.equals("COIR")){
whrcls2="  MOM.AGENCY_TYPE='COIR' AND  ";
}else if(AGENTYPE.equals("")){
whrcls2="    ";
}

if(!ACTCD.equals("")){
whrcls3="  AD.ACTIVITY_CD="+ACTCD+" AND  ";
}else if (ACTCD.equals("")){
whrcls3="  ";
}

StringBuffer qrysb= new StringBuffer();


qrysb.append("   SELECT "      );
qrysb.append("   "      );
qrysb.append("   MAX(AGENCY_UP) AS AGENCY_UP,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_UP/AGENCY_UP),0) AS APP_UP_AVG,"      );
qrysb.append("   MAX(AGN_REJECT) AS AGN_REJECT,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_REJECT/AGN_REJECT),0) AS APP_UP_REJ,"      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   "      );
qrysb.append("   MAX(BANK_FORD) AS BANK_FORD,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_F/BANK_FORD),0) AS BANK_FORD_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(BANK_SANC) AS BANK_SANC,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_LOAN_SAN/BANK_SANC),0) AS BANK_SANC_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(OWN_CONT) AS OWN_CONT,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_OWN/OWN_CONT),0) AS OWN_CONT_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(IST_LOANSANC) AS IST_LOANSANC,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_LOAN_SAN_FIRST/IST_LOANSANC),0) AS IST_LOANSANC_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(MM_CLAIM) AS MM_CLAIM,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_MM_CLAIMS/MM_CLAIM),0) AS MM_CLAIM_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(MM_REL) AS MM_REL,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_MM_REL/MM_REL),0) AS MM_REL_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(EDP_CERT_ISS) AS EDP_CERT_ISS,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_EDP/EDP_CERT_ISS),0) AS EDP_CERT_ISS_AVG,"      );
qrysb.append("   "      );
qrysb.append("   MAX(BANK_REJECT) AS BANK_REJECT,"      );
qrysb.append("   ROUND(MAX(NO_OF_DAYS_BANK_R/BANK_REJECT),0) AS BANK_REJECT_AVG"      );

qrysb.append("   from ("      );
qrysb.append("   SELECT SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID in(0,1,2,4)"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS agency_up,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID in(0,1,2,4)"      );
qrysb.append("       THEN (TRUNC(sysdate) - TRUNC(ad.ONLINE_SUBDT))+1   "      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_up,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID=3"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS AGN_REJECT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID=3 and TRUNC(AD.APP_REC_DATE) <> TRUNC(AD.ONLINE_SUBDT)"      );
qrysb.append("       THEN (TRUNC(NVL(ad.APP_REC_DATE, ad.TIME_STAMP)) - TRUNC(ad.ONLINE_SUBDT))+1"      );
qrysb.append("      "      );
qrysb.append("       ELSE  (TRUNC(ad.ONLINE_SUBDT)+ SUBSTR(AD.APP_ID, -1)- TRUNC(ad.ONLINE_SUBDT))+1"      );
qrysb.append("     END) AS no_of_days_REJECT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN  ad.ACT_ID = 5 AND ad.BANK_F_DATE IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS bank_ford,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID = 3"      );
qrysb.append("       AND ad.ACT_ID  = 5"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE) IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_reject,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 3"      );
qrysb.append("       AND TRUNC(ad.BANK_F_DATE) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.BANK_REC_DT) - TRUNC(ad.BANK_F_DATE))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_R,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("          THEN (TRUNC(ad.BANK_F_DATE) - TRUNC(ad.ONLINE_SUBDT))+1 "      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_f,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND ad.ACT_ID = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS bank_sanc,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT)  IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.LOAN_SANC_DT) - TRUNC(ad.BANK_F_DATE))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_LOAN_SAN,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS OWN_CONT,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.OWN_CONT_DT) - TRUNC(bd.LOAN_SANC_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_OWN,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID >= 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT) IS NOT NULL"      );
qrysb.append("       AND ad.ACT_ID              = 5"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS IST_LOANSANC,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN ad.ACT_ID = 5"      );
qrysb.append("       AND bd.ACT_ID  = 11"      );
qrysb.append("       AND TRUNC(bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.OWN_CONT_DT) IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.IST_LOAN_DT) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.IST_LOAN_DT) - TRUNC(bd.OWN_CONT_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_LOAN_SAN_FIRST,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID        >= 11"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) IS NOT NULL"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS mm_claim,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID        = 11"      );
qrysb.append("       AND bd.MM_CLAIM_AMT   > 0"      );
qrysb.append("       AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.MM_CLAIM_DT) IS NOT NULL"      );
qrysb.append("       THEN (TRUNC(bd.MM_CLAIM_DT) - TRUNC(bd.IST_LOAN_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_MM_CLAIMS,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.MM_REL_DT IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID  >= 11"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.APPRV_YN = 'A'"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS mm_rel,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID    = 11"      );
qrysb.append("       AND bd.MM_REL_DT IS NOT NULL"      );
qrysb.append("       AND TRUNC(bd.MM_REL_DT) IS NOT NULL"      );
qrysb.append("       AND bd.PACT_ID  = 34"      );
qrysb.append("       AND bd.APPRV_YN = 'A'"      );
qrysb.append("       THEN (TRUNC(bd.MM_REL_DT) - TRUNC(bd.MM_CLAIM_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_MM_REL,"      );
qrysb.append("     SUM(NVL("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.EDP_CERT_DT IS NOT NULL AND (bd.LOAN_SANC_DT) IS NOT NULL"      );
qrysb.append("       AND bd.ACT_ID = 11"      );
qrysb.append("       THEN 1"      );
qrysb.append("     END, 0)) AS edp_cert_iss,"      );
qrysb.append("     SUM("      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN bd.ACT_ID      = 11"      );
qrysb.append("       AND bd.EDP_CERT_DT IS NOT NULL   "      );
qrysb.append("       THEN (TRUNC(bd.EDP_CERT_DT) - TRUNC(bd.LOAN_SANC_DT))+1"      );
qrysb.append("       ELSE 0"      );
qrysb.append("     END) AS no_of_days_bank_EDP"      );
qrysb.append("   FROM app_detail ad,"      );
qrysb.append("     bank_dataentry bd,"      );
qrysb.append("     m_district dm,"      );
qrysb.append("     mas_off_mast mom,"      );
qrysb.append("     m_state ms,"      );
qrysb.append("     ZONE_MAST ZM"      );
qrysb.append("   WHERE "+whrcls+" "+whrcls2+" "+whrcls3+"  ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("   AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("   AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("   AND ad.OFF_CD       = mom.OFF_CD"      );
qrysb.append("   AND ms.ZONE_CD      = ZM.ZONE_CD"      );
qrysb.append("   AND TRUNC(ad.ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND  '"+TODT+"'     "      );
qrysb.append("   )"      );





DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());
ResultSet rs = db.execSQL(qrysb.toString());
//ResultSet rs = db.executeSQL(sb.toString(),values);


String AGENCY_UP="";
String APP_UP_AVG="";
String AGN_REJECT="";
String APP_UP_REJ="";
String BANK_FORD="";
String BANK_FORD_AVG="";

String BANK_SANC ="";
String BANK_SANC_AVG ="";
String OWN_CONT ="";
String OWN_CONT_AVG ="";
String IST_LOANSANC ="";
String IST_LOANSANC_AVG ="";
String MM_CLAIM ="";
String MM_CLAIM_AVG ="";
String MM_REL ="";
String MM_REL_AVG ="";
String EDP_CERT_ISS ="";
String EDP_CERT_ISS_AVG ="";
String BANK_REJECT ="";
String BANK_REJECT_AVG ="";


%>

    <!-- Page Wrapper -->
    <DIV id="wrapper">

     

        <!-- Content Wrapper -->
        <DIV id="content-wrapper" class="d-flex flex-column">
<IMG src="img/banner3.jpg" > 
            <!-- Main Content -->
            <DIV id="content">

<BR>

                <!-- Begin Page Content -->
                <DIV class="container-fluid">
	<DIV align="center">			
	<A class="btn btn-primary" href="index.jsp">Home</A>
	<A class="btn btn-primary" href="index22.jsp">Summarized Reports</A>
	<A class="btn btn-primary" href="pmegp/index.jsp">Pending Reports</A>
	<A class="btn btn-primary" href="analyticalrep.jsp">Analytical Reports</A>
	<A class="btn btn-primary" href="agewise_Ind.jsp">Agewise Report</A>
	 <%if(TYPE.equals("A")){%>
	<A class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=dashboardreport&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=dashboardreport&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	<%}%>
	 <%if(TYPE.equals("S")){%>
	<A class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=dashboardreportstate&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=dashboardreportstate&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	<%}%>
	 <%if(TYPE.equals("D")){%>
	<A class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=dashboardreportdistrict&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=dashboardreportdistrict&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	<%}%>
	<A hidden class="btn btn-primary" onClick="myFunction()">Filter</A>
	<A hidden class="btn btn-primary" href="reports/GenerateCSV.jsp?REP_NM=csvtest" >Download CSV test</A>
	</DIV>


<DIV id="myDIV">
<CENTER>

<!--<SELECT id="GENDERT" name="GENDERT">
<OPTION value="">Select Gender</OPTION>
<OPTION value="">All</OPTION>
<OPTION value="Male" <%// if(GENDERT.equals("Male")){out.print("SELECTED");} %>>Male</OPTION>
<OPTION value="Female"  <% //if(GENDERT.equals("Female")){out.print("SELECTED");} %>>Female</OPTION>
<OPTION value="Transgender"  <% //if(GENDERT.equals("Transgender")){out.print("SELECTED");} %>>Transgender</OPTION>
</SELECT>-->
Select Agency
<SELECT id="AGENTYPE" name="AGENTYPE">

<OPTION value="">All</OPTION>
<OPTION value="KVIC" <% if(AGENTYPE.equals("KVIC")){out.print("SELECTED");} %>>KVIC</OPTION>
<OPTION value="KVIB" <% if(AGENTYPE.equals("KVIB")){out.print("SELECTED");} %>>KVIB</OPTION>
<OPTION value="DIC" <% if(AGENTYPE.equals("DIC")){out.print("SELECTED");} %>>DIC</OPTION>
<OPTION value="COIR" <% if(AGENTYPE.equals("COIR")){out.print("SELECTED");} %>>COIR</OPTION>
</SELECT>


<INPUT name="FROMDT" type="text" id="FROMDT" value="<%= FROMDT %>" onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')"  maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="From date">

<INPUT name="TODT" type="text" id="TODT" value="<%= TODT %>" onClick="javascript:NewCssCal('TODT','ddMMMyyyy')"  maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="To date">


<INPUT type="hidden" name="TYPE" id="TYPE" value="<%= TYPE %>">  

<!--
<SELECT name="ACTCD" id="ACTCD" >
    <OPTION value="">Select Activity</OPTION>
	<OPTION value="">All</OPTION>
    <%
	/*
	String STATE_NM_D1="";
	ResultSet staters1 =db.execSQL("select AM.ACTIVITY_CD, AM.ACTIVITY_NAME||', '||IGM.IND_GRP_SHORT_DESC AS ACTIVITY_NAME from ACTIVITY_MAST AM, IND_GRP_MAST IGM WHERE AM.IND_GRP_CD=IGM.IND_GRP_CD AND STATUS='Y' ORDER BY IND_GRP_SHORT_DESC,AM.ACTIVITY_NAME");
	while (staters1.next()) {
STATE_CD_D1=staters1.getString(1);
STATE_NM_D1=staters1.getString(2);*/
	%>
    <OPTION value="<%//= STATE_CD_D1 %>" <%//if(ACTCD.equals(STATE_CD_D1)){out.print("selected");}%>><%//= STATE_NM_D1 %></OPTION>
    <% //ss }  staters1.close();//while close  
	   %>
  </SELECT>-->
 
<INPUT type="hidden" name="ACTSAVE" id="ACTSAVE" value="<%= ACTCD %>">  

<INPUT type="submit" value="Go" onClick="changetype()" >
</CENTER>
</DIV>
                    <!-- DataTales Example -->
                    <DIV class="card shadow mb-4">
                      
                        <DIV class="card-body">
                            <DIV class="table-responsive">
							  
							<DIV align="center"><H3>Data from <%= FROMDT %> TO <%= TODT %></H3></DIV>
                         
							    <TABLE class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                                    <THEAD>
                                        <TR>
                                          <TH>Country</TH>
										  
										  
                                            <TH>AGENCY_UP</TH>
                                            <TH>APP_UP_AVG</TH>
                                            <TH>AGN_REJECT</TH>
                                            <TH>APP_UP_REJ</TH>
                                            <TH>BANK_FORD</TH>
                                            <TH>BANK_FORD_AVG</TH>
                                            <TH>BANK_SANC</TH>
                                            <TH>BANK_SANC_AVG</TH>
                                            <TH>OWN_CONT</TH>
                                            <TH>OWN_CONT_AVG</TH>
                                            <TH>IST_LOANSANC</TH>
                                            <TH>IST_LOANSANC_AVG</TH>
                                            <TH>MM_CLAIM</TH>
                                            <TH>MM_CLAIM_AVG</TH>
                                            <TH>MM_REL</TH>
                                            <TH>MM_REL_AVG</TH>
                                            <TH>EDP_CERT_ISS</TH>
                                            <TH>EDP_CERT_ISS_AVG</TH>
                                            <TH>BANK_REJECT</TH>
                                            <TH>BANK_REJECT_AVG</TH>
                                            <TH>Bankwise Detail </TH>
                                        </TR>
                                    </THEAD>
                                    <TFOOT>
                                    </TFOOT>
                                    <TBODY>
				
									
 <%
int count=0;
while (rs.next()) {
count=count+1;


AGENCY_UP=rs.getString("AGENCY_UP")==null?"":rs.getString("AGENCY_UP");
APP_UP_AVG=rs.getString("APP_UP_AVG")==null?"":rs.getString("APP_UP_AVG");
AGN_REJECT=rs.getString("AGN_REJECT")==null?"":rs.getString("AGN_REJECT");
APP_UP_REJ=rs.getString("APP_UP_REJ")==null?"":rs.getString("APP_UP_REJ");
BANK_FORD=rs.getString("BANK_FORD")==null?"":rs.getString("BANK_FORD");
BANK_FORD_AVG=rs.getString("BANK_FORD_AVG")==null?"":rs.getString("BANK_FORD_AVG");
BANK_SANC=rs.getString("BANK_SANC")==null?"":rs.getString("BANK_SANC");
BANK_SANC_AVG=rs.getString("BANK_SANC_AVG")==null?"":rs.getString("BANK_SANC_AVG");
OWN_CONT=rs.getString("OWN_CONT")==null?"":rs.getString("OWN_CONT");
OWN_CONT_AVG=rs.getString("OWN_CONT_AVG")==null?"":rs.getString("OWN_CONT_AVG");
IST_LOANSANC=rs.getString("IST_LOANSANC")==null?"":rs.getString("IST_LOANSANC");
IST_LOANSANC_AVG=rs.getString("IST_LOANSANC_AVG")==null?"":rs.getString("IST_LOANSANC_AVG");
MM_CLAIM=rs.getString("MM_CLAIM")==null?"":rs.getString("MM_CLAIM");
MM_CLAIM_AVG=rs.getString("MM_CLAIM_AVG")==null?"":rs.getString("MM_CLAIM_AVG");
MM_REL=rs.getString("MM_REL")==null?"":rs.getString("MM_REL");
MM_REL_AVG=rs.getString("MM_REL_AVG")==null?"":rs.getString("MM_REL_AVG");
EDP_CERT_ISS=rs.getString("EDP_CERT_ISS")==null?"":rs.getString("EDP_CERT_ISS");
EDP_CERT_ISS_AVG=rs.getString("EDP_CERT_ISS_AVG")==null?"":rs.getString("EDP_CERT_ISS_AVG");
BANK_REJECT=rs.getString("BANK_REJECT")==null?"":rs.getString("BANK_REJECT");
BANK_REJECT_AVG=rs.getString("BANK_REJECT_AVG")==null?"":rs.getString("BANK_REJECT_AVG");

%>									
                                       
<TR>
<TH><A href="index22_st.jsp">INDIA</A></TH>
			 
										 
<TD><%= AGENCY_UP %></TD>                                            
<TD><%= APP_UP_AVG %></TD>
<TD><%= AGN_REJECT %></TD>
<TD><%= APP_UP_REJ %></TD>
<TD><%= BANK_FORD %></TD>
<TD><%= BANK_FORD_AVG %></TD>
<TD><%= BANK_SANC %></TD>
<TD><%= BANK_SANC_AVG %></TD>
<TD><%= OWN_CONT %></TD>
<TD><%= OWN_CONT_AVG %></TD>
<TD><%= IST_LOANSANC %></TD>
<TD><%= IST_LOANSANC_AVG %></TD>
<TD><%= MM_CLAIM %></TD>
										
										
<TD><%= MM_CLAIM_AVG %></TD>
<TD><%= MM_REL %></TD>
<TD><%= MM_REL_AVG %></TD>
<TD><%= EDP_CERT_ISS %></TD>
<TD><%= EDP_CERT_ISS_AVG %></TD>
<TD><%= BANK_REJECT %></TD>
<TD><%= BANK_REJECT_AVG %></TD>
<TD><DIV align="center"><A class="btn btn-primary" href="bankwisedetail.jsp">View</A></DIV></TD>
										
										 
										  
									
											
											
  <%

}
rs.close();
db.close();
%>											
                                        </TR>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </DIV>
                    </DIV>

                </DIV>
                <!-- /.container-fluid -->

            </DIV>
                                                
                                                
                                                
                                                
                                                 
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <DIV class="container my-auto">
                    <DIV class="copyright text-center my-auto">
                        <SPAN>Copyright &copy; KVIC 2021</SPAN>
                    </DIV>
                </DIV>
            </footer>
            <!-- End of Footer -->

        </DIV>
        <!-- End of Content Wrapper -->

    </DIV>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <A class="scroll-to-top rounded" href="#page-top">
        <I class="fas fa-angle-up"></I>
    </A>


<SCRIPT>
function myFunction() {
  var x = document.getElementById("myDIV");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
</SCRIPT>
    <!-- Bootstrap core JavaScript-->
    <SCRIPT src="vendor/jquery/jquery.min.js"></SCRIPT>
    <SCRIPT src="vendor/bootstrap/js/bootstrap.bundle.min.js"></SCRIPT>

    <!-- Core plugin JavaScript-->
    <SCRIPT src="vendor/jquery-easing/jquery.easing.min.js"></SCRIPT>

    <!-- Custom scripts for all pages-->
    <SCRIPT src="js/sb-admin-2.min.js"></SCRIPT>

    <!-- Page level plugins -->
    <SCRIPT src="vendor/datatables/jquery.dataTables.min.js"></SCRIPT>
    <SCRIPT src="vendor/datatables/dataTables.bootstrap4.min.js"></SCRIPT>

    <!-- Page level custom scripts -->
    <SCRIPT src="js/demo/datatables-demo.js"></SCRIPT>
</FORM>
</BODY>

</HTML>