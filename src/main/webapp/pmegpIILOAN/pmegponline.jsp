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
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/jquery-customselect.js"></script>

<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<script type = "text/javascript"  src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="../js1/ModalPopupWindow.js"></script>
</head>

<body>
<%
String state="";
String qrystr="";
 DBCon db= new DBCon();
db.connect();


%>
<form name="form" id="form"  class="form" method="post">
  <div align="center"></div>
  <table class="CSSTableGenerator" align="center">
    <tr bgcolor="#D1A476">
      <td colspan="6"><div align="center" class="style1">
          <h3>ONLINE APPLICATION FOR SECOND LOAN SUBSIDY FOR UPGRADING OF EXISTING UNIT </h3>
      </div></td>
    </tr>
    <tr>
      <th>(1)</th>
      <th nowrap><div align="left"><strong>First Loan Availed Under:*</strong></div></th>
      <td colspan="4"><div align="left">
          <select name="SCHEME_NM" id="SCHEME_NM" onChange="show()";>
            <option value="">-Select-</option>
            <option value="PMEGP">PMEGP</option>
            <option value="MUDRA">MUDRA</option>
			<option value="REGP">REGP/APPLICATION BEFORE 01-JUL-2016</option>
          </select>
      </div></td>
    </tr>
    <tr >
      <th>(2)</th>
      <th nowrap><div align="left"><strong>State :*</strong></div></th>
      <td colspan="4"><div align="left">
          <select name="STATE" class="button"  id="STATE" onChange="getDistrict(this.value);">
            <option value="-1">--Select State--</option>
            <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state=rs.getString("state_cd");
	   %>
            <option value="<%=rs.getString("state_cd")%>"><%=rs.getString("state_nm")%></option>
            <% } 
	  rs.close();
	   %>
          </select>
      </div></td>
    </tr>
    <tr>
      <th>(3)</th>
      <th nowrap><strong>District :*</strong></th>
      <td colspan="4"><select name="DISTRICT" id="DISTRICT" class="button" >
          <option value="">--Select--</option>
      </select></td>
    </tr>
    <tr>
      <th>(4)</th>
      <th nowrap><strong><span id="PMEGP" style="display:none">PMEGP</span><span id="text" style="display:none">MUDRA</span><span id="text1" style="display:none">REGP/APPLICATION BEFORE 01-JUL-2016</span>Application ID:*</strong></th>
      <td colspan="4"><input name="APP_ID" type="text"  id="APP_ID"  size="20" maxlength="20" /></td>
    </tr>   
    <tr >
      <th>(5)</th>
      <th nowrap><strong>Udyog Aadhar Registration No:*</strong></th>
      <td colspan="4"><div align="left">
          <input name="UAD" type="text"   class="aadharimg" id="UAD"  size="20" maxlength="20" />
      </div></td>
    </tr>
    <tr >
      <th>(6)</th>
      <input name="FLAG" type="hidden" id="FLAG" value="2">
      <th nowrap><strong>Aadhar No:*</strong></th>
      <td colspan="4"><div align="left">
          <input name="AADHAR_NO" type="text" class="aadharimg"  id="AADHAR_NO"  value=""  onKeyPress="return numbersonly(event);" size="17" maxlength="12" />
      </div></td>
    </tr>
    <tr>
      <th>(7)</th>
      <th nowrap><strong>Pan No:*</strong></th>
      <td colspan="4"><div align="left">
          <input name="	PAN_NO" type="text"   id="PAN_NO"  size="17" maxlength="10" />
      </div></td>
    </tr>
    <tr>
      <div align="center">
        <td colspan="6"><div align="center">
            <input name="btnSub" id="btnSub" type="button" onClick="getfrequenttab(2)"; class="button" value="Next" />
        </div></td>
      </div>
    </tr>
  </table>
</form>

</body>
</html>
