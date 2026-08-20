<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<HTML>

<HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>


    
       <TITLE>    </TITLE>
       <style type="text/css">
<!--
.style5 {font-family: "Times New Roman", Times, serif}
-->
       </style>
</HEAD>



<BODY>
<%@ include file = "sessionout.jsp" %>
<p><img src="../images/pmegponlineN.jpg" width="100%"></p>

<DIV id="menu">
<br>

<div align="center">
  <UL>
          <A href="logout.jsp" class="buttonMerun"> Logout</A>
    </UL>

  </div>
</DIV>


<FORM method = "post"  id="form" name="form"  >
 <%
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
APP_ID=APP_ID.trim();
APP_ID=APP_ID.toUpperCase();
String APP_NAME="";
String MOB_NO1="";
String STATE_NM="";
String DISTRICT_NAME="";
String PAN_NO="";
String AADHAR_NO="";
String EDP_TRG_NAME="";
String EDP_CERT_DT="";
String CURRENT_STATUS="";
String OFF_TYPE_SHORT_DESC="";
String EDP_FR_DT="";
String EDP_TO_DT="";
String ON_OFF="";
String PRE_POST="";
String ED_ID="";
String UP_ID="";
String DOC_NAME="";
String DOC_REMARKS="";
String UPLOAD_DATE="";
String LOAN_SANC_DT="";

String Datafetch="N";
String EDPOPT_YN="N";
String EDPCERTUPDT="N";
String EDP_CENT_NAME="";

DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AD.APP_ID, "      );
poR.append(" AD.APP_NAME, "      );
poR.append(" AD.MOB_NO1, "      );
poR.append(" MS.STATE_NM, "      );
poR.append(" MD.DISTRICT_NAME, "      );
poR.append(" 'xxxxx'||SUBSTR(AD.PAN_NO,6,LENGTH(AD.PAN_NO)) AS PAN_NO, "      );
poR.append(" 'xxxxx'||SUBSTR(AD.AADHAR_NO,6,LENGTH(AD.AADHAR_NO)) AS AADHAR_NO, TO_CHAR(BD.LOAN_SANC_DT,'DD-MON-RRRR') AS LOAN_SANC_DT,"      );
poR.append(" BD.EDP_TRG_NAME, "      );
poR.append(" TO_CHAR(BD.EDP_CERT_DT,'DD-MON-RRRR') AS EDP_CERT_DT, "      );
poR.append(" FUNC_GETCURRENTSTATUS(AD.APP_ID) AS CURRENT_STATUS "      );  
poR.append(" FROM APP_DETAIL AD, APP_DETAIL_ONLINE AOD, BANK_DATAENTRY BD, M_DISTRICT MD, M_STATE MS"      );
poR.append(" WHERE AD.APP_ID=AOD.APP_ID "      );
poR.append(" AND AD.APP_ID     = BD.APP_ID(+) "      );
poR.append(" AND AD.UNIT_DIST_CD = MD.DISTRICT_CD "      );
poR.append(" AND MD.STATE_CD = MS.STATE_CD "      );
poR.append(" AND AD.APP_ID=? ");

values.add(APP_ID);
ResultSet rsMain = db.executeSQL(poR.toString(),values);

// EDP DETAILS
StringBuffer poR1 = new StringBuffer();

poR1.append(" SELECT ECT.APP_ID, "      );
poR1.append(" MOMC.OFF_TYPE_SHORT_DESC, MOM.OFF_NAME AS EDP_CENT_NAME, "      );	
poR1.append(" ECT.EDPOFF_CD, "      );
poR1.append(" ECT.EDP_FR_DT, "      );
poR1.append(" ECT.EDP_TO_DT, "      );
poR1.append(" ECT.EDP_CERT_DT, "      );
poR1.append(" ECT.ED_ID, "      );
poR1.append(" ECT.ACT_YN, "      );
poR1.append(" ECT.DOC_NAME, "      );
poR1.append(" ECT.DOC_REMARKS, "      );
poR1.append(" CASE WHEN ECT.EDP_TYPE IN (1,2) THEN 'Online' ELSE 'Offline' END ON_OFF, "      );
poR1.append(" CASE WHEN ECT.EDP_TYPE IN (3,4) THEN 'Pre EDP' ELSE 'Post EDP' END PRE_POST, "      );
poR1.append(" MOM.ACT_YN AS EDPCENTACT_YN "      );
poR1.append(" FROM EDP_CONDUCT_TRANS ECT, MAS_OFF_MAST MOM, MAS_OFF_TYPE_CDMAST MOMC "      );
poR1.append(" WHERE ECT.EDPOFF_CD = MOM.OFF_CD "      );
poR1.append(" AND MOM.OFF_TYPE_CD = MOMC.OFF_TYPE_CD "      );
poR1.append(" AND MOM.OFF_TYPE_CD = MOMC.OFF_TYPE_CD "      );
poR1.append("AND ECT.APP_ID       = ? "      );

// EDP UPLOADED FILE
StringBuffer poR2 = new StringBuffer();

poR2.append(" SELECT AUT.UP_ID, "      );
poR2.append(" AUT.APP_ID, "      );
poR2.append(" AUT.DOC_NAME, "      );
poR2.append(" AUT.DOC_REMARKS, "      );
poR2.append(" TO_CHAR( AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR') AS UPLOAD_DATE "      );
poR2.append(" FROM APP_UPLOAD_TRANS AUT "      );
poR2.append(" WHERE AUT.UPM_CD  = 8 "      );
poR2.append(" AND AUT.DOC_ACTYN = 'Y' "      );
poR2.append(" AND AUT.APP_ID= ? "      );




while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
EDP_TRG_NAME=rsMain.getString("EDP_TRG_NAME")==null?"":rsMain.getString("EDP_TRG_NAME");
EDP_CERT_DT=rsMain.getString("EDP_CERT_DT")==null?"":rsMain.getString("EDP_CERT_DT");
CURRENT_STATUS=rsMain.getString("CURRENT_STATUS")==null?"":rsMain.getString("CURRENT_STATUS");
Datafetch="Y";
LOAN_SANC_DT=rsMain.getString("LOAN_SANC_DT")==null?"":rsMain.getString("LOAN_SANC_DT");
ResultSet rsMain1 = db.executeSQL(poR1.toString(),values);

while (rsMain1.next()){
APP_ID=rsMain1.getString("APP_ID")==null?"":rsMain1.getString("APP_ID");
OFF_TYPE_SHORT_DESC=rsMain1.getString("OFF_TYPE_SHORT_DESC")==null?"":rsMain1.getString("OFF_TYPE_SHORT_DESC");
EDP_FR_DT=rsMain1.getString("EDP_FR_DT")==null?"":rsMain1.getString("EDP_FR_DT");
EDP_TO_DT=rsMain1.getString("EDP_TO_DT")==null?"":rsMain1.getString("EDP_TO_DT");
ON_OFF=rsMain1.getString("ON_OFF")==null?"":rsMain1.getString("ON_OFF");
PRE_POST=rsMain1.getString("PRE_POST")==null?"":rsMain1.getString("PRE_POST");
ED_ID=rsMain1.getString("ED_ID")==null?"":rsMain1.getString("ED_ID");
EDPOPT_YN="Y";
EDP_CENT_NAME=rsMain1.getString("EDP_CENT_NAME")==null?"":rsMain1.getString("EDP_CENT_NAME");

}
rsMain1.close();

ResultSet rsMain2 = db.executeSQL(poR2.toString(),values);

while (rsMain2.next()){

UP_ID=rsMain2.getString("UP_ID")==null?"":rsMain2.getString("UP_ID");
APP_ID=rsMain2.getString("APP_ID")==null?"":rsMain2.getString("APP_ID");
DOC_NAME=rsMain2.getString("DOC_NAME")==null?"":rsMain2.getString("DOC_NAME");
DOC_REMARKS=rsMain2.getString("DOC_REMARKS")==null?"":rsMain2.getString("DOC_REMARKS");
UPLOAD_DATE=rsMain2.getString("UPLOAD_DATE")==null?"":rsMain2.getString("UPLOAD_DATE");
EDPCERTUPDT="Y";
}
rsMain2.close();

}
rsMain.close();
values.clear();
db.close();

%>
<CENTER>
<br>
<table   border="1">
 Enter PMEGP Applicant ID:<input name="APP_ID"  type="text" id="APP_ID" value="<%= APP_ID %>" Maxlength="20" Autocomplete="off">
 <input name="submit"  type="submit" class="buttonlogin" value="Search">
  </table>
</FORM>
		
	<br>	
	<% if (Datafetch.equals("Y")) { %>	
		
			 
		
 <table  border="1" align="center" cellpadding="2" cellspacing="2" class="display" id="example">
 <tr>
 <th><div align="left"><span class="style5">Applicant Id:</span></div></th>
 <td><span class="style5"><%=APP_ID%></span></td>
 <th><div align="left"><span class="style5">Applicant Name:</span></div></th>
 <td><%=APP_NAME%></td>
 </tr>
 <tr>
 <th><div align="left"><span class="style5">Mobile Number:</span></div></th>
 <td><span class="style5"><%=MOB_NO1%></span></td>
 <th><div align="left"><span class="style5">Current Status:</span></div></th>
 <td><%=CURRENT_STATUS%></td>
 </tr>
 <tr>
 <th><div align="left"><span class="style5">Aadhar Number:</span></div></th>
 <td><span class="style5"><%=AADHAR_NO%></span></td>
 <th><div align="left"><span class="style5">PAN Number:</span></div></th>
 <td><%=PAN_NO%></td>
 </tr>
 <tr>
 <th><div align="left"><span class="style5">State Name</span></div></th>
 <td><span class="style5"><%=STATE_NM%></span></td>
 <th><div align="left"><span class="style5">District Name</span></div></th>
 <td><%=DISTRICT_NAME%></td>
 </tr>
 <tr>
   <th colspan="4">Loan Sanction Date:<%= LOAN_SANC_DT %> </th>
 </tr>
 <tr>
   <th colspan="4">EDP TRAINING DETAIL AS CERTIFIED BY FINANCING BRANCH </th>
   </tr>
 <tr>
 <th><span class="style5">EDP Training Center Name</span></th>
 <th><span class="style5"><%=EDP_TRG_NAME%></span></th>
 <th><span class="style5">EDP Certificate Date</span></th>
 <th><%=EDP_CERT_DT%></th>
 </tr>
 </table>
  <br>
<br>

  <% if (EDPOPT_YN.equals("Y")) { %>	
 <table id="example" class="display"  border="1" width="80%">
<tr>
  <th colspan="4">TRAINING CENTER OPTED BY APPLICANT </th>
  </tr>
<tr>
 <th><span class="style5">EDP ID:</span></th>
 <td><span class="style5"><%=ED_ID%></span></td>
 <th><span class="style5">EDP Description:</span></th>
 <td><%=EDP_CENT_NAME%></td>
 </tr>
 <tr>
 <th><span class="style5">Online/Offline EDP:</span></th>
 <td><span class="style5"><%=ON_OFF%></span></td>
 <th><span class="style5">EDP Type:</span></th>
 <td><%=PRE_POST%></td>
 </tr>
 <tr>
 <th><span class="style5">EDP Training Start Date:</span></th>
 <td><span class="style5"><%=EDP_FR_DT%></span></td>
 <th><span class="style5">EDP Training End Date:</span></th>
 <td><%=EDP_TO_DT%></td>
 </tr>
 </table>
 <% }else {out.print("<table><tr><td><strong><h1>EDP Option Not Given</h1></strong></td></tr></table>");} %>
 <br>
	<% if (EDPCERTUPDT.equals("Y")) { %>		
 <table id="example" class="display"  border="1" width="80%">
<tr>
  <th colspan="2">Certificate Uploaded for Verification </th>
  <td>&nbsp;</td>
</tr>
<tr>
 <th><div align="right"><span class="style5">Document Upload Date:</span></div></th>
 <td><div align="right"><span class="style5">
   <input name="btnshowedp" type="button" value="SHOW EDP CERTIFICATE" onClick="showedpcertt('<%=DOC_NAME%>','<%=APP_ID%>')"  class="buttonMerun">
 </span></div></td>
 <td><span class="style5"><%=UPLOAD_DATE%></span></td>
 </tr>
 </table>
 <% }else {out.print("<table><tr><td><strong><h1>EDP Certificate Not Uploaded</h1></strong></td></tr></table>");} %>
 
 <% }else {out.print("<strong><h2>Enter Correct Applicant ID</h2></strong>");} %>
 <script>
  var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function showedpcertt(docname,appid){
var urlpar='../jsp/doctransfertoNas.jsp?APP_ID='+appid+'&docname='+docname;

 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,600,'EDP Certificate',null,null);
 }//end 
 </script>
</BODY>

</HTML>
