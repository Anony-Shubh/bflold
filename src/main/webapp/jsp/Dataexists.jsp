<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="500kb" %>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

					
</head>
<body>
<form method="post"  name="form" id="form" >

	  
	   
 
	  <table align="center">
       <input name="ins" type="hidden" id="ins">
      
          <td colspan="5" class="redLebel"><div align="center"><h3><strong>(Note:User Details has been Sent to your Registered Mobile No.  Login to Fill the Other Details .Your Application Will not be Considered Valid Until it is Finally Submitted to The Concerned Office)</strong></div></td>
        </tr>
       
         <tr>
          <td colspan="5"><h2 align="center" >
            <div align="center"><h3><strong>Please Proceed to upload Details </strong></div>
          </h2></td>
        </tr> 
      </table>
	<div align="center"><a href="applicantLogin.jsp"><h2>Applicant Login </h2></a></div>
</form>

</body>
</html>