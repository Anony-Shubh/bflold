<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script language="javascript">
function validatePwd() {
var vusr = document.form.usr.value;
var vpw = document.form.pwd.value;
 if(vusr == "") {
    inlineMsg('usr','Enter User Name',2);
    return false;
  }
  
 if(vpw == "") {
    inlineMsg('pwd','Enter Password',2);
    return false;
  }
  
 document.form.submit();
  
 
}//end of function
</script>
</head>

<body>
<form name="form" id="form"   method="Post">
<% 
   String msgStr="";
   DBCon db= new DBCon();
   db.connect();
 
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	String USER_NM="";
	String PASSWD="";
	String USER_DESC="";
	String IFSL_CODE="";
	if (!(UserCode.equals("") && pw.equals(""))) {
	try {
	 StringBuffer qry= new StringBuffer();
	 
	  qry.append(" SELECT USER_NM, PASSWD, USER_DESC, IFSL_CODE ");		   
			  qry.append("  FROM BU_USERMAST  ");
			   qry.append("  WHERE USER_NM = ?  AND PASSWD = ? ");
	 
	List values=new ArrayList();
     values.add (UserCode); 
	 values.add (pw);
	 
	
	 ResultSet rs = db.executeSQL(qry.toString(),values);
	 
	 int count=0;
	 
	 while (rs.next()){
	 	 USER_NM=rs.getString("USER_NM")==null?"":rs.getString("USER_NM");	    
		 USER_DESC=rs.getString("USER_DESC")==null?"":rs.getString("USER_DESC");
		 IFSL_CODE=rs.getString("IFSL_CODE")==null?"":rs.getString("IFSL_CODE");
	         session.setAttribute("sUSER_NM",USER_NM);
			 session.setAttribute("sUSER_DESC",USER_DESC);
			 session.setAttribute("sIFSL_CODE",IFSL_CODE);
			 count=count+1;
	 }
	 
	
	 if ( count>0) {
	response.sendRedirect("bankHomePage.jsp");

	} else{
	msgStr= "Login Fail........! <br><br> Please Enter Valid User Name and Password... ";
	 }
	 
	 
	 
	 }catch (Exception e) {
	  out.print ( e.toString());
	 }
	 
	 }//end validation
%>
<div align="center">
 <img src="../images/pmegponlineN.jpg" width="100%">
</div>
<br>
<table align="center">
  
  <tr>
    <td colspan="2"><center><img src="../images/pmegpetrackN.png"></center></td>
  </tr>
  
  <tr>
    <td colspan="2"><A href="../pmegphome/index.jsp" target="_parent" class="greenButtonRound">Home</A></td>
    </tr>
  
  

  
  
  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel">
      <h2>BANK NODAL OFFICER  LOGIN </h2>
    </div></th>
    </tr>
  <tr>
    <th><div align="right">User ID:</div></th>
    <td ><input name="usr" type="text" id="usr" tabindex="1" maxlength="20" autocomplete="off"></td>
    </tr>
  <tr>
    <th ><div align="right">Password:</div></th>
    <td ><input name="pwd" type="password" id="pwd" tabindex="2" maxlength="20" autocomplete="off"></td>
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
    <td colspan="2"><div align="center" class="mtextarea">for Technical assistance email to : pmegpeportal.kvic@gov.in </div></td>
    </tr>
  <tr> 
    <td colspan="2">     </td>
    </tr>
   
      <tr > 
        
    <th colspan="2" nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>
<%
//rs.close();
db.close();
%>
</form>
</body>
</html>
