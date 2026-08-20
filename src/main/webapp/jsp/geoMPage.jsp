<%@ include file="appIncludeHeaderPage.jsp" %>

<%


DBCon db= new DBCon();
 //int srn =0;
db.connect(); 


String MM_REL_DT="";
String MM_ADJ_YN="";
String MM_LOAN_DT="";
String AGENCY_UPLOAD="";



       
 ResultSet rsMANU= db.execSQL("SELECT AGENCY_UPLOAD,BD.MM_REL_DT,to_char(trunc(BD.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(BD.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN  FROM GEOTAG_TRANS GT,BANK_DATAENTRY BD  WHERE BD.APP_ID=GT.APP_ID AND BD.PACT_ID=34 AND BD.MM_REL_DT IS NOT NULL AND BD.APP_ID='"+vAppid+"' ");
		   while (rsMANU.next()) {  //3
           AGENCY_UPLOAD=rsMANU.getString("AGENCY_UPLOAD")==null?"":rsMANU.getString("AGENCY_UPLOAD");
		   MM_LOAN_DT=rsMANU.getString("MM_LOAN_DT")==null?"":rsMANU.getString("MM_LOAN_DT");
		   MM_ADJ_YN=rsMANU.getString("MM_ADJ_YN")==null?"":rsMANU.getString("MM_ADJ_YN");
		   MM_REL_DT=rsMANU.getString("MM_REL_DT")==null?"":rsMANU.getString("MM_REL_DT");
           } //3  
		   rsMANU.close();
		   session.setAttribute("MM_LOAN_DT",MM_LOAN_DT);
	   
	  	
	 if  (!MM_REL_DT.equals("")){
	
	 
	 if (MM_ADJ_YN.equals("Y") && (!AGENCY_UPLOAD.equals(""))){
	  db.close();	 
	  response.sendRedirect ("../geoportal/docView.jsp?docname="+AGENCY_UPLOAD);	  
	  }	  
	  else {	  
	  response.sendRedirect ("AdjMsg.jsp");
	  
	  }
	  
	  }
	    


	 %> 




	   
	   
	   
	   