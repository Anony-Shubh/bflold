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
		//String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
		out.print(IFS_CODE);
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
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' ");
		 

        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		
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
	 values.add (IFS_CODE);
	 values.add (REMTRID);
	 values.add (maxID);
	values.add (frenNm);				
						
	ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;
response.sendRedirect("savepage.jsp");
/*
while (rsValidate.next()){
errcount =errcount+1;
verror=verror+""+rsValidate.getString(2)+"<br>";
}
rsValidate.close();
*/
					/*StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" INSERT INTO APP_UPLOAD_TRANS ( UP_ID,");
						qryUpdate.append("APP_ID,");
						qryUpdate.append("UPM_CD,");
						qryUpdate.append("DOC_NAME,");
						qryUpdate.append("DOC_REMARKS ) VALUES (?,?,?,?,?) ");
						
						values.add (maxID);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						values.add (UPM_CD);pstm.add ("S");
						values.add (frenNm);pstm.add ("S");
		                values.add (DOC_REMARKS);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
							values.clear();	
							
								StringBuffer sv= new StringBuffer();
sv.append("INSERT INTO BANK_DATAENTRY_REFER(    ");
sv.append("SELECT * FROM BANK_DATAENTRY WHERE APP_ID='"+APP_ID+"' AND REMTRID='"+REMTRID+"'  AND APPRV_YN='A'  ");
sv.append("AND PACT_ID=30 AND APP_ID NOT IN ( ");
sv.append("SELECT APP_ID FROM BANK_DATAENTRY_REFER WHERE APP_ID='"+APP_ID+"' AND REMTRID ='"+REMTRID+"' AND APPRV_YN='A'  ");
sv.append("AND PACT_ID=30))  ");
// out.print(sv.toString());

ResultSet rsReff = db.executeSQL(sv.toString(),values);
						try{	
							StringBuffer sb = new StringBuffer();
 sb.append("  UPDATE BANK_DATAENTRY SET ACT_ID=3,BANK_REMARKS=?,BANK_REC_DT=SYSDATE, REJ_ID=44, "); 
 sb.append("  LOAN_SANC_DT=NULL,WORKSHED_COST=NULL,WORKING_CAPITAL=NULL,MACHINARY_COST=NULL,PRE_OPE_COST=NULL,OWN_CONTRIBUTION=NULL, "); 
  sb.append(" OWN_CONT_DT=NULL,IST_LOAN_AMT=NULL,IST_LOAN_DT=NULL,CGTSI=NULL,MM_CLAIM_LRNO=NULL,MM_CLAIM_DT=NULL, "); 
 sb.append(" MM_CLAIM_AMT=NULL,MM_REL_AMT=NULL,MM_REL_DT=NULL,OFF_CD=NULL,APP_NAME=NULL,EMP=NULL,PROD=NULL,SALES=NULL,TDR_ADJ_DT=NULL, "); 
 sb.append(" TDR_ADJ_AMT=NULL,BANK_COMMENT=NULL,TIME_STAMP=NULL,DATA_SAVING_REPORT=NULL,EDP_TRG_NAME=NULL,EDP_FR_DT=NULL, "); 
 sb.append(" EDP_TO_DT=NULL,EDP_CERT_DT=NULL,CE_SANC_FB=NULL,WC_SANC_FB=NULL,APPLOAN_ACCNO=NULL,FB_ACNO_OLD=NULL,FB_ACNAME=NULL,RINT=NULL, "); 
 sb.append(" LOAN_PERIOD=NULL,LOAN_REMARKS=NULL,TDR_ACNO=NULL,MM_ADJ_DT=NULL,MM_ADJ_AMT=NULL,PV_DT=NULL,PV_VAR_OFF=NULL,PHY_PROD=NULL,PHY_SALES=NULL, "); 
 sb.append("PHY_EMP=NULL,PHY_INV=NULL,PV_STATUS=NULL,PH_YN=NULL,EDP_YN=NULL,MM_ADJ_BY=NULL,PV_VER_OFF=NULL,MOR_PER=NULL,LOAN_DOCFNAME=NULL, "); 
 sb.append(" REMTRID=NULL,PBATCH_ID=NULL,BATCH_DATE=NULL,APPRV_YN=NULL,PACT_ID=NULL,UTRN_NO=NULL,PAY_STATUS=NULL,FB_ACNO=NULL, "); 
 sb.append(" FAIL_REASON=NULL,CORP_REL_DT=NULL,COMP_YN=NULL  "); 
  sb.append(" WHERE APP_ID=? AND IFSC_CODE=? AND PACT_ID=30 AND APPRV_YN='A' "); 
  
  values.add(DOC_REMARKS);pstm.add("D");  
  values.add(APP_ID);pstm.add("D");
  values.add(IFS_CODE);pstm.add("D");
  
  out.print(sb.toString());
  

			db.setSqlValue(sb.toString());
			db.setValues(values,pstm);
			db.executeUpdate() ;		
	}catch(Exception e) { 	
	out.print(e.toString()); 
	}
	pstm.clear();
    values.clear();	
						StringBuffer sbY = new StringBuffer();
		 sbY.append(" UPDATE APP_DETAIL SET ACT_YN='N' WHERE APP_ID=? ");  
 
  values.add(APP_ID);pstm.add("D");
  
try{
			db.setSqlValue(sbY.toString());
			db.setValues(values,pstm);
			db.executeUpdate() ;		
	}catch(Exception e) { 	
	out.print(e.toString()); 
	}
	pstm.clear();
    values.clear();	
	
							
							
							
							
							
							
							
			*/				
							
							
							
							
							
						
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