<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>

<LINK rel="stylesheet" type="text/css" href="css/pmegpTable.css">
<SCRIPT language="javascript" src="../js/sweetalert.min.js"></SCRIPT>


<SCRIPT language="javascript">

/*function chMd()
 {	
	var actid=document.form.MM_ADJUSTMENT_STATUS.value;

     if( actid == "FA")
     {
		document.forms[0].MM_ADJUSTMENT_AMT_S.style.backgroundColor="#FFFFFF";
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=false;
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=document.form.MM_REL_AMT.value;
                  
     }
     else if( actid == "PA")
     {
	 
	 var ce=document.form.MM_REL_AMT.value;	
		
	 var tcewe=Number(ce)/2;
	
      
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=false;
       
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=0
         document.forms[0].MM_ADJUSTMENT_AMT_S.style.backgroundColor="#FFFFFF";
        
      
     }
	   else if( actid == "FD")
     {      
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=true;
       
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=0
              
      document.forms[0].MM_ADJUSTMENT_AMT_S.style.backgroundColor="#A0A0A0";
     }
       
	    else if( actid == "RU")
     {      
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=true;
       
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=''
              
      document.forms[0].MM_ADJUSTMENT_AMT_S.style.backgroundColor="#A0A0A0";
     }
       

	
	
	}
*/

function form_submit(){



var MM_ADJUSTMENT_STATUS = document.form.MM_ADJUSTMENT_STATUS.value;
  //  var MM_ADJUSTMENT_AMT_S = document.form.MM_ADJUSTMENT_AMT_S.value;
    var NODAL_OFFICER_REMARK = document.form.NODAL_OFFICER_REMARK.value;
	//var MM_REL_AMT  = document.form.MM_REL_AMT.value;
//var MAX_AMT  = document.form.MAX_AMT.value;
if(MM_ADJUSTMENT_STATUS==""){
 swal ( 'Note:','Select MM Adjustemnt Status','error');	
 return (false);
}
/*
if(MM_ADJUSTMENT_AMT_S==""){
 swal ( 'Note:','Enter MM Adjustemnt Amount','error');	
 return (false);
}*/
if(NODAL_OFFICER_REMARK==""){
 swal ( 'Note:','Enter Nodal Officer Remarksn','error');	
 return (false);
}
/*
if ( MM_ADJUSTMENT_STATUS == "FA") {
if (MM_ADJUSTMENT_AMT_S != MM_REL_AMT) {
 swal ( 'Note:','Enter Correct MM Adjustemnt Amount','error');	
 return (false);
}
}
if ( MM_ADJUSTMENT_STATUS == "PA") {

if (Number(MM_ADJUSTMENT_AMT_S) > Number(MAX_AMT)) {
//alert(MM_REL_AMT);
 swal ( 'Note:','Enter Correct MM Adjustemnt Amount i.e '+MAX_AMT,'error');	
 return (false);
}
}*/

document.form.ins.value='I';
document.form.submit();


}

function closeAndRefresh(){
       window.parent.refresh_da();
    }


</SCRIPT></HEAD>
<BODY onLoad="chMd()";>
<form   name="form" id ="form" method="post" >
<%	

DBCon db= new DBCon();
db.connect();
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
//String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
//String  PMEGPGEOTAGID =request.getParameter("PMEGPGEOTAGID")==null?"":(String)request.getParameter("PMEGPGEOTAGID");
String  APP_ID =(String) session.getAttribute("SAPP_ID");
String  PMEGPGEOTAGID =(String) session.getAttribute("SPGID");
String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");

String MARGIN_MONEY_ADJUSTMENT_AMOUNT="";
String MM_REL_AMT="";
String CO_REMARKS="";
String VERIFICATION_STATUS="";
String VERIFIER_REMARKS="";

String NODAL_OFFICER_REMARK="";
String MM_ADJUSTMENT_AMT_S="";
String PHYSICAL_VERIFICATION_STATUS="";
String MM_ADJUSTMENT_STATUS="";
String CALLBACK_AMOUNT="";
  String DATE_OF_VERIFICATION="";
  String VERIFICATION_BY="";
  String TOT_PRJ="";

  String PER_CAPITA_INVESTMENT_NORM_SAT="";
  
  String UNIT_ESTABLISHMENT_DATE="";
  String UNIT_SETUP_ON="";
  String UNIT_NAME="";
  String CAPITAL_COST_OF_BUILDING="";
  String CAPITAL_COST_OF_MACHINERY="";
  String CALLBACK_REASON="";
  String MACHINARY_COST="";
  String WORKING_CAPITAL="";
String ACT_ID="";
String REMTRID="";
String TOT_PRJ_PROP="";
String pending_loan_amount="";
String PEN_LOAN="";
String MAX_AMT="";
String DIS_AMT="";
String LOAN_SANC_DT="";
String TOTAL_EMPLOYEES="";
String ANNUAL_PRODUCTION_VALUE="";
String LONGITUDE="";
 String MM_ADJ_YN="";
 String MM_LOAN_DT="";
String LATITUDE="";
String EDP_CERT_DT="";
String PERCAPITAEMPREQ="";
String PERCAPITAEMPCAL="";
String CE_SANC_FB="";
String WC_SANC_FB="";
StringBuffer qrysb= new StringBuffer();
	
qrysb.append("   "      );
qrysb.append("    SELECT GT.PMEGPGEOTAGID,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN, GT.REMTRID,GEOPERCAPITA(BD.APP_ID,GT.PMEGPGEOTAGID) AS ACT_EMP,GEOALLOWAMT(GT.PMEGPGEOTAGID) AS MAX_AMT,NVL(BD.MM_REL_AMT,0)-GEOALLOWAMT(GT.PMEGPGEOTAGID) AS DIS_AMT,"      );
qrysb.append("     AD.APP_ID, GT.VERIFICATION_STATUS,GT.VERIFIER_REMARKS ,  AD.APP_NAME,NVL(BD.WORKING_CAPITAL,0) AS WORKING_CAPITAL,NVL(BD.MACHINARY_COST,0) AS ");
qrysb.append(" MACHINARY_COST,NVL(BD.WC_SANC_FB,0)+NVL(BD.CE_SANC_FB,0)AS TOT_PRJ,NVL(BD.MACHINARY_COST,0)+NVL(BD.WORKING_CAPITAL,0)AS TOT_PRJ_PROP, "      );

qrysb.append(" BD.MM_REL_AMT, GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT,NVL(BD.WC_SANC_FB,0) AS WC_SANC_FB,NVL(BD.CE_SANC_FB,0) AS CE_SANC_FB ,GT.NODAL_OFFICER_REMARK,GT.ACT_ID,(NVL(BD.WC_SANC_FB,0)+NVL(BD.CE_SANC_FB,0)-NVL(GT.pending_loan_amount,0)) as PEN_LOAN,"      );
 qrysb.append(" GT.MM_ADJUSTMENT_AMT_S, GT.PHYSICAL_VERIFICATION_STATUS, GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("  GT.CALLBACK_AMOUNT,CASE WHEN MS.STATE_CD='AN' THEN 450000 WHEN MS.STATE_CD IN ( 'AR','AS','MN','MG','SK','TR','NG','MZ') OR AD.BENF_SPECAT_CD='HA' THEN 150000 ELSE 100000 END AS PERCAPITAEMPREQ, "      );
qrysb.append("   TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,GR.CO_REMARKS, "      );
qrysb.append("   GT.VERIFICATION_BY, "      );
qrysb.append("   GT.VERIFICATION_STATUS, "      );
qrysb.append("   GT.VERIFIER_REMARKS,NVL(GT.pending_loan_amount,0) AS pending_loan_amount,"      );
qrysb.append("   GT.PER_CAPITA_INVESTMENT_NORM_SAT, NVL(BD.WORKSHED_COST,0)+NVL(BD.MACHINARY_COST,0)+NVL(BD.PRE_OPE_COST,0) AS PROJ_CE, "      );
qrysb.append("   GT.TOTAL_EMPLOYEES, NVL(BD.WORKSHED_COST,0)+NVL(BD.WORKING_CAPITAL,0)+ NVL(BD.MACHINARY_COST,0)+NVL(BD.PRE_OPE_COST,0) AS PROJ_COST, "      );
qrysb.append("   TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,TO_CHAR(BD.LOAN_SANC_DT,'DD-MON-RRRR') AS LOAN_SANC_DT,"      );
qrysb.append("   GT.UNIT_SETUP_ON, "      );
qrysb.append("   GT.UNIT_NAME,GT.LATITUDE,GT.LONGITUDE,TO_CHAR(BD.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT, "      );
qrysb.append("   GT.CAPITAL_COST_OF_BUILDING,GT.ANNUAL_PRODUCTION_VALUE, "      );
qrysb.append("   GT.CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("  GT.CALLBACK_REASON "      );
qrysb.append("      FROM APP_DETAIL AD,"      );
qrysb.append("        BANK_DATAENTRY BD,"      );
qrysb.append("        MAS_OFF_MAST MOM,"      );
qrysb.append("        M_DISTRICT MD,"      );
qrysb.append("        M_STATE MS,"      );
qrysb.append("        ACTIVITY_MAST AM,"      );
qrysb.append("        GEOTAG_TRANS GT,"      );
qrysb.append("        RBIBANKLIST RBL,"      );
qrysb.append("        IND_GRP_MAST IGM,GEOTAG_REMARKS GR"      );
qrysb.append("    WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("      AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("      AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("      AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("      AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("      AND AD.IFSC_CODE    = RBL.IFSC_CODE AND GT.REMTRID=GR.REMTRID(+) "      );

qrysb.append("  AND AD.APP_ID       = GT.APP_ID AND AM.IND_GRP_CD   = IGM.IND_GRP_CD AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?     "      );

qrysb.append(" UNION  ");

qrysb.append("    SELECT GT.PMEGPGEOTAGID,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N0' ELSE 'YES' END AS MM_ADJ_YN, GT.REMTRID,GEOPERCAPITA(BD.APP_ID,GT.PMEGPGEOTAGID) AS ACT_EMP,GEOALLOWAMT(GT.PMEGPGEOTAGID) AS MAX_AMT,NVL(BD.MM_REL_AMT,0)-GEOALLOWAMT(GT.PMEGPGEOTAGID) AS DIS_AMT,"      );
qrysb.append("     AD.APP_ID, GT.VERIFICATION_STATUS,GT.VERIFIER_REMARKS ,  AD.APP_NAME,NVL(BD.WORKING_CAPITAL,0) AS WORKING_CAPITAL,NVL(BD.MACHINARY_COST,0) AS ");
qrysb.append(" MACHINARY_COST,NVL(BD.WC_SANC_FB,0)+NVL(BD.CE_SANC_FB,0)AS TOT_PRJ,NVL(BD.MACHINARY_COST,0)+NVL(BD.WORKING_CAPITAL,0)AS TOT_PRJ_PROP, "      );

qrysb.append(" BD.MM_REL_AMT, GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT,NVL(BD.WC_SANC_FB,0) AS WC_SANC_FB,NVL(BD.CE_SANC_FB,0) AS CE_SANC_FB ,GT.NODAL_OFFICER_REMARK,GT.ACT_ID,(NVL(BD.WC_SANC_FB,0)+NVL(BD.CE_SANC_FB,0)-NVL(GT.pending_loan_amount,0)) as PEN_LOAN,"      );
 qrysb.append(" GT.MM_ADJUSTMENT_AMT_S, GT.PHYSICAL_VERIFICATION_STATUS, GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("  GT.CALLBACK_AMOUNT,CASE WHEN MS.STATE_CD='AN' THEN 450000 WHEN MS.STATE_CD IN ( 'AR','AS','MN','MG','SK','TR','NG','MZ') OR AD.BENF_SPECAT_CD='HA' THEN 150000 ELSE 100000 END AS PERCAPITAEMPREQ, "      );
qrysb.append("   TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION,GR.CO_REMARKS, "      );
qrysb.append("   GT.VERIFICATION_BY, "      );
qrysb.append("   GT.VERIFICATION_STATUS, "      );
qrysb.append("   GT.VERIFIER_REMARKS,NVL(GT.pending_loan_amount,0) AS pending_loan_amount,"      );
qrysb.append("   GT.PER_CAPITA_INVESTMENT_NORM_SAT, NVL(BD.WORKSHED_COST,0)+NVL(BD.MACHINARY_COST,0)+NVL(BD.PRE_OPE_COST,0) AS PROJ_CE, "      );
qrysb.append("   GT.TOTAL_EMPLOYEES, NVL(BD.WORKSHED_COST,0)+NVL(BD.WORKING_CAPITAL,0)+ NVL(BD.MACHINARY_COST,0)+NVL(BD.PRE_OPE_COST,0) AS PROJ_COST, "      );
qrysb.append("   TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,TO_CHAR(BD.LOAN_SANC_DT,'DD-MON-RRRR') AS LOAN_SANC_DT,"      );
qrysb.append("   GT.UNIT_SETUP_ON, "      );
qrysb.append("   GT.UNIT_NAME,GT.LATITUDE,GT.LONGITUDE,TO_CHAR(BD.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT, "      );
qrysb.append("   GT.CAPITAL_COST_OF_BUILDING,GT.ANNUAL_PRODUCTION_VALUE, "      );
qrysb.append("   GT.CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("  GT.CALLBACK_REASON "      );
qrysb.append("      FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("        BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("        MAS_OFF_MAST MOM,"      );
qrysb.append("        M_DISTRICT MD,"      );
qrysb.append("        M_STATE MS,"      );
qrysb.append("        ACTIVITY_MAST AM,"      );
qrysb.append("        GEOTAG_TRANS GT,"      );
qrysb.append("        RBIBANKLIST RBL,"      );
qrysb.append("        IND_GRP_MAST IGM,GEOTAG_REMARKS GR"      );
qrysb.append("    WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("      AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("      AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("      AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("      AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("      AND AD.IFSC_CODE    = RBL.IFSC_CODE AND GT.REMTRID=GR.REMTRID(+) "      );

qrysb.append(" AND AD.APP_ID       = GT.APP_ID AND AM.IND_GRP_CD   = IGM.IND_GRP_CD AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?     "      );



List values=new ArrayList();

values.add(APP_ID);
values.add(PMEGPGEOTAGID);
values.add(APP_ID);
values.add(PMEGPGEOTAGID);



   ResultSet rs = db.executeSQL(qrysb.toString(),values);
   values.clear();




	while (rs.next()){
	
	CO_REMARKS=rs.getString("CO_REMARKS")==null?"":rs.getString("CO_REMARKS");
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");	
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	PMEGPGEOTAGID=rs.getString("PMEGPGEOTAGID")==null?"":rs.getString("PMEGPGEOTAGID");
	MARGIN_MONEY_ADJUSTMENT_AMOUNT=rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT")==null?"":rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	NODAL_OFFICER_REMARK=rs.getString("NODAL_OFFICER_REMARK")==null?"":rs.getString("NODAL_OFFICER_REMARK");
	MM_ADJUSTMENT_AMT_S=rs.getString("MM_ADJUSTMENT_AMT_S")==null?"":rs.getString("MM_ADJUSTMENT_AMT_S");
	PHYSICAL_VERIFICATION_STATUS=rs.getString("PHYSICAL_VERIFICATION_STATUS")==null?"":rs.getString("PHYSICAL_VERIFICATION_STATUS");
	MM_ADJUSTMENT_STATUS=rs.getString("MM_ADJUSTMENT_STATUS")==null?"":rs.getString("MM_ADJUSTMENT_STATUS");
	MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
	VERIFICATION_STATUS=rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
	VERIFIER_REMARKS=rs.getString("VERIFIER_REMARKS")==null?"":rs.getString("VERIFIER_REMARKS");
	 CALLBACK_AMOUNT=rs.getString("CALLBACK_AMOUNT")==null?"":rs.getString("CALLBACK_AMOUNT");
  DATE_OF_VERIFICATION=rs.getString("DATE_OF_VERIFICATION")==null?"":rs.getString("DATE_OF_VERIFICATION");
  VERIFICATION_BY=rs.getString("VERIFICATION_BY")==null?"":rs.getString("VERIFICATION_BY");
  VERIFICATION_STATUS=rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
  TOT_PRJ=rs.getString("TOT_PRJ")==null?"":rs.getString("TOT_PRJ");
  PER_CAPITA_INVESTMENT_NORM_SAT=rs.getString("PER_CAPITA_INVESTMENT_NORM_SAT")==null?"":rs.getString("PER_CAPITA_INVESTMENT_NORM_SAT");
  TOTAL_EMPLOYEES=rs.getString("TOTAL_EMPLOYEES")==null?"":rs.getString("TOTAL_EMPLOYEES");
  UNIT_ESTABLISHMENT_DATE=rs.getString("UNIT_ESTABLISHMENT_DATE")==null?"":rs.getString("UNIT_ESTABLISHMENT_DATE");
  UNIT_SETUP_ON=rs.getString("UNIT_SETUP_ON")==null?"":rs.getString("UNIT_SETUP_ON");
  UNIT_NAME=rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
  CAPITAL_COST_OF_BUILDING=rs.getString("CAPITAL_COST_OF_BUILDING")==null?"":rs.getString("CAPITAL_COST_OF_BUILDING");
  CAPITAL_COST_OF_MACHINERY=rs.getString("CAPITAL_COST_OF_MACHINERY")==null?"":rs.getString("CAPITAL_COST_OF_MACHINERY");
  CALLBACK_REASON=rs.getString("CALLBACK_REASON")==null?"":rs.getString("CALLBACK_REASON");
  MACHINARY_COST=rs.getString("MACHINARY_COST")==null?"":rs.getString("MACHINARY_COST");
  WORKING_CAPITAL=rs.getString("WORKING_CAPITAL")==null?"":rs.getString("WORKING_CAPITAL");
REMTRID	=rs.getString("REMTRID")==null?"":rs.getString("REMTRID");
TOT_PRJ_PROP=rs.getString("TOT_PRJ_PROP")==null?"":rs.getString("TOT_PRJ_PROP");
pending_loan_amount=rs.getString("pending_loan_amount")==null?"":rs.getString("pending_loan_amount");
PEN_LOAN=rs.getString("PEN_LOAN")==null?"":rs.getString("PEN_LOAN");
MAX_AMT=rs.getString("MAX_AMT")==null?"":rs.getString("MAX_AMT");
DIS_AMT=rs.getString("DIS_AMT")==null?"":rs.getString("DIS_AMT");
LOAN_SANC_DT=rs.getString("LOAN_SANC_DT")==null?"":rs.getString("LOAN_SANC_DT");
ANNUAL_PRODUCTION_VALUE=rs.getString("ANNUAL_PRODUCTION_VALUE")==null?"":rs.getString("ANNUAL_PRODUCTION_VALUE");
LONGITUDE=rs.getString("LONGITUDE")==null?"":rs.getString("LONGITUDE");
LATITUDE=rs.getString("LATITUDE")==null?"":rs.getString("LATITUDE");
EDP_CERT_DT=rs.getString("EDP_CERT_DT")==null?"":rs.getString("EDP_CERT_DT");
PERCAPITAEMPREQ=rs.getString("PERCAPITAEMPREQ")==null?"":rs.getString("PERCAPITAEMPREQ");
PERCAPITAEMPCAL=rs.getString("ACT_EMP")==null?"":rs.getString("ACT_EMP");
CE_SANC_FB=rs.getString("CE_SANC_FB")==null?"":rs.getString("CE_SANC_FB");
WC_SANC_FB=rs.getString("WC_SANC_FB")==null?"":rs.getString("WC_SANC_FB");
  MM_ADJ_YN=rs.getString("MM_ADJ_YN")==null?"":rs.getString("MM_ADJ_YN");
  MM_LOAN_DT=rs.getString("MM_LOAN_DT")==null?"":rs.getString("MM_LOAN_DT");
		}
	  rs.close();

if (ACT_ID.equals("2")){
StringBuffer sv= new StringBuffer();
sv.append("INSERT INTO GEOTAG_TRANS_REFFER(    ");
sv.append("SELECT * FROM GEOTAG_TRANS WHERE APP_ID='"+APP_ID+"' AND PMEGPGEOTAGID='"+PMEGPGEOTAGID+"' AND REMTRID='"+REMTRID+"'   ");
sv.append("AND ACT_ID=2 AND PMEGPGEOTAGID NOT IN ( ");
sv.append("SELECT PMEGPGEOTAGID FROM GEOTAG_TRANS_REFFER WHERE APP_ID='"+APP_ID+"'  AND PMEGPGEOTAGID='"+PMEGPGEOTAGID+"' AND REMTRID ='"+REMTRID+"'   ");
sv.append("AND ACT_ID=2))  ");
ResultSet rsReff = db.executeSQL(sv.toString(),values);


}
String verror="";

%>
<FORM name="form" id="form"  class="form" method="post" >

  <TABLE align="center" style="z-index:auto;">

  <TR>
    <TH colspan="9"> 
      <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
      Margin Money Adjustment Update Form
      <DIV align="center"></DIV></TH>
  </TR>
  <TR>
    <TD colspan="2" ><STRONG>Geo Tagging Id:</STRONG> <%= PMEGPGEOTAGID %> </TD>
    <TD colspan="2" ><DIV align="left">
      <INPUT name="ins" type="hidden" id="ins">
      <STRONG>Applicant Id</span> :</STRONG> <%=APP_ID %></DIV></TD>
    <TD colspan="5" ><STRONG>Beneficiary Name  :</STRONG> <%=  APP_NAME %></TD>
    </TR>
  
  
	<TR >
	  <TH colspan="9" ><DIV align="center">Verification Details </DIV></TH>
    </TR>
	<TR >
	  <TD colspan="2"  ><DIV align="left"><STRONG>Date of Verification: </STRONG></DIV></TD>
	  <TD  ><%= DATE_OF_VERIFICATION %></TD>
      <TD  ><STRONG>Verification By:</STRONG></TD>
      <TD  ><%= VERIFICATION_BY %></TD>
	  <TD colspan="3"  ><STRONG>Physical Verification Status: </STRONG></TD>
	  <TD  ><%= VERIFICATION_STATUS %></TD>
	</TR>
	<TR >
	  <TD colspan="2"  ><DIV align="left"><STRONG>PV Remarks: </STRONG></DIV></TD>
	  <TD  ><%= VERIFIER_REMARKS %></TD>
      <TD  ><STRONG>Annual Production  : </STRONG></TD>
      <TD  ><%= ANNUAL_PRODUCTION_VALUE %></TD>
	  <TD colspan="3"  ><STRONG>Total Employees As Per PV:</STRONG></TD>
	  <TD  ><%= TOTAL_EMPLOYEES %></TD>
	</TR>
<TR >
	  <TD colspan="2"  ><DIV align="left"><STRONG>Latitude: </STRONG></DIV></TD>
	  <TD  ><%= LATITUDE %></TD>
      <TD  ><STRONG>Longitude  : </STRONG></TD>
      <TD  ><%= LONGITUDE %></TD>
	  <TD colspan="3"  ><STRONG>Employement Requirement: </STRONG></TD>
	  <TD  ><%=PERCAPITAEMPCAL%></TD>
	</TR>
<!--PERCAPITAEMPREQ-->
	
	<TR >
	  <TH colspan="9" ><DIV align="center"><STRONG>Unit Description </STRONG></DIV></TH>
    </TR>
	
	<TR >
	  <TD colspan="2" ><DIV align="left"><STRONG>Unit Name: </STRONG></DIV></TD>
	  <TD ><%= UNIT_NAME %></TD>
	  <TD ><STRONG>Unit Establishment Date </STRONG></TD>
	  <TD ><%= UNIT_ESTABLISHMENT_DATE %></TD>
      <TD ><STRONG>Unit Set Up On: </STRONG></TD>
      <TD ><%= UNIT_SETUP_ON %></TD>
      <TD ><STRONG>Edp Cert Date:</STRONG> </TD>
      <TD ><%=EDP_CERT_DT%></TD>
	</TR>
	
	<!--<TR >
	  <TH colspan="2" >Capital Cost Of Biulding : </TH>
	  <TD ><%= CAPITAL_COST_OF_BUILDING %></TD>
	  <TH >Capital Cost Of Machinery: </TH>
	  <TD ><%= CAPITAL_COST_OF_MACHINERY %></TD>
      <TH >Working Capital </TH>
      <TD ><%= WORKING_CAPITAL %></TD>
	</TR>-->
	<TR >
	  <TD colspan="2" ><DIV align="left"><STRONG>Loan Sanction (CE+WC) </STRONG></DIV></TD>
	  <TD ><%= TOT_PRJ %>(<%=CE_SANC_FB%>+<%=WC_SANC_FB%>)</TD>
	  <TD ><STRONG>Balance Loan: </STRONG></TD>
	  <TD ><%=pending_loan_amount%></TD>
	  <TD colspan="3" ><STRONG>Loan Sanction Date: </STRONG></TD>
	  <TD ><%=LOAN_SANC_DT%></TD>
    </TR>
	 
	
        <INPUT name="MM_REL_AMT" type="hidden" id="MM_REL_AMT"  size="10" maxlength="7"  value="<%= MM_REL_AMT %>" >
		 <INPUT name="MAX_AMT" type="hidden" id="MAX_AMT"  size="10" maxlength="7"  value="<%= MAX_AMT %>" >
		 <INPUT name="DIS_AMT" type="hidden" id="DIS_AMT"  size="10" maxlength="7"  value="<%= DIS_AMT %>" >
	<%
	
	String validateqry="SELECT * FROM TABLE(GEOPHYSICAL_ERROR(?,?))";

    values.add(APP_ID);
values.add(PMEGPGEOTAGID);




  ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;

while (rsValidate.next()){
errcount =errcount+1;
verror=verror+""+rsValidate.getString(2)+"<br>";
//sout.print (verror);
}
rsValidate.close();
			
	
	%>
	
    <!--<TR >
	  <TH colspan="2" >CallBack Reason: </TH>
	  <TD ><%= CALLBACK_REASON %></TD>
      <TH >CallBack Amount: </TH>
      <TD colspan="3" ><%= CALLBACK_AMOUNT %></TD>
	</TR>-->
    <TR >
      <TH colspan="9" >* Margin Money eligible (<%= MAX_AMT%>) =MM Release(<%= MM_REL_AMT %>)-(MM Released(<%= MM_REL_AMT %>) / Sanctioned Loan ( <%= TOT_PRJ %>) * Balance Loan(<%=pending_loan_amount%>))</TH>
	  </TR>
	  
	 <TR>
	  <TD colspan="2" ><DIV align="left"><STRONG>MM Released: </STRONG></DIV></TD>
	  <TD ><%= MM_REL_AMT %></TD>
      <TD ><STRONG> MM Eligible* : </STRONG></TD>
      <TD > <SPAN class="GreenLebel"><%= MAX_AMT%></SPAN></TD>
      <TD colspan="3" ><STRONG>Call Back Amount: </STRONG></TD>
	  <TD > <SPAN class="redLebel"><%= DIS_AMT%></SPAN></TD>
	</TR>
	 <% if (!verror.equals("")) {%>
	 <TR >
    <TH colspan="9" ><H3 align="CENTER"><STRONG>System Validation Report</STRONG></H3></TH>
    </TR>
	<TR>
	 <TD colspan="9"  > <SPAN class="redLebel"><STRONG><%out.print (verror);%> </STRONG></SPAN></TD>
	 </TR>
	 <%}%>
    <TR >
    <TH colspan="9" ><H3 align="CENTER"><STRONG>Recommendation of District Nodal Officer</STRONG></H3></TH>
    </TR>
	<% if (MM_ADJ_YN.equals("N")){%>
	<TR >
    <TD colspan="9" > <SPAN class="redLebel"><H3 align="CENTER"><STRONG>Date of Completion of 3 Yrs is <%=MM_LOAN_DT%></STRONG></H3></SPAN></TD>
    </TR>
	<%}%>
  <TR >
    <TD colspan="3"><DIV align="left"><STRONG>MM Adjustment Status </STRONG>*</DIV></TD>
	 <TD colspan="2">
	  <STRONG>
	  <% if (MM_ADJ_YN.equals("N")){%>
	  <INPUT type="radio" id="opt-1" value="RM"   name="MM_ADJUSTMENT_STATUS" disabled>
	   <SPAN class="GreenLebel">Recommended For MM Adjustment (Rs. <%=MAX_AMT%>)</SPAN>	 
	   <%} else{%>
	    <INPUT type="radio" id="opt-1" value="RM"   name="MM_ADJUSTMENT_STATUS" <% if (MM_ADJUSTMENT_STATUS.equals("RM")){out.print("checked");}%>>
	   <SPAN class="GreenLebel">Recommended For MM Adjustment (Rs. <%=MAX_AMT%>)</SPAN>	 
	   <%}%>
	    </STRONG> </TD>
     <TD  colspan="4">
	  <STRONG>
	  <INPUT type="radio" id="opt-1" value="RU"   name="MM_ADJUSTMENT_STATUS" <% if (MM_ADJUSTMENT_STATUS.equals("RU")){out.print("checked");}%>>
	 <SPAN class="MarunLebel">Recommended For Reverification</SPAN></STRONG></TD>

	</TR>


  <TR >
    <!--<TD colspan="2" ><div align="left"><strong>MM Adjustemnt Amount </strong></div></TD>
    <TD ><DIV align="left"><INPUT name="MM_ADJUSTMENT_AMT_S" type="text" id="MM_ADJUSTMENT_AMT_S" value="<%= MM_ADJUSTMENT_AMT_S %>" size="10" maxlength="6"></DIV></TD>-->
    <TD colspan="3"><STRONG>Nodal Officer Remarks*</STRONG></TD>
    <TD colspan="6" ><textarea name="NODAL_OFFICER_REMARK" cols="40" rows="3" class="mtextarea" maxlength="500" id="NODAL_OFFICER_REMARK"></textarea>
	</TD>
    </TR>
  <% if (ACT_ID.equals("2")){%>  <TR>
	 <TD colspan="2" > <DIV align="left"><STRONG>Approver Remarks
	   </STRONG></DIV>
	 <TD colspan="7" ><%=CO_REMARKS%>	</TR>
	<%}%>
  <TR>
    <TD colspan="9"> 
        <DIV align="center">
		 <INPUT name="Button" type="button" class="button" onClick="form_submit()" value="Forward to Approver">

         
          <INPUT name="Button" type="button" class="button" value="Cancel" onClick="closeAndRefresh();">          
      </DIV></TD>
  </TR>
</TABLE>





    <% if (ins.equals("I")){

NODAL_OFFICER_REMARK=(String) request.getParameter("NODAL_OFFICER_REMARK")==null?"":(String) request.getParameter("NODAL_OFFICER_REMARK").trim();
MM_ADJUSTMENT_AMT_S=(String) request.getParameter("MAX_AMT")==null?"":(String) request.getParameter("MAX_AMT").trim();
PHYSICAL_VERIFICATION_STATUS=(String) request.getParameter("PHYSICAL_VERIFICATION_STATUS")==null?"":(String) request.getParameter("PHYSICAL_VERIFICATION_STATUS").trim();
MM_ADJUSTMENT_STATUS=(String) request.getParameter("MM_ADJUSTMENT_STATUS")==null?"":(String) request.getParameter("MM_ADJUSTMENT_STATUS").trim();
DIS_AMT=(String) request.getParameter("DIS_AMT")==null?"":(String) request.getParameter("DIS_AMT").trim();

if (MM_ADJUSTMENT_STATUS.equals("RU")){
MM_ADJUSTMENT_AMT_S="0";
}
else{
MM_ADJUSTMENT_AMT_S=MM_ADJUSTMENT_AMT_S;
}


 StringBuffer qryUpdate = new StringBuffer();
 
qryUpdate.append("UPDATE GEOTAG_TRANS SET  ");
qryUpdate.append("NODAL_OFFICER_REMARK=?,");
qryUpdate.append("MM_ADJUSTMENT_AMT_S=?,");
qryUpdate.append("MM_ADJUSTMENT_STATUS=?,ACT_ID=NULL,REMTRID=null,MM_ADJ_DATE=SYSDATE,LAST_UPDATE_DT=SYSDATE,AGN_CALLBACK=? ");
qryUpdate.append("WHERE APP_ID=? AND PMEGPGEOTAGID=?");

//List values=new ArrayList();
List pstm=new ArrayList();



values.add(NODAL_OFFICER_REMARK); pstm.add ("L");
values.add(MM_ADJUSTMENT_AMT_S); pstm.add ("L");
values.add(MM_ADJUSTMENT_STATUS); pstm.add ("L");
values.add(DIS_AMT); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");
try{
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();}
catch (Exception e) {
	
	out.print (e.toString());
	}	
values.clear();
pstm.clear();
response.sendRedirect("savepage.jsp");
}
//out.print(qryUpdate.toString());

 %>
    </p>
</FORM>
</BODY>
</HTML>
