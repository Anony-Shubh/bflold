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
<%@ page import="java.math.BigDecimal"%>

  
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
    <title>upload </title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
	<script language="javascript" src="../js/inlineMsgMain.js"></script>
	
<script language="javascript">

function getFilePathExtension(path) {
	var filename = path.split('\\').pop().split('/').pop();
	var lastIndex = filename.lastIndexOf(".");
	if (lastIndex < 1) return "";
	return filename.substr(lastIndex + 1);
}

		function submit_form() {
		
			
	document.form.ins.value='I';
	document.form.submit();
}
</script>
</head>

<body>
<%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/uploadclaim_temp1/");
//out.print(a);
%>
<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="true" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*.jpeg" />
 </jsp:useBean>
	    <%
		//String APP_ID = "DIUT16177108-1279576";
		//String APP_ID = (String)session.getAttribute("SAPP_ID");
		String APP_ID= request.getParameter("APP_ID")==null?"": request.getParameter("APP_ID");

        String IFSC_CODE=(String)session.getAttribute("bank_id");
		//out.print(IFSC_CODE);
		String APP_NAME="";
		String AADHAR_NO = "";
		String APPLOAN_ACCNO = "";
		String IST_LOAN_DT = "";
		String IST_LOAN_AMT = "";
		String FB_ACNO = "";
		String MM_CLAIM_AMT = "";
		String LOAN_DOCFNAME="";
		String APP_ID1="";

		int randomPIN = (int)(Math.random()*9000)+1000;
String val = ""+randomPIN;
//out.print("hello"+val);
        DBCon db= new DBCon();
        db.connect();
        StringBuffer qrysb = new StringBuffer();
			qrysb.append("   SELECT AD.APP_ID,"      );
			qrysb.append("     AD.APP_NAME,"      );
			qrysb.append("     AD.AADHAR_NO,"      );
			qrysb.append("     BD.APPLOAN_ACCNO,"      );
			qrysb.append("     TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,"      );
			qrysb.append("     BD.IST_LOAN_AMT,"      );
			qrysb.append("     AD.IFSC_CODE,"      );
			qrysb.append("     BD.FB_ACNO,LOAN_DOCFNAME,"      );
			qrysb.append("     BD.MM_CLAIM_AMT  "      );
			qrysb.append("   FROM APP_DETAIL AD,"      );
			qrysb.append("     BANK_DATAENTRY BD"      );
			qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
			qrysb.append("   AND AD.APP_ID       = '"+APP_ID+"'  "      );
			//qrysb.append("   AND BD.IST_LOAN_DT IS NOT NULL"      );
			qrysb.append("   AND AD.IFSC_CODE    = '"+IFSC_CODE+"'  "      );
			//qrysb.append("   AND BD.MM_CLAIM_AMT > 0"      );
			qrysb.append("   AND BD.ACT_ID       = 11"      );
			
			//out.print(qrysb.toString());
			List valuesq = new ArrayList();
			//valuesq.add(APP_ID);
			//valuesq.add(IFSC_CODE);

		  ResultSet rsMain = db.executeSQL(qrysb.toString(),valuesq);
        while (rsMain.next()){
		//APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
		APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
		
				AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
		APPLOAN_ACCNO=rsMain.getString("APPLOAN_ACCNO")==null?"":rsMain.getString("APPLOAN_ACCNO");
		IST_LOAN_DT=rsMain.getString("IST_LOAN_DT")==null?"":rsMain.getString("IST_LOAN_DT");
		IST_LOAN_AMT=rsMain.getString("IST_LOAN_AMT")==null?"":rsMain.getString("IST_LOAN_AMT");
		//IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
		FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
		MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
		LOAN_DOCFNAME=rsMain.getString("LOAN_DOCFNAME")==null?"":rsMain.getString("LOAN_DOCFNAME");

        }
		rsMain.close();
					
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="4" scope="col"><div align="center">ONLINE MARGIN MONEY (GOVT. SUBSIDY) FINAL SUBMISSION </div></th>
        </tr>
        <tr>
          <td colspan="4" scope="col"><div align="right"></div></td>
        </tr>
        <tr>
          <th scope="col">Applicant ID: </th>
		    <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value="">
          <th scope="col"><%= APP_ID %></th>
          <th scope="col">Applicant Name </th>
          <th scope="col"><%= APP_NAME %></th>
        </tr>
        <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>">
        <tr>
          <th scope="col">Aadhaar No: </th>
          <th scope="col"><%= AADHAR_NO %></th>
          <th scope="col">Loan Account No: </th>
          <td class="redLebel" scope="col"><H1><%= APPLOAN_ACCNO %></H1></td>
        </tr>
        <tr>
          <th scope="col">Loan Release Date: </th>
          <th scope="col"><%= IST_LOAN_DT %></th>
          <th scope="col">Total Loan Release Amount </th>
          <th scope="col"><%= IST_LOAN_AMT %></th>
        </tr>
        <tr>
          <th scope="col">NEFT IFS Code: 
          <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"></th>
          <td class="GreenLebel" scope="col"><%= IFSC_CODE %></td>
          <th scope="col">Bank Transient A/c No: </th>
          <td class="GreenLebel" scope="col"><H1><%= FB_ACNO %></H1></td>
        </tr>
        <tr>
          <th colspan="2" scope="col">Margin Money (Govt. Subsidy) Claim Amount:          </th>
          <td class="GreenLebel" scope="col"><H1><%= MM_CLAIM_AMT %></H1></td>
          <td class="GreenLebel" scope="col">&nbsp;</td>
        </tr>
        <tr>
          <th colspan="2"><div align="right">Upload Revised Loan Release Statement*: </div></th>
          <th colspan="2"><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
        <tr>
          <td colspan="4"><div align="center" class="GreenLebel"></div></td>
        </tr>
        <tr>
          <th colspan="4"><div align="center">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="Upload Revised Loan Document" onClick="submit_form();">
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
						String frenNm="lsr"+val+APP_ID+"."+ext;
						
						File f = new File(a+file.getFileName()+"");
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						//DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
                        APP_ID1 =(String) mrequest.getParameter("APP_ID")==null?"":(String) mrequest.getParameter("APP_ID").trim();
						//out.print(APP_ID1);
						//out.print(frenNm);
						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" UPDATE BANK_DATAENTRY  SET    ");
						qryUpdate.append(" LOAN_DOCFNAME=?  ");
						qryUpdate.append(" WHERE APP_ID=? AND IFSC_CODE=? AND PACT_ID=30 AND APPRV_YN='A'  ");
						
						
						values.add (frenNm);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						values.add (IFSC_CODE);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate();
						db.close();
						pstm.clear();
						values.clear();					
						
					response.sendRedirect("../jsp/savemsgAgency.jsp");
						
						
						}

						}
						}
						}
						
			
						
} 
catch (Exception e) {
out.print (e.toString());
}finally{

//db.close();

}
	
	   %>
</form>
</body>
</html>
