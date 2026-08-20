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
qryField="  nvl(OM.ZONE,' GrandTotal') AS OFF_NAME  ";
qryGroup=" OM.ZONE ";

} 

if (vfields.equals("1")){
ReportName="State wise";
qryField="  nvl(OM.STATE_NM,' GrandTotal') AS OFF_NAME  ";
qryGroup=" OM.STATE_NM ";
txtSearch= txtSearch+"AND OM.ZONE='"+ZONE+"' ";
}


if (vfields.equals("2")){
ReportName="TRAINING CENTREWISE";
//qryField="  nvl(Om.Off_Name,' GrandTotal') AS OFF_NAME  ";
qryField="  nvl(MM.MDTC_SHORT_DESC,' GrandTotal') AS OFF_NAME  ";
//qryGroup=" Om.Off_Name";
qryGroup=" Mm.MDTC_SHORT_DESC";
txtSearch= txtSearch+"AND OM.STATE_NM='"+ZONE+"' ";
}
	 
	 
StringBuffer qrysb = new StringBuffer();
qrysb.append("   select "+qryField+", "      );
qrysb.append("    count(distinct bm.co_id) as no_of_courses,"      );
qrysb.append("   count(case when bm.trg_to between '01-apr-2022' and '31-mar-2023' then t_id end ) as no_of_trainees"      );
qrysb.append("   from hrd_user.mdtc_mast mm,hrd_user.off_view om,hrd_user.batch_mast bm,hrd_user.trainee_data td"      );
qrysb.append("   where om.off_cd=mm.off_cd and mm.mdtc_id=bm.mdtc_id(+)"      );
qrysb.append("   and bm.b_id=td.b_id(+)"      );
qrysb.append("   and mm.MDTC_CAT NOT IN('SO/DO',"      );
qrysb.append("   'SFURTI','Dept.') AND mm.ACT_FLG='Y'  "+txtSearch+"  "      );
qrysb.append("    group by rollup ("+qryGroup+")  "      );
qrysb.append("   order by ("+qryGroup+")    "  );
qrysb.append("   "      );
  ResultSet rsMain = db.execSQL(qrysb.toString());
 // out.print(qrysb.toString());
 
	values.clear();
%>
        <div class="container-fluid">
            <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr class="main_head">
                            <th colspan="12">CAPACITY BUILDING (CB) FOR THE YEAR 2022-23</th>
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
                           
                            <th colspan="1">No. of Courses</th>
                            <th colspan="1">No. of Trainees </th>
                        </tr>
                    </thead>
                    <tbody>
					<%
					int srno =0;
					while (rsMain.next()){
						
 OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");	
 //PRJ_NO_TGT=rsMain.getString("NO_INS")==null?"":rsMain.getString("NO_INS");	
 MM_TGT=rsMain.getString("no_of_courses")==null?"":rsMain.getString("no_of_courses");	
 APP_REC=rsMain.getString("no_of_trainees")==null?"":rsMain.getString("no_of_trainees");
 //bank_ford=rsMain.getString("NET_MDA_INSTN")==null?"":rsMain.getString("NET_MDA_INSTN");	
 //bank_sanc=rsMain.getString("TOT_MDA")==null?"":rsMain.getString("TOT_MDA");
 srno=srno+1; 
			%>	
                        <tr>
                            <th scope="row"><%=srno%></th>
                            <% if (!OFF_NAME.equals(" GrandTotal")){%>
							<%if (vfields.equals("0")){ %>
                            <td colspan="1"><div align="left"><a href="CB.jsp?vfields=1&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></div></td>
							<%} else if (vfields.equals("1")){ %>	
							<td colspan="1"><a href="CB.jsp?vfields=2&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></td>	
							<%} else if (vfields.equals("2")){%>
							<td colspan="1"><%=OFF_NAME%></td>	
							<%}%>
                            <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>
                                                          
                       <%} else {%>
					   <td colspan="1"><%=OFF_NAME%></td>                         
                            <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>
                                                  
							
							 <%}%>
                        </tr>
					<%}rsMain.close(); %>
                        </tr>
                     
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