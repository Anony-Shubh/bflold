<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>



<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<%

String APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();

String PMEGPGEOTAGID=(String) request.getParameter("PMEGPGEOTAGID")==null?"":(String) request.getParameter("PMEGPGEOTAGID").trim();

String APPNAME=(String) request.getParameter("APPNAME")==null?"":(String) request.getParameter("APPNAME").trim();

DBCon db= new DBCon();

db.connect(); 



String UPLOAD_YN="";
ResultSet rsMANU;

 StringBuffer qrysb= new StringBuffer();


       
qrysb.append("  SELECT  ");
qrysb.append(" case when mm_adjustment_status='RM' AND NVL(agn_callback,0)+NVL(gt.mm_adjustment_amt_s,0) <> NVL(BD.MM_REL_AMT,0) ");
 qrysb.append("  then 'N' ELSE 'Y' END AS UPLOAD_YN  FROM GEOTAG_TRANS gt,bank_dataentry bd where gt.app_id=bd.app_id and bd.pact_id=34 and ");
qrysb.append(" bd.mm_rel_dt is not null and gt.act_id=1  AND agency_upload IS NULL ");
qrysb.append("  and bd.app_id=? and gt.pmegpgeotagid=? ");
qrysb.append("  UNION ");
qrysb.append(" SELECT ");
qrysb.append(" case when mm_adjustment_status='RM' AND NVL(agn_callback,0)+NVL(gt.mm_adjustment_amt_s,0) <> NVL(BD.MM_REL_AMT,0) ");
 qrysb.append("  then 'N' ELSE 'Y' END AS UPLOAD_YN  FROM GEOTAG_TRANS gt,bank_dataentry_SECOND bd where gt.app_id=bd.app_id ");
qrysb.append("  and bd.pact_id=34 and bd.mm_rel_dt is not null and gt.act_id=1  AND agency_upload IS NULL ");
qrysb.append("  and bd.app_id=? and gt.pmegpgeotagid=?  ");
	
	
	List values=new ArrayList();

values.add(APP_ID);
 values.add(PMEGPGEOTAGID); 	  
values.add(APP_ID);
 values.add(PMEGPGEOTAGID); 
 
 
 rsMANU = db.executeSQL(qrysb.toString(),values);
 
 		  
		   while (rsMANU.next()) {  //3
           UPLOAD_YN=rsMANU.getString("UPLOAD_YN")==null?"":rsMANU.getString("UPLOAD_YN");
		   
           } //3  
		   rsMANU.close();
		   //session.setAttribute("MM_LOAN_DT",MM_LOAN_DT);
	   
	  	
	 if  (UPLOAD_YN.equals("Y")){
	
	 
		  
	  response.sendRedirect ("../geoportal/UploadMMAdj.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID+"&APPNAME="+APPNAME);
	  
	  }
	  else{
	  out.print("<br/><div align=center class=redLebel><h2>There is difference in MM Adjustment Amount and Callback Amount .Plz Verify and mail us at pmegpeportal.kvic@gov.in   </h2></div>");
	  
	  }
	    


	 %> 




	   
	   
	   
	   