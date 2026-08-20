<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>


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

<table align="center" width="100%">
<tr>
<th>
<img src="../images/pmegponlineN.jpg" width="100%"  >
</th>
</tr>
</table><center>
<%@ include file="edp_header.jsp" %>
<form name="form1"  method="Post" action="convDltfcLogin.jsp">
<% 
String msgStr="";
   DBCon db= new DBCon();
   db.connect();
 
    
	String OFF_CD = "";
	String DISTRICT_CD = "";
	String AGENCY_TYPE = "";
	String OFF_NAME1 = "";
	String STATE_CD="";
	
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	
	
	
	
	try {
	
	 StringBuffer sb= new StringBuffer();
	sb.append (" SELECT MOM.OFF_CD, ");
	 sb.append (" MOM.DISTRICT_CD, ");
	 sb.append (" MOM.AGENCY_TYPE, ");
	 sb.append (" MOM.OFF_NAME1 , MS.STATE_CD ");
	sb.append (" FROM MAS_OFF_MAST MOM,M_DISTRICT MD, M_STATE MS  WHERE ");
	sb.append (" MOM.DISTRICT_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND ");
	sb.append ("  MOM.U_NAME=? AND MOM.P_WORD=? AND MOM.CONV_DLTFCYN='Y' ");


	List values=new ArrayList();
     values.add (UserCode); 
	 values.add (pw);
	 
	 String sbt=sb.toString();
	
	 ResultSet rs = db.executeSQL(sbt,values);
	 
	 int count=0;
	 
	 while (rs.next()){
	OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
DISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
AGENCY_TYPE=rs.getString("AGENCY_TYPE")==null?"":rs.getString("AGENCY_TYPE");
OFF_NAME1=rs.getString("OFF_NAME1")==null?"":rs.getString("OFF_NAME1");
STATE_CD=rs.getString("STATE_CD")==null?"":rs.getString("STATE_CD");
	         session.setAttribute("sOffCd",OFF_CD);
			   session.setAttribute("sStatecd",STATE_CD);
			 session.setAttribute("sDistrictCd",DISTRICT_CD);
			session.setAttribute("sOffName1",OFF_NAME1); 
			session.setAttribute("sAgencyType",AGENCY_TYPE); 
			count=count+1;
	 }
	 rs.close();
	 db.close();
	 if (count>0){
	  response.sendRedirect("ConvenorDLTFCHomePage.jsp");
	 }else if (!(UserCode.equals("")&&pw.equals(""))){
	 
	 msgStr=" DLTFC Convenor User Name or Password Incorrect........ ";
	 }
	 }catch (Exception e) {
	 
	  out.print ( e.toString());
	 }
	 
	 
%>


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
    <td colspan="2" ><div align="right"><a href="../pmegphome/index.jsp" class="greenButtonRound">
	Home Page</a> </div></td>
    </tr>
  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel"><h2>DLTFC Convenor Login Form </h2></div></th>
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
