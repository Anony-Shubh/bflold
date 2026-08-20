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

window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>
<form method="post" name="form" id="form"  >

	  <p>
	    <%
		
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		String surl="";
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		
		String UP_ID =""; 
		String UPM_CD = request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD").trim();
		out.print(UPM_CD);
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String DOC_TYPE = "";
		String DOC_DESC = "";
		String DOC_REMARK="";
		String ADD_REMARK="";

		if (APP_ID !=null && UPM_CD !="") {
		
        DBCon db= new DBCon();
        db.connect();

       
           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");		   
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL_online A,PMEGP_SCORE_CARD P ");
			  qry.append("WHERE A.APP_ID=P.APP_ID AND A.APP_ID = '"+APP_ID+"' ");
		 
//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
       // SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		
		
        }
		
			rsApp.close();
			
			
			
			
				
		
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">Document Delete Form  </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        
        
        <tr>
          <th scope="col"> Applicant ID 
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><%= APP_ID %> <input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>">
		  <input name="UPM_CD" type="hidden" id="UPM_CD" value="<%=UPM_CD%>">
		  </th>
        </tr>
        <tr>
          <th>Name </th>
          <th><div align="left">
              <div align="left"><%= APP_NAME %> </div></th>
        </tr>
        <tr>
          <th>Upload Type: </th>
          <th><% if (UPM_CD.equals("1")){
		  out.print("No. of dependencies Document"); }
		  else if (UPM_CD.equals("2")) {
		  out.print("Owning a house/parental house Document");}
		   else if (UPM_CD.equals("3")) {
		  out.print("address / location Document");}
		   else if (UPM_CD.equals("4")) {
		  out.print("Experience Document");}
		   else if (UPM_CD.equals("5")) {
		  out.print("Source of income Document");}
		   else if (UPM_CD.equals("6")) {
		  out.print("Income tax Document");}
		  		  
		   else if (UPM_CD.equals("7")) {
		  out.print("Life Insurance policy Document");}
		   else if (UPM_CD.equals("8")) {
		  out.print("Lending bank Document");}
		   else if (UPM_CD.equals("9")) {
		  out.print("Skill Certification Document");}
		  else if (UPM_CD.equals("10")) {
		  out.print("Registered with Govt. Authorities Document");}
		  else if (UPM_CD.equals("12")){
		  out.print("Additional Document");}
		   else if (UPM_CD.equals("13")){
		  out.print("Credit History Document");}
		   else if (UPM_CD.equals("14")){
		  out.print("Location Advantage Document");}		 
		  else if (UPM_CD.equals("15")){
		  out.print("Marketing Tie ups for sale of products Document");}
		   else if (UPM_CD.equals("16")){
		  out.print("Repayment Period Document");}
		   else if (UPM_CD.equals("17")){
		  out.print("Avg DSCR Document");}
		   else if (UPM_CD.equals("18")){
		  out.print("Collateral Security Coverage Document");}
		  %>
		 </th>
        </tr>
        <tr>
          <td colspan="2"><div align="center"><img src="../pmegpappupload/<%= DOC_NAME %>" width="20%">
            <div align="center">		  
          </div></td>
        </tr>
       
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="javascript:window.close();">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="Delete" onClick="submit_form();">
          </div></th>
        </tr>
      </table>
	 <%

	   try{
   if ((String)request.getParameter("ins")!=null){
   APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
	UPM_CD=(String) request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD").trim();
	out.print(APP_ID);
	out.print(UPM_CD);
   List values=new ArrayList();
		List pstm=new ArrayList();
		
		
		
		
		
		
		
		
		StringBuffer qryUpdate = new StringBuffer();
		
		if (UPM_CD.equals("1")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET DEPEN_DOC=NULL,DEPEN_REMARK=NULL WHERE APP_ID=?");	}	
							  
		    else if (UPM_CD.equals("2")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET HOUSE_DOC=NULL,HOUSE_REMARK=NULL WHERE APP_ID=?");	}
		  
		   else if (UPM_CD.equals("3")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET ADDR_DOC=NULL,ADDR_REMARK=NULL WHERE APP_ID=?");	}
		 
		   else if (UPM_CD.equals("4")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET EXP_DOC=NULL, EXP_REMARK=NULL WHERE APP_ID=?");	}
		  
		   else if (UPM_CD.equals("5")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET OTHSOUR_DOC=NULL,OTHSOUR_REMARK=NULL WHERE APP_ID=?");	}
		  
		   else if (UPM_CD.equals("6")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET INCOME_DOC=NULL,INCOME_REMARK=NULL WHERE APP_ID=?");	}
		   else if (UPM_CD.equals("7")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET INSU_DOC=NULL,INSU_REMARK=NULL WHERE APP_ID=?");	}		 
		  		  
		   else if (UPM_CD.equals("8")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET BANK_DOC=NULL,BANK_REMARK=NULL WHERE APP_ID=?");	}
		 
		   else if (UPM_CD.equals("9")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET SKILL_DOC=NULL,SKILL_REMARK=NULL WHERE APP_ID=?");	}
		 
		   else if (UPM_CD.equals("10")) { qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET REGEGOV_DOC=NULL,REGEGOV_REMARK=NULL WHERE APP_ID=?");	}
		   
		    else if (UPM_CD.equals("12")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET ADDL_DOC=NULL,ADDL_REMARK=NULL WHERE APP_ID=?"); }
		   
		    else if (UPM_CD.equals("13")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET CR_DOC=NULL,CR_REMARK=NULL WHERE APP_ID=?"); }
			
			 else if (UPM_CD.equals("14")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET LOC_DOC=NULL, LOC_REMARK=NULL WHERE APP_ID=?"); }
			  else if (UPM_CD.equals("15")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET MARK_DOC=NULL, MARK_REMARK=NULL WHERE APP_ID=?"); }
			   else if (UPM_CD.equals("16")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET REPY_DOC=NULL, REPY_REMARK=NULL WHERE APP_ID=?"); }
			    else if (UPM_CD.equals("17")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET DSCR_DOC=NULL,DSCR_REMARK=NULL WHERE APP_ID=?"); }
				 else if (UPM_CD.equals("18")){ qryUpdate.append(" UPDATE PMEGP_SCORE_CARD SET COLSEC_DOC=NULL,COLSEC_REMARK=NULL WHERE APP_ID=?"); }
		
		 
		
		
		
		
		
		values.clear();
        pstm.clear();
values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
 pstm.clear();


surl="savemsgDel.jsp";

   
 }//ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}

db.close();
if (surl !="") {
response.sendRedirect(surl);
}
	 }//end if;
	   %>
</form>
</body>
</html>