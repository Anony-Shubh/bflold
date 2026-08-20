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
                    columns: [ 0, 1, 2,3,4, 5,6,7,8,9,10]
                }
			
            },
			
			 {
                extend: 'excelHtml5',

				 exportOptions: {
                    columns: [ 0, 1, 2,3,4, 5,6,7,8,9,10]
                }
			
            },
			
			 {
                extend: 'print',
				orientation: 'landscape',
				 pageSize: 'LEGAL',
				 exportOptions: {
                    columns: [ 0, 1, 2,3,4, 5,6,7,8,9,10]
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
document.getElementById("TODT").value=now();
 }

</SCRIPT>


</HEAD>

<BODY>
<FORM name="form" id="form" >
<%List values=new ArrayList();
String vAGN= session.getAttribute("AGENTYPE")==null?"H":(String) session.getAttribute("AGENTYPE");
//out.print(vAGN);
String TYPE=request.getParameter("TYPE")==null?"":(String)request.getParameter("TYPE");

String STATE_CD=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
String STATE_NM=request.getParameter("STATE_NM")==null?"":(String)request.getParameter("STATE_NM");

String GENDERT=request.getParameter("GENDERT")==null?"":request.getParameter("GENDERT");
String ACTCD=request.getParameter("ACTCD")==null?"":request.getParameter("ACTCD");
String STATE_CD_D1=request.getParameter("STATE_CD_D1")==null?"":request.getParameter("STATE_CD_D1");
String ACTSAVE=request.getParameter("ACTSAVE")==null?"":request.getParameter("ACTSAVE");

String AGENTYPE= session.getAttribute("AGENTYPE")==null?"":(String) session.getAttribute("AGENTYPE");
String FROMDT= session.getAttribute("FROMDT")==null?"":(String) session.getAttribute("FROMDT");
String TODT= session.getAttribute("TODT")==null?"":(String) session.getAttribute("TODT");

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

sb.append("  SELECT DISTRICT_CD, DISTRICT_NAME, NO_OF_APP, RET_BY_AGENCY, BANK_FORD, PENDING_AGENCY, LOAN_SANC, CLAIM_BY_BANK_NO, CLAIM_BY_BANK_MM, MM_REL_NO, MM_REL_AMT, FOR_DECISION, BANK_REJ, LOANDIS_MM, round((PENDING_AGENCY/NO_OF_APP)*100,2) as PENDINGPERC, round((RET_BY_AGENCY/NO_OF_APP)*100,2) as RET_BY_AGENCYPERC, round((BANK_FORD/NO_OF_APP)*100,2) as BANK_FORDPERC, round(((NO_OF_APP-FOR_DECISION)/NO_OF_APP)*100,2) as BANKDEC_PER,LOANDIS_NO FROM ( SELECT "      );

sb.append("    MAX(MD.DISTRICT_CD) AS DISTRICT_CD,  nvl(MD.DISTRICT_NAME,' TOTAL')DISTRICT_NAME, "      );

sb.append("   SUM(CASE WHEN TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND ('"+TODT+"') THEN 1 END) AS NO_OF_APP,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID IN (3,7) AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) RET_BY_AGENCY,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID =5 AND TRUNC(BANK_F_DATE) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) BANK_FORD,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID  NOT IN (3,7,5) AND ad.act_yn='Y' AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) PENDING_AGENCY,"      );
sb.append("   SUM(CASE WHEN BD.ACT_ID=11 AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) LOAN_SANC,"      );
sb.append("   SUM(CASE WHEN BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) CLAIM_BY_BANK_NO,"      );
sb.append("   ROUND(SUM(CASE WHEN BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN BD.MM_CLAIM_AMT ELSE 0 END)/10000000,2) CLAIM_BY_BANK_MM,"      );
sb.append("   SUM(CASE WHEN BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) MM_REL_NO,"      );
sb.append("   ROUND(SUM(CASE WHEN BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN BD.MM_REL_AMT ELSE 0 END)/10000000,2) MM_REL_AMT,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID =5 AND "      );
sb.append("    NVL(BD.ACT_ID,0) IN (0,8) AND"      );
sb.append("   TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) FOR_DECISION,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID =5 AND "      );
sb.append("    BD.ACT_ID=3 AND"      );
sb.append("   TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) BANK_REJ,"      );

sb.append("   SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '"+FROMDT+"' AND ('"+TODT+"') THEN ROUND(BD.IST_LOAN_AMT/10000000,2) ELSE 0 END) LOANDIS_MM,    "      );
sb.append("   SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '"+FROMDT+"' AND '"+TODT+"' THEN 1 ELSE 0 END) LOANDIS_NO    "      );

sb.append("   FROM APP_DETAIL AD , BANK_DATAENTRY BD, M_DISTRICT MD, M_STATE MS, MAS_OFF_MAST MOM"      );
sb.append("   WHERE "+whrcls+" "+whrcls2+" AD.APP_ID=BD.APP_ID(+)"      );
sb.append("   AND AD.OFF_CD=MOM.OFF_CD"      );
sb.append("   AND AD.UNIT_DIST_CD=MD.DISTRICT_CD"      );
sb.append("   AND MD.STATE_CD=MS.STATE_CD"      );



sb.append("  AND MS.STATE_CD='"+STATE_CD+"' "      );




sb.append("   GROUP BY ROLLUP(MD.DISTRICT_NAME) ORDER BY MD.DISTRICT_NAME DESC) "      );
//sb.append("   GROUP BY MS.STATE_CD, MS.STATE_NM, MD.DISTRICT_CD, MD.DISTRICT_NAME  "      );
	

  
//out.print(sb.toString());
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
	<A HIDDEN class="btn btn-primary" href="analyticalrep.jsp">Analytical Reports</A>
	
	<A HIDDEN class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=dashboardreportdistrict&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A HIDDEN class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=dashboardreportdistrict&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	
	<A hidden class="btn btn-primary" onClick="myFunction()">Filter</A>
	<A hidden class="btn btn-primary" href="reports/GenerateCSV.jsp?REP_NM=csvtest" >Download CSV test</A>
	<A  class="btn btn-primary" href="logout.jsp">Logout</A>
	</DIV>

                    <!-- DataTales Example -->
                    <DIV class="card shadow mb-4">
                      
                        <DIV class="card-body">
                            <DIV class="table-responsive">
							 
							<DIV align="center"><H3><%= STATE_NM %>  Data from <%= FROMDT %> TO <%= TODT %> (Agency: 
   <%if(AGENTYPE.equals("")){%>
	 All
	 <%}%>
	 <%=AGENTYPE%>)
	 </H3></DIV>
                       
						    <TABLE class="table table-striped" id="example" width="100%" cellspacing="0">
                                    <THEAD>
                                        <TR>
                                       
										  
										  <TH>District</TH>
										  
                                            <TH>Application Received</TH>
                                            <TH>Returned by Agency</TH>
                                            <TH>Pending at Agency</TH>
                                            <TH>Forwarded to Bank</TH>
                                            <TH>Loan Sanc. (in No ) </TH>
                                            <TH>Loan Disb.(in No ) </TH>
                                            <TH>Claimed by Bank (in No.) / (MM in Cr.) </TH>
                                            <TH>MM Released (in No.) / (Amt. in Cr.)</TH>
                                            <TH>Pending for credit decision at Bank</TH>
                                           
                                            <TH>Rejected by Bank</TH>
											
											<TH>Application Status</TH>
   										    <TH>Age Wise</TH>
                                            <TH>Rejection Detail</TH>
                                            <TH>Bankwise Detail </TH>
                                        </TR>
                                    </THEAD>
                                    <TFOOT>
                                        <TR>
                                        
										 
										  <TH>District</TH>
										 
                                            <TH>Application Received</TH>
                                            <TH>Returned by Agency</TH>
                                            <TH>Pending at Agency</TH>
                                            <TH>Forwaded to Bank</TH>
                                            <TH>Loan Sanc. (in No ) </TH>
                                            <TH>Loan Disb.(in No ) </TH>
                                            <TH>Claimed by Bank (in No.) / (MM in Cr.) </TH>
                                            <TH>MM Released (in No.) / (Amt. in Cr.)</TH>
                                            <TH>Pending for decision by Bank</TH>
                                           
											<TH>Rejected by Bank</TH>
                                           
											<TH>Application Status</TH>
   										    <TH>Age Wise</TH>
                                            <TH>Rejection Detail</TH>
                                            <TH>Bankwise Detail </TH>
                                        </TR>
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

DISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");

LOANDIS_MM=rs.getString("LOANDIS_MM")==null?"":rs.getString("LOANDIS_MM");
LOANDIS_NO=rs.getString("LOANDIS_NO")==null?"":rs.getString("LOANDIS_NO");

PENDINGPERC=rs.getString("PENDINGPERC")==null?"":rs.getString("PENDINGPERC");
RET_BY_AGENCYPERC=rs.getString("RET_BY_AGENCYPERC")==null?"":rs.getString("RET_BY_AGENCYPERC");
BANK_FORDPERC=rs.getString("BANK_FORDPERC")==null?"":rs.getString("BANK_FORDPERC");
BANKDEC_PER=rs.getString("BANKDEC_PER")==null?"":rs.getString("BANKDEC_PER");
session.setAttribute("FROMDT",FROMDT);
session.setAttribute("TODT",TODT);
session.setAttribute("STATE_NM",STATE_NM);
session.setAttribute("STATE_CD",STATE_CD);
session.setAttribute("AGENTYPE",AGENTYPE);

session.setAttribute("DISTRICT_NAME",DISTRICT_NAME);
session.setAttribute("DISTRICT_CD",DISTRICT_CD);
%>									
                                       
<TR>
										
										


<%if(DISTRICT_NAME.equals(" TOTAL")){%>	
								 
<TD><%= DISTRICT_NAME %></TD>
<TD><DIV align="right"><%= NO_OF_APP %></DIV></TD>
<TD><DIV align="right"><%= RET_BY_AGENCY %></A></DIV></TD>
<TD><DIV align="right"><%= PENDING_AGENCY %></A></DIV></TD>
<TD><DIV align="right"><%= BANK_FORD %></A></DIV></TD>
<TD><DIV align="right"><%= LOAN_SANC %></A></DIV></TD>
<TD><DIV align="right"><%= LOANDIS_NO %></DIV></TD>
<TD><DIV align="right"><%= CLAIM_BY_BANK_NO %> / <%= CLAIM_BY_BANK_MM %></DIV></TD>
<TD><DIV align="right"><%= MM_REL_NO %> / <%= MM_REL_AMT %></DIV></TD>
<TD><DIV align="right"><%= FOR_DECISION %></A></DIV></TD>

<TD><DIV align="right"><%= BANK_REJ %></A></DIV></TD>

<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD><DIV align="center">-</DIV></TD>
										  										  
<%}else{%>									

<TD><%= DISTRICT_NAME %></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=1&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= NO_OF_APP %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=2&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= RET_BY_AGENCY %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=4&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= PENDING_AGENCY %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=3&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= BANK_FORD %></A></DIV></TD>

<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=5&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= LOAN_SANC %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=12&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= LOANDIS_NO %></A></DIV></TD>
<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=6&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= CLAIM_BY_BANK_NO %> / <%= CLAIM_BY_BANK_MM %></A></DIV></TD>

<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=8&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= MM_REL_NO %> / <%= MM_REL_AMT %></A></DIV></TD>

<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=10&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= FOR_DECISION %></A></DIV></TD>

<TD><DIV align="right"><A target="_blank" href="reports/GenerateXLS.jsp?AGENTYPE=<%= AGENTYPE %>&TYPE=D&REP_NM=detailed&REPTYPE=11&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>"><%= BANK_REJ %></A></DIV></TD>

	
<TD hidden>
<BUTTON type="button" class="btn btn-primary modalButton" DATA-TOGGLE="modal" DATA-ID="<%= STATE_CD %>">More</BUTTON></TD>	

<TD><A href="AppStatusRepo.jsp?STATE_CD=<%= STATE_CD %>&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&DLEVEL=3" class="btn btn-primary">More</A></TD>	

<TD><A href="AgeWiseRepo.jsp?STATE_CD=<%= STATE_CD %>&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&DLEVEL=3&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" class="btn btn-primary">More</A></TD>	



<TD><A href="rejectiondetail.jsp?STATE_CD=<%= STATE_CD %>&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&STATE_NM=<%= STATE_NM %>&DLEVEL=3" class="btn btn-primary">More</A></TD>	



<TD><DIV align="center"><A class="btn btn-primary" href="bankwisedetail.jsp?TYPE=D&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&DLEVEL=3">View</A></DIV></TD>


<%}%>
											
											
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




</FORM>
</BODY>

</HTML>