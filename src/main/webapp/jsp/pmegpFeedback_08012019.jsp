<%@ include file="appIncludeHeaderPage.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>

<script>
function form_submit(){
document.form.ins.value='I'; 
	document.form.submit();
}
 $(document).ready(function(){
$('#SATISFY_YN').change(function () {
   
    if ($(this).val() == "N") {
    $('.showother').show();
    } else {
            $('.showother').hide();
    }
   
});});

$(document).ready(function(){
                var EDP_TRG_NAME = document.form.EDP_TRG_NAME.value; 
 if (EDP_TRG_NAME != "") 
				{
				$('#EDP').show() ;}

else
				{
					
					 $('#EDP').hide() ;
				
				}
					
					});

	</script>


</head>
<body>
 <form name="form" id="form"  class="form" method="post">
	    <%
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		String PASSWRD="";
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		List values=new ArrayList();
        List pstm=new ArrayList();
		
        StringBuffer qrysb = new StringBuffer();
qrysb.append("   SELECT BD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.MOB_NO1, AD.MOB_NO2,MOM.OFF_NAME1,"      );
qrysb.append("    CASE"      );
qrysb.append("    WHEN  AD.IND_TYPE='S'  "      );
qrysb.append("    THEN 'Service' "      );
qrysb.append("    ELSE 'Manufacturing' "      );
qrysb.append("    END IND_TYPE, "      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     AD.PAN_NO,"      );
qrysb.append("     AM.ACTIVITY_NAME, NVL(AD.WORKING_CAPITAL, 0) AS WC,  NVL(AD.MACHINARY_COST, 0) AS CE,BD.MM_REL_AMT, "      );
qrysb.append("     NVL(AD.WORKING_CAPITAL, 0)+  NVL(AD.MACHINARY_COST, 0) AS PROP_COST,"      );
qrysb.append("    NVL(BD.CE_SANC_FB, 0)       +  NVL(BD.WC_SANC_FB, 0)  AS SANC_COST, "      );
qrysb.append("     MS.STATE_NM,"      );
qrysb.append("     EM.EDU_DESC,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     BCM.BENF_CATEGORY_DESC,"      );
qrysb.append("     AD.BANK_NAME,"      );
qrysb.append("     AD.BANK_POST_ADDR,"      );
qrysb.append("     AD.GENDER,"      );
qrysb.append("     AD.UNIT_POST_ADDR,"      );
qrysb.append("     AD.UNIT_LOC,BD.EDP_TRG_NAME,TO_CHAR(TRUNC(TO_DATE(BD.MM_REL_DT)),'DD-MON-RRRR') AS MM_REL_DT  "      );
qrysb.append("     FROM APP_DETAIL AD, BANK_DATAENTRY BD ,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     APP_STATUS_MAST ASM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     EDUCATION_MAST EM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM"      );
qrysb.append("   WHERE MD.DISTRICT_CD     = AD.UNIT_DIST_CD AND AD.APP_ID=BD.APP_ID"      );
qrysb.append("   AND ASM.ACT_ID           = AD.ACT_ID"      );
qrysb.append("   AND AD.OFF_CD           = MOM.OFF_CD"      );
qrysb.append("   AND EM.EDU_ID            = AD.EDU_ID"      );
qrysb.append("   AND BCM.BENF_CATEGORY_CD = AD.BENF_CATAGORY_CD"      );
qrysb.append("   AND MD.STATE_CD          = MS.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD       = AD.ACTIVITY_CD"      );
qrysb.append("   AND BD.APP_ID           = '"+APP_ID+"' AND BD.PACT_ID=34 "      );



		ResultSet rsMain = db.execSQL(qrysb.toString());
		values.clear();
        pstm.clear(); 
		//out.print (qrysb.toString());
		
String APP_NAME="";
//String APP_ID="";
String UNIT_POST_ADDR="";
String MOB_NO1="";
String IND_TYPE="";
String BENF_CATEGORY_DESC="";
String AADHAR_NO="";
String SANC_COST="";
String ACTIVITY_NAME="";
String DISTRICT_NAME="";
String PROPOSED_PROJ_COST="";
String AGENCY_TYPE="";
String UNIT_LOC="";
String BANK_NAME="";
String BANK_POST_ADDR="";
String STATE_NM="";
String EDU_DESC="";
String GENDER="";
String EDP_TRG_NAME="";
String ONLINE_VIEW="";
String REC_SMS_YN="";
String GUI_AGENCY="";
String EDP_YN="";
String EDP_RATE="";
String TDR_DETAIL="";
String PMEGP_BENF="";
String PMEGP_REM="";
String FEEDBACK="";
String SATISFY_YN="";
String SATISFY_RM="";
String LAND_DETAIL="";
String WORKSHED_DETAIL="";
String MACHINERY_DETAIL="";
String COMMN_PROD="";
String MM_REL_DT="";
String MM_REL_AMT="";
String WC="";
String CE="";
String OFF_NAME1="";
String MOB_NO2="";
String PAN_NO="";
String RECAVL="N";

	
  while(rsMain.next())
  {			
   RECAVL="Y";
	  APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");	
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	  AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
	  UNIT_POST_ADDR=rsMain.getString("UNIT_POST_ADDR")==null?"":rsMain.getString("UNIT_POST_ADDR");
	  MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
	  AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
	  IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
	  ACTIVITY_NAME=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
	  BENF_CATEGORY_DESC=rsMain.getString("BENF_CATEGORY_DESC")==null?"":rsMain.getString("BENF_CATEGORY_DESC");
	  UNIT_LOC=rsMain.getString("UNIT_LOC")==null?"":rsMain.getString("UNIT_LOC");
	  BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
	  BANK_POST_ADDR=rsMain.getString("BANK_POST_ADDR")==null?"":rsMain.getString("BANK_POST_ADDR");	  
	  STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
	  DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");	
	  PROPOSED_PROJ_COST=rsMain.getString("PROP_COST")==null?"":rsMain.getString("PROP_COST");	
	  SANC_COST=rsMain.getString("SANC_COST")==null?"":rsMain.getString("SANC_COST");
      EDU_DESC=rsMain.getString("EDU_DESC")==null?"":rsMain.getString("EDU_DESC");	  
	  GENDER=rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");	
      EDP_TRG_NAME=rsMain.getString("EDP_TRG_NAME")==null?"":rsMain.getString("EDP_TRG_NAME");		
	  MM_REL_DT= rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");	
	  MM_REL_AMT= rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
	  CE= rsMain.getString("CE")==null?"":rsMain.getString("CE");
	  WC = rsMain.getString("WC")==null?"":rsMain.getString("WC");
	  OFF_NAME1 = rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
	   MOB_NO2= rsMain.getString("MOB_NO2")==null?"":rsMain.getString("MOB_NO2");
	   PAN_NO= rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
	}
			rsMain.close();
			
			 ResultSet rsEdu = db.execSQL("SELECT COUNT(*) FROM PMEGPNEW_FEEDBACK_ONLINE  WHERE APP_ID='"+APP_ID+"' ");
			  String rcount="0";
		 while (rsEdu.next()) {
		 rcount=rsEdu.getString(1)==null?"0":rsEdu.getString(1);
		 }
		 rsEdu.close();
		 
		 if (rcount.equals("0")) {
			
	
		 if  (RECAVL.equals("Y")) { 
        %>

        <table align="center">
  <tr>
    <th colspan="5" class="mtextarea"><div align="center">Note: Feedback form is only for those applicants whose Margin Money (Govt. Subsidy) has been released </div></th>
  <tr bgcolor="#FF9E5E" >
    <td colspan="5">Feedback/Verification Form For PMEGP Benificiares</td>
  </tr>

  <tr><input name="ins" type="hidden" id="ins" value="">
    <th>1  
      <th><div align="left">Name</div></th>
        <th><%= APP_NAME%></th>
        <th>(2) Applicant ID </th>
        <th><%= APP_ID%></th>
  </tr>
  <tr>
    <th>3<th><div align="left">Address</div></th>
        <th colspan="3"><%=UNIT_POST_ADDR %></th>
  </tr>
  <tr>
    <th>4 (A) 
      <th>Aadhar Card No /</th>
        <th><%=AADHAR_NO %></th>
        <th>4(B) PAN NO </th>
        <th><%=PAN_NO%></th>
  </tr>
  <tr>
    <th>5 (A) 
      <th><p>Mobile  No1</p>
            </th>
        <th><%=MOB_NO1 %></th>
        <th>5 (B) Mobile No2(Alternative No) </th>
        <th><%=MOB_NO2%></th>
  </tr>
  <tr>
    <th>6  
      <th><p>Sponsoring Agency</p>
            </th>
        <th><%=AGENCY_TYPE %></th>
        <th>Office Name: </th>
        <th><%=OFF_NAME1%></th>
  </tr>
  <tr>
    <th>7  
      <th>District:</th>
        <th><%=DISTRICT_NAME %></th>
        <th>(8) State</th>
        <th><%=STATE_NM %></th>
  </tr>
  <tr>
    <th>9  
      <th>Gender</th>
        <th><%= GENDER%></th>
        <th>(10) Qualification:</th>
        <th><%= EDU_DESC%></th>
  </tr>
  <tr>
    <th>11  
      <th>Social Category </th>
        <th><%= BENF_CATEGORY_DESC%></th>
        <th>Special Category: </th>
        <th>&nbsp;</th>
  </tr>
  <tr>
    <th>12  
      <th><p>Name of the project</p>
            </th>
        <th colspan="3"><%=ACTIVITY_NAME %></th>
  </tr>
  <tr>
    <th>&nbsp; 13 <th><p>Status of the Unit </p>
          <p>&nbsp;</p></th>
      <td colspan="3"><table width="500" height="117"  border="2" cellpadding="0" cellspacing="0">
        <tr>
          <th width="28%"><p align="center">Whether land purchased/leased for the unit </p>
            </th>
          <th width="18%"><div align="center">Whether workshed set up </div></th>
          <th width="24%"><div align="center">Whether machinery purchased </div></th>
          <th width="30%"><div align="center">Likely date of commencement of production</div></th>
          </tr>
        <tr>
          <td height="50"><div align="center">
            <select name="LAND_DETAIL" id="LAND_DETAIL" size="1">
                <option value="Y" selected>Yes</option>
                <option value="N">No</option>
            </select>
          </div></td>
          <td><div align="center">
            <select name="WORKSHED_DETAIL" id="WORKSHED_DETAIL" size="1">
                <option value="Y" selected>Yes</option>
                <option value="N">No</option>
            </select>
          </div></td>
          <td><div align="center">
            <select name="MACHINERY_DETAIL" id="MACHINERY_DETAIL" size="1">
                <option value="Y" selected>Yes</option>
                <option value="N">No</option>
            </select>
          </div></td>
          <td><div align="center">
            <select name="COMMN_PROD" id="COMMN_PROD"  size="1">
                <option value="THR" selected>3 Months</option>
                <option value="SIX">6 Months</option>
                <option value="ONE">1 Year</option>
                <option value="TWO">2 and more year</option>
            </select>
          </div></td>
          </tr>
      </table></td>
  </tr>
  <tr>
    <th rowspan="2">14<th rowspan="2"><p>Project Cost </p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>Loan Released </p></th>
      <th colspan="3">
        <table width="500" border="1" cellspacing="0" cellpadding="0">
          <tr>
            <td width="231">Proposed in the application (in Rs.) </td>
            <td width="257"><div align="center">Sanctioned by Bank (in Rs.) </div></td>
          </tr>
          <tr>
            <td><div align="center"><%=PROPOSED_PROJ_COST %></div></td>
            <td><div align="center"><%=SANC_COST%></div></td>
          </tr>
        </table></th>
  </tr>
  <tr>
    <th colspan="3">     <table width="500" border="1" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="2"><div align="center">Amount of Loan ( In Rs.) </div></td>
        </tr>
      <tr>
        <td width="250">Capital Expenditure</td>
        <td width="238"><%=CE%></td>
      </tr>
      <tr>
        <td>Working Capital </td>
        <td><%=WC %></td>
      </tr>
      <tr>
        <td>Margin Money Subsidy Amount </td>
        <td><%=MM_REL_AMT %></td>
      </tr>
      <tr>
        <td>Margin Money Release Date </td>
        <td><%=MM_REL_DT %></td>
      </tr>
    </table></th>
  </tr>
  <tr>
    <th>15(a)
    <th>Your views about the new online system 
        </th>
      <td colspan="3"><p>
        <select name="ONLINE_VIEW" id="ONLINE_VIEW">
            <option value="EX" selected>Excellent</option>
            <option value="VG">V.Good</option>
            <option value="GD">Good</option>
            <option value="FA">Fair</option>
            <option value="US">Unsatisfactory</option>
            <option value="HU">Highly Unsatisfactory</option>
        </select>
      </p>
      </td>
  </tr>
  <tr>
    <th>15(b)  
    <th>Whether you have received SMS alerts </th>
    <td colspan="3"><select name="REC_SMS_YN" id="REC_SMS_YN" size="1">
      <option value="Y" selected>Yes</option>
      <option value="N">No</option>
    </select></td>
  </tr>
  <tr>
    <th>16
    <th><p>Guidance provided by implementing agency</p>
          </th>
      <td colspan="3"><select name="GUI_AGENCY" size="1" id="GUI_AGENCY">
          <option value="EX" selected>Excellent</option>
          <option value="VG">V.Good</option>
          <option value="GD">Good</option>
          <option value="FA">Fair</option>
          <option value="US">Unsatisfactory</option>
          <option value="HU">Highly Unsatisfactory</option>
      </select></td>
  </tr>
  <tr>
    <th>17
<th><p>Whether undertaken EDP</p>
        </th>
      <td colspan="3"><p>
        <select name="EDP_YN" id="EDP_YN" size="1">
            <option value="Y" selected>Yes</option>
            <option value="N">No</option>
        </select>
      </p>
	  <div id="EDP" style="display:none">
      <p>&nbsp;</p>
      <p>Name of the Training Center: <%=EDP_TRG_NAME %></p></div></td>
  </tr>
  <tr>
    <th>18
    <th>Rate the EDP </th>
      <td colspan="3"><select name="EDP_RATE" size="1" id="EDP_RATE">
          <option value="EX" selected>Excellent</option>
          <option value="VG">V.Good</option>
          <option value="GD">Good</option>
          <option value="FA">Fair</option>
          <option value="US">Unsatisfactory</option>
          <option value="HU">Highly Unsatisfactory</option>
      </select></td>
  </tr>
  <tr>
    <th>19
    <th><div align="left">
        <p>Whether margin money subsidy deposited in your TDR account by the Financing bank </p>
        </div></th>
        <td colspan="3"><select name="TDR_DETAIL" id="TDR_DETAIL"  size="1">
          <option value="Y" selected>Yes</option>
          <option value="N">No</option>
        </select></td>
  </tr>
  <tr>
    <th>20
    <th><p>Introduction of Online System has benefited PMEGP beneficiary </p>
          </th>
      <td colspan="3"><select name="PMEGP_BENF" id="PMEGP_BENF"  size="1">
          <option value="A" selected>Agree</option>
          <option value="D">Disagree</option>
            </select></td>
  </tr>
  <tr>
    <th>21
    <th><p>Any other suggestion/feedback about PMEGP Online System/PMEGP scheme </p></th>
      <td colspan="3"><textarea name="FEEDBACK" cols="60" rows="4" id="FEEDBACK"></textarea></td>
  </tr> <input name="EDP_TRG_NAME" type="hidden" id="EDP_TRG_NAME"  value="<%=EDP_TRG_NAME%>" size="20" maxlength="50">
  <tr>
    <th>22
    <th><p>Whether you are satisfied with the overall benefit received in the scheme.</p>
            <p>&nbsp;</p>
            <p>if no, reasons for dissatisfaction.</p></th>
        <td colspan="3"><p>
            <select name="SATISFY_YN" size="1" id="SATISFY_YN">
              <option value="Y" selected>Yes</option>
              <option value="N">No</option>
            </select>
          </p>
            <p><div id="Other" class="showother" style="display:none">
              <input name="SATISFY_RM" type="text" id="SATISFY_RM" value="" size="60" maxlength="100"></div>
</p></td>
  </tr>
  <tr>
    <td colspan="5">
  </tr>
  <tr>
    <th colspan="5"><div align="center">
          <input name="btnClose" type="button" class="button" id="btnClose" value="Submit FeedBack Form"onClick="form_submit();">
    </div></th>
  </tr>
        </table>
        <div align="center">
          <%
			try {
     
			if (ins.equals("I")) {	
 ONLINE_VIEW=request.getParameter("ONLINE_VIEW")==null?"":request.getParameter("ONLINE_VIEW");
 REC_SMS_YN=request.getParameter("REC_SMS_YN")==null?"":request.getParameter("REC_SMS_YN");
 GUI_AGENCY=request.getParameter("GUI_AGENCY")==null?"":request.getParameter("GUI_AGENCY");
 EDP_YN=request.getParameter("EDP_YN")==null?"":request.getParameter("EDP_YN");
 EDP_RATE=request.getParameter("EDP_RATE")==null?"":request.getParameter("EDP_RATE");
 TDR_DETAIL=request.getParameter("TDR_DETAIL")==null?"":request.getParameter("TDR_DETAIL");
 PMEGP_BENF=request.getParameter("PMEGP_BENF")==null?"":request.getParameter("PMEGP_BENF");
 PMEGP_REM=request.getParameter("PMEGP_REM")==null?"":request.getParameter("PMEGP_REM");
 FEEDBACK=request.getParameter("FEEDBACK")==null?"":request.getParameter("FEEDBACK");
 SATISFY_YN=request.getParameter("SATISFY_YN")==null?"":request.getParameter("SATISFY_YN");
 SATISFY_RM=request.getParameter("SATISFY_RM")==null?"":request.getParameter("SATISFY_RM");
 LAND_DETAIL=request.getParameter("LAND_DETAIL")==null?"":request.getParameter("LAND_DETAIL");
 WORKSHED_DETAIL=request.getParameter("WORKSHED_DETAIL")==null?"":request.getParameter("WORKSHED_DETAIL");
 MACHINERY_DETAIL=request.getParameter("MACHINERY_DETAIL")==null?"":request.getParameter("MACHINERY_DETAIL");
 COMMN_PROD=request.getParameter("COMMN_PROD")==null?"":request.getParameter("COMMN_PROD");

    StringBuffer sb= new StringBuffer();
		
		 
		
		
       if (rcount.equals("0"))
	   
	 {
	 sb.append("     INSERT INTO PMEGPNEW_FEEDBACK_ONLINE  ");
	    sb.append("     (ONLINE_VIEW, REC_SMS_YN , GUI_AGENCY , EDP_YN, EDP_RATE, TDR_DETAIL, ");
		sb.append("     PMEGP_BENF, PMEGP_REM , FEEDBACK, SATISFY_YN, SATISFY_RM,LAND_DETAIL, ");
		sb.append("     WORKSHED_DETAIL,MACHINERY_DETAIL,COMMN_PROD,PASSWRD,APP_ID ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)   ");
	 }
	 else{
		sb.append("     UPDATE PMEGPNEW_FEEDBACK_ONLINE SET  ");
		sb.append("     ONLINE_VIEW=?, REC_SMS_YN=? , GUI_AGENCY =?, EDP_YN=?, EDP_RATE =?, TDR_DETAIL=?, ");
		sb.append("     PMEGP_BENF=?, PMEGP_REM=? , FEEDBACK =?, SATISFY_YN=?, SATISFY_RM =? ,LAND_DETAIL=?, ");
		sb.append("     WORKSHED_DETAIL=?,MACHINERY_DETAIL=?,COMMN_PROD=?,PASSWRD=?  WHERE APP_ID=?   ");
		}
		db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		values.add (ONLINE_VIEW);pstm.add ("D");			
		values.add (REC_SMS_YN);pstm.add ("D"); 
		values.add (GUI_AGENCY);pstm.add ("D");		
        values.add (EDP_YN);pstm.add ("D");		
		values.add (EDP_RATE);pstm.add ("D");		
		values.add (TDR_DETAIL);pstm.add ("D");		
		values.add (PMEGP_BENF);pstm.add ("D");		
		values.add (PMEGP_REM);pstm.add ("D");		
		values.add (FEEDBACK);pstm.add ("D");		
		values.add (SATISFY_YN);pstm.add ("D");		
		values.add (SATISFY_RM);pstm.add ("D");	
		values.add (LAND_DETAIL);pstm.add ("D");	
		values.add (WORKSHED_DETAIL);pstm.add ("D");	
		values.add (MACHINERY_DETAIL);pstm.add ("D");	
		values.add (COMMN_PROD);pstm.add ("D");	
		values.add (PASSWRD);pstm.add ("D");	
		values.add (APP_ID);pstm.add ("D");         
		db.executeUpdate();		
		values.clear();
        pstm.clear();		
		
			}
		
		}
		catch (Exception e) {
		out.print (e.toString());
		}
		
		}//end of if
		
		}//end of recount
		else{
		%>
        <center>  <span class="mtextarea"> Feedback form successfully submitted and thanks for your valuable feedback</span></center>
		
		  <%
		}
		 db.close();
			%>


	
          </table>    
        </div>
</form>
</body>
</html>