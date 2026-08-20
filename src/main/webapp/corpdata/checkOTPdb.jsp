<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.math.*,org.apache.commons.lang3.StringUtils"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="../stylesheets/pmegpNew.css" />
<script language="javascript">
function save(){

window.parent.refreshpage();
}

</script>
</head>

<body>
  <input name="ins" type="hidden" id="ins">

<%
List values=new ArrayList();
String OTP =request.getParameter("OTP")==null?"":(String) request.getParameter("OTP"); 
String USER =(String)session.getAttribute("SUSER")==null?"":(String)session.getAttribute("SUSER");
	String msg="";	
		if(USER==null || USER==""){
%>

<h2 style="color:#990000 " align="center">Session Expired Please Login again.....</h2>

<%
}else{
		
DBCon db= new DBCon();
db.connect();
  
 values.add(USER);  
 values.add(OTP); 

 ResultSet rsSmast = db.executeSQL("select  otp from CORPMODULE_OTPGEN where  MOB_NO=? and otp=? and (TO_CHAR(sysdate,'HH24:MI:SS'))  between TO_CHAR(rtimestamp,'HH24:MI:SS') AND TO_CHAR((rtimestamp + interval '10' minute),'HH24:MI:SS') ",values);
		values.clear();	  
  while (rsSmast.next()) {
				OTP=rsSmast.getString("OTP")==null?"":rsSmast.getString("OTP");
 } rsSmast.close();
  db.close();



if( OTP.equals("") && OTP.equals("0") ){
msg="Incorrect OTP OR Your OTP has expired ..... ";

		response.sendRedirect("index_otp.jsp?MSG="+msg+"");

    }else{
		//USER_TYPE="BRADMIN";
	session.setAttribute("SOTP_TRID",OTP);

		response.sendRedirect("CORPBANK_GENEXCEL.jsp");
	}
	

	}
	%>
		 
</body>
</html>
