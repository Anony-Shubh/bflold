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
<%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("ENUMUPLOAD/");
//out.print(a);
%>
<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="0" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf" />
 </jsp:useBean>

	  <p>
	    <%
		
		String EN_ID= request.getParameter("EN_ID")==null?"0":(String) request.getParameter("EN_ID");
  
	String DOC_NAME="";
	String DOC_REMARK="";	
        DBCon db= new DBCon();
        db.connect();

          String docStr="SELECT STATE_CD,STATE_NM FROM M_STATE ORDER BY STATE_NM ";
		  
		    ResultSet rsDoc = db.execSQL(docStr);
			
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">Upload Form </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col"><input id="EN_ID" name="EN_ID" type="hidden" value="<%=EN_ID%>"> 
            <span class="redLebel">(Note  Scanned Copy can be uploaded and file size should not be more than 5mb)</span> </td>
        </tr>
        
        <tr>
          <td colspan="2" scope="col"><div align="center">( file format should be in pdf) </div></td>
        </tr>
       
          
          <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value=""></th>
         
      
        <tr>
          <th>State: </th>
          <th><select name="STATE_CD" class="button" id="STATE_CD">
			<% 
			      String STATE_NM="";
        String STATE_CD="";
			 while (rsDoc.next()) {
			 STATE_CD=rsDoc.getString(1);
			 STATE_NM=rsDoc.getString(2);
			  %>
            <option value="<%= STATE_CD %>"><%= STATE_NM %></option>
			<%}
			rsDoc.close();
			%>
          </select>          </th>
        </tr>
        <tr>
          <th>Select File: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
		 <tr>
          <th>Remark (if Any): </th>
          <th><input name="DOC_REMARK" type="text" id="DOC_REMARK" value="<%=DOC_REMARK%>"></th>
        </tr>
        
        <tr>
          <th colspan="2"><div align="center">
		   <input name="btnUpload" type="button" class="button" id="btnUpload" value="Upload" onClick="submit_form();">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="window.parent.HideModalWindow();">
           
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
						 ResultSet rsMax = db.execSQL("SELECT ENUM_SEQ.NEXTVAL AS MAX_ID FROM DUAL ");
						 
						 while (rsMax.next()) {
						 maxID=rsMax.getString(1);
						 }
						
						rsMax.close();
						
						String frenNm="app"+maxID+"."+ext;
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						EN_ID=(String) mrequest.getParameter("UP_ID")==null?"":(String) mrequest.getParameter("UP_ID").trim();
						STATE_CD=(String) mrequest.getParameter("STATE_CD")==null?"":(String) mrequest.getParameter("STATE_CD").trim();						
						DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
						DOC_REMARK=(String) mrequest.getParameter("DOC_REMARK")==null?"":(String) mrequest.getParameter("DOC_REMARK").trim();

						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" INSERT INTO GEOENUM_DETAIL ( EN_ID,");
						qryUpdate.append("DOC_NAME,");
						qryUpdate.append("UPLOAD_TIMESTAMP,");
						qryUpdate.append("ACT_YN,");
						qryUpdate.append("STATE_CD,DOC_REMARK ) VALUES (?,?,SYSDATE,'Y',?,?) ");
						
						values.add (maxID);pstm.add ("S");
						values.add (frenNm);pstm.add ("S");						
		                values.add (STATE_CD);pstm.add ("S");
						values.add (DOC_REMARK);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						db.close();
						pstm.clear();
							values.clear();	
							
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
