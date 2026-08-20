<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>DASHBOARD</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/style.css" rel="stylesheet">
    <link href="Media Query/media.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/font-awesome.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
-->
    </style>
</head>

<body>
    <section class="main" id="main">
        <header class="top-banner mt-1 mb-1" style="width: 100%;" id="myDiv1">
            <div class="container-fluid">
                 <div align="center"><img src="../img/chairman_dashboard (7).jpeg" style="margin: 0; width: 100%;">
                      </div>
            </div>
        </header>
        <section class="ftco-section">
            <nav class="navbar navbar-expand-lg" id="ftco-navbar">
                <div class="container">

                    <div align="center">
                      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                        aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="fa fa-bars" style="color: #fff;"> MENU</span>
                      </button>
                    </div>
                    <div class="logout order-lg-last">

                           <div align="center"><a href="logout.jsp">Logout</a>
                                  </div>
                    </div>
                    <div class="collapse navbar-collapse" id="ftco-nav">
                        <div align="center">
                          <ul class="navbar-nav mr-auto" ID="ftco-ul">
                            <li class="nav-item"><a href="../homepage.jsp" class="nav-link">Home</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Tour</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Leave</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Change Password</a></li>
                            <li class="nav-item"><a href="../smsservice.jsp" class="nav-link">SMS Service</a></li>
                            <li class="nav-item"><a href="kimismain.jsp" class="nav-link">SALES(KIMIS)</a></li>
                          </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </section>
		<div align="center">
		  <%
		DBCon db= new DBCon();
db.connect();

	 List values=new ArrayList();	

String NO_OF_BRANCH = "";
String No_started = "";
String NOT_started = "";
String TOTAL_SALES = "";
String NO_OF_PRODUCT = "";
String BEN_NM="";
String START_YN="";
String K_N="";
String STATE_OFF_NM="";

String STOCK_ENTRY ="";
String YESTERDAY_SALES ="";
String TODAY_SALES ="";
String OFF_NAME="";
String NAME="";
String CITY="";

double vTOTAL_STOCK=0.0;
double vTOTAL_SALES=0.0;
double vYESTERDAY_SALES=0.0;
double vTODAY_SALES=0.0;

String BEN_CD=(String) request.getParameter("BEN_CD")==null?"":(String) request.getParameter("BEN_CD").trim();

String INST_TYPE=(String) request.getParameter("INST_TYPE")==null?"":(String) request.getParameter("INST_TYPE").trim();

String STATENAME=(String) request.getParameter("STATENAME")==null?"":(String) request.getParameter("STATENAME").trim();
//decode(k_n,'DEPT','Departmental Bhavan','Khadi Institutions')
// AND K_N <>'CSP'
String whrcls="";
String whereState="and UPPER(STATENAME) LIKE UPPER('"+STATENAME+"')";

whrcls=" AND KM.BEN_CD="+BEN_CD+"";

StringBuffer qrysb = new StringBuffer();


qrysb.append("    SELECT * FROM ("      );
qrysb.append("         SELECT KM.BEN_CD,"      );
qrysb.append("        KM.KINAME,"      );
qrysb.append("        CM.NAME,"      );
qrysb.append("        CM.CITY,"      );
qrysb.append("        NVL((SELECT TO_CHAR(ROUND(abs((SUM(NVL(M_GROSS,0))) / 100000), 2), '99999999990.00')"      );
qrysb.append("        FROM KVICWEBKIMIS2023.STOCKOB_BAL_TEMP OB"      );
qrysb.append("        WHERE OB.CUSTCODE = CM.CUSTCODE"      );
qrysb.append("        ),0)                                                                  AS TOTAL_STOCK,"      );
qrysb.append("        "      );
qrysb.append("        NVL((SELECT COUNT(*)"      );
qrysb.append("        FROM KVICWEBKIMIS2023.STOCKOB OB"      );
qrysb.append("        WHERE OB.CUSTCODE = CM.CUSTCODE"      );
qrysb.append("        ),0)                                                                  AS STOCK_COUNT,"      );
qrysb.append("       NVL(("      );
qrysb.append("        SELECT TO_CHAR(ROUND(SUM(NVL(ST.PIECES,1)*NVL(ST.QUANTITY,1)*OB.ORATE) / 100000, 2), '99999999990.00')"      );
qrysb.append("        FROM KVICWEBKIMIS2023.SALESMAST SM,"      );
qrysb.append("          KVICWEBKIMIS2023.SALESTRANS ST,KVICWEBKIMIS2023.STOCKOB OB,"      );
qrysb.append("          KVICWEBKIMIS2023.CUSTMAST NN"      );
qrysb.append("        WHERE SM.GSNUMBER = ST.GSNUMBER AND OB.BARCODE=ST.COMPUTERID"      );
qrysb.append("        AND NN.CUSTCODE   = SM.CUSTCODE"      );
qrysb.append("        AND NN.CUSTCODE   = CM.CUSTCODE"      );
qrysb.append("        ),0) TOTAL_SALES,"      );
qrysb.append("        NVL(("      );
qrysb.append("        SELECT TO_CHAR(ROUND(SUM(NVL(ST.PIECES,1)*NVL(ST.QUANTITY,1)*OB.ORATE) / 100000, 2), '99999999990.00')"      );
qrysb.append("        FROM KVICWEBKIMIS2023.SALESMAST SM,"      );
qrysb.append("          KVICWEBKIMIS2023.SALESTRANS ST,KVICWEBKIMIS2023.STOCKOB OB,"      );
qrysb.append("          KVICWEBKIMIS2023.CUSTMAST NN"      );
qrysb.append("        WHERE SM.GSNUMBER = ST.GSNUMBER AND OB.BARCODE=ST.COMPUTERID"      );
qrysb.append("        AND NN.CUSTCODE   = SM.CUSTCODE"      );
qrysb.append("        AND NN.CUSTCODE   = CM.CUSTCODE"      );
qrysb.append("        AND TRUNC(SM.BDATE) BETWEEN '01-APR-2017' AND TRUNC(SysDate) - 1"      );
qrysb.append("        ),0) AS YESTERDAY_SALES,"      );
qrysb.append("        NVL((SELECT TO_CHAR(ROUND(NVL(SUM(NVL(ST.PIECES,1)*NVL(ST.QUANTITY,1)*OB.ORATE),0) / 100000, 2), '99999999990.00')"      );
qrysb.append("        FROM KVICWEBKIMIS2023.SALESMAST SM,"      );
qrysb.append("          KVICWEBKIMIS2023.SALESTRANS ST,KVICWEBKIMIS2023.STOCKOB OB,"      );
qrysb.append("          KVICWEBKIMIS2023.CUSTMAST MM"      );
qrysb.append("        WHERE SM.GSNUMBER   = ST.GSNUMBER AND OB.BARCODE=ST.COMPUTERID"      );
qrysb.append("        AND MM.CUSTCODE     = SM.CUSTCODE"      );
qrysb.append("        AND MM.CUSTCODE     = CM.CUSTCODE"      );
qrysb.append("        AND TRUNC(SM.BDATE) = TRUNC(SYSDATE)"      );
qrysb.append("        ),0) AS TODAY_SALES,"      );
qrysb.append("        CM.CUSTCODE"      );
qrysb.append("      FROM KVICWEBKIMIS2023.KIMAST KM,"      );
qrysb.append("        KVICWEBKIMIS2023.CUSTMAST CM"      );
qrysb.append("      WHERE KM.KIID   = CM.BASEID"      );
qrysb.append("      AND cm.cust_type_id=2 AND CM.ACT_YN='Y'"      );
qrysb.append("      AND KM.BEN_CD   = "+BEN_CD+"  and km.BEN_CD  NOT IN (1231, 1234, 2391)"      );
qrysb.append("      GROUP BY KM.BEN_CD,"      );
qrysb.append("        KM.KINAME,"      );
qrysb.append("        CM.NAME,"      );
qrysb.append("        CM.CITY,"      );
qrysb.append("        CM.CUSTCODE) where   TOTAL_SALES>0"      );

	   ResultSet rsMain = db.execSQL(qrysb.toString());
	values.clear();	
	
			
		%>
		  
		  
		  
		    <span class="style1"><%= INST_TYPE %>        </span>
	  </div>
		<div class="container-fluid">
            <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr class="main_head">
                            <th colspan="8">Khadi Institution Management Information System (KIMIS)
                                FOR THE YEAR 2023-24</th>
                        </tr>
                       
                     
                        <tr class="mini_head">
                          <th colspan="1">&nbsp;</th>
                          <th colspan="1">&nbsp;</th>
                          <th>&nbsp;</th>
                          <th>Sales&nbsp;(on MRP)&nbsp;Rs. in Lakhs</th>
                          <th>&nbsp;</th>
                          <th>&nbsp;</th>
                          <th>&nbsp;</th>
                          <th>&nbsp;</th>
                        </tr>
                        <tr class="mini_head">
                            <th colspan="1">Sr no.</th>
                            <th colspan="1"> Instn. Code</th>
                            <th>Institution Name </th>
                            <th>Branch Name</th>
                            <th>City</th>
                            <th>Cummulative Sales<br>
                            Up to Yesterday (in lakhs)</th>
                            <th>Today Sales (in lakhs)</th>
                            <th>Total Sales (in lakhs)</th>
                        </tr>
                    </thead>
					
                    <tbody>
					<%
					int srno =0;
					while (rsMain.next()){
		BEN_CD=rsMain.getString("BEN_CD")==null?"":rsMain.getString("BEN_CD");
		 NAME=rsMain.getString("NAME")==null?"":rsMain.getString("NAME");
 CITY =rsMain.getString("CITY")==null?"":rsMain.getString("CITY");

BEN_NM=rsMain.getString("KINAME")==null?"":rsMain.getString("KINAME");
TOTAL_SALES=rsMain.getString("TOTAL_SALES")==null?"":rsMain.getString("TOTAL_SALES");
YESTERDAY_SALES =rsMain.getString("YESTERDAY_SALES")==null?"":rsMain.getString("YESTERDAY_SALES");
TODAY_SALES =rsMain.getString("TODAY_SALES")==null?"":rsMain.getString("TODAY_SALES");
srno=srno+1;
	//  bigdecimal
	//BigDecimal c=c.add(new BigDecimal(TOTAL_STOCK));
	 double d=Double.parseDouble(TOTAL_SALES);
	 double e=Double.parseDouble(YESTERDAY_SALES);
	 double f=Double.parseDouble(TODAY_SALES);
	 
 vTOTAL_SALES=vTOTAL_SALES+d;
 vYESTERDAY_SALES=vYESTERDAY_SALES+e;
 vTODAY_SALES=vTODAY_SALES+f;
			%>	
                        <tr>
							
                            <th scope="row"><%=srno%></th>
							
                          <td >
<%= BEN_CD %></td>
							
							<td><% if (BEN_NM.equals("")){
out.print ("TOTAL");
}else{%><%= BEN_NM %><%}%></td>
							<td><%= NAME %></td>
							<td><%= CITY %></td>
							<td><div align="right"><%= YESTERDAY_SALES %></div></td>
							<td><div align="right"><%= TODAY_SALES %></div></td>
							<td><div align="right"><%= TOTAL_SALES %></div></td>
						</tr>
                        
					<%}rsMain.close();
					db.close();
					 %><tr>
                          <th scope="row">&nbsp;</th>
                          <td >&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>Total : </td>
                          <td>&nbsp;</td>
                         <th><div align="right" class="style3"><%  DecimalFormat two = new DecimalFormat("0.00"); out.print(two.format(vYESTERDAY_SALES));  %></div></th>
   <th bgcolor="#FCE1DC"><div align="right" class="style3"><%   DecimalFormat three = new DecimalFormat("0.00"); out.print(three.format(vTODAY_SALES));   %></div></th>
   <th bgcolor="#FCE1DC"><div align="right" class="style3"><%   DecimalFormat four = new DecimalFormat("0.00"); out.print(four.format(vTOTAL_SALES));   %></div></th>

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