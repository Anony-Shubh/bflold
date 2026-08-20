<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="E:\tomcat5\webapps\pmegpaward\css\menu.css"> -->
<head>
<script language="javascript">
function closeAndRefresh(){
   window.parent.refreshpage();  
    }
</script>
<style>
.topnav {
  
  background-color:	#3f506e;
  overflow: hidden;
}
#myTopnav{background-color:#4CAF50;;}

/* Style the links inside the navigation bar */
.topnav a {
  float: left;
  display: inline-block;
  color: #FFFFFF;
  text-align: center;
  text-transform: uppercase;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 18px;
  font-family: Arial Black, sans-serif;
  border: 1px solid #bbb;
}

/* Change the color of links on hover */
.topnav a:hover {
  background-color: #8B9DC3;
  color: #FFFFFF;
  border: black;
}

/* Add an active class to highlight the current page */
.topnav a.active {
  background-color: #000000;
  color: #333333;
}

/* Hide the link that should open and close the topnav on small screens */
.topnav .icon {
  display: none;
}
</style>


<title></title>

</head>
<body>

<%
String sAPP_IDnew=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");

if(sAPP_IDnew.equals("0")){
response.sendRedirect("logout.jsp")	;
}

%>

<img src="images/nomination.jpeg" width="100%" style="border: 5px solid #555;" >
<div class="topnav" >
 <a href="curr_status.jsp">HOME</a>
 <a href="award_guidelines.jsp">Read Eligibility Criteria</a>
  <a href="Dataentry.jsp">(1)Unit Profile</a>
  <a href="nomination.jsp" id="myTopnav">(2)Nomination Form</a>

<a href="upload.jsp">(3)Upload Document</a>
  <a href="final_sub.jsp">(4)Final Submission</a>
   <a href="logout.jsp">Logout</a>


</div>


</FORM>
</BODY>
</HTML>









