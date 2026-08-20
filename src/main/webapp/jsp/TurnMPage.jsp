<%@ include file="appIncludeHeaderPage.jsp" %>
<html>
<head>
   <title>PMEGP Tracking</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>
<%
String  Msg=session.getAttribute("Msg")==null?"":(String) session.getAttribute("Msg");
DBCon db= new DBCon();

db.connect(); 


String MM_REL_DT="";
String qryM="";




       
 qryM="SELECT MM_REL_DT FROM BANK_DATAENTRY WHERE APP_ID='"+vAppid+"' ";
       ResultSet rsM = db.execSQL(qryM);
	   while(rsM.next()){ 
	   MM_REL_DT=rsM.getString("MM_REL_DT")==null?"":rsM.getString("MM_REL_DT");
	   }
	  	 
	 if  (!MM_REL_DT.equals("")){
	
	 rsM.close();
		 db.close();
	  response.sendRedirect ("appAnnTurnover.jsp");	  
	  }	  
	  else {	  
	  Msg="MM NOT YET RELEASED";
	  session.setAttribute("Msg",Msg);
	  	  }
	 
     rsM.close();
		 db.close();
	 

	 %> 



<body>  

<h1><div align="center" class="redLebel"><%=Msg%></div></h1>

</body>
</html>
	   
	 
	   
	   
	   
	   