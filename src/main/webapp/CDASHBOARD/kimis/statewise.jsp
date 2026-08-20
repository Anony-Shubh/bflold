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
                            <li class="nav-item"><a href="kimis/kimismain.jsp" class="nav-link">SALES(KIMIS)</a></li>
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
String BEN_CD="";
String STATE_OFF_NM="";

String STOCK_ENTRY ="";
String YESTERDAY_SALES ="";
String TODAY_SALES ="";
String OFF_NAME="";

double vTOTAL_STOCK=0.0;
double vTOTAL_SALES=0.0;
double vYESTERDAY_SALES=0.0;
double vTODAY_SALES=0.0;


String INST_TYPE=(String) request.getParameter("INST_TYPE")==null?"":(String) request.getParameter("INST_TYPE").trim();

String STATENAME=(String) request.getParameter("STATENAME")==null?"":(String) request.getParameter("STATENAME").trim();
//decode(k_n,'DEPT','Departmental Bhavan','Khadi Institutions')
// AND K_N <>'CSP'
String whrcls="";
String whereState="and UPPER(STATENAME) LIKE UPPER('"+STATENAME+"')";

if(INST_TYPE.equals("Departmental Bhavan")){
whrcls="  AND UPPER(K_N) ='DEPT'  AND K_N <>'CSP'  ";
}else if(INST_TYPE.equals("Khadi Institutions")){
whrcls="  AND UPPER(K_N)  NOT IN ('CSP','DEPT')  ";
}else{
whrcls="  AND UPPER(K_N)  NOT IN ('CSP')  ";
}
StringBuffer qrysb = new StringBuffer();


qrysb.append("   SELECT STATENAME,"      );
qrysb.append("       ZONE_NM,"      );
qrysb.append("      "      );
qrysb.append("       KISTATEID,"      );
qrysb.append("       BEN_NM,"      );
qrysb.append("       BEN_CD,"      );
qrysb.append("       NVL(NO_OF_BRANCH, 0) NO_of_branch,"      );
qrysb.append("       NVL(NO_OF_PRODUCT, 0) NO_OF_PRODUCT,"      );
qrysb.append("       TO_CHAR(NVL(YEST_SALES, 0), '99999999990.00')       AS YESTERDAY_SALES,"      );
qrysb.append("       TO_CHAR(NVL(TODAY_SALES, 0), '99999999990.00')      AS TODAY_SALES,"      );
qrysb.append("       TO_CHAR(NVL(TOTAL_SALES, 0), '99999999990.00')      TOTAL_SALES,"      );
qrysb.append("       TO_CHAR(NVL(STOCK_ENTRY, 0), '99999999990.00')      STOCK_ENTRY,"      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN (NO_OF_BRANCH + NO_OF_PRODUCT + TOTAL_SALES + STOCK_ENTRY > 0)"      );
qrysb.append("         THEN 'Yes'"      );
qrysb.append("         ELSE 'No'"      );
qrysb.append("       END START_YN,"      );
qrysb.append("       K_N"      );
qrysb.append("     FROM"      );
qrysb.append("       (SELECT *"      );
qrysb.append("       FROM"      );
qrysb.append("         (SELECT smm.STATENAME,"      );
qrysb.append("           smm.ZONE_NM,"      );
qrysb.append("           MOM.OFF_CD,"      );
qrysb.append("           MOM.OFF_NAME,"      );
qrysb.append("           MB.BEN_NM,"      );
qrysb.append("           KM.BEN_CD,"      );
qrysb.append("           KM.KIID,"      );
qrysb.append("           KM.KISTATEID,KM.K_N"      );
qrysb.append("         FROM MAS.MH_BENEFICIARY MB,"      );
qrysb.append("           kvicwebkimis2023.KIMAST KM,"      );
qrysb.append("           MAS.OFF_MAST MOM,"      );
qrysb.append("           kvicwebkimis2023.statemaster smm"      );
qrysb.append("         WHERE MB.BEN_CD   = KM.BEN_CD"      );
qrysb.append("         AND MB.REG_OFF_CD = MOM.OFF_CD"      );
qrysb.append("         AND smm.STATEID   = KM.KISTATEID AND k_n not in ('CSP') "+whrcls+""      );
qrysb.append("         ) cust,"      );
qrysb.append("         ("      );
qrysb.append("         (SELECT CUSTCODE,"      );
qrysb.append("           ROUND(SUM(NVL(STOCKENTRY, 0))  / 100000, 2) AS STOCK_ENTRY,"      );
qrysb.append("           ROUND(SUM(NVL(TOTALSALES, 0))  / 100000, 2) AS TOTAL_SALES,"      );
qrysb.append("           ROUND(SUM(NVL(YEST_SALES, 0))  / 100000, 2) AS YEST_SALES,"      );
qrysb.append("           ROUND(SUM(NVL(TODAY_SALES, 0)) / 100000, 2) AS TODAY_SALES,"      );
qrysb.append("           MAX(NVL(NO_OF_PRODUCT, 0)) NO_OF_PRODUCT,"      );
qrysb.append("           MAX(NVL(NO_OF_BRANCH, 0)) NO_OF_BRANCH"      );
qrysb.append("         FROM"      );
qrysb.append("           (SELECT 'TSL' AS TP,"      );
qrysb.append("             CM.BASEID CUSTCODE,"      );
qrysb.append("             ST.ID3,"      );
qrysb.append("             0                     AS STOCKENTRY,"      );
qrysb.append("              NVL(St.PIECES,1)*NVL(St.QUANTITY,1)*SO.ORATE  AS TODAY_SALES,"      );
qrysb.append("             0                     AS YEST_SALES,"      );
qrysb.append("             0                     AS TOTALSALES,"      );
qrysb.append("             0                     AS NO_OF_PRODUCT,"      );
qrysb.append("             0                     AS NO_OF_BRANCH"      );
qrysb.append("           FROM kvicwebkimis2023.SALESMAST SM,"      );
qrysb.append("             kvicwebkimis2023.SALESTRANS ST,"      );
qrysb.append("             kvicwebkimis2023.STOCKOB SO,"      );
qrysb.append("             kvicwebkimis2023.CUSTMAST CM"      );
qrysb.append("           WHERE SM.GSNUMBER   = ST.GSNUMBER"      );
qrysb.append("           AND CM.CUSTCODE     = SM.CUSTCODE"      );
qrysb.append("           AND ST.COMPUTERID   = SO.BARCODE"      );
qrysb.append("           AND TRUNC(SM.BDATE) = TRUNC(SysDate)"      );
qrysb.append("           UNION ALL"      );
qrysb.append("           SELECT 'YSL' AS TP,"      );
qrysb.append("             CM.BASEID CUSTCODE,"      );
qrysb.append("             ST.ID3,"      );
qrysb.append("             0                     AS STOCKENTRY,"      );
qrysb.append("             0                     AS TODAY_SALES,"      );
qrysb.append("             NVL(St.PIECES,1)*NVL(St.QUANTITY,1)*SO.ORATE  AS YEST_SALES,"      );
qrysb.append("             0                     AS TOTALSALES,"      );
qrysb.append("             0                     AS NO_OF_PRODUCT,"      );
qrysb.append("             0                     AS NO_OF_BRANCH"      );
qrysb.append("           FROM kvicwebkimis2023.SALESMAST SM,"      );
qrysb.append("             kvicwebkimis2023.SALESTRANS ST,"      );
qrysb.append("             kvicwebkimis2023.STOCKOB SO,"      );
qrysb.append("             kvicwebkimis2023.CUSTMAST CM"      );
qrysb.append("           WHERE SM.GSNUMBER   = ST.GSNUMBER"      );
qrysb.append("           AND CM.CUSTCODE     = SM.CUSTCODE"      );
qrysb.append("           AND ST.COMPUTERID   = SO.BARCODE"      );
qrysb.append("           AND TRUNC(SM.BDATE) < SysDate - 1"      );
qrysb.append("           UNION ALL"      );
qrysb.append("           SELECT 'SL' AS TP,"      );
qrysb.append("             CM.BASEID CUSTCODE,"      );
qrysb.append("             ST.ID3,"      );
qrysb.append("             0                     AS STOCKENTRY,"      );
qrysb.append("             0                     AS TODAY_SALES,"      );
qrysb.append("             0                     AS YEST_SALES,"      );
qrysb.append("              NVL(St.PIECES,1)*NVL(St.QUANTITY,1)*SO.ORATE  AS TOTALSALES,"      );
qrysb.append("             0                     AS NO_OF_PRODUCT,"      );
qrysb.append("             0                     AS NO_OF_BRANCH"      );
qrysb.append("           FROM kvicwebkimis2023.SALESMAST SM,"      );
qrysb.append("             kvicwebkimis2023.SALESTRANS ST,"      );
qrysb.append("             kvicwebkimis2023.STOCKOB SO,"      );
qrysb.append("             kvicwebkimis2023.CUSTMAST CM"      );
qrysb.append("           WHERE SM.GSNUMBER = ST.GSNUMBER"      );
qrysb.append("           AND CM.CUSTCODE   = SM.CUSTCODE"      );
qrysb.append("           AND ST.COMPUTERID = SO.BARCODE"      );
qrysb.append("           UNION ALL"      );
qrysb.append("           SELECT 'ST' AS TP,"      );
qrysb.append("             CTM.BASEID CUSTCODE,"      );
qrysb.append("             0 AS ID3,"      );
qrysb.append("             SO.M_GROSS AS STOCKENTRY,"      );
qrysb.append("             0                                                  AS TODAY_SALES,"      );
qrysb.append("             0                                                  AS YEST_SALES,"      );
qrysb.append("             0                                                  AS TOTALSALES,"      );
qrysb.append("             0                                                  AS NO_OF_PRODUCT,"      );
qrysb.append("             0                                                  AS NO_OF_BRANCH"      );
qrysb.append("           FROM kvicwebkimis2023.STOCKOB_BAL_TEMP SO,"      );
qrysb.append("             kvicwebkimis2023.CUSTMAST CTM"      );
qrysb.append("           WHERE SO.CUSTCODE = CTM.CUSTCODE"      );
qrysb.append("           UNION ALL"      );
qrysb.append("           SELECT 'NOP' AS TP,"      );
qrysb.append("             ID3.CUSTCODE,"      );
qrysb.append("             0 AS ID3,"      );
qrysb.append("             0 AS STOCKENTRY,"      );
qrysb.append("             0 AS TODAY_SALES,"      );
qrysb.append("             0 AS YEST_SALES,"      );
qrysb.append("             0 AS TOTALSALES,"      );
qrysb.append("             COUNT(*) NO_OF_PRODUCT,"      );
qrysb.append("             0 AS NO_OF_BRANCH"      );
qrysb.append("           FROM kvicwebkimis2023.ID3"      );
qrysb.append("           GROUP BY ID3.CUSTCODE"      );
qrysb.append("           UNION ALL"      );
qrysb.append("           SELECT 'NOB' AS TP,"      );
qrysb.append("             CMM.BASEID,"      );
qrysb.append("             0 AS ID3,"      );
qrysb.append("             0 AS STOCKENTRY,"      );
qrysb.append("             0 AS TODAY_SALES,"      );
qrysb.append("             0 AS YEST_SALES,"      );
qrysb.append("             0 AS TOTALSALES,"      );
qrysb.append("             0 NO_OF_PRODUCT,"      );
qrysb.append("             COUNT(*) NO_OF_BRANCH"      );
qrysb.append("           FROM kvicwebkimis2023.CUSTMAST CMM"      );
qrysb.append("           WHERE CMM.CUST_TYPE_ID = 2"      );
qrysb.append("           GROUP BY CMM.BASEID"      );
qrysb.append("           )"      );
qrysb.append("         GROUP BY CUSTCODE"      );
qrysb.append("         )) mast"      );
qrysb.append("       WHERE cust.KIID = mast.CUSTCODE(+) "      );
qrysb.append("       ) where  BEN_CD  NOT IN (1231, 1234, 2391) and TOTAL_SALES>0 "+whereState+"  "      );


	//out.print(qrysb.toString());
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
                          <th>&nbsp;</th>
                          <th colspan="1">&nbsp;</th>
                          <th>&nbsp;</th>
                          <th colspan="3">Sales&nbsp;(on MRP)&nbsp;Rs. in Lakhs</th>
                          <th colspan="1">&nbsp;</th>
                        </tr>
                        <tr class="mini_head">
                            <th colspan="1">Sr no.</th>
                            <th>State Name</th>
                            <th colspan="1"> Instn. Code</th>
                            <th>Institution Name </th>
                            <th>Cummulative Sales<br>
                            Up to Yesterday (in lakhs)</th>
                            <th>Today Sales (in lakhs)</th>
                            <th>Total Sales (in lakhs)</th>
                            <th colspan="1">&nbsp;</th>
                        </tr>
                    </thead>
					
                    <tbody>
					<%
					int srno =0;
					while (rsMain.next()){
		BEN_CD=rsMain.getString("BEN_CD")==null?"":rsMain.getString("BEN_CD");
STATENAME=rsMain.getString("STATENAME")==null?"":rsMain.getString("STATENAME");
NO_OF_BRANCH=rsMain.getString("NO_OF_BRANCH")==null?"":rsMain.getString("NO_OF_BRANCH");
BEN_NM=rsMain.getString("BEN_NM")==null?"":rsMain.getString("BEN_NM");
START_YN=rsMain.getString("START_YN")==null?"":rsMain.getString("START_YN");
TOTAL_SALES=rsMain.getString("TOTAL_SALES")==null?"":rsMain.getString("TOTAL_SALES");
NO_OF_PRODUCT=rsMain.getString("NO_OF_PRODUCT")==null?"":rsMain.getString("NO_OF_PRODUCT");
K_N=rsMain.getString("K_N")==null?"":rsMain.getString("K_N");
STOCK_ENTRY =rsMain.getString("STOCK_ENTRY")==null?"":rsMain.getString("STOCK_ENTRY");
YESTERDAY_SALES =rsMain.getString("YESTERDAY_SALES")==null?"":rsMain.getString("YESTERDAY_SALES");
TODAY_SALES =rsMain.getString("TODAY_SALES")==null?"":rsMain.getString("TODAY_SALES");
srno=srno+1;
		
		
		
		 double d=Double.parseDouble(TOTAL_SALES);
	 double e=Double.parseDouble(YESTERDAY_SALES);
	 double f=Double.parseDouble(TODAY_SALES);
	 
 vTOTAL_SALES=vTOTAL_SALES+d;
 vYESTERDAY_SALES=vYESTERDAY_SALES+e;
 vTODAY_SALES=vTODAY_SALES+f;	%>	
                        <tr>
							
                            <th scope="row"><%=srno%></th>
							
                            <td ><%= STATENAME %></td>
                          <td >
<%= BEN_CD %></td>
							
							<td><% if (BEN_NM.equals("")){
out.print ("TOTAL");
}else{%><%= BEN_NM %><%}%></td>
							<td><div align="right"><%= YESTERDAY_SALES %></div></td>
							<td><div align="right"><%= TODAY_SALES %></div></td>
							<td><div align="right"><%= TOTAL_SALES %></div></td>
							<td> <a href="instwise.jsp?BEN_CD=<%= BEN_CD %>" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a></td>	
                        </tr>
                       
					<%}rsMain.close();
					db.close();
					 %>
                         <tr>
                          <th scope="row">&nbsp;</th>
                          <td >&nbsp;</td>
                          <td >&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <th><div align="right" class="style3"><%  DecimalFormat two = new DecimalFormat("0.00"); out.print(two.format(vYESTERDAY_SALES));  %></div></th>
   <th bgcolor="#FCE1DC"><div align="right" class="style3"><%   DecimalFormat three = new DecimalFormat("0.00"); out.print(three.format(vTODAY_SALES));   %></div></th>
   <th bgcolor="#FCE1DC"><div align="right" class="style3"><%   DecimalFormat four = new DecimalFormat("0.00"); out.print(four.format(vTOTAL_SALES));   %></div></th>

                        </tr>                    </tbody>
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