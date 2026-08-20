<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>DASHBOARD</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href="css/style.css" rel="stylesheet">
    <link href="Media Query/media.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
</head>

<body>
    <section class="main" id="main">
        <header class="top-banner mt-1 mb-1" style="width: 100%;" id="myDiv1">
            <div class="container-fluid">
                <img src="img/chairman_dashboard (7).jpeg" style="margin: 0; width: 100%;">
            </div>
        </header>
        <section class="ftco-section">
            <nav class="navbar navbar-expand-lg" id="ftco-navbar">
                <div class="container">

                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                        aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="fa fa-bars" style="color: #fff;"> MENU</span>
                    </button>
                    <div class="logout order-lg-last">

                         <a href="logout.jsp">Logout</a>

                    </div>
                    <div class="collapse navbar-collapse" id="ftco-nav">
                        <ul class="navbar-nav mr-auto" ID="ftco-ul">
                        <li class="nav-item"><a href="homepage.jsp" class="nav-link">Home</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Tour</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Leave</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Change Password</a></li>
							 <li class="nav-item"><a href="smsservice.jsp" class="nav-link">SMS Service</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </section>
		<%
		DBCon db= new DBCon();
db.connect();

	 List values=new ArrayList();	
String OFF_NAME="";
String PRJ_NO_TGT="";
String MM_TGT="";
String APP_REC="";
String bank_ford="";
String bank_sanc="";
String bank_sanc_mm="";
String CLAIM_NO="";
String CLAIM_AMT="";
String DISB_NO="";
String DISB_AMT="";
String qryField="";
String qryField1="";
String qryGroup="";
String qryGroup1="";
String ZONE=request.getParameter("ZONE")==null?"0":(String) request.getParameter("ZONE");
String vfields=request.getParameter("vfields")==null?"0":(String) request.getParameter("vfields");
String ReportName="";
String txtSearch="";
String qryField2=""; 
if (vfields.equals("0")){
ReportName="Zone Wise ";
qryField="  nvl(MU.ZONE_NM,' GrandTotal') AS OFF_NAME  ";
qryGroup=" MU.ZONE_NM ";
} 

if (vfields.equals("1")){
ReportName="State wise";
qryField="  nvl(MU.STATE_NM,' GrandTotal') AS OFF_NAME  ";
qryGroup=" MU.STATE_NM";
txtSearch= txtSearch+"AND MU.ZONE_NM='"+ZONE+"' ";
}


if (vfields.equals("2")){
ReportName="OFFICE WISE";
qryField="  nvl(MU.OFF_NM,' GrandTotal') AS OFF_NAME  ";
qryGroup=" MU.OFF_NM";
txtSearch= txtSearch+"AND MU.STATE_NM='"+ZONE+"' ";
}

if (vfields.equals("3")){
ReportName="INSTITUTION WISE";
qryField="  nvl(MB.BEN_NM,' GrandTotal') AS OFF_NAME  ";
qryGroup=" MB.BEN_NM";
txtSearch= txtSearch+"AND MU.OFF_NM='"+ZONE+"' ";
}

StringBuffer qrysb = new StringBuffer();
qrysb.append("	SELECT "+qryField+" ,count( DISTINCT IC.BEN_CD) AS NO_INS,ROUND(SUM(NVL(IC.SO_ADMIT_AMT, 0))/100000,2) ISEC_AVAILED, ");
qrysb.append("	ROUND(sum(( select max(LOAN_AMT) from BUDGET.isec_claim where ben_cd=ic.ben_cd and   ");
qrysb.append("	TRUNC(CHQ_DT) BETWEEN '01-apr-2022' AND '31-MAR-2023' ) )/100000,2)  AS ISEC_ELIG  ");
qrysb.append("  FROM BUDGET.MDAUSER_MAST MU,MAS.MH_BENEFICIARY MB,BUDGET.ISEC_CLAIM IC  ");
qrysb.append(" WHERE MU.OFF_CD  = MB.REG_OFF_CD ");
qrysb.append(" AND MB.BEN_CD=IC.BEN_CD   "+txtSearch+"   ");
qrysb.append("AND trunc(ic.chq_dt) between '01-apr-2022' and sysdate GROUP BY ROLLUP ("+qryGroup+") ORDER BY "+qryGroup+" ");
  ResultSet rsMain = db.execSQL(qrysb.toString());
  
  //out.print(qrysb.toString());
	values.clear();	


%>	
	 



        <div class="container-fluid">
            <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr class="main_head">
                            <th colspan="12">INTEREST SUBSIDY ELIGIBILITY CERTIFICATE (ISEC) FOR THE YEAR 2022-23</th>
                        </tr>
                        <tr class="second_head">
                            <th colspan="1">Sr. No.</th>
                           <%if (vfields.equals("0")){ %>
                            <th colspan="1">Zone Name</th>
							<%} else if (vfields.equals("1")){%>
                            <th colspan="1">State Name</th>
							<%} else if (vfields.equals("2")){%>
                            <th colspan="1">Office Name</th>
							<%} else if (vfields.equals("3")){%> 
							 <th colspan="1">Institution Name</th>
							 <%}%>
							 <% if (!vfields.equals("3")){%>                    
                            <th>No. of Institutions</th>
							<%}%>
                            <th colspan="1">Bank Finance Availed ( In lakh) </th>
                            <th colspan="1">ISEC Disbursed ( In lakh) </th>
                        </tr>
                    </thead>
                    <tbody>
						<%
					int srno =0;
					while (rsMain.next()){
						
 OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");	
 PRJ_NO_TGT=rsMain.getString("NO_INS")==null?"":rsMain.getString("NO_INS");	
 MM_TGT=rsMain.getString("ISEC_ELIG")==null?"":rsMain.getString("ISEC_ELIG");	
 APP_REC=rsMain.getString("ISEC_AVAILED")==null?"":rsMain.getString("ISEC_AVAILED");	
srno=srno+1; 
			%>	
                        <tr>
                            <th scope="row"><%=srno%></th>
                            	<% if (!OFF_NAME.equals(" GrandTotal")){%>
							<%if (vfields.equals("0")){ %>
                            <td colspan="1"><a href="ISEC.jsp?vfields=1&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></td>
							<%} else if (vfields.equals("1")){ %>	
							<td colspan="1"><a href="ISEC.jsp?vfields=2&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></td>	
							<%} else if (vfields.equals("2")){%>
							<td colspan="1"><a href="ISEC.jsp?vfields=3&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></td>	
							<%} else if (vfields.equals("3")){%>
							<td colspan="1"><%=OFF_NAME%></td>
							<%}%>
							<% if (!vfields.equals("3")){%>
                            <td colspan="1"><%=PRJ_NO_TGT%></td>
							<%}%>
                            <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>
							<%} else {%>
							 <td colspan="1"><%=OFF_NAME%></td>
							 <% if (!vfields.equals("3")){%>
							  <td colspan="1"><%=PRJ_NO_TGT%></td>
							  <%}%>
                            <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>  
                           
                        <%}%>
                        </tr>
					<%}rsMain.close(); %>
                       
                    </tbody>
                </table>
            </div>
        </div>


        <!-------------------------------------------------Footer Section  start  ---------------------------------------------->

        <Footer>
            <div class="container-fluid">
                <div class="footer-content py-2">
                    <p>DESIGNED AND MAINTAINED
                        BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI
                    </p>
                </div>
            </div>
        </Footer>
    </section>

    <!-------------------------------------------------Footer Section End  ---------------------------------------------->
    <script src="js/popper.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

</body>

</html>