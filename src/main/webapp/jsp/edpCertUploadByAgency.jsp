
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
	<script language="JavaScript" src="../js/popcalendar.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
    <script src="../js/AgencyUploadValidate.js"></script>
	<link href="../css/jquery-customselect.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="../js/jquery-customselect.js"></script>
    <script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">

$(function() {
$("#EDP_TRG_NAME").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     5,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});
</script>
</head>

<body>
<%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
//out.print(a);
%>
<form method="post"  name="form" id="form" class="form" action="edpCertUploadByAgency.jsp" enctype="multipart/form-data" >
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
    <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
    <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
    <jsp:setProperty name="upBean" property="overwrite" value="false" />
    <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*jpeg,*.png" />
    </jsp:useBean>

	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
		
	   String APP_NAME="";
        //String SUB_DT="";
		//String MOB_NO1="";
		//String E_MAIL="";
		String AADHAR_NO="";
		String EDP_TRG_NAME="";
		String EDP_FR_DT="";
		String EDP_TO_DT="";
		String EDP_CERT_DT="";
		String EDPOFF_CD="";
		
		String UP_ID = "";
		String UPM_CD ="";
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		
		
        DBCon db= new DBCon();
        db.connect();
		

          String docStr="SELECT UPM_CD,DOC_DESC FROM APP_UPLOAD_MAST WHERE  UPM_CD=8";
		  
		    ResultSet rsDoc = db.execSQL(docStr);

         StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");	  
		    qry.append(" A.AADHAR_NO ");			 
			  qry.append(" FROM APP_DETAIL A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' ");
		 

        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");       
		AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		
        
			
			
	ResultSet rsDown=db.execSQL("SELECT OFF_CD,OFF_NAME FROM MAS_OFF_MAST WHERE OFF_TYPE_CD=26 ");			
        %>
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
            <span class="redLebel">(Note  Scanned Copy can be uploaded and file size should not be more than 1mb)</span> </td>
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
		
        <tr>
          <th>Select Edp Training Center </th>
          <th>
		 <span id="EDP_TRG_NAME1"></span>
		  
		  <select name="EDP_TRG_NAME" id="EDP_TRG_NAME" class="custom-select" />
			<% 
			String OFF_CD="";
			String OFF_NAME="";
			 while (rsDown.next()) {
			 OFF_CD=rsDown.getString(1);
			 OFF_NAME=rsDown.getString(2);
			  %>
			<option value="">SELECT</option>
            <option value="<%= OFF_CD %>"><%= OFF_NAME %>(<%= OFF_CD %>)</option>
			<%}
			rsDown.close();
			}		
			rsApp.close();
			%>
			
          </select> 
		</div>
		   </th>
        </tr>
        <tr>
          <th>Training Duration </th>
          <th>From:- 
            <input name="EDP_FR_DT"  type="text"  id="EDP_FR_DT"  size="11" maxlength="11" placeholder="DD-MON-YYYY"> 
            To:-
            <input name="EDP_TO_DT"  type="text"  id="EDP_TO_DT"  size="11" maxlength="11" placeholder="DD-MON-YYYY"></th>
        </tr>
        <tr>
          <th>Certificate Issue Date </th>
          <th><input name="EDP_CERT_DT"  type="text"  id="EDP_CERT_DT"  size="11" maxlength="11" placeholder="DD-MON-YYYY" ></th>
        </tr>
        <tr>
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
        </tr>
        <tr>
          <th>Select File: </th>
          <th><input name="uploadfile" type="file" class="button" id="uploadfile" onchange="ValidateSingleInput(this);"></th>
        </tr>
        <tr>
          <th>Document Remark: </th>
          <th><input name="DOC_REMARKS" type="text" id="DOC_REMARKS" size="50" maxlength="50" ></th>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Close Form" onClick="window.parent.HideModalWindow();">
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
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						UP_ID=(String) mrequest.getParameter("UP_ID")==null?"":(String) mrequest.getParameter("UP_ID").trim();
						APP_ID=(String) mrequest.getParameter("APP_ID")==null?"":(String) mrequest.getParameter("APP_ID").trim();
						UPM_CD=(String) mrequest.getParameter("UPM_CD")==null?"":(String) mrequest.getParameter("UPM_CD").trim();
						DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
						DOC_REMARKS=(String) mrequest.getParameter("DOC_REMARKS")==null?"":(String) mrequest.getParameter("DOC_REMARKS").trim();
						EDP_TRG_NAME=(String) mrequest.getParameter("EDP_TRG_NAME")==null?"":(String) mrequest.getParameter("EDP_TRG_NAME").trim();
						EDP_FR_DT=(String) mrequest.getParameter("EDP_FR_DT")==null?"":(String) mrequest.getParameter("EDP_FR_DT").trim();
						EDP_TO_DT=(String) mrequest.getParameter("EDP_TO_DT")==null?"":(String) mrequest.getParameter("EDP_TO_DT").trim();
						EDP_CERT_DT=(String) mrequest.getParameter("EDP_CERT_DT")==null?"":(String) mrequest.getParameter("EDP_CERT_DT").trim();
						
						
						
						
						
						
						StringBuffer qryUpdate = new StringBuffer();
						    List values=new ArrayList();
							List pstm=new ArrayList();
							
						
						qryUpdate.append(" INSERT INTO EDP_CONDUCT_TRANS ( UP_ID,");
						qryUpdate.append("APP_ID,");											
						qryUpdate.append("DOC_NAME,");
						qryUpdate.append("DOC_REMARKS," );
						qryUpdate.append("EDP_TRG_NAME,");
						qryUpdate.append("EDP_FR_DT,");
						qryUpdate.append("EDP_TO_DT,");
						qryUpdate.append("EDP_CERT_DT," );
						qryUpdate.append("EDPTIMESTAMP )  VALUES (?,?,?,?,?,?,?,?,SYSDATE) ");
						
						values.add (maxID);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");						
						values.add (frenNm);pstm.add ("S");
		                values.add (DOC_REMARKS);pstm.add ("S");
						values.add (EDP_TRG_NAME);pstm.add ("S");
						values.add (EDP_FR_DT);pstm.add ("S");
						values.add (EDP_TO_DT);pstm.add ("S");
						values.add (EDP_CERT_DT);pstm.add ("S");						
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
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
