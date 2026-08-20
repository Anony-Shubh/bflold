<%@ include file="appIncludeHeaderPage.jsp" %>
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>



<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>


</head>

<body>
<form name="form1"  method="Post">

<%
 String msgStr =  (String) session.getAttribute("MM_LOAN_DT");

%>

  <br/>
   <br/>
    <br/>
	 <br/>
	  <br/>
  <div align="center" class="redLebel"><h2>Adjustment Letter Can be downloaded after 3 yrs from the date of first loan disbursement i.e <%=msgStr%></h2>
      <p>OR</p>
	   <p>Adjustment Letter not yet uploaded....</p>
    </div>
   
		
	

     
</form>
</body>
</html>

