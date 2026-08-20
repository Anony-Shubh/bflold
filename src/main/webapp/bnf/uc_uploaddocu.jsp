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
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

 <%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>

<HTML>
<HEAD>
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

<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT language="javascript" src="js/sweetalert.min.js"></SCRIPT>
<SCRIPT>
function submitform(){
 var uploadfile = document.form.uploadfile.value;
 var allowedExtensions = /(\.jpg|\.jpeg|\.pdf|\.PDF)$/i;
 
if(uploadfile == ""){
swal("Document Upload", "Upload Document in JPG/PDF format", "error");
 return false;
}


    if(!allowedExtensions.exec(uploadfile)){
	swal("Document Upload", "File format Not in PDF/JPG format", "error");
             
        return false;
  }



document.form.submit();
}
</SCRIPT>

<STYLE type="text/css">

* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 60%;
}



#customers td, #customers th {
    border: 1px solid #000000;
    padding: 4px;
	font-size:13px;
	font-weight:bold;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: #2e7d22;
    color: white;
}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.myButton {
	background-color:#2e823c;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.style1 {font-size: large}
</STYLE>

</HEAD>
<BODY>

 <%

kvicGlobalPath sm = new kvicGlobalPath();
String globalpath=sm.getStorage("bnf/uc_upload/");
//out.print (globalpath);
		
%>


<FORM method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >

  <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%= globalpath %>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="5000000" />
  <jsp:setProperty name="upBean" property="overwrite" value="false" />
  <jsp:setProperty name="upBean" property="whitelist" value="*.jpg,*.pdf,*.jpeg,*.png" />
  </jsp:useBean>

      <%
						DBCon db= new DBCon();
                        db.connect();
String uploadfile="";
String UC_ID = request.getParameter("UC_ID")==null?"":request.getParameter("UC_ID");

List values=new ArrayList();	
List pstm=new ArrayList();

String UC_UPLOAD_NAME="";
String sqlQry="";
String err="";

try {
 
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
		// DOC_REMARKS=mrequest.getParameter("DOC_REMARKS")==null?"":mrequest.getParameter("DOC_REMARKS");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {
                    UploadFile file = (UploadFile) files.get("uploadfile");
				
					 upBean.store(mrequest, "uploadfile");
						
						Date dNow = new Date();
						SimpleDateFormat ft = new SimpleDateFormat("yyMMddhhmmssMs");
						String rnddt = ft.format(dNow);
						
						String ext="";
						try{
						ext=getExtension(file.getFileName());
						}catch(Exception e){}

						
						String frenNm="doc"+UC_ID+"_"+rnddt+"."+ext;
						
						
						//File f = new File("E:\\Tomcat5\\webapps\\HRD\\otherdocu\\"+file.getFileName()+"");
						File f = new File(globalpath+file.getFileName()+"");
						//f.renameTo(new File(globalpath+frenNm+""));
     					boolean success =f.renameTo(new File(globalpath+frenNm+""));
						if(UC_ID.equals("")){
						ResultSet rsMax= db.execSQL("SELECT NVL(MAX(UC_ID),0)+1 AS UC_ID FROM BATCH_MAST");
		   while (rsMax.next()) {  //6
           UC_ID=rsMax.getString(1);
           }  rsMax.close();
						sqlQry="INSERT INTO  BATCH_MAST (UC_UPLOAD_NAME) VALUES (?) ";
						}else{
						sqlQry="UPDATE BNF_UC SET UC_UPLOAD_NAME=?, UC_UPLOAD_DT=SYSDATE WHERE UC_ID=? ";
						}
						frenNm=ext.equals("")?UC_UPLOAD_NAME:frenNm;
					   values.add(frenNm); pstm.add ("L");
					  // values.add(DOC_REMARKS); pstm.add ("L");
					  // values.add(PPEN_EMP_CODE); pstm.add ("L");
					   //values.add(UPM_CD); pstm.add ("L");
					   values.add(UC_ID); pstm.add ("L");
					db.setSqlValue(sqlQry);
					db.setValues(values,pstm);
					db.executeUpdate();
					db.close();
					response.sendRedirect("savemsgnew.jsp");						
						}
						}
						}
		}catch (Exception m) {
		try{
		err=m.toString();
		err=err.substring(33,err.length());
		}catch(Exception e){}
		}			
%>
			  <INPUT name="todo" type="hidden" value="upload"/>
</p>
      
<TABLE id="customers" align="center">
  <TR>
    <TH colspan="4"><DIV align="center"><SPAN class="style2">UPLOAD SIGNED UC</SPAN></DIV></TH>
  </TR>
  <TR>
    <TD colspan="4"><div align="center"><SPAN class="style1">Note: </SPAN><SPAN class="style1">1. Only jpg,jpeg,pdf File can be uploaded </SPAN></div></TD>
    </TR>
  
  <TR >
    <TD colspan="4"><div align="center">Max File size should be within 5 mb </div></TD>
    </TR>
  <TR >
    <TD><DIV align="left">Select File </DIV></TD>
    <TD colspan="3"><SPAN class="s">
      <INPUT name="uploadfile" type="file" class="myButton2" id="uploadfile" >
      <INPUT name="UC_UPLOAD_NAME" type="hidden" id="UC_UPLOAD_NAME" value="">
</SPAN>   </TD>
  </TR>

  <% if(!err.equals("")){ %>
  <TR class="text_header" >
    <TD colspan="4" class="error"><%= err %></TD>
  </TR>
  <% } %>
  <TR >
    <TD colspan="4"><DIV align="center">
	<a class="myButton" onClick="submitform();">Save</a>
    </DIV></TD>
    </TR>
</TABLE> 

</FORM>

</BODY>
</HTML>
