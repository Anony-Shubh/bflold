<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <title>New Loan Application</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link href="css/style.css" rel="stylesheet" />
    <link href="Media Query/media.css" rel="stylesheet" />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap"
      rel="stylesheet"
    />
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
    <header class="top-banner mt-1 mb-1" style="width: 100%">
      <div class="container-fluid">
     <img src="images/cftri.jpeg" width="100%" height="250" border="" ></div>
      </div>
    </header>
	<div>&nbsp;</div>
<div class="outerDiv">
  <div class="row">
    <div class="col-lg-4">
<div class="form1" >
<ul>  
<strong>Benefits of onboarding CFTRI for FPI Training:  </strong>
<li>Product development and product efficiency</li>
<li>Enable economies of scale production</li>
<li>Reduce wastages by integration of value chain</li>
<li>Better product lifecycle management</li>
<li>Capacity building / Skilling of workforce</li>
<li>Collaboration with multiple stakeholders</li>
<li>Exposure to cold chain facilities</li>
<li>Improved infrastructure of units</li>
<li>Automation in food processing Industry</li>
<li>Market Assistance</li></ul>
</div>
</div>
<div class="col-lg-4">
 	<FORM  class="form3" action="index.jsp" method="post">      
 <% 
String msgStr="";
  
 
    String UserCode=request.getParameter("username")==null?"":(String) request.getParameter("username");
    String pw = request.getParameter("password")==null?"":(String) request.getParameter("password");
	String ACT_ID="";
	String APP_ID="";
	String APP_NAME="";
	String BENF_TYPE_DESC="";
	String MOB_NO1="";
	if (!UserCode.equals("")) {
	try {
	
	 StringBuffer sb= new StringBuffer();


sb.append (" SELECT  AD.APP_ID,  AD.APP_NAME, AD.MOB_NO1 ");
sb.append (" FROM APP_DETAIL AD,BANK_DATAENTRY BD,activity_mast am,ind_grp_mast igm  ");
sb.append (" WHERE AD.APP_ID=BD.APP_ID AND BD.PACT_ID=34 AND AD.ACT_YN='Y' AND BD.MM_REL_DT is not null and igm.ind_grp_cd=4    ");
sb.append (" AND TO_NUMBER(substr(AD.App_id,instr(AD.App_id,'-')+1,length(AD.app_id))) =?   AND ad.ACTIVITY_CD=am.ACTIVITY_CD AND am.IND_GRP_CD= igm.IND_GRP_CD ");
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
	  response.sendRedirect("cftriform.jsp");
	 }else if (!(UserCode.equals("")&& pw.equals(""))){
	 
	 msgStr=" User Name and Password incorrect........ ";
	 }
	 
	 
	  
	 }catch (Exception e) {
		  out.print ( e.toString());
	 }
	 
	 }//end of if user id is not null
%>

      <label for="username">Username :</label>
      <input type="text" class="login-input" placeholder="Enter Username" id="username" name="username"  />

      <label for="password">Password :</label>
      <input type="password" class="login-input" placeholder="Enter Password" id="password" name="password" />
     <div align="center"> <button><INPUT type="submit" value="Login" style="color:#FFFFFF;" ></button></div>
	  <div align="center"><a href=""></a></div>
	 <div align="center"><A href="appFogpn.jsp" style="color:#333399">Forgot your password</A>  
      <button style="height:40px;"><a href="indexho.jsp" style="color:#FFFFFF;" >OFFICIAL LOGIN</a></button></div>
	
		<div align="center"> 
                <%
    if(null!=request.getAttribute("errorMessage"))
    {
      %>   
      <CENTER>  <H5 style="color: red"><%=request.getAttribute("errorMessage") %></H5></CENTER>
 <%   }
%>
	
	</div>
	
    </form>
	</div>
	<div class="col-lg-4">

	<div class="form2" >
<ul>
  <strong>Eligibility criteria for training:  </strong>
  <li>The PMEGP Applicant should have availed loan under food processing Industry.</li>
  <li>Margin Money (Government Subsidy) should have been released.</li>
  <li>Applicant who have applied online w.e.f  01st July 2016.</li>
</ul>  
<ul>
  <strong>Facilities:  </strong>
  <li>Accommodation, Food, Training material will be provided by KVIC, however, travelling expenses Shall be incurred by beneficiary him/her self.</li>
  <li>Training for 5 days will be conducted at Central Food Technological Research Institute (CFTRI), Mysore.</li>
  <li>Contact details: 
Coordinator, Short Term Courses, Phone No. : 0821-2514310, Mail: stc@cftri.res.in.</li>
 <li>To learn more about CFTRI please visit website: <a href="https://cftri.res.in/">https://cftri.res.in/</a> </li>
</ul></div>
</div>
</div>
</div>
    <!--------------Footer Section  start  ---------->



    <footer>
      <div class="container-fluid">
        <div class="footer-content">
          <p>
            DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY,
            KVIC, MUMBAI
            <!-- <span class="email">( pmegpeportal.kvic@gov.in )</span> -->
          </p>
        </div>
      </div>
    </footer>

    <!----------------Footer Section End---------------->
    <script src="js/popper.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.ticker.js" type="text/javascript"></script>
  </body>
</html>

