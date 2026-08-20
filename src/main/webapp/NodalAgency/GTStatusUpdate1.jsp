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
<LINK rel="stylesheet" type="text/css" href="css/pmegpTable.css" />
<SCRIPT language="javascript" src="../js/sweetalert.min.js"></SCRIPT>


<SCRIPT language="javascript">

function form_submit(){


/*
var MM_ADJUSTMENT_STATUS = document.form.MM_ADJUSTMENT_STATUS.value;
    var MM_ADJUSTMENT_AMT_S = document.form.MM_ADJUSTMENT_AMT_S.value;
    var NODAL_OFFICER_REMARK = document.form.NODAL_OFFICER_REMARK.value;
	var MM_REL_AMT  = document.form.MM_REL_AMT.value

if(MM_ADJUSTMENT_STATUS==""){
 swal ( 'Note:','Select MM Adjustemnt Status','error');	
 return (false);
}

if(MM_ADJUSTMENT_AMT_S==""){
 swal ( 'Note:','Enter MM Adjustemnt Amount','error');	
 return (false);
}

if(NODAL_OFFICER_REMARK==""){
 swal ( 'Note:','Enter Nodal Officer Remarksn','error');	
 return (false);
}

if ( MM_ADJUSTMENT_STATUS == "FA") {
if (MM_ADJUSTMENT_AMT_S != MM_REL_AMT) {
 swal ( 'Note:','Enter Correct MM Adjustemnt Amount','error');	
 return (false);
}
}
if ( MM_ADJUSTMENT_STATUS == "PA") {

if (Number(MM_ADJUSTMENT_AMT_S) > Number(MM_REL_AMT) || MM_ADJUSTMENT_AMT_S == "0") {
//alert(MM_REL_AMT);
 swal ( 'Note:','Enter Correct MM Adjustemnt Amount','error');	
 return (false);
}
}*/

document.form.ins.value='I';
document.form.submit();


}

//}

</SCRIPT>
<style type="text/css">
<!--
.style1 {font-family: Geneva, Arial, Helvetica, sans-serif}
.style2 {font-weight: bold}
.style3 {font-weight: bold}
-->
</style>
</HEAD>
<BODY onLoad="chMd()";>
<form   name="form" id ="form" method="post" >
<%	

DBCon db= new DBCon();
db.connect();
String ins = "";
String vOffcd =(String) session.getAttribute("sOffCd");
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String  PMEGPGEOTAGID =request.getParameter("PMEGPGEOTAGID")==null?"":(String)request.getParameter("PMEGPGEOTAGID");
String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");
String ACT_ID="";
String CO_REMARKS="";

String MARGIN_MONEY_ADJUSTMENT_AMOUNT="";
String MM_REL_AMT="";
String USER_TYPE="";
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
  String TOTAL_EMPLOYEES="";
  String UNIT_ESTABLISHMENT_DATE="";
  String UNIT_SETUP_ON="";
  String UNIT_NAME="";
  String CAPITAL_COST_OF_BUILDING="";
  String CAPITAL_COST_OF_MACHINERY="";
  String CALLBACK_REASON="";
  String MACHINARY_COST="";
  String WORKING_CAPITAL="";

StringBuffer qrysb= new StringBuffer();
	
qrysb.append("   "      );
qrysb.append("    SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("     AD.APP_ID, GT.VERIFICATION_STATUS,GT.VERIFIER_REMARKS ,  AD.APP_NAME,NVL(BD.WORKING_CAPITAL,0) AS WORKING_CAPITAL,+NVL(BD.MACHINARY_COST,0) AS ");
qrysb.append(" MACHINARY_COST,NVL(BD.MACHINARY_COST,0)+NVL(BD.WORKING_CAPITAL,0)AS TOT_PRJ, "      );
qrysb.append(" BD.MM_REL_AMT, GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT, GT.NODAL_OFFICER_REMARK,"      );
 qrysb.append(" GT.MM_ADJUSTMENT_AMT_S, GT.PHYSICAL_VERIFICATION_STATUS,DECODE(GT.MM_ADJUSTMENT_STATUS,'FA','FULLY ALLOWED','PA','PARTIALLY ALLOWED','FD','FULLY DISALLOWED','RC','RECOMMENDED FOR REVERIFICATION OF UNIT') AS MM_ADJUSTMENT_STATUS, "      );
 qrysb.append("  GT.CALLBACK_AMOUNT, "      );
qrysb.append("   TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION, "      );
qrysb.append("   GT.VERIFICATION_BY, "      );
qrysb.append("   GT.VERIFICATION_STATUS, "      );
qrysb.append("   GT.VERIFIER_REMARKS,"      );
qrysb.append("   GT.PER_CAPITA_INVESTMENT_NORM_SAT, "      );
qrysb.append("   GT.TOTAL_EMPLOYEES, "      );
qrysb.append("   TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("   GT.UNIT_SETUP_ON, "      );
qrysb.append("   GT.UNIT_NAME, "      );
qrysb.append("   GT.CAPITAL_COST_OF_BUILDING, "      );
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
qrysb.append("        IND_GRP_MAST IGM"      );
qrysb.append("    WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("      AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("      AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("      AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("      AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("      AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );

qrysb.append("      AND AD.APP_ID       = GT.APP_ID AND AM.IND_GRP_CD   = IGM.IND_GRP_CD AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?     "      );

qrysb.append(" UNION  "      );
qrysb.append("    SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("     AD.APP_ID, GT.VERIFICATION_STATUS,GT.VERIFIER_REMARKS ,  AD.APP_NAME,NVL(BD.WORKING_CAPITAL,0) AS WORKING_CAPITAL,+NVL(BD.MACHINARY_COST,0) AS ");
qrysb.append(" MACHINARY_COST,NVL(BD.MACHINARY_COST,0)+NVL(BD.WORKING_CAPITAL,0)AS TOT_PRJ, "      );
qrysb.append(" BD.MM_REL_AMT, GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT, GT.NODAL_OFFICER_REMARK,"      );
 qrysb.append(" GT.MM_ADJUSTMENT_AMT_S, GT.PHYSICAL_VERIFICATION_STATUS,DECODE(GT.MM_ADJUSTMENT_STATUS,'FA','FULLY ALLOWED','PA','PARTIALLY ALLOWED','FD','FULLY DISALLOWED','RC','RECOMMENDED FOR REVERIFICATION OF UNIT') AS MM_ADJUSTMENT_STATUS, "      );
 qrysb.append("  GT.CALLBACK_AMOUNT, "      );
qrysb.append("   TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION, "      );
qrysb.append("   GT.VERIFICATION_BY, "      );
qrysb.append("   GT.VERIFICATION_STATUS, "      );
qrysb.append("   GT.VERIFIER_REMARKS,"      );
qrysb.append("   GT.PER_CAPITA_INVESTMENT_NORM_SAT, "      );
qrysb.append("   GT.TOTAL_EMPLOYEES, "      );
qrysb.append("   TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("   GT.UNIT_SETUP_ON, "      );
qrysb.append("   GT.UNIT_NAME, "      );
qrysb.append("   GT.CAPITAL_COST_OF_BUILDING, "      );
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
qrysb.append("        IND_GRP_MAST IGM"      );
qrysb.append("    WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("      AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("      AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("      AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("      AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("      AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );

qrysb.append("      AND AD.APP_ID       = GT.APP_ID AND AM.IND_GRP_CD   = IGM.IND_GRP_CD AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?     "      );



List values=new ArrayList();

values.add(APP_ID);
values.add(PMEGPGEOTAGID);
values.add(APP_ID);
values.add(PMEGPGEOTAGID);
  
   ResultSet rs = db.executeSQL(qrysb.toString(),values);
   values.clear();




	while (rs.next()){
	
	
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");	
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	PMEGPGEOTAGID=rs.getString("PMEGPGEOTAGID")==null?"":rs.getString("PMEGPGEOTAGID");
	MARGIN_MONEY_ADJUSTMENT_AMOUNT=rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT")==null?"":rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT");
	
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
	
	
	
		}
	  rs.close();


%>
<FORM name="form" id="form"  class="form" method="post" >

    <TABLE align="center">

  <TR>
    <TH colspan="7"> 
      <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
	  
	  <INPUT name="PMEGPGEOTAGID" type="hidden" id="PMEGPGEOTAGID" value="<%= PMEGPGEOTAGID %>">
      <DIV align="center">Margin Money Adjustment Update Form</DIV></TH>
  </TR>
  <TR>
    <TD><strong>Geo Tagging Id: </strong><%= PMEGPGEOTAGID %></TD>
    <TD colspan="2"><INPUT name="ins" type="hidden" id="ins">
      <strong>Applicant Id:</strong> <%=APP_ID %> </TD>
    <TD colspan="3"><strong>Beneficiary Name  :</strong> <%=  APP_NAME %></TD>
    </TR>
  
	<TR >
	  <TH colspan="7" ><DIV align="center">Verification Details </DIV></TH>
    </TR>
	<TR >
	  <TD width="248" ><strong>Date of Verification: </strong></TD>
	  <TD width="54" ><%= DATE_OF_VERIFICATION %></TD>
      <TD width="215" ><strong>Verification By:</strong></TD>
      <TD width="185" ><%= VERIFICATION_BY %></TD>
	  <TD width="224" ><strong>Physical Verification Status: </strong></TD>
	  <TD width="132" colspan="2" ><%= VERIFICATION_STATUS %></TD>
	</TR>
	<TR >
	  <TD ><strong>Physical Verification Remarks: </strong></TD>
	  <TD ><%= VERIFIER_REMARKS %></TD>
      <TD ><strong>Per Capita Investment : </strong></TD>
      <TD ><%= PER_CAPITA_INVESTMENT_NORM_SAT %></TD>
	  <TD ><strong>Total Employees:</strong></TD>
	  <TD width="132" colspan="2" ><%= TOTAL_EMPLOYEES %></TD>
	</TR>

	
	<TR >
	  <TH colspan="7" ><DIV align="center"><strong>Unit Description </strong></DIV></TH>
    </TR>
	
	<TR >
	  <TD ><strong>Unit Name: </strong></TD>
	  <TD ><%= UNIT_NAME %></TD>
	  <TD ><strong>Unit Establishment Date </strong></TD>
	  <TD ><%= UNIT_ESTABLISHMENT_DATE %></TD>
      <TD ><strong>Unit Set Up On: </strong></TD>
      <TD colspan="2" ><%= UNIT_SETUP_ON %></TD>
	</TR>
	
	<TR >
	  <TD ><strong>Capital Cost Of Biulding : </strong></TD>
	  <TD ><%= CAPITAL_COST_OF_BUILDING %></TD>
	  <TD ><strong>Capital Cost Of Machinery: </strong></TD>
	  <TD ><%= CAPITAL_COST_OF_MACHINERY %></TD>
      <TD ><strong>Working Capital </strong></TD>
      <TD colspan="2" ><%= WORKING_CAPITAL %></TD>
	</TR>
	<TR >
	  <TD ><strong>Capital Expenditure </strong></TD>
	  <TD ><%= MACHINARY_COST %></TD>
      <TD ><strong>Total Project Cost </strong></TD>
      <TD ><%= TOT_PRJ %></TD>
	  <TD ><strong>MM Released Amount</strong></TD>
	  <TD colspan="2" ><%= MM_REL_AMT %>
        <INPUT name="MM_REL_AMT" type="hidden" id="MM_REL_AMT"  size="10" maxlength="7"  value="<%= MM_REL_AMT %>" ></TD>
	</TR>
	
    <TR >
	  <TD ><strong>CallBack Reason: </strong></TD>
	  <TD ><%= CALLBACK_REASON %></TD>
      <TD ><strong>CallBack Amount: </strong></TD>
      <TD colspan="4" ><%= CALLBACK_AMOUNT %></TD>
	</TR>
  <TR >
    <TH colspan="7" ><DIV align="center" class="style2">
     Recommendation of District Nodal Officer
    </DIV></TH>
    </TR>
  <TR >
    <TD  ><DIV align="left"><strong>MM Adjustemnt Status </strong></DIV></TD>
	
	
    <TD ><%= MM_ADJUSTMENT_STATUS%>	 </TD>
    <TD ><strong>MM Adjustemnt Amount </strong></TD>
    <TD ><%= MM_ADJUSTMENT_AMT_S %></TD>
    <TD ><STRONG>Nodal Officer Remarks</STRONG></TD>
    <TD ><%= NODAL_OFFICER_REMARK %></TD>
  </TR>


  <TR >
    <TD colspan="2" ><strong>Select Status </strong></TD>
	<TD colspan="5"><span class="style3">
	  <input name="ACT_ID" id="ACT_ID" type="radio"  value="1" >
        Approved </span>
		<strong>
        <input name="ACT_ID" id="ACT_ID" type="radio"  value="2" >
        Returned For Resubmission </strong></TD>
    </TR>
	 <tr>
      <TD colspan="2"><div align="center"><strong> Remarks:</strong></div> </TD>
	  <td colspan="5"><div align="center">
        <textarea name="CO_REMARKS" cols="40" rows="3" class="mtextarea" id="CO_REMARKS"></textarea>
      </div></td>
    </tr>
    
  <TR>
    <TD colspan="7"> 
        <DIV align="center">
		 <INPUT name="Button" type="button" class="button" onClick="form_submit()" value="Save Record">

         
          <INPUT name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
        </DIV></TD>
  </TR>
</TABLE>

  <span class="style1">
  <%
  String refqry=  " SELECT MRT.CO_REMARKS AS CO_REMARKS1, TO_CHAR(trunc(MRT.PROC_DT),'DD-MON-RRRR') AS PROC_DT1 FROM GEOTAG_REMARKS MRT,GEOTAG_TRANS BD WHERE BD.ACT_ID IN (2) ";
			refqry =refqry+ " AND MRT.APP_ID=BD.APP_ID AND BD.ACT_ID=MRT.ACT_ID  AND MRT.APP_ID='"+APP_ID+"' GROUP BY  MRT.CO_REMARKS,MRT.PROC_DT  ";
			refqry =refqry+ " ";

			String CO_REMARKS1="";
			String PROC_DT1="";
			ResultSet rsRef = db.execSQL(refqry);
			while ( rsRef.next()) {
			CO_REMARKS1 =rsRef.getString("CO_REMARKS1");
			PROC_DT1 =rsRef.getString("PROC_DT1");
			out.print("<u><H3>Process Date: "+PROC_DT1+"</H3></u><u><H3>Remarks:- "+CO_REMARKS1+"</H3></u>");
	
			
			}
			rsRef.close();

%>
  <%

     if (ins.equals("I")){
	 
	try {
String REMTR_ID="";
ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
CO_REMARKS=(String) request.getParameter("CO_REMARKS")==null?"":(String) request.getParameter("CO_REMARKS").trim();

//List values=new ArrayList();
List pstm=new ArrayList();
StringBuffer qryUpdate = new StringBuffer();
  ResultSet rsMax = db.execSQL(" SELECT GEOPROCREMSEQ.NEXTVAL FROM DUAL ");
  while (rsMax.next()){
  REMTR_ID=rsMax.getString(1);
  }
  rsMax.close();

qryUpdate.append("  INSERT INTO  GEOTAG_REMARKS (REMTRID,APP_ID,PROC_DT,USER_TYPE,ACT_ID,CO_REMARKS,USER_ID,PMEGPGEOTAGID) ");
qryUpdate.append(" values (?,?,SYSDATE,?,?,?,?,?) ");

values.clear();
pstm.clear();

values.add(REMTR_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(USER_TYPE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(CO_REMARKS); pstm.add ("L");
values.add(vOffcd); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();

String Updt= "UPDATE GEOTAG_TRANS SET REMTRID=?, ACT_ID=?  WHERE APP_ID=? AND PMEGPGEOTAGID=? ";
values.add(REMTR_ID); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");
db.setSqlValue(Updt);
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
db.close();
response.sendRedirect("savemsgAgency.jsp");

}catch (Exception e) {out.print (e.toString());}
 
	 
	 
	 
	 

}


 %>
    </p>
  </span>
</FORM>
</BODY>
</HTML>
