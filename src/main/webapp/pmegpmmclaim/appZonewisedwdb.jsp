<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>

<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

</head>

<body>
<form name="form" id="form" class="form" method="post">

<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<%
String VUSER_ID ="";
String VUSER_DETAIL ="";
String VSUSER_TYPE ="";

try {

 VUSER_ID = session.getAttribute("SUSER_ID")==null?"":(String) session.getAttribute("SUSER_ID");
 VUSER_DETAIL = session.getAttribute("SUSER_DETAIL")==null?"":(String) session.getAttribute("SUSER_DETAIL");
 VSUSER_TYPE = session.getAttribute("SUSER_TYPE")==null?"":(String) session.getAttribute("SUSER_TYPE");


if (VUSER_ID.equals("")) {
//session.invalidate();
response.sendRedirect("index.jsp");
}
}catch (Exception e){
response.sendRedirect("index.jsp");

}



String APP_STATUS=request.getParameter("APP_STATUS")== null?"%%":(String) request.getParameter("APP_STATUS");
//out.print(APP_STATUS);
String FROMDT=request.getParameter("FROMDT")==null?"01-JUL-2016":(String) request.getParameter("FROMDT");
String TODT=request.getParameter("TODT")==null?"":(String) request.getParameter("TODT");
String ZN_NM=request.getParameter("ZONE_NM")== null?"":(String) request.getParameter("ZONE_NM");
//out.print(ZN_NM);
String APPT_STATUS=request.getParameter("APPT_STATUS")== null?"":(String) request.getParameter("APPT_STATUS");
String APPR_STATUS=request.getParameter("APPR_STATUS")== null?"":(String) request.getParameter("APPR_STATUS");
String APPS_STATUS=request.getParameter("APPS_STATUS")== null?"":(String) request.getParameter("APPS_STATUS");
//out.print(APPR_STATUS);
String OF_NM=request.getParameter("OFF_NAME")== null?"":(String) request.getParameter("OFF_NAME");
//out.print(OF_NM);
String vcls="";
String Wcls="";
String tcls="";
String cls="";




 if (APP_STATUS.equals("RC")) {
vcls=vcls+ " VUPLOADTIMESTAMP > = PROC_DT AND PACT_ID=30  ";	
}
 else if (APP_STATUS.equals("RP")) {
vcls=vcls+ "(VUPLOADTIMESTAMP< PROC_DT OR (VUPLOADTIMESTAMP IS NULL OR PROC_DT IS NULL)) AND PACT_ID=30 AND APPRV_YN = 'A' ";
 }
 
else if (!APP_STATUS.equals("")) {
vcls=vcls+ " APP_STATUS LIKE '"+APP_STATUS+"'  ";
}

if (!APPS_STATUS.equals("")) {
tcls=tcls+ " AND PACT_ID=30 AND APPRV_YN = 'S'  ";
}


if (!APPT_STATUS.equals("")) {
cls=cls+ "AND PACT_ID IN (30,32) AND APPRV_YN = 'R'  ";
}

if (!APPR_STATUS.equals("")) {
Wcls= Wcls+ "  AND APPRV_YN  <> 'A' AND PACT_ID IN (30,32)  ";
}

if (APPR_STATUS.equals("A")) {
Wcls= Wcls+ "  AND APPRV_YN  = 'S' AND PACT_ID IN (32)  ";
}


if (!ZN_NM.equals("ZTOTAL")) {
vcls=vcls+"  AND ZONE_NM = '"+ZN_NM+"'  ";
}
else{
	vcls=vcls+"  AND ZONE_NM like '%%'  ";
}

if (!OF_NM.equals("ZTOTAL")) {
vcls=vcls+"  AND OFF_NAME1 = '"+OF_NM+"'  ";
}
else{
	vcls=vcls+"  AND OFF_NAME1 like '%%'  ";
}
String reportcls="";

if (!ZN_NM.equals("ZTOTAL")) {
reportcls=reportcls+"  AND ZONE_NM = '"+ZN_NM+"'  ";
}

if (!OF_NM.equals("ZTOTAL")) {
reportcls=reportcls+"  AND OFF_NAME1 = '"+OF_NM+"'  ";
}


String REPDT="";

REPDT=REPDT+"AND TRUNC(MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ";

String reportclsEX="";
reportclsEX=reportclsEX+vcls+Wcls+tcls+cls+REPDT;
//out.print(reportclsEX);
session.setAttribute("APP_ID",reportclsEX); 


Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();
 
qrysb.append("SELECT OFF_NAME1,ZONE_NM,DECODE(APPRV_YN,'A','Approved','R','Retruned','S','Submitted','Pending') as APPRV_YN ,APP_NAME,APP_ID,TO_CHAR(MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT,MM_CLAIM_AMT,     "      ); 
qrysb.append("CASE WHEN  APP_STATUS = 'RMR'  THEN ' Recommended For MM Release'"      ); 
qrysb.append("WHEN APP_STATUS = 'MR' THEN 'Margin Money Released' "      ); 
qrysb.append("WHEN APP_STATUS = 'RC' THEN 'Reffered And Clarified' "      ); 
qrysb.append("WHEN APP_STATUS = 'RP' THEN 'Reffered And Pending For Rectification' "      ); 
qrysb.append(" WHEN APP_STATUS = 'RET' THEN 'Returned Back For Resubmission' "      );
qrysb.append(" WHEN APP_STATUS = 'RPS' THEN 'Reffered And Pending For Approval' "      );
qrysb.append(" WHEN APP_STATUS = 'CPA' THEN 'Claims Pending For Approval' "      );

qrysb.append("ELSE 'Claims Under Process' END AS APP_STATUS  FROM (select * from mmclaim_view01 WHERE TRUNC(MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"') "      ); 
/*qrysb.append(" (SELECT AD.APP_ID,"      );
 qrysb.append(" AD.APP_NAME,AD.BENF_TYPE_CD,AD.BENF_CATAGORY_CD,"      );
 qrysb.append("PMEGPCO_PENDINGSTATUS(AD.APP_ID) APP_STATUS,"      );
  qrysb.append("BD.LOAN_DOCFNAME,"      );
  qrysb.append("BD.MM_CLAIM_AMT,"      );
  qrysb.append("MOM.AGENCY_TYPE,"      );
  qrysb.append("MOM.OFF_NAME1,"      );
  qrysb.append("ZM.ZONE_NM,"      );
  qrysb.append("MS.STATE_NM,"      );
  qrysb.append("BD.PAY_STATUS,"      );
  qrysb.append("BD.UTRN_NO,"      );
  qrysb.append("BD.PACT_ID,"      );
  qrysb.append("BD.MM_CLAIM_DT,"      );
  qrysb.append("BD.MM_REL_AMT,"      );
 qrysb.append(" BD.MM_REL_DT,"      );
  qrysb.append("BD.APPRV_YN        "      );
qrysb.append("FROM APP_DETAIL AD,"      );
  qrysb.append("BANK_DATAENTRY BD,"      );
 qrysb.append(" MAS_OFF_MAST MOM,"      );
  qrysb.append("M_DISTRICT MD,"      );
  qrysb.append("M_STATE MS,"      );
  qrysb.append("ZONE_MAST ZM     "      );
qrysb.append("WHERE AD.APP_ID       = BD.APP_ID    "      );
qrysb.append("AND MOM.OFF_CD        = AD.OFF_CD     "      );
qrysb.append("AND MOM.DISTRICT_CD   = MD.DISTRICT_CD     "      );
qrysb.append("AND MD.STATE_CD       = MS.STATE_CD    "      );
qrysb.append("AND MS.ZONE_CD        = ZM.ZONE_CD   "      );
qrysb.append("AND BD.LOAN_DOCFNAME IS NOT NULL   "      );
qrysb.append("AND BD.MM_CLAIM_AMT   > 0   "      );
qrysb.append("AND AD.ACT_ID         = 5   "      );
qrysb.append("AND BD.ACT_ID         = 11  ");
qrysb.append(" AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' AND '"+TODT+"' ) ");*/

qrysb.append(" WHERE     "+vcls+"    "+Wcls+"  "+tcls+" "+cls+" "      );
qrysb.append("GROUP BY OFF_NAME1,ZONE_NM,APP_NAME,APP_ID,MM_CLAIM_DT,MM_CLAIM_AMT,APP_STATUS,APPRV_YN    "  );
//out.print(reportcls);
//out.print(qrysb.toString());


String ZONE_NM="";
String OFF_NAME1="";
String  APP_ID = "";
String  APP_NAME = "";
String  MM_CLAIM_DT= "";
String  MM_CLAIM_AMT= "";
String  APP_STATUS1 = "";
String APPRV_YN="";

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
System.out.println("value of reportclsEX :- " +reportclsEX);
%>
<center>
  <h1> Margin Money (MM) Claim Status Zone Wise 01 July,2016 to <%= curdt %>
<a href="zonewisedwdb_claim_repo.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
  <p><a href="../jsp/PMEGPGenbulk.jsp?APP_ID=<%=reportcls  %>" target="_self" class="button">Download bulk claim form</a> </p>
   <p><a href="../jasperrop/grMmCLaiRepo.jsp?APP_ID=<%=reportclsEX%>" target="_self" class="button">Download bulk claim form in excel</a> </p>
</center>

 <table id="tableid" align="center" class="bordered">
 
  <tr>
    <th>SRNO</th>
    <th>ZONE </th>
    <th>OFFICE NAME</th>
    <th>APPLICANT ID </th>
    <th>APPLICANT NAME</th>
    <th>MM CLAIM DT</th>
    <th>MM CLAIM AMOUNT </th>
    <th>CURRENT STATUS</th>
    <th>Approved</th>
    <th>View </th>
  </tr>
  
   <% 

int srno =0;
 while (rsMain.next()) { 
 
ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
APP_STATUS1=rsMain.getString("APP_STATUS")==null?"":rsMain.getString("APP_STATUS");
APPRV_YN =rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
srno =srno+1;

%>
<tr>
    <td><%=srno %></td>
    <td><%=ZONE_NM %></td>
    <td><%=OFF_NAME1 %></td>
    <td><%=APP_ID %></td>
    <td><%=APP_NAME %></td>
    <td><%=MM_CLAIM_DT %></td>
    <td><%=MM_CLAIM_AMT %></td>
    <td><%=APP_STATUS1 %></td>
    <td><%= APPRV_YN %></td>
    <td><input name="btnDocument" type="button" class="button" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Forms / Document"></td>
  </tr>
  
   
  <% }
  rsMain.close();
  db.close();
 
    %>
</table>
<script language="javascript">

var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 
 function viewAlldocument(pAppid){
var urlpar='viewAppdocument.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,800,1200,'PMEGP View All Applicant Document',null,null);
 }
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

 </script>
</form>

</body>
</html>
