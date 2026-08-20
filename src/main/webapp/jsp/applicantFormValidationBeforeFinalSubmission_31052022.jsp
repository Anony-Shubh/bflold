<%@ include file="appIncludeHeaderPage.jsp" %>

<%
String APP_ID=(String) session.getAttribute("sAPP_ID");
String AADHAR_NO ="";
String PAN_NO="";
String DOB="";
String PROJ_COST="0";
String AGE="0";
String IND_TYPE="";
String APP_NAME="";
String MOB_NO1="";
String BENF_TYPE_CD="";
String EDP_C="";
String EDP_YN="";
int validcount=0;
String AGN_YN="";
String UNIT_LOC="";
String ORG_CD="";
String TECH_QUALI="";
String BLDG_TYPE="";

String VALID_DATA="Y";


 ArrayList aerror = new ArrayList();
         DBCon db= new DBCon();
         db.connect();
		 
		 try {
ResultSet rs= db.execSQL("UPDATE PMEGP_SCORE_CARD SET TIMESTAMP=TIMESTAMP WHERE APP_ID='"+APP_ID+"'");
rs.close();
}catch (Exception e){};

         StringBuffer qry = new StringBuffer();
qry.append(" SELECT A.APP_ID,MD.STATE_CD,A.BENF_TYPE_CD,A.EDP_YN,(SELECT COUNT(*) AS EDP_C FROM EDP_CONDUCT_TRANS WHERE APP_ID=A.APP_ID) AS EDP_C, ");
		 qry.append(" UPPER(A.APP_NAME) AS APP_NAME, NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0) AS PROJ_COST ,A.IND_TYPE,A.TECH_QUALI,A.BLDG_TYPE,");
		 qry.append(" NVL((SELECT TOTAL_SCORE FROM PMEGP_SCORE_CARD WHERE APP_ID=A.APP_ID),0) AS TOTAL_SCORE ,");
		 qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE),TRUNC(A.DOB))/12) AS AGE,");
		 qry.append("  A.MOB_NO1,upper(A.PAN_NO) as PAN_NO,MS.STATE_CD, MS.STATE_NM, UPPER(AM.ACTIVITY_NAME) AS ACTIVITY_NAME, ");
		 qry.append(" TO_CHAR(A.DOB,'DD-MON-RRRR') AS DOB,  A.E_MAIL,A.AADHAR_NO, UPPER(A.PROD_DESC) AS PROD_DESC, ");
		 qry.append(" CASE WHEN MS.STATE_CD IN ('AR','AS','MN','MG','SK','TR','NG','MZ','JK') THEN 'Y' ELSE 'N' END NER_YN, ");
		 qry.append(" CASE WHEN MS.STATE_CD IN ('DL','CH') THEN 'Y' ELSE 'N' END AGN_YN,DECODE(A.UNIT_LOC,'Urban','Y','N') as UNIT_LOC, (SELECT ORG_CD FROM MAS_OFF_MAST WHERE OFF_CD=A.OFF_CD) AS ORG_CD  ");
		 qry.append(" FROM APP_DETAIL_ONLINE A , M_STATE MS, M_DISTRICT MD, ACTIVITY_MAST AM ");
		 qry.append(" WHERE A.UNIT_DIST_CD=MD.DISTRICT_CD AND A.ACTIVITY_CD = AM.ACTIVITY_CD AND ");
		 qry.append("  MD.STATE_CD=MS.STATE_CD AND A.APP_ID='"+APP_ID+"'");
			  
			
  ResultSet rsApp = db.execSQL(qry.toString());
   
   int vtotalScore=0;
  boolean adharvalid=false;
  boolean apan =false;
  String STATE_CD="";
  String ACTIVITY_NAME="";
  String NER_YN="";
  String PROD_DESC ="";
  while (rsApp.next()){
  try {
  vtotalScore =Integer.parseInt ( rsApp.getString("TOTAL_SCORE"));
  } catch (Exception e) {}
  
  VALID_DATA="Y";
  APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
  AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
  PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
  DOB = rsApp.getString("DOB")==null?"":rsApp.getString("DOB");
  PROJ_COST=rsApp.getString("PROJ_COST")==null?"":rsApp.getString("PROJ_COST");
  AGE=rsApp.getString("AGE")==null?"":rsApp.getString("AGE");
  IND_TYPE=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
  APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
  ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
  PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC"); 
  STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");
  NER_YN=rsApp.getString("NER_YN")==null?"":rsApp.getString("NER_YN");
  BENF_TYPE_CD=rsApp.getString("BENF_TYPE_CD")==null?"":rsApp.getString("BENF_TYPE_CD");
  EDP_C=rsApp.getString("EDP_C")==null?"0":rsApp.getString("EDP_C");
  EDP_YN=rsApp.getString("EDP_YN")==null?"0":rsApp.getString("EDP_YN");
  
   UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
  AGN_YN=rsApp.getString("AGN_YN")==null?"":rsApp.getString("AGN_YN");
  ORG_CD=rsApp.getString("ORG_CD")==null?"":rsApp.getString("ORG_CD");
  TECH_QUALI=rsApp.getString("TECH_QUALI")==null?"":rsApp.getString("TECH_QUALI");
  BLDG_TYPE=rsApp.getString("BLDG_TYPE")==null?"":rsApp.getString("BLDG_TYPE");
  validateAutoForward vaf = new validateAutoForward();
  
  if (APP_NAME.equals("")) {
aerror.add("Applicant Name Should not be Blank and Name Should be As per Identity Proof..");
}
if ((EDP_C.equals("0")) && (EDP_YN.equals("N"))) {
aerror.add("EDP Center Details Not Filled......");
}
if (BLDG_TYPE.equals("")) {
aerror.add("Enter Where did You Hear abount PMEGP......");
}
if (TECH_QUALI.equals("")) {
aerror.add("Enter CGTMS Details......");
}

if ((!ORG_CD.equals("CB")) && (AGN_YN.equals("N"))){

if ((UNIT_LOC.equals("Y")) && (!ORG_CD.equals("DI"))) {
aerror.add("For Unit Location in Urban Area, Select sponsoring Agency DIC");
}

}
  
  if ( NER_YN.equals("Y")) {
  
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
  String dupid="";
  StringBuffer qrydup = new StringBuffer();
  
   try {
  if (adharvalid) {
 qrydup.append("SELECT * FROM ( SELECT AD.APP_ID,TO_CHAR(AD.AADHAR_NO) AS PER_IDENTITY,AD.ACT_YN FROM APP_DETAIL AD WHERE AD.AADHAR_NO="+AADHAR_NO+" ");
 qrydup.append(" AND LENGTH (AD.AADHAR_NO)=12 AND AD.ACT_ID NOT IN (3,7)) WHERE ACT_YN='Y' ");

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
 
qrydup.append(" SELECT * FROM (  SELECT APP_ID,PAN_NO,ACT_YN FROM APP_DETAIL WHERE TRIM(UPPER(PAN_NO))=TRIM(UPPER('"+PAN_NO+"')) ");
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
  
 
  
 if (DOB.equals("")&&BENF_TYPE_CD.equals("1")) {
   aerror.add("DOB not Provided.........");
  }
 
  try {
  if (Integer.parseInt(PROJ_COST)<1000) {
   aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
  
  
  try {
 if (Integer.parseInt(PROJ_COST)>2500000) {
   aerror.add("Invalid Project Cost.....");
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
   
 
 try {
 if (Integer.parseInt(AGE)<18 || Integer.parseInt(AGE)>90) {
  if (BENF_TYPE_CD.equals("1")){
   aerror.add("Invalid......:"+AGE);
   }//emd of
  }
  }catch (Exception m){
  if (BENF_TYPE_CD.equals("1")){
  aerror.add("Invalid :"+AGE);
  }//end of 
  }
 
  if ( !IND_TYPE.equals("M")&& Integer.parseInt(PROJ_COST)>1000000){
  aerror.add("Invalid Project Cost for Service/Trading Industry.....");
    
  }
  
   StringBuffer qryupdt = new StringBuffer();
   
qryupdt.append("   SELECT AUM.UPM_CD, ");
 qryupdt.append(" AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM WHERE ");
qryupdt.append("  UPM_CD IN ");
qryupdt.append(" (SELECT * FROM TABLE(FUPLOAD_DOC('"+APP_ID+"' )))  ");
qryupdt.append(" MINUS ");
qryupdt.append(" SELECT AUM.UPM_CD,AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM,APP_UPLOAD_TRANS AUT WHERE ");
qryupdt.append("  AUM.UPM_CD=AUT.UPM_CD AND AUT.APP_ID='"+APP_ID+"'  ");
 String docnotupdt="";
 ResultSet rsupdt = db.execSQL(qryupdt.toString());  
 while (rsupdt.next()){
 docnotupdt=docnotupdt+",  "+rsupdt.getString(2);
 }
 if (!docnotupdt.equals("")){
aerror.add("documents not Uploaded:"+docnotupdt);
 }
 int vprojectcode =Integer.parseInt(PROJ_COST);
 
 out.print (vprojectcode+" "+vtotalScore);
 if  (vprojectcode>1000000 &&vtotalScore <60) {
  aerror.add("Update Score Card Minimum Mark for more then 10 lakh Should be 60 out of 100 !");
 }
 
  if  (vprojectcode<1000001 && vtotalScore <50) {

 aerror.add("Update Score Card Form and Minimum Mark upto Project Cost 10 lakh , Should be 50 out of 100 !");
 
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
    <td>Email ID: </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row">Industry Type: </th>
    <td><%= IND_TYPE %></td>
    <td>Industry:</td>
    <td><%= ACTIVITY_NAME %>  / <%= PROD_DESC %></td>
  </tr>
  <tr>
    <th scope="row">Date of Birth: </th>
    <td><%= DOB %> ( Age:<%= AGE %>)<br> </td>
    <td>Project Cost: </td>
    <td><%= PROJ_COST %></td>
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
		
		
		}
 rsApp.close();
 db.close(); 
 
 
 if (VALID_DATA.equals("Y")){
 response.sendRedirect("appFinalSubmission.jsp");
 }
 
  
%>
</table>		
<p>&nbsp;</p>

</body>
</html>