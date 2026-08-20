<%@ include file="appIncludeHeaderPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>aadharvalidation</title>
<link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css" data-rocket-async="style" as="style" onload="this.onload=null;this.rel='stylesheet'" />
<style>
body{
 font-family: 'Roboto', sans-serif;
}

/* Change input control border color */
.form-control, .input-group-text {
    border: 1px solid #0080ff;
}

a.btn:hover{
    cursor: pointer !important;
}

/*loader*/
.loaderbody {
    width: 100%;
    height: 100%;
    left: 0px;
    top: 0px;
    position: absolute;
    background-color: rgba(128,128,128,0.2);
    z-index: 2147483647;
}

.loader {
    border: 16px solid #f3f3f3; /* Light grey */
    border-top: 16px solid #3498db; /* Blue */
    border-radius: 50%;
    width: 80px;
    height: 80px;
    animation: spin 2s linear infinite;
    position: fixed;
    top: 45%;
    left: 40%;
}

@keyframes spin {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(360deg);
    }
}

.hide{
    display:none;
}


input:invalid {
    border-color: red;
}
input,
input:valid {
    border-color: #ccc;
}


input[type=text], select, textarea {
  
  padding: 12px; /* Some padding */ 
  border: 1px solid #ccc; /* Gray border */
  border-radius: 4px; /* Rounded borders */
  box-sizing: border-box; /* Make sure that padding and width stays in place */
  margin-top: 6px; /* Add a top margin */
  margin-bottom: 16px; /* Bottom margin */
  resize: vertical /* Allow the user to vertically resize the textarea (not horizontally) */
}

/* Style the submit button with a specific background color etc */
input[type=submit] {
  background-color: #04AA6D;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

/* When moving the mouse over the submit button, add a darker green color */
input[type=submit]:hover {
  background-color: #45a049;
}

/* Add a background color and some padding around the form */
.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
input[type="date"]::-webkit-datetime-edit, input[type="date"]::-webkit-inner-spin-button, input[type="date"]::-webkit-clear-button {
  color: #fff;
  position: relative;
}

input[type="date"]::-webkit-datetime-edit-year-field{
  position: absolute !important;
  border-left:1px solid #8c8c8c;
  padding: 2px;
  color:#000;
  left: 56px;
}

input[type="date"]::-webkit-datetime-edit-month-field{
  position: absolute !important;
  border-left:1px solid #8c8c8c;
  padding: 2px;
  color:#000;
  left: 26px;
}


input[type="date"]::-webkit-datetime-edit-day-field{
  position: absolute !important;
  color:#000;
  padding: 2px;
  left: 4px;
  
}

#display-error
{
width: 800px;
border: 1px solid #D8D8D8;
padding: 5px;
border-radius: 5px;
font-family: Arial;
font-size: 18px;
text-transform: uppercase;
background-color: rgb(255, 249, 242);
color: rgb(211, 0, 0);
text-align: center;
}
 
img
{
max-width: 40%; 
float: left;
}
 
#display-success
{
width: 800px;
border: 1px solid #D8D8D8;
padding: 10px;
border-radius: 5px;
font-family: Arial;
font-size: 18px;
text-transform: uppercase;
background-color: rgb(236, 255, 216);
color: green;
text-align: center;
margin-top: 30px;
}
 
#display-success img
{
position: relative;
bottom: 5px;
}
</style>
</head>
<body>
<form name="form1" method="post" action="validateadhform.jsp">
<% 

String an="";
	 String nm="";
	String gn="";
		String dob="";
		String MOBILENO="";


String APP_ID=  vAppid;

StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT ado.GENDER,  to_char(ado.DOB,'YYYY-MM-DD') AS DOB, ado.app_name, ado.MOB_NO1,  ado.AADHAR_NO FROM app_detail_online ado  "      );
qrysb.append("     WHERE APP_ID='"+APP_ID+"' "      );


DBCon db= new DBCon();
db.connect();


int srno=0;
ResultSet rsMain = db.execSQL(qrysb.toString());
 while (rsMain.next()) {
gn =rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
nm =rsMain.getString("app_name")==null?"":rsMain.getString("app_name");
dob =rsMain.getString("DOB")==null?"":rsMain.getString("DOB");
MOBILENO =rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
an =rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");

}



 

//out.print(an);
 %>
<table width="0" border="1" align="center" cellpadding="4" cellspacing="4">
  <tr>
    <th colspan="2"><div align="center">Aadhar Verification </div></th>
  </tr>
  <tr>
    <td>Aadhar No*</td>
    <td><input name="AADHAR_NO" type="text" id="AADHAR_NO" title="Enter Aadhar No As per Your Aadhar Card" value="<%= an %>" maxlength="12"  minlength="12" placeholder="Aadhar Number" required ></td>
  </tr>
  <tr>
    <td>Applicant Name*</td>
    <td><input name="APP_NAME" type="text" id="APP_NAME" value="<%= nm %>" size="70" maxlength="60" placeholder="Applicant Name" ></td>
  </tr>
  <tr>
    <td>Gender*</td>
    <td><select name="GENDER" required>
      <option value="">Select Gender</option>
      <option value="Male" <% if (gn.equals("Male" )) {out.print("Selected");}%>>Male</option>
      <option value="Female" <% if (gn.equals("Female" )) {out.print("Selected");}%>>Female</option>
      <option value="Transgender" <% if (gn.equals("Transgender" )) {out.print("Selected");}%>>Transgender</option>
    </select></td>
  </tr>
  <tr>
    <td>Mobile No </td>
    <td><input name="MOBILENO" type="text" id="MOBILENO"  minlength="10" maxlength="10" value="<%= MOBILENO %>" placeholder="Mobile Number" title="Enter Mobile No As per Your Aadhar Card"></td>
  </tr>
  <tr>
    <td>Date of Birth </td>
    <td><input name="DOB" type="text" id="DOB"   placeholder="Date of Birth YYYY-MM-DD" value="<%= dob %>" title="Enter Date of Birth YYYY-MM-DD Your Aadhar Card"></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input name="Validate" type="submit" value="Validate Aadhar Detail">
    </div></td>
  </tr>
  <tr>
    <td colspan="2">
	<% 
	String emsg=request.getAttribute("errorMessage") ==null?"":(String) request.getAttribute("errorMessage");
	
	if (emsg.equals("S")) {
	%>
<div id="display-success"><img src="correct.png" alt="Success"  width="35px"/> Successfully Verified from UIDAI Server.........</div>
<%
}
	if (!emsg.equals("S")) { %>
<div id="display-error"><img src="error.png" alt="Error"  width="35px"/>Data Mismatch: Enter Aadhar Data As per Aadhar Card....</div>
<%	} %>
	</td>
  </tr>
</table>
<%
 an=request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO");
	  nm=request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME");
	 gn=request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER");
		 dob=request.getParameter("DOB")==null?"":(String) request.getParameter("DOB");
		 MOBILENO=request.getParameter("MOBILENO")==null?"":(String) request.getParameter("MOBILENO");


%>
</form>
</body>
</html>