<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>

<%@ include file="includeHeaderPage.jsp" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">
  function sub_form(){	  					 	
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
<body>
<form method="post"  name="form" id="form" >

<% 
String APP_ID=(String) session.getAttribute("sAPP_ID")==null?"":(String)session.getAttribute("sAPP_ID");

String BENF_TYPE_DESC=(String) session.getAttribute("sBENF_TYPE_DESC")==null?"":(String)session.getAttribute("sBENF_TYPE_DESC");
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

	
		
       String APP_NAME = "";
String AADHAR_NO = "";
String PAN_NO = "";
String ACT_ID="";
String UNIT_LOC="";
		String BENF_TYPE_CD = "";
		
		String APP_PWD = "";
		

 DBCon db= new DBCon();
db.connect();
ResultSet rsRd = db.execSQL("SELECT AD.APP_ID,  AD.APP_NAME,AD.BENF_TYPE_CD,AD.UNIT_LOC, AD.ACT_ID, AD.AADHAR_NO, ad.APP_PWD,   AD.PAN_NO FROM APP_DETAIL_ONLINE AD WHERE AD.APP_ID ='"+APP_ID+"' ");
		
		while (rsRd.next()){
		  APP_NAME=rsRd.getString("APP_NAME")==null?"":rsRd.getString("APP_NAME");
		  AADHAR_NO=rsRd.getString("AADHAR_NO")==null?"":rsRd.getString("AADHAR_NO");
		  UNIT_LOC=rsRd.getString("UNIT_LOC")==null?"":rsRd.getString("UNIT_LOC");
		  BENF_TYPE_CD=rsRd.getString("UNIT_LOC")==null?"":rsRd.getString("UNIT_LOC");
		   ACT_ID=rsRd.getString("ACT_ID")==null?"":rsRd.getString("ACT_ID");
		  PAN_NO=rsRd.getString("PAN_NO")==null?"":rsRd.getString("PAN_NO");
		  APP_PWD=rsRd.getString("APP_PWD")==null?"":rsRd.getString("APP_PWD");
		  
		}
		
		
		rsRd.close();
		
		if ((String)request.getParameter("ins")!=null){
			
			
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
BENF_TYPE_DESC=(String) request.getParameter("BENF_TYPE_DESC")==null?"":(String) request.getParameter("BENF_TYPE_DESC").trim();
BENF_TYPE_CD=(String) request.getParameter("BENF_TYPE_CD")==null?"1":(String) request.getParameter("BENF_TYPE_CD").trim();
	







	
session.setAttribute("sAPP_ID",APP_ID);
session.setAttribute("sAPP_NAME",APP_NAME);
session.setAttribute("sBENF_TYPE_CD",BENF_TYPE_CD);
session.setAttribute("sBENF_TYPE_DESC",BENF_TYPE_DESC); 
session.setAttribute("sACT_ID",ACT_ID); 
response.sendRedirect("upload_app_doc_agency_offline.jsp");
		}

	
		
	
		  %>
		  
		  
	   
 
	  <table align="center">
       <input name="ins" type="hidden" id="ins">
        <input name="APP_ID" id="APP_ID" type="hidden" value="<%=APP_ID%>" />
		 <input name="BENF_TYPE_CD" id="BENF_TYPE_CD" type="hidden" value="<%=BENF_TYPE_CD%>" />
		  <input name="APP_NAME" id="APP_NAME" type="hidden" value="<%=APP_NAME%>" />
		   <input name="BENF_TYPE_DESC" id="BENF_TYPE_DESC" type="hidden" value="<%=BENF_TYPE_DESC%>" />
		    <input name="ACT_ID" id="ACT_ID" type="hidden" value="<%=ACT_ID%>" />
        <tr>
          <td colspan="5" nowrap><h1 align="center" > <span class="style1">Your Application Id is</span>:<font color="red"><%=APP_ID%></font>	</h1></td>
        </tr>
		 <tr>
          <td colspan="5" nowrap ><h1 align="center" > <span class="style1">Password is</span>:<font color="red"><%=APP_PWD%></font></h1></td>
        </tr>
        <tr>
          <td colspan="5" class="redLebel"><div align="center"><h3><strong><span class="style1">(Note:Please note your application id for future refrence .Your Appliaction Will not be Considered Valid Until it is Finally Submitted to The Concerned Office)</span></strong></div></td>
        </tr>
       
         <tr>
          <td colspan="5"><h2 align="center" ><div align="center"><h3><strong<span class="style1">Please Proceed to upload documents</span> </strong></div></h2></td>
        </tr> 
      </table>
	<div align="center"><input name="Button" type="button" class="button" value="Proceed" onClick="sub_form();">
</div>
</form>

</body>
</html>