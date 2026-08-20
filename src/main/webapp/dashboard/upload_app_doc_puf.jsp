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
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
	<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
	<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">
window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {


var CIR_SUB= document.form.CIR_SUB.value;
var CIR_DATE= document.form.CIR_DATE.value;
var CIR_NO= document.form.CIR_NO.value;
var CIR_UPLOAD= document.getElementById('uploadfile');

   if(CIR_SUB == "") {
    inlineMsg('CIR_SUB','Enter Circular Subject',2);
    return false;
  }


 if(CIR_DATE == "") {
    inlineMsg('CIR_DATE','Enter Circular Date',2);
    return false;
  }
  
  if(CIR_NO == "") {
    inlineMsg('CIR_NO','Enter Circular No',2);
    return false;
  }
 

 if(CIR_UPLOAD.files.length === 0){
      inlineMsg('uploadfile','Upload Circular',2);
        CIR_UPLOAD.focus();
        return false;
    }
	
	
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>

<form method="post" action="upload_app_doc_puf.jsp" name="form" id="form" class="form" enctype="multipart/form-data" >
<%
String a="/opt/tomcat5/webapps/pmegpeportal/dashboard/notification/";
%>
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>"/>
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*.jpeg,*.png" />
 </jsp:useBean>

	  <p>
	    <%
		
		
		
String CIR_ID=request.getParameter("CIR_ID")==null?"0":(String) request.getParameter("CIR_ID");
String CIR_SUB="";
String CIR_DATE="";
String KVIC_MSME="";
String FILE_NM="";
String ACT_YN="";
String CIRTIMESTAMP="";
String CIR_NO="";
		

		
		
        DBCon db= new DBCon();
        db.connect();

           %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">Online Circular Upload Form </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col"><input id="CIR_ID" name="CIR_ID" type="hidden" value="<%=CIR_ID%>"> 
            <span class="redLebel">(Note  Scanned Copy can be uploaded and file size should not be more then 1 mb)</span> </td>
        </tr>
        
        <tr>
          <th scope="col"> Circular ID 
            <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value="">
          (Auto Generated) </th>
          <th scope="col"><%= CIR_ID %> </th>
        </tr>
        <tr>
          <th>Subject</th>
          <th><div align="left">
              <div align="left">
                <input name="CIR_SUB" type="text" id="CIR_SUB" size="50" maxlength="50" value="<%=CIR_SUB%>">
              </div></th>
        </tr>
        <tr>
          <th>Date</th>
          <th><input name="CIR_DATE" type="text" id="CIR_DATE" size="50" maxlength="50" value="<%=CIR_DATE%>" placeholder="DD-MON-YYYY" onClick="javascript:NewCssCal('CIR_DATE','ddMMMyyyy')" ></th>
        </tr>
        <tr>
          <th>Circular No </th>
          <th><input name="CIR_NO" type="text" id="CIR_NO" size="50" maxlength="50" value="<%=CIR_NO%>"></th>
        </tr>
        <input name="KVIC_MSME" type="hidden" id="KVIC_MSME" size="50" maxlength="50" value="<%=KVIC_MSME%>">
        <tr>
          <th>Select File: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
        
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="UPLOAD" onClick="submit_form();">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="self.close();">
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
												//String frenNm="app"+maxID+"."+ext;
						String frenNm1="notification/"+file.getFileName();
						String frenNm=file.getFileName();
						
						File f = new File("/opt/tomcat5/webapps/pmegpeportal/dashboard/notification/"+file.getFileName()+"");
						//File f = new File(a+file.getFileName()+"");
						
						//boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						CIR_ID=(String) mrequest.getParameter("CIR_ID")==null?"":(String) mrequest.getParameter("CIR_ID").trim();
						CIR_SUB=(String) mrequest.getParameter("CIR_SUB")==null?"":(String) mrequest.getParameter("CIR_SUB").trim();
						CIR_DATE=(String) mrequest.getParameter("CIR_DATE")==null?"":(String) mrequest.getParameter("CIR_DATE").trim();
						KVIC_MSME=(String) mrequest.getParameter("KVIC_MSME")==null?"":(String) mrequest.getParameter("KVIC_MSME").trim();
						CIR_NO=(String) mrequest.getParameter("CIR_NO")==null?"":(String) mrequest.getParameter("CIR_NO").trim();

						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
							
							
							if (CIR_ID.equals("0")) {

 ResultSet rsMax1= db.execSQL("select nvl(max(CIR_ID),0)+1 from PMEGPONLINE.CIRCULARS ");
     while (rsMax1.next()) {
     CIR_ID=rsMax1.getString(1);
     }
rsMax1.close();

		out.print(CIR_ID);
		out.print(CIR_SUB);
		out.print(CIR_DATE);
		out.print(KVIC_MSME);
		out.print(frenNm1);out.print(CIR_NO);
						
						
						qryUpdate.append(" INSERT INTO PMEGPONLINE.CIRCULARS ( CIR_ID,");
						qryUpdate.append("CIR_SUB,");
						qryUpdate.append("CIR_DATE,");
						qryUpdate.append("KVIC_MSME,");
						qryUpdate.append("FILE_NM,ACT_YN,CIRTIMESTAMP,CIR_NO ) VALUES (?,?,?,'KVIC',?,'Y',sysdate,?) ");
						
						values.add (CIR_ID);pstm.add ("S");
						values.add (CIR_SUB);pstm.add ("S");
						values.add (CIR_DATE);pstm.add ("S");
						values.add (frenNm1);pstm.add ("S");
		                values.add (CIR_NO);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
							values.clear();	
							db.close();
							response.sendRedirect("savemsg.jsp");
						}// CIR
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
