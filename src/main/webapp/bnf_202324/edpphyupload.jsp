<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat"  %>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="  org.apache.poi.xssf.usermodel.XSSFWorkbook"  %>
<%@ page import="  org.apache.poi.hssf.usermodel.HSSFWorkbook"  %>

<%@ page import=" org.apache.poi.ss.util.CellRangeAddress"  %>
<%@ page import="org.apache.poi.ss.usermodel.*"  %>
<%@ page import="pkgPmegpNew.DBCon"%>

<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.FileInputStream"  %>
<%@ page import="java.io.FileNotFoundException"  %>
<%@ page import="java.io.IOException"  %>
<%@ page import="java.util.Iterator"  %>

<%@ page import="java.io.File"  %>

 <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>

<html>


<head>
<link rel="stylesheet" href="../stylesheets/pmegpNew.css">
<script language="javascript" src="../js/inlinemsg.js"></script>
<script language="javascript" src="../js1/popcalendar.js"></script>
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

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
function submitform(){
document.form.INS.value='I';

document.form.submit();
}
</script>

<html>
<style type="text/css">
<!--
.style1 {color: #990000}
.style2 {color: #FFFFFF}
-->
</style>
<head>
<title>State Office Upload Form</title>
</head>
<body>

<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >

        <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="E:\tomcat5\webapps\pmegpeportal\bnf\upload" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="5000000" /> 
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.xlsx,*.xls" /></jsp:useBean>


      <%
	  String BNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID").trim();   
String BNF_DESC=request.getParameter("PBNF_DESC")==null?"":(String)request.getParameter("PBNF_DESC").trim();  	  

	  String INS="N";
	  String uploadfile="";
	  String INST_LOGO="";
	  
String BNF_AFROMDT = request.getParameter("BNF_AFROMDT")==null?"":(String)request.getParameter("BNF_AFROMDT").trim();   
String BNF_ATODT = request.getParameter("BNF_ATODT")==null?"":(String)request.getParameter("BNF_ATODT").trim();   
	   String CUSTCODE=request.getParameter("CUSTCODE")==null?"0":(String)  request.getParameter("CUSTCODE") ;  
	String MASTTRANS=request.getParameter("MASTTRANS")==null?"0":(String)  request.getParameter("MASTTRANS") ;  
String successFail=request.getParameter("success")==null?"0":(String)  request.getParameter("success") ;	
String TYPE_FLAG=request.getParameter("TYPE_FLAG")==null?"":(String)  request.getParameter("TYPE_FLAG") ;
//out.print(TYPE_FLAG);
String PRODUCT_DESC="";
String ACT_YN="";
String PROD_DESIGN="";
String PROD_SIZE="";
String COLOUR="";
String ADDT_DESC="";
String UPLOAD_ID="";
String FILENAME="";
String BATCH_ID="";
String BATCHIDPAYID="";
 DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();




	String sqlQry="";
String err="";
 


%>
  
			  <input type="hidden" name="todo" value="upload"/><input name="INS" type="hidden" id="INS" value="<%= INS %>" />
</p>
<CENTER><br>

<br>
<br><br>
        <table width="50%" border="1" align="center">
  <input name="BNF_TRID" type="hidden" id="BNF_TRID" size="20" maxlength="18" value="<%=BNF_TRID %>" >
  <tr>
    <td colspan="4" bgcolor="#003300"><div align="center"><span class="style2"><strong><h2><center><%=BNF_DESC%></center></h2></strong></span></div></td>
  </tr>
  <tr>
    <th><span class="style1">Note: </span></th>
    <th colspan="3"><span class="style1">1. Only xlsx,xls File can be uploaded </span></th>
    </tr>
  <tr >
    <th></th>
    <th colspan="3"><span class="style1">2. The file size should be not more than 1000 kb </span></th>
  </tr>  
  <tr >
    <th>Select Excel File : </th>
    <th colspan="3"><span class="s">
      <input name="uploadfile" type="file" class="button" id="uploadfile" >
</span>   </th>
  </tr>
  
    <% if(!err.equals("")){ %>

  <tr >
    <td colspan="4" class="error"><%= err %></td>
  </tr>
  <% } %>
  <tr >
    <th colspan="4"><div align="center">
      <input name="BtnSave" type="button" class="buttonMerun" id="BtnSave" onClick="submitform();" value="Upload">
	  <a href="dataentry.jsp" class="buttonGreen" >Back</a>
    </div></th>
    </tr>
</table>
 <%


 
 try {                              //try 1
 
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {                                                //if 2
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {                                                     //if3
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {     												//if 4
                    UploadFile file = (UploadFile) files.get("uploadfile");
					
					 upBean.store(mrequest, "uploadfile");
						String maxID="1111";
						
						Date dNow = new Date();
						SimpleDateFormat ft = new SimpleDateFormat("yyMMddhhmmssMs");
						String rnddt = ft.format(dNow);
						
						String ext=getExtension(file.getFileName());
						String frenNm="DOC"+"_"+rnddt+"."+ext;
						
						
						File f = new File("E:\\tomcat5\\webapps\\pmegpeportal\\bnf\\upload\\"+file.getFileName()+"");
						
						boolean success =f.renameTo(new File("E:\\tomcat5\\webapps\\pmegpeportal\\bnf\\upload\\"+frenNm+""));
						
									
						BNF_TRID=(String) mrequest.getParameter("BNF_TRID")==null?"":(String) mrequest.getParameter("BNF_TRID").trim();
						out.print(BNF_TRID);
						out.print(frenNm);
						StringBuffer qryUpdate = new StringBuffer();
						
						
							
							qryUpdate.append(" UPDATE BNF_FO_TRANS SET DOCFNAME=? WHERE BNF_TRID=? ");
													
							values.add (frenNm);pstm.add ("S");
							values.add (BNF_TRID);pstm.add ("S");
							db.setValues(values,pstm);
						    db.setSqlValue(qryUpdate.toString());
						    db.executeUpdate() ;
						    pstm.clear();
							values.clear();							
							

response.sendRedirect("savemsg.jsp");
 /*			
StringBuffer qryUpdate1 = new StringBuffer();		
qryUpdate1.append(" DELETE FROM TBL_TEMP_WAGES ");

//  out.print(ROW_ID);

try{
db.setSqlValue(qryUpdate1.toString());
db.setValues(values,pstm);
db.executeUpdate() ; 
//out.print(qryUpdate1.toString());
}catch(Exception e){
out.print (e.toString());
}
 values.clear();
pstm.clear();
*/ 
 
 
 
 
 
 		  String vDetail="";
  String excelFilePath = "E:\\Tomcat5\\webapps\\pmegpeportal\\pmegpappupload\\"+frenNm;
  
 //ApachePOIExcelRead sm = new ApachePOIExcelRead();
//	String vpath="D:/TEST/igl_18011603390919.xlsx";
	
//sm.ShowPath (excelFilePath);



	



						}    //if 4
						}    //if 3
						
						
						}		//if 2
		
 
 //out.print("SUCCESS");
}catch(Exception e){
out.print(e.toString());
out.print("<br><br><center><span class='error'>Invalid File Format .........Please upload correct file </span></center>");
}

 

 
 %>
 


</form>
</body>
</html>
