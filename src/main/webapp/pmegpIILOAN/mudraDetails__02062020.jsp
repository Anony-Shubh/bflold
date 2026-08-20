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
String STATE_CD = request.getParameter("state")==null?"1":(String) request.getParameter("state");
String AADHAR_NO = request.getParameter("aadhar")==null?"1":(String) request.getParameter("aadhar");
String PAN_NO = request.getParameter("pan")==null?"1":(String) request.getParameter("pan");
String APP_ID = request.getParameter("appid")==null?"":(String) request.getParameter("appid");
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
%>
<form name="form" id="form"  class="form" method="post">
<table align="center">
      
    <tr>
      <th colspan="6"><div align="center"><strong>APPLICATION DETAILS FOR 2nd LOAN </strong></div></th>
    </tr>
    <tr>
      <th width="78"><strong>(1)</strong></th>
      <th width="389" nowrap><strong>Applicant id (if any)*: </strong></th>
      <td colspan="4">  <input name="APP_ID" type="text"  id="APP_ID"   value="<%=APP_ID%>" size="30" maxlength="20" ></td>
  </tr>
      <tr>
        <th><strong>(2)</strong></th>
        <th>Udyog Aadhar Registration No *: </th>
        <td colspan="2"><input name="UAD" type="text"  id="UAD"  size="20" maxlength="12" value="<%=UAD%>"  /></td>
      </tr>
      <tr>
        <th><strong>(3)</strong></th>
        <th><strong>Name of Applicant:*(Name as Per Aadhaar Card)</strong></th>
        <td colspan="2"><input name="APP_NAME" type="text"  id="APP_NAME"   value="" size="30" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" />		</td>
        </tr>
      <tr>
        <th><strong>(4)</strong></th><input name="FLAG" type="hidden" id="FLAG" value="3">
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
        <th><strong>(5)</strong></th>
        <th nowrap>Mobile No:*:</th>
        <td colspan="2"><input name="MOB_NO1" type="text"   id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="12" maxlength="10" />         </td>
      </tr>
      <tr>
        <th><strong>(6)</strong></th>
        <th nowrap>Aadhar No:* </th>
        <td colspan="2"><input name="AADHAR_NO" type="text" id="AADHAR_NO"  value="<%=AADHAR_NO%>" size="20" maxlength="12" /></td>
      </tr>
      <tr>
        <th><strong>(7)</strong></th>
        <th nowrap>Pan No:* </th>
        <td colspan="2"><input name="PAN_NO" type="text" id="PAN_NO"  value=<%=PAN_NO%> size="20" maxlength="10" /></td>
      </tr>
      <tr>
        <th><strong>(8)</strong></th>
        <th nowrap>eMail*:</th>
        <td colspan="2"> <input name="E_MAIL" type="text" id="E_MAIL" size="20"  maxlength="58" /></td>
      </tr>
      <tr>
        <th colspan="4" bgcolor="#CCCCCC"><div align="center"><strong>Exsisting Unit Details </strong></div></th>
      </tr>
	  <tr>
        <th><strong>(9)</strong></th>
        <th nowrap>Unit Name* : </th>
        <td colspan="2"><input name="UNIT_NM" type="text" id="UNIT_NM"   size="50" maxlength="50" /></td>
      </tr>
      <tr>
        <th><strong>(10)</strong></th>
        <th nowrap>GSTN NO*: </th>
        <td colspan="2"><input name="GSTN_NO" type="text" id="GSTN_NO" size="20"  maxlength="15" /></td>
      </tr>
      
      <tr>
        <th><strong>(11)</strong></th>
        <th nowrap>Establishment Year*: </th>
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
        <th nowrap>Location* : </th>
        <td colspan="2"><select name="UNIT_LOC" class="button" id="UNIT_LOC" >
          <option value="" selected>Select</option>
          <option value="Rural">Rural</option>
          <option value="Urban">Urban</option>
        </select></td>
      </tr>
      
      <tr>
        <td><div align="center"><strong>(13)</strong></div></td>
        <td>Address*<strong>: </strong></td>
        <td colspan="2"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR"  size="25" maxlength="99" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Taluk/Block*</td>
        <td colspan="2"><input name="UNIT_TALUK_BLOCK" type="text" id="UNIT_TALUK_BLOCK"  size="20" maxlength="55" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
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
            <option value="<%=DIS_CD%>" <% if (DISTRICT_CD.equals(DIS_CD)){out.print("selected");} %>><%=DIS_NAME %></option>
            <% } 
	  rs1.close();
	   %>
	   </select ></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Pin*</td>
        <td colspan="2"><input name="UNIT_PIN" type="text" id="UNIT_PIN"  onkeypress="return numbersonly(event);" size="10" maxlength="6" /></td>
      </tr>
	  <tr>
        <th><strong>(14)</strong></th>
        <th nowrap><strong>Type of Activity  : * </strong></th>
        <td colspan="4"><select name="IND_TYPE" class="button" id="IND_TYPE" >
        <option value="" selected>-Select-</option>
        <option value="M" >Manufacturing</option>
        <option value="S" >Service</option>
		<option value="T" >Trading</option>

        </select><input name="btnActList" type="button" class="button" id="btnActList"  onClick="activity_M();"  value="Select Industry / Activity" /></td>
      </tr>
      <tr>
        <th><strong>(15)</strong></th>
        <th nowrap>Industry / Activity Name* : <strong>
          <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="" />
        </strong></th>
        <td colspan="4"><input name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="" size="60" readonly="true" /></td>
      </tr>
      <tr>
        <td><div align="center"><strong>(16)</strong></div></td>
        <td>Product Description: </td>
        <td colspan="2"><input name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" /></td>
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
 rs = db.execSQL("SELECT  DISTINCT(TRIM(UPPER(A.BANK_NAME))) AS BANK_NAME FROM rbibanklist A ,M_DISTRICT B WHERE  A.district_cd=B.district_cd(+) AND A.ACT_YN='Y' ORDER BY BANK_NAME");
	   while(rs.next()){ 
	   %>
            <option value="<%=rs.getString("BANK_NAME")%>"><%=rs.getString("BANK_NAME")%></option>
	        
      <% } 
	  rs.close();
	    
	   %>	</select>   </td>
	  </tr>
      <tr>
        <td>&nbsp;</td>
        <td>IFS/Bank Code*: </td>
        <td colspan="4"><input name="IFSC_CODE" type="text" id="IFSC_CODE"  style="background-color: #FFCCCC" size="11" maxlength="20"  readonly="true" />
          <input name="btnBank" id="btnBank" type="button" class="button" onClick="ShowNewPage();"  value="Select  Bank IFS Code and Address" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td><input name="FLAG" type="hidden" id="FLAG" value="3"><input name="SCHEME" type="hidden" id="SCHEME" value="MUDRA">
        <td>Branch Name*: </td>
        <td colspan="4"><input name="BRANCH_NAME" type="text" id="BRANCH_NAME"  size="60" maxlength="100" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Address*:</td>
        <td colspan="4"><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" onKeyPress="return RestrictSpecialChar(event);" size="70" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>District:</td>
        <td colspan="4"><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" onKeyPress="return RestrictSpecialChar(event);" /></td>
      </tr>
      <tr>
        <td><div align="center"><strong>(18)</strong></div></td>
        <th>Loan Sanction Date :*</th>
        <th colspan="4" nowrap><input type="text"  id="IST_LOAN_DT" name="IST_LOAN_DT" value="" placeholder="DD-MON-YYYY" size="11" maxlength="11" ></th>
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
          <input name="CE_SANC_FB" type="text" id="CE_SANC_FB"  size="8" maxlength="7" onKeyPress="return numbersonly(event);" />
        </div></td>
        <td nowrap><div align="center">
          <input name="WC_SANC_FB" type="text" id="WC_SANC_FB"  size="8" maxlength="7" onKeyPress="return numbersonly(event);" />
        </div></td>
        <td colspan="2" nowrap><div align="center">
          <input name="EMP_ENV" type="text" id="EMP_ENV"  size="8" maxlength="7"  onKeyPress="return numbersonly(event);"/>
        </div></td>
      </tr>
      <tr>
      <td><div align="center"><strong>(20)</strong></div></td>
      <th>Date of Complete Repayment:* </th>
      <td colspan="2"><div align="center">
        <input type="text"  id="REPAY_DT" name="REPAY_DT" value="" placeholder="DD-MON-YYYY" size="11"  maxlength="11">
      </div></td>
      <th>Repayment Amount*: </th>
      <td><input name="REPAY_AMT" type="text" id="REPAY_AMT"  size="8" maxlength="7" onKeyPress="return numbersonly(event);" /></td>
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
			
</body>
			</html>