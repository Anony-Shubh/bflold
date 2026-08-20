<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
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
    <title>upload </title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">

window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>
<form method="post" name="form" id="form"  >

	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		
		String UP_ID =""; 
		String UPM_CD = request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD").trim();
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String DOC_TYPE = "";
		String DOC_DESC = "";
		String DOC_REMARK="";
		String AGENCY_REMARK="";
String AGENCY_DOC="";
		
		
        DBCon db= new DBCon();
        db.connect();

       
           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,P.AGENCY_REMARK ,p.AGENCY_DOC,  ");		   
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL_online A,PMEGP_SCORE_CARD P ");
			  qry.append("WHERE A.APP_ID=P.APP_ID AND A.APP_ID = '"+APP_ID+"' ");
		 
//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
       // SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		AGENCY_REMARK=rsApp.getString("AGENCY_REMARK")==null?"":rsApp.getString("AGENCY_REMARK");
		 AGENCY_DOC=rsApp.getString("AGENCY_DOC")==null?"":rsApp.getString("AGENCY_DOC");
		
        }
		
			rsApp.close();
			
			
			
			
				
		
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">Document Delete Form  </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        
        
        <tr>
          <th scope="col"> Applicant ID 
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><%= APP_ID %> <input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>">
		  <input name="UPM_CD" type="hidden" id="UPM_CD" value="<%=UPM_CD%>">
		  </th>
        </tr>
        <tr>
          <th>Name </th>
          <th><div align="left">
              <div align="left"><%= APP_NAME %> </div></th>
        </tr>
        <tr>
          <th>Upload Type: </th>
          <th>Agency Document</th>
        </tr>
        <tr>
          <td colspan="2"><div align="center"><img src="../pmegpappupload/<%= DOC_NAME %>" width="20%">
            <div align="center">		  
          </div></td>
        </tr>
        <tr>
          <th>Remarks</th>
          <td>
		  <%=  AGENCY_REMARK %>
		 </td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="javascript:window.close();">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="Delete" onClick="submit_form();">
          </div></th>
        </tr>
      </table>
	 <%
	 
	   try{
   if ((String)request.getParameter("ins")!=null){
   APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
	UPM_CD=(String) request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD").trim();
	out.print(APP_ID);
	out.print(UPM_CD);
   List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		if (UPM_CD.equals("11")){
		qryUpdate.append("UPDATE PMEGP_SCORE_CARD SET AGENCY_DOC=NULL,AGENCY_REMARK=NULL WHERE APP_ID=?");
		}
		
		values.clear();
        pstm.clear();
values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
 pstm.clear();

db.close();
response.sendRedirect("savemsgDel.jsp");
   
 }//ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}
	 
	   %>
</form>
</body>
</html>