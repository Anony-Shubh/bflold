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

<html>
<head>
   <title>PMEGP e-Tracking</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">

<script language="javascript">
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

</script>
</head>

<body>

<img src="../images/pmegponline.jpg" width="100%" height="150" >

<%
String SOFF_CD =(String) session.getAttribute("sOffCd");
String SDISTRICT_CD =(String) session.getAttribute("sDistrictCd");
String SAGENCY_TYPE = (String)session.getAttribute("sAgencyType"); 
String SOFF_NAME1 = (String) session.getAttribute("sOffName1");
try {
if (SOFF_NAME1==null||SOFF_NAME1.equals("")){
response.sendRedirect("convDltfcLogin.jsp");
}
	}catch (Exception m) {}		
	
	
	String vPending="0";
try{
 DBCon db1= new DBCon();
  db1.connect(); 
	    ResultSet rs2 = db1.execSQL("SELECT COUNT(*) FROM APP_DETAIL AD   WHERE AD.UNIT_DIST_CD   = "+SDISTRICT_CD+" AND AD.MTG_ID IS NULL AND FORD_DT_DLTFC IS NOT NULL AND ACT_ID=2");
		while (rs2.next()){
		vPending=rs2.getString(1);
		}
		rs2.close();
		db1.close();
		}catch(Exception e) {}
%>
<table align="center" class="pmegpTable" >
  <tr>
    <td colspan="11" nowrap><div align="center">
      <h2>PMEGP e-Tracking  DLTFC Convenor Login : <%= SOFF_NAME1 %>, AGENCY: <%= SAGENCY_TYPE %></h2>
    </div></td>
  </tr>
  <tr>
    <td colspan="10" nowrap><div class="blinker"> <center> No of Application Waiting for DLTFC Meeting :<%= vPending %> </center></div> </td>
  </tr>
  <tr>
  <td nowrap> <div align="center"><a href="ConvenorDLTFCHomePage.jsp"  class="greenButtonRound">Home</a></div></td>
    
    <td nowrap><a href="resetPassDLTFC.jsp" class="greenButtonRound">Change Password </a></td>
    <td nowrap><a href="dltfcPendingAppProcess.jsp" class="greenButtonRound">Pending for DLTFC Meeting</div> </a></td>
    <td nowrap>
	  <div align="center"><a href="MtgView.jsp" class="greenButtonRound"> Meeting Update  </a> </div></td>
    <td nowrap><div align="center"><a href="dltfcAppwiseUpdate.jsp" class="greenButtonRound">DLTFC Applicantwise Update </a></div></td>
    <td nowrap><a href="../pmegpmr/index.jsp" class="greenButtonRound">MIS Report </a></td>
    <td nowrap><div align="center"><a href="../pmegpeportaltutorialdoc/DLTFC_CONVENOR.pdf" class="greenButtonRound">User Manual </a></div></td>
    <td nowrap><div align="center"><a href="convDltfcLogin.jsp"  class="greenButtonRound">Logout/close</a></div></td>
  </tr>
</table>
