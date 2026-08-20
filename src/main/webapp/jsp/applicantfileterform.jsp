<%@ include file="includeHeaderPage.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dis.css">
<script src="../js/dis.js"></script>

</head>
<body>
This form will facilitate to find the Multiple Application submitted in KVIC/KVIB/DIC
<table align="center" class="pmegpTable">
   
    <tr>
      <td colspan="18"><div align="center"> PMEGP DETAILS</div></td>
    </tr>
</table>
	<br/>
	<input name="ins" type="hidden" id="ins" value="">

<br/>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
              <th>Agency</th>
                <th>Office Name </th>
                <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>AADHAR</th>
                <th>PAN NO </th>
                <th>STATUS</th>
                <th>MOB-NO</th>
				<th>DOB</th>
				<th>ONLINE_SUBDT</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
              <th>Agency</th>
                <th>Office Name </th>
                <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>AADHAR</th>
                <th>PAN NO </th>
                <th>STATUS</th>
                <th>MOB-NO</th>
				<th>DOB</th>
				<th>ONLINE_SUBDT</th>
            </tr>
        </tfoot>
		        <tbody>
				
				
		<%
		try {
DBCon db= new DBCon();
db.connect();
String OFF_CD= (String) session.getAttribute("off_cd");
StringBuffer qrysb = new StringBuffer();
qrysb.append(" SELECT UPPER(AD.APP_NAME) AS APP_NAME,AD.APP_ID,AD.GENDER,AD.ACT_ID,CASE WHEN NVL(BD.ACT_ID,0)>0 THEN" );
qrysb.append(" FCURRENT_APP_STATUS(AD.APP_ID) ELSE ASM.ACT_DESC END AS ACT_DESC,AD.MOB_NO1,TO_CHAR(AD.DOB,'DD-MON-YYYY') AS DOB,AD.IFSC_CODE," );
qrysb.append(" AD.AADHAR_NO,AD.PAN_NO, TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR') AS ONLINE_SUBDT, MOM.OFF_NAME,MOM.AGENCY_TYPE FROM APP_DETAIL AD,MAS_OFF_MAST MOM,");
qrysb.append(" APP_STATUS_MAST ASM, BANK_DATAENTRY BD WHERE AD.OFF_CD = MOM.OFF_CD AND AD.ACT_ID= ASM.ACT_ID AND AD.APP_ID=BD.APP_ID(+)");
qrysb.append(" AND MOM.OFF_NAME1 IN (SELECT OFF_NAME1 FROM MAS_OFF_MAST WHERE OFF_CD LIKE '"+OFF_CD+"')");

ResultSet rsMain = db.execSQL(qrysb.toString());

String APP_NAME ="";
String GENDER ="";
String ACT_ID="";
String ACT_DESC="";
String MOB_NO1 ="";
String DOB ="";
String IFSC_CODE ="";
String AADHAR_NO ="";
String ONLINE_SUBDT ="";
String OFF_NAME ="";
String AGENCY_TYPE ="";
String APP_ID="";
String PAN_NO="";

while(rsMain.next())
  { 
	APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
	ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");
	MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
	DOB=rsMain.getString("DOB")==null?"":rsMain.getString("DOB");
	IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
	AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
	ONLINE_SUBDT=rsMain.getString("ONLINE_SUBDT")==null?"":rsMain.getString("ONLINE_SUBDT");
	OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
	AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
	APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
	PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
  %>
            <tr>
              <td><%= AGENCY_TYPE%></td>
			
                           <td><%= OFF_NAME%></td>
                           <td><%= APP_ID%></td>
                           <td> <%= APP_NAME%></td>
                            <td><%= AADHAR_NO %></td>
                            <td><%= PAN_NO %></td>
                            <td><%= ACT_DESC%></td>
							<td><%= MOB_NO1%></td>
							<td><%= DOB%></td>
                            <td><%= ONLINE_SUBDT%></td>
                  </tr>
			<%
			}
			rsMain.close();
			db.close();
			}catch (Exception e) {out.print(e.toString());}
			%>
            
        </tbody>
    </table>
</body>
	</html>