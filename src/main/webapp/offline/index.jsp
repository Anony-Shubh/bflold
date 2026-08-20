<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="cdacuidai.VerifyAadhaarByID"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import = "cdacuidai.pmegpAadharValidationModel"%>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<html>
<head>
<style>

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
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
	
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
function isDate(txtDate) {
    var objDate,  // date object initialized from the txtDate string
        mSeconds, // txtDate in milliseconds
        day,      // day
        month,    // month
        year;     // year
    // date length should be 10 characters (no more no less)
    if (txtDate.length !== 10) {
        return false;
    }
    // third and sixth character should be '/'
    if (txtDate.substring(2, 3) !== '-' || txtDate.substring(5, 6) !== '-') {
        return false;
    }
    // extract month, day and year from the txtDate (expected format is mm/dd/yyyy)
    // subtraction will cast variables to integer implicitly (needed
    // for !== comparing)
    month = txtDate.substring(3, 5) - 1; // because months in JS start from 0
    day = txtDate.substring(0, 2) - 0;
    year = txtDate.substring(6, 10) - 0;
    // test year range
    if (year < 1000 || year > 3000) {
        return false;
    }
    // convert txtDate to milliseconds
    mSeconds = (new Date(year, month, day)).getTime();
    // initialize Date() object from calculated milliseconds
    objDate = new Date();
    objDate.setTime(mSeconds);
    // compare input date and parts from Date() object
    // if difference exists then date isn't valid
    if (objDate.getFullYear() !== year ||
        objDate.getMonth() !== month ||
        objDate.getDate() !== day) {
        return false;
    }
    // otherwise return true
    return true;
}





window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
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
	  
    inlineMsg('DOB','Enter Date of Birth in DD-MON-YYYY Format',2);
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
</head>

<body>
<form method="post" action="OffAddharValidate.jsp" name="form" id="form" class="form"  >


	  <p>
	    <%
		



		
		
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
			String vUserID=(String)session.getAttribute("user_id");
			
     

         

           
			
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT DETAIL FORM PART I (Aadhar Validation) </div></th>
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
          <th scope="col"><%= AADHAR_NO %> <input name="AADHAR_NO" type="hidden" id="AADHAR_NO" size="50" value="<%=AADHAR_NO  %>" /> </th>
        </tr>
        <tr>
          <th>Name </th>
          <th>
              <div align="left"> <input name="APP_NAME" type="text" id="APP_NAME" size="50" value="<%=APP_NAME  %>" maxlength="50"  /> </div></th>
        </tr> 
       
       
		  <tr>
          <th>Date Of Birth </th>
          <td>
		  <input name="DOB" type="text" class="mob"  id="DOB"  placeholder="Date of Birth YYYY-MM-DD"   size="13" maxlength="10" value="<%= DOB %>" title="Enter Date of Birth YYYY-MM-DD Your Aadhar Card" />
     
      
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
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="UPDATE" onClick="submit_form();">
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
	if (emsg.equals("S")) {
		 String dupid="";
		//qryCount.append(" SELECT COUNT(APP_ID) AS COUNTYN FROM APP_DETAIL WHERE AADHAR_NO="+AADHAR_NO+" AND ACT_ID NOT IN (3,7) AND ACT_YN='Y' ");
qryCount.append("SELECT * FROM ( SELECT AD.APP_ID,TO_CHAR(AD.AADHAR_NO) AS PER_IDENTITY,AD.ACT_YN FROM APP_DETAIL AD WHERE AD.AADHAR_NO="+AADHAR_NO+" ");
 qryCount.append(" AND LENGTH (AD.AADHAR_NO)=12 AND AD.ACT_ID NOT IN (3,7)) WHERE ACT_YN='Y' ");
  ResultSet rsCountApp = db.execSQL(qryCount.toString()); 
 
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
		
		DBCon db= new DBCon();
		db.connect(); 
		List values=new ArrayList();
        List pstm=new ArrayList();	
		
		values.add(OFF_ID); pstm.add ("L");
		values.add(AADHAR_NO); pstm.add ("L");
        values.add(APP_NAME); pstm.add ("L");
        values.add(GENDER); pstm.add ("L"); 
		values.add(DOB); pstm.add ("L");
        values.add(MOB_NO); pstm.add ("L");
        values.add(OFF_CD); pstm.add ("L"); 
		values.add(DIST_CD); pstm.add ("L"); 
		values.add(UserID); pstm.add ("L"); 
	 
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
		

	if (!emsg.equals("S")) { %>
<br/><br/><br/><div id="display-error" align="center"><img src="../images/error.png" alt="Error"  width="35px"/>Data Mismatch: Enter Aadhar Data As per Aadhar Card....</div>
<%	}

db.close();	
	 }

 %>
						

	 
	
</form>
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function activity(){

var AGENCY= document.form.ORG_CD.value;
 var urlpar='PMEGPlovpage.jsp?AGENCY='+AGENCY;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 
 function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}


function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

 </script>

</body>
</html>