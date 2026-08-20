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

<html>


<head>


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
<script language="javascript" src="js/ModalPopupWindow.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="js/inlinemessages.js"></script>
<script>
function submitform(){

document.form.ins.value='I';
document.form.submit();

}
</script>

<html>
<style type="text/css">
<!--
.style1 {font-size: 16px}
.button{
    background-color: #3f506e;
  color:#FFFFFF;
  border: none;

  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
  }

-->
</style>

<head>
<title>PMEGP AWARD</title>
</head>
<body>

<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >
<%
String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");

kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("pmegpaward/"+sAPP_ID+"/");

%>

  <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
<jsp:setProperty name="upBean" property="folderstore" value="<%=a%>"/>
  <jsp:setProperty name="upBean" property="filesizelimit" value="3000000" />
  <jsp:setProperty name="upBean" property="overwrite" value="false" />
  <jsp:setProperty name="upBean" property="whitelist" value="*.jpg,*.png,*.jpeg,*.pdf" />
  </jsp:useBean>
  


      <%
String app_id =request.getParameter("app_id")==null?"0":(String)  request.getParameter("app_id") ;
String TYPE = request.getParameter("TYPE")==null?"0":(String)  request.getParameter("TYPE") ;
	  
String uploadfile="";
String INST_LOGO="";
String KI_CODE="";
String anl_updoc1="";
String anl_updoc2="";
String anl_updoc3="";
String iso_updoc="";
String gst_updoc="";
String udyam_updoc="";
String trademark_updoc="";
String gem_updoc="";
String ecom_updoc="";
String HEADING="";

DBCon db= new DBCon();
db.connect();
List values=new ArrayList();	
List pstm=new ArrayList();


String PKI_CODE="";
String PINST_LOGO="";
String PKINAME="";

	if(TYPE.equals("A")){
			HEADING="Upload CA Certificate for year 2018-19";					
						}else if(TYPE.equals("B")){
						HEADING="Upload CA Certificate for year 2019-20";		
						}else if(TYPE.equals("C")){
						HEADING="Upload CA Certificate for year 2020-21";
						}else if(TYPE.equals("D")){
						HEADING="ISO CERTIFICATE";
						}else if(TYPE.equals("E")){
						HEADING="GST REGISTRATION CERTIFICATE";
						}else if(TYPE.equals("F")){
						HEADING="UDYAM REGISTRATION CERTIFICATE";
						}else if(TYPE.equals("G")){
						HEADING="TRADEMARK REGISTRATION";
						}else if(TYPE.equals("H")){
						HEADING="GEM/CPP CERTIFICATE";
						}else if(TYPE.equals("I")){
						HEADING="E-COMMERCE CERTIFICATE";	
						}else if(TYPE.equals("J")){
						HEADING="SUPPLY TO GOVERNMENT /PUBLIC OFFICES/CORPOTAYES CERTIFICATE";	
						}else if(TYPE.equals("K")){
						HEADING="PARTICIPATION IN NATIONAL/ LOACAL LEVEL EXHIBITIONS, TRADE FAIRS ECT. CERTIFICATE";		
						}
						

//StringBuffer qrysb= new StringBuffer();
//qrysb.append(" SELECT anl_updoc1,anl_updoc2,anl_updoc3,iso_updoc,gst_updoc ,udyam_updoc ,trademark_updoc,gem_updoc,ecom_updoc FROM pmegp_award WHERE //app_id='KVTN16176970-1222110' "      );

 //values.add (TYPE); 
 //out.print(TYPE);
 //out.print(app_id);

 //ResultSet rsLogo = db.executeSQL(qrysb.toString(),values);
//values.clear();

//while ( rsLogo.next()) {
//anl_updoc1=rsLogo.getString("anl_updoc1");
//anl_updoc2=rsLogo.getString("anl_updoc2");
//anl_updoc3=rsLogo.getString("anl_updoc3");
//iso_updoc=rsLogo.getString("iso_updoc");
//gst_updoc=rsLogo.getString("gst_updoc");
//udyam_updoc=rsLogo.getString("udyam_updoc");

//trademark_updoc=rsLogo.getString("trademark_updoc");
//gem_updoc=rsLogo.getString("gem_updoc");
//ecom_updoc=rsLogo.getString("ecom_updoc");



//}
//rsLogo.close();


String sqlQry="";
String err="";

try {
 
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
		 KI_CODE=mrequest.getParameter("KI_CODE")==null?"":mrequest.getParameter("KI_CODE");
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
				
				
					String frenNm="PA_"+sAPP_ID+"_"+TYPE+"_"+rnddt+"."+ext;
						//  out.print(TUP_ID+"--TUP_ID");
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						
						
						
						if(TYPE.equals("A")){
						sqlQry="UPDATE pmegp_award SET anl_updoc1=?  WHERE APP_ID=?";
						
						}else if(TYPE.equals("B")){
						sqlQry="UPDATE pmegp_award SET anl_updoc2=?  WHERE APP_ID=?";
						
						}else if(TYPE.equals("C")){
						sqlQry="UPDATE pmegp_award SET anl_updoc3=?  WHERE APP_ID=?";
						
						}else if(TYPE.equals("D")){
						sqlQry="UPDATE pmegp_award SET iso_updoc=?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("E")){
						sqlQry="UPDATE pmegp_award SET gst_updoc=?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("F")){
						sqlQry="UPDATE pmegp_award SET udyam_updoc=?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("G")){
						sqlQry="UPDATE pmegp_award SET trademark_updoc=?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("H")){
						sqlQry="UPDATE pmegp_award SET gem_updoc=?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("I")){
						sqlQry="UPDATE pmegp_award SET ecom_updoc =?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("J")){
						sqlQry="UPDATE pmegp_award SET supply_updoc =?   WHERE APP_ID=?";
						
						}else if(TYPE.equals("K")){
						sqlQry="UPDATE pmegp_award SET partic_updoc =?   WHERE APP_ID=?";
						
						}
						
						
						
						frenNm=ext.equals("")?PINST_LOGO:frenNm;
							
					   values.add(frenNm); pstm.add ("L");
					   values.add(sAPP_ID); pstm.add ("L");
					   					   
					db.setSqlValue(sqlQry);
					db.setValues(values,pstm);
					db.executeUpdate();
					
					db.close();
					
		            PINST_LOGO=frenNm;			
						// response.sendRedirect("../../pmegpeportalappdoc/honeymission/uploaddoc/"+PINST_LOGO);
												response.sendRedirect("savemsg.jsp");

						}
						}
						}
		}catch (Exception m) {
		//out.print(m.toString());
		try{
		err=m.toString();
		err=err.substring(33,err.length());
		}catch(Exception e){}
		}			
%>


  
			  <input name="todo" type="hidden" value="upload"/>
			  <input name="ins" type="hidden" id="ins"/>
</p>
</p>
<br>
  
		<br>
        <table  align="center" border="1">
  <tr>
  
    <th colspan="4" style="background-color: #3f506e;
  color:#FFFFFF;"><div align="center"><H2><%= HEADING %><H2></div></td>  </tr>
  <tr>
    <th rowspan="2"><span class="style1">Note: </span></th>
    <th width="310"><span class="style1">1. Only jpg,png,jpeg File can be uploaded </span></th>
  </tr>
  <tr>
    <th><span class="style1">2. The file size should be not more than 3 MB </span></th>
  </tr>

  <tr >
    <th width="106"><H3>Select File for</H3><%= HEADING %></th>
    <th colspan="3">
      <input name="uploadfile" type="file" id="uploadfile"  value="<%=anl_updoc1 %>" class="button" >
	  <input name="anl_updoc1" type="hidden" id="anl_updoc1" value="<%=anl_updoc1 %>">  </th>
  </tr>
   
  <% if(!err.equals("")){ %>
  <tr >
    <td colspan="4" class="error"><%= err %></td>
  </tr>
  <% } %>
  <tr >
    <td colspan="4"><div align="center">
      <input name="button" type="button" class="button"  onClick="submitform();" value="Save">
    </div></td>
    </tr>
</table>
 

  <td colspan="2" >&nbsp;  </td>
    



</form>
<%
%>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");

 function HideModalWindow() {
    modalWin.HideModalPopUp();
}


function refreshpage() {
   form.submit(); 
}
	
     </script>
</body>
</html>
