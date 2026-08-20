
<%@ page session="true" import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<title>FB Profile View Page</title>
 <link rel="stylesheet" type="text/css" href="../css/dis.css">
 <link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
  <script>
  function form_submit(){  
	var APP_ID = document.form.APP_ID.value;
	if (APP_ID== "") {	 inlineMsg ( 'APP_ID','ENTER APPLICATION ID',2);	return (false);}    	
	document.form.submit();

}


</script>
</head>
<body >

<form  method="post"  name="form" action="KvicGenChaln.jsp" >	
<%@ include file="IncludeHeader.jsp" %>
    <div align="center">
      <p>
        <%
  String APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
  

String IFSC_CODE="";
String BANK_NAME="";
String MM_REL_DT="";

//String APP_ID="";

String APP_NAME="";
String DISTRICT_NAME="";
String STATE_NM="";
String OFF_NAME1="";
String PAY_STATUS="";
String MM_REL_AMT="";
String FAIL_REASON="";
String VERIFYAPP_CNT ="";
String verifyapp_chk="";
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();

qrysb.append(" SELECT (select  count(*) from indbank_request where substr(txnid,3,length(txnid))=substr(ad.app_id,instr(ad.app_id,'-')+1,length(ad.app_id)) AND UPPER(STATUS) NOT IN ('NOT FOUND' ,'FAILURE')   ) as verifyapp_cnt,(select  count(*) from indbank_request where substr(txnid,3,length(txnid))=substr(ad.app_id,instr(ad.app_id,'-')+1,length(ad.app_id)) and FIELD5='By KVIC'   ) as verifyapp_chk,to_char(bd.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT,  ad.APP_ID,  ad.APP_NAME,  bd.MM_REL_AMT, ");
qrysb.append("  dm.DISTRICT_NAME,  ms.STATE_NM,  mom.OFF_NAME1,  bd.PAY_STATUS,  bd.FAIL_REASON,  rbi.BANK_NAME, ");
qrysb.append("  rbi.IFSC_CODE FROM APP_DETAIL ad,  BANK_DATAENTRY bd,  M_DISTRICT dm,  M_STATE ms,  MAS_OFF_MAST mom,  rbibanklist rbi ");
qrysb.append(" WHERE ad.APP_ID     = bd.APP_ID(+) ");
qrysb.append(" AND ad.UNIT_DIST_CD = dm.DISTRICT_CD ");
qrysb.append(" AND dm.STATE_CD     = ms.STATE_CD ");
qrysb.append("  AND ad.OFF_CD       = mom.OFF_CD ");
qrysb.append(" AND bd.IFSC_CODE    = rbi.IFSC_CODE ");
qrysb.append(" AND (bd.MM_REL_DT  IS NOT NULL ");
qrysb.append(" AND bd.PACT_ID      = 34)  AND TO_NUMBER(substr(ad.App_id,instr(ad.App_id,'-')+1,length(ad.app_id)))=?  ");
//BR_IFSL_CODE=BR_IFSL_CODE.toUpperCase();
List values=new ArrayList();
values.add(APP_ID);	


 int count=0; 

			
ResultSet rsMain =db.executeSQL(qrysb.toString(),values); 
values.clear();

 while (rsMain.next()) {

IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
verifyapp_chk=rsMain.getString("verifyapp_chk")==null?"":rsMain.getString("verifyapp_chk");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");

APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
PAY_STATUS=rsMain.getString("PAY_STATUS")==null?"":rsMain.getString("PAY_STATUS");
MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
FAIL_REASON=rsMain.getString("FAIL_REASON")==null?"":rsMain.getString("FAIL_REASON");
VERIFYAPP_CNT =rsMain.getString("verifyapp_cnt")==null?"":rsMain.getString("verifyapp_cnt");
count=count+1;
}
rsMain.close();


		
%>
      </p>
      <p>&nbsp;</p>
    </div>
	<p></p>
<p></p>
<p></p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th colspan="4"><div align="center">Generate Challan  ( <%= USER_NM%> Login)
     
  </div></th>
  </tr>
 <tr>
  <th height="43" align="left" nowrap bgcolor="#CCCCCC" >   <input name="ins" type="hidden" id="ins" value="">
    APPLICANT ID     *</th>
   
	<td bgcolor="#CCCCCC"><input name="APP_ID"  id="APP_ID" placeholder="SEARCH" size="12" maxlength="12">	</td>
    <td bgcolor="#CCCCCC"><input name="Button" type="button" class="button" onClick="form_submit();" value="SEARCH"></td>
 </tr>
	
	<tr>
	<th colspan="4">&nbsp;</th>                              
	</tr>
  </table> 
  
  
   <% if (!APP_ID.equals("")) { if (count > 0){ %>
 <table width="878" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th colspan="15"><div align="center">APPLICANT DETAIL </div></th>
  </tr>
  <tr>
   <td nowrap bgcolor="#CCCCCC">APP ID </td>
   <td nowrap bgcolor="#CCCCCC">APP NAME </td>
   <td nowrap bgcolor="#CCCCCC">OFFNAME</td>
   <td nowrap bgcolor="#CCCCCC">DISTRICT</td>
   <td nowrap bgcolor="#CCCCCC">STATE</td>
   <td nowrap bgcolor="#CCCCCC">MM RELEASE DATE </td>
   <td nowrap bgcolor="#CCCCCC">MM RELEASE AMT </td>
   <td nowrap bgcolor="#CCCCCC">BANK NAME </td>
   <td nowrap bgcolor="#CCCCCC">IFSC CODE </td>
   <td nowrap bgcolor="#CCCCCC">STATUS</td>
   <td nowrap bgcolor="#CCCCCC">CHALLAN GENERATED</td>
    <td nowrap bgcolor="#CCCCCC">CHALLAN</td>
  </tr>
  <tr>
  <td><%=APP_ID%></td>
  <td><%=APP_NAME%></td>
  <td><%=OFF_NAME1%></td>
  <td><%=DISTRICT_NAME%></td><td><%=STATE_NM%></td><td><%=MM_REL_DT%></td><td><%=MM_REL_AMT%></td><td><%=BANK_NAME%></td><td><%=IFSC_CODE%></td><td><%=PAY_STATUS%></td>
  <td>
  <% if (verifyapp_chk.equals("0")){%>
  NO
  <%} else{%>
  YES
  <%}%>
  
   </td>
  <td>
   <% if(VERIFYAPP_CNT.equals("0") || VERIFYAPP_CNT.equals("")){ %>
  <DIV align="center"><A  href="KvicGencHk.jsp?APP_ID=<%= APP_ID %>&TYPE=R&VERIFYC=<%=VERIFYAPP_CNT%>" class="greenButtonRound">Generate Challan</A></DIV>
   <%} else{%>
	  <DIV align="center"><A  href="KvicGencHk.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Verify Payment Status</A></DIV>	
	  <%}%>
  
  </td>
  </tr>
  </table>
 <%} else{ %>
   <div align="center"><H2>ID is invalid/Margin Money Not yet Released</H2></div>
  <%}}%>
 
</form>
 
</body>
</html>
