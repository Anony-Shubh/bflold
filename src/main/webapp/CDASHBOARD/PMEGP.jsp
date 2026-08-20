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
							  <li class="nav-item"><a href="kimis/kimismain.jsp" class="nav-link">SALES(KIMIS)</a></li>
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
String PEND_CLAIM="";
String PEND_CLAIM_MM="";
if (vfields.equals("0")){
ReportName="Zone Wise ";
qryField="  ZM.zone_nm  ";
qryField1="  nvl(zone_nm,' GrandTotal') AS OFF_NAME  ";
qryField2="zone_nm";
qryGroup=" ZM.ZONE_NM,ZM.ZONE_CD";
qryGroup1=" ZONE_NM"; 
} 

if (vfields.equals("1")){
ReportName="State wise";
qryField="  ms.state_nm  ";
qryField1="  nvl(state_nm,' GrandTotal') AS OFF_NAME  ";
qryField2=" state_nm";
qryGroup="  ms.state_nm,ms.state_cd";
qryGroup1=" state_nm";
txtSearch= txtSearch+"AND ZM.zone_nm='"+ZONE+"' ";
}


if (vfields.equals("2")){
ReportName="Districtwise";
qryField="  dm.district_name  ";
qryField1="  nvl(district_name,' GrandTotal') AS OFF_NAME  ";
qryField2=" district_name";
qryGroup=" dm.district_name,ms.state_cd";
qryGroup1=" district_name";
txtSearch= txtSearch+"AND ms.state_nm='"+ZONE+"' ";
}
	 
	 
StringBuffer qrysb = new StringBuffer();
	qrysb.append("   SELECT /*+ PARALLEL(auto) */ "      );
	qrysb.append(" "+qryField1+" , ");
	if (!vfields.equals("2")){ 
qrysb.append("    SUM(PRJ_NO_TGT) PRJ_NO_TGT,"      );
qrysb.append("   SUM(MM_TGT) MM_TGT,"      );
	} else {
	qrysb.append("    MAX(PRJ_NO_TGT) PRJ_NO_TGT,"      );
qrysb.append("   MAX(MM_TGT) MM_TGT," );	
	}
qrysb.append("   SUM(APP_REC)  APP_REC,"      );
qrysb.append("     SUM(bank_ford)   bank_ford ,"      );
qrysb.append("     SUM(bank_sanc) bank_sanc,"      );
qrysb.append("     SUM(bank_sanc_mm) bank_sanc_mm, "      );
qrysb.append("     SUM(CLAIM_NO) CLAIM_NO,"      );
qrysb.append("     SUM(CLAIM_AMT) CLAIM_AMT,"      );
qrysb.append("     SUM(DISB_NO )DISB_NO,"      );
qrysb.append("     ROUND(SUM(DISB_MM)/100000,2) DISB_AMT,SUM(PEND_CLAIM) as PEND_CLAIM,SUM(PEND_CLAIM_MM) AS PEND_CLAIM_MM FROM"      );
qrysb.append("     ("      );
qrysb.append("     SELECT "      );
qrysb.append("   "+qryField+", ");

if (vfields.equals("0")){
qrysb.append("   (SELECT SUM(PRJ_NO_TGT) FROM mmtarget_online_2223 WHERE STATE_CD IN (SELECT STATE_CD FROM M_STATE WHERE zone_cd=ZM.ZONE_CD) ) AS PRJ_NO_TGT,"      );
qrysb.append("     (SELECT SUM(MM_TGT) FROM mmtarget_online_2223 WHERE STATE_CD IN (SELECT STATE_CD FROM M_STATE WHERE zone_cd=ZM.ZONE_CD) ) AS MM_TGT,"      );
}
if (vfields.equals("1")){
qrysb.append(" (SELECT SUM(PRJ_NO_TGT) FROM mmtarget_online_2223 WHERE STATE_CD=MS.STATE_CD) AS PRJ_NO_TGT, ");
qrysb.append("  (SELECT SUM(MM_TGT) FROM mmtarget_online_2223 WHERE STATE_CD=MS.STATE_CD) AS MM_TGT,");
}

if (vfields.equals("2")){
qrysb.append(" '-' AS PRJ_NO_TGT, ");
qrysb.append(" '-' AS MM_TGT,");
}

qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(ad.ONLINE_SUBDT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)  "      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS APP_REC,      "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN (ad.ACT_ID = 5 "      );
qrysb.append("         AND TRUNC(ad.BANK_F_DATE) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE))"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_ford,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND ad.ACT_ID = 5"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_sanc,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND ad.ACT_ID = 5"      );
qrysb.append("         THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("       END, 0)) AS bank_sanc_mm,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("        THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS CLAIM_NO,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         THEN ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0  END, 0)) AS CLAIM_AMT,"      );
qrysb.append("          SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN  bd.MM_REL_DT IS NOT NULL AND TRUNC(bd.MM_REL_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND bd.ACT_ID     >= 11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A'     "      );
qrysb.append("        THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS DISB_NO,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("        WHEN bd.MM_REL_DT IS NOT NULL AND TRUNC(bd.MM_REL_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND bd.ACT_ID     >= 11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A'"      );
qrysb.append("         THEN bd.MM_REL_AMT "      );
qrysb.append("         ELSE 0  END, 0)) AS DISB_MM,"      );
qrysb.append("  SUM(NVL(    ");
qrysb.append("	CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL ");
qrysb.append("	AND   TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)  ");
qrysb.append("	THEN 1 ELSE 0 END,0)) AS PEND_CLAIM, ");
qrysb.append("  SUM(NVL(    ");
qrysb.append("	CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL ");
qrysb.append("	AND   TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)  ");
qrysb.append("	THEN  ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2) ELSE 0 END,0)) AS PEND_CLAIM_MM ");
qrysb.append("       FROM app_detail ad,"      );
qrysb.append("       bank_dataentry bd,"      );
qrysb.append("       m_district dm,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("      AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("     AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("     AND ad.OFF_CD       = mom.OFF_CD(+)"      );
qrysb.append("     AND ms.ZONE_CD      = ZM.ZONE_CD  "+txtSearch+" "      );
qrysb.append("     GROUP BY "+qryGroup+"    "      );
qrysb.append("     UNION ALL"      );
qrysb.append("     SELECT "      );
qrysb.append("   "+qryField+", ");
if (vfields.equals("0")){
qrysb.append("   (SELECT SUM(PRJ_NO_TGT_II) FROM mmtarget_online_2223 WHERE STATE_CD IN (SELECT STATE_CD FROM M_STATE WHERE zone_cd=ZM.ZONE_CD) ) AS PRJ_NO_TGT,"      );
qrysb.append("     (SELECT SUM(MM_TGT_II) FROM mmtarget_online_2223 WHERE STATE_CD IN (SELECT STATE_CD FROM M_STATE WHERE zone_cd=ZM.ZONE_CD) ) AS MM_TGT,"      );
}
if (vfields.equals("1")){
qrysb.append(" (SELECT SUM(PRJ_NO_TGT_II) FROM mmtarget_online_2223 WHERE STATE_CD=MS.STATE_CD) AS PRJ_NO_TGT, ");
qrysb.append("  (SELECT SUM(MM_TGT_II) FROM mmtarget_online_2223 WHERE STATE_CD=MS.STATE_CD) AS MM_TGT,");
}
if (vfields.equals("2")){
qrysb.append(" '-' AS PRJ_NO_TGT, ");
qrysb.append("  '-' AS MM_TGT,");
}

qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(ad.ONLINE_SUBDT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS APP_REC,"      );
qrysb.append("       "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN (ad.ACT_ID = 5"      );
qrysb.append("         AND TRUNC(ad.BANK_F_DATE) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE))"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_ford,"      );
qrysb.append("     "      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND ad.ACT_ID = 5"      );
qrysb.append("         THEN 1"      );
qrysb.append("       END, 0)) AS bank_sanc,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.ACT_ID >= 11"      );
qrysb.append("         AND TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND ad.ACT_ID = 5"      );
qrysb.append("         THEN ROUND(MM_AMT_BANKSANC(bd.APP_ID) / 100000, 2)"      );
qrysb.append("       END, 0)) AS bank_sanc_mm,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("        THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS CLAIM_NO,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN bd.MM_CLAIM_AMT  > 0"      );
qrysb.append("         AND bd.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("         AND bd.ACT_ID        >= 11 AND TRUNC(bd.MM_CLAIM_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         THEN ROUND(bd.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("         ELSE 0  END, 0)) AS CLAIM_AMT,"      );
qrysb.append("          SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN  bd.MM_REL_DT IS NOT NULL AND TRUNC(bd.MM_REL_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND bd.ACT_ID     >= 11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A'     "      );
qrysb.append("        THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END, 0)) AS DISB_NO,"      );
qrysb.append("       SUM(NVL("      );
qrysb.append("       CASE"      );
qrysb.append("        WHEN bd.MM_REL_DT IS NOT NULL AND TRUNC(bd.MM_REL_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)"      );
qrysb.append("         AND bd.ACT_ID     >= 11 AND bd.PACT_ID        = 34 AND bd.APPRV_YN       = 'A'"      );
qrysb.append("         THEN bd.MM_REL_AMT "      );
qrysb.append("         ELSE 0  END, 0)) AS DISB_MM,"      );
qrysb.append("  SUM(NVL(    ");
qrysb.append("	CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL ");
qrysb.append("	AND   TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)  ");
qrysb.append("	THEN 1 ELSE 0 END,0)) AS PEND_CLAIM, ");
qrysb.append("  SUM(NVL(    ");
qrysb.append("	CASE WHEN AD.ACT_ID=5 AND BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL ");
qrysb.append("	AND   TRUNC(bd.LOAN_SANC_DT) BETWEEN '01-APR-2022' AND TRUNC(SYSDATE)  ");
qrysb.append("	THEN  ROUND(MMINV_BANKADMIT(AD.APP_ID)/100000,2) ELSE 0 END,0)) AS PEND_CLAIM_MM ");
qrysb.append("       FROM app_detail_SECOND ad,"      );
qrysb.append("       bank_dataentry_SECOND bd,"      );
qrysb.append("       m_district dm,"      );
qrysb.append("       mas_off_mast mom,"      );
qrysb.append("       m_state ms,"      );
qrysb.append("       ZONE_MAST ZM"      );
qrysb.append("     WHERE ad.APP_ID     = bd.APP_ID(+)"      );
qrysb.append("      AND ad.UNIT_DIST_CD = dm.DISTRICT_CD"      );
qrysb.append("     AND dm.STATE_CD     = ms.STATE_CD"      );
qrysb.append("     AND ad.OFF_CD       = mom.OFF_CD(+)"      );
qrysb.append("     AND ms.ZONE_CD      = ZM.ZONE_CD  "+txtSearch+" "      );
qrysb.append("     GROUP BY "+qryGroup+")"      );
qrysb.append("     GROUP BY rollup ("+qryGroup1+") order by "+qryField2+"  "      );
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
                            <th colspan="14">PRIME MINISTER'S EMPLOYMENT GENERATION PROGRAMME
                                (PMEGP)
                                FOR THE YEAR 2022-23
                            </th>
                        </tr>
                        <tr class="second_head">
                            <th colspan="1">Sr. No.</th>
							<%if (vfields.equals("0")){ %>
                            <th colspan="1">Zone</th>
							<%} else if (vfields.equals("1")){%>
                            <th colspan="1">State</th>
							<%} else if (vfields.equals("2")){%>
                            <th colspan="1">District</th>
							<%}%>
                            <th colspan="2">Target</th>
                            <th colspan="1"> No. of Application<br>Received at Agency</th>
                            <th colspan="1">No. of Applications<br>forwarded to Bank</th>
                            <th colspan="2">Sanctioned by Bank</th>
							<th colspan="2">Claim</th>
							<th colspan="2">Pending for Claim</th>
                            <th colspan="2">Disbursement</th>
                        </tr>
                        <tr class="mini_head">
                            <th colspan="1"></th>
                            <th colspan="1"></th>
                            <th colspan="1">No. of Project</th>
                            <th colspan="1">MM(In Lakh)</th>
                            <th colspan="1"></th>
                            <th colspan="1"></th>
							<th colspan="1">No. of Project</th>
                            <th colspan="1">MM(In Lakh)</th>
                            <th colspan="1">No. of Project</th>
                            <th colspan="1">MM(In Lakh)</th>
							<th colspan="1">No. of Project</th>
                            <th colspan="1">MM(In Lakh)</th>
                            <th colspan="1">No. of Project</th>
                            <th colspan="1">MM(In Lakh)</th>
                        </tr>
                    </thead>
					
                    <tbody>
					<%
					int srno =0;
					while (rsMain.next()){
						
 OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");	
 PRJ_NO_TGT=rsMain.getString("PRJ_NO_TGT")==null?"":rsMain.getString("PRJ_NO_TGT");	
 MM_TGT=rsMain.getString("MM_TGT")==null?"":rsMain.getString("MM_TGT");	
 APP_REC=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");	
 bank_ford=rsMain.getString("bank_ford")==null?"":rsMain.getString("bank_ford");	
 bank_sanc=rsMain.getString("bank_sanc")==null?"":rsMain.getString("bank_sanc");	
 bank_sanc_mm=rsMain.getString("bank_sanc_mm")==null?"":rsMain.getString("bank_sanc_mm");	
 CLAIM_NO=rsMain.getString("CLAIM_NO")==null?"":rsMain.getString("CLAIM_NO");	
 CLAIM_AMT=rsMain.getString("CLAIM_AMT")==null?"":rsMain.getString("CLAIM_AMT");	
 DISB_NO=rsMain.getString("DISB_NO")==null?"":rsMain.getString("DISB_NO");	
 DISB_AMT=rsMain.getString("DISB_AMT")==null?"":rsMain.getString("DISB_AMT");
 PEND_CLAIM=rsMain.getString("PEND_CLAIM")==null?"":rsMain.getString("PEND_CLAIM");
 PEND_CLAIM_MM=rsMain.getString("PEND_CLAIM_MM")==null?"":rsMain.getString("PEND_CLAIM_MM");
srno=srno+1; 
			%>	
                        <tr>
							
                            <th scope="row"><%=srno%></th>
							<% if (!OFF_NAME.equals(" GrandTotal")){%>
							<%if (vfields.equals("0")){ %>
                            <td colspan="1"><a href="PMEGP.jsp?vfields=1&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></td>
							<%} else if (vfields.equals("1")){ %>	
							<td colspan="1"><a href="PMEGP.jsp?vfields=2&ZONE=<%=OFF_NAME%>"><%=OFF_NAME%></a></td>	
							<%} else if (vfields.equals("2")){%>
							<td colspan="1"><%=OFF_NAME%></td>	
							<%}%>
                            <td colspan="1"><%=PRJ_NO_TGT%></td>
                            <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>
                            <td colspan="1"><%=bank_ford%></td>
                            <td colspan="1"><%=bank_sanc%></td>
                            <td colspan="1"><%=bank_sanc_mm%></td>
                            <td colspan="1"><%=CLAIM_NO%></td>
                            <td colspan="1"><%=CLAIM_AMT%></td>
							 <td colspan="1"><%=PEND_CLAIM%></td>
                            <td colspan="1"><%=PEND_CLAIM_MM%></td>
							 <td colspan="1"><%=DISB_NO%></td>
                            <td colspan="1"><%=DISB_AMT%></td>
							<%} else {%>
							 <td colspan="1"><%=OFF_NAME%></td>
							  <td colspan="1"><%=PRJ_NO_TGT%></td>
                            <td colspan="1"><%=MM_TGT%></td>
                            <td colspan="1"><%=APP_REC%></td>
                            <td colspan="1"><%=bank_ford%></td>
                            <td colspan="1"><%=bank_sanc%></td>
                            <td colspan="1"><%=bank_sanc_mm%></td>
                            <td colspan="1"><%=CLAIM_NO%></td>
                            <td colspan="1"><%=CLAIM_AMT%></td>
							 <td colspan="1"><%=PEND_CLAIM%></td>
                            <td colspan="1"><%=PEND_CLAIM_MM%></td>
						     <td colspan="1"><%=DISB_NO%></td>
                            <td colspan="1"><%=DISB_AMT%></td>
							
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