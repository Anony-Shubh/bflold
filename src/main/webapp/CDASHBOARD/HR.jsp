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
                <img src="img/chairman_dashboard (3).jpg" style="margin: 0; width: 100%;">
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

                        <a href="login.html">Logout</a>

                    </div>
                    <div class="collapse navbar-collapse" id="ftco-nav">
                        <ul class="navbar-nav mr-auto" ID="ftco-ul">
                            <li class="nav-item"><a href="homepage.html" class="nav-link">Home</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer's on Tour</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer's on Leave</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Change Password</a></li>
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
//qryField1="  nvl(zone_nm,' GrandTotal') AS OFF_NAME  ";
qryField1="  nvl(zone_nm,' GrandTotal') AS OFF_NAME  ";
qryGroup=" OM.ZONE_NM ";
qryGroup1=" ZONE_NM"; 
} 

if (vfields.equals("1")){
ReportName="State wise";
//qryField1="  nvl(STATE,' GrandTotal') AS OFF_NAME  ";
qryField1="  nvl(STATE,' GrandTotal') AS OFF_NAME  ";
qryGroup1=" STATE";
txtSearch= txtSearch+"AND OM.zone_nm='"+ZONE+"' ";
}


if (vfields.equals("2")){
ReportName="OFFICE WISE";
qryField1="  nvl(OFF_NAME,' GrandTotal') AS OFF_NAME  ";
qryGroup1=" OFF_NAME";
txtSearch= txtSearch+"AND OM.STATE='"+ZONE+"' ";
}
	 
	 
StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT "+qryField1+" ,"      );
qrysb.append("   SUM(CASE WHEN GAZETTED_Y_N='N' AND TRADING_REGULAR  IN ('R' ,'T')   THEN"      );
qrysb.append("      1 ELSE 0 END) AS STAFF_REGULAR_TOTAL,     "      );
qrysb.append("      SUM(CASE WHEN GAZETTED_Y_N='G' AND TRADING_REGULAR IN ('R' ,'T') THEN"      );
qrysb.append("      1 ELSE 0 END) AS OFFICER_REGULAR_TOTAL, "      );
qrysb.append("      COUNT(GAZETTED_Y_N) AS TOTAL_STRENGTH   "      );
qrysb.append("      FROM (   "      );
qrysb.append("      SELECT   e.EMPLOYEE_CODE,"      );
qrysb.append("        e.EMPLOYEE_NAME,"      );
qrysb.append("        d.DESIGNATION_DESC,"      );
qrysb.append("      CASE"      );
qrysb.append("          WHEN upper(e.PF_TYPE) IN ('EPF', 'CPF')"      );
qrysb.append("          THEN 'T'"      );
qrysb.append("          ELSE 'R'"      );
qrysb.append("        END AS TRADING_REGULAR,"      );
qrysb.append("        "      );
qrysb.append("        e.OFF_CD,"      );
qrysb.append("        e.GAZETTED_Y_N,"      );
qrysb.append("        CASE WHEN E.OFF_CD IN (201,202,203,204,205) THEN"      );
qrysb.append("        'CENTRAL OFFICE'"      );
qrysb.append("        ELSE"      );
qrysb.append("       OM.OFF_NAME ||' '|| OM.PLACE END"      );
qrysb.append("       OFF_NAME,"      );
qrysb.append("        "      );
qrysb.append("        OM.ZONE_NM,"      );
qrysb.append("        OM.STATE"      );
qrysb.append("      FROM fo_sal.emp_pay_master e,"      );
qrysb.append("   "      );
qrysb.append("        fo_sal.designation d,"      );
qrysb.append("        fo_sal.OFF_MAST OM"      );
qrysb.append("   "      );
qrysb.append("      where d.DESIGNATION_CODE    = e.DESIGNATION_CODE"      );
qrysb.append("      AND OM.OFF_CD             = e.OFF_CD"      );
qrysb.append("   "      );
qrysb.append("      AND e.SERVICE_STATUS NOT                                        IN ('RE', 'VR', 'EX')"      );
qrysb.append("      AND e.STOP_PAYMENT        = 'N'  "+txtSearch+" "      );
qrysb.append("     "      );
qrysb.append("      ) GROUP BY ROLLUP("+qryGroup1+") order by  "+qryGroup1+" asc "      );
qrysb.append("   "      );



	//out.print(qrysb.toString());
	   ResultSet rsMain = db.execSQL(qrysb.toString());
	values.clear();	
	
	
	
		
			
		%>
		
		
		
		
		

        <div class="container-fluid">
            <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr class="main_head">
                            <th colspan="12">STAFF POSTION OF KVIC 
                                FOR THE YEAR 2022-23                            </th>
                        </tr>
						<tr class="second_head">
                            <th colspan="1">Sr. No.</th>
							<%if (vfields.equals("0")){ %>
                            <th colspan="1">Zone Name</th>
							<%} else if (vfields.equals("1")){%>
                            <th colspan="1">State Name</th>
							<%} else if (vfields.equals("2")){%>
                            <th colspan="1">Office Name</th>
							<%}%>                           
                            <th colspan="1">Officers</th>
                            <th colspan="1">Staff</th>
                            <th colspan="1">Total Strength</th>
                        </tr>                       
                      
                    </thead>
					
                    <tbody>
					<%
					int srno =0;
					while (rsMain.next()){
						
 OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");	
 PRJ_NO_TGT=rsMain.getString("STAFF_REGULAR_TOTAL")==null?"":rsMain.getString("STAFF_REGULAR_TOTAL");	
 MM_TGT=rsMain.getString("OFFICER_REGULAR_TOTAL")==null?"":rsMain.getString("OFFICER_REGULAR_TOTAL");	
 APP_REC=rsMain.getString("TOTAL_STRENGTH")==null?"":rsMain.getString("TOTAL_STRENGTH");	
srno=srno+1; 
			%>	
                        <tr>
							
                            <th scope="row"><%=srno%></th>
							<% if (!OFF_NAME.equals(" GrandTotal")){%>
							<%if (vfields.equals("0")){ %>
                            <td colspan="1"><div align="left"><a href="hr.jsp?vfields=1&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></div></td>
							<%} else if (vfields.equals("1")){ %>	
							<td colspan="1"><div align="left"><a href="hr.jsp?vfields=2&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></div></td>	
							<%} else if (vfields.equals("2")){%>
							<td colspan="1"><div align="left"><%=OFF_NAME%></div></td>	
							<%}%>
                          <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=PRJ_NO_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>
                           
							<%} else {%>
							 <td colspan="1"><%=OFF_NAME%></td>
							
                            <td colspan="1"><%=MM_TGT%></td>
							  <td colspan="1"><%=PRJ_NO_TGT%></td>
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