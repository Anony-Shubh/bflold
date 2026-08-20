<%@ include file="includeHeaderPageDLTFC.jsp" %>
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="in.gov.mgov.SMSServices"%>

<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT src="../js/inlineMsgMain.js"></SCRIPT>
<SCRIPT>
function form_submit(){



var PER1_NO= document.form.PER1_NO.value;
var CONT_PER1= document.form.DESIGN.value;
var DESIGN= document.form.DESIGN.value;
var PER1_EMAIL= document.form.PER1_EMAIL.value;
 var numberOnly=/^[0-9]*$/;
 
 if(CONT_PER1 == "") {
    inlineMsg('CONT_PER1','Enter Approver Name',2);
    return false;
  }
   if(DESIGN == "") {
    inlineMsg('DESIGN','Enter Designation',2);
    return false;
  }
   if(PER1_EMAIL == "") {
    inlineMsg('PER1_EMAIL','Enter Email ID',2);
    return false;
  }





   if(PER1_NO == "") {
    inlineMsg('PER1_NO','Enter 10 digit Registered Mobile No',2);
    return false;
  }
  
   if(!numberOnly.test(PER1_NO)) {
	inlineMsg('PER1_NO','Mobile No should be in Number....',2);
				return false;
	}
  
	
	 if(Number(PER1_NO.length)!=10) {
	inlineMsg('PER1_NO','Mobile Number must be 10 digit',2);
				return false;
	}
	

document.form.ins.value='I'; 
document.form.submit();

}

</SCRIPT>





<STYLE type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</STYLE>
</HEAD>
<BODY> 
 <FORM name="form" id="form"  class="form" method="post">
<%
	  
		
		String OFF_CD1= (String) session.getAttribute("sOffCd");
		String U_COUNT=(String) session.getAttribute("sUC")==null?"0":(String)session.getAttribute("sUC");
		String vUSER_ID=(String) session.getAttribute("sUSERID")==null?"0":(String)session.getAttribute("sUSERID");
		String msg=(String) session.getAttribute("msg")==null?"0":(String)session.getAttribute("msg");
		//session.setAttribute("sUSERID",vUSERID);
		out.print(vUSER_ID);
		out.print(U_COUNT);
		try {
if (!U_COUNT.equals("0")){
session.setAttribute("SmsgStr","User Already Registered");
response.sendRedirect("rSucReg.jsp");
}
	}catch (Exception m) {}		
	
	

		String USER_ID="";
		String OTP="";
		String TRID="";
		
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT GU.USER_ID,  GU.USER_NAME ,  GU.MOB_NO,  GU.DESIG,  GU.E_MAIL,  GU.OFF_CD FROM MAS_OFF_MAST MOM,  GEOTAG_USER GU " );
        qrysb.append(" WHERE MOM.OFF_CD = GU.OFF_CD AND GU.ACT_YN='Y' AND MOM.OFF_CD="+OFF_CD1+"  " );
		

		ResultSet rsMain = db.execSQL(qrysb.toString());
		
		
String OFF_TYPE_CD="";
String DISTRICT_CD="";
String DISTRICT_NAME="";
String OFF_ADDR1="";
String OFF_ADDR2="";
String OFF_CD="";
String CITY="";
String PINCODE="";
String OFF_TEL_NO="";
String OFF_FAX_NO="";
String OFF_EMAIL_ADDR="";
String OFF_NAME="";
String OFF_LONG_DESC="";
String CONT_PER1="";
String CONT_PER2="";
String PER1_NO="";
String PER2_NO="";
String PER1_EMAIL="";
String PER2_EMAIL="";
String JURIS_DIST_CD="";
String LATITUDE="";
String LONGITUDE=""; 
String OFF_DIS_CD = "";
String ORG_CD="";
String ACT_YN="";
String AGENCY_TYPE="";

String DESIGN="";

  while(rsMain.next())
  {			
	  //OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");	
	  
	 
	 
	  CONT_PER1=rsMain.getString("USER_NAME")==null?"":rsMain.getString("USER_NAME");
	 
	  PER1_NO=rsMain.getString("MOB_NO")==null?"":rsMain.getString("MOB_NO");
	 
	  PER1_EMAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
	 DESIGN=rsMain.getString("DESIG")==null?"":rsMain.getString("DESIG");

	 // ACT_YN=rsMain.getString("ACT_YN")==null?"":rsMain.getString("ACT_YN");
	 
	 
	 }
			rsMain.close();
			
        %>

 
     
     <DIV align="center"></DIV>
      <INPUT name="ins" type="hidden" id="ins" value="<%= ins %>">



   <TABLE align="center" width="10%">
    <TR>

   <INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD1 %>">
 
  
   
   
	
   
   
    <TR bgcolor="#BC3F52" >
      <TD colspan="5"><H2><DIV align="center" class="style98 style1">Approver Contact Detail </DIV>
      </H2></TD></TR>
  <TR>
      <TD><DIV align="center">Sr. No. </DIV></TD>
      <TD><DIV align="center">Name </DIV></TD>
	   <TD><DIV align="center">Designation </DIV></TD>
      <TD><DIV align="center">        Mobile No </DIV></TD>
	  
      <TD><DIV align="center">Email</DIV></TD>
    </TR>
  
   <TR> 
      <TD >(1)</TD>

  <TD> <DIV align="center"> <INPUT name="CONT_PER1" type="text" id="CONT_PER1" value="<%=CONT_PER1%>" maxlength="30"> </DIV>   </TD>
  <TD> <DIV align="center">  <INPUT name="DESIGN" type="text" id="DESIGN" value="<%=DESIGN%>" maxlength="30">  </DIV>  </TD>
  <TD> <DIV align="center">  <INPUT name="PER1_NO" type="text" id="PER1_NO" value="<%=PER1_NO %>" maxlength="10"> </DIV>   </TD>  
  
  <TD> <DIV align="center">  <INPUT name="PER1_EMAIL" type="text" id="PER1_EMAIL" value="<%=PER1_EMAIL%>" maxlength="50"> </DIV></TD>
  </TR>
    <TR bgcolor="#BC3F52" >
      <TD colspan="5"><DIV align="center" class="style98 style1">
        <H2>Note:Please Ensure Correct Mobile No to receive OTP</H2>
      </DIV></TD>
    </TR>
  
   
  <TR>
    <TH colspan="5"> 
         <DIV align="center">
		  <INPUT name="Button" type="button" class="button" onClick="form_submit();" style="font-size:24px;" value="Send Otp">
          <INPUT name="Button" type="button" class="button" value="Cancel" style="font-size:24px;" onClick="self.close();">          
        </DIV></TH>
  </TR>

  </TABLE>
<%
			
			
			try {
			
			if (ins.equals("I")){
			
	  OFF_CD = request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD");		 
	 
	  CONT_PER1=request.getParameter("CONT_PER1")==null?"":request.getParameter("CONT_PER1");
	  
	  PER1_NO=request.getParameter("PER1_NO")==null?"":request.getParameter("PER1_NO");
	 
	  PER1_EMAIL=request.getParameter("PER1_EMAIL")==null?"":request.getParameter("PER1_EMAIL");
	 
	 DESIGN=request.getParameter("DESIGN")==null?"":request.getParameter("DESIGN");
	 PER1_NO=request.getParameter("PER1_NO")==null?"":request.getParameter("PER1_NO");
	  USER_ID=request.getParameter("USER_ID")==null?"0":request.getParameter("USER_ID");
	  StringBuffer qryUpdate= new StringBuffer();
 
	  
			 List values=new ArrayList();
             List pstm=new ArrayList();
             StringBuffer sb= new StringBuffer();


if ((USER_ID.equals("0")) && (U_COUNT.equals("0")))  {
 ResultSet rsMax= db.execSQL("SELECT GEOUSERSEQ.NEXTVAL AS MAX_ID FROM DUAL");
     while (rsMax.next()) {
     USER_ID=rsMax.getString(1);
     }
rsMax.close();

  
qryUpdate.append("INSERT INTO GEOTAG_USER( ");
qryUpdate.append("USER_NAME,");
qryUpdate.append("USER_TYPE,");
qryUpdate.append("MOB_NO,");
qryUpdate.append("ACT_YN,DESIG,OFF_CD,E_MAIL,TIMESTAMP,USER_ID)");
qryUpdate.append("VALUES (?,'V',?,'N',?,?,?,SYSDATE,?) ");
 
 
 }
 
 
 values.add (CONT_PER1);pstm.add ("D");
 values.add (PER1_NO);pstm.add ("D");
 values.add (DESIGN);pstm.add ("D");
 values.add (OFF_CD);pstm.add ("D");
 values.add (PER1_EMAIL);pstm.add ("D");
 values.add (USER_ID);pstm.add ("D");
 




 

 

 
 db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm); 
	db.executeUpdate() ;
	//db.close();
	
	 values.clear();
    pstm.clear();
	
	//if ((!USER_ID.equals("0")) && (!U_COUNT.equals("0")))  {
	
	 ResultSet rsMax1= db.execSQL("select nvl(max(TRID),0)+1 from GEOUSER_OTP ");
     while (rsMax1.next()) {
     TRID=rsMax1.getString(1);
     }
rsMax1.close();
 session.setAttribute("STRID",TRID);


		ResultSet rsRd = db.execSQL("select round(dbms_random.value(10000,99999),0) APP_PWD from dual ");
		
		while (rsRd.next()){
		  OTP=rsRd.getString(1);
		}
		rsRd.close();
session.setAttribute("SOTP",OTP);
// String sms_string="Dear KIeportal Beneficiary  ( "+USER_ID +" ). Your requested OTP  for Updation of Artisan Data is  "+OTP+" . Do not share //this OTP with anyone. This will be valid for 60 mins only -KVIC";
//String sms_string="Dear KVIC PMEGPUser, Your One Time Password is "+OTP+" - KVIC" ; 
//String sms_string=OFF_CD+" Your Credential for PMEGPeportal is: "+OTP+"  - KVIC";
String	 sms_string = "PMEGP Approver  Your Credential for  OTP is "+OTP+" and Password is as earlier - KVIC";

 
	 SMSServices sms1=new SMSServices();
	
	
			try {
			
			String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",PER1_NO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007767720108823736");
			//String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",PER1_NO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007691521385364161");
    // String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",PER1_NO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007141026265968304");	
}catch (Exception e) {}


		
	StringBuffer qryUpd = new StringBuffer();
						
						//	List values=new ArrayList();
						//	List pstm=new ArrayList();
						
//out.print(TRID);
//out.print(USER_ID);
//out.print(PER1_NO);
//out.print(OTP);



						qryUpd.append(" INSERT INTO GEOUSER_OTP ( TRID,");
						qryUpd.append("USER_ID,");				
						qryUpd.append("MOB_NO,");
						qryUpd.append("OTP,VALID_YN,TIMESTAMP ) VALUES (?,?,?,?,'N',SYSDATE) ");
						
						values.add (TRID);pstm.add ("S");
						values.add (USER_ID);pstm.add ("S");						
						values.add (PER1_NO);pstm.add ("S");
		                values.add (OTP);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpd.toString());
						db.executeUpdate() ;
						pstm.clear();
						values.clear();	
						db.close();
						response.sendRedirect("geoUserValid.jsp");
						

	
	

	//response.sendRedirect("savemsg.jsp");

			
			//}
			}
			}catch (Exception e) {
		//out.print (e.toString());
			out.print ("<center><span class='error'>Active User Already Exists</span></center>");
			}
			
			%>


	
</table>    
</FORM>

</BODY>
</HTML>