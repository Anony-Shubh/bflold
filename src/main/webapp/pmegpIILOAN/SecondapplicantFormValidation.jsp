<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%
String APP_ID=(String) session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID") ;
out.print(APP_ID);
if ((!APP_ID.equals(""))||(!APP_ID.equals("null"))){






String AADHAR_NO ="";
String PAN_NO="";
String DOB="";
String PROJ_COST="0";
String AGE="0";
String IND_TYPE="";
String APP_NAME="";
String MOB_NO1="";
String BENF_TYPE_CD="";
String UNIT_ESTB_YR="";
int validcount=0;
String UNIT_YR="";
String VALID_DATA="Y";
String BENF_SPECAT_CD="";
String BENF_CATAGORY_CD="";
String SECL_ID="";
String SCHEME_NM="";
String EMP_YN ="";
String REPAYDT_VAL="";

 ArrayList aerror = new ArrayList();
        DBCon db= new DBCon();
        db.connect();
           StringBuffer qry = new StringBuffer();
          qry.append(" SELECT A.APP_ID,MD.STATE_CD,A.BENF_SPECAT_CD,A.BENF_CATAGORY_CD,A.S_ID,B.SCHEME_NM,CASE WHEN A.EMP_ENV <B.EMP_ENV THEN 'N' ELSE 'Y' END AS EMP_ENV,");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME, NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0) AS PROJ_COST ,A.IND_TYPE,");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT,");
		    qry.append("  A.MOB_NO1,upper(A.PAN_NO) as PAN_NO,MS.STATE_CD, MS.STATE_NM, UPPER(AM.ACTIVITY_NAME) AS ACTIVITY_NAME,TO_CHAR(A.UNIT_ESTB_YR,'DD-MON-RRRR') as UNIT_YR, ");
			 qry.append("  A.E_MAIL,A.AADHAR_NO, UPPER(A.PROD_DESC) AS PROD_DESC, ");
			 qry.append(" CASE WHEN MS.STATE_CD IN ('AR','AS','MN','MG','SK','TR','NG','MZ','JK') THEN 'Y' ELSE 'N' END NER_YN,CASE WHEN TO_char(A.UNIT_ESTB_YR,'RRRR')<= to_char(add_months(SYSDATE,-36),'RRRR') THEN 'Y' ELSE 'N'  END AS UNIT_ESTB_YR ,case when trunc(REPAY_DT) - trunc(IST_LOAN_DT)>=0 then  'SUCC'   ELSE 'ERR' END REPAYDT_VAL ");
			  qry.append(" FROM APP_DETAIL_ONLINE_SECOND A , M_STATE MS, M_DISTRICT MD, ACTIVITY_MAST AM,APP_SEC_LOAN B ");
			  qry.append(" WHERE A.UNIT_DIST_CD=MD.DISTRICT_CD AND A.ACTIVITY_CD = AM.ACTIVITY_CD AND B.SECL_ID=A.S_ID  AND ");
			 qry.append("  MD.STATE_CD=MS.STATE_CD AND A.APP_ID='"+APP_ID+"'");
			  
			//out.print(qry.toString());
  ResultSet rsApp = db.execSQL(qry.toString());
  boolean adharvalid=false;
  boolean apan =false;
  String STATE_CD="";
  String ACTIVITY_NAME="";
  String NER_YN="";
  String PROD_DESC ="";
  while (rsApp.next()){
  VALID_DATA="Y";
  REPAYDT_VAL=rsApp.getString("REPAYDT_VAL")==null?"":rsApp.getString("REPAYDT_VAL");
  APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
  AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
  PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
   UNIT_YR=rsApp.getString("UNIT_YR")==null?"":rsApp.getString("UNIT_YR");
  PROJ_COST=rsApp.getString("PROJ_COST")==null?"":rsApp.getString("PROJ_COST");
  UNIT_ESTB_YR=rsApp.getString("UNIT_ESTB_YR")==null?"":rsApp.getString("UNIT_ESTB_YR");
  IND_TYPE=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
  APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
  ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
  PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC"); 
  STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");
  NER_YN=rsApp.getString("NER_YN")==null?"":rsApp.getString("NER_YN");  
  BENF_SPECAT_CD=rsApp.getString("BENF_SPECAT_CD")==null?"":rsApp.getString("BENF_SPECAT_CD");
  BENF_CATAGORY_CD=rsApp.getString("BENF_CATAGORY_CD")==null?"":rsApp.getString("BENF_CATAGORY_CD");
  SECL_ID=rsApp.getString("S_ID")==null?"":rsApp.getString("S_ID");
  SCHEME_NM=rsApp.getString("SCHEME_NM")==null?"":rsApp.getString("SCHEME_NM");
   EMP_YN=rsApp.getString("EMP_ENV")==null?"":rsApp.getString("EMP_ENV");  
   
  validateAutoForward vaf = new validateAutoForward();
  
  if (APP_NAME.equals("")) {
aerror.add("Applicant Name Should not be Blank and Name Should be As per Identity Proof..");
}
  
   if (UNIT_ESTB_YR.equals("N")) {
aerror.add(" Unit Establisment Should be atleast 3 Yrs Back");
}
  
   if (BENF_CATAGORY_CD.equals("")) {
aerror.add("Please Select Social Cateogry");
}
   if (EMP_YN.equals("N")) {
aerror.add(" New Unit Should lead to additional Employement as compared to the previous unit");
}
  

    if (REPAYDT_VAL.equals("ERR")) {
//aerror.add(" Loan Sanction Date and Date of Repayment Must be entered.. Repayment Date cannot be before Loan sanction Date !");
}
  
  
  
  if ( NER_YN.equals("Y")) {
  
   if (BENF_SPECAT_CD.equals("NA")){
	 aerror.add("Your State belongs to either North east Or Hill States Cateogry.... Please select Correct Social cateogry  ");  
}  
  
  if (AADHAR_NO.equals("") && PAN_NO.equals("") ) {
   aerror.add("Adhaar Number Preferred , if Adhaar Number is Not issued by UIDIA then PAN No Must be entered. Please Dont enter Invalid Adhaar or PAN");
  }
  
  if (!AADHAR_NO.equals("")) {
    adharvalid = vaf.validateAadharNumber(AADHAR_NO);
   if (!adharvalid) { 
    aerror.add( "Invalid Aadhaar Number:"+AADHAR_NO);
    
   }
  }
  
  if (!PAN_NO.equals("")) {
   apan = vaf.validatePAN(PAN_NO);
   if (!apan) {  aerror.add( "Invalid PAN Number:"+PAN_NO);
   }
   }
  
  // END OF NER
  
  }else{
  if (BENF_SPECAT_CD.equals("NE") || BENF_SPECAT_CD.equals("HS")){
	 aerror.add("Your State is not declared as Hill states or North East States...Please select Correct Social cateogry");   
}     
  
  
  if (AADHAR_NO.equals("")) {
   aerror.add("Aadhar Number Not provided");
  }
  
   if (!AADHAR_NO.equals("")) {
    adharvalid = vaf.validateAadharNumber(AADHAR_NO);
   if (!adharvalid) { 
    aerror.add( "Invalid Aadhaar Number:"+AADHAR_NO);
    
   }
  }
 
  
  if (!PAN_NO.equals("")) {
    apan = vaf.validatePAN(PAN_NO);
   if (!apan) {  aerror.add( "Invalid PAN Number:"+PAN_NO);
    
   }
  }
    
 
  
  }
  
   String cAppid="";
  StringBuffer qryCount = new StringBuffer();
  if (SCHEME_NM.equals("PMEGP")){
  qryCount.append(" SELECT MAX(COUNTYN) AS COUNTYN FROM (
SELECT COUNT(APP_ID) AS COUNTYN FROM PMEGPONLINE.APP_DETAIL APP_ID WHERE APP_ID IN (SELECT APP_ID FROM APP_SEC_LOAN WHERE SECL_ID="+SECL_ID+")
UNION
SELECT COUNT(APP_ID) AS COUNTYN FROM APP_DETAIL APP_ID WHERE APP_ID IN (SELECT APP_ID FROM APP_SEC_LOAN WHERE SECL_ID="+SECL_ID+")
) ");
  ResultSet rsCountApp = db.execSQL(qryCount.toString()); 
 
 while (rsCountApp.next()){
 cAppid=cAppid+","+rsCountApp.getString("COUNTYN")==null?"0":rsCountApp.getString("COUNTYN");
 }
 
 if (cAppid.equals("0")){
 aerror.add(" This Application is Not an E-tracking Application ");
 }
 rsCountApp.close();
}
 
  
  
  
  
  
  
  String dupid="";
  StringBuffer qrydup = new StringBuffer();
  
   try {
  if (adharvalid) {
 qrydup.append(" SELECT * FROM (SELECT APP_ID,TO_CHAR(AADHAR_NO) AS PER_IDENTITY FROM APP_DETAIL_SECOND WHERE AADHAR_NO="+AADHAR_NO+" ");
 qrydup.append(" AND LENGTH (AADHAR_NO)=12 AND ACT_ID NOT IN (3,7)) WHERE ACT_YN='Y'  ");

  ResultSet rsdup = db.execSQL(qrydup.toString()); 
 
 while (rsdup.next()){
 dupid=dupid+","+rsdup.getString("APP_ID");
 }
 
 if (!dupid.equals("")){
 aerror.add("Application ID "+ dupid +" already applied with the same Aadhar Number ");
 }
 rsdup.close();
 }// ON AADHAR apan
 
  if (apan) {
 
qrydup.append(" SELECT * FROM (SELECT APP_ID,PAN_NO FROM APP_DETAIL_SECOND WHERE TRIM(UPPER(PAN_NO))=TRIM(UPPER('"+PAN_NO+"')) ");
 qrydup.append(" AND LENGTH(PAN_NO)=10  AND ACT_ID NOT IN (3,7)) WHERE ACT_YN='Y' ");
 
  ResultSet rsdup = db.execSQL(qrydup.toString()); 
 
 while (rsdup.next()){
 dupid=dupid+","+rsdup.getString("APP_ID");
 
 }
 
 if (!dupid.equals("")){
 aerror.add("Application ID "+ dupid +" already applied with the same PAN Number ");
  
 
 }
 rsdup.close();
 }// ON  PAN
 
 } catch (Exception e) {}
  
 
 
 
  try {
  if (Integer.parseInt(PROJ_COST)<1000) {
   aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
  
  
 
   
  
 
  if ( !IND_TYPE.equals("M")&& Integer.parseInt(PROJ_COST)>2500000){
  aerror.add("Invalid Project Cost for Service/Trading Industry.....");
    
  }
  
  
  if ( IND_TYPE.equals("M")&& Integer.parseInt(PROJ_COST)>10000000){
  aerror.add("Invalid Project Cost for Manufacturing Industry.....");
    
  }
  
   StringBuffer qryupdt = new StringBuffer();
   
  qryupdt.append("    SELECT AUM.UPM_CD,");
 qryupdt.append(" AUM.DOC_DESC FROM APP_UPLOAD_MAST_second AUM WHERE AUM.USR_TYPE='I' AND AUM.UPM_CD NOT IN (8,16)  ");
qryupdt.append("  MINUS ");
qryupdt.append(" SELECT AUM.UPM_CD,AUM.DOC_DESC FROM APP_UPLOAD_MAST_SECOND AUM,APP_UPLOAD_TRANS_SECOND AUT WHERE ");
 qryupdt.append("  AUM.UPM_CD=AUT.UPM_CD AND AUM.USR_TYPE='I' AND AUT.APP_ID='"+APP_ID+"'  "); 
  String docnotupdt="";
 ResultSet rsupdt = db.execSQL(qryupdt.toString());  
 while (rsupdt.next()){
 docnotupdt=docnotupdt+",  "+rsupdt.getString(2);
 }
 if (!docnotupdt.equals("")){
aerror.add("documents not Uploaded:"+docnotupdt);
 }
 rsupdt.close();
%>

<table align="center" class="pmegpTable">
  <tr>
    <th colspan="4" scope="row"><div align="center">PMEGP SYSTEM VALIDATION REPORT </div></th>
  </tr>
  <tr>
    <td scope="row">Applicant ID: </td>
    <td><%= APP_ID %></td>
    <td>Applcant Name: </td>
    <td><%= APP_NAME %></td>
  </tr>
  <tr>
    <td scope="row">Aadhar No: </td>
    <td><%= AADHAR_NO %></td>
    <td>Pan No: </td>
    <td><%= PAN_NO %></td>
  </tr>
  <tr>
    <td scope="row">Mobile No:</td>
    <td><%= MOB_NO1 %></td>
    <td>Project Cost: </td>
    <td><%= PROJ_COST %></td>
  </tr>
  <tr>
    <th scope="row">Industry Type: </th>
    <td><%= IND_TYPE %></td>
    <td>Industry:</td>
    <td><%= ACTIVITY_NAME %>  / <%= PROD_DESC %></td>
  </tr>
  
  <tr>
    <td colspan="4" class="warning" scope="row"><h2 class="error">  Final submission failed due to following reason: </h2></td>
  </tr>
  
  <%
   ListIterator itr=aerror.listIterator();
   int cnterro=0;
   while(itr.hasNext()){ VALID_DATA="N"; 
cnterro=cnterro+1;   %>
  
  <tr class="redLebel">
    <td class="OrangeLebel" scope="row">
	
	  <div align="right"><%= cnterro %></div></td>
    <td colspan="3" class="warning" scope="row"><h3><%= itr.next()%></h3></td>
  </tr>
 
<%			
        }
 if (VALID_DATA.equals("Y")){
 response.sendRedirect("appFinalSubmission.jsp");
 }
 }
 rsApp.close();
 db.close(); 
  
%>
</table>
<div align="center">  <a href="editpmegpapplication.jsp?app_id=<%= APP_ID %>" class="greenButtonRound"/>Edit Appplication</a>
<a href="upload.jsp?app_id=<%= APP_ID %>" class="greenButtonRound"/>Upload Document</a>	</div>	
<p>&nbsp;</p>

</form>
<%}else { out.print("Session Expired"); %>
<a href="applicantLogin.jsp" class="greenButtonRound"/>Login to Submit your application</a>	</div>	
<%}%>
</body>
</html>