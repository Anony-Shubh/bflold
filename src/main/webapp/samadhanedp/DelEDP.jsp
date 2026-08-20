<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%><head><head>
	<title>SAMADHAN ONLINE EDP TRAININIG</title>
	

	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/responsive.css">
</head>

<script language="javascript">




function submitform() {


  

var DEL_REMARKS = form.DEL_REMARKS.value; 





 
  
  
  if (DEL_REMARKS == "")   {	 alert ( 'please enter Remarks ',2);	return (false);} 
	
	


document.form.ins.value='I';
document.form.submit();

}
</script>




<style>

<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: auto;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 4px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

.readonlytext {
 border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}


.style1 {font-weight: bold}
</style>
</style>


</head>
<body>
<form method="post"  name="form" id="form" class="form"  >


<%
List values=new ArrayList(); 


String off_cd=request.getParameter("off_cd")==null?"0":(String)request.getParameter("off_cd") ;


String invupid =request.getParameter("invupid")==null?"0":(String)request.getParameter("invupid");


String invno=request.getParameter("invno")==null?"0":(String)request.getParameter("invno");
String inv_date="";
String DEL_REMARKS="";
String INVUPID="";
String add_update="I";
String ins=request.getParameter("ins")==null?"I":(String) request.getParameter("ins");



 DBCon db= new DBCon();
      db.connect(); 



%>
<body>

<table align="center" border="1" id="cont">
<div class="limiter" align="center">
		<div class="container-login100" align="center">
<div class="wrap-login100" align="center">
				<div class="login_head"><h5>Samadhan Online EDP training</h5></div>
				<form class="login100-form validate-form">
<input name="ins" type="hidden" id="ins" value="<%= ins %>"></td>
<tr align="left">
  <td class="style1"></tr>
<table  align="center" cellpadding="2" cellspacing="2"  id="cont1" >
  
  <tr>
    <td align="center">&nbsp;</td>
    <td  align="center" colspan="2">Delete Invoice </td>
    </tr>
  <tr>
    <td align="center"><strong>(1)</strong></td>
    <td><strong>Invoice No:</strong></td>
    <td><input type="text"  name="inv_no" id="inv_no"  value="<%=invno%>" required />
	<input type="hidden"  name="invupid" id="invupid"  value="<%=invupid%>"  /></td>
    </tr>
  <tr>
    <td align="center"><strong>(2)</strong></td>
    <td><strong>Delete Remarks: </strong></td>
    <td><input  type="text"  name="DEL_REMARKS" id="DEL_REMARKS" value="<%=DEL_REMARKS%>"    /></td>
    </tr>
  <br>
  <tr>
    <td colspan="3" class="style1" align="center"><div align="center">
      <input name="button" type="button" class="login100-form-btn"  onClick="submitform();" value="Delete " />    
    </div></td>
  </tr>
</table>

   <%
   List pstm=new ArrayList();
   if ((String)request.getParameter("ins")!=null){

DEL_REMARKS=(String) request.getParameter("DEL_REMARKS")==null?"":(String) request.getParameter("DEL_REMARKS").trim();
INVUPID=(String) request.getParameter("invupid")==null?"":(String) request.getParameter("invupid").trim();


StringBuffer qryEXR = new StringBuffer();

qryEXR.append("INSERT INTO bnf_onlineedp_inf_del (INVUPID,  OFF_CD,  UPDOC_EDP,  TOTAL_INV_AMT,  GST_AMT,  TOTAL_AMT,  MONTH_DT,  UPLOAD_TIMESTAMP,  FORWARD_DT,  ACT_YN,  EDP_NO,  INV_NO,  INV_DATE,  FOPAY_DT,  FOPAY_AMT,  PAYDETAILS,  ANY_REMARKS,  FO_DISALLOWMENT,  TDS_AMT,DEL_REMARKS,DEL_TIMESTAMP) SELECT b.INVUPID,  b.OFF_CD,  b.UPDOC_EDP,  b.TOTAL_INV_AMT,  b.GST_AMT,  b.TOTAL_AMT,  b.MONTH_DT,  b.UPLOAD_TIMESTAMP,  b.FORWARD_DT,  b.ACT_YN,  b.EDP_NO,  b.INV_NO,  b.INV_DATE,  b.FOPAY_DT,  b.FOPAY_AMT,  b.PAYDETAILS,  b.ANY_REMARKS,  b.FO_DISALLOWMENT,  b.TDS_AMT,  ? AS DEL_REMARKS ,SYSDATE AS DEL_TIMESTAMP from bnf_onlineedp_inf b WHERE INVUPID=?");


values.add(DEL_REMARKS); pstm.add ("L");
values.add(INVUPID); pstm.add ("L");



db.setSqlValue(qryEXR.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();

try {




StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append("DELETE FROM bnf_onlineedp_inf WHERE INVUPID=? AND FOPAY_DT IS NULL AND FOPAY_AMT IS NULL");
values.add(INVUPID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();

response.sendRedirect("savemsg.jsp");

}
catch(Exception e){

response.sendRedirect("savemsg.jsp");
//response.sendRedirect("failed_deleted_msg_GS.jsp?ACCTRID="+ACCTRID);


}
	


//}
//else{
//out.print("<br><br><br><span style='color:red;font-size:18px'><center>Bill cannot be deleted since payment already been paid..</center></span>");
//}

     db.close();
   }
  
  %>  

</form>

</body>
 
</html>


