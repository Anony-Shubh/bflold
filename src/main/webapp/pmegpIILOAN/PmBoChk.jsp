<%@ include file="appIncludeHeaderPage.jsp" %>

<%


DBCon db= new DBCon();
 //int srn =0;
db.connect(); 


String DY_N="";
String SIGNC="";



       
 ResultSet rsMANU= db.execSQL("SELECT AD.APP_ID,CASE WHEN TRUNC(AD.ONLINE_SUBDT) > '31-MAY-2022' AND trunc(IST_LOAN_DT) IS NOT NULL AND BD.ACT_ID=11 THEN 'Y' ELSE 'N' END AS DY_N,(SELECT COUNT(*) FROM APP_UPLOAD_TRANS_SECOND WHERE APP_ID=AD.APP_ID and upm_cd=16) AS SIGNC FROM APP_DETAIL_SECOND  AD,BANK_DATAENTRY_SECOND BD  WHERE AD.APP_ID=BD.APP_ID(+)  AND AD.APP_ID='"+vAppid+"' ");
		   while (rsMANU.next()) {  //3
           DY_N=rsMANU.getString("DY_N")==null?"":rsMANU.getString("DY_N");
		   SIGNC=rsMANU.getString("SIGNC")==null?"0":rsMANU.getString("SIGNC");
		   
           } //3  
		   rsMANU.close();
		  
	   
	  	
	
	
	 
	 if (DY_N.equals("Y") && (SIGNC.equals("0"))){
	  db.close();	 
	  response.sendRedirect ("PmegpBoardUpload.jsp?APP_ID="+vAppid);	  
	  }	  
	  else {	  
	  response.sendRedirect ("bmsg.jsp");
	  
	  }
	  
	 
	    


	 %> 




	   
	   
	   
	   