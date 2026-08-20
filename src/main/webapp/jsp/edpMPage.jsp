<%@ include file="appIncludeHeaderPage.jsp" %>
<html>
<head>
   <title>PMEGP Tracking</title>
   <link rel="stylesheet" type="text/css" href="../css/pmegpTable.css">
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>
<%


DBCon db= new DBCon();
 //int srn =0;
db.connect(); 

String qrysY ="";
String qryE="";
String EDP_YN_S="";
String EDP_CERT_DTS="";
String MM_REL_DT1="";
String qryM="";

String  Msg=session.getAttribute("Msg")==null?"":(String) session.getAttribute("Msg");

 qrysY="SELECT  EDP_YN FROM APP_DETAIL_ONLINE WHERE APP_ID='"+vAppid+"' ";
       ResultSet rsY = db.execSQL(qrysY);
	   while(rsY.next()){ 
	   EDP_YN_S=rsY.getString("EDP_YN")==null?"":rsY.getString("EDP_YN");
	   }
	   
	    qryE="SELECT EDP_CERT_DT FROM EDP_CONDUCT_TRANS WHERE APP_ID='"+vAppid+"' ";
       ResultSet rsE = db.execSQL(qryE);
	   while(rsE.next()){ 
	   EDP_CERT_DTS=rsE.getString("EDP_CERT_DT")==null?"":rsE.getString("EDP_CERT_DT");
	   }
	    qryM="SELECT MM_REL_DT FROM BANK_DATAENTRY WHERE APP_ID='"+vAppid+"' ";
       ResultSet rsM = db.execSQL(qryM);
	   while(rsM.next()){ 
	   MM_REL_DT1=rsM.getString("MM_REL_DT")==null?"":rsM.getString("MM_REL_DT");
	   }
	   
	  	
	  if ((EDP_YN_S.equals("N")) && (EDP_CERT_DTS.equals("")) && (MM_REL_DT1.equals(""))){
    rsY.close();
rsE.close();
rsM.close();
db.close() ;
	  response.sendRedirect ("edpDetails.jsp");
	  
	  }
	  
	  else {
	  
	  Msg="NOT ELIGIBLE OR ALREADY OPTED";
	  session.setAttribute("Msg",Msg);
	  
	  }
	    rsY.close();
rsE.close();
rsM.close(); 
db.close();

	 %> 


<body>  

<h1><div align="center" class="redLebel"><%=Msg%></div></h1>

</body>
</html>
	   
	   
	   
	   