
<%@ page  buffer="500kb" import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,pkgPmegpNew.validateAutoForward"  %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpTable.css"" />
</head>
<body>
<%
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String AADHAR_NO ="";
String PAN_NO="";
String DOB="";
String PROJ_COST="0";
String AGE="0";
String IND_TYPE="";
String APP_NAME="";
String MOB_NO1="";
int validcount=0;

String VALID_DATA="Y";

List values=new ArrayList();
List pstm=new ArrayList();

 ArrayList aerror = new ArrayList();
        DBCon db= new DBCon();
        db.connect();
           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,MD.STATE_CD, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME, NVL(A.WORKING_CAPITAL, 0) + NVL(A.MACHINARY_COST, 0) AS PROJ_COST ,A.IND_TYPE,");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE),TRUNC(A.DOB))/12) AS AGE,");
		    qry.append("  A.MOB_NO1,upper(A.PAN_NO) as PAN_NO,MS.STATE_CD, MS.STATE_NM,");
			 qry.append(" TO_CHAR(A.DOB,'DD-MON-RRRR') AS DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A , M_STATE MS, M_DISTRICT MD ");
			  qry.append("WHERE A.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND A.APP_ID='"+APP_ID+"'");

  ResultSet rsApp = db.execSQL(qry.toString());
  boolean adharvalid=false;
  boolean apan =false;
  String STATE_CD="";
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
  
  STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");

  validateAutoForward vaf = new validateAutoForward();
  
  if (APP_NAME.equals("")) {
aerror.add("Applicant Name Should not be Blank and Name Should be As per Identity Proof..");
}
  
  
  if (AADHAR_NO.equals("")) {
   aerror.add("Aadhar Number Not provided");
  }else{
   adharvalid = vaf.validateAadharNumber(AADHAR_NO);
   if (!adharvalid) { 
    aerror.add( "Invalid Aadhaar Number:"+AADHAR_NO);
    
   }
  }
 
  if (!adharvalid) {
  if (PAN_NO.equals("")) {
   aerror.add ("PAN Number Not provided");
    
  }else{
    apan = vaf.validatePAN(PAN_NO);
   if (!apan) {  aerror.add( "Invalid PAN Number:"+PAN_NO);
    
   }
  }
  }//pan no....
  
  String dupid="";
  StringBuffer qrydup = new StringBuffer();
  
   try {
  if (adharvalid) {
 qrydup.append(" SELECT APP_ID,TO_CHAR(AADHAR_NO) AS PER_IDENTITY FROM APP_DETAIL WHERE AADHAR_NO="+AADHAR_NO+" ");
 qrydup.append(" AND LENGTH (AADHAR_NO)=12 AND ACT_ID=5  ");

  ResultSet rsdup = db.execSQL(qrydup.toString()); 
 
 while (rsdup.next()){
 dupid=dupid+","+rsdup.getString("APP_ID");
 }
 
 if (!dupid.equals("")){
 aerror.add("Application ID "+ dupid +" already Fordwarded to Bank with the same Aadhar Number ");
 }
 rsdup.close();
 }// ON AADHAR apan
 
  if (apan) {
 
qrydup.append(" SELECT APP_ID,PAN_NO FROM APP_DETAIL WHERE TRIM(UPPER(PAN_NO))=TRIM(UPPER('"+PAN_NO+"')) ");
 qrydup.append(" AND LENGTH(PAN_NO)=10  AND ACT_ID=5  ");
 
  ResultSet rsdup = db.execSQL(qrydup.toString()); 
 
 while (rsdup.next()){
 dupid=dupid+","+rsdup.getString("APP_ID");
 
 }
 
 if (!dupid.equals("")){
 aerror.add("Application ID "+ dupid +" already Fordwarded to Bank with the same PAN Number ");
  
 
 }
 rsdup.close();
 }// ON  PAN
 
 } catch (Exception e) {}
  
 
  
 if (DOB.equals("")) {
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
   aerror.add("Invalid......:"+AGE);
  }
  }catch (Exception m){
  
  aerror.add("Invalid:"+AGE);
  }
 
  if ( !IND_TYPE.equals("M")&& Integer.parseInt(PROJ_COST)>1000000){
  aerror.add("Invalid Project Cost for Service/Trading Industry.....");
    
  }
  
   StringBuffer qryupdt = new StringBuffer();
   
qryupdt.append("   SELECT AUM.UPM_CD, ");
 qryupdt.append(" AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM WHERE ");
qryupdt.append("  UPM_CD IN ");
qryupdt.append(" (SELECT * FROM TABLE(FUPLOAD_DOC('"+APP_ID+"' ))) AND AUM.UPM_CD NOT IN (2,3,8) ");
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
 rsupdt.close();
%>

<table align="center" class="pmegpTable">
  <tr>
    <th colspan="4" scope="row">PMEGP SYSTEM VALIDATION REPORT </th>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row">Date of Birth: </th>
    <td><%= DOB %> ( Age:<%= AGE %>)<br> </td>
    <td>Project Cost: </td>
    <td><%= PROJ_COST %></td>
  </tr>
  
  <tr>
    <td colspan="4" class="warning" scope="row"><h1>Please get Corrected the Following as per Scheme Gudelines.</h1></td>
  </tr>
  
  <%
   ListIterator itr=aerror.listIterator();
   int cnterro=0;
   while(itr.hasNext()){ VALID_DATA="N"; 
cnterro=cnterro+1;   %>
  
  <tr class="redLebel">
    <td class="OrangeLebel" scope="row">
	
	  <div align="right"><%= cnterro %></div></td>
    <td colspan="3" class="OrangeLebel" scope="row"><h3><%= itr.next()%></h3></td>
  </tr>
 
<%			
        }
 
 String YS="N";
 if (VALID_DATA.equals("Y")){
 validcount=validcount+1;
 pstm.clear();
values.clear();	
values.add (APP_ID);pstm.add ("S");
db.setValues(values,pstm);
 db.setSqlValue("INSERT INTO AUTOFORWARD_VALID (APP_ID) VALUES(?)");
db.executeUpdate() ;
YS="Y";
 //response.sendRedirect("Pending45daysForward.jsp?APP_ID="+APP_ID+"");
 }
						
 }
 rsApp.close();
 db.close(); 
 if (YS.equals("Y"))
 {
 response.sendRedirect("Pending45daysForward.jsp?APP_ID="+APP_ID+"");
 }
  //out.print (validcount);
  
%>
</table>		
<p>&nbsp;</p>

</body>
</html>