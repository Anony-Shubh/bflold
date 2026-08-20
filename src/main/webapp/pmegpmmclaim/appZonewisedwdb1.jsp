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
String APP_STATUS=request.getParameter("APP_STATUS")== null?"%%":(String) request.getParameter("APP_STATUS");
String ZN_NM=request.getParameter("ZONE_NM")== null?"":(String) request.getParameter("ZONE_NM");

String OF_NM=request.getParameter("OFF_NAME")== null?"":(String) request.getParameter("OFF_NAME");
String vcls="";

if (!APP_STATUS.equals("")) {
vcls=" APP_STATUS LIKE '"+APP_STATUS+"'  ";
}



if (!ZN_NM.equals("TOTAL")) {
vcls=vcls+"  AND ZONE_NM = '"+ZN_NM+"'  ";
}

if (!OF_NM.equals("TOTAL")) {
vcls=vcls+"  AND OFF_NAME1 = '"+OF_NM+"'  ";
}


Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdt = df.format(now);

 StringBuffer qrysb= new StringBuffer();
 
qrysb.append("SELECT OFF_NAME1,ZONE_NM,APP_NAME,APP_ID,TO_CHAR(MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT,MM_CLAIM_AMT,     "      ); 
qrysb.append("CASE WHEN  APP_STATUS = 'RMR'  THEN ' Recommended For MM Release'"      ); 
qrysb.append("WHEN APP_STATUS = 'MR' THEN 'Margin Money Released' "      ); 
qrysb.append("WHEN APP_STATUS = 'RC' THEN 'Reffered And Clarified' "      ); 
qrysb.append("WHEN APP_STATUS = 'RP' THEN 'Reffered And Pending' "      ); 
qrysb.append("ELSE 'Claims Under Process' END AS APP_STATUS  FROM"      ); 
qrysb.append(" (SELECT AD.APP_ID,"      );
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
qrysb.append("AND BD.ACT_ID         = 11 ) WHERE   "+vcls+"   "      );
qrysb.append("GROUP BY OFF_NAME1,ZONE_NM,APP_NAME,APP_ID,MM_CLAIM_DT,MM_CLAIM_AMT,APP_STATUS    "  );
 // out.print(qrysb.toString());



String ZONE_NM="";
String OFF_NAME1="";
String  APP_ID = "";
String  APP_NAME = "";
String  MM_CLAIM_DT= "";
String  MM_CLAIM_AMT= "";
String  APP_STATUS1 = "";

DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<center>
  <h1> Margin Money (MM) Claim Status Zone Wise 01 July,2016 to <%= curdt %>
<a href="zonewisedwdb_claim_repo.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a> (Rs. in Lakhs) </h1>
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
