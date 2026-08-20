<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%@ page import="cdacuidai.VerifyAadhaarByID"%>


<%
String APP_ID=request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String adhvalid="F";

try {
VerifyAadhaarByID v= new VerifyAadhaarByID();	
adhvalid=v.VerifyAad(APP_ID, "AG");
}catch (Exception e) {}

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
String ACT_YN ="";
String IFSC_CODE ="";
String IND_DESC ="";
String BANK_NAME ="";
String BRANCH_NAME ="";
String GENDER ="";
String EDU_DESC ="";
String SOCIAL_CATEGORY ="";
String SPECIAL_CATEGORY ="";
String UNIT_LOC="";
String MACHINARY_COST="";
String WORKING_CAPITAL="";
String EMAIL="";
String EMP_ENV="";
String VALID_DATA="Y";
String EDU_ID="";

 ArrayList aerror = new ArrayList();
        DBCon db= new DBCon();
        db.connect();
           StringBuffer qrysb = new StringBuffer();
		   
qrysb.append("   SELECT A.APP_ID,CASE WHEN A.IND_TYPE='M' AND A.ACTIVITY_CD IN (312,313,314,315,316) THEN 'N' ELSE 'Y' END AS ACT_VALID,"      );
qrysb.append("     MD.STATE_CD,"      );
qrysb.append("     A.IFSC_CODE,A.BENF_TYPE_CD,"      );
qrysb.append("     BRM.ACT_YN,"      );
qrysb.append("     UPPER(A.APP_NAME)                                    AS APP_NAME,"      );
qrysb.append("     NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0) AS PROJ_COST,"      );
qrysb.append("     A.IND_TYPE,"      );
qrysb.append("     CASE "      );
qrysb.append("       WHEN A.IND_TYPE = 'M'"      );
qrysb.append("       THEN 'MANUFACTURING'"      );
qrysb.append("       WHEN A.IND_TYPE = 'T'"      );
qrysb.append("       THEN 'TRADING'"      );
qrysb.append("       WHEN A.IND_TYPE = 'S'"      );
qrysb.append("       THEN 'SERVICING'"      );
qrysb.append("     END                                                      AS IND_DESC,"      );
qrysb.append("     TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS')          AS ONLINE_SUB_DT,CASE WHEN TRUNC(A.ONLINE_SUBDT) >'31-MAY-2022' THEN 'Y' ELSE 'N' END  AS ONLINE_SUBDT,"      );
qrysb.append("     TRUNC(MONTHS_BETWEEN(TRUNC(SysDate), TRUNC(A.DOB)) / 12) AS AGE,"      );
qrysb.append("     A.MOB_NO1,"      );
qrysb.append("     upper(A.PAN_NO) AS PAN_NO,NVL(A.MACHINARY_COST, 0) MACHINARY_COST,"      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     UPPER(AM.ACTIVITY_NAME)       AS ACTIVITY_NAME,"      );
qrysb.append("     TO_CHAR(A.DOB, 'DD-MON-RRRR') AS DOB,"      );
qrysb.append("     A.E_MAIL AS EMAIL,"      );
qrysb.append("     A.AADHAR_NO,DECODE(A.IND_TYPE,'M',(60/100*(NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0))),(40/100*(NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0)))) AS VALID_CE, "      );
qrysb.append("     UPPER(A.PROD_DESC) AS PROD_DESC,"      );
qrysb.append("     CASE"      );
qrysb.append("       WHEN MS.STATE_CD IN ('AR', 'AS', 'MN', 'MG', 'SK', 'TR', 'NG', 'MZ', 'JK')"      );
qrysb.append("       THEN 'Y'"      );
qrysb.append("       ELSE 'N'"      );
qrysb.append("     END NER_YN,"      );
qrysb.append("     A.GENDER,"      );
qrysb.append("     A.BENF_CATAGORY_CD,"      );
qrysb.append("     A.EMP_ENV,"      );
qrysb.append("     A.BANK_NAME,"      );
qrysb.append("     A.BRANCH_NAME,"      );
qrysb.append("     A.EDU_ID,"      );
qrysb.append("     BCM_S.BENF_CATEGORY_DESC AS SOCIAL_CATEGORY,"      );
qrysb.append("     BCM.BENF_CATEGORY_DESC   AS SPECIAL_CATEGORY,"      );
qrysb.append("     EM.EDU_DESC,A.UNIT_LOC, A.WORKING_CAPITAL, A.MACHINARY_COST "      );
qrysb.append("   FROM APP_DETAIL A,"      );
qrysb.append("     RBIBANKLIST BRM,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM_S,"      );
qrysb.append("     EDUCATION_MAST EM"      );
qrysb.append("   WHERE BRM.IFSC_CODE    = A.IFSC_CODE"      );
qrysb.append("   AND A.UNIT_DIST_CD     = MD.DISTRICT_CD"      );
qrysb.append("   AND A.ACTIVITY_CD      = AM.ACTIVITY_CD"      );
qrysb.append("   AND MD.STATE_CD        = MS.STATE_CD"      );
qrysb.append("   AND A.BENF_SPECAT_CD   = BCM.BENF_CATEGORY_CD"      );
qrysb.append("   AND A.BENF_CATAGORY_CD = BCM_S.BENF_CATEGORY_CD"      );
qrysb.append("   AND A.EDU_ID          = EM.EDU_ID "      );
qrysb.append("   AND A.APP_ID= '"+APP_ID+"'  "    );			   
			 //out.print (qrysb.toString());
			
  ResultSet rsApp = db.execSQL(qrysb.toString());
  boolean adharvalid=false;
  boolean apan =false;
  String STATE_CD="";
  String ACTIVITY_NAME="";
  String NER_YN="";
  String PROD_DESC ="";
  String ONLINE_SUBDT="";
    int Validce=0;
	String ACT_VALID="";
   //String MACHINARY_COST="";
   int mc=0;
String VALID_CE="";
  while (rsApp.next()){
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
  IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
  ACT_YN=rsApp.getString("ACT_YN")==null?"":rsApp.getString("ACT_YN");
  BANK_NAME=rsApp.getString("BANK_NAME")==null?"":rsApp.getString("BANK_NAME");
  BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"":rsApp.getString("BRANCH_NAME");  
  SOCIAL_CATEGORY=rsApp.getString("SOCIAL_CATEGORY")==null?"":rsApp.getString("SOCIAL_CATEGORY");
  SPECIAL_CATEGORY=rsApp.getString("SPECIAL_CATEGORY")==null?"":rsApp.getString("SPECIAL_CATEGORY");
  EDU_DESC=rsApp.getString("EDU_DESC")==null?"":rsApp.getString("EDU_DESC");
  IND_DESC=rsApp.getString("IND_DESC")==null?"":rsApp.getString("IND_DESC");
  GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
  UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
  MACHINARY_COST=rsApp.getString("MACHINARY_COST")==null?"0":rsApp.getString("MACHINARY_COST");
  WORKING_CAPITAL=rsApp.getString("WORKING_CAPITAL")==null?"0":rsApp.getString("WORKING_CAPITAL");
 EMAIL=rsApp.getString("EMAIL")==null?"":rsApp.getString("EMAIL");
EMP_ENV=rsApp.getString("EMP_ENV")==null?"":rsApp.getString("EMP_ENV");
 EDU_ID=rsApp.getString("EDU_ID")==null?"":rsApp.getString("EDU_ID");
 ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
  ACT_VALID=rsApp.getString("ACT_VALID")==null?"":rsApp.getString("ACT_VALID");
  try {
  mc =Integer.parseInt ( rsApp.getString("MACHINARY_COST"));
  } catch (Exception e) {}
  
  VALID_CE=rsApp.getString("VALID_CE")==null?"":rsApp.getString("VALID_CE");
  try {
  Validce =Integer.parseInt ( rsApp.getString("VALID_CE"));
  } catch (Exception e) {}
  
 validateAutoForward vaf = new validateAutoForward();

  if (APP_NAME.equals("")) {
aerror.add("Applicant Name Should not be Blank and Name Should be As per Identity Proof..");
}
 if ( ACT_YN.equals("N")) {
  
     aerror.add(" This bank("+IFSC_CODE+")is closed , Please select another bank before forwarding the application ");
  }
  
  if (ACT_VALID.equals("N")) {
aerror.add(ACTIVITY_NAME+" Activity doess not belong to Manufacturing Industry...PLz Change the industry Type");
}
  
 /* if ( NER_YN.equals("Y")) {
  
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
  
  }else{*/
  
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
    
  if (!BENF_TYPE_CD.equals("1")) {
   aerror.add(" Only Individual Application are allowed.......");
  }
  
 // }
  String dupid="";
  StringBuffer qrydup = new StringBuffer();
 
  /* try {
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
 
 } catch (Exception e) {}*/
 
 
  
 if (DOB.equals("")&&BENF_TYPE_CD.equals("1")) {
   aerror.add("DOB not Provided.........");
  }
  
   if (ACTIVITY_NAME.equals("OTHERS")&& PROD_DESC.equals("")) {
   aerror.add("Enter Product Description.........");
  }
  
    if (EMP_ENV.equals("0")) {
   aerror.add("Enter No of Employment.........");
  }
 
  try {
  if (Integer.parseInt(PROJ_COST)<1000) {
   aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
  
  
 try {
 if (Integer.parseInt(PROJ_COST)>10000000) {
   aerror.add("Total Project Cost for Micro Industry Unit should not exceed 1 crore.");
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
    try {
 if ((Integer.parseInt(PROJ_COST)>2500000) && (ONLINE_SUBDT.equals("N"))) {
   aerror.add("Total Project Cost for Micro Industry Unit should not exceed 2500000.");
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
 /*
   if (IND_TYPE.equals("M") && mc < Validce){
aerror.add("Capital Expenditure For Manufacturing Industry should be 60 % of Total Project Cost i.e" + Validce);
}

 if (!IND_TYPE.equals("M") && mc < Validce){
aerror.add("Capital Expenditure For Service/Trading Industry should be 40 % of Total Project Cost i.e"+ Validce);
}*/

  if (IND_TYPE.equals("M") && mc < Validce){
aerror.add(" FOR MANUFACTURING  UNIT  WORKING CAPITAL COMPONENT SHOULD NOT BE MORE THAN 40% OF THE TOTAL PJOECT COST");
}

 if (!IND_TYPE.equals("M") && mc < Validce){
aerror.add("FOR SERVICE/TRADING UNIT  WORKING CAPITAL COMPONENT SHOULD NOT BE MORE THAN 60% OF THE TOTAL PJOECT COST");
}	
	

 try {
 if (Integer.parseInt(AGE)<18 || Integer.parseInt(AGE)>90) {
  if (BENF_TYPE_CD.equals("1")){
   aerror.add("Invalid AGE......:"+AGE);
   }//emd of
  }
  }catch (Exception m){
  if (BENF_TYPE_CD.equals("1")){
  aerror.add("Invalid AGE............ :"+AGE);
  }//end of 
  }
 
 /* if ( !IND_TYPE.equals("M")&& Integer.parseInt(PROJ_COST)>2000000){
  aerror.add("Invalid Project Cost for Service/Trading Industry.....");
    
  }*/
  if ( IND_TYPE.equals("M") && EDU_ID.equals("5") && Integer.parseInt(PROJ_COST)>1000000){
  aerror.add("Total Project Cost for Under 8th  for Manufacturing Industry should not exceed 10 lakhs");
    
  }
  if ( IND_TYPE.equals("S") && EDU_ID.equals("5") && Integer.parseInt(PROJ_COST)>500000){
  aerror.add("Total Project Cost for Under 8th  for Manufacturing Industry should not exceed 5 lakhs");
    
  }
 /* if ( IND_TYPE.equals("M") && Integer.parseInt(PROJ_COST)>5000000){
  aerror.add("Total Project Cost for Manufacturing Unit should not exceed 25 lakhs");
    
  }*
  if ( IND_TYPE.equals("S") && Integer.parseInt(PROJ_COST)>2000000){
  aerror.add("Total Project Cost for Service Unit should not exceed 10 lakhs");
    
  }*/
   if (!adhvalid.equals("S") ){
 aerror.add("Aadhaar Details are invalid! Please ensure Aadhaar No, Name, Date Of Birth , Gender and mobile No Details are as per Aadhaar Card....... ! Update Correct  Details in Applicant Data form ");
 }

  
  
   StringBuffer qryupdt = new StringBuffer();
   
qryupdt.append("   SELECT AUM.UPM_CD, ");
 qryupdt.append(" AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM WHERE ");
qryupdt.append("  UPM_CD IN ");
qryupdt.append(" (SELECT * FROM TABLE(FUPLOAD_DOC('"+APP_ID+"' ))) AND AUM.UPM_CD <> '3' ");
qryupdt.append(" MINUS ");
qryupdt.append(" SELECT AUM.UPM_CD,AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM,APP_UPLOAD_TRANS AUT WHERE ");
qryupdt.append("  AUM.UPM_CD=AUT.UPM_CD AND AUT.APP_ID='"+APP_ID+"'  ");
//out.print(qryupdt.toString());
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
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
</head>
<body>
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
   
    <td>Pan No: </td>
    <td><%= PAN_NO %></td>
	 <th scope="row">Date of Birth: </th>
    <td><%= DOB %> ( Age:<%= AGE %>)<br> </td>
  </tr>
  <tr>
 
	
    <td>Employement: </td>
    <td><%=EMP_ENV%></td>
	<td>Gender</td>
    <td><%=GENDER%></td>
  </tr>
  <tr>
    <th scope="row">Industry Type: </th>
    <td><%= IND_DESC %></td>
	<td scope="row">Aadhar No: </td>
    <td><%= AADHAR_NO %></td>
    
  </tr>

  <tr>
   
    <td>Project Cost (CE+WC): </td>
    <td><%=MACHINARY_COST%>+<%=WORKING_CAPITAL%>=<%= PROJ_COST %></td>
	   <td scope="row">Mobile No:</td>
    <td><%= MOB_NO1 %></td>
  </tr>
    <tr>
    <th scope="row">Unit Location </th>
    <td><%=UNIT_LOC%></td>
	<td>Industry/Product Description:</td>
    <td><%= ACTIVITY_NAME %>  / <%= PROD_DESC %></td>
    
  </tr>
  <tr>
    <th scope="row">Social Category </th>
    <td><%=SPECIAL_CATEGORY%></td>
    <td>Special Category</td>
    <td><%=SOCIAL_CATEGORY%></td>
  </tr>
  <tr>
    <th scope="row">Education </th>
    <td><%=EDU_DESC%></td>
    <td>IFSC Code </td>
    <td><%=IFSC_CODE%></td>
  </tr>
  <tr>
    <th scope="row">Bank Name </th>
    <td><%=BANK_NAME%></td>
    <td>Branch Name </td>
    <td><%=BRANCH_NAME%></td>
  </tr>
  
  <tr>
    <td colspan="4" class="warning" scope="row"><h2 class="error">  Submission failed due to following reason: </h2></td>
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
	 session.setAttribute("sAPP_ID",APP_ID);
response.sendRedirect("StatusBankForward.jsp");
 
 }
%>
</table>		
<p>&nbsp;</p>

</body>
</html>