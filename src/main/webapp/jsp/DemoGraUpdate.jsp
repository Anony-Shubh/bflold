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
<form method="post" action="DemoGraUpdate.jsp" name="form" id="form" class="form"  >


	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
		
		
	
		
		
		
		String adhvalid="F";

try {
VerifyAadhaarByID v= new VerifyAadhaarByID();	
adhvalid=v.VerifyAad(APP_ID, "AG");
}catch (Exception e) {}
out.print(adhvalid);

		if (!adhvalid.equals("S") ){
		
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
			if (sOFF_TYPE_CD.equals("2")){
			 vwhereqry =" AND MOM.DISTRICT_CD= "+sdistrict_cd+"  AND A.APP_ID='"+APP_ID+"' ";
			}else{
			vwhereqry =" AND MOM.USER_ID= "+vUserID+"  AND A.APP_ID='"+APP_ID+"' ";
			}
        DBCon db= new DBCon();
        db.connect();

         

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,A.AADHAR_NO, ");
		  qry.append(" UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, TRUNC((SYSDATE-A.DOB)/365) AS AGE, ");
		    qry.append("  A.MOB_NO1,MOM.ORG_CD,A.GENDER, ");
			 qry.append(" TO_CHAR(A.DOB,'RRRR-MM-DD') AS DOB,  A.ACTIVITY_CD,AM.ACTIVITY_NAME ");
			  qry.append(" FROM APP_DETAIL A,ACTIVITY_MAST AM,MAS_OFF_MAST MOM,BANK_DATAENTRY BD ");
 qry.append(" WHERE A.APP_ID=BD.APP_ID AND A.ACTIVITY_CD=AM.ACTIVITY_CD AND BD.ACT_ID=11 AND A.OFF_CD=MOM.OFF_CD and bd.act_id=11  ");
 qry.append("  and ((BD.MM_CLAIM_DT is null and loan_docfname is null) or (BD.MM_CLAIM_DT is not null and pact_id=30 and apprv_yn='A')) "+vwhereqry+" ");
//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
		
		
        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        AGE=rsApp.getString("AGE")==null?"":rsApp.getString("AGE");
	    MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		DOB=rsApp.getString("DOB")==null?"":rsApp.getString("DOB");
		GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
		AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		
        }
			rsApp.close();
			
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT DETAIL UPDATE FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col">
             </td>
        </tr>
        
       
        <tr>
          <th scope="col"> Applicant ID 
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><%= APP_ID %> </th>
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
	
						APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
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
		StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
		
							qryUpdate.append("UPDATE APP_DETAIL SET  ");
qryUpdate.append("MOB_NO1=?,");
qryUpdate.append("GENDER=?,DOB=?,");
qryUpdate.append("APP_NAME=? ");
qryUpdate.append("WHERE APP_ID=? and AADHAR_NO=? ");

						
						values.add (MOB_NO1);pstm.add ("S");
						values.add (GENDER);pstm.add ("S");
						values.add (getDate(FDOB));pstm.add ("L");
						values.add (APP_NAME);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						values.add (AADHAR_NO);pstm.add ("S");
		               
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
					    values.clear();
		response.sendRedirect("AadharSave.jsp");
	}
		

	if (!emsg.equals("S")) { %>
<br/><br/><br/><div id="display-error" align="center"><img src="../images/error.png" alt="Error"  width="35px"/>Data Mismatch: Enter Aadhar Data As per Aadhar Card....</div>
<%	}

db.close();	
	 }

 %>
						

	   <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
		<%}else{%>
		
		<br/><br/><br/><div id="display-success" align="center"><img src="../images/correct.png" alt="Success"  width="35px"/>Aadhaar Details Name,Aadhaar No,Gender,DOB And Mobile No Were Validated  </div>
		
		<%}%>
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