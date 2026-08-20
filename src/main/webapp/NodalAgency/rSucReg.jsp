<%@ include file="includeHeaderPageDLTFC.jsp" %>
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>



<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>


</head>

<body>
<form name="form1"  method="Post">
<% 

	 String msgStr =  (String) session.getAttribute("SmsgStr");

%>

<table align="center" width="100%">


<table align="center">
  <tr>
    <td>    </td>
  </tr>

  <tr > 
    <th > <div align="center" class="GreenLebel">
      <h2>
        <input name="ins" type="hidden" id="ins" value="">
       Approver Registration </h2>
    </div></th>
    </tr>  
	
  <tr>
  
    <td ><div align="center" class="redLebel"><%=msgStr%></div></td>
    </tr>
		
	
  <tr> 
    <td>     </td>
    </tr>
   
      <tr > 
        
    <th nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>

</form>
</body>
</html>

