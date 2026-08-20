<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>Samadhan</TITLE>
<LINK rel="stylesheet" type="text/css" href="main1.css">
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
</HEAD>

<STYLE>
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}

.myButton {
	background-color:#2e823c;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}

.mbgcolour {
 color: red;
}
</STYLE>

<BODY>

<FORM method="post" name="form">

  <%@ include file = "sessionoutinc.jsp" %>
   
<%
DBCon db= new DBCon();
db.connect(); 
 String month_dt=request.getParameter("month_dt")==null?"":(String)request.getParameter("month_dt");
		   String STATECD=request.getParameter("STATECD")==null?"":(String)request.getParameter("STATECD");
		 //  String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
List values=new ArrayList();
//out.print(SOFF_CD);
//if (vlogin.equals("Y")){
StringBuffer sb= new StringBuffer();

sb.append(" select * from(select m.*,q.DOC_NAME,  ");
 sb.append("   ");
      
 sb.append("  FUNC_GETEDPDAYS (M.APP_ID) AS edptobedays  from (SELECT mom.agency_type, ms.state_nm     AS state, mom.off_name2   AS off_name1,md.district_name,ad.app_id,ad.app_name,"      );
sb.append("    TO_CHAR(last_day(bsa.inv_date), 'DD-MON-RRRR') AS invoice_dt,TO_CHAR(BSA.cert_dt, 'DD-MON-RRRR') AS edp_cert_dt,"      );
 sb.append(" nvl(bd.WORKING_CAPITAL,0)+nvl(bd.MACHINARY_COST,0) as PRJ_COST, "      );
 sb.append("  to_char(bd.LOAN_SANC_DT,'DD-MON-RRRR') as LOAN_SANC_DT,"      );
  sb.append(" to_char(bd.EDP_FR_DT,'DD-MON-RRRR') as EDP_FR_DT, "      );
  sb.append("  to_char(bd.EDP_TO_DT,'DD-MON-RRRR') as EDP_TO_DT,"      );
 sb.append(" nvl( bd.CE_SANC_FB,0)+nvl(bd.WC_SANC_FB,0) as ADMPRJ_COST,"      );
 sb.append(" CASE WHEN NVL(bd.ACT_ID, 0) IN (0,8) THEN '(*) Under Process at Bank'  WHEN bd.ACT_ID = 3 THEN '(*) Returned/Rejected' ELSE 'Sanctioned' END  as CUR_STATUS,"      );
 sb.append(" (TRUNC(TO_DATE(bd.EDP_TO_DT))- TRUNC(TO_DATE(bd.EDP_FR_DT))+1) as NO_OF_DAYS,"      );
 sb.append("  decode(trunc(bd.loan_sanc_dt),null,trunc(ad.bank_f_date),trunc(bd.loan_sanc_dt)) as edp_dt_cal  "      );

sb.append(" FROM app_detail  ad,mas_off_mast mom,m_state ms,zone_mast zm,m_district  md,bnf_samadhanedp_appdetail   bsa,bank_dataentry bd "     );
sb.append(" WHERE ad.app_id=bd.app_id(+) and ad.app_id = bsa.app_id  AND ad.off_cd = mom.off_cd  AND ms.zone_cd = zm.zone_cd "      );
 sb.append("  AND md.district_cd = mom.district_cd AND ms.state_cd = md.state_cd  AND last_day(trunc(bsa.inv_date)) =? "      );
 sb.append("  AND mom.off_type_cd IN (2,3,22,5,7,27) and ms.state_cd=? AND MOM.MIS_OFF_CD2=? )m, "      );
sb.append(" (  SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT WHERE "      );
 sb.append("        AUT.UPM_CD=8  AND AUT.DOC_ACTYN='Y' group by AUT.app_id)q "      );
        
  sb.append("      where m.app_id=q.app_id(+)) "      );


  
values.add(month_dt);
values.add(STATECD);
if (STATECD.equals("AN")) {
values.add("10");
}else if (STATECD.equals("PJ") ) {
values.add("33");
}else if (STATECD.equals("LD") ){
values.add("25");
}else if (STATECD.equals("DD") ){
values.add("6029");
}else {
values.add(SOFF_CD);
}


//out.print(sb.toString());
ResultSet rs = db.executeSQL(sb.toString(),values);

String INVUPID="";
String MONTH_DT="";
String UPDOC_EDP="";
String EDP_NO="";
String TOTAL_AMT="";
String FORWARD_DT="";
String FOPAY_DT="";
String NETPAMENT_SAMADHAN="";
String MIS_OFF_CD="";
String APP_ID="";
String APP_NAME="";

String DOC_NAME="";

String EDP_FR_DT="";
String EDP_TO_DT="";
String PRJ_COST="";
String LOAN_SANC_DT="";
String EDP_CERT_DT="";
String CUR_STATUS="";
String NO_OF_DAYS="";
String ADMPRJ_COST="";
String edptobedays="";

%>

<div align="center"><h1>ONLINE EDP CERTIFICATE</h1></div>
<br>
<div class="mbgcolour" align="center">
<h2>(*) Sanctioned earlier and Online EDP Training Completed but the Financing Bank Rejected/Returned/Revoked the Original Sanction subsequently</h2>
</div>
<TABLE border="1" width="90%" align="center" id="customers">
  <TR>
    <TH width="3%"><DIV align="center">Id.</DIV></TH>
    <TH width="8%"><div align="center">APPLICANT ID</div></TH>
    <TH width="10%"><div align="center">NAME</div></TH>
    <TH width="11%"><div align="center">EDP CERTIFICATE DATE</div></TH>
	<TH width="11%"><div align="center">EDP FROM DATE</div></TH>
    <TH width="11%"><div align="center">EDP TO DATE</div></TH>
	<TH width="11%"><div align="center">NO OF DAYS</div></TH>
	 <TH width="11%"><div align="center">PRJ COST ADMITTED BY BANK</div></TH>
	<TH width="11%"><div align="center">SANCTION DATE</div></TH>
	<TH width="11%"><div align="center">LOAN SANCTION BY BANK </div></TH>
	<TH width="11%"><div align="center">*MINIMUN NO OF DAYS REQUIRED</div></TH>
	<TH width="11%"><div align="center">CURRENT STATUS</div></TH>
    <TH width="11%"><div align="center">CERTIFICATE</div></TH>
   
  </TR>
  <%
int count=0;
while (rs.next()) {
count=count+1;
APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
EDP_CERT_DT=rs.getString("EDP_CERT_DT")==null?"":rs.getString("EDP_CERT_DT");
DOC_NAME=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");
edptobedays=rs.getString("edptobedays")==null?"":rs.getString("edptobedays");
CUR_STATUS=rs.getString("CUR_STATUS")==null?"":rs.getString("CUR_STATUS");
NO_OF_DAYS=rs.getString("NO_OF_DAYS")==null?"":rs.getString("NO_OF_DAYS");
PRJ_COST=rs.getString("PRJ_COST")==null?"":rs.getString("PRJ_COST");
ADMPRJ_COST=rs.getString("ADMPRJ_COST")==null?"":rs.getString("ADMPRJ_COST");
EDP_FR_DT=rs.getString("EDP_FR_DT")==null?"":rs.getString("EDP_FR_DT");
EDP_TO_DT=rs.getString("EDP_TO_DT")==null?"":rs.getString("EDP_TO_DT");

LOAN_SANC_DT=rs.getString("LOAN_SANC_DT")==null?"":rs.getString("LOAN_SANC_DT");

%>
  <TR>
   <TD><DIV align="center"><%= count %></DIV></TD>
    <TD><DIV align="center"><%= APP_ID %></DIV></TD>
    <TD><DIV align="center"><%= APP_NAME%></DIV></TD>
    <TD><DIV align="center"><%= EDP_CERT_DT %></DIV></TD>
    <TD><DIV align="center"><%= EDP_FR_DT %></DIV></TD>
    <TD><DIV align="center"><%= EDP_TO_DT %></DIV></TD>
    <TD><DIV align="center"><%= NO_OF_DAYS%></DIV></TD>
    <TD><DIV align="center"><%= PRJ_COST %></DIV></TD>
       <TD><DIV align="center"><%= LOAN_SANC_DT %></DIV></TD>
	   <TD><DIV align="center"><%= ADMPRJ_COST %></DIV></TD>
    <TD><DIV align="center"><%= edptobedays %></DIV></TD>
    <TD><DIV align="center"><%= CUR_STATUS%></DIV></TD>
   
   
   
<TD><DIV align="center"> 

<input type="button" name="button" id="button" class="myButton" value="View" onClick="viewdocument('<%= DOC_NAME %>','<%=APP_ID%>');">
</DIV></TD>
	
	
	
  </TR>
  <%

}
rs.close();
db.close();
%>
</TABLE>
<p>* EDP Training Upto 2 Lakh Project cost is optional </p>
</FORM>
<SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");


 function viewdocument(DOC_NAME,APP_ID){
var callbackFunctionArray = new Array(refreshpage);
modalWin.ShowURL("edpDOcna.jsp?docname="+DOC_NAME+"&APP_ID="+APP_ID,500,800,'View Document',null,null);
 //modalWin.ShowURL("../jsp/doctransfertoNas.jsp?docname="+DOC_NAME,500,800,'View Document',null,null);
 }//end of bank

  function HideModalWindow() {
  modalWin.HideModalPopUp();
}

function refreshpage() {
  location.reload();
}

</SCRIPT>
</BODY>
</HTML>