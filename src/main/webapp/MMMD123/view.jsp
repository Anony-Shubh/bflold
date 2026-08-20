<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
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


<html xmlns="http://www.w3.org/1999/xhtml">
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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" href="css/bootstrap.min.css" /> 
 <SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>
<style type="text/css">
<!--
.style1 {font-weight: bold}

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}-->
</style>
<script>
function submit_form() {
	alert("fggg");
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>
<FORM  name="form" action="view.jsp" id="form" method="post" enctype="multipart/form-data" >
<div class="container">


<%
 DBCon db= new DBCon();
db.connect();
String MIID=(String)session.getAttribute("sMIID");
String M_OTP=(String)session.getAttribute("sM_OTP");
out.print(M_OTP);
out.print(MIID);
String DOC_OTP="";	 
String DOC_NAME="";
	 List values=new ArrayList();
 List pstm=new ArrayList();
%>
<%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("pmegpeportalupload/KHADIMHTSV/");
%>
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>"/>
  <jsp:setProperty name="upBean" property="filesizelimit" value="4000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*.jpeg,*.png" />
 </jsp:useBean>
<br /><br />
<br />

  <table align="center" width="100%" id="customers"  >
        <tr>
		  <input type="hidden" name="todo" value="upload"/>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col">
            <span class="redLebel">(Note  Scanned Copy can be uploaded and file size should not be more then 1 mb)</span> </td>
        </tr>
        
       
        <tr>
          <th>Select File: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile">
		 
		   <input name="ins" type="hidden" id="ins" value=""></th></th>
        </tr>
        <tr>
          <th>OTP </th>
          <td><input name="DOC_OTP" type="text" id="DOC_OTP" value="<%=DOC_OTP%>" size="50" maxlength="8"></td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            
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
						 ResultSet rsMax = db.execSQL("SELECT APPUPLOAD_SEQ.NEXTVAL AS MAX_ID FROM SYS.DUAL");
						 
						 while (rsMax.next()) {
						 maxID=rsMax.getString(1);
						 }
						
						rsMax.close();
						
						String frenNm="app"+maxID+"."+ext;
						
						
						//File f = new File("/opt/tomcat5/webapps/pmegpeportal/pmegpappupload/"+file.getFileName()+"");
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						DOC_OTP=(String) mrequest.getParameter("DOC_OTP")==null?"":(String) mrequest.getParameter("DOC_OTP").trim();
						
						
						out.print("M"+M_OTP);
						out.print("D"+DOC_OTP);
						try{
						if (DOC_OTP.equals(M_OTP)) {
		String docStr="update MMMD_DETAIL set DOC_NAME='"+frenNm+"',ACT_YN='Y',UPLOAD_TIMESTAMP=SYSDATE where MIID=3 ";
		    ResultSet rsDoc = db.execSQL(docStr);	
			
						}}catch (Exception e) {
out.print (e.toString());
}
						
						db.close();
							
							response.sendRedirect("view.jsp");
							}//end of jpg

						}
						}
						}
						
			
						
} catch (Exception e) {
out.print (e.toString());
}finally{

}
						%>

</div>
</FORM>
</body>


</html>


