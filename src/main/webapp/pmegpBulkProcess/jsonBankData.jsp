  <%@page language="java" import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

		<%
		
DBCon db= new DBCon();
 int srn =0;
db.connect();

String TYPE = request.getParameter("DTYPE")==null?"":request.getParameter("DTYPE");

String IFSC_CODE=(String)session.getAttribute("bank_id");
String APP_NAME="";
String CURRENT_STATUS="";
String BANK_F_DATE="";
String  BANK_REC_DT="";
String  UP_DATE ="";
String APP_ID ="";
String TR_ID ="";
String LOAN_DOCFNAME="";
String MM_CLAIM_AMT="";
String MM_CLAIM_DT="";
String ACT_ID="";
 String EDP_CERT="";
 String DOC_NAME="";
 String ACT_YN="";
  String BRANCHNAME=""; 
 String BIFSC_CODE="";
 String whrcls="";
 String sancupload="";
  String counsign="";
  String ONLINE_SUBDT="";
  String BR_UPDATE_YN="";

 
 if(TYPE.equals("ALL")){
 whrcls="";
 }else if(TYPE.equals("NEW")){
 whrcls="  and mqr.ACT_ID is null  and  mqr.ACT_YN='Y' ";
 }else if(TYPE.equals("UP")){
 whrcls="  and mqr.ACT_ID =8   and  mqr.ACT_YN='Y'  ";
  }else if(TYPE.equals("SC")){
 whrcls=" and mqr.ACT_ID =11 and mqr.mm_claim_Dt is null   ";
   }else if(TYPE.equals("CL")){
 whrcls=" and mqr.ACT_ID =11 and mqr.mm_claim_Dt is NOT null ";
    }else if(TYPE.equals("RJ")){
 whrcls="  and ( mqr.ACT_ID =3 or   mqr.ACT_YN='N' ) ";
    
 }
 //
 
 
		StringBuffer av= new StringBuffer();
		 av.append("SELECT * FROM  (select B.TR_ID, a.app_id,a.act_yn,B.act_id ,NVL(c.act_desc,'') AS CURRENT_STATUS,bbm.BR_ifsL_code AS ifsc_code,RBI.branchname, a.app_name,a.fh_name,TO_CHAR(a.bank_f_date,'DD-MON-YYYY') AS bank_f_date,(select count(*) from  app_upload_trans where app_id=a.app_id and upm_cd=22 and doc_actyn='Y') as sancupload,BBM.BR_UPDATE_YN,   "). 
		 append("B.LOAN_DOCFNAME, B.MM_CLAIM_AMT,TO_CHAR(b.bank_rec_dt,'DD-MON-YYYY') AS BANK_REC_DT,to_char(b.time_stamp,'DD-MON-YYYY:HH:MM:SS') AS UP_DATE,TO_CHAR(B.MM_CLAIM_DT,'DD-MON-RRRR')   ").
		 append(" AS MM_CLAIM_DT,(select count(*) from  app_upload_trans where app_id=a.app_id and upm_cd=16 and doc_actyn='Y') as counsign,case when trunc(a.online_subdt)> '31-MAY-2022' AND B.act_id=11 THEN 'Y' ELSE 'N' END  AS online_subdt from app_detail a,bank_dataentry b,bank_app_status c,rbibanklist RBI,BANK_BR_MAST BBM where a.app_id=b.app_id (+) and RBI.ifsc_code=BBM.BR_IFSL_CODE(+) ").
         append(" AND BBM.BR_IFSL_CODE=a.ifsc_code(+) AND A.ACT_ID=5  AND  b.act_id=c.act_id (+)    ").
		append("  AND BBM.CIRCLE_IFSC=?   ").
  		append(" Order by b.time_stamp, B.bank_rec_dt desc) MQR,   ").
		append(" (  SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS AUT, BANK_DATAENTRY BD,BANK_BR_MAST BBM WHERE AUT.APP_ID=BD.APP_ID   ").
       append("   AND BD.IFSC_CODE=BBM.BR_IFSL_CODE AND BBM.CIRCLE_IFSC=? ").
       append("   AND AUT.UPM_CD=8  AND AUT.DOC_ACTYN='Y' ").
        append("   GROUP BY AUT.APP_ID,BD.IFSC_CODE) SQR   ").
        append("  WHERE MQR.APP_ID=SQR.APP_ID (+) "+whrcls+" ");

		
		

		List values=new ArrayList();
     values.add (IFSC_CODE);	 
	 values.add (IFSC_CODE);

		
		

try{
JSONArray list = new JSONArray();
ResultSet rsinst = db.executeSQL(av.toString(),values);

out.print ("{ \"data\":");
while(rsinst.next())
  { 

  APP_ID=rsinst.getString ("app_id")==null?"":rsinst.getString("app_id") ;
  APP_NAME= rsinst.getString("app_name")==null?"":rsinst.getString("app_name") ;
  BANK_F_DATE=rsinst.getString("BANK_F_DATE")==null?"":rsinst.getString("BANK_F_DATE");
  BIFSC_CODE=rsinst.getString("IFSC_CODE")==null?"":rsinst.getString("IFSC_CODE");
  BANK_REC_DT=rsinst.getString("BANK_REC_DT")==null?"":rsinst.getString("BANK_REC_DT");
  CURRENT_STATUS=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
  TR_ID=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
  LOAN_DOCFNAME=rsinst.getString("LOAN_DOCFNAME")==null?"":rsinst.getString("LOAN_DOCFNAME");
  MM_CLAIM_AMT=rsinst.getString("MM_CLAIM_AMT")==null?"":rsinst.getString("MM_CLAIM_AMT");
  MM_CLAIM_DT=rsinst.getString("MM_CLAIM_DT")==null?"":rsinst.getString("MM_CLAIM_DT");
  ACT_ID=rsinst.getString("ACT_ID")==null?"":rsinst.getString("ACT_ID");
  DOC_NAME=rsinst.getString("DOC_NAME")==null?"":rsinst.getString("DOC_NAME");
  ACT_YN=rsinst.getString("ACT_YN")==null?"":rsinst.getString("ACT_YN");
BRANCHNAME=rsinst.getString("BRANCHNAME")==null?"":rsinst.getString("BRANCHNAME");
 sancupload=rsinst.getString("sancupload")==null?"0":rsinst.getString("sancupload");
 counsign=rsinst.getString("counsign")==null?"0":rsinst.getString("counsign");
 ONLINE_SUBDT=rsinst.getString("online_subdt")==null?"0":rsinst.getString("online_subdt");
 BR_UPDATE_YN=rsinst.getString("BR_UPDATE_YN")==null?"0":rsinst.getString("BR_UPDATE_YN");
 
JSONObject obj=new JSONObject();

  if (ACT_YN.equals("Y")){



 obj.put("APP ID", APP_ID);
 
  obj.put("APP NAME", APP_NAME); 
  
   obj.put("IFSCODE", BIFSC_CODE);
   
  obj.put("BRANCHNAME", BRANCHNAME); 
  
 obj.put("BANK F DATE", BANK_F_DATE); 
 
 
 obj.put("DOCUMENTS","<input name=btnSunction type=button class=buttonGreen style=color:black id=btnSunction onClick=viewAppDocument('"+APP_ID+"') value=View>"); 
 
 if (ACT_ID.equals("11")) { 
 obj.put("STATUS","<a href=../jsp/PMEGPGenAppForm.jsp?APP_ID="+APP_ID+"&RNAME=LetterHeadOfBank class=buttonOrange target=_blank>Sanction letter</a>");
  }else{	  
	 obj.put("STATUS", CURRENT_STATUS);
  }
  
   if (ACT_ID.equals("11")) { 
  obj.put("UPLOAD","<input name=btnUpload type=button class=buttonMerun style=color:#FF0000 value=Sanction Letter onClick=uploadBanc('"+APP_ID+"')>");
   }else{	  
	 obj.put("UPLOAD", "-");
  }
 
 
	  if ((ACT_ID.equals("11")) && (DOC_NAME != "" )) {  
	  obj.put("EDP","Uploaded");
	  } else if ((ACT_ID.equals("11")) && (DOC_NAME.equals("")) ){
 obj.put("EDP", "<input name=btnUpload type=button class=buttonMerun style=color:#000000  value=Upload EDP Certificate onClick=uploadCert('"+APP_ID+"')>");
  }
  else{
	  obj.put("EDP","-"); 
	  
  }
  
 if (ONLINE_SUBDT.equals("Y") && (counsign.equals("0"))){ 
obj.put("SIGNBOARD","<input name=btnUpload type=button class=buttonMerun style=color:#FF0000  value=SignBoard onClick=uploadSign('"+APP_ID+"')>");
	} 
	else  if (ONLINE_SUBDT.equals("N") && (counsign.equals("0"))){
	 obj.put("SIGNBOARD","-"); 
} else{
	 obj.put("SIGNBOARD","Uploaded");
	}
  
  
  obj.put("CLAIM",MM_CLAIM_DT);
  
  obj.put("AMOUNT", MM_CLAIM_AMT); 
  
  
	     if (LOAN_DOCFNAME.equals("")) { 
	  obj.put("LOAN","-");	  
		 }
	  else{
	  obj.put("LOAN","<a href=docview.jsp?docname="+LOAN_DOCFNAME+"  target=_blank class=buttonGray>View</a>");	 
	  }
  
  if (MM_CLAIM_AMT.equals("") || MM_CLAIM_AMT.equals("0")) { 
  obj.put("DOWNLOAD","-"); 
	
	}else if ((!MM_CLAIM_AMT.equals("") || MM_CLAIM_AMT.equals("0"))  && MM_CLAIM_DT.equals("") ) { 
	
	obj.put("DOWNLOAD","<input name=btnSunction type=button class=buttonMerun style=color:black value=Claim(Draft) onClick=openmmReport('"+APP_ID+"')>");
	} else if (!MM_CLAIM_DT.equals("")) {
	obj.put("DOWNLOAD","<input name=btnSunction type=button class=buttonBlue style=color:black value=Claimed(Final) onClick=openmmReport('"+APP_ID+"')>");
	}
	
	
  if (LOAN_DOCFNAME.equals(""))  { 
	obj.put("APPLICANT DATA","<a href=appidSn.jsp?APP_ID="+APP_ID+" class=buttonOrange style=background-color:yellow;color:black>Update</a>");
	} else { 
	obj.put("APPLICANT DATA","Claimed");
	}
	
  }
  else{
	obj.put("APP ID", APP_ID);
 
  obj.put("APP NAME", APP_NAME); 
  
   obj.put("IFSCODE", IFSC_CODE);
   
  obj.put("BRANCHNAME", BRANCHNAME); 
  
 obj.put("BANK F DATE", BANK_F_DATE); 
 
 obj.put("DOCUMENTS","<input name=btnSunction type=button class=buttonGreen style=color:black id=btnSunction onClick=viewAppDocument("+APP_ID+") value=View>");
 
 if (ACT_ID.equals("11")) {
 obj.put("STATUS","<a href=../jsp/PMEGPGenAppForm.jsp?APP_ID='"+APP_ID+"'&RNAME=LetterHeadOfBank class=buttonOrange target=_blank>Sanction letter</a>");
  }
  else{	  
	 obj.put("STATUS", "<div class=style5><span style=font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(238, 238, 238); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;>Returned</span></div>");  
	  
	  
  }
  obj.put("UPLOAD","");
  
    obj.put("EDP","");
	 obj.put("SIGNBOARD","");
	 obj.put("CLAIM","");
	   obj.put("AMOUNT","");
	  obj.put("LOAN","");
		    obj.put("DOWNLOAD","");
			  obj.put("APPLICANT DATA","");
  
  
  
  
  }
  list.add(obj);
  } out.print(list);
		
    out.print ("}");
}
    catch(Exception ex)
    {
        //out.println("<h1>"+ex+"</g1>");
    }

 
 %>
        