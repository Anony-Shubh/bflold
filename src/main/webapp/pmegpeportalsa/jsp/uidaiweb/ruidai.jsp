<%@ page import="in.gov.uidai.auth.sampleapp.NewUidMain"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UIDAI TEST....</title>
<link rel="stylesheet" type="text/css" href="../pmegpeportal/css/pmegpNew.css" />
</head>
<body>
<form id="form" method="post" action="">

<%

		    String uid=request.getParameter("uid")==null?"":(String)request.getParameter("uid");		
			String name=request.getParameter("uidname")==null?"":(String)request.getParameter("uidname");
			String gend=request.getParameter("gender")==null?"":(String)request.getParameter("gender");
			String year=request.getParameter("year")==null?"":(String)request.getParameter("year");
			
			String vSucess="";
			String ecode="";
		
			if (!uid.equals("")){
			NewUidMain sm=new NewUidMain();
			sm.validateuidaidata(uid, name, gend, year);
			vSucess=(String) sm.getSucessYN();
			ecode=(String) sm.getErrcode();
			out.print (vSucess);
			out.print (ecode);
			
			}
   %>
  <table border="20" align="center" cellpadding="10" cellspacing="10">
    <tr>
      <th colspan="2" ><h2 align="center">PMEGP E PORTAL AADHAAR TEST..............</h2> </th>
    </tr>
    <tr>
      <td ><div align="right">AADHAR ID</div></td>
      <td><input name="uid" type="text" class="aadharimg" id="uid" value="<%= uid %>" maxlength="12"></td>
    </tr>
    <tr>
      <td><div align="right">NAME</div></td>
      <td><input name="uidname" type="text" id="uidname" value="<%= name %>" maxlength="99"></td>
    </tr>
    <tr>
      <td><div align="right">GENDER</div></td>
      <td><select id="gender" name="gender"  style="width: 170px; " >
          <option ></option>
          <option value="Female" <% if (gend.equals("Female")) {out.print("Selected");}%>>Female</option>
          <option value="Male" <% if (gend.equals("Male")) {out.print("Selected");}%>>Male</option>
        </select>
      </td>
    </tr>
    <tr>
      <td><div align="right">YEAR OF BIRTH</div></td>
      <td><input name="year" type="text" id="year" value="<%= year %>" maxlength="4">
    </tr>
    <tr>
      <th colspan="2" align="center"><div align="center">
        <input name="submit" type="submit" class="buttonGreen" id="submit" value="Authenticate">
      </div></th>
    </tr>
  </table>
  <p>&nbsp;</p>
   <p><br>
    
  </p>
   <table align="center">
   <% if (vSucess.equals("S")) { %>
  <tr>
    <th width="78" ><img src="success.png" width="133" height="103"></th>
   
      <p align="center"> Sucessfully Submitted.........</p></td>
  </tr>
  <%} else if (vSucess.equals("F") ) {%>
  <tr>
    <th scope="row"><img src="failure.png" width="98" height="99"></th>
   
  </tr>
  <%}%>
</table>

</form>
</body>
</html>