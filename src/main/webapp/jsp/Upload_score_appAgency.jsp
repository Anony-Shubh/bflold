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
<%@ page import="globalp.*"%>
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
	<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css">
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

<form method="post" action="Upload_score_appAgency.jsp" name="form" id="form" class="form" enctype="multipart/form-data" >

	

	  <p>
	    <%
		String APP_ID= (String) session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");
		//String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
		//out.print(APP_ID);
		
		if (APP_ID.equals("")){
response.sendRedirect("AgencyloginPageNew.jsp");
}
		//out.print(APP_ID);
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String add_update="I";
		
		String UP_ID = "";
		String UPM_CD = request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD").trim();
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String REDPATH="";

		
		
        DBCon db= new DBCon();
        db.connect();

        
           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,'scorecardupload'||'/'||substr(A.app_id,1,instr(app_id,'-')-1)||'/'||substr(A.app_id,instr(app_id,'-')+1,length(A.app_id))||'/'  as redpath, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A where ");
			  qry.append("  A.APP_ID = '"+APP_ID+"' ");
		 
//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	     MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		REDPATH=rsApp.getString("REDPATH")==null?"":rsApp.getString("REDPATH");
        }
			rsApp.close();
	
	
		
        %>
		
		
		
		     <%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage(REDPATH);
//out.print("a"+a);
%>
  <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>"/>
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*.jpeg,*.png" />
 </jsp:useBean> 
	  
  </p>
  

	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col"><input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
		  
            <span class="redLebel">(Note  Scanned Copy can be uploaded and file size should not be more then 1 mb)</span> </td>
        </tr>
        
        <tr>
          <th scope="col"> Applicant ID 
          <input type="hidden" name="todo" value="upload"/>
		    
          <input name="ins" type="hidden" id="ins" value="">
		   <input name="UPM_CD" type="hidden" id="UPM_CD" value="<%=UPM_CD%>">
		  </th>
          <th scope="col"><%= APP_ID %> </th>
        </tr>
        <tr>
          <th>Name </th>
          <th><div align="left">
              <div align="left"><%= APP_NAME %> </div></th>
        </tr>
        <tr>
          <th>Upload  Type: </th>
          <th>Agency Document</th>
        </tr>
        <tr>
          <th>Select File: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
        <tr>
          <th>Document (Description if any) </th>
          <td><input name="DOC_REMARKS" type="text" id="DOC_REMARKS" size="50" maxlength="50"></td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Close Form" onClick="self.close();">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="UPLOAD" onClick="submit_form();">
          </div></th>
        </tr>
      </table>
	 
	
	  
	  
	  
	  
	 <%
	 
	 
	 try {
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
	  
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {
                    UploadFile file = (UploadFile) files.get("uploadfile");
					
					String ext=getExtension(file.getFileName());
					
					if (ext.equals("jpg")||ext.equals("jpeg")||ext.equals("pdf")) {
					 upBean.store(mrequest, "uploadfile");
						String maxID="";
						 ResultSet rsMax = db.execSQL("SELECT APPUPLOAD_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
						 
						 while (rsMax.next()) {
						 maxID=rsMax.getString(1);
						 }
						
						rsMax.close();
						
						String frenNm="app"+maxID+"."+ext;						
						
						 
	
	  
	  
						
						
						
						
						
						
						//File f = new File("/opt/tomcat5/webapps/pmegpeportal/pmegpappupload/"+file.getFileName()+"");
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						
						APP_ID=(String) mrequest.getParameter("APP_ID")==null?"":(String) mrequest.getParameter("APP_ID").trim();
						UPM_CD=(String) mrequest.getParameter("UPM_CD")==null?"":(String) mrequest.getParameter("UPM_CD").trim();
						DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
						DOC_REMARKS=(String) mrequest.getParameter("DOC_REMARKS")==null?"":(String) mrequest.getParameter("DOC_REMARKS").trim();
						
						out.print(UPM_CD);
						out.print(APP_ID);
						out.print(frenNm);
						out.print(DOC_REMARKS);
						
						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
							
						
		
		   
		   qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET AGENCY_DOC=?,AGENCY_REMARK=? WHERE APP_ID=?");
		 

		  
						
						
						
						
						
						
						
						
						
						
										
						
												
						
						values.add (frenNm);pstm.add ("S");
		                values.add (DOC_REMARKS);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						db.setValues(values,pstm);	
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
							values.clear();	
							db.close();
							response.sendRedirect("savemsg.jsp");
						
						}//end of jpg

						}
						}
						}
						
			
						
} catch (Exception e) {
out.print (e.toString());
}finally{

}

	   %>
</form>
</body>
</html>
