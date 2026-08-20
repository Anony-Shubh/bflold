<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.net.*"  %>


<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");%>
<html>
<head>
<title>PMEGP e-Tracking System Login Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>

<script language="javascript">
	

function validatePwd() {
var vusr = document.form1.usr.value;
var vpw = document.form1.pwd.value;


 if(vusr == '') {
    inlineMsg('usr','Enter User Name',2);
    return false;
  }else if(vpw == '') {
    inlineMsg('pwd','Enter Password',2);
    return false;
  }else {
  document.form1.submit();
  }
}//end of function
</script>
</head>

<body>
<form name="form1"  method="Post">
<% 
String msgStr="";

 
    
	String USER_ID = "";
	String DISTRICT_CD = "";
	String USER_DETAIL = "";
	String OFF_NAME1 = "";
	String STATE_CD="";
	String USER_TYPE="";
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	String CLIENTIP=request.getRemoteHost()==null?"NA":(String) request.getRemoteHost();
	
	if (UserCode !="" && pw !="") {
	
	try {
	
	 StringBuffer sb= new StringBuffer();
	sb.append (" SELECT MCU.USER_ID,MCU.USER_TYPE,MCU.USER_DETAIL FROM MMCLAIM_USER MCU WHERE MCU.ACT_YN = 'Y' AND MCU.USER_NAME=? AND  MCU.PASSWD=? ");
	

	List values=new ArrayList();
     values.add (UserCode); 
	 values.add (pw);
	 
	 String sbt=sb.toString();
	   DBCon db= new DBCon();
       db.connect();
	 ResultSet rs = db.executeSQL(sbt,values);
	 
	 int count=0;
	 
	 while (rs.next()){
	USER_ID=rs.getString("USER_ID")==null?"":rs.getString("USER_ID");
   USER_DETAIL=rs.getString("USER_DETAIL")==null?"":rs.getString("USER_DETAIL");
    USER_TYPE=rs.getString("USER_TYPE")==null?"":rs.getString("USER_TYPE");
	         session.setAttribute("SUSER_ID",USER_ID);
			 session.setAttribute("SUSER_DETAIL",USER_DETAIL); 
			  session.setAttribute("SUSER_TYPE",USER_TYPE); 
				session.setAttribute("SCLIENTIP",CLIENTIP);		
			count=count+1;
	 }
	 rs.close();
	 db.close();
	 if (count>0){
	  response.sendRedirect("mmclaimProcHomepage.jsp");
	 }else if (!(UserCode.equals("")&&pw.equals(""))){
	 msgStr="Login Failed...... ";
	 }
	 }catch (Exception e) {
	  out.print ( e.toString());
	 }
	 }// end if;
%>
<table align="center" width="100%">
<tr>
<th>
<img src="../images/pmegponlineN.jpg" width="100%"  >
</th>
</tr>

<table align="center">
  <tr>
    <td colspan="2">    </td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  
  <tr>
    <td colspan="2"><center><img src="../images/pmegpetrackN.png"></center></td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
    </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
  <tr > 
    <td colspan="2" > <div align="center" class="GreenLebel">
      <h2>PMEGP CLAIM PROCESS BY CENTRAL OFFICE </h2>
    </div></td>
    </tr>
  <tr>
    <th><div align="right">User ID:</div></th>
    <td ><input name="usr" type="text" id="usr" tabindex="1" maxlength="10" autocomplete="off"></td>
    </tr>
  <tr>
    <th ><div align="right">Password:</div></th>
    <td ><input name="pwd" type="password" id="pwd" tabindex="2" maxlength="10" autocomplete="off"></td>
    </tr>
  <tr>
    <td colspan="2" ><div align="center" class="redLebel"><%=msgStr%></div></td>
    </tr>
  <tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validatePwd()" value="Login">          
        </div>      </th>
    </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
    </tr>
  <tr> 
    <td colspan="2">     </td>
    </tr>
   
      <tr > 
        
    <th colspan="2" nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>

</form>
</body>
</html>
