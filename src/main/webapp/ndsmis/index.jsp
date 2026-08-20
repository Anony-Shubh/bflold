<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon,java.util.Date,java.util.*,java.text.SimpleDateFormat"  %>
<%//@ include file="includesessionpage.jsp" %>
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

    <LINK href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css" rel="stylesheet">
    <LINK href="https://cdn.datatables.net/buttons/1.7.0/css/buttons.dataTables.min.css" rel="stylesheet">

<SCRIPT type="text/javascript" src="js/datetimepicker_css.js"></SCRIPT>

<SCRIPT type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.0/js/dataTables.buttons.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.0/js/buttons.html5.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.0/js/buttons.print.min.js"></SCRIPT>








<SCRIPT language="javascript">


$(document).ready(function() {
    $('#example').DataTable( {
        dom: 'Bfrtip',
		
        buttons: [
          
		  {
                extend: 'pdfHtml5',
                orientation: 'landscape',
                pageSize: 'LEGAL',
				 exportOptions: {
                    columns: [ 0, 1, 2,3,4, 5,6,7,8,9,11 ]
                }
			
            },
			
			 {
                extend: 'excelHtml5',

				 exportOptions: {
                    columns: [ 0, 1, 2,3,4, 5,6,7,8,9,11 ]
                }
			
            },
			
			 {
                extend: 'print',
				orientation: 'landscape',
				 pageSize: 'LEGAL',
				 exportOptions: {
                    columns: [ 0, 1, 2,3,4, 5,6,7,8,9,11 ]
                }
			
            }
			
			
			
        ]
		
		
    } );
} );


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
document.getElementById("TODT").value='31-Mar-2021';
 }

</SCRIPT>

<STYLE>
.modal{
 padding: 30px !important;
}
.modal-dialog {
  max-width: 100% !important;
  height: auto;
  padding: 0;
  margin: 0;
}

.modal-content {
  border-radius: 0 !important;
  height: auto;
}
</STYLE>

</HEAD>

<BODY onLoad="todaydt();" id="page-top">
<FORM name="form" id="form" >
<%
 Date dNow = new Date( );
   SimpleDateFormat ft = new SimpleDateFormat ("dd-MMM-yyyy"); 
String DT="31-Mar-2021";



List values=new ArrayList();

String TYPE=request.getParameter("TYPE")==null?"A":(String)request.getParameter("TYPE");

String STATE_CD=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
String STATE_NM=request.getParameter("STATE_NM")==null?"":(String)request.getParameter("STATE_NM");

String GENDERT=request.getParameter("GENDERT")==null?"":request.getParameter("GENDERT");
String ACTCD=request.getParameter("ACTCD")==null?"":request.getParameter("ACTCD");
String AGENTYPE=request.getParameter("AGENTYPE")==null?"":request.getParameter("AGENTYPE");
String STATE_CD_D1=request.getParameter("STATE_CD_D1")==null?"":request.getParameter("STATE_CD_D1");
String ACTSAVE=request.getParameter("ACTSAVE")==null?"":request.getParameter("ACTSAVE");

String FROMDT=request.getParameter("FROMDT")==null?"01-APR-2020":request.getParameter("FROMDT");
String TODT=request.getParameter("TODT")==null?"":request.getParameter("TODT");

if (TODT.equals("")){
TODT=DT;
}
else{
TODT=TODT;
}

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

 StringBuffer sb= new StringBuffer();
sb.append("   SELECT /*+ PARALLEL(AUTO) */"      );
sb.append("     SUM(RET_BY_AGENCY)     AS RET_BY_AGENCY,"      );
sb.append("     SUM(BANK_FORD)         AS BANK_FORD,"      );
sb.append("     SUM(PENDING_AGENCY)    AS PENDING_AGENCY,"      );
sb.append("     SUM(LOAN_SANC)         AS LOAN_SANC,"      );
sb.append("     SUM(CLAIM_BY_BANK_NO)  AS CLAIM_BY_BANK_NO,"      );
sb.append("     SUM(CLAIM_BY_BANK_MM)  AS CLAIM_BY_BANK_MM,"      );
sb.append("     SUM(FOR_DECISION)      AS FOR_DECISION,"      );
sb.append("     SUM(BANK_REJ)          AS BANK_REJ,"      );
sb.append("     SUM(LOANDIS_MM)        AS LOANDIS_MM,"      );
sb.append("      ROUND((SUM(PENDING_AGENCY) / SUM(NULLIF(NO_OF_APP,0))) * 100, 2)                 AS PENDINGPERC,"      );
sb.append("     ROUND((SUM(RET_BY_AGENCY) / SUM(NULLIF(NO_OF_APP,0))) * 100, 2)                 AS RET_BY_AGENCYPERC,"      );
sb.append("      ROUND((SUM(BANK_FORD) / SUM(NULLIF(NO_OF_APP,0))) * 100, 2)                 AS BANK_FORDPERC,"      );
sb.append("       ROUND(((SUM(NO_OF_APP)-SUM(FOR_DECISION)) / SUM(NULLIF(NO_OF_APP,0))) * 100, 2)                 AS BANKDEC_PER,"      );
sb.append("     "      );
sb.append("    SUM(LOANDIS_NO)        AS LOANDIS_NO,"      );
sb.append("     SUM(NO_OF_APP)         AS NO_OF_APP, "      );
sb.append("        SUM(MM_REL_NO) AS MM_REL_NO ,"      );
sb.append("       ROUND(SUM(MM_REL_AMT),2) MM_REL_AMT"      );
sb.append("       "      );
sb.append("       FROM("      );
sb.append("    SELECT  NO_OF_APP, RET_BY_AGENCY, BANK_FORD, PENDING_AGENCY, LOAN_SANC, CLAIM_BY_BANK_NO, CLAIM_BY_BANK_MM,  FOR_DECISION, BANK_REJ, LOANDIS_MM, "      );
sb.append("    LOANDIS_NO,MM_REL_NO, MM_REL_AMT FROM (  SELECT "      );
sb.append("   "      );
sb.append("      SUM(CASE WHEN TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND ('"+TODT+"') THEN 1 END) AS NO_OF_APP,"      );
sb.append("      SUM(CASE WHEN AD.ACT_ID IN (3,7) AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) RET_BY_AGENCY,"      );
sb.append("      SUM(CASE WHEN AD.ACT_ID =5 AND TRUNC(BANK_F_DATE) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) BANK_FORD,"      );
sb.append("      SUM(CASE WHEN AD.ACT_ID  NOT IN (3,7,5)  AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) PENDING_AGENCY,"      );
sb.append("      SUM(CASE WHEN BD.ACT_ID=11 AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) LOAN_SANC,"      );
sb.append("      SUM(CASE WHEN BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) CLAIM_BY_BANK_NO,"      );
sb.append("      ROUND(SUM(CASE WHEN BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN BD.MM_CLAIM_AMT ELSE 0 END)/10000000,2) CLAIM_BY_BANK_MM,"      );
sb.append("    "      );
sb.append("      SUM(CASE WHEN AD.ACT_ID =5 AND "      );
sb.append("       NVL(BD.ACT_ID,0) IN (0,8) AND"      );
sb.append("      TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) FOR_DECISION,"      );
sb.append("      SUM(CASE WHEN AD.ACT_ID =5 AND "      );
sb.append("       BD.ACT_ID=3 AND"      );
sb.append("      TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) BANK_REJ, "      );
sb.append("   "      );
sb.append("      SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '"+FROMDT+"' AND '"+TODT+"' THEN ROUND(BD.IST_LOAN_AMT/10000000,2) ELSE 0 END) LOANDIS_MM,    "      );
sb.append("      "      );
sb.append("   SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '"+FROMDT+"' AND '"+TODT+"' THEN 1 ELSE 0 END) LOANDIS_NO  ,"      );
sb.append("   "      );
sb.append("        SUM(CASE WHEN BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("      AND ('"+TODT+"') THEN 1 ELSE 0 END) MM_REL_NO,"      );
sb.append("         SUM(NVL("      );
sb.append("           CASE"      );
sb.append("             WHEN   TRUNC(bd.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'  "      );
sb.append("           "      );
sb.append("             AND bd.PACT_ID  = 34"      );
sb.append("                THEN (bd.MM_REL_AMT / 10000000)"      );
sb.append("           END, 0)) AS MM_REL_AMT"      );
sb.append("   "      );
sb.append("      FROM APP_DETAIL AD , BANK_DATAENTRY BD, M_DISTRICT MD, M_STATE MS, MAS_OFF_MAST MOM"      );
sb.append("      WHERE "+whrcls+" "+whrcls2+" "+whrcls3+" AD.APP_ID=BD.APP_ID(+)"      );
sb.append("      AND AD.OFF_CD=MOM.OFF_CD"      );
sb.append("      AND AD.UNIT_DIST_CD=MD.DISTRICT_CD"      );
sb.append("      AND MD.STATE_CD=MS.STATE_CD     and AD.BENF_CATAGORY_CD IN ('ST')      )    "      );
sb.append("       UNION ALL"      );
sb.append("        (SELECT "      );
sb.append("        "      );
sb.append("           0,0,0,0,0,0,0,0,0,0,0,"      );
sb.append("           SUM(NVL("      );
sb.append("           CASE"      );
sb.append("             WHEN   TRUNC(bd.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' "      );
sb.append("             AND bd.ACT_ID  >= 11"      );
sb.append("             AND bd.PACT_ID  = 34"      );
sb.append("             AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
sb.append("             AND bd.MM_CLAIM_DT    IS NOT NULL    THEN 1"      );
sb.append("           END, 0)) AS MM_REL_NO,"      );
sb.append("             SUM(NVL("      );
sb.append("           CASE"      );
sb.append("             WHEN   TRUNC(bd.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'  "      );
sb.append("             AND bd.ACT_ID  >= 11"      );
sb.append("             AND bd.PACT_ID  = 34"      );
sb.append("             AND bd.LOAN_DOCFNAME  IS NOT NULL"      );
sb.append("             AND bd.MM_CLAIM_DT    IS NOT NULL    THEN (bd.MM_REL_AMT / 10000000)"      );
sb.append("           END, 0)) AS MM_REL_AMT"      );
sb.append("           "      );
sb.append("            FROM APP_DETAIL_SECOND AD,"      );
sb.append("          BANK_DATAENTRY_SECOND BD,"      );
sb.append("          M_DISTRICT MD,"      );
sb.append("          M_STATE MS,"      );
sb.append("          MAS_OFF_MAST MOM"      );
sb.append("        WHERE "+whrcls+" "+whrcls2+" "+whrcls3+"  AD.APP_ID     = BD.APP_ID(+)"      );
sb.append("        AND AD.OFF_CD       = MOM.OFF_CD"      );
sb.append("        AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
sb.append("        AND MD.STATE_CD     = MS.STATE_CD     and AD.BENF_CATAGORY_CD IN ('ST')     "      );
sb.append("        ) UNION ALL "      );
sb.append("        (SELECT "      );
sb.append("        "      );
sb.append("           0,0,0,0,0,0,0,0,0,0,0,"      );
sb.append("           SUM(1) AS MM_REL_NO ,   "      );

sb.append("            ROUND(SUM(cf.MARGIN_AMOUNT_CLAIMED) / 10000000, 2)  AS MM_REL_AMT    "      );

sb.append("            FROM PMEGPONLINE.CORPDATA_FINAL CF,"      );
sb.append("          PMEGPONLINE.APP_DETAIL AD,"      );
sb.append("          PMEGPONLINE.m_district dm,"      );
sb.append("          PMEGPONLINE.mas_off_mast mom,"      );
sb.append("            PMEGPONLINE.m_state ms "      );
sb.append("    WHERE "+whrcls+" "+whrcls2+" "+whrcls3+"  "      );
sb.append("    CF.APP_ID       = AD.APP_ID"      );
sb.append("   AND AD.UNIT_DIST_CD     = dm.DISTRICT_CD "      );
sb.append("  AND dm.STATE_CD         = ms.STATE_CD "      );
sb.append("        AND AD.OFF_CD       = MOM.OFF_CD     and AD.BENF_CATAGORY_CD IN ('ST')     "      );

sb.append("        AND CF.APR_YEAR=( select getfinyr('"+FROMDT+"')  from dual)    "      );

sb.append("        )"      );
sb.append("      )"      );
sb.append("      "      );


DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());
ResultSet rs = db.execSQL(sb.toString());
//ResultSet rs = db.executeSQL(sb.toString(),values);


String NO_OF_APP="";
String RET_BY_AGENCY="";
String BANK_FORD="";
String PENDING_AGENCY="";
String LOAN_SANC="";
String CLAIM_BY_BANK_NO="";
String CLAIM_BY_BANK_MM="";
String MM_REL_NO="";
String MM_REL_AMT="";
String FOR_DECISION="";
String BANK_REJ="";

String DISTRICT_CD="";
String DISTRICT_NAME="";

String LOANDIS_MM="";
String LOANDIS_NO="";

String PENDINGPERC="";
String RET_BY_AGENCYPERC="";
String BANK_FORDPERC="";
String BANKDEC_PER="";

%>

    <!-- Page Wrapper -->
    <DIV id="wrapper">


        <!-- Content Wrapper -->
        <DIV id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <DIV id="content">

<BR>

                <!-- Begin Page Content -->
                <DIV class="container-fluid">
	
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

<INPUT type="hidden" name="ACTSAVE" id="ACTSAVE" value="<%= ACTCD %>">  

<INPUT type="submit" value="Go" onClick="changetype()" >
</CENTER>
</DIV>
</br>
                    <!-- DataTales Example -->
                    <DIV class="card shadow mb-4">
                      
                        <DIV class="card-body">
                            <DIV class="table-responsive">
							  
							<DIV align="center"><H3>PMEGP Portal online Performance Report for ST<br>Data from <%= FROMDT %> TO <%= TODT %>(Agency: 
   <%if(AGENTYPE.equals("")){%>
	 All
	 <%}%>
	 <%=AGENTYPE%>)
	 </H3></DIV>
                         
							    <TABLE class="table table-striped" id="example" width="100%" cellspacing="0">
                                    <THEAD>
                                        <TR>
                                          <TH><DIV align="center">Country</DIV></TH>
										  
										  
                                            <TH><DIV align="center">Application Received</DIV></TH>
                                            <TH><DIV align="center">Returned by Agency</DIV></TH>
                                            <TH><DIV align="center">Pending at Agency</DIV></TH>
                                            <TH><DIV align="center">Forwarded to Bank*</DIV></TH>
                                            <TH><DIV align="center">Loan Sanc. (No)*</DIV></TH>
                                            <TH><DIV align="center">Loan Disb. (No)*</DIV></TH>
                                            <TH><DIV align="center">Claimed by Bank (No) / (MM in Cr.)*</DIV></TH>
                                            <TH><DIV align="center">MM Released (No) / (Amt.Cr.)*</DIV></TH>
                                            <TH><DIV align="center">Pending for Credit Decision at Bank</DIV></TH>
                                            <TH hidden><DIV align="center">% Decided by Bank </DIV></TH>
                                            <TH><DIV align="center">Rejected by Bank</DIV></TH>
										</TR>
                                    </THEAD>
                                    <TFOOT>
                                    </TFOOT>
                                    <TBODY>
				
									
 <%
int count=0;
while (rs.next()) {
count=count+1;
NO_OF_APP=rs.getString("NO_OF_APP")==null?"":rs.getString("NO_OF_APP");
RET_BY_AGENCY=rs.getString("RET_BY_AGENCY")==null?"":rs.getString("RET_BY_AGENCY");
BANK_FORD=rs.getString("BANK_FORD")==null?"":rs.getString("BANK_FORD");
PENDING_AGENCY=rs.getString("PENDING_AGENCY")==null?"":rs.getString("PENDING_AGENCY");
LOAN_SANC=rs.getString("LOAN_SANC")==null?"":rs.getString("LOAN_SANC");
CLAIM_BY_BANK_NO=rs.getString("CLAIM_BY_BANK_NO")==null?"":rs.getString("CLAIM_BY_BANK_NO");
CLAIM_BY_BANK_MM=rs.getString("CLAIM_BY_BANK_MM")==null?"":rs.getString("CLAIM_BY_BANK_MM");
MM_REL_NO=rs.getString("MM_REL_NO")==null?"":rs.getString("MM_REL_NO");
MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
FOR_DECISION=rs.getString("FOR_DECISION")==null?"":rs.getString("FOR_DECISION");
BANK_REJ=rs.getString("BANK_REJ")==null?"":rs.getString("BANK_REJ");
LOANDIS_MM=rs.getString("LOANDIS_MM")==null?"":rs.getString("LOANDIS_MM");
LOANDIS_NO=rs.getString("LOANDIS_NO")==null?"":rs.getString("LOANDIS_NO");

PENDINGPERC=rs.getString("PENDINGPERC")==null?"":rs.getString("PENDINGPERC");
RET_BY_AGENCYPERC=rs.getString("RET_BY_AGENCYPERC")==null?"":rs.getString("RET_BY_AGENCYPERC");
BANK_FORDPERC=rs.getString("BANK_FORDPERC")==null?"":rs.getString("BANK_FORDPERC");
BANKDEC_PER=rs.getString("BANKDEC_PER")==null?"":rs.getString("BANKDEC_PER");

session.setAttribute("FROMDT",FROMDT);
session.setAttribute("TODT",TODT);
session.setAttribute("AGENTYPE",AGENTYPE);

%>									
                                       
                                        <TR>
                                          <TH><A href="index_st.jsp">ALL INDIA</A></TH>
										
										
										 
										 
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=1&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= NO_OF_APP %></A></DIV></TD>                                            
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=2&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= RET_BY_AGENCY %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed_pend&REPTYPE=4&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= PENDING_AGENCY %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=3&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= BANK_FORD %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=5&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= LOAN_SANC %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=12&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= LOANDIS_NO %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=6&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= CLAIM_BY_BANK_NO %> / </A><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=7&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= CLAIM_BY_BANK_MM %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=8&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= MM_REL_NO %> / </A><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=9&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= MM_REL_AMT %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=10&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= FOR_DECISION %></A></DIV></TD>
<TD hidden><DIV align="right"><%= BANKDEC_PER %>%</DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=A&REP_NM=detailed&REPTYPE=11&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= BANK_REJ %></A></DIV></TD>
											
	
<%

}
rs.close();
db.close();
%>											
                                        </TR>
                                    </TBODY>
                                </TABLE>
<DIV align="right">(*) includes previous years applications</DIV>
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



</FORM>
</BODY>

</HTML>