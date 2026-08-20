<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
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

<SCRIPT>
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

<BODY onLoad="todaydt();" id="page-top">
<FORM name="form" id="form" >
 <%
List values=new ArrayList();

String TYPE=request.getParameter("TYPE")==null?"A":(String)request.getParameter("TYPE");
String STATE_CD=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
String STATE_NM=request.getParameter("STATE_NM")==null?"":(String)request.getParameter("STATE_NM");
String DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":(String)request.getParameter("DISTRICT_CD");
String DISTRICT_NAME=request.getParameter("DISTRICT_NAME")==null?"":(String)request.getParameter("DISTRICT_NAME");
String BANK_NAME="";

String FROMDT=request.getParameter("FROMDT")==null?"01-APR-2020":request.getParameter("FROMDT");
String TODT=request.getParameter("TODT")==null?"01-APR-2021":request.getParameter("TODT");

String FROMDT1="";
String TODT1="";

StringBuffer sb= new StringBuffer();

sb.append("  SELECT NVL(BANK_NAME,' TOTAL') AS BANK_NAME, BANK_FORD, LOAN_SANC, CLAIM_BY_BANK_NO, CLAIM_BY_BANK_MM, MM_REL_NO, MM_REL_AMT, FOR_DECISION, BANK_REJ FROM ( SELECT "      );
sb.append("    RBL.BANK_NAME,"      );
sb.append("     SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN AD.ACT_ID = 5"      );
sb.append("       AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN 1"      );
sb.append("       ELSE 0"      );
sb.append("     END) BANK_FORD,"      );
sb.append("    "      );
sb.append("     SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN BD.ACT_ID = 11"      );
sb.append("       AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN 1"      );
sb.append("       ELSE 0"      );
sb.append("     END) LOAN_SANC,"      );
sb.append("     SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN BD.ACT_ID = 11"      );
sb.append("       AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN 1"      );
sb.append("       ELSE 0"      );
sb.append("     END) CLAIM_BY_BANK_NO,"      );
sb.append("     ROUND(SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN BD.ACT_ID = 11"      );
sb.append("       AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN BD.MM_CLAIM_AMT"      );
sb.append("       ELSE 0"      );
sb.append("     END) / 10000000, 2) CLAIM_BY_BANK_MM,"      );
sb.append("     SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN BD.PACT_ID = 34"      );
sb.append("       AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN 1"      );
sb.append("       ELSE 0"      );
sb.append("     END) MM_REL_NO,"      );
sb.append("     ROUND(SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN BD.PACT_ID = 34"      );
sb.append("       AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN BD.MM_REL_AMT"      );
sb.append("       ELSE 0"      );
sb.append("     END) / 10000000, 2) MM_REL_AMT,"      );
sb.append("     SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN AD.ACT_ID         = 5"      );
sb.append("       AND NVL(BD.ACT_ID, 0) IN (0, 8)"      );
sb.append("       AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN 1"      );
sb.append("       ELSE 0"      );
sb.append("     END) FOR_DECISION,"      );
sb.append("     SUM("      );
sb.append("     CASE"      );
sb.append("       WHEN AD.ACT_ID = 5"      );
sb.append("       AND BD.ACT_ID  = 3"      );
sb.append("       AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"'"      );
sb.append("       THEN 1"      );
sb.append("       ELSE 0"      );
sb.append("     END) BANK_REJ"      );
sb.append("    "      );
sb.append("   FROM APP_DETAIL AD,"      );
sb.append("     BANK_DATAENTRY BD,"      );
sb.append("     M_DISTRICT MD,"      );
sb.append("     M_STATE MS,"      );
sb.append("     MAS_OFF_MAST MOM,"      );
sb.append("     RBIBANKLIST RBL"      );
sb.append("   WHERE AD.APP_ID    = BD.APP_ID(+)"      );
sb.append("   AND AD.OFF_CD      = MOM.OFF_CD"      );
sb.append("   AND AD.APP_DIST_CD = MD.DISTRICT_CD"      );
sb.append("   AND MD.STATE_CD    = MS.STATE_CD"      );
sb.append("   AND AD.IFSC_CODE   = RBL.IFSC_CODE"      );

if(TYPE.equals("S")){
sb.append("  AND MS.STATE_CD='"+STATE_CD+"' "      );
}


if(TYPE.equals("D")){
sb.append("  AND MD.DISTRICT_CD='"+DISTRICT_CD+"' "      );
}

sb.append("   GROUP BY "      );
sb.append("     ROLLUP(RBL.BANK_NAME) "      );
sb.append("      ) ORDER BY BANK_NAME"      );




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



%>

    <!-- Page Wrapper -->
    <DIV id="wrapper">

     

        <!-- Content Wrapper -->
        <DIV id="content-wrapper" class="d-flex flex-column">
<IMG src="img/banner3.jpg" >   <BR>
            <!-- Main Content -->
            <DIV id="content">



                <!-- Begin Page Content -->
                <DIV class="container-fluid">
	<DIV align="center">			
	<A class="btn btn-primary" href="index.jsp">Home</A>
	<A class="btn btn-primary" href="index22.jsp">Summarized Reports</A>
	<A class="btn btn-primary" href="pmegp/index.jsp">Pending Reports</A>
	 <%if(TYPE.equals("A")){%>
	<A class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=bankwise&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=bankwise&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	<%}%>
	 <%if(TYPE.equals("S")){%>
	<A class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=bankwisestate&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=bankwisestate&STATE_CD=<%= STATE_CD %>&STATE_NM=<%= STATE_NM %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	<%}%>
	 <%if(TYPE.equals("D")){%>
	<A class="btn btn-primary" target="_blank" href="reports/dashboardrep.jsp?REP_NM=bankwisedistrict&STATE_NM=<%= STATE_NM %>&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>">Download PDF</A>
	<A class="btn btn-primary" href="reports/GenerateXLS.jsp?REP_NM=bankwisedistrict&STATE_NM=<%= STATE_NM %>&DISTRICT_CD=<%= DISTRICT_CD %>&DISTRICT_NAME=<%= DISTRICT_NAME %>&FROMDT=<%= FROMDT %>&TODT=<%= TODT %>" >Download Excel</A>
	<%}%>
	</DIV>
	
	
	  <CENTER>

<INPUT name="FROMDT" type="text" id="FROMDT" value="<%= FROMDT %>" onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')"  maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="From date">

<INPUT name="TODT" type="text" id="TODT" value="<%= TODT %>" onClick="javascript:NewCssCal('TODT','ddMMMyyyy')"  maxlength="11" readonly="true"  autocomplete="off" PLACEHOLDER="To date">

  <INPUT type="hidden" name="STATE_CD" id="STATE_CD" value="<%= STATE_CD %>"> 
  
  <INPUT type="hidden" name="STATE_NM" id="STATE_NM" value="<%= STATE_NM %>">   
  
  <INPUT type="hidden" name="DISTRICT_CD" id="DISTRICT_CD" value="<%= DISTRICT_CD %>">  
  
  <INPUT type="hidden" name="DISTRICT_NAME" id="DISTRICT_NAME" value="<%= DISTRICT_NAME %>">  

<INPUT type="hidden" name="TYPE" id="TYPE" value="<%= TYPE %>">  

<INPUT type="submit" value="Go" onClick="changetype()" >
</CENTER>

                    <!-- DataTales Example -->
                    <DIV class="card shadow mb-4">
                      
                        <DIV class="card-body">
                            <DIV class="table-responsive">
							  <%if(TYPE.equals("A")){%>
							<DIV align="center"><H3>Data from <%= FROMDT %> TO <%= TODT %></H3></DIV>
							  <%}%>
							  <%if(TYPE.equals("S")){%>
							<DIV align="center"><H3>Bankwise Details for <%= STATE_NM %> (Data from <%= FROMDT %> TO <%= TODT %>)</H3></DIV>
                            <%}%>
							
							  <%if(TYPE.equals("D")){%>
							<DIV align="center"><H3>Bankwise Details for <%= DISTRICT_NAME %>, <%= STATE_NM %> (Data from <%= FROMDT %> TO <%= TODT %>)</H3></DIV>
                            <%}%>
							
							    <TABLE class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                                    <THEAD>
                                        <TR>
                                          <TH>Sr. No. </TH>
										  
										  <TH>Bank Name</TH>
										 
                                            <TH>Forwaded to Bank</TH>
                                            <TH>Loan Sanctioned</TH>
                                            <TH>Claim by Bank (in No.)</TH>
                                            <TH>Claim by Bank (MM. in Crs)</TH>
                                            <TH>MM Released (in No.)</TH>
                                            <TH>MM Released (Amt. in Crs)</TH>
                                            <TH>Pending for decision at Bank</TH>
                                            <TH>Rejected by Bank</TH>
                                        </TR>
                                    </THEAD>
                                    <TFOOT>
                                        <TR>
                                          <TH>Sr. No. </TH>
										  
										  <TH>Bank Name</TH>
										
                                            <TH>Bank Forwaded </TH>
                                            <TH>Loan Sanctioned </TH>
                                            <TH>Claim by Bank (in No.)</TH>
                                            <TH>Claim by Bank (MM. in Crs)</TH>
                                            <TH>MM Released (in No.)</TH>
                                            <TH>MM Released (Amt. in Crs)</TH>
                                            <TH>Pending for decision by Bank</TH>
                                            <TH>Rejected by Bank</TH>
                                        </TR>
                                    </TFOOT>
                                    <TBODY>
				
									
 <%
int count=0;
while (rs.next()) {
count=count+1;

BANK_FORD=rs.getString("BANK_FORD")==null?"":rs.getString("BANK_FORD");
LOAN_SANC=rs.getString("LOAN_SANC")==null?"":rs.getString("LOAN_SANC");
CLAIM_BY_BANK_NO=rs.getString("CLAIM_BY_BANK_NO")==null?"":rs.getString("CLAIM_BY_BANK_NO");
CLAIM_BY_BANK_MM=rs.getString("CLAIM_BY_BANK_MM")==null?"":rs.getString("CLAIM_BY_BANK_MM");
MM_REL_NO=rs.getString("MM_REL_NO")==null?"":rs.getString("MM_REL_NO");
MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
FOR_DECISION=rs.getString("FOR_DECISION")==null?"":rs.getString("FOR_DECISION");
BANK_REJ=rs.getString("BANK_REJ")==null?"":rs.getString("BANK_REJ");
BANK_NAME=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
%>									
                                       
                                        <TR>
                                          <TD><%= count %></TD>
										
										  <TH><%= BANK_NAME %></TH>
																				 
										    <TD><%= BANK_FORD %></TD>
                                            <TD><%= LOAN_SANC %></TD>
                                            <TD><%= CLAIM_BY_BANK_NO %></TD>
                                            <TD><%= CLAIM_BY_BANK_MM %></TD>
                                            <TD><%= MM_REL_NO %></TD>
                                            <TD><%= MM_REL_AMT %></TD>
                                            <TD><%= FOR_DECISION %></TD>
                                            <TD><%= BANK_REJ %></TD>
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

    <!-- Logout Modal-->
    <DIV class="modal fade" id="logoutModal" TABINDEX="-1" ROLE="dialog" ARIA-LABELLEDBY="exampleModalLabel"
        aria-hidden="true">
        <DIV class="modal-dialog" ROLE="document">
            <DIV class="modal-content">
                <DIV class="modal-header">
                    <H5 class="modal-title" id="exampleModalLabel">Ready to Leave?</H5>
                    <BUTTON class="close" type="button" DATA-DISMISS="modal" ARIA-LABEL="Close">
                        <SPAN ARIA-HIDDEN="true">×</SPAN>
                    </BUTTON>
                </DIV>
                <DIV class="modal-body">Select "Logout" below if you are ready to end your current session.</DIV>
                <DIV class="modal-footer">
                    <BUTTON class="btn btn-secondary" type="button" DATA-DISMISS="modal">Cancel</BUTTON>
                    <A class="btn btn-primary" href="login.html">Logout</A>
                </DIV>
            </DIV>
        </DIV>
    </DIV>

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