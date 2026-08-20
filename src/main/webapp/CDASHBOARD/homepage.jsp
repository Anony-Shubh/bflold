<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
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
<%
		DBCon db= new DBCon();
db.connect();

	 List values=new ArrayList();	
String OFF_NAME="";
String PRJ_NO_TGT="";
String MM_TGT="";
String APP_REC="";
String TYPE="";
String NO_INS="";
String TOT_MDA="";
StringBuffer qrysb = new StringBuffer();

qrysb.append(" SELECT * FROM (SELECT 2 AS SRNO, 'MMDA' AS TYPE,COUNT(DISTINCT MA.BEN_CD) NO_INS, ");
qrysb.append(" ROUND(SUM(CASE WHEN DBT.REC_ID <> 57 THEN NVL(DBT.AMT, 0)END)/100000,2) AS TOT_MDA ");
qrysb.append(" FROM  BUDGET.MDA_ADDINFO MA, ");
 qrysb.append("    BUDGET.MDA_DBT_BANK_TRANS DBT  ");
qrysb.append(" WHERE  MA.CLAIM_ID    = DBT.CLAIM_ID ");
qrysb.append(" AND TRUNC(MA.CHQ_DT) BETWEEN '01-APR-2023' AND sysdate ");
qrysb.append(" AND MA.STAT_ID = 10 ");
qrysb.append(" UNION ");
qrysb.append(" SELECT 3 AS SRNO,'ISEC' AS TYPE,count( DISTINCT IC.BEN_CD) AS NO_INS, ");
qrysb.append(" ROUND(SUM(NVL(IC.SO_ADMIT_AMT, 0))/100000,2) ISEC_AVAILED ");
qrysb.append("  from BUDGET.isec_claim ic where TRUNC(ic.chq_dt)  ");
qrysb.append("  BETWEEN '01-apr-2023' AND SysDate  and ic.stat_id=10 ");
qrysb.append(" UNION ");
qrysb.append(" SELECT 1 AS SRNO,'PMEGP' AS TYPE, SUM(NO_OF_APP),ROUND(SUM(AMT)/100000,2) FROM ( ");
qrysb.append(" SELECT COUNT(*) AS NO_OF_APP,SUM(MM_REL_AMT) AS AMT FROM BANK_DATAENTRY WHERE PACT_ID=34 AND TRUNC(MM_REL_DT) IS NOT NULL ");
qrysb.append(" AND TRUNC(MM_REL_DT)  BETWEEN '01-apr-2022' AND '31-mar-2023'  ");
qrysb.append(" UNION  ");
qrysb.append(" SELECT COUNT(*) AS NO_OF_APP,SUM(MM_REL_AMT) AS AMT  FROM BANK_DATAENTRY_SECOND WHERE PACT_ID=34 AND TRUNC(MM_REL_DT) IS NOT NULL ");
qrysb.append(" AND TRUNC(MM_REL_DT)  BETWEEN '01-apr-2022' AND '31-mar-2023') ");
qrysb.append(" union ");
qrysb.append("  select 5 srno, 'HR' as type, ");
qrysb.append("  1247 as no_of_ins, 161.42 as tot_mda from dual ");
qrysb.append(" UNION ");
qrysb.append(" select 5 AS SRNO,'CB' AS TYPE,no_of_trainees,round(exp/100000,2) as exp from ( ");
//qrysb.append(" SELECT COUNT(  CASE WHEN bm.TRG_TO BETWEEN hrd_user.FINANCIAL_YEAR_BEGIN(sysdate) AND sysdate ");
qrysb.append(" SELECT COUNT(  CASE WHEN bm.TRG_TO BETWEEN '01-apr-2022' AND sysdate ");
qrysb.append("     THEN td.T_ID   END) AS no_of_trainees   ");
qrysb.append(" FROM hrd_user.mdtc_mast mm,  hrd_user.batch_mast bm, ");
qrysb.append("   hrd_user.trainee_data td WHERE mm.MDTC_ID  = bm.MDTC_ID(+) ");
qrysb.append(" AND bm.B_ID  = td.B_ID(+)");
qrysb.append(" AND mm.MDTC_CAT NOT IN ('SO/DO', 'SFURTI', 'Dept.') ");
qrysb.append(" AND mm.ACT_FLG       = 'Y' )a,( select sum(nvl(amt,0)) as exp from hrd_user.exp_trans where exp_month between '01-apr-2022' AND '31-mar-2023') b ) ORDER BY SRNO ");

/*  2023-24  Fin budget 190.77 crore for HR */



  ResultSet rsMain = db.execSQL(qrysb.toString());
  
//out.print(qrysb.toString());
	values.clear();	

int srno =0;
					
%>

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
    <div class="container-fluid">
      <div class="online-application">
        <div class="row">
          <div class="col-lg-4 col-md-12">
            <div class="card">
              <div class="card-body" style="padding: 0; margin: 0;">
                <div class="info-head">
                  <h5>ACHIEVEMENT 2022-23</h5>
                </div>
                <div class="info-data">
                  <div class="row row_head">
                    <div class="col-4 head"></div>
                    <div class="col-4 phy_head">
                      <h5>Physical</h5>
                    </div>
                    <div class="col-4 fin_head">
                      <h5>Financial</h5>
                    </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>PMEGP</h5>
                    </div>
                    <div class="col-4 phy_data">10329(Units)</div>
                    <div class="col-4 fin_data">2978 lakhs.</div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>MMDA</h5>
                    </div>
                    <div class="col-4 phy_data">172378</div>
                    <div class="col-4 fin_data">272 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>ISEC</h5>
                    </div>
                    <div class="col-4 phy_data">1088</div>
                    <div class="col-4 fin_data">34 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>CB</h5>
					  

                    </div>
                    <div class="col-4 phy_data">62736</div>
                    <div class="col-4 fin_data">10.82 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>HR</h5>
                    </div>
                    <div class="col-4 phy_data">1511</div>
                    <div class="col-4 fin_data">180 lakhs </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-12">
            <div class="card">
              <div class="card-body" style="padding: 0; margin: 0;">
                <div class="info-head">
                  <h5>BUDGET 2023-24</h5>
                </div>
                <div class="info-data">
                  <div class="row row_head">
                    <div class="col-4 head"></div>
                    <div class="col-4 phy_head">
                      <h5>Physical</h5>
                    </div>
                    <div class="col-4 fin_head">
                      <h5>Financial</h5>
                    </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>PMEGP</h5>
                    </div>
                    <div class="col-4 phy_data">101008 (Units) </div>
                    <div class="col-4 fin_data">2955 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>MMDA</h5>
                    </div>
                    <div class="col-4 phy_data">2180 (Instns.) </div>
                    <div class="col-4 fin_data">247.67 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>ISEC</h5>
                    </div>
                    <div class="col-4 phy_data">1500 (Instns) </div>
                    <div class="col-4 fin_data">39.71 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>CB</h5>
                    </div>
                    <div class="col-4 phy_data">95700 (Trainees) </div>
                    <div class="col-4 fin_data">22.61 lakhs </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-4 head">
                      <h5>HR</h5>
                    </div>
                    <div class="col-4 phy_data">1496 (Sanctioned)</div>
                    <div class="col-4 fin_data">208.99 lakhs </div>
					
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-12">
            <div class="card">
              <div class="card-body" style="padding: 0; margin: 0;">
                <div class="info-head">
                  <h5>ACHIEVEMENT 2023-24</h5>
                </div>
                <div class="info-data">
                  <div class="row row_head">
                    <div class="col-3 head"></div>
                    <div class="col-3 phy_head">
                      <h5>Physical</h5>
                    </div>
                    <div class="col-3 fin_head">
                      <h5>Financial( Lakhs) </h5>
					  <!--  <div class="col-4 phy_data">1247 (Employee)</div>
                     <div class="col-4 fin_data">161.42 Cr. </div>-->

                    </div>
                  </div>
				  <div class="inner">&nbsp;</div>
				  <%
				  
				  while (rsMain.next()){
		
 TYPE=rsMain.getString("TYPE")==null?"":rsMain.getString("TYPE");	
 NO_INS=rsMain.getString("NO_INS")==null?"":rsMain.getString("NO_INS");	
 TOT_MDA=rsMain.getString("TOT_MDA")==null?"":rsMain.getString("TOT_MDA");	

srno=srno+1;
				  
				  %>
                  

                  <div class="row">
                    <div class="col-3 head">
                      <h5><%=TYPE%></h5>
                    </div>
                    <div class="col-3 phy_data"><%=NO_INS%></div>
                    <div class="col-3 fin_data"><%=TOT_MDA%></div>
                   	 <div class="col-3 view_more">
                      <a href="<%=TYPE%>.jsp" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a>
                    </div>
                  </div>
                  <div class="inner">&nbsp;</div>
				 
                     
					<%}
					rsMain.close(); %>
             <!--   <div class="row">
                    <div class="col-3 head">
                      <h5>MMDA</h5>
                    </div>
                    <div class="col-3 phy_data">70759</div>
                    <div class="col-3 fin_data">64 Cr.</div>                   
					 <div class="col-3 view_more">
                      <a href="mmda.jsp" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a>
                    </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-3 head">
                      <h5>ISEC</h5>
                    </div>
                    <div class="col-3 phy_data">961</div>
                    <div class="col-3 fin_data">2 Cr.</div>
                   
					 <div class="col-3 view_more">
                      <a href="isec.jsp" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a>
                    </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-3 head">
                      <h5>CB</h5>
                    </div>
                    <div class="col-3 phy_data">17816</div>
                    <div class="col-3 fin_data">2.90  Cr.</div>
                  
					 <div class="col-3 view_more">
                      <a href="cb.jsp" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a>
                    </div>
                  </div>
                  <div class="inner">&nbsp;</div>
                  <div class="row">
                    <div class="col-3 head">
                      <h5>HR</h5>
                    </div>
                    <div class="col-3 phy_data">1423</div>
                    <div class="col-3 fin_data">107.23 Cr. </div>                   
					 <div class="col-3 view_more">
                      <a href="hr.jsp" target="_blank" data-toggle="tooltip" title="View More"><i
                          class="fa fa-chevron-circle-right" aria-hidden="true"></i></a>
                    </div>
                  </div>-->
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- <div class="row">
            <div class="col-12">
              <div class="tour_link">
                <div class="tour_section">
                  <a href="#" onclick="readonlyFunction()" 
                  id="login-alert"><h3>Officers on Tour/Leave</h3></a>
                </div>                
              </div>
            </div>
          </div> -->
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

  <div class="alert kircs-alert" role="alert">
    <div class="login-links">
      <a href="#" class="alert-link">ON TOUR</a>
      <a href="#" class="alert-link">ON LEAVE</a>
    </div>
  </div>




  <script src="js/popper.min.js"></script>
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script>
    $(document).ready(function () {
      $('#login-alert').click(function () {
        $('.alert').show()
      })
    });

    function readonlyFunction() {
      document.getElementById("main").disabled = true;
      document.getElementById("main").style.filter = 'blur(10px)';
    }
  </script>
  
  <!--script>
    $(document).ready(function () {
      $('[data-toggle="tooltip"]').tooltip();
    });
  </script-->

</body>

</html>