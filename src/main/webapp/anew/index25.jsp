<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
    <!DOCTYPE html>
<HTML lang="en">

<HEAD>

    <META CHARSET="utf-8">
    <META http-equiv="X-UA-Compatible" content="IE=edge">
    <META name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <META name="description" content="">
    <META name="author" content="">

    <TITLE>PMEGP Dashboard</TITLE>

    <!-- Custom fonts for this template-->
    <LINK href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <LINK
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <LINK href="css/sb-admin-2.css" rel="stylesheet">
        
        
       
        
</HEAD>

<BODY id="page-top">

<%
DBCon db= new DBCon();
db.connect();

String APP_REC="";
String BANK_FORWAD_NO="";
String BANK_FORWAD_MM="";
String SANC_NO="";
String SANC_MM="";
String OWNCONTRI_NO="";
String OWNCONTRI="";
String LOANDIS_NO="";
String LOANDIS_MM="";
String EDP_NO="";

StringBuffer qrysb=new StringBuffer();

qrysb.append("	SELECT	");
//APPLICATIONS RECEIVED BY AGENCY
qrysb.append("	SUM(CASE WHEN AD.ONLINE_SUBDT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN 1 ELSE 0 END) APP_REC,	");
//FORWARDED TO BANK
qrysb.append("	SUM(CASE WHEN AD.BANK_F_DATE BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN 1 ELSE 0 END) BANK_FORWAD_NO,	");
qrysb.append("	SUM(CASE WHEN AD.BANK_F_DATE BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN ROUND(MMINVOLVE(AD.APP_ID)/10000000,2) ELSE 0 END) BANK_FORWAD_MM,	");
//SANCTIONED BY BANK
qrysb.append("	SUM(CASE WHEN BD.LOAN_SANC_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN 1 ELSE 0 END) SANC_NO, SUM(CASE WHEN BD.LOAN_SANC_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN ROUND(MMINVOLVEBANK(AD.APP_ID)/10000000,2) ELSE 0 END) SANC_MM,	");
//OWN CONTRIBUTION DEPOSITED BY BENEFICIARY
qrysb.append("	SUM(CASE WHEN BD.OWN_CONT_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN 1 ELSE 0 END) OWNCONTRI_NO, SUM(CASE WHEN BD.OWN_CONT_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN ROUND(BD.OWN_CONTRIBUTION/10000000,2) ELSE 0 END) OWNCONTRI,	");
//LOAN DISBURSED BY BANK
qrysb.append("	SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN 1 ELSE 0 END) LOANDIS_NO, SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN ROUND(BD.IST_LOAN_AMT/10000000,2) ELSE 0 END) LOANDIS_MM,	");
//EDP TRAINING COMPLETED
qrysb.append(" SUM(CASE WHEN BD.EDP_CERT_DT BETWEEN '01-APR-2020' AND TRUNC(SYSDATE) THEN 1 ELSE 0 END) EDP_NO FROM APP_DETAIL AD	");
qrysb.append("	,BANK_DATAENTRY BD WHERE AD.APP_ID=BD.APP_ID(+)	");

List values=new ArrayList();

ResultSet rs1=db.execSQL(qrysb.toString());



	while (rs1.next()) {


  APP_REC=rs1.getString("APP_REC")==null?"":rs1.getString("APP_REC");
  BANK_FORWAD_NO=rs1.getString("BANK_FORWAD_NO")==null?"":rs1.getString("BANK_FORWAD_NO");
  BANK_FORWAD_MM=rs1.getString("BANK_FORWAD_MM")==null?"":rs1.getString("BANK_FORWAD_MM");
  SANC_NO=rs1.getString("SANC_NO")==null?"":rs1.getString("SANC_NO");
  SANC_MM=rs1.getString("SANC_MM")==null?"":rs1.getString("SANC_MM");
  OWNCONTRI_NO=rs1.getString("OWNCONTRI_NO")==null?"":rs1.getString("OWNCONTRI_NO");
  OWNCONTRI=rs1.getString("OWNCONTRI")==null?"":rs1.getString("OWNCONTRI");
  LOANDIS_NO=rs1.getString("LOANDIS_NO")==null?"":rs1.getString("LOANDIS_NO");
  LOANDIS_MM=rs1.getString("LOANDIS_MM")==null?"":rs1.getString("LOANDIS_MM");
  OWNCONTRI=rs1.getString("OWNCONTRI")==null?"":rs1.getString("OWNCONTRI");
  EDP_NO=rs1.getString("EDP_NO")==null?"":rs1.getString("EDP_NO");

}
rs1.close();
%>



    <!-- Page Wrapper -->
    <DIV id="wrapper">

        <!-- Content Wrapper -->
        <DIV id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <DIV id="content">

                <!-- Topbar -->
            
                <!-- Begin Page Content -->
                <DIV class="container-fluid">

 <CENTER>   
 
  <IMG src="img/banner3.jpg" width="100%">   <BR><BR>
  <A href="#" class="btn btn-info btn-icon-split">
                                        <SPAN class="icon text-white-50">
                                            <I class="fas fa-home"></I>
                                        </SPAN>
                                        <SPAN class="text">Home</SPAN>
                                    </A>
     <SELECT>
         <OPTION value="">Year</OPTION>
         <OPTION value="">2020-21</OPTION>
         <OPTION value="">2019-20</OPTION>
         <OPTION value="">2018-19</OPTION>
         <OPTION value="">2017-18</OPTION>
         <OPTION value="">2016-17</OPTION>
     </SELECT>
    
     <SELECT>
         <OPTION value="">Agency</OPTION>
         <OPTION value="">All</OPTION>
         <OPTION value="">KVIC</OPTION>
          <OPTION value="">KVIB</OPTION>
          <OPTION value="">DIC</OPTION>
          <OPTION value="">Coir</OPTION>
     </SELECT>
      <SELECT>
         <OPTION value="">State</OPTION>
          <OPTION value="">All</OPTION>
         <OPTION value="AP">ANDHRA PRADESH</OPTION>
           <OPTION value="AR">ARUNACHAL PRADESH</OPTION>
           <OPTION value="AS">ASSAM</OPTION>
           <OPTION value="BH">BIHAR</OPTION>
           <OPTION value="GO">GOA</OPTION>
           <OPTION value="GJ">GUJARAT</OPTION>
           <OPTION value="HY">HARYANA</OPTION>
           <OPTION value="HP">HIMACHAL PRADESH</OPTION>
          
           <OPTION value="JK">JAMMU KASHMIR</OPTION>
           <OPTION value="KN">KARNATAKA</OPTION>
           <OPTION value="KL">KERALA</OPTION>
          
           <OPTION value="MP">MADHYA PRADESH</OPTION>
           <OPTION value="MH">MAHARASHTRA</OPTION>
           <OPTION value="MN">MANIPUR</OPTION>
          <OPTION value="MG">MEGHALAYA</OPTION>
          <OPTION value="OR">ODISHA</OPTION>
          <OPTION value="PJ">PUNJAB</OPTION>
          <OPTION value="RJ">RAJASTHAN</OPTION>
          <OPTION value="SK">SIKKIM</OPTION>
           <OPTION value="TN">TAMIL NADU</OPTION>
           <OPTION value="TR">TRIPURA</OPTION>
           <OPTION value="UP">UTTAR PRADESH</OPTION>
           <OPTION value="WB">WEST BENGAL</OPTION>
           <OPTION value="AN">ANDAMAN NICOBAR</OPTION>
           <OPTION value="CH">CHANDIGARH-UT</OPTION>
           <OPTION value="DN">DADRA NAGAR HAVELI</OPTION>
           <OPTION value="DD">DAMAN AND  DIU</OPTION>
           <OPTION value="DL">DELHI</OPTION>
          
          <OPTION value="LD">LAKSHADWEEP</OPTION>
          <OPTION value="PY">PUDUCHERRY</OPTION>
          <OPTION value="NG">NAGALAND</OPTION>
          <OPTION value="MZ">MIZORAM</OPTION>
          <OPTION value="UT">UTTARAKHAND</OPTION>
          <OPTION value="CG">CHHATTISGARH</OPTION>
          <OPTION value="JD">JHARKHAND</OPTION>
          <OPTION value="TG">TELANGANA</OPTION>
          <OPTION value="LK">LADAKH (UT)</OPTION>
          
          
     </SELECT>
	
      

                    <A href="pmegp/index.jsp" class="btn btn-info btn-icon-split">
                                        <SPAN class="icon text-white-50">
                                            <I class="fas fa-info-circle"></I>
                                        </SPAN>
                                        <SPAN class="text">MIS Reports</SPAN>
                                    </A>
     
     
     
                    </CENTER> <BR>
                    <DIV class="row">
                        
                        
                          <DIV class="col-xl-3 col-lg-3">
                        
                        
                         <DIV class="card shadow mb-4">
                               
                                <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center ">
                                        <DIV class="col mr-2">
                                           
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                               Applications received by agency</DIV>
                                             <DIV class="h5 mb-0 font-weight-bold text-white">No. of Application: <%= APP_REC %></DIV>
                                            
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-rupee-sign fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV>
                                 <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center">
                                        <DIV class="col mr-2">
                                           
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                                Forwarded to bank</DIV>
                                            <DIV class="h5 mb-0 font-weight-bold text-white">No.: <%= BANK_FORWAD_NO %> <BR>MM involved: <%= BANK_FORWAD_MM %></DIV>
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-clock fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV>
                                 <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center">
                                       <DIV class="col mr-2">
                                           
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                                Sanctioned by Bank</DIV>
                                            <DIV class="h5 mb-0 font-weight-bold text-white">No.: <%= SANC_NO %> <BR>MM involved: <%= SANC_MM %></DIV>
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-eye fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV>
                               
                                 <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center">
                                      <DIV class="col mr-2">
                                           
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                                Loan disbursed by bank</DIV>
                                            <DIV class="h5 mb-0 font-weight-bold text-white">No.: <%= LOANDIS_NO %> <BR> MM involved: <%= LOANDIS_MM %></DIV>
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-file fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV>
                                   <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center">
                                        <DIV class="col mr-2">
                                          
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                                Claim Received</DIV>
                                            <DIV class="h5 mb-0 font-weight-bold text-white">No., MM involved</DIV> 
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-flag fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV>
                             
                              <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center">
                                        <DIV class="col mr-2">
                                          
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                                Claim Disbursed</DIV>
                                            <DIV class="h5 mb-0 font-weight-bold text-white">No., MM involved</DIV> 
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-flag fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV>
                                   <DIV class="card border-left-primary shadow h-100 py-2 bg-gradient-info">
                                <DIV class="cardtestnew-body">
                                    <DIV class="row no-gutters align-items-center">
                                        <DIV class="col mr-2">
                                            
                                            <DIV class="h6 font-weight-bold text-white text-uppercase mb-1">
                                                Employment Opportunity Created</DIV>
                                           <DIV class="h5 mb-0 font-weight-bold text-white">No.: <%= OWNCONTRI_NO %> <BR> MM involved: <%= OWNCONTRI %></DIV> 
                                        </DIV>
                                        <DIV class="col-auto">
                                            <I class="fas fa-exclamation-triangle fa-2x text-gray-300"></I>                                        </DIV>
                                    </DIV>
                                </DIV>
                            </DIV> 
                            </DIV>
                        
  </DIV>

                        
                   
                         <DIV class="col-xl-5 col-lg-5">
                        
                        
                           <!-- Color System -->
                           
                              
                              
                         
                              
                                  <DIV class="card shadow mb-1">
                                     
                                 
                                      
                                      
                                   <DIV class="col-lg-13 mb-1">
                                    <DIV style="background-color: #4e73df" class="card text-white shadow">
                                        <DIV class="card-body">
                                          Margin Money (Govt. Subsidy) Disbursed (2020-21)
                                            <DIV class="text-white-50 large">
                                                
                                                <DIV class="row">
        <DIV class="col-sm-2" align="center">No.<BR>1</DIV>
        <DIV class="col-sm-4" align="center">Margin Money<BR>1</DIV>
        <DIV class="col-sm-6" align="center">Employment Opportunity Created<BR>1</DIV>
    </DIV>
                                               
                                            
                                            </DIV>
                                        </DIV>
                                    </DIV>
                                          <!-- Bar Chart -->
                            
                              
                               <DIV class="cardnew-body border-bottom-dark">
                                    <DIV class="chart-bar" >
                                        <canvas id="myBarChart"></canvas>
                                    </DIV>
                               
                                </DIV>
                            </DIV>
                                </DIV>
                             
                              <DIV class="card shadow mb-1">
                                    <DIV class="col-lg-13 mb-1">
                                     <DIV style="background-color: #4e73df" class="card text-white shadow">
                                        <DIV class="card-body">
                                            Target for the year
                                            <DIV class="text-white-50 large">
                                                
                                                <DIV class="row">
        <DIV class="col-sm-2" align="center">No. : 1</DIV>
        <DIV class="col-sm-4" align="center">Margin Money : 1</DIV>
        <DIV class="col-sm-6" align="center">Employment Opportunity Created : 1</DIV>
    </DIV>
                               
                                            
                                            </DIV>
                                        </DIV>
                                    </DIV>
                                          <!-- Bar Chart -->
                            
                               <DIV class="cardnew-body border-bottom-dark">
                                    <DIV class="chart-area">
                                        <canvas id="myAreaChart"></canvas>
                                    </DIV>
                                </DIV>
                            </DIV>
                                </DIV>
                             
                             
                             
                              <DIV class="card shadow mb-1">
                                <DIV class="col-lg-13 mb-1">
                                     <DIV style="background-color: #4e73df" class="card text-white shadow">
                                        <DIV class="card-body">
                                            Achievement Percentage
                                            <DIV class="text-white-50 large">
                                                
                                            <DIV class="row">
        <DIV class="col-sm-2" align="center">No. : 1</DIV>
        <DIV class="col-sm-4" align="center">Margin Money : 1</DIV>
        <DIV class="col-sm-6" align="center">Employment Opportunity Created : 1</DIV>
    </DIV>
                                            
                                            
                                            </DIV>
                                        </DIV>
                                    </DIV>
                                          <!-- Bar Chart -->
                            
                              
                                <DIV class="cardnew-body border-bottom-dark">
                                    <DIV class="chart-bar" >
                                        <canvas id="myBarChart2"></canvas>
                                    </DIV>
                               
                                </DIV>
                            </DIV>
                                </DIV>
                              
                          
                             
                             
                             
                             
                             
                             
                        
                        </DIV>
                        
                        
                     
                        <DIV class="col-xl-4 col-lg-3" >
                          
                            
                              <DIV class="row">   
                          
                        <!-- Pie Chart -->
                        <DIV class="col-xl-6 col-lg-5 ">
                            <DIV class="card shadow mb-4 border-bottom-dark">
                                <!-- Card Header - Dropdown -->
                                <DIV
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between border-bottom-dark">
                                    <H6 class="m-0 font-weight-bold text-primary">PMEGP Target</H6>
                                 
                                </DIV>
                                <!-- Card Body -->
                                <DIV class="card-body">
                                    <DIV class="chart-pie pt-4 pb-2">
                                        <canvas id="myPieChart"></canvas>
                                    </DIV>
                                    <DIV class="mt-4 text-center small">
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-primary"></I> Target  Achieved                                        </SPAN>
                                     
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Pending                                        </SPAN>     
                                    </DIV>
                                </DIV>
                            </DIV>
                        </DIV>
       
	   
	   



						
<%


	ResultSet rsCat1 = db.execSQL("SELECT AD.BENF_CATAGORY_CD, COUNT(*) AS NO_OF_APP, ROUND(SUM(MM_REL_AMT)/10000000,2) AS MM_REL_AMT ,SUM(NVL(AD.EMP_ENV,1)) AS EMP FROM APP_DETAIL AD ,BANK_DATAENTRY BD, ACTIVITY_MAST AM, IND_GRP_MAST IGM WHERE AD.APP_ID=BD.APP_ID AND BD.PACT_ID=34 AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND AM.IND_GRP_CD=IGM.IND_GRP_CD GROUP BY AD.BENF_CATAGORY_CD");
	
	
	    String MN ="0";
		String GEN ="0";
		String SC ="0";
		String OBC ="0";
		String ST ="0";
		
	//	String todt="";
		String BENF_CATAGORY_CD="";
		String NO_OF_APP="0";

 while (rsCat1.next()) {
//todt=rsCat.getString("TODT");
  BENF_CATAGORY_CD=rsCat1.getString("BENF_CATAGORY_CD");
		 NO_OF_APP=rsCat1.getString("NO_OF_APP");
		 
 if (BENF_CATAGORY_CD.equals("GEN")) {
 GEN=NO_OF_APP;
 }

if (BENF_CATAGORY_CD.equals("MN")) {
 MN=NO_OF_APP;
 }


if (BENF_CATAGORY_CD.equals("SC")) {
 SC=NO_OF_APP;
 }

if (BENF_CATAGORY_CD.equals("OBC")) {
 OBC=NO_OF_APP;
 }

if (BENF_CATAGORY_CD.equals("ST")) {
 ST=NO_OF_APP;
 }
}//END IF....
	rsCat1.close();	
%>		



	                    
                      
                     <DIV class="col-xl-6 col-lg-5 ">
                            <DIV class="card shadow mb-4 border-bottom-dark">
                                <!-- Card Header - Dropdown -->
                                <DIV
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between border-bottom-dark">
                                    <H6 class="m-0 font-weight-bold text-primary">Social Category wise</H6>
                                 
                                </DIV>
                                <!-- Card Body -->
                                <DIV class="card-body">
                                    <DIV class="chart-pie pt-4 pb-2">
                                        <canvas id="myPieChart3"></canvas>
                                    </DIV>
                                    <DIV class="mt-4 text-center small">
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-primary"></I> Target  Achieved                                        </SPAN>
                                     
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Pending                                        </SPAN>     
										<SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Pending                                        </SPAN>     
										<SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Pending                                        </SPAN>     
										<SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Pending                                        </SPAN>     			
                                    </DIV>
                                </DIV>
                            </DIV>
                        </DIV>
						
						
						
						
<%


	ResultSet rsCat = db.execSQL("SELECT IGM.IND_GRP_LONG_DESC, COUNT(*) AS NO_OF_PRJ, ROUND(SUM(MM_REL_AMT)/10000000,2) AS MM_REL_AMT ,SUM(NVL(AD.EMP_ENV,1)) AS EMP FROM APP_DETAIL AD ,BANK_DATAENTRY BD, ACTIVITY_MAST AM, IND_GRP_MAST IGM WHERE AD.APP_ID=BD.APP_ID AND BD.PACT_ID=34 AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND AM.IND_GRP_CD=IGM.IND_GRP_CD GROUP BY IGM.IND_GRP_LONG_DESC");
	
	
	
String FOREST_BASED_INDUSTRY ="0";
String POLYMER_AND_CHEMICAL_BASED_INDUSTRY ="0";
String AGRO_BASED_FOOD_PROCESSING_INDUSTRY ="0";
String HAND_MADE_PAPER_AND_FIBRE_INDUSTRY ="0";
String MINERAL_BASED_INDUSTRY ="0";
String COIR_BOARD_BASED_INDUSTRY ="0";
String SERVICE_AND_TEXTILE_INDUSTRY ="0";
String RURAL_ENGG_AND_BIO_TECH_INDUSTRY ="0";
		

		String IND_GRP_LONG_DESC="";
		String NO_OF_PRJ="0";
		

 while (rsCat.next()) {
 //todt=rsCat.getString("TODT");
  IND_GRP_LONG_DESC=rsCat.getString("IND_GRP_LONG_DESC");
		 NO_OF_PRJ=rsCat.getString("NO_OF_PRJ");
		 
 if (IND_GRP_LONG_DESC.equals("FOREST BASED INDUSTRY")) {
 FOREST_BASED_INDUSTRY=NO_OF_PRJ;
 }

if (IND_GRP_LONG_DESC.equals("POLYMER AND CHEMICAL BASED INDUSTRY")) {
 POLYMER_AND_CHEMICAL_BASED_INDUSTRY=NO_OF_PRJ;
 }


if (IND_GRP_LONG_DESC.equals("AGRO BASED FOOD PROCESSING INDUSTRY")) {
 AGRO_BASED_FOOD_PROCESSING_INDUSTRY=NO_OF_PRJ;
 }

if (IND_GRP_LONG_DESC.equals("HAND MADE PAPER AND FIBRE INDUSTRY")) {
 HAND_MADE_PAPER_AND_FIBRE_INDUSTRY=NO_OF_PRJ;
 }

if (IND_GRP_LONG_DESC.equals("MINERAL BASED INDUSTRY")) {
 MINERAL_BASED_INDUSTRY=NO_OF_PRJ;
 }
 
if (IND_GRP_LONG_DESC.equals("COIR BOARD BASED INDUSTRY")) {
 COIR_BOARD_BASED_INDUSTRY=NO_OF_PRJ;
 }
 
 if (IND_GRP_LONG_DESC.equals("SERVICE AND TEXTILE INDUSTRY")) {
 SERVICE_AND_TEXTILE_INDUSTRY=NO_OF_PRJ;
 }
 
 if (IND_GRP_LONG_DESC.equals("RURAL ENGG. AND BIO-TECH INDUSTRY")) {
 RURAL_ENGG_AND_BIO_TECH_INDUSTRY=NO_OF_PRJ;
 } 
}//END IF....
	rsCat.close();	

%>						
	

					
						
                        <DIV class="col-xl-12 col-lg-5">
                            <DIV class="card shadow mb-4 border-bottom-dark">
                                <!-- Card Header - Dropdown -->
                                <DIV
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between border-bottom-dark">
                                    <H6 class="m-0 font-weight-bold text-primary">Industrywise Disbursement</H6>
                                 
                                </DIV>
                                <!-- Card Body -->
                                <DIV class="card-body">
                                    <DIV class="chart-pie pt-4 pb-2">
                                        <canvas id="myPieChart2"></canvas>
                                    </DIV>
                                    <DIV class="mt-4 text-center small">
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-primary"></I> Para 1                                       </SPAN>
                                     
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Para 2                                        </SPAN>    
										<SPAN class="mr-2">
                                            <I class="fas fa-circle text-primary"></I> Para 1                                       </SPAN>
                                     
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Para 2                                        </SPAN>     
										<SPAN class="mr-2">
                                            <I class="fas fa-circle text-primary"></I> Para 1                                       </SPAN>
                                     
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Para 2                                        </SPAN>    
										<SPAN class="mr-2">
                                            <I class="fas fa-circle text-primary"></I> Para 1                                       </SPAN>
                                     
                                        <SPAN class="mr-2">
                                            <I class="fas fa-circle text-info"></I> Para 2                                        </SPAN> 	
												 
                                    </DIV>
                                </DIV>
                            </DIV>
                        </DIV>               
                        
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
                        <SPAN>Copyright &copy; KVIC 2021</SPAN>                    </DIV>
                </DIV>
            </footer>
            <!-- End of Footer -->
        </DIV>
        <!-- End of Content Wrapper -->
    </DIV>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <A class="scroll-to-top rounded" href="#page-top">
        <I class="fas fa-angle-up"></I>    </A>



    <!-- Bootstrap core JavaScript-->
    <SCRIPT src="vendor/jquery/jquery.min.js"></SCRIPT>
    <SCRIPT src="vendor/bootstrap/js/bootstrap.bundle.min.js"></SCRIPT>

    <!-- Core plugin JavaScript-->
    <SCRIPT src="vendor/jquery-easing/jquery.easing.min.js"></SCRIPT>

    <!-- Custom scripts for all pages-->
    <SCRIPT src="js/sb-admin-2.min.js"></SCRIPT>

    <!-- Page level plugins -->
    <SCRIPT src="vendor/chart.js/Chart.min.js"></SCRIPT>

    <!-- Page level custom scripts -->
    <SCRIPT src="js/demo/chart-area-demo.js"></SCRIPT>
  
    <SCRIPT src="js/demo/chart-bar-demo.js"></SCRIPT>
	
	
	  <SCRIPT type="text/javascript">
  
  Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';
// Pie Chart Example
var ctx2 = document.getElementById("myPieChart2");
var myPieChart2 = new Chart(ctx2, {
  type: 'pie',
  data: {
    labels: ["FOREST_BASED_INDUSTRY", "POLYMER_AND_CHEMICAL_BASED_INDUSTRY", "AGRO_BASED_FOOD_PROCESSING_INDUSTRY", "HAND_MADE_PAPER_AND_FIBRE_INDUSTRY", "MINERAL_BASED_INDUSTRY", "COIR_BOARD_BASED_INDUSTRY", "SERVICE_AND_TEXTILE_INDUSTRY", "RURAL_ENGG_AND_BIO_TECH_INDUSTRY"],
    datasets: [{
      data: [<%= FOREST_BASED_INDUSTRY %>,<%= POLYMER_AND_CHEMICAL_BASED_INDUSTRY %>,<%= AGRO_BASED_FOOD_PROCESSING_INDUSTRY %>,<%= HAND_MADE_PAPER_AND_FIBRE_INDUSTRY %>,<%= MINERAL_BASED_INDUSTRY %>,<%= COIR_BOARD_BASED_INDUSTRY %>,<%= SERVICE_AND_TEXTILE_INDUSTRY %>,<%= RURAL_ENGG_AND_BIO_TECH_INDUSTRY %>],
      backgroundColor: ['#9400D3', '#4B0082', '#0000FF','#00FF00','#FFFF00','#FF7F00','#FF0000','#ff9100'],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf','#cf9904','#a704b0','#d91122','#d1cd08','#cf7500'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});
		
		
		
		
var ctx3 = document.getElementById("myPieChart3");
var myPieChart3 = new Chart(ctx3, {
  type: 'pie',
  data: {
    labels: ["MN", "GEN", "SC", "OBC", "ST"],
    datasets: [{
      data: [<%= MN %>,<%= GEN %>,<%= SC %>,<%= OBC %>,<%= ST %>],
      backgroundColor: ['#9400D3', '#4B0082', '#0000FF','#00FF00','#FFFF00'],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf','#cf9904','#a704b0'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});
	
	
	
	
	
// Pie Chart Example
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: ["Target Achieved", "Pending"],
    datasets: [{
      data: [65,30],
      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});



// Bar Chart Example -------------Margin Money (Govt. Subsidy) Disbursed (2020-21)
var ctx = document.getElementById("myBarChart");
var myBarChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ["2016-17", "2017-18", "2018-19", "2019-20", "2020-21"],
    datasets: [{
      label: "Revenue",
      backgroundColor: "#4e73df",
      hoverBackgroundColor: "#2e59d9",
      borderColor: "#4e73df",
      data: [4215, 5312, 6251, 7841, 9821, 14984],
    }],
  },
  options: {
    maintainAspectRatio: false,
    layout: {
      padding: {
        left: 10,
        right: 25,
        top: 25,
        bottom: 0
      }
    },
    scales: {
      xAxes: [{
        time: {
          unit: 'month'
        },
        gridLines: {
          display: false,
          drawBorder: false
        },
        ticks: {
          maxTicksLimit: 6
        },
        maxBarThickness: 25,
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: 15000,
          maxTicksLimit: 5,
          padding: 10,
          // Include a dollar sign in the ticks
          callback: function(value, index, values) {
            return 'Rs.' + number_format(value);
          }
        },
        gridLines: {
          color: "rgb(0, 0, 0)",
          zeroLineColor: "rgb(234, 236, 244)",
          drawBorder: false,
          borderDash: [2],
          zeroLineBorderDash: [2]
        }
      }],
    },
    legend: {
      display: false
    },
    tooltips: {
      titleMarginBottom: 10,
      titleFontColor: '#6e707e',
      titleFontSize: 14,
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
      callbacks: {
        label: function(tooltipItem, chart) {
          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
          return datasetLabel + ': $' + number_format(tooltipItem.yLabel);
        }
      }
    },
  }
});

								
						
  </SCRIPT>	
  
	
	<%
db.close();
%>

</BODY>
</HTML>