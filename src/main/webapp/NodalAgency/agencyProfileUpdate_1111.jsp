<%@ include file="includeHeaderPageDLTFC.jsp" %>
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>
<script>
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

</script>


<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<body> 
 <form name="form" id="form"  class="form" method="post">
	    <%
		
		String OFF_CD1= (String) session.getAttribute("sOffCd");
		String U_COUNT=(String) session.getAttribute("sUC")==null?"0":(String)session.getAttribute("sUC");
		//out.print(U_COUNT);
		
		
		String USER_ID="";
		
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

 
     
    <!-- <div align="center"> <span class="style90 style96">AGENCY PROFILE UPDATE FORM </span></div>-->
      <input name="ins" type="hidden" id="ins" value="<%= ins %>">



   <table align="center" width="10%">
    <tr>

   <input name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD1 %>">
 
  
   
   
	
   
   
    <tr bgcolor="#BC3F52" >
      <td colspan="5"><H2><div align="center" class="style98 style1">Approver Contact Detail </div>
      </H2></td>
    </tr>
  <tr>
      <td><div align="center">Sr. No. </div></td>
      <td><div align="center">Name </div></td>
	   <td><div align="center">Designation </div></td>
      <td><div align="center">Telephone (STD)/<br>Mobile No </div></td>
	  
      <td><div align="center">Email</div></td>
    </tr>
  
   <tr> 
      <td >(1)</td>

  <td> <div align="center"> <input name="CONT_PER1" type="text" id="CONT_PER1" value="<%=CONT_PER1%>" maxlength="30"> </div>   </td>
  <td> <div align="center">  <input name="DESIGN" type="text" id="DESIGN" value="<%=DESIGN%>" maxlength="30">  </div>  </td>
  <td> <div align="center">  <input name="PER1_NO" type="text" id="PER1_NO" value="<%=PER1_NO%>"maxlength="10"> </div>   </td>  
  
  <td> <div align="center">  <input name="PER1_EMAIL" type="text" id="PER1_EMAIL" value="<%=PER1_EMAIL%>" maxlength="50"> </div></td>
  </tr>
  
  <tr bgcolor="#BC3F52" >
      <td colspan="5"><div align="center" class="style98"></div></td>
    </tr>
	 <tr bgcolor="#BC3F52" >
      <td colspan="5"><div align="center" class="style98"></div></td>
    </tr> <tr bgcolor="#BC3F52" >
      <td colspan="5"><div align="center" class="style98"></div></td>
    </tr>
   
  <tr>
    <th colspan="5"> 
         <div align="center">
		  <input name="Button" type="button" class="button" onClick="form_submit();" value="Save Record">
          <input name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
        </div></th>
  </tr>
  </table>
<%
			
			
			try {
			
			if (ins.equals("I")){
			
	  OFF_CD = request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD");		 
	 
	  CONT_PER1=request.getParameter("CONT_PER1")==null?"":request.getParameter("CONT_PER1");
	  
	  PER1_NO=request.getParameter("PER1_NO")==null?"":request.getParameter("PER1_NO");
	 
	  PER1_EMAIL=request.getParameter("PER1_EMAIL")==null?"":request.getParameter("PER1_EMAIL");
	 
	 DESIGN=request.getParameter("DESIGN")==null?"":request.getParameter("DESIGN");
	 
	  USER_ID=request.getParameter("USER_ID")==null?"0":request.getParameter("USER_ID");
	  StringBuffer qryUpdate= new StringBuffer();
 
	  
			 List values=new ArrayList();
             List pstm=new ArrayList();
             StringBuffer sb= new StringBuffer();
out.print(USER_ID);
out.print(U_COUNT);
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
qryUpdate.append("VALUES (?,'V',?,'Y',?,?,?,SYSDATE,?) ");
}
/*else{
 

qryUpdate.append("   UPDATE GEOTAG_USER SET ");
qryUpdate.append("   USER_NAME=?,USER_TYPE='V',MOB_NO=?,");
qryUpdate.append("   ACT_YN='Y',DESIG=?,OFF_CD=?,E_MAIL=?,TIMESTAMP=? ");
qryUpdate.append("   WHERE USER_ID = ?");
}
*/


 

 
 values.add (CONT_PER1);pstm.add ("D");
 values.add (PER1_NO);pstm.add ("D");
 values.add (DESIGN);pstm.add ("D");
 values.add (OFF_CD);pstm.add ("D");
 values.add (PER1_EMAIL);pstm.add ("D");
 values.add (USER_ID);pstm.add ("D");
 
 db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm); 
	db.executeUpdate() ;
	db.close();
	
	 values.clear();
    pstm.clear();
	
	

	response.sendRedirect("PMEGPAgencyHomePage.jsp");

			
			}
			}catch (Exception e) {
			out.print (e.toString());
			out.print ("Active User Already Exists");
			}
			
			%>


	
</table>    
</form>

</body>
</html>