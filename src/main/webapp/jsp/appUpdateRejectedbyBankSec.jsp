<%@ page import="java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">
 var xmlhttpObject = null;
	function getXMLHTTPObject() {
       
        try {
                // For Old Microsoft Browsers
                xmlhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
                try {
                        // For Microsoft IE 6.0+
                        xmlhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e1) {
                        // No Browser accepts the XMLHTTP Object then false
                        xmlhttpObject = false;
                }
        }
        if (!xmlhttpObject && typeof XMLHttpRequest != 'undefined') {
                // For Mozilla, Opera Browsers
                xmlhttpObject = new XMLHttpRequest();
        }
        // Mandatory Statement returning the ajax object created
        return xmlhttpObject;
}

// Change the value of the outputText field
function setAjaxOutput() {
        document.getElementById('ajaxResponse').innerHTML = xmlhttpObject.responseText;
}

function handleServerResponse() {
        if (xmlhttpObject.readyState == 4) {
                if (xmlhttpObject.status == 200) {
                        setAjaxOutput();
                } else {
                        alert("Error during AJAX call. Please try again");
                }
        }
}

// Implement business logic
function doAjaxCall() {
ifsvalidreg=/^[A-Z|a-z]{4}[0][\d]{6}$/;
var ifs=document.getElementById('IFSC_CODE_SER').value;
if (Number(ifs.length) !=11) {
inlineMsg ('IFSC_CODE_SER' ,"Enter 11 digit IFS Code and 5th Place should be Zero");
return (false);
}


        xmlhttpObject = getXMLHTTPObject();
        if (xmlhttpObject != null) {
		param =document.getElementById('IFSC_CODE_SER').value;
                var URL = "ifsclov.jsp?IFSC_CODE_SER="+param;
                xmlhttpObject.open("POST", URL, true);
                xmlhttpObject.send(null);
                xmlhttpObject.onreadystatechange = handleServerResponse;
        }
}

function reforward() {
var IFSC_CODE=document.getElementById('IFSC_CODE').value;
var BRANCH_NAME=document.getElementById('BRANCH_NAME').value;
var BANK_POST_ADDR=document.form.BANK_POST_ADDR.value;
var BANK_DISTRICT=document.getElementById('BANK_DISTRICT').value;
var BANK_NAME=document.getElementById('BANK_NAME').value;

if (Number(IFSC_CODE.length) !=11) {
inlineMsg ('IFSC_CODE_SER' ,"Please Select Bank Details.......");
return (false);
}

if (BANK_NAME ="") {
inlineMsg ('BANK_NAME' ,"Bank Name Should be Blank");
return (false);
}
//inlineMsg ('BRANCH_NAME' ,BANK_NAME);
if (BRANCH_NAME ="") {
inlineMsg ('BRANCH_NAME' ,"BRANCH NAME Should be Blank");
return (false);
}

if (BANK_POST_ADDR ="") {
inlineMsg ('BANK_POST_ADDR' ,"Financing Branch Postal Detail  Should be Blank");
return (false);
}
//inlineMsg ('BANK_POST_ADDR' ,BANK_POST_ADDR);
if (BANK_DISTRICT ="") {
inlineMsg ('BANK_DISTRICT' ,"BANK DISTRICT  Should be Blank");
return (false);
}

document.form.ins.value="I";
form.submit();
}
</script>
<style>
body {
  font: normal medium/1.4 sans-serif;
}
table {
  border-collapse: collapse;
  width: 100%;
}
th, td {
  padding: 0.25rem;
  text-align: left;
  border: 1px solid #ccc;
}
tbody tr:nth-child(odd) {
  background: #eee;
}
</style>
</head>
<body>
<form  method="post"  name="form" id="form" action="appUpdateRejectedbyBankSec.jsp" >
    <table width="100%"  border="1" cellspacing="3" cellpadding="3">
     
      <tr>
        <th colspan="3" scope="row"><div align="center">Reject by Bank Applications Reforward to Financing Bank Branch Form </div></th>
      </tr>
      <tr>
        <td colspan="3" class="GreenLebel" scope="row"><div align="center">Note: Enter IFS Code and Click on &quot;Get Bank Detail &quot; button -&gt; The Bank Detail will display, Edit bank Address (if Required) and Clik on &quot;Forward to Bank&quot; button.</div></td>
      </tr>
      <tr>
        <th scope="row">Enter  IFS Code to Reforward the Application:        </th>
        <td><input name="IFSC_CODE_SER" type="text" id="IFSC_CODE_SER" size="11" maxlength="11">        </td>
        <td>
          <div align="left">
            <input name="Button" type="button" class="buttonGreen"  onClick="doAjaxCall();" value="Get Bank Detail and reforward">
            <input name="ins" type="hidden" id="ins" value="">
</div></td></tr>
      
     
      
    </table>
	<br>
	<div id="ajaxResponse">
	
	</div>
  
    <p>
      <%
  
  DBCon db= new DBCon();
db.connect();
  String APP_ID = request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
  StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT AD.APP_ID,"      );
qrysb.append("     UPPER(AD.APP_NAME) AS APP_NAME,"      );
qrysb.append("     AD.MOB_NO1,"      );
qrysb.append("     AD.MACHINARY_COST,"      );
qrysb.append("     AD.WORKING_CAPITAL,"      );
qrysb.append("     AD.BANK_NAME,"      );
qrysb.append("     AD.BANK_POST_ADDR,"      );
qrysb.append("     AD.BANK_TALUK_BLOCK,"      );
qrysb.append("     AD.BANK_PINCD,"      );
qrysb.append("     AD.IFSC_CODE,"      );
qrysb.append("     AD.ONLINE_SUBDT,"      );
 qrysb.append("   CASE WHEN (NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0))=0 THEN"      );
 qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0)"      );
 qrysb.append("   ELSE NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0) END TOTAL_PROJCOST,"      );
qrysb.append("     AD.PAN_NO,"      );
qrysb.append("     BD.BANK_REC_DT,"      );
qrysb.append("     BD.BANK_REMARKS,"      );
qrysb.append("     AD.BRANCH_NAME,"      );
qrysb.append("     AD.BANK_DISTRICT,"      );
qrysb.append("     AD.ACTIVITY_CD,"      );
qrysb.append("     CASE WHEN AD.IND_TYPE='M' THEN 'Manufacturing' WHEN AD.IND_TYPE='M' THEN 'Service' WHEN AD.IND_TYPE='T' THEN 'Trading' END IND_TYPE ,"      );
qrysb.append("     AD.BANK_F_DATE,"      );
qrysb.append("     AD.IFSC_CODE2,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     RBL.BANK_NAME AS BANK_NAME2,"      );
qrysb.append("     RBL.BRANCHNAME AS BRANCHNAME2 ,"      );
qrysb.append("     RBL.ADDRESS AS ADDRESS2,"      );
qrysb.append("     RBL.CENTRE AS CENTRE2,"      );
qrysb.append("     RBL.DISTRICT AS DISTRICT2,"      );
qrysb.append("     RBL.STATE AS STATE2,"      );
qrysb.append("     RBL.EMAIL AS EMAIL2,"      );
qrysb.append("  UPPER(AM.ACTIVITY_NAME) AS ACTIVITY_NAME,"      );
 qrysb.append("  UPPER(AD.PROD_DESC) AS PROD_DESC"      );
qrysb.append("   FROM APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     RBIBANKLIST RBL, ACTIVITY_MAST AM "      );
qrysb.append("   WHERE AD.APP_ID   = BD.APP_ID AND AM.ACTIVITY_CD=AD.ACTIVITY_CD "      );
qrysb.append("   AND AD.IFSC_CODE2 = RBL.IFSC_CODE(+)"      );
qrysb.append("   AND AD.OFF_CD     = MOM.OFF_CD"      );
qrysb.append("   AND AD.APP_ID LIKE '"+APP_ID+"'"      );
qrysb.append("   AND AD.ACT_ID = 5"      );
qrysb.append("   AND BD.ACT_ID = 3"      );
//out.print(qrysb.toString());
ResultSet rsMain = db.execSQL(qrysb.toString());

String APP_NAME = "";
String MOB_NO1 = "";
String MACHINARY_COST = "";
String BANK_POST_ADDR = "";
String BANK_TALUK_BLOCK = "";
String BANK_PINCD = "";
String MTG_ID = "";
String IFSC_CODE = "";
String ONLINE_SUBDT = "";
String DLTFC_CE = "";
String DLTFC_WC = "";
String PAN_NO = "";
String BANK_REC_DT = "";
String BANK_REMARKS = "";
String BRANCH_NAME = "";
String BANK_DISTRICT = "";
String ACTIVITY_CD = "";
String IND_TYPE = "";
String BANK_F_DATE = "";
String IFSC_CODE2 = "";
String AADHAR_NO = "";
String BANK_NAME2 = "";
String BRANCHNAME2 = "";
String ADDRESS2 = "";
String CENTRE2 = "";
String DISTRICT2 = "";
String STATE2 = "";
String EMAIL2 = "";
String WORKING_CAPITAL="";
String BANK_NAME="";
String ACTIVITY_NAME="";
String PROD_DESC="";
String TOTAL_PROJCOST="";
  while(rsMain.next())
  { 
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
MACHINARY_COST=rsMain.getString("MACHINARY_COST")==null?"":rsMain.getString("MACHINARY_COST");
WORKING_CAPITAL=rsMain.getString("WORKING_CAPITAL")==null?"":rsMain.getString("WORKING_CAPITAL");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
BANK_POST_ADDR=rsMain.getString("BANK_POST_ADDR")==null?"":rsMain.getString("BANK_POST_ADDR");
BANK_TALUK_BLOCK=rsMain.getString("BANK_TALUK_BLOCK")==null?"":rsMain.getString("BANK_TALUK_BLOCK");
BANK_PINCD=rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
//MTG_ID=rsMain.getString("MTG_ID")==null?"":rsMain.getString("MTG_ID");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
ONLINE_SUBDT=rsMain.getString("ONLINE_SUBDT")==null?"":rsMain.getString("ONLINE_SUBDT");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
BANK_REC_DT=rsMain.getString("BANK_REC_DT")==null?"":rsMain.getString("BANK_REC_DT");
BANK_REMARKS=rsMain.getString("BANK_REMARKS")==null?"":rsMain.getString("BANK_REMARKS");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
BANK_DISTRICT=rsMain.getString("BANK_DISTRICT")==null?"":rsMain.getString("BANK_DISTRICT");
ACTIVITY_CD=rsMain.getString("ACTIVITY_CD")==null?"":rsMain.getString("ACTIVITY_CD");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
BANK_F_DATE=rsMain.getString("BANK_F_DATE")==null?"":rsMain.getString("BANK_F_DATE");
IFSC_CODE2=rsMain.getString("IFSC_CODE2")==null?"":rsMain.getString("IFSC_CODE2");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
BANK_NAME2=rsMain.getString("BANK_NAME2")==null?"":rsMain.getString("BANK_NAME2");
BRANCHNAME2=rsMain.getString("BRANCHNAME2")==null?"":rsMain.getString("BRANCHNAME2");
ADDRESS2=rsMain.getString("ADDRESS2")==null?"":rsMain.getString("ADDRESS2");
CENTRE2=rsMain.getString("CENTRE2")==null?"":rsMain.getString("CENTRE2");
DISTRICT2=rsMain.getString("DISTRICT2")==null?"":rsMain.getString("DISTRICT2");
STATE2=rsMain.getString("STATE2")==null?"":rsMain.getString("STATE2");
EMAIL2=rsMain.getString("EMAIL2")==null?"":rsMain.getString("EMAIL2");
ACTIVITY_NAME=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
PROD_DESC=rsMain.getString("PROD_DESC")==null?"":rsMain.getString("PROD_DESC");
TOTAL_PROJCOST=rsMain.getString("TOTAL_PROJCOST")==null?"":rsMain.getString("TOTAL_PROJCOST");
}
rsMain.close();
db.close();
  %>
  <p>    
  <table>
  <tr>
    <td scope="row">Applicant id 
      <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>"></td>
    <td><%= APP_ID %></td>
    <td>Applicant name </td>
    <td><%= APP_NAME %></td>
  </tr>
  <tr>
    <td scope="row">Adhaar/ PAN No:</td>
    <td><%= AADHAR_NO %> / <%= PAN_NO %></td>
    <td>Mobile No: </td>
    <td><%= MOB_NO1 %></td>
  </tr>
  <tr>
    <td scope="row">Proposed Project Cost: </td>
    <td><%= TOTAL_PROJCOST %></td>
    <td>Meeting ID </td>
    <td> <%= MTG_ID %></td>
  </tr>
  <tr>
    <td scope="row">Industry Detail: </td>
    <td colspan="3"><%= ACTIVITY_NAME %>,<%= PROD_DESC %>,<%= IND_TYPE %></td>
    </tr>
  <tr>
    <td scope="row"> Forwarding Date to 1st Bank </td>
    <td><%= BANK_F_DATE %></td>
    <td>2ND Bank IFS Code: </td>
    <td><H2 class="mtextarea"><%= IFSC_CODE2 %></H2></td>
  </tr>
  <tr>
    <td scope="row">1st Bank IFS Code: </td>
    <td colspan="3" class="OrangeLebel"><%= IFSC_CODE %></td>
  </tr>
  <tr>
    <td scope="row">Bank Name </td>
    <td colspan="3"><%= BANK_NAME %></td>
  </tr>
  <tr>
    <td scope="row">Branch Name </td>
    <td colspan="3"><%= BRANCH_NAME %></td>
  </tr>
  <tr>
    <td scope="row">Rejected Reason: </td>
    <td colspan="3" class="redLebel"><%=  BANK_REMARKS%></td>
  </tr>
</table>
<%
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String PBANK_NAME=request.getParameter("BANK_NAME")==null?"":(String) request.getParameter("BANK_NAME");
String PIFSC_CODE=request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE");
String PBRANCH_NAME=request.getParameter("BRANCHNAME")==null?"":(String) request.getParameter("BRANCHNAME");
String PADDRESS=request.getParameter("ADDRESS")==null?"":(String) request.getParameter("ADDRESS");
String PBANK_DISTRICT=request.getParameter("DISTRICT")==null?"":(String) request.getParameter("DISTRICT");
String PBANK_POST_ADDR=request.getParameter("BANK_POST_ADDR")==null?"":(String) request.getParameter("BANK_POST_ADDR");

if (ins.equals("I")){

try {
 Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
Connection conn=ds.getConnection(); 

CallableStatement cs = conn.prepareCall("{call  PROCEDURE_REFORWARDTOBANKSEC  (?,?,?,?,?,?)}");


 cs.setString(1,APP_ID); 
	cs.setString(2,PIFSC_CODE);
	cs.setString(3,PBANK_NAME);
	cs.setString(4,PBRANCH_NAME);
	cs.setString(5,PBANK_DISTRICT );
	cs.setString(6,PBANK_POST_ADDR );
      cs.executeQuery();
cs.close();
conn.close();

response.sendRedirect("PMEGPGenAppForm.jsp?RNAME=SecondBankForwardingLetter&APP_ID="+APP_ID+"");

}catch (Exception b) {
out.print (b.toString());
}

}//END INS


%>
</form>
</body>

</html>