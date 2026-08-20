<%@ include file="includeHeaderPage.jsp" %>

<%@ page import="cdacuidai.VerifyAadhaarByID"%>
<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%@ page import = "cdacuidai.pmegpAadharValidationModel"%>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>

<head>

   
	
<%!
 public String getDate(String str){
 str=str.trim();
SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yyyy");
try{
     Date date = sdfSource.parse(str);
	 
     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
	  str=sdfDestination.format(date);
	  }catch(Exception e){}
	 return(str); 
	 
}
 %>	
	
	
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}
 %>
    <title>Aadhar Verification </title>
	<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
	<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script language="javascript">
function isDate(date) {
 
    // Date format: YYYY-MM-DD
    var datePattern = /^([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/;

    // Check if the date string format is a match
    var matchArray = date.match(datePattern);
    if (matchArray == null) {
        return false;
    }

    // Remove any non digit characters
    var dateString = date.replace(/\D/g, ''); 

    // Parse integer values from the date string
    var year = parseInt(dateString.substr(0, 4));
    var month = parseInt(dateString.substr(4, 2));
    var day = parseInt(dateString.substr(6, 2));
   
    // Define the number of days per month
    var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Leap years
    if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) {
        daysInMonth[1] = 29;
    }

    if (month < 1 || month > 12 || day < 1 || day > daysInMonth[month - 1]) {
        return false;
    }
    return true;
}


function checkDateAge(){
	var DOB='DOB';
    var t=document.getElementById(DOB+"").value;
        if (!isDate(t)){
    inlineMsg('DOB','<Strong><U>Invalid Date</U> </strong><br>Date Format should be YYYY-MM-DD <br> Ex:2011-03-30',2);
			}

}

	
function submit_form() {
	var numberOnly=/^[0-9]*$/;
	var APP_NAME=document.form.APP_NAME.value;

	var DOB=document.form.DOB.value;

	var MOB_NO1=document.form.MOB_NO1.value;

	var GENDER=document.form.GENDER.value;

	if(APP_NAME == "") {
	  
    inlineMsg('APP_NAME','Enter Applicant Name',2);
    return false;
  }
  
  if(DOB == "") {
	  
    inlineMsg('DOB','Enter Date of Birth in YYYY-MM-DD Format',2);
    return false;
  }
	


   if(MOB_NO1 == "") {
	  
    inlineMsg('MOB_NO1','Enter Mobile No',2);
    return false;
  }

  
   if(!numberOnly.test(MOB_NO1))
    {
	    inlineMsg('MOB_NO1','Enter Valid mobile No. in numbers',2);
        return false;
    }
	if(MOB_NO1.length !=10)
    {
	    inlineMsg('MOB_NO1','Enter 10 digit Mobile No.',2);
        return false;
    }

 
if(GENDER == "") {
	  
    inlineMsg('GENDER','Select GENDER',2);
    return false;
  }


	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
</head>


	  
	    <%
		



		
		 ArrayList aerror = new ArrayList();
		String vOffcd= (String) session.getAttribute("off_cd");
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String GENDER = "";
		String UserID="";
		String AGE = "";
		String ACTIVITY_CD = "";
		String DOB = "";
		String ORG_CD = "";
			String Activity_desc = "";
			String sOFF_TYPE_CD=(String) session.getAttribute("sOFF_TYPE_CD");
			String sdistrict_cd =(String) session.getAttribute("sdistrict_cd");
			String sagency_type=(String) session.getAttribute("sagency_type");
			String vwhereqry="";
			//String vUserID=(String)session.getAttribute("user_id");
			
     String VALID_DATA="Y";

          DBCon db= new DBCon();
db.connect();



           
			
        %>
		
<body>

<form method="post" action="OffAddharValidate.jsp" name="form" id="form" >

  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">OFFLINE APPLICANT DETAIL FORM PART I (Aadhar Validation) </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col">
             </td>
        </tr>
        
       
       
		<tr>
          <th scope="col"> Aadhaar NO
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><input name="AADHAR_NO" type="text"  class="aadharimg" id="AADHAR_NO" size="50" maxlength="12" value="<%=AADHAR_NO  %>" /> </th>
        </tr>
        <tr>
          <th>Name </th>
          <th>
              <div align="left"> <input name="APP_NAME" type="text" id="APP_NAME" size="50" value="<%=APP_NAME  %>" maxlength="50"  /> </div></th>
        </tr> 
       
       
		  <tr>
          <th>Date Of Birth </th>
          <td>
		  <input name="DOB" type="text" class="mob"  id="DOB"  placeholder="YYYY-MM-DD"   onBlur="checkDateAge();" onKeyPress="return onlyDate(event);" size="13" maxlength="10" value="<%= DOB %>" title="Enter Date of Birth YYYY-MM-DD Your Aadhar Card" />
     
      
<input name="UserID" type="hidden" id="UserID" size="50" value="<%=vUserID  %>"  /> 
		  </td>
        </tr>
		  <tr>
          <th>Mobile No:</th>
          <td> <input name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" value="<%=MOB_NO1%>" /></td>
        </tr>
		  <tr>
          <th>Gender:</th>
          <td> <SELECT name="GENDER" class="button" id="GENDER">
      <OPTION value="" selected>Select</OPTION>
      <OPTION value ="Male" <% if (GENDER.equals("Male")){out.print("selected");}%>>Male</OPTION>
      <OPTION value ="Female" <% if (GENDER.equals("Female")){out.print("selected");}%>>Female</OPTION>
      <OPTION value="Transgender" <% if (GENDER.equals("Transgender")){out.print("selected");}%>>Transgender</OPTION>
    </SELECT>
		 </td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnUpload" type="button"  class="button" id="btnUpload" onClick="submit_form();" value="Verify">
          </div></th>
        </tr>
      
		 
	 
	 
      </table>
	 <%
	 if ((String)request.getParameter("ins")!=null){	
	
						
						MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
						GENDER=(String) request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER").trim();
						APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
						DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
						UserID=(String) request.getParameter("UserID")==null?"":(String) request.getParameter("UserID").trim();
						AADHAR_NO=(String) request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO").trim();
				
			
		

DateFormat parser = new SimpleDateFormat("yyyy-MM-dd"); 
Date date = (Date) parser.parse(DOB);

DateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy"); 
String FDOB=formatter.format(date);
//out.print(FDOB);
     


		
	pmegpAadharValidationModel pam=new pmegpAadharValidationModel(AADHAR_NO,APP_NAME,GENDER,MOB_NO1,DOB);
	
	
	
		if (pam.errlist().size()>0) {
		
		 request.setAttribute("errorMessage", "Please Verifiy Aadhar Details....."+pam.errlist().toString());
		}else {
		 request.setAttribute("errorMessage", "S");         
			
		}	
		//out.print((getDate(DOB)));
		
	String emsg=request.getAttribute("errorMessage") ==null?"":(String) request.getAttribute("errorMessage");
	//out.print(emsg);
	 String dupid="";
	if (emsg.equals("S")) {
		
		 StringBuffer qrydup = new StringBuffer();
qrydup.append(" SELECT * FROM ( SELECT AD.APP_ID,TO_CHAR(AD.AADHAR_NO) AS PER_IDENTITY,AD.ACT_YN FROM APP_DETAIL AD WHERE AD.AADHAR_NO="+AADHAR_NO+" ");
 qrydup.append(" AND LENGTH (AD.AADHAR_NO)=12 AND AD.ACT_ID NOT IN (3,7)) WHERE ACT_YN='Y' ");
 
 
ResultSet rsdup = db.execSQL(qrydup.toString()); 
 
 while (rsdup.next()){
 dupid=dupid+","+rsdup.getString("APP_ID");
 }
 
 if (!dupid.equals("")){
 aerror.add("Application ID "+ dupid +" already applied with the same Aadhar Number ");
 }
 else{
	 
	StringBuffer  qrysb= new StringBuffer();
	String OFF_ID="";
		ResultSet rsMax= db.execSQL("SELECT SEQ_OFFLINE.nextval AS MAX_ID FROM DUAL");
     while (rsMax.next()) {
     OFF_ID=rsMax.getString(1);
     }
	 rsMax.close();
		qrysb.append(" INSERT INTO AADHAR_VERI_OFFLINE (OFF_ID,AADHAR_NO,APP_NAME, GENDER,DOB,MOB_NO ,OFF_CD,DIST_CD,TIMESTAMP,USERID)  VALUES ( ?,?,?,?, ?,?,?, ?,SYSDATE,?) ");
		
		 
		List values=new ArrayList();
        List pstm=new ArrayList();	
		
		values.add(OFF_ID); pstm.add ("L");
		values.add(AADHAR_NO); pstm.add ("L");
        values.add(APP_NAME); pstm.add ("L");
        values.add(GENDER); pstm.add ("L"); 
		values.add (getDate(FDOB));pstm.add ("L");
        values.add(MOB_NO1); pstm.add ("L");
        values.add(vOffcd); pstm.add ("L"); 
		values.add(sdistrict_cd); pstm.add ("L"); 
		values.add(vUserID); pstm.add ("L"); 
	 
db.setSqlValue(qrysb.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;

  values.clear();
 pstm.clear();

	 rsdup.close();
	 db.close();
	 session.setAttribute("SOFFID",OFF_ID);
	 response.sendRedirect("offappform.jsp");
	 
 }
 rsdup.close();
 	 db.close();
	}
		

	%>



 <table align="center" class="pmegpTable">
 <tr>
    <td colspan="4" class="warning" scope="row"><h2 class="error">  Submission failed due to following reason: </h2></td>
  </tr>
 <% if (!emsg.equals("S")) { %>
<br/><br/><br/><td colspan="3" class="OrangeLebel" scope="row"><img src="../images/error.png" alt="Error"  width="35px"/><h3 class="style1">Data Mismatch: Enter Aadhar Data As per Aadhar Card....</h3></td>
<%	}
  
   ListIterator itr=aerror.listIterator();
   int cnterro=0;
   while(itr.hasNext()){ VALID_DATA="N"; 
cnterro=cnterro+1;   %>

  <tr class="redLebel">
    <td class="OrangeLebel" scope="row">
	
	  <div align="right"><%= cnterro %></div></td>
    <td colspan="3" class="warning" scope="row"><h3 class="style1"><%= itr.next()%></h3></td>
  </tr>
   <%}
db.close();	
	 }

 %>
						
</table>
	 
	
</form>
<style>
/*
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
}*/
</style>

</body>
</html>