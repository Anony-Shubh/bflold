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

<script language="javascript">

</script>




<%
 DBCon db= new DBCon();
db.connect();
String SESSION_ID =(String) request.getParameter("SESSION_ID")==null?"0":(String) request.getParameter("SESSION_ID").trim();
//out.print(SESSION_ID);
String UAD ="";
String APP_NAME= "";
String STATE_CD="";
String AADHAR_NO="";
String UNIT_LOC = "";
String UNIT_POST_ADDR = "";
String UNIT_TALUK_BLOCK = "";
String UNIT_DIST_CD = "";
String UNIT_PIN = "";
String GENDER = "";
String MOB_NO1 = "";
String PROD_DESC = "";
String IFSC_CODE = "";
String E_MAIL = "";
String BANK_NAME = "";
String BANK_POST_ADDR = "";
String BANK_TALUK_BLOCK = "";
String BANK_PINCD = "";
String BRANCH_NAME = "";
String BANK_DISTRICT = "";
String GSTN_NO="";
String PAN_NO="";
String DISTRICT_NAME="";
String BLDG_TYPE = "";

String PRE_OPE_EXP = "";




String BENF_TYPE_CD = "";
String BENF_TYPE_DESC="";
String BENF_CATAGORY_CD = "";

String DOB = "";
ResultSet rsRd = db.execSQL("SELECT A.APP_NAME, A.UNIT_DIST_CD, A.E_MAIL, A.STATE_CD, A.UNIT_ADDR, A.UNIT_TALUK_BLOCK, A.UNIT_PIN, A.MOB_NO1, A.AADHAR_NO, A.PAN_NO, A.IFSC_CODE, A.BANK_NAME, A.BANK_POST_ADDR, A.BRANCH_NAME, A.BANK_DISTRICT, A.GSTN_NO, A.UAD,MD.DISTRICT_NAME FROM APP_SEC_LOAN a,M_DISTRICT MD WHERE A.UNIT_DIST_CD=MD.DISTRICT_CD AND SECL_ID='"+SESSION_ID+"'  ");
		
		while (rsRd.next()){
		  APP_NAME=rsRd.getString("APP_NAME")==null?"":rsRd.getString("APP_NAME");
		  STATE_CD=rsRd.getString("STATE_CD")==null?"":rsRd.getString("STATE_CD");
		  AADHAR_NO=rsRd.getString("AADHAR_NO")==null?"":rsRd.getString("AADHAR_NO");
		  UAD=rsRd.getString("UAD")==null?"":rsRd.getString("UAD");	
		  
          UNIT_POST_ADDR=rsRd.getString("UNIT_ADDR")==null?"":rsRd.getString("UNIT_ADDR");
		  UNIT_TALUK_BLOCK=rsRd.getString("UNIT_TALUK_BLOCK")==null?"":rsRd.getString("UNIT_TALUK_BLOCK");
		  UNIT_PIN=rsRd.getString("UNIT_PIN")==null?"":rsRd.getString("UNIT_PIN");
		  PAN_NO=rsRd.getString("PAN_NO")==null?"":rsRd.getString("PAN_NO");	
		  UNIT_DIST_CD=rsRd.getString("UNIT_DIST_CD")==null?"":rsRd.getString("UNIT_DIST_CD");	
		  IFSC_CODE=rsRd.getString("IFSC_CODE")==null?"":rsRd.getString("IFSC_CODE");
		  BANK_NAME=rsRd.getString("BANK_NAME")==null?"":rsRd.getString("BANK_NAME");
		  BANK_POST_ADDR=rsRd.getString("BANK_POST_ADDR")==null?"":rsRd.getString("BANK_POST_ADDR");
		  BRANCH_NAME=rsRd.getString("BRANCH_NAME")==null?"":rsRd.getString("BRANCH_NAME");	
		  
	       BANK_DISTRICT=rsRd.getString("BANK_DISTRICT")==null?"":rsRd.getString("BANK_DISTRICT");
		  GSTN_NO=rsRd.getString("GSTN_NO")==null?"":rsRd.getString("GSTN_NO");
		 MOB_NO1=rsRd.getString("MOB_NO1")==null?"":rsRd.getString("MOB_NO1");
E_MAIL=rsRd.getString("E_MAIL")==null?"":rsRd.getString("E_MAIL");
DISTRICT_NAME=rsRd.getString("DISTRICT_NAME")==null?"":rsRd.getString("DISTRICT_NAME");
		  
		}
		rsRd.close();

//out.print(APP_NAME);
//out.print(STATE_CD);
//out.print(AADHAR_NO);
//out.print(UAD);


String state="";
String qrystr="";
String Agency=""; 
String qrystr1="";


String APP_ID = "";
String vOffcd= "";
String vOrgCD= "";
String vState= "";
String cmbSel="";
String Org ="";
String IdPrix="";
String  vMaxID="";
String OFF_CD = "";
String APP_PRIX = "";


String WORKSHED_COST = "";
String MACHINARY_COST = "";

String WORKING_CAPITAL = "";
String EMP_ENV = "";

String BANK_DIST_CD = "";
String MTG_ID = "";

String TIME_STAMP = "";
String APP_REC_DATE = "";
String ACT_ID = "-1";
String BANK_F_DATE = "";
String REMARKS = "";
String IND_TYPE = "";
String ACTIVITY_CD = "";


String MOB_NO2 = "";
String IFSC_CODE2 = "";
String ONLINE_SUBDT = "";
String EDP_INST_ADDR = "";

String FH_NAME="";

String UNIT_ESTB_YR="";



String APP_PWD="";
String BENF_SPECAT_CD="";

//EXTRA CALCULATED

String Activity_desc="";
String TOTAL_PRJ="";
String ORG_CD="";
String STATE="";
String AGE="";

 List values=new ArrayList();
 
	%>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>

<body>
<%!
 public String getDate(String str){
 str=str.trim();
SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yyyy");
try{
     Date date = sdfSource.parse(str);
	 
     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
	  str=sdfDestination.format(date);
	  }catch(Exception e){}
	 return(str); 
	 
}
 %>



<form name="form" id="form"  class="form" method="post">

<table>

<tr>
  <td>
    <table class="CSSTableGenerator">
      
    <tr bgcolor="#D1A476">
      <td colspan="6">
        <div align="center" class="style1">
          <h3>ONLINE APPLICATION  FOR SECOND LOAN SUBSIDY FOR UPGRADING OF EXISTING UNIT </h3>
        </div></td>
      </tr>
      
      <tr>
        <th width="44">(1)</th>
        <th width="298" nowrap><strong>Udyog Aadhar Registration No*: </strong></th>
        <td colspan="4">  <input name="UAD" type="text" class="aadharimg"  value="<%=UAD%>"  id="UAD" onKeyPress="return numbersonly(event);" size="20" maxlength="20" /></td>
        </tr>
      <tr>
        <th>(2)</th>
        <th><strong>Name of Applicant:*</strong></th>
        <td colspan="4"><select name="APP_PRIX" id="APP_PRIX">
          <option value="">-Select-</option>
          <option value="Shri">Shri</option>
          <option value="Smt.">Smt.</option>
          <option value="Kum.">Kum.</option>
          <option value="Ms.">Ms.</option>
        </select>
		<input name="SESSION_ID" type="hidden"  id="SESSION_ID"   value="<%=SESSION_ID%>" size="30">
		<input name="APP_NAME" type="text"  id="APP_NAME"   value="<%=APP_NAME%>" size="30" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" />
		(Name as Per Aadhaar Card)		</td>
        </tr>
      
      <tr>
        <th>&nbsp;</th>
        <th nowrap><strong>Aadhaar Card No*: </strong></th>
        <td colspan="4"><input name="AADHAR_NO" type="text" class="aadharimg"  value="<%=AADHAR_NO%>" id="AADHAR_NO" onKeyPress="return numbersonly(event);" size="17" maxlength="12" /></td>
      </tr>
      <tr>
        <th>(3)</th>
        <th nowrap><strong> Sponsoring Agency*:</strong></th>
        <td colspan="4"><select name="AGENCY" class="button" id="AGENCY"   onChange="showOffice(this.value);" >
          <option value ="-1" >--Select Agency --</option>
          <option value="KV">KVIC</option>
          <option value="KB">KVIB</option>
          <option value="DI">DIC</option>
          <option value="CB">COIR</option>
        </select></td>
      </tr>
      <tr>
        <th>(4)</th>
        <th nowrap>State*:</th>
        <td colspan="4">
		
		
          <select name="STATE"  class="button" id="STATE"  onBlur="showOffice(this.value);" onChange="getDistrict(this.value);">
            <option value="-1">--Select State--</option>
            <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   %>
            <option value="<%=rs.getString("state_cd")%>" <% if ( STATE_CD.equals(state)){out.print("selected");} %>><%=rs.getString("state_nm")%></option>
            <% } 
	  rs.close();
	   %>
            </select>          		</td>
      </tr>
      <tr>
        <th>(5)</th>
        <th nowrap>District*:</th>
		
		<td id ='DISTRICT' colspan="4"><select name="DISTRICT" class="button" onBlur="showOffice(this.value);copy_dist()">
        <option value="-1" >--Select District-</option>
		 <%
		 String district_nm="";
		 String district_cd="";
	    qrystr1="SELECT  ms.district_cd, initCap(ms.district_name) as state_nm FROM m_district ms where district_cd<>0  order by ms.district_name";
       ResultSet rs1 = db.execSQL(qrystr1);
	   while(rs1.next()){ 
	   district_cd=rs1.getString("district_cd");
	   district_nm=rs1.getString("state_nm");
	   %>
            <option value="<%=district_cd%>" <% if (UNIT_DIST_CD.equals(district_cd)){out.print("selected");} %>><%=district_nm%></option>
            <% } 
	  rs1.close();
	   %>
		
		
        </select></td>
      </tr>
      <tr>
        <th>(6)</th>
        <th nowrap>Sponsoring Office*: 
          <input name="OFF_CD" type="radio" disabled value="" /></th>
		
		 <td   colspan="4" id="office">To get Office Select   Agency, State and District </td>
      </tr>
      <tr>
        <th>(7)</th>
        <th nowrap><strong>Legal Type*         
        </strong></th>
        <th colspan="4">		
		INDIVIDUAL</th>
      </tr>
      <tr>
        <th>(8)</th>
        <th nowrap><strong>Gender:*</strong></th>
        <td colspan="4"><select name="GENDER" class="button" id="GENDER">
          <option value="" selected>Select</option>
          <option value ="Male">Male</option>
          <option value ="Female">Female</option>
          <option value="Transgender">Transgender</option>
        </select></td>
      </tr>
	   <tr>
    <th>(9)</th>
    <th colspan="2" nowrap><strong>Date of Birth (dd-mm-yyyy) :*</strong></th>
    <td colspan="4"><input name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" value="<%= DOB %>" />
      Age:
      <input name="AGE" type="text" id="AGE" size="5" maxlength="3" readonly="true" value="<%= AGE %>" /></td>
  </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap><strong>Social Category : *</strong></th>
        <td colspan="4"><select name="BENF_CATAGORY_CD" class="button" id="BENF_CATAGORY_CD" >
          <option value="" selected>-Social Category-</option>
          <option value="GEN">General</option>
          <option value="OBC">Other Backward Caste</option>
          <option value="SC">Scheduled Caste</option>
          <option value="ST">Scheduled Tribe</option>
          <option value="MN">Minority</option>
        </select></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap><strong>Special Category (if any): </strong></th>
        <td colspan="4"><select name="BENF_SPECAT_CD" class="button" id="BENF_SPECAT_CD" >
          <option value="">-Special Category-</option>
          <option value="NA" selected>Not Applicable</option>         
          <option value="HS" <% if (BENF_SPECAT_CD.equals("HS")){out.print("selected");}%>>Hill States</option>
          <option value="NE" <% if (BENF_SPECAT_CD.equals("NE")){out.print("selected");}%>>North East Region</option>
                        </select></td>
      </tr>
      <tr>
        <th>(9)</th>
        <th nowrap><strong>Communication Address: * </strong></th>
        <td colspan="4"><input name="APP_POST_ADDR" type="text" id="APP_POST_ADDR"  size="50" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Taluk/Block*:</td>
        <td colspan="4"><input name="APP_TALUK_BLOCK" type="text" id="APP_TALUK_BLOCK" size="50" maxlength="60" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input name="APP_DIST_CD" type="hidden" id="APP_DIST_CD" value="<%=UNIT_DIST_CD%>" />
          District*:</td>
        <td colspan="4"><input name="UNIT_DIST_NM" type="text" id="UNIT_DIST_NM" value="<%=DISTRICT_NAME%>" style="background-color: #FFCCCC"  readonly="true"  />
            <input name="btnBank" id="btnBank" type="button" class="button" onClick="changeComDistrict();"  value="Change Communication District" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Pin*:</td>
        <td colspan="4"><input name="APP_PIN" type="text" id="APP_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th nowrap>&nbsp;</th>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th nowrap>Mobile No:*:</th>
        <td colspan="4">(1)<input name="MOB_NO1" type="text" class="mob"  id="MOB_NO1"  value="<%=MOB_NO1%>" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" />
        (2)      
        <input name="MOB_NO2" type="text" class="mob"  id="MOB_NO2" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" /> </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <th nowrap>eMail*:</th>
        <td colspan="4"> <input name="E_MAIL" type="text" id="E_MAIL" value="<%=E_MAIL%>" size="20"  maxlength="58" /></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap>PAN NO: </th>
        <td colspan="4"><input name="PAN_NO" type="text" id="PAN_NO"  value="<%=PAN_NO%>"  size="20" maxlength="10" /></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <th nowrap>Previous Unit Establishment Year *: </th>
        <td colspan="4"> <input type="text"  id="UNIT_ESTB_YR" name="UNIT_ESTB_YR" value="<%=UNIT_ESTB_YR%>" onClick="javascript:NewCssCal('UNIT_ESTB_YR','ddMMMyyyy')" placeholder="DD-MON-YYYY"  size="11" maxlength="11"></td>
      </tr>
      <tr>
        <th>(10)</th>
        <th nowrap>New Unit Location *: </th>
        <td colspan="4"><select name="UNIT_LOC" class="button" id="UNIT_LOC" >
          <option value="">Select</option>
          <option value="Rural">Rural</option>
          <option value="Urban">Urban</option>
        </select></td>
      </tr>
      <tr>
        <th>(11)</th>
        <th nowrap><strong> Unit Address* </strong><strong>: </strong></th>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Address*</td>
        <td colspan="4"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  value="<%=UNIT_POST_ADDR%>"  size="45" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Taluk/Block*</td>
        <td colspan="4"><input name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  value="<%=UNIT_TALUK_BLOCK%>"  size="40" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td> District*
          <input name="UNIT_DIST_CD" type="hidden" id="UNIT_DIST_CD" value="<%=UNIT_DIST_CD%> " /></td>
        <td colspan="4"><input name="APP_DIST_NM" type="text" id="APP_DIST_NM"  value="<%=DISTRICT_NAME%>" style="background-color: #FFCCCC" readonly="true"  /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Pin*</td>
        <td colspan="4"><input name="UNIT_PIN" type="text" id="UNIT_PIN" value="<%=UNIT_PIN%>"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
      <tr>
        <th>(12)</th>
        <th nowrap><strong>Type of Activity  : * </strong></th>
        <td colspan="4"><select name="IND_TYPE" class="button" id="IND_TYPE" >
        <option value="" selected>-Select-</option>
        <option value="M" >Manufacturing</option>
        <option value="S" >Service</option>
		<option value="T" >Trading</option>

        </select><input name="btnActList" type="button" class="button" id="btnActList"  onClick="activity();"  value="Select Industry / Activity" /></td>
      </tr>
      <tr>
        <th>(13)</th>
        <th nowrap>Industry / Activity Name *: <strong>
          <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
        </strong></th>
        <td colspan="4"><input name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Product Description: </td>
        <td colspan="4"><input name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <th nowrap>(14)</th>
        <th nowrap><strong>Project Cost  :                    
           
            <span class="style60">            </span></strong></th>
        <th width="197" nowrap> <div align="center">Capital Expenditure</div></th>
        <th width="229" nowrap><div align="center">Working Capital</div></th>
        <th width="164" nowrap><div align="center">Total</div></th>
        <th width="" nowrap><div align="center">Employement</div></th>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>          <div align="center">
          <input name="MACHINARY_COST" type="text" id="MACHINARY_COST" onChange="proj_cal();" size="8" maxlength="7" />        
        </div></td>
        <td><div align="center">
          <input name="WORKING_CAPITAL" type="text" id="WORKING_CAPITAL"  onchange="proj_cal();" onKeyPress="return numbersonly(event);" size="8" maxlength="7" />
        </div></td>
        <td><div align="center">          
          <input name="TOTAL_PRJ" type="text" id="TOTAL_PRJ" style="background-color: #FFCCCC" value="" readonly="true"  size="8" />
          &nbsp;</div></td>
        <td><div align="center">
          <input name="EMP_ENV" type="text" id="EMP_ENV"  size="8" maxlength="3" value="" />
        </div></td>
        </tr><input name="TOTAL_CE" type="hidden" id="TOTAL_CE" style="background-color: #FFCCCC" value="" />
      <tr>
        <th>(15)</th>
        <th nowrap>1st Financing Bank*: 
          <input name="b1" type="hidden" id="b1" size="1" maxlength="1" ></th>
        <td colspan="4">
		<select name="BANK_NAME"  id="BANK_NAME" class="custom-select">
            <option value="-1" >-Select Bank Name-</option>
            <%
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd(+) AND A.ACT_YN='Y' ORDER BY BANK_NAME");
	   while(rs.next()){ 
	   %>
            <option value="<%=rs.getString("BANK_NAME")%>"  <% if (BANK_NAME.equals(rs.getString("BANK_NAME"))){out.print("selected");} %> ><%=rs.getString("BANK_NAME")%></option>
            <% } 
	  rs.close();
	   %>
          </select>        </td>
      </tr>
      <tr><input name="FLAG" type="hidden" id="FLAG" value="4">
        <td>&nbsp;</td>
        <td>IFS/Bank Code*: </td>
        <td colspan="4"><input name="IFSC_CODE" type="text" id="IFSC_CODE"  value="<%=IFSC_CODE%>" style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <input name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Branch Name*: </td>
        <td colspan="4"><input name="BRANCH_NAME" type="text" id="BRANCH_NAME" value="<%=BRANCH_NAME%>" size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Address*:</td>
        <td colspan="4"><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR"  value="<%=BANK_POST_ADDR%>" onKeyPress="return RestrictSpecialChar(event);" size="70" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      <td>District:</td>
      <td colspan="4"><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" value="<%=BANK_DISTRICT%>" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" /></td>
    </tr>
      
     <!-- <tr>
        <th>(19)</th>
        <th nowrap>Alternate Financing Bank Name </th>
        <td colspan="4">		
		<select name="BANK_NAME2"  id="BANK_NAME2"  >
          <option value="-1" selected="selected" >-Select Bank Name-</option>
         // <%
 //rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd");
	   
	  // while(rs.next()){ 
	   
	   //%>
          <option value="></option>
       
	 // rs.close();
	  // %>
        </select></td>
      </tr>
      <tr>
        <th>(20)</th>
      <th nowrap>2nd Financing Branch IFS Code <input type="hidden" name="BANK_TYPE" id="BANK_TYPE" value="1" />
        <input type="hidden" name="ins" id="ins" value="" /></th>-->
      <td colspan="4"><input name="IFSC_CODE2" type="hidden" id="IFSC_CODE2" value="" />
        <input name="btnBank2" type="hidden" class="button" id="btnBank2" onClick="ShowNewPage2();"  value="Select  Bank IFS Code" /></td>
      </tr>
      
      
      <tr>
        <td colspan="6"><input name="checkbox" type="checkbox" value="checkbox" checked>
          I hereby declare that information given above is true to the best of my knowledge. Any information to be found incorrect /false / wrong , I shall be liable for suitable Action. </td>
      </tr>
      <tr>
        <td colspan="6">
          <div align="center">&nbsp;&nbsp;&nbsp;&nbsp;
            <div align="center">
  <input name="Button" type="button" class="button"  onClick="getfrequenttab(4);" value="Save Applicant Data" />
&nbsp;&nbsp;&nbsp;&nbsp;                  </div>
            <tr>
        <td colspan="6"><div align="right">


 
          </div></td>
    </tr>
</table></td>
  
</tr>
</table>



</form>
 

</body>
</html>
