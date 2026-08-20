<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
<title>PMEGP Online Application Registration</title>
<body  >
<%
String APP_ID= request.getParameter("appid")==null?"":(String) request.getParameter("appid");
String STATE_CD = request.getParameter("state")==null?"1":(String) request.getParameter("state");
//String vStatecd= (STATE_CD.equals("TG")||STATE_CD.equals("AP"))?"('TG','AP')":"('"+vStatecd+"')";
String AADHAR= request.getParameter("aadhar")==null?"1":(String) request.getParameter("aadhar");

String PAN_NO = request.getParameter("pan")==null?"1":(String) request.getParameter("pan");
//String APP_ID = request.getParameter("appid")==null?"":(String) request.getParameter("appid");
String UAD = request.getParameter("UAD")==null?"":(String) request.getParameter("UAD");
String DISTRICT_CD= request.getParameter("dis")==null?"":(String) request.getParameter("dis");
//out.print(UAD);
String state="";
String qrystr="";
String qrystr1="";
				String DIS_CD="";
				String DIS_NAME="";
//String DISTRICT_CD="";
String DISTRICT_NAME="";
String state_nm="";
 DBCon db= new DBCon();
db.connect();
String IFSC_CODE="";
String AADHAAR=""; 
	String BANK_NAME="";
	String  BRANCH_NAME="";


String LOAN_SANC_DT = "";
String WORKSHED_COST ="";
String WORKING_CAPITAL = "";
String MACHINARY_COST = "";
String APPID = "";
String AADHAR_NO="";



String IST_LOAN_AMT = "";
String IST_LOAN_DT = "";
String CGTSI = "";

String MM_REL_DT = "";
String AGENCY = "";
String MM_REL_AMT = "";
String PROJ_COST="";

String APPLOAN_ACCNO = "";
String FB_ACNO = "";

String TDR_ACNO = "";
String TDR_ADJ_DT = "";

String CE_SANC_FB="";
String WC_SANC_FB="";
String TOTAL_SANC_FB="";
String UTRN_NO="";
String APP_NAME="";
String UNIT_NM="";
String GSTN_NO="";




String UNIT_LOC="";
String UNIT_ADDR="";

 String UNIT_PIN="";
  String ACTIVITY_NAME="";
  String BANK_POST_ADDR="";
String BANK_DISTRICT="";
  String STATE_NM="";
  String EMP_ENV="";
 

 String BENF_CATEGORY_DESC="";

  String AGENCY_TYPE="";
 
  String MOB_NO1="";
String OFF_CD="";

  String IND_GRP_LONG_DESC="";
  String EDP_TRG_NAME="";
String UNIT_TALUK_BLOCK="";

String IND_ACTIVITY="";
String IND_TYPE="";
String E_MAIL="";
String UNIT_DIST_CD="";

String PROD_DESC="";
try {

StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT"      );
qrysb.append("       tq.*"      );
qrysb.append("      "      );
qrysb.append("   FROM"      );
qrysb.append("       ("      );
qrysb.append("           SELECT"      );
qrysb.append("               ad.app_id,"      );
qrysb.append("               ad.app_name,"      );
qrysb.append("               ad.aadhar_no,"      );
qrysb.append("               md.state_cd,"      );
qrysb.append("               ad.tel_no    AS mob_no1,"      );
qrysb.append("               ad.unit_dist_cd,"      );
qrysb.append("               mom.agency_type"      );
qrysb.append("               || '('"      );
qrysb.append("               || mom.off_name1"      );
qrysb.append("               || ')' AS agency,"      );
qrysb.append("               ms.state_nm,"      );
qrysb.append("               mom.agency_type,"      );
qrysb.append("               ad.br_code   AS ifsc_code,"      );
qrysb.append("               ad.prod_desc,"      );
qrysb.append("               ad.emp_env,"      );
qrysb.append("               ad.off_cd,"      );
qrysb.append("               ad.unit_loc,"      );
qrysb.append("               ad.unit_post_addr"      );
qrysb.append("               || ''"      );
qrysb.append("               || ad.unit_taluk_block AS unit_addr,"      );
qrysb.append("               ad.unit_taluk_block,"      );
qrysb.append("               ad.unit_pin,"      );
qrysb.append("               md.district_name,"      );
qrysb.append("               am.activity_name,"      );
qrysb.append("               ad.bank_name,"      );
qrysb.append("               ad.bank_post_addr,"      );
qrysb.append("               ad.bank_district,"      );
qrysb.append("               ad.branch_name,"      );
qrysb.append("               nvl(ad.machinary_cost, 0) AS machinary_cost,"      );
qrysb.append("               nvl(ad.working_capital, 0) AS working_capital,"      );
qrysb.append("               ad.ind_type,"      );
qrysb.append("               ad.ind_activity,"      );
qrysb.append("               igm.ind_grp_long_desc"      );
qrysb.append("           FROM"      );
qrysb.append("               pmegponline.app_detail   ad,"      );
qrysb.append("               mas_off_mast             mom,"      );
qrysb.append("               app_status_mast          asm,"      );
qrysb.append("               m_state                  ms,"      );
qrysb.append("               m_district               md,"      );
qrysb.append("               activity_mast            am,"      );
qrysb.append("               ind_grp_mast             igm"      );
qrysb.append("           WHERE"      );
qrysb.append("               ad.off_cd = mom.off_cd"      );
qrysb.append("               AND ad.act_id = asm.act_id"      );
qrysb.append("               AND ad.unit_dist_cd = md.district_cd"      );
qrysb.append("               AND md.state_cd = ms.state_cd"      );
qrysb.append("               AND ad.ind_activity = am.activity_cd"      );
qrysb.append("               AND igm.ind_grp_cd = am.ind_grp_cd"      );
qrysb.append("   AND AD.APP_ID='"+APP_ID+"' AND MD.STATE_CD IN ('"+STATE_CD+"') "      );
qrysb.append("           UNION ALL"      );
qrysb.append("           SELECT"      );
qrysb.append("               ad.app_id,"      );
qrysb.append("               upper(ad.app_name) AS app_name,"      );
qrysb.append("               ad.aadhar_no,"      );
qrysb.append("               md.state_cd,"      );
qrysb.append("               TO_CHAR(ad.mob_no1) AS mob_no1,"      );
qrysb.append("               ad.unit_dist_cd,"      );
qrysb.append("               mom.agency_type"      );
qrysb.append("               || '('"      );
qrysb.append("               || mom.off_name1"      );
qrysb.append("               || ')' AS agency,"      );
qrysb.append("               ms.state_nm,"      );
qrysb.append("               mom.agency_type,"      );
qrysb.append("               ad.ifsc_code     AS ifsc_code,"      );
qrysb.append("               ad.prod_desc,"      );
qrysb.append("               ad.emp_env,"      );
qrysb.append("               ad.off_cd,"      );
qrysb.append("               ad.unit_loc,"      );
qrysb.append("               ad.unit_post_addr"      );
qrysb.append("               || ''"      );
qrysb.append("               || ad.unit_taluk_block AS unit_addr,"      );
qrysb.append("               ad.unit_taluk_block,"      );
qrysb.append("               ad.unit_pin,"      );
qrysb.append("               md.district_name,"      );
qrysb.append("               am.activity_name,"      );
qrysb.append("               ad.bank_name,"      );
qrysb.append("               ad.bank_post_addr,"      );
qrysb.append("               ad.bank_district,"      );
qrysb.append("               ad.branch_name,"      );
qrysb.append("               nvl(ad.machinary_cost, 0) AS machinary_cost,"      );
qrysb.append("               nvl(ad.working_capital, 0) AS working_capital,"      );
qrysb.append("               ad.ind_type,"      );
qrysb.append("               ad.activity_cd   AS ind_activity,"      );
qrysb.append("               igm.ind_grp_long_desc"      );
qrysb.append("           FROM"      );
qrysb.append("               app_detail        ad,"      );
qrysb.append("               mas_off_mast      mom,"      );
qrysb.append("               app_status_mast   asm,"      );
qrysb.append("               m_state           ms,"      );
qrysb.append("               m_district        md,"      );
qrysb.append("               activity_mast     am,"      );
qrysb.append("               ind_grp_mast      igm,"      );
qrysb.append("               bank_dataentry    bd"      );
qrysb.append("           WHERE"      );
qrysb.append("               ad.off_cd = mom.off_cd"      );
qrysb.append("               AND ad.act_id = asm.act_id"      );
qrysb.append("               AND ad.unit_dist_cd = md.district_cd"      );
qrysb.append("               AND md.state_cd = ms.state_cd"      );
qrysb.append("               AND ad.activity_cd = am.activity_cd"      );
qrysb.append("               AND igm.ind_grp_cd = am.ind_grp_cd"      );
qrysb.append("               AND bd.app_id = ad.app_id"      );
qrysb.append("               AND bd.pact_id = 34"      );
qrysb.append("               AND bd.ist_loan_dt < trunc(SYSDATE) - 1095"      );
qrysb.append("   AND AD.APP_ID='"+APP_ID+"' AND MD.STATE_CD IN ('"+STATE_CD+"') "      );
qrysb.append("       ) tq"      );


ResultSet rsApp = db.execSQL(qrysb.toString());


while (rsApp.next()) {
    MACHINARY_COST=rsApp.getString("MACHINARY_COST")==null?"0":rsApp.getString("MACHINARY_COST");
	IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"0":rsApp.getString("IFSC_CODE");
	BANK_NAME=rsApp.getString("BANK_NAME")==null?"":rsApp.getString("BANK_NAME");
	BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"":rsApp.getString("BRANCH_NAME");
	WORKING_CAPITAL=rsApp.getString("WORKING_CAPITAL")==null?"0":rsApp.getString("WORKING_CAPITAL"); 
	EMP_ENV=rsApp.getString("EMP_ENV")==null?"":rsApp.getString("EMP_ENV");
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
     OFF_CD=rsApp.getString("OFF_CD")==null?"":rsApp.getString("OFF_CD");
	AGENCY=rsApp.getString("AGENCY")==null?"":rsApp.getString("AGENCY");
   PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC");
	 BANK_POST_ADDR=rsApp.getString("BANK_POST_ADDR")==null?"":rsApp.getString("BANK_POST_ADDR");
 BANK_DISTRICT=rsApp.getString("BANK_DISTRICT")==null?"":rsApp.getString("BANK_DISTRICT");
	IND_ACTIVITY=rsApp.getString("IND_ACTIVITY")==null?"":rsApp.getString("IND_ACTIVITY");
	IND_TYPE=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
	APPID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
	UNIT_ADDR=rsApp.getString("UNIT_ADDR")==null?"":rsApp.getString("UNIT_ADDR");
	OFF_CD=rsApp.getString("OFF_CD")==null?"":rsApp.getString("OFF_CD");
	UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
	
	 UNIT_PIN=rsApp.getString("UNIT_PIN")==null?"":rsApp.getString("UNIT_PIN");
   ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
   DISTRICT_NAME=rsApp.getString("DISTRICT_NAME")==null?"":rsApp.getString("DISTRICT_NAME");
   STATE_NM=rsApp.getString("STATE_NM")==null?"":rsApp.getString("STATE_NM");
 
  STATE_CD=rsApp.getString("STATE_CD")==null?"":rsApp.getString("STATE_CD");
UNIT_TALUK_BLOCK=rsApp.getString("UNIT_TALUK_BLOCK")==null?"":rsApp.getString("UNIT_TALUK_BLOCK");

   AGENCY_TYPE=rsApp.getString("AGENCY_TYPE")==null?"":rsApp.getString("AGENCY_TYPE");
 
   MOB_NO1="";
   //rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");

   IND_GRP_LONG_DESC=rsApp.getString("IND_GRP_LONG_DESC")==null?"":rsApp.getString("IND_GRP_LONG_DESC");
  UNIT_DIST_CD=rsApp.getString("UNIT_DIST_CD")==null?"":rsApp.getString("UNIT_DIST_CD");
	AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
	
	} //end of resultset	
	//END OF BANK DATA
	
	//out.print(ACT_ID);
		
	}//end of ins
	catch (Exception e) {
	
	out.print (e.toString());
	}		
%>
  <br/><br/>
  <%
  if (!AADHAR_NO.equals("")){
	  AADHAAR=AADHAR_NO;
  }
  else
  {
	  AADHAAR=AADHAR;
  }
  
  
  %>
  
  
  
  
  <% if (!APPID.equals("")){%>
  
  

<form name="form" id="form"  class="form" method="post">
<table align="center">
      
    <tr>
      <th colspan="6"><div align="center"><strong>APPLICATION DETAILS FOR PMEGP </strong></div></th>
    </tr>
    <tr>
      <th width="78"><strong>(1)</strong></th>
      <th width="389" nowrap><strong>Applicant id (if any): * </strong></th>
      <td colspan="4">  <input name="APP_ID" type="text"  id="APP_ID"  readonly="true"  value="<%=APP_ID%>" size="30" maxlength="100" ></td>
  </tr>
      <tr>
        <th><strong>(2)</strong></th>
        <th>Udyog Aadhar Registration No* </th>
        <td colspan="2"><input name="UAD" type="text"  id="UAD"  size="20" maxlength="12" value="<%=UAD%>"  /></td>
      </tr><input name="OFF_CD" type="HIDDEN"  id="OFF_CD"  size="30" maxlength="20" value="<%=OFF_CD%>"  />
	  <input name="MM_REL_AMT" type="HIDDEN"  id="MM_REL_AMT"  size="30" maxlength="20" value="<%=MM_REL_AMT%>"  />
	  <input name="MM_REL_DT" type="HIDDEN"  id="MM_REL_DT"  size="30" maxlength="20" value="<%=MM_REL_DT%>"  />
	  <input name="UTRN_NO" type="HIDDEN"  id="UTRN_NO"  size="30" maxlength="20" value="<%=UTRN_NO%>"  />
      <tr>
        <th><strong>(3)</strong></th>
        <th><strong>Name of Applicant:*(Name as Per Aadhaar Card)</strong></th>
        <td colspan="2"><input name="APP_NAME" type="text"  id="APP_NAME"   readonly="true" value="<%=APP_NAME%>" size="50" maxlength="30" onKeyPress="return RestrictSpecialChar(event);" />		</td>
        </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap>Aadhar No * </th>
        <td colspan="2"><input name="AADHAR_NO" type="text"  id="AADHAR_NO"    value="<%=AADHAAR%>" size="20" maxlength="12" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th><strong>(4)</strong></th>
        <th nowrap>State*:</th>
        <td colspan="2">
		
		
             <select name="STATE" class="button"  id="STATE" onChange="getDistrict(this.value);">
            <option value="-1">--Select State--</option>
            <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   state_nm=rs.getString("state_nm");
	   %>
            <option value="<%=state%>" <% if ( STATE_CD.equals(state)){out.print("selected");} %>><%=state_nm %></option>
            <% } 
	  rs.close();
	   %>
            </select>         		</td>
      </tr> 
	   <tr>
        <th><strong>(6)</strong></th>
        <th nowrap>Agency:* </th>
        <td colspan="2"><input name="AGENCY" type="text" id="AGENCY"  readonly="true" value="<%=AGENCY%>" size="20" maxlength="20" /></td>
      </tr>
      
      <tr>
        <th><strong>(5)</strong></th>
        <th nowrap>Mobile No:*:</th>
        <td colspan="2"><input name="MOB_NO1" type="text"  id="MOB_NO1" onKeyPress="return numbersonly(event);" value="<%=MOB_NO1%>"  size="12" maxlength="10" />         </td>
      </tr>
     
      <tr>
        <th><strong>(7)</strong></th>
        <th nowrap>Pan No:* </th>
        <td colspan="2"><input name="PAN_NO" type="text" id="PAN_NO"  value=<%=PAN_NO%> size="20" maxlength="10" /></td>
      </tr>
      <tr>
        <th><strong>(8)</strong></th>
        <th nowrap>eMail:*</th>
        <td colspan="2"> <input name="E_MAIL" type="text" id="E_MAIL" value="<%=E_MAIL%>" size="20"  maxlength="58" /></td>
      </tr>
      <tr>
        <th colspan="4" bgcolor="#CCCCCC"><div align="center"><strong>Exsisting Unit Details </strong></div></th>
      </tr>
	  <tr>
        <th><strong>(9)</strong></th>
        <th nowrap>Unit Name * </th>
        <td colspan="2"><input name="UNIT_NM" type="text" id="UNIT_NM"   size="50" maxlength="50" /></td>
      </tr>
      <tr>
        <th><strong>(10)</strong></th>
        <th nowrap>GSTN NO*: </th>
        <td colspan="2"><input name="GSTN_NO" type="text" id="GSTN_NO" size="20"  maxlength="58" /></td>
      </tr>
      
      <tr>
        <th><strong>(11)</strong></th>
        <th nowrap>Establishment Year * </th>
        <td colspan="2"><select name="ESTB_YR" class="button" id="ESTB_YR" >
          <option value="" selected>Select</option>
		  <option value="1995">1995</option>
		  <option value="1996">1996</option>
		  <option value="1997">1997</option>
		  <option value="1998">1998</option>
		  <option value="1999">1999</option>
		  <option value="2000">2000</option>
		  <option value="2001">2001</option>
		  <option value="2002">2002</option>
		  <option value="2003">2003</option>
		  <option value="2004">2004</option>
		  <option value="2005">2005</option>
          <option value="2006">2006</option>
          <option value="2007">2007</option>
          <option value="2008">2008</option>
          <option value="2009">2009</option>
          <option value="2010">2010</option>
          <option value="2011">2011</option>
          <option value="2012">2012</option>
          <option value="2013">2013</option>
          <option value="2014">2014</option>
          <option value="2015">2015</option>
          <option value="2016">2016</option>
          <option value="2017">2017</option>
		  <option value="2018">2018</option>
        </select></td>
      </tr>
      <tr>
        <th><strong>(12)</strong></th>
        <th nowrap>Location * </th>
        <td colspan="2"><select name="UNIT_LOC" class="button" id="UNIT_LOC" >
          <option value="" selected>Select</option>
          <option value="Rural"  <% if (UNIT_LOC.equals("Rural")){out.print("selected");} %> >Rural</option>
          <option value="Urban" <% if (UNIT_LOC.equals("Urban")){out.print("selected");} %>>Urban</option>
        </select> </td>
      </tr>
      
      <tr>
        <td><div align="center"><strong>(13)</strong></div></td>
        <td>Address* <strong>: </strong></td>
        <td colspan="2"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  value="<%=UNIT_ADDR%>"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Taluk/Block*</td>
        <td colspan="2"><input name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  value="<%=UNIT_TALUK_BLOCK%>" size="20" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" /></td>
      <tr>
        <td>&nbsp;</td>
        <td> District*         </td>
        <td colspan="2"><select name="DISTRICT" id ='DISTRICT' class="button">
         <option value="-1">--Select District--</option>
            <%
			
	    qrystr1="SELECT  ms.DISTRICT_CD, initCap(ms.DISTRICT_NAME) as state_nm FROM M_DISTRICT ms  where ms.STATE_CD='"+STATE_CD+"' order by ms.DISTRICT_NAME";
       ResultSet rs1 = db.execSQL(qrystr1);
	   while(rs1.next()){ 
	   DIS_CD=rs1.getString("DISTRICT_CD");
	   DIS_NAME=rs1.getString("state_nm");
	   %>
            <option value="<%=DIS_CD%>" <% if (DIS_CD.equals(UNIT_DIST_CD)){out.print("selected");} %>><%=DIS_NAME %></option>
            <% } 
	  rs1.close();
	   %>
	   
	   </select></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Pin*</td>
        <td colspan="2"><input name="UNIT_PIN"  value="<%=UNIT_PIN%>"  type="text" id="UNIT_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
	  <tr>
        <th><strong>(14)</strong></th>
        <th nowrap><strong>Type of Activity  : * </strong></th>
        <td colspan="4"><select name="IND_TYPE" class="button" id="IND_TYPE" >
        <option value="" selected>-Select-</option>
        <option value="M"  <% if (IND_TYPE.equals("M")){out.print("selected");} %> >Manufacturing</option>
        <option value="S"  <% if (IND_TYPE.equals("S")){out.print("selected");} %> >Service</option>
		<option value="T"  <% if (IND_TYPE.equals("T")){out.print("selected");} %> >Trading</option>

        </select><input name="btnActList" type="button" class="button" id="btnActList"  onClick="activity_M();"  value="Select Industry / Activity" /></td>
      </tr>
      <tr>
        <th><strong>(15)</strong></th>
        <th nowrap>Industry / Activity Name *: <strong>
          <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=IND_ACTIVITY%>" />
        </strong></th>
        <td colspan="4"><input name="Activity_desc" type="text" id="Activity_desc"  style="background-color: #FFCCCC" value="<%=IND_GRP_LONG_DESC%>" size="60" readonly="true" /></td>
      </tr>
      <tr>
        <td><div align="center"><strong>(16)</strong></div></td>
        <td>Product Description: </td>
        <td colspan="2"><input name="PROD_DESC" type="text" id="PROD_DESC"  value="<%=PROD_DESC%>"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>     

      <tr>
        <th colspan="6" bgcolor="#CCCCCC"><div align="center"><strong>Sanction Details </strong></div></th>
      </tr>
      <tr>
        <th><strong>(17)</strong></th>
        <th nowrap> Financing Bank*: 
          <input name="b1" type="hidden" id="b1" size="1" maxlength="1" ></th>
        <td colspan="4">
		<select name="BANK_NAME"  id="BANK_NAME" >
             <option value="-1" >-Select Bank Name-</option>
            <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM pmegponline.rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd(+)  ORDER BY BANK_NAME");
	   while(rs.next()){ 
	   %>
            <option value="<%=rs.getString("BANK_NAME")%>" <% if (BANK_NAME.equals(rs.getString("BANK_NAME"))){out.print("selected");} %>><%=rs.getString("BANK_NAME")%></option>
	        
      <% } 
	  rs.close();
	    
	   %>	</select>   </td>
	  </tr>
      <tr>
        <td>&nbsp;</td>
        <td>IFS/Bank Code*: </td>
        <td colspan="4"><input name="IFSC_CODE" type="text" id="IFSC_CODE"  value="<%=IFSC_CODE%>" style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <input name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td><input name="FLAG" type="hidden" id="FLAG" value="3"><input name="SCHEME" type="hidden" id="SCHEME" value="PMEGP">
        <td>Branch Name*: </td>
        <td colspan="4"><input name="BRANCH_NAME" type="text" id="BRANCH_NAME"  value="<%=BRANCH_NAME%>"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Address*:</td>
        <td colspan="4"><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR"  onKeyPress="return RestrictSpecialChar(event);" value="<%=BANK_POST_ADDR%>" size="70" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>District:</td>
        <td colspan="4"><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" onKeyPress="return RestrictSpecialChar(event);" value="<%=BANK_DISTRICT%>" size="30" maxlength="25" /></td>
      </tr>
      <tr>
        <td><div align="center"><strong>(18)</strong></div></td>
        <th>Loan Sanction Date :*</th>
        <th colspan="4" nowrap><input type="text"  id="IST_LOAN_DT" name="IST_LOAN_DT" value=""  placeholder="DD-MON-YYYY" size="11" maxlength="11" ></th>
      </tr>
      <tr>
        <td><div align="center"><strong>(19)</strong></div></td>
        <th>Loan Sanction Details :* </th>
        <th nowrap> <div align="center">Capital Expenditure</div></th>
        <th nowrap><div align="center">Working Capital</div></th>
        <th colspan="2" nowrap><div align="center">Employement</div>
            <div align="center"></div></th>
      </tr>
      <tr>
        <td><div align="center"></div></td>
        <td>&nbsp;</td>
        <td nowrap><div align="center">
          <input name="CE_SANC_FB" type="text" id="CE_SANC_FB" value="<%=MACHINARY_COST%>" onKeyPress="return numbersonly(event);"  size="8" maxlength="7" />
        </div></td>
        <td nowrap><div align="center">
          <input name="WC_SANC_FB" type="text" id="WC_SANC_FB" value="<%=WORKING_CAPITAL%>" onKeyPress="return numbersonly(event);" size="8" maxlength="7" />
        </div></td>
        <td colspan="2" nowrap><div align="center">
          <input name="EMP_ENV" type="text" id="EMP_ENV"  value="<%=EMP_ENV%>" onKeyPress="return numbersonly(event);" size="8" maxlength="7" />
        </div></td>
      </tr>
      <tr>
      <td><div align="center"><strong>(20)</strong></div></td>
      <th>Date of Complete Repayment:* </th>
      <td colspan="2"><div align="center">
        <input type="text"  id="REPAY_DT" name="REPAY_DT" value="" placeholder="DD-MON-YYYY" size="11" maxlength="11">
      </div></td>
      <th>Repayment Amount*: </th>
      <td><input name="REPAY_AMT" type="text" id="REPAY_AMT" onKeyPress="return numbersonly(event);"  size="8" maxlength="7" /></td>
    </tr>
      
      <tr>
        <td colspan="8">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="8">
          <div align="center">&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="Button" type="button" class="button"  onClick="getfrequenttab(3);" value="Save Applicant Data" />
           </div></td></tr>
			</table>
			
  <% } else {%>
  
  
  <table>
	<tr>	
	<h1 align="center">No Records Found</h1>
	</tr>
	
	 <%}
  db.close();
   %>	
</table>
			
</body>
			</html>