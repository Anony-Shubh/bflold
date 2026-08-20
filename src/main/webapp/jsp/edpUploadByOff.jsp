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

<%@ page import="in.gov.mgov.mobileseva.SendSMS"%>
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
<script src="../js/inlineMsgMain.js"></script>
<script language="javascript">
function closeAndRefresh(){
      window.parent.refreshpage();
    }
function submit_form() {
 var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');

	            var UPLOADFILE = document.form.uploadfile.value; 
				var EDP_FR_DT = document.form.EDP_FR_DT.value; 
				var EDP_TO_DT = document.form.EDP_TO_DT.value; 
				var EDP_CERT_DT = document.form.EDP_CERT_DT.value; 
				
				if (UPLOADFILE == "") {
	
	inlineMsg('uploadfile',"PLEASE SELECT FILE",2);
    return false;
	  }
  
				
	
	if (EDP_FR_DT == "") {
	
	inlineMsg('EDP_FR_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  
  if (EDP_FR_DT == "") {
	
	inlineMsg('EDP_FR_DT',"PLEASE SELECT FROM DATE",2);
    return false;
	  }
  
  if (EDP_TO_DT == "") {
	
	inlineMsg('EDP_TO_DT',"PLEASE SELECT TO DATE",2);
    return false;
	  }
  
   if (EDP_CERT_DT == "") {
	
	inlineMsg('EDP_CERT_DT',"PLEASE SELECT CERTIFICATE ISSUE DATE",2);
    return false;
	  }
	
	
	 if (EDP_FR_DT != "") {
	if  (!dtRegex.test(EDP_FR_DT)){
	inlineMsg('EDP_FR_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
	
	 if (EDP_TO_DT != "") {
	if  (!dtRegex.test(EDP_TO_DT)){
	inlineMsg('EDP_TO_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
  
  
   if (EDP_CERT_DT != "") {
	if  (!dtRegex.test(EDP_CERT_DT)){
	inlineMsg('EDP_CERT_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
	
	
	
	
	

	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>
<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >
  


<%
String APP_ID=request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
 String ED_ID= request.getParameter("ED_ID")==null?"0":(String) request.getParameter("ED_ID");
 String vOFF_CD =(String) session.getAttribute("off_cd"); 
	//String vREDPATH=(String)session.getAttribute("sREDPATH");
		//String vDOCNAME=(String)session.getAttribute("sDOC_NAME");
		//String EXT="";
//out.print(vREDPATH);
//out.print(vDOCNAME);
String EDP_TRG_NAME="";
%>

	

	  <p>
	    <%
		
		//String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
        String APP_NAME="";
       
		String EDP_CERT_DT="";
		String EDP_TO_DT="";
		String EDP_FR_DT="";
		String REMARKS="";
		String MOB_NO1="";
		String OPT="";
		//out.print(ED_ID);
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String REDPATH = "";
		String CITY="";
		
		
        DBCon db= new DBCon();
        db.connect();

          
		  
		   
           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT  A.APP_ID,TO_CHAR(SYSDATE,'RRRR')||'/'||TO_CHAR(SYSDATE,'MON')||'/'|| TO_CHAR(SYSDATE,'DD') ||'/'||substr(A.APP_ID,instr(A.APP_ID,'-')+1,length(A.APP_ID))||'/'   as redpath, ");
		  qry.append(" UPPER(B.APP_NAME) AS APP_NAME, A.EDP_TRG_NAME,MOM.CITY, ");
		  qry.append("     CASE"      );
qry.append("       WHEN A.EDP_TYPE = 1"      );
qry.append("       THEN 'Paid online EDP'"      );
qry.append("       WHEN A.EDP_TYPE = 2"      );
qry.append("       THEN 'free Online EDP'"      );
qry.append("       WHEN A.EDP_TYPE = 3"      );
qry.append("       THEN 'Paid offline EDP' WHEN A.EDP_TYPE = 4 THEN 'free offline EDP' "      );
qry.append("       ELSE 'EDP Not Opted' "      );
qry.append("     END AS OPT, ");
		   qry.append("  TO_CHAR(A.EDP_FR_DT, 'DD-MON-RRRR') AS EDP_FR_DT,TO_CHAR(A.EDP_TO_DT, 'DD-MON-RRRR') AS EDP_TO_DT,  ");
		    qry.append("   TO_CHAR(A.EDP_CERT_DT, 'DD-MON-RRRR') AS EDP_CERT_DT, ");
			 qry.append(" A.DOC_REMARKS ,A.DOC_NAME ");
			  qry.append(" FROM EDP_CONDUCT_TRANS A ,APP_DETAIL B,MAS_OFF_MAST MOM ");
			  qry.append(" WHERE A.APP_ID=B.APP_ID AND A.EDPOFF_cD=MOM.OFF_CD AND A.ED_ID="+ED_ID+" AND A.APP_ID='"+APP_ID+"'  ");
		// out.print(qry.toString());

        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        EDP_FR_DT=rsApp.getString("EDP_FR_DT")==null?"":rsApp.getString("EDP_FR_DT");
	     EDP_TO_DT=rsApp.getString("EDP_TO_DT")==null?"":rsApp.getString("EDP_TO_DT");
		 EDP_CERT_DT=rsApp.getString("EDP_CERT_DT")==null?"":rsApp.getString("EDP_CERT_DT");
		 REMARKS=rsApp.getString("DOC_REMARKS")==null?"":rsApp.getString("DOC_REMARKS");
		 DOC_NAME=rsApp.getString("DOC_NAME")==null?"":rsApp.getString("DOC_NAME");
		 REDPATH=rsApp.getString("REDPATH")==null?"":rsApp.getString("REDPATH");
		 EDP_TRG_NAME=rsApp.getString("EDP_TRG_NAME")==null?"":rsApp.getString("EDP_TRG_NAME");
		 OPT=rsApp.getString("OPT")==null?"":rsApp.getString("OPT");
		//out.print(REDPATH);
		CITY=rsApp.getString("CITY")==null?"":rsApp.getString("CITY");
        }
			rsApp.close();
			
		
        %>
  </p>
  
  <%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage(REDPATH);
//out.print(a);
%>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*.jpeg,*.png" />
 </jsp:useBean>



	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT EDP CERTIFICATE UPLOAD FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col"><input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
		   <input name="APP_NM" type="hidden" value="<%=APP_NAME%>" id="APP_NM"/>   
   <input name="MOBNO" type="hidden" value="<%=MOB_NO1%>" id="MOBNO"/> 
            <span class="redLebel">(Note  Scanned Copy can be uploaded and file size should not be more than 1mb)</span> </td>
        </tr>
        
        <tr>
          <td colspan="2" scope="col"><div align="center">( file format should be in pdf,jpg,png) </div></td>
        </tr>
        <tr>
          <th scope="col"> Applicant ID 
          <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value=""><input name="ED_ID" type="hidden" id="ED_ID" value="<%=ED_ID%>">
		  <input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>"></th>
          <th scope="col"><%= APP_ID %> </th>
        </tr>
        <tr>
          <th>Name </th>
          <th><div align="left">
              <div align="left"><%= APP_NAME %> </div></th>
        </tr>
        <tr>
          <th>Training Center Name </th>
          <th><%= EDP_TRG_NAME %></th>
        </tr>
        <tr>
          <th>City</th>
          <th><%= CITY %></th>
        </tr>
        <tr>
          <th>Training Type </th>
          <th><%=OPT%></th>
        </tr>
        <tr>
          <th>Upload  Type: </th>
          <th> EDP Cerificate Upload   </th>
        </tr>
		<tr>        </tr>
        <tr>
          <th>Select File: </th>
		  
          <th>
		  
		  <input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
		<tr>
          <th>EDP From Date</th>
          <td><input name="EDP_FR_DT" type="text" id="EDP_FR_DT" value="<%=EDP_FR_DT%>"  placeholder="DD-MON-YYYY" size="50" maxlength="50"></td>
        </tr>
		<tr>
          <th>EDP To date</th>
          <td><input name="EDP_TO_DT" type="text" id="EDP_TO_DT" value="<%=EDP_TO_DT%>" placeholder="DD-MON-YYYY" size="50" maxlength="50"></td>
        </tr>
		<tr>
          <th>EDP Certificate Issue Date </th>
          <td><input name="EDP_CERT_DT" type="text" id="EDP_CERT_DT" value="<%=EDP_CERT_DT%>"  placeholder="DD-MON-YYYY" size="50" maxlength="50"></td>
        </tr>
        <tr>
          <th>Document (Description if any) </th>
          <td><input name="REMARKS" type="text" id="REMARKS"  value="<%=REMARKS%>" size="50" maxlength="50"></td>
        </tr>
		<tr>
		 <th colspan="2"><div align="center">
		  <input name="btnUpload" type="button" class="button" id="btnUpload" value="UPLOAD" onClick="submit_form();">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Close Form" onClick="closeAndRefresh();">
            
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
					
						ED_ID=(String) mrequest.getParameter("ED_ID")==null?"":(String) mrequest.getParameter("ED_ID").trim();
						String frenNm="app"+ED_ID+"."+ext;
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						EDP_FR_DT=(String) mrequest.getParameter("EDP_FR_DT")==null?"":(String) mrequest.getParameter("EDP_FR_DT").trim();
						APP_ID=(String) mrequest.getParameter("APP_ID")==null?"":(String) mrequest.getParameter("APP_ID").trim();
						EDP_TO_DT=(String) mrequest.getParameter("EDP_TO_DT")==null?"":(String) mrequest.getParameter("EDP_TO_DT").trim();
						EDP_CERT_DT=(String) mrequest.getParameter("EDP_CERT_DT")==null?"":(String) mrequest.getParameter("EDP_CERT_DT").trim();
						REMARKS=(String) mrequest.getParameter("REMARKS")==null?"":(String) mrequest.getParameter("REMARKS").trim();
						ED_ID=(String) mrequest.getParameter("ED_ID")==null?"":(String) mrequest.getParameter("ED_ID").trim();
						DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
						out.print(EDP_FR_DT);
						out.print(APP_ID);						
						out.print(EDP_TO_DT);
						out.print(EDP_CERT_DT);						
						out.print(REMARKS);
						out.print(frenNm);
						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
qryUpdate.append(" UPDATE EDP_CONDUCT_TRANS SET EDP_FR_DT=?,EDP_TO_DT=?,EDP_CERT_DT=? ,DOC_NAME=?,DOC_REMARKS=?,EDPUPLOADTIMESTAMP=SYSDATE,UPLOADUSERID=? WHERE ED_ID=? AND APP_ID=?  ");
						
						
						values.add (EDP_FR_DT);pstm.add ("S");
						values.add (EDP_TO_DT);pstm.add ("S");
						values.add (EDP_CERT_DT);pstm.add ("S");
						values.add (frenNm);pstm.add ("S");
		                values.add (REMARKS);pstm.add ("S");
						values.add (vOFF_CD);pstm.add ("S");
						values.add (ED_ID);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
					    values.clear();	
						
						
Connection conn=null;	
		try {
 
  Class.forName("oracle.jdbc.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "PMEGPNEW", "PMEGP_1239");
 try {
 out.print("IN");
CallableStatement cs = conn.prepareCall("{call PROC_UPDATEEDP(?,?)}");
cs.setString(1,APP_ID);
cs.setString(2,ED_ID);
cs.executeQuery();
	}catch (Exception e){
out.print(e.toString());
}
}
catch (Exception e) {
out.print(e.toString());
}
conn.close();	
db.close();							
							
							
							
							
							
							
							//response.sendRedirect("../jsp/savemsgAgency.jsp");
						//session.setAttribute("APP_ID",APP_ID);
						/*
						if(MOBNO.length() == 10){
String sms_string="Dear "+APP_NM+" ("+APP_ID+") Your EDP Certificate(Upload ID:"+maxID+") has been uploaded for PMEGP. Please contact Financing Bank Manager with original EDP certificate for verification as per PMEGP Norms." ;
	 SendSMS.sendSingleSMS("KVICDIT", "Panda@1974", "KVICIT", MOBNO, sms_string);
}
	*/						
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
