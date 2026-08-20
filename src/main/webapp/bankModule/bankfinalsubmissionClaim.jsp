<%@ page buffer="500kb" %>
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

   <%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<%@ include file="headerfile.jsp" %>

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
		var uploadfile=document.form.uploadfile.value;
		if (uploadfile=="") {
			 inlineMsg('uploadfile',"Upload Loan Disbursement Statement",2);
            return (false);
			}
			
			var ext1=getFilePathExtension(uploadfile);
			var ext=ext1.toLowerCase();
			
			if (!(ext=='jpg'||ext=='jpeg'||ext=='pdf')) {
			inlineMsg('uploadfile',"Loan Document should be in PDF,JPG format within 1 mb size",2);
			 return (false);
			}
			
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
<form method="post" name="form" id="form" class="form" enctype="multipart/form-data" >
	<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="10000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="true" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*.jpeg" />
 </jsp:useBean>
	    <%
		  String CLIENT_IP= (String)session.getAttribute("SCLIENTIP");
		String APP_ID = (String)session.getAttribute("SAPP_ID");
        String IFSC_CODE=(String)session.getAttribute("bank_id");
		
		
		String APP_NAME="";
		String AADHAR_NO = "";
		String APPLOAN_ACCNO = "";
		String IST_LOAN_DT = "";
		String IST_LOAN_AMT = "";
		String FB_ACNO = "";
		String MM_CLAIM_AMT = "";
		String LOAN_DOCFNAME="";
		String NEFT_IFSC="";
		String mm_claim_valid="";
		

        DBCon db= new DBCon();
        db.connect();
		
		List valuesq = new ArrayList();
		
		
        StringBuffer qrysb = new StringBuffer();
			qrysb.append("   SELECT AD.APP_ID,"      );
			qrysb.append("     AD.APP_NAME,"      );
			qrysb.append("     AD.AADHAR_NO,FGETNEFTIFSCODE(AD.APP_ID) AS NEFT_IFSC,"      );
			qrysb.append("     BD.APPLOAN_ACCNO,"      );
			qrysb.append("     TO_CHAR(BD.IST_LOAN_DT,'DD-MON-RRRR') AS IST_LOAN_DT,"      );
			qrysb.append("     BD.IST_LOAN_AMT,"      );
			qrysb.append("     AD.IFSC_CODE,"      );
			qrysb.append("     BD.FB_ACNO,LOAN_DOCFNAME,"      );
			qrysb.append("     BD.MM_CLAIM_AMT,  "      );
			qrysb.append(" CASE  WHEN nvl(bd.mm_claim_amt, 0) = 0  THEN "      );
           qrysb.append(" 'Govt. Subsidy Claim Amount is Zero' "      );
       qrysb.append(" WHEN nvl(bd.mm_claim_amt, 0) <> mminv_bankadmit(bd.app_id) THEN "      );
          qrysb.append("  'Govt. Subsidy Claim Amount Mismatch' "      );
          qrysb.append("  WHEN FGETTRANSACNO(BD.APP_ID) IS NULL THEN "      );
          qrysb.append("   'Non-Customer Account No mismatch or blank' "      );
   qrysb.append("   WHEN FGETNEFTIFSCODE(BD.APP_ID) IS NULL THEN "      );
         qrysb.append("    'NEFT IFSC CODE MISMATCH OR BLANK'  "      );       
       qrysb.append(" ELSE  'S' "      );
    qrysb.append(" END mm_claim_valid"      );		
			
			qrysb.append("   FROM APP_DETAIL AD,"      );
			qrysb.append("     BANK_DATAENTRY BD "      );
			qrysb.append("   WHERE AD.APP_ID     = BD.APP_ID"      );
			qrysb.append("   AND AD.APP_ID       = ? "      );
			qrysb.append("   AND BD.IST_LOAN_DT IS NOT NULL"      );
			qrysb.append("   AND AD.IFSC_CODE    = ?"      );
			qrysb.append("   AND BD.MM_CLAIM_AMT > 0"      );
			qrysb.append("   AND BD.ACT_ID       = 11"      );
			
			
			
			valuesq.add(APP_ID);
			valuesq.add(IFSC_CODE);

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
		NEFT_IFSC=rsMain.getString("NEFT_IFSC")==null?"":rsMain.getString("NEFT_IFSC");
		mm_claim_valid=rsMain.getString("mm_claim_valid")==null?"":rsMain.getString("mm_claim_valid");
        }
		rsMain.close();
		//out.print("he"+mm_claim_valid);		
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="4" scope="col"><div align="center">ONLINE MARGIN MONEY (GOVT. SUBSIDY) FINAL SUBMISSION </div></th>
        </tr>
        <tr>
          <td colspan="4" scope="col"><div align="right"><a href="bankApplicationView.jsp" class="greenButtonRound">go Back: </a></div></td>
        </tr>
        <tr>
          <th scope="col">Applicant ID: </th>
          <th scope="col"><%= APP_ID %></th>
          <th scope="col">Applicant Name </th>
          <th scope="col"><%= APP_NAME %></th>
        </tr>
        
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
          <td class="GreenLebel" scope="col"><%= NEFT_IFSC %></td>
          <th scope="col">Bank Transient A/c No: </th>
          <td class="GreenLebel" scope="col"><H1><%= FB_ACNO %></H1></td>
        </tr>
        <tr>
          <th colspan="2" scope="col">Margin Money (Govt. Subsidy) Claim Amount:          </th>
          <td class="GreenLebel" scope="col"><H1><%= MM_CLAIM_AMT %></H1></td>
          <td class="GreenLebel" scope="col">&nbsp;</td>
        </tr>
		<% 
		
		
		if (LOAN_DOCFNAME.equals("")) { %>
        <tr class="redLebel">
          <td colspan="4" scope="col"><div align="center">NOTE</div></td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col"> (1) Please verify the Margin Money (Govt. Subidy) Details before &quot;FINAL SUBMISSION&quot; </td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col">(2) Verify Transient Account No(Non-customer) of Your Bank and NEFT IFS Code. </td>
        </tr>
        <tr class="redLebel">
          <td colspan="4" scope="col">(3) After Final Submission Data cannot be Updated 
          <input name="ins" type="hidden" id="ins" value="">
          <input type="hidden" name="todo" value="upload"/></td>
        </tr>
        <tr>
          <td colspan="4" class="redLebel" scope="col">(4) Upload Scanned copy of Loan Release Statement with Branch Seal and Signature of Authorised Officer.</td>
        </tr>
        <tr>
          <td colspan="4"><div align="center"><span class="GreenLebel">(  Scanned copy should be in pdf,jpg format and size of the document is less than 1 mb) </span></div></td>
        </tr>
        <tr>
          <th colspan="2"><div align="right">Upload Loan Release Statement*: </div></th>
          <th colspan="2"><input name="uploadfile" type="file" class="button" id="uploadfile"></th>
        </tr>
        <tr>
          <td colspan="4"><div align="center" class="GreenLebel"></div></td>
        </tr>
        <tr>
          <th colspan="4"><div align="center">
		  <% if (mm_claim_valid.equals("S")){%>		  
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="FINAL SUBMISSION OF GOVT. SUBSIDY CLAIM" onClick="submit_form();">
			<%} else { %>
			
			<span class="redLebel"><%out.print(mm_claim_valid); %></span> <%   } %>
			
			
          </div></th>
        </tr>
		<% } %>
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
						String frenNm="ls"+APP_ID+"."+ext;
						
						File f = new File(a+file.getFileName()+"");
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						//DOC_NAME=(String) mrequest.getParameter("DOC_NAME")==null?"":(String) mrequest.getParameter("DOC_NAME").trim();
                      
						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
				

 	
						qryUpdate.append(" UPDATE BANK_DATAENTRY BD  SET MM_CLAIM_DT=SYSDATE,CLIENT_IP=?,");
						qryUpdate.append("LOAN_DOCFNAME=?  ");
qryUpdate.append("  WHERE APP_ID=? AND IFSC_CODE=? AND APP_ID IN (SELECT APP_ID FROM APP_DETAIL WHERE APP_ID=? AND ACT_YN='Y')");
qryUpdate.append(" AND MM_CLAIM_AMT>0 AND FB_ACNO IS NOT NULL  ");

/* AND MM_CLAIM_AMT=MMINV_BANKADMIT(APP_ID) ");
qryUpdate.append("  AND FB_ACNO IN (SELECT TRANS_ACNO FROM BANK_BR_MAST WHERE BR_IFSL_CODE=BD.IFSC_CODE)  ");
qryUpdate.append("	AND FGETNEFTIFSCODE(BD.APP_ID) IN (SELECT NEFT_IFSC FROM BANK_BR_MAST WHERE BR_IFSL_CODE=BD.IFSC_CODE)	");					
						
*/						values.add (CLIENT_IP);pstm.add ("S");
						values.add (frenNm);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						values.add (IFSC_CODE);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
						values.clear();	
				/*
				qrysb = new StringBuffer();		
		
		qrysb.append(" MERGE INTO BANK_DATAENTRY BD USING ( SELECT WAITLISTNO,app_id FROM MMCLAIM_WL )TD ");
        qrysb.append(" ON ( TD.APP_ID=BD.APP_ID) ");
        qrysb.append(" WHEN MATCHED THEN UPDATE SET BD.MM_CLAIM_LRNO=TD.WAITLISTNO ");
        qrysb.append(" WHERE BD.MM_CLAIM_LRNO IS NULL ");
        qrysb.append(" AND TRUNC(BD.MM_CLAIM_DT)>'31-JUL-2025' ");
		
		  ResultSet rswl = db.executeSQL(qrysb.toString(),values);
		  
		     while ( rswl.next() ) {}
			 rswl.close();
						*/
						db.close();
						
						response.sendRedirect("bankApplicationView.jsp");
						
						}//end of jpg

						}
						}
						}
						
			
						
} catch (Exception e) {
out.print (e.toString());
}finally{

//db.close();

}
	
	   %>
</form>
</body>
</html>
