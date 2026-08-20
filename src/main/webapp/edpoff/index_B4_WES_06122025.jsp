<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<HTML>
<HEAD>
<TITLE>EDP Training Center Login Form</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT type="text/javascript" src="../js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript">
function validatePwd() {
var vusr = encodeURIComponent(document.form.usr.value);
var vpw = encodeURIComponent(document.form.pwd.value);
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
</SCRIPT>

<STYLE>
.notification {
  background-color: #bf980b;
  color: white;
  text-decoration: none;
  padding: 15px 26px;
  position: relative;
  display: inline-block;
  border-radius: 2px;
}

.notification:hover {
  background: red;
}

.notification .badge {
  position: absolute;
  top: -10px;
  right: -10px;
  padding: 5px 10px;
  border-radius: 50%;
  background-color: red;
  color: white;
}
</STYLE>

</HEAD>

<BODY>

 
<FORM name="form" id="form"   method="Post" >
<% 
String msgStr="";
   DBCon db= new DBCon();
   db.connect();
 
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	String OFF_CD="";
	String OFF_NAME="";
	String DISTRICT_CD="";
	String BENF_TYPE_DESC="";
	String OFF_TYPE_CD="";
	if (!UserCode.equals("")) {
	try {
	
	 StringBuffer sb= new StringBuffer();
	 
	 
	sb.append (" SELECT   A.OFF_CD, A.OFF_TYPE_CD, ");
 sb.append (" A.OFF_NAME, ");
 sb.append (" A.DISTRICT_CD ");
sb.append (" FROM MAS_OFF_MAST A ");
sb.append (" WHERE ACT_YN='Y' AND TRIM(U_NAME)=TRIM(?) AND TRIM(P_WORD)=TRIM(? )");


	List values=new ArrayList();
     values.add (UserCode); 
	 values.add (pw);
	 
	 String sbt=sb.toString();
	
	 ResultSet rs = db.executeSQL(sbt,values);
	 
	 int count=0;
	 
	 while (rs.next()){
	 
	 	 OFF_CD=rs.getString("OFF_CD")==null?"":rs.getString("OFF_CD");
	 OFF_NAME=rs.getString("OFF_NAME")==null?"":rs.getString("OFF_NAME");
	 DISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
	OFF_TYPE_CD=rs.getString("OFF_TYPE_CD")==null?"":rs.getString("OFF_TYPE_CD");
	 

	         session.setAttribute("SOFF_CD",OFF_CD);
			 session.setAttribute("SOFF_NAME",OFF_NAME);
			session.setAttribute("SDIST_CD",DISTRICT_CD); 
			session.setAttribute("SOFF_TYPE_CD",OFF_TYPE_CD); 
			

			count=count+1;
	 }
	 rs.close();
	 db.close();
	 if (count>0){
	  response.sendRedirect("edpHomePage.jsp");
	 }else if (!(UserCode.equals("")&&pw.equals(""))){
	 
	 msgStr=" User Name and Password incorrect........ ";
	 }
	 
	 
	  
	 }catch (Exception e) {
		  out.print ( e.toString());
	 }
	 
	 }//end of if user id is not null
%>

 <IMG src="../images/pmegponlineN.jpg" width="100%" />
 <br><br>
<TABLE align="center">

  <TR>
    <TD colspan="2">
	
	<DIV align="center">
	<A href="../pmegphome/Phy.verification.pdf" download class="notification">
  <SPAN>Download Physical verification and Geo tagging Letter</SPAN>
  <SPAN class="badge">New</SPAN>
</A></DIV>
	
	<DIV align="right"><A href="../jsp/loginPage.jsp">Home</A></DIV></TD>
    </TR>
  
  
  <TR > 
    <TH colspan="2" > <DIV align="center" class="GreenLebel">
      <H2>Login Form for EDP Training Center </H2>
    </DIV></TH>
    </TR>
  <TR>
    <TH><DIV align="right">User ID:</DIV></TH>
    <TD ><INPUT name="usr" type="text" id="usr" tabindex="1" maxlength="10" AUTOCOMPLETE="off"></TD>
    </TR>
  <TR>
    <TH ><DIV align="right">Password:</DIV></TH>
    <TD ><INPUT name="pwd" type="password" id="pwd" tabindex="2" maxlength="10" AUTOCOMPLETE="off"></TD>
    </TR>
   <TR>
    <TD colspan="2" ><DIV align="center" class="redLebel"><%=msgStr%></DIV></TD>
    </TR>
  <TR>
    <TH colspan="2" >
      <div align="center">
        <DIV align="center">
          <INPUT  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validatePwd()" value="Login">          
        </DIV>      </TH>
    </TR>
  <TR>
    <TD colspan="2">&nbsp;</TD>
    </TR>
  <TR> 
    <TD colspan="2">     </TD>
    </TR>
   
      <TR > 
        
    <TH colspan="2" nowrap>
      <DIV align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </DIV></TH>
      </TR>
</TABLE>

</FORM>
</BODY>
</HTML>
