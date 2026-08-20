<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="500kb" %>
<% 
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<HTML>
<HEAD>
   <TITLE>PMEGP e-Tracking</TITLE>
   <LINK rel="stylesheet" type="text/css" href="../css/lov.css" />
<SCRIPT type="text/javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<SCRIPT src="https://code.jquery.com/jquery-1.12.3.js"></SCRIPT>
<LINK href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<SCRIPT src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></SCRIPT>
<SCRIPT src="../js/dis.js"></SCRIPT>
<LINK rel="stylesheet" type="text/css" href="../css/dis.css">


<SCRIPT language="javascript">
function mypopup(myurl,param,w,h ) { 
//var w = 700; 
//var h = 400; 
var winl = (screen.width-w)/2; 
var wint = (screen.height-h)/2; 
if (winl < 0) winl = 0; 
if (wint < 0) wint = 0; 

var page = myurl+'?'+param; 
windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=no"; 
window.open(page, "Popup", windowprops); 
} 

</SCRIPT>
</HEAD>

<BODY>

<IMG src="../images/pmegponline.jpg" width="100%" height="150" >

<%
String SOFF_CD =(String) session.getAttribute("sOffCd");
String SDISTRICT_CD =(String) session.getAttribute("sDistrictCd");
String SAGENCY_TYPE = (String)session.getAttribute("sAgencyType"); 
String SOFF_NAME1 = (String) session.getAttribute("sOffName1");
String SDISTRICT_NAME=(String) session.getAttribute("sDistrictnm");
String SLOGINTYPE=(String) session.getAttribute("slgType");
//String SMISOFFCD=(String) session.getAttribute("sMiscd");
out.print(SLOGINTYPE);
//out.print(SMISOFFCD);

try {
if (SOFF_NAME1==null||SOFF_NAME1.equals("")){
response.sendRedirect("../jsp/AgencyloginPageNew.jsp");
}
	}catch (Exception m) {}		
	
	
	String vPending="0";
	String vUSERID="";
try{
 DBCon db1= new DBCon();
  db1.connect(); 
  String docStr="";
  
 // if(SLOGINTYPE.equals("KVIC")){
 //docStr="SELECT COUNT(*) as vcount,nvl(USER_ID,0) as USER_ID FROM geotag_user WHERE OFF_CD="+SOFF_CD+"  AND ACT_YN='Y' GROUP BY USER_ID";
  
 ResultSet rs2 = db1.execSQL(" SELECT COUNT(*) as vcount,nvl(USER_ID,0) as USER_ID FROM geotag_user WHERE OFF_CD="+SOFF_CD+"  AND ACT_YN='Y' GROUP BY USER_ID ");
  //}
  //else{
  //
  //docStr="SELECT COUNT(*) as vcount,nvl(USER_ID,0) as USER_ID FROM geotag_user WHERE mis_off_Cd="+SOFF_CD+"  AND ACT_YN='Y' GROUP BY USER_ID";
  //}
	//  ResultSet rs2 = db1.execSQL(docStr);
		//}
		//else{
		// ResultSet rs2 = db1.execSQL(" SELECT COUNT(*) as vcount,nvl(USER_ID,0) as USER_ID FROM geotag_user WHERE MIS_OFF_CD="+SOFF_CD+"  AND ACT_YN='Y' GROUP BY USER_ID ");
		//}
		while (rs2.next()){
		vPending=rs2.getString("vcount")==null?"0":rs2.getString("vcount");
		vUSERID=rs2.getString("USER_ID")==null?"0":rs2.getString("USER_ID");
		session.setAttribute("sUSERID",vUSERID);
		session.setAttribute("sUC",vPending);
		
		 
		}
		rs2.close();
		db1.close();
		}catch(Exception e) {}
		//out.print("no"+vPending);
		//out.print("no"+vUSERID);
%>
<TABLE align="center" class="pmegpTable" >
  <TR>
    <TD colspan="11" nowrap><DIV align="center">
      <H2>PMEGP Agency Approver Login : <%= SOFF_NAME1 %>, AGENCY: <%= SAGENCY_TYPE %>,DISTRICT:  <%=SDISTRICT_NAME%> </H2>
    </DIV></TD>
  </TR>
 
  <TR>
  <TD nowrap> <DIV align="center"><A href="PMEGPAgencyHomePage.jsp"  class="greenButtonRound">Home</A></DIV></TD>
 
   <td nowrap><div align="center"><a href="ApprestPass.jsp" class="greenButtonRound">Reset Password </a></div></td>
   
   <TD nowrap><DIV align="center"><A href="agencyUpdate.jsp" class="greenButtonRound">Approver Registration </A></DIV></TD> 
   
   <TD nowrap><DIV align="center"><A href="AppwiseBank.jsp" class="greenButtonRound">Physical Verification</A></DIV></TD>
   
   
  
   
   <TD nowrap><DIV align="center"><A href="../jsp/pdf/PhysicalVerificationPPT.pptx" class="greenButtonRound">Download Physical Verification PPT </A></DIV></TD>
   
    <TD nowrap><DIV align="center"><A href="GTAppSearchLOV_award.jsp" class="greenButtonRound">PMEGP Award</A></DIV></TD>
	
   <!-- <td nowrap><div align="center"><a href="dltfcAppwiseUpdate.jsp" class="greenButtonRound">Applicantwise Update </a></div></td>-->
    <TD nowrap><DIV align="center"><A href="../pmegpeportaltutorialdoc/User_manual_Approver 21.10.21-converted.pdf" class="greenButtonRound">User Manual </A></DIV></TD>
 <!-- <td nowrap><div align="center"><a href="edpDetails.jsp" class="greenButtonRound">EDP</a></div></td>-->
    <TD nowrap><DIV align="center"><A href="logout.jsp"  class="greenButtonRound">Logout/close</A></DIV></TD>
  </TR>
</TABLE>
