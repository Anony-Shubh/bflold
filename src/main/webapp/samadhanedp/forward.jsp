<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"   %>
<HTML>
<head>
	<title>SAMADHAN ONLINE EDP TRAINIG</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/responsive.css">
</head>

<SCRIPT>	
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</SCRIPT>
<STYLE type="text/css">
<!--
.style4 {font-size: 24px}
.style5 {font-size: 18px}
-->
</STYLE>
</HEAD>

<BODY>
<FORM method="post" name="form" id="form"  >

<%

List values=new ArrayList();
List pstm=new ArrayList();
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String invupid =request.getParameter("invupid")==null?"0":(String)request.getParameter("invupid");

out.print(invupid);

%>

				<div class="login_head" align="center"><h5>Samadhan Online EDP training</h5></div>
				<div class="limiter" align="center">
		<div class="container-login100">
			
<TABLE width="600"  border="1" align="center" id="cont">

<TR>
  <TH width="635" height="53"><DIV align="center" class="style4">FINAL SUBMISSION</DIV></TH>
  </TR>

<TR>
  <TD height="217"><h3 align="center"> Do you want to Final Submit?</h3> <br>
    
    
        <INPUT name="ins" type="hidden" id="ins"  value="<%= ins %>">
 <div align="center">
        <INPUT name="Button"  type="button" class="login100-form-btn" onClick="submit_form();" value="FINAL SUBMIT">
		
      </div></TD>
  </TR>

</TABLE>
<BR/>
<DIV align="center"></DIV>
</div>
</div>
<%
if (ins.equals("I")) {
DBCon db= new DBCon();
db.connect();
StringBuffer qryUpdate = new StringBuffer();
qryUpdate.append("UPDATE BNF_ONLINEEDP_INF SET ");
qryUpdate.append("FORWARD_DT=SYSDATE");
qryUpdate.append(" WHERE invupid=?");
values.add(invupid); pstm.add ("L");


try{

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
}
 catch(Exception e){
out.print(e.toString());
	

}

response.sendRedirect("savemsg.jsp");
}
%>

</FORM>



</BODY>
</HTML>