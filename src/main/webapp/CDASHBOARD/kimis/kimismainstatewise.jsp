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
String STATENAME = "";
String NO_OF_BRANCH = "";
String No_started = "";
String NOT_started = "";
String TOTAL_SALES = "";
String NO_OF_PRODUCT = "";
String STOCK_ENTRY="";
String USERS="";
String YESTERDAY_SALES="";
String TODAY_SALES="";
String ZONE_NM="";

String INST_TYPE=(String) request.getParameter("INST_TYPE")==null?"":(String) request.getParameter("INST_TYPE").trim();
//decode(k_n,'DEPT','Departmental Bhavan','Khadi Institutions')
// AND K_N <>'CSP'
String whrcls="";
if(INST_TYPE.equals("Departmental Bhavan")){
whrcls="  AND UPPER(K_N) ='DEPT'  AND K_N <>'CSP'  ";
}else if(INST_TYPE.equals("Khadi Institutions")){
whrcls="  AND UPPER(K_N)  NOT IN ('CSP','DEPT')  ";
}else{
whrcls="  AND UPPER(K_N)  NOT IN ('CSP')  ";
}
StringBuffer qrysb = new StringBuffer();



qrysb.append("                    SELECT MAX(ZONE_NM) AS ZONE_NM,STATENAME,count(ben_cd) as users,       "      );
qrysb.append("                      SUM(NO_of_branch) AS NO_OF_BRANCH,       "      );
qrysb.append("                      SUM(DECODE (START_YN,'Y',1,0)) AS No_started,       "      );
qrysb.append("                      SUM( DECODE (START_YN,'N',1,0)) AS NOT_started,       "      );
qrysb.append("                      to_char(SUM(TOTAL_SALES),'99999999990.00') AS TOTAL_SALES,       "      );
qrysb.append("                           to_char(SUM(YESTERDAY_SALES),'99999999990.00') AS YESTERDAY_SALES,       "      );
qrysb.append("                                to_char(SUM(TODAY_SALES),'99999999990.00') AS TODAY_SALES,       "      );
qrysb.append("                                       "      );
qrysb.append("                      SUM(NO_OF_PRODUCT) AS NO_OF_PRODUCT,       "      );
qrysb.append("                      TO_CHAR(SUM(STOCK_ENTRY),'99999999990.00') AS STOCK_ENTRY       "      );
qrysb.append("                    FROM       "      );
qrysb.append("              (       "      );
qrysb.append("                      SELECT STATENAME,ZONE_NM,       "      );
qrysb.append("                        OFF_NAME,       "      );
qrysb.append("                        BEN_NM,       "      );
qrysb.append("                        BEN_CD,          "      );
qrysb.append("                        nvl(NO_of_branch,0) NO_of_branch,       "      );
qrysb.append("                        nvl(NO_OF_PRODUCT,0) NO_OF_PRODUCT,       "      );
qrysb.append("                       NVL(YEST_SALES,0) AS YESTERDAY_SALES,       "      );
qrysb.append("                       NVL(TODAY_SALES,0) AS TODAY_SALES,       "      );
qrysb.append("                       nvl( TOTAL_SALES,0) TOTAL_SALES,       "      );
qrysb.append("                        nvl(STOCK_ENTRY,0) STOCK_ENTRY,       "      );
qrysb.append("                        CASE       "      );
qrysb.append("                          WHEN (NO_of_branch + NO_OF_PRODUCT + TOTAL_SALES + STOCK_ENTRY > 0)       "      );
qrysb.append("                                THEN 'Y'       "      );
qrysb.append("                          ELSE 'N'       "      );
qrysb.append("                         END START_YN       "      );
qrysb.append("                      FROM       "      );
qrysb.append("                     "      );
qrysb.append("                        (select * from        "      );
qrysb.append("                       (SELECT smm.STATENAME,smm.ZONE_NM,       "      );
qrysb.append("                          MOM.OFF_NAME,       "      );
qrysb.append("                          MB.BEN_NM,       "      );
qrysb.append("                          KM.BEN_CD,km.kiid       "      );
qrysb.append("                                  "      );
qrysb.append("                          FROM MAS.MH_BENEFICIARY MB,       "      );
qrysb.append("                          KVICWEBKIMIS2023.KIMAST KM,       "      );
qrysb.append("                          MAS.OFF_MAST MOM,       "      );
qrysb.append("                          KVICWEBKIMIS2023.statemaster smm       "      );
qrysb.append("                        WHERE MB.BEN_CD   = KM.BEN_CD       "      );
qrysb.append("                        AND MB.REG_OFF_CD = MOM.OFF_CD       "      );
qrysb.append("                        AND smm.STATEID   = KM.KISTATEID   and km.BEN_CD  NOT IN (1231, 1234, 2391) "+whrcls+"       "      );
qrysb.append("                              "      );
qrysb.append("           ) cust,       "      );
qrysb.append("           (       "      );
qrysb.append("           (       "      );
qrysb.append("           SELECT CUSTCODE,round(SUM(nvl(STOCKENTRY,0)) / 100000 ,2) AS STOCK_ENTRY,round(SUM(nvl(TOTALSALES,0) )/ 100000,2) AS TOTAL_SALES,       "      );
qrysb.append("             round(SUM(nvl(YEST_SALES,0) )/ 100000,2) AS YEST_SALES,       "      );
qrysb.append("           round(SUM(nvl(TODAY_SALES,0) )/ 100000,2) AS TODAY_SALES,       "      );
qrysb.append("           MAX(nvl(NO_OF_PRODUCT,0)) NO_OF_PRODUCT,MAX(nvl(NO_OF_BRANCH,0)) NO_OF_BRANCH FROM        "      );
qrysb.append("                  "      );
qrysb.append("           (       "      );
qrysb.append("                  "      );
qrysb.append("           SELECT 'TSL' AS TP ,CM.BASEID CUSTCODE,          "      );
qrysb.append("             ST.ID3, 0 AS STOCKENTRY,       "      );
qrysb.append("            NVL(St.PIECES,1)*NVL(St.QUANTITY,1)*SO.ORATE  AS TODAY_SALES,       "      );
qrysb.append("            0 AS YEST_SALES,       "      );
qrysb.append("             0 AS TOTALSALES,       "      );
qrysb.append("             0 AS NO_OF_PRODUCT,       "      );
qrysb.append("              0 AS NO_OF_BRANCH       "      );
qrysb.append("           FROM KVICWEBKIMIS2023.SALESMAST SM,       "      );
qrysb.append("             KVICWEBKIMIS2023.SALESTRANS ST,       "      );
qrysb.append("                   KVICWEBKIMIS2023.STOCKOB SO,       "      );
qrysb.append("             KVICWEBKIMIS2023.CUSTMAST CM       "      );
qrysb.append("           WHERE SM.GSNUMBER = ST.GSNUMBER AND CM.CUSTCODE=SM.CUSTCODE       "      );
qrysb.append("           AND ST.COMPUTERID = SO.BARCODE AND TRUNC(SM.BDATE) = TRUNC(SYSDATE)       "      );
qrysb.append("                  "      );
qrysb.append("           UNION ALL       "      );
qrysb.append("                  "      );
qrysb.append("           SELECT 'YSL' AS TP ,CM.BASEID CUSTCODE,           "      );
qrysb.append("             ST.ID3, 0 AS STOCKENTRY,       "      );
qrysb.append("           0 AS TODAY_SALES,       "      );
qrysb.append("            NVL(St.PIECES,1)*NVL(St.QUANTITY,1)*SO.ORATE  AS YEST_SALES,       "      );
qrysb.append("             0 AS TOTALSALES,       "      );
qrysb.append("             0 AS NO_OF_PRODUCT,       "      );
qrysb.append("                     0 AS NO_OF_BRANCH       "      );
qrysb.append("           FROM KVICWEBKIMIS2023.SALESMAST SM,       "      );
qrysb.append("             KVICWEBKIMIS2023.SALESTRANS ST,       "      );
qrysb.append("             KVICWEBKIMIS2023.STOCKOB SO,       "      );
qrysb.append("             KVICWEBKIMIS2023.CUSTMAST CM       "      );
qrysb.append("           WHERE SM.GSNUMBER = ST.GSNUMBER AND CM.CUSTCODE=SM.CUSTCODE       "      );
qrysb.append("           AND ST.COMPUTERID = SO.BARCODE AND TRUNC(SM.BDATE) < SYSDATE-1       "      );
qrysb.append("                  "      );
qrysb.append("           UNION ALL       "      );
qrysb.append("                  "      );
qrysb.append("                 SELECT 'SL' AS TP ,CM.BASEID CUSTCODE,          "      );
qrysb.append("             ST.ID3, 0 AS STOCKENTRY,       "      );
qrysb.append("            0 AS TODAY_SALES,       "      );
qrysb.append("            0 AS YEST_SALES,       "      );
qrysb.append("                  NVL(St.PIECES,1)*NVL(St.QUANTITY,1)*SO.ORATE  AS TOTALSALES,       "      );
qrysb.append("             0 AS NO_OF_PRODUCT,       "      );
qrysb.append("                  0 AS NO_OF_BRANCH       "      );
qrysb.append("                FROM KVICWEBKIMIS2023.SALESMAST SM,       "      );
qrysb.append("             KVICWEBKIMIS2023.SALESTRANS ST,       "      );
qrysb.append("             KVICWEBKIMIS2023.STOCKOB SO,       "      );
qrysb.append("             KVICWEBKIMIS2023.CUSTMAST CM       "      );
qrysb.append("           WHERE SM.GSNUMBER = ST.GSNUMBER AND CM.CUSTCODE=SM.CUSTCODE       "      );
qrysb.append("           AND ST.COMPUTERID = SO.BARCODE       "      );
qrysb.append("                  "      );
qrysb.append("           UNION ALL       "      );
qrysb.append("              SELECT 'ST' AS TP, CTM.BASEID CUSTCODE,       "      );
qrysb.append("          0 AS ID3,       "      );
qrysb.append("            SO.M_GROSS AS STOCKENTRY,       "      );
qrysb.append("              0 AS TODAY_SALES,       "      );
qrysb.append("            0 AS YEST_SALES,       "      );
qrysb.append("             0 AS TOTALSALES,       "      );
qrysb.append("             0 AS  NO_OF_PRODUCT,       "      );
qrysb.append("                    0 AS NO_OF_BRANCH       "      );
qrysb.append("           FROM        "      );
qrysb.append("             KVICWEBKIMIS2023.STOCKOB_BAL_TEMP SO,KVICWEBKIMIS2023.CUSTMAST CTM       "      );
qrysb.append("           WHERE  SO.CUSTCODE=CTM.CUSTCODE       "      );
qrysb.append("                  "      );
qrysb.append("           UNION ALL       "      );
qrysb.append("                  "      );
qrysb.append("           SELECT 'NOP' AS TP, ID3.CUSTCODE,       "      );
qrysb.append("            0 AS ID3,       "      );
qrysb.append("             0 AS STOCKENTRY,       "      );
qrysb.append("              0 AS TODAY_SALES,       "      );
qrysb.append("            0 AS YEST_SALES,       "      );
qrysb.append("             0 AS TOTALSALES,       "      );
qrysb.append("             COUNT(*) NO_OF_PRODUCT,       "      );
qrysb.append("             0 AS NO_OF_BRANCH       "      );
qrysb.append("           FROM        "      );
qrysb.append("             KVICWEBKIMIS2023.ID3       "      );
qrysb.append("             GROUP BY  ID3.CUSTCODE       "      );
  qrysb.append("               "      );
qrysb.append("           UNION ALL       "      );
qrysb.append("                  "      );
qrysb.append("           SELECT 'NOB' AS TP, Cmm.Baseid,       "      );
qrysb.append("            0 AS ID3,       "      );
qrysb.append("             0 AS STOCKENTRY,       "      );
qrysb.append("              0 AS TODAY_SALES,       "      );
qrysb.append("            0 AS YEST_SALES,       "      );
qrysb.append("             0 AS TOTALSALES,       "      );
qrysb.append("             0 NO_OF_PRODUCT,       "      );
qrysb.append("             COUNT(*) NO_OF_BRANCH       "      );
qrysb.append("           FROM        "      );
qrysb.append("             KVICWEBKIMIS2023.CUSTMAST CMM WHERE CMM.CUST_TYPE_ID = 2       "      );
qrysb.append("             GROUP BY  Cmm.Baseid        "      );
qrysb.append("                  "      );
qrysb.append("                  "      );
qrysb.append("           ) GROUP BY CUSTCODE )) mast where  cust.kiid=mast.CUSTCODE (+)        "      );
qrysb.append("                        )          "      );
qrysb.append("                      )       "      );
qrysb.append("                    WHERE BEN_CD  NOT IN (1231, 1234)       "      );
qrysb.append("                    GROUP BY rollup(STATENAME) order by ZONE_NM,count(ben_cd)       "      );



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
                            <th colspan="1">Sr no.</th>
                            <th colspan="1">Zone</th>
                            <th>State</th>
                            <th>No. of KI/Depat Bhavan</th>
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
STATENAME=rsMain.getString("STATENAME")==null?"TOTAL":rsMain.getString("STATENAME");
NO_OF_BRANCH=rsMain.getString("NO_OF_BRANCH")==null?"":rsMain.getString("NO_OF_BRANCH");
No_started=rsMain.getString("No_started")==null?"":rsMain.getString("No_started");
NOT_started=rsMain.getString("NOT_started")==null?"":rsMain.getString("NOT_started");
TOTAL_SALES=rsMain.getString("TOTAL_SALES")==null?"":rsMain.getString("TOTAL_SALES");
NO_OF_PRODUCT=rsMain.getString("NO_OF_PRODUCT")==null?"":rsMain.getString("NO_OF_PRODUCT");
USERS=rsMain.getString("USERS")==null?"":rsMain.getString("USERS");
STOCK_ENTRY=rsMain.getString("STOCK_ENTRY")==null?"":rsMain.getString("STOCK_ENTRY");
YESTERDAY_SALES=rsMain.getString("YESTERDAY_SALES")==null?"":rsMain.getString("YESTERDAY_SALES");
TODAY_SALES=rsMain.getString("TODAY_SALES")==null?"":rsMain.getString("TODAY_SALES");
ZONE_NM=rsMain.getString("ZONE_NM")==null?"-":rsMain.getString("ZONE_NM");
srno=srno+1;
			%>	
                        <tr>
							
                            <th scope="row"><%=srno%></th>
							
<td ><% if (STATENAME.equals("")){
out.print ("TOTAL");
}else{
%><%= ZONE_NM %><%}%></td>
							
							<td><%= STATENAME %></td>
							<td><%= USERS %></td>
							<td><div align="right"><%= YESTERDAY_SALES %></div></td>
							<td><div align="right"><%= TODAY_SALES %></div></td>
							<td><div align="right"><%= TOTAL_SALES %></div></td>
							<td> <a href="statewise.jsp?STATENAME=<%= STATENAME %>&INST_TYPE=<%= INST_TYPE %>" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a></td>	
                        </tr>
					<%}rsMain.close();
					db.close();
					 %>
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