<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<%@ page import="pkgPmegpNew.validateAutoForward"%>
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
int validcount=0;

String VALID_DATA="Y";

 ArrayList aerror = new ArrayList();
        DBCon db= new DBCon();
        db.connect();
           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,MD.STATE_CD, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME, NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0) AS PROJ_COST ,A.IND_TYPE,");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT,");
		    qry.append("  A.MOB_NO1,upper(A.PAN_NO) as PAN_NO,MS.STATE_CD, MS.STATE_NM, UPPER(AM.ACTIVITY_NAME) AS ACTIVITY_NAME, ");
			 qry.append("  A.E_MAIL,A.AADHAR_NO, UPPER(A.PROD_DESC) AS PROD_DESC, ");
			 qry.append(" CASE WHEN MS.STATE_CD IN ('AR','AS','MN','MG','SK','TR','NG','MZ','JK') THEN 'Y' ELSE 'N' END NER_YN ");
			  qry.append(" FROM APP_DETAIL_ONLINE_SECOND A , M_STATE MS, M_DISTRICT MD, ACTIVITY_MAST AM ");
			  qry.append(" WHERE A.UNIT_DIST_CD=MD.DISTRICT_CD AND A.ACTIVITY_CD = AM.ACTIVITY_CD AND ");
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
  APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
  AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
  PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
  
  PROJ_COST=rsApp.getString("PROJ_COST")==null?"":rsApp.getString("PROJ_COST");
  
  IND_TYPE=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
  APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
  ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
  PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC"); 
  STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");
  NER_YN=rsApp.getString("NER_YN")==null?"":rsApp.getString("NER_YN");  
  validateAutoForward vaf = new validateAutoForward();
  
  if (APP_NAME.equals("")) {
aerror.add("Applicant Name Should not be Blank and Name Should be As per Identity Proof..");
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
 qrydup.append(" SELECT APP_ID,TO_CHAR(AADHAR_NO) AS PER_IDENTITY FROM APP_DETAIL_SECOND WHERE AADHAR_NO="+AADHAR_NO+" ");
 qrydup.append(" AND LENGTH (AADHAR_NO)=12 AND ACT_ID NOT IN (3,7)  ");

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
 
qrydup.append(" SELECT APP_ID,PAN_NO FROM APP_DETAIL_SECOND WHERE TRIM(UPPER(PAN_NO))=TRIM(UPPER('"+PAN_NO+"')) ");
 qrydup.append(" AND LENGTH(PAN_NO)=10  AND ACT_ID NOT IN (3,7)");
 
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
  
  
  try {
 if (Integer.parseInt(PROJ_COST)>2500000) {
   aerror.add("Invalid Project Cost.....");
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
   
  
 
  if ( !IND_TYPE.equals("M")&& Integer.parseInt(PROJ_COST)>25000000){
  aerror.add("Invalid Project Cost for Service/Trading Industry.....");
    
  }
  
   StringBuffer qryupdt = new StringBuffer();
   
  qryupdt.append("    SELECT AUM.UPM_CD,");
 qryupdt.append(" AUM.DOC_DESC FROM APP_UPLOAD_MAST_second AUM  ");
qryupdt.append("  MINUS ");
qryupdt.append(" SELECT AUM.UPM_CD,AUM.DOC_DESC FROM APP_UPLOAD_MAST_SECOND AUM,APP_UPLOAD_TRANS_SECOND AUT WHERE ");
 qryupdt.append("  AUM.UPM_CD=AUT.UPM_CD AND AUT.APP_ID='"+APP_ID+"'  "); 
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
    <td><%= APP_ID %></td><input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>">
    <td>Applcant Name: </td>
    <td><%= APP_NAME %></td>
  </tr>
  <tr>
    <td scope="row">Aadhar No: </td>
    <td><%= AADHAR_NO %></td>
    <td>Pan No: </td><input name="FLAG" type="hidden" id="FLAG" value="8">
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
 if (VALID_DATA.equals("Y")){
 response.sendRedirect("appFinalSubmission.jsp");
 }
 }
 rsApp.close();
 db.close(); 
  
%>
</table>		
<p><div align="center"><input name="btnCnf" id="btnCnf" type="button" onClick="getfrequenttab(8)"; class="button" value="Edit Application" /> </div></p>

</body>
</html>