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
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
//out.print(a);
%>



<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*jpeg,*.png" />
 </jsp:useBean>

	  <p>
	    <%
		String IFS_CODE=(String)session.getAttribute("bank_id");
		String IFSC_CODE="";
		//String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
		//out.print(IFS_CODE);
		String APP_ID= (String) session.getAttribute("SAPPID");
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		
		String UP_ID = "";
		String UPM_CD = "20";
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		
		
        DBCon db= new DBCon();
        db.connect();

          String docStr="SELECT UPM_CD,DOC_DESC FROM APP_UPLOAD_MAST WHERE  UPM_CD=20";
		  
		    ResultSet rsDoc = db.execSQL(docStr);

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME, IFSC_CODE, ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' AND ACT_YN='Y' ");
		 

        ResultSet rsApp = db.execSQL(qry.toString());
      
	  int count=0;

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		 IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
		count=count+1;
        }
			rsApp.close();
			
		String REMTRID="";
			
			StringBuffer qryUp = new StringBuffer();	
			
		qryUp.append("  SELECT REMTRID from bank_dataentry where app_id='"+APP_ID+"' ");
		
			
	ResultSet rsUp = db.execSQL(qryUp.toString());		
		 while (rsUp.next()){
		REMTRID=rsUp.getString("REMTRID")==null?"":rsUp.getString("REMTRID");
		 }	
		
        %>
  </p>
  <% if (count>0 ) { %>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT CANCEL MM CLAIM FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr> <input id="MOB_NO1" name="MOB_NO1" type="hidden" value="<%=MOB_NO1%>">
          <td colspan="2" scope="col"><input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
		  <input id="REMTRID" name="REMTRID" type="hidden" value="<%=REMTRID%>"> 
            <span class="redLebel">(Note: Once Claim is cancelled it will be returned to the applicant and you will not be able to resubmit the claim)</span> </td>
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
          <th>Name </th>
          <th><div align="left">
              <div align="left"><%= APP_NAME %> </div></th>
        </tr>
        <!--<tr>
          <th>Upload  Type: </th>
          <th><select name="UPM_CD" class="button" id="UPM_CD">
			<% 
			String CUPM_CD="";
			String CDOCDESC="";
			 while (rsDoc.next()) {
			 CUPM_CD=rsDoc.getString(1);
			 CDOCDESC=rsDoc.getString(2);
			  %>
            <option value="<%= CUPM_CD %>"><%= CDOCDESC %></option>
			<%}
			rsDoc.close();
			%>
          </select>          </th>
        </tr>-->
        <tr>
          <th>Supporting Document: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
        <tr>
          <th>Cancel Remarks </th>
          <td><input name="DOC_REMARKS" type="text" id="DOC_REMARKS" size="50" maxlength="50"></td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
		    <input name="btnUpload" type="button" class="button" id="btnUpload" value="Cancel Claim" onClick="submit_form();">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Close Form" onClick="window.parent.HideModalWindow();">
          
          </div></th>
        </tr>
      </table>
	  
	 <%
	 } else { out.print ("cancelled application or session out");}
	 
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
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						UP_ID=(String) mrequest.getParameter("UP_ID")==null?"":(String) mrequest.getParameter("UP_ID").trim();
						APP_ID=(String) mrequest.getParameter("APP_ID")==null?"":(String) mrequest.getParameter("APP_ID").trim();
						UPM_CD=(String) mrequest.getParameter("UPM_CD")==null?"20":(String) mrequest.getParameter("UPM_CD").trim();
						DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
						DOC_REMARKS=(String) mrequest.getParameter("DOC_REMARKS")==null?"":(String) mrequest.getParameter("DOC_REMARKS").trim();
						REMTRID=(String) mrequest.getParameter("REMTRID")==null?"":(String) mrequest.getParameter("REMTRID").trim();
						MOB_NO1=(String) mrequest.getParameter("MOB_NO1")==null?"":(String) mrequest.getParameter("MOB_NO1").trim();
						//out.print(UP_ID);
						
						//out.print(APP_ID);
						
						//out.print(UPM_CD);
						//out.print(DOC_NAME);
				
						//out.print(DOC_REMARKS);
						String verror="";
						
						List values=new ArrayList();
						
String validateqry="(SELECT FUNC_RETURNAPP_REFER(?,?,?,?,?) from dual  )";

    values.add (APP_ID); 
	 values.add (IFSC_CODE);
	 values.add (REMTRID);
	 values.add (maxID);
	values.add (frenNm);				
						
	ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;
response.sendRedirect("savepage.jsp");
	
							
							
						
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