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
<%@ page import="globalp.*"%>
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
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>




<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >


	  <p>
	    <%
		//String IFS_CODE=(String)session.getAttribute("bank_id");
		String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
		//out.print(APP_ID);
		String PMEGPGEOTAGID=request.getParameter("PMEGPGEOTAGID")==null?"0":(String) request.getParameter("PMEGPGEOTAGID");
		//out.print(PMEGPGEOTAGID);
        String APP_NAME=request.getParameter("APPNAME")==null?"":(String) request.getParameter("APPNAME");
       
	   String UPM_CD=request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD");
	   out.print(UPM_CD);
		
		
		
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		String ID="";
		
        DBCon db= new DBCon();
        db.connect();
ResultSet rsMANU= db.execSQL("SELECT substr(A.App_id,instr(A.App_id,'-')+1,length(A.app_id))  AS ID FROM APP_DETAIL A WHERE APP_ID='"+APP_ID+"'");
		   while (rsMANU.next()) {  //3
           ID=rsMANU.getString(1);
           } //3  
		   rsMANU.close();

         
		  
		   kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("GEOTAGUPLOAD/AGENCY/OTHER/"+ID+"/" ); 


       
			
		
        %>
			<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*jpeg,*.png" />
 </jsp:useBean>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE MM ADJUSTMENT UPLOAD FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr> 
          <td colspan="2" scope="col"><input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
		  <input id="UPM_CD" name="UPM_CD" type="hidden" value="<%=UPM_CD%>"> 
		  <input id="PMEGPGEOTAGID" name="PMEGPGEOTAGID" type="hidden" value="<%=PMEGPGEOTAGID%>">		  </td>
        </tr>
        
        <tr>
          <td colspan="2" scope="col"><div align="center">( file format should be in pdf,jpg,png) </div></td>
        </tr>
        <tr>
          <th scope="col"> Applicant ID 
          <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><%= APP_ID %> </th>
        </tr>
        <tr>
          <th>PMEGPGeotag ID: </th>
          <th><%= PMEGPGEOTAGID %></th>
        </tr>
        <tr>
          <th>Name </th>
          <th><%= APP_NAME %> </th>
        </tr>
      
        <tr>
          <th>Supporting Document: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
		
		  <tr>
          <th>Document (Description if any) </th>
          <td><input name="DOC_REMARKS" type="text" id="DOC_REMARKS" size="50" maxlength="50"></td>
        </tr>
        
        <tr>
          <th colspan="2"><div align="center">
		    <input name="btnUpload" type="button" class="button" id="btnUpload" value="Upload" onClick="submit_form();">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Close Form" onClick="window.parent.HideModalWindow();">
          
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
						
						String frenNm="Geo"+maxID+"."+ext;
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						
						APP_ID=(String) mrequest.getParameter("APP_ID")==null?"":(String) mrequest.getParameter("APP_ID").trim();
						PMEGPGEOTAGID=(String) mrequest.getParameter("PMEGPGEOTAGID")==null?"":(String) mrequest.getParameter("PMEGPGEOTAGID").trim();
						DOC_REMARKS=(String) mrequest.getParameter("DOC_REMARKS")==null?"":(String) mrequest.getParameter("DOC_REMARKS").trim();
						UPM_CD=(String) mrequest.getParameter("UPM_CD")==null?"":(String) mrequest.getParameter("UPM_CD").trim();
						
						out.print(frenNm);
						List values=new ArrayList();
						List pstm=new ArrayList();
						
						StringBuffer qryUpdate = new StringBuffer();
		qryUpdate.append(" INSERT INTO GEOTAG_UPLOAD_TRANS ( UP_ID,");
						qryUpdate.append("APP_ID,");
						qryUpdate.append("UPM_CD,");
						qryUpdate.append("DOC_NAME,");
						qryUpdate.append("DOC_REMARKS,DOC_ACTYN,UPLOAD_TIMESTAMP,PMEGPGEOTAGID) VALUES (?,?,?,?,?,'Y',SYSDATE,?) ");
						
						values.add (maxID);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						values.add (UPM_CD);pstm.add ("S");
						values.add (frenNm);pstm.add ("S");
		                values.add (DOC_REMARKS);pstm.add ("S");
						values.add (PMEGPGEOTAGID);pstm.add ("S");
						try{
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						db.close();
						response.sendRedirect("savepage.jsp");
						pstm.clear();
						values.clear();						
							
							}catch(Exception e) { 	
	out.print(e.toString()); 
	}
						
  
	
							
							
							
							
							
							
							
					
							
							
							
							
						
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