<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP National Award</title>


    <!-- Custom styles for this template -->
    <LINK href="css/simple-sidebar1.css" rel="stylesheet">
	<LINK rel="stylesheet" href="css/animate.css">
	<LINK rel="stylesheet" href="css/style.css">

<SCRIPT language="javascript">
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
</SCRIPT>

</head>
	
<body>
<img src="images/nomination.jpeg" width="100%" style="border: 5px solid #555;">

<FORM name="form1"  method="Post" action="index.jsp">
<% 
String msgStr="";
  
 
    String UserCode=request.getParameter("usr")==null?"":(String) request.getParameter("usr");
    String pw = request.getParameter("pwd")==null?"":(String) request.getParameter("pwd");
	String ACT_ID="";
	String APP_ID="";
	String APP_NAME="";
	String BENF_TYPE_DESC="";
	String MOB_NO1="";
	if (!UserCode.equals("")) {
	try {
	
	 StringBuffer sb= new StringBuffer();

sb.append ("SELECT  AD.APP_ID,  AD.APP_NAME, AD.MOB_NO1 ");
sb.append ("FROM APP_DETAIL AD,BANK_DATAENTRY BD  ");
sb.append ("WHERE AD.APP_ID=BD.APP_ID AND BD.PACT_ID=34 AND AD.ACT_YN='Y' AND TRUNC(bd.loan_sanc_dt) <'31-MAR-2021' ");
sb.append ("AND TO_NUMBER(substr(AD.App_id,instr(AD.App_id,'-')+1,length(AD.app_id))) =? ");
sb.append ("AND AD.APP_PWD = ? ");



	List values=new ArrayList();
     values.add (UserCode); 
	 values.add (pw);
	 
	 String sbt=sb.toString();
	  DBCon db= new DBCon();
   db.connect();
	 ResultSet rs = db.executeSQL(sbt,values);
	 
	 int count=0;
	 
	 while (rs.next()){
	 
	 	 APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
	 APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	//ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	MOB_NO1=rs.getString("MOB_NO1")==null?"":rs.getString("MOB_NO1");
	
	 

	         session.setAttribute("sAPP_ID",APP_ID);
			 session.setAttribute("sAPP_NAME",APP_NAME);
			session.setAttribute("sBENF_TYPE_DESC",BENF_TYPE_DESC); 
			session.setAttribute("sACT_ID",ACT_ID); 

			count=count+1;
	 }
	 rs.close();
	 db.close();
	 if (count>0){
	  response.sendRedirect("award_guidelines.jsp");
	 }else if (!(UserCode.equals("")&&pw.equals(""))){
	 
	 msgStr=" User Name and Password incorrect........ ";
	 }
	 
	 
	  
	 }catch (Exception e) {
		  out.print ( e.toString());
	 }
	 
	 }//end of if user id is not null
%>
<br>
 <DIV align="center" >
<a href="../pmegphome/index.jsp">&#8617; BACK</a>
</DIV>
  
        <!-- Page Content -->
		
            <DIV class="container-fluid" >
								
			 		<DIV class="login-box animated fadeInUp">
			<DIV class="box-header" style="background-color:black">
				<H6 >APPLICANT Login</H6>
			</DIV>
			<LABEL for="username" style="color:black;">Username</LABEL>
			
			<INPUT name="usr" type="text" id="usr" tabindex="1" maxlength="10">
			<BR/>
			<LABEL for="password" style="color:black;">Password</LABEL>
			
			<INPUT name="pwd" type="password" id="pwd" tabindex="2" maxlength="10">
			<BR>
			 <INPUT name="btnLogIn"  type="button"   class="button" id="btnLogIn"  style="background-color:#000000;"  tabindex="3" onClick="validatePwd()" value="Login"> 
		
	<BR>
			<A href="appFogpn.jsp" style="color:#333399">Forgot your password?</A> <BR><BR>
			
			<a class="button" href="view2.jsp">OFFICIAL LOGIN</a>


	    	 <P id="error"></P>
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
      <CENTER>  <H5 style="color: red"><%=request.getAttribute("errorMessage") %></H5></CENTER>
 <%   }
%>
		</DIV>
	</DIV>







</FORM>

	
</body>
</html>



