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
<LINK rel="stylesheet" type="text/css" href="main1.css">
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
		String SOFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");
		String month_dt=request.getParameter("MONTHDT")==null?"":(String)request.getParameter("MONTHDT");
        String invupid =request.getParameter("INVDT")==null?"0":(String)request.getParameter("INVDT");
		
		
		
		
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		String ID="";
		
        DBCon db= new DBCon();
        db.connect();


         
		  
		   kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("SAMADHANUPLOAD/"); 


       
			
		
        %>
			<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*jpeg,*.png" />
 </jsp:useBean>
  </p>
	  <table align="center" id="customers">
        <tr>
          <th colspan="2" scope="col"><div align="center">RECOMMENDATION LETTER UPLOAD FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr> 
          <td colspan="2" scope="col"><input id="invupid" name="invupid" type="hidden" value="<%=invupid%>"> 
		  <input id="month_dt" name="month_dt" type="hidden" value="<%=month_dt%>">		  </td>
        </tr>
        
        <tr>
          <td colspan="2" scope="col"><div align="center">( file format should be in pdf,jpg,png) </div></td>
        </tr>
        <tr>
          <th scope="col"> Invoice ID 
          <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value=""></th>
          <td scope="col"> <%=invupid%></th>
        </tr>
        <tr>
          <th>MONTH: </th>
          <td scope="col"><%=month_dt%></th>
        </tr>
        
      
        <tr>
          <th> Document: </th>
          <td scope="col"><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
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
						ResultSet rsMax = db.execSQL("SELECT BNFREC_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
						 
						 while (rsMax.next()) {
						 maxID=rsMax.getString(1);
						 }
						
						rsMax.close();
						
						String frenNm="samaref"+maxID+"."+ext;
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						
						month_dt=(String) mrequest.getParameter("month_dt")==null?"":(String) mrequest.getParameter("month_dt").trim();
						invupid=(String) mrequest.getParameter("invupid")==null?"":(String) mrequest.getParameter("invupid").trim();
						
						
						
						List values=new ArrayList();
						List pstm=new ArrayList();
						
						StringBuffer sbY = new StringBuffer();
		 sbY.append(" UPDATE BNF_ONLINEEDP_INF SET RECOM_LET_UPLOAD=?,RECOM_DATE=sysdate WHERE invupid=? AND trunc(month_dt)=?");  
  values.add(frenNm);pstm.add("D");
  values.add(invupid);pstm.add("D");
  values.add(month_dt);pstm.add("D");
try{
			db.setSqlValue(sbY.toString());
			db.setValues(values,pstm);
			db.executeUpdate() ;
			db.close();
			response.sendRedirect("savemsg.jsp");		
	}catch(Exception e) { 	
	out.print(e.toString()); 
	}
	pstm.clear();
    values.clear();	
	
							
							
							
							
							
							
							
					
							
							
							
							
						
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