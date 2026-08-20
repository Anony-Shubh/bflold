 <%@ page session="true" buffer="500kb" import="java.sql.*,java.util.Date,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>
<head>
<title>PMEGP Bank Data Entry Form</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/popcalendarN.js"></script>
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script type="text/javascript">
function abc(){

				var APP_NAME = document.form1.APP_NAME.value; 
				var GENDER = document.form1.GENDER.value; 
				
	
	
	
	 if (APP_NAME == "") {
	inlineMsg('APP_NAME',"Enter Name",2);
    return false;
	  }
   if (GENDER == "") {
	inlineMsg('GENDER',"Select Gender",2);
    return false;
	  }
  
	
	
	
	
	
	
	document.form1.ins.value='I';
	document.form1.submit();
}







function closeAndRefresh(){
       window.parent.refresh_data();
    }


</script> 
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-size: 24px;
}
.style3 {font-size: 18px}
.style8 {font-size: 17px; }
.style9 {color: #008000; font-size: 17px; }
-->
</style>
</head>
 <body>
 <form  method="post"  name="form1" id="form1" >
  <%		
		String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
		
        String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins");   
		
		
List values=new ArrayList();
List pstm=new ArrayList();
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
   qrysb.append("  SELECT ad.app_id,app_name,aadhar_no,to_char(dob,'dd-mon-rrrr') as dob,gender from app_detail ad where ad.app_id='"+APP_ID+"'" );
  
   
		ResultSet rsMain = db.execSQL(qrysb.toString());		
		
String AADHAR_NO="";
String DOB="";
String GENDER="";
String APP_NAME="";


String verror="";


int edpcount=0;
while(rsMain.next())
  {	 
      	
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");	
	  AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");	  
	   DOB=rsMain.getString("DOB")==null?"":rsMain.getString("DOB");	
	  GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");	  
	  
	  
	 edpcount=edpcount+1;		
  }
 rsMain.close();
 //Validation query
 try{
 
			if (ins.equals("I")){
				
				
				
				
APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
APP_NAME=request.getParameter("APP_NAME")==null?"":request.getParameter("APP_NAME").trim();
GENDER=request.getParameter("GENDER")==null?"":request.getParameter("GENDER").trim();	





try {

	
StringBuffer sb = new StringBuffer();
		 sb.append("   UPDATE  AADHARVALIDATION_OLD SET    ").
             append("   app_name=? ,gender=? WHERE APP_ID =? and RET_YN='N'   ");

db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  
  
  values.add(APP_NAME);pstm.add("D");
  values.add(GENDER);pstm.add("D");
  values.add(APP_ID);pstm.add("D");
 
//db.executeUpdate();
  db.close();
  values.clear();
  pstm.clear();	
 response.sendRedirect("savemsg.jsp");
	
  }
   catch (Exception e) {
	  out.print(e);
  }
  }


		
		
	}catch (Exception e) {
	
	out.print (e.toString());
	}	
  
 
	  
			
 
 
 %>

  
    <table width="100%">
    <tr>
      <th height="23" colspan="6" nowrap><div align="center" class="style29 style39 style3">AADHAR DETAIL UPDATION FORM </div></th>
	  <input name="ins" type="hidden" id="ins" value="<%= ins %>   ">
	  <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>   ">
	  </tr>
	  <tr>
      <th colspan="6" ><div align="center" class="style34"> </div></th>
    </tr>
    <tr>
      <th  ><div align="right">Applicant ID : </div></th>
      <td> <%= APP_ID %> </td>
	  </tr>
	  <tr>
       <th ><div align="right">Applicant Name:</div></th>
      <td> <input name="APP_NAME" type="text" id="APP_NAME" value="<%= APP_NAME %>" size="50"> </td>
    </tr>
	 <tr>
      <th  ><div align="right"> AADHAR_NO:</div></th>
	  <td> <%=AADHAR_NO%></td>
    </tr>
	<tr>
	<th> <div align="right">Gender:</div></th>
	<td><select name="GENDER" class="button" id="GENDER">
      <option value="" selected>Select</option>
      <option value ="Male" <% if (GENDER.equals("Male")){out.print("selected");}%>>Male</option>
      <option value ="Female" <% if (GENDER.equals("Female")){out.print("selected");}%>>Female</option>
      <option value="Transgender" <% if (GENDER.equals("Transgender")){out.print("selected");}%>>Transgender</option>
    </select></td>
	</tr>
	<tr>
	<th><div align="right">DOB:</div></th>
	<td><%= DOB %></td>
	
	</tr>
	
	
	
	<tr>
        <th colspan="5"><div align="center">
            <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="abc();"  value="Save Data">
			  <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="closeAndRefresh();"  value="Close">
        </div></th>
      </tr>
    
   </table>
    
	
	

</form>

</body>
</html>
