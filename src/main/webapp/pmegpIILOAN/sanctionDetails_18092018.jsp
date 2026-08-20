<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
<title>PMEGP Online Application Registration</title>
</head>
<body>



<%
String AADHAR= request.getParameter("aadhar")==null?"1":(String) request.getParameter("aadhar");
String PAN= request.getParameter("aadhar")==null?"1":(String) request.getParameter("pan");
String STATE= request.getParameter("state")==null?"":(String) request.getParameter("state");
String UAD= request.getParameter("UAD")==null?"":(String) request.getParameter("UAD");
String DISTRICT_CD= request.getParameter("dis")==null?"":(String) request.getParameter("dis");
String APP_ID= request.getParameter("appid")==null?"":(String) request.getParameter("appid");
String vcls="";
if (STATE.equals("AR")||STATE.equals("AS")||STATE.equals("MN")||STATE.equals("MG")||STATE.equals("SK")||STATE.equals("TR")||STATE.equals("NG")||STATE.equals("MZ")||STATE.equals("JK"))
{
vcls=vcls+" AND (AD.PAN_NO ='"+PAN+"' OR AD.AADHAR_NO='"+AADHAR+"') AND AD.UNIT_DIST_CD="+DISTRICT_CD+" ";	
}
else{
vcls=vcls+" AND AD.AADHAR_NO='"+AADHAR+"' AND AD.UNIT_DIST_CD="+DISTRICT_CD+" ";	
}
	
	

DBCon db= new DBCon();
db.connect();



 String IFSC_CODE="";
 
	String BANK_NAME="";
	String  BRANCH_NAME="";


String LOAN_SANC_DT = "";
String WORKSHED_COST ="";
String WORKING_CAPITAL = "";
String MACHINARY_COST = "";
String APPID = "";




String IST_LOAN_AMT = "";
String IST_LOAN_DT = "";
String CGTSI = "";

String MM_REL_DT = "";
String MM_REL_AMT = "";

String PROJ_COST="";

String APPLOAN_ACCNO = "";
String FB_ACNO = "";

String TDR_ACNO = "";
String TDR_ADJ_DT = "";

String CE_SANC_FB="";
String WC_SANC_FB="";
String TOTAL_SANC_FB="";
String UTRN_NO="";
String APP_NAME="";
String UNIT_NM="";
String GSTN_NO="";



String AADHAR_NO="";
String PAN_NO="";
String UNIT_LOC="";
String UNIT_ADDR="";

 String UNIT_PIN="";
  String ACTIVITY_NAME="";
  String DISTRICT_NAME="";
  String STATE_NM="";
 
 String STATE_CD="";
 String BENF_CATEGORY_DESC="";

  String AGENCY_TYPE="";
 
  String MOB_NO1="";

  String IND_GRP_LONG_DESC="";
  String EDP_TRG_NAME="";






try {

StringBuffer qrysb= new StringBuffer();

  
  qrysb.append("   SELECT AD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     NVL(BD.WORKSHED_COST, 0)               AS WORKSHED_COST,"      );
qrysb.append("     NVL(BD.MACHINARY_COST, 0)              AS MACHINARY_COST,"      );
qrysb.append("     NVL(BD.CE_SANC_FB, 0)                  AS CE_SANC_FB,"      );
qrysb.append("     NVL(BD.WC_SANC_FB, 0)                  AS WC_SANC_FB,"      );
qrysb.append("     NVL(BD.IST_LOAN_AMT, 0)                AS IST_LOAN_AMT,"      );
qrysb.append("     TO_CHAR(BD.IST_LOAN_DT, 'DD-MON-RRRR') AS IST_LOAN_DT,"      );
qrysb.append("     BD.APPLOAN_ACCNO,"      );
qrysb.append("     BD.TDR_ACNO,"      );
qrysb.append("     TO_CHAR(BD.TDR_ADJ_DT, 'DD-MON-RRRR') AS TDR_ADJ_DT,"      );
qrysb.append("     BD.UTRN_NO,"      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     TO_CHAR(BD.MM_REL_DT, 'DD-MON-RRRR') AS MM_REL_DT,"      );
qrysb.append("     NVL(BD.CE_SANC_FB, 0) + NVL(BD.WC_SANC_FB, 0) TOTAL_SANC_FB,"      );
qrysb.append("     BD.WORKING_CAPITAL,"      );
qrysb.append("     BD.IFSC_CODE,"      );
qrysb.append("     AD.BANK_NAME,"      );
qrysb.append("     AD.BRANCH_NAME,"      );
qrysb.append("      AD.UNIT_POST_ADDR ||''||AD.UNIT_TALUK_BLOCK AS UNIT_ADDR,"      );
qrysb.append("     AD.UNIT_LOC,"      );
qrysb.append("     AD.UNIT_TALUK_BLOCK,"      );
qrysb.append("     AD.UNIT_PIN,"      );
qrysb.append("     AM.ACTIVITY_NAME,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     MS.STATE_CD,"      );
qrysb.append("     BCM_S.BENF_CATEGORY_DESC,"      );
qrysb.append("     BCM.BENF_CATEGORY_DESC AS BENF_CATEGORY_DESC1,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME1,"      );
qrysb.append("     MOM.OFF_ADDR1,"      );
qrysb.append("     MOM.OFF_ADDR2,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.PAN_NO,"      );
qrysb.append("     IGM.IND_GRP_LONG_DESC,"      );
qrysb.append("     BD.EDP_TRG_NAME"      );
qrysb.append("   FROM app_detail AD,"      );
qrysb.append("     bank_dataentry BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     APP_STATUS_MAST ASM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM_S,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     EDUCATION_MAST EM,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     BENF_TYPE_MAST BTM,"      );
qrysb.append("     APP_MEETING_MAST AMM,"      );
qrysb.append("     MM_REMARKS_TRANS MRT,"      );
qrysb.append("     IND_GRP_MAST IGM"      );
qrysb.append("   WHERE AD.APP_ID         = BD.APP_ID(+)" );
qrysb.append("   AND AD.OFF_CD           = MOM.OFF_CD"      );
qrysb.append("   AND AD.ACT_ID           = ASM.ACT_ID"      );
qrysb.append("   AND AD.BENF_SPECAT_CD   = BCM.BENF_CATEGORY_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD     = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD         = MS.STATE_CD"      );
qrysb.append("   AND AD.EDU_ID           = EM.EDU_ID"      );
qrysb.append("   AND AD.MTG_ID           = AMM.MTG_ID(+)"      );
qrysb.append("   AND BD.REMTRID          = MRT.REMTR_ID(+)"      );
qrysb.append("   AND AD.BENF_TYPE_CD     = BTM.BENF_TYPE_CD(+)"      );
qrysb.append("   AND AD.ACTIVITY_CD      = AM.ACTIVITY_CD"      );
qrysb.append("   AND IGM.IND_GRP_CD      = AM.IND_GRP_CD"      );
qrysb.append("   AND AD.BENF_CATAGORY_CD = BCM_S.BENF_CATEGORY_CD"      );
qrysb.append("   AND BD.MM_REL_AMT      IS NOT NULL"      );
qrysb.append("   AND BD.PACT_ID          = 34"      );
qrysb.append("   AND BD.APPRV_YN         = 'A'"      );
qrysb.append("   AND BD.MM_REL_DT       IS NOT NULL   "      );
qrysb.append(" "+vcls+" ");

//out.print(qrysb.toString());
			List values=new ArrayList();
    // values.add (AADHAR); 
	// values.add (IFSC_CODE);
			
ResultSet rsApp = db.execSQL(qrysb.toString());


values.clear();

while (rsApp.next()) {
    MACHINARY_COST=rsApp.getString("MACHINARY_COST")==null?"0":rsApp.getString("MACHINARY_COST");
	IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"0":rsApp.getString("IFSC_CODE");
	BANK_NAME=rsApp.getString("BANK_NAME")==null?"0":rsApp.getString("BANK_NAME");
	BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"":rsApp.getString("BRANCH_NAME");
	WORKSHED_COST=rsApp.getString("WORKSHED_COST")==null?"0":rsApp.getString("WORKSHED_COST"); 
	APPLOAN_ACCNO=rsApp.getString("APPLOAN_ACCNO")==null?"":rsApp.getString("APPLOAN_ACCNO");
	TDR_ACNO=rsApp.getString("TDR_ACNO")==null?"":rsApp.getString("TDR_ACNO");
	TDR_ADJ_DT=rsApp.getString("TDR_ADJ_DT")==null?"":rsApp.getString("TDR_ADJ_DT");
	CE_SANC_FB=rsApp.getString("CE_SANC_FB")==null?"0":rsApp.getString("CE_SANC_FB");
	WC_SANC_FB=rsApp.getString("WC_SANC_FB")==null?"0":rsApp.getString("WC_SANC_FB");
    TOTAL_SANC_FB=rsApp.getString("TOTAL_SANC_FB")==null?"":rsApp.getString("TOTAL_SANC_FB");
    MM_REL_DT=rsApp.getString("MM_REL_DT")==null?"":rsApp.getString("MM_REL_DT");
    MM_REL_AMT=rsApp.getString("MM_REL_AMT")==null?"":rsApp.getString("MM_REL_AMT");
	IST_LOAN_AMT=rsApp.getString("IST_LOAN_AMT")==null?"":rsApp.getString("IST_LOAN_AMT");
	IST_LOAN_DT=rsApp.getString("IST_LOAN_DT")==null?"":rsApp.getString("IST_LOAN_DT");
	UTRN_NO=rsApp.getString("UTRN_NO")==null?"":rsApp.getString("UTRN_NO");
	APPID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
	UNIT_ADDR=rsApp.getString("UNIT_ADDR")==null?"":rsApp.getString("UNIT_ADDR");
	
	UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
	
	 UNIT_PIN=rsApp.getString("UNIT_PIN")==null?"":rsApp.getString("UNIT_PIN");
   ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
   DISTRICT_NAME=rsApp.getString("DISTRICT_NAME")==null?"":rsApp.getString("DISTRICT_NAME");
   STATE_NM=rsApp.getString("STATE_NM")==null?"":rsApp.getString("STATE_NM");
 
  STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");
 BENF_CATEGORY_DESC=rsApp.getString("BENF_CATEGORY_DESC")==null?"":rsApp.getString("BENF_CATEGORY_DESC");

   AGENCY_TYPE=rsApp.getString("AGENCY_TYPE")==null?"":rsApp.getString("AGENCY_TYPE");
 
   MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");

   IND_GRP_LONG_DESC=rsApp.getString("IND_GRP_LONG_DESC")==null?"":rsApp.getString("IND_GRP_LONG_DESC");
  EDP_TRG_NAME=rsApp.getString("EDP_TRG_NAME")==null?"":rsApp.getString("EDP_TRG_NAME");
	AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
	PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
	
	
	} //end of resultset	
	//END OF BANK DATA
	
	//out.print(ACT_ID);
		
	}//end of ins
	catch (Exception e) {
	
	//out.print (e.toString());
	}		
%>
  <br/><br/>
  
  <% if (!APPID.equals("")){
  
  
  %>
  <table align="center">
    
    <tr>
      <td colspan="4"><div align="center"><strong>APPLICATION DETAILS FOR PMEGP </strong></div></td>
    <tr>
      <th colspan="4">&nbsp;</th>
    <tr>
      <th colspan="4"><div align="center">Personal Details </div></th>
    <tr>
      <th>(1)</th>
      <th>Application ID : </th> <input name="APP_ID" type="hidden" id="APP_ID"  value="<%=APPID%>" size="8" maxlength="7" />
      <td colspan="2"><div align="left"><%= APPID %></div></td>
    <tr>
      <th>(2)</th>
      <th>Applicant Name: </th>
      <td colspan="2"><div align="left"><%= APP_NAME %></div></td>
    <tr>
      <th>&nbsp;</th>
      <th>Aadhar No: </th>
      <td colspan="2"><div align="left"><%= AADHAR_NO %></div></td>
    <tr>
      <th>&nbsp;</th>
      <th>Pan No: </th>
      <td colspan="2"><div align="left"><%= PAN_NO %></div></td>
    <tr>
      <th>&nbsp;</th>
      <th>Mobile No : </th>
      <td colspan="2"><div align="left"><%= MOB_NO1 %></div></td>
    <tr>
      <th>(3)</th>
      <th>State:</th>
      <td colspan="2"><div align="left"><%= STATE_NM %></div></td>
    <tr>
      <th>(4)</th>
      <th>Agency:</th>
      <td colspan="2"><div align="left"><%= AGENCY_TYPE %></div></td>
    <tr>
      <th>(5)</th>
      <th>Category</th>
      <td colspan="2"><div align="left"><%= BENF_CATEGORY_DESC %></div></td>
    <tr>
      <th colspan="4"><div align="center">Unit Details </div></th>
    <tr>
      <th>(6)</th>
      <th>Unit Location </th>
      <td colspan="2"><div align="left"><%= UNIT_LOC %></div></td>
	  <tr>
      <th>(7)</th>
      <th>Existing Unit Name </th>
      <td colspan="2"> <input name="UNIT_NM" type="text" id="UNIT_NM" value="<%=UNIT_NM%>" size="30" maxlength="25" /></div></td>
	  <tr>
	  <th>(7)</th>
      <th>GSTN NO of the Unit</th>	  
	  <td> <input name="GSTN_NO" type="text" id="GSTN_NO" value="<%=GSTN_NO%>" size="20" maxlength="15" /></div></td>
    <tr>
      <th>(8)</th>
      <th>Existing Unit Address </th>
      <td colspan="2"><div align="left"><%= UNIT_ADDR %></div></td>
    <tr>
      <th>(8)</th>
      <th>Unit Pin </th>
      <td colspan="2"><div align="left"><%= UNIT_PIN %></div></td>
    <tr>
      <th>(9)</th>
      <th>Unit district </th>
      <td colspan="2"><div align="left"><%=DISTRICT_NAME%></div></td>
    <tr>
      <th>(10)</th>
      <th>Activity Name and Type </th>
      <td colspan="2"><div align="left"><%= ACTIVITY_NAME %>( <%= IND_GRP_LONG_DESC %>)</div></td>
    <tr>
      <th colspan="4"><div align="center">Sanction Details </div></th>
    <tr>
      <th>(11)</th>
      <th>Financing Bank Name*: </th>
      <th colspan="2"><%= BANK_NAME %></th>
    <tr>
      <th>&nbsp;</th>
      <th>IFSC Code : </th>
      <th colspan="2"><%= IFSC_CODE %></th>
    <tr>
      <th>&nbsp;</th>
      <th>Branch Name : </th>
      <th colspan="2"><%= BRANCH_NAME %></th>
    <tr>
      <td colspan="4">&nbsp;</td>
    <tr>
      <th>(12)</th>
      <th>Project Cost Detail: </th>
      <th> <div align="center">Project Cost </div></th>
      <th> <div align="center"> Loan Sanction </div></th>
    <tr>
      <th nowrap>&nbsp;</th>
      <th nowrap>(a) Capital Expenditure/Term Loan (in Rs) </th>
      <td nowrap><div align="center">
       <%= MACHINARY_COST %>
      </div></td>
      <td nowrap><div align="center">
       <%= CE_SANC_FB %>
      </div></td>
    <tr>
      <th>&nbsp;</th>
      <th>(b) Working Capital/Cash Credit (in Rs.) </th>
      <td><div align="center">
      <%= WORKING_CAPITAL %>
      </div></td>
      <td><div align="center">
        <%= WC_SANC_FB %>
      </div></td>
    <tr>
      <th>&nbsp;</th>
      <th> (c) Total  Project Cost  (a+b) </th>
      <th><div align="center">
       
</div></th>
      <th><div align="center">
       <%= TOTAL_SANC_FB %>
        </div></th>
    <tr>
      <th>(13)</th>
      <th>Date of Release of Loan:</th>
      <td colspan="2"><%= IST_LOAN_DT %></td>
    <tr>
      <th>(14)</th>
      <th>Loan Released (in Rs.): </th>
      <td colspan="2"><%= IST_LOAN_AMT %></td>
    <tr>
      <th>(15)</th>
      <th>Loan Account No.( Beneficiary ) </th>
      <td colspan="2"><%= APPLOAN_ACCNO %></td>
    <tr>
      <td><div align="center"><strong>(16)</strong></div></td>
      <td colspan="3"><div align="center" class="GreenLebel">Details of Margin Money (Subsidy) Claim Transfer through Corp. Bank to Your Bank</div></td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">Transfer    Date: </div></td>
      <td colspan="2"><%=MM_REL_DT%></td>
    <tr>
      <td>&nbsp;</td><input name="FLAG" type="hidden" id="FLAG" value="3"><input name="SCHEME" type="hidden" id="SCHEME" value="PMEGP"><input name="UAD" type="hidden" id="UAD" value="<%=UAD%>">
      <td><div align="right">MM Amount: </div></td>
      <td colspan="2"><%=MM_REL_AMT%></td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right"> Reference No: </div></td>
      <td colspan="2"><%=UTRN_NO%></td>
    <tr>
      <td colspan="4">  <div align="center" class="GreenLebel">Loan Repayment Detail</div></td>
      <tr>
      <td>(19)</td>
      <td>Date of Complete Repayment:* </td>
      <td colspan="2"><input type="text"  id="REPAY_DT" name="REPAY_DT" value="" onClick="popUpCalendar(this, this.form.REPAY_DT,'dd-mmm-yyyy');return false;" size="10" readonly="true"></td>
      <tr>
	  <td>(20)</td>
	  <td>Repayment Amount: </td>
      <td colspan="2"><input name="REPAY_AMT" type="text" id="REPAY_AMT"  size="8" maxlength="7" /></td>
	 
	  <tr>
	  <td colspan="4">  <div align="center"> <input name="btnCnf" id="btnCnf" type="button" onClick="getfrequenttab(3)"; class="button" value="Conform" /> </div></td>
      
   
  
  
  
  </table> 

  <% } else {%>
  
  
  <table>
	<tr>	
	<h1 align="center">No Records Found</h1>
	</tr>
	
	 <%}
  db.close();
   %>	
</table>
  

</body>
</html>



