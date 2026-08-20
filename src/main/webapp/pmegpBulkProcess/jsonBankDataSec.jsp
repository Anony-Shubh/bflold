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
  String BR_UPDATE_YN="";
 
 
		StringBuffer qrysb= new StringBuffer();
		
		/*
		
		av.append(" SELECT * FROM  (select B.TR_ID, a.app_id,a.act_yn,B.act_id ,NVL(c.act_desc,'') AS CURRENT_STATUS,bbm.BR_ifsL_code AS ifsc_code,rbi.branchname, a.app_name,TO_CHAR(a.bank_f_date,'DD-MON-YYYY') AS bank_f_date,  ").
		append(" B.LOAN_DOCFNAME, B.MM_CLAIM_AMT,TO_CHAR(b.bank_rec_dt,'DD-MON-YYYY') AS BANK_REC_DT,to_char(b.time_stamp,'DD-MON-YYYY:HH:MM:SS') AS UP_DATE,TO_CHAR(B.MM_CLAIM_DT,'DD-MON-RRRR') "). 
		append("  AS MM_CLAIM_DT from app_detail_second a,bank_dataentry_second b,bank_app_status c,rbibanklist RBI,BANK_BR_MAST BBM where a.app_id=b.app_id (+) and RBI.ifsc_code=BBM.BR_IFSL_CODE(+) AND BBM.BR_IFSL_CODE=b.ifsc_code AND A.ACT_ID=5  AND  b.act_id=c.act_id (+)   ").
		append("  AND BBM.CIRCLE_IFSC=?  ").
  		append (" Order by b.time_stamp, B.bank_rec_dt desc) MQR,  ").
		append (" (  SELECT AUT.APP_ID,MAX(AUT.DOC_NAME) AS DOC_NAME FROM APP_UPLOAD_TRANS_second AUT, BANK_DATAENTRY_second BD,BANK_BR_MAST BBM WHERE AUT.APP_ID=BD.APP_ID  ").
        append ("  AND BD.IFSC_CODE=BBM.BR_IFSL_CODE AND BBM.CIRCLE_IFSC=? AND AUT.UPM_CD=8  ").
        append ("   GROUP BY AUT.APP_ID,BD.IFSC_CODE) SQR  ").
        append ("  WHERE MQR.APP_ID=SQR.APP_ID (+) ");
		*/
		
		
		qrysb.append("   SELECT"      );
qrysb.append("   a.ifsc_code,CASE WHEN B.ACT_ID=3 THEN 'Rejected' WHEN B.ACT_ID=11 THEN 'Sanctioned' ELSE '-' END as CURRENT_STATUS,"      );
qrysb.append("   b.TR_ID,"      );
qrysb.append("     a.APP_ID,"      );
qrysb.append("     a.ACT_YN,"      );
qrysb.append("     b.ACT_ID,"      );
qrysb.append("     a.APP_NAME,"      );
qrysb.append("     TO_CHAR(a.BANK_F_DATE, 'DD-MON-YYYY') AS bank_f_date,BBM.BR_UPDATE_YN,"      );
qrysb.append("     b.LOAN_DOCFNAME,"      );
qrysb.append("     b.MM_CLAIM_AMT,"      );
qrysb.append("     TO_CHAR(b.BANK_REC_DT, 'DD-MON-YYYY')         AS BANK_REC_DT,"      );
qrysb.append("     TO_CHAR(b.TIME_STAMP, 'DD-MON-YYYY:HH:MM:SS') AS UP_DATE,"      );
qrysb.append("     TO_CHAR(b.MM_CLAIM_DT, 'DD-MON-RRRR')         AS MM_CLAIM_DT,"      );
qrysb.append("     BBM.BR_IFSL_CODE, BBM.BRANCH_NAME AS BRANCHNAME"      );
qrysb.append("   FROM app_detail_second a,"      );
qrysb.append("     bank_dataentry_second b,"      );
qrysb.append("     BANK_BR_MAST BBM"      );
qrysb.append("   WHERE a.APP_ID       = b.APP_ID(+)"      );
qrysb.append("   AND BBM.BR_IFSL_CODE = a.IFSC_CODE "      );
//qrysb.append("   AND a.APP_ID LIKE '%TN%'"      );
qrysb.append("   AND a.ACT_ID = 5"      );
qrysb.append("   AND BBM.CIRCLE_IFSC=?"      );
qrysb.append("   ORDER BY b.TIME_STAMP,"      );
qrysb.append("     TO_CHAR(b.BANK_REC_DT, 'DD-MON-YYYY') DESC"      );

		
		List values=new ArrayList();
     values.add (IFSC_CODE);	 
	// values.add (IFSC_CODE);
		

try{
JSONArray list = new JSONArray();
ResultSet rsinst = db.executeSQL(qrysb.toString(),values);

out.print ("{ \"data\":");
  while (rsinst.next()) {
  srn=srn+1;
  APP_ID=rsinst.getString ("app_id")==null?"":rsinst.getString("app_id") ;
  APP_NAME= rsinst.getString("app_name")==null?"":rsinst.getString("app_name") ;
   BANK_F_DATE=rsinst.getString("BANK_F_DATE")==null?"":rsinst.getString("BANK_F_DATE");
  BANK_REC_DT=rsinst.getString("BANK_REC_DT")==null?"":rsinst.getString("BANK_REC_DT");
  BIFSC_CODE=rsinst.getString("IFSC_CODE")==null?"":rsinst.getString("IFSC_CODE");
 CURRENT_STATUS=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
 TR_ID=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
  LOAN_DOCFNAME=rsinst.getString("LOAN_DOCFNAME")==null?"":rsinst.getString("LOAN_DOCFNAME");
  MM_CLAIM_AMT=rsinst.getString("MM_CLAIM_AMT")==null?"0":rsinst.getString("MM_CLAIM_AMT");
  MM_CLAIM_DT=rsinst.getString("MM_CLAIM_DT")==null?"":rsinst.getString("MM_CLAIM_DT");
  ACT_ID=rsinst.getString("ACT_ID")==null?"":rsinst.getString("ACT_ID");
  // DOC_NAME=rsinst.getString("DOC_NAME")==null?"":rsinst.getString("DOC_NAME");
  DOC_NAME="-";
  ACT_YN=rsinst.getString("ACT_YN")==null?"":rsinst.getString("ACT_YN");
  BRANCHNAME=rsinst.getString("BRANCHNAME")==null?"":rsinst.getString("BRANCHNAME");
  BR_UPDATE_YN=rsinst.getString("BR_UPDATE_YN")==null?"0":rsinst.getString("BR_UPDATE_YN");
JSONObject obj=new JSONObject();

  if (ACT_YN.equals("Y")){

 obj.put("APP ID", APP_ID);
 
  obj.put("APP NAME", APP_NAME); 
  
   obj.put("IFSCODE", BIFSC_CODE);
   
  obj.put("BRANCHNAME", BRANCHNAME); 
  
 obj.put("BANK F DATE", BANK_F_DATE); 
 
 obj.put("DOCUMENTS","<input name=btnSunction type=button class=buttonGreen style=background-color:blue id=btnSunction onClick=viewAppDocument('"+APP_ID+"') value=Documents>");
 
 if (ACT_ID.equals("11")) {
 obj.put("STATUS","<a href=../jsp/PMEGPGenAppForm.jsp?APP_ID='"+APP_ID+"'&RNAME=LetterHeadOfBank class=buttonOrange target=_blank>Sanction letter</a>");
  }
  else{	  
	 obj.put("STATUS", CURRENT_STATUS); }
  
  
  obj.put("CLAIM",MM_CLAIM_DT);
  
  obj.put("AMOUNT", MM_CLAIM_AMT); 
  
  
	     if (LOAN_DOCFNAME.equals("") ) { 
	  obj.put("LOAN","-");	  
		 }
	  else{
	  obj.put("LOAN","<a href=docview.jsp?docname='"+LOAN_DOCFNAME+"' target=_blank class=buttonGray>View</a>");	 
	  }
  
  if (MM_CLAIM_AMT.equals("0")) { 
  obj.put("DOWNLOAD","Not Claimed"); 
	
	//}else if ( !(MM_CLAIM_AMT.equals("")  && MM_CLAIM_DT.equals("") )) { 
	
	//obj.put("DOWNLOAD","<input name=btnSunction type=button class=buttonMerun value=DraftMMClaim onClick=openmmReport('"+APP_ID+"')>");
	} else if (!MM_CLAIM_DT.equals("")) {
	obj.put("DOWNLOAD","<input name=btnSunction type=button class=buttonBlue value=MMClaimletter(Final) onClick=openmmReport('"+APP_ID+"')>");
	}
	
	
  if (LOAN_DOCFNAME.equals("") ) { 
	obj.put("APPLICANT DATA","<a href=appidSnSec.jsp?APP_ID="+APP_ID+"&IFSC_CODE="+BIFSC_CODE+" class=greenButtonRound>Update</a>");
	} else { 
	obj.put("APPLICANT DATA","Online Claim Submitted");
	}
	
  }
  else{
	obj.put("APP ID", APP_ID);
 
  obj.put("APP NAME", APP_NAME); 
  
   obj.put("IFSCODE", IFSC_CODE);
   
  obj.put("BRANCHNAME", BRANCHNAME); 
  
 obj.put("BANK F DATE", BANK_F_DATE); 
 
 obj.put("DOCUMENTS","<input name=btnSunction type=button class=buttonGreen id=btnSunction onClick=viewAppDocument('"+APP_ID+"') value=Documents>");
 
 if (ACT_ID.equals("11")) {
 obj.put("STATUS","<a href=../jsp/PMEGPGenAppForm.jsp?APP_ID='"+APP_ID+"'&RNAME=LetterHeadOfBank class=buttonOrange target=_blank>Sanction letter</a>");
  }
  else{	  
	 obj.put("STATUS", "<span style=font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(238, 238, 238); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;>Returned to the Applicant For Fresh Application Submission</span>");  
	  
	  
  }
  
  
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
        out.println("<h1>"+ex.toString()+"</g1>");
    }

 
 %>
        