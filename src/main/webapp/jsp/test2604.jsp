<%@ include file="includeHeaderPage.jsp" %>
<%@ page import="cdacuidai.VerifyAadhaarByID"%>
<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%@ page import = "cdacuidai.pmegpAadharValidationModel"%>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
 <script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
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

 

   
    <style type="text/css">
<!--
.style2 {font-size: 18}
-->
    </style>
</HEAD>




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
			
     

          DBCon db= new DBCon();
db.connect();
%>


<BODY>
<form method="post" action="test2604.jsp" name="form" id="form" >
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
          <th scope="col"><input name="AADHAR_NO" type="text"  class="aadharimg" id="AADHAR_NO" size="50" value="<%=AADHAR_NO  %>" /> </th>
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
		

	if (!emsg.equals("S")) { %>
<br/><br/><br/><div id="display-error" align="center"><img src="../images/error.png" alt="Error"  width="35px"/>Data Mismatch: Enter Aadhar Data As per Aadhar Card....</div>
<%	}

db.close();	
	 }

 %>
 </form>
</BODY>

</HTML>
